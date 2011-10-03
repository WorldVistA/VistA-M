GMVWT2 ;HIOFO/YH,FT-KYOCERA WEIGHT GRAPH - MACRO ;11/6/01  14:49
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN1 W !,"!R! RES; DAM;"
BOX W !,"MCRO BOX;"
 W !,"UNIT C; SLM 3; STM 1; MAP 0,0; SPD 0.05; BOX 16,21.5; MAP -3,18; BOX 19,3.5;"
 W !,"FONT 40; MAP -2,0.4; TEXT 'Date/Time'; MAP -2,1; TEXT 'Pounds/Kgs'; "
 W !,"SPD 0.01; MAP -2,2; TEXT %1; MAP 0,1; DAP 16,1;"
 W !,"SPD 0.05; MAP -0.5,3; TEXT '5'; MAP 0,2; DAP 16,2;"
 W !,"SPD 0.01; MAP -2,4; TEXT %2; MAP 0,3; DAP 16,3;"
 W:GTNM=0 "MAP 2,5; TEXT 'THERE  IS  NO  DATA  FOR  THIS  PERIOD';"
 W !,"SPD 0.05; MAP -0.5,5; TEXT '5'; MAP 0,4; DAP 16,4;"
 W !,"SPD 0.01; MAP -2,6; TEXT %3; MAP 0,5; DAP 16,5;"
 W !,"SPD 0.05; MAP -0.5,7; TEXT '5'; MAP 0,6; DAP 16,6;"
 W !,"SPD 0.01; MAP -2,8; TEXT %4; MAP 0,7; DAP 16,7;"
 W !,"SPD 0.05; MAP -0.5,9; TEXT '5'; MAP 0,8; DAP 16,8;"
 W !,"SPD 0.01; MAP -2,10; TEXT %5; MAP 0,9; DAP 16,9;"
 W !,"SPD 0.05; MAP -0.5,11; TEXT '5'; MAP 0,10; DAP 16,10;"
 W !,"SPD 0.01; MAP -2,12; TEXT %6; MAP 0,11; DAP 16,11;"
 W !,"SPD 0.05; MAP -0.5,13; TEXT '5'; MAP 0,12; DAP 16,12;"
 W !,"SPD 0.01; MAP -2,14; TEXT %7; MAP 0,13; DAP 16,13;"
 W !,"SPD 0.05; MAP -0.5,15; TEXT '5'; MAP 0,14; DAP 16,14;"
 W !,"SPD 0.01; MAP -2,16; TEXT %8; MAP 0,15; DAP 16,15;"
 W !,"SPD 0.05; MAP -0.5,17; TEXT '5'; MAP 0,16; DAP 16,16;"
 W !,"SPD 0.01; MAP 0,17; DAP 16,17;"
BOX2 W !,"SPD 0.05;" S I(1)="" F I=1:1:9 S I(1)=I(1)_"MAP "_(1.6*I)_",0; DAP "_(1.6*I)_",21.5;"
 W !,"SPD 0.01; MAP -3,18.5; DAP 16,18.5; MAP -3,19; DAP 16,19; MAP -3,19.5; DAP 16,19.5; MAP -3,20; DAP 16,20; MAP -3,20.5; DAP 16,20.5; MAP -3,21; DAP 16,21;"
 W !,I(1)
 W !,"FONT 57; MAP -3,18.4; TEXT 'Weight (lb)'; MAP -3,18.9; TEXT '           (kg)'; MAP -3,19.4; TEXT 'Qualifier'; MAP -3,19.9; TEXT 'Body Mass Index';"
 W !,"MAP -3,20.4; TEXT 'Height (in)'; MAP -3,20.9; TEXT '          (cm)'; MAP -3,21.4; TEXT 'Qualifier';"
 W !,"MAP -3,21.9; TEXT 'W: Weight     ** - Value off of graph';"
FORM W !,"MAP 12,24; FONT 56; TEXT 'MEDICAL RECORD'; MAP 12,24.4; TEXT 'WEIGHT CHART'; MAP 12,24.8; TEXT 'VAF 10-2614f';"
 W !,"ENDM;"
DATE W !,"MCRO DATE;" S J=0.4 D WRTEXT^GMVBP2
 W !,"ENDM;"
TIME W !,"MCRO TIME;" S J=0.8 D WRTEXT^GMVBP2
 W !,"ENDM;"
HT W !,"MCRO HT;" S J=20.4 D WRTEXT^GMVBP2
 W !,"ENDM;" Q
