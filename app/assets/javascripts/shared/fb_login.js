$(function(){
  $(".fb-login").on('click', function(){

    $btnFb = $(this)
    var url =  $btnFb.attr("data-url")

    var fbLogin = new FacebookLogin(url)
    fbLogin.authenticate()
    return false
  })
})

function FacebookLogin(url){
  this._url = url

  this.authenticate = function(){
    var _self = this
    FB.login(function(loginResponse) {
      if(loginResponse.authResponse){
        _self.informUrl(loginResponse.authResponse.accessToken)
      }
    }, {scope: 'public_profile,email'})
  }

  this.informUrl = function(accessToken) {
    var paramString = "fb_access_token=" + accessToken
    var completeUrl = this._appendParamString(this._url, paramString)
    window.location.href = completeUrl
  }

  this._appendParamString = function(url, paramString){
    if(url.indexOf("?") == -1)
      return url + "?" + paramString
    else
      return url + "&" + paramString

  }
}
