(function() {

  function getVideoId (url) {
    var videoId = null;
    if (url.match(/^http:\/\/www.youtube.com\/watch\?v=([\w-]+).*/)) {
      videoId = RegExp.$1;
    }
    return videoId;
  }

  window.onChangeUrl = function () {
    var url = $('#inputUrl').val();
    var videoId = getVideoId(url);
    // console.log(videoId);

    if (videoId) {
      $.get('http://gdata.youtube.com/feeds/api/videos/' + videoId + '?v=2&alt=jsonc&callback=onGetInfo');
    }
  };

  window.onGetInfo = function (res) {
    var data = res.data;
    // console.log(data);
    // console.log(data.title);
    // console.log(data.description);

    if (data) {
      $('#inputTitle').val(data.title);
      $('#inputDescription').val(data.description);
      $('#inputDuration').val(data.duration);
    }
  };

  window.onKeyPress = function (event) {
    if (event.keyCode === 13) {
      event.preventDefault();
      onChangeUrl();
    }
  };
})();
