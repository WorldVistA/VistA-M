PRSATP5 ;HISC/MGD-Timekeeper Post Absence ;04/18/06
 ;;4.0;PAID;**102,108**;Sep 21, 1995
 ;
CNV96(TDATA,NSEG,ARRAY,ZERO,DADRFM) ;
 ; Convert the external representation of the start/stop time to
 ; its 1 - 192 piece equivalent
 ; 
 ; Input:
 ;       TDATA - Time segments to operate on passed by reference
 ;        NSEG - Number of Segments per start/stop time entry
 ;                       3 for tours, 4 for exceptions
 ;       ARRAY - Name of ordered array to create
 ;       1st char - P = Prior (to holiday)
 ;                  H = Holiday
 ;                  N = Next day after holiday
 ;       2nd char - T = Tour segments
 ;                  E = Exception segments, does not include segments
 ;                      that define periods of On-Call
 ;                  O = Segments that define periods of On-Call
 ;                      Could have come from Tour(s) or Exceptions
 ;                  C = Segments of work performed during periods
 ;                      of On-Call
 ;       Format for all arrays
 ;         ARRAY(START)=START^STOP^TOT
 ;         Note: Exceptions arrays (PE, HE, NE) will contain the
 ;               Remarks Code as the 4th piece of DATA
 ;               Exceptions(START)=START^STOP^TOT^RC
 ;               
 ;        ZERO - 0 node of day being processed 
 ;        
 ;        DADRFM - variable needed for tracking of tours that
 ;                 cross midnight.  Passed by reference and may
 ;                 be changed.
 ;
 Q:TDATA=""
 N D,FLAG,K,LAST,K1,N,N1,N14,NDAY,QT,V,X,Y,Y1,Z
 S N=$S(NSEG=4:2,1:1)
 D CNV,COA
 Q
 ;
 ; The CNV code was copied from PRS8SU and modified to fit
 ; out needs
 ; 
 ; loop thru data nodes for day
CNV S D(0)=ZERO,Z=TDATA,N1=NSEG,(N14,NDAY,LAST,QT)=0
 ;
 ; process tour and work nodes by looping thru postings in the node
 F K=1:N1 S V=$P(Z,"^",K,K+1) Q:QT  D
 .S X=$P(Z,U,K,999)
 .S:X?1"^"."^"!(X="")!(N14=1) QT=1
 .I QT!($P(Z,U,K)="") Q
 .;
 .S:K=1 (NDAY,LAST)=0
 .;
 .; process start time and stop time for posting in node
 .F K1=1,2 S X=$P(V,"^",K1),(Y,Y1)=K1-1 I X'="" D
 ..;
 ..; when a tour exception (N=2) start time (K1=1) is being processed
 ..; determine if LAST should be reset (FLAG). If LAST is reset then
 ..; the start time of the tour exception will initially be placed
 ..; in the current day (X'>96) instead of the following day (X>96)
 ..S FLAG=1
 ..I N=2&(K1=1)&("^HW^"[("^"_$P(Z,"^",K+2)_"^")) D
 ...S FLAG=$S(NDAY=1!(LAST>96)&("^HW^"[("^"_$P(Z,"^",K+2)_"^"))&((X["A")!(X["MID")):0,1:1),NDAY=0
 ..S:$P(D(0),"^",14)'=""&(X="MID")&(LAST=96)&(N=2)&(K1=1) FLAG=0
 ..S:N=2&(K1=1)&(FLAG=1) (NDAY,LAST)=0
 ..;
 ..S Y=K1-1 D 15^PRS8SU ; determine number (1-192) corresponding to time
 ..;
 ..; if some tour exceptions (such as leave) are not within a sched.
 ..; tour then they must be for the following day (i.e. 2-day tour)
 ..I N=2,"^RG^OT^CT^ON^SB^HW^"'[("^"_$P(Z,"^",K+2)_"^") D
 ...S Y=+$O(DADRFM("S",(-X-.01))),Y1=+$O(DADRFM("F",(X-.01)))
 ...I $G(DADRFM("S",Y))'=$G(DADRFM("F",Y1)) S X=X+96
 ...;
 ..S $P(Z,"^",K+(K1-1))=X ; replace time by number
 ..;
 ..; save scheduled tour start and stop times for later use when
 ..; placing some tour exceptions on correct day for 2-day tours
 ..I K1=1,N=1!(N=4) S DADRFM("S",-X)=DADRFM
 ..I K1=2,N=1!(N=4) S DADRFM("F",X)=DADRFM,DADRFM=DADRFM+1
 ..;
 ..; End of code copied from PRS8SU
 ..S $P(TDATA,U,K+(K1-1))=X
 Q
 ;
 ; Create ordered arrays
COA N ARY,RC,SEG,STI,STOP,STRT,TOT
 S RC=""
 F SEG=0:1:6 D
 .S STRT=$P(TDATA,U,(SEG*NSEG)+1)
 .Q:STRT=""
 .S STOP=$P(TDATA,U,(SEG*NSEG)+2),TOT=$P(TDATA,U,(SEG*NSEG)+3)
 .; For Node1 & Node4 TOT will be numeric so we will need to get
 .; its external representation (2 character string)
 .; For Node2 TOT will be a 2 character string
 .I NSEG=4 S RC=$P(TDATA,U,(SEG*NSEG)+4)
 .S STI="" ; Special Tour Indicator
 .I NSEG=3,TOT S STI=$P($G(^PRST(457.2,TOT,0)),U,2)
 .;
 .; Don't set exceptions defining periods of On-Call into Exception array
 .I $E(ARRAY,2)="E",TOT'="ON" D
 ..S @ARRAY@(STRT)=STRT_U_STOP_U_TOT_U_RC
 .;
 .; Set only Reg segments of tour where the Special Tour Indicator
 .; is "" or RG into the Tour array
 .I $E(ARRAY,2)="T" D
 ..I TOT="" S @ARRAY@(STRT)=STRT_U_STOP_U_TOT
 ..I STI="RG" S @ARRAY@(STRT)=STRT_U_STOP_U_TOT
 .;
 .; Only set segments that define On-Call into On-Call array
 .I TOT="ON"!(STI="ON") D
 ..S TOT=$S(TOT'="":TOT,1:STI)
 ..S ARY=$E(ARRAY,1)_"O" S @ARY@(STRT)=STRT_U_STOP_U_TOT
 .;
 .; Only segments of work get in the Call-Back
 .I "^RG^OT^CT^"[("^"_TOT_"^") D
 .. S ARY=$E(ARRAY,1)_"C" S @ARY@(STRT)=STRT_U_STOP_U_TOT
 Q
 ;
GETPPP(PPIP,DFN,WDAY,BACK,QUIT) ;
 ; Set appropriate variables for prior pay period
 ;   Input:
 ;     PPIP - Internal format of current pay period
 ;      DFN - IEN of employee
 ;     WDAY - Day currently being examined
 ;     QUIT - Null
 ;     
 ;  Output:
 ;     PPIP - IEN of Prior Pay Period
 ;     WDAY - Set to last day of prior pay period
 ;     BACK - Counter for number of pay period looked back
 ;     QUIT - Will be set to 1 if there is no timecard for
 ;            the employee in the prior pay period
 ;
 S PPIP=$O(^PRST(458,PPIP),-1) ; Get Prior PP
 I 'PPIP S QUIT=1 Q  ; No prior pay period on file
 ; Check for employee timecard in this PP
 I '$D(^PRST(458,PPIP,"E",DFN,0)) S QUIT=1 Q
 S WDAY=14,BACK=BACK+1
 Q
 ;
GETNPP(PPIN,DFN,WDAY,NEXT,QUIT) ;
 ; Set appropriate variables for next pay period
 ;   Input:
 ;     PPIN - Internal format of current pay period
 ;      DFN - IEN of employee
 ;     WDAY - Day currently being examined
 ;     QUIT - Null
 ;
 ;  Output:
 ;     PPIN - IEN of Next Pay Period
 ;     WDAY - Set to first day of next pay period
 ;     BACK - Counter for number of pay period looked forward
 ;     QUIT - Will be set to 1 if there is no timecard for
 ;            the employee in the next pay period
 ;
 S PPIN=$O(^PRST(458,PPIN)) ; Get next PP
 I 'PPIN S QUIT=1 Q  ; Next pay period not on file
 ; Check for employee timecard in this PP
 I '$D(^PRST(458,PPIN,"E",DFN,0)) S QUIT=1 Q
 S WDAY=1,NEXT=NEXT+1
 Q
