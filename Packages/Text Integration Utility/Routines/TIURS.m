TIURS ; SLC/JER - Electronic signature actions ; 5/21/07 11:00am
 ;;1.0;TEXT INTEGRATION UTILITIES;**3,4,20,67,79,98,107,58,100,109,179,157,227**;Jun 20, 1997;Build 15
ACCEPT(TIUSLST,TIUI) ; Accept for signing
 N TIUSGN,TIUMSG,TIUPR,TIUFLAG
 I +$G(TIUDA),($G(TIUEVNT)]"") D  Q:'+$G(TIUSGN)
 . S TIUSGN=$$CANDO^TIULP(TIUDA,TIUEVNT)
 . I '+TIUSGN D
 . . D FULL^VALM1
 . . W !!,"Document has changed...",!,$P(TIUSGN,U,2)
 . . W !!,"Item #",TIUI,": Removed from signature list.",!
 . . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 S TIUSLST(TIUI)=""
 W !,"Item #",TIUI,": Added to signature list." ;H 2
 I +$P($G(TIUDPRM(0)),U,8) D
 . S TIUMSG="Print this note"
 . S TIUPR=$$READ^TIUU("Y",TIUMSG,"No")
 . I +TIUPR S TIUSLST(TIUI)=1
 I +$G(TIUPR),+$P($G(TIUDPRM(0)),U,9) D
 . S TIUFLAG=$$FLAG^TIUPRPN3
 . I +TIUFLAG S $P(TIUSLST(TIUI),U,2)=1
 I +$G(XTRASGNR) S $P(TIUSLST(TIUI),U,3)=$G(XTRASGNR)
 Q
EDSIG(TIUDA,TIUADD,TIUPASK) ; interactive sign
 N TIU,TIU0,TIU12,ASK,X,X1,TIUTYPE,SIGNER,COSIGNER,TIUTYPE,TIUMSG,TIUSTAT
 N TIUES,TIUACT,TIUDPRM,XTRASGNR,TIUCOM,TIU15,TIUCPFLD
 I +$D(TIUSIGN),(TIUSIGN=0) Q
 I '$D(TIUPRM0) D SETPARM^TIULE
 I '+$P(TIUPRM0,U,2) S VALMBCK="R" Q
 S TIUADD=1
 S TIU0=$G(^TIU(8925,+TIUDA,0)),TIU12=$G(^(12)),TIU15=$G(^(15))
 S SIGNER=$S(+$P(TIU12,U,4):$P(TIU12,U,4),1:$P(TIU12,U,2))
 S COSIGNER=$P(TIU12,U,8)
 I (DUZ'=SIGNER),(DUZ'=COSIGNER) S XTRASGNR=+$O(^TIU(8925.7,"AE",+TIUDA,+DUZ,0))
 I '$G(XTRASGNR) S XTRASGNR=$$ASURG^TIUADSIG(TIUDA)
 S TIUSTAT=+$P(TIU0,U,5)
 S TIUACT=$S(TIUSTAT'>5:"SIGNATURE",+$G(XTRASGNR):"SIGNATURE",1:"COSIGNATURE")
 S ASK=$$CANDO^TIULP(TIUDA,TIUACT)
 S TIUTYPE=$$PNAME^TIULC1(+TIU0)
 I +ASK'>0 D  Q
 . S VALMBCK="R"
 . I +$$ISA^USRLM(+$G(DUZ),"MEDICAL INFORMATION SECTION"),(+$$ISPN^TIULX(+TIU0)'>0) Q
 . I +$$ISA^USRLM(+$G(DUZ),"MAS TRANSCRIPTIONIST") Q
 . I +$$ISA^USRLM(+$G(DUZ),"TRANSCRIPTIONIST") Q
 . W !,$P(ASK,U,2)
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 W:$G(VALMAR)'="^TMP(""TIUVIEW"",$J)" !
 ;If document is a clinical procedures (CP) title, and
 ;(P179 for P182) this is not an additional signature,
 ;check if CP fields are required. If required, prompt for them
 ;and don't let user sign unless fields are defined. (P109)
 I '$G(XTRASGNR),+$$ISA^TIULX(+TIU0,+$$CLASS^TIUCP),$$REQCPF^TIULP(+$P($G(^TIU(8925,+TIUDA,14)),U,5)) D  Q:+TIUCPFLD'>0
 . I $G(^TIU(8925,+TIUDA,702)),$P(^(702),U)]"",$P(^(702),U,2)]"" S TIUCPFLD=1 Q
 . S TIUCPFLD=$$ASKCPF(TIUDA)
 . I +TIUCPFLD'>0 D
 . . W !!,"The Procedure Summary Code and Date/Time Performed MUST be entered before",!,"you may sign.",!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") ;pause
 I $S(+$$REQCOSIG^TIULP(+TIU0,+TIUDA,+SIGNER):1,+$P(TIU15,U,6):1,1:0),(+COSIGNER'>0) D  Q:+COSIGNER'>0
 . S COSIGNER=$$ASKCSNR(TIUDA,SIGNER)
 . I +COSIGNER'>0 D
 . . W !!,"This ",TIUTYPE," MUST have a cosigner before you may sign.",!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 I TIUSTAT=5,$G(DUZ)'=SIGNER D
 . S TIUMSG="Author hasn't signed, are you SURE you want to sign "_TIUTYPE
 W ! I $G(TIUMSG)]"",$$READ^TIUU("YO",TIUMSG,"NO","^D SIG^TIUDIRH")'>0 S VALMBCK="R" Q
 L +^TIU(8925,+TIUDA):1
 E  W !?5,$C(7),"Another user is editing this entry.",! W:$$READ^TIUU("EA","Press RETURN to continue...") "" S TIUQUIT=2 Q
 S TIUES=$$ASKSIG^TIULA1 L -^TIU(8925,+TIUDA) I '+TIUES Q
 I $D(VALMAR) D FULL^VALM1
 I +$G(XTRASGNR) D ADDSIG^TIURS1(TIUDA,XTRASGNR)
 I '+$G(XTRASGNR) D ES(TIUDA,TIUES)
 I $G(TIUACT)="COSIGNATURE",(+$$ISADDNDM^TIULC1(TIUDA)'>0) D  Q:+TIUCOM
 . N TIUADDND S TIUCOM=0
 . S TIUADDND=$$READ^TIUU("YO","Do you wish to add your comments in an addendum","NO")
 . I +TIUADDND D ADD^TIUADD(TIUDA,.TIUCHNG) S TIUCOM=1
 I '+$G(TIUPASK) Q
 D DOCPRM^TIULC1(+TIU0,.TIUDPRM,TIUDA)
 I +$P($G(TIUDPRM(0)),U,8) D PRINT^TIUEPRNT(TIUDA)
 Q
 ;
ASKCPF(DA) ;Ask required clinical procedure fields
 N DR,DIE,TIUY
 D FULL^VALM1
AGNCP W !!,$C(7),"You must designate the Procedure Summary Code and Date/Time Performed...",!
 L +^TIU(8925,+DA):1
 E  W !?5,$C(7),"Another user is editing this entry.",! W:$$READ^TIUU("EA","Press RETURN to continue...") "" G ASKCPFQ
 S DR="70201R;70202R"
 S DIE="^TIU(8925," D ^DIE
ASKCPFQ L -^TIU(8925,+DA)
 I $G(^TIU(8925,+DA,702)),$P(^(702),U)]"",$P(^(702),U,2)]"" S TIUY=1
 Q +$G(TIUY)
 ;
ASKCSNR(DA,SIGNER) ; Ask cosigner
 N DR,DIE,TIUY,TIUDCSNR,TIUPREF,TIUFLD
 S TIUPREF=$$PERSPRF^TIULE(SIGNER)
 S TIUDCSNR=$$PERSNAME^TIULC1($P(TIUPREF,U,9))
 I TIUDCSNR="UNKNOWN" S TIUDCSNR=""
 S TIUFLD=$S(+$$ISDS^TIULX(+$G(^TIU(8925,+DA,0))):"ATTENDING PHYSICIAN",1:"EXPECTED COSIGNER")
 D FULL^VALM1
AGN W !!,$C(7),"You must designate an ",TIUFLD,"...",!
 L +^TIU(8925,+DA):1
 E  W !?5,$C(7),"Another user is editing this entry.",! W:$$READ^TIUU("EA","Press RETURN to continue...") "" G ASKCOUT
 I $E(TIUFLD)="A" S DR="1209R//^S X=TIUDCSNR;1208////^S X=$P(^TIU(8925,DA,12),U,9);1506////1"
 E  S DR="1208R//^S X=TIUDCSNR;1506////1"
 S DIE="^TIU(8925," D ^DIE
ASKCOUT L -^TIU(8925,+DA)
 S TIUY=+$P($G(^TIU(8925,+DA,12)),U,8)
 Q TIUY
ES(DA,TIUES,TIUI) ; ^DIE call for /es/
 N SIGNER,DR,DIE,ESDT,TIUSTAT,TIUSTNOW,COSIGNER,SVCHIEF,CSREQ,TIUPRINT
 N CSNEED,TIUTTL,TIUPSIG,TIUDPRM,DAO,TIUSTWAS,TIUSTIS,DAORIG,TIUCSPRM,TIUCSPM2
 S TIUSTWAS=$P($G(^TIU(8925,DA,0)),U,5),TIUCSPRM=1,TIUCSPM2=0
 D DOCPRM^TIULC1(+$G(^TIU(8925,+DA,0)),.TIUDPRM,DA)
 S TIUSTAT=$P($G(^TIU(8925,+DA,0)),U,5),ESDT=$$NOW^TIULC
 S SVCHIEF=+$$ISA^USRLM(DUZ,"CLINICAL SERVICE CHIEF")
 S SIGNER=$P(^TIU(8925,+DA,12),U,4),COSIGNER=$P(^(12),U,8),CSREQ=0
 S CSNEED=+$P($G(^TIU(8925,+DA,15)),U,6)
 ; VMP/RJT - PATCH 227  ALLOW THIRD PARTY ONE-TIME SIGNING FOR SIGNATURE AND COSIGNATURE
 I +CSNEED,(DUZ=SIGNER),'+$G(SVCHIEF),(TIUSTAT'=6) S CSREQ=1
 I +CSNEED,(DUZ'=SIGNER),(DUZ'=COSIGNER) D
 . D THIRD I '+$G(SVCHIEF),(('+$G(TIUCSPRM))!(+$G(TIUCSPM2))),(TIUSTAT'=6) S CSREQ=1 Q
 I TIUSTAT=5 D
 . S DR=".05////"_$S(+CSREQ:6,1:7)_";1501////"_ESDT_";1502////"_+DUZ
 . I '+$G(CSREQ),+CSNEED D
 . . S DR=DR_";1506////0;1507////"_ESDT_";1508////"_+DUZ_";1509///^S X=$P(TIUES,U,2);1510///^S X=$P(TIUES,U,3);1511////E"
 I TIUSTAT=6 S DR=".05////7;1506////0;1507////"_ESDT_";1508////"_+DUZ
 Q:'$D(DR)
 S DIE=8925 D ^DIE W:'$D(XWBOS) "."
 I TIUSTAT=5 S DR="1503///^S X=$P(TIUES,U,2);1504///^S X=$P(TIUES,U,3);1505////E"
 I TIUSTAT=6 D
 . N TIUSBY S DR="",TIUSBY=$P($G(^TIU(8925,+DA,15)),U,2)
 . I +TIUSBY>0 S DR="1503///^S X=$$SIGNAME^TIULS("_TIUSBY_");1504///^S X=$$SIGTITL^TIULS("_TIUSBY_");"
 . S DR=$G(DR)_"1509///^S X=$P(TIUES,U,2);1510///^S X=$P(TIUES,U,3);1511////E"
 S DIE=8925 D ^DIE W:'$D(XWBOS) "." S:'+$G(TIUCHNG) TIUCHNG=1
 D SEND^TIUALRT(DA),SIGNIRT^TIUDIRT(+DA)
 S DAORIG=DA
 I +$$ISADDNDM^TIULC1(DA) S DA=+$P($G(^TIU(8925,+DA,0)),U,6)
 I +$G(CSREQ)'>0 D MAIN^TIUPD(DA,"S") I 1
 ;If 'Credit Stop Code on Completion' is Yes
 I +$P(^TIU(8925,+DA,0),U,11) D
 . ;If workload does not exist, process using TIU's interview otherwise
 . ;process as an edit using PCE's interview
 . I '$$CHKVST^TIUPXAP2(+DA) D  I 1
 . . N TIUCONT,TIUPRMT
 . . Q:$D(XWBOS)
 . . I $P(+$P(^TIU(8925,+DA,0),U,7),".")>DT D  Q
 . . . W !!
 . . . D QUE^TIUPXAP1
 . . . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 . . W !!
 . . ;Check if workload should be entered
 . . I $$CHKWKL^TIUPXAP2(+DA,.TIUDPRM) D CREDIT^TIUVSIT(DA)
 . E  D
 . . ;Check if workload should be entered
 . . I $$CHKWKL^TIUPXAP2(+DA,.TIUDPRM) D EDTENC^TIUPXAP2(DA)
 . D REMFLAG^TIUVSIT(+DA)
 ;If document does not have a visit and docmt is associated with
 ;an event type visit or call is invoked by broker, check if
 ;docmt can be linked to an existing visit or try and create a new
 ;visit. (P179)
 I $D(^TIU(8925,+DA,0)),$P(^(0),U,3)'>0,($P(^(0),U,13)="E"!($$BROKER^XWBLIB)) D
 . N D0,DFN,TIU,TIUVSIT
 . ;Try to link docmt to an existing visit, quit if successful
 . I $$LNKVST^TIUPXAP3(DA,.TIUVSIT) Q
 . ;Otherwise set TIU array and DFN to use TIU API which calls PCE
 . ;to resolve multiple visits or creates a new visit
 . D GETTIU^TIULD(.TIU,DA)
 . S DFN=$P($G(^TIU(8925,+DA,0)),U,2)
 . D QUE^TIUPXAP1
 ; post-signature action
 N TIUCONS S TIUCONS=-1
 D ISCNSLT^TIUCNSLT(.TIUCONS,+$G(^TIU(8925,DA,0)))
 I TIUCONS S DA=DAORIG
 S TIUSTIS=$P($G(^TIU(8925,DA,0)),U,5)
 S TIUTTL=+$G(^TIU(8925,+DA,0)),TIUPSIG=$$POSTSIGN^TIULC1(TIUTTL)
 I +$L(TIUPSIG),'+$G(CSREQ) X TIUPSIG
 I TIUCONS,TIUSTIS=7,TIUSTWAS<7,$$HASKIDS^TIUSRVLI(DA) D
 . N SEQUENCE,TIUKIDS,TIUINT,TIUK
 . S SEQUENCE="D",TIUKIDS="TIUKIDS",TIUINT=0,TIUK=0
 . D SETKIDS^TIUSRVLI(TIUKIDS,DA,TIUINT)
 . F  S TIUK=$O(TIUKIDS(TIUK)) Q:'TIUK  D
 . . I $P(TIUKIDS(TIUK),U,7)="completed" X TIUPSIG
 Q
THIRD ;
 N TYPE
 S TIUCSPRM=+$$CANDO^TIULP(DA,"COSIGNATURE")
 S TYPE=$G(^TIU(8925,+TIUDA,0))
 S TIUCSPM2=$$REQCOSIG^TIULP(+TYPE,+DA,DUZ)
 Q
