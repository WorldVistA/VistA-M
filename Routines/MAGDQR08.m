MAGDQR08 ;WOIFO/EdM - Cross-References for Query/Retrieve ; 10/10/2007 07:40
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
 ;
UIDS ; Overflow from MAGDQR02
 N FATAL,IDX,PAT,PAT0
 S FATAL=0
 F I=20:1:23 K ^TMP("MAG",$J,"QR",I)
 S T="0020,000D",(ANY,PAT)=0
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . S ANY=1 K ^TMP("MAG",$J,"QR",7)
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^MAG(2005,""P"",LOOP)","^TMP(""MAG"",$J,""QR"",7,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",7,V)) Q:V=""  D
 . . S PAT=""
 . . S I="" F  S I=$O(^MAG(2005,"P",V,I)) Q:I=""  D
 . . . N C,X
 . . . ; If this image has a parent,
 . . . ; its UID is an image UID and not a study UID
 . . . S X=$G(^MAG(2005,I,0)),PAT0=$P(X,"^",7)
 . . . S IDX=$G(^MAG(2005,I,2))\2_" "_PAT0
 . . . D:PAT0
 . . . . I PAT="" S PAT=PAT0 Q
 . . . . Q:PRMUID=1
 . . . . S:PAT'=PAT0 PAT=-1 ; Duplicate UID if different patient...
 . . . . Q
 . . . Q:$P(X,"^",10)
 . . . S UID=1,^TMP("MAG",$J,"QR",20,I)=""
 . . . S C=0 F  S C=$O(^MAG(2005,I,1,C)) Q:'C  D
 . . . . S X=+$P($G(^MAG(2005,I,1,C,0)),"^",1)
 . . . . S:X ^TMP("MAG",$J,"QR",21,X)=""
 . . . . Q
 . . . Q
 . . Q
 . Q
 D:PAT<0
 . I (PRMUID=2)!(PRMUID=3) S PRMUID(T)="" Q
 . D ERR^MAGDQR01("Duplicate Study UID (tag 0020,000D)")
 . S FATAL=1
 . Q
 S T="0020,000E"
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . S ANY=1 K ^TMP("MAG",$J,"QR",7)
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^MAG(2005,""SERIESUID"",LOOP)","^TMP(""MAG"",$J,""QR"",7,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",7,V)) Q:V=""  D
 . . S I="" F  S I=$O(^MAG(2005,"SERIESUID",V,I)) Q:I=""  D
 . . . S UID=1,^TMP("MAG",$J,"QR",22,I)=""
 . . . Q
 . . Q
 . Q
 S T="0008,0018"
 S P="" F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . S ANY=1 K ^TMP("MAG",$J,"QR",7)
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^MAG(2005,""P"",LOOP)","^TMP(""MAG"",$J,""QR"",7,LOOP)")
 . S V="" F  S V=$O(^TMP("MAG",$J,"QR",7,V)) Q:V=""  D
 . . S PAT=""
 . . S I="" F  S I=$O(^MAG(2005,"P",V,I)) Q:I=""  D
 . . . ; If this image has a parent,
 . . . ; its UID is an image UID and not a study UID
 . . . S X=$G(^MAG(2005,I,0)),PAT0=$P(X,"^",7)
 . . . S IDX=$G(^MAG(2005,I,2))\2_" "_PAT0
 . . . D:PAT0
 . . . . I PAT="" S PAT=PAT0 Q
 . . . . Q:PRMUID=1
 . . . . S:PAT'=PAT0 PAT=-1 ; Duplicate UID if different patient...
 . . . . Q
 . . . Q:$P(X,"^",10)
 . . . S UID=1,^TMP("MAG",$J,"QR",23,I)=""
 . . . Q
 . . Q
 . Q
 D:PAT<0
 . I (PRMUID=2)!(PRMUID=3) S PRMUID(T)="" Q
 . D ERR^MAGDQR01("Duplicate Series UID (tag 0008,0018)")
 . S FATAL=1,ANY=0
 . Q
 I FATAL D ERRSAV^MAGDQR01 Q
 ;
 S OK=1,X="Study Series Image",UIDS=""
 F T=23,22 S I="" F  S I=$O(^TMP("MAG",$J,"QR",T,I)) Q:I=""  D  Q:'OK
 . F P=22,21 D
 . . Q:P'<T  Q:'$D(^TMP("MAG",$J,"QR",P))  Q:$D(^TMP("MAG",$J,"QR",P,I))
 . . S OK=0 S:UIDS'="" UIDS=UIDS=UIDS_", "
 . . S UIDS=UIDS_$P(X," ",P)_"/"_$P(X," ",T)
 . . Q
 . Q
 S T=0 S:OK T=1 F I=23,22,20 D:T
 . Q:'$D(^TMP("MAG",$J,"QR",I))
 . M ^TMP("MAG",$J,"QR",8)=^TMP("MAG",$J,"QR",I)
 . S T=0
 . Q
 F I=20:1:23 K ^TMP("MAG",$J,"QR",I)
 Q
 ;
PRUNE ; Remove results from duplicate UIDs
 N ANY,IDX,OK,R1,X
 I PRMUID'=2,PRMUID'=3 Q
 S IDX=$O(^TMP("MAG",$J,"QR",99,""),-PRMUID*2+5) Q:IDX=""
 S ANY=0,OK=0
 S R1=0 F  S R1=$O(^MAGDQR(2006.5732,RESULT,1,R1)) Q:'R1  D
 . S X=$G(^MAGDQR(2006.5732,RESULT,1,R1,0))
 . S:$E(X,1,19)="0000,0902^Result # " OK=$D(^TMP("MAG",$J,"QR",99,IDX,R1))
 . I 'OK K ^MAGDQR(2006.5732,RESULT,1,R1) Q
 . Q:$E(X,1,19)'="0000,0902^Result # "
 . S ANY=ANY+1,$P(X,"# ",2)=ANY
 . S ^MAGDQR(2006.5732,RESULT,1,R1,0)=X
 . Q
 Q
 ;
ACCNUM(IMAGE) ; Calculate Accession Number for Image
 N GMRCPTR,PARENT,TIUPTR,X
 S X=$G(^MAG(2005,IMAGE,2)),PARENT=+$P(X,"^",6),TIUPTR=$P(X,"^",7)
 I PARENT'=8925,PARENT'=2006.5839 Q ""
 Q:'TIUPTR ""
 S GMRCPTR=$$GET1^DIQ(8925,TIUPTR,1405,"I") Q:GMRCPTR'[";GMR(123" "" ; IA # 3268
 Q "GMRC-"_(+GMRCPTR)
 ;
PROCNAM(IMAGE) ; Calculate Procedure Name for Image
 N PROCPTR,X
 S X=$G(^MAG(2005,IMAGE,40)),PROCPTR=$P(X,"^",4) Q:'PROCPTR ""
 S X=$G(^MAG(2005.84,PROCPTR,0))
 Q $P(X,"^",1)
 ;
PROCNUM(IMAGE) ; Calculate Procedure Number for Image
 N X
 S X=$G(^MAG(2005,IMAGE,40))
 Q $P(X,"^",4)
 ;
 ;
 ; This routine takes care of two cross-references on the Image File
 ;
 ;    ^MAG(2005,"CONSULT1",accession,image)=""
 ;    ^MAG(2005,"CONSULT2",procedure,accession,image)=""
 ;
 ; DA ---- Image #
 ; KILL -- flag: 0=SET, 1=KILL
 ;
X1(DA,KILL) N GP,PA,T0,X
 S X=$G(^MAG(2005,IMAGE,2)),PA=+$P(X,"^",6),T0=$P(X,"^",7)
 I PA'=8925,PA'=2006.5839 Q
 Q:'T0
 S GP=$$GET1^DIQ(8925,T0,1405,"I") Q:GP'[";GMR(123"
 I KILL K ^MAG(2005,"CONSULT1","GMRC-"_(+GP),IMAGE) Q
 S ^MAG(2005,"CONSULT1","GMRC-"_(+GP),IMAGE)=""
 Q
 ;
X2(IMAGE,KILL) N CO,GP,PA,PR,T0,X
 S X=$G(^MAG(2005,IMAGE,2)),PA=+$P(X,"^",6),T0=$P(X,"^",7)
 I PA'=8925,PA'=2006.5839 Q
 Q:'T0
 S X=$G(^MAG(2005,IMAGE,40)),PR=$P(X,"^",4) Q:'PR
 S X=$G(^MAG(2005.84,PR,0)),CO=$P(X,"^",1) Q:CO=""
 S GP=$$GET1^DIQ(8925,T0,1405,"I") Q:GP'[";GMR(123"
 I KILL K ^MAG(2005,"CONSULT2",CO,"GMRC-"_(+GP),IMAGE) Q
 S ^MAG(2005,"CONSULT2",CO,"GMRC-"_(+GP),IMAGE)=""
 Q
 ;
 ; ============================================================
 ; To be included in post-init (through TaskMan?):
 ;
REDO F X="CONSULT1","CONSULT2" K ^MAG(2005,X)
 S DA=0 F  S DA=$O(^MAG(2005,DA)) Q:'DA  D
 . D X1(DA,0)
 . D X2(DA,0)
 . Q
 Q
 ;
