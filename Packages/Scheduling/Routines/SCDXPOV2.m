SCDXPOV2 ;ALB/SCK - VISIT REPORT BY NPCDB TRANSMISSION STATUS ; 10/31/96
 ;;5.S;Scheduling;**73**;Aug 13, 1993
 Q
GETDATE(CAPTION) ;  Get and return a date value
 ;  Input:
 ;     Caption  -  Prompt to be displayed in reader call
 ;
 D NOW^%DTC S Y=X D DD^%DT
 S DIR(0)="DA^::EP",DIR("A")=CAPTION,DIR("B")=Y,DIR("??")="^D HELP^%DTC"
 D ^DIR K DIR
 S:$D(DIRUT) Y=-1
 D CLEAR
 Q Y
 ;
SHWTOT() ; Selects wether only the grand total page is shown
 S DIR(0)="YA",DIR("A")="PRINT FACILITY TOTAL ONLY? ",DIR("B")="NO"
 S DIR("A",2)="THIS IS A MULTI-DIVISIONAL FACILITY.",DIR("A",1)=""
 S DIR("?")="IF YOU ANSWER YES (Y), YOU WILL GIVEN THE FACILITY TOTAL ONLY."
 D ^DIR K DIR
 S:$D(DIRUT) Y=-1
 D CLEAR
 Q Y
 ;
RPTOPT() ; Selects which parts of the report are shown
 S DIR(0)="S^1:TRANSMISSION STATUS ONLY;2:VISIT COUNT;3:BOTH"
 S DIR("A")="SELECT REPORT OPTION",DIR("B")=3
 D ^DIR K DIR
 S:$D(DIRUT) Y=-1
 D CLEAR
 Q Y
 ;
QUE ;  Sets up the report for queueing
 N LV
 S ZTRTN="START^SCDXPOV"
 S ZTDESCR="VISIT REPORT, TRANSMISSION STATUS TO NPCDB"
 F LV="SCXOPT","SCXBEG","SCXEND","SCXMD","SCXTFLG" S ZTSAVE(LV)=""
 D ^%ZTLOAD W:$D(ZTSK) !,"TASK #: ",ZTSK
 D HOME^%ZIS K IO("Q")
 Q
CHKELG(SCELG) ; checks for inactive entries in the ELIGIBILTIT CODE File, #8
 ;
 Q +$P($G(^DIC(8,SCELG,0)),U,7)
 ;
ELGPRI(SCEL,SCCUR) ; Returns whether heirarchy level of eligibility should change
 ;   Input
 ;      SCEL - Eligibility
 ;      SCCUR - Current Hierarchy level
 ;   Returns  
 ;      SCPRI = 1 Change current hierarchy to new
 ;      SCPRI = 0 Do not change
 ;
 N SCPRI,SCNEW
 S SCPRI=4,SCNEW=+$P($G(^DIC(8,SCEL,0)),U,9)
 S:SCNEW=1!(SCNEW=3) SCPRI=1
 S:SCNEW=2!(SCNEW=15)!(SCNEW=16)!(SCNEW=17)!(SCNEW=18) SCPRI=2
 S:SCNEW=4!(SCNEW=5) SCPRI=3
 Q SCPRI_U_(SCPRI<SCCUR)
 ;
COVPRI(SCNEW,SCCUR) ; Returns whether heirarchy level of visit should change
 ;   Input
 ;      SCNEW - Eligibility
 ;      SCCUR - Current Hierarchy level
 ;   Returns  
 ;      SCPRI = 1 Change current hierarchy to new
 ;      SCPRI = 0 Do not change
 ;
 N SCPRI
 S SCPRI=3
 S:SCNEW=1 SCPRI=2
 S:SCNEW=2 SCPRI=3
 S:SCNEW=3 SCPRI=1
 Q SCPRI_U_(SCPRI<SCCUR)
 ;
CLEAR ;  Clear DIR variables
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT
 Q
