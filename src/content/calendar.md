---
permalink: /calendar/
layout: layouts/contentWide.njk
title: Calendar
---

<div style="overflow-x: auto;">
  <iframe 
    id="outlook-calendar"
    src="https://outlook.office365.com/owa/calendar/a60cebdae6c94da89be2ca5ac4148bf6@orlandoyouthalliance.org/c7bbec8cca64423eb3e6d308eae40dee5682817281027274579/calendar.html"
    width="100%" 
    height="800" 
    frameborder="0" 
    scrolling="no"
    style="border: none; display: block; min-width: 900px;">
  </iframe>
</div>

<script>
  (function () {
    var iframe = document.getElementById('outlook-calendar');
    function applyTheme() {
      if (document.documentElement.classList.contains('dark')) {
        iframe.style.filter = 'invert(1) hue-rotate(180deg)';
      } else {
        iframe.style.filter = '';
      }
    }
    applyTheme();
    new MutationObserver(applyTheme).observe(document.documentElement, { attributeFilter: ['class'] });
  })();
</script>
