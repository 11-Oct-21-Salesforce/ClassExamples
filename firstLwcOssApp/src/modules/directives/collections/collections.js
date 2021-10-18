import { LightningElement } from 'lwc';

export default class Collections extends LightningElement {
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
}