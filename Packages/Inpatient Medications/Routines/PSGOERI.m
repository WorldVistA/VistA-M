PSGOERI ;BIR/CML3 - REINSTATE A DC'D ORDER ;06 Aug 98 / 2:17 PM
 ;;5.0;INPATIENT MEDICATIONS ;**17,27,31,88,110,137,181,320**;16 DEC 97;Build 7
 ;
 ; Reference to ^PS(55 is supported by DBIA# 2191
 ;
ENRI ;
 S PSGALR=80,PSGFD=$P($G(^PS(55,PSGP,5,+PSGORD,2)),"^",3) I 'PSGFD W:'$D(PSJUNDC) $C(7),$C(7),!?3,"I CANNOT REINSTATE THIS ORDER!  THE OLD STOP DATE IS MISSING!" Q
 I PSGFD'>PSGDT Q:$D(PSJUNDC)  W !!,"This order has technically expired as of ",$$ENDTC^PSGMI,"." F  S %=1 W !!,"Do you want to RENEW this order" D YN^DICN Q:%  D
 .W !!?2,"This order has expired, and cannot be renewed.  But the order can be",!,"reinstated.  Answer 'YES' to reinstate the order now.  Answer 'NO' (or '^') if",!,"you do not want to reinstate this order now."
 I PSGFD'>PSGDT G:%'=1 DONE S PSGRRF=0 D NEW^PSGOER,DONE^PSGOER G DONE
 W:'$D(PSJUNDC) !!,"...reinstating this order..."
 ;Create a list of recipients beyond normal mail group
 D:$D(PSJUNDC)  ;  do only if from movement deletion 
 .I $P(^PS(55,PSGP,5,+PSGORD,4),U,1)'="" S PSJSENTO($J,$P(^PS(55,PSGP,5,+PSGORD,4),U,1))="" ; Record verifying Nurse
 .I $P(^PS(55,PSGP,5,+PSGORD,4),U,3)'="" S PSJSENTO($J,$P(^PS(55,PSGP,5,+PSGORD,4),U,3))="" ; Record verifying Pharmacist
 .I $P(^PS(55,PSGP,5,+PSGORD,4),U,5)'="" S PSJSENTO($J,$P(^PS(55,PSGP,5,+PSGORD,4),U,5))="" ; Record Physician
 .I $P(^PS(55,PSGP,5,+PSGORD,0),U,2)'="" S PSJSENTO($J,$P(^PS(55,PSGP,5,+PSGORD,0),U,2))="" ; Record Provider
 ;If a duplicate order exists do not reinstate the older one.  Record in ^TMP for later advice in auto e-mail (PSJADT2)
 D NOW^%DTC
 I $D(PSJUNDC) I $$CHECKDUP^PSGOERI(PSGP,+PSGORD) S ^TMP("PSJNOTUNDC",$J,PSGP,PSGORD_"U")="" G DONE
 ;S DR=$S(+$P($G(^PS(55,PSGP,5,+PSGORD,4)),U,18)=1:"28///H",+$P($G(^(4)),U,26)=1:"28///H",1:"28////A")_";34////"_PSGFD_";136////@"
 S DR=$S(+$P($G(^PS(55,PSGP,5,+PSGORD,4)),U,26)=1:"28///H;136////HP",+$P($G(^(4)),U,18)=1:"28///H;136////@",1:"28////A;136////@")_";34////"_PSGFD
 S Z=$G(^PS(55,PSGP,5,+PSGORD,4)),$P(Z,U,11)="",$P(Z,"^",15,17)="^^" S:'$D(PSJUNDC) $P(Z,"^",PSJSYSU,PSJSYSU+1)=DUZ_"^"_PSGDT S ^(4)=Z W "."
 N CHKIT S CHKIT=$G(^PS(55,PSGP,5,+PSGORD,0)) I $P(CHKIT,U,26)["P",($P(CHKIT,U,27)="R") S DR=DR_";105///@;107///@"
 S DIE="^PS(55,"_PSGP_",5,",DA(1)=PSGP,DA=+PSGORD,PSGAL("C")=$S($D(PSJUNDC):40,1:(PSJSYSU*10))+18500 D ^PSGAL5 W "." D ^DIE W "."
 S X=$P(^PS(55,PSGP,5,+PSGORD,0),"^",20),$P(^(0),"^",20)="" K:X ^PS(55,"AUDDD",X,PSGP,+PSGORD) ;Removed cross reference after reinstate order.
 ;S X=$O(^ORD(101,"B","PS EVSEND OR",0))_";ORD(101,",PSOC="SC",PSJORDER=$$ORDER^PSJHLU(PSGORD) D EN1^XQOR:X K X
 S ^TMP("PSJUNDC",$J,PSGP,PSGORD_"U")=""
 D EN1^PSJHL2(PSGP,"SC",+PSGORD_"U",$S($D(PSJUNDC):"AUTO REINSTATED",1:"REINSTATED"))
 Q:$S('$D(PSJUNDC):0,PSGALO=18540:1,1:'$P($G(PSJSYSW0),U,15))
 S PSGTOL=$S($D(PSJUNDC):3,1:2),PSGUOW=$S($D(PSJUNDC):PSJUOW,1:DUZ)
 I $D(^PS(53.41,1,1,+PSGUOW,1,PSGP,1,1,1,+PSGORD)) K DIK,DA S DIK="^PS(53.41,"_1_",1,"_+PSGUOW_",1,"_PSGP_",1,1,1,",DA=+PSGORD,DA(1)=1,DA(2)=PSGP,DA(3)=+PSGUOW,DA(4)=1 D ^DIK
 E  D
 .S X=0 S:$D(PSJUNDC) X=$O(^PS(59.6,"B",+PSGUOW,0)),X=$P($G(^PS(59.6,+X,0)),U,15)
 .I $S(X:1,'PSJSYSL:0,PSJSYSL<3:1,1:$P(^PS(55,PSGP,5,DA,4),"^",+PSJSYSU'=3+9)) D
 ..K DA S DA=+PSGORD,DA(1)=PSGP,$P(^PS(55,PSGP,5,DA,7),"^",1,2)=PSGDT_"^RE",PSGTOO=1,PSGUOW=$S($D(PSJUNDC):+PSJUOW,1:DUZ) D ENL^PSGVDS W "."
 W:'$D(PSJUNDC) ".DONE!" Q
 ;
DONE ;
 K DA,DIE,DR,PSGAL,PSGALR,PSGFD,PSGID,PSGOD,RF,Z
 Q
CHECKDUP(PSGP,PSGORD) ;
 N Z,ZZ,PSJCOM
 S FOUND=0
 S PSGX=+$G(^PS(55,PSGP,5,+PSGORD,.2)),PSJCOM=+$P($G(^(.2)),"^",8)
 I PSGX'="" D
 .F Z=%:0 S Z=$O(^PS(55,+PSGP,5,"AUS",Z)) Q:'Z!FOUND  D
 ..F ZZ=0:0 S ZZ=$O(^PS(55,+PSGP,5,"AUS",Z,ZZ)) Q:'ZZ!FOUND  D
 ...I PSJCOM>0 Q:+$P($G(^PS(55,+PSGP,5,ZZ,.2)),"^",8)=PSJCOM
 ...I +$G(^PS(55,+PSGP,5,ZZ,.2))=PSGX D
 ....S FOUND=1
 Q FOUND
