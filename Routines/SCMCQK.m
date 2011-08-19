SCMCQK ;ALB/REW - Single Pt Tm/Pt Tm Pos Assign and Discharge ; 1 Jul 1998
 ;;5.3;Scheduling;**148,177,297**;AUG 13, 1993
 ;
EN ; - main call
 W !,"Primary Care Team/PC Assignment/Unassignment",!
 W !,?6,"Prior to using this option, PCMM's Graphical User Interface (GUI)"
 W !,?6,"must be used to:"
 W !,?10,"1) Setup active primary care and non-primary care team(s)"
 W !,?10,"2) Setup active PC and non-primary care Practitioner position(s)"
 W !,?10,"3) Setup any necessary preceptor/preceptee relationships"
 W !,?10,"4) Assign practitioner to position(s)"
 W !!?6,"A patient can only have one PC team and one"
 W !?6,"PC Position assignment on a given day.  The patient must be"
 W !?6,"assigned to a position's team to be assigned to the position."
 W !!?6,"Note: You must use the PCMM GUI if the patient was:"
 W !?10,"o unassigned from PC assignment today or in the future"
 W !?10,"o assigned to a future PC assignment."
 N DFN
 F  S DFN=$$PATIENT() Q:DFN<0  D PAT
 Q
 ;
PAT ;process patient
 Q:'$G(DFN)
 N SCTPSTAT,SCTMSTAT,SCSTAT,SCTM,SCTP
 W !,"Checking PC Team and Position Status...",!
 ;display PC info, check if patient has a current PC team
 D PCMM^SCRPU4(DFN,DT)
 D DSPL^SCMCQK2
 N DATA
 S DATA=$$IU^SCMCTSK1(DFN)
 I $E(DATA)=1 I $D(^XUSEC("SC PCMM SETUP",+$G(DUZ))) D
 .W !,"This patient was inactivated from "_$P(DATA,"~",2)_" TEAM"
 .W !,$P(DATA,"~",4)_" Position"
 .W !,"Do you wish to reactivate" S %=2 D YN^DICN
 .I %=1 D FILEIN^SCMCTSK3(.DATA,+$P(DATA,"~",6))
 W !,"Do you want to make a primary care assignment/unassignment" S %=1 D YN^DICN Q:%<0
 I %=2 G NPC^SCMCQK2
 ;below functions return status^message^pointer
 S SCTMSTAT=$$YSPTTMPC^SCMCTMU2(DFN,DT)  ;ok to assign new PC team?
 S SCTPSTAT=$$YSPTTPPC^SCMCTPU2(DFN,DT,1)  ;ok to assign new PC prac?
 ;what is current/future PC assignment status?
 S SCSTAT=$S((SCTMSTAT&SCTPSTAT):"NONE",('SCTMSTAT&SCTPSTAT):"TEAM",('SCTMSTAT&'SCTPSTAT):"BOTH",1:"ERROR")  ;error if PC pract w/o PC team assignment
 W:SCSTAT="NONE" !,"No current PC Team/PC Practitioner Assignments"
 IF $S(SCTMSTAT:0,(SCTMSTAT["future"):1,1:0) W !,$P(SCTMSTAT,U,2) S SCSTAT="FUTURE"
 IF $S(SCTPSTAT:0,(SCTPSTAT["future"):1,1:0) W !,$P(SCTPSTAT,U,2) S SCSTAT="FUTURE"
 S SCTM=$P(SCTMSTAT,U,3)
 S SCTP=$P(SCTPSTAT,U,3)
 D @SCSTAT
 D BREAK
 Q
 ;
BREAK ;
 N DIR,X,Y
 S DIR(0)="EA",DIR("A",1)="",DIR("A")="Press enter to continue."
 D ^DIR
 Q
 ;
NONE ;
 N SCASSDT
 D ASTM^SCMCQK1
 Q
TEAM ;
 N DIR,X,Y,SCDISCH,SCASSDT,SCSELECT
 S DIR(0)="SO^1:POSITION ASSIGNMENT - BY PRACTITIONER NAME;2:POSITION ASSIGNMENT - BY POSITION NAME;3:TEAM UNASSIGNMENT"
 D ^DIR
 IF $P(Y,U,1)=1!($P(Y,U,1)=2) D
 .S SCSELECT=$S($P(Y,U,1)=1:"PRACT",1:"POSIT")
 .D ASTP^SCMCQK1
 ELSE  D:$P(Y,U,1)=3 UNTM^SCMCQK1
 Q
 ;
BOTH ;
 N DIR,X,Y,SCDISCH
 S DIR(0)="SO^1:PC ASSIGNMENT UNASSIGNMENT;2:TEAM UNASSIGNMENT"
 D ^DIR
 IF $P(Y,U,1)=1 D
 .D UNTP^SCMCQK1
 ELSE  D:$P(Y,U,1)=2 UNTM^SCMCQK1
 Q
 ;
FUTURE ;
 W !,"This patient has future assignments for Primary Care"
 W !,"Team and/or Practitioner"
 W !!!,"You must use PCMM's Graphical User Interface to change"
 Q
 ;
ERROR ;
 W !,"This patient has NO active Primary Care Team, but does have"
 W !,"an active PC Position Assignment"
 W !!!,"You must use PCMM's Graphical User Interface to correct"
 Q
 ;
PATIENT() ;Return Patient DFN or -1
 ;
 N DIC,X,Y
 W !!!
 S DIC=2
 S DIC(0)="AEMQZ"
 D ^DIC
 Q $S($D(DTOUT):-1,$D(DUOUT):-1,(Y<0):-1,1:+Y)
