function addClass(el, classNames) {
  var className;
  if (!classNames) return;
  if (classNames.constructor !== Array) {
    classNames = [classNames];
  }
  if (el.classList) {
    classNames.forEach(function(className) {
      el.classList.add(className);
    });
  } else {
    el.className += " " + className.join(" ");
  }
}

export default addClass;
