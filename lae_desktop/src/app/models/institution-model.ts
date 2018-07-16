

export class InstitutionModel{
	institutionId: number;
    addressId: number;
    institutionName: string;
    institutionDetails: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
    schoolBeginDate: string;
    schoolEndDate: string;
}

export class InstitutionClassModel{
    institutionClassId: number;
    institutionId: number;
    institutionClassName: string;
    institutionClassLevel: string;
    institutionClassDesc: string;
    institutionClassCode: string;
    nbrStudent: number;    
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class ClassCourse{
    classCourseId: number;
    courseId: number;
    institutionClassId: number;
    teacherId: number;
    classCourseDetails: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
    dateStart: string;
    dateEnd: string;
}

export class Periode{
    periodeId: number;
    institutionId: number;
    periodeNo: number;
    periodeName: string;
    periodeDstart: string;
    periodeDend: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class PaymentClassModel{
    paymentClassId: number;
    institutionClassId: number;
    paymentClassBeginFeeValue: number;
    paymentClassPeriodValue: number;
    paymentClassFreq: number;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class EmployeeModel{
    employeeId: number;
    addressId: number;
    employeeFirstname: string;
    employeeLastname: string;
    employeeFunction: string;
    employeeCardId: string;
    employeeType: string;
    employeeDetails: string;
    employeeSex: string;
    employeeTels: string;
    employeeEmail: string;
    employeeActive: boolean;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
    employeeBirthday: string;
}

export class TeacherModel{
    teacherId: number;
    addressId: number;
    teacherFirstname: string;
    teacherLastname: string;
    teacherLevel: string;
    teacherDomain: string;
    teacherBirthday: string;
    teacherSex: string;
    teacherTels: string;
    teacherEmail: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class EmployeeSalaryModel{
    employeeSalaryId: number;
    employeeId: number;
    employeeSalaryValue: number;
    employeeSalaryPaymentFreq: number;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class Course{
    courseId: number;
    periodeId: number;
    institutionClassId: number;
    courseLevel: string;
    courseTitle: string;
    courseShortName: string;
    courseCreditHours: string;
    courseDesc: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class Event{
    eventId: number;
    userId: number;
    eventTitle: string;
    eventDesc: string;
    eventDstart: string;
    eventDend: string;
    eventConcerns: string;
    eventDetails: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class EmployeePaymentModel{
    paymentEmployeeId: number;
    employeeId: number;
    paymentEmployeeValue: number;
    paymentEmployeeDetails: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;
}

export class UserModel{
    userId: string;
    userPrivilege: number;
    userFirstname: string;
    userLastname: string;
    userTitle: string;
    userSex: string;
    userPhone: string;
    userEmail: string;
    userUsername: string;
    userPassword: string;
    userCode: string; 
    userImg: string;
    userDetails: string;
    userActive: boolean;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;

    constructor(
        id:string, 
        priv: number,
        fname: string, 
        lname: string, 
        title: string, 
        sex: string, 
        phone: string, 
        email: string, 
        username: string, 
        pwd: string, 
        code:string, 
        img:string, 
        details: string, 
        act: boolean,
        cBy: string,
        dCreated: string,
        mBy: string,
        dMod: string
        ){
             this.userId = id;
             this.userPrivilege = priv;
             this.userFirstname = fname;
             this.userLastname = lname;
             this.userTitle = title;
             this.userSex = sex;
             this.userPhone = phone;
             this.userEmail = email;
             this.userUsername = username;
             this.userPassword = pwd;
             this.userCode = code;
             this.userImg = img;
             this.userDetails = details;
             this.userActive = act
             this.createdBy = cBy;
             this.dateCreated = dCreated;
             this.modifiedBy = mBy;
             this.dateModified = dMod;
  }
}

export class Counter{
    stdCounter: number;
    tchCounter: number;
    empCounter: number;
}


export class PaymentPeriodModel{
    paymentPeriodeId: number;
    institutionClassId: number;
    periodeId: number;
    paymentPeriodeValue: number;
    paymentPeriodeDateStart:string;
    paymentPeriodeDateEnd: string;
    paymentPeriodeDetails: string;
    createdBy: string;
    dateCreated: string;
    modifiedBy: string;
    dateModified: string;

    init(){
        this.paymentPeriodeId = 0;
        this.institutionClassId = 0;
        this.periodeId = 0;
        this.paymentPeriodeValue = 0;
        this.paymentPeriodeDateStart = " ";
        this.paymentPeriodeDateEnd = " ";
        this.paymentPeriodeDetails = " ";
        this.createdBy = " ";
        this.dateCreated = " ";
        this.modifiedBy = " ";
        this.dateModified = " "; 
    }
}