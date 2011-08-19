PRCHNPO7 ;WISC/RHD-MISCELLANEOUS ROUTINES FROM P.O.ADD/EDIT 442 ; 7/27/05 10:16am
V ;;5.1;IFCAP;**79,100**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN1 ;INPUT TRANSFORM-FILE 442, NSN #9.5
 I '$D(^PRC(441.2,+X,0)) W !!,$C(7),"Invalid NSN--first 4 characters must be FSC code!!" K X Q
 S PRCHCI=+$P(^PRC(442,DA(1),2,DA,0),U,5)
 S Z=$O(^PRC(441,"BB",X,0)) S:Z=PRCHCI Z=$O(^(Z)) I Z W !!,$C(7),"This NSN has already been assigned to item # "_$O(^(0))_"!!" K X Q
 I $P(^PRC(441.2,+X,0),U,4)="" W $C(7),!,"Commodity Code missing on this FSC--Required for LOG code sheets!" K X Q
 S $P(^PRC(442,DA(1),2,DA,2),U,3)=+X
 Q:$P(^PRC(442,DA(1),2,DA,0),U,5)=""
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0) S PRCHCPO=DA(1) D EN5^PRCHCRD
 S PRCHSAVX=X,X=+X
 G EN11
 ;
EN10 ;UPDATE FEDERAL SUPPLY CLASSIFICATION/PRODUCT SERVICE CODE (FSC/PSC), field #8, file #442.
 ;PRC*5.1*79: if entering a service item, don't check for commodity code.
 ;The field title is now called 'FSC/PSC' to hold either a Federal Supply
 ;Classification (FSC) code or a Product Service Code (PSC) to support a
 ;new FPDS report for the Austin Automation Center (AAC). The variable
 ;PRCSAVE is killed in various PO input templates where it is used.
 ;
 I '$D(PRCSAVE)&(X'=$P(^PRC(441.2,+X,0),U,1))&($P(^PRC(442,DA(1),2,DA,0),U,5)'="") D EN102 K A,X Q
 ;
 I ($P(^PRC(441.2,+X,0),U,4)="")&(X=$P(^PRC(441.2,+X,0),U,1)) D EN104 K A,X Q
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0)
 I $G(PRCSAVE)="G"&(X'=$P(^PRC(441.2,+X,0),U,1)) D EN102 K A,X Q
 ;
 I $G(PRCSAVE)="S"&(X=$P(^PRC(441.2,+X,0),U,1))&($P(^PRC(442,DA(1),2,DA,0),U,5)="") D EN103 K A,X Q
 ;
EN11 S PRCHCI=+$P(^PRC(442,DA(1),2,DA,0),U,5),PRCHCPO=DA(1) I $D(^PRC(441,+PRCHCI,0)) D EN8^PRCHCRD1
 S:$D(PRCHSAVX) X=PRCHSAVX K PRCHSAVX
 Q
 ;
EN100 ;Come here for amended orders - check FSC/PSC, field #8, file #443.6.
 ;PRC*5.1*79: if entering a service item, don't check for commodity code
 I X=""&($P(^PRC(443.6,DA(1),2,DA,2),U,3)="") D EN^DDIOL("This field is Required!!") S Y="@6" Q
 I '$D(PRCSAVE)&(X'=$P(^PRC(441.2,+X,0),U,1))&($P(^PRC(443.6,DA(1),2,DA,0),U,5)'="") D EN102 K A,X Q
 ;
 I ($P(^PRC(441.2,+X,0),U,4)="")&(X=$P(^PRC(441.2,+X,0),U,1)) D EN104 K A,X Q
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0)
 I $G(PRCSAVE)="G"&(X'=$P(^PRC(441.2,+X,0),U,1)) D EN102 K A,X Q
 ;
 I $G(PRCSAVE)="S"&(X=$P(^PRC(441.2,+X,0),U,1))&($P(^PRC(443.6,DA(1),2,DA,0),U,5)="") D EN103 K A,X Q
 ;
 S PRCHCI=+$P(^PRC(443.6,DA(1),2,DA,0),U,5),PRCHCPO=DA(1) I $D(^PRC(441,+PRCHCI,0)) D EN8^PRCHCRD1
 S:$D(PRCHSAVX) X=PRCHSAVX K PRCHSAVX
 Q
 ;
EN101 ;Check Request for Quotations - check FSC/PSC, field #4, file #444.
 I '$D(PRCSAVE)&($P(^PRC(444,DA(1),2,DA,0),U,4)'="")&(X'=$P(^PRC(441.2,+X,0),U,1)) D EN102 K A,X Q
 ;
 I ($P(^PRC(441.2,+X,0),U,4)="")&(X=$P(^PRC(441.2,+X,0),U,1)) D EN104 K A,X Q
 I $G(PRCSAVE)="G"&(X'=$P(^PRC(441.2,+X,0),U,1)) D EN102 K A,X Q
 ;
 I $G(PRCSAVE)="S"&(X=$P(^PRC(441.2,+X,0),U,1)) D EN103 K A,X Q
 ;
 S PRCHCI=+$P(^PRC(444,DA(1),2,DA,0),U,5),PRCHCPO=DA(1) I $D(^PRC(441,+PRCHCI,0)) D EN8^PRCHCRD1
 S:$D(PRCHSAVX) X=PRCHSAVX K PRCHSAVX
 Q
 ;
EN102 ;Stop assignment of a PSC to an item.
 S A(1)="This is a Product Service Code - Not allowed on ITEMS!!"
 S A(2,"F")="!"
 D EN^DDIOL(.A)
 Q
 ;
EN103 ;Stop assignment of an FSC to a service.
 S A(1)="This is a Federal Supply Classification Code - Not allowed on SERVICES!!"
 S A(2,"F")="!"
 D EN^DDIOL(.A)
 Q
 ;
EN104 ;Stop user if commodity code is missing.
 S A(1)="Commodity Code missing on this Federal Supply Classification--Required for LOG code sheets!"
 S A(2,"F")="!"
 D EN^DDIOL(.A)
 Q
 ;
EN105 ;Stop a PO if a line item does not contain an FSC or PSC. This tag is
 ;called from the routine PRCHNP04. Do not clean up variables here.
 ;This check is for all POs that may be required by FPDS. PRC*5.1*100.
 I $P(^PRC(442,PRCHPO,1),U,7)]"" D
 . S PRCHITM=0 F  S PRCHITM=$O(^PRC(442,PRCHPO,2,PRCHITM)) Q:'PRCHITM  I $P($G(^PRC(442,PRCHPO,2,PRCHITM,2)),U,3)="" D EN^DDIOL("Line item "_PRCHITM_" on this PO does not contain an FSC or PSC.","","!!?5") S ERROR=1
 ;End of changes for PRC*5.1*79
 Q
 ;
EN106 ;PRC*5.1*100: stop amended PO with line items lacking an FSC or PSC.
 I $P(^PRC(443.6,PRCHPO,1),U,7)]"" D
 . S PRCHITM=0 F  S PRCHITM=$O(^PRC(443.6,PRCHPO,2,PRCHITM)) Q:'PRCHITM  I $P($G(^PRC(443.6,PRCHPO,2,PRCHITM,2)),U,3)="" D EN^DDIOL("Line item "_PRCHITM_" on this PO does not contain an FSC or PSC.","","!!?5") S ERROR=1
 Q
 ;
EN2 ;IF 'ESTIMATED P.O.' MOVE VERBAGE INTO COMMENTS
 D EN2A
 Q:'$D(^PRC(442,PRCHPO,7))  Q:$P(^(7),U,3)'="Y"  S WX="*** ESTIMATED PURCHASE ORDER ***" I $D(^PRC(442,PRCHPO,4,1,0)),^(0)[WX K WX Q
 S WX=WX_"   ",PRCH="^PRC(442,PRCHPO,4," D WORD^PRCHUTL K PRCH
 Q
 ;
EN2A ;CHECK DELIVERY SCHEDULES-QUANTITY DELIVERED MUST BE >0
 N NUM,J,K,DA
 S NUM=$P(^PRC(442,PRCHPO,0),U)
 I $D(^PRC(442.8,"AC",NUM)) D
 . F J=0:0 S J=$O(^PRC(442.8,"AC",NUM,J)) Q:J'>0  D
 . . F K=0:0 S K=$O(^PRC(442.8,"AC",NUM,J,K)) Q:K'>0  D
 . . . I $P(^PRC(442.8,K,0),U,5)'>0 S DIK="^PRC(442.8,",DA=K D ^DIK K DIK
 Q
EN3 ;COMPLETE DEPOT/GSA PUSH ORDERS
 S I=$P(^PRC(442,PRCHPO,0),U,15)
 W !!,"Total Dollar Amount: "_I_" //" R X:DTIME S:'$T X="^" S:X="" X=I I X["^" S X=1 G EN31
 I X=""!(X=0) G EN30
 I X["?" W !!,"You can either enter the total dollar amount for the entire PUSH, or just the",!,"dollar amount for this part (regular, subsistence or drugs).  This is just",!,"used to update the P.O.register." G EN3
 S:X["$" X=$P(X,"$",2) I X'?.N.1".".2N!(X>9999999.99)!(X<1) W $C(7),"??" G EN3
 S $P(^PRC(442,PRCHPO,0),U,15)=X
 ;
EN30 S X=1,%A="Complete this Requisition ",%B="This action will change the status to 'Transaction Complete'.",%=1 D ^PRCFYN I %=1 S X=40
 ;
EN31 S DA=PRCHPO D ENS^PRCHSTAT
 Q
 ;
EN6 ;FILE 442, SKU #9.4
 D VEN Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=$P($P(^PRC(442,DA(1),0),U,1),"-",1) S PRCHCV=$P(^PRC(442,DA(1),1),U,1),PRCHCI=$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN10^PRCHCRD1
 Q
 ;
EN7 ;FILE 442, UNIT CONVERSION FACTOR #9.7
 D VEN Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0) S PRCHCV=+$P(^PRC(442,DA(1),1),U,1),PRCHCI=+$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN11^PRCHCRD1
 Q
 ;
VEN I $S('$D(^PRC(442,DA(1),1)):1,$P(^(1),U,1)="":1,1:0) W !!,"Vendor must be entered before items ! ",$C(7) K X
 Q
 ;
VENA I $S('$D(^PRC(442,DA,1)):1,$P(^(1),U,1)="":1,1:0) W !!,"Vendor must be entered before items ! ",$C(7) K X
 Q
 ;
VEN1 I $S('$D(^PRC(443.6,DA(1),1)):1,$P(^(1),U,1)="":1,1:0) W !!,"Vendor must be entered before items ! ",$C(7) K X
 Q
 ;
VEN1A I $S('$D(^PRC(443.6,DA,1)):1,$P(^(1),U,1)="":1,1:0) W !!,"Vendor must be entered before items ! ",$C(7) K X
 Q
 ;
 ;
 ;
SUPBOC(QUIETLY) ;stmts.to compute pre-implied BOC, moved from template PRCH2138 into this routine and also called in BOC input transform
 N PRCHIDA,SPFCP,PRCHBOCC,ACCT
 S:$G(QUIETLY)=-1 X=$P($G(^PRC(442,DA(1),2,DA,0)),U,4)
 D VEN Q:'$D(X) ""
 S PRCHIDA=+$P(^PRC(442,DA(1),2,DA,0),U,5),SPFCP=+$P(^PRC(442,DA(1),0),U,19)
 I SPFCP=2 D
 . S PRCHN("SFC")=SPFCP,ACCT=$$ACCT^PRCPUX1($E($$NSN^PRCPUX1(PRCHIDA),1,4))
 . D  ;:$D(ACCT)
 .  .  S PRCHBOCC=$P($G(^PRCD(420.2,$S(ACCT=1:2697,ACCT=2:2698,ACCT=3:2699,ACCT=6:2699,ACCT=8:2696,1:2699),0)),U)
 .  .  I PRCHBOCC S $P(^PRC(442,DA(1),2,DA,0),U,4)=PRCHBOCC D
 .  .  .  I PRCHBOCC'=X,PRCHBOCC W:'$G(QUIETLY) !,?5,"BOC must be ",PRCHBOCC,!,?5,"For a supply fund order, a BOC ",X," is invalid.",! S X=PRCHBOCC
 Q X
 ;
 ;
 ;
EN8 ;FILE 442, ITEM #40; BOC #3.5  -- Z0 must = BOC on entry
 N DIC D VEN Q:'$D(X)
 S DIC="^PRCD(420.1,"_Z0_",1,",DIC(0)="QEMZ"
 I $P(^PRC(442,DA(1),0),U,19)'=2 D
 . D ^DIC K:Y<0 X K Z0
 . I $D(X) S X=$P(Y(0,0),"^",1) D
 . . S PRCHBOC=+Y ;D EN2^PRCHNPO8
 . . W !,X
 Q
 ;
 ;
EN88 ;FILE 442, EST. SHIPPING BOC #13.05  -- Z0 must = BOC on entry
 N DIC D VENA Q:'$D(X)
 S DIC="^PRCD(420.1,"_Z0_",1,",DIC(0)="QEMZ" D ^DIC K:Y<0 X K Z0
 I $D(X) S X=$P(Y(0,0),"^",1) W !,X
 Q
 ;
EN9 ;CHECK FOR PAYMENT FIELDS AND OTHER FIELDS IN VENDOR FILE
 ;CALLED FROM FILE 442 INPUT TEMPLATES.
 ;FLAG --is set to 1 in template when certain VENDOR conditions are met
 S PRCHOV7=$G(^PRC(440,+^PRC(442,D0,1),7)) G:PRCHOV7="" EXIT
 I $P(PRCHOV7,U,3)]"",($P(PRCHOV7,U,7)]""),($P(PRCHOV7,U,8)]""),($P(PRCHOV7,U,9)]""),$P(PRCHOV3,U,11)]"",$P(PRCHOV3,U,14)]"",$P(PRCHOV3,U,13)]"",FLAG S Y="@20" G EXIT
 S VEN=+^PRC(442,D0,1),%X="^PRC(440,VEN,",%Y="^PRC(440.3,VEN," D %XY^%RCR K VEN
EXIT Q
 ;
EN12 ;UPDATE NATIONAL DRUG CODE #9.3
 D VEN Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=$P($P(^PRC(442,DA(1),0),U,1),"-",1) S PRCHCV=$P(^PRC(442,DA(1),1),U,1),PRCHCI=$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN12^PRCHCRD1
 Q
 ;
EN13 ;FILE 443.6, ITEM #40;BOC #3.5, EST. SHIPPING BOC #13.05
 D VEN1 Q:'$D(X)  S DIC="^PRCD(420.1,"_Z0_",1,",DIC(0)="QEMZ" D ^DIC K:Y<0 X K DIC,Z0 I $D(X) S X=$P(Y(0,0),"^",1) W !,X
 Q
EN133 ;FILE 443.6, EST. SHIPPING BOC #13.05
 D VEN1A Q:'$D(X)  S DIC="^PRCD(420.1,"_Z0_",1,",DIC(0)="QEMZ" D ^DIC K:Y<0 X K DIC,Z0 I $D(X) S X=$P(Y(0,0),"^",1) W !,X
 Q
