VBECA3 ;HINES IFO/DDA-API interfaces for CPRS ;9/20/00  12:44
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ; Reference DBIA 4619 - VBECS Order Entry
 ; Reference to GETS^DIQ() supported by IA #2056
 ; Reference to $$LRDFN^LR7OR1 supported by IA #2503
 ; Reference to EN^LR7OSBR supported by IA #3190-A
 ; Reference to EN1^LR7OSBR supported by IA #3190-B
 ; Reference to $$CHARCHK^XOBVLIB supported by IA #4090
 ; 
 QUIT
 ;
EN(LRDFN) ; Call to encapsulate the extract of Blood Bank data for CPRS
 ;  via the call EN^LR7OSBR.  This call can be tested by invoking the
 ;  routine BLR^ORWRP1(root,dfn), where root is the null string and
 ;  DFN is the PATIENT FILE numeric internal entry number for the
 ;  patient.
 ; Parameter LRDFN is the LAB numeric internal entry number for the
 ;   LAB patient.
 N X
 S X="LR7OSBR" X ^%ZOSF("TEST") I '$T W !,"LR7OSBR does not exist in this environment." Q
 D EN^LR7OSBR
 Q
 ;
EN1(DFN) ; Call to encapsulate the extract of Blood Bank data for CPRS
 ;  via the call EN1^LR7OSBR.
 ; Parameter DFN is the PATIENT FILE numeric internal entry number for
 ;   the LAB patient.
 N X
 S X="LR7OSBR" X ^%ZOSF("TEST") I '$T W !,"LR7OSBR does not exist in this environment." Q
 D EN1^LR7OSBR(DFN)
 Q
 ;
 ; ------------------------------------------------------
 ;     Private method supports IA #4766
 ; ------------------------------------------------------
OEAPI(ARR,DFN,DIV) ; CPRS query to return patient and component related
 ;         data from VBECS through VistALink
 IF DFN']"" SET ARR("ERROR")="1^No Patient ID Provided" QUIT
 IF '$D(^DPT(DFN,0)) SET ARR("ERROR")="1^Undefined VistA Patient ID" QUIT
 IF DIV']"" SET ARR("ERROR")="1^No Patient Division Provided" QUIT
 ;
 NEW VBECY,VBECSTAT
 SET ARR("ERROR")=0
 DO INITV^VBECRPCC("VBECS Order Entry")
 IF +VBECPRMS("ERROR") S ARR("ERROR")=VBECPRMS("ERROR") Q
 SET VBECPRMS("PARAMS",1,"TYPE")="STRING"
 SET VBECPRMS("PARAMS",1,"VALUE")=$$CHARCHK^XOBVLIB(DFN)
 SET VBECPRMS("PARAMS",2,"TYPE")="STRING"
 SET VBECPRMS("PARAMS",2,"VALUE")=$$CHARCHK^XOBVLIB(DIV)
 ;
 SET VBECSTAT=$$EXECUTE^VBECRPCC(.VBECPRMS)
 ;
 SET VBECY=$NA(^TMP("VBECS_XML_RES",$J))
 KILL @VBECY
 DO PARSE^VBECRPC1(.VBECPRMS,VBECY)
 IF $D(@VBECY@("ERROR")) SET ARR("ERROR")="1^"_@VBECY@("ERROR") DO CLEANUP QUIT
 DO EN^VBECA3C(.ARR,VBECY)
 ; Setting for debugging GUI
 KILL ^XTMP("OEAPI")
 M ^XTMP("OEAPI",$J,$P(^DPT(DFN,0),U),DIV)=ARR
 M ^XTMP("OEAPI",$J,DFN,DIV)=^TMP("VBECS_XML_RES",$J)
 ;Q  KILL @VBECY
 ;
 ;DO CLEANUP
 QUIT
BBDATA(DFN) ;Retrieve data for CPRS reports
 ;File 63's somewhat unique storage method limits the usefulness
 ;of some of the Kernel database calls.  It was necessary to determine
 ;the first subscript level in the BB node and call the Kernel
 ;API with this level predefined.
 ;All references (field name and values) are converted to the external
 ;format.
 ;Null values are not returned.
 ;Inverse date values are converted to normal format.
 K ^TMP("VBHOLD",$J),^TMP("VBDATA",$J)
 S LRDFN=$$LRDFN^LR7OR1(DFN)
 F VBAA=0  F  S VBAA=$O(^LR(LRDFN,"BB",VBAA)) Q:'VBAA  S VBAAA=VBAA_","_LRDFN_"," D
  . D GETS^DIQ(63.01,VBAAA,"**","ERN","^TMP(""VBHOLD"","_$J,"ERROR")
 S VBAA=0 F  S VBAA=$O(^TMP("VBHOLD",$J,VBAA)) Q:VBAA=""  D
  . S VBAB=0 F  S VBAB=$O(^TMP("VBHOLD",$J,VBAA,VBAB)) Q:VBAB=""  D
  . . S VBAC=0 F  S VBAC=$O(^TMP("VBHOLD",$J,VBAA,VBAB,VBAC)) Q:VBAC=""  D
  . . . I $L(VBAB,",")=3 S VBAD=$P(VBAB,",") I VBAD?7N1".".N S VBAD=9999999-VBAD
  . . . I $L(VBAB,",")=4 S VBAD=$P(VBAB,",",2) I VBAD?7N1".".N S VBAD=9999999-VBAD
  . . . S ^TMP("VBDATA",$J,VBAD,VBAC)=^TMP("VBHOLD",$J,VBAA,VBAB,VBAC,"E")
 D GETS^DIQ(63,LRDFN,".084*","ERN","VBCMPRQ","ERROR")
 S VBAA="" F  S VBAA=$O(VBCMPRQ(63.084,VBAA)) Q:VBAA=""  D
  . S VBAB=""  F  S VBAB=$O(VBCMPRQ(63.084,VBAA,VBAB)) Q:VBAB=""  D
  . . S VBAC=$P(VBAA,",")
  . . S ^TMP("VBDATA",$J,"COMPONENT REQUEST",VBAC,VBAB)=VBCMPRQ(63.084,VBAA,VBAB,"E")
 K ^TMP("VBHOLD",$J),VBAA,VBAB,VBAC,VBAD,VBAAA,VBCMPRQ
 Q
CLEANUP ;
 KILL VBECPRMS,VBECSTAT
 KILL ^TMP("VBECS_XML_RES",$J)
 QUIT
