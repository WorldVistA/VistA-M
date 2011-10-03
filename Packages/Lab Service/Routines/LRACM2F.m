LRACM2F ;MILW/JMC - LIST CUMULATIVE PATIENTS FOR SELECTED LOCATIONS ; 5/15/92
 ;;5.2;LAB SERVICE;**1**;Sep 27, 1994
EN ;Print list of cumulative patients for range of locations.
 K ^TMP($J),%DT,LR,DIR,LRLLOC
 S (LR,LRALL,LREND)=0,Y=$P($G(^LAB(64.5,1,0)),U,3)
 I Y S Y=$$FMTE^XLFDT(Y),%DT("B")=Y W !,"Current Cumulative Report Date: ",Y,!
 S %DT="AEQ",%DT("A")="Select REPORT DATE: ",%DT(0)="-NOW" D ^%DT Q:Y<1
 S LRDT=Y,LRDT1=$$FMTE^XLFDT(Y)
 D HDR1
 S Y="",(LRI,X)=0
 F  S Y=$O(^LRO(69,LRDT,1,"AR",Y)) Q:Y=""!(LREND)  D
 . S LRI=LRI+1,^TMP($J,"LR",LRI)=Y W ?X,$J(LRI,4),?X+6,$E(Y,1,20) S X=X+25
 . I X=75 S X=0 W !
 . I $Y+3>IOSL D
 . . N X,Y S DIR(0)="E" D ^DIR K DIR I 'Y S LREND=1 Q
 . . D HDR1
 I 'LRI W "No patients for this day",! G END
 I LRI,'LREND S (LRI,LR)=LRI+1 W ?X,$J(LRI,4),?X+6,"ALL Locations"
 W !!
 S DIR(0)="LO^1:"_LRI,DIR("A")="Select LOCATIONS" D ^DIR K DIR
 I $D(DIRUT) G END
 S Z="",J=0
 F  S Z=$O(Y(Z)) Q:Z=""!(LRALL)  D
 . S X=Y(Z)
 . F XX=1:1 Q:'$P(X,",",XX)!(LRALL)  D
 . . I $P(X,",",XX)=LR S LRALL=1 Q
 . . S ^TMP($J,"LRLLOC",^TMP($J,"LR",$P(X,",",XX)))="",J=J+1
 S ^TMP($J,"LRLLOC",0)=J
 I LRALL D
 . S (I,J)=0
 . F  S I=$O(^TMP($J,"LR",I)) Q:'I  S ^TMP($J,"LRLLOC",^TMP($J,"LR",I))="",J=J+1
 . S ^TMP($J,"LRLLOC",0)=J
 S %ZIS="Q" K IO("Q"),IO("C") D ^%ZIS Q:POP
 I $D(IO("Q")) D  G END
 . S ZTRTN="DQ^LRACM2F",ZTDESC="Lab Cum Patient List"
 . S (ZTSAVE("LRALL"),ZTSAVE("LRDT"),ZTSAVE("LRDT1"),ZTSAVE("^TMP($J,""LRLLOC"","))=""
 . D ^%ZTLOAD W !,"Request ",$S($D(ZTSK):"",1:"NOT "),"Queued" K ZTSK
 . D ^%ZISC
 ;
DQ ; Dequeue entry point.
 U IO
 S (LRCTRR,LRCTRR(0),LRCTRR(1),LREND,LRPG)=0
 S LRLINE="",$P(LRLINE,"-",IOM)="-",LRPDT=$$HTE^XLFDT($H)
 S LRCNT=^TMP($J,"LRLLOC",0) ; Count of number of locations selected
 D HDR
 S L=0
 F  S L=$O(^TMP($J,"LRLLOC",L)) Q:L=""!(LREND)  D
 . I $Y+10>IOSL D HDR Q:LREND
 . W !!," LOCATION: ",L,?43,"LRDFN",!
 . S P=""
 . F  S P=$O(^LRO(69,LRDT,1,"AR",L,P)) Q:P=""!(LREND)  D
 . . S LRDFN=0
 . . F  S LRDFN=$O(^LRO(69,LRDT,1,"AR",L,P,LRDFN)) Q:'LRDFN!(LREND)  D
 . . . I $Y+5>IOSL D HDR Q:LREND  W !!," LOCATION: ",L," (Continued)",?43,"LRDFN",!
 . . . S X=^LR(LRDFN,0),LRDPF=$P(X,"^",2),DFN=$P(X,"^",3) D PT^LRX
 . . . S Y=^LRO(69,LRDT,1,"AR",L,P,LRDFN),LRCTRR=LRCTRR+1,LRCTRR(1)=LRCTRR(1)+Y
 . . . W !,LRCTRR,?5,$E(PNM,1,20),?28,SSN,?42,$J(LRDFN,6),?50,$S(Y:"Processed",1:"")
 . . . W ?61,"File: ",LRDPF,?72,$E(LRWRD,1,8)
 . S LRCTRR(0)=LRCTRR(0)+LRCTRR,LRCTRR=0
 I 'LREND D
 . I $Y+6>IOSL D HDR
 . W !!,"Totals for ",$S(LRALL:"'ALL'",1:"Selected")," Locations"
 . W !!,"Number of Patients: ",$J($FN(LRCTRR(0),","),5)
 . W !,"  Number Processed: ",$J($FN(LRCTRR(1),","),5)
 I $E(IOST,1,2)="P-" W @IOF
 ;
END ; Clean up.
 K ^TMP($J)
 K LRI,%DT,J,L,LR,LRALL,LRCNT,LRLINE,LRLLOC,LRPDT,LRPRAC,P,X,XX,Z
 D END^LRACM
 D KVAR^LRX
 I $D(ZTQUEUED) S ZTREQ="@"
 E  D ^%ZISC
 Q
 ;
HDR ; Print header for report.
 I LRPG,'$D(ZTQUEUED),$E(IOST,1,2)="C-" D  Q:LREND
 . F  Q:$Y+3>IOSL  W !
 . K DIR S DIR(0)="E" D ^DIR K DIR I 'Y S LREND=1
 W:$Y @IOF
 S LRPG=LRPG+1
 W "List of Cumulative Patients for ",$S(LRALL:"'ALL'",1:"Selected")," Location",$S(LRCNT>1:"s",1:"")
 W:$X+32>IOM ! W ?IOM-32," Printed: ",LRPDT
 W !,"Report Date: ",LRDT1,?IOM-28,"Page: ",LRPG
 W !,"For Location",$S(LRCNT>1:"s",1:""),": "
 I LRALL W "'ALL'"
 E  S X=0 F  S X=$O(^TMP($J,"LRLLOC",X)) Q:X=""  W:$X+$L(X)+3>IOM !,?17 W X,", "
 W !,LRLINE,!
 Q
 ;
HDR1 ; Print header for display.
 W @IOF,"The following locations have patients for ",LRDT1,".",!!
 Q
 ;
TASK ; Entry point for tasked option. Prints current report date for all locations.
 S LREND=0,LRALL=1
 S LRDT=$P($G(^LAB(64.5,1,0)),U,3) I 'LRDT G END ; No report date on file.
 S LRDT1=$$FMTE^XLFDT(LRDT)
 S Y="",LRI=0
 F  S Y=$O(^LRO(69,LRDT,1,"AR",Y)) Q:Y=""  S LRI=LRI+1,^TMP($J,"LRLLOC",Y)=Y
 I 'LRI G END ; No patients on report.
 S ^TMP($J,"LRLLOC",0)=LRI
 G DQ
