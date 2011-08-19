PRCNREQE ;SSI/ALA,SEB-Edit a NX Request ;[ 02/06/97  11:55 AM ]
 ;;1.0;Equipment/Turn-In Request;**3,11,12,14**;Sep 13, 1996
EN S DIC="^PRCN(413,",DIC(0)="AEQZ"
 I $G(PRCNCMF)="" S DIC("S")="S ST=$P(^(0),U,7) I ST=1!(ST=3)!(ST=4)!(ST=11)!(ST=12)!(ST=15)&($P(^(0),U,2)=DUZ)"
 I $G(PRCNCMF)'="" D
 . S PRCNC=DUZ D CMR^PRCNCMR K PRCNC
 . S DIC("S")="S ST=$P(^(0),U,7),CMRZ=$P(^(0),U,16) I ST=1!(ST=3)!(ST=5)!(ST=4)!(ST=11)!(ST=45)!(ST=17)!(ST=18)!(ST=15)&($D(PRCNCMR(CMRZ)))"
 D ^DIC K DIC("S") G EQ:Y<0 S IN=+Y,PRCNUSR=0 D SETUP^PRCNPRNT
 I $P($G(^PRCN(413,IN,2)),U,16)]"" S $P(^(2),U,16)="" K ^PRCN(413,IN,15)
EDIT ; Edit the transaction if desired
 W !,"Do you want to edit this request" S %=2 D YN^DICN G EDIT:%=0
 G EQ:%'=1
 K NEW S DIE=413,DIE("NO^")="OUTOK",DR="[PRCNEDIT]",DA=IN D ^DIE
 I PRCNTY="R" D
 . I $G(TDA)="" S TDA=$P(^PRCN(413,DA,0),U,11)
 . I $G(PRCNTDA)="" S PRCNTDA=TDA
 .  Q:$O(^PRCN(413.1,PRCNTDA,1,0))=""
 . S EDIT=2,DIE=413.1,DR="[PRCNTIRQ]",DA=PRCNTDA D ^DIE
EQ K DIC,DIE,DA,DR,IN,PRCNUSR,PRCNQT,PRCNTXT,PRCNTY,PRCNCMR,CMRZ,ST,STA
 K J,JJ,PRCN,PRCNC,VEN,PRCNTDA,D1,PFL,QTY,RDA,RDI,TDA,EDIT
 Q
LINE ; Display associated replacement line items
 S RDA=D0,RDI=D1,QTY=$P($G(^PRCN(413,RDA,1,RDI,0)),U,5)
EN1 N DIEL,DG,DI,DK,DL,DM,DP,DU,D0,D1,DA,DIC,DIE,DR,DQ,X,Y,DV,DOV
 S DIC("S")="I $P(^(0),U,3)=RDI",DA(1)=TDA,DIC(0)="AEQZ",DIC("A")="Select Replacement Line Item: "
 S PRCNCMR=$P(^PRCN(413.1,TDA,0),U,16)
 S DIC="^PRCN(413.1,"_TDA_",1," D ^DIC Q:Y<1  S RI=$P(Y,U,2),DA=+Y D DISP^PRCNTIRQ K DIC("S")
 S DIE("NO^")=""
 S DR=".01;.5Replacement Justification~;I X'=6 S Y="""";.7",DIE=DIC D ^DIE
 D CT I NUM<QTY D
 . W !,"Number of replacement items does not equal quantity"
 . S NM=$P($G(^PRCN(413.1,TDA,1,0)),U,3)
 . I NM="" S ^PRCN(413.1,TDA,1,0)="^413.11IPA^^"
 . D RP2^PRCNREQN
EXIT K TDA,RDA,RI,DA,DIE,DIC,DR
 Q
CT S NUM=0,NN="" F  S NN=$O(^PRCN(413.1,TDA,1,"AC",RDI,NN)) Q:NN=""  S NUM=NUM+1
 Q
TXT ;  Set first 20 characters into Short Description field
 S $P(^PRCN(413,D0,0),U,18)=""
 S PRCNTXT=$G(^PRCN(413,D0,1,1,1,1,0))
 I $L(PRCNTXT)>20 S PRCNTXT=$E(PRCNTXT,1,20)
 S VEN=$P($G(^PRCN(413,D0,1,D1,0)),U,2) S:VEN'="" VEN=$P(^PRC(440,VEN,0),U)
 S VEN=$S($G(VEN)="":$P($G(^PRCN(413,D0,1,D1,0)),U,13),1:VEN)
 Q
CMP ;  Check for completeness of data
 S PFL=0
 S PDD1=D1 D CMPD Q:QFL
 S PDD1=0 F  S PDD1=$O(^PRCN(413,D0,1,PDD1)) Q:'PDD1  D CMPD Q:QFL
 I $P(^PRCN(413,D0,0),U,9)'="R" S PFL=1
 Q
CMPD S QFL=0
 Q:'$D(^PRCN(413,D0,1,PDD1))
 F I=1,4,5,12 I $P(^PRCN(413,D0,1,PDD1,0),U,I)="" S QFL=1 Q
 I $P(^PRCN(413,D0,1,PDD1,0),U,12)="P" S PFL=1
 Q
