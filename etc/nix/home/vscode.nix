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
  "editor.tabSize" = 2;
  "editor.formatOnSave" = true;
  "editor.cursorBlinking" = "solid";
  "terminal.integrated.fontSize" = 14;
  "files.insertFinalNewline" = true;
  "files.trimFinalNewlines" = true;
  "update.mode" = "manual";
  "extensions.autoUpdate" = false;
  "explorer.openEditors.visible" = 0;
  "explorer.autoReveal" = false;
  "files.insertFinalNewLine" = true;
  "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[javascriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "[typescriptreact]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
  "ruby.useBundler" = true;
  "ruby.useLanguageServer" = true;
  "ruby.lint" = {
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
    {
      "before" = [ "g" "m" ];
      "commands" = [ "editor.action.marker.nextInFiles" ];
    }
  ];
  "vim.operatorPendingModeKeyBindings" = [
    {
      "before" = [ "H" ];
      "after" = [ "^" ];
    }
    {
      "before" = [ "L" ];
      "after" = [ "$" ];
    }
  ];
  "vim.visualModeKeyBindings" = [
    {
      "before" = [ "H" ];
      "after" = [ "^" ];
    }
    {
      "before" = [ "L" ];
      "after" = [ "$" ];
    }
  ];
  "sorbet.useBundler" = true;
  "rust-analyzer.diagnostics.enableExperimental" = false;
  "rust-analyzer.inlayHints.enable" = false;
}
