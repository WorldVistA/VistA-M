SYNFHF  ;ven/gpl - fhir loader utilities ;2018-08-17  3:27 PM
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ; Authored by George P. Lilly 2017-2018
 ;
 ; Health Factors
 q
 ;
HFCPCAT(CODE,TEXT) ; returns ien^name for the Health Factor Category
 ; for the Care Plan category. This ien will be needed for all
 ; calls to get Care Plan, Activity, and Goal Health Factors
 ;
 n COMMENT
 s COMMENT="SYN Care Plan Health Factor Category for: "_CODE_" "_TEXT
 q $$GETHF("CPCAT","",CODE,TEXT,1,COMMENT,1)
 ;
HFCP(CODE,TEXT,CAT) ; returns ien^name for the Care Plan Health Factor
 ; CAT is the ien^name (name optional) of the Health Factor Category
 ; for this Care Plan Health Factor
 ; CODE is the Snomed code for the Care Plan Category
 ; TEXT is the Snomed text for the Care Plan Category
 ;
 n COMMENT
 s COMMENT="SYN Care Plan Health Factor for: "_CODE_" "_TEXT
 q $$GETHF("CP",CAT,CODE,TEXT,0,COMMENT,1)
 ;
HFACT(CODE,TEXT,CAT) ; returns ien^name for a Care Plan Activity
 ; in the Care Plan Category CAT (ien)
 ;
 n COMMENT
 s COMMENT="SYN Care Plan Activity Health Factor for: "_CODE_" "_TEXT
 q $$GETHF("ACT",CAT,CODE,TEXT,0,COMMENT,1)
 ;
HFADDR(CODE,TEXT,CAT) ; returns ien^name for a Care Plan Address HF
 ; in the Care Plan Category CAT (ien)
 ;
 n COMMENT
 s COMMENT="SYN Care Plan Adresses Health Factor for: "_CODE_" "_TEXT
 q $$GETHF("ADDR",CAT,CODE,TEXT,0,COMMENT,1)
 ;
HFGOAL(CODE,CAT,TEXT,DIAG) ; returns ien^name for a Care Plan Goal
 ; in the Care Plan Category CAT (ien)
 ; DIAG is the diagnosis code^text for the problem the goal addresses (opt)
 ;
 n COMMENT
 s COMMENT=TEXT_" which addresses: "_$g(DIAG)
 q $$GETHF("GOAL",$g(CAT),CODE,TEXT,0,COMMENT,1)
 ;
 ;
HFPOV(CODE,TEXT) ; returns ien^name for the Purpose of Visit Health Factor
 ; in the SYN POV  health factor category
 ;
 ;
 N CMT0
 s CMT0="SYN Purpose of Visit SNOMED Codes"
 n ien
 s ien=$$GETHF("POV",,"","Purpose of visit codes",1,CMT0,0)
 n COMMENT
 s COMMENT="SYN Purpose of Visit Health Factor for: "_CODE_" "_TEXT
 q $$GETHF("POV",ien,CODE,TEXT,0,COMMENT,1)
 ;
HFPROC(CODE,TEXT) ; returns the ien^name of the Procedures Health Factor
 ; in category SYN SNOMED PROCEDURES
 ;
 N CMT0
 s CMT0="SYN Procedure Health Codes"
 n ien
 s ien=$$GETHF("POV",,"","Procedure codes",1,CMT0,0)
 n COMMENT
 s COMMENT="SYN Procedure Health Factor for: "_CODE_" "_TEXT
 q $$GETHF("PROC",,CODE,TEXT,0,COMMENT,1)
 ;
 ; the following are private routines used by the above public APIs
 ;
GETHF(SYNCAT,HFCAT,CODE,TEXT,ISHFCAT,CMT,LAYGO) ;
 ; returns ien^name of the health factor
 ; SYNCAT is the text abbrieviation of the kind of health factor one of:
 ;   CPCAT = care plan category
 ;   CP = care plan
 ;   ACT = care plan activity
 ;   GOAL = care plan goal
 ;   POV = purpose of visit
 ;   PROC = SNOMED procedure
 ; if ISHFCAT=1 the HEALTH FACTOR is a HEALTH FACTOR category
 ; if LAYGO=1 the HEALTH FACTOR will be created if it does not exist
 ;
 n name,ien,cpart,nlen,cde,cdesys
 s (cpart,cde,cdesys)=""
 i CODE[":" d  ;
 . s cpart=" ("_CODE_")"
 . s cde=$p(CODE,":",2)
 . s cdesys=$p(CODE,":",1)
 e  d  ;
 . q:$G(CODE)=""
 . s cpart=" (SCT:"_CODE_")"
 . s cde=CODE
 . s cdesys="SCT"
 s nlen=64-$l(cpart)
 s name="SYN "_SYNCAT_" "_TEXT
 i $l(name)>nlen s name=$e(name,1,nlen)
 s name=name_cpart
 s pname=TEXT ; print name
 s name=$$UP^XLFSTR(name) ; hf name
 i ISHFCAT=1 d  ; name for a health factor category
 . i $l(name)>60 s name=$e(name,1,60) ; leave room for [C]
 . s name=name_" [C]"
 s ien=$o(^AUTTHF("B",name,""))
 i ien'=""  q ien_"^"_name
 ; hf not found
 i $g(LAYGO)'=1 Q "-1^Health Factor not found: "_name
 n FDA,fn,fncode
 s fn=9999999.64
 s fncode=9999999.66
 s FDA(fn,"?+1,",.01)=name
 s FDA(fn,"?+1,",.03)=+HFCAT
 s FDA(fn,"?+1,",.08)="Y"
 s FDA(fn,"?+1,",.1)=$s($G(ISHFCAT)=1:"C",1:"F")
 s FDA(fn,"?+1,",100)="L"
 s FDA(fn,"?+1,",200)=$G(CMT)
 ;s FDA(fn,"?+1,",201)=$G(CMT) ; WORD PROCESSING FIELD
 I $D(^DD(9999999.64,200)) D  ; this system has the codes subfile
 . q:cdesys=""
 . s FDA(fncode,"?+2,?+1,",.01)=cdesys ; always code system
 . s FDA(fncode,"?+2,?+1,",1)=cde ;
 . s FDA(fncode,"?+2,?+1,",2)=$p($$NOW^XLFDT,".",1) ;
 n err
 D UPDIE(.FDA,.ien)
 i ien="" s ien=$o(^AUTTHF("B",name,""))
 q ien_"^"_name
 ;
UPDIE(ZFDA,ZIEN) ; INTERNAL ROUTINE TO CALL UPDATE^DIE AND CHECK FOR ERRORS
 ; ZFDA IS PASSED BY REFERENCE
 ; ZIEN IS PASSED BY REFERENCE
 ;D:$G(DEBUG)
 ;. ZWRITE ZFDA
 ;. B
 K ZERR
 D CLEAN^DILF
 D UPDATE^DIE("K","ZFDA","ZIEN","ZERR")
 I $D(ZERR) ZWR ZERR
 I '$G(TRUST) I $D(ZERR) S ZZERR=ZZERR ; ZZERR DOESN'T EXIST,
 ; INVOKE THE ERROR TRAP IF TASKED
 ;. W "ERROR",!
 ;. ZWR ZERR
 ;. B
 K ZFDA
 Q
 ;
