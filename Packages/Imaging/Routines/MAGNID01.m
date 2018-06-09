MAGNID01 ;WOIFO/NST - DELETE IMAGES RPCS ; 28 Jul 2017 11:43 AM
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
 ;***** DELETE IMAGES BY IEN
 ;
 ; RPC: MAGN DELETE IMAGES BY IEN
 ;
 ; .MAGOUT       Reference to a local variable where the results are returned to
 ; .MAGPARAM
 ;    MAGPARAM(1..n)=IMAGE IEN^GROUP DELETE FLAG (0|1)^REASON
 ;
 ; Return Values
 ; =============   
 ; MAGOUT(1..n) = Image IEN^1^SUCCESS 
 ;                Image IEN^0^reason for failure
DELIMGS(MAGOUT,MAGPARAM) ;RPC [MAGN DELETE IMAGES BY IEN]
 N MAGNI,MAGGRY,MAGNIEN,MAGNGDF,MAGNRSN
 S MAGOUT=$NA(^TMP($J,"MAGNID01"))
 K @MAGOUT
 ;
 S MAGNI=""
 F  S MAGNI=$O(MAGPARAM(MAGNI)) Q:MAGNI=""  D
 . S MAGNIEN=$P(MAGPARAM(MAGNI),"^",1)  ; Image IEN
 . S MAGNGDF=$P(MAGPARAM(MAGNI),"^",2)  ; Group delete flag
 . S MAGNRSN=$P(MAGPARAM(MAGNI),"^",3)  ; Reason
 . K MAGGRY
 . D IMAGEDEL^MAGGTID(.MAGGRY,MAGNIEN,MAGNGDF,MAGNRSN)
 . I ($P(MAGGRY(0),"^")=1)!($P(MAGGRY(0),"^")=0) S @MAGOUT@(MAGNI)=MAGNIEN_"^"_MAGGRY(0)
 . E  S @MAGOUT@(MAGNI)=MAGNIEN_"^0^"_MAGGRY(0)
 . Q
 Q
