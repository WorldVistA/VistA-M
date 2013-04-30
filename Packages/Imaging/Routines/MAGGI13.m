MAGGI13 ;WOIFO/SG/BNT/NST/GEK/JSL - IMAGE FILE API (QUERY) ; 21 Jul 2010 11:05 AM
 ;;3.0;IMAGING;**93,117,122**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;P122 : Stop Timeout error from QA Review window.
 ;       Modified tag : QUERY,  to now use ADTDUZ Cross reference 
 ;       when searching for images captured by a User.
 ;       Remedy _<todo, get remedy ticket>
 Q
 ;
 ;+++++ RETURNS INVERTED/REVERSED DATE/TIME (FILEMAN)
INVDT(DATETIME) ;
 Q 9999999.9999-DATETIME
 ;
 ;##### $ORDER BOTH #2005 AND #2005.1 FILES AT THE SAME TIME
 ;
 ; NODE          Name of a node in file #2005 or #2005.1 (it does
 ;               not matter in which one if the BOTH parameter is
 ;               not zero). The last subscript can be empty string.
 ;
 ; [DIR]         Browsing direction:
 ;                 $G(DIR)'<0  forward
 ;                 DIR<0       backward
 ;
 ; [BOTH]        If this parameter is defined and not zero, then
 ;               the MAGORD browses subscripts of IMAGE (#2005) and
 ;               IMAGE AUDIT (2005.1) files at the same time (as if
 ;               the nodes were merged into a single array).
 ;               Otherwise, it works as the $ORDER function.
 ;
 ; Return Values
 ; =============
 ;           ""  No more records
 ;               Next/previous subscript (in #2005, #2005.1, or both)
 ;
 ; Notes
 ; =====
 ;
 ; This function relies on the fact that there are no records with
 ; the same IENs in the files #2005 and #2005.1.
 ;
MAGORD(NODE,DIR,BOTH) ;
 Q:NODE'?1"^MAG(2005".1".1"1","1.E1")" ""
 N FILE,LST,PI,SUBS,TRAIL
 S DIR=$S($G(DIR)<0:-1,1:1)
 Q:'$G(BOTH) $O(@NODE,DIR)
 ;--- Find subscripts in both files that follow the @NODE
 S TRAIL=","_$P(NODE,",",2,999)
 F FILE=2005,2005.1  D
 . S PI="^MAG("_FILE_TRAIL,SUBS=$O(@PI,DIR)
 . S:SUBS'="" LST(SUBS,FILE)=""
 . Q
 ;--- Return one of the subscripts according to the direction
 Q $O(LST(""),DIR)
 ;
 ;+++++ CHECKS THE PATIENT REFERENCE
 ;
 ; IMGIEN        Internal entry number of the image entry
 ;
 ; DFN           Patient IEN (DFN)
 ;
 ; Return Values
 ; =============
 ;            0  Skip the image entry (different patient or error)
 ;            1  Process the image entry
 ;
PTCHK(IMGIEN,DFN) ;
 N NODE  S NODE=$$NODE^MAGGI11(IMGIEN)
 Q $S(NODE'="":$P($G(@NODE@(0)),U,7)=DFN,1:0)
 ;
 ;##### BROWSES IMAGES AND CALLS THE CALLBACK FUNCTION
 ;
 ; CALLBACK      Full name of the callback function ($$TAG^ROUTINE)
 ;               that is called for each preselected image.
 ;
 ;               SINCE ENTRIES THAT ARE NOT MARKED AS DELETED CAN
 ;               REFERENCE DELETED "CHILDREN", SUCH ENTRIES ARE PASSED
 ;               TO THE CALLBACK FUNCTION EVEN IF ONLY DELETED IMAGES
 ;               ARE REQUESTED! THEREFORE, THE FUNCTION MUST PERFORM
 ;               ADDITIONAL SCREENING BY CHECKING THE "CHILD" ENTRIES.
 ;
 ;               The function should accept 3 parameters:
 ;
 ;                 IMGIEN     IEN of the image record
 ;                            (file #2005 or #2005.1)
 ;
 ;                 FLAGS      Value of the FLAGS parameter of the
 ;                            $$QUERY function (see below).
 ;
 ;                 .DATA      Reference to the local array passed via
 ;                            the MAG8DATA parameter of the $$QUERY
 ;                            function (see below).
 ;
 ;               Non-zero result values of the callback function
 ;               terminate the query:
 ;
 ;                 <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;                  0  Continue
 ;                 >0  Terminate the query (e.g. if maximum number of 
 ;                     returned records has been reached)
 ;
 ;               See the source code of the IMGQUERY^MAGGA03 and
 ;               $$QRYCBK^MAGGA03 for an example.
 ;
 ; FLAGS         Flags that control the execution (can be combined):
 ;
 ;                 C  Capture date range. If this flag is provided,
 ;                    then the remote procedure uses values of the
 ;                    MAG8FROM and MAG8TO parameters to select images
 ;                    that were captured in this date range (see the
 ;                    DATE/TIME IMAGE SAVED field (7) and the "AD"
 ;                    cross-reference).
 ;
 ;                    Otherwise, values of those parameters are
 ;                    treated as the date range when procedures were
 ;                    performed (see the PROCEDURE/EXAM DATE/TIME
 ;                    field (15) and cross-references "APDTPX" and
 ;                    "APDT").
 ;
 ;                 G  Include Group Images in the list of images returned. 
 ;                    If any image in a group has an image that matches the 
 ;                    status provided in the search criteria then 
 ;                    the group will be returned.
 ;                    
 ;                    If the G flag is not set then only the status of the 
 ;                    Group entry will be checked and the group will be 
 ;                    returned if it passes.
 ;                    
 ;                 D  Include only deleted images (file #2005.1)
 ;
 ;                 E  Include only existing images (file #2005)
 ;
 ;               If neither 'E' nor 'D' flag is provided, then an
 ;               error code is returned.
 ;
 ; [.MAG8DATA]   Reference to a local array that is passed to the
 ;               callback function (by reference) "as is"
 ;
 ; [MAG8FROM]    Date/time range for image selection. Parameter
 ; [MAG8TO]      values should be valid date/times in internal or
 ;               external FileMan format. If a parameter is not
 ;               defined or empty, then the range remains open on
 ;               the corresponding side.
 ;
 ;               The beginning of the date/time range is included
 ;               the search but the end is not! For example, if you
 ;               need images for October 15, 2007, the internal
 ;               parameter values should be 3071015 and 3071016.
 ;
 ;               If the MAG8FROM is after the MAG8TO, then values
 ;               of the parameters are swapped.
 ;
 ; [DFN]         Patient IEN (DFN). If this parameter is defined and
 ;               greater than 0, then only images associated with this
 ;               patient are processed.
 ;
 ; Return Values
 ; =============
 ;           <0  Error descriptor (see the $$ERROR^MAGUERR)
 ;            0  All appropriate image records have been processed
 ;           >0  Value returned by the callback function when it
 ;               terminated the query
 ;
 ; Notes
 ; =====
 ;
 ; Temporary global node ^TMP($J,"MAGGI13") is used by this function.
 ;
QUERY(CALLBACK,FLAGS,MAG8DATA,MAG8FROM,MAG8TO,DFN) ;
 N MAG8BOTH,MAG8CALL,MAG8DT,MAG8IEN,MAG8RC,MAG8ROOT,MAG8XREF,TMP
 ;P122
 N MAG8APP,MAG8DUZ,MAG8SITE,BOTHAPP
 ;
 S FLAGS=$G(FLAGS)
 ;=== Validate parameters
 Q:'(CALLBACK?2"$"1.8UN1"^MAG"1.5UN) $$IPVE^MAGUERR("CALLBACK")
 ;--- If a patient IEN is provided, it must be valid
 I $G(DFN)>0,'$$VALDFN^MAGUTL05(DFN,.TMP)  D STORE^MAGUERR(TMP)  Q TMP
 ;--- Unknown/Unsupported flag(s)
 Q:$TR(FLAGS,"CDEG")'="" $$IPVE^MAGUERR("FLAGS")
 ;--- Missing required flag
 Q:$TR(FLAGS,"DE")=FLAGS $$ERROR^MAGUERR(-6,,"D,E")
 ;
 ;=== The expression in the following line does not look like
 ;    (FLAGS["E")&(FLAGS["D") because a group header that is
 ;=== not marked as deleted can reference deleted "children".
 S MAG8BOTH=(FLAGS["D")
 S TMP=$S(FLAGS["E":2005,1:2005.1),MAG8ROOT=$NA(^MAG(TMP))
 S TMP=$$DDQ^MAGUTL05(FLAGS)
 S MAG8CALL="S MAG8RC="_CALLBACK_"(MAG8IEN,"_TMP_",.MAG8DATA)"
 S MAG8RC=0
 ;P122 set a variable (MAG8DUZ) to $Order through the Cross Ref.
 S MAG8DUZ=+$P($G(MAG8DATA("SAVEDBY")),"^",1)
 ;=== Return images in the capture date range captured by a User MAG8DUZ
 ;    This call is made by the QA Review window.  Looking for a list of images
 ;    captured by a certain user in a certain date range.
 I (FLAGS["C"),(MAG8DUZ) D  Q MAG8RC
 . ;--- Modify the callback to check for patient
 . S:$G(DFN)>0 $E(MAG8CALL,1)="S:$$PTCHK(MAG8IEN,"_DFN_")"
 . ;---
 . ; ATDUZ may be used by more than QA Review,  can't Force MAG8BOTH
 . ; to '0', Deleted Images may be wanted by other functions.
 . ;- S MAG8BOTH=0
 . ; Loop through both Capture Application nodes of  ADTDUZ
 . F MAG8APP="C","I" D
 . . S MAG8XREF=$NA(@MAG8ROOT@("ADTDUZ",MAG8APP))
 . . S MAG8DT=MAG8TO
 . . F  S MAG8DT=$$MAGORD($NA(@MAG8XREF@(MAG8DT)),-1,MAG8BOTH)  Q:(MAG8DT="")!(MAG8DT<MAG8FROM)  D  Q:MAG8RC
 . . . S MAG8SITE=""
 . . . F  S MAG8SITE=$$MAGORD($NA(@MAG8XREF@(MAG8DT,MAG8DUZ,MAG8SITE)),-1,MAG8BOTH) Q:(MAG8SITE="")  D
 . . . . S MAG8IEN=""
 . . . . F  D  Q:(MAG8IEN="")!MAG8RC  X MAG8CALL  Q:MAG8RC
 . . . . . S MAG8IEN=$$MAGORD($NA(@MAG8XREF@(MAG8DT,MAG8DUZ,MAG8SITE,MAG8IEN)),-1,MAG8BOTH)
 . . . . . I $D(ZTQUEUED),$$S^%ZTLOAD S MAG8RC="1^Task asked to stop",ZTSTOP=1
 . . . . . Q
 . . . . Q
 . . Q
 . Q
 ;=== Browse images in the capture date range
 I FLAGS["C"  D  Q MAG8RC
 . ;--- Modify the callback to check for patient
 . S:$G(DFN)>0 $E(MAG8CALL,1)="S:$$PTCHK(MAG8IEN,"_DFN_")"
 . ;---
 . S MAG8XREF=$NA(@MAG8ROOT@("AD"))
 . S MAG8DT=MAG8TO
 . F  S MAG8DT=$$MAGORD($NA(@MAG8XREF@(MAG8DT)),-1,MAG8BOTH)  Q:(MAG8DT="")!(MAG8DT<MAG8FROM)  D  Q:MAG8RC
 . . S MAG8IEN=""
 . . F  D  Q:(MAG8IEN="")!MAG8RC  X MAG8CALL  Q:MAG8RC
 . . . S MAG8IEN=$$MAGORD($NA(@MAG8XREF@(MAG8DT,MAG8IEN)),-1,MAG8BOTH)
 . . . I $D(ZTQUEUED),$$S^%ZTLOAD S MAG8RC="1^Task asked to stop",ZTSTOP=1
 . . . Q
 . . Q
 . Q
 ;
 ;=== Browse images in the procedure date range; single patient
 I $G(DFN)>0  D  Q MAG8RC
 . N MAG8DT1,MAG8DT2,MAG8PRX,MAG8TMP
 . S MAG8XREF=$NA(@MAG8ROOT@("APDTPX",+DFN))
 . S MAG8TMP=$NA(^TMP("MAGGI13",$J))
 . ;--- "Invert" the dates
 . S MAG8DT1=$$INVDT(MAG8TO),MAG8DT2=$$INVDT(MAG8FROM)
 . ;---
 . S MAG8DT=MAG8DT1
 . F  S MAG8DT=$$MAGORD($NA(@MAG8XREF@(MAG8DT)),1,MAG8BOTH)  Q:(MAG8DT="")!(MAG8DT>MAG8DT2)  D  Q:MAG8RC
 . . K @MAG8TMP
 . . I $D(ZTQUEUED),$$S^%ZTLOAD S MAG8RC="1^Task asked to stop",ZTSTOP=1 Q
 . . ;--- Merge IEN lists from both files
 . . S MAG8PRX=""
 . . F  S MAG8PRX=$$MAGORD($NA(@MAG8XREF@(MAG8DT,MAG8PRX)),1,MAG8BOTH)  Q:MAG8PRX=""  D
 . . . S MAG8IEN=""
 . . . F  S MAG8IEN=$$MAGORD($NA(@MAG8XREF@(MAG8DT,MAG8PRX,MAG8IEN)),1,MAG8BOTH)  Q:MAG8IEN=""  D
 . . . . S @MAG8TMP@(MAG8IEN)=""
 . . . . Q
 . . ;--- Browse the list and select the images
 . . S MAG8IEN=""
 . . F  D  Q:(MAG8IEN'>0)!MAG8RC  X MAG8CALL  Q:MAG8RC
 . . . S MAG8IEN=$O(@MAG8TMP@(MAG8IEN),-1)
 . . . I $D(ZTQUEUED),$$S^%ZTLOAD S MAG8RC="1^Task asked to stop",ZTSTOP=1
 . . . Q
 . . Q
 . ;---
 . K @MAG8TMP
 . Q
 ;
 ;=== Browse images in the procedure date range; all patients
 S MAG8XREF=$NA(@MAG8ROOT@("APDT"))
 S MAG8DT=MAG8TO
 F  S MAG8DT=$$MAGORD($NA(@MAG8XREF@(MAG8DT)),-1,MAG8BOTH)  Q:(MAG8DT="")!(MAG8DT<MAG8FROM)  D  Q:MAG8RC
 . S MAG8IEN=""
 . F  D  Q:(MAG8IEN="")!MAG8RC  X MAG8CALL  Q:MAG8RC
 . . S MAG8IEN=$$MAGORD($NA(@MAG8XREF@(MAG8DT,MAG8IEN)),-1,MAG8BOTH)
 . . I $D(ZTQUEUED),$$S^%ZTLOAD S MAG8RC="1^Task asked to stop",ZTSTOP=1
 . . Q
 . Q
 ;---
 Q MAG8RC
