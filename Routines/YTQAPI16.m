YTQAPI16 ;ASF/ALB MHA REPORT BY Q ; 4/3/07 11:34am
 ;;5.01;MENTAL HEALTH;**85**;Dec 30, 1994;Build 48
 Q
MAIN ;
 N N,YSAD,G,YSCODE,YSB,YSD,YSE,YSCN,DIRUT,Y,YSA,YSC,YSCOMP,YSQNUMB,YSQTEXT
 D SELAD
 W !!,"You must queue this report- off hours are strongly suggested"
 S %ZIS="QM" D ^%ZIS Q:IO=""
 I '$D(IO("Q")) W !,"Must be queued-- try again",! H 2 Q  ;-->out
 I $D(IO("Q")) D  D ^%ZTLOAD D HOME^%ZIS K IO("Q") Q
 .S ZTRTN="ENQ^YTQAPI16",ZTDESC="MHA3 QRQ Export",ZTSAVE("YS*")=""
 .S ZTIO=ION_";"_IOST
 .I $D(IO("DOC"))#2,IO("DOC")]"" S ZTIO=ZTIO_";"_IO("DOC") Q
 .I IOM S ZTIO=ZTIO_";"_IOM
 .I IOSL S ZTIO=ZTIO_";"_IOSL
 Q
ENQ ;taskman entry
 K ^TMP("YSQR",$J),^TMP("YSQA",$J)
 S N=0
 D BUILDG
 D XML
 D ^%ZISC
 Q
XML ;setup output
 S N=N+1,^TMP("YSXML",$J,N)="<?xml version='1.0' encoding='UTF-8'?>"
 S N=N+1,^TMP("YSXML",$J,N)="<Report>"
 D GUTS
 S N=N+1,^TMP("YSXML",$J,N)="</Report>"
 U IO S N=0 F  S N=$O(^TMP("YSXML",$J,N)) Q:N'>0  W ^(N),!
 Q  ;-->out
SELAD ;administation filter
 W @IOF,!!,"MHA Question Frequency Report"
 K DIR S DIR(0)="DA^2961001:NOW:TX",DIR("A")="Begin date/time: ",DIR("B")="T-1M" D ^DIR
 Q:$D(DIRUT)
 S YSB=Y
 K DIR S DIR(0)="DA^2961001:NOW:TX",DIR("A")="End date/time: ",DIR("B")="NOW" D ^DIR
 Q:$D(DIRUT)
 S YSE=Y
 K DIC S DIC(0)="AEQ",DIC="^YTT(601.71," D ^DIC Q:Y'>0  S YSCODE=$P(Y,U,2)
 Q
BUILDG ;global create
 S YSCN=$O(^YTT(601.71,"B",YSCODE,-1))
 S YSD=YSB-.00001
 F  S YSD=$O(^YTT(601.84,"AC",YSCN,YSD)) Q:(YSD'>0)!(YSD>YSE)  D
 . S YSAD=0 F  S YSAD=$O(^YTT(601.84,"AC",YSCN,YSD,YSAD)) Q:YSAD'>0  D
 .. S YSCOMP=$P(^YTT(601.84,YSAD,0),U,9)
 .. Q:YSCOMP'="Y"
 .. S ^TMP("YSQA",$J,YSAD)=""
 S YSAD=0 F  S YSAD=$O(^TMP("YSQA",$J,YSAD)) Q:YSAD'>0  S YSA=0 F  S YSA=$O(^YTT(601.85,"AD",YSAD,YSA)) Q:YSA'>0  D B3
 Q
B3 ;
 S YSQNUMB=$P(^YTT(601.85,YSA,0),U,3)
 S YSC=$P(^YTT(601.85,YSA,0),U,4)
 S:YSC'?1N.N YSC="?"
 S YSCN=$S(YSC?1N.N:^YTT(601.75,YSC,1),1:"???")
 S:$D(^YTT(601.85,YSA,1,1,0)) YSCN=^YTT(601.85,YSA,1,1,0)
 S ^TMP("YSQR",$J,YSQNUMB)=$G(^TMP("YSQR",$J,YSQNUMB))+1
 S ^TMP("YSQR",$J,YSQNUMB,YSC)=$G(^TMP("YSQR",$J,YSQNUMB,YSC))+1
 Q
GUTS ;extract the data into an XML global
 S N=N+1,^TMP("YSXML",$J,N)="<Instrument>"_YSCODE_"</Instrument>"
 S YSQNUMB=0 F  S YSQNUMB=$O(^TMP("YSQR",$J,YSQNUMB)) Q:YSQNUMB'>0  D
 . S N=N+1,^TMP("YSXML",$J,N)="<Question>"
 . S N=N+1,^TMP("YSXML",$J,N)="<Number>"_YSQNUMB_"</Number>"
 . S YSQTEXT=$G(^YTT(601.72,YSQNUMB,1,1,0))
 . S N=N+1,^TMP("YSXML",$J,N)="<QText>"_YSQTEXT_"</QText>"
 . S YSC=0 F  S YSC=$O(^TMP("YSQR",$J,YSQNUMB,YSC)) Q:YSC'>0  D
 .. S N=N+1,^TMP("YSXML",$J,N)="<Choice>"
 .. S N=N+1,^TMP("YSXML",$J,N)="<ChoiceNumb>"_YSC_"</ChoiceNumb>"
 .. S N=N+1,^TMP("YSXML",$J,N)="<ChoiceTxt>"_$G(^YTT(601.75,YSC,1))_"</ChoiceTxt>"
 .. S N=N+1,^TMP("YSXML",$J,N)="<ChoiceCount>"_^TMP("YSQR",$J,YSQNUMB,YSC)_"</ChoiceCount>"
 .. S N=N+1,^TMP("YSXML",$J,N)="<Qcount>"_^TMP("YSQR",$J,YSQNUMB)_"</Qcount>"
 .. S N=N+1,^TMP("YSXML",$J,N)="</Choice>"
 . S N=N+1,^TMP("YSXML",$J,N)="</Question>"
 Q
