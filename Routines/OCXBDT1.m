OCXBDT1 ;SLC/RJS,CLA - BUILD OCX PACKAGE DIAGNOSTIC ROUTINES (Routine Checksums) ;8/04/98  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 ;
 N RTN,RTNSET
 K ^UTILITY($J),OCXPATH
 S ^TMP("OCXBDT",$J,$O(^TMP("OCXBDT",$J,""),-1)+1)="RSTRT"
 ;
 I $D(^%ZOSF("RSEL")) X ^%ZOSF("RSEL") Q:'$D(^UTILITY($J))
 ;
 S RTN="A" F  S RTN=$O(^UTILITY($J,RTN)) Q:'$L(RTN)  W !,RTN,?10,$$CHKSUM(RTN)
 ;
 S ^TMP("OCXBDT",$J,$O(^TMP("OCXBDT",$J,""),-1)+1)="REND"
 ;
 Q
 ;
TEST(R) N X X "S X=''$L($T(^"_R_"))" Q X
 ;
CHKSUM(RTN) ; ;
 ;
 N LINE,CHAR,CSUM,SIZE,TEXT,DATE,RSUM,X,LAST
 ;
 I '$$TEST(RTN) Q "Routine not found"
 I ($E(RTN,1,5)="OCXOZ") Q "Compiled routine not checked"
 I ($E(RTN,1,5)="OCXDI") Q $$RDEL(RTN)
 ;
 S DATE=$P($$TEXT(RTN,1),";",3)
 S LAST=$O(^TMP("OCXBDT",$J,""),-1)+1,^TMP("OCXBDT",$J,LAST)="RTN"_U_RTN_U_DATE
 S RSUM="RSUM",SIZE=$L($$TEXT(RTN,1))+$L($$TEXT(RTN,2))
 ;
 F LINE=4:1:999 S TEXT=$$TEXT(RTN,LINE) Q:'$L(TEXT)  D
 .S CSUM=0,SIZE=SIZE+$L(TEXT)
 .F CHAR=1:1:$L(TEXT) S CSUM=CSUM+($A(TEXT,CHAR)*CHAR)
 .I ($L(RSUM)>200) S LAST=$O(^TMP("OCXBDT",$J,""),-1)+1,^TMP("OCXBDT",$J,LAST)=RSUM,RSUM="RSUM"
 .S RSUM=RSUM_U_(+(CSUM_"."_$L(TEXT)_"1"))
 ;
 I $P(RSUM,U,2) S LAST=$O(^TMP("OCXBDT",$J,""),-1)+1,^TMP("OCXBDT",$J,LAST)=RSUM
 S LAST=$O(^TMP("OCXBDT",$J,""),-1)+1,^TMP("OCXBDT",$J,LAST)="RND"_U_RTN_U_DATE
 ;
 I (SIZE>8000) W *7
 ;
 Q $J(SIZE,6)_"  "_DATE_"  "_$S((SIZE>8000):"******* Routine too large",1:"")
 ;
TEXT(RTN,LINE) ;
 ;
 N TEXT X "S TEXT=$T(+"_(+LINE)_"^"_RTN_")" Q TEXT
 ;
RDEL(X) ;
 ;
 I '$D(^%ZOSF("DEL")) Q "Routine not deleted (^%ZOSF(""DEL"") undefined)"
 X ^%ZOSF("DEL")
 Q "Routine Deleted"
 ;
