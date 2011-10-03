PRSPESR2 ;WOIFO/JAH - PTP ESR Edit-Calls from ScreenMan Form ;07/28/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
ELAPSE(MEAL,START,STOP) ; CALCULATE THE HOURS BETWEEN 2 TIMES
 ;this function is called from ScreenMan Form Computed fields
 ;  file 458 PRSA ESR EDIT form.
 N ELAPSE
 S ELAPSE=0
 Q:($G(START)="")!($G(STOP)="") ELAPSE
 S START=$$TWENTY4(START)
 ;
 S STOP=$$TWENTY4(STOP)
 ; if stop time is next day add a day
 I STOP<START!(STOP=START) D
 .  S STOP=$$FMADD^XLFDT(DT,1,0,0,0)_"."_STOP
 E  D
 .  S STOP=DT_"."_STOP
 S START=DT_"."_START
 S ELAPSE=$$FMDIFF^XLFDT(STOP,START,3)
 ;for special case of a 24 hour segment
 I ELAPSE="1" S ELAPSE="24:00"
 ;
 ;Remove any blanks
 S ELAPSE=$TR(ELAPSE," ","")
 I $G(MEAL)>0 S ELAPSE=$$MEALESS(ELAPSE,MEAL)
 S ELAPSE=$$FIVE(ELAPSE)
 Q ELAPSE
FIVE(TIME) ;ENSURE ELAPSE IS A FIVE CHAR STRING--04:15 OR 02:00
 N FIVE,HH,MM
 I $E(TIME,1,1)="-" Q "-00:00"
 S HH="00"_$P(TIME,":"),MM="00"_$P(TIME,":",2)
 S HH=$E(HH,$L(HH)-1,$L(HH))
 S MM=$E(MM,$L(MM)-1,$L(MM))
 S MM=$P(TIME,":",2)_"0"
 S MM=$E(MM,1,2)
 S FIVE=HH_":"_MM
 Q FIVE
TWENTY4(TIME) ;CONVERT TIME TO TWENTY FOUR HOUR TIME
 ;
 ; TIME Y: 0=Mid=0,1=Mid=2400 Output: Y=time in 2400
 S Y=0
 I TIME="MID"!(TIME="NOON") D
 .   S Y=$S(TIME="NOON":1200,TIME="MID":2400,1:0)
 E  D
 .  S Y=$P(TIME,":",1)_$P(TIME,":",2),Y=+Y
 I TIME["P" D
 .  S:Y<1200 Y=Y+1200
 ;
 ; pad time with leading zeros so we always have 4 digits
 ; for cases like start times of 15 past midnight 0015
 ;
 S Y="000"_Y
 S Y=$E(Y,$L(Y)-3,$L(Y))
 Q Y
MEALESS(HHMM,MEAL) ;Remove meal time from hours total
 ; (subtract a 15 minute increment from length of time
 ; in hh:mm format, i.e. hh:mm - mm
 ;
 N X,Y,DECR,OBJ,I
 S MM=$P(HHMM,":",2) ; get minutes
 ; quit minutes or meal not quarter hours
 Q:(MM#15'=0&(+MM)!((MEAL#15)'=0&(+MEAL))) HHMM
 ; get hours
 S HH=$P(HHMM,":")
 ;
 ; convert segment minutes and meal to a digit.
 ;
 S X=MM D MEALIN S OBJ=X
 S X=$G(MEAL) D MEALIN S DECR=X
 I OBJ=0 S OBJ=4
 F I=1:1:DECR D
 . I OBJ=4 S HH="0"_(+HH-1) S HH=$E(HH,$L(HH)-1,$L(HH))
 . S OBJ=$S(OBJ=4:3,OBJ=3:2,OBJ=2:1,OBJ=1:4)
 S MM=$S(OBJ=1:15,OBJ=2:30,OBJ=3:45,1:"00")
 Q $$FIVE(HH_":"_MM)
 ;
MEALIN ;convert 15 minute meal to a digit
 I +X#15=0 S X=X\15 Q
 I "^0^00^15^30^45^60^75^90^105^120^"[("^"_$G(X)_"^") D
 .  S X=$S(+X=0:0,X=60:4,X=30:2,X=15:1,X=45:3,1:0)
 E  D
 . K X
 Q
MEALOUT ; convert meal digit to minutes
 S Y=$S(Y=1:15,Y=2:30,Y=3:45,Y=4:60,1:"00")
 Q
 ;
VALIDTT ; Set DDSERROR if not a valid type of time.
 ;This procedure is called from ScreenMan form PRSA ESR EDIT (file 458)
 ;with the validate field of the Type Of Time.
 ; set DDSERROR to reject user input, then ring bell and 
 ; display a message reject explanation
 Q:X=""!($G(PPI)'>0)!($G(PRSIEN)'>0)!($G(PRSD)'>0)
 I "^RG^AL^AA^DL^ML^RL^CP^SL^HX^CB^AD^WP^TR^TV^"'[(U_X_U) D
 . S DDSERROR=1
 . D HLP^DDSUTL("Invalid type of time.")
 I "^HX^"[(U_X_U) D
 . I $P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),"^",12)'>0 S DDSERROR=1 D HLP^DDSUTL("Holiday Excused is only allowed on a Holiday Benefit Day.  See Payroll to set this day as a holiday.")
 I $G(PPI),$G(PRSD),$P(^PRST(458,PPI,1),U,PRSD)>$G(DT) D
 . I "^AL^AA^DL^ML^RL^CP^SL^HX^CB^AD^WP^TR^TV^"'[(U_X_U) D
 ..   S DDSERROR=1
 ..   D HLP^DDSUTL("Invalid type of time. Only leave may be entered on future days")
 Q
VALIDLV(SSCH,SPST) ; Set DDSERROR if any posting is outside the
 ; tour time segements inappropriately
 ;
 ;INPUT:
 ;  SSCH : tour segments as scheduled from node 1 of the day multiple
 ;  SPST : tour segments as posted by ptp in T array format
 N OK,P1,P2,S1,S2,LV,I,I2,J,MSA,VALIDLV
 S (LV,OK,I)=0
 S VALIDLV=""
 ; put tour in similar format as posting
 D MARRAY(.MSA,SSCH)
 F  S I=$O(SPST(I)) Q:I'>0!(LV&'OK)  D
 .  S P1=I,I2=$O(SPST(I,0)),P2=$P(SPST(I,I2),U)
 .  Q:"^AL^AA^DL^CU^ML^RL^HX^SL^CB^AD^WP^TV^TR^"'[$P(SPST(I,I2),U,4)
 .  S LV=1,OK=0
 .  S J=0
 .  F  S J=$O(MSA(J)) Q:J'>0!OK  D
 ..    S S1=J,S2=$O(MSA(J,0)),S2=$P(MSA(J,S2),U)
 ..    I P1=S1!(P1>S1)&((P2=S2)!(P2<S2)) S OK=1
 ;
 I LV,('OK) S VALIDLV=1
 Q VALIDLV
 ;
MARRAY(MARRAY,SEGS) ; BUILD MINUTE ARRAY
 ; INPUT : SEGS--tour of duty segments in global format
 ; OUTPUT: MARRAY--array by reference of tour segments in minutes 
 ;          from midnight format
 ;          EXAMPLE:  
 ;   2 segment tour will look like the following:
 ;        MARRAY(945,1)=1140^03:45P^07:00P
 ;        MARRAY(1140,6)=1305^07:00P^09:45P
 ;        MARRAY(1320,11)=1380^10:00P^11:00P
 ;loop thru the 5 columns of the 7 time segments on ESR
 ; quit if we encounter an error
 ;
 N I,ANY,Z1,Z2,X,Y
 S ANY=1
 F I=1:3:21 Q:('ANY)  D
 . ;
 . ;if absolutely nothing on the segment then we're done
 .  S ANY=$L($P(SEGS,U,I)_$P(SEGS,U,I+1)_$P(SEGS,U,I+2))
 .  Q:'ANY
 .  S X=$P(SEGS,U,I)_U_$P(SEGS,U,I+1)
 .  D CNV^PRSATIM S Z1=$P(Y,U,1),Z2=$P(Y,U,2)
 .  D V0^PRSATP1
 .  S MARRAY(Z1,I)=Z2_U_$P(SEGS,U,I,I+2)
 Q
PSTML(ROW) ; AUTO POST MEAL TIME
 ; if the time segment row that we are on in a form covers
 ; the tour then post a meal.
 ; ROW - is passed as the 
 ; Z is in the form of NODE 5 in the 458.02 day mult
 ;  it changes with edits on the form
 ;  like Z=09:00A^NOON^RG^^30^NOON^08:00P^RG^^^08:00P^MID^CU^15
 ;
 N RNG,ST2SP,FLDNUM,BASE
 Q:$G(PRSML)=""!($G(PRSML)=0)
 ;
 S BASE=ROW-1*5
 ; quit if something is already in mealtime on the form
 Q:$P(Z,U,BASE+5)'=""
 ; compute the field number of the meal time for this row
 S FLDNUM=BASE+114
 ; get the start TO stop segments for this row of the form
 ; if it's an exact match then auto post the meal
 S ST2SP=$P(Z,U,BASE+1,BASE+2)
 I ST2SP=$P($G(PRSN1),U,1,2) D  Q
 .  D PUT^DDSVAL(DIE,.DA,FLDNUM,PRSML)
 .  D REFRESH^DDSUTL
 ; get the start TO stop segments for this row of the form
 ; if it covers the meal and then some autopost the meal
 N DY2,TWO,SCHED,POST,SCH,P1,P2,S1,S2
 ; TOD is a global set up in form start up in ESRFRM^PRSPESR1
 S ST2SP=$P(Z,U,BASE+1,BASE+3)
 S SCHED=$P($G(PRSN1),U,1,3)
 ; is this a two day tour? need to check before calling the
 ; code to set up the minutes array in MARRAY
 S TWO=$P($G(^PRST(457.1,+TOD,0)),U,5)
 S DY2=TWO="Y"
 D MARRAY(.POST,ST2SP)
 D MARRAY(.SCH,$P($G(PRSN1),U,1,3))
 ;get start and stop time minutes form midnight for both
 ; schedule and posting to determine if meal should be autoposted
 S P1=$O(POST(0))
 Q:P1'>0
 S P2=$P(POST(P1,1),U)
 Q:P2'>0
 S S1=$O(SCH(0))
 Q:S1'>0
 S S2=$P(SCH(S1,1),U)
 Q:22'>0
 I P1'>S1&(P2'<S2) D
 .  D PUT^DDSVAL(DIE,.DA,FLDNUM,PRSML)
 .  D REFRESH^DDSUTL
 .  S $P(Z,U,BASE+5)=PRSML
 Q
 ;
OVEREAT(ROW) ; Display warning on POST ACTION ON CHANGE for the 
 ; meal field on the form if lunch more than allotted for tour
 N MTOT,K,BASE,WORK,STR,PRSZ
 ; When X is null they are trying to delete and that's always ok
 Q:$G(Z)=""!($G(ROW)'>0)!($G(X)="")
 S BASE=ROW-1*5
 ;
 S WORK=$$ELAPSE^PRSPESR2(X,$P(Z,U,BASE+1),$P(Z,U,BASE+2))
 I $E(WORK,1,1)="-"!(WORK="00:00")!(WORK=0) D  Q
 .  S DDSERROR=1
 .  S STR="Meal time greater than or equal to time segment."
 .  I X=0 S STR=STR_"  Type @ to remove meal time."
 .  D HLP^DDSUTL(STR)
 S MTOT=0
 S PRSZ=Z S $P(PRSZ,U,BASE+5)=X
 F K=1:5:31 S MTOT=MTOT+$P(PRSZ,U,K+4)
 I MTOT>($G(PRSML)+$G(PRSML2)) D 
 .  S STR="Warning: More meal time than allotted with tour."
 .  D HLP^DDSUTL(.STR)
 Q
BURP(PRSN5) ; return ESR WORK NODE with no blank pieces
 ; PRSN5--esr work node $G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5)
 ; if there's only a meal with a zero then skip that too.
 ;^^^^^NOON^08:00P^RG^^^08:00P^MID^CU^15
 ;
 N SN,I,TSEG
 S SN=""
 F I=1:5:31 D
 .  S TSEG=$P(PRSN5,U,I,I+4)
 .;  W !,I,": ",TSEG
 .  Q:TSEG="^^^^"!(TSEG="")!(TSEG="^^^^0")
 .  S SN=SN_TSEG_"^"
 Q SN
