function scopeEnforcingKeywords() {
    console.log(a);
    var a = 13;
    console.log(a);

    for(let i = 0; i < 10; i++) {
        console.log(i);
    }

    console.log(i);
}

function dynamicTypes() {
    let a = '3';
    console.log(typeof a);
    a -= 3;
    console.log(typeof a);
    a *= 1;
    console.log(typeof a);
}

function forLoop() {
    let internationalGreetings = ["Hola", "Konnichawa", "Bonjour"];
    for(let i = 0; i < internationalGreetings.length; i++) {
        if(internationalGreetings[i] == "Hola") {
            console.log(internationalGreetings[i] + ", greeting is hello in Spanish.");
        } else if(internationalGreetings[i] == "Konnichawa") {
            console.log(`${internationalGreetings[i]}, greeting is good afternoon in Japanese`);
        } else if(internationalGreetings[i] == "Bonjour") {
            console.log(`${internationalGreetings[i]}, greeting is hello in French`);
        }
    }
}

function forOfLoop() {
    let internationalGreetings = ["Hola", "Konnichawa", "Bonjour"];
    for(let i of internationalGreetings) {
        if(i == "Hola") {
            console.log(i + ", greeting is hello in Spanish.");
        } else if(i == "Konnichawa") {
            console.log(`${i}, greeting is good afternoon in Japanese`);
        } else if(i == "Bonjour") {
            console.log(`${i}, greeting is hello in French`);
        }
    }
}

function foodOrderSwitch(value) {
    switch(value) {
        case 1:
            console.log("Ordered a Combo #1: Big Belly Burger");
            break;
        case 2:
            console.log("Ordered a Combo #2: Big Kahuna Burger");
            break;
        case 3:
            console.log("Ordered a Combo #3: The Max");
            break;
        case 4:
            console.log("Ordered a Combo #4: The Implausible Burger");
        case 5:
            console.log("Ordered a Quentin Tarantino action figure");
            break;
        default:
            console.log("Invalid option");
    }
}