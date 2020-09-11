require 'rack/lobster'

map '/health' do
  health = proc do |env|
    [200, { "Content-Type" => "text/html" }, ["1"]]
  end
  run health
end

map '/lobster' do
  run Rack::Lobster.new
end

map '/headers' do
  headers = proc do |env|
    [200, { "Content-Type" => "text/plain" }, [
      env.select {|key,val| key.start_with? 'HTTP_'}
      .collect {|key, val| [key.sub(/^HTTP_/, ''), val]}
      .collect {|key, val| "#{key}: #{val}"}
      .sort
      .join("\n")
    ]]
  end
  run headers
end

map '/' do
  welcome = proc do |env|
    [200, { "Content-Type" => "text/html" }, [<<WELCOME_CONTENTS
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>Welcome to OpenShift</title>


<style>
span {
  background-color: YELLOW;
}
</style>
<body style="background-color:ORANGE;">


 <section class='container'>
  <hgroup>
    <h1><center>HELLO NIKHIL! YOU HAVE REACHED ROUTE NUMBER <span>TWO</span> !</h1>
  </hgroup>
  <div class="row">
    <section class='col-xs-12 col-sm-6 col-md-6'>
      <section>
        <h2><I>Now Testing....ALTERNATE ROUTES!</h2>
      </section>
    </section>
    </div> 
</section>


</body>
</html>
WELCOME_CONTENTS
    ]]
  end
  run welcome
end
