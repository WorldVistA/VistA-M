PRS8 ;HISC/MRL,WIRMFO/JAH-DECOMPOSITION, PROCESSOR ;01/30/2007
 ;;4.0;PAID;**22,111**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This is the routine which is used to start the decomposition
 ;process.  There are several entry points which allow one to
 ;process either an entire T&L, all entries or a single person.
 ;Once the decision is made as to which entries to process the
 ;routine ^PRS8DR is called and everything starts running.
 ;
 D DT^DICRW,HOME^%ZIS S DIK="^DOPT(""PRS8"","
 G OPT:$D(^DOPT("PRS8",3)) K ^DOPT("PRS8")
 S ^DOPT("PRS8",0)="PAID Decomposition Option"
 F I=1:1 S X=$T(@I) Q:X']""  D
 .S ^DOPT("PRS8",I,0)=$P(X,";",3)
 .S ^DOPT("PRS8","B",$P(X,";",3),I)=""
 D IXALL^DIK
 ;
OPT ; --- option selection
 W !! S DIC="^DOPT(""PRS8"",",DIC(0)="EAQM" D ^DIC
 I Y>0 S SEE=1 D @+Y G OPT
 G ^PRS8CV
 ;
1 ;;EMPLOYEE
 W @IOF,!?21,"DECOMPOSE TIME FOR A SPECIFIC EMPLOYEE",!
11 S (SEE,SAVE)=1,DIC("A")="Select Desired PAY PERIOD:  "
 D PY I 'OK D ^PRS8CV Q
12 S DIC("A")="Decompose Time for which EMPLOYEE?  "
 D EMP G 11:'OK,12:OK<0
 S (OK,SEE)=1 D EXIST G 12:'OK
 D PRINT
 G 12 ;ask for another
 ;
2 ;;T&L DECOMPOSITION
 W @IOF,!?35,"DECOMPOSE TIME FOR A T&L",!
 D ^PRS8TL Q
 ;
3 ;;VIEW
 W @IOF,!?22,"VIEW DECOMPOSED TIME FOR A SPECIFIC EMPLOYEE",!
 S SAVE=0,SEE=1 G 11
 ;
DFN ; --- entry point where DFN and PY are defined
 N %
 S DFN=$G(DFN),PY=$G(PY)
 D CKPY Q:'OK
 D CKDFN Q:OK'>0
 S SEE=+$G(SEE)
 S SAVE=+$G(SAVE)
 G ^PRS8DR
 ;
PY ; --- select pay period to decompose
 W ! S DIC="^PRST(458,",DIC(0)="AEQMZ" D ^DIC
 S PY=+Y K DIC
 ;
CKPY ; --- entry point for checking PY variable
 S (E,OK)=0,PY=+$G(PY) D
 .I '$D(^PRST(458,+PY,0)) S E=1 Q  ;no/invalid pp
 .S PPD=$G(^PRST(458,+PY,1)) I 'PPD S E=2 Q  ;no/invalid days node
 .S X1=+PPD,X2=-14 D C^%DTC S PRS8D=X
 .S X=$G(^PRST(458,"AD",X)),PPD(0)=+X,PPD(1)=$G(^PRST(458,+X,1)) ;last pp dates
 .S X1=+PPD,X2=14 D C^%DTC ;15th day
 .S X=$G(^PRST(458,"AD",X)),PPD(15)=+X
 .S OK=1 D EN^PRS8HD K HO,PRS8D
 I 'OK,E,PY'=-1 D NOPE
 Q
 ;
EMP ; --- select employee
 W ! S DIC="^PRSPC(",DIC(0)="AEQMZ" D ^DIC
 S OK=0,DFN=+Y K DIC Q:DFN'>0  S OK=1
 ;
CKDFN ; --- entry point for checking DFN
 S E=0,DFN=+$G(DFN)
 S:'$D(^PRSPC(+DFN,0)) E=3
 S:'$D(^PRST(458,+PY,"E",+DFN,0)) E=4
 I E,DFN'=-1 D NOPE
 Q
 ;
ONE ; --- entry point for decomposing a single entry (non-inteactive)
 N %,DA
 S SEE=0,SAVE=1,PY=+$G(PPI)
 D CKPY G END:'OK
 D CKDFN G END:'OK
 D ^PRS8DR G END
 ;
PRINT ; --- where do I display this
 S PRS8("PGM")="1^PRS8DR",PRS8("VAR")="DFN^PY^SAVE^SEE^PPD^PPD(^HD(",PRS8("DES")="Single Employee Descomposition" D DEV^PRS8UT
 K PRS8 Q
 ;
EXIST ; --- check to see if data exists and show
 K VAL,VALOLD S VALOLD=$G(^PRST(458,+PY,"E",+DFN,5)) Q:VALOLD=""
 D ^PRSAENT,^PRS8VW ;show existing data
 S TMTD=$G(^PRST(458,+PY,"E",DFN,0)),TMTD=$S($P(TMTD,"^",2)="X":1,1:0)
 W !!,"The above data already exists from a previous decomposition.  You may decompose"
 W !,"again at this time to identify any changes.  Since this "
 I TMTD W "record has been TRANSMITTED",!,"already the original record will not be overwritten!!" Q
 E  W "is a",$S(SAVE:"n EDIT",1:" VIEW")," option",!,"running the decomposition WILL ",$S('SAVE:"NOT ",1:""),"overwrite existing information!"
 ;
DECOM ; --- decompose again
 W !!,"Do you wish to run the decomposition" S %=2 D YN^DICN
 I % S OK=$S(%=1:1,1:0) Q
 W !?4,"Answer YES to rerun the decomposition process for this individual and ",$S('TMTD!('SAVE):"VIEW",1:"SAVE"),!?4,"the changes.  Respond NO to QUIT now!" G DECOM
 ;
NOPE ; --- can't process
 Q:'E  S ER(+E)=$P($T(ER+E),";;",2) W:SEE !?4,ER(+E),$C(7) S OK=0 Q
 ;
END ; --- all done here/kill variables
 Q
 ;
AUTOPINI(PPIEN,EMPIEN,PRIOR,PRVAL) ; initialize auto-posted data
 ; This call backs out auto-posted data from the time card (if any)
 ; inputs
 ;   PPIEN  = pay period IEN (file 458)
 ;   EMPIEN = employee IEN (file 450, sub-file 458.01)
 ;   PRIOR  = optional flag, true (=1) to return original data
 ;   PRVAL  = optional array, required if PRIOR true
 ;            passed by reference
 ;            contains the original data (before removal) in the format
 ;              PRVAL(day number,node number)=value of node
 ;            if no auto-posted data then array would be undefined
 ;
 N DAY,NODE,TOUR
 I $G(PRIOR) K PRVAL
 ;
 ; loop thru days of employee time card
 S DAY=0 F  S DAY=$O(^PRST(458,PPIEN,"E",EMPIEN,"D",DAY))  Q:DAY=""  D
 . ; quit if day not auto-posted (DUZ not = .5 POSTMASTER)
 . Q:$P($G(^PRST(458,PPIEN,"E",EMPIEN,"D",DAY,10)),"^",2)'=.5
 . ;
 . ; if PRIOR true then save the current data
 . I $G(PRIOR) F NODE=2,3,10 D
 . . S PRVAL(DAY,NODE)=$G(^PRST(458,PPIEN,"E",EMPIEN,"D",DAY,NODE))
 . ;
 . ; determine tour of duty
 . S TOUR=$P($G(^PRST(458,PPIEN,"E",EMPIEN,"D",DAY,0)),"^",2)
 . ;
 . ; if day off then delete auto-posted data else restore day to HX
 . I TOUR=1 K ^PRST(458,PPIEN,"E",EMPIEN,"D",DAY,2),^(3),^(10)
 . E  D
 . . S $P(^PRST(458,PPIEN,"E",EMPIEN,"D",DAY,2),"^",3)="HX"
 . . K ^PRST(458,PPIEN,"E",EMPIEN,"D",DAY,3)
 Q
 ;
AUTOPRES(PPIEN,EMPIEN,PRVAL) ; restore auto-posted data
 ; This call restores original auto-posted data that was initialized
 ; by AUTOPINI. See AUTOPINI for description of inputs.
 ;
 N DAY,NODE
 ;
 ; loop thru days with auto-posted data
 S DAY=0 F  S DAY=$O(PRVAL(DAY)) Q:'DAY  D
 . ; loop thru nodes and restore original data
 . F NODE=2,3,10 I $D(PRVAL(DAY,NODE)) D
 . . S ^PRST(458,PPIEN,"E",EMPIEN,"D",DAY,NODE)=PRVAL(DAY,NODE)
 Q
 ;
ER ; error messages
 ;;Invalid/Missing Pay Period passed (variable PY)
 ;;The 1 node for the Pay Period is missing but needed to process
 ;;Employee does not exist in Employee (450) file
 ;;Employee has no timekeeping record for requested Pay Period
