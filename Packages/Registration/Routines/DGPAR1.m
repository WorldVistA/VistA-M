DGPAR1 ;ALB/MRL - ADT PARAMETERS ENTRY/EDIT ; 24 Feb 2000  6:52 PM
 ;;5.3;Registration;**51,62,86,93,109,214,265,277,343**;Aug 13, 1993
 S DGERR=0 D L W !,"Enter " W:DGMULT "'D' to view DIVISIONS, " W "1-3 to EDIT, or RETURN to QUIT:  " R DGAN:DTIME G Q1:'$T!(DGAN["^")!(DGAN']"") I $S("Dd"[$E(DGAN):0,DGAN?1N.E:0,1:1) G HELP
 I "Dd"[$E(DGAN) G DIV:DGMULT,HELP
 I DGAN?1N1"-"1N S DGAN1=DGAN,DGAN="" F I=+DGAN1:1:$P(DGAN1,"-",2) S DGAN=DGAN_I_","
 S DGAN1=DGAN,DGAN="" F J=1:1 S I=$P(DGAN1,",",J) Q:I=""  I I'>DGMULT+2 S:I'["-" DGAN=DGAN_I_"," I I["-" S I1=$P(I,"-",1),I2=$P(I,"-",2) F I3=I1:1:I2 I I3'>DGMULT+2,DGAN'[(","_I3_",") S DGAN=DGAN_I3_","
 S DGAN=","_DGAN,DR="" S:DGAN[(",1,") DR=DR_$P($T(1),";;",2) S:DGAN[(",2,") DR=DR_$P($T(2),";;",2) I DR]"" S DIE="^DG(43,",DA=1 D ^DIE K DR,DIE,DA
 I DGAN'[",3," D Q G ^DGPAR
 G ^DGPAR:DGAN'[(",3,") I 'DGMULT S DIE="^DG(40.8,",DA=+$P(DGNOD("GL"),"^",3),DR=$P($T(3),";;",2) I $D(^DG(40.8,DA,0)) D ^DIE
 I 'DGMULT D Q G ^DGPAR
 F DGI=0:0 S DIC="^DG(40.8,",DIC(0)="AEQML" D ^DIC Q:Y'>0  D:$P(Y,U,3) VASITE(Y) S DIE=DIC,DA=+Y,DR=$P($T(3),";;",2) D ^DIE
 D Q G ^DGPAR
Q G Q1:'$D(DFN1),Q:DFN1'=+DFN1 I $D(SDMD),SDMD=1,$D(^DIC(4,+$P(^DG(40.8,DFN1,0),"^",2),0)) S ^DIC(4,$P(^DG(40.8,DFN1,0),"^",2),"DIV")="Y"
 I $D(SDMD),SDMD=0,$D(^DIC(4,$P(^DG(40.8,DFN1,0),"^",2),0)) K ^DIC(4,$P(^DG(40.8,DFN1,0),"^",2),"DIV")
Q1 K C,DGIND,DA,DFN1,DGERR,DGAN,DGAN1,DGD,DGIN,DGDV,DGDV1,DGHEAD,DGI,DGMULT,DGNOD,DGPTFP,DG,SDMD,X,DGX,DGX1,DGZE,DIC,DIE,DIK,DR,I,I1,I2,I3,J,X,X1,Y Q
DIV S (C,DGERR)=0 D H1
 F DGD=0:0 S DGD=$O(^DG(40.8,DGD)) Q:'DGD!(DGERR)  S DGZE=$S($D(^(DGD,0)):^(0),1:""),DGDV=$S($D(^("DEV")):^("DEV"),1:"") S X=$P(DGZE,"^",1)_" DIVISION",X1="",$P(X1,"-",$L(X))="" W !,X,!,X1,!?4 D DEV W ! S C=C+1 D:'(C#2) H
 G SC
 ;CHANGED $N TO $O BELOW
H Q:'+$O(^DG(40.8,+DGD))  I C>0 D L W !,"Press RETURN to see more DIVISION PARAMETERS:  " R X:DTIME I X["^" S DGERR=1 Q
H1 W @IOF,!,"DIVISION PARAMETERS",$S(C>0:", CONTINUED",1:""),! S X="",$P(X,"=",79)="" W X Q
DEV W ?4,"Print Wristbands",?25,": ",$S($P(DGZE,"^",8)="Y":"YES",1:"NO"),!
 S DGDV1="AA<96 HOURS^AA" S X=$P(DGZE,"^",4) W ?4,"'",$P(DGDV1,"^",1),"' on G&L",?25,": ",$S($P(DGZE,"^",4):"YES",1:"NO")
 D EN^DGPAR2
P Q:'DGPTFP  S X=$S($P(DGDV,"^",4)]"":$P(DGDV,"^",4),1:$P(DGNOD(0),"^",19)) W !?4,"Division PTF printer",?25,": ",$S(X]"":X,1:"NEEDS TO BE SPECIFIED") Q
HELP W @IOF,!,"ADT PARAMETER ENTRY/EDIT, HELP SCREEN"
 S X="",$P(X,"=",79)="" W !,X
 W !,">>> Enter RETURN to QUIT this option.",!
 I DGMULT W !,">>> Enter a 'D' to display individual DIVISION parameters.",!
 W !,">>> NOTE: To view and edit Scheduling parameters use the 'Scheduling Parameters'"
 W !,"          option under the 'Supervisor Menu' in the Scheduling package.",!
 W !,">>> Enter the field group number(s) you wish to edit using commas"
 W !,"    and or dashes as delimiters."
 W !!,"Edit Data Group(s) [Select by number]:"
 W !,"-------------------------------------"
 W !,"[1] Primary facility parameters, which if multi-divisional facility apply to all",!?4,"divisions, such as 'PRINT PTF MESSAGE?', etc."
 W !!,"[2] ADT Specific parameters which, again, if the facility is multi-divisional",!?4,"apply to all divisions.  Includes such items as 'at what point is a",!?4,"disposition considered late', etc."
 W !!,"[3] "
 I DGMULT W "The names of the individual divisions associated with this facility.  You",!?4,"may enter a 'D' at the 'ENTER' prompt to view division specific data."
 I 'DGMULT W "The device/G&L parameters associated with this facility."
 G SC
 ;
L F I=$Y:1:21 W !
 Q
SC D L R:'DGERR !,"Press RETURN to return to SCREEN:  ",X:DTIME G ^DGPAR
 ;
VASITE(Y) ; -- add new time sensitive entry
 N DIC,DIE,DR,DFN1,SDMD,DGI,VASITE
 S VASITE("NEW")=Y D NEW^VASITE1
 Q
 ;
1 ;;12;S DFN1=X;13;11;S SDMD=X,DGIND=1;15;16;4;9.6;9.5;9;34;76;77;37;38;
2 ;;46;5.5;6;7;17;8;S:X'=1 Y="@42";44;45;Q;@42;42;S:X'=1 Y="@18";43;Q;@18;18;19;70;722;25;39;33;47;S:X'=1 Y="@48";48;Q;@48;1201;1100.01;1100.02;1100.03;1100.04;1100.05;1100.06;1110;1120;1202
3 ;;35.01;35.03;S:X'="Y"&($P($G(^DG(40.8,DA,"MT")),U)'="Y") Y="@36";35.02;@36;S:'DGMULT Y=.08;3;S:X=1 Y=.07;.08;4;5;6;.07;7;8;9;S:'$P(DGNOD(0),"^",31) Y=0;9.1;
