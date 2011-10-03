GMVGR2 ;HIOFO/YH,FT-VITALS GRAPH KYOCERA DEFINE MACRO (PART 1) ;11/8/01  14:54
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN1 W !,"!R! RES; DAM;"
BOX W !,"MCRO BOX;"
 W !,"UNIT C; SLM 3; STM 1; MAP 0,0; SPD 0.05; BOX 16,22.2; MAP -2.5,13; BOX 18.5,9.2;"
 W !,"FONT 40; MAP -2,0.5; TEXT 'Date/Time'; MAP -2.7,1; TEXT 'Pulse'; MAP -1.7,1; TEXT 'Temp/F/C';"
 W !,"SPD 0.01; MAP -2.7,2; TEXT '150'; MAP -1.5,2; TEXT '104/40.0'; MAP 0,1; DAP 16,1;"
 W !,"MAP -2.7,3; TEXT '140'; MAP -1.5,3; TEXT '103/39.4'; MAP 0,2; DAP 16,2;"
 W !,"MAP -2.7,4; TEXT '130'; MAP -1.5,4; TEXT '102/38.9'; MAP 0,3; DAP 16,3;"
 W:GTNM=0 "MAP 2,5; TEXT 'THERE  IS  NO  DATA  FOR  THIS  REPORT';"
 W !,"MAP -2.7,5; TEXT '120'; MAP -1.5,5; TEXT '101/38.3'; MAP 0,4; DAP 16,4;"
 W !,"MAP -2.7,6; TEXT '110'; MAP -1.5,6; TEXT '100/37.8'; MAP 0,5; DAP 16,5;"
 W !,"MAP -2.7,7; TEXT '100'; MAP -1.5,7; TEXT '99/37.2'; MAP 0,6; DAP 16,6;"
 W !,"SPD 0.05; MAP -1.5,7.4; TEXT '98.6'; MAP 0,7.4; DAP 16,7.4;"
 W !,"SPD 0.01; MAP -2.7,8; TEXT '90'; MAP -1.5,8; TEXT '98/36.7'; MAP 0,7; DAP 16,7; MAP 0,8; DAP 16,8;"
 W !,"MAP -2.7,9; TEXT '80'; MAP -1.5,9; TEXT '97/36.1'; MAP 0,9; DAP 16,9;"
 W !,"MAP -2.7,10; TEXT '70'; MAP -1.5,10; TEXT '96/35.6'; MAP 0,9; DAP 16,9;"
 W !,"MAP -2.7,11; TEXT '60'; MAP -1.5,11; TEXT '95/35.0'; MAP 0,10; DAP 16,10;"
 W !,"MAP -2.7,12; TEXT '50'; MAP -1.5,12; TEXT '94'; MAP 0,11; DAP 16,11; MAP 16,12; DAP0,12;"
BOX2 W !,"MAP -2.5,13.4; DAP 16,13.4; MAP -2.5,14.2; DAP 16,14.2; MAP -2.5,14.6; DAP 16,14.6; MAP -2.5,15; DAP 16,15; MAP -2.5,15.4; DAP 16,15.4;"
 W !,"MAP -2.5,15.8; DAP 16,15.8; MAP -2.5,16.2; DAP 16,16.2; MAP -2.5,17.4; DAP 16,17.4; MAP -2.5,17.8; DAP 16,17.8;"
 W !,"MAP -2.5,18.2; DAP 16,18.2; MAP -2.5,18.6; DAP 16,18.6; MAP -2.5,19; DAP 16,19; MAP -2.5,19.4; DAP 16,19.4; MAP -2.5,19.8; DAP 16,19.8;"
 W !,"MAP -2.5,20.2; DAP 16,20.2; MAP -2.5,20.6; DAP 16,20.6; MAP -2.5,21; DAP 16,21; MAP -2.5,21.4; DAP 16,21.4;"
 W !,"MAP -2.5,21.8; DAP 16,21.8;MAP -2.5,22.2; DAP 16,22.2;"
 W !,"FONT 57; MAP -2.4,13.3; TEXT 'Temperature'; MAP -2.4,13.7; TEXT 'Pulse'; MAP -2.4,14.5; TEXT 'Respiration';"
 W !,"MAP -2.4,14.9; TEXT 'Pulse Ox.'; MAP -2.2,15.3; TEXT 'L/Min'; MAP -2.2,15.7; TEXT %1; MAP -2.2,16.1; TEXT 'Method';"
 W !,"MAP -2.4,16.6; TEXT 'Blood Pressure';"
 W !,"MAP -2.4,17.7; TEXT 'Weight (lb)'; MAP -1.5,18.1; TEXT '(kg)'; MAP -2.4,18.5; TEXT 'Body Mass Index'; MAP -2.4,18.9; TEXT 'Height (in)'; MAP -1.5,19.3; TEXT '(cm)';"
 W !,"MAP -2.4,19.7; TEXT 'C/G (in)'; MAP -1.9,20.1; TEXT '(cm)'; MAP -2.4,20.5; TEXT 'CVP'; MAP -1.5,20.5; TEXT '(cm H2O)'; MAP -1.5,20.9; TEXT '(mm Hg)';"
 W !,"MAP -2.4,21.3; TEXT 'Intake (24hr)(cc)'; MAP -2.4,21.7; TEXT 'Output (24hr)(cc)';" W !," MAP -2.4,22.1; TEXT 'Pain';"
VERT W !,"SPD 0.03;" S I(1)="" F I=1:1:9 S I(1)=I(1)_"MAP "_(1.6*I)_",0; DAP "_(1.6*I)_",22.2;"
 W !,I(1)
 W !,"MAP -2.4,22.6; TEXT 'T: Temperature     P: Pulse     C/G: Circumference/Girth     * - Abnormal value     ** - Abnormal value off of graph';"
 W !,"MAP -2.4,22.9; TEXT 'Pain:  99 - Unable to respond   0 - No pain   10 - Worst imaginable pain';"
FORM W !,"MAP 12,25.3; TEXT 'MEDICAL RECORD'; MAP 12,25.6; TEXT 'VITAL FLOW SHEET'; MAP 12,25.9; TEXT 'VAF 10-7987 VICE SF 511';"
 W !,"ENDM;"
DATE W !,"MCRO DATE; FONT 56;" S J=0.4 D WRTEXT^GMVBP2
 W !,"ENDM;"
TIME W !,"MCRO TIME;" S J=0.8 D WRTEXT^GMVBP2
 W !,"ENDM;"
WT W !,"MCRO WT;" S J=17.7 D WRTEXT^GMVBP2
 W !,"ENDM;"
WTKG W !,"MCRO WTKG;" S J=18.1 D WRTEXT^GMVBP2
 W !,"ENDM;"
HT ;
 D HT^GMVGR7
 Q
