SPNGDINA ;WDE/SD OUTCOME GRID FOR DIENER 8/22/2002
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;this routine is called from SPNOGRDA
 ;to display the header information and to route the user to
 ;the right display.
ASK ;
REASK ;
 W !!!,"You have entered an INPT START or OUTPT START Diener's SWLS for a patient with"
 W !,SPNNEUR," level spinal cord injury and ASIA Impairment Scale of ",SPNIMPAR,"."
 W !,"Do you want to see a goal setting template you can copy and paste"
 W !,"into a CPRS progress note "
 S %=2
 D YN^DICN
 I %=0 W !!,"Answer with Yes or No." W !,*7 G REASK
 I %=-1 Q
 Q:%=2
 Q
EN ;
 ;
 I "C01C02C03C04"[SPNNEUR I "ABC"[SPNIMPAR S SPNNEUR="a C1-C4",SPNIMPAR="A or B or C" S SPNROU="SPNGDINB" S SPNTAG="DIN2" D ASK I %=1 D SHOW
 ;
 I "C05C06C07C08"[SPNNEUR I "ABC"[SPNIMPAR S SPNNEUR="a C5-C8",SPNIMPAR="Aor B or C" S SPNROU="SPNGDINB" S SPNTAG="DIN3" D ASK I %=1 D SHOW
 ;
 I "T01T02TO3T04T05T06T07T08T09T10T11T12L01L02L03L04L05S01S02S03S04S05"[SPNNEUR I "ABC"[SPNIMPAR S SPNNEUR=" a T1-S5",SPNIMPAR="A or B or C" S SPNROU="SPNGDINB" S SPNTAG="DIN4" D ASK I %=1 D SHOW
 ;
 I "C01C02C03C04C05C06C07C08T01T02T03T04T05T06T07T08T09T10T11T12L01L02L03L04L05S01S02S03S04S05"[SPNNEUR I "D"[SPNIMPAR S SPNNEUR="any neurologic",SPNIMPAR="D" S SPNROU="SPNGDINB" S SPNTAG="DIN5" D ASK I %=1 D SHOW
 Q
ZAP ;
 Q
SHOW ;
 ;
 D COPY1^SPNGCOPY
 S X=$P($G(^SPNL(154.1,DA,"SCORE")),U,1) S:X="" X=0
 I $D(IOF) W @IOF
 W !,"----------------------------------------------------------"
 W !,"|                           |  Diener's SWLS Composite   |"
 W !,"----------------------------------------------------------"
 W !,"|Start                      |",?42,X,?57,"|"
 S SPNX=""
 F SPNLINE=1:1 D  Q:SPNX["EOR999"
 .S X="S SPNX=$T("_SPNTAG_"+"_SPNLINE_"^"_SPNROU_")"
 .X X
 .Q:SPNX["EOR999"
 .W !,$P(SPNX,";;",2)
 R !?10,"Press Return to continue",SPNRD:DTIME
