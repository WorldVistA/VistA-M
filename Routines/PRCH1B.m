PRCH1B ;WISC/PLT-PURCHASE CARD APPROVE REONCILIATION ; 03/01/96  1:27 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;approve reconciled purchase card orders
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,PRCDUZ,PRC,PRCQT,PRCSEL,PRCSST,PRCSTC
 N A,B,C
Q1 ;station
 S PRCSST=1 D STA^PRCSUT S PRCSTC=SI G:$G(PRC("SITE"))=""!(Y<0)!(PRCSTC<1) EXIT
 S PRCRI(420)=+PRC("SITE")
Q2 S B="O^1:All Purchase Card Users;2:Single Purchase Card User"
 K X,Y S Y(1)="^W ""Enter an option number 1 to 2."""
 D SC^PRC0A(.X,.Y,"Select Number",B,"")
 S A=Y K X,Y
 G EXIT:A=""!(A["^")
 S PRCOPT=+A
 I PRCOPT=1 G AUTO
Q3 ;select purchase card user
 W !! S PRCDI="200;^VA(200,;"
 S X("S")="I Y-DUZ,$D(^PRC(440.5,""MAAH"",DUZ,+Y))"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"AEOQS","Select Purchase Card Order User: ")
 I Y<0!(X="") S PRCQT="^" G Q2
 K X S PRCRI(200)=+Y
 D USER(PRCRI(200),PRCOPT)
 D EN^DDIOL("Approving reconciliation for "_$P($G(^VA(200,PRCRI(200),0)),U)_" ends.")
 G Q3
AUTO ;start auto
 S PRCRI(200)="" F  S PRCRI(200)=$O(^PRC(440.5,"MAAH",DUZ,PRCRI(200))) QUIT:'PRCRI(200)  D:DUZ-PRCRI(200) USER(PRCRI(200),PRCOPT) QUIT:$D(DUOUT)!($G(X)["^")
 K DUOUT
 D EN^DDIOL("Approving reconciliation for all purchase card users ends.")
EXIT QUIT
 ;
USER(PRCA,PRCB) ;approve by user
 N PRCRI,PRCC,PRCD,PRCOPT,PRCUSR,PRCCNT
 N A,B,C,D,X,Y
 S PRCRI(200)=PRCA,PRCUSR=$P($G(^VA(200,PRCA,0)),U,1),PRCOPT=PRCB
RL W ! K ^TMP("PRCHAPP",$J,PRCRI(200))
 S PRCRI(442)=0,PRCCNT=0
 F  S PRCRI(442)=$O(^PRC(442,"MAPP",PRCRI(200)_"~",PRCRI(442))) QUIT:'PRCRI(442)  I ^PRC(442,PRCRI(442),0)-PRC("SITE")=0 S C=$P(^(23),"^",8) I C,$P(^PRC(440.5,C,0),"^",10)=DUZ!($P(^(0),"^",9)=DUZ) D DISP QUIT:X["^"!$D(DUOUT)
 I PRCCNT=0 G USEREXT
 S PRCSEL=""
ACT S X(1)=$TR($J("",79)," ","_")
 S X(2)="   Action Code: SL: Select    DO: Display Order             NU: Next User",X(3)="                AP: Approve   RL: Relist Reconciled Orders  DC: Display Charges"
 S Y(1)="Enter an action code"
 D FT^PRC0A(.X,.Y,"Action","",$S($G(PRCSEL)="":"SL",1:"")) QUIT:X["^"
 S Y=$$LU
 I Y="NU" QUIT
 I Y="RL" G RL
DO I Y="DO"!(Y="DC") D  G DO:Y="DO"!(Y="DC"),RL
 . N PRCOPT
 . S PRCOPT=Y
 . S E="O^1:5^",Y(1)="Enter one sequence # to display the purchase order"
 . D FT^PRC0A(.X,.Y,"Select Sequence # to Display (1-"_PRCCNT_")",E,"") QUIT:X["^"!(X="")
 . I Y'?1.N!(Y<1)!(Y>PRCCNT) D EN^DDIOL("Invalid sequence #, try again!")  S Y=PRCOPT QUIT
 . N D0 S D0=$P(^TMP("PRCHAPP",$J,PRCRI(200),+Y),"^") D ^PRCHDP1:PRCOPT="DO",DC^PRCH1A(D0):PRCOPT="DC"
 . S Y=""
 . QUIT
 I Y="AP" G APP:PRCSEL]"" D EN^DDIOL("No purchase orders selected") G ACT
 I Y'="SL" D EN^DDIOL("Invalid Action code, try again") G ACT
Q11 S PRCSEL="",E="O^1:230^",Y(1)="Enter format: 'ALL', 'E/1,3,6-9,10' for exception, or '1,3,6-9,10' to approve"
 D FT^PRC0A(.X,.Y,"Select Sequence #'s to approve (1-"_PRCCNT_")",E,"")
 G USEREXT:X=""!(X["^")
 S X=$$LU()
 S PRCSEL=X
 I X="ALL" G ACT
 I X?1"E/".E S X=$E(X,3,999)
 S Y="",C=0 F A=1:1 QUIT:$P(X,",",A,999)=""  S B=$P(X,",",A) D
 . I B?1.N,0<B,B'>PRCCNT I ","_Y_","'[(","_B_",") S C=C+1,$P(Y,",",C)=B QUIT
 . I B?1.N1"-"1.N,$P(B,"-",2)>$P(B,"-"),0<B,B'>PRCCNT,0<$P(B,"-",2),$P(B,"-",2)'>PRCCNT I ","_Y_","'[(","_B_",") S C=C+1,$P(Y,",",C)=B QUIT
 . QUIT
 I Y="" W !,"Invalid selection, try again!" G Q11
 S:PRCSEL?1"E/".E Y="E/"_Y G:PRCSEL=Y ACT
 I X'=Y W !,"Warning: Invalid entries entered in the selection." W:Y]"" !,"The valid selection is: ",!,?3,"'",Y,"'"
 S PRCSEL=Y G ACT
 ;
APP ;enter ESIG to approve
 D ESIG^PRCUESIG(DUZ,.A)
 I A=0!(A=3) D EN^DDIOL("Invalid Code Entered") G APP
 I A=-1!(A=-2) D EN^DDIOL("NOT APPROVED") G USEREXT
 I PRCSEL="ALL" D  G USEREXT
 . F PRCA=1:1:PRCCNT D APREC^PRCH1B1($P(^TMP("PRCHAPP",$J,PRCRI(200),PRCA),"^")) QUIT:X["^"!$D(DUOUT)
 . QUIT
 I PRCSEL?1"E/".E D  G USEREXT
 . S A=$E(PRCSEL,3,999) F B=1:1 QUIT:$P(A,",",B,999)=""  S C=$P(A,",",B) D
 .. I C?1.N S $P(^TMP("PRCHAPP",$J,PRCRI(200),C),"^",2)="E"
 .. I C?1.N1"-"1.N F D=+C:1:$P(C,"-",2) S $P(^TMP("PRCHAPP",$J,PRCRI(200),D),"^",2)="E"
 .. QUIT
 . F PRCA=1:1:PRCCNT D:$P(^TMP("PRCHAPP",$J,PRCRI(200),PRCA),"^",2)'="E" APREC^PRCH1B1($P(^TMP("PRCHAPP",$J,PRCRI(200),PRCA),"^")) QUIT:X["^"!$D(DUOUT)
 . QUIT
 S A=PRCSEL F B=1:1 QUIT:$P(A,",",B,999)=""  S C=$P(A,",",B) D
 . I C?1.N S $P(^TMP("PRCHAPP",$J,PRCRI(200),C),"^",2)="A"
 . I C?1.N1"-"1.N F D=+C:1:$P(C,"-",2) S $P(^TMP("PRCHAPP",$J,PRCRI(200),D),"^",2)="A"
 . QUIT
 F PRCA=1:1:PRCCNT D:$P(^TMP("PRCHAPP",$J,PRCRI(200),PRCA),"^",2)="A" APREC^PRCH1B1($P(^TMP("PRCHAPP",$J,PRCRI(200),PRCA),"^")) QUIT:X["^"!$D(DUOUT)
USEREXT K ^TMP("PRCHAPP",$J,PRCRI(200))
 QUIT
 ;
DISP ;display purchase card order
 N A,B,C,D,E
 S PRCCNT=PRCCNT+1,^TMP("PRCHAPP",$J,PRCRI(200),PRCCNT)=PRCRI(442)
 I PRCCNT=1 D EN^DDIOL("Start approving purchase card orders for "_PRCUSR),EN^DDIOL("Compiling user's reconciled purchase orders..."),EN^DDIOL("Seq#  IFCAP PO #  Vendor             $Amount    Credit Card Vendor    $Amount")
 S C="442;^PRC(442,;"_PRCRI(442)
 K A D PIECE^PRC0B(C,".01;5;92","E","A")
 S A=$G(A(442,PRCRI(442),.01,"E"))
 S C=$G(A(442,PRCRI(442),92,"E"))
 S E=$E($G(A(442,PRCRI(442),5,"E")),1,20)
 I E="SIMPLIED" S D=$O(^PRC(442,PRCRI(442),2,0)) I D S D=$O(^PRC(442,PRCRI(442),2,D,1,0)) I D S E=^(D,0)
 S B=$$FP^PRCH0A(PRCRI(442))
 W !,$J(PRCCNT,4),"  ",$P(A,U),?18,$E(E,1,20),?36,$J(C,8,2),?48,$E($P(B,"^",4),1,20),?69,$J($P(B,"^",2),8,2),$S($P(B,"^",2)-C:"*",1:"")
 K A
 S X="" I PRCCNT#20=0 S E="O^1:5^",Y(1)="Enter 'RETURN' to continue for listing or '^' to quit for selection." D FT^PRC0A(.X,.Y,"Hit 'RETURN' to continue for listing or '^' to quit for selection",E,"")
 QUIT
 ;
LU() ;EV - low to upper
 QUIT $TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
