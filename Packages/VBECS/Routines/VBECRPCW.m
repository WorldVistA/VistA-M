VBECRPCW ; HOIFO/BNT-VBECS Workload Code Lookup RPC ;18 May 2004
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; Reference to ^LAM suppored by IA #4779
 ;
 QUIT
 ;
WKLD(RESULTS) ;
 ; Get Workload data for use case 29
 ;
 S VBECCNT=0
 S RESULTS=$NA(^TMP("VBECWKLD",$J))
 K @RESULTS
 N WKLD0,CNT,X,Y,LRSEC,PROC,COST,CPT
 S (CNT,X)=0
 D BEGROOT^VBECRPC("Workload")
 F  S X=$O(^LAM(X)) Q:'+X  D
 . S WKLD0=^LAM(X,0)
 . S WGHT=$P(WKLD0,"^",3)
 . S:'WGHT WGHT=1
 . ; Round weight multiplier decimal value to nearest integer.
 . I WGHT["." D
 . . S X1=$P(WGHT,"."),X2=$P(WGHT,".",2)
 . . S WGHT=$S(X2>4:X1+1,1:X1)
 . ; Set weight multiplier to 1 if undefined or 0.
 . S WGHT=$S(WGHT']"":1,WGHT=0:1,1:WGHT)
 . S LRSEC=$P(WKLD0,"^",15) Q:LRSEC=""
 . Q:'$D(^LAB(64.21,"B","Blood Bank",LRSEC))
 . D BEGROOT^VBECRPC("Code")
 . D ADD^VBECRPC("<LMIP>"_$$CHARCHK^XOBVLIB($P(WKLD0,"^",2))_"</LMIP>")
 . D ADD^VBECRPC("<Procedure>"_$$CHARCHK^XOBVLIB($P(WKLD0,"^"))_"</Procedure>")
 . D ADD^VBECRPC("<Cost>"_$$CHARCHK^XOBVLIB($P(WKLD0,"^",10))_"</Cost>")
 . D ADD^VBECRPC("<WeightMultiplier>"_$$CHARCHK^XOBVLIB(WGHT)_"</WeightMultiplier>")
 . I $D(^LAM("AD",X,"CPT")) D
 . . S Y=0
 . . F  S Y=$O(^LAM("AD",X,"CPT",Y)) Q:Y']""  D
 . . . I $P(^LAM(X,4,Y,0),"^",4)]"" Q
 . . . D ADD^VBECRPC("<CPTCode>"_$$CHARCHK^XOBVLIB(+^LAM(X,4,Y,0))_"</CPTCode>")
 . D ENDROOT^VBECRPC("Code")
 . Q
 D ENDROOT^VBECRPC("Workload")
 Q
 ;
KILL ;
 K VBECCNT,CNT,X
 Q
