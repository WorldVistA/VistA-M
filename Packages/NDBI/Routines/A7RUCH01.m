A7RUCH01 ;HCIOFO/CAH - Print last patch installed in ea pkg as of dt selected ;11/23/98
 ;;1.0;NDBI UTILITIES;;Oct 01, 2000
 ;
 ;This produces a list sorted by patch name, with one patch printed per
 ;package.  It prints the last (highest sequence) patch installed
 ;for each package as of the date selected.
 ;Builds temporary global:
 ; ^A7RTMP1("A7RUCH01",Station#,Package)=SEQ#^Patch name
 ;
EN ;
 D INIT Q:$G(A7RQ)
 W !
DQ K ^A7RTMP1("A7RUCH01",A7RSTN)
 S X=""
 F  S X=$O(^A7RTMP1("A7RUCH01","CALL",X)) Q:X=""  K ^A7RTMP1("A7RUCH01","CALL",X,A7RSTN)
 S A7RD0=0,C=0 W !
 S A7RSITE=$$SITE^VASITE,A7RSTN=$P(A7RSITE,U,3),A7RSNAM=$P(A7RSITE,U,2)
 F  S A7RD0=$O(^XPD(9.7,A7RD0)) Q:'A7RD0  D
 . S A7R0=$G(^XPD(9.7,A7RD0,0))
 . S A7RPKG=$P($P(A7R0,U),"*",1,2)
 . I A7RPKG'["*" Q
 . S A7RINSTL=$P($G(^XPD(9.7,A7RD0,1)),U,3)
 . S ^A7RTMP1("A7RUCH01","CALL",$P(A7R0,U,1),A7RSTN)="" ;GET ALL
 . I A7RINSTL>A7RDT Q  ;If patch was installed after dt selected, quit
 . S A7RSEQ=$P($G(^XPD(9.7,A7RD0,2)),"#",2)
 . I 'A7RINSTL!('A7RSEQ) Q
 . S A7RLAST=$G(^A7RTMP1("A7RUCH01",A7RSTN,A7RPKG))
 . S ^A7RTMP1("A7RUCH01","ALLPKG",A7RPKG)="" ;Save entry for every pkg regardless of station
 . I '$L(A7RLAST) S ^A7RTMP1("A7RUCH01",A7RSTN,A7RPKG)=A7RSEQ_U_$P(A7R0,U) Q
 . I A7RSEQ>+A7RLAST S ^A7RTMP1("A7RUCH01",A7RSTN,A7RPKG)=A7RSEQ_U_$P(A7R0,U)
 . S C=C+1 I C#50=0 W "."
 S X=0,C=0 F  S X=$O(^A7RTMP1("A7RUCH01",X)) Q:'X  S C=C+1 ;Count stations
 I $G(A7RNORPT) D KILL Q
 I C>1 D PRINTALL,DTALL^A7RUCH04,KILL Q  ;Print multiple station report
 D PRINT,KILL  ;Print single station report
 Q
 ;
INIT ;Prompt for date, device
 K A7RQ S A7RPG=0
 S A7RSTN=$P($$SITE^VASITE,U,3)
 W !!,"This utility will print the highest installed patch for each package",!,"as of the date you select.",!!,"WARNING: Patches with no sequence number are ignored!"
 W !?9,"A maximum of 3 stations can be compared.",!
 K DIR S DIR(0)="Y",DIR("A")="Want to clean out all collected data for all stations" D ^DIR
 I $D(DIRUT) S A7RQ=1 Q
 I Y=1 W !," . . . . " K ^A7RTMP1("A7RUCH01") W "Done.",!
 K DIR S DIR(0)="D^:"_DT_":AEPTX" S DIR("A")="Enter the date for which you would like a patch status" S DIR("B")="TODAY" D ^DIR
 I 'Y S A7RQ=1
 I $D(DIRUT) S A7RQ=1 Q
 S A7RDT=Y I A7RDT'["." S A7RDT=A7RDT_".9999"
 K A7RL S $P(A7RL,"-",79)=""
 S A7RNORPT=0 K DIR S DIR(0)="Y" S DIR("A")="Want to suppress report"
 S DIR("?")="Suppress if you don't want a report until all stations are collected" D ^DIR
 I $D(DIRUT) S A7RQ=1 Q
 K DIR I Y=1 S A7RNORPT=1
 I $G(A7RNORPT) Q
 ;
 W !
 S A7RNDRP=0 K DIR S DIR(0)="Y" S DIR("A")="Detailed Compare report"
 S DIR("?")="Would you like a detailed compare report?" D ^DIR
 I $D(DIRUT) S A7RQ=1 Q
 K DIR I Y=1 S A7RNDRP=1
 ;
 I '$G(A7RNORPT) D ASKDEV I $G(POP) S A7RQ=1 Q
 S ^A7RTMP1("A7RUCH01",A7RSTN)=A7RDT
 Q
 ;
PRINT ;Print single stn list of high patch numbers and their sequence number
 U IO W:IOST["C-" @IOF ;initial FF for CRT
 D HDG
 I '$L($O(^A7RTMP1("A7RUCH01",A7RSTN,""))) W !!,"No patches to report!" Q
 S A7RUCH01=""
 F  S A7RUCH01=$O(^A7RTMP1("A7RUCH01",A7RSTN,A7RUCH01)) Q:'$L(A7RUCH01)!($G(A7RQ))  D
 . S A7R0=^A7RTMP1("A7RUCH01",A7RSTN,A7RUCH01)
 . W !,$P(A7R0,U,2),?32,$P(A7R0,U),?37,"(STN ",A7RSTN,")"
 . I $Y>(IOSL-5) D HDG I $G(A7RQ) Q
 Q
PRINTALL ;Print comparison of multiple stations
 U IO W:IOST["C-" @IOF ;initial FF for CRT
 D HDGALL S A7RSTN=0 S A7RSTN=$O(^A7RTMP1("A7RUCH01",A7RSTN))
 I '$L($O(^A7RTMP1("A7RUCH01",A7RSTN,""))) W !!,"No patches to report!" Q
 S A7RPKG="" F  S A7RPKG=$O(^A7RTMP1("A7RUCH01","ALLPKG",A7RPKG)) Q:'$L(A7RPKG)!($G(A7RQ))  D
 . I $Y>(IOSL-5) D HDGALL I $G(A7RQ) Q
 . W ! S A7RSTN=0 F  S A7RSTN=$O(^A7RTMP1("A7RUCH01",A7RSTN)) Q:'A7RSTN!($G(A7RQ))  D
 . . S A7R0=$G(^A7RTMP1("A7RUCH01",A7RSTN,A7RPKG))
 . . W:$X>1 ?27 W:$X>27 ?55
 . . W:A7R0]"" $P(A7R0,U,2)_" (SEQ# "_$P(A7R0,U)_")" W "  "
 Q
 ;
ASKDEV S %ZIS="Q",%ZIS("B")="" D ^%ZIS I POP W ! S A7RQ=1 Q
 I $D(IO("Q")) D
 . S ZTDESC="NDBI - HIGHEST INSTALLED PATCH LIST",ZTRTN="DQ^A7RUCH01"
 . S ZTSAVE("A7RDT")="",ZTSAVE("A7RL")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 . K ZTSK,IO("Q") D HOME^%ZIS
 . S A7RQ=1
 Q
 ;
HDG ;Heading for single station report
 I A7RPG>0,IOST?1"C-".E K DIR S DIR(0)="E" D ^DIR W ! S:$D(DTOUT)!(X[U) A7RQ=1 Q:$G(A7RQ)
 W:A7RPG>0 @IOF S A7RPG=A7RPG+1 S Y=DT D DD^%DT
 W !,"NDBI- HIGHEST PATCHES INSTALLED ON ",$P($$SITE^VASITE,U,2)," as of ",$$FMTE^XLFDT(A7RDT),?74,"<",A7RPG,">"
 W !!,"PATCH NAME",?32,"SEQUENCE #",!,A7RL,!
 Q
 ;
HDGALL ;
 I A7RPG>0,IOST?1"C-".E K DIR S DIR(0)="E" D ^DIR W ! S:$D(DTOUT)!(X[U) A7RQ=1 Q:$G(A7RQ)
 W:A7RPG>0 @IOF S A7RPG=A7RPG+1 S Y=DT D DD^%DT
 W !,"NDBI -- HIGHEST PATCH LEVEL COMPARISON ",?74,"<",A7RPG,">"
 W !! S X=$O(^A7RTMP1("A7RUCH01",0)) W "STN "_X
 S A7RX=$O(^DIC(4,"D",+X,0))
 S A7RSTNAM=$P($G(^DIC(4,+A7RX,0)),U)
 I $L(A7RSTNAM) W "-",$E(A7RSTNAM,1,17)
 S X=$O(^A7RTMP1("A7RUCH01",X)) W ?27,"STN "_X
 S A7RX=$O(^DIC(4,"D",+X,0))
 S A7RSTNAM=$P($G(^DIC(4,+A7RX,0)),U)
 I $L(A7RSTNAM) W "-",$E(A7RSTNAM,1,17)
 S X=$O(^A7RTMP1("A7RUCH01",X)) I $L(X),X'="ALLPKG" W ?55,"STN "_X
 S A7RX=$O(^DIC(4,"D",+X,0))
 S A7RSTNAM=$P($G(^DIC(4,+A7RX,0)),U)
 I $L(A7RSTNAM) W "-",$E(A7RSTNAM,1,17)
 W !,A7RL,!
 Q
 ;
KILL ;
 W:IOST?1"P-".E @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIR,DTOUT,DUOUT,DIROUT,DIRUT,A7RPG,X,Y
 K A7R0,A7RD0,A7RDT,A7RINSTL,A7RL,A7RLAST,A7RUCH01,A7RPG
 K A7RPKG,A7RQ,A7RSEQ
 Q
