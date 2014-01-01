$(function() {

  $('.cancel-enter-key').keydown(function (event) {
    if (event.keyCode === 13) {
      event.preventDefault();
    }
  });

  $('#inputUrl').change(function () {
    onChangeUrl();
  });

  function getVideoId (url) {
    var videoId = null;
    if (url.match(/^http:\/\/www.youtube.com\/watch\?v=([\w-]+).*/)) {
      videoId = RegExp.$1;
    }
    return videoId;
  }

  function onChangeUrl () {
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

    if (data) {
      $('#inputTitle').val(data.title);
      $('#inputDescription').val(data.description);
      $('#inputDuration').val(data.duration);
      onDescriptionUpdate();
    }
  };

  var inputDescription = $('#inputDescription');
  inputDescription.keyup(onDescriptionUpdate);

  var preview = $('#preview');

  var converter = new Showdown.converter();

  function onDescriptionUpdate () {
    var markdown = inputDescription.val();
    var html = converter.makeHtml(markdown);
    preview.html(html);
  }
});
