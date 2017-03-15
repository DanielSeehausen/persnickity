function bindEvent(e, eventName, callback) {
    e.addEventListener(eventName, callback, false);
};

bindEvent(document.body, 'scroll', function(e) {
    document.body.scrollLeft = 0;
});
