PRSATE6 ; WCIOFO/JAH-VALIDATE FIREFIGHTER TOURS OF DUTY (ToD);3/19/99
 ;;4.0;PAID;**45**;Sep 21, 1995
 Q
FFTOUR(PPI,DFN,WHICHPP,ERROR) ; Validate a Firefighter ToD
 N WK1BTOT,WK2BTOT,BASEMAX,PMP
 ;
 S PMP=$$GETPMP(DFN)
 ;
 ;Define maximum base hrs for 1 week of a firefighter ToD.
 ;
 S BASEMAX=$$GETBSMAX(DFN,PPI,WHICHPP)
 ;
 ; Loop thru week 1,2 & get total base ToD hrs scheduled.
 ;
 D GETTOTS(PPI,DFN,WHICHPP,.WK1BTOT,.WK2BTOT)
 ;
 ; convert minutes to 1/4 hour segments
 ;
 S WK1BTOT=WK1BTOT/15,WK2BTOT=WK2BTOT/15
 ;
 ; Determine any error in ToD
 ;
 D GETERROR(WK1BTOT,WK2BTOT,BASEMAX,PMP,.ERROR)
 ;
 ; display any errors
 ;
 I $$ISERRORS(.ERROR)  D
 . D DISPERR(PPI,DFN,PMP,WHICHPP,.ERROR,BASEMAX)
 Q
 ;=======================
 ;
GETBSMAX(DFN,PPI,WHICHPP) ; GET MAX BASE ToD HRS FOR FIREFIGHTER'S WEEK
 ;INPUT:
 ;  Employee DFN  or internal entry number in file 450 
 ;OUTPUT:
 ;  return total base hrs in .25 hr segments that 
 ;  this fire fighter is allowed in a week of thier ToD.
 ;  If this isn't a firefighter (Premium pay indicator C)
 ;  then return 0
 ;
 S MAX=0
 S TOURTYPE=$$FLEXIND(PPI,DFN,WHICHPP)
 S MAX=$S(TOURTYPE="C":53,1:40)
 Q MAX*4
 ;=======================
 ;
GETPMP(DFN) ; RETURN PREMIUM PAY INDICATOR CODE FROM FILE 450
 ;^DD(450,548,0) = PREMIUM PAY IND^F^^PREMIUM;6
 Q $P($G(^PRSPC(DFN,"PREMIUM")),"^",6)
 ;=======================
 ;
GETTOTS(PPI,DFN,WHICHPP,WK1TOT,WK2TOT) ;
 N TOURDAY,TOUR,SEGMNT,START,STOP,SPECIND
 ;
 S (WK1TOT,WK2TOT)=0
 F TOURDAY=1:1:14  D
 .  S TOUR=$$GETTOUR(PPI,DFN,WHICHPP,TOURDAY)
 .  S MEAL=$$MEALTM(PPI,DFN,TOURDAY,WHICHPP)
 .;
 .;  Read each segment of ToD.
 .;
 .  F SEGMNT=1:3 D  Q:$P(TOUR,"^",SEGMNT)=""
 ..   S (STARTHR,START)=$P(TOUR,"^",SEGMNT)
 ..   S (STOPHR,STOP)=$P(TOUR,"^",SEGMNT+1)
 ..   S SPECIND=$P(TOUR,"^",SEGMNT+2)
 ..;
 ..;  if this is base ToD hours then add the time to the approriate
 ..;  week.
 ..;
 ..   I SPECIND="",$G(START)'="",$G(STOP)'="" D
 ...     D MINUTES(.START,.STOP)
 ...     S (WK1LEN,WK2LEN)=0
 ...;
 ...;    when ToD crosses midnight check if it's Sat. or Sun
 ...;    & adjust the stop time
 ...;
 ...     I STOP<(START+1) D
 ....      I (TOURDAY#7)=0 D
 .....        D SPLIT(STARTHR,STOPHR,.WK1LEN,.WK2LEN)
 .....        I WK1LEN+1>WK2LEN S WK1LEN=WK1LEN-MEAL
 .....        I WK1LEN<WK2LEN S WK2LEN=WK2LEN-MEAL
 .....        D UPTOT(.WK1TOT,.WK2TOT,WK1LEN,WK2LEN)
 ....      E  D
 .....        S STOP=1440+STOP
 .....        S LEN=STOP-START-MEAL
 .....        I TOURDAY<8 D UPTOT(.WK1TOT,.WK2TOT,LEN,0)
 .....        I TOURDAY>7 D UPTOT(.WK1TOT,.WK2TOT,0,LEN)
 ...     E  D
 ....       S LEN=STOP-START-MEAL
 ....       I TOURDAY<8 D UPTOT(.WK1TOT,.WK2TOT,LEN,0)
 ....       I TOURDAY>7 D UPTOT(.WK1TOT,.WK2TOT,0,LEN)
 ;
 Q
 ;=======================
 ;
MEALTM(PPI,DFN,DAY,WHICHPP) ;
 ; RETURN LENGTH OF MEALTIME FOR THIS EMPs ToD ON THIS DAY.
 N TOUR
 S LEN=0
 S TOUR=$G(^PRST(458,PPI,"E",DFN,"D",DAY,0))
 S TOUR=$P(TOUR,"^",2)
 I $P(TOUR,"^",4),(WHICHPP="N") S TOUR=$P(TOUR,"^",4)
 I TOUR S LEN=$P($G(^PRST(457.1,TOUR,0)),"^",3)
 ;
 Q LEN
 ;=======================
 ;
MINUTES(T1,T2) ; CONVERT TIME 1 & TWO TO MINUTES FROM MIDNIGHT
 ; OF THE CURRENT DAY.  IF T2 IS LESS THAN OR EQUAL TO T1 THEN
 ; IT IS ASSUMMED TO BE ON THE NEXT DAY.
 ;
 N X,Y
 ;
 ;call to convert start & stop to minutes from midnight
 ;
 S X=T1_"^"_T2
 D CNV^PRSATIM
 S T1=$P(Y,"^",1),T2=$P(Y,"^",2)
 Q
 ;=======================
 ;
SPLIT(DAY,T1,T2,L1,L2) ; SPLIT two day ToD into 2 segments.
 ;INPUT:
 ;  DAY = day of pay period that the ToD begins.
 ;  T1  = start time of ToD in 08:00A format.
 ;  T2  = stop time of ToD in 11:00P format.
 ;OUTPUT:
 ;  L1 = Length of ToD (minutes) from start time to midnight.
 ;  L2 = Length of ToD (min) from midnight to stop time in next day.
 ;
 N X,Y
 S X=T1_"^"_"MID"
 D CNV^PRSATIM
 S L1=$P(Y,"^",2)-$P(Y,"^",1)
 S X="MID^"_T2
 S L2=$P(Y,"^",2)-$P(Y,"^",1)
 ;
 ; If it's the 2nd Sat of the pay period then move the carry over
 ; to the first week of this pay period.
 ;
 I DAY=14 S TEMP=L2,L2=L1,L1=TEMP
 Q
 ;=======================
 ;
UPTOT(W1T,W2T,W1LN,W2LN) ;
 S W1T=W1T+W1LN
 S W2T=W2T+W2LN
 Q
 ;=======================
 ;
GETERROR(W1TOT,W2TOT,BMAX,PMP,ERROR) ;
 ;
 ;    1. Code C firefighters on compressed ToDs may not have base 
 ;       ToD hours that exceed 53 for either week 1 or 2.
 ;     2. Code C firefighters without compressed ToDs may not have 
 ;        base hours that exceed 40 for either week 1 or 2.
 ;     3. Code C firefighters may not have base ToD hours that 
 ;        exceed 80.
 ;
 I PMP="C" D
 .  I W1TOT>BMAX S ERROR(1)=1
 .  I W2TOT>BMAX S ERROR(2)=1
 .  I (W2TOT+W1TOT)>(80*4) S ERROR(3)=1
 Q
 ;=======================
 ;
ISERRORS(ERROR) ; RETURN TRUE IF THERE ARE ERRORS IN THE ERROR ARRAY
 S (ENUM,IS)=0
 F  S ENUM=$O(ERROR(ENUM)) Q:ENUM=""!IS  I +$G(ERROR(ENUM)) S IS=1
 ;
 Q IS
 ;=======================
 ;
DISPERR(PPI,DFN,PMP,WHICHPP,ERROR,BMAX) ;
 ;
 ; See GETERRORS for error descriptions.
 ;
 N FLX,COUNT,WK
 S FLX=$$FLEXIND(PPI,DFN,WHICHPP)
 S FLX=$S(FLX="C":"Compressed",FLX="F":"Flexitime",1:"None")
 ;
 S WK="",COUNT=0
 I $G(ERROR(1)) S WK="one"
 I $G(ERROR(2)) S WK="two"
 I WK="two",$G(ERROR(1)) S WK="one and two"
 W @IOF,!!!,?5,"There are the following problems with the tour entered:"
 I +$G(ERROR(1))!(+$G(ERROR(2))) D
 . S COUNT=COUNT+1
 . W !!,?7,COUNT,".  Code ",PMP," firefighters with a compressed/flex "
 . W !,?11,"indicator of ",FLX," may not have BASE tour hours that "
 . W !,?11,"exceed ",BMAX/4," for week ",WK,"."
 ;
 I +$G(ERROR(3)) D
 . S COUNT=COUNT+1
 . W !!,?7,COUNT,".  Code ",PMP," firefighters may not have BASE tour "
 . W !,?11,"hours that exceed 80 for the pay period."
 ;
 Q
 ;=======================
 ;
ASKTOFIX() ;RETURN TK RESPONSE--DO YOU WANT TO FIX THE ToD?
 N DIR,DIRUT,Y
 W !!
 S DIR("A",1)="This tour MUST BE CORRECTED or it will be removed."
 S DIR("A")="Correct the tour"
 S DIR(0)="Y"
 S DIR("B")="Y"
 S DIR("?",1)=" You must correct the tour.  Answer Yes to re-edit the tour."
 S DIR("?")=" If you answer No the entire tour will be removed. "
 D ^DIR
 Q Y
 ;=======================
 ;
GETTOUR(PPI,DFN,WHICHPP,PPDAY) ; This function returns the employees ToD
 ; based on the WHICHPP variable.  WHICHPP can be set to N, for next
 ; pay period, or C for current pay period or 'L' for last.  If set 
 ; to 'N'ext, we have to look at the prior scheduled field in the 
 ; current pay period to see if the ToD is changing next pp.
 ;
 N TEMPTOUR,TOURNODE,TOUR
 I PPI'>0!(DFN'>0)!(PPDAY'>0) Q 0
 S TOURNODE=$G(^PRST(458,PPI,"E",DFN,"D",PPDAY,0))
 S TOUR=$P(TOURNODE,U,2)
 S TEMPTOUR=$P(TOURNODE,U,3)
 I WHICHPP="N",+TEMPTOUR D
 .  S TOUR=$P(TOURNODE,"^",4)
 I TOUR'>0 Q 0
 Q $G(^PRST(457.1,TOUR,1))
 ;=======================
 ;
SAVETOUR(PPI,DFN) ;SAVE ToD in ^TMP global
 ;
 S %X="^PRST(458,"_PPI_",""E"","_DFN_",""D"","
 S %Y="^TMP($J,""OLDTOUR""," D %XY^%RCR
 Q
 ;=======================
 ;
RESTORE(PPI,DFN) ;restore a ToD
 ;  use with EXTREME CAUTION. SAVETOUR should be called 1st.
 ; This utility first removes the entire "D" node from the
 ; input employee's pay period record.  It depends on the fact that
 ; a backup of an earlier copy of the "D" node was saved in TMP.
 N %X,%Y
 K ^PRST(458,PPI,"E",DFN,"D")
 S %X="^TMP($J,""OLDTOUR"","
 S %Y="^PRST(458,"_PPI_",""E"","_DFN_",""D"","
 D %XY^%RCR
 Q
 ;=======================
 ;
ASKTEMP() ; ASK USER-TEMP OR PERM ToD CHANGE
 N DIR,DIRUT
 S DIR("A")="Is this tour change Temporary or Permanent? "
 S DIR("B")="P"
 S DIR(0)="SAMO^P:Permanent;T:Temporary"
 S DIR("?")="A Temporary change is for this Pay Period only."
 S DIR("?",1)="A Permanent change is for this and future Pay Periods."
 D ^DIR
 I $D(DIRUT) S Y="^"
 Q Y
 ;=======================
 ;
GETEMP(TLE) ; SELECT EMP FROM THE PASSED T&L UNIT
 N DIC,X,Y,D
 S DIC("A")="Select EMPLOYEE: "
 S DIC("S")="I $P(^(0),""^"",8)=TLE"
 S DIC(0)="AEQM"
 S DIC="^PRSPC("
 S D="ATL"_TLE
 W ! D IX^DIC S DFN=+Y K DIC
 Q DFN
 ;=======================
 ;
FLEXIND(PPI,DFN,WHICHPP) ;
 ;Return emp's flexitime code (compressed, flex or none)
 ; INPUT:
 ;    PPI = pp internal #
 ;    DFN =  emps internal # from 450/458
 ;    WHICHPP = N for next pp otherwise current
 Q $P($G(^PRST(458,PPI,"E",DFN,0)),"^",$S(WHICHPP="N":7,1:6))
 ;=======================
 ;
ASKTLWRK(TLE) ; ASK TIMEKEEP WHICH TLU ToD WILL BE WORKED
 N DIC,X,Y
 S DIC="^PRST(455.5,"
 S DIC(0)="AEQM"
 S DIC("A")="T&L on which Tour will be worked: "
 S DIC("B")=TLE
 W ! D ^DIC
 Q +Y
