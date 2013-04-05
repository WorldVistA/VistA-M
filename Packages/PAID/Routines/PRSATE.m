PRSATE ;WCIOFO/JAH/PLT - Enter/Edit Employee (emp) Tour of Duty (ToD) ;03/15/2005
 ;;4.0;PAID;**8,11,27,45,55,93,112,117,121,132**;Sep 21, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;ppi=ien of 450, ppi=ien of 458, ppe=pp (yy-mm)
 ;tli = ien of t&l, tlu=t&l # (nnn), prstlv=2 for timekeeper user
 N PPI,PPE,PRSTLV,TLI,TLE,DFN
 S PRSTLV=2 D ^PRSAUTL Q:TLI<1
 F  S DFN=$$GETEMP^PRSATE6(TLE) Q:DFN<1  D
 . S PPI=$P(^PRST(458,0),"^",3),PPE=$P($G(^PRST(458,PPI,0)),"^",1)
 . D TOUREDIT(DFN,PPI,PPE,TLI,TLE,PRSTLV)
 Q
 ;
TOUREDIT(DFN,PPI,PPE,TLI,TLE,PRSTLV) ;
 N C0,NH,FLX,PMP,PP,PB,ENT,SRT,WTL,TYP,Z,TD,ERROR,NOERROR,PRSDAY,PRSETD
 N PRSTW,PRSTWA,PRSTWB
 ;
 ;  PRSTW: employees telework type
 ;  PRSTWA: telework eligibilty string
 ;  PRSTWB: this pay period (PPI) telework eligibilty
 ;
 ;   Entitlement lookup leaks many variables.  Following R used in 
 ;   this routine but may be looked up again despite the fact they R 
 ;   leaked by ^PRSAENT.  See PRSAENT for further doc.
 ;
 ;   
 ;    C0=emps 0 node in file 450    NH= emps 8B normal hrs
 ;    FLX= compressed/flextime code (0=none,C=compressed,F=flextime)
 ;    PMP= premium pay indicator 
 ;      ( D=entitled Sun., F=entitled Sat./Sun.,
 ;        E=entitled variable Sat./Sun. premium pay,
 ;        G=entitled variable Sun. prem pay, X=title 5 emps
 ;        R,C,O=different types of firefighters)
 ;  * PP= emps pay plan
 ;    DB = pay basis-1:full,2:part,3:intermit
 ;    ENT= 39 char entitlement string
 ;  Entitlement lookup.
 D ^PRSAENT I ENT="" D ERROR(1) S OUT=1 Q
 ;
 ; Display header/Ask pp (NOL^PRSATE2 returns SRT = Current, Next, Last)
 D NOW^%DTC S NOW=% K %
 W:$E(IOST,1,2)="C-" @IOF
 W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?29,"EMPLOYEE TOUR OF DUTY"
 D HDR^PRSADP1,NOL^PRSATE2
 Q:SRT="^"
 I SRT="L" S PPI=PPI-1,PPE=$P($G(^PRST(458,PPI,0)),"^",1)
 ;
 ;get emp's flexitime code, telework ind.
 S FLX=$$FLEXIND^PRSATE6(PPI,DFN,SRT),PRSTWA=$$TWE^PRSATE0(DFN,PPI),PRSTWB=$P(PRSTWA,U,4)="Y"
 ;entitled reg. scheduled is o
 I $E(ENT,1)="0" D
 .  S Z=$E(ENT,2),TD=$S(Z="D":3,1:4) D NONE
 E  D
 .;
 .;    initialize t&l for this ToD
 .;
 .  S WTL=TLI
 .  I "NL"[SRT D
 ..    S TYP=0
 .  E  D
 ..    S TYP=$$ISTEMPTR()
 ..;
 ..;  For temp ToDs--ask user for T&L ToD will be worked
 ..;  Quit if we don't get a valid T&L unit.
 ..;
 ..    I TYP S WTL=$$ASKTLWRK^PRSATE6(TLE)
 .;
 .;  Save current ToD in case user aborts with an unacceptable ToD.
 .;
 .   D SAVETOUR^PRSATE6(PPI,DFN)
 .;
 .  I WTL'<1,TYP'["^" D 
 ..    D A1
 ..;
 ..; verify firefighter ToD after compressed ind. edit.  Don't accept 
 ..; ToD until its within guidlines. If TK force exits, restore old ToD.
 ..  I PMP="C" S NOERROR=0 F  D  Q:NOERROR
 ...    N ERROR D FFTOUR^PRSATE6(PPI,DFN,SRT,.ERROR)
 ...    I $$ISERRORS^PRSATE6(.ERROR) D
 ....      I $$ASKTOFIX^PRSATE6() D
 .....        D A1
 ....      E  D
 .....        D RESTORE^PRSATE6(PPI,DFN) S NOERROR=1
 ...    E  D
 ....      S NOERROR=1
 K NOW Q
 ;
ISTEMPTR() ; IS TEMPORARY ToD ?
 ; Ask user if ToD is temp or perm & convert TYP to true false flag
 ;    Permanent set TYP=0,  Temporary set TYP=true (1)
 ; 
 S TYP=$$ASKTEMP^PRSATE6() I TYP'["^" S TYP=$E(TYP,1)="T",WTL=TLI
 Q TYP
 ;
A1 ; Set up for emps ToD look up. Screen allows Daily ToDs & days off 
 ; for daily emps.  Everyone else gets days off & all other ToDs.
 ; Screen further ensures ToD is available either to all t&ls 
 ; or to t&l that this emp is working in.
 ;
 N DIC,X,DB
 S DIC="^PRST(457.1,",DIC(0)="AEQMN"
 S DIC("S")="I "_$S($E(ENT,1)="D":"Y<3",1:"Y>5!(Y=1)")_",$P(^PRST(457.1,+Y,0),U,4)!($D(^PRST(457.1,+Y,""T"",""B"",WTL)))"
 ;
 ; Setup a fixed or varying ToD.  Compressed ToDs must be varying;
 ; ask TK about all others.
 ;
 S DB=$P(C0,U,10) I FLX="C"!("KM"[PP&(DB=1)&(NH=72)) D VAR QUIT
 S X=$$ASKFIXED() QUIT:X="^"  I X="N" D VAR QUIT
 I PRSTWB S X=$$ASKTWMF^PRSATE6() QUIT:X="^"  I X="Y" D FX,VAR QUIT
 D FX
 QUIT
 ;
FX ; Fixed ToD
FX1 S DIC("A")="Select TOUR OF DUTY: "
 W ! D ^DIC
 Q:Y'>0
 S TD=+Y
 ;check overlap
 K PRSDAY,PRSETD
 F DAY=1:1:14 S $P(PRSETD,U,DAY)=$S(DAY#7<2:1,1:TD) D
 . N TOLD
 . S PRSDAY(DAY)=$P($G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),U,1,4),$P(TOLD,U,DAY)=$S(SRT="N"&($P($G(^(0)),U,3)):$P(^(0),U,4),1:$P($G(^(0)),U,2)) S:DAY#7>1 $P(PRSDAY(DAY),U,6)=$P($G(^(0)),U,13),$P(PRSDAY(DAY),U,7,999)=$G(^(4))
 . D PRSDAY^PRSATE0
 . QUIT
 D ENT^PRSATE5 I $G(PRSERR) K PRSERR G FX1
 S Y=$G(^PRST(457.1,TD,1)),TDH=$P(^(0),"^",6),HRS=TDH*10
 S (ZENT,STR)=""
 D OT^PRSATP,VS^PRSATE0
 I STR'="" W *7,!!,STR G FX
 I '$D(^PRST(458,PPI,"E",DFN,"D",0)) S ^(0)="^458.02^14^14"
 I SRT="N" D
 .  D F1
 E  D
 .  F DAY=2:1:6,9:1:13 D SET
 .  S TD=1,(Y,TDH)="" F DAY=1,7,8,14 D SET
 .  W "  ... done" D:HRS'=NH ERROR(2,NH,HRS)
 .  D:'PRSTWB T2
 .  QUIT
 I 'PRSTWB D HOL,RS K HRS,STR
 QUIT
 ;
 ;
F1 F DAY=2:1:6,9:1:13 D NX
 S TD=1 F DAY=1,7,8,14 D NX
 W "  ... done"
 D:HRS'=NH ERROR(2,NH,HRS)
 QUIT
 ;
VAR ; Variable ToD
 D ^PRSATE0
 I SRT'="N" D T2
 D HOL,RS
 Q
 ;
NONE ; No ToD
 N TYP2,UPDT,Y,TDH,PRSTWB
 S PRSTWB=0
 W !!,"This is an intermittent employee with no specified tour."
 W !!,"Time records will now be updated to indicate this."
 I '$D(^PRST(458,PPI,"E",DFN,"D",0)) S ^(0)="^458.02^14^14"
 I '$$PERM^PRSALIB(PPI,DFN) D
 .  W !!,"Not all tour days are assigned a permanent status."
 .  I $$UPDTQ^PRSALIB(),$$TMPST^PRSALIB(.TYP2) D UPDSTAT^PRSALIB(PPI,DFN,TYP2)
 S (Y,TDH)="",TYP=0,WTL=TLI
 I SRT="N" D
 .  F DAY=1:1:14 D NX
 E  D
 .  F DAY=1:1:14 D SET
 W "  ... done"
 D HOL,RS
 Q
 ;
 ;
RS ; Get Comp Ind
 S Y=$G(^PRST(458,PPI,"E",DFN,0))
 S FLX=$S((SRT="N")&($P(Y,U,7)]""):$P(Y,U,7),1:$P(Y,U,6))
 S DIR(0)="SAM^C:Compressed;F:Flexitime;0:None"
 S DIR("A")="Compressed Tour Indicator: "
 S DIR("B")=$S(FLX="C":"Compressed",FLX="F":"Flexitime",1:"None")
 D ^DIR K DIR I "^C^F^0^"'[(U_Y_U) S Y=FLX
 ;
 ;  Intermittent employee cannot have compressed tour.
 ;
 I $P(C0,U,10)=3,Y="C" D  G RS
 .   W *7,!?5,"Compressed tour not valid for this employee."
 ;
 I Y="F" S Z=0 D  I Z G RS
 .S PAY=$P(C0,U,21),PB=$P(C0,U,20)
 .I "0123456789GU"'[PAY S Z=1
 .I PAY="G",PB'=2 S Z=1
 .I PAY="U","27EXT"'[PB S Z=1
 .I Z W *7,!?5,"Flexitime not valid for this employee."
 .Q
 S $P(^PRST(458,PPI,"E",DFN,0),U,$S(SRT="N":7,1:6))=Y
 I $D(^PRST(458,"ATC",DFN)) D UPD^PRSASAL
 K PAY,ZENT Q
 ;
 ;
NX ; Set Next ToD
 S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0))
 I $P(Z,"^",2)=TD,'$P(Z,"^",3),'PRSTWB!($P($G(^PRST(458,PPI,"E",DFN,"D",DAY,8)),U)=$G(PRSTW(DAY))) QUIT
 S $P(Z,"^",3,4)="2^"_TD,$P(Z,"^",10,11)=DUZ_"^"_NOW
 S ^PRST(458,PPI,"E",DFN,"D",DAY,0)=Z S:PRSTWB $P(^(8),U,5)=$G(PRSTW(DAY))
 S ^PRST(458,"ATC",DFN,PPI,DAY)=""
 QUIT
 ;
 ;
SET ; Set ToD
 N ZLASTPP,OLD,SCH,PRSTW1,PRSTW5
 ;get Zero node of emp pp rec, Old ToD, & Prior scheduled ToD.
 ;ZLASTPP is true if a ToD present on this day last pp.
 S Z=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0)),PRSTW1=$P($G(^(8)),U),PRSTW5=$P($G(^(8)),U,5),OLD=$P(Z,U,2),SCH=$P(Z,U,4)
 S ZLASTPP=$P($G(^PRST(458,PPI-1,"E",DFN,"D",DAY,0)),U,2)'=""
 ;quit if old tour and its time segments/telework tour=edited one
 I OLD=TD,$G(^PRST(458,PPI,"E",DFN,"D",DAY,1))=Y,PRSTW1=$G(PRSTW(DAY))!'$G(PRSTWB) QUIT
 ;Z is updated with new ToD info & replaces the emp ToD record.
 S $P(Z,U,8)=TDH,$P(Z,U,10,11)=DUZ_U_NOW
 I $P(Z,U,12) S $P(Z,U,12)="" ; remove holiday flag
 ;Temp ToD, store T&L ToD will be worked if it's not emp's usual t&l.
 I TYP,TLI'=WTL S $P(Z,U,9)=WTL
 ;no existing ToD on this day.
 I OLD="" S $P(Z,U,1,3)=DAY_U_TD_U_TYP D S0:ZLASTPP,S1,S8($G(PRSTW(DAY)),1):$G(PRSTWB) QUIT
 ;clean out postings and other ToD info since ToD is changing
 D CLEANTOD(PPI,DFN,DAY,TD)
 I SCH="" S $P(Z,U,2,4)=TD_U_TYP_U_OLD D S0,S1 D:$G(PRSTWB) S8($G(PRSTW(DAY)),1),S8(PRSTW1,5) QUIT
 S $P(Z,U,5,7)="^^"
 I SCH=TD,PRSTW5=$G(PRSTW(DAY))!'$G(PRSTWB) S $P(Z,U,2,4)=TD_"^^" K ^PRST(458,"ATC",DFN,PPI,DAY) D S1 D:$G(PRSTWB) S8("",5),S8($G(PRSTW(DAY)),1) QUIT
 S $P(Z,U,2,3)=TD_U_TYP D S0,S1 D:$G(PRSTWB) S8($G(PRSTW(DAY)),1)
 QUIT
 ;
 ;
 ; Set up x-ref for supervisor approval of ToD change
 ;
S0 S ^PRST(458,"ATC",DFN,PPI,DAY)=""
 Q
 ;
 ;
S1 ;
 S ^PRST(458,PPI,"E",DFN,"D",DAY,0)=Z S:Y'="" ^(1)=Y
 Q
 ;
 ;a=telework tour reg/med, b=1 if reg/temp tour, 5 if prior/next tour
S8(A,B) ;set telework tour in node 8 of daily multiple
 ;prstwb=1 telework eligible
 I '$G(PRSTWB) K ^PRST(458,PPI,"E",DFN,"D",DAY,8) QUIT
 S $P(^PRST(458,PPI,"E",DFN,"D",DAY,8),U,B)=A
 ; if no telework data then clean up
 I ^PRST(458,PPI,"E",DFN,"D",DAY,8)?."^" K ^PRST(458,PPI,"E",DFN,"D",DAY,8)
 QUIT
 ;
 ;
T2 ; Ask if second ToD
 N X
 ;
 ;  Don't ask for Daily ToDs
 ;
 Q:$E(ENT,1)="D"
 ;
 S X=$$ASK2NDTR()
 Q:X'="Y"  G ^PRSATE4
 ;
 ;
HOL ; Determine if Holiday within ToD
 N DAY
 D ^PRSAPPH
 Q:'$D(HOL)
 S TT="HX",DUP=1
 D E^PRSAPPH K DUP,HOL,TT
 Q
 ;
 ;
CLEANTOD(PPI,DFN,DAY,TD) ; CLEAN OUT TOUR
 N PRSDT,MIEN
 K ^PRST(458,PPI,"E",DFN,"D",DAY,1),^(2),^(3),^(10),^(8) I TD<5 K ^(4) S $P(Z,U,13,15)="^^"
 ; if employee is PTP with active memo then reset the ESR day
 S PRSDT=$P($G(^PRST(458,PPI,1)),U,DAY)
 S MIEN=$$MIEN^PRSPUT1(DFN,PRSDT)
 I MIEN D
 . N PRSFDA
 . S PRSFDA(458.02,DAY_","_DFN_","_PPI_",",146)="3" ; status = resubmit
 . S PRSFDA(458.02,DAY_","_DFN_","_PPI_",",148)="Tour Changed" ; remarks
 . D FILE^DIE("","PRSFDA"),MSG^DIALOG()
 Q
 ;
 ;
ERROR(NUM,VAR1,VAR2) ;
 W *7,!!
 I NUM=1 W "Employee has no Pay Entitlement table entry."
 I NUM=2 D
 .  Q:$G(NH)=112
 .  W "Warning: Normal Hours are ",$G(VAR1),"; Tour Hours are ",$G(VAR2)
 Q
 ;
 ;
ASKFIXED() ;GET USER'S YES OR NO RESPONSE TO FIXED ToD QUESTION
 N DIR,DIRUT,Y
 S DIR("A")="Do you wish to enter a fixed Mon-Fri Tour"
 S DIR(0)="Y"
 S DIR("?")="Answer NO to create any other type of tour."
 S DIR("?",1)="Fixed tours are Monday - Friday with the same hours."
 D ^DIR
 Q $S(Y=1:"Y",Y=0:"N",1:"^")
 ;
 ;
ASK2NDTR() ;GET USER'S YES OR NO RESPONSE TO 2nd ToD QUESTION
 N DIR,DIRUT,Y
 S DIR("A")="Do you wish to enter a Second Tour"_$S($G(SRT)="X":"",1:" for any Day")
 S DIR(0)="Y"
 S DIR("B")="N"
 S DIR("?",1)="Answer Yes to add a second tour.  No to continue."
 S DIR("?")="Enter ^ to escape and cancel this tour change."
 D ^DIR
 Q $S(Y=1:"Y",Y=0:"N",1:"^")
 ;
 ;
