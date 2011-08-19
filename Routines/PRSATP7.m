PRSATP7 ;HISC/MGD-Timekeeper Post Absence ;04/18/06
 ;;4.0;PAID;**102,108**;Sep 21, 1995
 ;       
DAH(PPIP,DFN,WDAY,DAH,QUIT) ;
 ; Find Day After Holiday - Called from PRSASR
 ; Input:
 ;   PPIP - IEN of pay period to check
 ;    DFN - IEN of employee to check
 ;   WDAY - Day to start looping from
 ;    DAH - Null
 ;   QUIT - Null
 ;   
 ;  Output: 
 ;    DAH - PPIP^WDAY^Type of non-pay
 ;   QUIT - Will be set to 1 if the holiday encapsulation
 ;          rules are broken
 ;
 N DADRFM,EDATA,EEND,EIN,EINDX,ETOT,NODE0,NODE1,NODE2,NODE4
 N TINDX,TOUR1,TOUR2,REGHRS1,REGHRS2
 N NT,NE,NO,NC ; New ordered arrays
 S NODE0=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,0))
 I NODE0="" S QUIT=1 Q  ; Corrupted data 
 S NODE2=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,2))
 ;
 ; Skip Days off
 Q:$P(NODE0,U,2)=1
 ;
 ; Check for tours with no regular hours
 S TOUR1=+$P(NODE0,U,2),TOUR2=+$P(NODE0,U,13)
 S REGHRS1=$P($G(^PRST(457.1,TOUR1,0)),U,6)
 S REGHRS2=$S(TOUR2:$P($G(^PRST(457.1,TOUR2,0)),U,6),1:"")
 Q:$P(NODE0,U,2)'=2&($P(NODE0,U,2)'=3)&(REGHRS1+REGHRS2=0)
 ;
 ; If scheduled work day w/o any non-pay, set QUIT
 I $P(NODE0,U,2)>1,NODE2'["NP",NODE2'["WP" S QUIT=1 Q
 ;
 ; Checks for employees with DAILY tours
 I $P(NODE0,U,2)=2!($P(NODE0,U,2)=3) S DAH=PPIP_U_DFN_U_$P(NODE2,U,3) Q
 ;
 ; Load tours and convert to numeric equivalents
 ; This creates the ordered arrays
 ;
 S DADRFM=1
 S NODE1=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,1))
 D CNV96^PRSATP5(.NODE1,3,"NT",NODE0,.DADRFM)
 S NODE4=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,4))
 I NODE4'="" D CNV96^PRSATP5(.NODE4,3,"NT",NODE0,.DADRFM)
 D CNV96^PRSATP5(.NODE2,4,"NE",NODE0,.DADRFM)
 ;
 ; Identify beginning of tour
 S TINDX="",TINDX=$O(NT(TINDX))
 ;
 ; Loop through ordered exceptions to see if the first 15 minutes
 ; of the tour was non-pay
 S (EINDX,EDATA)=""
 F EIN=1:1:7 D  Q:QUIT!(EINDX="")!(DAH'="")
 . S EINDX=$O(NE(EINDX))
 . Q:EINDX=""
 . S EDATA=NE(EINDX),EEND=$P(EDATA,U,2),ETOT=$P(EDATA,U,3)
 . Q:EINDX'=TINDX  ; not first 15 minutes
 . I ETOT'="NP"&(ETOT'="WP") S QUIT=1 Q  ; first 15 wasn't non-pay
 . S DAH=PPIP_U_WDAY_U_ETOT
 I DAH="" S QUIT=1
 Q
