DGPREP3 ;ALB/SCK - Pre-Registration calling statistics ; 1/2/97
 ;;5.3;Registration;**109**;Aug 13, 1993
 Q
 ;
EN ;  Main entry point for pre-registration calling statistics
 N X1,DIR,DGPBEG,DGPEND,DGPDSH,DGPN1,DGPDATA,VAUTD,DGPN2,DGPTOT,DGPE,DGPABRT,DGSNGLDV
 ;
 K DUOUT,DIRUT,^TMP("DGPRERPT",$J)
 S DIR(0)="DA^::EX"
 S X1=$P($$NOW^XLFDT,".")
 S DIR("?",1)="Enter the beginning or ending date in an acceptable format"
 S DIR("?")="The ending date cannot be before the beginning date."
 S DIR("B")=$$FMTE^XLFDT(X1,1)
 S DIR("A")="Enter beginning date for report: "
 D ^DIR
 I $D(DIRUT) G EXIT
 S DGPBEG=Y
AGN S DIR("A")="Enter ending date for report: "
 D ^DIR
 I $D(DIRUT) G EXIT
 S DGPEND=Y
 I DGPEND<DGPBEG D  G AGN
 . W !,"The ending date for this report cannot be earlier then the beginning date"
 K DIR
 ;
 ; *** Select division
 I $P($G(^DG(43,1,"GL")),U,2) D
 . D DIVISION^VAUTOMA
 E  D
 . S DGSNGLDV=1
 . S VAUTD=1
 ;
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="RPT^DGPREP3",ZTDESC="DISPLAY PRE-REG CALLING STATS"
 . N ZTX
 . F ZTX="DGPBEG","DGPEND","VAUTD(","VAUTD","DGSNGLDV" S ZTSAVE(ZTX)=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"TASK #: ",ZTSK
 . D HOME^%ZIS
 . K IO("Q"),ZTSK,ZTDESC,ZTRTN,ZTSAVE
 ;
 D WAIT^DICD
RPT ;  Build report data array
 U IO
 K ^TMP($J)
 S $P(DGPDSH,"=",70)=""
 S DGPTOT=0
 ;
 S DGPE=DGPEND+.9999
 S DGPN1=DGPBEG-.1 F  S DGPN1=$O(^DGS(41.43,"B",DGPN1)) Q:'DGPN1!(DGPN1>DGPE)  D
 . S DGPN2=0 F  S DGPN2=$O(^DGS(41.43,"B",DGPN1,DGPN2)) Q:'DGPN2  D
 .. S DGPDATA=$G(^DGS(41.43,DGPN2,0))
 .. I +$P(DGPDATA,U,5)'>0 D
 ... I $G(DGSNGLDV) S $P(DGPDATA,U,5)=$S($D(^DG(40.8,1)):1,1:0) Q
 ... S $P(DGPDATA,U,5)="NO DIV"
 .. I VAUTD=1!($D(VAUTD($P(DGPDATA,U,5)))) D
 ... S DGPTOT=DGPTOT+1
 ... I $P(DGPDATA,U,4)']"" S ^TMP("DGPRERPT",$J,$P(DGPDATA,U,5),"NONE")=$G(^TMP("DGPRERPT",$J,$P(DGPDATA,U,5),"NONE"))+1 Q
 ... S ^TMP("DGPRERPT",$J,$P(DGPDATA,U,5),$P(DGPDATA,U,4))=$G(^TMP("DGPRERPT",$J,$P(DGPDATA,U,5),$P(DGPDATA,U,4)))+1
 ;
 D PRNT
 ;
EXIT ;
 D:'$D(ZTQUEUED) ^%ZISC
 K ^TMP("DGPERPT",$J),POP,ZTQUEUED
 Q
 ;
PRNT ;  Print report to selected device
 N DGPDV,SBTOT,SB1,PAGE
 ;
 S PAGE=0
 I '$D(^TMP("DGPRERPT",$J)) D  G EXIT
 . S DGPDV=""
 . D HDR
 . W !!?10,"No data available"
 ;
 S DGPDV="" F  S DGPDV=$O(^TMP("DGPRERPT",$J,DGPDV)) Q:DGPDV']""  D  G:$G(DGPABRT) EXIT
 . D HDR Q:$G(DGPABRT)
 . S SBTOT=0
 . W !?10,"               BUSY: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"B")),5)
 . W !?10,"          CONNECTED: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"C")),5)
 . W !?10,"              DEATH: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"D")),5)
 . W !?10,"         DON'T CALL: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"T")),5)
 . W !?10,"          NO ANSWER: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"N")),5)
 . W !?10,"           NO PHONE: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"P")),5)
 . W !?10,"      UNCOOPERATIVE: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"U")),5)
 . W !?10,"       WRONG NUMBER: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"W")),5)
 . W !?10,"LEFT A CALLBACK MSG: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"M")),5)
 . W !?10," CHANGE INFORMATION: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"X")),5)
 . W !?10," PREVIOUSLY UPDATED: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"V")),5)
 . W !?10,"          CALL BACK: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"K")),5)
 . W !?10,"          NO STATUS: ",$J(+$G(^TMP("DGPRERPT",$J,DGPDV,"NONE")),5)
 . W !?10,"                        -------"
 . S SB1="" F  S SB1=$O(^TMP("DGPRERPT",$J,DGPDV,SB1)) Q:SB1']""  D
 .. S SBTOT=$G(SBTOT)++$G(^TMP("DGPRERPT",$J,DGPDV,SB1))
 . W !?10," Total for Division: ",$J(SBTOT,5)
 Q
 ;
HDR ;
 I PAGE>0,IOST?1"C-".E S DIR(0)="E" D ^DIR S DGPABRT='+$G(Y)
 G:$G(DGPABRT) HDRQ
 W @IOF
 S PAGE=PAGE+1
 W !!?5,"PRE-REGISTRATION CALL STATISTICS"
 W:DGPDV]"" !?5,"FOR",$S($G(DGSNGLDV):": ",1:" DIVISION: ")
 W $S(DGPDV="NO DIV":"NO DIVISION SPECIFIED",+DGPDV>0:$P($G(^DG(40.8,DGPDV,0)),U),1:"")
 ;
 W !?5,"FOR PERIOD COVERING "_$$FMTE^XLFDT(DGPBEG,"2D")_" TO "_$$FMTE^XLFDT(DGPEND,"2D")
 W !!?5,DGPDSH
HDRQ Q
