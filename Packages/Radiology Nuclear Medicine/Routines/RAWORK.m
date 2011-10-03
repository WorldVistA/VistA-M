RAWORK ;HISC/CAH,FPT,GJC AISC/TMP,RMO-Rad/Nuc Med Worksheet print (132 Char. Format) ;9/5/95  12:39
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 W !!,?5,"***  RADIOLOGY/NUCLEAR MEDICINE WORKSHEETS  ***",!!!
ASKNUM R !!,"Enter the number of worksheets needed: ",X:DTIME G Q:'$T!(X="")!(X["^") I +X'>0 W:X'["?" *7 W !!?3,"Enter the number of worksheets to be printed." G ASKNUM
 S RANUM=+X,RADIV=$S('$D(RAMDIV):"",$D(^DIC(4,RAMDIV,0)):$P(^(0),"^"),1:"")
 W !!,"NOTE: This output should be sent to a printer that supports 132 columns.",!
 S ZTSAVE("RANUM")="",ZTSAVE("RADIV")="",ZTRTN="START^RAWORK",RAZIS=1 D ZIS^RAUTL G Q:RAPOP
START U IO S RASKIP="!,""|  |"",?64,""|"",?131,""|""",RALINE="",$P(RALINE,"_",133)=""
 S RASKIP1="!,""|"",?21,""|"",?83,""|"",?99,""|"",?115,""|"",?131,""|"""
 F J=1:1:+RANUM D RAREP
Q K DUOUT,I,I1,I2,J,POP,RALIM,RALINE,RAMES,RANUM,RAPOP,RASKIP,RASKIP1,RAZIS,RADIV,X,ZTDESC,ZTRTN,ZTSAVE
 D CLOSE^RAUTL
 Q
 ;
RAREP W:J>1 @IOF W !,?56,"RADIOLOGY/NUCLEAR MEDICINE WORKSHEET",! W RALINE
 W @RASKIP,!,"|  |",?9,"VAMC  ",RADIV,?64,"|",?131,"|",@RASKIP,!,"|  | DATE  ",$E(RALINE,1,32),?46,"AGE  ",$E(RALINE,1,11),?64,"|",?75,"TIME:  ",$E(RALINE,1,20),?131,"|",@RASKIP
 W !,"|  | SSN   ",$E(RALINE,1,32),?46,"TCH  ",$E(RALINE,1,11),?64,"|",?75,"LAST EXAM:  ",$E(RALINE,1,15),?131,"|",@RASKIP,!,"|  | NAME  ",$E(RALINE,1,32),?64,"|",?75,"WARD OR OTHER:  ",$E(RALINE,1,11),?131,"|"
 F I=1:1:2 W @RASKIP
 W !,"|  |",$E(RALINE,1,60),"|",?131,"|",!,"|",?131,"|"
 W !,"|",?131,"|",!,"!",?9,"AMIS",?21,"|",?47,"DESCRIPTION",?83,"|",?89,"TECH",?99,"|",?105,"DIAG.",?115,"|",?121,"M.D.",?131,"|"
 F I1=1:1:10 D LINE1 F I2=1:1:3 W @RASKIP1
 D LINE1 W !,?120,"__________",!,?100,"DATA ENTRY CLERK:  |          |",!,?119,"|__________|"
 Q
LINE1 W !,"|",$E(RALINE,1,20),"|",$E(RALINE,1,61),"|",$E(RALINE,1,15),"|",$E(RALINE,1,15),"|",$E(RALINE,1,15),"|" Q
 ;
PCE() ;Switch to turn on/off the PCE API vs the SDACS credit interface
 Q 1
