export function addClass(el, className) {
  if (el.classList) {
    el.classList.add(className);
  } else {
    el.className += " " + className;
  }
}

export function removeClass(el, className) {
  if (el.classList) {
    el.classList.remove(className);
  } else {
    el.className = el.className.replace(
      new RegExp("(^|\\b)" + className.split(" ").join("|") + "(\\b|$)", "gi"),
      " "
    );
  }
}

/**
 * Empty the passed `node` of all children
 * @param  {Element} node Node to empty
 * @return {Void}
 */
export function emptyNode(node) {
  while (node.firstChild) {
    node.removeChild(node.firstChild);
  }
}
