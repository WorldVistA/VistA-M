GMRVBP2 ;HIRMFO/YH-DEFINE KYOCERA BP GRAPH MACRO ;5/16/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
EN1 W !,"!R! RES; DAM;"
BOX W !,"MCRO BOX;"
 W !,"UNIT C; SLM 3; STM 1; MAP 0,0; SPD 0.05; BOX 16,23; MAP -3,20; BOX 19,3;"
 W !,"FONT 40; MAP -2,0.5; TEXT 'Date/Time'; MAP -2.5,1; TEXT 'Blood Pressure';"
 W !,"SPD 0.01; MAP -0.8,2; TEXT '220'; MAP 0,1; DAP 16,1; MAP -0.8,3; TEXT '210'; MAP 0,2; DAP 16,2;"
 W !,"MAP -0.8,4; TEXT '200'; MAP 0,3; DAP 16,3;"
 W:GTNM=0 "MAP 2,5; TEXT 'THERE  IS  NO  DATA  FOR  THIS  REPORT';"
 W !,"MAP -0.8,5; TEXT '190'; MAP 0,4; DAP 16,4; MAP -0.8,6; TEXT '180'; MAP 0,5; DAP 16,5; MAP -0.8,7; TEXT '170'; MAP 0,6; DAP 16,6;"
 W !,"MAP -0.8,8; TEXT '160'; MAP 0,7; DAP 16,7;"
 W !,"MAP -0.8,9; TEXT '150'; MAP 0,8; DAP 16,8; MAP -0.8,10; TEXT '140'; MAP 0,9; DAP 16,9; MAP -0.8,11; TEXT '130'; MAP 0,10; DAP 16,10;"
 W !,"MAP -0.8,12; TEXT '120'; MAP 0,11; DAP 16,11; MAP -0.8,13; TEXT '110'; MAP 0,12; DAP 16,12; MAP -0.8,14; TEXT '100'; MAP 0,13; DAP 16,13;"
 W !,"MAP -0.7,15; TEXT '90'; MAP 0,14; DAP 16,14; MAP -0.7,16; TEXT '80'; MAP 0,15; DAP 16,15; MAP -0.7,17; TEXT '70'; MAP 0,16; DAP 16,16;"
 W !,"MAP -0.7,18; TEXT '60'; MAP 0,17; DAP 16,17; MAP -0.7,19; TEXT '50'; MAP 0,18; DAP 16,18; MAP 0,19; DAP 16,19;"
BOX2 ;
 W !,"FONT 57; MAP -3,20.4; TEXT 'Pulse'; SPD .03; MAP -3,20.5; DAP 16,20.5; MAP -3,21;DAP 16,21; MAP -3,21.4; TEXT 'Blood Pressure';"
 W !,"MAP -3,21.5; DAP 16,21.5; MAP 16,22; DAP -3,22; MAP -3,22.5; DAP 16,22.5; MAP -3,22.9; TEXT 'MAP';"
VERT W !,"SPD 0.03;" S I(1)="" F I=1:1:9 S I(1)=I(1)_"MAP "_(1.6*I)_",0; DAP "_(1.6*I)_",23;"
 W !,I(1)
 W !,"FONT 57; MAP -3,23.4; TEXT 'S: Systolic B/P     D: Diastolic B/P     MAP: Mean Arterial Pressure     * - Abnormal value     ** - Abnormal value off of graph';"
FORM W !,"MAP 12,25; FONT 56; TEXT 'MEDICAL RECORD'; MAP 12,25.4; TEXT 'B/P PLOTTING CHART'; MAP 12,25.8; TEXT 'VA STANDARD FORM 512-A';"
 W !,"ENDM;"
DATE W !,"MCRO DATE; FONT 56;" S J=0.4 D WRTEXT
 W !,"ENDM;"
TIME W !,"MCRO TIME;" S J=0.8 D WRTEXT
 W !,"ENDM;"
 Q
WRTEXT ;
 S I(1)="" F I=1:1:5 S I(1)=I(1)_$S(I(1)="":"",1:" ")_"MAP "_(1.6*(I-1))_","_J_"; TEXT %"_I_";"
 W !,I(1)
 S I(1)="" F I=6:1:10 S I(1)=I(1)_$S(I(1)="":"",1:" ")_"MAP "_(1.6*(I-1))_","_J_"; TEXT %"_I_";"
 W !,I(1) Q
