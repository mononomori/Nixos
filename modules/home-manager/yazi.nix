{ config, pkgs, lib, inputs, ... }:

{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      dragon-drop
    ;
  };
	programs.yazi = {
    package = inputs.yazi.packages.${pkgs.system}.default;

		enable = true;
		enableFishIntegration = true;
		shellWrapperName = "y";

		settings = {
			manager = {
        ratio = [
          1
          4
          3
          
        ];
        sort_by = "natural";
        sort_sensitive = true;
        sort_reverse = false;
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
			};
			preview = {
        image_filter = "lanczos3";
        image_quality = 90;
        cache_dir = "";
        ueberzug_scale = 0;
        ueberzug_offset = [
          0
          0
          0
          0
        ];
			};
    tasks = {
      micro_workers = 5;
      macro_workers = 10;
      bizarre_retry = 5;
    };
		};
		plugins = {
      chmod = pkgs.yaziPlugins.chmod;
			starship = pkgs.yaziPlugins.starship;
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
		};
		initLua = ''
			require("starship"):setup()
		'';
    keymap.mgr = {
      prepend_keymap = [
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = ["<C-n>"];
          run = "shell -- 'dragon-drop -x -i -T \"$1\"'";
          desc = "Drag and drop files";
        }
        {
          on = [ "<C-t>" ];
          run = "shell ${./scripts/yazi-drop-handler.sh}";
          desc = "Drop file into yazi";
        }
        {
          on  = [ "y" ];
          run = ["shell 'for path in \"$@\"; do echo \"file://$path\"; done | wl-copy -t text/uri-list' --confirm" "yank"];
          desc = "Copy file paths to system clipboard as URI list and copy file to yazi's built in clipboard";
        }
      ];
    };
	};
}