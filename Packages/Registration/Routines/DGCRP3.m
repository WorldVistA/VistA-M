DGCRP3 ;ALB/RJS - BRIDGE ROUTINE TO IBCF13 FROM A/R TO IB ; 20-OCT-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ;Entry point for Ar to print 2nd and 3rd notice bills
 ;Device handling to be done by calling routine
 ;Requires Input: - PRCASV("ARREC") = internal number of bill
 ;                - PRCASV("NOTICE") = number of notice
 ;Outputs:        - DGCRAR("ERR") = error message
 ;                - DGCRAR("OKAY") = 1 normal finish, 0 not finished
 ;
REPRNT ;
 D REPRNT^IBCF13
 S DGCRAR("OKAY")=IBAR("OKAY")
 I $D(IBAR("ERR")) S DGCRAR("ERR")=IBAR("ERR")
 K IBAR
 Q
