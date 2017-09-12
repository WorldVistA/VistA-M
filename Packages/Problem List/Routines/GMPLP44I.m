GMPLP44I ; SLC/PKR - Update cross-references for Clinical Reminders Index. ;04/18/2014
 ;;2.0;Problem List;**44**;Aug 25, 1994;Build 92
 ;
 Q
 ;===========================================
AWRITE(REF) ;Write all the descendants of the array.
 N DONE,IND,LEN,LN,PROOT,ROOT,START,TEMP,TEXT
 I REF="" Q
 S LN=0
 S PROOT=$P(REF,")",1)
 ;Build the root so we can tell when we are done.
 S TEMP=$NA(@REF)
 S ROOT=$P(TEMP,")",1)
 S REF=$Q(@REF)
 I REF'[ROOT Q
 S DONE=0
 F  Q:(REF="")!(DONE)  D
 . S START=$F(REF,ROOT)
 . S LEN=$L(REF)
 . S IND=$E(REF,START,LEN)
 . S LN=LN+1,TEXT(LN)=PROOT_IND_"="_@REF
 . S REF=$Q(@REF)
 . I REF'[ROOT S DONE=1
 D MES^XPDUTL(.TEXT)
 Q
 ;
 ;===========================================
CACR01 ;Update the cross-reference for the .01 field.
 N MSG,NAME,RESULT,XREF
 D BMES^XPDUTL("Creating Problem List .01 diagnosis cross-reference.")
 S XREF("FILE")=9000011
 S XREF("ROOT FILE")=9000011
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders Index for ICD diagnosis code lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular ICD diagnosis code and one for"
 S XREF("DESCR",3)="finding all the ICD diagnosis codes a patient has. The indexes are"
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
 ;
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
 S XREF("VAL",7)=80202
 ;
 S XREF("NAME")="ACR01"
 S XREF("SET")="D SPROB01^GMPLPXRM(.X,.DA)"
 S XREF("KILL")="D KPROB01^GMPLPXRM(.X,.DA)"
 ;Remove any existing cross-references before creating the new one.
 D DELIXN^DDMOD(9000011,"ACR","","MSG")
 D DELIXN^DDMOD(9000011,"ACR01","","MSG")
 K MSG
 D CREIXN^DDMOD(.XREF,"",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^GMPLP44I(.MSG,.XREF)
 Q
 ;
 ;===========================================
CACRMT ;Create the cross-reference for Mapping Targets multiple.
 ;Make sure the field exists.
 I $$GET1^DID(9000011,80300,"","GLOBAL SUBSCRIPT LOCATION")="" Q
 N MSG,NAME,RESULT,XREF
 D BMES^XPDUTL("Creating Problem List Mapping Targets cross-reference.")
 S XREF("FILE")=9000011
 S XREF("ROOT FILE")=9000011.803
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
 ;
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=.01
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=.02
 S XREF("VAL",2,"SUBSCRIPT")=2
 ;
 S XREF("NAME")="ACRMT"
 S XREF("SET")="D SPROBMT^GMPLPXRM(.X,.DA)"
 S XREF("KILL")="D KPROBMT^GMPLPXRM(.X,.DA)"
 ;Remove any existing cross-references before creating the new one.
 D DELIXN^DDMOD(9000011,"ACRMT","","MSG")
 K MSG
 D CREIXN^DDMOD(.XREF,"",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^GMPLP44I(.MSG,.XREF)
 Q
 ;
 ;===========================================
CACRSCT ;Create the cross-reference for the SNOMED CT CONCEPT CODE.
 ;Make sure the field exists.
 I $$GET1^DID(9000011,80001,"","GLOBAL SUBSCRIPT LOCATION")="" Q
 N MSG,NAME,RESULT,XREF
 D BMES^XPDUTL("Creating Problem List SNOMED CT cross-reference.")
 S XREF("FILE")=9000011
 S XREF("ROOT FILE")=9000011
 S XREF("TYPE")="MU"
 S XREF("SHORT DESCR")="Clinical Reminders Index for SNOMED CT concept code lookup."
 S XREF("DESCR",1)="This cross-reference builds two indexes, one for finding"
 S XREF("DESCR",2)="all patients with a particular SNOMED CT code and one for"
 S XREF("DESCR",3)="finding all the SNOMED CT codes a patient has. The indexes are"
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
 ;
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=80001
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
 S XREF("NAME")="ACRSCT"
 S XREF("SET")="D SPROBSCT^GMPLPXRM(.X,.DA)"
 S XREF("KILL")="D KPROBSCT^GMPLPXRM(.X,.DA)"
 ;Remove any existing cross-references before creating the new one.
 D DELIXN^DDMOD(9000011,"ACRSCT","","MSG")
 K MSG
 D CREIXN^DDMOD(.XREF,"",.RESULT,"","MSG")
 I RESULT="" D DCERRMSG^GMPLP44I(.MSG,.XREF)
 Q
 ;
 ;===========================================
CPROBXR ;Create all the cross-references.
 D BMES^XPDUTL("Creating Clinical Reminders Index cross-references.")
 D CACR01^GMPLP44I
 D CACRSCT^GMPLP44I
 D CACRMT^GMPLP44I
 Q
 ;
 ;===========================================
DCERRMSG(MSG,XREF) ;Display cross-reference creation errors.
 D BMES^XPDUTL("A cross-reference could not be created. The error message is:")
 D AWRITE^DG53862I("MSG")
 D BMES^XPDUTL("Cross-reference information:")
 D AWRITE^DG53862I("XREF")
 Q
 ;
 ;===========================================
POST ;Post-init
 ;Update the cross-references.
 D CPROBXR^GMPLP44I
 ;Rebuild the Index in the new format.
 D REINDEX^GMPLP44I
 Q
 ;
 ;===========================================
REINDEX ;Rebuild the Problem List portion of the Clinical Reminders Index in
 ;the new structure.
 N TEXT,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSK
 ;If the Index has already been restructured don't do it again.
 I $D(^PXRMINDX(9000011,"ICD")),$D(^PXRMINDX(9000011,"DATE BUILT")) D
 . S TEXT(1)="The Problem List Index has already been rebuilt, skipping another rebuild."
 I $D(^PXRMINDX(9000011,"ICD")),'$D(^PXRMINDX(9000011,"DATE BUILT")) D
 . S TEXT(1)="The Problem List Index has been partially rebuilt; not starting another rebuild in case a rebuild is in progress."
 . S TEXT(2)="Please make sure the Index is completely rebuilt."
 I $D(TEXT(1)) D BMES^XPDUTL(.TEXT) Q
 S ZTRTN="INDEX^GMPLPXRM"
 S ZTDESC="Problem List Clinical Reminders Index rebuild"
 S ZTDTH=$H
 S ZTIO=""
 D ^%ZTLOAD
 S TEXT(1)="Problem List Clinical Reminders Index rebuild queued."
 S TEXT(2)="The task number is "_ZTSK_"."
 D MES^XPDUTL(.TEXT)
 Q
 ;
