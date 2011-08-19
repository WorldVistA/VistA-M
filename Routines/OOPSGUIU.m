OOPSGUIU ;WIOFO/LLH-RPC Broker calls for GUI ;03/25/04
 ;;2.0;ASISTS;**11**;Jun 03, 2002
 ;
SERVICE ; calling this Service report but it really is Location
 ; of injury and detail location of injury report
 ; Note: to sort this report by station, add DSTXT as the first
 ;       subscript in ARR
 N DLOC,DLSTAIEN,DLOCTX,DS,DSTXT,LOC,LOCTX,TI
 S LOC=$$GET1^DIQ(2260,IEN,27,"I"),LOCTX=$$GET1^DIQ(2260,IEN,27)
 S DLOC=$$GET1^DIQ(2260,IEN,348),DS=$$GET1^DIQ(2260,IEN,13,"I")
 S DSTXT=$$GET1^DIQ(2260,IEN,13)
 S TI=$$GET1^DIQ(2260,IEN,3)
 I ($G(TI)="") Q
 I $G(LOCTX)="" S LOCTX="No Location Text,Loc Code ="_LOC
 I LOC="" S ARR(TI,"NO LOC ENTERED"," - ")=$G(ARR(TI,"NO LOC ENTERED"," - "),0)+1 Q
 I DLOC="" S ARR(TI,LOCTX,"NO DETAIL ENTERED")=$G(ARR(TI,LOCTX,"NO DETAIL ENTERED"),0)+1 Q
 I DLOC'="" D
 .S DLSTAIEN=$O(^OOPS(2261.4,LOC,1,"B",DS,""))
 .I DLSTAIEN="" S ARR(TI,LOCTX,"STADET NO ENT")=$G(ARR(TI,LOCTX,"STADET NO ENT"),0)+1
 .S DLOCTX=$G(^OOPS(2261.4,LOC,1,DLSTAIEN,1,DLOC,0),"BAD DATA")
 .S ARR(TI,LOCTX,DLOCTX)=$G(ARR(TI,LOCTX,DLOCTX),0)+1
 Q
CMPLSRV ; move data from ARR to ^TMP($J,"SERVICE"
 N N1,N2,N3,N4,CN
 S CN=0,N1=""
 F  S N1=$O(ARR(N1)) Q:N1=""  S N2="" D
 .F  S N2=$O(ARR(N1,N2)) Q:N2=""  S N3="" D
 ..F  S N3=$O(ARR(N1,N2,N3)) Q:N3=""  S N4="" D
 ...;add line below back in if sorting by station
 ...;F  S N4=$O(ARR(N1,N2,N3,N4)) Q:N4=""  D
 ...S ^TMP($J,TAG,CN)=N1_U_N2_U_N3_U_N4_U_ARR(N1,N2,N3),CN=CN+1
 Q
DSPUTE ; from OOPSGUIR, set temp global from compiled data
 ; this should only be called from DSPUTE^OOPSGUIR
 N IEN,CN,FI,LT,NLT
 S IEN=0 F  S IEN=$O(^OOPS(2262.8,IEN)) Q:(IEN'>0)  D
 .S FI=$P($G(^OOPS(2262.8,IEN,0)),U) I '$D(ARR(FI)) S ARR(FI,"NLT")=0
 S FI="",CN=1
 F  S FI=$O(ARR(FI)) Q:FI=""  D
 .S LT=$G(ARR(FI,"LT"),0),NLT=$G(ARR(FI,"NLT"),0)
 .S ^TMP($J,TAG,CN)=FI_U_LT_U_NLT,CN=CN+1
 Q
