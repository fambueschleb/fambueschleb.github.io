var v = new Array();
var p = new Array();
var prev = "https://drive.google.com/uc?export=download&id=";
var prevpic = "https://drive.google.com/uc?export=download&id=";
var myVideo = document.getElementById("video1");

v[1] = [prev + "1F3oS8usip2DCSX9tZHxjjSmEFNR3GmaW"];
v[2] = [prev + "115OYq2mcne3TXbIdHYfY2TRwH6TRCqaY"];
v[3] = [""];

p[1] = [prevpic + "1hcD5aJN2iIcNOiRVIYxKC_SxYWeEPIRF"];
p[2] = [prevpic + "1V9on0is0zIG-X3m4TDVxKUqjtyp-VOkc"];
p[3] = [prevpic + "1dZ-85-Y4WzzljIfiVWV9p33rhVoyBY0t"];
p[4] = [prevpic + "1sj4nLIFh4Nm4H-W0VAQ35W5VKagtUzr8"];
p[5] = [prevpic + "1Tmm7JGmj6dwiOTVyy61qYA2zLpXQ0NBP"];
p[6] = [prevpic + "1hg2xEWno0Bg_x2bUS4ZVGKrx_mDpJNCR"];
//p[7] = [prevpic + "18aT6rLGqQKL-3G5TnEDDP-V1h0sQitC1"];
p[7] = [prevpic + "1aALP3X3HLG-hMXh4vI8OrsIYrTVYNpej"];
p[8] = [prevpic + "1f8guZwi5yeHlUK_vuSw1fijC7xFw3f6P"];
p[10] = [prevpic + "1uV70LnwG3B7pgPpe5Iz-y_jhVBMNrZON"];

var a = new Array();
a[1] = ["Video 1"];
a[2] = ["Video 2"];
a[3] = ["nächstes Bild"];

let zaehler = 0;
let zaehlermax = 8;

function playPause() {
    if (myVideo.paused)
        myVideo.play();
    else
        myVideo.pause();
}

function changevid(n) {
  if (n == "1" || n == "2")
  {
  document.getElementById("fn").innerHTML =  a[n];
  document.getElementById("video1").src = v[n];
  document.getElementById("video1").style.display = "";
  document.getElementById("picid").style.display = "none";
  document.getElementById("picid").src = p[10];
  }
else {
if (zaehler < zaehlermax && n > 2) {
      zaehler = zaehler + 1;}
      else
      {zaehler = 1;}

  document.getElementById("picid").src = p[zaehler];
  document.getElementById("picid").style.height = "120";
  document.getElementById("picid").style.display = "";
  document.getElementById("video1").style.display = "none";
  }
}

function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}

function settxt() {

  for (i = 1; i <= 3; i++) {
    b = "b" + i;
    document.getElementById(b).innerHTML = a[i];};
    document.getElementById("video1").style.display = "none";
    document.getElementById("picid").style.display = "none";
    }

function makeBig(n) {myVideo.width = n;}
//</script>
