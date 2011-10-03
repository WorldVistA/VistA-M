GMRVHPO1 ;HIRMFO/YH-HP LASER PULSE OXIMETRY/RESP. GRAPH - FORM ;5/13/97
 ;;4.0;Vitals/Measurements;**1**;Apr 25, 1997
EN1 ;RESET PRINTER, SET PAGE SIZE (PORTRAIT) AND PCL PICTURE FRAME 8 1/2"*11"
 W !,$CHAR(27),"E",$CHAR(27),"&l1E",$CHAR(27),"*c5952x7920Y",$CHAR(27),"%0B"
 W !,"IN;SP1;IP;SC-3,18,-8,20,1;PW.3;PA0,0;FT3,1;RR16,20;PW.3;PA0,-2.8;EA16,20;PA-3,-2.8;EA16,0;PW.15;"
 S I(1)="" F I=1:1:5 S I(1)=I(1)_"PU"_(1.6*I)_",20;PD"_(1.6*I)_",-2.8;"
 W !,I(1)
 S I(1)="" F I=6:1:9 S I(1)=I(1)_"PU"_(1.6*I)_",20;PD"_(1.6*I)_",-2.8;"
 W !,I(1) K I
 W !,"PU16,-0.4;PD-3,-0.4;PU-3,-0.8;PD16,-0.8;PU16,-1.2;PD-3,-1.2;PU-3.-1.6;PD16,-1.6;PU16,-2.0;PD-3,-2.0;PU-3,-2.4;PD16,-2.4;PU;"
 ;PRINT LABEL
 W !,"DT#,1;"
 W !,"SD1,277,2,1,4,10,5,1,6,5,7,4;SS;LO12;PA-2,19.5;LBDate/Time#;PA-2.5,18.8;LBPulse Ox. Resp.#;PA-2,18;LB100     40#;"
 W !,"PA-2,17;LB 98     38#;" W !,"PA-2,16;LB 96     36#;PA-2,15;LB 94     34#;PA-2,14;LB 92     32#;PA-2,13;LB 90     30#;"
 W !,"PA-2,12;LB 88     28#;PA-2,11;LB 86     26#;"
 W !,"PA-2,10;LB 84     24#;PA-2,9;LB 82     22#;PA-2,8;LB 80     20#;PA-2,7;LB 78     18#;"
 W !,"PA-2,6;LB 76     16#;PA-2,5;LB 74     14#;PA-2,4;LB 72     12#;PA-2,3;LB 70     10#;PA-2,2;LB 68     8#;PA-2,1;LB 66     6#;"
 ;LABEL THE LOWER BOX
 W !,"SD1,277,2,1,4,8,5,1,6,5,7,4;SS;LO11;PA-3,-0.4;LBRespiration#;PA-3,-0.8;LBPulse Oximetry#;"
 W !,"PA-2.5,-1.2;LBL/Min#;PA-2.5,-1.6;LB%#;PA-2.5,-2;LBMethod#;"
 W !,"PA-3,-2.4;LBPulse#;"
 W !,"PA-3,-3.2;LBR: Respiration        POx: Pulse Oximetry         * - Abnormal value        ** - Abnormal value off of graph#;"
 W !,"PA-3,-3.6;LB"_$E($G(GLINE(1)),1,100)_"#;" W !,"LB"_$E($G(GLINE(1)),101,180)_"#;"
 W !,"PA-3,-3.9;LB"_$E($G(GLINE(2)),1,100)_"#;" W !,"LB"_$E($G(GLINE(2)),101,180)_"#;"
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;PA10,-4.9;LBPulse Oximetry/Respiration Graph#;"
 W !,"SD1,277,2,1,4,9,5,1,6,5,7,4;SS;PA10,-4.5;LBMedical Record#;PA10,-5.3;LBSF 512#;"
 I GTNM=0 W !,"PA3,10;LBTHERE  IS  NO  DATA  FOR  THIS  PERIOD#;"
 W "PW.3;SD1,277,2,1,4,8,5,1,6,5,7,4;SS;LO7;PU;" S I=0 F  S I=$O(GRAPHR(I)) Q:I'>0  W !,GRAPHR(I)
 W "PU;" S I=0 F  S I=$O(GRAPHP(I)) Q:I'>0  W !,GRAPHP(I)
 W !,"PU;LO1;" D EN1^GMRVHPO2
 D PTID^GMRVHPO3
 ;ENTER PCL MODE, RESET PRINTER AND EJECT PAGE
Q1 ;
 W !,"PA-3,22;",$CHAR(27),"&r0F",$CHAR(27),"%0A" K I Q
