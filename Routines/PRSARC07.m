PRSARC07 ;WOIFO/JAH - Tour Hours Procedure ;01/07/08
 ;;4.0;PAID;**112,116**;Sep 21, 1995;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
TOURHRS(THRARY,PPI,PRSIEN,TOURSTR) ; Return data for TOUR OF DUTY
 ;Input:
 ;  PPI (optional) IEN of #458 otherwise curr PPI assumed.
 ;    *If PPI and TOURSTR (or only PPI) defined then last pay period
 ;     spill over from 2nd sat. is added to day 1.
 ;    *If TOURSTR is defined but not PPI then tour hours
 ;     from 2nd saturday of tour in TOURSTR are placed on 1st Sunday.
 ;
 ;  PRSIEN (required) IEN-File (#450). 
 ;  TOURSTR (optional) if defined should contain 14 piece string
 ;          delimited by "^" pieces 1-14 contain pointers
 ;          to ToD file. Will be used instead of pp to determine
 ;          tour hrs.
 ; Output
 ;  THRARY (TOUR HRS ARRAY)-2 piece array subsc by day #.
 ;     W1 & W2 node w/ wkly tour hrs.
 ;    Piece one = Shift code:
 ;      -Null when no tour hrs fall on that day.
 ;      -Always 0 for Wage Grades
 ;      -1, 2, or 3 corresponds to earliest shift on day being reported.
 ;    Piece two = total hrs for tours that fall on each day.
 ;       Tours crossing midnight--hrs placed in node on day the occur
 ;    SPECIAL CASE: COMPRESSED TOURS: "CT" node is defined
 ;      Piece one set to shift (earliest for pp or 0 for wage)
 ;      Piece 2 = total pp hrs 
 ;
 ;    Error Codes = ARRAY VARIABLE contains a 1 for success or 0 for
 ;       failure.  If failed then error codes returned in Array 0 node
 ;         1 = pp undef
 ;         2 = emp undef
 ;         3 = no timecard for emp in pp
 ; Example
 ; >D TOURHRS^PRSARC04(.THRS,257,12711)
 ; >ZW THRS
 ; THRS=1
 ; THRS(1)=^0
 ; THRS(2)=1^3
 ; THRS(3)=1^6
 ; ...
 ; THRS(14)=^0
 N SHIFTCD,ISWAGE,ZNODE,PRSD,SAT,LASTPPI
 K THRARY
 I '$D(^PRSPC(+$G(PRSIEN),0)) S THRARY=0,THRARY(0)="2^undefined employee"
 I $G(TOURSTR)="" D
 .  I $G(PPI)'>0 S PPI=$P(^PRST(458,0),"^",3)
 .  I '$D(^PRST(458,+$G(PPI),0)) S THRARY=0,THRARY(0)="1^undefined pay period"
 .  S LASTPPI=PPI-1
 .  S ISWAGE=$$ISWAGE^PRSARC08(PRSIEN)
 . ;
 . ; Get ToD and Second ToD from last saturday of 
 . ; prior PP to check for spill over hrs onto day 1 of this PP.
 . S SAT=$G(^PRST(458,LASTPPI,"E",PRSIEN,"D",14,0))
 . S PRSD=0,T1=$P(SAT,U,2),T2=$P(SAT,U,13)
 . D PLACEHRS(.THRARY,PRSIEN,PRSD,T1,T2,LASTPPI)
 . F PRSD=1:1:14 D
 ..   S ZNODE=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0))
 ..   S T1=$P(ZNODE,U,2),T2=$P(ZNODE,U,13)
 ..   D PLACEHRS(.THRARY,PRSIEN,PRSD,T1,T2,PPI)
 ..   D PLACESHF(.THRARY,PRSD,T1,T2,ISWAGE)
 .;
 .; add compressed tour node if necessary
 .I $$ISCMPTR^PRSARC08(PPI,PRSIEN) S THRARY("CT")=$$EARLYSH^PRSARC08(.THRARY,ISWAGE)_"^"_$$TOTAL^PRSARC08(.THRARY)
 E  D
 .; use tourstring for tours
 .; add prior tour spillover from 2nd Sat to first Sun
 . I $G(PPI)>0 D
 ..   S SAT=$G(^PRST(458,PPI-1,"E",PRSIEN,"D",14,0))
 ..   S PRSD=0,T1=$P(SAT,U,2),T2=$P(SAT,U,13)
 ..   D PLACEHRS(.THRARY,PRSIEN,PRSD,T1,T2,PPI)
 . F PRSD=1:1:14 D
 ..   S T1=$P(TOURSTR,U,PRSD),T2=""
 ..   D PLACEHRS(.THRARY,PRSIEN,PRSD,T1,T2,PPI)
 . ; wrap second saturday to first sunday (IF PPI NOT PASSED)
 . I $G(PPI)="" S $P(THRARY(1),U,2)=$P(THRARY(1),U,2)+$P($G(THRARY(15)),U,2)
 ; Prior Sat THRARY(0) only needed temp to get any part of a two day 
 ; tour that spilled onto THRARY(1)-1st Sun. Next Sun THRARY(15) is 
 ; only an artifact.
 S THRARY("W1")=$$TOTAL^PRSARC08(.THRARY,1)
 S THRARY("W2")=$$TOTAL^PRSARC08(.THRARY,2)
 K THRARY(0),THRARY(15)
 Q
 ;
PLACEHRS(PRSTH,PRSIEN,PRSD,T1,T2,PPI) ; procedure puts hrs from tours on current 
 ; day and next.  called once for each day so a call for curr day 
 ; may have hrs from prior two day tour
 ;
 N CURHRS,CURSHFT,TODAYND,TOMORND,TODHRS,TOMHRS,TOURHRS
 S TODAYND=$G(PRSTH(PRSD))
 S TOMORND=$G(PRSTH(PRSD+1))
 S TODHRS=$P(TODAYND,U,2)
 S TOMHRS=$P(TOMORND,U,2)
 ;
 ; get tour 1 hrs-add to today, tomorrow
 I T1>0 D
 .  S TOURHRS=$$TRHRS(1,PRSD,PRSIEN,T1,PPI)
 .  S TODHRS=TODHRS+$P(TOURHRS,U)
 .  S TOMHRS=TOMHRS+$P(TOURHRS,U,2)
 ;
 ; get tour 2 hrs-add to today, tomorrow
 I T2>0 D
 .  S TOURHRS=$$TRHRS(2,PRSD,PRSIEN,T2,PPI)
 .  S TODHRS=TODHRS+$P(TOURHRS,U)
 .  S TOMHRS=TOMHRS+$P(TOURHRS,U,2)
 ;
 ; add tour hrs to array
 S $P(PRSTH(PRSD),U,2)=TODHRS
 ;
 ; add hrs to day node of array 
 ;   (2 day tour hrs past midnight on last Sat. go in node 15)
 ;
 S $P(PRSTH(PRSD+1),U,2)=TOMHRS
 Q
TRHRS(TNUM,PRSD,PRSIEN,TOURIEN,PPI) ; return string w/ todays hrs p1 ^ tomorrows hrs p2
 ;
 N TODHR,TOMHR,TOUR,TSEGS,TWODAYTR,REGHRS,DONE,CROSS,BEG,END,MEALTIME
 N BEG24,END24,SEGTIME,SEGTOD,SEGTOM,I,SPECIND
 ;
 S TODHR=0,TOMHR=0
 I $G(TOURIEN)'>0 Q TODHR_"^"_TOMHR
 S TOUR=$G(^PRST(457.1,TOURIEN,0))
 I TNUM=1 S TSEGS=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,1))
 I TNUM=2 S TSEGS=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,4))
 I TSEGS="" S TSEGS=$G(^PRST(457.1,TOURIEN,1))
 S TWODAYTR=$P(TOUR,U,5)="Y"
 S MEALTIME=$P(TOUR,U,3)
 I TNUM=1 S REGHRS=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,8)
 I TNUM=2 S REGHRS=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)),U,14)
 I REGHRS'>0 S REGHRS=$P(TOUR,U,6)
 I TWODAYTR D
 .  S (DONE,CROSS)=0
 .  F I=1:3:19 D  Q:DONE
 ..    S BEG=$P(TSEGS,U,I)
 ..    I BEG="" S DONE=1 Q
 ..    S END=$P(TSEGS,U,I+1)
 ..    S SPECIND=$P(TSEGS,U,I+2)
 ..;   only count regular hours
 ..    I SPECIND,"RG"'[$P($G(^PRST(457.2,+SPECIND,0)),"^",2) Q
 ..;  convert beg & end to 24 hr to check if one < other (Xes midnight)
 ..;  also crossed midnight if not first seg starts at midnight.
 ..;  CROSS is true so remaining segments recorded to tomorrow.
 ..    S BEG24=$$TWENTY4^PRSPESR2(BEG)
 ..    S END24=$$TWENTY4^PRSPESR2(END)
 ..    I 'CROSS&(((BEG24'<END24)&(BEG24'=2400))!((I>1)&(BEG24=2400))) D
 ...     S CROSS=1
 ...     S SEGTOD=$S(BEG24=2400:0,1:$$AMT^PRSPSAPU(BEG,"MID",0))
 ...     S SEGTOM=$$AMT^PRSPSAPU("MID",END,0)
 ...     S TODHR=TODHR+SEGTOD
 ...     S TOMHR=TOMHR+SEGTOM
 ..    E  D
 ...     S SEGTIME=$$AMT^PRSPSAPU(BEG,END,0)
 ...     I CROSS D
 ....      S TOMHR=TOMHR+SEGTIME
 ...     E  D
 ....      S TODHR=TODHR+SEGTIME
 . ;Pull meal off hrs for today, tomorrow or both.
 . N HOURS S HOURS=$$PLACEML^PRSARC08(TODHR,TOMHR,MEALTIME)
 . S TODHR=$P(HOURS,U)
 . S TOMHR=$P(HOURS,U,2)
 E  D
 .  S TODHR=REGHRS
 Q TODHR_"^"_TOMHR
 ;
PLACESHF(PRSTH,PRSD,T1,T2,WAGER) ;Place earliest shift from
 ; tour 1 and tour 2 in SDA Tour array (PRSTH)
 ;INPUT:
 ;  PRSTH - array to store SDA tour info p1=shift, p2=tour hrs.
 ;  PRSD - day number in pp 1-14
 ;  T1, T2 - tour 1 and 2 (ien in ToD file)
 ;  WAGER - 0 or 1 for whether this is a wage grade employee.
 ;OUTPUT:
 ;  PRSTH by reference.  Update "^" piece 1 with shift indicator
 ;
 N SHIFT,T1SHFTS,T2SHFTS,SHIFTINI,EARLIEST,SHIFT2
 ;
 ; Wage grade always have a 0 for shift
 I WAGER D
 .  S $P(PRSTH(PRSD),U)=0
 E  D 
 .  S T1SHFTS=$$TRSHFTS^PRSARC08(T1) ; get tour 1 shift for today and tomorrow
 .  S T2SHFTS=$$TRSHFTS^PRSARC08(T2) ; and tour 2
 .;  Get any shift placed by a two day tour from yesterday.
 .;  Then find earliest shift from t1, t2 and two day carryover
 .  S SHIFTINI=$P($G(PRSTH(PRSD)),U) I SHIFTINI="" S SHIFTINI=4
 .  S SHIFT=$P(T1SHFTS,U) I SHIFT="" S SHIFT=4
 .  S SHIFT2=$P(T2SHFTS,U) I SHIFT2="" S SHIFT2=4
 .  S EARLIEST=SHIFTINI
 .  I SHIFT<SHIFTINI S EARLIEST=SHIFT
 .  I SHIFT2<EARLIEST S EARLIEST=SHIFT2
 .  I EARLIEST=4 S EARLIEST=""
 .  S $P(PRSTH(PRSD),U)=EARLIEST
 . ;
 . ; Now do anything for tomorrow
 .  S SHIFTINI=$P($G(PRSTH(PRSD+1)),U,1) I SHIFTINI="" S SHIFTINI=4
 .  S SHIFT=$P(T1SHFTS,U,2) I SHIFT="" S SHIFT=4
 .  S SHIFT2=$P(T2SHFTS,U,2) I SHIFT2="" S SHIFT2=4
 .  S EARLIEST=SHIFTINI
 .  I SHIFT<SHIFTINI S EARLIEST=SHIFT
 .  I SHIFT2<EARLIEST S EARLIEST=SHIFT2
 .  I EARLIEST=4 S EARLIEST=""
 .  S $P(PRSTH(PRSD+1),U)=EARLIEST
 Q
 ;
