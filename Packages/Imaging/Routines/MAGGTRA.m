MAGGTRA ;WOIFO/GEK - RPC Call to list Patient's Rad/Nuc Exams, Reports ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**59**;Nov 27, 2007;Build 20
 ;;Per VHA Directive 2004-038, this routine should not be modified.
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
LIST(MAGRY,DATA) ;
 ; SOME OLD IMAGING EXECUTABLES (IMGVWP10) STILL CALL HERE
 ;  THIS HAS BEEN SWITCHED TO LIST^MAGGTRA1
 ;
 ;MAGRY - return array of patient's exams.
 ;DATA   - RADFN - Radiology Patient's DFN  ^RADPT(
 ;
 D LIST^MAGGTRA1(.MAGRY,.DATA)
 Q
MAGPTR(MAGRY,XDUZ,MAGIEN,DATA) ;RPC Call to file Image pointer into Radiology
 ;   File and Radiology pointer into Image File.
 ;
 ; MAGRY is the return string = 1^success     if things work okay.
 ;                               0^message     if things not okay.
 ;  DATA is The data that was sent in LIST^MAGGTRA
 ;        it is the display data _ to ^TMP($J,"RAEX",RACNT
 ;        the ^TMP is setup by RAPTLU, (and MAGGTRA) in the lookup
 ;        of patient exams, we keep it, and send it back in case
 ;        we need to create a new report.
 ;
 ;  XDUZ is not used from parameter list anymore.
 ;  MAGIEN is Image File IEN ^MAG(2005,IEN
 ;
 N Y,I,CT,MAGERR,DIQUIET
 N RADFN,RADTI,RACNI,RANME,RASSN,RADATE,RADTE,RACN,RAPRC,RARPT,RAST,MAGGP
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^MAGGTERR"
 E  S X="ERR^MAGGTERR",@^%ZOSF("TRAP")
 S DIQUIET=1,MAGERR=0,CT=0
 D DT^DICRW
 ;    The list entry selected has the following data associated with it
 ;    it was created using parts of RAPTLU routine to list rad exams
 ;^TMP($J,"RAEX",RACNT)=RADFN_"^"_RADTI_"^"_RACNI_"^"_RANME_"^"_RASSN_"^"_RADATE_"^"_RADTE_"^"_RACN_"^"_RAPRC_"^"_RARPT_"^"_RAST
 ;
 S DATA=$P(DATA,"^",7,99)
 F I="RADFN","RADTI","RACNI","RANME","RASSN","RADATE","RADTE","RACN","RAPRC","RARPT","RAST" S CT=CT+1,@I=$P(DATA,"^",CT)
 ;
 ; let us check a few things first
 ; Do we have a valid IMAGE IEN  ^MAG(2005,
 I '$D(^MAG(2005,MAGIEN,0)) S MAGRY="0^OPERATION CANCEDED: INVALID Imaging (2005) entry" Q
 ; Does this Imaging entry already point to a Report.
 I $D(^MAG(2005,MAGIEN,2)) S Z=^(2) D
 . F I=6,7,8 S X=$P(Z,U,I) I $L(X) S MAGERR=1 Q
 I MAGERR S MAGRY="0^OPERATION CANCELED: Imaging File entry already has an associated Report" Q
 ; Does the Imaging entry patient, match the Rad Exam entry patient
 I $P(^MAG(2005,MAGIEN,0),U,7)'=RADFN S MAGRY="0^OPERATION CANCELED: Imaging Patient doesn't match Radiology Patient" Q
 I RARPT,'$D(^RARPT(RARPT,0)) S MAGRY="0^OPERATION CANCELED: INVALID Radiology Report Number" Q
 I '$G(RARPT) D CREATE^RARIC I '$G(RARPT) S MAGRY="0^OPERATION FAILED creating new Radiology Report entry" Q
 ;    Now lets file the Image pointer in the ^RARPT(  file.
 S MAGGP=MAGIEN
 D PTR^RARIC
 I Y<1 S MAGRY="0^OPERATION FAILED Creating Image pointer in Report File" Q
 ; Now SET the Parent fields in the Image File
 S $P(^MAG(2005,MAGIEN,2),U,6,8)=74_U_RARPT_U_+Y
 ; DONE.
 S MAGRY="1^Image pointer filed successfully"
 D LINKDT^MAGGTU6(.X,MAGIEN)
 Q
