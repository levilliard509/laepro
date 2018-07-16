
export class StudentModel{
   studentId: number;
   institutionId: number;
   parentId : number;
   personRefId: number;
   institutionClassId: number;
   studentFirstname: string;
   studentLastname: string;
   studentBirthday: string;
   studentBirthplace: string;
   studentSex: string;
   studentMotherTonge: string;
   studentSkills: string;
   studentTels: string;
   studentEmail: string; 
   studentReligion: string;
   studentAddress: string;
   createdBy: string;
   dateCreated: string;
   modifiedBy: string;
   dateModified: string;
   studentImg: string;
   studentActive: boolean;
   parentFId: number;
   studentOldSchool: string;
}

export class StudentPaymentModel{
   paymentStudentId: number;
   studentId: number;
   paymentStudentValue: number;
   createdBy: string;
   dateCreated: string;
   modifiedBy: string;
   dateModified: string;
}

export class StudentAbsenceModel{
   absenceId: number;
   studentId: number;
   absenceMotif: string;
   absenceDetails: string;
   createdBy: string;
   dateCreated: string;
   modifiedBy: string;
   dateModified: string;
}

export class PenalityTypeModel{
   penalityTypeId: number;
   penalityTypeName: string;
   penalityTypeDesc:string;
   penalityTypeFee: string;
   createdBy: string;
   dateCreated: string;
   modifiedBy: string;
   dateModified: string;
}

export class StudentPenalityModel{
   penalityId: number;
   penalityTypeId: number;
   studentId: number;
   penalityDesc: string;
   createdBy: string;
   dateCreated: string;
   modifiedBy: string;
   dateModified: string;
}