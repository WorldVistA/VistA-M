FBSHUTL ;WCIOFO/SAB-STATE HOME UTILITIES ;2/8/1999
 ;;3.5;FEE BASIS;**13**;JAN 30, 1995
 Q
DOC(FBFR,FBTO,FBDTP1,FBDTP2) ; Days of Care Extrinsic Function
 ; Return length (days) of authorization. The authorization TO DATE
 ; is not counted unless it is equal to the authorization FROM DATE.
 ; If optional period is specified then only the authorization days
 ; within the period are counted.
 ; input
 ;   FBFR    - authorization FROM DATE (FileMan format)
 ;   FBTO    - authorization TO DATE (FileMan format)
 ;   FBDTP1  - (optional) start date of period (FileMan format)
 ;   FBDTP2  - (optional) end date of period (FileMan format)
 ; returns length of authorization (days) within optional period
 ;
 N FBDTC1,FBDTC2,FBQUIT
 ;
 ; validate input parameters
 I FBFR'?7N!(FBTO'?7N)!(FBFR>FBTO) S FBQUIT=1
 I $G(FBDTP1)'?7N!($G(FBDTP2)'?7N)!(FBDTP1>FBDTP2) S (FBDTP1,FBDTP2)=""
 ;
 ; initialize calculation start and end dates as authorization dates
 S FBDTC1=FBFR,FBDTC2=FBTO
 ;
 ; if period specified then check if auth in period and adjust calc dates
 I '$G(FBQUIT),FBDTP1]"",FBDTP2]"" D
 . I FBFR>FBDTP2 S FBQUIT=1 Q  ; not within specified period
 . I FBTO<FBDTP1 S FBQUIT=1 Q  ; not within specified period
 . ; if auth FROM DATE before period then set calculation start date
 . ;  as 1st day in period
 . I FBFR<FBDTP1 S FBDTC1=FBDTP1
 . ; if auth TO DATE after period then set calculation end date as
 . ; next day after period in order to count through last day in period
 . I FBTO>FBDTP2 S FBDTC2=$$FMADD^XLFDT(FBDTP2,1)
 ;
 ; return days of care (within optional specified period)
 ;   count as 1 day when auth FROM DATE = TO DATE (special case)
 Q $S($G(FBQUIT):0,FBFR=FBTO:1,1:$$FMDIFF^XLFDT(FBDTC2,FBDTC1))
 ;
 ;FBSHUTL
