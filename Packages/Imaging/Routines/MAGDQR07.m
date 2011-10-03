MAGDQR07 ;WOIFO/EdM - Imaging RPCs for Query/Retrieve ; 25 Sep 2008 5:15 PM
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
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
ACCNUM ; TAG = 0008,0050  R  Accession Number
 N ACCNUM,D0,IMAGE
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . ; The references below to ^RADPT are permitted according to the
 . ; existing Integration Agreement # 1172
 . ;
 . ; First scan for Radiology Related Images
 . S ANY=1
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^RADPT(""ADC"",LOOP)","^TMP(""MAG"",$J,""QR"",5,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",5,V)) Q:V=""  D
 . . S MAGD0="" F  S MAGD0=$O(^RADPT("ADC",V,MAGD0)) Q:MAGD0=""  D
 . . . S MAGD1="" F  S MAGD1=$O(^RADPT("ADC",V,MAGD0,MAGD1)) Q:MAGD1=""  D
 . . . . S MAGD2="" F  S MAGD2=$O(^RADPT("ADC",V,MAGD0,MAGD1,MAGD2)) Q:MAGD2=""  D
 . . . . . S ^TMP("MAG",$J,"QR",6,"R^"_MAGD0_"^"_MAGD1_"^"_MAGD2)="",ACC=1
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . ; Then scan for Consult Related Images
 . S ACCNUM=REQ(T,P) S:$E(ACCNUM,1,5)="GMRC-" ACCNUM=$E(ACCNUM,6,$L(ACCNUM))
 . K ^TMP("MAG",$J,"QR",5)
 . ; For the time being, we can only do this:
 . S:ACCNUM ^TMP("MAG",$J,"QR",5,ACCNUM)=""
 . S I=$$MATCHD^MAGDQR03(ACCNUM,"^GMR(123,LOOP)","^TMP(""MAG"",$J,""QR"",5,LOOP)")
 . S D0="" F  S D0=$O(^TMP("MAG",$J,"QR",5,D0)) Q:D0=""  D
 . . N MAGDFN
 . . S MAGDFN=$$GET1^DIQ(123,D0,.02,"I") Q:'MAGDFN  ; No Patient IEN
 . . Q:$$GET1^DIQ(123,D0,8)="CANCELLED"
 . . I $O(^MAG(2006.5839,"C",123,D0,0)) D  Q  ; 1+ studies assoc w/consult
 . . . S IMAGE=0
 . . . F  S IMAGE=$O(^MAG(2006.5839,"C",123,D0,IMAGE)) Q:'IMAGE  D
 . . . . S X=$G(^MAG(2006.5839,IMAGE,0)) Q:X=""
 . . . . S X=MAGDFN_"^"_$P(X,"^",1)_"^"_$P(X,"^",2)_"^"_$P(X,"^",3)_"^"_ACCNUM
 . . . . S ^TMP("MAG",$J,"QR",6,"C^"_X)="",ACC=1
 . . . . Q
 . . . Q
 . . D  ; Otherwise find images in ^TIU
 . . . N I,RESULT,X
 . . . D TIUALL^MAGDGMRC(D0,.RESULT)
 . . . S I="" F  S I=$O(RESULT(I)) Q:I=""  D
 . . . . S X=MAGDFN_"^8925^"_$P(RESULT(I),"^",1)_"^"_$P(RESULT(I),"^",3)_"^"_$P(RESULT(I),"^",2)
 . . . . S ^TMP("MAG",$J,"QR",6,"C^"_X)="",ACC=1
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
STUDYID ; TAG = 0020,0010  R  Study ID
 ; The references below to ^RADPT are permitted according to the
 ; existing Integration Agreement # 1172
 N D1,ID
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  S ID=+REQ(T,P) D:ID
 . S ANY=1
 . ; First scan for Radiology Related Images
 . S I=$$MATCHD^MAGDQR03("*-"_ID,"^RADPT(""ADC"",LOOP)","^TMP(""MAG"",$J,""QR"",9,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",9,V)) Q:V=""  D
 . . S MAGD0="" F  S MAGD0=$O(^RADPT("ADC",V,MAGD0)) Q:MAGD0=""  D
 . . . S MAGD1="" F  S MAGD1=$O(^RADPT("ADC",V,MAGD0,MAGD1)) Q:MAGD1=""  D
 . . . . S MAGD2="" F  S MAGD2=$O(^RADPT("ADC",V,MAGD0,MAGD1,MAGD2)) Q:MAGD2=""  D
 . . . . . S ^TMP("MAG",$J,"QR",10,"R^"_MAGD0_"^"_MAGD1_"^"_MAGD2)="",SID=1
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . ; Then scan for Consult Related Images
 . S D1=0 F  S D1=$O(^GMR(123,ID,50,D1)) Q:'D1  D
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
 ;
ACCSID ; Overflow from MAGDQR02
 N OK,P1,P2,P3,P4,TYPE
 S P="" F  S P=$O(^TMP("MAG",$J,"QR",12,P)) Q:P=""  D  Q:FATAL
 . N IMAGE,IARRAY
 . S TYPE=$P(P,"^",1)
 . D:TYPE="R"  ; Radiology Images
 . . S MAGD0=$P(P,"^",2),MAGD1=$P(P,"^",3),MAGD2=$P(P,"^",4)
 . . I PAT+SSN,'$D(^TMP("MAG",$J,"QR",11,MAGD0)) Q
 . . S OK=0 D  Q:'OK  Q:FATAL
 . . . S V=$P($G(^RADPT(MAGD0,"DT",MAGD1,"P",MAGD2,0)),"^",17) Q:'V  ; IA # 1172
 . . . S P1=0 F  S P1=$O(^RARPT(V,2005,P1)) Q:'P1  D  Q:OK  Q:FATAL  ; IA # 1171
 . . . . S P2=+$G(^RARPT(V,2005,P1,0)) Q:'P2  ; IA # 1171
 . . . . I UID,$D(^TMP("MAG",$J,"QR",8,P2)) S OK=1,IARRAY(P2)="" Q
 . . . . ; don't set 'OK' flag next line, allow mult. studies per acc#
 . . . . I 'UID S IARRAY(P2)="" Q
 . . . . S P3=0 F  S P3=$O(^MAG(2005,P2,1,P3)) Q:'P3  D  Q:OK  Q:FATAL
 . . . . . S P4=$P($G(^MAG(2005,P2,1,P3,0)),"^",1) Q:'P4
 . . . . . I UID,$D(^TMP("MAG",$J,"QR",8,P4)) S OK=1,IARRAY(P4)="" Q
 . . . . . ; don't set 'OK' flag next line, allow mult. studies / acc#
 . . . . . I 'UID S OK=1,IARRAY(P4)="" Q
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . D:TYPE="C"  ; Consult Images
 . . ; P = C ^ DFN ^ File# ^ IEN ^ Image# ^ Accession#
 . . S IMAGE=$P(P,"^",5) Q:'IMAGE  S IARRAY(IMAGE)=""
 . . S MAGD0=+$P($G(^MAG(2005,+IMAGE,0)),"^",7)
 . . S (MAGD1,MAGD2)=0 ; Not a radiology study...
 . . S ACCNUM=$P(P,"^",6)
 . . Q
 . S IMAGE=""
 . F  S IMAGE=$O(IARRAY(IMAGE)) Q:'IMAGE  D
 . . D RESULT^MAGDQR03(TYPE,RESULT,IMAGE,MAGD0,MAGD1,MAGD2)
 . . Q
 . Q
 Q
 ;
