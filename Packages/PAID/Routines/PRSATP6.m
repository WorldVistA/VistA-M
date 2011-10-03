PRSATP6 ;HISC/MGD-Timekeeper Post Absence ;04/18/06
 ;;4.0;PAID;**102,108**;Sep 21, 1995
 ;       
DBH(PPIP,DFN,WDAY,DBH,QUIT) ;
 ; Find Day Before Holiday
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
 N TEND,TINDX,TOUR1,TOUR2,REGHRS1,REGHRS2
 N PT,PE,PO,PC ; New ordered arrays
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
 ; If the day has a tour that defines work and there are no exceptions
 ; encapsulation is broken
 I $P(NODE0,U,2)>1,NODE2'["NP",NODE2'["WP" S QUIT=1 Q
 ;
 ; Checks for employees with DAILY tours
 I $P(NODE0,U,2)=2!($P(NODE0,U,2)=3) S DBH=PPIP_U_DFN_U_$P(NODE2,U,3) Q
 ;
 ; Load tours and convert to numeric equivalents
 ; This creates the ordered arrays
 S DADRFM=1
 S NODE1=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,1))
 D CNV96^PRSATP5(.NODE1,3,"PT",NODE0,.DADRFM)
 S NODE4=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,4))
 I NODE4'="" D CNV96^PRSATP5(.NODE4,3,"PT",NODE0,.DADRFM)
 D CNV96^PRSATP5(.NODE2,4,"PE",NODE0,.DADRFM)
 ;
 ; Identify end of tour
 S TINDX="",TINDX=$O(PT(TINDX),-1)
 S TEND=$P(PT(TINDX),U,2)
 ;
 ; Loop backwards through ordered exceptions to see if last 15
 ; minutes of tour was non-pay
 S (EINDX,EDATA)=""
 F EIN=1:1:7 D  Q:QUIT!(EINDX="")!(DBH'="")
 . S EINDX=$O(PE(EINDX),-1)
 . Q:EINDX=""
 . S EDATA=PE(EINDX),EEND=$P(EDATA,U,2),ETOT=$P(EDATA,U,3)
 . Q:EEND'=TEND  ; not last 15 minutes
 . I ETOT'="NP"&(ETOT'="WP") S QUIT=1 Q  ; last 15 wasn't non-pay
 . S DBH=PPIP_U_WDAY_U_ETOT
 I DBH="" S QUIT=1
 Q
