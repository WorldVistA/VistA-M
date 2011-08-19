MAGDQR02 ;WOIFO/EdM - Imaging RPCs for Query/Retrieve ; 07/05/2007 07:51
 ;;3.0;IMAGING;**51,54,66**;Mar 19, 2002;Build 1836;Sep 02, 2010
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
 ;
QUERY ; --- perform actual query --- Called by TaskMan
 N ACC,ANY,FATAL,MAGD0,MAGD1,MAGD2,ERROR,FD,FT,I,IMAGE,L,LD,LT,OFFSET,P,PAT,PRMUID,SDT,SID,SSN,T,TIM,UID,V,X
 ;
 K ^TMP("MAG",$J,"QR")
 S (PAT,SSN,ACC,UID,SID,SDT,TIM,ERROR,FATAL)=0
 S FD=0,LD=9999999,FT=0,LT=240000
 ;
 S PRMUID=0 ; 0=error, 1=all, 2=oldest, 3=newest
 S T="0000,0902",I=0 ; Duplicate UID handling parameter
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . S PRMUID=REQ(T,P)
 . Q
 K REQ(T)
 S:($L(PRMUID)'=1)!(123'[PRMUID) PRMUID=0
 ;
 S T="0008,0020",I=0 ; R  Study Date
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . N FR,UT
 . S I=I+1 I I>1 D ERR^MAGDQR01("More than one study date specified.") Q
 . S (X,FR,UT)=REQ(T,P) S:X["-" FR=$P(X,"-",1),UT=$P(X,"-",2)
 . I FR'="",FR'?8N D ERR^MAGDQR01("Invalid 'from' date: """_FR_""".")
 . I UT'="",UT'?8N D ERR^MAGDQR01("Invalid 'until' date: """_UT_""".")
 . S FD=+FR S:FD FD=FD-17000000
 . S LD=+UT S:LD LD=LD-17000000
 . S TIM=1
 . Q
 ;
 S T="0008,0030",I=0 ; R  Study Time
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . N FR,UT
 . S I=I+1 I I>1 D ERR^MAGDQR01("More than one study time specified.") Q
 . S (X,FR,UT)=REQ(T,P) S:X["-" FR=$P(X,"-",1),UT=$P(X,"-",2)
 . D CHKTIM(FR,"from")
 . D CHKTIM(UT,"until")
 . S FT=+$E(FR_"000000",1,6)
 . S LT=+$E(UT_"000000",1,6)
 . S TIM=1
 . Q
 I ERROR D ERRSAV^MAGDQR01 Q
 ;
 S FD=FT/1E6+FD,LD=LT/1E6+LD
 ;
 S T="0010,0010",ANY=0 ; R  Patient's Name
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . ; The references below to ^DPT are permitted according to the
 . ; explicit permission in Section II of the PIMS V5.3 technical manual
 . ; (dated 23 Nov 2004)
 . S ANY=1
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^DPT(""B"",LOOP)","^TMP(""MAG"",$J,""QR"",1,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",1,V)) Q:V=""  D
 . . S I="" F  S I=$O(^DPT("B",V,I)) Q:I=""  S ^TMP("MAG",$J,"QR",2,I)="",PAT=1
 . . Q
 . Q
 I ANY,'PAT D  Q
 . D ERR^MAGDQR01("No matches for tag "_T)
 . D ERRSAV^MAGDQR01
 . Q
 ;
 S T="0010,0020",ANY=0 ; R  Patient ID
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . ; The references below to ^DPT are permitted according to the
 . ; explicit permission in Section II of the PIMS V5.3 technical manual
 . ; (dated 23 Nov 2004)
 . S ANY=1
 . S I=$$MATCHD^MAGDQR03($TR(REQ(T,P),"-"),"^DPT(""SSN"",LOOP)","^TMP(""MAG"",$J,""QR"",3,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",3,V)) Q:V=""  D
 . . S I="" F  S I=$O(^DPT("SSN",V,I)) Q:I=""  S ^TMP("MAG",$J,"QR",4,I)="",SSN=1
 . . Q
 . Q
 I ANY,'SSN D  Q
 . D ERR^MAGDQR01("No matches for tag "_T)
 . D ERRSAV^MAGDQR01
 . Q
 ;
 S T="0008,0050",ANY=0 ; R  Accession Number
 D ACCNUM^MAGDQR07
 I ANY,'ACC D  Q
 . D ERR^MAGDQR01("No matches for tag "_T)
 . D ERRSAV^MAGDQR01
 . Q
 ;
 S T="0020,0010",ANY=0 ; R  Study ID
 D STUDYID^MAGDQR07
 I ANY,'SID D  Q
 . D ERR^MAGDQR01("No matches for tag "_T)
 . D ERRSAV^MAGDQR01
 . Q
 ;
 D  I ANY,'UID Q
 . N OK,UIDS
 . D UIDS^MAGDQR08
 . Q:'ANY  Q:OK
 . S UID=0
 . D ERR^MAGDQR01("Conflicting UIDs: "_UIDS)
 . D ERRSAV^MAGDQR01
 . Q
 ;
 I TIM,'(PAT+SSN+SID+UID+ACC) D TIM^MAGDQR05
 ;
 I '(PAT+SSN+SID+UID+ACC) D  Q
 . D ERR^MAGDQR01("No Selection Specified.")
 . D ERRSAV^MAGDQR01
 . Q
 ;
 D ELIM(ACC,SID,6,10,"Accession and Study ID",0)
 M ^TMP("MAG",$J,"QR",12)=^TMP("MAG",$J,"QR",6)
 M ^TMP("MAG",$J,"QR",12)=^TMP("MAG",$J,"QR",10)
 ;
 D ELIM(PAT,SSN,2,4,"Patient Name and ID",0)
 M ^TMP("MAG",$J,"QR",11)=^TMP("MAG",$J,"QR",2)
 M ^TMP("MAG",$J,"QR",11)=^TMP("MAG",$J,"QR",4)
 ;
 D ELIMB(PAT+SSN,ACC+SID,11,12,"Patient and Study Info")
 I ERROR D ERRSAV^MAGDQR01 Q
 ;
 K ^TMP("MAG",$J,"DICOMQR")
 S ^TMP("MAG",$J,"DICOMQR","RESULTSET")=0
 S ^TMP("MAG",$J,"DICOMQR","DUMMY SIUID")=0
 D
 . I UID D  Q
 . . S IMAGE="" F  S IMAGE=$O(^TMP("MAG",$J,"QR",8,IMAGE)) Q:IMAGE=""  D  Q:FATAL
 . . . S X=$G(^MAG(2005,IMAGE,0)),P=+$P(X,"^",7)
 . . . I PAT+SSN,P,'$D(^TMP("MAG",$J,"QR",11,P)) Q
 . . . S X=$G(^MAG(2005,IMAGE,2))
 . . . S V=$P(X,"^",5) I V,(V<FD)!(V>LD) Q
 . . . S V=$P(X,"^",6)
 . . . ; Radiology Image
 . . . I V=74 D  Q  ; Radiology Image
 . . . . S X=$G(^RARPT(+$P(X,"^",7),0)) ; IA # 1171
 . . . . S MAGD0=$P(X,"^",2),MAGD1=9999999.9999-$P(X,"^",3),V=$P(X,"^",4)
 . . . . S MAGD2=$O(^RADPT(MAGD0,"DT",MAGD1,"P","B",V,"")) ; IA # 1172
 . . . . I ACC+SID,'$D(^TMP("MAG",$J,"QR",12,"R^"_MAGD0_"^"_MAGD1_"^"_MAGD2)) Q
 . . . . D RESULT^MAGDQR03("R",RESULT,IMAGE,MAGD0,MAGD1,MAGD2)
 . . . . Q
 . . . ; Consult Image
 . . . I (V=8925)!(V=2006.5839) D RESULT^MAGDQR03("C",RESULT,IMAGE,P) Q
 . . . Q
 . . Q
 . ;
 . I ACC+SID D ACCSID^MAGDQR07 Q
 . ;
 . I PAT+SSN D  Q
 . . S P="" F  S P=$O(^TMP("MAG",$J,"QR",11,P)) Q:P=""  D  Q:FATAL
 . . . S IMAGE="" F  S IMAGE=$O(^MAG(2005,"AC",P,IMAGE)) Q:IMAGE=""  D  Q:FATAL
 . . . . Q:$P($G(^MAG(2005,IMAGE,0)),"^",10)
 . . . . S X=$G(^MAG(2005,IMAGE,2))
 . . . . S V=$P(X,"^",5) I V,(V<FD)!(V>LD) Q
 . . . . S V=$P(X,"^",6)
 . . . . I V=74 D  Q  ; Radiology Image
 . . . . . S V=$P(X,"^",5) I V,(V<FD)!(V>LD) Q
 . . . . . S X=$G(^RARPT(+$P(X,"^",7),0)) ; IA # 1171
 . . . . . S MAGD0=$P(X,"^",2),MAGD1=9999999.9999-$P(X,"^",3),V=$P(X,"^",4)
 . . . . . S MAGD2=$O(^RADPT(MAGD0,"DT",MAGD1,"P","B",V,"")) ; IA # 1172
 . . . . . I ACC+SID,'$D(^TMP("MAG",$J,"QR",12,"R^"_MAGD0_"^"_MAGD1_"^"_MAGD2)) Q
 . . . . . D RESULT^MAGDQR03("R",RESULT,IMAGE,MAGD0,MAGD1,MAGD2)
 . . . . . Q
 . . . . I (V=8925)!(V=2006.5839) D  Q  ; Consult Image
 . . . . . S MAGD0=+$P($G(^MAG(2005,IMAGE,0)),"^",7)
 . . . . . D RESULT^MAGDQR03("C",RESULT,IMAGE,MAGD0)
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 D:$O(PRMUID(""))'="" PRUNE^MAGDQR08 ; There are duplicate UIDs
 S $P(^MAGDQR(2006.5732,RESULT,0),"^",2,3)="OK^"_$$NOW^XLFDT()
 K ^TMP("MAG",$J,"QR")
 K ^TMP("MAG",$J,"DICOMQR")
 Q
 ;
CHKTIM(V,L) ;
 Q:V=""
 I V'?1.6N D ERR^MAGDQR01("Invalid '"_L_"' time: """_V_""".")
 I $E(V,1,2)>23 D ERR^MAGDQR01("Invalid hours in '"_L_"' time: """_V_""".")
 I $E(V,3,4),$E(V,3,4)>59 D ERR^MAGDQR01("Invalid minutes in '"_L_"' time: """_V_""".")
 I $E(V,5,6),$E(V,5,6)>59 D ERR^MAGDQR01("Invalid seconds '"_L_"' time: """_V_""".")
 Q
 ;
ELIM(ONE,TWO,I1,I2,E,C) N ANY,I,O
 Q:'ONE  Q:'TWO
 S I="" F  S I=$O(^TMP("MAG",$J,"QR",I1,I)) Q:I=""  D
 . S O=I I C Q:I'["^"  S O=+I
 . I '$D(^TMP("MAG",$J,"QR",I2,O)) K ^TMP("MAG",$J,"QR",I1,I)
 . Q
 S I="" F  S I=$O(^TMP("MAG",$J,"QR",I2,I)) Q:I=""  D
 . S O=I I C Q:I'["^"  S O=+I
 . I '$D(^TMP("MAG",$J,"QR",I1,O)) K ^TMP("MAG",$J,"QR",I2,I)
 . Q
 S ANY=($D(^TMP("MAG",$J,"QR",I1))>9)*($D(^TMP("MAG",$J,"QR",I2))>9)
 D:'ANY ERR^MAGDQR01("No matches left, conflict between "_E)
 Q
 ;
ELIMB(ONE,TWO,I1,I2,E) N ANY,I,O
 ; elimination logic between subtrees w/different data structures,
 ; e.g., 11 (I1) and 12 (I2)
 N HIT ; match flag
 Q:'ONE  Q:'TWO
 S I="" F  S I=$O(^TMP("MAG",$J,"QR",I1,I)) Q:I=""  D
 . S O="",HIT=0
 . ; match?
 . F  S O=$O(^TMP("MAG",$J,"QR",I2,O)) Q:O=""  I $P(O,"^",2)=I S HIT=1 Q  ; yes
 . K:'HIT ^TMP("MAG",$J,"QR",I1,I) ; no
 . Q
 S I="" F  S I=$O(^TMP("MAG",$J,"QR",I2,I)) Q:I=""  D
 . S O=$P(I,"^",2) I O,$D(^TMP("MAG",$J,"QR",I1,O)) Q  ; match
 . K ^TMP("MAG",$J,"QR",I2,I) ; no match
 . Q
 S ANY=($D(^TMP("MAG",$J,"QR",I1))>9)*($D(^TMP("MAG",$J,"QR",I2))>9)
 D:'ANY ERR^MAGDQR01("No matches left, conflict between "_E)
 Q
 ;
