ECXLAB1 ;ALB/JAP,BIR/CML,-Driver Routine for DSS Lab Extract; [ 03/20/97  11:54 AM ] ; 8/8/01 4:16pm
 ;;3.0;DSS EXTRACTS;**8,37**;Dec 22, 1997
EN ;entry point from option
 N JJ,SS,LN,X,Y,DIRUT,DTOUT,DUOUT,DIR
 I '$O(^ECX(728,0)) D  Q
 .W $C(7),!!,"You have not yet defined your facility in the DSS EXTRACTS file (#728)!"
 .I ($E(IOST)="C") D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..K X,Y
 ..S DIR(0)="E" W ! D ^DIR K DIR
 ;Check for lmip flag (field .5) in file (#728), if empty string write message and terminate extract
 I $G(^ECX(728,1,"LMIP"))'=1 D  Q
 .S $P(LN,"-",80)=""
 .W !,"LAB Extracts cannot be generated without LMIP Codes.",!,"Please check with your LAB ADPAC or LAB Service."
 .W !,"...exiting."
 D BEG^ECXLABN
 Q
