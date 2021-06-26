/*
window.addEventListener('DOMContentLoaded', function() {
    document.getElementById('enlarge-touch').addEventListener('touchstart', function() {
      this.animate(
        {
          transform: [
            'scale(1)',
            'scale(5)'
          ]
        },
        {
          duration: 1000,
          fill: 'forwards',
          easing: 'ease'
        }
      );
    });
    document.getElementById('enlarge-touch').addEventListener('touchend', function() {
      this.animate(
        {
          transform: [
            'scale(5)',
            'scale(1)'
          ]
        },
        {
          duration: 1000,
          fill: 'forwards',
          easing: 'ease'
        }
      );
    });
  });

  window.addEventListener('DOMContentLoaded', function() {
    document.getElementById('enlarge').addEventListener('touchstart', function() {
      const image = document.getElementById('enlarge-touch');
      let touchObject = event.changedTouches[0];
      let x = touchObject.clientX;
  	  let y = touchObject.clientY;
      image.style.marginTop = y + "px";
      image.style.marginLeft = x + "px";
      image.style.marginRight = 0;
      image.style.marginBottom = 0;
    });
  });

  window.addEventListener('DOMContentLoaded', function() {
    document.getElementById('enlarge').addEventListener('click', function(event) {
      const image = document.getElementById('enlarge-touch');
      image.style.marginTop = event.clientY + "px";
      image.style.marginLeft = event.clientX + "px";
      image.style.marginRight = 0;
      image.style.marginBottom = 0;
    });
  });
  
  */