MAGDQR13 ;WOIFO/EdM/MLH/JSL/SAF/BT - Imaging RPCs for Query/Retrieve - Overflow from MAGDQR03; 10 Apr 2012 2:05 PM ; 06 Aug 2012 2:42 PM
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
 ;
 ; SAVRSLT^MAGDQR13 is called by MAGDQR03
 ;
 ; This procedure 
 ;    - saves compiled result (V) to the Query Retrieve Result File (#2006.5732)
 ;    - merges modalities with the same Study Instance UID
 ; 
 ; Input Parameters
 ; ================
 ;   RESULT = pointer into the Query Retrieve Result File (#2006.5732)
 ;   MAGDFN = pointer into the Patient File (#2)
 ;   MAGIEN = pointer into the Image File (#2005 or 2005.64)
 ;   V      = compiled result
 ; 
 ; V Structure
 ; ===========
 ; V(TAG) = VALUE
 ; V(TAG,SEQ) = VALUE
 ; V(TAG,SEQ,SEQ2) = VALUE
 ;
 ; Values of V(TAG) and V(TAG,SEQ) will be merged as one record using delimiter 
 ; Each value of V(TAG,SEQ,SEQ2) will be saved separately
 ; 
 ; TAG  = see MAGDQR00 for list of Supported tags
 ; 
SAVRSLT(RESULT,MAGDFN,MAGIEN,V) ;
 N PRVRSLT,STUDYUID,ACCN,PATNAME
 ;
 ; At this point V($$STUIDTAG) - STUDY INSTANCE UID will exist, caller validates the value before calling this proc
 S STUDYUID=V($$STUIDTAG^MAGDQR00)
 S ACCN=$G(V($$ACCNTAG^MAGDQR00)) ;Accession number
 S:ACCN="" ACCN="*" ;might not be requested in the result
 S PATNAM=$G(V($$PTNAMTAG^MAGDQR00)) ;patientname
 S:PATNAM="" PATNAM="*" ;might not be requested in the result
 ;
 ; if there are multiple modalities, replace comma delimiter with "\"
 N MODTAG
 S MODTAG=$$MODTAG^MAGDQR00
 S:$G(V(MODTAG))'="" V(MODTAG)=$TR(V(MODTAG),",","\")
 ;
 ; Get pointer (RESULT) for the given STUDYUID in file 2006.5732
 S PRVRSLT=$$GETPRSLT(MAGDFN,STUDYUID,ACCN,PATNAM)
 ; Merge record if there is previous record with the same STUDYUID
 I PRVRSLT>0 D MERGEREC(PRVRSLT,.V) Q
 ; otherwise, save record to file 
 I PRVRSLT=0 D SAVREC(RESULT,MAGDFN,MAGIEN,STUDYUID,ACCN,PATNAM,.V)
 ; PRVSLT=-1 Do not save Duplicate Study UID
 Q
 ;
GETPRSLT(MAGDFN,STUDYUID,ACCN,PATNAM) ; Get pointer (RESULT) for the given STUDYUID in file 2006.5732
 ; Return 0             -  Study UID not found
 ;        Record Number -  Study UID found
 ;        -1            -  Study UID found but has different patient id, patient name or accession number
 ;
 ;    ^TMP("MAG",$J,"DICOMQR","STUDYUID") and ^TMP("MAG",$J,"DICOMQR","STUDYUNIQUEFIELDS") below are
 ;    cross references of file 2006.5732 
 ;
 I '$D(^TMP("MAG",$J,"DICOMQR","STUDYUID",STUDYUID)) Q 0
 I '$D(^TMP("MAG",$J,"DICOMQR","STUDYUNIQUEFIELDS",MAGDFN,ACCN,PATNAM)) Q -1
 Q ^TMP("MAG",$J,"DICOMQR","STUDYUID",STUDYUID)
 ;
MERGEREC(PRVRSLT,V) ; Merge record to previous record with the same UID
 ; Merge Modalities
 D:$G(V($$MODTAG^MAGDQR00))'="" MRGONMOD(PRVRSLT,.V)
 ;
 ; Accumulate "Number of Study Related Series" and "Number of Study Related Instances"
 N NIMGTAG
 F NIMGTAG=$$NSRSTAG^MAGDQR00,$$NSRITAG^MAGDQR00 D:$G(V(NIMGTAG)) MRGONIMG(PRVRSLT,.V,NIMGTAG)
 ;
 ; Use non empty Study Description 
 D:$G(V($$STDESTAG^MAGDQR00))'="" UPDSTDES(PRVRSLT,.V)
 Q
 ;
MRGONMOD(PRVRSLT,V) ; Merge modalities from old and new db
 ; V(MODTAG) must have value before calling this procedure
 N MODTAG
 S MODTAG=$$MODTAG^MAGDQR00
 ;
 ; find record number for the Modalities of previous record with the same Study UID
 N STUDYUID,STUDYTA,MODRECNO
 S STUDYUID=V($$STUIDTAG^MAGDQR00)
 S MODRECNO=$$GTAGRECN(PRVRSLT,MODTAG,STUDYUID)
 ;
 ; if not found, add modalities to sub file (2006.57321)
 I 'MODRECNO D ADDTAGFL(PRVRSLT,MODTAG,V(MODTAG)) Q
 ;
 ; if found, merge current modalities to previous record with the same Study UID
 N PAIR,TAG,PREVMOD,MERGE
 S PAIR=$$GTAGPAIR(PRVRSLT,MODRECNO)
 S TAG=$P(PAIR,U)
 Q:MODTAG'=TAG  ;should not happen, corrupted data, no merge
 ;
 S PREVMOD=$P(PAIR,U,2) ;modalities from previous record
 S MERGE=$$MERGEMOD(.PREVMOD,V(MODTAG))
 D:MERGE UTAGPAIR(PRVRSLT,MODRECNO,MODTAG_U_PREVMOD)
 Q
 ;
MERGEMOD(PREVMOD,NEWMOD) ; return the merged modalities
 I PREVMOD="" S PREVMOD=NEWMOD Q 1
 ;
 N I,MOD,MERGE
 S MERGE=0
 ;
 F I=1:1:$L(NEWMOD,"\") D
 . S MOD=$P(NEWMOD,"\",I)
 . I '$F("\"_PREVMOD_"\","\"_MOD_"\") D
 . . S PREVMOD=PREVMOD_"\"_MOD
 . . S MERGE=1
 ;
 Q MERGE
 ;
MRGONIMG(PRVRSLT,V,NIMGTAG) ; Sum Number of NIMGTAG values from old and new db
 ; NIMGTAG is either 
 ;   $$NSRSTAG (Number of Study Related Series TAG) or
 ;   $$NSRITAG (Number of Study Related Instances TAG)
 ;
 ; find record number for the NIMGTAG of previous record with the same Study UID
 N STUDYUID,RECNO
 S STUDYUID=V($$STUIDTAG^MAGDQR00)
 S RECNO=$$GTAGRECN(PRVRSLT,NIMGTAG,STUDYUID)
 ;
 ; if not found, add NIMGTAG entry to sub file (2006.57321)
 I 'RECNO D ADDTAGFL(PRVRSLT,NIMGTAG,V(NIMGTAG)) Q
 ;
 ; if found, sum up the NIMGTAG value from old and new db
 N PAIR,TAG
 S PAIR=$$GTAGPAIR(PRVRSLT,RECNO)
 S TAG=$P(PAIR,U)
 Q:NIMGTAG'=TAG  ;should not happen, corrupted data, no merge
 ;
 S $P(PAIR,U,2)=$P(PAIR,U,2)+V(NIMGTAG) ;Sum current NIMGTAG with previous value
 D UTAGPAIR(PRVRSLT,RECNO,PAIR)
 Q
 ;
UPDSTDES(PRVRSLT,V) ; Update Study Description
 N STDESTAG
 S STDESTAG=$$STDESTAG^MAGDQR00 ; Study Description Tag
 ;
 ; find record number for Study Description of previous record with the same Study UID
 N STUDYUID,RECNO
 S STUDYUID=V($$STUIDTAG^MAGDQR00)
 S RECNO=$$GTAGRECN(PRVRSLT,STDESTAG,STUDYUID)
 ;
 ; if not found, add Study Description to sub file (2006.57321)
 I 'RECNO D ADDTAGFL(PRVRSLT,STDESTAG,V(STDESTAG)) Q
 ;
 ; if found, update empty Study Description with non empty description
 N PAIR,TAG
 S PAIR=$$GTAGPAIR(PRVRSLT,RECNO)
 S TAG=$P(PAIR,U)
 Q:STDESTAG'=TAG  ;should not happen, corrupted data, no merge
 ;
 I $P(PAIR,U,2)="" D
 . S $P(PAIR,U,2)=V(STDESTAG)
 . D UTAGPAIR(PRVRSLT,RECNO,PAIR)
 Q
 ;
SAVREC(RESULT,MAGDFN,MAGIEN,UID,ACCN,PATNAM,V) ; save record (V) to file 2006.5732
 ; save header
 D SAVHDR(RESULT)
 ; save Image saved date
 D SAVIMGDT(RESULT,MAGDFN,MAGIEN,UID)
 ; 
 ; save each tag/tag value pair to a separate record
 N TAG
 S TAG=""
 F  S TAG=$O(V(TAG)) Q:TAG=""  D
 . D SAVTAG(RESULT,.V,TAG)
 . Q
 ;
 ; The following TMPs used to identify whether a record need to be merged to previous
 ; record with the same identities (MAGDFN,ACCN,PATNAM)
 S ^TMP("MAG",$J,"DICOMQR","STUDYUID",UID)=RESULT
 S ^TMP("MAG",$J,"DICOMQR","STUDYUNIQUEFIELDS",MAGDFN,ACCN,PATNAM)=""
 Q 
 ;
SAVHDR(RESULT) ; Save header
 N TAGVAL
 S ^TMP("MAG",$J,"DICOMQR","RESULTSET")=$G(^TMP("MAG",$J,"DICOMQR","RESULTSET"))+1
 S TAGVAL="Result # "_^TMP("MAG",$J,"DICOMQR","RESULTSET")
 D ADDTAGFL(RESULT,$$HDRTAG^MAGDQR00,TAGVAL)
 Q
 ;
SAVIMGDT(RESULT,MAGDFN,MAGIEN,STUDYUID) ; Save Image Saved Date
 N IMGSAVDT,RECNO
 S IMGSAVDT=$$GETIMGDT(MAGIEN)
 S RECNO=$O(^MAGDQR(2006.5732,RESULT,1," "),-1)
 S ^TMP("MAG",$J,"QR",99,STUDYUID,IMGSAVDT_" "_MAGDFN,RECNO)=MAGIEN
 Q
 ;
GETIMGDT(MAGIEN) ; Return Image Saved date
 ; MAGIEN must exist. 
 ; Caller validates the existence of the image in either file 2005 or 2005.64
 I $D(^MAG(2005,MAGIEN)) Q $G(^MAG(2005,MAGIEN,2))\1 ;Date Image Saved
 I $D(^MAGV(2005.64,MAGIEN)) Q $G(^MAGV(2005.64,MAGIEN,15))\1 ;Last Update Date
 Q ""
 ;
SAVTAG(RESULT,V,TAG) ; Save TAG^TAG_VALUE pair
 N TAGVAL
 S TAGVAL=$$GTAGVAL(.V,TAG)
 D ADDTAGFL(RESULT,TAG,TAGVAL)
 ;
 Q:$D(V(TAG))<10  ;no multiple values
 ;
 ; save multiple values V(TAG,TAGRECNO,SEQ)
 N TAGRECNO,SEQ
 S (TAGRECNO,SEQ)=""
 ;
 F  S TAGRECNO=$O(V(TAG,TAGRECNO)) Q:TAGRECNO=""  D
 . F  S SEQ=$O(V(TAG,TAGRECNO,SEQ)) Q:SEQ=""  D
 . . S TAGVAL=$G(V(TAG,TAGRECNO,SEQ)) Q:TAGVAL=""
 . . D ADDTAGFL(RESULT,TAG,TAGVAL)
 . . Q
 . Q
 Q
 ;
GTAGVAL(V,TAG) ; Get Tag Value
 ; Values of V(TAG) and V(TAG,SEQ) will be saved as one record using delimiter "\"
 N TAGVAL,SEQ
 S TAGVAL=$G(V(TAG))
 S SEQ=""
 ;
 F  S SEQ=$O(V(TAG,SEQ)) Q:SEQ=""  D
 . Q:$G(V(TAG,SEQ))=""
 . S:TAGVAL'="" TAGVAL=TAGVAL_"\"
 . S TAGVAL=TAGVAL_V(TAG,SEQ)
 . Q
 Q TAGVAL
 ;
GTAGRECN(RESULT,TAG,STUDYUID) ; Return Sub Index for Sub File (2006.57321) for the TAG within RESULT records with STUDYUID
 N STUIDTAG,HDRTAG
 S STUIDTAG=$$STUIDTAG^MAGDQR00 ; Study UID Tag
 S HDRTAG=$$HDRTAG^MAGDQR00 ; Result Header Tag
 ;
 ; Find the Result Header Record # for StudyUID
 N HDRRECNO,FOUND
 S FOUND=0
 S HDRRECNO=""
 F  S HDRRECNO=$O(^MAGDQR(2006.5732,RESULT,1,"B",HDRTAG,HDRRECNO)) Q:HDRRECNO=""  D  Q:FOUND
 . N STUIDRCN
 . S STUIDRCN=$O(^MAGDQR(2006.5732,RESULT,1,"B",STUIDTAG,HDRRECNO))
 . Q:STUIDRCN=""
 . I STUDYUID=$P(^MAGDQR(2006.5732,RESULT,1,STUIDRCN,0),U,2) S FOUND=1
 . Q
 ;
 N RECNO
 S RECNO=0
 S:FOUND RECNO=$O(^MAGDQR(2006.5732,RESULT,1,"B",TAG,HDRRECNO))
 Q RECNO
 ;
ADDTAGFL(RESULT,TAG,TAGVAL) ; Add entry to Sub File (2006.57321)
 N LSTRECNO
 S LSTRECNO=$O(^MAGDQR(2006.5732,RESULT,1," "),-1)+1
 ;
 N HDR
 S HDR=$G(^MAGDQR(2006.5732,RESULT,1,0))
 S $P(HDR,U,1,2)="TAG^2006.57321"
 S $P(HDR,U,3)=LSTRECNO
 S $P(HDR,U,4)=$P(HDR,U,4)+1
 S ^MAGDQR(2006.5732,RESULT,1,0)=HDR
 ;
 S ^MAGDQR(2006.5732,RESULT,1,LSTRECNO,0)=TAG_U_TAGVAL
 S ^MAGDQR(2006.5732,RESULT,1,"B",TAG,LSTRECNO)=""
 Q
 ;
GTAGPAIR(RESULT,RECNO) ; Given Result and RecNo, Get Tag pair value from File 2006.5732
 N TAGPAIR
 S TAGPAIR=^MAGDQR(2006.5732,RESULT,1,RECNO,0)
 Q TAGPAIR
 ;
UTAGPAIR(RESULT,RECNO,TAGPAIR) ; Update Result, RecNo of File 2006.5732 with Tag Pair Value
 S ^MAGDQR(2006.5732,RESULT,1,RECNO,0)=TAGPAIR
 Q
