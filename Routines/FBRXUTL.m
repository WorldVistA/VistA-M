FBRXUTL ;WIOFO/SAB-FEE BASIS PHARMACY UTILITY ;4/8/2004
 ;;3.5;FEE BASIS;**78**;JAN 30, 1995
 Q
 ;
RXSUM(FBDT,FBSN) ; fee prescription costs extrinsic function
 ; Integration Agreement #4395
 ; This API returns the count and cost of prescriptions paid
 ; through the fee software for a specified date.
 ;
 ; Usage: S X=$$FEERX(FBDT,FBSN)
 ; input
 ;   FBDT - date, required, VA FileMan internal format
 ;          Used to select prescriptions based on Date Certified for
 ;          Payment.
 ;   FBSN - station number, required, 3 digit value
 ;          Used to select prescriptions based on the VAMC that approved
 ;          payment when querying the national Fee Replacement system.
 ;          Prescriptions will be included when the approving station
 ;          number Starts With this 3 digit value so satellite
 ;          station 688A1 would be included when FBSN = 688.
 ;          This parameter will not be evaluated until the API is
 ;          modified to obtain data from the Fee Replacement system.
 ; Return value is a string
 ;   string value = count ^ total amount paid
 ;   where
 ;     count = the number of prescriptions for the date and station
 ;     total amount paid = sum of the Amount Paid for the prescriptions
 ;       in dollars and cents
 ;   OR
 ;   X = -1 ^ exception number ^ exception text
 ;
 ;   Examples S var=$$FEERX^FBZSAB9(DT,688) could return values like
 ;     8^10.54
 ;     0^0.00
 ;     -1^110^Database Unavailable
 ;
 ;   List of Exceptions
 ;     101^Valid date not specified.
 ;     102^Valid station number not specified.
 ;     110^Database Unavailable.
 ;   The database unavailable exception will not occur until this API
 ;   is modified to obtain data from the fee replacement system.
 ;   However, calling applications should code to handle this exception
 ;   now so appropriate action will be taken once the data is moved from
 ;   the local VistA system to the remote fee replacement system.
 ;
 N FBDFN,FBC,FBDA,FBDA1,FBRET,FBTAMT
 S FBDT=$G(FBDT)
 S FBSN=$G(FBSN)
 S FBRET=""
 ;
 ; check for required input
 I FBRET'<0 D
 . I FBDT'?7N S FBRET="-1^101^Valid date not specified." Q
 . I $$FMTHL7^XLFDT(FBDT)<0 S FBRET="-1^101^Valid date not specified." Q
 . I FBSN'?3N S FBRET="-1^102^Valid station number not specified." Q
 . I $$IEN^XUAF4(FBSN)'>0 S FBRET="-1^102^Valid station number not specified." Q
 ;
 ; get count and total amount
 I FBRET'<0 D
 . S FBC=0 ; initialize count
 . S FBTAMT=0 ; initialize total amount paid
 . ;
 . ; find prescriptions using File #162.1 "AA" cross-reference
 . ; loop thru patient within date certified
 . S FBDFN=""
 . F  S FBDFN=$O(^FBAA(162.1,"AA",FBDT,FBDFN)) Q:FBDFN=""  D
 . . ; loop thru invoice ien
 . . S FBDA1=0
 . . F  S FBDA1=$O(^FBAA(162.1,"AA",FBDT,FBDFN,FBDA1)) Q:'FBDA1  D
 . . . ; loop thru prescription ien
 . . . S FBDA=0
 . . . F  S FBDA=$O(^FBAA(162.1,"AA",FBDT,FBDFN,FBDA1,FBDA)) Q:'FBDA  D
 . . . . ; add prescription to count and total amount paid
 . . . . S FBC=FBC+1
 . . . . S FBTAMT=FBTAMT+$P($G(^FBAA(162.1,FBDA1,"RX",FBDA,0)),U,16)
 . ; 
 . S FBRET=FBC_U_$FN(FBTAMT,"",2)
 ;
 Q FBRET
 ;
 ;FBRXUTL
