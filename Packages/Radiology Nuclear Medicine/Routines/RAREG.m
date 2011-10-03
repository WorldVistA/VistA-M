RAREG ;HISC/GJC AISC/MJK,RMO-Register Rad/NM Patient ;8/15/97  11:04
 ;;5.0;Radiology/Nuclear Medicine;**23,85**;Mar 16, 1998;Build 4
 ; 06/07/2007 KAM/BAY RA*5*85 Remedy Call 185568 Exam Backdating
 K RADTE
PAT D SET^RAPSET1 I $D(XQUIT) K XQUIT Q
 ; Is our sign-on location inactive?
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,RADIRYN,RAINATVE
 S RAINATVE=$$INLO^RAUTL13(+RAMLC)
 I RAINATVE D  I $D(XQUIT)!(RADIRYN) K RADIRYN,RAINATVE Q
 . W !!?3,"Your current Imaging Location: '"_$P($G(RACCESS(DUZ,"LOC",+RAMLC)),U,2)_"' is inactive."
 . W !?3,"If you wish to register this patient for an exam, locations must be switched.",!
 . S DIR(0)="YA",DIR("B")="Yes"
 . S DIR("A")="Do you wish to switch locations at this time? "
 . S DIR("?")="Enter 'Y'es to switch locations, 'N'o to exit."
 . D ^DIR K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . S RADIRYN=$S('+Y:1,1:0) K X,Y Q:RADIRYN
 . W ! D KILL^RAPSET1,^RAPSET
 . I $D(XQUIT) K RACCESS Q
 . Q
 K RADIRYN,RAINATVE
 D HOME^%ZIS K X S DIC(0)="AEMQZ"_$S('$D(RAVSTFLG):"L",1:"") D ^RADPA G Q:Y<0 S RADFN=+Y,RACAT=$S($P(Y(0),"^",4)']"":"OUTPATIENT",1:$P($P(^DD(70,.04,0),$P(Y(0),"^",4)_":",2),";")) S:'$D(RAVSTFLG) RAREGFLG=""
 D ^RADEM2 G Q:RAPOP I $D(RAVSTFLG) S J=$O(^RADPT(RADFN,"DT",0)) G ADD1:$D(^(+J,0)) W !?3,*7,"A previous exam date does not exist for this patient!",! G Q
DT K RADTEBAD N RAHRS S RAHRS=+$P($G(^RA(79,+RAMDIV,.1)),"^",24) ;How many hrs in adv?
 R !!,"Imaging Exam Date/Time: NOW// ",X:DTIME
 G Q:'$T!(X=" ")!(X="^")
 S:X="" RANOW="",X="NOW"
 S %DT(0)=-$$FMADD^XLFDT($$NOW^XLFDT,0,RAHRS,0,0),%DT="ETXR"
 D ^%DT K %DT G DT:Y<0
 ;
 ; 06/06/2007 KAM/BAY Remedy Call 185568 Added next line
 I '$$BACKDATE(Y) G DT
 ;
DT1 S RADTE=Y,RADTI=9999999.9999-RADTE
 I '$D(RAVSTFLG),$D(^RADPT(RADFN,"DT",RADTI,0)) D  G DT
 . W !,*7,"Patient already has exams (which may have been cancelled) for this date/time."
 . W !,"....use 'Add Exams to Last Visit' option, or enter a date/time a few minutes",!,"    earlier or later."
 . Q
 ;Next line checks for case where exam date entered is a 'subset' of an
 ;existing exam date (i.e. 10:00 is a subset of 11:00 because DIC lookup
 ;drops trailing zeros - this was causing users to hang  ;CH 4/19/94
 S RADTEBAD=$O(^RADPT(RADFN,"DT","B",RADTE)) I RADTEBAD[RADTE W *7,!,"?? Please try a different time of day (a few minutes later)." G DT
 ;next line is a lock to prevent multiple users from adding/overwriting
 ;the same "DT" node if they begin registration of a case for the same
 ;patient during the same minute using NOW as the exam date/time.
 L +^RADPT(RADFN,"DT",RADTI):1 I '$T W !,*7,"Someone else is now editing an exam for this patient on the date/time",!,"you selected.  Please try entering a date/time a few minutes earlier or later." G DT
 K RADTEBAD I $D(RANOW),$D(RAWARD) S RACAT="INPATIENT"
 I '$D(RANOW) K RAWARD,RABED,RASER D ^RASERV S:$D(RAWARD) RACAT="INPATIENT"
 G ^RAREG1
 ;
ADD S RAVSTFLG="" G PAT
ADD1 S YY=^RADPT(RADFN,"DT",J,0)
 I $P(YY,"^",4)'=+RAMLC D  G Q
 . W !!?3,"Last visit date is for location '",$S('$D(^RA(79.1,+$P(YY,"^",4),0)):"Unknown",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"Unknown"),"'."
 . W !?3,"Your current location is defined as: '"
 . W $P($G(^SC(+$P($G(^RA(79.1,+RAMLC,0)),"^"),0)),"^")_"'."
 . W !?3,"You must log into the '"
 . W $S('$D(^RA(79.1,+$P(YY,"^",4),0)):"Unknown",$D(^SC(+^(0),0)):$P(^(0),"^"),1:"Unknown"),"' location"
 . W !?3,"to add exams to the last visit.",$C(7)
 . K DIR S DIR(0)="E" D ^DIR K DIR Q
 S X1=DT,X2=-1 D C^%DTC I X>+YY,'$D(^XUSEC("RA MGR",DUZ)) W !!?3,*7,"Last visit was before yesterday. No adding exams allowed!" G Q
 W !!,"Last Visit Date/Time: " S Y=$P(YY,"^") D D^RAUTL W Y,!!?1,"Case No.",?10,"Procedure",?42,"Status",!?1,"--------",?10,"---------",?42,"------"
 N RA0,RA17,RA1 S RA1=0 ;1=valid rpt, 0=stub/no rpt
 F I=0:0 S I=$O(^RADPT(RADFN,"DT",J,"P",I)) Q:I'>0  I $D(^(I,0)) S Y=^(0) D ADD2
 I $P(YY,U,5),RA1 S Y=1 D  Q
 . I $Y>(IOSL-6) N DIR S DIR(0)="E" D ^DIR Q:Y'>0
 . W !!?2,"NOTE: Because all the cases within this exam date/time are"
 . W !?8,"part of one order set, and a valid report has been filed"
 . W !?8,"already, additional procedures may not be added to this visit."
 . W !?8,"You must register the desired exam(s) at a later date/time."
 . N Y R !!?2,"Press RETURN to continue:",Y:DTIME
 . Q
 S RARD("A")="Do you wish to add exams to this visit? ",RARD(1)="Yes^add exams to this visit",RARD(2)="No^stop",RARD("B")=2,RARD(0)="S" D SET^RARD K RARD G Q:$E(X)'="Y"
 S RAREC="",Y=$P(YY,"^") G DT1
ADD2 W !?3,$P(Y,"^"),?10,$E($S($D(^RAMIS(71,+$P(Y,"^",2),0)):$P(^(0),"^"),1:"Unknown"),1,30),?42,$S($D(^RA(72,+$P(Y,"^",3),0)):$P(^(0),"^"),1:"Unknown")
 K RAVLEDTI,RAVLECNI,RASHA,RARSH,RAPIFN,RARDTE,RALIFN S RAVLEDTI=J,RAVLECNI=I,RADIV=$P(YY,"^",3),RACAT=$S('$D(RAWARD):$P($P(^DD(75.1,4,0),$P(Y,"^",4)_":",2),";"),1:RACAT)
 S:"CS"[$E(RACAT)&($D(^DIC(34,+$P(Y,"^",9),0))) RASHA=$P(^(0),"^") S:"R"[$E(RACAT)&($D(^RADPT(RADFN,"DT",J,"P",I,"R"))) RARSH=^("R")
 S:$D(^VA(200,+$P(Y,"^",14),0)) RAPIFN=+$P(Y,"^",14) S:$P(Y,"^",21) RARDTE=$P(Y,"^",21) S:$D(^SC(+$P(Y,"^",22),0)) RALIFN=+$P(Y,"^",22)
 I $P(Y,"^",17)]"" D  ; is this a non-stub report 
 . S RA17=+$P(Y,"^",17) ;keep RA17 only if image stub rpt exists
 . I '$D(^RARPT(RA17,0))#2 K RA17 Q  ; no rpt
 . Q:$$STUB^RAEDCN1(RA17)  ;quit if image stub rpt
 . S RA1=1 K RA17 ; valid (non-stub record)
 Q
 ;
Q K %,%DT,DA,DIC,GMRAL,POP,RABED,RACAT,RADFN,RADIV,RADTE,RADTI,RALIFN,RANME,RAOIFN,RAPIFN,RAPOP,RAPTFL,RARDTE,RAREGFLG,RARSH,RASER,RASEX,RASHA,RAVLECNI,RAVLEDTI,RAVSTFLG,RAWARD,X,XQUIT,Y,YY
 K %W,%X,%Y,%Y1,D,D3,DDER,DDH,DFN,DI,DIG,DIH,DIU,DIW,DIWF,DIWI,DIWL,DIWR
 K DIWT,DIWTC,DIWX,DN,I,RACANC,RACN0,RACPT,RACPTNDE,RAEXIT,RAHSMULT,RAI
 K RAN,RAOBR4,RAPARENT,RAPRCNDE,RAPROC,RAPROCI,RAPROCIT,RAPRV,RASKIPIT
 K VA,VADM,VAERR,Z
 Q
 ;06/06/2007 KAM/BAY for Remedy Call 185568 Added next 11 lines
BACKDATE(RADT) ;
 N RACON,RAEXMDAT,RATODAY,RAANS,Y
 S RACON=1
 S X="NOW" D ^%DT S RATODAY=Y K %DT
 I (RATODAY-RADT)>9999 D
 . W !!,"********************************************************"
 . W !,"The Exam date entered is more than one year in the past."
 . W !,"********************************************************"
 . R !!,"Are you sure you want to continue Y/N?: N// ",RAANS:DTIME
 . I "Y,y,YES,yes,Yes"'[RAANS!(RAANS="") S RACON=0
 Q RACON
