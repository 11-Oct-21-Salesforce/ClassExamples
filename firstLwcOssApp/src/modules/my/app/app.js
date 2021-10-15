import { LightningElement } from 'lwc';

export default class App extends LightningElement {
    displayMarkup = true;
    teams = [
        {
            teamName: 'Alchemy',
            squadName: 'Codeforce'
        },
        {
            teamName: 'Alchemy',
            squadName: 'Rogue Squadron'
        },
        {
            teamName: 'Synergy',
            squadName: 'Team Seven'
        },
        {
            teamName: 'Vanquish',
            squadName: 'Vanquishing America\'s Llama Undead Empire'
        }
    ]

    changeDisplay() {
        this.displayMarkup = !this.displayMarkup;
    }
}
