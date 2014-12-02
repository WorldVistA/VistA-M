MAGFXQRS ;WOIFO/MLH - clean up headers in ^MAGDAUDT(2006.5733); 31-Jan-2012 19:27
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
 ; This routine resolves issues in ^MAGDAUDT(2006.5733), whose header node
 ; and subnodes all formerly contained incorrect values in the file number
 ; portion of the header (e.g., '2006.57633' instead of '2006.5733').
 ; 
 Q
 ;
CLEANUP ;
 N FIL,FMDT,MAGIEN,ACTIX
 S FIL=$NA(^MAGDAUDT(2006.5733))
 L +@FIL:5 E  D  Q
 . W:$D(IO(0)) !,"ERROR: Could not lock statistics file!",!
 . Q
 W:$D(IO(0)) !,"Correcting headers on QUERY/RETRIEVE STATISTICS file (#2006.5733)..."
 S $P(@FIL@(0),"^",2)=2006.5733
 S FMDT=0
 F  S FMDT=$O(@FIL@(FMDT)) Q:'FMDT  D
 . S $P(@FIL@(FMDT,0),"^",2)=2006.57331
 . S MAGIEN=0
 . F  S MAGIEN=$O(@FIL@(FMDT,1,MAGIEN)) Q:'MAGIEN  D
 . . S $P(@FIL@(FMDT,1,MAGIEN,1,0),"^",2)=2006.57332
 . . S ACTIX=0
 . . F  S ACTIX=$O(@FIL@(FMDT,1,MAGIEN,1,ACTIX)) Q:'ACTIX  D
 . . . S $P(@FIL@(FMDT,1,MAGIEN,1,ACTIX,1,0),"^",2)=2006.57333
 . . . Q
 . . Q
 . Q
 W:$D(IO(0)) "done!"
 L -@FIL
 Q
