GMRVKPN1 ;HCIOFO/YH-KYOCERA PAIN CHART MACRO-1 ;2/12/99
 ;;4.0;Vitals/Measurements;**9**;Apr 25, 1997
EN1 W !,"!R! RES; DAM;"
BOX W !,"MCRO BOX;"
 W !,"UNIT C; SLM 3; STM 1; MAP 0,0; SPD 0.05; BOX 16,13;"
 W !,"FONT 40; MAP -2,0.5; TEXT 'Date/Time';"
 W !,"SPD 0.01; MAP -0.5,2; TEXT '10'; MAP 0,1; DAP 16,1;MAP 16,1; DAP 0,1;"
 W !,"MAP -0.5,3; TEXT '9'; MAP 0,2; DAP 16.2,2;"
 W !,"MAP -0.5,4; TEXT '8'; MAP 0,3; DAP 16,3;"
 W:GTNM=0 "MAP 2,5; TEXT 'THERE  IS  NO  DATA  FOR  THIS  PERIOD';"
 W !,"MAP -0.5,5; TEXT '7'; MAP 0,4; DAP 16,4;"
 W !,"MAP -0.5,6; TEXT '6';MAP 0,5; DAP 16,5;"
 W !,"MAP -0.5,7; TEXT '5'; MAP 0,6; DAP 16,6;"
 W !,"MAP -0.5,8; TEXT '4'; MAP 0,7; DAP 16,7;"
 W !,"MAP -0.5,9; TEXT '3'; MAP 0,8; DAP 16,8;"
 W !,"MAP -0.5,10; TEXT '2'; MAP -0.5,11; TEXT '1'; MAP 0,9; DAP 16,9;"
 W !,"MAP 0,10; DAP 16,10;"
 W !,"MAP 0,11; DAP 16,11;"
 W !,"MAP -1,12.7; TEXT 'Pain';"
VERT W !,"SPD 0.05;" S I(1)="" F I=1:1:9 S I(1)=I(1)_"MAP "_(1.6*I)_",0; DAP "_(1.6*I)_",13;"
 W !,I(1) W !,"MAP 16,12; DAP 0,12;"
 W !,"MAP 0,13.5; TEXT '0 - No pain   10 - Worst imaginable pain   99 - Unable to respond';"
FORM W !,"MAP 12,22.4; TEXT 'Medical Record'; MAP 12,22.8; TEXT 'Pain Chart'; MAP 12,23.2; TEXT 'SF 512';"
 W !,"ENDM;"
DATE W !,"MCRO DATE; FONT 56;" S J=0.4 D WRTEXT^GMRVBP2
 W !,"ENDM;"
TIME W !,"MCRO TIME;" S J=0.8 D WRTEXT^GMRVBP2
 W !,"ENDM;"
RPG W !,"MCRO RPG; SPD 0.03; MAP %1, %2; DAP 2, %3; DAP 3.6, %4; DAP 5.2, %5; DAP 6.8, %6; DAP 8.4, %7; DAP 10, %8; DAP 11.6, %9;"
 W !,"DAP 13.2, %10; DAP 14.8, %11;"
 W !,"ENDM;"
RESP W !,"MCRO RSP;" S J=12.7 D
 . S I(1)="" F I=1:1:5 S I(1)=I(1)_$S(I(1)="":"",1:" ")_"MAP "_(1.6*(I-1)+0.2)_","_J_"; TEXT %"_I_";"
 . W !,I(1)
 . S I(1)="" F I=6:1:10 S I(1)=I(1)_$S(I(1)="":"",1:" ")_"MAP "_(1.6*(I-1)+0.2)_","_J_"; TEXT %"_I_";"
 . W !,I(1)
 W !,"ENDM;"
PID W !,"MCRO PID; MAP -2,21.6; TEXT %1; MAP -2,22; TEXT %2; MAP 2.5,22; TEXT %3; MAP -2,22.4; TEXT %4; MAP 6,23.2; TEXT %5; MAP 6,22.8; TEXT %6; MAP -2,22.8; TEXT %7; MAP -2,23.2; TEXT %8;"
 W !,"ENDM;"
RS1 W !,"MCRO RS1; MAP %1,%2; TEXT %3; MAP 2.0,%4; TEXT %5; MAP 3.6,%6; TEXT %7; MAP 5.2,%8; TEXT %9; MAP 6.8,%10; TEXT %11; MAP 8.4,%12; TEXT %13; MAP 10,%14; TEXT %15; MAP 11.6,%16; TEXT %17; MAP 13.2,%18; TEXT %19;"
 W !,"ENDM;"
RS2 W !,"MCRO RS2; MAP 14.8,%1; TEXT %2;"
 W !,"ENDM;"
 Q
