
export class AddressModel{

    addressId: number;
    addressCountry: string;
    addressState: string;
    addressCity: string;
    addressStreet: string;
    addressZopcode: string;
    addressDetails: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;

    /*
	constructor(aId: number, aC: string, aSt: string, aCt: string, aStr: string, aZc: string, aDt: string, cBy: string, dCreated: string, mBy: string, dModified: string) {
		this.addressId - aId;
		this.addressCountry = aC;
		this.addressState = aSt;
		this.addressCity = aCt;
		this.addressStreet = aStr;
		this.addressDetails = aDt;
	    this.createdBy = cBy;
	    this.dateCreated = dCreated;
	    this.modifiedBy = mBy;
	    this.dateModified = dModified;
	}*/
}