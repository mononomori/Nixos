{ pkgs, ...};
{
    security = {
        polkit = {
            enable = true;
            debug = true;
        }
        pam.services.hyprlock = [];
    };
}