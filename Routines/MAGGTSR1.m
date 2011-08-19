MAGGTSR1 ;WOIFO/GEK - ADD IMAGES TO SURGERY FILE ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**59**;Nov 27, 2007;Build 20
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
 Q
FILE(MAGRY,MAGIEN,DATA) ;RPC Call to file Image pointers in Surgery package
 ;   and Surgery pointers in Image File.
 ;
 ; DATA is same data that we listed in the GET^MAGGTSR call
 ; MAGIEN is the Imaging internal number.
 ;  example
 ; for Imaging Versions < 2.5 the data is 
 ; #     DATE             DESC      SRF(IEN   FM DATE
 ;CNT_U_(READABLE DATE)_U_SROPS(1)_U_SROP_U_SRSDATE
 ;
 ; for Imaging Versions > 2.4, the data is different
 ;CNT_U_(READABLE DATE)_U_SROPS(1)_U_IMAGECT_U_"|"_SROP_U_SRSDATE
 ;  example
 ;  1^05-06-1997^REMOVE TONSILS (REQUESTED)^8^|9853^2970506^
 ;
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 N Y,MAGSIEN,MAGPDT,MAGFDA,MAGERR,MAGIENS
 ; 
 I (+$G(MAGJOB("VERSION"))>2.4) D
 . S MAGSIEN=$P($P(DATA,$C(124),2),U,1)
 . S MAGPDT=$P($P(DATA,$C(124),2),U,2)
 E  S MAGSIEN=$P(DATA,U,4),MAGPDT=$P(DATA,U,5)
 S MAGFDA(130.02005,"+1,"_MAGSIEN_",",.01)=MAGIEN
 D UPDATE^DIE("S","MAGFDA","MAGIENS","MAGERR")
 I '$G(MAGIENS(1)) D  D CLEAN^DILF S MAGRY=MAGERR Q
 . S MAGERR="0^ERROR Adding Image to Surgery Package "
 . I $D(DIERR) D RTRNERR(.MAGERR)
 S MAGRY="1^Image added to Surgery Package"
 S $P(^MAG(2005,MAGIEN,2),U,6,8)="130^"_MAGSIEN_U_MAGIENS(1)
 D LINKDT^MAGGTU6(.X,MAGIEN)
 Q
RTRNERR(ETXT) ; There was error from UPDATE^DIE quit with error text
 S ETXT="0^ERROR  "_MAGERR("DIERR",1,"TEXT",1)
 Q
