PRCH1D ;WISC/PLT-REMOVE PURCHASE CARD RECONCILIATION ;7/19/96  09:02
V ;;5.1;IFCAP;**117**;Oct 20, 2000;Build 2
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;remove reconcile purchase card order
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,PRCDUZ,PRC,PRCC,PRCE,PRCF,PRCG,PRCVAL,PRCCP,PRCR,PRCSST,PRCSTC,PRCEDRM
 N PRCSELF,PRCCN,PRCCNT,PCN
 N A,B,C
Q1 ;station
 S PRCSST=1 D STA^PRCSUT S PRCSTC=SI G:$G(PRC("SITE"))=""!(Y<0)!(PRCSTC<1) EXIT
 S PRCRI(420)=+PRC("SITE")
 S PRCSELF=1 I $D(^PRC(440.5,"MAA",DUZ)) D  G EXIT:X=""!(X["^") S PRCSELF=Y
 . D YN^PRC0A(.X,.Y,"Edit/Remove Reconciliation for your own purchase card orders","O","")
 . QUIT
 S PRCCN="" I PRCSELF=1 S PRCDUZ=DUZ G Q3
Q21 S X("S")="I $P(^(2),U,3)=PRC(""SITE""),$P(^(0),U,9)=DUZ!($P(^(0),U,10)=DUZ)"
 S X("W")="W ""    "",$P(^(0),U,11),""    "" W:$P(^(0),U,8) $P($G(^VA(200,$P(^(0),U,8),0)),U)"
 D LOOKUP^PRC0B(.X,.Y,"440.5;^PRC(440.5,;","AEMOQS~~G^MAA^H^D","Select Purchase Credit Card/Holder: ")
 I X["^"!(X="")!(Y<1) G Q1
 S PRCRI(440.5)=+Y,PRCDUZ=$P(^PRC(440.5,PRCRI(440.5),0),U,8),PRCCN=$P(^(0),U)
Q3 ;select oracle cc-record
 K DIRUT,PCSTAT
 S X("S")="I ""RD""[$P(^(0),U,16),$P(^(0),U,8)=PRC(""SITE""),$P(^(0),U,4)=PRCCN&'PRCSELF!($P(^(0),U,17)="_PRCDUZ_"&PRCSELF)"
 S X("W")="W:$X>20 ! W $P(^(0),U,1),""   "",$E($P(^(0),U,9),4,5)_""-""_$E($P(^(0),U,9),6,7)_""-""_$E($P(^(0),U,9),2,3),""  $"",$J($P(^(0),U,14),0,2) W:$D(^(6)) ""   "",$P(^(6),U,1)"
 W ! D LOOKUP^PRC0B(.X,.Y,"440.6;^PRCH(440.6,;","AEMOQS~~","Select Reconciled/Disputed C-Document/Purchase Card Order: ")
 I Y<0!(X="") G EXIT
 K X S PRCRI(440.6)=+Y,PRCRI(442)=$P($G(^PRCH(440.6,PRCRI(440.6),1)),"^",1),PCSTAT=$P($G(^PRCH(440.6,PRCRI(440.6),0)),"^",16)
 I 'PRCRI(442) D EN^DDIOL("Not reconciled yet.") G Q3
 ;
 ;if the charge has been reconciled warn user before starting any changes
 I $D(PRCRI(442)),$G(PCSTAT)="R"!($G(PCSTAT)="D") D  G:X="NO"!(X["^")!(X="") Q3
 . W $C(7),!!,?25,"**** WARNING ****"
 . S DIR("A",1)=""
 . S DIR("A",2)="This charge is reconciled. If you 'Edit' it, another approval will be needed."
 . S DIR("A",3)="If you 'Remove' the reconciliation, you must reconcile the charge and your "
 . S DIR("A",4)="Approving Official will have to approve it again."
 . S DIR("A",5)=""
 . S DIR("A",6)="Use the action code DD (Display Document) if no change is desired."
 . S DIR("A",7)=""
 . S DIR("A")="Do you want to continue"
 . S DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR Q:$D(DIRUT)
 D ACT
 G Q3
 ;
 ;
EXIT QUIT
ACT S PRCE=^PRC(442,PRCRI(442),0),PRCCP=$P($G(^(23)),"^",16),PRCR=$P($G(^(23)),"^",15) S:PRCR="" PRCR="N"
 S X(1)=$TR($J("",79)," ","_")
 S X(2)="   Action Code: ED: Edit        DO: Display Order    ND: Next Document",X(3)="                RM: Remove      DD: Display Document"
 S Y(1)="Enter an action code"
 D FT^PRC0A(.X,.Y,"Action","","")
 I X["^"!(X="") QUIT
 S Y=$$LU
 I Y="ND" QUIT
 I Y="DO" D  G ACT
 . N D0 S D0=PRCRI(442) D ^PRCHDP1
 . QUIT
 I Y="DD" D DD G ACT
 S PRCEDRM="" I Y="ED" S PRCEDRM=1 D RC^PRCH1A1 QUIT
 I Y'="RM" D EN^DDIOL("Invalid Action code, try again") G ACT
 ;remove conciliation
 S PRCA=^PRCH(440.6,PRCRI(440.6),0),PRCB=$G(^(1))
 D E20,ET
 S PRCA=^PRCH(440.6,PRCRI(440.6),0),PRCB=$G(^(1))
 S PRCRI(410)=$P(^PRC(442,PRCRI(442),0),"^",12)
 D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"44///N;15////N;45///@")
 D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"18///@;19///@;46///@;41///@;42///@")
 ;if final payment entry removed
 I $P(PRCB,"^",4)="Y" D
 . S PRCST=$P(PRCA,"^",20) D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"58///@;44///@;.5///"_PRCST)
 . I PRCRI(410) D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"27////"_$P(PRCA,"^",19))
 . S PRCRI=0 F  S PRCRI=$O(^PRC(442,PRCRI(442),13,PRCRI)) QUIT:'PRCRI  D:PRCRI ERS410^PRC0G(PRCRI_"^A")
 . QUIT
 S PRCC=$$FP^PRCH0A(PRCRI(442))
 ;if last payment entry removed
 I $P(PRCC,"^",2)="" S PRCST=$P(PRCA,"^",20) D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"58///@;44///@;.5///"_PRCST) G Q9
 ;if not last payment entry removed
 D:PRCRI(410)&PRCC
 . N A,B
 . S A=0,B=0 F  S A=$O(^PRCH(440.6,"PO",PRCRI(442),A)) QUIT:'A  S B=B+$P(^PRCH(440.6,A,0),"^",14)
 . D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"27////"_B)
 . QUIT
Q9 ;prompt status
 K X
 S X=+^PRC(442,PRCRI(442),7) S:X=40!(X=71) X=95 S X("B")=$P(^PRCD(442.3,X,0),"^")
 S PRCVAL=",22,27,25,30,24,32,37,39,46,48,50,"
 S:$O(^PRC(442,PRCRI(442),6,0)) PRCVAL=",22,27,25,26,30,31,23,24,29,32,34,37,38,39,44,46,47,48,49,50,51,"
 S X("S")="N A S A=$P(^PRCD(442.3,+Y,0),U,2) I PRCVAL[("",""_A_"","")"
 D LOOKUP^PRC0B(.X,.Y,"442.3;^PRCD(442.3,","AEMQ","AFTER Removing Change P.O. Status to: ")
 I Y<0!(X="") D EN^DDIOL("The purchase card order status is required") G Q9
 S PRCST=$P(^PRCD(442.3,+Y,0),"^",2)
 D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),".5///"_PRCST)
 K PCN QUIT
 ;
E20 D EDIT^PRC0B(.X,"442;^PRC(442,;"_PRCRI(442),"20")
 QUIT
 ;
ET S A=$$DDA4406^PRCH0A(PRCRI(440.6)),B=$$DDA442^PRCH0A(PRCRI(442)),$P(B,"^",17)="",PRCBOC=$P(B,"^",21),$P(B,"^",33)=$P(A,"^",33)
 I A'=B D
 . I $E(PRCA,13,15)>490 D EN^DDIOL("Enter ET-Document by FMS-ON LINE!") QUIT
 . D EN^DDIOL("Generating ET-document to FMS...")
 . D ET^PRCH8A(.X,PRCRI(440.6)_"^"_PRCRI(442)_"^2^"_PRCBOC,"")
 . I X D EDIT^PRC0B(.X,"440.6;^PRCH(440.6,;"_PRCRI(440.6),"17////"_$P(X,"^"))
 . QUIT
 QUIT
 ;
 ;
DD ;dispaly document
 N A
 D PIECE^PRC0B("440.6;^PRC(440.6,;"_PRCRI(440.6),".01;8;13;31;44","E","A")
 W !,"Reconcile Doc: ",$G(A(440.6,PRCRI(440.6),.01,"E")),?32,"Purchase Date: ",$G(A(440.6,PRCRI(440.6),8,"E")),?60,"$Amount: ",$J($G(A(440.6,PRCRI(440.6),13,"E")),0,2)
 W !,"Final Payment: ",$G(A(440.6,PRCRI(440.6),44,"E"))
 W !,"Vendor Name: ",$G(A(440.6,PRCRI(440.6),31,"E"))
 QUIT
 ;
LU() ;lower to upper
 QUIT $TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
