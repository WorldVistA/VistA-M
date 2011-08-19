RMPR4E21 ;PHX/HNC - CLOSE OUT PURCHASE CARD TRANSACTION ;3/1/1996
 ;;3.0;PROSTHETICS;**3,12,26,28,30,34,41,45,62,111,78,114,118,133,137**;Feb 09, 1996;Build 5
 ;TH  Patch #78 - 08/04/03 - Add shipment date. Call routine ^RMPR4E23
 ;RVD patch #62 - PCE processing and link to suspense
 ;
 ;I '$D(^PRC(440.5,"H",DUZ)) W !!,"You are not an authorized Purchase Card User, CONTACT FISCAL!" Q
START I '$D(RMPR) D DIV4^RMPRSIT Q:$D(X)
CL K ^TMP($J,"RMPRPCE")
 K DIC S DIC="664",DIC(0)="AEQM",DIC("W")="D EN2^RMPR4D1",DIC("A")="Select PATIENT: "
 S DIC("S")="I $D(^(4)) I ('$P(^(0),U,8)&'$P(^(0),U,5)),($P(^(0),U,14)=RMPR(""STA""))"
 W !!,"You may also make a selection by Purchase Card Transaction"
 W !,"(Example, PO number), or Bank Authorization Number (6 digit number).",!
 D ^DIC S (DA,RMPRA)=+Y I Y=-1 G EXIT
 K DIC G:$P(^RMPR(664,RMPRA,0),U,8) M4 G:$P(^(0),U,5) M6
 L +^RMPR(664,RMPRA,0):1 I $T=0 W !,?5,$C(7),"Someone else is Editing this entry!" G EXIT
 ;get amis grouper number RGRP1
 S RGRP=0,RGRP1=""
 S RGRP=$O(^RMPR(664,RMPRA,1,RGRP)) G:'RGRP BRK S RGRPP=$P($G(^RMPR(664,RMPRA,1,RGRP,0)),U,13) I 'RGRPP W !!,$C(7),"ERROR** This transaction was not posted to 2319, please contact your IRM..",!! S DIR(0)="E" D ^DIR G EXIT
 S RGRP1=$P($G(^RMPR(660,RGRPP,"AMS")),U,1)
 S (RMPRDFN,DFN)=$P(^RMPR(664,RMPRA,0),U,2),RMPRWO=$P(^(0),U,15),RMPRDA=$P(^(0),U,17)
 D DEM^VADPT S RMPRSSNE=VA("PID"),RMPRSSN=+VADM(2),RMPRNAM=VADM(1) K VADM
 ;set original value before close-out
 K ^TMP("RM",$J),RM(RMPRA),RHCED S RMPRF=2
 K %X,%Y S %X="^RMPR(664,RMPRA,",%Y="^TMP("_"""RM"""_",$J,RMPRA," D %XY^%RCR
 S RM(RMPRA,0)=$G(^RMPR(664,RMPRA,0)),RM(RMPRA,2)=$G(^(2)),RM(RMPRA,4)=$G(^(4))
 S RMPER=$P(RM(RMPRA,2),U,6),RMBAN=$P(RM(RMPRA,4),U,2),RMSHI=$P(RM(RMPRA,0),U,11),RMSHIEN=$P(RM(RMPRA,0),U,12)
 S:RMSHI=""!(RMSHI+0=0) RMSHI=0
 ;added by #62
 ;collect all items and previous linkage to suspense.
 I $G(RMSHIEN) S:'$D(^RMPR(660,RMSHIEN,10)) RM60LINK(RMSHIEN)=""
 D COL^RMPRPCEL
 ;
L ;**** ask for final posting *****************************************
 D ^RMPR4LI N DIR K RFLG
 S DIR("A")="Ready to Reconcile and Close-Out Transaction",DIR("B")="NO",DIR(0)="Y"
 S DIR("?")="You may now Close-out and Post this Transaction. Please answer Yes or No."
 D ^DIR I Y["^"!($D(DTOUT)) W !,"Transaction NOT Closed-Out!" S:$D(^TMP("RM",$J)) RFLG=1 G:$D(RFLG) POST1 G KTMP
 I Y=1 G POST1
 ;***add/edit transaction**********************************************
L1 K DIR S DIR(0)="FO",DIR("A")="Select ITEM"
 S DIR("?")="^S RFL=1 D ZDSP^RMPR421A"
 D ^DIR G:(Y="^")!(Y="") DS G:$D(DTOUT) L
 G:$D(DIRUT)&($D(^RMPR(664,RMPRA,1))) L
 S DIC=661,DIC(0)="ENMZ" D ^DIC I +Y'>0 W !,"** No Item selected.." G DS
 G:$D(DTOUT)!$D(DUOUT) L
 D PROC G L1
 ;***process items*******************************************************
PROC N NEW S HY=+Y I $D(^RMPR(664,RMPRA,1,"B",+Y)) S DA=$O(^RMPR(664,RMPRA,1,"B",+Y,0)) G CHK
FILE S Y=HY,NUM=$P(^RMPR(664,RMPRA,1,0),U,4)+1,$P(^(0),U,4)=NUM,$P(^(0),U,3)=$P(^(0),U,3)+1,^RMPR(664,RMPRA,1,NUM,0)=+Y,DA=NUM,^RMPR(664,RMPRA,1,"B",+Y,NUM)="" S NEW=1
ENT K DR,DQ S DA(1)=RMPRA,DIE="^RMPR(664,"_RMPRA_",1,"
 ;S DR=$S($D(NEW):"",1:".01;")
 I '$D(NEW),($P(^RMPR(664,RMPRA,1,DA,0),U,7)="") S $P(^(0),U,7)=$P(^(0),U,3)
 S:'$D(NEW) RMDACA=$P(^RMPR(664,RMPRA,1,DA,0),U,13)
 S R4DA=DA
 S DR="8;S RMTYPE=$P(^RMPR(664,RMPRA,1,R4DA,0),U,9);9;.01;"
 S DR=DR_"16R;1;14;17;15;3R;"
 I $D(NEW) S DR=DR_"2R~UNIT COST;"
 E  S DR=DR_"6R;",RHCNEW=$P($G(^RMPR(664,RMPRA,1,R4DA,0)),U,16)
 S DR=DR_"4R~UNIT OF ISSUE;7;11////C" D ^DIE
 I $D(NEW) S:$G(DA) ^TMP("RM",$J,"N",R4DA)=$G(^RMPR(664,RMPRA,1,R4DA,0))
 E  S:'$G(DA)&(RMDACA) ^TMP("RM",$J,"C",RMDACA)="" I $G(DA) S ^TMP("RM",$J,"E",DA)=$G(^RMPR(664,RMPRA,1,DA,0)),RHCOLD=$P(^RMPR(664,RMPRA,1,DA,0),U,16),RD660=$P(^(0),U,13) I RHCNEW'=RHCOLD D
 .S RHCED=1
 .I $D(RD660)&(RD660) S DIE="^RMPR(660,",DA=RD660,DR="4.5///^S X=$G(RHCOLD)" D ^DIE
 I $D(R4DA),$P($G(^RMPR(664,RMPRA,1,R4DA,0)),U,10)=4 S DA=R4DA,DR=10 D ^DIE
 ;check for Type of Transaction and update the cpt modifier.
 I $D(R4DA),$D(RMTYPE) S RDATA=RMTYPE_"^"_RMPRA_"^"_R4DA D CHKCPT^RMPR4UTL(RDATA)
 Q:$D(DTOUT)  K NUM,R4DA,DA,Y,DR,RD660,RHCOLD,RHCNEW,DIE,RDATA,RMTYPE Q
CHK ;ADD DUPLICATE LINE ITEM
 K DIR,Y S DIR(0)="S^Y:YES;N:NO",DIR("A")="DO YOU WANT TO ADD A DUPLICATE ITEM?",DIR("B")="NO" D ^DIR Q:$D(DIRUT)!($D(DTOUT))  I (X["Y")!(X["y") G FILE
 S RD=0 F RDA=0:0 S RDA=$O(^RMPR(664,RMPRA,1,"B",HY,RDA)) Q:RDA'>0  S RD=RD+1
LKP I RD>1 D  Q:$D(DIRUT)!$D(DTOUT)  I '$D(RD(+Y)) W $C(7) G LKP
 .F RDA=0:0 S RDA=$O(^RMPR(664,RMPRA,1,"B",HY,RDA)) Q:RDA'>0  S RD(RDA)=^RMPR(664,RMPRA,1,RDA,0) W !?5,RDA,?10,$P(^PRC(441,$P(^RMPR(661,$P(RD(RDA),U),0),U),0),U,2),"  $",$S($P(RD(RDA),U,7)'="":$P(RD(RDA),U,7),1:$P(RD(RDA),U,3))
 .K DIR,Y S DIR(0)="N" D ^DIR I +Y S DA=+Y
 G ENT
 ;
DS ;**** update shipping cost, % discount and bank authorization ********
 S (RMPERF,RMBANF,RMSHIF)=0
 I $P(^RMPR(664,RMPRA,0),U,11)="",$P(^(0),U,10) S $P(^(0),U,11)=$P(RM(RMPRA,0),U,10)
 S DA=RMPRA,DIE="^RMPR(664,",DR="12;17;26" D ^DIE
 S:+$P(^RMPR(664,RMPRA,0),U,11)=0 $P(^(0),U,11)=0
 I RMPER'=$P(^RMPR(664,RMPRA,2),U,6) S RMPERF=1
 I RMBAN'=$P(^RMPR(664,RMPRA,4),U,2) S RMBANF=1
 I RMSHI'=$P(^RMPR(664,RMPRA,0),U,11)!($P(^(0),U,11)=0&$P(^(0),U,12)) S RMSHIF=1
CHK1 ;delete imcomplete items
 S DIK="^RMPR(664,"_RMPRA_",1,",DA(1)=RMPRA F I=0:0 S I=$O(^RMPR(664,RMPRA,1,I)) Q:I'>0  S RMPRI=$G(^(I,0)) I $P(RMPRI,U,3)=""!($P(RMPRI,U,4)="")!($P(RMPRI,U,5)="") S DA=I D ^DIK
 G L ;go back to select ITEM
 ;*************************************************************
POST1 ;SET AMOUNT FOR IFCAP AMENDMENT.
 S (R1,RMPR("AMT"),AMT,DCT,RMPRTO)=0
 I $D(^RMPR(664,RMPRA,2)),$P(^(2),U,6) S DCT=$P(^(2),U,6),DCT=DCT/100
 F RI=0:0 S RI=$O(^RMPR(664,RMPRA,1,RI)) Q:RI'>0  D
 .N RMACT
 .S RMX=$G(^RMPR(664,RMPRA,1,RI,0)),RMACT=$P(RMX,U,7),RMQTY=$P(RMX,U,4)
 .I DCT S RMTOT=$S(RMACT=0!(RMACT>0):RMACT-$J(RMACT*DCT,0,2)*RMQTY,1:$P(RMX,U,3)-$J($P(RMX,U,3)*DCT,0,2)*RMQTY)
 .I 'DCT S RMTOT=$S(RMACT=0!(RMACT>0):RMACT*RMQTY,1:$P(RMX,U,3)*RMQTY)
 .S RMPR("AMT")=RMPR("AMT")+RMTOT,RMPRTO=RMPR("AMT")
 S RMPRSH=$S($P(^RMPR(664,RMPRA,0),U,11)=0:0,$P(^RMPR(664,RMPRA,0),U,11):$P(^(0),U,11),$P(^RMPR(664,RMPRA,0),U,10):$P(^(0),U,10),1:"")
 D CHECK^RMPRCT I '$D(RMPRTO) W !,"***** NOT CLOSED-OUT !!!!" G KTMP
 ;**************************************************************
 ;check 4;3,2;8&2;9&4;6 call PRCH7C if needed
 ;if total amount has not changed, then don't need to call ammend
 ;if it is an early record with no ifcap order then don't call ammend
 ;set the reprint flag
 I $FN($P(^RMPR(664,RMPRA,4),U,3),"P",2)'=$FN(RMPRTO+RMPRSH,"P",2)&($P(^(2),U,9)="")!($P(^(2),U,9)'="")&($FN($P(^(2),U,9),"P",2)'=$FN(RMPRTO+RMPRSH,"P",2)) D  I (X=0)&'$D(^TMP("RM",$J)) W !!,"**** NOT CLOSED-OUT!! ****" G KTMP
 .;call IFCAP AMMEND
 .S RMPR442=$P(^RMPR(664,RMPRA,4),U,6) I RMPR442="" Q
 .D AMEND^PRCH7C(RMPR442,RMPRTO+RMPRSH)
 .I X=1 S $P(^RMPR(664,RMPRA,2),U,8)=DUZ,$P(^RMPR(664,RMPRA,2),U,9)=RMPRTO+RMPRSH,$P(^RMPR(664,RMPRA,2),U,10)=1
 .I X'=1 S $P(^RMPR(664,RMPRA,2),U,10)=""
 ;do posting to 660
 I $D(^TMP("RM",$J))!$G(RMSHIF)!$G(RMPERF)!$G(RMBANF) D POST2^RMPR4M
 I $D(RMPRWO),$D(^RMPR(664.2,+RMPRWO,0)) S $P(^("AM"),U,2)=1 S $P(^RMPR(664.2,+RMPRWO,0),U,7)=$P(^(0),U,7)+RMPRSH D DA0^RMPR29M(RMPRDA,RMPRA),POST^RMPR29U
 G:$D(RFLG) EXIT
 ;go to exit in above line if not close-out.
 ;close-out remarks
 W ! S DIE="^RMPR(664,",DA=RMPRA,DR="8.1" D ^DIE S RMPRCC=$P($G(^RMPR(664,RMPRA,2)),U,3)
 F  S R1=$O(^RMPR(664,RMPRA,1,R1)) Q:R1'>0  I $D(^(R1,0)) D
 .N RM660
 .S RM660=$P($G(^(0)),U,13) I RM660,$P($G(^RMPR(660,RM660,0)),U,18)'[RMPRCC S $P(^(0),U,18)=$P(^(0),U,18)_" "_RMPRCC
 ;
EX ;***reindex record in 664 here
 L -^RMPR(664,RMPRA,0)
 ;IFCAP final charge payment
 S RMPR442=$P(^RMPR(664,RMPRA,4),U,6) ;don't call recon if it is an early record, no ifcap order.
 D:RMPR442'="" RECON^PRCH7C(RMPR442,DUZ)
 I (X=0)&(RMPR442'="") W !!,"**** TRANSACTION NOT CLOSED-OUT!! ****" G EX1
 S $P(^RMPR(664,RMPRA,4),U,4)=RMPRTO+RMPRSH
 ;set close out date 
 D NOW^%DTC S $P(^RMPR(664,RMPRA,0),U,8)=%
 ;set closed by
 S $P(^RMPR(664,RMPRA,2),U,7)=DUZ,DA=$P(^RMPR(664,RMPRA,0),U,12)
 I DA'="" S $P(^RMPR(660,DA,0),U,12)=%,DIK="^RMPR(660," D IX1^DIK
 S RMPR660=0,DA="",DIK="^RMPR(660,"
 F  S RMPR660=$O(^RMPR(664,RMPRA,1,RMPR660)) Q:RMPR660'>0  D
 .;get pointer from item mult
 .S DA=$P(^RMPR(664,RMPRA,1,RMPR660,0),U,13)
 .;set delivery date
 .I DA'="" S $P(^RMPR(660,DA,0),U,12)=DT D IX1^DIK
 .;Patch #78 - Get IFCAP Transaction Date and prompt for Shipment Date
 .I DA'="" S SKPSHDT=1 D ^RMPR4E23 K SKPSHDT
EX1 ;
 I $D(RM60LINK) D
 . F I=0:0 S I=$O(RM60LINK(I)) Q:I'>0  D
 .. I '$D(^RMPR(660,I,0)) K RM60LINK(I)
 ;added by #62
 D:$D(RM68FG)=1 AUTO^RMPRPCEL D:$D(RM68FG)>1 MAN^RMPRPCEL
 ;
 D EXIT
 W !!,"Enter Next Transaction to Close-out, or <RETURN> to continue."
 G CL
 ;
EXIT ;KILL VARIABLES AND EXIT ROUTINE
 L:$D(RMPRA) -^RMPR(664,RMPRA,0)
 K ^TMP($J),^TMP("RM")
 K RGRP,RGRP1,RGRPP,RMBAN,RMBANF
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
 ;
KTMP S DIK="^RMPR(664,"_RMPRA_",1,",DA(1)=RMPRA F I=0:0 S I=$O(^TMP("RM",$J,"N",I)) Q:I'>0  S DA=I D ^DIK
 S %X="^TMP("_"""RM"""_",$J,RMPRA,",%Y="^RMPR(664,RMPRA," D %XY^%RCR G EX1
BRK W !,$C(7),"INCOMPLETE RECORD..file 664..entry..",RMPRA,"...PLEASE CONTACT YOUR IRM or CANCEL THIS ENTRY!!!" G EX1
UNK W !,$C(7),"UNKNOWN 2319 RECORD TO UPDATE, 2319 NOT UPDATED!" G EXIT
M4 W !,$C(7),"This Transaction has already been CLOSED!" G EXIT
M6 W !,$C(7),"This Transaction has been CANCELED!" G EXIT
