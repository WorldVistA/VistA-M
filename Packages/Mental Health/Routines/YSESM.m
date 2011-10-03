YSESM ;SLC/DCM-MAIN MENU DRIVER/ACCESS ROUTINE FOR DECISION EXPERT SYSTEM ;7/24/89  09:59 ;
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
 ; Called by routines YSESE,YSESR
 ; Called from the top by MENU option YSDECTREES-R
 ;
 ;DECISION EXPERT SYSTEM (VERSION 1.0) FOR MENTAL HEALTH PACKAGE - DWIGHT MCDANIEL / REGION 5 ISC, SLC
E I '$D(DUZ)!('$D(DUZ(0))) W $C(7),!!!,"******  YOU MUST SET UP YOUR SECURITY PARAMETERS TO RUN THIS PROGRAM  ******",!,"******",?20,"'DUZ' AND 'DUZ(0)' MUST BE DEFINED",?70,"******",!!! H 2 Q
EN I '$D(IOF) D HOME^%ZIS
 S YSTIME=DTIME,DTIME=$S('$D(DTIME):600,DTIME<600:600,1:DTIME)
 S Q="""",UU="",$P(UU," ",20)="",STR="",$P(STR,"*",80)="",ST=0,A5ASP=0 K A5AFL
MEN W @IOF,!?13,"******  DECISION SUPPORT SYSTEM MAIN MENU  ******",!!
 F YSESI=1:1 S YSOPT=$P($P($T(@(YSESI)),";;",2),U) Q:YSOPT=""  W ?15,YSESI,".  ",YSOPT,!
MEN1 W !!?15,"Select Option: (1-",YSESI-1,"):  " R A5AX:DTIME G:A5AX["?" QUES1 I A5AX]"",A5AX<0!(A5AX>(YSESI-1))!(A5AX?.P) W $C(7) G MEN
 I A5AX["^"!(A5AX="")!(A5AX=3) G END
 I A5AX?1A.A.E S YSOPT=$S("Rr"[$E(A5AX):"^YSESR","Aa"[$E(A5AX):"^YSESE","Ee"[$E(A5AX):"END",1:"") G:A5AX="END" END I A5AX="" W $C(7)," ??" G EN
 I A5AX?1N S YSOPT=$P($P($T(@(A5AX)),";;",2),U,2) S YSOPT="^"_YSOPT I YSOPT=""!(YSOPT?.P) W $C(7) G EN
 G @YSOPT,MEN
QUES1 ;Response to ? on Main Menu (MEN+2)
 W !!,"""Running a Decision Support Algorithm"" will allow the individual to follow a",!,"decision tree to its logical conclusion as determined by the data base.",!
 W !,"""Add Nodes, etc."" permits qualified personnel to enter information into the",!,"decision support data base.  Use of this option requires detailed knowledge",!,"of data entry material and special access to the system.",!
 W !,"""Exit"" will return user to preceding menu.",!
 K A5AX G MEN1
END K C,P,Q,X,Y,DA,DR,GN,ST,TB,TC,UU,ANS,DIC,DIE,ESI,ESJ,GN1,GN2,STR,A5AI,A5AJ,A5AS,A5AX,SDIC,A5AGN,A5ALG,A5ASP,SDIC0,ESDBP,YSESI,YSOPT,XCODE,A5ARES,A5ASYS,ESDBP1,PROMPT
 K X,Y,D0,DQ I $D(YSTIME) S:YSTIME>0 DTIME=YSTIME K YSTIME
 W @IOF Q
 ;;5.0;Mental Health System;January 1992
 ;;
1 ;;Run a Decision Support Algorithm.^YSESR
2 ;;Add Nodes to/Edit Nodes in a Decision Support Algorithm.^YSESE
3 ;;Exit.^END
