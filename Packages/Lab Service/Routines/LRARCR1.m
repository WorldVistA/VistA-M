LRARCR1 ;DALISC/CKA - ARCHIVED WKLD REP GENERATOR-MAIN ;
 ;;5.2;LAB SERVICE;**59**;August 31, 1995
GO ;
 G TRIAL
EN ;
 K DIC,%DT,^TMP("LRAR",$J),LRCOL,LRCPSX,LRCAPS,LRTSTS,LRSP,LRLOC
 K LRSITSEL,DIR
 S (LRCOL,LRCPSX,LRCAPS,LRTSTS,LRSP,LRLOC,LREND)=0
 S LRIOPAT=""
 Q
LRINST ;
 S LRSITNUM=+$P($G(^XMB(1,1,"XUS")),U,17)
 S LRSITE=$P($G(^DIC(4,LRSITNUM,0)),U) S:LRSITE="" LRSITE="UNKNOWN"
 S LRSITSEL=0 K DIR S DIR(0)="S^Y:YES;N:NO"
 S DIR("A")="Do you want to print a specific DIVISION?"
 S DIR("?")="If you have a multi-divisional institution you might want to print a particular division, otherwise your report will reflect the whole instution which might not be what you have intended."
 D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 I Y="N" Q
 S DIC("A")="Select a Division:",DIC=4,DIC(0)="AEMQ"
 F  D ^DIC Q:Y=-1  S LRSITSEL=+Y,LRSITSEL(+Y)=$S($L($P($G(^DIC(4,+Y,0)),U)):$P(^(0),U),1:"ERROR"_Y)
 Q
TRIAL ; entry point for work load lookup
 D EN,LRINST G:$D(DUOUT)!($D(DTOUT)) EXIT K DIR
 D ACCN^LRARCR1A G:Y<0 EXIT
 D DATE^LRARCR1A G:Y<0 EXIT S %=2
 W !,"Do you want to look up by Specimen Type and/or Collection Sample"
 D YN^DICN G:%<0 EXIT G:%=2 A
 S DIR(0)="S^S:SPECIMEN TYPE;C:COLLECTION SAMPLE;B:BOTH;A:ALL or ANY (Will not prompt)"
 S DIR("?")="<All> will not prompt for a specimen or sample"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) EXIT G @Y
B D SPEC^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
C D COLL^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT G A
S D SPEC^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
A W !,"Do you want to select by TESTS or WKLD CODES (YES or NO )"
 S %=2 D YN^DICN G:%=-1 EXIT
 G:%=2 I D ASK G:$D(DUOUT)!($D(DTOUT)) EXIT K DIC,DIR
 I Y="A" G L
 I Y="W" D CAP^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT G L
 D TEST^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
I D INSTR^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
L ;
 D STAT^LRARCR1A G:$D(DUOUT)!($D(DTOUT))!(%<0) EXIT
 D LOC^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
 D IOPAT^LRARCR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
 D CONTROL^LRARCR1A G:LREND EXIT
 D REPTYP^LRARCR1A G:LREND EXIT
 K DIR S DIR(0)="SX^D:DETAILED;C:CONDENSED",DIR("A")="        REPORT"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) EXIT S LRANS=Y K DIR
 K IO("Q") S %ZIS="Q" D ^%ZIS G:POP EXIT I $D(IO("Q")) G QUE
 D WAIT^DICD
 U IO D ^LRARCR2
 Q
ASK ;
 S DIR(0)="S^T:TEST;W:WKLD CODE;A:ALL (means no specific TEST or WKLD CODE )",DIR("A")="Do you want to select by (T)est or (W)KLD Code or (A)ll"
 S DIR("?")="All means no specified TEST or WKLD code is desired and will take you to the next prompt."
 S DIR("?",1)="You can only select either by TESTs or by WKLD CODEs"
 S DIR("?",2)="Choosing ALL will take you to the location prompt right away."
 S DIR("?",3)="Selecting by WLKD codes will limit you to a particular test only,"
 S DIR("?",4)="whereas by TEST might give you 1 or more WKLD codes."
 D ^DIR
 Q
QUE ;
 S ZTSAVE("LR*")="",ZTRTN="LRARCR2",ZTDESC="ARCHIVED WORKLOAD REPORT",ZTIO=ION
 S:$G(LRSITE) ZTSAVE("LRSITE*")=""
 S:$G(LRSP) ZTSAVE("LRSP*")="" S:$G(LRCOL) ZTSAVE("LRCOL*")=""
 S:$G(LRTST) ZTSAVE("LRTST*")="" S:$G(LRCAPS) ZTSAVE("LRCAPS*")=""
 S:$G(LRCPSX) ZTSAVE("LRCPSX*")="" S:$G(LRLOC) ZTSAVE("LRLOC*")=""
 D ^%ZTLOAD,^%ZISC
 S LREND=1
EXIT ;
 S LREND=1
 D CLEAN^LRARCR4
 Q
