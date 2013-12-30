$(function() {
  function onUpdate (event, ui) {
    var selectedVideos = $('#selected-videos')[0].children;
    var selectedVideoIds = [];
    var length = selectedVideos.length;
    for (var i = 0; i < length; i++) {
      selectedVideoIds.push(Number(selectedVideos[i].id));
    }
    // console.log(selectedVideoIds);

    $('#playlist_videos2').val(selectedVideoIds.join(','));
  }

  $('#selected-videos').sortable({
    connectWith: '.videos-list',
    update: onUpdate
  });
  $('#unselected-videos').sortable({
    connectWith: '.videos-list',
  });

  $('.videos-list').disableSelection();
});
