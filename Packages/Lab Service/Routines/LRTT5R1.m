LRTT5R1 ;DALISC/FHS - LAB URGENCY TURNAROUND TIMES REPORT GENERATOR ; 12/3/1997
 ;;5.2;LAB SERVICE;**153,201,274**;Sep 27, 1994
ONE ; from LRTT5
 ; input LRPQ(, ^TMP("LR",$J processed from LRTT5P1
 S LREND=0
 I $O(LRLLOC(0)) W !?10," Institution included in report:" D
 . S I=0 F  S I=$O(LRLLOC(I)) Q:I<1  W !?20,$P(LRLLOC(I),U,2)
 F LRPTYPE="REG","IRREG" D  W !
 .W !,"      Turnaround Time (TAT) - ",$S(LRPTYPE="REG":"Regular (0701-1700) ",1:"Irregular")," hours",!
 .W !,"   Number of tests                Total time             Ave TAT"
 .W !,"   ----------------------         ----------             -------"
 .W !,?12,+^TMP("LR",$J,LRPTYPE),?35,+$P(^TMP("LR",$J,LRPTYPE),U,2)," min" I +^TMP("LR",$J,LRPTYPE) W ?57,+$P(^TMP("LR",$J,LRPTYPE),U,2)\+^TMP("LR",$J,LRPTYPE)," min"
 W "Urgencies:" S LRX=0 F  S LRX=$O(LRPQ("URGENCY",LRX)) Q:LRX<1  W !?5,LRPQ("URGENCY",LRX)
 W !!,"Tests:" S LRX=0 F  S LRX=$O(^TMP("LRTT5",$J,"TESTS",LRX)) Q:LRX<1  W !?5,^(LRX)
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR S:$G(DIRUT) LREND=1 Q:LREND
CHK I 'LRPDET D CLEANUP Q
SHEAD ;S LRPDHEAD="Test               Number of Tests   Total TAT       Ave TAT",LRPPAGE=0 D DHDR^LRTT5
 ;F LRPTYPE="REGT","IRREGT" Q:$G(LREND)  D
 ;. D LNCHECK^LRTT5 Q:$G(LREND)  W !,$S(LRPTYPE="REGT":"Regular",1:"Irregular")," hours" S LRTEST="" F  S LRTEST=$O(^TMP("LR",$J,LRPTYPE,LRTEST)) Q:LRTEST=""!($G(LREND))  S LRX=^(LRTEST) D
 ;. . D LNCHECK^LRTT5 Q:$G(LREND)  W !,LRTEST,?25,$J(+LRX,9,0),?37,$J(+$P(LRX,U,2),9,0) I +LRX W ?50,$J($P(LRX,U,2)/+LRX,9,1)
 ;I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR S:$G(DIRUT) LREND=1 Q:LREND
 S LRPDHEAD="TAT       Acc           Test               In                  Out" D DHDR^LRTT5 Q:$G(LREND)
TYPE F LRPDTYPE="BAD","REG","IRREG" Q:$G(LREND)  D
 .D LNCHECK^LRTT5 Q:$G(LREND)  W !!,$S(LRPDTYPE="BAD":"Tests not counted:",LRPDTYPE="REG":"Regular hours:",1:"Irregular hours:"),!
 .S LRPCNT=0,LRPDIFF="" F  S LRPDIFF=$O(^TMP("LR",$J,LRPDTYPE,LRPDIFF)) Q:LRPDIFF=""  D
 . . S LRPN="" F  S LRPN=$O(^TMP("LR",$J,LRPDTYPE,LRPDIFF,LRPN)) Q:LRPN=""  S LRPLINE=^(LRPN),LRPCNT=LRPCNT+1 D
 . . . D LNCHECK^LRTT5 Q:$G(LREND)
 . . . W ! W:$L($P(LRPLINE,U,4)) LRPDIFF W ?6,$P(LRPLINE,U),?21,$E($P(LRPLINE,U,2),1,15),?37,$$FMTE^XLFDT($E($P(LRPLINE,U,3),1,12)) I $L($P(LRPLINE,U,4)) W ?58,$$FMTE^XLFDT($E($P(LRPLINE,U,4),1,12))
 .I 'LRPCNT W !,"none found",!
 I $E(IOST,1,2)="C-" K DIR S DIR(0)="E" D ^DIR S:$G(DIRUT) LREND=1 Q:LREND
 D CLEANUP
 Q
CLEANUP ;
STOP K ^TMP("LR",$J),LRPCNT,LRPDET,LRPDHEAD,LRPDIFF,LRPDTYPE,LRPLINE,LRPN,LRPPAGE,LRPQ,LRTEST,LRPTYPE,LRX
 Q
