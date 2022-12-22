var v = new Array();
var p = new Array();
var prev = "https://drive.google.com/uc?export=download&id=";
//var prevpic = "https://drive.google.com/uc?export=download&id=";
var myVideo = document.getElementById("video1");

v[1] = [prev + "1OFdTBydJmZ7UQ-fgsG7xPaKtgz4AdwC2"];

var a = new Array();
a[1] = ["Video abspielen"];

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
//im Balken fn wird a[n] ausgegeben  document.getElementById("fn").innerHTML =  a[n];
  document.getElementById("video1").src = v[n];
  document.getElementById("video1").style.display = "";
//  document.getElementById("picid").style.display = "none";
//  document.getElementById("picid").src = p[10];
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

  for (i = 1; i <= 1; i++) {
    b = "b" + i;
    document.getElementById(b).innerHTML = a[i];};
    //document.getElementById("video1").style.display = "none";
    document.getElementById("picid").style.display = "none";
    }

function makeBig(n) {myVideo.width = n;}
//</script>
