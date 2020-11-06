{
  "workbench.colorTheme" = "GitHub Dark";
  "workbench.iconTheme" = "file-icons";
  "editor.multiCursorModifier" = "ctrlCmd";
  "editor.formatOnPaste" = true;
  "editor.fontFamily" = "'Fantasque Sans Mono', Menlo, Monaco, 'Courier New', monospace";
  "editor.fontSize" = 14;
  "editor.minimap.enabled" = false;
  "editor.dragAndDrop" = false;
  "editor.rulers" = [ 80 ];
  "update.mode" = "manual";
  "explorer.openEditors.visible" = 0;
  "explorer.autoReveal" = false;
  "files.insertFinalNewLine" = true;
  "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[javascriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "ruby.useBundler" = true;
  "ruby.useLanguageServer" = true;
  "ruby.lint" = {
    "ruby" = true;
    "rubocop"."useBundler" = true;
  };
  "solargraph.symbols" = false;
  "vim.leader" = "<space>";
  "vim.sneak" = true;
  "vim.normalModeKeyBindingsNonRecursive" = [
    {
      "before" = [ "<leader>" "C" ];
      "commands" = [ "copyRelativeFilePath" ];
    }
    {
      "before" = [ "H" ];
      "after" = [ "^" ];
    }
    {
      "before" = [ "L" ];
      "after" = [ "$" ];
    }
  ];
  "vim.operatorPendingModeKeyBindingsNonRecursive" = [
    {
      "before" = [ "H" ];
      "after" = [ "^" ];
    }
    {
      "before" = [ "L" ];
      "after" = [ "$" ];
    }
  ];
  "vim.visualModeKeyBindingsNonRecursive" = [
    {
      "before" = [ "H" ];
      "after" = [ "^" ];
    }
    {
      "before" = [ "L" ];
      "after" = [ "^" ];
    }
  ];
}
