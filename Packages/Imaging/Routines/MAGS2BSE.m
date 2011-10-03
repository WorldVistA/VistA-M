MAGS2BSE ;WOIFO/JSL - IMAGING BROKER SECURITY PROGRAM ; 9-JUN-2010 2:45 PM
 ;;3.0;IMAGING;**111,90**;Mar 19, 2002;Build 1764;Jun 09, 2010
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
BSE(RES) ;RETURN A BROKER SECURITY TOKEN
 D SETVISIT^XUSBSE1(.RES)  ;XUS SET VISITOR - RPC return a token RES
 Q
 ;
 ;+++++ RPC: MAG BROKER GET VISITOR
 ; 
 ;   External Call: GETVISIT^XUSBSE1()  ; Check for expired token.
 ; 
 ; MAGREF1 -- Local variable name for the return value.
 ; MAGTKN  -- The token to be checked.
 ; 
 ; Returns ...
 ; ===========
 ;                ______ON_ERROR_______    ___EXPECTED___
 ; MAGREF1      : 0                        "^"-delimited demographic data
 ;
 ; Notes:
 ; ======
 ; 
 ; See the description for RPC: XUS GET VISITOR.
BSEXP(MAGREF1,MAGTKN) ;
 D GETVISIT^XUSBSE1(.MAGREF2,MAGTKN)
 S MAGREF1=$S(MAGREF2="":0,1:MAGREF2)
 Q
 ;
 ; MAGS2BSE
