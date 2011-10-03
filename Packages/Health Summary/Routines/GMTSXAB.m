GMTSXAB ; SLC/KER - List Parameters/Build List            ; 01/06/2003
 ;;2.7;Health Summary;**47,49,58,66**;Oct 20, 1995
 Q
 ;                                 
 ; External References
 ;                                 
 ;   None
 ;                                    
 ; This routine expects:
 ;                                 
 ;   GMTSCPL    Compile Method   1 = Append  0 = Overwrite
 ;   GMTSPRE    Precedence       i.e., USR;SYS;NAT
 ;   ^TMP($J,"GMTSTYP",   List             Input Array
 ;   ROOT(     List             Output Array
 ;                            
BUILD ; Build list of User/System Parameters and National Types
 N GMTSC,GMTSOK,GMTSI,GMTSID,GMTSE,GMTSEI,GMTSV,GMTSVI,GMTSVN,GMTSAT,GMTSOVR
 S GMTSOVR=$S(+($G(GMTSCPL))'>0:1,1:0),GMTSOK=0
 S GMTSC=+($O(@ROOT@(" "),-1))
 F GMTSEI=1:1 Q:$P($G(GMTSPRE),";",GMTSEI)=""  S GMTSE=$P($G(GMTSPRE),";",GMTSEI) D
 . Q:'$L(GMTSE)  I GMTSE="NAT" D NAT Q
 . Q:+GMTSOK>0  S GMTSID="" D ADH,ENT
 Q
NAT ;   Add National Health Summary Types to the List
 Q:+($G(GMTSCPL))>1  N GMTSC,GMTSI,GMTSID,GMTSVI,GMTSVN,GMTSV
 S GMTSI=0,GMTSID=""
 S GMTSC=+($O(@ROOT@(" "),-1))
 F  S GMTSID=$O(^TMP($J,"GMTSTYP","NAT","B",GMTSID)) Q:GMTSID=""  D
 . S GMTSI=0 F  S GMTSI=$O(^TMP($J,"GMTSTYP","NAT","B",GMTSID,GMTSI)) Q:+GMTSI=0  D
 . . S GMTSV=$$VAL($G(^TMP($J,"GMTSTYP","NAT",GMTSI)))
 . . Q:'$L(GMTSV)  Q:+GMTSV=0  Q:'$L($$TRIM^GMTSXA($P(GMTSV,"^",2)," "))
 . . Q:$D(@ROOT@("B",GMTSV))
 . . S GMTSC=GMTSC+1
 . . S @ROOT@(GMTSC)=GMTSV,@ROOT@("B",GMTSV,GMTSC)=""
 . . S @ROOT@("C",GMTSC)="NAT"
 K ^TMP($J,"GMTSTYP","NAT")
 Q
ADH ;   Add Adhoc Health Summary Types to the List
 N GMTSC S GMTSC=+($O(@ROOT@(" "),-1)) F GMTSAT="ADH","RAD" S GMTSI=0 D
 . F  S GMTSI=$O(^TMP($J,"GMTSTYP",GMTSE,GMTSAT,GMTSI)) Q:+GMTSI=0  D
 . . S GMTSV=$$VAL($G(^TMP($J,"GMTSTYP",GMTSE,GMTSAT,GMTSI))) Q:'$L(GMTSV)
 . . Q:+GMTSV=0  Q:'$L($$TRIM^GMTSXA($P(GMTSV,"^",2)," "))
 . . Q:$D(@ROOT@("B",GMTSV))  S GMTSC=GMTSC+1,@ROOT@(GMTSC)=GMTSV,@ROOT@("B",GMTSV,GMTSC)="",@ROOT@("C",GMTSC)=$G(GMTSE)
 Q
ENT ;   Add Entity Parameters (System/User) to the List
 N GMTSC S GMTSC=+($O(@ROOT@(" "),-1)) F  S GMTSID=$O(^TMP($J,"GMTSTYP",GMTSE,"B",GMTSID)) Q:GMTSID=""  D
 . Q:'$L(GMTSID)  S GMTSI=0 F  S GMTSI=$O(^TMP($J,"GMTSTYP",GMTSE,"B",GMTSID,GMTSI)) Q:+GMTSI=0  D
 . . S GMTSV=$$VAL($G(^TMP($J,"GMTSTYP",GMTSE,GMTSI))) Q:'$L(GMTSV)  Q:+GMTSV=0
 . . Q:'$L($$TRIM^GMTSXA($P(GMTSV,"^",2)," "))  K:$D(@ROOT@("B",GMTSV)) ^TMP($J,"GMTSTYP",GMTSE,GMTSI)
 S GMTSI=0 F  S GMTSI=$O(^TMP($J,"GMTSTYP",GMTSE,GMTSI)) Q:+GMTSI=0  D
 . S GMTSV=$$VAL($G(^TMP($J,"GMTSTYP",GMTSE,GMTSI))) Q:'$L(GMTSV)
 . Q:+GMTSV=0  Q:'$L($$TRIM^GMTSXA($P(GMTSV,"^",2)," "))
 . Q:$D(@ROOT@("B",GMTSV))
 . S GMTSC=GMTSC+1,@ROOT@(GMTSC)=GMTSV,@ROOT@("B",GMTSV,GMTSC)="",@ROOT@("C",GMTSC)=$G(GMTSE)
 . S:+($G(GMTSOVR))>0 GMTSOK=1
 S:+($G(GMTSOVR))>0&($D(@ROOT@("B"))) GMTSOK=1
 K ^TMP($J,"GMTSTYP",GMTSE)
 Q
VAL(GMTSV) ; Value
 S GMTSV=$G(GMTSV) N GMTST,GMTSI,GMTSVA,GMTSN,GMTSAD,GMTSNM S GMTSI=+GMTSV Q:+GMTSI=0 GMTSV
 S GMTST=$G(^GMT(142,+GMTSI,"T")),GMTSNM=$P($G(^GMT(142,+GMTSI,0)),"^",1)
 S GMTSVA=+($G(^GMT(142,+GMTSI,"VA"))) I +GMTSVA>0,$L(GMTSNM) S GMTSV=+GMTSI_"^"_GMTSNM Q GMTSV
 S GMTSN=$P(GMTSV,"^",2) S:$L(GMTST) GMTSN=GMTST
 S GMTSV=+GMTSI_"^"_GMTSN,GMTSAD=$P($G(^GMT(142,+GMTSI,0)),"^",1)
 S:GMTSAD="GMTS HS ADHOC OPTION" GMTSV=+GMTSI_"^"_GMTSAD
 Q GMTSV
UP(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
