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

class Apartment extends Home {
    leaseLength;

    constructor(leaseLength, numberOfBedrooms, monthlyCost, numberOfBathrooms, sqFootage) {
        super(numberOfBedrooms, monthlyCost, numberOfBathrooms, sqFootage);
        this.leaseLength = leaseLength;
    }
}

let marioHotel = new Home(20, 50, 20, 40000);
console.log(marioHotel.calcCostPerSqFoot());

let marioApartment = new Apartment(13, 20, 50, 20, 40000);
console.log(marioApartment.calcCostPerSqFoot());