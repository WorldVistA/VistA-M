PRCNCNCL ;SSI/SEB-Cancel equipment request ;[ 02/26/97  5:59 PM ]
 ;;1.0;PRCN;**3**;Sep 13, 1996
REQ ;  Requestor cancel
 S DIC("S")="S ST=$P(^(0),U,7) I $P(^(0),U,2)=DUZ&(ST=4!(ST=11)!(ST=12)!(ST=14)!(ST=15)!(ST=16)!(ST=1))"
 Q
PPM ;  PPM cancel
 S DIC("S")="S ST=$P(^(0),U,7) I (ST'=20&(ST'=34)&(ST'=35)&(ST'=36))"
 Q
EN W @IOF S DIC("A")="Enter TRANSACTION #: ",DIC="^PRCN(413,",DIC(0)="AEQ"
 D ^DIC K DIC("S")
 G:$D(DUOUT)!(X="") EXIT S D0=+Y,PRCNDATA=^PRCN(413,D0,0),NUM=$P(Y,U,2)
PR ; Prints the data for this transaction
 W !!,"Service: ",$P(^DIC(49,$P(PRCNDATA,U,3),0),U),?41,"CMR Official: "
 I $P(PRCNDATA,U,6)'="" W $P(^VA(200,$P(PRCNDATA,U,6),0),U)
 W !,"Requestor: ",$P(^VA(200,$P(PRCNDATA,U,2),0),U)
 W ?41,"Date entered: " S Y=$P(PRCNDATA,U,4)\1
 D DD^%DT W Y,!,"Line Items:" S D1=0
 F  S D1=$O(^PRCN(413,D0,1,D1)) Q:D1'?1N.N  D
 . W !,?5,$P($G(^PRCN(413,D0,1,D1,0)),U),?10,$G(^PRCN(413,D0,1,D1,1,1,0))
 . S DR=15,DR(413.015)=6,DIQ(0)="C",DIQ="LBTOT"
 . S DIC=413,DA=D0,DA(1)=D1,DA(413.015)=D1 NEW D1,D0
 . D EN^DIQ1
 . S X=$G(LBTOT(413.015,DA(413.015),6))
 . W ?55,"$",$J(X,9,2)
 . K DIQ,DA,DR,DIC,X,LBTOT
ASK ; Ask if user is certain he/she wants to cancel request
 W !!,"Are you sure you want to cancel this transaction" S %=2 D YN^DICN
 I %=0 W !,"Please enter 'Y' to cancel this transaction." G ASK
 I %'=1 W !!,"OK, the transaction was not cancelled." G EXIT:%=-1,REP
 S DR="127;I '$D(^PRCN(413,D0,37)) W $C(7),""??  Reason for cancellation is required!"" S Y=127;6////^S X=20;7////^S X=DT;49///@"
 S DIE=413,DA=D0 D ^DIE
 S X=$P($G(^PRCN(413,DA,2)),U,18) D
 . D:'$D(PSER) PRIMAX^PRCNCMRP
 . S RNK="" F  S RNK=$O(^PRCN(413,"P",PSER,RNK)) Q:RNK=""  K ^PRCN(413,"P",PSER,RNK,DA)
 . K PSER,X,RNK
 S $P(^PRCN(413,DA,2),U,18)=""
 W !!,"Transaction #",NUM," has been cancelled."
REP ; If replacement, ask if user wants to cancel turn-in
 G EXIT:$P(^PRCN(413,D0,0),U,9)'="R"
 S DA=$P(^PRCN(413,D0,0),U,11)
QS W !!,"Do you want to cancel the corresponding turn-in request" S %=2
 D YN^DICN I %=2 W !!,"OK, the turn-in request was not cancelled." G EXIT
 I %=0 W !,"Please enter 'Y' to cancel the corresponding Turn-in request." G QS
 S DIE=413.1,DR="6////^S X=20;7////^S X=DT" D ^DIE
 ;  Remove associated items from Equip Inv file 6914
 S D1=0 F  S D1=$O(^PRCN(413.1,DA,1,D1)) Q:'D1  D
 . S PTR=$P(^PRCN(413.1,DA,1,D1,0),U)
 . K ^PRCN(413.1,"AB",PTR,DA,D1)
 W !!,"Turn-in request #",$P(^PRCN(413.1,DA,0),U)," cancelled."
EXIT ; Kill variables and quit
 K X,Y,ST,TRN,NUM,C,PRCNDATA,D1,PTR,DA,DIE,DIC,SERV,OLD,PRIMAX,PSER
 K D0,J,LPRI,OLDPRI,SK,DR,TEX1,TEX2,TEX3
 Q
