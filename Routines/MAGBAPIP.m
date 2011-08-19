MAGBAPIP ;WOIFO/MLH - Background Processor API to build queues - Modules for place
 ;;3.0;IMAGING;**1,7,8,20,59**;Nov 27, 2007;Build 20
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
DUZ2PLC(WARN) ;Convert DUZ to a PLACE. File 2006.1 entry (PLACE)
 ; Extrinsic : Always returns a PLACE
 ; WARN          : message about where the PLACE was derived from.
 ; Compute the Users Institution for older versions of Imaging Display workstation.
 ; This is called when DUZ(2) doesn't exist Or Can't resolve DUZ(2)
 ;  into site param entry.  This solved a GateWay Problem where DUZ(2) didn't
 ;  exist.  - Shouldn't get here anymore, that was fixed.
 N MAGINST,DIVDTA,PLACE
 S MAGINST=0
 D GETS^DIQ(200,DUZ,"16*","I","DIVDTA") ; look up Division field
 ;                                 ? Any division data on file for this user
 I $D(DIVDTA) D  ; yes, use it
 . S MAGINST=@$Q(DIVDTA),WARN="Using first Division of New Person File."
 . Q
 E  D  ;                   no, use default site param?
 . S MAGINST=$$KSP^XUPARAM("INST"),WARN="Using Kernel Site Param default entry." Q
 . Q
 S PLACE=$$GETPLACE^MAGBAPI(+$$PLACE^MAGBAPI(MAGINST))
 I 'PLACE S PLACE=$O(^MAG(2006.1,0)),WARN="Using First Site Param entry."
 Q PLACE
 ;
DA2PLC(MAGDA,TYPE) ; Get Place from Image File IEN
 ; TYPE :        Possible values "A" Abstract, "F" Full Res or "B" Big File
 ; (defaults to "F" if null)
 ; Resolve Place (PLC) using the Acquisition Site field (ACQS)
 ; IF ACQS is null or not doesn't exist in the site parameter file
 ; THEN Resolve PLC using NetWork Location pointer
 ; 
 N MAGREF,MAG0,FBIG,SITE,PLC,MAGJB
 I '$G(MAGDA) Q 0
 S SITE=$P($G(^MAG(2005,MAGDA,100)),U,3)
 I SITE S PLC=$$PLACE^MAGBAPI(SITE) Q:PLC PLC
 ; p59  Stop the error when an Image is Deleted.
 S MAG0=$G(^MAG(2005,MAGDA,0)) Q:MAG0="" 0
 ;
 S TYPE=$E($G(TYPE)_"F",1)
 I "AF"[TYPE D
 . S MAGREF=$S(TYPE="A":+$P(MAG0,"^",4),1:+$P(MAG0,"^",3))
 . I MAGREF=0 S MAGJB=1,MAGREF=+$P(MAG0,"^",5) ; get file from jukebox
 I "B"[TYPE D
 . S FBIG=$G(^MAG(2005,MAGDA,"FBIG"))
 . S MAGREF=+$P(FBIG,"^") ; get file from magnetic disk, if possible
 . I MAGREF=0 S MAGREF=+$P(FBIG,"^",2) ; get file from jukebox
 I 'MAGREF Q 0
 I '$D(^MAG(2005.2,MAGREF,0)) Q 0
 Q $$GETPLACE^MAGBAPI(+$$GET1^DIQ(2005.2,MAGREF,.04,"I"))
