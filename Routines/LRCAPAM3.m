LRCAPAM3 ;SLC/FHS - LAB PHASE 3 LMIP DATA COLLECTION PRINT REPORT ;8/23/91 1039;
 ;;5.2;LAB SERVICE;**42,119,201**;Sep 27, 1994
EN ;
 S LINE="This is Phase 3 of LMIP Data Collection" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="This option will provide a print out" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="of CONDENSED data that will be loaded into the actual" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="LMIP Mail message.  Review these figures for completeness" W !?(IOM-$L(LINE))\2,LINE,!
 S LINE="and accuracy." W !?(IOM-$L(LINE))\2,LINE,!
 K ^TMP($J),ZTSK,%DT
ASK1 ;
 K CNT S CNT=0 S I=0 F  S I=$O(^LAH("LABWL",I)) Q:I<1  S LN=^(I) I $E(LN)="$" D
 .S LRDATE=$P(LN,"$$$",2) W !?5,"Division ",$P($P(LN,U,3),"$$$"),"  has data for ",$$FMTE^XLFDT(LRDATE,"1D") S CNT=CNT+1,CNT(LRDATE)=""
 I 'CNT W !!?10,"I do not have any data in the file ",!! G EXIT
DT W ! K DIR S DIR(0)="D^::AEP",DIR("A")="Enter Month and Year for start of report: "
 S DIR("?")="You must enter a Valid Month and Year [ .ie 10-93 ]"
 S DIR("?",1)="Select from the list displayed above."
 D ^DIR
 G:$D(DUOUT)!($D(DTOUT))!(Y<0) EXIT
 S LRDT1=$E(Y,1,5)_"00" I '$D(CNT(LRDT1)) W !!?10,"I do not have data for this ",$$FMTE^XLFDT(LRDT1,"1D"),!!,$C(7) G ASK1
ASK2 ;
 W ! K DIR("?") S DIR("?")="Month and Year you wish to end with "
 S DIR("A")="Ending Report Date: ",DIR("B")=$$FMTE^XLFDT(LRDT1,"1D")
 D ^DIR G:$D(DUOUT)!($D(DTOUT))!(Y<0) EXIT
 S LRDT2=$E(Y,1,5)_"00"
 W !! S %ZIS="Q" D ^%ZIS G:POP!($D(DUOUT))!($D(DTOUT)) EXIT
 I $D(IO("Q")) G QUEUE
 U IO
DQ ;
 W:$E(IOST)="C" @IOF,!
 S LRPRDT=$TR($$FMTE^XLFDT($$NOW^XLFDT,"1M"),"@"," "),LRPAGE=0
 S LRHDT=$$FMTE^XLFDT(LRDT1,"1D")_"  TO  "_$$FMTE^XLFDT(LRDT2,"1D") D LOOP
 W ! W:$E(IOST,1,2)="P-" @IOF
EXIT ;
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K DIR,%DT,%ZIS,CNT,I,LINE,LRCCD,LRCCDN,LRCCDN0,LRCCDNX,LRDT,LRDT1,LRDT2
 K LRDV1,LRDV2,LRHDT,LRLN,LRPAGE,LRPRDT,LRQUIT,LRTXT,NUM,TCNT,Y,ZTSK
 K IFN,LN,LRCHK,LRDATE,LRX,LRDV1X,LRDV2X
 K ^TMP($J)
 Q
QUEUE ;
 S ZTRTN="DQ^LRCAPAM3",ZTSAVE("LR*")="",ZTDESC="Lab Austin Workload Report",ZTIO=ION
 D ^%ZTLOAD
 W !! G EXIT
 Q
LOOP ;
 S (LRLN,LRDV1,LRCHK,LRDV2,LRDV1X,LRDV2X)=0
 F  S LRLN=$O(^LAH("LABWL",LRLN)) Q:'LRLN  S LRTXT=^(LRLN) D
 .I $E(LRTXT)="$" S LRDV1=$P($P(LRTXT,"$",2),U),LRDV2=$P($P(LRTXT,"$$",2),U),LRDT=+$P(LRTXT,"$$$",2)
 .I 'LRDV1!'LRDV2 Q
 .S LRDV1X=$O(^DIC(4,"D",LRDV1,0)),LRDV2X=$O(^DIC(4,"D",LRDV2,0))
 .Q:'LRDV1X!('LRDV2X)
 .I '(LRDT<(LRDT1-.00001)),'(LRDT>(LRDT2+99))
 .E  Q
 .I $E(LRTXT)="$" D  Q
 ..S IFN=+$O(^LRO(67.9,LRDV1X,1,LRDV2X,1,"B",LRDT,0)) I $D(^LRO(67.9,LRDV1X,1,LRDV2X,1,IFN,0)) S $P(^(0),U,2)=DUZ,LRCHK=1 Q
 ..I '$G(LRCHK) W !?5,"Unable to enter User into 'CERTIFIED BY' field in file #67.9",!?10,"Div: [ ",LRDV2," ]for the month of ",$$FMTE^XLFDT(LRDT),! Q
 .I $E(LRTXT)="\" S ^TMP($J,LRDV1,LRDV2,LRCCD,0)=$P(LRTXT,"\",2) Q
 .I $E(LRTXT)="*" S LRCCDN=$P(LRTXT,"*",2),LRCCD=$P(LRCCDN,U) D
 ..S LRCCD=$E(LRCCD,13,15)_$E(LRCCD,1,12)
 ..I '$D(^TMP($J,LRDV1,LRDV2,LRCCD))#2 S ^(LRCCD)="",^(LRCCD,"TOT WRK")=0
 ..S CNT=0,LRCCDNX=$G(^TMP($J,LRDV1,LRDV2,LRCCD)) F I=2:1:11 D
 ...S NUM=$P(LRCCDN,U,I) I NUM S $P(LRCCDNX,U,I)=$P(LRCCDNX,U,I)+NUM I I'=6,I'=7,I'=9 S CNT=CNT+NUM
 ..S ^TMP($J,LRDV1,LRDV2,LRCCD)=LRCCDNX I $D(^(LRCCD,"TOT WRK")),$G(CNT) S ^("TOT WRK")=^("TOT WRK")+CNT
 S LRDV1=$O(^TMP($J,0)) I 'LRDV1 W !!?5,"Nothing to Report",!! Q
 S LRDV1="" F  Q:$G(LRQUIT)  S LRDV1=$O(^TMP($J,LRDV1)) Q:'LRDV1  D
 . S LRDV1X=$O(^DIC(4,"D",LRDV1,0)) Q:'LRDV1X
 . D LOOP2
 W !!
 Q
LOOP2 ;
 S (TCNT,LRDV2)="" F  Q:$G(LRQUIT)  S LRDV2=$O(^TMP($J,LRDV1,LRDV2)) Q:'LRDV2  D
 .S LRDV2X=$O(^DIC(4,"D",LRDV2,0))
 .I 'LRDV1X!('LRDV2X) S LRQUIT=1 Q
 .D HEADER Q:$G(LRQUIT)
 .W !?10,"**************  Division: ",$P($G(^DIC(4,LRDV2X,0)),U),"  **************"
 .S LRCCD=0 F  Q:$G(LRQUIT)  S LRCCD=$O(^TMP($J,LRDV1,LRDV2,LRCCD)) Q:LRCCD=""  S LRCCDN=^(LRCCD),LRCCDN0=$G(^(LRCCD,0)) D
 ..Q:$G(LRQUIT)  I ($Y>(IOSL-5)) D HEADER Q:$G(LRQUIT)
 ..W !!,?5,LRCCDN0,!?10,$E(LRCCD,1,3),"  WKLD Code: ",$S($E(LRCCD,4):$E(LRCCD,4,14),1:$E(LRCCD,5,14)) W:$E(LRCCD,15) $E(LRCCD,15) W !
 ..F I=2:1:11 I $P(LRCCDN,U,I) D
 ...W $S(I=2:"[IN PAT]",I=3:"[OUT PAT]",I=4:"[OTH PAT]",I=5:"[QC]",I=6:"[IN ST*]",I=7:"[T ST*]",I=9:"[SO*]",I=10:"[REP]",I=11:"[OTH]",1:"[MAN]"),"=",$P(LRCCDN,U,I),"  " W:$X>(IOM-10) !
 ..W !,?60,"Total: ",$J(^TMP($J,LRDV1,LRDV2,LRCCD,"TOT WRK"),7,0) S TCNT=TCNT+^("TOT WRK")
 .W:'$G(LRQUIT) !!,"Total On-Site Tests for "_$$FMTE^XLFDT(LRDT1,"1D")_"  TO  "_$$FMTE^XLFDT(LRDT2,"1D")_" = [",TCNT,"]",!
 .W:'$G(LRQUIT) !?20,"[ XX *] NOT included in Total",!!
 .W !! W:$E(IOST,1,2)="P-" @IOF
 Q
HEADER ;
 I LRPAGE,'$D(ZTQUEUED),$E(IOST,1,2)="C-" W !!,"Press <Enter> to continue or '^' to stop.   " R LRX:DTIME S:'$T!($E(LRX)="^") LRQUIT=1 Q:$G(LRQUIT)
 W:$G(LRPAGE) @IOF S LRPAGE=LRPAGE+1 W !,"Lab WORKLOAD data Report for Div/Institution: ",$P($G(^DIC(4,LRDV2X,0)),U)_" / "_$P($G(^DIC(4,LRDV1X,0)),U),?(IOM-10)," Page: ",LRPAGE
 W !?(IOM-$L(LRHDT))/2,LRHDT
 W !,"    Printed: ",LRPRDT,!
 W ?5,"[ XX* data ] NOT included in total ",!
 Q
