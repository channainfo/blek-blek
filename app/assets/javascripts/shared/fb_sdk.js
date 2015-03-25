$(function(){
  $('body').prepend('<div id="fb-root"></div>')
  
  var id = 'facebook-jssdk'
  var ref = document.getElementsByTagName('script')[0];

  var js = document.createElement('script');
  js.id = id;
  js.async = true;
  js.src = "//connect.facebook.com/en_US/sdk.js";
  ref.parentNode.insertBefore(js, ref);
});



window.fbAsyncInit = function() {
  FB.init({ appId: Config.fbId,
            version    : 'v2.0',
            cookie: true,
            state: true })
}
