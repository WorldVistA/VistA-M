SCRPU1 ;ALB/CMM - GENERIC PROMPTS FOR PCMM REPORTS ;1/12/96
 ;;5.3;Scheduling;**41,45,130,520**;AUG 13, 1993;Build 26
 ;
INST ;Prompt for institution
 S VAUTVB="VAUTD",DIC="^DIC(4,",DIC("S")="I $D(^SCTM(404.51,""AINST"",+Y))"
 S VAUTNI=2,VAUTSTR="Division"
 G FIRST^VAUTOMA
 ;
PRMTT ;Prompt for team.  Set VAUTTN to allow not assigned to a team as a selection
 I '$D(VAUTD) G ERR
 S VAUTVB="VAUTT",DIC="^SCTM(404.51,",VAUTNI=2,VAUTSTR="Team",DIC("B")=""
 S DIC("S")="I VAUTD=1!($D(VAUTD(+$P(^(0),U,7))))"
 G FIRST
 ;
CLINIC ;Prompt for Clinic
 I '$D(VAUTT)&'$D(VAUTCA) G ERR
 S VAUTVB="VAUTC",VAUTSTR="Clinic",VAUTNI=2,DIC="^SC("
 ;Set screen to only allow clinics and clinics that are associated to the teams selected
 I '$D(VAUTCA) S DIC("S")="I $$CLSC^SCRPU1()"
 ;VAUTCA allows for selection of any clinic in the selected
 I $D(VAUTCA) S DIC("S")="I $$CLSC2^SCRPU1()"
 G FIRST
 ;
USER ;Prompt for User Class
 I '$D(VAUTT) G ERR
 I $P($G(^SD(404.91,1,"PCMM")),"^")'=1 Q  ;user class turned off
 S VAUTVB="VAUTUC",DIC="^USR(8930,",VAUTSTR="User Class",VAUTNI=2
 S DIC("S")="I $$USRCL^SCRPU1"
 G FIRST
 ;
USRCL() ;Screen for user class - must be related to teams selected
 N STOP,ENT,NODE,TIEN
 I '+$P(^(0),U,3) Q 0
 ;check for active/exiting user class
 S ENT=0,STOP=0
 F  S ENT=$O(^SCTM(404.57,"AUSR",+Y,ENT)) Q:ENT=""!(STOP)  D
 .S NODE=$G(^SCTM(404.57,ENT,0))
 .I NODE="" S STOP=0 Q
 .S TIEN=+$P(NODE,"^",2) ;team ien
 .I $D(VAUTT(TIEN))!(VAUTT=1) S STOP=1 Q
 .I VAUTT=""&(TIEN="") S STOP=1 Q  ;no team selected, no team assigned
 .I VAUTT'=1&('$D(VAUTT(TIEN))) S STOP=0
 Q STOP
 ;
ROLE ;Prompt for Role
 I '$D(VAUTT) G ERR
 S VAUTVB="VAUTR",DIC="^SD(403.46,",VAUTSTR="Role",VAUTNI=2
 S DIC("S")="I $$RL^SCRPU1()"
 G FIRST
 ;
RL() ;Screen for Role - screen on team
 N EN,STOP,ACT,TEAM
 S EN="",STOP=0
 I $D(^SCTM(404.57,"AC",+Y)) D
 .F  S EN=$O(^SCTM(404.57,"AC",+Y,EN)) Q:EN=""!(STOP)  D
 ..S ACT=+$$ACTTP^SCMCTPU(EN) ;currently active?
 ..I 'ACT!('$D(^SCTM(404.57,EN,0))) Q
 ..S TEAM=$P(^SCTM(404.57,EN,0),"^",2)
 ..I $D(VAUTT(TEAM))!(VAUTT=1) S STOP=1
 ..I VAUTT=""&(TEAM="") S STOP=1
 Q STOP
 ;
PRACT ; Prompt for One (set VAUTPO) or One,Many,All,None Practitioner(s)
 I '$D(VAUTT) G ERR
 S VAUTVB="VAUTP",VAUTSTR="Practitioner",VAUTNI=2,DIC="^VA(200,"
 S DIC("S")="I $$PRACS^SCRPU1()"
 G FIRST
 ;
PRACS() ;Practitioner screen - off of team selection
 N EN,STOP,NODE,TEAM
 S EN="",STOP=0
 I '$D(^SCTM(404.52,"C",+Y)) Q 0
 ;Position Assignment History file
 F  S EN=$O(^SCTM(404.52,"C",+Y,EN)) Q:EN=""!(STOP)  D
 .I '$D(^SCTM(404.52,EN)) Q
 .S NODE=$G(^SCTM(404.52,EN,0))
 .S TEAM=+$P($G(^SCTM(404.57,$P(NODE,"^"),0)),"^",2)
 .I $P(NODE,"^",4),$D(VAUTT(TEAM)) S STOP=1
 .I VAUTT=1 S STOP=1
 Q STOP
 ;
FIRST ;
 S DIC(0)="EQMNZ",DIC("A")="Select "_VAUTSTR_": " K @VAUTVB
 S (@VAUTVB,Y)=0
REDO W !,DIC("A") R X:DTIME G ERR:(X="^")!'$T D:X["?"!(X=""&('$G(SCOKNULL))) HELP^SCRPU3
 G:$G(SCOKNULL)&(X="") QUIT
 I X="A"!(X="ALL")&'$D(VAUTNA) S @VAUTVB=1 G QUIT
 ;VAUTNA doesn't allow all to be selected
 ;VAUTTN allows 'Not assigned to a team' as a selection
 I X="N"!(X="NOT")!(X="NONE") I $D(VAUTTN)!($D(VAUTPP)) S @VAUTVB="" G QUIT
 ;VAUTPP allows 'Not assigned to a practitioner' as a selection
 S DIC("A")="Select another "_VAUTSTR_": " D ^DIC G:Y'>0 FIRST D SET
 I '$D(VAUTPO) F VAI=1:0:19 W !,DIC("A") R X:DTIME G ERR:(X="")!(X="^")!'$T K Y D HELP^SCRPU3:X["?" S:$E(X)="-" VAUTX=X,X=$E(VAUTX,2,999) D ^DIC I Y>0 D SET G:VAX REDO S:'VAERR VAI=VAI+1
 ;VAUTPO - only one practitioner allowed to be selected
 G QUIT
SET S VAX=0 I $D(VAUTX) S J=$S(VAUTNI=2:+Y,1:$P(Y(0),"^")) K VAUTX S VAERR=$S($D(@VAUTVB@(J)):0,1:1) W $S('VAERR:"...removed from list...",1:"...not on list...can't remove") Q:VAERR  S VAI=VAI-1 K @VAUTVB@(J) S:$O(@VAUTVB@(0))']"" VAX=1 Q
 S VAERR=0 I $S($D(@VAUTVB@($P(Y(0),U))):1,$D(@VAUTVB@(+Y)):1,1:0) W !?3,*7,"You have already selected that ",VAUTSTR,".  Try again." S VAERR=1
 S @VAUTVB@(+Y)=$P(Y(0),U)
 Q
 ;
ERR S Y=-1 I $O(@VAUTVB@(0))="" K @VAUTVB I X="^" S SCUP=""
QUIT S:'$D(Y) Y=1
 I $D(@VAUTVB),VAUTSTR="Team",@VAUTVB=1 D:'$G(DGQUIET) EN^DDIOL("All Teams selected, this report may take some time...","","!,?10")
 K DIC,J,VAERR,VAI,VAJ,VAJ1,VAX,VAUTNI,VAUTSTR,VAUTVB,X
 Q
 ;
CLSC() ;screen on clinic selection, must be related to team prompt
 I $P(^(0),U,3)'="C" Q 0
 N TRUE,EN,TEAM
 S TRUE=0,EN=""
 F  S EN=$O(^SCTM(404.57,"E",+Y,EN)) Q:EN=""!(TRUE)  D
 .S TEAM=+$P($G(^SCTM(404.57,EN,0)),"^",2)
 .I $D(VAUTT(TEAM))!(VAUTT=1) S TRUE=1
 I VAUTT="" S TRUE=1
 Q TRUE
 ;
CLSC2() ;screen on clinic selection, must be a clinic
 I $P(^(0),U,3)'="C" Q 0
 Q 1
 ;
CLSC2OLD() ;screen on clinic selection, must be related to division prompt
 I $P(^(0),U,3)'="C" Q 0
 N TRUE,EN,INST,TDIV
 S TRUE=0,EN=""
 S TDIV=+$P(^(0),U,15) ;clinic's division
 Q:TDIV=0 0
 S INST=+$P(^DG(40.8,TDIV,0),U,7)
 I '$D(VAUTD(INST))&(VAUTD'="") S TRUE=0
 I $D(VAUTD(INST)) S TRUE=1
 I VAUTD=1 S TRUE=1
 Q TRUE
