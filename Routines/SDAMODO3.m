SDAMODO3 ;ALB/SCK - PROVIDER DIAGNOSTICS REPORT OUTPUT ; 05 Oct 98  8:44 PM
 ;;5.3;Scheduling;**11,25,46,49,159,529**;Aug 13, 1993;Build 3
 Q
REPORT ;
 I '$D(^TMP("SDRPT",$J)) D NOREP G EXIT
START ;
 N SDIV,OEN,SDPRX,SUB1,SUB2,OEN,SDATA,SDX,SPRV,SDCHECK
 S (SDIV,SDFIN,SDVC,SUBX,SUB1,SUB2)="",(PAGE,QFLAG,SUBCNT)=0
 W:$E(IOST,1,2)="C-" @IOF
 F  S SDIV=$O(^TMP("SDRPT",$J,SDIV)) Q:SDIV=""  D  Q:SDFIN
 . I SDIV'=SDVC S SUBX=$$SUBCNT(SUB1,SUBX),SDFIN='$$HDR(SDIV) Q:SDFIN  S SDVC=SDIV
 . S SUB1="" F  S SUB1=$O(^TMP("SDRPT",$J,SDIV,SUB1)) Q:SUB1=""  D  Q:SDFIN
 .. I SUBX'=SUB1 S SUBX=$$SUBCNT(SUB1,SUBX)
 .. I SORT1=4!(SORT1=5) I SUBX]"",SUBX'=SUB1 S SDFIN='$$HDR(SDIV)
 .. S SUB2="" F  S SUB2=$O(^TMP("SDRPT",$J,SDIV,SUB1,SUB2)) Q:SUB2=""  D  Q:SDFIN
 ... S OEN=0 F  S OEN=$O(^TMP("SDRPT",$J,SDIV,SUB1,SUB2,OEN)) Q:'OEN  S SUBCNT=SUBCNT+1,SDCHECK="" D  Q:SDFIN
 .... S I=0 F  S I=$O(^TMP("SDRPT",$J,SDIV,SUB1,SUB2,OEN,I)) Q:'I  S SDFIN='$$PRNT(I) Q:SDFIN
 S SUBX=$$SUBCNT(SUB1,SUBX)
EXIT ;
 K QFLAG,PAGE,SDFIN,SDVC,SDONE,XX,^TMP("SDRPT",$J),SUBCNT,SUBX
 Q
 ;
SUBCNT(SB1,SB1P) ;
 I SB1P']""!(SUBCNT'>0) G SUBCNTQ
 W !,SUBCNT," ",$S(SORT2=1!(SORT2=2):"Primary "_$P($T(SORT+SORT2^SDAMODO1),";;",2),1:$P($T(SORT+SORT2^SDAMODO1),";;",2))," entries for ",$S(SORT1=1!(SORT1=3):$P(SB1P,"^"),SORT1=5:$P($G(^DIC(40.7,SB1P,0)),U),1:SB1P),!!
 S SUBCNT=0
SUBCNTQ Q (SB1)
 ;
PRNT(I) ;
 N Y,SDATA,SPRV,SDX,XX,SCODE,SDDX1,SDPRX,SDSID
 S SDATA=(^TMP("SDRPT",$J,SDIV,SUB1,SUB2,OEN,I,0))
 S XX="" F  S XX=$O(^TMP("SDRPT",$J,SDIV,SUB1,SUB2,OEN,I,"PRV",XX)) Q:'XX  S SPRV(XX)=""
 S XX="" F  S XX=$O(^TMP("SDRPT",$J,SDIV,SUB1,SUB2,OEN,I,"DX",XX)) Q:XX=""  S SDX(XX)=""
 I SORT1=1,'$$SELPRV(SUB1) S Y=1 G PRNTQ
 I SORT1=2,'$$SELDX(SUB1) S Y=1 G PRNTQ
 I $Y+5>IOSL  S Y='$$HDR(SDIV) G:Y PRNTQ
LINE1 ;
 S SDSID=$P($G(SDATA),U,2)
 W !,$P(^DPT($P($G(SDATA),U),0),U)_" "_$P(SDSID,"-",3)
 S:SDCHECK="" SDCHECK=SDSID I SDSID'=SDCHECK S SUBCNT=SUBCNT+1
 W ?32,$P($$FMTE^XLFDT(OEN,1),":",1,2) ; modified to drop seconds
 W ?55,$E($P(SDATA,U,3),1,25)
 W ?90,$S(+$P(SDATA,U,5)>0:$P(^VA(200,+$P(SDATA,U,5),0),U),1:$P(SDATA,U,5))
 W ?117,$P(SDATA,U,6)
LINE2 ;
 S SCODE=$P(SDATA,U,4)
 W !?56,$P($G(^DIC(40.7,+SCODE,0)),U,2),"/",$P($G(^DIC(40.7,+SCODE,0)),U)
 S SDPRX="",SDPRX=$O(SPRV(SDPRX)) I $D(SDPRX),SORT1'=1 W ?90,$S(+SDPRX>0:$P(^VA(200,SDPRX,0),U),1:"")
 S SDDX1="",SDDX1=$O(SDX(SDDX1)) I $D(SDDX1),SORT1'=2 W ?117,SDDX1
 S SDONE=0
 F XX=1:1 D  Q:SDONE
 . I SDDX1'="" S SDDX1=$O(SDX(SDDX1))
 . I SDPRX'="" S SDPRX=$O(SPRV(SDPRX))
 . I SDPRX']""&(SDDX1']"") S SDONE=1 Q
 . I $Y+5>IOSL S SDONE='$$HDR(SDIV) Q:SDONE
 . W !
 . I $D(SDPRX),SORT1'=1 W ?90,$S(+SDPRX>0:$P(^VA(200,SDPRX,0),U),1:"")
 . I $D(SDDX1),SORT1'=2 W ?117,SDDX1
 S Y=1
PRNTQ S:QFLAG Y=0 Q (Y)
 ;
HDR(SDIV) ;
 N Y
 S Y=0
 I SDVC'="",$E(IOST,1,2)="C-" D  G:QFLAG HDRQ
 . K DIR S DIR(0)="FO",DIR("A")="Press RETURN to continue or '^' to exit"
 . S DIR("?",1)="Pressing any key other than the '^' key will scroll to the next screen",DIR("?")="The '^' key will exit the listing."
 . D ^DIR K DIR I $D(DTOUT)!($D(DUOUT)) S QFLAG=1 Q
 . W @IOF
 S PAGE=PAGE+1
 I $E(IOST,1,2)'="C-",SDVC'="" W @IOF
 W !!,"Provider/Diagnosis Encounter Report sorted by ",$P($T(SORT+SORT1^SDAMODO1),";;",2)," and ",$P($T(SORT+SORT2^SDAMODO1),";;",2)
 W ?(IOM-40),"Report Date: ",$P($$NOW^VALM1,"@"),?(IOM-10),"Page: ",PAGE
 W !,"Inclusion Dates: ",$P($$FMTE^XLFDT(SDBEG,1),"@")," to ",$P($$FMTE^XLFDT(SDEND,1),"@")
 W !,"Division: ",$P($G(^DG(40.8,SDIV,0)),U)
 W !!,"PATIENT",?32,"ENCOUNTER DATE",?55,"CLINIC/PRIMARY STOP CODE",?90,"PROVIDER",?117,"DX CODE"
 W !,"-------------------",?32,"------------------",?55,"------------------------",?90,"--------------",?117,"-------"
 S Y=1
HDRQ Q (Y)
 ;
NOREP ;
 W !!,"Provider/Diagnosis Report sorted by ",$P($T(SORT+SORT1^SDAMODO1),";;",2)," and ",$P($T(SORT+SORT2^SDAMODO1),";;",2)
 W ?(IOM-40),"Report Date: ",$P($$NOW^VALM1,"@")
 W !,"Inclusion Dates: ",$P($$FMTE^XLFDT(SDBEG,1),"@")," to ",$P($$FMTE^XLFDT(SDEND,1),"@")
 W !!,"No data found matching sort parameters"
 Q
 ;
SELPRV(PRV) ;
 N Y S Y=1
 I PROVDR=1 G SELPRVQ
 I $D(PROVDR($P(PRV,"^",2))) G SELPRVQ
 S Y=0
SELPRVQ Q (Y)
 ;
SELDX(DX) ;
 N Y S Y=1
 I PDIAG=1 G SELDXQ
 S DIC="^ICD9(",DIC(0)="XMS",X=DX_" "  ;SD/529
 D ^DIC K DIC I Y<0 S Y=0 G SELDXQ
 I $D(PDIAG($P(Y,U))) G SELDXQ
 S Y=0
SELDXQ Q (Y)
