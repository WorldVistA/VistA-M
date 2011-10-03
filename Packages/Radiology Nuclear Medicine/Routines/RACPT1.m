RACPT1 ;HISC/GJC,FPT-Procedure/CPT Stats Report ;12/29/00  11:28
 ;;5.0;Radiology/Nuclear Medicine;**26,69,103**;Mar 16, 1998;Build 2
 ;04/05/2010 KAM/BP Remedy Call 349101 CPT Codes w/modifiers do not
 ;                                     display properly
 ;01/19/2006 KAM/BAY Remedy Call 97373 CPT Code Display Problem
CHK ;
 I $O(RACCESS(DUZ,""))="" D SETVARS^RAPSET1(0) S RAPSTX=""
 I $O(RACCESS(DUZ,""))="" D ACCVIO^RAUTL19 S RAQUIT=1 Q
 D ASK1^RAWKL ;ask if want separate CPT mods
 I $$DIVLOC^RAUTL7() D  S RAQUIT=1 Q
 . I $O(^TMP($J,"RA D-TYPE",""))="" W !!?5,"No divisions selected." Q
 . I $O(^TMP($J,"RA I-TYPE",""))="" W !!?5,"No imaging types selected."
 . Q
 W ! S RACAN=$$YESNO()
 ; RACAN=0: cancelled exams excluded, RACAN=1: cancelled exams
 ; are included, RACAN=-1: exit option
 S:RACAN<0 RAQUIT=1 Q:$G(RAQUIT)
 K DIR S DIR(0)="Y",DIR("B")="Yes"
 S DIR("A")="Do you wish to include all Procedures"
 S DIR("?",1)="Enter 'Yes' to select all entries in the file."
 S DIR("?")="Enter 'No' to select a subset of entries in the file."
 W ! D ^DIR K DIR I $D(DIRUT) S RAQUIT=1 Q
 S RAINPUT=+Y
 I RAINPUT=0 D  Q:$G(RAQUIT)
 . K RADIC
 . S RADIC="^RAMIS(71,",RADIC(0)="EMQZ",RADIC("A")="Select PROCEDURE: "
 . S RAUTIL="RA P-TYPE" D EN1^RASELCT(.RADIC,RAUTIL,"",RAINPUT)
 . I $O(^TMP($J,"RA P-TYPE",""))=""!$G(RAQUIT) W !!?5,"No procedures selected." S RAQUIT=1
 . Q
 S RANUMPRC=$$PROCNUM()
DATE D DATE^RAUTL Q:RAPOP
 ;S Z=9999999.9999, WHY IS THIS NEEDED?
 S RABEG=BEGDATE,RAEND=ENDDATE+.9
 S DIR(0)="S^I:INPATIENT;O:OUTPATIENT;B:BOTH;",DIR("B")="BOTH",DIR("?",1)="This CPT Workload Report can be broken",DIR("?")="out by Inpatient, Outpatient or Both.",DIR("A")="Report to include"
 D ^DIR S RASORT=Y I $D(DIRUT) S RAQUIT=1 Q
 K DIR,X,Y
 S ZTRTN="START^RACPT"
 F RASV="RACAN","RANUMPRC","BEGDATE","ENDDATE","RABEG","RAEND","RASORT","RAINPUT","RACMLIST" S ZTSAVE(RASV)=""
 F RASV="D","I","P" S ZTSAVE("^TMP($J,""RA "_RASV_"-TYPE"",")=""
 W ! D ZIS^RAUTL
 Q
PRINT ; Output data
 ; 01/19/2006 KAM/BAY Changed next line to utilize $$NAMCODE^RACPTMSC
 I '$G(RACMLIST) W !,$P($$NAMCODE^RACPTMSC(CPT,""),U),?7,$S($D(^RAMIS(71,J,0)):$E($P(^(0),"^"),1,38),1:"UNKNOWN") S RATOT(1)=+$P(^(0),U,10) ;cost per unit
 ; 01/19/2006 KAM/BAY Changed next line to utilize $$NAMCODE^RACPTMSC
 ;I $G(RACMLIST) W !,$P($$NAMCODE^RACPTMSC(CPT,""),U),?15,$S($D(^RAMIS(71,J,0)):$E($P(^(0),"^"),1,30),1:"UNKNOWN") S RATOT(1)=+$P(^(0),U,10) ;cost per unit
 ; 01/13/2010 KAM/BAY Changed next line to display CPT w/Modifier
 I $G(RACMLIST) W !,$S(CPT["-":$P($$NAMCODE^RACPTMSC($P(CPT,"-"),""),U)_"-"_$P(CPT,"-",2),1:$P($$NAMCODE^RACPTMSC(CPT,""),U)),?15,$S($D(^RAMIS(71,J,0)):$E($P(^(0),"^"),1,30),1:"UNKNOWN") S RATOT(1)=+$P(^(0),U,10) ;cost per unit KEN TESTING
 S RATOT(2)=RATOT*RATOT(1) ;occurrence * cost per unit
 S RATOT(4)=$G(^TMP($J,"RA",RAI,RADIV,RAIMAG(1),"DONE"))
 S RATOT(5)=$G(^TMP($J,"RA",RAI,RADIV,RAIMAG(1),"COST"))
 W ?45,$J(RATOT,5),?52,$S(RATOT(4)=0:$J(0,3,0),1:$J(RATOT/RATOT(4)*100,3,0))
 W ?56,$J(RATOT(1),8,2)
 W ?65,$J(RATOT(2),10,2),?77,$S(RATOT(5)=0:$J(0,3,0),1:$J(RATOT(2)/RATOT(5)*100,3,0))
 I $E(IOST,1,2)="C-",$Y+4>IOSL D HANG1,HED:'RAEXIT
 Q
HED ; Issue header
 W:($E(IOST)="C")!(PAGE>1) @IOF
 N RA S RA=">>>>> PROCEDURE/CPT STATISTICS REPORT "
 S RA=RA_$S(RAI="I":"(INPATIENT)",RAI="O":"(OUTPATIENT)",1:"")_" <<<<<"
 W !?78-$L(RA)\2,RA,?70,"Page: ",PAGE S PAGE=PAGE+1
 W !!,"    Division: ",$S(RADIV="":"Unknown",$D(^DIC(4,RADIV,0)):$P(^(0),U),1:"Unknown")
 W !,"Imaging Type: ",RAIMAG(0)
 W ?52,"For period: ",BEGDATE(0)," to"
 W !,"    Run Date: ",RARUNDTE,?64,ENDDATE(0)
 W !,"    # of Procedures selected: ",$S(RAINPUT:"All",1:RANUMPRC)
 W ?52,"Cancelled Exams: "_$S(RACAN:"in",1:"ex")_"cluded"
 W:'$G(RACMLIST) !!,"CPT",?7,"PROCEDURE"
 W:$G(RACMLIST) !!,"CPT (* : >3 CPT mods)",?25,"PROCEDURE"
 W ?44,"# DONE",?52,"(%)",?59,"$UNIT",?69,"$TOTAL",?77,"(%)",!,QQ
 Q
HANG ; get to the EOP
 Q:$E(IOST,1,2)'="C-"
 F Z=1:1:(IOSL-($Y+4)) W !
HANG1 ; Issue EOP prompt
 R !!,"Press RETURN to continue or an '^' to stop ",X:DTIME
 S RAEXIT=(X=U)
 Q
SRTPA(RA) ; Check on the sort parameters.  If inpatient and outpatient,
 ; issue a EOP prompt when the sort parameter changes.
 ; '1' implies that we are sorting by both inpatient/outpatient and
 ; are on the second parameter, '0' implies that we fail the above
 ; conditions.
 I ($L(RASORT,",")#2)=0,(RA>1),('+$G(RAEOPFLG)) Q 1
 Q 0
PROCNUM() ; Determine the number of procedures a user has chosen.
 N X,Y S X="",Y=0
 F  S X=$O(^TMP($J,"RA P-TYPE",X)) Q:X']""  S Y=Y+1
 Q Y
YESNO() ; Pass back the user's response to the 'Yes/No' question
 ; returns: 0=user answers No, 1=user answers Yes, -1='^' or timeout
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y S DIR(0)="Y",DIR("B")="Yes"
 S DIR("A")="Do you wish to include cancelled cases"
 S DIR("?",1)="Enter 'Yes' if exams with an examination status of Cancelled"
 S DIR("?",2)="are to be included on the report.  Enter 'No' if cancelled exams"
 S DIR("?")="are to be excluded from the report." D ^DIR
 S:$D(DIRUT) Y=-1
 Q Y
