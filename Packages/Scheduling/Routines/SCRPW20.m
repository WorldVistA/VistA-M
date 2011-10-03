SCRPW20 ;RENO/KEITH - ACRP Ad Hoc Report ; 15 Nov 98  4:31 PM
 ;;5.3;Scheduling;**144,171**;AUG 13, 1993
 I $E(IOST)'="C" D  Q
 .N SDX S SDX="Your current terminal type is "_IOST_"." W !?(IOM-$L(SDX)\2),SDX
 .S SDX="This option requires a CRT terminal type!" W !!?(IOM-$L(SDX)\2),SDX,! Q
 K ^TMP("SCRPW",$J),SDPAR D BLD^SCRPW21 N DIR,X,Y,SDOUT,T S (SDREV,SDOUT)=0,T="~"
 F SDTAG="INTRO","FMT","PERS","LIM","ORD","XPF","REVIEW" D @SDTAG Q:SDOUT!SDREV
 G:SDOUT EXIT^SCRPW27 D SAVT^SCRPW21(.SDPAR)
QUE N ZTSAVE S ZTSAVE("SDPAR(")="" D MAR^SCRPW29,EN^XUTMDEVQ("RPT^SCRPW26","ACRP Ad Hoc Report",.ZTSAVE) G EXIT^SCRPW27
 ;
INTRO K SDBOT S (SDTOP,SDBOT(1))="A C R P   A d   H o c   R e p o r t" D DISP^SCRPW23(SDTOP,.SDBOT),INTRO^SCRPW26
 I $$REST^SCRPW22() H 1 S SDREV=1 G REVIEW
 Q:SDOUT  I '$O(^SDD(409.91,0)) W !! K DIR S DIR(0)="E" S X=$$DIR^SCRPW23(.DIR,0)
 Q
FMT ;Get format parameters
 S SDS1="F",(SDOUT,SDNUL)=0,SDBOT(1)="Report format selection",SDBOT(2)="Report format parameters determine the appearance of the report."
 D DISP^SCRPW23("R E P O R T   F O R M A T",.SDBOT)
 F SDTAG="F1","F2","F3","F4","F5","F6" D @SDTAG Q:SDOUT
 G:$$VF^SCRPW29() FMT I SDREV G:$$VP^SCRPW29() PERS
 Q
PERS ;Prompt for perspective
 K SDBOT S SDS1="P",(SDOUT,SDNUL)=0,SDBOT(1)="Report perspective selection",SDBOT(2)="The element selected for this parameter will determine how the statistics will",SDBOT(3)="be organized and sub-totaled."
 D DISP^SCRPW23("R E P O R T   P E R S P E C T I V E",.SDBOT)
 D P1 G:$$VP^SCRPW29() PERS Q
LIM ;Prompt for limitations
 K SDBOT S SDS1="L",(SDOUT,SDNUL)=0
 S SDBOT(1)="Report limitation selection",SDBOT(2)="Limiting factors determine which encounter records to count.  Multiple limiting",SDBOT(3)="factors can be chosen and specified to only include (or exclude) specific data."
 D DISP^SCRPW23("R E P O R T   L I M I T A T I O N S",.SDBOT)
 F SDTAG="L1","L2" D @SDTAG Q:SDOUT
 G:$$VL^SCRPW29() LIM Q
ORD ;Prompt for print order
 K SDBOT S SDS1="O",(SDOUT,SDNUL)=0,SDBOT(1)="Report print order selection",SDBOT(2)="This parameter determines the order in which the report will be printed."
 D DISP^SCRPW23("R E P O R T   P R I N T   O R D E R",.SDBOT)
 K DIR D DIRB1^SCRPW23("O",1,"ALPHABETIC") S DIR("A")="Select report print order",DIR(0)="S^A:ALPHABETIC;E:ENCOUNTER TOTAL;V:VISIT TOTAL;U:UNIQUE TOTAL",DIR("?")="Specify the order to print elements of selected perspective."
 S SDX=$$DIR^SCRPW23(.DIR,0) S:$L(SDX) SDPAR("O",1)=SDX Q:SDOUT
 D DESC^SCRPW22 Q:SDOUT  G:$$VO^SCRPW29() ORD Q
 ;
XY(X) ;Maintain $X, $Y
 ;Required input: X=screen handling variable to write
 N DX,DY S DX=$X,DY=$Y W X X SDXY Q ""
 ;
XPF ;Extra print fields
 D PF^SCRPW29 Q
 ;
REVIEW ;Review selected parameters
 D REVSCR,REV0 Q
 ;
REVSCR K SDBOT S SDTOP="S e l e c t e d   R e p o r t   P a r a m e t e r s",SDBOT(1)="Parameters selected for ACRP Ad Hoc Report",SDBOT(2)="These parameters will determine the appearance and data contained in the output."
 D DISP^SCRPW23(SDTOP,.SDBOT) Q
 ;
VERS ;Verify segments
 W ! F SDX="VF","VP","VL","VO" S SDX="$$"_SDX_"^SCRPW29(1)" I @(SDX)
 Q
 ;
REV0 S SDREV=1,SDOUT=0 D PLIST^SCRPW22(0,15) S SDOUT=0
REV1 D VERS W:SDOUT ! S SDOUT=0 W !?32,$$XY(IORVON)," Report action ",$$XY(IORVOFF)
 K DIR S DIR("A")="Select report action",DIR(0)="S^C:CONTINUE;E:EDIT PARAMETERS;R:RE-DISPLAY PARAMETERS;P:PRINT PARAMETERS;Q:QUIT",DIR("B")="CONTINUE",SDACT=$P($$DIR^SCRPW23(.DIR,0),U)
 I $D(DTOUT)!$D(DUOUT)!(SDACT="Q") S SDOUT=1 Q
 I SDACT="P" N ZTSAVE S ZTSAVE("SDPAR(")="" W ! D EN^XUTMDEVQ("PPAR^SCRPW27","ACRP Ad Hoc Report Parameters",.ZTSAVE) G REV1
 G:SDACT="R" REVIEW I SDACT="C" S SDOUT=0 D VERS D:SDOUT  Q
 .W !!,"Required information missing.  Unable to continue with queueing!" H 3 Q
 F  S (SDOUT,SDNUL)=0 W !!?31,$$XY(IORVON)," Re-edit actions ",$$XY(IORVOFF) D RDIR S SDACT=$P($$DIR^SCRPW23(.DIR,0),U) Q:SDOUT!SDNUL  D REV2,REVSCR Q:SDOUT!SDNUL
 S (SDOUT,SDNUL)=0 G REV1
 ;
RDIR K DIR S DIR("A")="Select section to re-edit",DIR(0)="SO^F:FORMAT;P:PERSPECTIVE;L:LIMITATIONS;O:ORDER;"_$$PFC^SCRPW29()_"A:ALL SECTIONS;E:EXIT FROM RE-EDIT" Q
 ;
REV2 I SDACT="E" S SDNUL=1 Q
 D @($S(SDACT="F":"FMT",SDACT="P":"PERS",SDACT="L":"LIM",SDACT="O":"ORD",SDACT="X":"XPF",1:"REV3")) Q
 ;
REV3 F SDACT="FMT","PERS","LIM","ORD","XPF" D @SDACT Q:SDOUT
 Q
 ;
F1 K DIR D DIRB1^SCRPW23("F",1,"SUMMARY") S DIR("A")="Select report format",DIR(0)="S^D:DETAILED;S:SUMMARY",DIR("?",1)="DETAILED format allows the listing of encounters, visits or uniques and ranked"
 S DIR("?",2)="lists of diagnoses and procedures for selected items in the selected",DIR("?",3)="perspective.  SUMMARY format provides subtotals of encounters, visits and"
 S DIR("?",4)="uniques for all items in a selected perspective and allows subtotals to be",DIR("?")="compared to the same date range in the previous year.",SDX=$$DIR^SCRPW23(.DIR,0) S:$L(SDX) SDPAR("F",1)=SDX D PFR^SCRPW29 Q
 ;
F2 I $P(SDPAR("F",1),U)="S" W ! K DIR D DIRB1^SCRPW23("F",2,"NO") S DIR("A")="Compare data to same date range for the previous year",DIR(0)="Y",SDX=$$DIR^SCRPW23(.DIR,0) S:$L(SDX) SDPAR("F",2)=SDX
 Q
 ;
F3 Q:$P(SDPAR("F",1),U)="S"  K DIR D DIRB1^SCRPW23("F",3)
 S DIR("A")="Select type of detail",DIR(0)="S^E:ENCOUNTER/VISIT/UNIQUE LIST;D:DIAGNOSIS/PROCEDURE RANKING;B:BOTH ACTIVITY & DX/PROC. LISTS",SDX=$$DIR^SCRPW23(.DIR,0) S:$L(SDX) SDPAR("F",3)=SDX D PFR^SCRPW29 Q
 ;
F4 Q:$P(SDPAR("F",1),U)="S"  Q:"BE"'[$P(SDPAR("F",3),U)
 K DIR D DIRB1^SCRPW23("F",4) S DIR("A")="List activity by",DIR(0)="S^E:ENCOUNTER;V:VISIT;U:UNIQUE",SDX=$$DIR^SCRPW23(.DIR,0) S:$L(SDX) SDPAR("F",4)=SDX D PFR^SCRPW29 Q
 ;
F5 Q:$P(SDPAR("F",1),U)="S"  Q:"BD"'[$P(SDPAR("F",3),U)  K DIR
 W ! D DIRB1^SCRPW23("F",5,50) S DIR("A")="Limit Dx/procedure list to most frequent",DIR(0)="N^1:999:0",DIR("?")="Specify how many of the most frequent items to list.",SDX=$$DIR^SCRPW23(.DIR,0) S:$L(SDX) SDPAR("F",5)=SDX Q
 ;
F6 K DIR W ! D DIRB1^SCRPW23("F",6,"FORMATTED TEXT") S DIR("A")="Produce output as",DIR(0)="S^F:FORMATTED TEXT;D:DELIMITED VALUES FOR EXPORT TO SPREADSHEET",SDX=$$DIR^SCRPW23(.DIR,0) S:$L(SDX) SDPAR("F",6)=SDX Q
 ;
P1 K DIR,SDPAR("X") D DIRB1^SCRPW23("P",1) S DIR("A")="Select report perspective",DIR("?")="Specify the element to be used for report subtotals." S SDNUL=0,SDS1="P",SDS2=1 D CAT^SCRPW22($S(SDREV:"E",1:"A")) Q:SDOUT
 Q
 ;
L1 N %DT,SDS1 D SUBT^SCRPW50("*** Date Range Selection ***")
FDT W ! S %DT="AEPX",%DT("A")="Beginning date: ",%DT(0)="-TODAY" D DIRB1^SCRPW23("L",1) S:$D(DIR("B")) %DT("B")=DIR("B") D ^%DT I X=U!($D(DTOUT)) S SDOUT=1 Q
 G:Y<1 FDT K:Y>$G(SDPAR("L",2)) SDPAR("L",2) S SDS1=Y X ^DD("DD") S SDPAR("L",1)=SDS1_U_Y
LDT W ! S %DT("A")="   Ending date: " D DIRB1^SCRPW23("L",2) S:$D(DIR("B")) %DT("B")=DIR("B") D ^%DT I X=U!($D(DTOUT)) S SDOUT=1 Q
 I Y<$P(SDPAR("L",1),U) W !!,$C(7),"Ending date must be after beginning date!" G LDT
 S SDS1=Y X ^DD("DD") S SDPAR("L",2)=SDS1_U_Y Q
 ;
L2 I SDREV D AED^SCRPW22("L") Q
L2A S SDS1="L",SDS2=$O(SDPAR(SDS1,""),-1),SDNUL=0 F  Q:SDOUT!SDNUL  S SDS2=SDS2+1 D:'$D(SDPAR(SDS1,SDS2)) L3
 Q
L3 S SDX="Select "_$S(SDS2=3:"additional",1:"another")_" output limiting factor:  (optional)" W !!?(80-$L(SDX)\2),$$XY(IORVON),SDX,$$XY(IORVOFF) D LDIR,CAT^SCRPW22("A") Q
 ;
LDIR K DIR S DIR("A")="Select limiting factor",DIR("?")="Specify elements to be used to restrict the scope of data returned." Q
