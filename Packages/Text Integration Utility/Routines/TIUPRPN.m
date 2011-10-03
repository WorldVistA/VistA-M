TIUPRPN ;SLC/MJC - Print SF 509 Progress Notes ;;7-6-95 9:00pm
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ; Writes SF 509- Progress Note to screen or paper.
DEVICE(TIUFLAG,TIUSPG) ; pick your device
 ;
 W ! K IOP S %ZIS="Q" D ^%ZIS I POP K POP G EXIT
 S TIUFLAG=+$G(TIUFLAG),TIUSPG=+$G(TIUSPG)
 I $D(IO("Q")) K IO("Q") D  G EXIT
 .S ZTRTN="ENTRY1^TIUPRPN",ZTSAVE("^TMP(""TIUPR"",$J,")=""
 .S ZTSAVE("TIUFLAG")="",ZTSAVE("TIUSPG")="",ZTDESC="TIU PRT PNS"
 .D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,TIUFLAG,TIUSPG
 .D HOME^%ZIS
 U IO D ENTRY1,^%ZISC
 Q
ENTRY ; Entry point to print progress notes-called from ^TIUA
 N TIUSPG
 U IO
ENTRY1 ; Entry point from above
 N TIUERR,D0,DN,Y,DTOUT,DUOUT,DIRUT,DIROUT
 I $E(IOST)="C" S (TIUSPG,TIUFLAG)=1
 I '+$G(TIUFLAG) S TIUSPG=1
 K ^TMP("TIULQ",$J)
 I $D(ZTQUEUED) S ZTREQ="@" ; Tell TaskMan to delete Task log entry
 D PRINT^TIUPRPN1($G(TIUFLAG),$G(TIUSPG))
EXIT K ^TMP("TIULQ",$J),^TMP("TIUPR",$J)
 Q
