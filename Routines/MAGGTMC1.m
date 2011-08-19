MAGGTMC1 ;WOIFO/GEK - RPC Calls for Imaging/Medicine procedures ; [ 06/20/2001 08:57 ]
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
FILE(MAGRY,DATA,MAGARR) ;RPC Call to File the Image pointer into 
 ; the Procedure/Subspecialty and Proc/Subspec into Image file.
 ;
 ; DATA = DATETIME^PSIEN^DFN^MCIEN^PROCSTUB ; 6/19/97
 ; If MCIEN isn't sent, this will be added as new procedure
 ; MAGARR is array of image pointers
 ; IF PROCSTUB is 1 we JUST want New Medicine procedure stub IEN 6/19/97
 ; as the success    i.e.  MAGRY="IEN^Procdure Stub created"    6/19/97
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 N I,J,K,X,Y,Z,TIME,PSIEN,DFN,MAGPTR,MAGMCIEN,MCFILE,MAGOK,MAGERR,PROCSTUB
 ;
 S X=$P(DATA,U,1),%DT="TS" D ^%DT S TIME=Y
 S PSIEN=+$P(DATA,U,2)
 S DFN=+$P(DATA,U,3)
 S MAGMCIEN=+$P(DATA,U,4)
 S PROCSTUB=+$P(DATA,U,5) ; NEW 6/19/97 GEK
 S MCFILE=$P($P(^MCAR(697.2,PSIEN,0),U,2),"(",2)
 I '$D(^MAG(2005.03,MCFILE)) S MAGRY="0^Procedure file is Invalid in Imaging Parent Data File " Q
 S MAGOK=""
 S I="" F  S I=$O(MAGARR(I)) Q:I=""  D
 . S MAGPTR(I)=""
 . I '$D(^MAG(2005,I)) S MAGERR="0^INVALID Image entry "_I
 I $D(MAGERR) S MAGRY=MAGERR Q
 ; 6/19/97  New Note .MAGMCIEN
 D UPDATE^MCUIMAG0(TIME,PSIEN,DFN,.MAGPTR,.MAGMCIEN,.MAGOK)
 ;
 I 'MAGOK S MAGRY=MAGOK Q
 ; Next if we're getting a stub, Quit with the stub if it was created
 I MAGOK,PROCSTUB D  Q
 . I MAGMCIEN<1 S MAGRY="0^FAILED Creating New Procedure stub"_MAGOK Q
 . S MAGRY=$P(MAGMCIEN,U,1)_"^Procedure Stub created"
 ;
 ; now enter the pointers to procedures, in the image file.
 ; we get back MAGPTR(I)= MCFILE^PSIEN^MULTIPLE ENTRY IEN
 S I="" F  S I=$O(MAGPTR(I)) Q:I=""  D
 . S $P(^MAG(2005,I,2),U,6,8)=MAGPTR(I)
 . D LINKDT^MAGGTU6(.X,I)
 S MAGRY=MAGOK
 Q
 ;/GEK/ 4/29/98 put in modification to return DICOM ID for MED proc.
DICOMID(MAGRY,DATA) ;RPC Call to return a Dicom ID for medicine procedure.
 ;  This is displayed on workstation, and used to link Dicom images 
 ;  to a medicine procedure.
 ;  DATA is    null  ^ PSIEN ^ DFN ^ MCIEN ^ null
 ; 
 N TMCFILE,TPSIEN,TDFN,TMCIEN,RETX
 S TPSIEN=+$P(DATA,U,2)
 S TDFN=+$P(DATA,U,3)
 S TMCIEN=+$P(DATA,U,4)
 S TMCFILE=$P($P($G(^MCAR(697.2,TPSIEN,0)),U,2),"(",2)
 I 'TMCFILE S MAGRY="0^InValid data input PSIEN="_TPSIEN Q
 D DICOMID^MAGDMEDI(.RETX,TMCFILE,TMCIEN,TPSIEN,TDFN)
 S MAGRY=RETX
 Q
NEW(MAGRY,DATA) ;RPC call to Create NEW Procedure stub
 ;       for a medicine procedure
 ;
 ; DATA = DATETIME^PSIEN^DFN  ; same as old call
 S $P(DATA,"^",4)="^1" ; the 1 means we want a new procedure stub
 K MAGARR ; we are not passing any images.
 D FILE(.MAGRY,DATA,.MAGARR)
 Q
