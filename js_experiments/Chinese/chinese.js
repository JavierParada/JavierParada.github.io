var paragraphs = document.getElementsByClassName("square");

var animals = {
    狗: "perro",
    猫: "gato",
    鸟: "pájaro",
    马: "caballo",
    奶牛: "vaca",
    老鼠: "ratón",
    猴子: "chango",
    猪: "puerco",
    鹿: "venado",
    大象: "elefante",
    长颈鹿: "jirafa",
    山羊: "borrego",
    猩猩: "gorila",
    蝴蝶: "mariposa",
    熊貓: "panda"
};

var keys = Object.keys(animals);

// Display some data from the object:

for(var i = 0; i < paragraphs.length; i++){
    paragraphs[i].addEventListener("click", function(){
        this.classList.toggle("selected");
        this.textContent = animals[this.textContent];
    })
}

