{ config, pkgs, lib, inputs, ... }:

let
	yazi-plugins = pkgs.fetchFromGitHub {
		owner = "yazi-rs";
		repo = "plugins";
		rev = "273019910c1111a388dd20e057606016f4bd0d17";
		hash = "sha256-80mR86UWgD11XuzpVNn56fmGRkvj0af2cFaZkU8M31I=";
	};
in {
  home.packages = with pkgs; [
    dragon-drop
  ];

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
      chmod = pkgs.runCommandLocal "chmod.yazi" { } ''
        mkdir -p $out
        cp -r ${inputs.yazi-plugins}/chmod.yazi/* $out/
        cp $out/main.lua $out/init.lua
      '';
      toggle-pane = pkgs.runCommandLocal "toggle-pane.yazi" { } ''
        mkdir -p $out
        cp -r ${inputs.yazi-plugins}/toggle-pane.yazi/* $out/
        cp $out/main.lua $out/init.lua
      '';

			starship = pkgs.fetchFromGitHub {
				owner = "Rolv-Apneseth";
				repo = "starship.yazi";
				rev = "6c639b474aabb17f5fecce18a4c97bf90b016512";
        sha256 = "sha256-bhLUziCDnF4QDCyysRn7Az35RAy8ibZIVUzoPgyEO1A=";
		  };
		};
		initLua = ''
			require("starship"):setup()
		'';
    keymap.manager = {
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
          on = [ "<C-n>" ];
          run = "shell 'dragon-drop -x -i -T \"$1\"'";
          desc = "Drag and drop files";
        }
        {
          on = [ "<C-t>" ];
          run = "shell --confirm 'dragon-drop -t -k --print-path | grep -v \"^$\" | xargs -I{} sh -c \"cp -v \\\"{}\\\" . && notify-send \\\"Copied: {} → $(pwd)/\\\"\"'";
          desc = "Drop and copy file into current directory with notification";
        }
      ];
    };
	};
}