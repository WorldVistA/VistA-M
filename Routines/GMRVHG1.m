GMRVHG1 ;HIRMFO/YH-HP LASER SF511 GRAPH - FORM ;2/3/99
 ;;4.0;Vitals/Measurements;**1,7**;Apr 25, 1997
EN1 ;RESET PRINTER, SET PAGE SIZE (PORTRAIT) AND PCL PICTURE FRAME 8 1/2"*11"
 W !,$CHAR(27),"E",$CHAR(27),"&l1E",$CHAR(27),"*c5952x7920Y",$CHAR(27),"%0B"
 W !,"IN;SP1;IP;SC-3,18,-15,13,1;PW.15;PA0,0;FT3,1;RR16,14;PW.3;EA16,14;PA-3,-9.2;EA16,0;"
 W !,"PW.3;PA0,0;PD0,-9.2;"
 S I(1)="" F I=1:1:5 S I(1)=I(1)_"PU"_(1.6*I)_",13;PD"_(1.6*I)_",-9.2;"
 W !,I(1)
 S I(1)="PW.15" F I=6:1:9 S I(1)=I(1)_"PU"_(1.6*I)_",13;PD"_(1.6*I)_",-9.2;"
 W !,I(1) K I
 W !,"PU-3,-9.2;PD16,-9.2;PU-3,-8.8;PD16,-8.8;PU16,-8.4;PD-3,-8.4;PU;"
 W !,"PA16,-8.0;PD-3,-8.0;PU-3,-7.6;PD16,-7.6;PU16,-7.2;PD-3,-7.2;PU-3,-6.8;PD16,-6.8;PU-3,-6.4;PD16,-6.4;PU16,-6.0;PD-3,-6.0;" W !,"PU-3,-5.6;PD16,-5.6;PU16,-5.2;PD-3,-5.2;"
  W !,"PU-3,-4.8;PD16,-4.8;PU16,-4.4;PD-3,-4.4;PU-3,-3.2;PD16,-3.2;PU16,-2.8;PD-3,-2.8;PU-3,-2.4;PD16,-2.4;PU16,-2.0;PD-3,-2.0;"
 W !,"PU-3,-1.6;PD16,-1.6;PU16,-1.2;PD-3,-1.2;PU-3,-0.4;PD16,-0.4;PU;"
 W !,"PW.3;PA0,5.6;PD16,5.6;PU;"
LABEL ;PRINT LABEL
 W !,"DT#,1;"
 W !,"SD1,277,2,1,4,10,5,1,6,5,7,4;SS;LO12;"
 W !,"PA-2,12.5;LBDate/Time#;PA-3,11.8;LB Pulse   Temp/F/C#;"
 W !,"PA-3,11;LB150#;PA-1.6,11,LB104/40.0#;" W !,"PA-3,10;LB140#;PA-1.6,10;LB103/39.4#;PA-3,9;LB130#;PA-1.6,9;LB102/38.9#;"
 W !,"PA-3,8;LB120#;PA-1.6,8;LB101/38.3#;PA-3,7;LB110#;PA-1.6,7;LB100/37.8#;"
 W !,"PA-3,6;LB100#;PA-1.6,6;LB 99/37.2#;PA-1.6,5.6;LB 98.6#;"
 W !,"PA-3,5;LB 90#;PA-1.6,5;LB 98/36.7#;PA-3,4;LB 80#;PA-1.6,4;LB 97/36.1#;PA-3,3;LB 70#;PA-1.6,3;LB 96/35.6#;"
 W !,"PA-3,2;LB 60#;PA-1.6,2;LB 95/35.0#;PA-3,1;LB 50#;PA-1.6,1;LB 94#;"
 ;LABEL THE LOWER BOX
 W !,"SD1,277,2,1,4,8,5,1,6,5,7,4;SS;LO11;PA-3,-0.3;LBTemperature#;PA-3,-0.7;LBPulse#;PA-3,-1.5;LBRespiration#;PA-3,-1.9;LBPulse Ox.#;"
 W !,"PA-3,-2.3;LB  L/Min#;PA-3,-2.7;LB  %#;"
 W !,"PA-3,-3.1;LB  Method#;PA-3,-3.5;LBBlood Pressure#;"
 W !,"PA-3,-4.7;LBWeight (lb)#;PA-3,-5.1;LB         (kg)#;PA-3,-5.5;LBBody Mass Index#;"
 W !,"PA-3,-5.9;LBHeight (in)#;PA-3,-6.3;LB         (cm)#;PA-3,-6.7;LBC/G (in)#;PA-2.5,-7.1;LB(cm)#;PA-3,-7.5;LBCVP#;PA-2,-7.5;LB(cm H2O)#;"
 W !,"PA-2,-7.9;LB(mm Hg)#;"
 W !,"PA-3,-8.3;LBIntake (24hr)(cc)#;PA-3,-8.7;LBOutput (24hr)(cc)#;"
 W !,"PA-3,-9.1;LBPain#;"
 W !,"PA-3,-9.6;LBT: Temperature     P: Pulse     C/G: Circumference/Girth     * - Abnormal value     **- Abnormal value off of graph#;"
 W !,"PA-3,-9.9;LBPAIN: 99 - Unable to respond  0 - No pain  10 - Worst imaginable pain#;"
 W !,"PA-3,-10.3;LB"_$E($G(GLINE(1)),1,100)_"#;" W !,"LB"_$E($G(GLINE(1)),101,180)_"#;"
 W !,"PA-3,-10.6;LB"_$E($G(GLINE(2)),1,100)_"#;" W !,"LB"_$E($G(GLINE(2)),101,180)_"#;"
 W !,"PA-3,-10.9;LB"_$E($G(GLINE(3)),1,100)_"#;" W !,"LB"_$E($G(GLINE(3)),101,180)_"#;"
 W !,"PA-3,-11.2;LB"_$E($G(GLINE(4)),1,100)_"#;" W !,"LB"_$E($G(GLINE(4)),101,180)_"#;"
 W 1,"PA-3,-11.5;LB"_$E($G(GLINE(5)),1,100)_"#;" W !,"LB"_$E($G(GLINE(5)),101,180)_"#;"
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;PA12,-11.7;LBVITAL FLOW SHEET#;"
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;PA12,-11.3;LBMEDICAL RECORD#;PA12,-12.1;LBVAF 10-7987 VICE SF 511#;"
 I GTNM=0 W !,"PA3,10;LBTHERE  IS  NO  DATA  FOR  THIS  PERIOD#;"
 W "SD1,277,2,1,4,8,5,1,6,5,7,4;SS;LO7;PU;" S I=0 F  S I=$O(GRAPHT(I)) Q:I'>0  W !,GRAPHT(I)
 W "PU;" S I=0 F  S I=$O(GRAPHP(I)) Q:I'>0  W !,GRAPHP(I)
 W !,"PU;LO1;" D EN1^GMRVHG2
 ;ENTER PCL MODE, RESET PRINTER AND EJECT PAGE
Q1 ;
 W !,"PA-3,18;",$CHAR(27),"&r0F",$CHAR(27),"%0A" K I,J Q
