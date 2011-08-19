PRCH1A ;WISC/PLT-PURCHASE CARD RECONCILIATION ;8/28/98  11:46
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;reconcile purchase card order
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,PRCDUZ,PRC,PRCC,PRCE,PRCF,PRCG,PRCVAL,PRCQT,PRCSST,PRCSTC
 N PRCSELF,PRCCN,PRCCNT,PRCR
 N A,B,C
 I $G(IOSTBM)="" S X="IOSTBM" D ENDR^%ZISS I $G(IOSTBM)="" D EN^DDIOL("Wrong type terminal (missing IOSTBM)!") QUIT
 I $G(IOXY)="" D EN^DDIOL("Wrong type terminal (missing IOXY)!") QUIT
Q1 ;station
 S PRCSST=1 D STA^PRCSUT S PRCSTC=SI G:$G(PRC("SITE"))=""!(Y<0)!(PRCSTC<1) EXIT
 S PRCRI(420)=+PRC("SITE"),PRCR=$P($G(^PRC(411,PRCRI(420),9)),"^",7)
Q2 S B="O^1:Auto Charge Selection;2:Manual Charge Selection;3:Reconcile by Purchase Card Order #"
 K X,Y S Y(1)="^W ""Enter an option number 1 to 3."""
 D SC^PRC0A(.X,.Y,"Select Number",B,"")
 S A=Y K X,Y
 G EXIT:A=""!(A["^")
 S PRCOPT=+A G:PRCOPT=3 Q7
 S PRCSELF=1 I $D(^PRC(440.5,"MAA",DUZ)) D  G Q2:X=""!(X["^") S PRCSELF=Y
 . D YN^PRC0A(.X,.Y,"Reconcile for your own purchase card orders","O","")
 . QUIT
 S PRCCN="" I PRCOPT=1,PRCSELF S PRCDUZ=DUZ G AUTO
Q21 I PRCSELF S X("S")="I $P(^(2),U,3)=PRC(""SITE""),$P(^(0),U,8)=DUZ"
 E  S X("S")="I $P(^(2),U,3)=PRC(""SITE""),$P(^(0),U,9)=DUZ!($P(^(0),U,10)=DUZ)"
 S X("W")="W ""    "",$P(^(0),U,11),""    "" W:$P(^(0),U,8) $P($G(^VA(200,$P(^(0),U,8),0)),U)"
 D LOOKUP^PRC0B(.X,.Y,"440.5;^PRC(440.5,;","AEMOQS~~G^MAA^H^D","Select Purchase Credit Card/Holder: ")
 I X["^"!(X="")!(Y<1) G Q1
 S PRCRI(440.5)=+Y,PRCDUZ=$P(^PRC(440.5,PRCRI(440.5),0),U,8),PRCCN=$P(^(0),U)
 G:PRCOPT=1 AUTO
Q3 ;select oracle cc-record
 W !! D EN^DDIOL("Manual Select by Listing Unreconciled C-payment document:")
 S X("S")="I $P(^(0),U,8)=PRC(""SITE""),$P(^(0),U,4)="_PRCCN_" S:PRCCNT="""" PRCCNT=+Y S:PRCCNT-Y PRCCNT=0"
 ;
 ; Change below for NOIS CLA-0199-22457
 S X("W")="N PRCBK S $P(PRCBK,$C(8),$L(X)+4)="""" W PRCBK,""   "",$E($P(^(0),U,9),4,5)_""-""_$E($P(^(0),U,9),6,7)_""-""_$E($P(^(0),U,9),2,3),""  $"",$J($P(^(0),U,14),0,2),""   "",$P(^(0),U,21) W:$D(^(6)) ""   "",$P(^(6),U,1)"
 S X="N"_PRCDUZ_"~",PRCCNT="" D LOOKUP^PRC0B(.X,.Y,"440.6;^PRCH(440.6,;","EOQS~~ST","Select C-payment document: ")
 I Y<0!(X="") S PRCQT="^" D EN^DDIOL("MANUAL reconciliation ends") G Q2
 K X S PRCRI(440.6)=+Y
 D RECON^PRCH1A1(PRCRI(440.6),PRCR)
 I X["^"!$D(DUOUT)!PRCCNT S PRCQT="^" D EN^DDIOL("MANUAL reconciliation ends") G Q2
 G Q3
 ;
 ;
Q7 ;select purchase order
 S X("S")="I PRC(""SITE"")-^(0)=0,$P(^(0),U,2)=25,$P($G(^(23)),U,22),"",1,4,5,6,45,40,41,50,51,""'[("",""_$P($G(^(7)),U,2)_"","")"
 S X("W")="N A,B,C,D,PRCBK S $P(PRCBK,$C(8),$L(X)+4)="""",A=$G(^(0)),B=$G(^(1)),C=$G(^(7)) D DISP^PRCH1A1"
 D LOOKUP^PRC0B(.X,.Y,"442;^PRC(442,;","AEFIMQ~~B^C","Select Purchase Card Order #: ") G:X["^" Q1
 I Y<0 G Q2
 S PRCRI(442)=+Y
 D RECON^PRCH1A2(PRCRI(442),DUZ,PRCR) G Q7
 ;
AUTO ;start auto
 S PRCRI(440.6)=""
 F  S PRCRI(440.6)=$O(^PRCH(440.6,"ST","N"_PRCDUZ_"~",PRCRI(440.6))) QUIT:'PRCRI(440.6)  S A=^PRCH(440.6,PRCRI(440.6),0) I $P(A,"^",8)=PRC("SITE"),PRCSELF!($P(A,U,4)=PRCCN&'PRCSELF) D RECON^PRCH1A1(PRCRI(440.6),PRCR) QUIT:$D(DUOUT)!($G(X)["^")
 K DUOUT
 D EN^DDIOL("AUTO reconciliation ends.")
EXIT QUIT
 ;
DC(PRCA) ;diplay all charges, PRCA =IEN of file 442
 N L,DIC,FLDS,BY,FR,TO,DHD
 S DIC="^PRCH(440.6,",L=0,BY="@NUMBER",(FR,TO)=""
 S BY(0)="^PRCH(440.6,""PO"","_PRCA_",",L(0)=1
 S DHD="All Reconciled Charges for "_$P($G(^PRC(442,PRCA,0)),U)_" with AMOUNT $"_$J($P($G(^(0)),U,16),0,2)
 S PRCA=$O(^PRCH(440.6,"PO",PRCA,0))
 S FLDS=".01;""Charge Id"",8;""PO Date"",31;L30;""Vendor"",20;C5;""P.O. #"",9;""TXN Ref"",&13;C60;R15;""Reconciled $AMT"""
 I PRCA D EN1^DIP
 D EOP^PRC0A(.X,.Y,$S(PRCA:"End of All Reconciled Charge List",1:"No Reconciled Charges for This P.O. Order")_" and Hit 'Return' to Continue","","")
 QUIT
