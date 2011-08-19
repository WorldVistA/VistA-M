VBECA3A ;DALOI/RLM-API interface for CPRS ;9/20/00  12:44
 ;;1.0;VBECS;;Apr 14, 2005;Build 35
 ;
 ; Note: This routine supports data exchange with an FDA registered
 ; medical device. As such, it may not be changed in any way without
 ; prior written approval from the medical device manufacturer.
 ; 
 ; Integration Agreements:
 ;
 QUIT
 ;
 ; ----------------------------------------------------------
 ;      Private Method supports IA 3879
 ; ----------------------------------------------------------
DFN(DFN) ;Main entry point.  Calls the SPECIMEN, COMPONENT REQUEST, and CROSSMATCH data
 D DFN^VBECA1B(DFN)
 Q
 ;D EXIT K VBCMPRQ
 ;K ^TMP("VBHOLD",$J),^TMP("VBDATA",$J)
 ;S LRDFN=$$LRDFN^LR7OR1(DFN) Q:'LRDFN
 ;D A,B,C
 ;M ^TMP("ZBNT",$J)=^TMP("VBDATA",$J)
 ;G EXIT
A ;Retrieves SPECIMEN data
 ;S VBAA=0  F  S VBAA=$O(^LR(LRDFN,"BB",VBAA)) Q:'VBAA  S VBAAA=VBAA_","_LRDFN_"," D
 ; . D GETS^DIQ(63.01,VBAAA,".01;.03;.99*;2.1;2.4;2.6;2.9;2.91;3*;6;7*;8*;10;10.3;11;11.3","EN","^TMP(""VBHOLD"","_$J,"ERROR")
 ;S VBAA=0 F  S VBAA=$O(^TMP("VBHOLD",$J,VBAA)) Q:VBAA=""  D
 ; . S VBAB=0 F  S VBAB=$O(^TMP("VBHOLD",$J,VBAA,VBAB)) Q:VBAB=""  D
 ; . . ;I $L(VBAB,",")=3,$G(^TMP("VBHOLD",$J,VBAA,VBAB,"DATE/TIME SPECIMEN TAKEN","E"))="" Q
 ; . . I $L(VBAB,",")=3,$G(^TMP("VBHOLD",$J,VBAA,VBAB,.01,"E"))="" Q
 ; . . S VBAC=0 F  S VBAC=$O(^TMP("VBHOLD",$J,VBAA,VBAB,VBAC)) Q:VBAC=""  D
 ; . . . I $L(VBAB,",")=3 S VBAD=$P(VBAB,",") I VBAD?7N1".".N S VBAD=9999999-VBAD
 ; . . . I $L(VBAB,",")=4 S VBAD=$P(VBAB,",",2) I VBAD?7N1".".N S VBAD=9999999-VBAD
 ; . . . I $L(VBAB,",")=3 S ^TMP("VBDATA",$J,"SPECIMEN",VBAD,VBAA_","_VBAC)=^TMP("VBHOLD",$J,VBAA,VBAB,VBAC,"E")
 ; . . . I $L(VBAB,",")=4 S ^TMP("VBDATA",$J,"SPECIMEN",VBAD,VBAA_","_VBAC,$P(VBAB,","))=^TMP("VBHOLD",$J,VBAA,VBAB,VBAC,"E")
 Q
B ;Retrieves COMPONENT REQUEST data
 ;S VBAA=0,VBINT(.08)="" F  S VBAA=$O(^LR(LRDFN,1.8,VBAA)) Q:'VBAA  S VBAAA=VBAA_","_LRDFN_"," D
 ; . D GETS^DIQ(63.084,VBAAA,".01;.04;.03;.05;.09;.08","IEN","VBCMPRQ","ERROR")
 ;S VBAA="" F  S VBAA=$O(VBCMPRQ(63.084,VBAA)) Q:VBAA=""  D
 ; . S VBAB=""  F  S VBAB=$O(VBCMPRQ(63.084,VBAA,VBAB)) Q:VBAB=""  D
 ; . . S VBAC=$P(VBAA,",")
 ; . . S ^TMP("VBDATA",$J,"COMPONENT REQUEST",VBAC,VBAB)=VBCMPRQ(63.084,VBAA,VBAB,$S($D(VBINT(VBAB)):"I",1:"E"))
 Q
C ;Retrieves CROSSMATCH data
 ;S VBAA=0 F  S VBAA=$O(^LRD(65,"AP",LRDFN,VBAA)) Q:'VBAA  D
 ; . D GETS^DIQ(65,VBAA,".01;.04;.07;.08;.06;.16","EN","VBXMATCH","ERROR")
 ; . S VBAC=$O(^LRD(65,+VBAA,3,0)) Q:'VBAC
 ; . D GETS^DIQ(65.03,VBAC_","_+VBAA_",",.04,"EN","VBXMTCH1","ERROR")
 ;S VBAA=0 F  S VBAA=$O(VBXMATCH(65,VBAA)) Q:VBAA=""  S VBAB=0 F  S VBAB=$O(VBXMATCH(65,VBAA,VBAB)) Q:VBAB=""  D
 ; . S ^TMP("VBDATA",$J,"CROSSMATCH",+VBAA,VBAB)=VBXMATCH(65,VBAA,VBAB,"E")
 ;S VBAA="" F  S VBAA=$O(VBXMTCH1(65.03,VBAA)) Q:VBAA=""  S VBAB="" F  S VBAB=$O(VBXMTCH1(65.03,VBAA,VBAB)) Q:VBAB=""  S ^TMP("VBDATA",$J,"CROSSMATCH",$P(VBAA,",",2),3)=$G(VBXMTCH1(65.03,VBAA,".04","E"))
 Q
EXIT ;Clean up a few variables
 ;K LRDFN,VBAA,VBAB,VBAC,VBAD,VBAAA,VBCMPRQ,VBINT,VBXMATCH,VBXMTCH1
 Q
ZEOR ;VBECA3A
