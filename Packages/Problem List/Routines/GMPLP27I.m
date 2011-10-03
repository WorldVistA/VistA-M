GMPLP27I ;SLC/JVS - Create cross-references. ;10/08/2004
 ;;2.0;Problem List;**27**;Aug 25, 1994
 ;
 Q
 ;===============================================================
CPROB ;Create cross-reference for Problem List.
 N IND,MSG,NAME,RESULT,XREF
 D BMES^XPDUTL("Creating Problem List cross-reference.")
 S XREF("FILE")=9000011
 S XREF("ROOT FILE")=9000011
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000011)"
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders index for ICD9 lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular ICD9 code and one for"
 S XREF("DESCR",3)="finding all the ICD9 codes a patient has. The indexes are"
 S XREF("DESCR",4)="stored in the Clinical Reminders index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(9000011,""ISPP"",ICD9,STATUS,PRIORITY,DFN,DLM,DAS)"
 S XREF("DESCR",6)=" ^PXRMINDX(9000011,""PSPI"",DFN,STATUS,PRIORITY,ICD9,DLM,DAS)"
 S XREF("DESCR",8)="respectively."
 S XREF("DESCR",9)=" "
 S XREF("DESCR",10)="STATUS can be ""A"" for active or ""I"" for inactive."
 S XREF("DESCR",11)="PRIORITY can be ""A"" for acute or ""C"" for chronic. If"
 S XREF("DESCR",12)="PRIORITY is missing then a ""U"" will be stored in the index."
 S XREF("DESCR",13)="For Problems whose PRIORITY is ""C"" Clinical Reminders uses"
 S XREF("DESCR",14)="today's date for the date of the Problem. In all other"
 S XREF("DESCR",15)="cases Clinical Reminders uses DLM where DLM is the date last modified."
 S XREF("DESCR",16)="When Problems are ""removed"" then CONDITION is set"
 S XREF("DESCR",17)="to ""H"" for hidden. Hidden Problems are not indexed."
 S XREF("DESCR",18)="For all the details, see the Clinical Reminders Index Technical Guide/Programmer's Manual."
 S XREF("USE")="ACTION"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=.02
 S XREF("VAL",2,"SUBSCRIPT")=2
 S XREF("VAL",3)=.03
 S XREF("VAL",3,"SUBSCRIPT")=3
 S XREF("VAL",4)=.12
 S XREF("VAL",4,"SUBSCRIPT")=4
 S XREF("VAL",5)=1.14
 S XREF("VAL",6)=1.02
 ;
 S XREF("NAME")="ACR"
 S XREF("SET")="D SPROB^GMPLPXRM(.X,.DA)"
 S XREF("KILL")="D KPROB^GMPLPXRM(.X,.DA)"
 S XREF("WHOLE KILL")="K ^PXRMINDX(9000011)"
 D CREIXN^DDMOD(.XREF,"k",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^PXRMP12I(.MSG,.XREF)
 Q
