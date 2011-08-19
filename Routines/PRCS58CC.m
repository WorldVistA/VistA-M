PRCS58CC ;WISC/CLH,PLT-UTILITY CALLS ; 10/13/93  2:19 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Post payment and close out 1358 when close out flag set
 ;PRCSX=INT DAILY REF #^INTERNAL DATE/TIME^AMT OF PAYMENT^COMMENTS^COMPLETED FLAG^REFERENCE
 N X,X1,X2,DIC,PRCSDA,PRCSAMT,PRCSNADJ,AUDA,ABAL,BAL1,DA,DR,DIE,PRCSY,DLAYGO
 S Y=1 I '$D(PRCSX) S Y=0_U_$P($T(ER+0),";;",2) Q
 F I=1:1:3 I $P(PRCSX,U,I)="" S Y=0_U_$P($T(ER+1),";;",2)
 I 'Y K PRCSX Q
 S PRCSDA=+PRCSX,PRCSAMT=$P(PRCSX,U,3),PRCSY=$G(^PRC(424,PRCSDA,0)) I PRCSY="" S Y=0_U_$P($T(ER+2),";;",2) K PRCSX Q
 I '$D(^PRC(420,+$P(^PRC(424,PRCSDA,0),U),1,+$P(^PRC(442,+$P(PRCSY,U,2),0),U,3),1,DUZ,0)) S Y=0_U_$P($T(ER+4),";;",2) K PRCSX Q
 I $P(PRCSY,U,9)=1 S $P(PRCSX,U,5)=1
 I $P(PRCSY,U,3)'="AU" S Y=0_U_$P($T(ER+2),";;",2) K PRCSX Q
 I PRCSAMT<0,$P(PRCSY,U,5)-$P(PRCSY,U,12)>PRCSAMT S Y=0_U_$P($T(ER+6),";;",2) K PRCSX Q
 S Y=0 I $P(PRCSY,U,5)+0<PRCSAMT D  I Y S Y=0_U_$P($T(ER+Y),";;",2) K PRCSX Q
 . N DA,X,AMT,ABAL,DIFF,BAL,PRCADJ,BAL2,BAL1,AAMT,AUDA,AUDA0
 . S BAL=$$BAL^PRCH58($P(PRCSY,U,2)),ABAL=$P(PRCSY,U,5),DIFF=PRCSAMT-ABAL
 . I +BAL-$P(BAL,U,3)-DIFF<0 S Y=5 Q
 . S PRCADJ=0,AAMT=DIFF,AUDA=PRCSDA,AUDA0=PRCSY D ADJ^PRCEDRE0 I PRCADJ S Y=3 Q
 . S DA=AUDA,BAL2=$P($G(^PRC(424,DA,0)),U,12)+DIFF,BAL1=+DIFF,ABAL=ABAL+DIFF,DR=".05////^S X=ABAL;.12////^S X=BAL2",DIE="^PRC(424," D ^DIE
 . S PRCSY=^PRC(424,PRCSDA,0)
 . D BALUP^PRCH58($P(PRCSY,U,2),BAL1) S Y=0
 . QUIT
 S Y=1
 L +^PRC(424,PRCSDA):5 Q:$T=0  S X=$P(^PRC(424,PRCSDA,0),U,11)+1,$P(^(0),U,11)=X L -^PRC(424,PRCSDA)
 S X=$P(PRCSY,U)_"-"_X
 S DIC="^PRC(424.1,",DIC(0)="LX",DLAYGO=424.1 D FILE^DICN I Y<0 S Y=0_U_$P($T(ER+7),";;",2) K PRCSX Q
 S DA=+Y,DIE="^PRC(424.1,",DR=".02////^S X=PRCSDA;.03///^S X=-PRCSAMT;.04///^S X=""NOW"";.05////^S X=DUZ;.011///^S X=""P"""
 S:$P(PRCSX,U,4)]"" DR=DR_";1.1///^S X=$P(PRCSX,U,4);.08///^S X=$P(PRCSX,U,6)" S:$P(PRCSX,U,5)]"" DR=DR_";.07///^S X=$P(PRCSX,U,5)" D ^DIE
 S $P(^PRC(424,PRCSDA,0),U,5)=$P($G(^PRC(424,PRCSDA,0)),U,5)-PRCSAMT
 ;final/complete payment and mark authorization as COMPLETE
 I $P(PRCSX,U,5)]"" D
  .N AUDA,AAMT,BAL1,AUDA0 S AUDA=PRCSDA,AUDA0=PRCSY
  .S X=$G(^PRC(424,AUDA,0)),AAMT=-$P(X,U,5),BAL1=$P(X,U,12)+AAMT,PRCADJ=0 D ADJ^PRCEDRE0 Q:PRCADJ
  .S DA=AUDA,DR=".05////^S X=0;.12////^S X=BAL1;.09////^S X=1",DIE="^PRC(424," D ^DIE
  .D BALUP^PRCH58($P(PRCSY,U,2),AAMT)
  .Q
 S Y=1 K PRCSX Q
 ;
ER ;;No data string passed
 ;;Data element in string missing
 ;;Invalid Transaction or Transaction previously closed
 ;;Authorization amount can't be adjusted.
 ;;Unauthorized control point user
 ;;Insufficent obligation funds to adjust authorization to post bill
 ;;Credit bill amount will exceed total bill amount
 ;;Unable to create Authorization Line Item
 Q
