MAGNGMR ;WOIFO/NST - Imaging interface to Consult RPC Calls etc. ; 11 Feb 2011 8:36 AM
 ;;3.0;IMAGING;**106**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
 ;*****  Add a consult and image pointers to 
 ;       Unread/Read List file (#2006.5849)
 ;       and 
 ;       DICOM GMRC TEMP LIST file (#2006.5839)
 ;       
 ; RPC:MAG3 TELEREADER READ/UNRD ADD
 ; 
 ; Input Parameters
 ; ================
 ;   MAGDA is an image IEN in IMAGE file (#2005) - ^MAG(2005,MAGDA)
 ;   MAGCNT is count of new images captured
 ;   MAGRIEN is a request/consult IEN in REQUEST/CONSULTATION file (#123)
 ;
 ; Return Values
 ; =============
 ; if error MAGRY = The first "^" piece is zero if error occurs. The second piece is an error message
 ; if success MAGRY = The first "^" piece is one and the second is update message
 ;                              
FILE(MAGRY,MAGDA,MAGCNT,MAGRIEN) ;RPC [MAG3 TELEREADER READ/UNRD ADD]
 ; 
 ; The routine is called from GUI after the group is captured
 N D0,X,MAGI
 N MAGNFDA,MAGNIEN,MAGNXE,MAGRESA
 N RESULT,MAGFND,MAGGRP
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 S MAGRY="0^Filing Image Pointer Failed"
 ;
 ; Get a Group IEN
 S MAGGRP=$$GRPIEN^MAGGI12(MAGDA)
 I MAGGRP<0 S MAGRY="0^Error getting Group IEN" Q  ; Error getting Group IEN
 I MAGGRP=0 S MAGGRP=MAGDA ; Single Image or the group IEN itself
 ;
 ; add the consult to the Consult Unread List, if necessary
 D ADD^MAGDTR03(.RESULT,MAGRIEN,"I",MAGCNT) ; add if "ON IMAGE" is set
 ;
 I 'RESULT S MAGRY="1^Skipped filing image pointer" Q  ; Do not add it to file #2006.5839 
 ;
 S MAGI="",MAGFND=0
 F  S MAGI=$O(^MAG(2006.5839,"C",123,MAGRIEN,MAGI)) Q:'MAGI  D  Q:MAGFND
 . S:MAGGRP=$P(^MAG(2006.5839,MAGI,0),"^",3) MAGFND=1
 . Q
 ;
 I MAGFND S MAGRY="1^Image pointer filed previously" Q  ; No need to add it to file #2006.5839  
 ;
 ; Update DICOM GMRC TEMP LIST counters
 ;
 S MAGNFDA(2006.5839,"+1,",.01)=123     ; REQUEST/CONSULTATION file (#123) 
 S MAGNFDA(2006.5839,"+1,",2)=MAGRIEN   ; IEN in file #123
 S MAGNFDA(2006.5839,"+1,",3)=MAGGRP    ; IEN in IMAGE file (#2005)
 D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 I $D(MAGNXE("DIERR","E")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY="0^"_MAGRESA(1)
 . Q
 ;
 ; Set the Parent fields in the Image File for the group
 S $P(^MAG(2005,MAGGRP,2),U,6,8)=2006.5839_U_MAGRIEN_U_""
 ; Save the PARENT ASSOCIATION Date/Time 
 D LINKDT^MAGGTU6(.X,MAGGRP)
 ;
 ; Set Parent fields for the children
 S MAGI=0
 F  S MAGI=$O(^MAG(2005,MAGGRP,1,MAGI)) Q:'MAGI  D
 . S D0=$P($G(^MAG(2005,MAGGRP,1,MAGI,0)),U,1)  ; Get IEN of the child
 . Q:'D0  ; IEN is missing
 . S $P(^MAG(2005,D0,2),U,6,8)=2006.5839_U_MAGRIEN_U_""
 . D LINKDT^MAGGTU6(.X,D0)
 . Q
 ;
 ; DONE.
 S MAGRY="1^Image pointer filed successfully"
 Q
 ;
 ;***** Return not completed consults for a patient where
 ;      consult request "To Service" is setup in TELEREADER ACQUISITION SERVICE file (#2006.5841)
 ; RPC: MAG3 TELEREADER CONSULT LIST
 ;
 ; Input Parameters
 ; ================
 ; DFN - Patient ID
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "0^Error getting consult list"
 ; if success
 ;   MAGRY(0)    = "1^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "Consult ID^Consult Request Date^Service^Procedure^Sending Provider^Status"
 ;   MAGRY(2..n) = "^" delimited string with values of the fields listed in MAGRY(1) 
 ;
CONSLIST(MAGRY,DFN) ;RPC [MAG3 TELEREADER CONSULT LIST]
 ;
 N I,SRVC,PROC,STAT,DAT,X,CNT
 N RES
 N CONIEN,IENS,OUT,DOCNAME
 N EXCLCONS
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ;
 ; Exclude consult with statuses
 S EXCLCONS("DISCONTINUED")=""
 S EXCLCONS("COMPLETE")=""
 S EXCLCONS("HOLD")=""
 S EXCLCONS("FLAGGED")=""
 S EXCLCONS("EXPIRED")=""
 S EXCLCONS("DELAYED")=""
 S EXCLCONS("UNRELEASED")=""
 S EXCLCONS("DISCONTINUED/EDIT")=""
 S EXCLCONS("CANCELLED")=""
 S EXCLCONS("LAPSED")=""
 ;
 K MAGRY
 S MAGRY(0)="0^Error"
 ;
 I +DFN'>0 S MAGRY(0)="0^Not a valid Patient ID" Q  ; no patient number provided
 ;
 K ^TMP("GMRCR",$J,"CS")  ; clean up the temp list before the consult call
 D OER^GMRCSLM1(DFN,"","","","",1) ; IA #2740
 S CNT=1
 S I=0
 F  S I=$O(^TMP("GMRCR",$J,"CS",I)) Q:+I'>0  D
 . S X=$G(^TMP("GMRCR",$J,"CS",I,0))
 . S CONIEN=$P(X,U,1)  ; consult IEN
 . Q:CONIEN'>0  ; Quit if no consult found
 . Q:'$$FINDLIST^MAGDTR01(CONIEN)  ; skip the Consult/Procedure - the TO Service is not in TELEREADER ACQUISITION SERVICE file (#2006.5841)
 . S STAT=$P(X,U,3)    ; consult status
 . Q:STAT=""
 . Q:$D(EXCLCONS(STAT))  ; skip consults with status in EXCLCONS array 
 . S SRVC=$P(X,U,4)    ; REQUEST SERVICES
 . S DAT=$P(X,U,2)     ; date of consult
 . S PROC=$S($P(X,U,5)="Consult":"",1:$P(X,U,5))    ; procedure 
 . S IENS=CONIEN_","
 . K OUT
 . D GETS^DIQ(123,IENS,10,"","OUT") ; Get SENDING PROVIDER for a consult
 . S DOCNAME=$G(OUT(123,IENS,10)) ; requested physician name
 . S CNT=CNT+1
 . S MAGRY(CNT)=CONIEN_U_DAT_U_SRVC_U_PROC_U_DOCNAME_U_STAT
 . Q
 K ^TMP("GMRCR",$J,"CS")  ; clean up the temp list from the consult call
 S MAGRY(0)="1^"_(CNT-1)
 S MAGRY(1)="Consult ID^Consult Request Date^Service^Procedure^Sending Provider^Status"
 K RES
 Q
 ;
 ;***** Returns a new TELEREADER DICOM Study, Series or SOP Instance UID
 ;
 ; RPC: MAG3 TELEREADER DICOM UID
 ;
 ; Input Parameters
 ; ================
 ; MAGPARAM - array with input values
 ;            MAGPARAM("TYPE")= Type UID - "STUDY", "SERIES", "SOP"
 ;            MAGPARAM("ACNUM")= Accession number - Patient consult ID 
 ;            MAGPARAM("DFN")= Patient DFN
 ;            
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY = "0^Error message"
 ; if success
 ;   MAGRY    = "1^UID
 ;
 ;
GETUID(MAGRY,MAGPARAM) ; RPC [MAG3 TELEREADER DICOM UID] 
 N UID,SITE,SITEIEN
 N MAGTYPE,MAGACNUM,MAGDFN
 N RESULT,TYPENUM
 N ERR,DONE
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 ;
 S MAGTYPE=$G(MAGPARAM("TYPE"))
 S MAGACNUM=$G(MAGPARAM("ACNUM"))
 S MAGDFN=$G(MAGPARAM("DFN"))
 S MAGRY="0^Error creating UID"
 ;
 I (MAGTYPE'="STUDY"),(MAGTYPE'="SERIES"),(MAGTYPE'="SOP") S MAGRY="0^Unknow TYPE parameter:"_MAGTYPE Q
 S TYPENUM=$S(MAGTYPE="STUDY":"106.4",MAGTYPE="SERIES":"106.7",1:"106.8")
 ;
 ; Get the Study UID for the consult if one already exists
 S RESULT=""
 I MAGTYPE="STUDY" D  I RESULT'="" S MAGRY="1^"_RESULT Q 
 . Q:(MAGACNUM="")!(MAGDFN="")  ; Generate a new Study UID. Accession number or DFN is not provided
 . S RESULT=$$GSTUID^MAGNGMR(MAGACNUM,MAGDFN)
 . Q
 ;
 S SITEIEN=$G(DUZ(2))
 S:SITEIEN="" SITEIEN=$$KSP^XUPARAM("INST") ; IA #2541 Get Default Station IEN
 S SITE=$P($$NS^XUAF4(SITEIEN),U,2) ; IA #2171  Get Station Number
 ; Generate a new UID and check for dupes
 S (ERR,DONE)=0
 F  D  Q:ERR!DONE
 . D NEWUID^MAGNUID1(.MAGRY,SITE,TYPENUM,"")  ; Get a new UID
 . I 'MAGRY S ERR=1 Q  ; Error during UID generation
 . S UID=$P(MAGRY,"^",2)  ; Set the UID
 . ; Check for Dupes
 . I $$ISDUP^MAGNUID2(MAGTYPE,UID) Q  ; generate a new one
 . S DONE=1
 . Q
 Q  ; MAGRY is set when a new UID is generated
 ;
 ;+++++ Returns Study UID for accession number
 ;
 ; ACCNUM - Consult/Procedure Accession number
 ; DFN - Patient ID
 ;
GSTUID(ACCNUM,DFN) ; Check if a study UID exist for accession number (ACCNUM) and patient (DFN)
 ; Study UID is stored in image group level in IMAGE file (#2005)
 N RESULT
 N MAGIEN  ; IEN in DICOM GMRC TEMP LIST file (#2006.5839)
 N MAGDA,MAGGRP
 ; Get the image IEN in IMAGE file (#2005)
 S MAGIEN=$O(^MAG(2006.5839,"C",123,ACCNUM,""))  ; Get IEN for the consult in file #2006.5839
 I MAGIEN="" Q ""   ; Cannot find Study UID
 S MAGGRP=$P(^MAG(2006.5839,MAGIEN,0),U,3) ; IEN in IMAGE file (#2005)
 I '$$ISGRP^MAGGI11(MAGGRP) D
 . S MAGGRP=$$GRPIEN^MAGGI12(MAGGRP) ; Get the group IEN
 . Q
 I MAGGRP'>0 Q "" ; It is not a group. Cannot get Study UID from a single image
 I $P(^MAG(2005,MAGGRP,0),U,7)'=DFN Q ""  ; the patient of the group is not the same. Quit blank
 S RESULT=$P(^MAG(2005,MAGGRP,"PACS"),U,1)  ; Get Study UID
 Q RESULT
 ;
 ;***** Generates DICOM Series Number
 ;
 ; RPC: MAG3 TELEREADER DICOM SER NUM
 ;
 ; Input Parameters
 ; ================
 ; N/A
 ;
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY = "0^Error message"
 ; if success
 ;   MAGRY = "1^DICOM Series Number
 ;
 ;
GETSRNUM(MAGRY) ; RPC [MAG3 TELEREADER DICOM SER NUM]  
 N H,M,S,TIME,DATE,DH,X
 S MAGRY="0^Error creating Series Number"
 ; can't use D NOW^XLFDT to set DH because it is incorrect at midnight
 S DH=$H
 S DATE=$$HTFM^XLFDT(DH,1)+17000000
 S DATE=$E(DATE,5,8) ; Strip the year. Just get MMDD because of size limitation in DICOM standard
 S X=$P(DH,",",2)
 S H=X\3600,M=X\60#60,S=X#60
 S TIME=H*100+M*100+S
 S TIME=$E("000000",1,6-$L(TIME))_TIME ; Pad the time
 S MAGRY="1^"_DATE_TIME
 Q
