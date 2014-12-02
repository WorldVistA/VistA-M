MAGDQR12 ;WOIFO/EdM,MLH,NST - Imaging RPCs for Query/Retrieve ; 16 Apr 2013 1:12 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ; -- overflow from MAGDQR02
 ;
STUDYID(REQ,T,SID,ANY) ; TAG = 0020,0010  R  Study ID
 ; The references below to ^RADPT are permitted according to the
 ; existing Integration Agreement # 1172
 N D1,ID,PATREFDTA,MAGD0,MAGD1,I,ACCARY,P,TMPQ,V
 S TMPQ=$NA(^TMP("MAG",$J,"QR"))
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  S ID=+REQ(T,P) D:ID
 . S ANY=1
 . ; First scan for images in the new structure
 . S I=$$MATCHD^MAGDQR03("*-"_ID,"^MAGV(2005.61,""B"",LOOP)","^TMP(""MAG"",$J,""QR"",19.1,LOOP)")
 . S I=$$MATCHD^MAGDQR03("*-"_ID,"^RADPT(""ADC"",LOOP)","^TMP(""MAG"",$J,""QR"",19.1,LOOP)")  ; Radiology lookup
 . S I=$$MATCHD^MAGDQR03("*-"_ID,"^RADPT(""ADC1"",LOOP)","^TMP(""MAG"",$J,""QR"",19.1,LOOP)") ; Radiology lookup
 . S V=""
 . F  S V=$O(^TMP("MAG",$J,"QR",19.1,V)) Q:V=""  D   ; V is an accession number
 . . S:$$ADDSTUDY^MAGDQR74(V,$NA(@TMPQ@(10)),$NA(@TMPQ@(19))) SID=1
 . . Q 
 . ; Then scan for legacy Radiology Related Images (including site specific accession numbers)
 . S I=$$MATCHD^MAGDQR03("*-"_ID,"^RADPT(""ADC"",LOOP)","^TMP(""MAG"",$J,""QR"",9,LOOP)")
 . S I=$$MATCHD^MAGDQR03("*-"_ID,"^RADPT(""ADC1"",LOOP)","^TMP(""MAG"",$J,""QR"",9,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",9,V)) Q:V=""  D
 . . Q:$D(^TMP("MAG",$J,"QR",19,V))  ; already picked up from new structure
 . . D ACCFIND^RAAPI(V,.ACCARY) ; Radiology acc# lookup utility Private IA (#5020) 
 . . S I=0 F  S I=$O(ACCARY(I)) Q:'I  D
 . . . S ^TMP("MAG",$J,"QR",10,"R^"_ACCARY(I))="",SID=1
 . . . Q
 . . Q
 . ; Then scan for legacy Consult Related Images
 . S D1=0
 . I '$D(^TMP("MAG",$J,"QR",19,ID)) F  S D1=$O(^GMR(123,ID,50,D1)) Q:'D1  D
 . . N I,T,X
 . . S X=$P($G(^GMR(123,ID,50,D1,0)),"^",1) Q:X'[";TIU(8925,"
 . . S T=+X
 . . S MAGD1="" F  S MAGD1=$O(^TIU(8925.91,"B",T,MAGD1)) Q:MAGD1=""  D
 . . . S X=$G(^TIU(8925.91,MAGD1,0)),I=$P(X,"^",2) Q:'I
 . . . S ^TMP("MAG",$J,"QR",10,"C^"_MAGD0_"^8925^"_T_"^"_I_"^"_ID)="",SID=1
 . . . Q
 . . Q
 . Q
 Q
