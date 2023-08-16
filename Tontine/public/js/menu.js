// ici je recupere les boutons de menu pour l'action de click
const buttonParametrer = document.querySelector("#parametrage a");
const buttonOuvrir = document.querySelector("#ouvrir a");
const buttonFermer = document.querySelector("#fermer a");
const buttonTontiner = document.querySelector("#tontiner a");
const buttonPayer = document.querySelector("#payer a");
console.log(buttonFermer.textContent + " ouvrir "+ buttonOuvrir.textContent + " parametrer "+ buttonParametrer.id); 

// ici je recupere les menus en question
const menuParametrer = document.getElementById("blockParametrage");
const menuOuvrir = document.getElementById("blockOuvrir");
const menuFermer = document.getElementById("blockFermer");
const menuTontiner = document.getElementById("blockTontiner");
const menuPayer = document.getElementById("blockPayer");

//ici je recupere l'adresse du menu
//console.log(locationNav);

//ici il s'agit de mes fonctions appeler lors de l'evenement click sur un menu
function parametrerTontineMenu() {
    window.location.hash = "#parametrage";
    menuParametrer.style.display = "block";
    buttonParametrer.classList.add("activer");
    buttonFermer.classList.remove("activer");
    buttonOuvrir.classList.remove("activer");
    buttonPayer.classList.remove("activer");
    buttonTontiner.classList.remove("activer");
    menuPayer.style.display = "none";
    menuTontiner.style.display = "none";
    menuFermer.style.display = "none";
    menuOuvrir.style.display = "none";
}

function ouvrirTontineMenu() {
    window.location.hash = "#ouvrir";
    menuOuvrir.style.display = "block";
    buttonOuvrir.classList.add("activer");
    buttonFermer.classList.remove("activer");
    buttonParametrer.classList.remove("activer");
    buttonPayer.classList.remove("activer");
    buttonTontiner.classList.remove("activer");
    menuFermer.style.display = "none";
    menuTontiner.style.display = "none";
    menuParametrer.style.display = "none";
    menuPayer.style.display = "none";
}

function fermerTontineMenu() {
    window.location.hash = "#fermer";
    menuFermer.style.display = "block";
    buttonFermer.classList.add("activer");
    buttonOuvrir.classList.remove("activer");
    buttonParametrer.classList.remove("activer");
    buttonTontiner.classList.remove("activer");
    buttonPayer.classList.remove("activer");
    menuOuvrir.style.display = "none";
    menuTontiner.style.display = "none";
    menuParametrer.style.display = "none";
    menuPayer.style.display = "none";
}

function tontinerTontineMenu() {
    window.location.hash = "#tontiner";
    menuTontiner.style.display = "block";
    buttonTontiner.classList.add("activer");
    buttonFermer.classList.remove("activer");
    buttonOuvrir.classList.remove("activer");
    buttonParametrer.classList.remove("activer");
    buttonPayer.classList.remove("activer");
    menuFermer.style.display = "none";
    menuOuvrir.style.display = "none";
    menuParametrer.style.display = "none";
    menuPayer.style.display = "none";
}

function payerTontineMenu() {
    window.location.hash = "#payer";
    menuPayer.style.display = "block";
    buttonPayer.classList.add("activer");
    buttonFermer.classList.remove("activer");
    buttonOuvrir.classList.remove("activer");
    buttonTontiner.classList.remove("activer");
    buttonParametrer.classList.remove("activer");
    menuTontiner.style.display = "none";
    menuFermer.style.display = "none";
    menuOuvrir.style.display = "none";
    menuParametrer.style.display = "none";
}

//ici je recupere l'evenement et declenche l'action correspondant
// switch (locationNav) {
//     case "#parametrage":
//         parametrerTontineMenu();
//     break;

//     case "#ouvrir":
//         ouvrirTontineMenu();
//     break;

//     case "#tontiner":
//         tontinerTontineMenu();
//     break;

//     case "#fermer":
//         fermerTontineMenu();
//     break;

//     case "#payer":
//         payerTontineMenu();
//     break;
//     default:
//     break;
// }
 //buttonOuvrir.addEventListener("click",ouvrirTontineMenu(),false);
 //buttonTontiner.addEventListener("click",tontinerTontineMenu(),false);
 //buttonFermer.addEventListener("click",fermerTontineMenu(),false);
// buttonPayer.addEventListener("click",payerTontineMenu(),false);