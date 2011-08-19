SCRPU2 ;ALB/CMM - GENERIC PROMPTS FOR PCMM REPORTS ; 12 Jan 99  1:23 PM
 ;;5.3;Scheduling;**41,174,297,526,520**;AUG 13, 1993;Build 26
 ;
DTRANG(FIRST,SECOND) ;Date Range - begin date ^ end date => fileman format
 ;FIRST - first prompt (not required)
 ;SECOND - second prompt (not required)
 N BDATE,EDATE,DIROUT,DUOUT,DTOUT
 S EDATE=-1
 S DIR(0)="D^::E",DIR("B")="Today"
 I '$D(FIRST) S DIR("A")="Begin Date"
 I $D(FIRST) S DIR("A")=FIRST
 D ^DIR
 I $D(DTOUT)!(X="Today") S BDATE=$P(DT,".")
 I $D(DUOUT)!($D(DIROUT))  Q -1
 S BDATE=+Y
DEN I '$D(SECOND) S DIR("A")="End Date"
 I $D(SECOND) S DIR("A")=SECOND
 K DTOUT,X,Y
 D ^DIR
 I $D(DTOUT)!(X="Today") S EDATE=$P(DT,".")
 I $D(DUOUT)!($D(DIROUT)) Q -1
 S EDATE=+Y
 I EDATE<BDATE W !,"End date can't occur before Begin Date",! G DEN
 K X,Y,DIR
 Q BDATE_"^"_EDATE
 ;
GTEAM(CLN,DFN) ;
 ;given clinic and patient, find related team
 N TPEN,FOUND,TEAM
 S TPEN="",FOUND=0
 F  S TPEN=$O(^SCTM(404.57,"E",CLN,TPEN)) Q:TPEN=""!(FOUND)  D
 .S TEAM=$P(^SCTM(404.57,TPEN,0),"^",2)
 .I $D(^SCPT(404.42,"APTTM",DFN,TEAM)) S FOUND=1
 I FOUND=1 Q TEAM
 Q FOUND
 ;
ASSUN ;
 ;prompt for assigned or unassigned to Primary Care Team
 N VAUTVB
 S VAUTVB="VAUTA"
 W !,"(A)ssigned or (U)nassigned Patients to Primary Care Team: "
 R X:DTIME
 I (X="^")!'$T G ERR
 I (X'="A")&(X'="U") D HLP G ASSUN
 I (X="")!(X["?") D HLP G ASSUN
 I X="A" S @VAUTVB=1
 I X="U" S @VAUTVB=0
 K X
 Q
 ;
PCLNHR() ;Prompt to Print Clinic Hours
 S DIR("A")="Print Clinic Hours",DIR("B")="Y"
 Q $$YESNO()
 ;
PCLNIN() ;Prompt to Print Clinic Information
 S DIR("A")="Print Clinic Information",DIR("B")="Y"
 Q $$YESNO()
 ;
SUMM() ;Prompt to Print Summary Only (y/n)
 S DIR("A")="Print Summary Only",DIR("B")="N"
 S DIR("?")="Enter 'Y' to have patient names excluded, 'N' to include patient names"
 Q $$YESNO()
 ;
YESNO() ;Yes/No prompt
 N X,DTOUT,DUOUT,DIROUT,Y
 S DIR(0)="Y"
 D ^DIR
 I $D(DTOUT)!(X="") S Y=$S(DIR("B")="Y":1,1:0)
 I $D(DUOUT)!($D(DIROUT)) S Y=-1
 K DIR
 Q +Y
 ;
PTSTAT ;Prompt for Patient Status (All, OPT, AC)
 ;Modified by patch 172
 S VAUTPS=1 Q
 ;
 N X,STAT,VAUTVB
 S VAUTVB="VAUTPS"
 W !,"Patient Status: ALL//"
 R X:DTIME
 I '$T!(X="")!(X="ALL") S @VAUTVB=1
 I X="^" G ERR
 I (X["?") D HLP2 G PTSTAT
 I X="A"!(X="AC") S @VAUTVB="AC"
 I X="O"!(X="OPT") S @VAUTVB="OPT"
 I '$D(@VAUTVB) D HLP2 G PTSTAT
 Q
 ;
HLP2 ;help prompt for Patient Status
 W !,"Enter: ",!?10,"- A or AC for patients whose status is AC"
 W !?10,"- O or OPT for patient whose status is OPT"
 W !?10,"- Enter or ALL for both AC and OPT patients"
 Q
HLP ;
 ;help prompt
 W !,"Enter: ",!?5,"- A for patients assigned to the team as Primary Care"
 W !?10,"- U for patients not assigned to the team as Primary Care"
 Q
 ;
ERR S Y=-1 I $O(@VAUTVB@(0))="" K @VAUTVB
QUIT S:'$D(Y) Y=1 K DIC,J,VAERR,VAI,VAJ,VAJ1,VAX,VAUTNI,VAUTSTR,VAUTVB,X
 Q
 ;
SORT() ;
 ;Prompt for sorting by Division, Team, Practitioner or Division, Practitioner, Team
 ;
EN1 N X
 W !,"Sort By:",!?10,"[1] Division, Team, Practitioner",!?10,"[2] Division, Practitioner, Team"
 W !?10,"[3] Practitioner,Associated Clinic"
 W !!,"Select 1 or 2 or 3: "
 R X:DTIME
 I (X="^")!'$T Q 0
 I (X'="1")&(X'="2")&(X'=3) D HLP3 G EN1
 I (X["?")!(X="") D HLP3 G EN1
 Q X
HLP3 ;
 ;help prompt
 W !,"Enter: ",!?5,"- 1 to sort by Division, Team, Practitioner "
 W !?10,"- 2 to sort by Division, Practitioner, Team"
 Q
 ;
SORT2() ;Prompt for sorting by:
 ;   [1] Division, Team, Patient Name
 ;or [2] Division, Team, SSN
 ;or [3] Division, Team, Practitioner, Patient Name
 ;or [4] Division, Team, Practitioner, SSN
 ;
EN4 ;
 N X
 W !,"Sort By:",!?10,"[1] Division, Team, Patient Name"
 W !?10,"[2] Division, Team, SSN"
 W !?10,"[3] Division, Team, Practitioner, Patient Name"
 W !?10,"[4] Division, Team, Practitioner, SSN"
 W !!,"Select 1, 2, 3, or 4: "
 R X:DTIME
 I X=""!(X="^")!'$T Q 0
 I (X'="1")&(X'="2")&(X'="3")&(X'="4") D HLP4 G EN4
 I (X["?") D HLP4 G EN4
 Q X
HLP4 ;
 ;help prompt
 W !,"Enter: ",!?5,"- 1 to sort by Division, Team, Patient Name"
 W !?10,"- 2 to sort by Division, Team, SSN"
 W !?10,"- 3 to sort by Division, Team, Practitioner, Patient Name"
 W !?10,"- 4 to sort by Division, Team, Practitioner, SSN"
 Q
