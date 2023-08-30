MAGVRS07 ;WOIFO/MLH - RPC calls for DICOM file processing ; 15 Apr 2010 4:05 PM
 ;;3.0;IMAGING;**118,278**;Mar 19, 2002;Build 138
 ;; Per VA Directive 6402, this routine should not be modified.
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
GETPROC(OUT,PROCIEN,STUDYIEN,OVERRIDE) ;RPC - get study data
 D REFRESH^MAGVRS41(.OUT,2005.62,STUDYIEN,$G(PROCIEN),$G(OVERRIDE))
 Q
INPROC(OUT,PROCIEN,PATIEN,OVERRIDE) ;RPC - inactivate a procedure
 D INACTIVT^MAGVRS41(.OUT,2005.61,PROCIEN,$G(PATIEN),$G(OVERRIDE))
 Q
FINDPROC(OUT,PROCATTS) ;RPC - find a procedure given attributes
 D STATUS(.PROCATTS)
 D FINDBYAT^MAGVRS42(.OUT,2005.61,.PROCATTS)
 Q
STATUS(PROCATTS) ; STATUS is required; add "STATUS`A" if not passed in
 N ATT,FOUND
 S (ATT,FOUND)=0
 F  S ATT=$O(PROCATTS(ATT)) Q:'ATT!FOUND  D
 . I $P(PROCATTS(ATT),"`")="STATUS" S FOUND=1
 ; STATUS was passed in, don't override
 Q:FOUND
 ; Find the highest/last attribute subscript
 S ATT="" F  S ATT=$O(PROCATTS(ATT),-1) Q:ATT=""!$G(ATT)
 ; Quit if no attributes
 Q:'ATT
 ; Default to procedures having STATUS=ACCESSIBLE
 S PROCATTS(ATT+1)="STATUS`A"
 Q
