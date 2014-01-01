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

  var converter = new Showdown.converter();

  function convertFromMarkdownToHTML (markdown) {
    var result = null;
    if (markdown.length > 0) {
      result = converter.makeHtml(markdown);
    }

    return result;
  }

  var preview = $('#preview');

  var inputDescription = $('#inputDescription');
  if (inputDescription[0]) {
    inputDescription.keyup(onDescriptionUpdate);
    onDescriptionUpdate();
  }

  function onDescriptionUpdate () {
    preview.html(convertFromMarkdownToHTML(inputDescription.val()));
  }

  $('.markdown').each(function (index, element) {
    $(element).html(convertFromMarkdownToHTML($(element).text()));
  });
});
