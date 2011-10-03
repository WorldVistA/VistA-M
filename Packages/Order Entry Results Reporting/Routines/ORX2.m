ORX2 ; slc/dcm - OE/RR Patient lock entry points ;4/21/04  09:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**16,48,158,168,183,190,195,292**;Dec 17, 1997;Build 6
PT1 ;;Entry point to unlock patient when done adding orders - NO LONGER USED
 ;;Required variable ORVP.
 Q:'$D(ORVP)  Q:'$L(ORVP)  Q:ORVP'["DPT("
 D UNLOCK(+ORVP) K ORPTLK,ORELK
 Q
LK ;;Entry point for locking patient when updating orders
 ;;Entry: X=VP to Patient "DFN;DPT("  Exit: Y=1 if lock succeeds
 Q:'$D(X)  Q:'$L(X)  Q:X'["DPT("  Q:'$D(@("^"_$P(X,";",2)_+X_",0)"))
 S Y=$$LOCK(+X) Q:Y
 W !!,$C(7),$P(Y,U,2) D READ
 S Y=0 K X
 Q
ULK ;;Entry point to unlock patient
 ;;Required variable X=VP to patient.
 Q:'$D(X)  Q:'$L(X)  Q:X'["DPT("  Q:'$D(@("^"_$P(X,";",2)_+X_",0)"))
 D UNLOCK(+X)
 Q
 ;
LOCK(DFN) ; -- Lock patient chart (silent)
 ; Returns 1 if successful, or 0^Message if could not get lock
 ;
 Q:'$G(DFN) "0^Invalid patient" N Y,ORLK,NOW,NOW1
 S ORLK=$G(^XTMP("ORPTLK-"_DFN,1)) Q:ORLK=(DUZ_U_$J) 1 ;locked
 L +^XTMP("ORPTLK-"_DFN):$S($G(DILOCKTM)>0:DILOCKTM,1:5) I '$T S Y="0^"_$S(+ORLK:$P($G(^VA(200,+ORLK,0)),U),1:"Another person")_" is editing orders for this patient." Q Y
 S NOW=$$NOW^XLFDT,NOW1=$$FMADD^XLFDT(NOW,1)
 S ^XTMP("ORPTLK-"_DFN,0)=NOW1_U_NOW_"^CPRS Chart Lock",^(1)=DUZ_U_$J
 Q 1
 ;
UNLOCK(DFN) ; -- Unlock patient chart (silent)
 L -^XTMP("ORPTLK-"_DFN)
 I $G(^XTMP("ORPTLK-"_DFN,1))=(DUZ_U_$J) K ^XTMP("ORPTLK-"_DFN)
 Q
 ;
INC(IFN) ;Increment zero node on file 100.2
 N X,X3,X4
 Q:'$G(IFN) 1 Q:$D(^OR(100.2,IFN)) 1
 L +^OR(100.2,0):5 I '$T Q 0
 S:'$D(^OR(100.2,0)) ^(0)="OE/RR PATIENT^100.2P" S X=^(0)
 S X4=+$P(X,U,4)+1,X3=$S(IFN>$P(X,U,3):IFN,1:$P(X,U,3))
 S $P(^OR(100.2,0),U,3,4)=X3_U_X4
 L -^OR(100.2,0)
 Q 1
 ;
LOCK1(ORDER) ; -- Lock ORDER in file #100
 ; Returns 1 if successful or 0^Message if could not get lock
 ;
 N X,Y,NOW,NOW1 I '$G(ORDER) Q "0^Invalid order number"
 ;DBIA #4001 Private DBIA w CMOP
 I $D(^XTMP("ORLK-"_ORDER,0)),(^(0)["CPRS/CMOP") Q "0^CMOP Transmission"
 L +^OR(100,+ORDER):$S($G(DILOCKTM)>0:DILOCKTM,1:5) I '$T S X=+$G(^XTMP("ORLK-"_+ORDER,1)),Y="0^"_$S(X:$P($G(^VA(200,X,0)),U),1:"Another person")_" is working on this order." Q Y
 I $P($G(^OR(100,+ORDER,0)),U,12)="I" S Y=+$P($G(^(3)),U,6) I Y,$P($G(^OR(100,Y,3)),U,3)=11 D  Q Y
 . S X=$S($P(^OR(100,Y,3),U,11)=2:"renewal",1:"edit")
 . S Y="0^An unreleased "_X_" exists for this order." L -^OR(100,+ORDER)
 S NOW=$$NOW^XLFDT,NOW1=$$FMADD^XLFDT(NOW,1)
 S ^XTMP("ORLK-"_+ORDER,0)=NOW1_U_NOW_"^CPRS Order Lock",^(1)=DUZ_U_$J
 Q 1
 ;
UNLK1(ORDER) ; -- Unlock ORDER in file #100
 ;DBIA #4001 CMOP
 S ORDER=+ORDER Q:'ORDER
 I $D(^XTMP("ORLK-"_ORDER,0)),(^(0)["CPRS/CMOP") D  Q
 . I $J'=$P($G(^XTMP("ORLK-"_ORDER,1)),U,2) Q
 . L -^OR(100,ORDER) K ^XTMP("ORLK-"_ORDER)
 L +^OR(100,ORDER):$S($G(DILOCKTM)>0:DILOCKTM,1:5)
 I '$T Q
 E  L -^OR(100,ORDER)
 L -^OR(100,ORDER) K ^XTMP("ORLK-"_ORDER)
 Q
 ;
READ ; -- instead of READ^ORUTL
 N X,Y,DIR
 S DIR(0)="EA",DIR("A")="     Press return to continue  "
 D ^DIR
 Q
 ;
LCKEVT(EVT) ;Function atttempts to lock event, added w/patch 194
 N J
 F J=1:1:5 L +^ORE(100.2,EVT,0):1 Q:$T  H 1
 Q $T
 ;
UNLEVT(EVT) ;Unlocks global, added w/patch 195
 L -^ORE(100.2,EVT,0)
 Q
