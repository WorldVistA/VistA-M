YSP77I ; SLC/PKR - Create cross-references. ;10/12/2004
 ;;5.01;MENTAL HEALTH;**77**;Dec 30, 1994
 ;
 Q
CMH ;Create cross-reference for Psych Instrument Patient File.
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating Mental Health cross-reference.")
 S XREF("FILE")=601.2
 S XREF("ROOT FILE")=601.22
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders cross-reference."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular mental health instrument and one for finding all"
 S XREF("DESCR",3)="the mental health instruments a patient has."
 S XREF("DESCR",4)="The index is stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(601.2,""IP"",INSTRUMENT,DFN,COMPLETION DATE,DAS)"
 S XREF("DESCR",6)=" ^PXRMINDX(601.2,""PI"",DFN,INSTRUMENT,COMPLETION DATE,DAS)"
 S XREF("DESCR",7)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("WHOLE KILL")="K ^PXRMINDX(601.2)"
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("NAME")="ACR"
 S XREF("SET")="D SMH^YTPXRM(.X,.DA)"
 S XREF("KILL")="D KMH^YTPXRM(.X,.DA)"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
 ;
