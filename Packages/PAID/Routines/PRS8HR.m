PRS8HR ;WCIOFO/JAH - DECOMPOSITION, HOURS ;7/14/2008
 ;;4.0;PAID;**2,22,29,42,52,102,108,112,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine is called by ^PRS8PP (premium pay calculator)
 ;=====================================================================
 ; ** indicates incompleted comments
 ;
 ;VARIABLE DEFINITION
 ;
 ; TYP   =  contains codes representing type of employee.
 ;          It's a composite code string w/ characters that
 ;          represent pay plan, duty basis, & normal hours.
 ;    CODE  REPRESENTS      CODE   REPRESENTS
 ;     D     daily            f     firefighter
 ;     W     wagegrade        P     part-time
 ;     N     nurse            d     doctor
 ;     B     baylor plan      dR    doctor/resident or intern
 ;     H     Nurse Hybrid     ""    *
 ;     I     intermittent
 ; VAL   =  Single char code represents employee's work status for
 ;          current 15 min increment.
 ; FLX   =  Flex tour indicator.
 ; TH(W) =  Tour Hours for week 1, TH(1) & week 2, TH(2)
 ; TH    =  Tour Hours
 ; HTP   =  PAYABLE hours worked today.
 ; HT    =  Hours worked today.
 ; AV    =  String w/ most normal types of time (see bottom of PRS8EX)
 ;          does NOT contain premium times or unscheduled time (OoEes4)
 ;====================================================================
 ;
 S AV="1235nHMLSWNARUXYVJFGDZq"
 ;
 ;   Loop thru each quarter hour segment of day.
 ;   Check for times in AV array.
 ;   Proceed w/ calculation if Overtime worked on Holiday.
 ;
 F M=1:1:96 D
 .  S VAL=$E(D,M)
 .;
 .;    If non premium type of time or (overtime on holiday)
 .;
 .  I AV[VAL!(VAL="O"&($E(DAY(DAY,"HOL"),M)=2)) D CALC
 Q
 ;
 ;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 ;
CALC ; --- Entry point for calculating placement of time
 ;
 ;     Set up variables for calculations and comparisons in this routine
 ;
 N HOLWKD,HOLEX,HOLWKEX
 D ^PRS8HRSV
 ;
 ;     IF intermittent employee on continuation of pay OR overtime on 
 ;     holiday THEN increment Pay Period tour hours and current weeks 
 ;     tour hours.
 ;
 I TYP["I",VAL["V"!(VAL="O"&(HOLWKD)) S TH=TH+1,TH(W)=TH(W)+1
 ;
 ;     IF part time doctor & total hours = 80 & type of
 ;     time is unscheduled, overtime, comptime THEN quit
 ;
 I TYP["d",TYP["P",TH=320,"4OosEe"[VAL Q
 ;
 ;     IF INT doctor & total hours = 80 THEN quit
 ;
 I TYP["I",$E(AC,1)="L",TH=320,"4OosEe"[VAL Q
 ;
 ;     IF type of time is anything but Leave Without Pay "W" or Non-Pay "n"
 ;     THEN increment total hrs HT & increment HTP.  Also update
 ;     ^TMP global for reference during the processing of On-Call (PRS8OC).
 ;
 I "Wn"'[VAL S HT=HT+1,HTP=HTP+1,^TMP($J,"PRS8",DAY,"HT")=HT
 ;
 ;---------------------------------------------------------
 ;     IF entitled to VCS commission sales & normal time(1) ??(2,3)
 ;     & holiday excused set X to type of time=Piece Worker Hol excused.
 ;     Then IF part time set X to part time hours code.
 ;
 I $E(ENT,38),"123"[VAL,HOLEX S X=36 D CHK^PRS8HRSV D  Q:X
 .  I TYP["P" S X=32 D CHK^PRS8HRSV
 ;
 ;---------------------------------------------------------------
 ;
 ;     Don't mess w/ fire fighters
 ;
 Q:"Ff"[TYP
 ;
 S GO=0
 ;     IF compressed tour & parttime & tour hours are over 80
 ;     OR tour hours = 80 & it's overtime, comptime, or unscheduled reg.
 ;
 ; Check for FT
 I $E(AC,2)=1,NH>319,("OoseE4"[VAL) S GO=1
 ;
 ; Check for week
 I (TH(W)>160&("OoseE4"[VAL))!(TH(W)=160&("OosEe4"[VAL)) S GO=1
 ;
 ; Check for day
 I HT>32,"OoseE4"[VAL S GO=1
 ;
 ;     Following segment is concerned w/ variations of part time
 ;     employees (TYP["P"), & 1 baylor (TYP["B").
 ;-------------------------------------------------------------------
 ;
 ;     Doctor over 8 hours
 ;
 I TYP["Pd",HT>32 S GO=0 ; part-time doctors PT + PH must = NH
 ;
 I TYP["P",HOLWKD S GO=0
 ;
 ;     Baylor plan & ct/ot/s
 ;
 I TYP["B","EeOos"[VAL S GO=1
 ;
 ;-------------------------------------------------------------------
 ;     GO set in cases where employee maybe eligible for OT
 ;     due to over > 8/day OR > 40/week.
 ;
 S X=0 I GO D TH^PRS8HRSV D OVER840^PRS8HROT Q
 ;
 ;-------------------------------------------------------------------
 ;-------------------------------------------------------------------
 ;     GO not set for compressed schedule of at least 80 hrs.
 ;     GO not set for non compressed schedule of over 40 hrs.
 ;     IF GO is set and we are evaluating normal hours or
 ;     HOLIDAY OVERTIME use NORMHRS to increment TIME
 ;     in week array.  THEN QUIT.
 ;
 S GO=1
 I FLX="C",NH>319 S GO=0
 I FLX'="C",NH(WK)>160,TYP'["Pd" S GO=0 ;IF pt-doctor don't set GO=0
 I GO,"1235nHMLSWNARUXYVJFGDZq"[VAL!(VAL="O"&(HOLWKD)) S X=32 D CHK^PRS8HRSV Q
 ;
 ;--------------------------------------------------------------------
 ;   Check employees with Normal hours less than 80. (Baylor NH=320)
 ;
 I NH'>319!(($E(AC,2)=2)&(NH=320)) D TH^PRS8HRSV D  Q
 .I FLX="C" D  Q:X
 ..;
 ..; For PT employees review hours worked to determine X
 ..I "OosEe4"'[VAL S X=32  ; All tour time = PT/PH
 ..;
 ..; Checks for CT
 ..I "Ee"[VAL D
 ...; <8/DAY & <40/WK  = UN/US
 ...I HT'>32,TH(W)'>160 S X=9 Q
 ...S X=7 ; CE/CT
 ..;
 ..; Checks for all other types of time
 ..I "Oos4"[VAL D
 ...I HT>32 S X=TOUR+15 Q  ; DA/DE
 ...I TH(W)>160 S X=TOUR+19 Q  ; OA/OE
 ...S X=9 ; UN/US
 ..D CHK^PRS8HRSV
 .;
 .;     Under 8/day, 40/week, and not coded as overtime or comptime
 .;     or overtime on holiday.
 .;
 .; Checks for non-compressed employees
 .I HT'>32,TH(W)'>160,"OoseE"'[VAL!(VAL="O"&(HOLWKD)) S X=0 D  Q:X
 ..;
 ..;    Not intermittent, normal hours and not unscheduled reg. 
 ..;    TIME gets parttime hours.
 ..;
 ..I TYP'["I",AV[VAL,VAL'=4 S X=32 D CHK^PRS8HRSV Q
 ..;
 ..;    All else fails - TIME gets unscheduled regular.
 ..;
 ..S X=9 D CHK^PRS8HRSV Q
 .;
 .;     Part time doctor w/ unscheduled reg. TIME gets unscheduled reg.
 .; 
 .I TYP["P",TYP["d",VAL=4 S X=9 D CHK^PRS8HRSV Q
 .;
 .;     Over 8/day
 .;
 .I HT>32 D G8^PRS8HRSV Q:X
 .;
 .;     For all time left except comptime set TIME to appropriate OT
 .;     unless comptime has been worked earlier in the week making
 .;     the total hours less than 40, then TIME gets unscheduled reg.
 .;     COMPTIME OVER 8/DAY WILL BE CREDITED HERE
 .;
 .S X=$S("Ee"'[VAL:TOUR+19,(TH(W)'>160)&(HT'>32):9,1:7)
 .I TYP["P",VAL[4,TH(W)'>160,HT'>32 S X=9
 .I TYP["P",VAL="O",TH(W)'>160,HT'>32 S X=9
 .D CHK^PRS8HRSV
 Q
