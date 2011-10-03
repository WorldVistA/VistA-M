SPNGFIMK ;WDE/SD OUTCOME GRID FOR FIM 8/22/2002
 ;;2.0;Spinal Cord Dysfunction;**19**;01/02/1997
 ;this routine is called from SPNOGRDA
 ;to display the header information and to route the user to
 ;the right display.
 ;
 ;unlike the other grids this one needs a fim start, fim finish and an 
 ; asia on file
ASK ;
REASK ;
 W !!,"You have entered an INPT REHAB FINISH FIM for a patient with ",SPNNEUR
 W !,"spinal cord injury level and ASIA Impairment Scale of ",SPNIMPAR,"."
 W !
 W !,"Do you want to see a comparison template you can copy and paste into a CPRS"
 W !,"progress note "
 S %=2
 D YN^DICN
 I %=0 W !!,"Answer with Yes or No." W !,*7 G REASK
 I %=-1 Q
 Q:%=2
 Q
EN ;
 D CALC^SPNGFIMM
 Q:$D(SPNGFIS)=0
 Q:SPNGFIS=""
 ;ABOVE QUIT IF THERE IS NO FIM START ON FILE
 I "C01C02C03C04"[SPNNEUR I "ABC"[SPNIMPAR S SPNNEUR="a C1-C4",SPNIMPAR="A or B or C" S SPNROU="SPNGFIML" S SPNTAG="FIM26" D ASK I %=1 D SHOW
 ;
 I "C05C06C07C08"[SPNNEUR I "ABC"[SPNIMPAR S SPNNEUR="a C5-C8",SPNIMPAR="A or B or C" S SPNROU="SPNGFIML" S SPNTAG="FIM27" D ASK I %=1 D SHOW
 ;
 I "T01T02T03T04T05T06T07T08T09T10T11T12L01L02L03L04L05S01S02S03S04S05"[SPNNEUR I "ABC"[SPNIMPAR S SPNNEUR=" a T1-S5",SPNIMPAR="A or B or C" S SPNROU="SPNGFIML" S SPNTAG="FIM28" D ASK I %=1 D SHOW
 ;
 I "C01C02C03C04C05C06C07C08T01T02T03T04T05T06T07T08T09T10T11T12L01L02L0L04L05S01S02S03S04S05"[SPNNEUR I "D"[SPNIMPAR S SPNNEUR="any neurologic",SPNIMPR="D" S SPNROU="SPNGFIML" S SPNTAG="FIM29" D ASK I %=1 D SHOW
 Q
SHOW ;
 ;
 D COPY2^SPNGCOPY
 S SPNX=""
 I $D(IOF) W @IOF
 W !,"---------------------------------------------------------------------"
 W !,"|      | Total | Total   | Motor | Motor   | Cognitive | Cognitive  |"
 W !,"|      | Gain  | Efficny | Gain  | Efficny |   Gain    |  Efficny   |"
 W !,"---------------------------------------------------------------------"
 W !,"|      |",?10,SPNR1C1,?15,"|",?18,SPNR1C2,?25,"|",?28,SPNR1C3,?33,"|"
 W ?36,SPNR1C4,?43,"|",?49,SPNR1C5,?55,"|",?59,SPNR1C6,?68,"|"
 F SPNLINE=1:1 D  Q:SPNX["EOR999"
 .S X="S SPNX=$T("_SPNTAG_"+"_SPNLINE_"^"_SPNROU_")"
 .X X
 .Q:SPNX["EOR999"
 .W !,$P(SPNX,";;",2)
 R !!!?10,"Press Return to continue",SPNRD:DTIME
