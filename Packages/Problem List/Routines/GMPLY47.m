GMPLY47 ;ISL/TC - Post-install for GMPL*2.0*47 ;12/21/15  13:39
 ;;2.0;Problem List;**47**;Aug 25,1994;Build 58
 ;
 ;===========================================
 ; INDEXD^PXRMDIEV    ICR #6059
 ;
CACRMTA ;Create the auxillary cross-reference for Mapping Targets multiple.
 N MSG,NAME,RESULT,XREF
 D BMES^XPDUTL("Creating Problem List Mapping Targets auxillary cross-reference.")
 S XREF("FILE")=9000011
 S XREF("ROOT FILE")=9000011
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders Index for Mapping Targets code lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular Mapping Target code and one for"
 S XREF("DESCR",3)="finding all the Mapping Target codes a patient has. The indexes are"
 S XREF("DESCR",4)="stored in the Clinical Reminders Index global as:"
 S XREF("DESCR",5)=" ^PXRMINDX(9000011,CODESYS,""ISPP"",CODE,STATUS,PRIORITY,DFN,DLM,DAS)"
 S XREF("DESCR",6)=" ^PXRMINDX(9000011,CODESYS,""PSPI"",DFN,STATUS,PRIORITY,CODE,DLM,DAS)"
 S XREF("DESCR",7)="respectively."
 S XREF("DESCR",8)=" "
 S XREF("DESCR",9)="CODESYS is the standard three-character abbreviation for the coding system."
 S XREF("DESCR",10)="STATUS can be ""A"" for active or ""I"" for inactive. PRIORITY"
 S XREF("DESCR",11)="can be ""A"" for acute or ""C"" for chronic. If PRIORITY is"
 S XREF("DESCR",12)="missing, then a ""U"" will be stored in the Index. For"
 S XREF("DESCR",13)="Problems whose PRIORITY is ""C"", Clinical Reminders uses"
 S XREF("DESCR",14)="today's date for the date of the Problem. In all other"
 S XREF("DESCR",15)="cases, Clinical Reminders uses DLM, where DLM is the Date"
 S XREF("DESCR",16)="Last Modified. When Problems are ""removed"", then CONDITION"
 S XREF("DESCR",17)="is set to ""H"" for hidden. Hidden Problems are not indexed."
 S XREF("DESCR",18)="For complete details, see the Clinical Reminders Index"
 S XREF("DESCR",19)="Technical Guide/Programmer's Manual."
 S XREF("DESCR",20)=""
 S XREF("DESCR",21)="This cross-reference is based on the fields DATE LAST"
 S XREF("DESCR",22)="MODIFIED, STATUS, PRIORITY, and CONDITION because the first"
 S XREF("DESCR",23)="three are Index subscripts Problems whose CONDITION equals"
 S XREF("DESCR",24)="HIDDEN are not indexed."
 ;
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=.03
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=.12
 S XREF("VAL",2,"SUBSCRIPT")=2
 S XREF("VAL",3)=1.14
 S XREF("VAL",4)=1.02
 ;
 S XREF("NAME")="ACRMTA"
 S XREF("SET")="D SPROBMTA^GMPLPXRM(.X,.DA)"
 S XREF("KILL")="D KPROBMTA^GMPLPXRM(.X,.DA)"
 ;Remove any existing cross-references before creating the new one.
 D DELIXN^DDMOD(9000011,"ACRMTA","","MSG")
 K MSG
 D CREIXN^DDMOD(.XREF,"",.RESULT,"","MSG")
 Q
 ;
POST ; Post-install subroutine
 ;Create the new cross-reference
 D CACRMTA
 ;Call Reminders reindexing API to clean up any ACRMT indexes that didn't get deleted appropriately.
 D REINDEX
 Q
 ;
REINDEX ;Rebuild the Problem List portion of the Clinical Reminders Index.
 N TEXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 S ZTRTN="INDEX^GMPLY47"
 S ZTDESC="Problem List Clinical Reminders Index rebuild"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 S TEXT(1)="Problem List Clinical Reminders Index rebuild queued."
 S TEXT(2)="The task number is "_ZTSK_"."
 D MES^XPDUTL(.TEXT)
 Q
INDEX ;Disable reminder evaluations prior to reindexing.
 K ^PXRMINDX(9000011,"DATE BUILT")
 D INDEXD^PXRMDIEV(9000011) ;disable/re-eanble evaluations
 D INDEX^GMPLPXRM
 Q
