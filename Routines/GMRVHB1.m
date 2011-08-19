GMRVHB1 ;HIRMFO/YH-HP LASER B/P GRAPH - FORM ;5/15/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
EN1 ;RESET PRINTER, SET PAGE SIZE (PORTRAIT) AND PCL PICTURE FRAME 8"*11"
 W !,$CHAR(27),"E",$CHAR(27),"&l1E",$CHAR(27),"*c5952x7920Y",$CHAR(27),"%0B"
 W !,"IN;SP1;IP;SC-3,18,-8,20,1;PW.15;PA0,0;FT3,1;RR16,20;PW.3;PA0,-3;EA16,20;PA-3,-3;EA16,0;PW.15;"
 S I(1)="" F I=1:1:5 S I(1)=I(1)_"PU"_(1.6*I)_",20;PD"_(1.6*I)_",-3;"
 W !,I(1) S I(1)="" F I=6:1:9 S I(1)=I(1)_"PU"_(1.6*I)_",20;PD"_(1.6*I)_",-3;"
 W !,I(1) W !,"PU;"
 ;PRINT LABEL
 W !,"DT#,1;"
 W !,"SD1,277,2,1,4,10,5,1,6,5,7,4;SS;LO12;PA-2,19.5;LBDate/Time#;PA-2.5,18.8;LBBlood Pressure#;PA-1,18;LB220#;PA-1,17;LB210#;"
 W !,"PA-1,16;LB200#;PA-1,15;LB190#;PA-1,14;LB180#;PA-1,13;LB170#;PA-1,12;LB160#;PA-1,11;LB150#;PA-1,10;LB140#;"
 W !,"PA-1,9;LB130#;PA-1,8;LB120#;PA-1,7;LB110#;"
 W !,"PA-1,6;LB100#;PA-1,5;LB 90#;PA-1,4;LB 80#;PA-1,3;LB 70#;PA-1,2;LB 60#;PA-1,1;LB 50#;"
 ;LABEL THE LOWER BOX
 W !,"SD1,277,2,1,4,8,5,1,6,5,7,4;SS;LO11;PA-3,-0.4;LBPulse#;PA-3,-.5;PD16,-.5;PA16,-1;PD-3,-1;"
 W !,"PA-3,-1.4;LBBlood Pressure#;PU;PA-3,-1.5;PD16,-1.5;PA16,-2;PD-3,-2;PA-3,-2.5;PD16,-2.5;PU;PA-3,-2.9;LBMAP#;"
 W !,"PA-3,-3.4;LBS: Systolic B/P     D: Diastolic B/P     MAP: Mean Arterial Pressure   #;" W !,"LB  * - Abnormal value     ** - Abnormal value off of graph#;"
QUAL ;
 W !,"PA-3,-3.7;LB"_$E($G(GLINE(1)),1,100)_"#;" W !,"LB"_$E($G(GLINE(1)),101,180)_"#;"
 W !,"PA-3,-4;LB"_$E($G(GLINE(2)),1,100)_"#;" W !,"LB"_$E($G(GLINE(2)),101,180)_"#;"
 W !,"PA-3,-4.3;LB"_$E($G(GLINE(3)),1,100)_"#;" W !,"LB"_$E($G(GLINE(3)),101,180)_"#;"
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;PA12,-4.9;LBB/P PLOTTING CHART#;"
 W !,"PA12,-4.5;LBMEDICAL RECORD#;PA12,-5.3;LBVA STANDARD FORM 512-A#;"
 I GTNM=0 W !,"PA3,10;LBTHERE  IS  NO  DATA  FOR  THIS  PERIOD#;"
 W "SD1,277,2,1,4,8,5,1,6,5,7,4;SS;PW.3;LO7;PU;" S I=0 F  S I=$O(GRAPHS(I)) Q:I'>0  W !,GRAPHS(I)
 W "PU;" S I=0 F  S I=$O(GRAPHD(I)) Q:I'>0  W !,GRAPHD(I)
 W !,"PU;LO1;" D EN1^GMRVHB2
 ;ENTER PCL MODE, RESET PRINTER AND EJECT PAGE
Q1 ;
 W !,"PA-3,18;",$CHAR(27),"&r0F",$CHAR(27),"%0A" K I,J Q
