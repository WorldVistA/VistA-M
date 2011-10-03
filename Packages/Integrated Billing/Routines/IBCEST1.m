IBCEST1 ;ALB/ESG - IB 837 EDI Status Message Processing Cont ;18-JUL-2005
 ;;2.0;INTEGRATED BILLING;**320,397**;21-MAR-94;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
CHKSUM(IBARRAY) ; Incoming 277STAT status message checksum calculation
 ; This function calculates the checksum of the raw 277stat data from
 ; the data in array IBARRAY.  This is done to prevent duplicates.
 ; Input parameter IBARRAY is the array reference where the data exists
 ;    at @IBARRAY@(n,0) where n is a sequential #
 ; For file 364.2, IBARRAY = "^IBA(364.2,IBTDA,2)" where IBTDA = the ien
 ;    of the entry in file 364.2 being evaluated
 ;
 NEW Y,LN,DATA,IBREC,POS,STSFLG
 S Y=0,STSFLG=0
 S LN=0
 F  S LN=$O(@IBARRAY@(LN)) Q:'LN  D
 . S DATA=$$EXT($G(@IBARRAY@(LN,0))) Q:DATA=""
 . S IBREC=$P(DATA,U,1)
 . I IBREC="277STAT" S STSFLG=1 Q      ; set the STS flag
 . I IBREC<1 Q             ; rec# too low
 . I IBREC'<99 Q           ; rec# too high
 . F POS=1:1:$L(DATA) S Y=Y+($A(DATA,POS)*POS)
 . Q
 ;
 I 'STSFLG S Y=0   ; if this array is not a 277stat message
 Q Y
 ;
EXT(DATA) ; Extracts from the text in DATA if the text contains 
 ;  "##RAW DATA: "
 Q $S(DATA["##RAW DATA: ":$P(DATA,"##RAW DATA: ",2,99),1:DATA)
 ;
SCODE(Z0) ; status code for message
 N IBFD,IBI,IBRD S IBFD=0
 F IBI=1:1 S IBRD=$P($T(CODE+IBI),";;",2,999) Q:IBRD=""!IBFD  D
 . I IBRD[Z0 S IBFD=1
 Q IBFD
 ;
CODE ; *397
 ;;A3^AC^A7^A8^AA^2P^10^11
 ;;19^20^21^30^40^221^960^1AE^1AF^1AG^1AI^1AJ^1AK^1AL^1AS^1BS^1BV^1BY
 ;;2B^2D^2H^2M^2U^3A^3C^3E^3F^3G^3I^3K^3L^3N^3P^3S
 ;;4B^4C^4D^4E^4H^4I^4J^4P^4S^4T^4U^4X^4Y^7A^7D^7I^7U^7V
 ;;A0^A9^ACCEPT^ACCEPTED^AE^AP^APPROVE^C01^CI^CP^CTRL!99001^INQUIRY
 ;;OA7^OAH^OAI^OAK^OAT^OAV^OAY^OAZ^OB9^OBX^OCU^PG^PN5
 ;;TE^W!00000117^Z3^ZAI^ZAN
 ;
