VBECRPCH ; HOIFO/BNT - VBECS HCPCS Codes lookup;19 May 2004
 ;;1.0;VBECS;**3**;Apr 14, 2005;Build 21
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference to CPT CATEGORY file supported by IA #1587
 ; Reference to CPT file supported by IA #4776
 ; Reference to LIST^DIC supported by IA #2051
 ; Reference to $$FIND1^DIC supported by IA #2051
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; Reference to $$CPT^ICPTCOD supported by IA #1995
 ;
 QUIT
 ;
 ; ---------------------------------------------------------------
 ;       Private Method Supports IA #4610
 ; ---------------------------------------------------------------
HCPCS(RESULTS) ; Get active HCPCS codes from the CPT file for Path/Lab CPT Categories
 ;
 N OUT,X
 S VBECCNT=0
 S RESULTS=$NA(^TMP("VBECHCPCS",$J))
 K @RESULTS,^TMP("DILIST",$J)
 D BEGROOT^VBECRPC("Root")
 S VBHPC=$$FIND1^DIC(81.1,,,"PATHOLOGY AND LABORATORY SERVICES",,,"VBERR")
 I 'VBHPC!($D(VBERR)) D  Q
 . D ERROR^VBECRPC("Error collecting HCPCS data")
 . D ENDROOT^VBECRPC("Root")
 . Q
 S VBSCRN="N CPT S CPT=$$CPT^ICPTCOD(Y) I $P(CPT,U,4)="_VBHPC_",$P(CPT,U,7),$P(CPT,U,5)=""H"""
 D LIST^DIC(81,,.01,,,,,"D",VBSCRN,,.OUT,"VBERR")
 I $D(VBERR) D  Q
 . D ERROR^VBECRPC("Error collecting HCPCS data")
 . D ENDROOT^VBECRPC("Root")
 . Q
 ;Replace the next lines with code to call $$CPT^ICPTCOD(x) and get code and name.
 ;Use ^XTMP($J,"DILIST","ID",n,.01)=P2028 to get the code (28 characters)
 S VBB=0 F  S VBB=$O(^TMP("DILIST",$J,"ID",VBB)) Q:'VBB  S VBDATA=^TMP("DILIST",$J,"ID",VBB,.01) D
  . S VBDATA=$$CPT^ICPTCOD(VBDATA) Q:$P(VBDATA,"^")=-1
  . D ADD^VBECRPC("<HCPCS>")
  . D ADD^VBECRPC("<Code>"_$P(VBDATA,"^",2)_"</Code>")
  . D ADD^VBECRPC("<Name>"_$P(VBDATA,"^",3)_"</Name>")
  . D ADD^VBECRPC("</HCPCS>")
 ;S VBB=0 F  S VBB=$O(^TMP("DILIST",$J,"ID",VBB)) Q:'VBB  S VBDATA="" D
 ; . D ADD^VBECRPC("<HCPCS>")
 ; . F VBC=".01^Code","2^Name" D ADD^VBECRPC("<"_$P(VBC,"^",2)_">"_$$STRIPL^VBECRPC($$CHARCHK^XOBVLIB(^TMP("DILIST",$J,"ID",VBB,$P(VBC,"^"))))_"</"_$P(VBC,"^",2)_">")
 ; . D ADD^VBECRPC("</HCPCS>")
 D ENDROOT^VBECRPC("Root")
 K @OUT,VBB,VBC,VBDATA,VBECCNT,VBFLD,VBHPC,VBSCRN
 Q
