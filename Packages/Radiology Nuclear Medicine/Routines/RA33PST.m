RA33PST ;HOIFO/SWM-Post Install for RA*5*33 ;10/12/2004
 ;;5.0;Radiology/Nuclear Medicine;**33**;Mar 16, 1998
 ; IA #3736 grants use of DCERRMSG^PXRMP12I
CRAD ;Create cross-reference for RAD/NUC MED PATIENT file.
 ; code below is taken from CRAD^PXRMP12X
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating RAD/NUC MED PATIENT cross-reference.")
 ;Set the XREF nodes
 S XREF("FILE")=70
 S XREF("ROOT FILE")=70.03
 S XREF("WHOLE KILL")="K ^PXRMINDX(70)"
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders index."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular radiology procedure and one for finding all"
 S XREF("DESCR",3)="the radiology procedures a patient has."
 S XREF("DESCR",4)="The indexes are stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(70,""IP"",PROCEDURE,DFN,EXAM DATE,DAS) and"
 S XREF("DESCR",6)=" ^PXRMINDX(70,""PI"",DFN,PROCEDURE,EXAM DATE,DAS)"
 S XREF("DESCR",7)="respectively."
 S XREF("DESCR",8)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=2
 S XREF("VAL",1,"SUBSCRIPT")=1
 ;
 S XREF("NAME")="ACR"
 S XREF("SET")="D SRAD^RAPXRM(.X,.DA)"
 S XREF("KILL")="D KRAD^RAPXRM(.X,.DA)"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
