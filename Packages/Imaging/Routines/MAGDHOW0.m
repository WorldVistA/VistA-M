MAGDHOW0 ;WOIFO/PMK,DAC - Capture Consult/Request data ; 10 Oct 2016 3:30 PM
 ;;3.0;IMAGING;**138,174**;Mar 19, 2002;Build 30
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
 ;
 ;
 Q
 ;
FINDSEG(ARRAY,SEGMENT,I,X) ; find a specific HL7 segment in an array
 ; input -- ARRAY ---- an HL7 array
 ; input -- SEGMENT -- three-letter HL7 segment identifier 
 ; input -- I -------- index of the found segment (or null)
 ; output - I -------- index of the found segment (or null)
 ; output - X -------- string of fields sans segment identifier
 ; return - HIT ------ flag indicating segment found 
 ;
 N HIT
 S HIT=0
 F  S I=$O(ARRAY(I)) Q:I=""  I $P(ARRAY(I),DEL)=SEGMENT D  Q
 . S X=$P(ARRAY(I),DEL,2,99999) ; strip off the segment name
 . S HIT=1
 . Q
 Q HIT
 ;
NEWTIU(GMRCIEN) ; check if this is a TIU note to be linked to an image group
 ; if so, create the cross-linkages now
 N CROSSREF,D0,FILEDATA,HIT,MAGGP,MAGIEN,NIMAGE,TIUIEN
 S HIT=0
 S D0=""
 F  S D0=$O(^MAG(2006.5839,"C",123,GMRCIEN,D0)) Q:'D0  D
 . S MAGGP=$P($G(^MAG(2006.5839,D0,0)),"^",3) Q:'MAGGP
 . S TIUIEN=$$TIULAST^MAGDGMRC(GMRCIEN) Q:'TIUIEN
 . S $P(^MAG(2005,MAGGP,2),"^",6,7)="8925^"_TIUIEN
 . D TIUXLINK ; create the cross-linkages to TIU
 . ; update the parent file pointers for all the images
 . S CROSSREF="8925^"_TIUIEN_"^"_FILEDATA("PARENT FILE PTR")
 . S NIMAGE=0 F  S NIMAGE=$O(^MAG(2005,MAGGP,1,NIMAGE)) Q:'NIMAGE  D
 . . S MAGIEN=$P(^MAG(2005,MAGGP,1,NIMAGE,0),"^")
 . . S $P(^MAG(2005,MAGIEN,2),"^",6,8)=CROSSREF
 . . Q
 . ; remove entries from ^MAG(2006.5839) & decrement the counter
 . K ^MAG(2006.5839,D0),^MAG(2006.5839,"C",123,GMRCIEN,D0)
 . L +^MAG(2006.5839):1E9 ; Background process MUST wait
 . S $P(^MAG(2006.5839,0),"^",4)=$P(^MAG(2006.5839,0),"^",4)-1
 . L -^MAG(2006.5839)
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
 . S MSG(1)="ERROR ASSOCIATING WITH TIU EXTERNAL DATA LINK (file 8925.91):"
 . S MSG(2)=$P(TIUXDIEN,"^",2,999)
 . S MSG(3)=" for lookup in DICOM GMRC TEMP LIST (file 2006.5839)."
 . D ERR^MAGGTERR ; P174 DAC - Error trap call fix
 . Q
 Q
