PRCFDE ;WISC/CTB/CLH/BGJ-ENTER/EDIT CERTIFIED INVOICE ; 9/28/99 11:30am
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DE I '$D(PRC("SITE")) S PRCF("X")="AS" D ^PRCFSITE Q:'$D(PRC("SITE"))
 S DIC=421.5,DIC("S")="I $P(^(2),U)=0",DIC(0)="AEMNQ"
 S DIC("A")="Select CERTIFIED INVOICE: "
 D ^DIC K DIC Q:+Y<0  S PRCF("CIDA")=+Y
 S %A="Are you SURE you want to delete this record",%B="",%=2
 D ^PRCFYN I %'=1 S X="  <Nothing deleted.>*" D MSG^PRCFQ,OUT Q
DEL ;DELETE INDIVIDUAL CERTIFIED INVOICE RECORD
 S DA=PRCF("CIDA"),DIK="^PRCF(421.5," D ^DIK K DIK
 S X="Certified Invoice Record Deleted*" D MSG^PRCFQ
OUT ;EXIT LINE
 K %,C,DA,DIC,DIE,DLAYGO,DR,F,J,N,PRCF,PRCFD,PRCFCK,PRCHPO,X,X1,Y,Z,D0
 Q
OUT1 D NA^PRCFDE1 S X=0 D STATUS^PRCFDE1,OUT Q
CREATE ;ASSIGN NEXT NUMBER
 S X=$P(^PRCF(421.5,0),"^",3) F Y=X+1:1 L +^PRCF(421.5,Y):0 Q:$T&('$D(^PRCF(421.5,Y)))  L -^PRCF(421.5,Y)
 S X=Y,DIC=421.5,DLAYGO=421.5,DIC(0)="ELZN",D="B" D IX^DIC K DLAYGO Q:Y<0
 S X=+Y L -^PRCF(421.5,X)
 Q
QUES W $C(7),!,"You may:",!,"1. Scan a Certified Invoice Barcode Label or,",!,"2. Enter 'NEW' or 'NEXT' for auto assignment.",!!
 Q
PT K PRCF("PODA"),PRCF("VENDA")
 N PRCFVEN
 S PRCFVEN=$P(^PRCF(421.5,PRCF("CIDA"),0),U,8) I $G(PRCFVEN)]"" D
 . K ^PRCF(421.5,"C",PRCFVEN,PRCF("CIDA"))
 . S $P(^PRCF(421.5,PRCF("CIDA"),0),U,8)=""
 S DIE="^PRCF(421.5,",DR="4.5Select PAT Number: ",DA=PRCF("CIDA")
 D ^DIE
 Q
NEW ;ENTER NEW CERTIFIED INVOICE
 S PRCFNOPO=0
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
N1 S (PRCFD("NEW"),PRCFD("PAY"))="",Y=0
 R !,"Enter Invoice Tracking Number: ",X:DTIME
 G:'$T!(X["^")!(X="") OUT I $E(X)=" " W $C(7) G NEW
 I X["?" D QUES G N1
 S A="~NEW~New~new~NEXT~Next~next",Z="~"_X I X'?1.9N,A'[Z W $C(7)," Incorrect format." S X="Correct Format is 1 to 9 numbers or the words NEW or NEXT*" D MSG^PRCFQ D QUES G N1
 I A[Z D CREATE G:Y<0 NEW
 K Z,A I Y=0 S DIC=421.5,DLAYGO=421.5,DIC(0)="XZL" D ^DIC K DLAYGO I Y<0 S X="Unable to add "_X_" to the file. Try again.*" D MSG^PRCFQ W $C(7),$C(7),$C(7),$C(7) G NEW
 S X="Adding "_X_" to Invoice Tracking File.*" D MSG^PRCFQ
N2 K DIC,DLAYGO I Y<0 K X,Y G OUT
 I '$P(Y,"^",3) S X="This is not a new Invoice Tracking Number.  Use EDIT INCOMPLETE INVOICE Option if you wish to edit it.*" D MSG^PRCFQ G NEW
 S DA=+Y,PRCF("CIDA")=+Y,$P(^PRCF(421.5,DA,1),"^",2)=PRC("SITE")
 ;D ^PRCFDLN S $P(^PRCF(421.5,PRCF("CIDA"),0),"^",2)=PRCFDLN K PRCFDLN
 K PRCFX,DIC
 D PAT G:$D(PRCFD("^")) OUT
 S %A="Do you wish to enter another invoice",%B="",%=1 D ^PRCFYN
 G:%'=1 OUT D OUT G NEW
PAT D PT I $D(Y) S %A="OK to Delete",%B="",%=1 D ^PRCFYN G:%=2 PAT D DEL Q
 S Y(0)=^PRCF(421.5,DA,0),Y(1)=$G(^(1))
 I $P(Y(1),"^",3)="" S X="PAT Number is REQUIRED.*" D MSG^PRCFQ
 I $P(Y(0),"^",7)="" S X="Purchase Order data will not be available for this payment.*" D MSG^PRCFQ S PRCFNOPO=1 G DIE
 S (PRCF("PODA"),D0)=$P(^PRCF(421.5,DA,0),"^",7)
 I $$CLSD1358^PRCFDE2(PRCF("PODA"),1) R !,"Hit <CR> to continue",X:DTIME
 D ^PRCFDSC1 S PRCF("VENDA")=$P($G(^PRCF(421.5,PRCF("CIDA"),0)),U,8)
 I $D(^PRC(442,PRCF("PODA"),1)),+^(1)>0 S PRCF("VENDA")=+^(1)
 S $P(^PRCF(421.5,PRCF("CIDA"),0),"^",7)=PRCF("PODA")
 I PRCF("VENDA")?1.N D
 . S DA=PRCF("CIDA"),DIE=421.5,DR="6////"_PRCF("VENDA")
 . D ^DIE K DA,DIE,DR
 S (X,PRCF("PO"))=$P(^PRC(442,PRCF("PODA"),0),"^")
 S $P(^PRCF(421.5,PRCF("CIDA"),2),"^",3)=X,$P(^(1),"^",3)=X
 D
 . S DIC=421.9,DIC(0)="Z",X=PRCF("PO") D ^DIC
 . I Y'<0,$P(Y(0),"^",2)>949 D  W !! D MSG^PRCFQ W $C(7),$C(7),$C(7),$C(7)
 . . I $P(Y(0),"^",2)<974 S X="WARNING:  This PO currently has "_$P(Y(0),"^",2)_" partials and is approaching the limit of 974 permitted by the system." Q
 . . I $P(Y(0),"^",2)=974 S X="WARNING:  This PO currently has 974 partials, which is the limit permitted by the system.  The addition of further partials will result in errors." D  Q
 . . . S X=X_"  If you proceed with the processing of this invoice in IFCAP, the PV document will have to be created on-line in FMS."
 . . S X="WARNING:  This PO currently has "_$P(Y(0),"^",2)_" partials and has exceeded the limit of 974 permitted by the system.  Corrective action must be taken." D  Q
 . . . S X=X_"  If you proceed with the processing of this invoice in IFCAP, the PV document will have to be created on-line in FMS."
 . K DIC,Y
 W !,$C(7) S %=2,%A="Do you need to view the entire PO",%B=""
 D ^PRCFYN I %<0 D OUT1 Q
 S D0=PRCF("PODA") I %=1 D ^PRCHDP1,^PRCFDSC1 W !,$C(7) K PRCHPO
 S %=1,%A="Is this the correct Purchase Order for this Invoice",%B=""
 D ^PRCFYN G PAT:%=2 I %<0 D OUT1 Q
 S %A="Do you want to review other Invoices for this Purchase Order"
 S %B="",%=2 D ^PRCFYN I %<0 D OUT1 Q
 D:%=1 PO^PRCFDIC
VEN ;
 D
 . S X=$O(^PRC(442,PRCF("PODA"),5,0)) Q:X=""
 . S X1=$G(^PRC(442,PRCF("PODA"),5,X,0))
 . S PRCF("%")=$P(X1,"^"),PRCF("DAYS")=$P(X1,"^",2)
 . S:+X1>0 $P(^PRCF(421.5,PRCF("CIDA"),0),"^",11,12)=PRCF("%")_"^"_PRCF("DAYS")
 . S:$E(X1,1,3)="NET" $P(^PRCF(421.5,PRCF("CIDA"),1),"^",10)=PRCF("DAYS")
 . Q
 S $P(^PRCF(421.5,PRCF("CIDA"),0),U,6)=$P($G(^PRC(442,PRCF("PODA"),12)),U,15)
 I +$P($G(^PRC(442,PRCF("PODA"),1)),U) D  I %'=1 D VENED^PRCFDCI
 . S %A="Is this the correct Vendor for this Invoice",%B="",%=1
 . D ^PRCFYN
 I '$P($G(^PRC(442,PRCF("PODA"),1)),U) D  I PRCF("VENDA")'?1.N W !,"Terminating Edit." D OUT Q
 . S DIC=440,DIC(0)="AENMQ" S:$P($G(^PRC(411,PRC("SITE"),0)),U,20) DIC(0)=DIC(0)_"L",DLAYGO=440
 . S DIC("A")="Invoice's Vendor: " S:PRCF("VENDA")?1.N DIC("B")=$P($G(^PRC(440,PRCF("VENDA"),0)),U)
 . D ^DIC K DIC,DLAYGO,ORDER,PRCHOV3,STATE Q:+Y<1  S PRCF("VENDA")=+Y
 . I $P(Y,U,3) S PRCF("NUVEND")=1 D VENDOR^PRCFDE2
 . S DIE=421.5,DR="6////"_PRCF("VENDA"),DA=PRCF("CIDA") D ^DIE
 . K DA,DR,DIE
 I +$G(PRCF("VENDA")),'$G(PRCF("NUVEND")) S %A="Do you want to edit this Vendor's information",%B="",%=2 D ^PRCFYN G OUT:%<1 D:%=1 VENDOR^PRCFDE2
VL ;
 S %A="Do you want to review other Invoices for this VENDOR"
 S %B="",%=2 D ^PRCFYN I %<0 D OUT1 Q
 D:%=1 VENDOR^PRCFDIC
DIE G ^PRCFDE1
