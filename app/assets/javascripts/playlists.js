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
  var yList = [];

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

    dragging
      .css('top', pos.top + 'px')
      .css('left', pos.left + 'px');

    yList = [];
    var items = $('#unselected-videos')[0].children;
    var length = items.length;
    for (var i = 0; i < length; i++) {
      yList.push($(items[i]).position().top);
    }
  };

  window.onmousemove = function (event) {
    if (!pressed) {
      return;
    }

    var x = pos.left + (event.x - startPosition.x);
    var y = pos.top  + (event.y - startPosition.y);
    dragging
      .css('top', y + 'px')
      .css('left', x + 'px');

    var index = getIndex(y);
    focus.insertBefore($('#unselected-videos')[0].children[index]);
  };

  window.onmouseup = function (event) {
    pressed = false;

    target.removeClass('dragging');

    var y = pos.top  + (event.y - startPosition.y);
    var index = getIndex(y);

    var item = $(dragging[0].children[0]);
    $($('#unselected-videos')[0].children[index]).before(item);

    $('.focus').detach();
  };

  function getIndex (y) {
    var length = yList.length;
    for (var i = 0; i < length; i++) {
      if (yList[i] > y) {
        return i;
      }
    }
    return 0;
  }

})();
