VPREVNT ;SLC/MKB -- VistA event listeners ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,15,17,19,21,20,26,25,27,29,31**;Sep 01, 2011;Build 3
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References               DBIA#
 ; -------------------               -----
 ; DG FIELD MONITOR                   3344
 ; DG SA FILE ENTRY NOTIFIER          7232
 ; DGPM MOVEMENT EVENTS               1181
 ; GMPL EVENT                         6065
 ; GMRA ASSESSMENT CHANGE             6986
 ; GMRA ENTERED IN ERROR              1467
 ; GMRA SIGN-OFF ON DATA              1469
 ; GMRA VERIFY DATA                   1470
 ; IBCN NEW INSURANCE                 7010
 ; MDC OBSERVATION UPDATE             6084
 ; PSB EVSEND VPR                     6085
 ; PXK VISIT DATA EVENT               1298
 ; SCMC PATIENT TEAM CHANGES          7012
 ; SCMC PATIENT TEAM POSITION         7013
 ; SDAM APPOINTMENT EVENTS            1320
 ; TIU DOCUMENT ACTION EVENT          6774
 ; WV PREGNANCY STATUS CHANGE EVENT   7200
 ; ^AUPNPROB                          5703
 ; ^AUPNVSIT                          2028
 ; ^DGPM                              1865
 ; ^DGS(41.1                          3796
 ; ^DIC(42                           10039
 ; ^DPT                              10035
 ; ^GMR(120.8                         6973
 ; ^GMR(120.86                        3449
 ; ^TIU(8925.1                        5677
 ; ^TIU(8925.7                        7416
 ; %ZTLOAD                           10063
 ; DIQ                                2056
 ; XLFDT                             10103
 ;
DG ; -- DG FIELD MONITOR protocol listener
 ;   [expects variables DGDA, DGFIELD, DGFILE]
 N VPRFN S VPRFN=$G(DGFILE)
 I "^2^2.01^2.02^2.06^38.1^"'[(U_VPRFN_U) Q
 N DFN S DFN=+$G(DGDA)
 ; collect individual fields into single tasked update if possible
 D QUE^VPRHS(DFN) Q  ;skip fld check
 I VPRFN=2 D:$$FLD(+$G(DGFIELD)) QUE^VPRHS(DFN) Q
 D POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
FLD(X) ; -- Return 1 or 0, if X is a field tracked by VPR
 ;    via DG FIELD MONITOR
 S X=U_+$G(X)_U
 I "^.01^.02^.03^.05^.07^.08^.09^.092^.093^.351^"[X Q 1     ;demographic
 I "^.111^.1112^.112^.113^.114^.115^.131^.132^.134^"[X Q 1  ;addr/phone
 I "^.211^.212^.213^.214^.216^.217^.218^.219^.21011^"[X Q 1 ;NOK
 I "^.331^.332^.333^.334^.335^.336^.337^.338^.339^"[X Q 1   ;ECON
 I "^.301^.302^.32102^.32103^.3215^.32201^.5295^"[X Q 1     ;serv conn
 I "^.14^.323^.361^1901^"[X Q 1
 Q 0
 ;
NEWINPT() ; -- is DFN newly admitted?
 N Y S Y=0
 I DGPMT=1,DGPMA,'DGPMP,+$G(^DPT(DFN,.105))=DGPMDA S Y=1 ;new admission
 Q Y
 ;
DGPM ; -- DGPM MOVEMENT EVENTS protocol listener
 ;    [expects DFN,DGPM* variables]
 I $$NEWINPT,$$ON^VPRHS,'$$SUBS^VPRHS(DFN),$$VALID^VPRHS(DFN) D NEW^VPRHS(DFN) Q
 N ADM,VST,ADMA,ADMP
 I DGPMT'=1 D  ;update related admission if not in ^UTILITY
 . S ADM=$S(DGPMA:+$P(DGPMA,U,14),1:+$P(DGPMP,U,14))
 . Q:$D(^UTILITY("DGPM",$J,1,ADM))
 . S VST=$$VNUM^VPRSDAV(ADM) Q:'VST
 . D POST^VPRHS(DFN,"Encounter",ADM_"~"_VST_";405")
 ; process all updated admissions
 S ADM=0 F  S ADM=$O(^UTILITY("DGPM",$J,1,ADM)) Q:ADM<1  D
 . S ADMA=$G(^UTILITY("DGPM",$J,1,ADM,"A")),ADMP=$G(^("P"))
 . I ADMP,ADMA="" D CKVST Q  ;deleted (still has Visit#)
 . S VST=$$VNUM^VPRSDAV(ADM) Q:'VST
 . D POST^VPRHS(DFN,"Encounter",ADM_"~"_VST_";405")
 Q
CKVST ; -- delete visit if unused [from DGPM]
 N HLOC,VPRSQ
 S HLOC=+$G(^DIC(42,+$P(ADMP,U,6),44))
 S VST=$O(^AUPNVSIT("AET",DFN,+ADMP,HLOC,"P",0)) Q:'VST
 Q:$P($G(^AUPNVSIT(VST,0)),U,9)>0  ;D POST^VPRHS(DFN,"Encounter",VST_";9000010")
 ; save deleted encounter in ^XTMP - see DELALL^VPRENC
 K VPRSQ D POST^VPRHS(DFN,"Encounter",VST_";9000010","@",,.VPRSQ)
 I $G(VPRSQ) D SAVST^VPRENC(VPRSQ)
 Q
 ;
DGS ; -- DG SA FILE ENTRY NOTIFIER protocol listener
 N IEN,DFN,ACT S ACT=""
 S IEN=+$G(^TMP("DG SA FILE ENTRY NOTIFIER",$J,"IEN")) Q:IEN<1
 S DFN=+$G(^TMP("DG SA FILE ENTRY NOTIFIER",$J,"DFN","CURRENT"))
 I DFN<1 S DFN=+$G(^TMP("DG SA FILE ENTRY NOTIFIER",$J,"DFN","OLD")) Q:DFN<1
 I $G(^TMP("DG SA FILE ENTRY NOTIFIER",$J,"ACTION"))="DELETED" S ACT="@"
 I $G(^TMP("DG SA FILE ENTRY NOTIFIER",$J,"ACTION"))="MODIFIED",$P($G(^DGS(41.1,IEN,0)),U,13) S ACT="@"
 D POST^VPRHS(DFN,"Appointment",IEN_";41.1",ACT)
 Q
 ;
SDAM ; -- SDAM APPOINTMENT EVENTS protocol listener
 ;    [expects variables SDATA, SDAMEVT]
 N DFN,DATE,ACT Q:'$G(SDATA)
 Q:$G(SDAMEVT)>5  ;only track make, cancel, no show, check in/out
 ; quit if status has not changed
 Q:$G(SDATA("BEFORE","STATUS"))=$G(SDATA("AFTER","STATUS"))
 S DFN=+$P(SDATA,U,2) Q:DFN<1
 S DATE=+$P(SDATA,U,3),ACT=$S($G(SDAMEVT)=2:"@",1:"")
 D POST^VPRHS(DFN,"Appointment",(DATE_","_DFN_";2.98"),ACT)
 Q
 ;
GMRA(ACT) ; -- GMRA SIGN-OFF ON DATA protocol listener
 ;   also GMRA ENTERED IN ERROR [ACT=@]
 ;   [expects GMRAPA variables]
 N DFN,IEN,NEW,I
 S DFN=+$G(GMRAPA(0)),IEN=+$G(GMRAPA)
 D POST^VPRHS(DFN,"Allergy",IEN_";120.8") ;,$G(ACT))
 Q
 ;
GMRASMT(DFN) ; -- GMRA ASSESSMENT CHANGE listener
 N ACT S ACT=$S($P($G(^GMR(120.86,DFN,0)),U,2):"@",1:"")
 D POST^VPRHS(DFN,"Allergy",DFN_";120.86",ACT)
 Q
 ;
GMPL(DFN,IEN) ; -- GMPL EVENT protocol listener
 S DFN=+$G(DFN),IEN=+$G(IEN)
 N ACT S ACT=$S($P($G(^AUPNPROB(IEN,1)),U,2)="H":"@",1:"")
 D POST^VPRHS(DFN,"Problem",IEN_";9000011",ACT)
 Q
 ;
GMRV(DFN,IEN,ERR) ; -- Vital Measurement file #120.5 AVPR index
 S DFN=+$G(DFN),IEN=+$G(IEN)
 N ACT S ACT=$S($G(ERR):"@",1:"")
 D POST^VPRHS(DFN,"Observation",IEN_";120.5",ACT)
 Q
 ;
MDC(OBS) ; -- MDC OBSERVATION UPDATE protocol listener [not in use]
 N DFN,ID,ACT
 S DFN=+$G(OBS("PATIENT_ID","I")) Q:DFN<1
 S ID=$G(OBS("OBS_ID","I")) Q:'$L(ID)
 S ACT=$S('$G(OBS("STATUS","I")):"@",1:"")
 D POST^VPRHS(DFN,"Observation",ID_";704.117",ACT)
 ;I $G(OBS("DOMAIN","VITALS")) D POST^VPRHS(DFN,"Observation",ID,ACT)
 Q
 ;
CP(DFN,ID,ACT) ; -- CP Transaction file #702 AVPR index
 Q  ; via VPRPROC [no longer used]
 S DFN=+$G(DFN),ID=+$G(ID)
 N VST S VST=$$GET1^DIQ(702,ID,".06:.03","I")
 D POST^VPRHS(DFN,"Procedure",ID_";702",$G(ACT),VST)
 Q
 ;
TIU(DFN,IEN) ; -- TIU Document file #8925 AEVT index
 ;    [expects X, X1, X2 arrays from FM]
 N STS,DAD,ACT
 S DFN=+$G(DFN),IEN=+$G(IEN) Q:DFN<1  Q:IEN<1
 S STS=$G(X(2)),DAD=$G(X(3)) ;X = FM data array for index
 I STS<7 Q                   ;not complete
 I STS=9 Q                   ;archived, leave in cache unchanged
 I STS>13 Q                  ;removed, handled via protocol
 S:DAD IEN=DAD               ;if addendum, repull entire note
 S ACT=$S(X2(2)&(X1(2)=""):1,X1&(X2=""):"@",1:"") ;add/remove amendment
 D TIU^VPRENC(IEN,ACT)       ;add to ^XTMP("VPRPX") encounter list
 Q
 ;
TIUR ; -- TIU DOCUMENT ACTION EVENT listener (removing notes)
 N ARY,ACT,DFN,IEN,VST,DAD,X,VPRSQ,CLS
 S ARY=$NA(^TMP("TIUDOCACT",$J)),ACT=$G(@ARY@("ACTION"))
 I ACT="RETRACT" D  G TRQ  ;not DELETE
 . S DFN=+$G(@ARY@("PATIENT")),VST=$G(@ARY@("VISIT"))
 . S IEN=+$G(@ARY@("DOCUMENT")) Q:IEN<1  Q:DFN<1
 . S DAD=+$$GET1^DIQ(8925,IEN,.06,"I") S:DAD IEN=DAD
 . ;D TIU^VPRENC(IEN,,VST)
 ;
 Q:ACT'="REASSIGN"
 S DFN=+$G(@ARY@("PATIENT","OLD")),VST=$G(@ARY@("VISIT","OLD"))
 S IEN=+$G(@ARY@("DOCUMENT","OLD")) ;DA in NEW if patient unchanged
 S:IEN<1 IEN=+$G(@ARY@("DOCUMENT","NEW")) Q:IEN<1  Q:DFN<1
 S DAD=+$$GET1^DIQ(8925,IEN,.06,"I") I DAD D TIU^VPRENC(DAD) Q
 ; new document saved via regular index event
TRQ ; remove document from old patient/visit
 D POST^VPRHS(DFN,"Document",IEN_";8925","@",VST,.VPRSQ)
 I $G(VPRSQ) D  ;save visit
 . S ^XTMP("VPR-"_VPRSQ,IEN)=DFN_"^Document^"_IEN_";8925^D^"_VST
 . S X=+$$GET1^DIQ(8925,IEN,.01,"I"),^XTMP("VPR-"_VPRSQ,IEN,0)=X_U_DFN_U_VST
 . S ^XTMP("VPR-"_VPRSQ,0)=$$FMADD^XLFDT(DT,14)_U_DT_"^Deleted record for AVPR"
 S CLS=$$GET1^DIQ(8925,IEN,.04,"I")
 D:CLS=27 POST^VPRHS(DFN,"AdvanceDirective",IEN_";8925","@")
 D:CLS=30!(CLS=31) POST^VPRHS(DFN,"Alert",IEN_";8925","@")
 Q
 ;
TIUS(IEN) ; -- TIU MULTIPLE SIGNATURE file #8925.7 AVPR index
 S IEN=+$G(IEN) Q:IEN<1
 N TIU0,TIUIEN,DFN,VST
 S TIU0=$G(^TIU(8925.7,IEN,0)),TIUIEN=+$P(TIU0,U) Q:TIUIEN<1
 S DFN=$$GET1^DIQ(8925,TIUIEN,.02,"I") Q:DFN<1
 S VST=$$GET1^DIQ(8925,TIUIEN,.03,"I") ;Ok if null
 ; non-PCE event so post immediately for BMS
 D POST^VPRHS(DFN,"Document",TIUIEN_";8925",,VST)
 Q
 ;
IBCN ; -- IBCN NEW INSURANCE EVENTS listener
 ; expects IBCDFN, IBEVTACT="ADD","EDT", or "DEL"
 I '$G(IBCDFN) Q
 N ACT,ID,VPRSQ,I S ID=IBCDFN_","_DFN
 S ACT=$S($G(IBEVTACT)="DEL":"@",$G(IBEVTACT)="ADD":"",1:$$IBDIFF)
 D POST^VPRHS(DFN,"MemberEnrollment",ID_";2.312",ACT,,.VPRSQ)
 I ACT="@",$G(VPRSQ) D  ;save old values for delete msg
 . S ^XTMP("VPR-"_VPRSQ,ID)=DFN_"^MemberEnrollment^"_ID_";2.312^D^"
 . F I=0,1,2,3,7 S ^XTMP("VPR-"_VPRSQ,ID,I)=$G(@("IBEVTP"_I))
 . S ^XTMP("VPR-"_VPRSQ,0)=$$FMADD^XLFDT(DT,14)_U_DT_"^Deleted record for AVPR"
 I ($G(IBEVTACT)="EDT")&(ACT="@") D  ;task edit to ensure delete happens first
 . N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 . S ZTRTN="IBTASK^VPREVNT",ZTDESC="VPR Insurance Update",ZTIO=""
 . S ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,2),ZTSAVE("DFN")="",ZTSAVE("ID")=""
 . D ^%ZTLOAD
 Q
IBDIFF() ; -- return 1 or 0, if key matching values changed
 I +$G(IBEVTP0)'=+$G(IBEVTA0) Q 1
 I +$P($G(IBEVTP0),U,18)'=+$P($G(IBEVTA0),U,18) Q 1
 I +$P($G(IBEVTP7),U,2)'=+$P($G(IBEVTA7),U,2) Q 1
 Q 0
IBTASK ; -- tasked update
 Q:'$G(DFN)  Q:'$G(ID)
 D POST^VPRHS(DFN,"MemberEnrollment",ID_";2.312")
 Q
 ;
PCMMT ; -- SCMC PATIENT TEAM CHANGES protocol listener
 ;    [expects SCPTTM* variables]
 ;I '$G(SCPCTM) Q  ;not pc change
 N DFN S DFN=$S($G(SCPTTMAF):+SCPTTMAF,1:+$G(SCPTTMB4)) Q:'DFN
 D QUE^VPRHS(DFN) ;POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
PCMMTP ; -- SCMC PATIENT TEAM POSITION CHANGES protocol listener
 ;    [expects SCPTTP* variables]
 ;I '$G(SCPCTP) Q  ;not pc change
 N TM,DFN
 S TM=$S($G(SCPTTPAF):+SCPTTPAF,1:+$G(SCPTTPB4)) Q:'TM
 S DFN=+$$GET1^DIQ(404.42,TM_",",.01,"I")
 D QUE^VPRHS(DFN) ;POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
WV ; -- WV PREGNANCY STATUS CHANGE EVENT protocol listener
 N VPRPREG,VPRDFN,VPRFLD,VPRFLAG
 M VPRPREG=^TMP("WVPREGST",$J)
 Q:'$D(VPRPREG)
 S VPRDFN=+$P($G(VPRPREG("AFTER","EXTERNAL ID")),",",2)
 Q:VPRDFN=0
 ; if no before value, then new record, post
 I '$D(VPRPREG("BEFORE")) D POST^VPRHS(VPRDFN,"SocialHistory",VPRDFN_";790.05") Q
 Q:VPRDFN'=+$P($G(VPRPREG("BEFORE","EXTERNAL ID")),",",2)
 ; if external ids do not match, then additional record, post
 I $G(VPRPREG("BEFORE","EXTERNAL ID"))'=$G(VPRPREG("AFTER","EXTERNAL ID")) D POST^VPRHS(VPRDFN,"SocialHistory",VPRDFN_";790.05") Q
 ; if change in fields we send to HS, post
 S VPRFLAG=0
 F VPRFLD="FROM TIME","STATE","STATUS","TO TIME" S:$G(VPRPREG("BEFORE",VPRFLD))'=$G(VPRPREG("AFTER",VPRFLD)) VPRFLAG=1 Q:VPRFLAG=1
 I VPRFLAG=1 D POST^VPRHS(VPRDFN,"SocialHistory",VPRDFN_";790.05")
 Q
 ;
 ; Deprecated calls:
 ;
DOCDEF(IEN) ; -- TIU Document Definition file #8925.1 AVPR index
 Q
 ;
DOCITM(DAD) ; -- TIU Document Def'n Items subfile #8925.14 AVPR1 index
 Q
 ;
USR(IEN) ; -- USR Authorization/Subscription file #8930.1 AVPR index
 Q
 ;
XU(IEN,ACT) ; -- XU USER ADD/CHANGE/TERMINATE option listener
 Q
