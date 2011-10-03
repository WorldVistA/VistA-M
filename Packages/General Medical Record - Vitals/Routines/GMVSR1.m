GMVSR1 ;HIOFO/RM,YH-PATIENT VITAL SIGNS-I/O SF 511 GRAPH - 1 ;11/6/01  16:00
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10061 - ^VADPT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
SF511 ;PRODUCE PATIENT VITAL SIGNS-I/O GRAPH
 S GRPT=5,GMRHT=0 D SETIO^GMVGR0 D DEM^VADPT,INP^VADPT S GMRBTH=$P(VADM(3),"^",2),GMRNAM=VADM(1)
 F GMRK="P","T","B","H","W","R","PO2","CVP","CG","XI1","PN" D GMRDT^GMVVS3
 I $D(^TMP($J,"GMRVG","I")) F GMRI=0:0 S GMRI=$O(^TMP($J,"GMRVG","I",GMRI)) Q:GMRI'>0  S GFOUND=0 D CKDT^GMVVS3 S:GFOUND=0 ^TMP($J,"GMRDT",GMRI)=""
 I $D(^TMP($J,"GMRVG","O")) F GMRI=0:0 S GMRI=$O(^TMP($J,"GMRVG","O",GMRI)) Q:GMRI'>0  S GFOUND=0 D CKDT^GMVVS3 S:GFOUND=0 ^TMP($J,"GMRDT",GMRI)=""
 S (GMRTNM,GMRI)=0 I $D(^TMP($J,"GMRDT")) F  S GMRI=$O(^TMP($J,"GMRDT",GMRI)) Q:GMRI'>0  S GMRTNM=GMRTNM+1
 D GRAPH K GMR3,GMRDAT,GMREN,GMRHDR1,GMRHDR11,GMRHDR10,GMRHDR2,GMRHT,GMRI,GMRJ,GMRK,GMRLINE,GDATA,GMROLD,GMRP,GMRPDIF,GMRPG,GMRPGC,GMRPGS,GMRPHI,GMRPLO,GMRPOFF,GMRSITE,GMRT,GMRTDIF,GMRTHI,GMRTLO,GMRTNM
 K GLPRNTR,GMRTOFF,GMRTY,GMRNM,GMRVX,GMRVX1,GMRVX2,^TMP($J,"GMRDT"),^TMP($J,"GMRG"),^TMP($J,"GMR")
 Q
GRAPH ;
 S:'$D(GFLAG) GFLAG=0 S GMRPGC=0,GMRX1="" F X=1:1:10 S GMRX1=GMRX1_"          "_"|"
 S (GMRX,GMRX2)=GMRX1 F X=1:1:10 S $P(GMRX,"|",X)="__________",$P(GMRX2,"|",X)="----------"
 S GMRPG=$S(GMRTNM=0:1,1:GMRTNM\10+$S(GMRTNM#10>0:1,1:0)) F GMRPGS=1:1:GMRPG S GMRTLO=105.8335,GMRPLO=168.335 D PAGE Q:GMROUT
 K GDIP,GDOP,GRNDIP,GRNDOP,GSIP,GSOP Q
PAGE ;
 K GMRQUAL,GLINE W:'($E(IOST)'="C"&'GFLAG) @IOF S GFLAG=1,GMRPGC=GMRPGC+1 W !
 I '$D(^TMP($J,"GMR")) W !!!!!!!!,?5,"THERE  IS  NO  DATA  FOR  THIS  REPORT" X "F Y=$Y:1:(IOSL-6) W !" D FOOTER^GMVVS2 Q
 W ! D DATES^GMVVS2 W !,?3,"Pulse Temp/F/C",?17,"|",?18,GMRX
 F GMRI=0:0 Q:$Y>43  W ! D SETHD^GMVVS4 W ?2,$S(GMRHDR1'["41.1":GMRHDR1,1:""),?16,$S(GMR3!($Y=28):"-",1:""),?17,"|" D DATAPRT^GMVVS4
 W !,?17,"|",GMRX2 F GMRI="T","P","R","B","B1","B2","W","H","PO2","CVP","CG","PN" S GMRLINE(GMRI)=GMRX1
 S (GMRLINE("H1"),GMRLINE("W1"),GMRLINE("BMI"),GMRLINE("P1"),GMRLINE("OX1"),GMRLINE("OX2"),GMRLINE("OX3"),GMRLINE("CVP1"),GMRLINE("CG1"),GMRLINE("CG2"))=GMRX1
 S GMRNM=0 F GMRDT=0:0 S GMRDT=$O(^TMP($J,"GMRDT",GMRDT)) Q:GMRDT'>0  S GMRNM=GMRNM+1 Q:GMRNM>10  F GMRI="T","P","R","H","W","PO2","CVP","CG","PN" D:$D(^TMP($J,"GMR",GMRI,GMRDT)) STLNP^GMVVS1
 S GMRNM=0 F GMRDT=0:0 S GMRDT=$O(^TMP($J,"GMRDT",GMRDT)) Q:GMRDT'>0  S GMRNM=GMRNM+1 Q:GMRNM>10  D BP^GMVVS2
 F GMRI="T","P","P1","R","PO2","OX1","OX2","OX3","B","B1","B2","W","W1","BMI","H","H1","CG","CG2","CVP","CVP1" D
 .S G=$S(GMRI="T":"Temperature",GMRI="P":"Pulse",GMRI="R":"Respiration",GMRI="W":"Weight (lb)",GMRI="H":"Height (in)",GMRI="B":"BLOOD",GMRI="B1":"  PRESSURE",GMRI="W1":"       (kg)",GMRI="H1":"       (cm)",GMRI="BMI":"Body Mass Index",1:"")
 . I G="" S G=$S(GMRI="PO2":"Pulse Ox.",GMRI="OX1":"  L/Min",GMRI="OX2":"  %",GMRI="OX3":"  Method",GMRI="CG":"C/G (in)",GMRI="CVP":"CVP (cm H2O)",GMRI="CVP1":"    (mm Hg)",GMRI="CG2":"    (cm)",1:"")
 . W !,G,?17,"|",GMRLINE(GMRI)
 D IO
 S G="Pain" W !,G,?17,"|",GMRLINE("PN")
 I 'GMROUT W !,?17,$$REPEAT^XLFSTR("-",111)
 W !,"T: Temperature     P: Pulse     C/G: Circumference/Girth     * - Abnormal value     ** - Abnormal value off of graph"
 W !,"Pain:  99 - Unable to respond  0 - No pain  10 - Worst imaginable pain"
 W ! I $D(GMRQUAL) S GLPRNTR=1 D LEGEND^GMVLGQU F I=1:1:5 W !,GLINE(I)
 I IOSL'<($Y+10) F X=1:1 W ! Q:IOSL<($Y+10)
 D FOOTER^GMVVS2 S GMRDT="" F GMRNM=1:1:10 S GMRDT=$O(^TMP($J,"GMRDT",GMRDT)) Q:GMRDT'>0  K ^TMP($J,"GMRDT",GMRDT)
 K GG,GI,GMRVJ,GSYNO Q
IO ;PRINT INTAKE/OUTPUT SECTION OF VITAL SIGNS-I/O SHEET
 S (GMRLINE("I"),GMRLINE("O"))=GMRX1
 S GMRNM=0 F GMRDT=0:0 S GMRDT=$O(^TMP($J,"GMRDT",GMRDT)) Q:GMRDT'>0  S GMRNM=GMRNM+1 Q:GMRNM>10  S GDT=+$E(GMRDT,1,7) I $D(^TMP($J,"GMRVG","I",GDT))!($D(^TMP($J,"GMRVG","O",GDT))) D SETDATA
 W !,"Intake(24 Hr)(cc)",?17,"|",GMRLINE("I")
 W !,"Output(24 Hr)(cc)",?17,"|",GMRLINE("O")
 Q
SETDATA ; FILL GMRLINE WITH I/O DATA AND WRITE GMRLINE
 I $D(^TMP($J,"GMRVG","I",GDT)) S GDATA=$O(^(GDT,0)) S:GDATA>0 $P(GMRLINE("I"),"|",GMRNM)=$E(GDATA_"          ",1,10) K ^TMP($J,"GMRVG","I",GDT)
 I $D(^TMP($J,"GMRVG","O",GDT)) S GDATA=$O(^(GDT,0)) S:GDATA>0 $P(GMRLINE("O"),"|",GMRNM)=$E(GDATA_"          ",1,10) K ^TMP($J,"GMRVG","O",GDT)
 Q
SELECT(J) ;TYPE OF GRAPH FOR REPORT
 N X,I W !
TRYAGN F I=1:1:5 W !,?2,I_"  "_$P($T(GCHART+I),";;",2)
 W !!,?2,"Select a number between 1 and 5: 1  Vital Signs Record// " S X="" R X:DTIME I '$T!(X["^") S J=0 Q
 I X="" S J=1 Q
 I $L(X)>2 G TRYAGN
 I '(X?1N&(X>0&(X<6)))!(X["?") W !!,"Enter the number for the graph you wish to print.",!,"The default is Vital Signs Record.",! G TRYAGN
 W "  ",$P($T(GCHART+X),";;",2) S J=X Q
 Q
WRT1 W !!,?5,$C(7),"This report must be queued to a 132 column printer.",!!
 Q
SETT ; SET GMRT
 D SETT^GMVSR2 Q
GCHART ;
 ;;Vital Signs Record
 ;;B/P Plotting Chart
 ;;Weight Chart
 ;;Pulse Oximetry/Respiratory Graph
 ;;Pain Chart
