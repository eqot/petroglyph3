(function() {
  $('li').click(function () {
    console.log('ok');
    $(this).addClass('dragging');
  });

  var pressed = false;
  var target = null;
  var startPosition = {
    x: null,
    y: null
  };
  var pos = null;
  var unselectedListY = [];
  var selectedListY = [];
  var selectedListX = null;
  var draggingX = null;

  var focus = $('<li class="focus"></li>');
  var dragging = null;

  window.onmousedown = function (event) {
    event.preventDefault();

    target = $(event.target);

    if (target[0].localName !== 'li') {
      return;
    }

    pressed = true;
    startPosition.x = event.x;
    startPosition.y = event.y;

    pos = target.position();

    target.before(focus);

    dragging = $('#dragging');
    target.appendTo(dragging);

    selectedListX = $(window).width() / 2;

    if (event.x < selectedListX) {
      draggingX = 0;
    } else {
      draggingX = $('#selected-area').position().left;
    }

    dragging
      .css('top', pos.top + 'px')
      .css('left', pos.left + draggingX + 'px');

    unselectedListY = [];
    var items = $('#unselected-videos')[0].children;
    var length = items.length;
    for (var i = 0; i < length; i++) {
      unselectedListY.push($(items[i]).position().top);
    }

    selectedListY = [];
    var items = $('#selected-videos')[0].children;
    var length = items.length;
    for (var i = 0; i < length; i++) {
      selectedListY.push($(items[i]).position().top);
    }
  };

  window.onmousemove = function (event) {
    if (!pressed) {
      return;
    }

    var x = pos.left + (event.x - startPosition.x) + draggingX;
    var y = pos.top  + (event.y - startPosition.y);
    dragging
      .css('top', y + 'px')
      .css('left', x + 'px');

    var videos = null;
    var listY = null;
    if (event.x < selectedListX) {
      videos = '#unselected-videos';
      listY = unselectedListY;
    } else {
      videos = '#selected-videos';
      listY = selectedListY;
    }
    var index = getIndex(listY, y);
    if (index !== -1) {
      focus.insertBefore($(videos)[0].children[index]);
    } else {
      focus.appendTo($(videos));
    }
  };

  window.onmouseup = function (event) {
    pressed = false;

    target.removeClass('dragging');

    var y = pos.top  + (event.y - startPosition.y);

    var videos = null;
    var listY = null;
    if (event.x < selectedListX) {
      videos = '#unselected-videos';
      listY = unselectedListY;
    } else {
      videos = '#selected-videos';
      listY = selectedListY;
    }
    var index = getIndex(listY, y);

    var item = $(dragging[0].children[0]);
    if (index !== -1) {
      $($(videos)[0].children[index]).before(item);
    } else {
      $(videos).append(item);
    }

    $('.focus').detach();
  };

  function getIndex (listY, y) {
    var length = listY.length;
    for (var i = 0; i < length; i++) {
      if (listY[i] > y) {
        return i;
      }
    }
    return -1;
  }

})();
