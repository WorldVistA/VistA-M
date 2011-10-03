PRCHFPDE ;SF-ISC/TKW-EDIT FPDS DATA ON P.O. AFTER SIGNED BY P.A. ;12-6-90/15:48
V ;;5.1;IFCAP;**79,100**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN1 ;EDIT FPDS DATA ON P.O. AFTER BEING SIGNED BY P.A.
 I $D(PRCHAM) S PRCHFLG=""
 N PRCHER,PRCHAM,PRCHAMDA,PRCHAMT,PRCHDUZ ;Newing variables for amends
 I $D(PRCHPO) S PRCHPOO=PRCHPO N PRCHPO S PRCHPO=PRCHPOO K PRCHPOO
 D:'$D(PRCHPO) ST^PRCHE Q:'$D(PRC("SITE"))
EN10 D:'$D(PRCHPO)!'$D(PRCHFLG) LOOK G:'$D(PRCHPO) Q D LCK1^PRCHE G:'$D(DA) EN10 S PRCHEST=$P(^PRC(442,PRCHPO,0),U,13)
 S X=$G(^PRC(442,PRCHPO,1)),PRCHV=+X,PRCHDT=$S($P(X,U,15)<2881001:0,$P(X,U,15)>2880930:1,1:""),PRCHSC="" I $D(^PRCD(420.8,+$P(X,U,7),0)) S PRCHSC=$P(^(0),U,1)
 ;
 ;PRC*5.1*79 - check for canceled orders or ineligible orders, i.e. RMPR
 I $P(^PRC(442,PRCHPO,7),U,2)=45!($G(PRCHSC)="") D OUT G EN10
 I $P(^PRC(442,PRCHPO,7),U,2)'>10 D EN^DDIOL("This Purchase Order has not been properly completed.") G EN10
 I "0139"[PRCHSC D OUT G EN10
 ;End check for PRC*5.1*79
 I PRCHDT="" D EN^DDIOL("Purchase Order has no date. ","","!") G EN10
 I 'PRCHDT W $C(7),!,"This option only available for P.O.'s beyond FY 1988!" G EN10
 S Y=$G(^PRC(440,PRCHV,2)),PRCHN("LSA")=$P(Y,U,5),PRCHN("MB")=$S(PRCHDT:$P(Y,U,3),1:$P(Y,U,6))
 S PRCHN("SFC")=$P(^PRC(442,PRCHPO,0),U,19),PRCHN("MP")=$P($G(^PRCD(442.5,+$P(^PRC(442,PRCHPO,0),U,2),0)),U,3) I 'PRCHN("MP") W !,$C(7),"Method of Processing not entered!" G Q
 S PRCHBO=$S(PRCHDT:1.1,1:1) K PRCHB
 G:PRCHDT&("013"[PRCHSC) ASK I $O(^PRC(440,PRCHV,PRCHBO,0)) S PRCHB(0)="^442.16PA^"_$P(^(0),U,3,4) F I=0:0 S I=$O(^PRC(440,PRCHV,PRCHBO,I)) Q:'I  S PRCHB(I)=I
 I PRCHDT,'$D(PRCHB) D ER3^PRCHNPO6 G EN10
 ;
ASK W !!,$C(7),"ARE YOU SURE YOU WANT TO RE-ENTER THE FPDS CODES " D YN^DICN Q:($D(PRCHFLG)>0)&(%=-1)  G:($D(PRCHFLG)=0)&(%=-1) EN10
 D:%=0 W G:%=0 ASK Q:($D(PRCHFLG)>0)&(%'=1)  G:($D(PRCHFLG)=0)&(%'=1) EN10
 I 'PRCHDT!("013"'[PRCHSC) D EN6^PRCHNPO2 G EN10:'$D(PRCHPO)
 K PRCH S PRCHEC=0 F I=0:0 S I=$O(^PRC(442,PRCHPO,2,I)) Q:'I  I $D(^(I,0)) S X=^(0),Y=$G(^(2)) D TBL
 ;
 ;Clear node 25 of any FPDS data, PRC*5.1*79
 K ^PRC(442,PRCHPO,9),^PRC(442,PRCHPO,25) S ^(9,0)="^442.1A^^",$P(^PRC(442,PRCHPO,0),U,15)=0
 W $C(7),!!,"PREVIOUS FPDS CODES HAVE BEEN DELETED!",!!
 S PRCHY=0 I PRCHEST>0,PRCHEC>0 S PRCHY=PRCHEST/PRCHEC,Y=$P(PRCHY,".",2) I $L(Y)>2 S PRCHY=$P(PRCHY,".",1)+$J("."_Y,2,2)
 S DIE="^PRC(442,",DR="[PRCHAMT89]",DA=PRCHPO
 I PRCHDT D FPDS^PRCHFPD2 Q:$D(PRCHFLG)>0&(%=-1)  G:'PRCHFPDS EN10
 S PRCH="" F PRCHI=1:1 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  D TYPE^PRCHNPO1 S PRCHAMT=+PRCH("AM",PRCH),PRCHCN=$S(PRCH=".OM":"",1:PRCH) W ?40,"AMOUNT: ",PRCHAMT S PRCHAMT=""""_PRCHAMT_"""",DIE("NO^")="NO" D ^DIE
 ;PRC*5.1*79 - call new input templates for FPDS data.
 ;Check a regular PO from a Purchasing Agent.
 ;PRC*5.1*100 - if the user times out and does not complete the input
 ;template for the new FPDS, don't allow electronic sig. Check the last
 ;field required for the PO, based on the source code.
 ;
 I ("25"[PRCHSC),$D(^PRC(442,PRCHPO,14)) D  G:$G(PRCHER)=1 Q
 . S DR="[PRCH NEW PO FPDS]" D ^DIE
 . I '$D(^PRC(442,PRCHPO,25)) D STOP Q
 . I $P(^PRC(442,PRCHPO,25),U,6)="" D STOP Q
 . ;Fund agency code & fund agency office code can be empty in pairs only.
 . I +$P(^PRC(442,PRCHPO,25),U,7)>0,$P(^PRC(442,PRCHPO,25),U,8)="" D STOP Q
 ;End of changes for PRC*5.1*100.
 ;
 ;For FPDS purposes, consider any PO with any of the following source
 ;codes as a delivery order:
 ;PRC*5.1*100 - if the user times out, don't allow electronic sig.
 I ("467B"[PRCHSC)&($D(^PRC(442,PRCHPO,14))) D  G:$G(PRCHER)=1 Q
 . S DR="[PRCH NEW PO FPDS]" D ^DIE
 . I '$D(^PRC(442,PRCHPO,25)) D STOP Q
 . I $P(^PRC(442,PRCHPO,25),U,15)="" D STOP Q 
 . E  D POP^PRCHNPO1
 ;
 ;Quit if type code, pref, program, etc., are not defined.
 I '$D(^PRC(442,PRCHPO,9)) D STOP G Q
 D EN^DDIOL("Ok, let me save your changes.....done!","","!!?3") D ^PRCHSF
 ;End of changes for PRC*5.1*100.
 ;
 ;Send HL7 message to the AAC
 I $P($G(^PRC(442,PRCHPO,25)),U,17)="YES",$P(^PRC(442,PRCHPO,0),U,15)>0 D EN^DDIOL("...now generating the FPDS message for the AAC","","!") D AAC^PRCHAAC
 ;End changes for PRC*5.1*79
 K DIE F I=0:0 Q:'$D(PRCHPO)  S I=$O(^PRC(442,PRCHPO,9,I)) Q:'I  D ER2^PRCHNPO6:$P(^(I,0),U,2)="",ER3^PRCHNPO6:'$O(^(1,0))
 L  I $D(PRCHFLG) K PRCHFLG Q
 G EN10
 ;
OUT ;Tell the user that the PO is not eligible for FPDS
 D EN^DDIOL("This PO is not required for FPDS.","","!!?10")
 Q
 ;
STOP ;PRC*5.1*100 - quit if all the FPDS info was not entered.
 D EN^DDIOL("WARNING: YOU HAVE NOT ENTERED ALL THE FPDS DATA - NO MESSAGE GENERATED.","","!!?5") S PRCHER=1
 Q
 ;End of changes for PRC*5.1*100.
 ;
TBL ;TABLE LINE/ITEM AMOUNTS MINUS DISCOUNTS BY CONTRACT NO.
 S PRCHCN=$S($P(Y,U,2)'="":$P(Y,U,2),1:".OM") S:'$D(PRCH("AM",PRCHCN)) PRCH("AM",PRCHCN)="",PRCHEC=PRCHEC+1
 S PRCH("AM",PRCHCN)=($P(PRCH("AM",PRCHCN),U,1)+1)_"^"_($P(PRCH("AM",PRCHCN),U,2)+Y-$P(Y,U,6))_"^"_($P(PRCH("AM",PRCHCN),U,3))_+X_"," Q:$L(PRCH("AM",PRCHCN))<240
 ;
CNDNS N X,Y,I,J,C S C=",",X=$P(PRCH("AM",PRCHCN),U,3)
 F I=1:1:999 Q:$P(X,C,I)=""  I $P(X,C,I)?.N,$P(X,C,I+1)=($P(X,C,I)+1) F J=I+1:1:999 I ($P(X,C,J+1)'?1N.N)!(($P(X,C,J)+1)'=$P(X,C,J+1)) S Y=C_$P(X,C,I+1,J-1)_C,$P(PRCH("AM",PRCHCN),U,3)=$P(X,Y,1)_":1:"_$P(X,Y,2),I=999,J=999
 Q
 ;
LOOK ;K PRCHPO,PRCHNEW,DA,DIC,D0,DQ S DIC("S")="I +^(0)=PRC(""SITE"") S PRCHX=$S($D(^(7)):+^(7),1:0) I $D(^PRCD(442.3,PRCHX,0)),$P(^(0),U,2)>9"
 K PRCHPO,PRCHNEW,DA,DIC,D0,DQ S DIC("S")="I +^(0)=PRC(""SITE"") S PRCHX=+$G(^(7)) I $D(^PRCD(442.3,PRCHX,0)),$P(^(0),U,2)>9"
 S DIC="^PRC(442,",DIC(0)="QEAMZ",D="C",DIC("A")="PURCHASE ORDER: " S:'$D(DIC("S")) DIC("S")="I +$P(^(0),U,1)=PRC(""SITE"")"
 W !! D IX^DIC K DIC S X="" Q:+Y<0  S (PRCHPO,DA)=+Y
 Q
 ;
ER W !,$S('PRCHDT:" Breakout Code is undefined.",1:" Socioeconomic Group (FY89) not defined in Vendor file."),$C(7) K PRCHPO
 Q
 ;
W W !!,?10," Enter either Yes/No  or  enter ""^"" to exit."
 W !!,"This option will delete all FPDS codes that were previously entered",!,"for this Purchase Order, then allow you to re-enter them."
 Q
 ;
 ;
Q L  K PRC,PRCHI,PRCHFLG G Q^PRCHNPO4
