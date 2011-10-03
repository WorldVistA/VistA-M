SPNAHOC4 ;HISC/DAD-AD HOC REPORTS: MACRO OUTPUT ; [ 02/21/95  4:02 PM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;
EN1 ; *** Set the output macro flag
 S SPNMOUTP=1
 W !!?3,"You will be prompted for an output"
 W !?3,"device when you exit the ",SPNTYPE(0)," menu. ",$C(7)
 R SP:SPNDTIME
 Q
EN2 ; *** Print the macro report
 K %ZIS,IOP S %ZIS="QM",%ZIS("A")="   Output macro to device: "
 W ! D ^%ZIS G:POP EXIT I $D(IO("Q")) K IO("Q") D QVAR,^%ZTLOAD G EXIT
ENTSK S SPNEXIT=0
 U IO W:$E(IOST)="C" @IOF
 W !?19,"=========================================="
 W !?19,"|| AD HOC REPORT GENERATOR MACRO REPORT ||"
 W !?19,"=========================================="
 W !!!,"Report name: ",$E(SPNUNDL,1,67)
 F SPNTYP="S","P" Q:SPNEXIT  D
 . W !!,$S(SPNTYP="S":"Sort",1:"Print")," fields:"
 . W !,$E("-------------",1,13-(SPNTYP="S")),!!,"Macro: "
 . S X=$P($G(SPNMACRO(SPNTYP)),U,2) W $S(X]"":X,1:$E(SPNUNDL,1,73))
 . F SPNORDER=1:1:SPNMAXOP(SPNTYP) Q:SPNEXIT  D
 .. S SPNFIELD=$O(SPNOPTN(SPNTYP,SPNORDER,""))
 .. S X=$G(SPNOPTN(SPNTYP,SPNORDER,+SPNFIELD))
 .. S X(1)=$P(X,";"),X(1)=$TR(X(1),$TR(X(1),"+-&!@'#"))
 .. S X(1)=X(1)_SPNFIELD_$S($P(X,";")]"":";"_$P(X,";",2,99),1:"")
 .. I SPNTYP="S" D
 ... S X=$G(FR(SPNORDER)),X(2)=$S(X]"":X,X(1)]"":"Beginning",1:"")
 ... S X=$G(TO(SPNORDER)),X(3)=$S(X]"":X,X(1)]"":"Ending",1:"")
 ... Q
 .. I $D(SPNMACRO(SPNTYP)),X(1)]"" D
 ... S SPND1=0 F SP=$L(X(1),";"):-1:1 D  Q:SPND1
 .... S SPND1=$O(^SPNL(154.8,+SPNMACRO(SPNTYP),"FLD","B",$P(X(1),";",1,SP),0))
 .... Q
 ... I SPND1 D
 .... S SP=$G(^SPNL(154.8,+SPNMACRO(SPNTYP),"FLD",SPND1,0)),SPN=$G(^("FRTO"))
 .... S X(1)=$P(SP,U)
 .... I SPNTYP="S" F SPI=1,2 S X(SPI+1)=$S($P(SP,U,3):"Ask User",$P(SPN,U,SPI)]"":$E($P(SPN,U,SPI),1,30),SPI=1:"Beginning",1:"Ending")
 .... Q
 ... Q
 .. W ! D PRNTFLD
 .. Q
 . D PAUSE
 . Q
 G:SPNEXIT EXIT
 W ! D PRNTHDR(+$G(SPNMACRO("P")))
 W ! D SORTHDR(+$G(SPNMACRO("S")))
 W ?46,"Device: ",$E(SPNUNDL,1,26)
 W:$E(IOST)'="C" @IOF
EXIT ; *** Exit the macro report
 D ^%ZISC S SPNMOUTP=0
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
PRNTFLD ; *** Inquire macro entry point
 S SP=$G(SPNMENU(+SPNFIELD))
 S SP=$S((SPNTYP="S")&(SP'>0):"",1:$P(SP,U,2))
 W !?3,SPNORDER,") Field: "
 W $S(SP]"":SP,SPNFIELD?1.N:"*** CORRUPTED ***",1:$E(SPNUNDL,1,30))
 W !?6,"Entry: ",$S(X(1)]"":X(1),1:$E(SPNUNDL,1,30))
 I SPNTYP="S" D
 . W !?6,"From:  ",$E($S(X(2)]"":X(2),1:SPNUNDL),1,30)
 . W ?46,"To: ",$E($S(X(3)]"":X(3),1:SPNUNDL),1,30)
 . Q
 Q
PRNTHDR(Y) ; *** Print DHD header
 W !,"Header: ",$P($$DHD(Y),U,2)
 Q
SORTHDR(Y) ; *** Print DIPCRIT header
 W !,"Sort criteria in report header: ",$P($$DIPCRIT(Y),U,2)
 Q
DHD(Y) ; *** Get Header
 N X S X=$P($G(^SPNL(154.8,+Y,0)),U,6)
 Q X_U_$S(X]"":X,1:$E(SPNUNDL,1,72))
DIPCRIT(Y) ; *** Get DIPCRIT
 N X S X=$P($G(^SPNL(154.8,+Y,0)),U,5),X=$S(X=0:2,X=1:1,1:0)
 Q X_U_$S(X=1:"Yes",X=2:"No",1:"( Y / N )")
PAUSE ; *** Pause at the end of page
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR K DIR S SPNEXIT=$S(Y'>0:1,1:0)
 Q
QVAR ; *** Save variables for queueing
 S ZTRTN="ENTSK^SPNAHOC4",ZTDESC="Ad Hoc Report Generator Macro Report"
 F SP="FR(","SPNMAXOP(","SPNMENU(","SPNOPTN(","SPNTEMP","SPNMACRO(","TO(","SPNUNDL" S ZTSAVE(SP)=""
 Q
