PSOPOST9 ;BIR/MR-Reminders Index Post-Install Routine ;10/12/2004
 ;;7.0;OUTPATIENT PHARMACY;**118**;DEC 1997
 ;Reference to PXRMP12I supported by DBIA 3736
 ;
CPSRX ;Create cross-references for Prescription file.
 N IND,MSG,NAME,RESULT,XREF
 D MES^XPDUTL("Creating Prescription file cross-references...")
 S XREF("FILE")=52
 S XREF("WHOLE KILL")="Q"
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders index."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular drug and one for"
 S XREF("DESCR",3)="finding all the drugs a patient has. The indexes are"
 S XREF("DESCR",4)="stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(52,""IP"",DRUG,DFN,START DATE,STOP DATE,DAS)"
 S XREF("DESCR",6)=" ^PXRMINDX(52,""PI"",DFN,DRUG,START DATE,STOP DATE,DAS)"
 S XREF("DESCR",8)="respectively. START DATE is the RELEASE DATE and STOP DATE is"
 S XREF("DESCR",9)="calculated by adding the DAYS SUPPLY to the RELEASE DATE."
 S XREF("DESCR",10)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="F"
 S XREF("ACTIVITY")="IR"
 ;
 ;Original node
 S XREF("ROOT FILE")=52
 S XREF("NAME")="ACRO"
 S XREF("SET")="D SKIDX^PSOPXRMU(.X,.DA,""O"",""S"")"
 S XREF("KILL")="D SKIDX^PSOPXRMU(.X,.DA,""O"",""K"")"
 S XREF("VAL",1)=8
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=31
 S XREF("VAL",2,"SUBSCRIPT")=2
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 ;Refill node
 S XREF("ROOT FILE")=52.1
 S XREF("NAME")="ACRR"
 S XREF("SET")="D SKIDX^PSOPXRMU(.X,.DA,""R"",""S"")"
 S XREF("KILL")="D SKIDX^PSOPXRMU(.X,.DA,""R"",""K"")"
 S XREF("VAL",1)=1.1
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=17
 S XREF("VAL",2,"SUBSCRIPT")=2
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 ;
 ;Partial node
 S XREF("ROOT FILE")=52.2
 S XREF("NAME")="ACRP"
 S XREF("SET")="D SKIDX^PSOPXRMU(.X,.DA,""P"",""S"")"
 S XREF("KILL")="D SKIDX^PSOPXRMU(.X,.DA,""P"",""K"")"
 S XREF("VAL",1)=.041
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=8
 S XREF("VAL",2,"SUBSCRIPT")=2
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 D MES^XPDUTL("OK!")
 Q
 ;
