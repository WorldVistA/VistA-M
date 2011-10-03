PRSATP8 ;HISC/MGD-Timekeeper Post Absence ;01/27/06
 ;;4.0;PAID;**102**;Sep 21, 1995
 ;
FNDHOL(PPIP,DFN,WDAY,HOL,QUIT) ;
 ; Procedure to determine if there was a holiday in a PP
 ; Will also check to see if there was any On-Call posted
 ; as an exception that abuts the scheduled tour and if
 ; the first/last 15 minutes of the On-call was worked
 ; 
 ; Input:
 ;    PPIP - IEN of Pay Period to be checked
 ;     DFN - IEN of employee to be checked
 ;    WDAY - Day to start looping backwards from
 ;     HOL - null
 ;    QUIT - null 
 ;    
 ; Output:
 ;    HOL - IF not found = ""
 ;          IF found = PPIP^WDAY^SOH
 ;            PPIP - IEN of pay period containing the holiday
 ;            WDAY - the day number on which the holiday occurs
 ;             SOH - The status of the timecard containing the holiday
 ;   QUIT - Will be set to 1 if the holiday encapsulation
 ;          rules are broken
 ;          
 N DADRFM,HTAFTER,HTPRIOR,HTSTRT,HTEND,NODE0,NODE1,NODE2,NODE4
 N REGHRS1,REGHRS2,SOH,TOUR1,TOUR2,TPPIP,TWDAY
 N HT,HE,HO,HC,NT,NE,NO,NC,PT,PE,PO,PC ; New ordered arrays
 S NODE0=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,0))
 S SOH=$P($G(^PRST(458,PPIP,"E",DFN,0)),U,2)
 S TPPIP=PPIP,TWDAY=WDAY
 I NODE0="" S QUIT=1 Q  ; Corrupted data 
 Q:$P(NODE0,U,2)=1  ; Scheduled day off
 ;
 ; Check for tours with no regular hours
 S TOUR1=+$P(NODE0,U,2),TOUR2=+$P(NODE0,U,13)
 S REGHRS1=$P($G(^PRST(457.1,TOUR1,0)),U,6)
 S REGHRS2=$S(TOUR2:$P($G(^PRST(457.1,TOUR2,0)),U,6),1:"")
 Q:$P(NODE0,U,2)'=2&($P(NODE0,U,2)'=3)&(REGHRS1+REGHRS2=0)
 ;
 ; Quit if day has a tour with regular hours and it is not
 ; a holiday (#10.2)OBSERVED HOLIDAY
 I REGHRS1,$P(NODE0,U,12)="" S QUIT=1 Q
 ;
 ; If the holiday has two tours, Timekeepers will post
 I $P(NODE0,U,13)'="" S QUIT=1 Q
 ;
 ; Load Holiday exceptions and check for HW & HX
 S NODE2=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,2))
 I NODE2["HW" S QUIT=1 Q  ; worked was performed on a holiday
 I NODE2'["HX" S QUIT=1 Q  ; no HX to convert
 ;
 ; Checks for employees with DAILY tours
 I $P(NODE0,U,2)=2!($P(NODE0,U,2)=3) S HOL=PPIP_U_WDAY_U_SOH Q
 ;
 ; Load nodes 1, 4
 S NODE1=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,1))
 S NODE4=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,4))
 ;
 ; Convert Start/Stop times and create all
 ; ordered arrays
 S DADRFM=1
 D CNV96^PRSATP5(.NODE1,3,"HT",NODE0,.DADRFM)
 I NODE4'="" D CNV96^PRSATP5(.NODE4,3,"HT",NODE0,.DADRFM)
 D CNV96^PRSATP5(.NODE2,4,"HE",NODE0,.DADRFM)
 ;
 ; Get start/end times of holiday tour
 S HTSTRT="",HTSTRT=$O(HT(HTSTRT))
 S HTEND="",HTEND=$O(HT(HTEND),-1)
 I HTEND S HTEND=$P(HT(HTEND),U,2)
 ;
 ; Load prior days info
 S WDAY=WDAY-1
 I WDAY=0 D  Q:QUIT
 . N BACK S BACK=0
 . D GETPPP^PRSATP5(.PPIP,DFN,.WDAY,.BACK,.QUIT)
 S NODE0=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,0))
 S NODE1=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,1))
 S DADRFM=1
 D CNV96^PRSATP5(.NODE1,3,"PT",NODE0,.DADRFM)
 S NODE4=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,4))
 I NODE4'="" D CNV96^PRSATP5(.NODE4,3,"PT",NODE0,.DADRFM)
 S NODE2=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,2))
 D CNV96^PRSATP5(.NODE2,4,"PE",NODE0,.DADRFM)
 ;
 ; Load next day's info
 S PPIP=TPPIP,WDAY=TWDAY+1
 I WDAY=15 D  Q:QUIT
 . N NEXT S NEXT=0
 . D GETNPP^PRSATP5(.PPIP,DFN,.WDAY,.NEXT,.QUIT)
 S NODE0=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,0))
 S NODE1=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,1))
 S DADRFM=1
 D CNV96^PRSATP5(.NODE1,3,"NT",NODE0,.DADRFM)
 S NODE4=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,4))
 I NODE4'="" D CNV96^PRSATP5(.NODE4,3,"NT",NODE0,.DADRFM)
 S NODE2=$G(^PRST(458,PPIP,"E",DFN,"D",WDAY,2))
 D CNV96^PRSATP5(.NODE2,4,"NE",NODE0,.DADRFM)
 ;
 ; init flags as 0 (false)
 S HTPRIOR("OC")=0 ; time immediately prior to holiday tour was on-call
 S HTPRIOR("WK")=0 ; time immediately prior to holiday tour was worked
 S HTAFTER("OC")=0 ; time immediately after holiday tour was on-call
 S HTAFTER("WK")=0 ; time immediately after holiday tour was worked
 ;
 ; check if on-call segments posted on prior day abut the holiday tour
 I $$INCTM(HTSTRT-1+96,.PO) S HTPRIOR("OC")=1
 I $$INCTM(HTEND+1+96,.PO) S HTAFTER("OC")=1
 ;
 ; check if on-call segments posted on holiday abut the holiday tour
 I $$INCTM(HTSTRT-1,.HO) S HTPRIOR("OC")=1
 I $$INCTM(HTEND+1,.HO) S HTAFTER("OC")=1
 ;
 ; check if on-call segments posted on next day abut the holiday tour
 I $$INCTM(HTEND+1-96,.NO) S HTAFTER("OC")=1
 ;
 ; check if extra work segments posted on prior day abut the holiday tour
 I $$INCTM(HTSTRT-1+96,.PC) S HTPRIOR("WK")=1
 ;
 ; check if extra work segments posted on holiday abut the holiday tour
 I $$INCTM(HTSTRT-1,.HC) S HTPRIOR("WK")=1
 I $$INCTM(HTEND+1,.HC) S HTAFTER("WK")=1
 ;
 ; check if extra work segments posted on next day abut the holiday tour
 I $$INCTM(HTEND+1-96,.NC) S HTAFTER("WK")=1
 ;
 ; if call-back abuts the holiday tour then it is not considered encap.
 I HTPRIOR("OC"),HTPRIOR("WK") S QUIT=1 Q  ; call-back abuts beginning
 I HTAFTER("OC"),HTAFTER("WK") S QUIT=1 Q  ; call-back abuts end
 ;
 ; checks done so holiday excused is considered encapsulated by non-pay
 S HOL=TPPIP_U_TWDAY_U_SOH
 Q
 ;
INCTM(PRST,PRSARR) ; Includes Time Extrinsic Function
 ; determines if a time is included within any time segments in array
 ; input
 ;   PRST - number that represents a time segment (1-192)
 ;   PRSARR - array, passed by reference with following format
 ;       PRSARR(start)=start^stop^type of time
 ; returns 1 if PRST included within a time segment or 0 if not
 ;
 N RET,START,STOP
 S RET=0 ; initialize return value
 ;
 ; loop thru array
 I PRST>0 S START="" F  S START=$O(PRSARR(START)) Q:START=""  D  Q:RET
 . S STOP=$P(PRSARR(START),U,2)
 . I PRST'<START,PRST'>STOP S RET=1 ; check if time included in segment
 ;
 Q RET
