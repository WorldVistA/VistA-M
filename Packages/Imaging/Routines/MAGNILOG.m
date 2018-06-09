MAGNILOG ;WOIFO/NST - LOG ACTION on IMAGES RPCS ; 14 Sep 2017 11:43 AM
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
 ;***** MAGN LOG IMAGE ACCESS BY IEN
 ;
 ; RPC: MAGN LOG IMAGE ACCESS BY IEN
 ;
 ; .MAGOUT       Reference to a local variable where the results are returned to
 ; .MAGPARAM
 ;    MAGPARAM(0..n)=IMAGE IEN^DATA
 ;      See LOGACT^MAGGTU6 for details on DATA
 ;
 ; Return Values
 ; =============   
 ; MAGOUT(0..n) = Image IEN^1^SUCCESS 
 ;                Image IEN^0^reason for failure
LOGACT(MAGOUT,MAGPARAM) ;RPC [MAGN LOG IMAGE ACCESS BY IEN]
 N MAGNI,MAGGRY,MAGNIEN,MAGDATA
 S MAGOUT=$NA(^TMP($J,"MAGNILOG"))
 K @MAGOUT
 ;
 S MAGNI=""
 F  S MAGNI=$O(MAGPARAM(MAGNI)) Q:MAGNI=""  D
 . S MAGNIEN=$P(MAGPARAM(MAGNI),U)
 . S MAGDATA=$P(MAGPARAM(MAGNI),U,2,99)
 . K MAGGRY
 . D LOGACT^MAGGTU6(.MAGGRY,MAGDATA)
 . I ($P(MAGGRY,"^")=1)!($P(MAGGRY,"^")=0) S @MAGOUT@(MAGNI)=MAGNIEN_"^"_MAGGRY
 . E  S @MAGOUT@(MAGNI)=MAGNIEN_"^0^"_MAGGRY
 . Q
 Q
