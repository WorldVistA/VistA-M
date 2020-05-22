MAGDQR02 ;WOIFO/EdM,MLH,JSL,BT,DSB - Imaging RPCs for Query/Retrieve ; 09 Sept 2019 4:11 PM
 ;;3.0;IMAGING;**51,54,66,118,239**Sept 09,2019;Build ;Build 18
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
 ; The RESULT index, MAGDUZ, and REQ() array are passed into this routine's
 ; partition implicitly by the TaskMan invocation
 N ACC,ANY,ENT,FATAL,MAGD0,MAGD1,MAGD2,FD,FT,I,IMAGE,L,LD,LT,OFFSET,P,PAT,PRMUID,SDT,SID,SSN,T,TIM,UID,V,X
 ;
 K ^TMP("MAG",$J,"QR")
 S (PAT,SSN,ACC,UID,SID,SDT,TIM,FATAL)=0
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
 S P="" F  S P=$O(REQ(T,P))   Q:P=""  D:REQ(T,P)'=""
 . N FR,UT
 . S I=I+1 I I>1 D ERR^MAGDQRUE("More than one study date specified.") Q
 . S (X,FR,UT)=REQ(T,P) S:X["-" FR=$P(X,"-",1),UT=$P(X,"-",2)
 . I FR'="",FR'?8N D ERR^MAGDQRUE("Invalid 'from' date: """_FR_""".")
 . I UT'="",UT'?8N D ERR^MAGDQRUE("Invalid 'until' date: """_UT_""".")
 . S FD=+FR S:FD FD=FD-17000000
 . I UT'="" S LD=+UT S:LD LD=LD-17000000  ;P239;DSB-Fix last date when null
 . I UT="" S LD=$$HTFM^XLFDT($H,1)
 . S TIM=1
 . Q
 ;
 S T="0008,0030",I=0 ; R  Study Time
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . N FR,UT
 . S I=I+1 I I>1 D ERR^MAGDQRUE("More than one study time specified.") Q
 . S (X,FR,UT)=REQ(T,P) S:X["-" FR=$P(X,"-",1),UT=$P(X,"-",2)
 . D CHKTIM(FR,"from")
 . D CHKTIM(UT,"until")
 . S FT=+$E(FR_"000000",1,6)
 . S LT=+$E(UT_"000000",1,6)
 . S TIM=1
 . Q
 I $D(^TMP("MAG",$J,"ERR")) D ERRSAV^MAGDQRUE Q
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
 . D ERR^MAGDQRUE("No matches for tag "_T)
 . D ERRSAV^MAGDQRUE
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
 . I 'SSN,$$ISIHS^MAGSPID(),REQ(T,P)?1.6N D  Q  ;IHS Health Record No - patient lookup
 . . S V=$$FIND1^DIC(9000001,,"MX",REQ(T,P)) ;IA #447 
 . . S:V ^TMP("MAG",$J,"QR",4,V)="",SSN=1
 . . Q
 . Q
 I ANY,'SSN D  Q
 . D ERR^MAGDQRUE("No matches for tag "_T)
 . D ERRSAV^MAGDQRUE
 . Q
 ;
 S T="0008,0050",ANY=0 ; R  Accession Number
 D ACCNUM^MAGDQR07(.REQ,T,.ACC,.ANY)
 I ANY,'ACC D  Q
 . D ERR^MAGDQRUE("No matches for tag "_T)
 . D ERRSAV^MAGDQRUE
 . Q
 ;
 S T="0020,0010",ANY=0 ; R  Study ID
 D STUDYID^MAGDQR12(.REQ,T,.SID,.ANY)
 I ANY,'SID D  Q
 . D ERR^MAGDQRUE("No matches for tag "_T)
 . D ERRSAV^MAGDQRUE
 . Q
 ;
 D  I ANY,'UID Q
 . N OK,UIDS
 . D UIDS^MAGDQR08(.REQ,T,.UID,PRMUID,.ANY,.OK,.UIDS)
 . Q:'$G(ANY)  Q:$G(OK)
 . S UID=0
 . D ERR^MAGDQRUE("Conflicting UIDs: "_$G(UIDS))
 . D ERRSAV^MAGDQRUE
 . Q
 ;
 I TIM,'(PAT+SSN+SID+UID+ACC) D TIM^MAGDQR05(.REQ,FD,LD,.TIM,.ANY,.SID)
 ;
 I '(PAT+SSN+SID+UID+ACC) D  Q
 . D ERR^MAGDQRUE("No Selection Specified.")
 . D ERRSAV^MAGDQRUE
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
 I $D(^TMP("MAG",$J,"ERR")) D ERRSAV^MAGDQRUE Q
 ;
 K ^TMP("MAG",$J,"DICOMQR")
 S ^TMP("MAG",$J,"DICOMQR","RESULTSET")=0
 S ^TMP("MAG",$J,"DICOMQR","DUMMY SIUID")=0
 D  ; switch
 . ;return data on image / study entries from appropriate queue based on type of lookup
 . I UID D  Q  ; UID lookup case
 . . S IMAGE="" F  S IMAGE=$O(^TMP("MAG",$J,"QR",8,IMAGE)) Q:IMAGE=""  D
 . . . ; new or old database?
 . . . I $E(IMAGE,1)="N" D UIDNEW^MAGDQR31(IMAGE,.REQ,RESULT,MAGDUZ,PAT,SSN,UID,FD,LD) Q
 . . . D UIDOLD^MAGDQR32(IMAGE,.REQ,RESULT,MAGDUZ,PAT,SSN,ACC,SID,UID,FD,LD)
 . . . Q
 . . Q
 . I ACC+SID D  Q  ; accession no. / study ID lookup case
 . . S P="" F  S P=$O(^TMP("MAG",$J,"QR",12,P)) Q:P=""  D
 . . . D ACCSID^MAGDQR10(P,.REQ,RESULT,MAGDUZ,PAT,SSN,UID,FD,LD)
 . . . Q
 . . Q
 . I PAT+SSN D  Q  ; pt name / SSN lookup case
 . . S P="" F  S P=$O(^TMP("MAG",$J,"QR",11,P)) Q:P=""  D  Q:$G(FATAL)
 . . . ; new database
 . . . D:$D(^MAGV(2005.6,"B",P)) PATSSNNU^MAGDQR22(.P,.REQ,RESULT,MAGDUZ,PAT,SSN,UID,FD,LD,.ERROR,.FATAL)
 . . . ; old database
 . . . S IMAGE="" F  S IMAGE=$O(^MAG(2005,"AC",P,IMAGE)) Q:IMAGE=""  D  Q:$G(FATAL)
 . . . . D PATSSNOL^MAGDQR23(IMAGE,.REQ,RESULT,MAGDUZ,FD,LD,.ERROR,.FATAL)
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 D:$O(PRMUID(""))'="" PRUNE^MAGDQR08(RESULT) ; There are duplicate UIDs
 S $P(^MAGDQR(2006.5732,RESULT,0),"^",2,3)="OK^"_$$NOW^XLFDT()
 K ^TMP("MAG",$J,"QR")
 K ^TMP("MAG",$J,"DICOMQR")
 Q
 ;
CHKTIM(V,L) ;
 Q:V=""
 I V'?1.6N D ERR^MAGDQRUE("Invalid '"_L_"' time: """_V_""".")
 I $E(V,1,2)>23 D ERR^MAGDQRUE("Invalid hours in '"_L_"' time: """_V_""".")
 I $E(V,3,4),$E(V,3,4)>59 D ERR^MAGDQRUE("Invalid minutes in '"_L_"' time: """_V_""".")
 I $E(V,5,6),$E(V,5,6)>59 D ERR^MAGDQRUE("Invalid seconds '"_L_"' time: """_V_""".")
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
 D:'ANY ERR^MAGDQRUE("No matches left, conflict between "_E)
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
 D:'ANY ERR^MAGDQRUE("No matches left, conflict between "_E)
 Q
