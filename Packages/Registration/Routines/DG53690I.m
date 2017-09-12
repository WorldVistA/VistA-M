DG53690I ;SLC/PKR - Init for patch 690. ;02/17/2006
 ;;5.3;Registration;**690**;Aug 13, 1993
 ;===============================================================
CXREFS ;Create the cross-references.
 N DGRESULT,DGXREF,MSG,TEXT
 S TEXT=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")_" Creating cross-references."
 D BMES^XPDUTL(.TEXT)
 ;Parameters common to all the service cross-references.
 S DGXREF("FILE")=2,DGXREF("TYPE")="MUMPS",DGXREF("ROOT FILE")=2
 S DGXREF("USE")="ACTION",DGXREF("EXECUTION")="RECORD",DGXREF("ACTIVITY")="R"
 ;Cross-reference for LAST
 S DGXREF("NAME")="ASERLAST"
 S DGXREF("SHORT DESCR")="Index LAST ENTRY and SEPARATION dates"
 S DGXREF("DESCR",1)="This cross-reference indexes the LAST ENTRY and SEPARATION dates."
 S DGXREF("DESCR",2)="The form of the index is:"
 S DGXREF("DESCR",3)="  ^DPT(""ASERVICE"",SEPARATION DATE,ENTRY DATE,DA,""LAST"")"
 S DGXREF("DESCR",4)=""
 S DGXREF("DESCR",5)="If one of the dates is missing the corresponding subscript is replaced by U_DA."
 S DGXREF("SET")="D SSERV^DGSRVICE(.X,.DA,""LAST"")"
 S DGXREF("KILL")="D KSERV^DGSRVICE(.X,.DA,""LAST"")"
 S DGXREF("WHOLE KILL")="K ^DPT(""ASERVICE"")"
 S DGXREF("VAL",1)=.326
 S DGXREF("VAL",2)=.327
 D CREIXN^DDMOD(.DGXREF,"S",.DGRESULT,"","MSG")
 I DGRESULT="" D
 . S TEXT="Could not create ASERLAST cross-reference"
 . D BMES^XPDUTL(.TEXT)
 ;Cross-reference for NTL.
 K DGRESULT,MSG
 S DGXREF("NAME")="ASERNTL"
 S DGXREF("SHORT DESCR")="Index NTL ENTRY and SEPARATION dates"
 S DGXREF("DESCR",1)="This cross-reference indexes the NTL ENTRY and SEPARATION dates."
 S DGXREF("DESCR",2)="The form of the index is:"
 S DGXREF("DESCR",3)="  ^DPT(""ASERVICE"",SEPARATION DATE,ENTRY DATE,DA,""NTL"")"
 S DGXREF("DESCR",4)=""
 S DGXREF("DESCR",5)="If one of the dates is missing the corresponding subscript is replaced by U_DA."
 S DGXREF("SET")="D SSERV^DGSRVICE(.X,.DA,""NTL"")"
 S DGXREF("KILL")="D KSERV^DGSRVICE(.X,.DA,""NTL"")"
 S DGXREF("WHOLE KILL")="K ^DPT(""ASERVICE"")"
 S DGXREF("VAL",1)=.3292
 S DGXREF("VAL",2)=.3293
 D CREIXN^DDMOD(.DGXREF,"S",.DGRESULT,"","MSG")
 I DGRESULT="" D
 . S TEXT="Could not create ASERNTL cross-reference"
 . D BMES^XPDUTL(.TEXT)
 ;Cross-reference for NNTL.
 K DGRESULT,MSG
 S DGXREF("NAME")="ASERNNTL"
 S DGXREF("SHORT DESCR")="Index NNTL ENTRY and SEPARATION dates"
 S DGXREF("DESCR",1)="This cross-reference indexes the NNTL ENTRY and SEPARATION dates."
 S DGXREF("DESCR",2)="The form of the index is:"
 S DGXREF("DESCR",3)="  ^DPT(""ASERVICE"",SEPARATION DATE,ENTRY DATE,DA,""NNTL"")"
 S DGXREF("DESCR",4)=""
 S DGXREF("DESCR",5)="If one of the dates is missing the corresponding subscript is replaced by U_DA."
 S DGXREF("SET")="D SSERV^DGSRVICE(.X,.DA,""NNTL"")"
 S DGXREF("KILL")="D KSERV^DGSRVICE(.X,.DA,""NNTL"")"
 S DGXREF("WHOLE KILL")="K ^DPT(""ASERVICE"")"
 S DGXREF("VAL",1)=.3297
 S DGXREF("VAL",2)=.3298
 D CREIXN^DDMOD(.DGXREF,"S",.DGRESULT,"","MSG")
 I DGRESULT="" D
 . S TEXT="Could not create ASERNNTL cross-reference"
 . D BMES^XPDUTL(.TEXT)
 ;Cross-reference TYPE OF PATIENT
 ;For test sites
 D DELIXN^DDMOD(2,"PTYPE","K","","MSG")
 K ^DPT("PTYPE")
 K DGRESULT,DGXREF,MSG
 S DGXREF("FILE")=2,DGXREF("TYPE")="R",DGXREF("ROOT FILE")=2
 S DGXREF("USE")="S",DGXREF("EXECUTION")="FIELD",DGXREF("ACTIVITY")="R"
 S DGXREF("NAME")="APTYPE"
 S DGXREF("SHORT DESCR")="Index TYPE OF PATIENT"
 S DGXREF("SET")="S ^DPT(""APTYPE"",X,DA)="""""
 S DGXREF("KILL")="K ^DPT(""APTYPE"",X,DA)"
 S DGXREF("WHOLE KILL")="K ^DPT(""APTYPE"")"
 S DGXREF("VAL",1)=391
 S DGXREF("VAL",1,"SUBSCRIPT")=1
 D CREIXN^DDMOD(.DGXREF,"S",.DGRESULT,"","MSG")
 I DGRESULT="" D
 . S TEXT="Could not create TYPE cross-reference"
 . D BMES^XPDUTL(.TEXT)
 S TEXT=$$FMTE^XLFDT($$NOW^XLFDT,"5Z")_" Cross-references have been created and indexes populated."
 D BMES^XPDUTL(.TEXT)
 Q
 ;
 ;===============================================================
DXREFS ;Delete the cross-references.
 N MSG
 D DELIXN^DDMOD(2,"ASERLAST","K","","MSG")
 D DELIXN^DDMOD(2,"ASERNTL","K","","MSG")
 D DELIXN^DDMOD(2,"ASERNNTL","K","","MSG")
 D DELIXN^DDMOD(2,"APTYPE","K","","MSG")
 Q
 ;
 ;===============================================================
POST ;Post-inits
 D CXREFS^DG53690I
 Q
 ;
