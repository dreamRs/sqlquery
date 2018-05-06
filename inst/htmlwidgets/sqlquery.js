HTMLWidgets.widget({

  name: 'sqlquery',

  type: 'output',

  factory: function(el, width, height) {

    var SQLCodeMirror;

    return {

      renderValue: function(x) {

        // Styling
        var element = document.getElementById(el.id);
        var widthEl = element.clientWidth;
        var heightEl = element.clientHeight;
        var editorId = el.id + "-editor";
        var editor = document.createElement('textarea');
        editor.id = editorId;
        editor.innerHTML = x.options.value;

        var btnCopy;

        if (!x.raw) {
          var title = document.createElement('div');
          title.style.height = "40px";
          title.style.backgroundColor = "#112446";
          title.style.color = "#FFF";
          title.style.fontWeight = "bold";
          title.style.lineHeight = "40px";
          title.style.textAlign = "center";
          title.style.fontFamily = 'font-family: Georgia, "Times New Roman", Times, serif;';
          titleIcon = document.createElement('span');
          titleIcon.classList.add('glyphicon');
          titleIcon.classList.add('glyphicon-console');
          title.appendChild(titleIcon);
          title.innerHTML += "&nbsp;SQL Query Editor";
          element.appendChild(title);

          element.appendChild(editor);

          var keys = document.createElement('span');
          keys.style.fontStyle = "italic";
          keys.style.fontSize = "12px";
          keys.style.marginLeft = "10px";
          keys.innerHTML = "Press Ctrl-Space for autocomplete";
          element.appendChild(keys);

          var breakline = document.createElement('br');
          element.appendChild(breakline);

          btnCopy = document.createElement('button');
          btnCopy.id = el.id + "-btn-copy";
          btnCopy.type = "button";
          btnCopy.classList.add('btn');
          btnCopy.classList.add('btn-default');
          btnCopy.classList.add('clip-btn-native');
          btnCopy.style.marginLeft = "10px";
          btnIcon = document.createElement('span');
          btnIcon.classList.add('glyphicon');
          btnIcon.classList.add('glyphicon-copy');
          btnCopy.appendChild(btnIcon);
          btnCopy.innerHTML += "&nbsp;Copy to clipboard";
          element.appendChild(btnCopy);

        } else {
          element.appendChild(editor);
        }

        var params = x.options;
        params.extraKeys = {"Ctrl-Space": "autocomplete"};
        params.hintOptions = x.autocomplete;


        // Set font size
        document.getElementById(el.id).style.fontSize = x.fontSize;
        // Initialize editor
        SQLCodeMirror = CodeMirror.fromTextArea(document.getElementById(editorId), params);

        // Shiny interaction
        if (HTMLWidgets.shinyMode) {
          // init
          Shiny.onInputChange(el.id + '_value', SQLCodeMirror.getValue());
          // Send value to shiny on change
          SQLCodeMirror.on("change", function() {
            Shiny.onInputChange(el.id + '_value', SQLCodeMirror.getValue());
          });
        }

        // Copy to clipboard
        if (!x.raw) {
          editorSelector = '#' + editorId + ' + .CodeMirror';
          new ClipboardJS('.clip-btn-native', {
              text: function(trigger) {
                  return getCodeMirrorNative(editorSelector).getDoc().getValue();
              }
          });
        } else {
          SQLCodeMirror.setSize(widthEl, heightEl);
        }

      },

      getEditor: function() {
        return SQLCodeMirror;
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});


// utils
// https://stackoverflow.com/questions/9492842/does-codemirror-provide-cut-copy-and-paste-api
function getCodeMirrorNative(target) {
    var _target = target;
    if (typeof _target === 'string') {
        _target = document.querySelector(_target);
    }
    if (_target === null || !_target.tagName === undefined) {
        throw new Error('Element does not reference a CodeMirror instance.');
    }

    if (_target.className.indexOf('CodeMirror') > -1) {
        return _target.CodeMirror;
    }

    if (_target.tagName === 'TEXTAREA') {
        return _target.nextSibling.CodeMirror;
    }

    return null;
}



// PROXY

function get_editor(id){
  var htmlWidgetsObj = HTMLWidgets.find("#" + id);
  var editorObj ;
  if (typeof htmlWidgetsObj != 'undefined') {
    editorObj = htmlWidgetsObj.getEditor();
  }
  return(editorObj);
}


if (HTMLWidgets.shinyMode) {

  // setValue
  Shiny.addCustomMessageHandler('sqlquery-setvalue',
    function(data) {
      var editor = get_editor(data.id);
      if (typeof editor != 'undefined') {
        editor.setValue(data.value);
      }
  });

  // copy to clipboard
  Shiny.addCustomMessageHandler('sqlquery-clipboard',
    function(data) {
      new ClipboardJS(data.selector, {
          text: function(trigger) {
            var editor = get_editor(data.id);
            return editor.getValue();
          }
      });
  });

}
