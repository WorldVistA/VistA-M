RMPR29LC ;HIN/RVD-LAB ISSUE FROM STOCK ;5/27/1998
 ;;3.0;PROSTHETICS;**33,37,42**;Feb 09, 1996
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K RMNEW,RMCLOF,RMEDIT,RMFLG D DIV4^RMPRSIT G:$D(X) EXIT
STA S RMUSSN=$P($G(^VA(200,DUZ,1)),U,9) I $D(RMUSSN),(RMUSSN'="") S RMPIEN=$O(^PRSPC("SSN",RMUSSN,0))
 I '$D(RMPIEN) S RMQSAL="*** User is not a valid employee...Please contact Personnel..Transaction not closed." W !!,RMQSAL G EXIT
 S:RMPIEN RMANSA=$P(^PRSPC(RMPIEN,0),U,29)
 I '$D(RMANSA) S RMQSAL="*** Employee is not in PAID Employee file...Please check with Personnel..Transaction not closed." W !!,RMQSAL G EXIT
 I $D(RMANSA),('RMANSA) S RMQSAL="*** Employees' SALARY is missing...Please check with Personnel..Transaction not closed." W !!,RMQSAL G EXIT
 S:RMANSA RMSAL=(RMANSA/2080)*1.23
 ;
SEL G:$G(RSTOCK) COM
 S DIC="^RMPR(664.1,",DIC(0)="AEMQZ",DIC("S")="I $P(^RMPR(664.1,+Y,0),U,17)=""S""&($P(^(0),U,3)=RMPR(""STA""))"
 S DIC("W")="D EN3^RMPRD1"
 D ^DIC G:$D(DTOUT)!$D(DTOUT)!(Y'>0) EXIT
 L +^RMPR(664.1,+Y):1
 I '$T W $C(7),!!,?5,"Someone is already editing this entry" G EXIT
 S RMPRDA=+Y,PAC=1
 ;
COM ;COMPLETE 2529-3
 Q:'$G(RMPRDA)  K RMEDIT D LIS^RMPR29LU
 W !,RMPR("L") K DIR S DIR("A")="Select Processing Action: "
 S DIR(0)="SAO^1:EDIT 2529-3 ITEM;2:VIEW PATIENT 2319  ;3:PRINT LAB ISSUE FORM;4:RE-DISPLAY      ;5:CANCEL 2529-3",DIR("?")="^D HELP^RMPR29W W !,$C(7),?5,""Enter a number 1-5""" D HELP^RMPR29W
 ;D ^DIR I X="" S PAGE=PAGE+1 D HD^RMPR29W D:$D(^UTILITY($J,"W"))!$O(^UTILITY("DIQ1",$J,664.16,+RI,7,0)) EXT^RMPR29D D ITD^RMPR29D
 D ^DIR G:$D(DUOUT)!$D(DTOUT) EXIT I X="" G POST
 I $D(Y),(Y=1) S RMCLOF=1 D TYPE^RMPR29LI G:$D(RMEXIT)!('$D(RMPRDA)) EXIT G COM
 I $D(Y),(Y=2) S RFLG=1 D ^RMPRPAT G COM
 I $D(Y),(Y=4) G COM
 I $D(Y),(Y=5) D DEL^RMPR29LU G:$D(RDEL) SEL G COM
 I $D(Y),(Y=3) D PRT^RMPR29R G COM
POST K DIR S DIR(0)="Y",DIR("A")="Do you want to Complete Issuance From Stock",DIR("B")="NO" D ^DIR I +Y=0 W !,"Transaction not completed !!",! Q:$G(RSTOCK)  G SEL
 ;create entry in 664.3
 S DIC(0)="L",X=DT K RMRPOST
 S RMPRWO=$P(^RMPR(664.1,RMPRDA,0),U,13)
 I 'RMPRWO W !,"No Work Order associated with this request...Unable to complete this order...",! G SEL
 S RMWODA=$O(^RMPR(664.2,"B",RMPRWO,0))
 I 'RMWODA W !,"No Work Order associated with this request...Unable to complete this order...",! G SEL
 S RMDAT7=DT_"^"_DT_"^"
 S ^RMPR(664.1,RMPRDA,7)=RMDAT7
 S $P(^RMPR(664.1,RMPRDA,0),U,16)=DUZ,RITC=$P(^RMPR(664.1,RMPRDA,2,0),U,4)
 S RMPRGIP=$P(^RMPR(669.9,RMPRSITE,0),U,3)
 F RI=0:0 S RI=$O(^RMPR(664.1,RMPRDA,2,RI)) Q:RI'>0  I $D(^(RI,0)) D
 .S RM0=$G(^RMPR(664.1,RMPRDA,2,RI,0))
 .S RM3=$G(^RMPR(664.1,RMPRDA,2,RI,3))
 .S RM660=$P(RM0,U,5),RMWO=$P(RM0,U,6),RMITEM=$P(RM0,U,1),RMQTY=$P(RM0,U,2)
 .I '$G(RM660) W !,"*** Not posted to 2319, Please edit and repost transaction..",! S RMRPOST=1 H 3 Q
 .S RMSER=$P(RM0,U,12),RMIT=$P(RM3,U,3),RMSO=$P(RM3,U,1),RMGIP=$P(RM0,U,13)
 .S RMUNI=$P(RM0,U,3),RMCOST=$P(RM0,U,4),RMTT=$P(RM0,U,7)
 .S RMLOC=$P(RM3,U,4),(RMHCPC,RMDAHC)=$P($G(^RMPR(664.1,RMPRDA,2,RI,2)),U,1)
 .I '$G(RMDAHC) W !,"*** Transaction has no HCPCS, Please edit and repost transaction..",! S RMRPOST=1 H 3 Q
 .S RMTIME=$P(^RMPR(661.1,RMDAHC,0),U,10)/60,RMLACO=RMSAL*RMTIME,RMLACO=$J(RMLACO,0,2)
 .I $G(RMPRGIP)&($G(RMGIP)) D GIP Q:$D(RMEXIT)
 .I (RMIT["-")&($G(RMLOC)) D RM6612 ;create entry in 661.2
 .S RMTOCO=$P(RM0,U,11)
 .S $P(^RMPR(660,RM660,0),U,12)=DT
 .S $P(^RMPR(660,RM660,3),U,1)="Veteran"
 .S $P(^RMPR(660,RM660,0),U,27)=DUZ
 .S $P(^RMPR(660,RM660,0),U,13)=15
 .S $P(^RMPR(660,RM660,"LB"),U,6)=RMTIME
 .S $P(^RMPR(660,RM660,"LB"),U,7)=$J(RMLACO,0,2)
 .S $P(^RMPR(660,RM660,"LB"),U,8)=$J(RMTOCO,0,2)
 .S RMTOTC=RMLACO+RMTOCO
 .S $P(^RMPR(660,RM660,"LB"),U,9)=$J(RMTOTC,0,2)
 .S $P(^RMPR(660,RM660,"LB"),U,11)=DT
 .S DIK="^RMPR(660,",DA=RM660 D IX1^DIK
 .S DIC="^RMPR(664.3,"
 .K DD,DO,DA,DIK D FILE^DICN
 .S ^RMPR(664.3,+Y,0)=DT_"^"_RM660_"^"_RMPR("STA")
 .S DA=+Y,DIK="^RMPR(664.3," D IX1^DIK K DA,DD,DO
 .S ^RMPR(664.3,+Y,1,0)="^664.33PA^1^1",DA(1)=+Y
 .S DIC="^RMPR(664.3,"_DA(1)_",1,",DIC(0)="L",X=DUZ
 .S RMTIME=RMTIME*($G(RITC))
 .S ^RMPR(664.3,DA(1),1,1,0)=DUZ_"^"_RMTIME_"^"_$J(RMSAL,0,2)_"^"
 .S DA=1,DIK="^RMPR(664.3,"_DA(1)_",1," D IX1^DIK
 .S DIE="^RMPR(664.2,",DA=RMWODA,DR="8////^S X=$G(DT);9////^S X=$G(DUZ)" D ^DIE
 G:$G(RMRPOST) COM
 S $P(^RMPR(664.2,RMWODA,0),U,10)=DT,DA=RMPRDA G:$D(RMEXIT) EXIT
 K DA,Y,DIC,X
 S DA=RMPRDA,DR="24////1;33////^S X=DT;20////^S X=DT",DIE="^RMPR(664.1," D ^DIE I $D(DTOUT)!($D(Y)) G EXIT
 S:'$P(^RMPR(664.1,RMPRDA,0),U,25) $P(^RMPR(664.1,RMPRDA,0),U,25)=DUZ S $P(^RMPR(664.1,RMPRDA,0),U,26)=DT
 W !!,?5,$C(7),"Request Completed and Posted!!!" S DIE="^RMPR(664.1,",DR="16///^S X=""C""",DA=RMPRDA D ^DIE
 S DIK=DIE D IX1^DIK K DIK,DA,DR,DIE
 Q:$D(RMCOMP)!$G(RSTOCK)  G SEL
 ;END
 ;
RM6612 S RMLAB=1
 S RMHCDA=$O(^RMPR(661.3,RMLOC,1,"B",RMDAHC,0))
 I 'RMHCDA S RMEXIT=1 Q
 S RMITDA=$O(^RMPR(661.3,RMLOC,1,RMHCDA,1,"B",RMIT,0))
 I 'RMITDA S RMEXIT=1 Q
 D ADD^RMPR5NU1
 K RMLAB
 Q
 ;
GIP S PRCP("QTY")=RMQTY*-1,PRCP("TYP")="R",PRCP("I")=RMGIP,PRCP("ITEM")=$P($G(^RMPR(661,RMITEM,0)),U,1) D ^PRCPUSA
 I $D(PRCP("ITEM")) W !!,"Error encountered while posting to GIP. Inventory Issue did not post, Patient 10-2319 not updated!! Please check with your Application Coordinator." H 1 S RMEXIT=1
 Q
 ;
EXIT ;EXIT FOR STOCK ISSUES
 L:+$G(RMPRDA) -^RMPR(664.1,+RMPRDA,0) K ^UTILITY("DIQ1",$J)
 ;W !! S DIR(0)="Y",DIR("B")="YES",DIR("A")="Would you like to Complete and Post another 2529-3" D ^DIR G:+Y=1 SEL
 N RMPR,RMPRSITE D KILL^XUSCLEAN Q
