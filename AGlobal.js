.pragma library



function uiWidth() {return 1440;}


function uiHeight() {return 2560;}


function desktopApplicationWidth() {return 504;}


function desktopApplicationHeight() {return 896;}



function scaleProportion(CurrentWidth) {return CurrentWidth/originalScreenWidth();}



function mIsDesktop() {

    switch (Qt.platform.os) {
        case "macos": return true;
        case "osx": return true;
        case "windows": return true;
        case "linux": return true;
        default: return false;
    }
}
