FBUTLMVI ;OAK/ELZ - MPIF API CALLS ;6/21/2016
 ;;3.5;FEE BASIS;**173**;JAN 30, 1995;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
ACTIVITY(DFN,FBDATE,FBACT) ; - API for MPIF to search for FB related activity
 ; after the given date relating to the DFN.  FBACT should be passed by
 ; reference and will return an array of activity.  The ACTIVITY
 ; function will return a count of the number of occurrences of activity
 ; that occurred after the FBDATE for the patient.
 ;
 I '$G(DFN)!('$G(FBDATE)) Q 0
 ;
 K FBACT
 N FBC,FBX,FBY,FBZ
 S FBC=0
 ;
 ; Fee Basis Payment (#162) file
 S FBX=0 F  S FBX=$O(^FBAAC(DFN,"AB",FBX)) Q:'FBX!((9999999.9999-FBX)<FBDATE)  D
 . S FBY=0 F  S FBY=$O(^FBAAC(DFN,"AB",FBX,FBY)) Q:'FBY  D
 .. Q:(9999999.9999-FBX\1)'>FBDATE
 .. S FBC=FBC+1
 .. S FBACT(FBC)=(9999999.9999-FBX\1)_"^FEE BASIS PAYMENT/INITIAL TREATMENT"
 S FBX=FBDATE F  S FBX=$O(^FBAAC(DFN,3,"AB",FBX)) Q:'FBX!(FBX<FBDATE)  D
 . S FBY=0 F  S FBY=$O(^FBAAC(DFN,3,"AB",FBX,FBY)) Q:'FBY  D
 .. S FBC=FBC+1
 .. S FBACT(FBC)=FBX_"^FEE BASIS PAYMENT/TRAVEL PAYMENT"
 ;
 ; Fee Basis Unauthorized Claims (#162.7) file
 S FBX=0 F  S FBX=$O(^FB583("D",DFN,FBX)) Q:'FBX  D
 . S FBY=$G(^FB583(FBX,0))
 . ; treatment from date
 . I $P(FBY,"^",5)>FBDATE D  Q
 .. S FBC=FBC+1
 .. S FBACT(FBC)=$P(FBY,"^",5)_"^FEE BASIS UNAUTHORIZED CLAIMS/FROM DATE"
 . ; treatment to date
 . I $P(FBY,"^",6)>FBDATE D
 .. S FBC=FBC+1
 .. S FBACT(FBC)=$P(FBY,"^",6)_"^FEE BASIS UNAUTHORIZED CLAIMS/TO DATE"
 ;
 ; Fee Basis Pharmacy Invoice (#162.1) file
 S FBX=0 F  S FBX=$O(^FBAA(162.1,"AD",DFN,FBX)) Q:'FBX!((9999999-FBX)<FBDATE)  D
 . S FBY=0 F  S FBY=$O(^FBAA(162.1,"AD",DFN,FBX,FBY)) Q:'FBY  D
 .. S FBZ=0 F  S FBZ=$O(^FBAA(162.1,"AD",DFN,FBX,FBY,FBZ)) Q:'FBZ  D
 ... S FBC=FBC+1
 ... S FBACT(FBC)=9999999-FBX_"^FEE BASIS PHARMACY INVOICE/RX FILL DATE"
 ;
 Q FBC
 ;
