var v = new Array();
var prev = "https://drive.google.com/uc?export=download&id=";

v[1] = [prev + "1lmdYNFWnXXa91doyhv2ONXnW2ThRKsbA3A"];
v[2] = [prev + "1pcsaKoA0xRGGTj8yD0Pa5-4_c9AqDg7uvw"];
v[3] = [prev + "1u2lp6UbZ6VWvTaH8L48SflQQlst0dD98RQ"];
v[4] = [prev + "1VeNo_Ti_Kv0ZNLeExsAertvNiOUPNn8BhQ"];
v[5] = [prev + "1IMcurNlRNdISK-NPIzwrZnxwZkWhKlSDWA"];
v[6] = [prev + "1RFr_pDFdKoU7G3BRbKkn8ZnrDOmzPhxw7w"];
v[7] = [prev + "1PFEgmDc9hbdiMD8DwGEzW5m3OJdOGGWfKw"];
v[8] = [prev + "1Zumn2CO-L7HCFKE4rt3IIMdIX8HLqrccWA"];
v[9] = [prev + "1RFr_pDFdKoU7G3BRbKkn8ZnrDOmzPhxw7w"];
v[9] = [prev + "1MvyEyjjHCpINLx0ietZblODmQztkUjK6yw"];
v[10] = [prev + "1tHPZPouxWARas0sBMM8cw6EvCi53ZGgANA"];
v[11] = [prev + "1-YDUNoSuCxsbHPOeBpyZnCYg7R7rnmR1wA"];
v[12] = [prev + "13VnKwRH22t3F-Gt52khhzB5KdsHTvt1OgQ"];
v[13] = [prev + "1cAutBjDY9OoSbW1xtkcE4lO_0xsyB-wzWA"];
v[14] = [prev + "1XkEI-URH4izYCJa15__Z-Py8wzFHUu229A"];
v[15] = [prev + "1b3cPv1qeyaaIGOARFxs1ztlp0m1KYz5nRg"];
v[16] = [prev + "1cRjBZOqSmRD7Kiz3_udvfGxNhrhTg2u2DQ"];
v[17] = [prev + "1WAVM9QJadMaqSAluwdIS3OtSOmr51UfGqg"];
v[18] = [prev + "14J3QZDEB2KNd4DFlnLn75Ay64TX_3gEO9g"];


var a = new Array();
a[1] = ["Hip Hop Shop"];
a[2] = ["Chrismukkah"];
a[3] = ["Secret Santa"];
a[4] = ["Feliz Navidad"];
a[5] = ["Office Party"];
a[6] = ["Breakin"];
a[7] = ["EDM"];
a[8] = ["Charleston"];
a[9] = ["House Party"];
a[10] = ["HipHop"];
a[11] = ["Jingle Pop"];
a[12] = ["Cats"];
a[13] = ["Espanol"];
a[14] = ["Classic"];
a[15] = ["Honkey Tonk"];
a[16] = ["Soul"];
a[17] = ["80's"];
a[18] = ["Oh Hannukkah"];

var myVideo = document.getElementById("video1");

function playPause() {
    if (myVideo.paused)
        myVideo.play();
    else
        myVideo.pause();
}

function changevid(n) {myVideo.src = v[n];
  document.getElementById("fn").innerHTML =  v[n];
  document.getElementById("na").innerHTML =  a[n];
  playPause();

}

function settxt() {
  for (i = 1; i <= 18; i++) {
    b = "b" + i;
    document.getElementById(b).innerHTML = a[i];};
}

function makeBig(n) {myVideo.width = n;}
