SDOEPRV ;ALB/MJK - ACRP Provider APIs For An Encounter ;8/12/96
 ;;5.3;Scheduling;**131**;Aug 13, 1993
 ;
PRV(SDOE,SDERR) ; -- SDOE ASSIGNED A PROVIDER
 ;   API ID: 63
 ;
 ;
 N SDOK
 S SDOK=0
 ;
 ; -- do validation checks
 IF '$$VALOE^SDOEOE(.SDOE,$G(SDERR)) G PRVQ
 IF $$OLD^SDOEUT(SDOE) S SDOK=$$OLDPRV(SDOE) G PRVQ
 ;
 S SDOK=$$PRV^PXAPIOE($$VIEN^SDOEUT(.SDOE),$G(SDERR))
PRVQ Q SDOK
 ;
 ;
GETPRV(SDOE,SDPRV,SDERR) ; -- SDOE GET PROVIDERS
 ;   API ID: 58
 ;
 ;
GETPRVG ;; -- goto entry point
 ; -- do validation checks
 IF '$$VALOE^SDOEOE(.SDOE,$G(SDERR)) G GETPRVQ
 IF $$OLD^SDOEUT(SDOE) D OLDPRVS(SDOE,.SDPRV) G GETPRVQ
 ;
 D GETPRV^PXAPIOE($$VIEN^SDOEUT(.SDOE),.SDPRV,$G(SDERR))
GETPRVQ Q
 ;
 ;
FINDPRV(SDOE,SDPRVID,SDERR) ; -- SDOE FIND PROVIDER
 ;   API ID: 69
 ;
 ;
 N SDPRVS,SDOK,I
 S SDPRVS="SDPRVS"
 ;
 ; -- do validation checks
 IF '$$VALPRV(.SDPRVID,$G(SDERR)) S SDOK=0 G FINDPRVQ
 ;
 D GETPRV(.SDOE,.SDPRVS,$G(SDERR))
 S (I,SDOK)=0
 F  S I=$O(SDPRVS(I)) Q:'I  S SDOK=(+SDPRVS(I)=SDPRVID) Q:SDOK
FINDPRVQ Q SDOK
 ;
 ;
VALPRV(SDPRVID,SDERR) ; -- validate provider input
 ;
 ; -- do checks
 IF SDPRVID,$D(^VA(200,SDPRVID,0)) Q 1
 ;
 ; -- build error msg
 N SDIN,SDOUT
 S SDIN("ID")=SDPRVID
 S SDOUT("ID")=SDPRVID
 D BLD^SDQVAL(4096800.003,.SDIN,.SDOUT,$G(SDERR))
 Q 0
 ;
 ;
OLDPRV(SDOE) ; -- at least one provider for OLD encounter?
 Q ($O(^SDD(409.44,"OE",+SDOE,0))>0)
 ;
OLDPRVS(SDOE,SDARY) ; -- get provider's for OLD encounter
 N SDIEN,SDCNT,Y,X
 S (SDIEN,SDCNT)=0
 F  S SDIEN=$O(^SDD(409.44,"OE",SDOE,SDIEN)) Q:'SDIEN  D
 . S SDCNT=SDCNT+1,X=$G(^SDD(409.44,SDIEN,0))
 . S $P(Y,U,1)=+X          ; -- person ien
 . S $P(Y,U,6)=$P(X,"^",3) ; -- person class
 . S @SDARY@(SDIEN)=Y
 S @SDARY=SDCNT
 Q
 ;
