GMV6PST ;HIOFO/FT-Create Clinical Reminders Index ;10/14/04  11:35
 ;;5.0;GEN. MED. REC. - VITALS;**6**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ;  #3736 - ^PXRMP12I calls    (private)
 ; #10141 - ^XPDUTL calls      (supported)
 ;
CGMRVVM ; Create cross-reference for GMRV Vital Measurement file (#120.5)
 N MSG,RESULT,XREF
 D BMES^XPDUTL("Creating GMRV Vital Measurement cross-reference.")
 S XREF("FILE")=120.5
 S XREF("ROOT FILE")=120.5
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders cross-reference."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular vital measurement and one for finding all"
 S XREF("DESCR",3)="the vital measurements a patient has."
 S XREF("DESCR",4)="The index is stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(120.5,""IP"",MEASUREMENT,DFN,DATE/TIME TAKEN,DAS)"
 S XREF("DESCR",6)=" ^PXRMINDX(120.5,""PI"",DFN,MEASUREMENT,DATE/TIME TAKEN,DAS)"
 S XREF("DESCR",7)="Entries that are marked as entered-in-error are not indexed."
 S XREF("DESCR",8)="Permission to use the PXRM namespace is documented in IAs 3736 and 4114."
 S XREF("DESCR",9)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("WHOLE KILL")="K ^PXRMINDX(120.5)"
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=.02
 S XREF("VAL",2,"SUBSCRIPT")=2
 S XREF("VAL",3)=.03
 S XREF("VAL",3,"SUBSCRIPT")=3
 S XREF("VAL",4)=2
 S XREF("NAME")="ACR"
 S XREF("SET")="D SVITAL^GMVPXRM(.X,.DA)"
 S XREF("KILL")="D KVITAL^GMVPXRM(.X,.DA)"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
