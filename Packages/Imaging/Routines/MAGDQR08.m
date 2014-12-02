MAGDQR08 ;WOIFO/EdM,MLH,BT - Cross-References for Query/Retrieve ; 27 Nov 2012 12:58 PM
 ;;3.0;IMAGING;**54,118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
UIDS(REQ,T,UID,PRMUID,ANY,OK,UIDS) ; Overflow from MAGDQR02
 N FATAL,I,P,V,IDX,PAT,PAT0
 S FATAL=0
 S PRMUID=$G(PRMUID)
 F I=20:1:23 K ^TMP("MAG",$J,"QR",I)
 S T=$$STUIDTAG^MAGDQR00,(ANY,PAT)=0
 ;
 S P=""
 F  S P=$O(REQ(T,P)) Q:P=""  D:REQ(T,P)'=""
 . S ANY=1 K ^TMP("MAG",$J,"QR",7)
 . ; old DB structure
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^MAG(2005,""P"",LOOP)","^TMP(""MAG"",$J,""QR"",7,LOOP)")
 . S V=""
 . F  S V=$O(^TMP("MAG",$J,"QR",7,V)) Q:V=""  D
 . . S PAT=""
 . . S I=""
 . . F  S I=$O(^MAG(2005,"P",V,I)) Q:I=""  D
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
 . ; new DB structure
 . S I=$$MATCHD^MAGDQR03(REQ(T,P),"^MAGV(2005.62,""B"",LOOP)","^TMP(""MAG"",$J,""QR"",27,LOOP)")
 . S V=""
 . F  S V=$O(^TMP("MAG",$J,"QR",27,V)) Q:V=""  D  Q:PAT<0
 . . S PAT=""
 . . S I="" F  S I=$O(^MAGV(2005.62,"B",V,I)) Q:I=""  D  Q:PAT<0
 . . . Q:$P($G(^MAGV(2005.62,I,5)),"^",2)="I"  ; study marked inaccessible
 . . . N PROCIX,PATIX
 . . . S PROCIX=$P($G(^MAGV(2005.62,I,6)),"^",1) Q:'PROCIX
 . . . S PATIX=$P($G(^MAGV(2005.61,PROCIX,6)),"^",1) Q:'PATIX
 . . . S PAT0=$P($G(^MAGV(2005.6,PATIX,0)),"^",1) Q:PAT0=""
 . . . S:PAT="" PAT=PAT0
 . . . I PRMUID'=1,PAT'=PAT0 S PAT=-1 Q  ; duplicate UID if different patient...
 . . . S UID=1,^TMP("MAG",$J,"QR",20,"N"_I)=""
 . . . Q
 . . Q
 . Q
 ;
 D:PAT<0
 . I (PRMUID=2)!(PRMUID=3) S PRMUID(T)="" Q
 . D ERR^MAGDQRUE("Duplicate Study UID (tag 0020,000D)")
 . S FATAL=1
 . Q
 I FATAL D ERRSAV^MAGDQRUE Q
 ;
 S OK=1,X="Study Series Image",UIDS=""
 F T=23,22 S I="" F  S I=$O(^TMP("MAG",$J,"QR",T,I)) Q:I=""  D  Q:'OK
 . F P=22,21 D
 . . Q:P'<T  Q:'$D(^TMP("MAG",$J,"QR",P))  Q:$D(^TMP("MAG",$J,"QR",P,I))
 . . S OK=0 S:UIDS'="" UIDS=UIDS=UIDS_", "
 . . S UIDS=UIDS_$P(X," ",P)_"/"_$P(X," ",T)
 . . Q
 . Q
 ;
 S T=0 S:OK T=1
 F I=23,22,20 D:T
 . Q:'$D(^TMP("MAG",$J,"QR",I))
 . M ^TMP("MAG",$J,"QR",8)=^TMP("MAG",$J,"QR",I)
 . S T=0
 . Q
 ;
 F I=20:1:23,27 K ^TMP("MAG",$J,"QR",I)
 Q
 ;
PRUNE(RESULT) ; Remove duplicate UIDs based on PRMUID
 ; PRMUID must be defined before calling this procedure
 ; PRMUID : Duplicate UID Handling parameter
 ;    0   : Error if there is duplicate UID (Error Handled outside this procedure)
 ;    1   : All (Duplicate is not an error so this proc won't be called)
 ;    2   : Keep UID with the oldest image saved date, delete the rest (handled in this procedure)
 ;    3   : Keep UID with the latest image saved date, delete the rest (handled in this procedure)
 ;
 I PRMUID'=2,PRMUID'=3 Q
 ;
 ; Based on Study UID and PRMUID, generate KEEP array containing Header Records to keep
 N KEEP
 D KEEPHDR(.KEEP)
 ;
 ; Based on what records to keep, generate HDR containing all headers with remove/keep indicator
 N HDR
 D SAVHDR(.KEEP,.HDR)
 ;
 ; Based on HDR indicators, remove or keep Study UID, return number of records removed
 N KILLCNT
 S KILLCNT=$$REMDUP(.HDR)
 ;
 ; Update the Sub File 2006.57321 Header's highest IEN and # of entries
 D UPDSUBHD(RESULT,KILLCNT)
 Q
 ;
REMDUP(HDR) ; Based on HDR array, remove or keep Study UID records, return number of records removed
 N NEWCNT,KILLCNT
 S NEWCNT=0 ;Result # counter
 S KILLCNT=0 ;Number of killed records
 N HDRRECNO
 S HDRRECNO=0
 ;
 F  S HDRRECNO=$O(HDR(HDRRECNO)) Q:'HDRRECNO  D
 . ; if this header to delete, delete the rest of the group records
 . I HDR(HDRRECNO)=0 S KILLCNT=KILLCNT+$$DELSUB(RESULT,HDRRECNO) Q
 . ; if this header to keep, update the "Result # " with the new counter
 . D UPDHDREC(RESULT,HDRRECNO,.NEWCNT)
 ;
 Q KILLCNT
 ;
SAVHDR(KEEP,HDR) ; Based on what to keep, generate HDR array contains records to keep and to remove
 N STUIDTAG,HDRTAG
 S STUIDTAG=$$STUIDTAG^MAGDQR00
 S HDRTAG=$$HDRTAG^MAGDQR00
 ;
 N STUIDREC,STUDYUID,HDRRECNO
 S STUIDREC=0
 F  S STUIDREC=$O(^MAGDQR(2006.5732,RESULT,1,"B",STUIDTAG,STUIDREC)) Q:'STUIDREC  D
 . S STUDYUID=$P(^MAGDQR(2006.5732,RESULT,1,STUIDREC,0),U,2)
 . S HDRRECNO=$O(^MAGDQR(2006.5732,RESULT,1,"B",HDRTAG,STUIDREC),-1)
 . S HDR(HDRRECNO)=$D(KEEP(STUDYUID,HDRRECNO))
 Q
 ;
KEEPHDR(KEEP) ; Based on PRMUID, get "the oldest/latest date" records to keep
 N ORD
 S ORD=$S(PRMUID=2:1,1:-1)
 ;
 N STUDYUID,IMGSAVDT,HDRRECNO
 S STUDYUID=""
 F  S STUDYUID=$O(^TMP("MAG",$J,"QR",99,STUDYUID)) Q:STUDYUID=""  D
 . S IMGSAVDT=$O(^TMP("MAG",$J,"QR",99,STUDYUID,""),ORD) Q:IMGSAVDT=""
 . S HDRRECNO=$O(^TMP("MAG",$J,"QR",99,STUDYUID,IMGSAVDT,""))
 . S KEEP(STUDYUID,HDRRECNO)=""
 . Q
 Q
 ;
DELSUB(RESULT,HDRRECNO) ; Delete Sub File (2006.57321) record group including indices
 ; The Header Information such as Highest IEN and Counter will be updated at the end (UPDSUBHD)
 N HDRTAG
 S HDRTAG=$$HDRTAG^MAGDQR00
 N DELCNT,RECNO,TAG,QUIT
 S (QUIT,DELCNT)=0
 S RECNO=HDRRECNO-1
 ;
 F  S RECNO=$O(^MAGDQR(2006.5732,RESULT,1,RECNO)) Q:'RECNO  D  Q:QUIT
 . S TAG=$P(^MAGDQR(2006.5732,RESULT,1,RECNO,0),U)
 . I TAG=HDRTAG,RECNO'=HDRRECNO S QUIT=1 Q
 . K ^MAGDQR(2006.5732,RESULT,1,RECNO)
 . K ^MAGDQR(2006.5732,RESULT,1,"B",TAG,RECNO)
 . S DELCNT=DELCNT+1
 ;
 Q DELCNT
 ;
UPDHDREC(RESULT,R1,NEWCNT) ; Update Header Result # record with a new counter
 N TAGVAL
 S NEWCNT=NEWCNT+1
 S TAGVAL="Result # "_NEWCNT
 S ^MAGDQR(2006.5732,RESULT,1,R1,0)=$$HDRTAG^MAGDQR00_U_TAGVAL
 Q
 ;
UPDSUBHD(RESULT,KILLCNT) ; Update the Sub File 2006.57321 Header
 N HDR,LSTIEN,LSTRECNO,CNT
 S HDR=$G(^MAGDQR(2006.5732,RESULT,1,0))
 S LSTIEN=$P(HDR,U,3)
 S LSTRECNO=$O(^MAGDQR(2006.5732,RESULT,1," "),-1)
 S:LSTRECNO<LSTIEN LSTIEN=$O(^MAGDQR(2006.5732,RESULT,1,LSTIEN),-1)
 S CNT=$P(HDR,U,4)-KILLCNT
 S ^MAGDQR(2006.5732,RESULT,1,0)="TAG"_U_"2006.57321"_U_LSTIEN_U_CNT
 Q
 ;
ACCNUM(IMAGE) ; Calculate Accession Number for Image
 N GMRCPTR,PARENT,TIUPTR,X
 S X=$G(^MAG(2005,IMAGE,2)),PARENT=+$P(X,"^",6),TIUPTR=$P(X,"^",7)
 I PARENT'=8925,PARENT'=2006.5839 Q ""
 Q:'TIUPTR ""
 S GMRCPTR=$$GET1^DIQ(8925,TIUPTR,1405,"I") Q:GMRCPTR'[";GMR(123" "" ; IA # 3268
 Q $$GMRCACN^MAGDFCNV(+GMRCPTR)
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
 I KILL K ^MAG(2005,"CONSULT1",$$GMRCACN^MAGDFCNV(+GP),IMAGE) Q
 S ^MAG(2005,"CONSULT1",$$GMRCACN^MAGDFCNV(+GP),IMAGE)=""
 Q
 ;
X2(IMAGE,KILL) N CO,GP,PA,PR,T0,X
 S X=$G(^MAG(2005,IMAGE,2)),PA=+$P(X,"^",6),T0=$P(X,"^",7)
 I PA'=8925,PA'=2006.5839 Q
 Q:'T0
 S X=$G(^MAG(2005,IMAGE,40)),PR=$P(X,"^",4) Q:'PR
 S X=$G(^MAG(2005.84,PR,0)),CO=$P(X,"^",1) Q:CO=""
 S GP=$$GET1^DIQ(8925,T0,1405,"I") Q:GP'[";GMR(123"
 I KILL K ^MAG(2005,"CONSULT2",CO,$$GMRCACN^MAGDFCNV(+GP),IMAGE) Q
 S ^MAG(2005,"CONSULT2",CO,$$GMRCACN^MAGDFCNV(+GP),IMAGE)=""
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
