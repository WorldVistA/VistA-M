EASMTRP2 ; ALB/SCK - MEANS TEST REPORTS 2 ; 2/19/02
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,15,22**;MAR 15,2001
 ;
QUE ; Que pending letter count (letters flagged to print)
 N ZTSAVE,DIR,EASUM,Y
 ;
 S DIR(0)="YAO",DIR("A")="Print Summary Only? ",DIR("B")="YES"
 S DIR("?")="'YES' will print a summary total only, 'NO' will print the summary and a detail listing by scheduled print date"
 D ^DIR K DIR
 Q:$D(DIRUT)
 S EASUM=+Y
 S ZTSAVE("EASUM")=""
 D EN^XUTMDEVQ("PEND^EASMTRP2","EAS LETTERS DETAILED PENDING REPORT",.ZTSAVE)
 Q
PEND ; Print report
 N CNT,EASIEN,PCNT,RCNT,EASX,TOT,PAGE,EAS0,EAS4,EAS6,EASPDT,EAX,TOTALS,DUOUT
 ;
 K ^TMP("EASPND",$J)
 F EAX=0,30,60 S TOTALS(EAX)=0
 S EASIEN=0
 F  S EASIEN=$O(^EAS(713.2,"AC",0,EASIEN)) Q:'EASIEN  D
 . I $P($G(^EAS(713.2,EASIEN,"Z")),U,2) D  Q
 . . S EAS0=$P($G(^EAS(713.2,EASIEN,"Z")),U,1)
 . . S ^TMP("EASPND",$J,EAS0,0)=$G(^TMP("EASPND",$J,EAS0,0))+1
 . . S TOTALS(0)=TOTALS(0)+1
 . ;
 . I $P($G(^EAS(713.2,EASIEN,4)),U,2) D  Q
 . . S EAS4=$P($G(^EAS(713.2,EASIEN,4)),U,1)
 . . S ^TMP("EASPND",$J,EAS4,4)=$G(^TMP("EASPND",$J,EAS4,4))+1
 . . S TOTALS(30)=TOTALS(30)+1
 . ;
 . I $P($G(^EAS(713.2,EASIEN,6)),U,2) D
 . . S EAS6=$P($G(^EAS(713.2,EASIEN,6)),U,1)
 . . S ^TMP("EASPND",$J,EAS6,6)=$G(^TMP("EASPND",$J,EAS6,6))+1
 . . S TOTALS(60)=TOTALS(60)+1
 ;
 D HDR1
 I 'EASUM,$E(IOST,1,2)="C-" D  Q:$D(DUOUT)
 . S DIR(0)="FAO",DIR("A")="Press any key to continue..."
 . D ^DIR K DIR
 . Q:$D(DUOUT)
 ;
 D:'EASUM DETAIL
 Q
 ;
DETAIL ; Print details section
 N EASPDT,DIRUT
 ;
 D HDR
 S EASPDT=0
 F  S EASPDT=$O(^TMP("EASPND",$J,EASPDT)) Q:'EASPDT  D  Q:$D(DIRUT)
 . I ($Y+4)>IOSL D  Q:$D(DIRUT)
 . . I $E(IOST,1,2)="C-" D  Q:$D(DIRUT)
 . . . S DIR(0)="E"
 . . . D ^DIR K DIR
 . . D HDR
 . W !?4,$$FMTE^XLFDT(EASPDT),?20
 . S TOT=0
 . F EAX=6,4,0 D
 . . S CNT=$G(^TMP("EASPND",$J,EASPDT,EAX))
 . . W $J(+CNT,6),"    "
 . . S TOT=$G(TOT)+(+CNT)
 . W $J(TOT,8)
 ;
 K ^TMP("EASPND",$J)
 Q
 ;
HDR1 ;
 N TAB,LINE,DASH
 ;
 W @IOF
 S LINE(1)="Count of Letters Pending to Print (Flag to Print marked 'YES')"
 S LINE(2)="Printed: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S LINE(60)="60-Day letters flagged to print:    "_$FN(TOTALS(60),",")
 S LINE(30)="30-Day letters flagged to print:    "_$FN(TOTALS(30),",")
 S LINE(0)=" 0-Day letters flagged to print:    "_$FN(TOTALS(0),",")
 ;
 S TAB=(IOM-$L(LINE(1)))/2
 W !?TAB,LINE(1)
 W !?TAB,LINE(2)
 S $P(DASH,"=",IOM)=""
 W !,DASH
 ;
 F EAX=60,30,0 D
 . S TAB=(IOM-$L(LINE(EAX)))/2
 . W !?TAB,LINE(EAX)
 Q
 ;
HDR ;
 N TAB,LINE
 ;
 W @IOF
 W !,"Detailed List of Letters Flagged to Print"
 W !,"Printed: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S PAGE=$G(PAGE)+1
 S TAB=IOM-8
 W ?TAB,"PAGE: ",PAGE
 W !!?4,"Sched. Date",?20,"60-Day","    ","30-Day","    "," 0-day","    ","   TOTAL"
 S $P(LINE,"=",IOM)="" W !,LINE
 Q
