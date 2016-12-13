MAGT7MA ;WOIFO/MLH/PMK - Telepathology - create HL7 message to DPS ;02 Aug 2016 12:08 PM
 ;;3.0;IMAGING;**138,173**;Mar 19, 2002;Build 23;Sep 03, 2013
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
EDIT ; main entry point to create HL7 order message for modification
 Q:'$$ISLRSSOK^MAGT7MA(LRSS)  ; check for supported anatomic pathology sections
 ;
 N RETURN
 S RETURN=$$BUILDHL7("EDIT")
 I RETURN D ERROR^MAGT7MA(RETURN,"EDIT")
 Q
 ;
NEW ; entry point for to create HL7 order message for a new case
 Q:'$$ISLRSSOK^MAGT7MA(LRSS)  ; check for supported anatomic pathology sections
 ;
 N MAGNEWCASE ; cause MAGNEWCASE to be undefined (it is set to 1 in LRAPLG1)
 N RETURN
 S RETURN=$$BUILDHL7("NEW")
 I RETURN D ERROR^MAGT7MA(RETURN,"NEW")
 Q
 ;
BUILDHL7(STATE) ; build the segments
 ; Input variables from Lab Package
 ; LRDFN ----- lab file (#63) patient pointer
 ; LRI ------- inverse date in lab file (#63)
 ; LRSS ------ anatomic pathology section abbreviation in lab file (#63) - CY, EM, or SP
 ;
 N ACNUMB ; -- Accession Number (order number, not specimen number)
 N COMPLETED ; date the report was completed
 N DFN ; ----- local copy of DFN obtained from file #63 using LRDFN 
 N FILE ; ---- LAB DATA subfile numbers and other info
 N MSHELTS ; - HL7 element array for the message header
 N ERRMSG ; -- error message returned from called HLO modules
 N HLBIEN ; -- HLO message subscript
 N MSG ; ----- HLO HL7 message pointer
 N IENS ; ---- subscripts to lab patient record
 N RELEASED ;- date/time the report was released
 N SEGNAME ; - segment names to be created
 N SEGELTS ; - HL7 element array for a single segment
 N SETID ; --- counters used for message segments
 N LABDATA ; - array to hold the data for GETS^DIQ call
 N ERROR ; --- error variable for GETS^DIQ call
 ;
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 ;
 ; is this a new case?  MAGNEWCASE set in LRAPLG1 before call to MAGTP005.
 I $G(MAGNEWCASE)=1 Q ERRSTAT ; ignore the first call for a new case
 ;
 I $G(LRDFN)="" Q ERRSTAT  ; P173 no/null LRDFN - just quit
 I $G(LRI)="" Q ERRSTAT  ; P173 no/null LRI - just quit
 I '$$ISLRSSOK^MAGT7MA($G(LRSS)) Q ERRSTAT  ; P173 AUtopsy(not supported AP section) - just quit
 ;
 I $$GET1^DIQ(63,LRDFN,.02)'="PATIENT" Q ERRSTAT  ; not in PATIENT file (#2)
 S DFN=$$GET1^DIQ(63,LRDFN,.03,"I")
 I 'DFN Q ERRSTAT  ; P173 Patient DFN not defined in LAB DATA (#63) file for LRDFN
 ;
 S MSHELTS("EVENT")="O21"
 S MSHELTS("MESSAGE STRUCTURE")="OML_O21"
 S MSHELTS("MESSAGE TYPE")="OML"
 S MSHELTS("VERSION")="2.5.1"
 S MSHELTS("COUNTRY")="USA"
 ;
 I '$$NEWMSG^HLOAPI(.MSHELTS,.MSG,.ERRMSG) S ERRSTAT="-2`HLO MESSAGE INITIALIZATION ERROR ("_ERRMSG_")" Q ERRSTAT
 ;
 ; get FILE information
 S ERRSTAT=$$GETFILE^MAGT7MA(LRSS) ; set FILE value
 Q:ERRSTAT ERRSTAT  ; quit and return the error
 ;
 S IENS=LRI_","_LRDFN_","
 S LABDATA=$NA(^TMP("MAG",$J,"LABDATA"))
 K @LABDATA
 D GETS^DIQ(FILE(0),IENS,"**","I",LABDATA,"ERROR")
 I $D(ERROR) D  Q "-1`ERROR IN GETS^DIQ CALL" ; ignore this error
 . N VARS
 . S VARS="ERROR^FILE(0)^IENS"
 . D ERROR^MAGT7MA("-2`ERROR IN GETS^DIQ CALL","BUILDHL7",VARS)
 . Q
 S ACNUMB=$G(@LABDATA@(FILE(0),IENS,.06,"I"))
 I ACNUMB="" Q "-2`Case not defined in LAB DATA (#63) file for """_LRSS_""" for IENS: """_IENS_""""
 ;
 ; lookup case in MAG PATH CASELIST file(#2005.42)
 I '$D(^MAG(2005.42,"B",ACNUMB)) Q 0 ; not an error, just skip the old case
 ;
 I STATE'="NEW" D
 . S COMPLETED=$$GET1^DIQ(FILE(0),IENS,.03,"I") ; date report completed
 . I COMPLETED S STATE="COMPLETED"
 . ;
 . S RELEASED=$$GET1^DIQ(FILE(0),IENS,.11,"I") ; date/time report released
 . I RELEASED D  ; change status of case in MAG PATH CASELIST (#2005.42)
 . . D STATUPDT^MAGTP005(ACNUMB,"READ")
 . . Q
 . I STATE="CANCELLED" D
 . . ; remove the case from the MAG PATH CASELIST (#2005.42) file
 . . D CANCEL^MAGTP005(ACNUMB)
 . . Q
 . Q
 ;
 D:'ERRSTAT  ; build segments if no error from previous call
 . F SEGNAME="PID","PV1","ORC","TQ1","OBR","NTE","TXT","SPM","IPC" D  Q:ERRSTAT
 . . S ERRSTAT=$$SEGADD^MAGT7S(.MSG,.FILE,LABDATA,STATE,SEGNAME,DFN,LRDFN,LRSS,LRI,IENS,ACNUMB) Q:ERRSTAT
 . . Q
 . Q
 D:'ERRSTAT
 . N WHOTO,PARMS ; --- HLO arrays
 . S PARMS("SENDING APPLICATION")="MAG TELEPATHOLOGY"
 . S WHOTO("RECEIVING APPLICATION")="DIGITAL PATHOLOGY SYSTEM"
 . S WHOTO("FACILITY LINK NAME")="MAG DPS"
 . S HLBIEN=$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERRMSG)
 . I 'HLBIEN D
 . . S ERRSTAT="-99`HLO MESSAGE QUEUEING ERROR ("_ERRMSG_")"
 . . Q
 . E  D  ; send this to the DICOM Gateway
 . . N FMDATE ;-- fileman date
 . . N FMDATETM ; fileman date/time
 . . N HLMSTATE ; HLO parameters used in OUTPUT^MAGDHOW2
 . . N MSGTYPE ;- HL7 message type
 . . S FMDATETM=$$NOW^XLFDT(),FMDATE=FMDATETM\1
 . . M HLMSTATE=MSG S MSGTYPE="OML"
 . . D OUTPUT^MAGDHOW2
 . . Q
 . Q
 K @LABDATA
 Q ERRSTAT
 ;
GETFILE(LRSS) ; get FILE information
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to report
 N IEN ; file 60 internal enter number
 ;
 K FILE
 I LRSS="CY" D
 . S FILE("NAME")="CYTOPATHOLOGY"
 . S FILE(0)=63.09
 . S FILE("FIELD")=9
 . S FILE("ORDERED TEST")=63.51
 . S FILE("SPECIMEN")=63.902
 . S FILE("SPECIMEN","SMEAR PREP")=63.9121
 . S FILE("SPECIMEN","SMEAR PREP","STAIN/PROCEDURE")=63.9122
 . S FILE("SPECIMEN","CELL BLOCK")=63.922
 . S FILE("SPECIMEN","CELL BLOCK","CELL BLOCK STAIN")=63.923
 . S FILE("SPECIMEN","MEMBRANE FILTER")=63.924
 . S FILE("SPECIMEN","MEMBRANE FILTER","MEMBRANE FILTER STAIN")=63.9241
 . S FILE("SPECIMEN","PREPARED SLIDES")=63.9024
 . S FILE("SPECIMEN","PREPARED SLIDES","PREPARED SLIDES STAIN")=63.90241
 . S FILE("SPECIMEN","CYTOSPIN")=63.9025
 . S FILE("SPECIMEN","CYTOSPIN","CYTOSPIN STAIN")=63.90251
 . S FILE("COMMENT")=63.908
 . S FILE("TIU REFERENCE")=63.47
 . S FILE("PARENT FILE")=63.09
 . S FILE("PROC/EVENT")=$O(^MAG(2005.85,"B","CYTOLOGY",""))
 . Q
 E  I LRSS="EM" D
 . S FILE("NAME")="ELECTRON MICROSCOPY"
 . S FILE(0)=63.02
 . S FILE("FIELD")=2
 . S FILE("ORDERED TEST")=63.52
 . S FILE("SPECIMEN")=63.202
 . S FILE("SPECIMEN","EPON BLOCK")=63.2021
 . S FILE("SPECIMEN","EPON BLOCK","EM PROCEDURE")=63.20211
 . S FILE("COMMENT")=63.208
 . S FILE("TIU REFERENCE")=63.49
 . S FILE("PARENT FILE")=63.02
 . S FILE("PROC/EVENT")=$O(^MAG(2005.85,"B","ELECTRON MICROSCOPY",""))
 . Q
 E  I LRSS="SP" D
 . S FILE("NAME")="SURGICAL PATHOLOGY"
 . S FILE(0)=63.08
 . S FILE("FIELD")=8
 . S FILE("ORDERED TEST")=63.53
 . S FILE("SPECIMEN")=63.812
 . S FILE("SPECIMEN","PARAFFIN BLOCK")=63.8121
 . S FILE("SPECIMEN","PARAFFIN BLOCK","STAIN/PROCEDURE")=63.8122
 . S FILE("SPECIMEN","PLASTIC BLOCK")=63.822
 . S FILE("SPECIMEN","PLASTIC BLOCK","PLASTIC STAIN/PROCEDURE")=63.823
 . S FILE("SPECIMEN","FROZEN TISSUE BLOCK")=63.824
 . S FILE("SPECIMEN","FROZEN TISSUE BLOCK","STAIN/PROCEDURE")=63.825
 . S FILE("COMMENT")=63.98
 . S FILE("TIU REFERENCE")=63.19
 . S FILE("PARENT FILE")=63.08
 . S FILE("PROC/EVENT")=$O(^MAG(2005.85,"B","SURGICAL PATHOLOGY",""))
 . Q
 E  S ERRSTAT="-1`Illegal AP section abbreviation: """_LRSS_""""
 ;
 D:'ERRSTAT ; get default procedure name, first one if multiple
 . N X
 . S IEN=0 F  S IEN=$O(^LAB(60,IEN)) Q:'IEN  D  Q:$D(FILE("PROCEDURE NAME"))
 . . S X=$G(^LAB(60,IEN,0))
 . . Q:$P(X,"^",4)'=LRSS ; SUBSCRIPT needs to match CY, EM, or SP
 . . Q:"IBO"'[$P(X,"^",3)  ; TYPE needs to be INPUT, OUTPUT, or BOTH
 . . Q:'$P($G(^LAB(60,IEN,64)),"^",1)  ; needs to have a VA National Lab Code (file #64)
 . . S FILE("PROCEDURE NAME")=$$GET1^DIQ(60,IEN,.01)
 . . S FILE("PROCEDURE IEN")=IEN
 . . Q
 . I '$D(FILE("PROCEDURE NAME")) D
 . . S ERRSTAT="-53`No test found in LAB(60) file for LRSS="""_LRSS_""""
 . . Q
 . Q
 ;
 Q ERRSTAT
 ;
REPORT ; main entry point - create HL7 order message for an elecronically signed report
 Q:'$$ISLRSSOK^MAGT7MA($G(LRSS))  ; check for supported anatomic pathology sections
 Q:'$G(LRDFN)
 N LRI,PARENTFILE,RETURN,X
 S LRI=$G(LRDATA(1)) Q:LRI=""  ;P173
 S PARENTFILE=$G(LRSF) Q:PARENTFILE=""  ;P173
 S X=$$NEWTIU(LRSS,PARENTFILE,LRDFN,LRI)
 S RETURN=$$BUILDHL7^MAGT7MA("COMPLETED")
 I RETURN D ERROR^MAGT7MA(RETURN,"REPORT")
 Q
 ;
CANCEL ; main entry point - create HL7 order message for a cancelled order
 Q:'$$ISLRSSOK^MAGT7MA(LRSS)  ; check for supported anatomic pathology sections
 ;
 N RETURN
 S RETURN=$$BUILDHL7^MAGT7MA("CANCELLED")
 I RETURN D ERROR^MAGT7MA(RETURN,"CANCEL")
 Q
 ;
NEWTIU(LRSS,PARENTFILE,LRDFN,LRI) ; check if this is a TIU note to be linked to an image group
 ; if so, create the cross-linkages now
 N CROSSREF,D0,FILEDATA,HIT,MAGGP,MAGIEN,NIMAGE,TIUIEN
 S HIT=0
 S D0=""
 F  S D0=$O(^MAG(2006.5838,"C",PARENTFILE,LRDFN,LRI,D0)) Q:'D0  D
 . S MAGGP=$P($G(^MAG(2006.5838,D0,0)),"^",4) Q:'MAGGP
 . S TIUIEN=$$TIUIEN(LRSS,LRDFN,LRI) Q:'TIUIEN
 . S $P(^MAG(2005,MAGGP,2),"^",6,7)="8925^"_TIUIEN
 . D TIUXLINK ; create the cross-linkages to TIU
 . ; update the parent file pointers for all the images
 . S CROSSREF="8925^"_TIUIEN_"^"_FILEDATA("PARENT FILE PTR")
 . S NIMAGE=0 F  S NIMAGE=$O(^MAG(2005,MAGGP,1,NIMAGE)) Q:'NIMAGE  D
 . . S MAGIEN=$P(^MAG(2005,MAGGP,1,NIMAGE,0),"^")
 . . S $P(^MAG(2005,MAGIEN,2),"^",6,8)=CROSSREF
 . . Q
 . ; remove entries from ^MAG(2006.5838) & decrement the counter
 . K ^MAG(2006.5838,D0),^MAG(2006.5838,"C",PARENTFILE,LRDFN,LRI,D0)
 . L +^MAG(2006.5838):1E9 ; Background process MUST wait
 . S $P(^MAG(2006.5838,0),"^",4)=$P(^MAG(2006.5838,0),"^",4)-1
 . L -^MAG(2006.5838)
 . S HIT=1
 . Q
 Q HIT
 ;
TIUXLINK ; create the cross-linkages to TIU EXTERNAL DATA LINK file
 N TIUXDIEN
 D PUTIMAGE^TIUSRVPL(.TIUXDIEN,TIUIEN,MAGGP)
 I TIUXDIEN D
 . S FILEDATA("PARENT FILE PTR")=TIUXDIEN
 . S $P(^MAG(2005,MAGGP,2),"^",8)=TIUXDIEN
 . Q
 E  D  ; fatal error
 . N MSG
 . S MSG(1)="ERROR ASSOCIATING WITH TIU EXTERNAL DATA LINK (file 8925.91): "
 . S MSG(2)=$P(TIUXDIEN,"^",2,999)
 . S MSG(3)=" for lookup in DICOM LAB TEMP LIST (file 2006.5838)."  ;P173
 . D ERR^MAGGTERR  ;P173
 . Q
 Q
 ;
TIUIEN(LRSS,LRDFN,LRI) ; lookup TIU reference
 N FILE ; ---- LAB DATA subfile numbers and other info
 N LABDATA ;-- array to hold LAB DATA (#63)
 N TIUIEN ;--- TIU file 8925 IEN value
 N TIUREF ;--- Anatomic Pathology reference file
 N ERROR ;---- error return for GETS^DIQ Filename API call
 N ERRSTAT S ERRSTAT=0 ; error status - assume nothing to repor
 ;
 S ERRSTAT=$$GETFILE^MAGT7MA(LRSS)
 I ERRSTAT<0 D  Q 0
 . D ERROR^MAGT7MA(ERRSTAT,"TIUIEN")
 . Q 
 ;
 S TIUREF=FILE("TIU REFERENCE")
 ; look up TIU note
 S IENS="1,"_LRI_","_LRDFN_","
 D GETS^DIQ(TIUREF,IENS,"**","I","LABDATA","ERROR")
 I $D(ERROR) D  Q 0
 . N VARS
 . S VARS="ERROR^TIUREF^IENS"
 . D ERROR^MAGT7MA("-2`ERROR IN GETS^DIQ CALL","TIUIEN",VARS)
 . Q
 S TIUIEN=$G(LABDATA(TIUREF,IENS,1,"I"))
 Q TIUIEN
 ;
ERROR(RETURN,TAG,VARS) ; log the error to the user's email
 N I,SUBJECT,MSG,VARIABLES
 S SUBJECT="Anatomic Pathology HL7 Generation"
 S MSG(1)="An error occurred in "_TAG_"^"_$T(+0)_" when trying to create and/or"
 S MSG(2)="send an HL7 message.  The error message is as follows:"
 S MSG(3)=""""_RETURN_""""
 S MSG(4)=""
 S MSG(5)="Please notify your local IRM Staff."
 S VARIABLES("LRDFN")=""
 S VARIABLES("LRI")=""
 S VARIABLES("LRSS")=""
 I $G(VARS)'="" F I=1:1:$L(VARS,"^") S VARIABLES($P(VARS,"^",I))=""
 D ERROR^MAGDHOWA(SUBJECT,.MSG,.VARIABLES)
 Q
 ;
ISLRSSOK(LRSS) ; Check for supported anatomic pathology sections
 ; So far we support only  CY, EM, or SP
 ; Return 1 - supported
 ;        0 - not supported
 Q LRSS?1(1"SP",1"CY",1"EM")
