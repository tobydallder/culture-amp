function cloneSelf(node) {
  const clone = node.cloneNode(true);
  node.parentNode.replaceChild(clone, node);
  return clone;
}

/**
 * Toggle the `options.targetToggleClassName` on the passed
 * `props.targetSelector` elements when the `el` is
 * `props.event-ed` (click for example)
 * `props.onOutsideClick` — "add" or "remove" the toggle class on outside click
 */
export default function toggleClass(el, props) {
  // Clone self to ensure clean listeners
  el = cloneSelf(el);
  let triggered = false;
  const defaults = {
    event: "click",
    preventDefault: true
  };
  const options = { ...defaults, ...props };
  const targets = Array.prototype.slice.call(
    document.querySelectorAll(options.targetSelector)
  );

  // Remove the loadClass on initialisation
  if (options.targetLoadClassName) {
    window.requestAnimationFrame(() => {
      targets.forEach(target => {
        target.classList.remove(options.targetLoadClassName);
      });
    });
  }

  // Bind to the passed event
  el.addEventListener(options.event, e => {
    if (options.preventDefault) {
      e.preventDefault();
    }
    targets.forEach(target => {
      target.classList.toggle(options.targetToggleClassName);
    });
    if (options.triggerToggleClassName) {
      el.classList.toggle(options.triggerToggleClassName);
    }
    triggered = true;
  });

  // Bind a general listener to handle an add or remove action when
  // we click outside the target
  if (options.onClickOutsideTarget) {
    window.addEventListener("click", e => {
      if (el === e.target || el.contains(e.target)) {
        return;
      }
      let outsideTarget = true;
      targets.forEach(target => {
        const contains = target !== e.target && target.contains(e.target);
        if (contains) {
          outsideTarget = false;
        }
      });
      if (outsideTarget) {
        targets.forEach(target => {
          // Perform an `.add` or `.remove`
          if (el.offsetParent !== null) {
            // check the element is visible.
            target.classList[options.onClickOutsideTarget](
              options.targetToggleClassName
            );
          }
        });
        if (options.triggerToggleClassName) {
          // Should be the opposite of the other action
          const triggerAction =
            options.onClickOutsideTarget === "add" ? "remove" : "add";
          el.classList[triggerAction](options.triggerToggleClassName);
        }
      }
    });
  }

  // Trigger after timeout
  if (options.triggerAfter) {
    setTimeout(() => {
      if (triggered === false) {
        el[options.event]();
        triggered = true;
      }
    }, options.triggerAfter);
  }
}
