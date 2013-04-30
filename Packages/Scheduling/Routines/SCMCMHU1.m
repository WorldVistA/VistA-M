SCMCMHU1 ;BP-CIOFO/LLH - Mental Health Reports (cont.) ; 02/08/2012 09:15 AM
 ;;5.3;Scheduling;**589**;AUG 13, 1993;Build 41
 ;
 ; created to use with new Mental Health reports
 ;
PRMTT ;Prompt for team.
 ;
 ;This subroutine was copied from SCRPU1 and modified to return MH teams. Additionally, 
 ;the code was modified to set all mental health teams into the VAUTT array if all was 
 ;selected. This was done so that all other routines could be used to process the data
 ;
 I '$D(VAUTD) G ERR
 S VAUTVB="VAUTT",DIC="^SCTM(404.51,",VAUTNI=2,VAUTSTR="Team",DIC("B")=""
 ;screen for mental health teams
 S DIC("S")="I $$MHTEAM^SCMCMHU1(Y)"
 G FIRST
 ;
MHTEAM(IEN) ; Screen for mental health teams only
 ; input: IEN - internal record number for the team
 ;output: VALID - 1 if a valid mental health team, 0 if not
 ;
 N VALID
 I $P(^SD(403.47,$P(^SCTM(404.51,IEN,0),U,3),0),U,1)'="MENTAL HEALTH TREATMENT" Q 0
 I $D(VAUTD(+$P(^SCTM(404.51,IEN,0),U,7))) Q 1
 I VAUTD=1 Q 1
 Q 0
 ;
 ;
PRACT ; Patch 589, Change Practitioner to Clinician/Provider
 ;Prompt for One (set VAUTPO) or One,Many,All,None Practitioner(s)
 I '$D(VAUTT) G ERR
 S VAUTVB="VAUTP",VAUTSTR="Clinician/Provider",VAUTNI=2,DIC="^VA(200,"
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
 ;PRACT ; patch 589 - added subroutine, changed Practitioner to Clinician/Provider 
 ; ;Prompt for One (set VAUTPO) or One,Many,All,None Clinician/Provider(s)
 ; I '$D(VAUTT) G ERR
 ;S VAUTVB="VAUTP",VAUTSTR="Clinician/Provider(s)",VAUTNI=2,DIC="^VA(200,"
 ;S DIC("S")="I $$PRACS^SCMCMHU1()"
 ;G FIRST
 ;
 ;PRACS() ;Practitioner screen - off of team selection
 ;N EN,STOP,NODE,TEAM
 ;S EN="",STOP=0
 ;I '$D(^SCTM(404.52,"C",+Y)) Q 0
 ;Position Assignment History file
 ;F S EN=$O(^SCTM(404.52,"C",+Y,EN)) Q:EN=""!(STOP) D
 ;.I '$D(^SCTM(404.52,EN)) Q
 ;.S NODE=$G(^SCTM(404.52,EN,0))
 ;.S TEAM=+$P($G(^SCTM(404.57,$P(NODE,"^"),0)),"^",2)
 ;.I $P(NODE,"^",4),$D(VAUTT(TEAM)) S STOP=1
 ;.I VAUTT=1 S STOP=1
 ;Q STOP
 ; 
FIRST ;
 S DIC(0)="EQMNZ",DIC("A")="Select "_VAUTSTR_": " K @VAUTVB
 S (@VAUTVB,Y)=0
 ;
REDO W !,DIC("A") R X:DTIME G ERR:(X="^")!'$T D:X["?"!(X=""&('$G(SCOKNULL))) HELP
 G:$G(SCOKNULL)&(X="") QUIT
 ;patch 589 call to GETALL is to get all Mental health teams, also must set
 ;VAUTVB if Clinican/Provider = All
 I X="A"!(X="ALL")&'$D(VAUTNA) D  G QUIT
 .I VAUTVB="VAUTT" D GETALL Q
 .I VAUTVB="VAUTP" S @VAUTVB=1 Q
 .Q
 S DIC("A")="Select another "_VAUTSTR_": " D ^DIC G:Y'>0 FIRST D SET
 I '$D(VAUTPO) F VAI=1:0:19 W !,DIC("A") R X:DTIME G ERR:(X="")!(X="^")!'$T K Y D HELP:X["?" S:$E(X)="-" VAUTX=X,X=$E(VAUTX,2,999) D ^DIC I Y>0 D SET G:VAX REDO S:'VAERR VAI=VAI+1
 G QUIT
 ;
SET S VAX=0 I $D(VAUTX) S J=$S(VAUTNI=2:+Y,1:$P(Y(0),"^")) K VAUTX S VAERR=$S($D(@VAUTVB@(J)):0,1:1) W $S('VAERR:"...removed from list...",1:"...not on list...can't remove") Q:VAERR  S VAI=VAI-1 K @VAUTVB@(J) S:$O(@VAUTVB@(0))']"" VAX=1 Q
 S VAERR=0 I $S($D(@VAUTVB@($P(Y(0),U))):1,$D(@VAUTVB@(+Y)):1,1:0) W !?3,*7,"You have already selected that ",VAUTSTR,". Try again." S VAERR=1
 S @VAUTVB@(+Y)=$P(Y(0),U)
 Q
 ;
ERR S Y=-1 I $O(@VAUTVB@(0))="" K @VAUTVB I X="^" S SCUP=""
QUIT S:'$D(Y) Y=1
 I $D(@VAUTVB),VAUTSTR="Team",@VAUTVB=1 D:'$G(DGQUIET) EN^DDIOL("All Teams selected, this report may take some time...","","!,?10")
 K DIC,J,VAERR,VAI,VAJ,VAJ1,VAX,VAUTNI,VAUTSTR,VAUTVB,X
 Q
 ;
HELP ; 
 W:'$D(VAUTNA) !,"ENTER:",!?5,"- A or ALL for all Mental Health ",VAUTSTR,"s, or"
 W !?5,"- Select individual Mental Health "_VAUTSTR W:'$D(VAUTPO) " -- limit 20"
 W !?5,"Imprecise selections will yield an additional prompt."
 I $O(@VAUTVB@(0))]"" W !?5,"- An entry preceeded by a minus [-] sign to remove entry from list."
 I $O(@VAUTVB@(0))]"" W !,"NOTE, you have already selected:" S VAJ=0 F VAJ1=0:0 S VAJ=$O(@VAUTVB@(VAJ)) Q:VAJ=""  W !?8,$S(VAUTNI=1:VAJ,1:@VAUTVB@(VAJ))
 Q
 ;
GETALL ; user selected all MH teams, rather than manipulate other routines
 ; will set all the mental health teams for the division into the team array
 ;
 ; input: none
 ;output: VAUTT array
 ;
 K @VAUTVB
 S @VAUTVB=0
 N CNT,MHT,STR
 S (CNT,MHT)=0
 F  S MHT=$O(^SCTM(404.51,MHT)) Q:(MHT'>0)!(CNT>20)  D
 .S STR=$G(^SCTM(404.51,MHT,0))
 .I $P(^SD(403.47,$P(STR,U,3),0),U,1)'="MENTAL HEALTH TREATMENT" Q
 .I VAUTD=1!($D(VAUTD(+$P(STR,U,7)))) S @VAUTVB@(MHT)=$P(STR,U,1),CNT=CNT+1
 Q
DELOUT() ; ask user if Summary should be in a delimited output format
 ; input - none
 ;output - 1 if delimited output
 ; 0 if a regular report format is desired
 ;
 N X,DTOUT,DUOUT,DIROUT,Y
 S DIR("A")="Should the Summary be a '^' delimited format?",DIR("B")="N"
 S DIR("?")="Enter 'Y' for '^' output, 'N' for a formatted report."
 S DIR(0)="Y"
 D ^DIR
 ;I $D(DTOUT)!(X="") S Y=$S(DIR("B")="Y":1,1:0)
 I $D(DUOUT)!($D(DIROUT)) S Y=-1
 K DIR
 Q +Y
 ;
 ;patch 589 - copied from SORT^SCRPU2 and modified to change Practitioner with
 ; Clinician
SORT() ;
 ;Prompt for sorting by Division, Team, Clinician or Division, Practitioner, Team
 ;
EN1 N X
 W !,"Sort By:",!?10,"[1] Division, Team, Clinician",!?10,"[2] Division, Clinician, Team"
 W !?10,"[3] Clinician,Associated Clinic"
 W !!,"Select 1 or 2 or 3: "
 R X:DTIME
 I (X="^")!'$T Q 0
 I (X'="1")&(X'="2")&(X'=3) D HLP3 G EN1
 I (X["?")!(X="") D HLP3 G EN1
 Q X
HLP3 ;
 ;help prompt
 W !,"Enter: ",!?5,"- 1 to sort by Division, Team, Clinician "
 W !?10,"- 2 to sort by Division, Clinician, Team"
 Q 
