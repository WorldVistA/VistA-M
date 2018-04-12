MAGNISET ;WOIFO/NST - UPDATES IMAGES RPCS ; 12 Sep 2017 11:43 AM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 92;Aug 02, 2012
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
 ;***** Updates one or more image properties
 ;
 ; RPC: MAGN SET IMAGES PROPS BY IEN
 ;
 ; .MAGOUT       Reference to a local variable where the results are returned to
 ; .MAGPARAM
 ;    MAGPARAM(0..n)=IMAGE IEN^Parameter name^Value
 ;
 ; Return Values
 ; =============   
 ; MAGOUT(0..n) = IMAGE IEN^1^Ok
 ;                IMAGE IEN^0^reason for failure
 ;
 ; Note: See RPC [MAGG IMAGE SET PROPERTIES] for more details
 ;
SETIMGS(MAGOUT,MAGPARAM) ;RPC [MAGN SET IMAGES PROPS BY IEN]
 N MAGNI,MAGGRY,MAGNIEN,FLAGS,PROPVALS
 K MAGOUT
 ;
 S MAGNI=""
 F  S MAGNI=$O(MAGPARAM(MAGNI)) Q:MAGNI=""  D
 . S MAGNIEN=$P(MAGPARAM(MAGNI),"^",1)  ; Image IEN
 . S PROPVALS(1)=$P(MAGPARAM(MAGNI),"^",2)_"^^"_$P(MAGPARAM(MAGNI),"^",3)
 . S FLAGS=$P(MAGPARAM(MAGNI),"^",4)    ; Flags
 . K MAGGRY
 . D SETPROPS^MAGGA02(.MAGGRY,MAGNIEN,FLAGS,.PROPVALS)
 . S MAGOUT(MAGNI)=MAGNIEN_"^"_MAGGRY(0)
 . Q
 Q
