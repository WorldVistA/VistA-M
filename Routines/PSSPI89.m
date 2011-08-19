PSSPI89 ; BIR/PKR - Init for PSS*1.0*89. ;10/12/2004
 ;;1.0;PHARMACY DATA MANAGEMENT;**89**;9/30/97
 ;
 Q
 ;===============================================================
CNVA ;Create non-VA med cross-reference in Pharmacy Patient file.
 N IND,MSG,NAME,RESULT,XREF
 D BMES^XPDUTL("Creating Pharmacy Patient non-VA med cross-reference.")
 S XREF("FILE")=55
 S XREF("WHOLE KILL")="K ^PXRMINDX(""55NVA"")"
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders index."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a pharmacy orderable item and one for"
 S XREF("DESCR",3)="finding all the pharmacy orderable items a patient has. The indexes are"
 S XREF("DESCR",4)="stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(""55NVA"",""IP"",POI,DFN,START DATE,STOP DATE,DAS)"
 S XREF("DESCR",6)=" ^PXRMINDX(""55NVA"",""PI"",DFN,POI,START DATE,STOP DATE,DAS)"
 S XREF("DESCR",8)="respectively. POI is the pharmacy orderable item."
 S XREF("DESCR",9)="If there is no START DATE then the DOCUMENTED DATE is used in its place."
 S XREF("DESCR",10)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("ROOT FILE")=55.05
 S XREF("NAME")="ACRNVA"
 S XREF("SET")="D SNVA^PSOPXRMU(.X,.DA)"
 S XREF("KILL")="D KNVA^PSOPXRMU(.X,.DA)"
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=11
 S XREF("VAL",2,"SUBSCRIPT")=2
 S XREF("VAL",3)=8
 S XREF("VAL",4)=6
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===============================================================
CPSPA ;Create cross-references for Pharmacy Patient.
 N IND,MSG,NAME,RESULT,XREF
 D BMES^XPDUTL("Creating Pharmacy Patient cross-references.")
 S XREF("FILE")=55
 S XREF("SET CONDITION")="S X=$$PATCH^XPDUTL(""PXRM*1.5*12"")"
 S XREF("KILL CONDITION")="S X=$$PATCH^XPDUTL(""PXRM*1.5*12"")"
 S XREF("WHOLE KILL")="K ^PXRMINDX(55)"
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders index."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular drug and one for"
 S XREF("DESCR",3)="finding all the drugs a patient has. The indexes are"
 S XREF("DESCR",4)="stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(55,""IP"",DRUG,DFN,START,STOP,DAS)"
 S XREF("DESCR",6)=" ^PXRMINDX(55,""PI"",DFN,DRUG,START,STOP,DAS)"
 S XREF("DESCR",8)="respectively. START is the start date and STOP is the stop date."
 S XREF("DESCR",9)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 ;
 ;Unit Dose
 S XREF("ROOT FILE")=55.06
 S XREF("NAME")="ACRUD"
 S XREF("SET")="D SPSPA^PSJXRFS(.X,.DA,""UD"")"
 S XREF("KILL")="D KPSPA^PSJXRFK(.X,.DA,""UD"")"
 S XREF("VAL",1)=10
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=34
 S XREF("VAL",2,"SUBSCRIPT")=2
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="",$T(DCERRMSG^PXRMP12I) D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 ;IV node
 S XREF("ROOT FILE")=55.01
 S XREF("NAME")="ACRIV"
 S XREF("SET")="D SPSPA^PSJXRFS(.X,.DA,""IV"")"
 S XREF("KILL")="D KPSPA^PSJXRFK(.X,.DA,""IV"")"
 S XREF("VAL",1)=.02
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=.03
 S XREF("VAL",2,"SUBSCRIPT")=2
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="",$T(DCERRMSG^PXRMP12I) D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
 ;===================================================
POST ;Post-init
 D CNVA
 D CPSPA
 Q
 ;
