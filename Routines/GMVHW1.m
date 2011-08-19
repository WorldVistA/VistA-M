GMVHW1 ;HIOFO/YH,FT-HP LASER WEIGHT CHART - FORM AND GRAPH ;11/6/01  15:23
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
EN1 ;RESET PRINTER, SET PAGE SIZE (PORTRAIT) AND PCL PICTURE FRAME 8 1/2"*11"
 W !,$CHAR(27),"E",$CHAR(27),"&l1E",$CHAR(27),"*c5952x7920Y",$CHAR(27),"%0B"
 W !,"IN;SP1;IP;SC-3,18,-10,18,1;PW.15;PA0,0;FT3,1;RR16,18;PW.3;PA0,-3.5,EA16,18;PA-3,-3.5;EA16,0;PW.15;"
 S I(1)="" F I=1:1:5 S I(1)=I(1)_"PU"_(1.6*I)_",18;PD"_(1.6*I)_",-3.5;"
 W !,I(1) S I(1)="" F I=6:1:10 S I(1)=I(1)_"PU"_(1.6*I)_",18;PD"_(1.6*I)_",-3.5;"
 W !,I(1),"PU;"
 W !,"PA16,-3;PD-3,-3;PA-3,-2.5;PD16,-2.5;PU16,-2;PD-3,-2;PU-3,-1.5;PD16,-1.5;PU16,-1;PD-3,-1;PU-3,-0.5;PD16,-0.5;PU;"
LABEL ;PRINT LABEL
 W !,"DT#,1;"
 W !,"PW.3;SD1,277,2,1,4,10,5,1,6,5,7,4;SS;LO12;PA-2,17.5;LBDate/Time#;PA-2,16.9;LBPounds/Kgs#;PA-2,16;LB"_GWT(8)_"#;PA0,16;PD16,16;PU;"
 W !,"PA-.4,15;LB5#;PA-2,14;LB"_GWT(7)_"#;PA0,14;PD16,14;PU;;PA-.4,13;LB5#;PA-2,12;LB"_GWT(6)_"#;PA0,12;PD16,12;PU;"
 W !,"PA-.4,11;LB5#;PA-2,10;LB"_GWT(5)_"#;PA0,10;PD16,10;PU;PA-.4,9;LB5#;"
 W !,"PA-2,8;LB"_GWT(4)_"#;PA0,8;PD16,8;PU;PA-.4,7;LB5#;PA-2,6;LB"_GWT(3)_"#;PA0,6;PD16,6;PU;PA-.4,5;LB5#;"
 W !,"PA-2,4;LB"_GWT(2)_"#;PA0,4;PD16,4;PU;PA-.4,3;LB5#;PA-2,2;LB"_GWT(1)_"#;PA0,2;PD16,2;PU;PA-.4,1;LB5#;"
LBOX ;LABEL THE LOWER BOX
 W !,"SD1,277,2,1,4,8,5,1,6,5,7,4;SS;LO11;PA-3,-0.5;LBWeight (lb)#;PA-3,-1;LB          (kg)#;PA-3,-1.5;LB   Qualifier#;"
 W !,"PA-3,-2;LBBody Mass Index#;"
 W !,"PA-3,-2.5;LBHeight (in)#;PA-3,-3;LB         (cm)#;PA-3,-3.5;LB   Qualifier#;"
 W !,"SD1,277,2,1,4,8,5,1,6,5,7,4;SS;"
 W !,"PA-3,-4;LBW: Weight      ** - Value off of graph#;"
 W !,"PA-3,-4.3;LB"_$E($G(GLINE(1)),1,100)_"#;" W !,"LB"_$E($G(GLINE(1)),101,180)_"#;"
 W !,"PA-3,-5.1;LB"_$E($G(GLINE(2)),1,100)_"#;"
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;PA12,-6;LBWEIGHT CHART#;"
 W !,"PA12,-5.6;LBMEDICAL RECORD#;PA12,-6.4;LBVAF 10-2614f#;"
 I GTNM=0 W !,"PA3,10;LBTHERE  IS  NO  DATA  FOR  THIS  PERIOD#;"
 W "SD1,277,2,1,4,8,5,1,6,5,7,4;SS;PW.3;LO7;PU;" S I=0 F  S I=$O(GRAPHW(I)) Q:I'>0  W !,GRAPHW(I)
 W !,"PU;LO1;" D EN1^GMVHW2
 ;ENTER PCL MODE, RESET PRINTER AND EJECT PAGE
Q1 ;
 W !,"PA-3,18;",$CHAR(27),"&r0F",$CHAR(27),"%0A" Q
