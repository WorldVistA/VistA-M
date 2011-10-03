PRS8HRSV ;WCIOFO/JAH-HOLIDAY FLAG, TIME CHECKER, WK() SET; 04/05/07 ; 6/30/09 12:40pm
 ;;4.0;PAID;**29,52,102,108,112,119**;Sep 21, 1995;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;  Set up variable for holiday worked or holiday excused
 ;  Holiday worked coded 2 in DAY array
 ;  Holiday excused coded 1 in DAY array
 ;  A NON holiday is coded as all zero's in day array.
 ;
 ;  HOLIDAY WORKED
 S HOLWKD=$E(DAY(DAY,"HOL"),M)=2
 ;
 ;  HOLIDAY EXCUSED
 S HOLEX=$E(DAY(DAY,"HOL"),M)=1
 ;
 ;  HOLIDAY EXCUSED OR HOLIDAY WORKED
 S HOLWKEX=$E(DAY(DAY,"HOL"),M)
 Q
 ;
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ;
CHK ; --- Check ENT for acceptable X value
 ;    Pieces of Y have values in locations corresponding to premium
 ;    times in value of X.  Values in Y string are locations
 ;    in entitlement string where associated time in X is
 ;    located.
 ;   --------------------------------------------------
 ;                 | Fixed      |  Premium
 ;     Piece       | Position in|  Type Of Time
 ;    Of Y-String  | Entitlement|
 ;    & **WK()     | String     |
 ;    -----------  | -----------|  --------------------
 ;        7        |    28      |  comp earned
 ;        9        |     2      |  unscheduled regular
 ;       16        |    19      |  hrs excess 8-d
 ;       17        |    20      |  hrs excess 8-d2
 ;       18        |    21      |  hrs excess 8 d3
 ;       20        |    12      |  OT total hrs d
 ;       21        |    13      |  OT total hrs d2
 ;       22        |    14      |  OT total hrs d3
 ;   ---------------------------------------------------
 ;
 N ZZ,PRSHOLSET S Y="^^^^^^28^^2^^^^^^^19^20^21^^12^13^14^^^^3^4^^^^",PRSHOLSET=0
 ;
 ;   Set Y to a premium time in Y string, based on X 
 ;   OR set Y to zero if X is a non premium time or parttime hours.
 ;
 I X'=32 S Y=+$P(Y,"^",X)
 ;
 ;   IF Y is premium time & not Unscheduled regular but employee not
 ;   ENTITLED to that type of time THEN set X to zero.
 ;
 I +Y,Y'=2,'$E(ENT,+Y) S X=0
 ;
 ;   Overtime & Not entitled set X & Y to unscheduled regular
 ;
 I "^12^13^14^"[("^"_Y_"^"),'X S X=9,Y=2
 ;
 ;   IF regular unscheduled (Y=2) & not hourly for regular unscheduled
 ;   THEN set X=0, unless Baylor then X gets regular unscheduled.
 ;
 I X,Y=2,$E(ENT,+Y)'="H" S X=$S(TYP'["B":0,1:9)
 ;
 ;   IF 36/40 AWS with WP determine eligibility for OT/CT
 ;   Skip this check if time is HW (X=29) or OT on Hol (X=24)
 ;   
 I "KM"[$E(AC,1),$E(AC,2)=1,$P(C0,U,16)=72,X'=32,X'=29,X'=24 D
 . I HT>32 S X=$S(VAL="O":TOUR+15,VAL="e":7,1:X)  Q
 . I TH(W)>160 S X=$S(VAL="O":TOUR+19,VAL="e":7,1:X)  Q
 . I HT'>32,TH(W)'>160 S X=9
 ;
 ;   If X is hours in excess of 8/day & > 40/week & type of time
 ;   is compensatory time X = 0
 ;
 I "^16^17^18^"[("^"_X_"^"),TH(WK)>160,"Ee"[VAL S X=0
 ;
 ;   ** Significance of checking "X" now as opposed to Y.
 ;
 K Y Q:'X
 ;
 ;   (Hours excess 8/day, OT hours, Reg hours @ OT rate, Holiday hours, 
 ;   part time hours) OR unscheduled regular & Nurse or Nurse Hybrid.
 ; ### DO WE NEED TO ADD !HYBRID TO THIS CHECK ???
 I "^16^17^18^20^21^22^29^30^31^32^"[("^"_X_"^")!(X=9&(TYP["N"!(TYP["H"))) D
 .;
 .;     If today holiday or holiday benefit day for employee
 .;
 .I $$HOLIDAY^PRS8UT(PY,DFN,DAY) D  Q:'X
 ..;
 ..;     If part time hours & entitled to (Holiday [Shift day, 2 or 3])
 ..;
 ..I X=32,$E(ENT,TOUR+21),HOLWKD S ZZ=X,X=$S($G(DAY(DAY,"OFF"))'=1:TOUR+28,1:9) D SET S X=$S(TYP'["I":ZZ,1:9) Q
 ..;
 ..;     IF not part time hours & intermittent employee & employee
 ..;     entitled to holiday overtime & holiday worked THEN set TIME 
 ..;     to OT on Holiday and credit that TIME in SET.
 ..;
 ..I X'=32,TYP["I",$E(ENT,25),HOLWKD S ZZ=X,X=24 D SET S X=0
 ..;
 ..;     IF conditions same as above except employee is NOT entitled
 ..;     to Holiday OT THEN use X as coded to credit TIME.
 ..;
 ..I X'=32,TYP["I",'$E(ENT,25),HOLWKD S ZZ=0 D SET S X=9
 ..;
 ..;     IF not part time hours & emp. is entitled to Holiday OT But
 ..;     they did not work the holiday THEN if emp. is part time or
 ..;     intermittent set type of time to Regular hrs @ OT rate 3
 ..;     otherwise OT @ Holiday rate & IF the original coded TIME
 ..;     NOT = reg hrs @ OT rate(shift D,2,3) THEN credit TIME at 
 ..;     OT on holiday or Reg hours @ OT rate.  THEN also credit time 
 ..;     as unscheduled regular.  ** why code time twice?
 ..;
 ..I X'=32,$E(ENT,25),'HOLWKD D
 ...S ZZ=X
 ...; for 36/40 AWS w/ WP or NP report OT on Holiday as (OK/OS)
 ...; For 9mo AWS w/ Recess report OT on Holiday as (OK/OS)
 ...I +NAWS,VAL["O",$E(DAY(DAY,"HOL"),M)=0 S X=24 D SET S X=0 Q
 ...;
 ...S X=$S(TYP["P"!(TYP["I"):TOUR+28,1:24) D SET
 ...I TYP["P"!(TYP["I") S X=9 D SET
 ...S X=0
 .;
 .;     IF type of time is part time hours for intermittent employee
 .;     THEN set TIME = unscheduled regular.
 .;
 .I X=32,TYP["I" S X=9
 .;
 .;    Part time hours or unscheduled regular.
 .;
 .Q:X=32!(X=9)
 .;
 .;     IF employee worked holiday THEN set TIME to zero & if original
 .;     coded type of time is NOT regular hours @ OT rate DO
 .;
 .I HOLWKD S ZZ=X,X=0 D
 ..;
 ..;     IF entitled to Holiday pay for this shift THEN set TIME
 ..;     to Holiday HRS (shift d, 2 or 3)
 ..;
 ..I $E(ENT,TOUR+21) S X=TOUR+28
 ;
 ;     IF employee is part time or a nurse or nurse hybrid 
 ;     & they worked the holiday
 ; ### SHOULD HYBRID BE ADDED TO THIS CHECK  HOW SHOULD THESE HYBRIDS
 ; ### TREATED ON A HOLIDAY
 I TYP["P"!(TYP["N")!(TYP["H"),HOLWKD,X=32 D
 .;
 .;     J gets start & stop times for employee's holiday tour.
 .;     Start/stop times are represented w/ natural numbers
 .;     from 0-96.  Each 15 minute segment of the 24 hour period
 .;     beginning & ending at midnight can be represented w/
 .;     a positive integer.  I.e.  1 = mid-12:15am,
 .;     2 = 12:15-12:30a ... 96 = 11:45pm-mid.
 .;
 .;     Loop thru each set of start & stop times.  IF the single
 .;     1/4 hr segment we're working w/ falls w/in any of the nurses 
 .;     start & stop times THEN set TIME to Holiday Hours Day.
 .;
 .N I,J S J=$G(^TMP($J,"PRS8",DAY,"HWK")),ZZ=X
 .;
 .F I=1:2 Q:$P(J,U,I)=""  I M'<$P(J,U,I),M'>$P(J,U,I+1),'$G(PRSHOLSET) S X=29
 .;
 .;     Holiday hrs-Day. reset X if 2 day tour.  Otherwise X = 0.
 .;
 .I X=29 D SET S X=$S($P(^PRST(457.1,$P(DAY(DAY-1,0),U,2),0),U,5)="Y":ZZ,1:0)
 ;
 ;
SET ; --- Set value into WK array
 ;
 ; Nurses on the 36/40 AWS are FT with Normal Hours of 72.  Nurses on the 9 month
 ; AWS are PT with Normal Hours of 80.  Neither will not have Part Time Hours
 ; counted in their 8B string.
 ;
 Q:$E(AC,2)=1&($P(C0,U,16)=72)&(X=32)  ; 36/40 AWS
 Q:$E(AC,2)=2&(NH=320)&(X=32)  ; 9month AWS before any Recess processed
 ;
 ;     Full time employee & part time hours & normal hours WK1 + WK2
 ;     = biweekly normal hours.
 ;
 I $P(C0,"^",10)=1,X=32,NH(1)+NH(2)=NH Q
 ;
 ;     For all types of TIME, increment the WK array.
 ;
 I +X D  Q
 . S $P(WK(W),"^",+X)=$P(WK(W),"^",+X)+1
 . I "^29^30^31^"[("^"_X_"^") S PRSHOLSET=1
 ;
 ;     When X is zero, reset to originally coded time.
 ;
 I 'X S X=ZZ Q
 Q
 ;
 ;
TH ; --- increment total hours & compensatory time hours.
 ; Posted RG/OT/CT that is >8/day but < 40/week and < 80/pp will not be
 ; counted in TH or TH(W)
 ; 
 ; I $S(VAL=4:1,"osEe"[VAL!(VAL="O"&('HOLWKD)):1,1:0) S TH=TH+1,TH(W)=TH(W)+1
 ;
 I $S(VAL=4:1,"osEe"[VAL!(VAL="O"&('HOLWKD)):1,1:0) D
 . Q:(HT>32)&(TH(W)<160)&(NH<320)&($E(ENT,19)=1)
 . Q:(HT>32)&(TH(W)<160)&(NH=320)&($E(ENT,19)=1)&($E(AC,2)=2)  ; 9month AWS
 . S TH=TH+1,TH(W)=TH(W)+1
 Q
 ;
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ;
G8 ; --- Check for greater than 8 hours in day
 ;
 Q:HTP'>32!(VAL="E")
 ;
 ; Checks for Hours Excess 8/day (DA/DE)
 S X=TOUR+15 D CHK^PRS8HRSV
 I X,NH<320,CYA2806>0 S CYA2806=CYA2806-1
 Q:X
 ;
 ; Checks for OT Total Hours (OA/OE)
 I TYP["I"!(TYP["P"),TYP'["B",TH(W)>160 S X=TOUR+19 D CHK^PRS8HRSV
 Q
 ;
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
