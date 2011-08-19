LRCAP64S ;DALISC/FHS - SEARCH 64 FOR CODES
 ;;5.2;LAB SERVICE;**258,369**;Sep 27, 1994;Build 2
EN ;
 K DA,DIR,LRCPT,LRAN,LRANS,LRCODE,LRN,Y,X,LRX,LRIEN,%ZIS
 K ^TMP("LROUT",$J)
 S DIR("A")="Select the code type"
 S DIR("?",1)="Indicate what code you want to find in the"
 S DIR("?")="CODE field of the WKLD CODE file."
 S DIR(0)="SO^1:CPT;2:SNOMED;3:ICD9;4:LOINC"
 D ^DIR
 G END:$G(Y)<1
 S LRAN=Y,LRAN(0)=Y(0)
 K LRCODE S LRCODE=""
 S LRANS=$S(Y=1:" CPT",Y=2:" SNOMED,",Y=3:" ICD9",1:" LOINC")
 K DIR S DIR("A")="Select "_Y(0)_" Code"
 S LRGLB=$S(Y=1:";ICPT(",Y=2:";LAB(61.1,",Y=3:";ICD9(",1:"")
 S DIR(0)="PO^"_$S(Y=1:"81",Y=2:"61.1",Y=3:"80",1:"95.3")_":ENMZQ"
 F  D ^DIR Q:Y<1  D
 . I LRAN'=4 S LRCODE(+Y_LRGLB_"-"_LRANS)=" ["_$S(LRAN=3:$P(Y(0),U,3),1:$P(Y(0),U,2))_"]",DIR("A")=" Select another "_LRAN(0)_" code "
 . I LRAN=4 S LRCODE(+Y_"-"_LRANS)=" ["_$G(^LAB(95.3,+Y,80))_"]"
 G:$D(DTOUT)!($D(DUOUT)) END
 I $O(LRCODE(0))="" W !?5,"Nothing Selected ",!!,$C(7) G END
DEV ;SELECT DEVICE
 K %ZIS S %ZIS="Q" D ^%ZIS G:POP!($D(DUOUT))!($D(DTOUT)) END
 I $D(IO("Q")) G QUE
 U IO
DEQUE ;
 S LREND=0 W:$E(IOST,1,2)="C-" @IOF
 I $D(ZTDEQUED) S ZTREQ="@"
 S LRHD=LRANS_" Listing   "_$$FMTE^XLFDT($$NOW^XLFDT,"1P")
 S LRPG=0 D HD
 S LRN="" F  S LRN=$O(LRCODE(LRN)) Q:LRN=""!($G(LREND))  D
 . K ^TMP("LROUT",$J) D FIND^DIC(64,"","@;.01;1;IX",$S(LRAN=4:"XQ",1:"QM"),$P(LRN,"-"),"",$S(LRAN=4:"AH^AI",1:"AB"),"","","^TMP(""LROUT"",$J)")
 . I '$O(^TMP("LROUT",$J,"DILIST",0)) D  Q
 . . D TOP Q:$G(LREND)
 . . W !!?2,$TR(LRN,";(-","  ")_$P(LRCODE(LRN),U),!?5," [ IS NOT LINKED ]"
 . I $O(^TMP("LROUT",$J,"DILIST",0)) D
 . . D TOP Q:$G(LREND)
 . . W !!?2,$TR(LRN,";(","  ")_$P(LRCODE(LRN),U)_" linked to:"
 . . S LRX=0 F  S LRX=$O(^TMP("LROUT",$J,"DILIST",2,LRX)) Q:LRX<1  Q:LREND  D
 . . . S LRIEN=^TMP("LROUT",$J,"DILIST",2,LRX)
 . . . S LRANOUT=^TMP("LROUT",$J,"DILIST","ID",LRX,1)_" "_^TMP("LROUT",$J,"DILIST","ID",LRX,.01)
 . . . D TOP Q:$G(LREND)  W !?4,LRIEN,?15,$E(LRANOUT,1,64)
 G:$D(DTOUT)!($D(DUOUT)) END
 W !?10,"Finished"
END ;
 W ! I $E(IOST,1,2)="P-" W @IOF
 D ^%ZISC
 Q:$G(LRDEBUG)
 K DA,DIR,DIRUT,DTOUT,DUOUT,LRAN,LRANOUT,LRANS,LRCODE,LRCPT,LREND
 K LRGLB,LRHD,LRIEN,LRN,LRPG,LRX,POP,X,Y
 K ZTDEQUED,ZTREQ,ZTSK,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSTOP
 K ^TMP("LROUT",$J) D CLEAN^DILF
 Q
TOP ;
 I $$S^%ZTLOAD("Report Stopped") S (ZTSTOP,LREND)=1 Q
 N DIR
 Q:$Y<(IOSL-4)
 I $E(IOST,1,2)="P-" G HD
 N DIR
 S DIR(0)="E" D ^DIR
 S:$D(DTOUT)!($D(DUOUT)) LREND=1
 I $G(LREND) W !! Q
HD ;
 S LRPG=$G(LRPG)+1
 W:$G(LRN)'="" @IOF
 W !!,$$CJ^XLFSTR(LRHD_" Page: "_LRPG,IOM)
 I $G(LRN)'="" W !?2,$TR(LRN,";(","  ")_$P(LRCODE(LRN),U)_" linked to:"
 Q
QUE ;
 K ZTDTH
 S ZTRTN="DEQUE^LRCAP64S",ZTSAVE("LR*")=""
 S ZTDESC="Lab List of codes from LAM"
 S ZTIO=ION D ^%ZTLOAD
 I $G(ZTSK) W !,$$CJ^XLFSTR("Queued to "_ION,80)
 G END
 Q
