MAGSIXG4 ;WOIFO/SG - LIST OF IMAGES RPCS (POST-PROCESSING) ; 4/6/09 1:49pm
 ;;3.0;IMAGING;**93**;Dec 02, 2009;Build 163
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; 
 ; LOCAL VARIABLE ------ DESCRIPTION
 ;
 ; MAGDATA(              Closed root of the result array
 ;
 ;   "MAXNUM")           If the value of this node is greater than 0, 
 ;                       then it determines the maximum number of
 ;                       images returned by the query. See the MAXNUM 
 ;                       parameter of the GETIMGS^MAGSIXG1.
 ;
 ;   "RESCNT")           Counter of image entries in the result array
 ;
 ;   "CAPTAPP",...)
 ;   "CLS",...)
 ;   "EVT",...)
 ;   "FLAGS")
 ;   "GDESC",...)
 ;   "IDFN")
 ;   "ISTAT",...)
 ;   "ORIG",...)
 ;   "PKG",...)
 ;
 ;   "PREVPT")           IEN of the patient who the previous image was
 ;                       associated with.
 ;
 ;   "SAVEDBY")
 ;   "SENSIMG",...)
 ;   "SPEC",...)
 ;
 ;   "SUBSET%")          Percentage of preselected image entries
 ;                       returned by the sparse subset query. See the
 ;                       S flag of the GETIMGS^MAGSIXG1 for details.
 ;
 ;   "TCNT")             Total number of preselected image entries.
 ;
 ;   "TYPE",...)
 ;
 ;   Nodes PREVPT, SUBSET%, and TCNT exist only during sparse subset
 ;   queries. See the S flag of the GETIMGS^MAGSIXG1 for details.
 ;
 ; TEMPORARY GLOBAL ---- DESCRIPTION
 ;
 ; ^TMP("MAGSIXG3",$J,
 ;
 ;   "P",                BUFFER FOR "PRIORITY" IMAGE ENTRIES
 ;     Counter,          Image info
 ;                         |01: Counter
 ;                         |02: Image IEN
 ;                         |03: Group counters ($$GRPCT^MAGGI14)
 ;       0)              Image descriptor
 ;
 ;   "R",                BUFFER FOR REGULAR IMAGE ENTRIES
 ;     Seq#,             Image info
 ;                         |01: Counter
 ;                         |02: Image IEN
 ;                         |03: Group counters ($$GRPCT^MAGGI14)
 ;       0)              Image descriptor
 ;
 Q
 ;
 ;+++++ POST-PROCESSING FOR THE SPARSE SUBSET QUERY
 ;
 ; Input Variables
 ; ===============
 ;   MAGDATA, ^TMP("MAGSIXG3",$J,...)
 ;
 ; Output Variables
 ; ================
 ;   MAGDATA, MAGOUT
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  Success
 ;           >0  Success; not all "priority" records are returned
 ;
SUBSET() ;
 Q:$G(MAGDATA("TCNT"))'>0 0
 N FLTX,I,IIFLAGS,MORE,PCNT,RC,RCNT,TMP
 S RC=0
 ;
 ;--- Get the nuber of images in temporary buffers
 S RCNT=+$O(^TMP("MAGSIXG3",$J,"R",""),-1)  ; Regular
 S PCNT=MAGDATA("TCNT")-RCNT                ; "Priority"
 ;
 ;--- Calculate the maximum number of images (requested percentage)
 S TMP=MAGDATA("TCNT")*$G(MAGDATA("SUBSET%"))/100
 S MAGDATA("MAXNUM")=$J(TMP,0,0)
 S:MAGDATA("MAXNUM")<1 MAGDATA("MAXNUM")=1
 S MORE=(PCNT>MAGDATA("MAXNUM"))
 ;
 ;--- Merge images from the regular buffer to the "priority" one
 ;--- to fill the latter up to MAXNUM entries.
 I PCNT<MAGDATA("MAXNUM"),RCNT>0  D  Q:RC<0 RC
 . N RSV,STEP
 . S STEP=RCNT/(MAGDATA("MAXNUM")-PCNT)  S:STEP<1 STEP=1
 . F RSV=1:STEP:RCNT  S I=RSV\1  D  Q:RC
 . . S TMP=$P($G(^TMP("MAGSIXG3",$J,"R",I)),"|")
 . . I TMP>0,'$D(^TMP("MAGSIXG3",$J,"P",TMP))  D  Q
 . . . M ^TMP("MAGSIXG3",$J,"P",TMP)=^TMP("MAGSIXG3",$J,"R",I)
 . . . K ^TMP("MAGSIXG3",$J,"R",I)
 . . . Q
 . . S RC=$$ERROR^MAGUERR(-47)  ; This should never happen!
 . . Q
 . Q
 ;
 ;--- Copy selected image entries to the result array
 S IIFLAGS=$$TRFLAGS^MAGUTL05(MAGDATA("FLAGS"),"DE")
 S I=""
 F  S I=$O(^TMP("MAGSIXG3",$J,"P",I))  Q:I=""  D  Q:RC
 . I MAGDATA("RESCNT")'<MAGDATA("MAXNUM")  S RC=1  Q
 . S TMP=^TMP("MAGSIXG3",$J,"P",I),FLTX=^(I,0)
 . S RC=$$APPEND^MAGSIXG3($P(TMP,"|",2),FLTX,$P(TMP,"|",3),IIFLAGS)
 . Q
 ;---
 Q $S(RC<0:RC,1:MORE)
