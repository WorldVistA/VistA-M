DGOERNOT ;ALB/LDB - OERR NOTIFICATIONS ;24 JUN 91
 ;;5.3;Registration;**118,192**;Aug 13, 1993
EN ;Entry point from event driver
ADM D CHK G ADMQ:'DGCHK
 N Y S Y=$P(DGPMA,"^")
 I $P(DGPMA,"^",2)=1,'DGPMP S NIEN=18 D DATE S ORBPMSG="Admitted on "_DATE_$S($P(DGPMA,"^",6):"  "_$P($G(^DIC(42,+$P(DGPMA,"^",6),0)),U),1:"")_$S($P(DGPMA,"^",7):" RmBd: "_$P($G(^DG(405.4,+$P(DGPMA,"^",7),0)),U),1:"") D NOTE
DIS I $P(DGPMA,"^",2)=3,$P(DGPMA,"^",18)'=$P(DGPMP,"^",18),"^12^38^"[("^"_$P(DGPMA,"^",18)_"^") S NIEN=20 D DATE S ORBPMSG="Died while an inpatient on "_DATE D NOTE
ADMQ K DGCHK Q
 ;
DATE X ^DD("DD") S DATE=Y K Y
 Q
 ;
CHK S DGCHK=0 I $D(^DD(100,0,"VR")),^("VR")>2.09 S DGCHK=1
 Q
 ;
DEATH ;Entry point from cross-reference on DATE OF DEATH field in PATIENT file
 D CHK G DEATHQ:'DGCHK
 S DATE=+^DPT(DA,.35) I $D(^DGPM("APRD",DA,+^DPT(DA,.35))),$D(^DGPM(+$O(^(DATE,0)),0)),"^12^38^"[("^"_$P(^(0),U,18)_"^") K DATE Q
 N Y S NIEN=20,DFN=DA,Y=$P(^DPT(DA,.35),"^") D DATE S ORBPMSG="Died on "_DATE D NOTE
DEATHQ K DGCHK Q
 ;
UNSCHED ;Entry point from STATUS field in DISPOSITION multiple in PATIENT file
 D CHK G UNSCHEDQ:'DGCHK
 N Y Q:X']""!(X>1)
 I $S('$P(^DPT(DA(1),"DIS",DA,0),U,3)&'$D(DGOERNOT):1,'$D(DGOERNOT):0,(DGOERNOT>1):1,1:0) S DFN=DA(1),NIEN=19,Y=$P(^DPT(DA(1),"DIS",DA,0),"^") D DATE S ORBPMSG="Unscheduled visit on "_DATE D NOTE
UNSCHEDQ K DGCHK,DGOERNOT Q
 ;
NOTE S ORNOTE(NIEN)="",ORVP=DFN_";DPT(" D NOTE^ORX3
 K DATE,ORNOTE,ORBPMSG Q
