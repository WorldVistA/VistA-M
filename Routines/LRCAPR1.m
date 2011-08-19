LRCAPR1 ;DALOI/PAC/FHS/JBM - WKLD REP GENERATOR-MAIN ;10/15/92 11:15
 ;;5.2;LAB SERVICE;**263**;Sep 27, 1994
GO ;
 G TRIAL
EN ;
 K DIC,%DT,^TMP("LR",$J),LRCOL,LRCPSX,LRCAPS,LRTSTS,LRSP,LRLOC,LRLDIV
 K LRSITSEL,DIR
 S (LRCOL,LRCPSX,LRCAPS,LRTSTS,LRSP,LRLDIV,LRLOC,LREND)=0
 S LRIOPAT=""
 Q
LRINST ;
 S LRSITNUM=+$P($G(^XMB(1,1,"XUS")),U,17)
 S LRSITE=$P($G(^DIC(4,LRSITNUM,0)),U) S:LRSITE="" LRSITE="UNKNOWN"
 S LRSITSEL=0 K DIR S DIR(0)="S^Y:YES;N:NO"
 S DIR("A")="Do you want to print a specific DIVISION?"
 S DIR("?")="If you have a multi-divisional institution you might want to print a particular division, otherwise your report will reflect the whole instution which might not be what you have intended."
 S DIR("B")="NO"
 D ^DIR Q:$D(DUOUT)!($D(DTOUT))
 I Y="N" Q
 S DIC("A")="Select a Division:",DIC=4,DIC(0)="AEMQ"
 F  D ^DIC Q:Y=-1  S LRSITSEL=+Y,LRSITSEL(+Y)=$S($L($P($G(^DIC(4,+Y,0)),U)):$P(^(0),U),1:"ERROR"_Y)
 Q
TRIAL ; entry point for work load lookup
 D EN,LRINST G:$D(DUOUT)!($D(DTOUT)) EXIT K DIR
 D ACCN^LRCAPR1A G:Y<0 EXIT
 D DATE^LRCAPR1A G:Y<0 EXIT S %=2
 W !,"Do you want to look up by Specimen Type and/or Collection Sample"
 D YN^DICN G:%<0 EXIT G:%=2 A
 S DIR(0)="S^S:SPECIMEN TYPE;C:COLLECTION SAMPLE;B:BOTH;A:ALL or ANY (Will not prompt)"
 S DIR("?")="<All> will not prompt for a specimen or sample"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) EXIT G @Y
B D SPEC^LRCAPR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
C D COLL^LRCAPR1A G:$D(DUOUT)!($D(DTOUT)) EXIT G A
S D SPEC^LRCAPR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
A W !,"Do you want to select by TESTS or WKLD CODES (YES or NO )"
 S %=2 D YN^DICN G:%=-1 EXIT
 G:%=2 I D ASK G:$D(DUOUT)!($D(DTOUT)) EXIT K DIC,DIR
 I Y="A" G L
 I Y="W" D CAP^LRCAPR1A G:$D(DUOUT)!($D(DTOUT)) EXIT G L
 D TEST^LRCAPR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
I D INSTR^LRCAPR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
L ;
 D STAT^LRCAPR1A G:$D(DUOUT)!($D(DTOUT))!(%<0) EXIT
LOC ;
 D   G:$D(DUOUT)!($D(DTOUT)) EXIT
 . N DIR S DIR(0)="YO",DIR("A")="Do you want to select Hospital Location ",DIR("B")="Yes"
 . D ^DIR I Y'=1 S LRLOC="1A" Q
 . D LOC^LRCAPR1A
LEDIDIV ;Select LEDI Institution sites
INST D  G:$D(DUOUT)!($D(DTOUT)) EXIT
 . N DIR,DIC
 . I LRLOC="1A" S DIR("B")="Yes"
 . S DIR(0)="YO",DIR("A")="Do you want to select LEDI Collecting Sites "
 . D ^DIR I Y'=1 S LRLDIV="1A" Q
 . S DIC=4,DIC(0)="AEMQ",DIC("A")="Select LEDI Collecting Sites : All // "
 . F I=1:1 D ^DIC Q:Y=-1  S LRLDIV(+Y)=$P(^(0),U),DIC("A")="Select another Site: ",LRLDIV=I
 I LRLDIV="1A",LRLOC="1A" D  G LOC
 . W !!?5,"<You HAVEN'T selected any locations> "
 . S (LRLOC,LRLDIV)=0
 D IOPAT^LRCAPR1A G:$D(DUOUT)!($D(DTOUT)) EXIT
 D CONTROL^LRCAPR1A G:LREND EXIT
 D REPTYP^LRCAPR1A G:LREND EXIT
 K DIR S DIR(0)="SX^D:DETAILED;C:CONDENSED",DIR("A")="        REPORT"
 D ^DIR G:$D(DUOUT)!($D(DTOUT)) EXIT S LRANS=Y K DIR
 K IO("Q") S %ZIS="Q" D ^%ZIS G:POP EXIT I $D(IO("Q")) G QUE
 D WAIT^DICD
 U IO D ^LRCAPR2
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
 S ZTSAVE("LR*")="",ZTRTN="LRCAPR2",ZTDESC="WORKLOAD REPORT",ZTIO=ION
 S:$G(LRSITE) ZTSAVE("LRSITE*")=""
 S:$G(LRSP) ZTSAVE("LRSP*")="" S:$G(LRCOL) ZTSAVE("LRCOL*")=""
 S:$G(LRTST) ZTSAVE("LRTST*")="" S:$G(LRCAPS) ZTSAVE("LRCAPS*")=""
 S:$G(LRCPSX) ZTSAVE("LRCPSX*")="" S:$G(LRLOC) ZTSAVE("LRLOC*")=""
 S:$G(LRLDIV) ZTSAVE("LRLDIV")=""
 D ^%ZTLOAD,^%ZISC
 S LREND=1
EXIT ;
 S LREND=1
 D CLEAN^LRCAPR4 K LRLDIV,LREDT,LRSDT
 Q
