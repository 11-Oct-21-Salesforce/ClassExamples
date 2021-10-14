class Home {
    numberOfBedrooms;
    monthlyCost;
    numberOfBathrooms;
    sqFootage;

    constructor(numberOfBedrooms, monthlyCost, numberOfBathrooms, sqFootage) {
        this.numberOfBedrooms = numberOfBedrooms;
        this.monthlyCost = monthlyCost;
        this.numberOfBathrooms = numberOfBathrooms;
        this.sqFootage = sqFootage;
    }

    calcCostPerSqFoot() {
        return this.monthlyCost / this.sqFootage;
    }
}

let marioHotel = new Home(20, 50, 20, 40000);
console.log(marioHotel.calcCostPerSqFoot());