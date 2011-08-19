SPNRPC5 ;SD/WDE - Routine to list Vitals / Cover Sheet data;Jan 10, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to API EN6^GMRVUTL supported by IA #1120
 ;
EN(RESULTS,ICN) ;
 ;****************************
 Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;****************************
 Q:$G(^DPT(DFN,0))=""
 ;JAS - 01/10/2008 - Defect 766 DBIA Changes 
 ;Section of code below commented out and replaced due to DBIA changes
 ;S REVDATE="" F  S REVDATE=$O(^GMR(120.5,"AA",DFN,22,REVDATE)) Q:(REVDATE="")!('+REVDATE)  S IEN="" F   S IEN=$O(^GMR(120.5,"AA",DFN,22,REVDATE,IEN)) Q:IEN'>0  D
 ;.I $P($G(^GMR(120.5,IEN,2)),U,1)=1 Q  ;entered in error
 ;.D SET S REVDATE=999999999999999999
 ;.Q
 ;K IEN,ICN,DFN,REVDATE,X,X1,X2,X3
 ;Q
 ;SET ;set up data
 ;S X=$$GET1^DIQ(120.5,IEN_",",.01,"E")
 ;S X1=$$GET1^DIQ(120.5,IEN_",",.03,"E")
 ;S X2=$$GET1^DIQ(120.5,IEN_",",1.2,"E")
 ;S X3=$$GET1^DIQ(120.5,IEN_",",5,"E")
 ;S RESULTS=X_U_X1_U_X2_U_"GMR(120.5,"_IEN_U_"EOL999"
 S GMRVSTR="PN"
 D EN6^GMRVUTL
 Q:X=""
 S RESULTS=$$FMTE^XLFDT($P(X,U,1))_U_"PAIN"_U_$P(X,U,8)_U_"GMR(120.5,"_U_"EOL999"
 K GMRVSTR,X,DFN
 Q
