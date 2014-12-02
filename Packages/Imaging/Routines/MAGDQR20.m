MAGDQR20 ;WOIFO/EdM,NST,MLH,BT - RPCs for Query/Retrieve SetUp ; 25 Jan 2012 4:27 PM
 ;;3.0;IMAGING;**119**;Mar 19, 2002;Build 4396;Apr 19, 2013
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
 ;This procedure called by STUDY^MAGDQR21 to generate IMAGE INFO lines
WRTIMG(SERIESARRAY,D0,REQDFN,STUMO,INCDEL) ; Retrieve Image info and output to IMAGE INFO line
 N I
 N SERID  ;SERID(UID _ DCOM SERIES NUM, UID)
 N SERIES ;SERIES(UID _ DCOM SERIES NUM, DCOM IMAGE NUM, OBJECT GROUP)=""
 N SNUM,TMP
 K ^TMP("MAG",$J,"S") ;Images info by IEN
 K ^TMP("MAG",$J,"M") ;RAD Procedure by IEN (1,IEN) and by SERIESUID (2,SERIESUID,Procedure)
 ;
 D RTRVIMG^MAGDQR20(.TMP,D0,REQDFN,INCDEL) ;retrieve images info for D0 and saved to TMP
 D:$E($G(TMP),1,5)="^TMP(" WRTMAGM^MAGDQR20(.TMP,.STUMO) ;Save images and procedures, return STUMO (procedures)
 ;
 D GETSER^MAGDQR20(D0,.SERIES,.SERID,INCDEL) ;Get SERIESUID info, store in SERIES and SERID
 S SNUM="" F  S SNUM=$O(SERIES(SNUM)) Q:SNUM=""  D WRTSER^MAGDQR20(D0,.SERIESARRAY,.SERIES,SNUM,.SERID,REQDFN)
 ;
 S I="" F  S I=$O(^TMP("MAG",$J,"S",I)) Q:I=""  D WRTOUT^MAGDQR21("UNUSED_GROUP_INFO|"_^TMP("MAG",$J,"S",I))
 ;
 K ^TMP("MAG",$J,"S")
 K ^TMP("MAG",$J,"M")
 Q
 ;
RTRVIMG(TMP,D0,REQDFN,INCDEL) ; Retrieve info for either single or group image
 N MAGFIL,X
 S MAGFIL=$$FILE^MAGGI11(D0)
 ;
 I MAGFIL,$D(^MAG(MAGFIL,D0,1)) D  Q  ; images and/or deleted images group
 . ; allow return of info if DFN defined
 . D GROUP^MAGGTIG(.TMP,D0,REQDFN)
 . D:INCDEL RTRVDIMG^MAGDQR20(.TMP,D0) ;include deleted images of the active group
 . Q
 ;
 ; DEFAULT - image is a single
 D IMAGEINF^MAGGTU3(.X,D0,REQDFN)
 I INCDEL,$$ISDEL^MAGGI11(D0) D DIMGINF^MAGDQR20(.X,D0)
 S TMP=$NA(^TMP("MAGGTIG",$J))
 K @TMP S @TMP@(0)="1^1",@TMP@(1)=X(0)
 Q
 ;
RTRVDIMG(MAGRY,MAGIEN) ; Get Deleted images and output the info
 N MAGCHILD,MAGCT,MAGFILE,X
 ;
 I $G(MAGRY)="" D
 . ;  we'll use @ notation, this'll work if an Array or a Global Array is being returned
 . S X=$$RTRNFMT^XWBLIB("GLOBAL ARRAY",1) ;must call this, setting up Internal Variables
 . S MAGRY=$NA(^TMP("MAGGTIG",$J))
 . K @MAGRY
 . Q
 ;
 S MAGCT=$O(@MAGRY@(""),-1)
 S MAGCHILD=""
 ;
 F  S MAGCHILD=$O(^MAG(2005.1,"AGP",MAGIEN,MAGCHILD)) Q:'MAGCHILD  D
 . S MAGCT=MAGCT+1
 . S MAGFILE=$$INFO^MAGGAII(MAGCHILD,"D")
 . S @MAGRY@(MAGCT)="B2^"_MAGFILE
 . Q
 S @MAGRY@(0)="1^"_MAGCT
 Q
 ;
DIMGINF(MAGRY,IEN) ; Retrieve Deleted images
 N MAGINFO,Z,EXIST
 ;
 S MAGINFO=$$INFO^MAGGAII(IEN,"E")
 S EXIST=$D(^MAG(2005.1,IEN,0))
 I 'EXIST S Z="1^Missing Record"
 I EXIST D
 . S Z=$P(^MAG(2005.1,IEN,0),U,7)
 . I '$D(^DPT(Z)) S Z="1^Invalid patient pointer"
 . E  S Z=Z_U_$P(^DPT(Z,0),U)
 S MAGRY(0)="1^"_MAGINFO
 S MAGRY(1)=Z ; dfn^name
 Q
 ;
WRTMAGM(TMP,STUMO) ; Save series to TMP
 N D,G,M,P,X,I
 N MAGFILD,MAGFILG
 K @TMP@(0)
 S I=""
 ;
 F  S I=$O(@TMP@(I)) Q:I=""  D
 . S X=$G(@TMP@(I))
 . S D=$P(X,"^",2) ;IEN containing the images' info
 . Q:'D
 . S ^TMP("MAG",$J,"S",D)=X
 . S MAGFILD=$$FILE^MAGGI11(D)
 . S X=$S(MAGFILD:$G(^MAG(MAGFILD,D,0)),1:"")
 . S G=+$P(X,"^",10) ;Group IEN
 . S M=$P(X,"^",8)   ;Procedure
 . S:$E(M,1,4)="RAD " M=$E(M,5,$L(M))
 . Q:M=""
 . S MAGFILG=$$FILE^MAGGI11(G)
 . S G=$S(MAGFILG:$P($G(^MAG(MAGFILG,G,2)),"^",6),1:"") ;Parent Data File# for Group IEN
 . S P=$S(MAGFILD:$P($G(^MAG(MAGFILD,D,2)),"^",6),1:"") ;Parent Data File# for IEN
 . I P'=74,G'=74 Q  ;quit if not RAD/NUC MED REPORTS file (#74)
 . S ^TMP("MAG",$J,"M",1,D)=M
 . S STUMO(M)=""
 . S G=$S(MAGFILD:$G(^MAG(MAGFILD,D,"SERIESUID")),1:"")
 . S:G'="" ^TMP("MAG",$J,"M",2,G,M)=""
 . Q
 Q
 ;
GETSER(D0,SERIES,SERID,INCDEL) ; Populate SERIES array for File 2005 and 2005.1
 N MAGFIL,U1
 ; 
 ; group IEN 
 I $D(^MAG(2005,D0,1)) D GETRSER^MAGDQR20(D0,.SERIES,.SERID)
 ; include deleted images 
 I INCDEL D GETDSER^MAGDQR20(D0,.SERIES,.SERID)
 ;
 D:'$D(SERIES)
 . S U1=""
 . S MAGFIL=$$FILE^MAGGI11(D0)
 . S:MAGFIL U1=$G(^MAG(MAGFIL,D0,"SERIESUID"))
 . S:U1="" U1="?"
 . S SERIES(U1_"_1",1,D0)="",SERID(U1_"_1",U1)=""
 . Q
 Q
 ;
GETRSER(D0,SERIES,SERID) ; Populate SERIES array for File 2005
 N ANY,D1,X
 N SNUM ;DCOM SERIES NUM
 N INUM ;DCOM IMAGE NUM
 N U1   ;UID
 N I0   ;object for a GROUP
 S (ANY,D1)=0
 ;
 F  S D1=$O(^MAG(2005,D0,1,D1)) Q:'D1  D
 . S X=$G(^MAG(2005,D0,1,D1,0)),I0=+X Q:'I0
 . S ANY=1,I0=+X,SNUM=$P(X,"^",2),INUM=$P(X,"^",3)
 . S U1=$G(^MAG(2005,I0,"SERIESUID"))
 . S:SNUM="" SNUM="?" S:INUM="" INUM="?" S:U1="" U1="?"
 . S SERIES(U1_"_"_SNUM,INUM,I0)="",SERID(U1_"_"_SNUM,U1)=""
 . Q
 Q
 ;
GETDSER(D0,SERIES,SERID) ; Populate SERIES array for File 2005.1
 N SNUM ;DCOM SERIES NUM
 N INUM ;DCOM IMAGE NUM
 N U1   ;UID
 N I0   ;object for a GROUP (Child IEN)
 S I0=""
 ;
 F  S I0=$O(^MAG(2005.1,"AGP",D0,I0)) Q:I0=""  D
 . D GETDINUM^MAGDQR20(D0,I0,.SNUM,.INUM)
 . S U1=$G(^MAG(2005.1,I0,"SERIESUID"))
 . S:U1="" U1="?"
 . S SERIES(U1_"_"_SNUM,INUM,I0)="",SERID(U1_"_"_SNUM,U1)=""
 . Q
 Q
 ;
GETDINUM(GRPIEN,CHLDIEN,SNUM,INUM) ; Get DICOM Serial Number and Image Number for Child IEN from Audit Image 
 N X,D1,I0
 S SNUM="",INUM=""
 S D1=0
 ;
 F  S D1=$O(^MAG(2005.1,GRPIEN,1,D1)) Q:'D1  D  Q:SNUM'=""!(INUM'="")
 . S X=$G(^MAG(2005.1,GRPIEN,1,D1,0)),I0=+X Q:'I0
 . S:I0=CHLDIEN SNUM=$P(X,"^",2),INUM=$P(X,"^",3)
 . Q
 ;
 S:SNUM="" SNUM="?"
 S:INUM="" INUM="?"
 Q
 ;
WRTSER(D0,SERIESARRAY,SERIES,SNUM,SERID,REQDFN) ; Output to TMP based on SERIES array
 ; refresh temp image index
 ; SERIES(UID _ DCOM SERIES NUM, DCOM IMAGE NUM, OBJECT GROUP)=""
 N MAGTI
 N INUM ;IMAGE NUMBER
 N I0   ;OBJECT GROUP
 N UID  ;SERIES UID
 S MAGTI=0 ; temp image index
 K ^TMP("MAG",$J,"TI") ;temp for sorting
 ;
 ; seek qualifying images (no QI or matching known DFN)
 S INUM=""
 F  S INUM=$O(SERIES(SNUM,INUM)) Q:INUM=""  D
 . S I0=""
 . ;sort into ^TMP(,,"TI",)
 . F  S I0=$O(SERIES(SNUM,INUM,I0)) Q:I0=""  D SRTMAGTI^MAGDQR20(INUM,I0,REQDFN)
 . Q
 ;
 ;quit if qualifying images were not found
 Q:'$D(^TMP("MAG",$J,"TI"))
 ;
 S UID="" F  S UID=$O(SERID(SNUM,UID)) Q:UID=""  D WRSERUID^MAGDQR20(UID,D0)
 ;
 D:SNUM'="?" WASGNSER^MAGDQR20(SNUM,.SERIESARRAY)  ; assign the series number
 S MAGTI="" F  S MAGTI=$O(^TMP("MAG",$J,"TI",MAGTI)) Q:'MAGTI  D WRTOUT^MAGDQR21(^TMP("MAG",$J,"TI",MAGTI))
 ;
 K ^TMP("MAG",$J,"TI")
 Q
 ;
SRTMAGTI(INUM,I0,REQDFN) ; Save IMAGE_IEN and GROUP_IEN lines
 ; if dup study instance UID, purge image info and bail out
 ; unless pt is specified and this image is for that pt
 N MAGFIL,MAGR0,X
 N UID ;PACS UID
 N MAGTI ;Line counter
 N GRPIEN ;Group IEN
 N IMGINFO
 ;
 S MAGR0=""
 S MAGFIL=$$FILE^MAGGI11(I0)
 S:MAGFIL MAGR0=$G(^MAG(MAGFIL,I0,0))
 I REQDFN,$P(MAGR0,"^",7)'=REQDFN K ^TMP("MAG",$J,"S",I0) Q  ;patient must be the REQDFN
 ;
 S UID=$P($G(^MAG(MAGFIL,I0,"PACS")),"^",1)
 S MAGTI=$O(^TMP("MAG",$J,"TI",""),-1)+1
 S MAGTI=MAGTI+1,^TMP("MAG",$J,"TI",MAGTI)="NEXT_IMAGE"
 S:UID'="" MAGTI=MAGTI+1,^TMP("MAG",$J,"TI",MAGTI)="IMAGE_UID|"_UID
 S MAGTI=MAGTI+1,^TMP("MAG",$J,"TI",MAGTI)="IMAGE_IEN|"_I0
 S GRPIEN=$P(MAGR0,"^",10)
 S:GRPIEN MAGTI=MAGTI+1,^TMP("MAG",$J,"TI",MAGTI)="GROUP_IEN|"_GRPIEN
 ;
 ; QI check - override only if DFN specified in call
 ; (VA internal only!)
 D CHK^MAGGSQI(.X,I0) ;Check the integrity of I0
 I '$G(X(0)) D  Q:'REQDFN
 . S MAGTI=MAGTI+1,^TMP("MAG",$J,"TI",MAGTI)="IMAGE_ERR|"_$P($G(X(0)),"^",2)
 . Q
 ;
 S:INUM'="?" MAGTI=MAGTI+1,^TMP("MAG",$J,"TI",MAGTI)="IMAGE_NUMBER|"_INUM
 S IMGINFO=$G(^TMP("MAG",$J,"S",I0)) K ^TMP("MAG",$J,"S",I0)
 ; Get Site image parameters IEN from 16^ piece of IMGINFO
 S:IMGINFO'="" MAGTI=MAGTI+1,^TMP("MAG",$J,"TI",MAGTI)="IMAGE_INFO|"_IMGINFO_"|"_$$GETSNUM^MAGDQR21($P(IMGINFO,"^",16))
 Q
 ;
WRSERUID(UID,D0) ; Output SERIES_IEN line
 N M,X
 ;
 D WRTOUT^MAGDQR21("NEXT_SERIES")
 D:UID'="?" WRTOUT^MAGDQR21("SERIES_UID|"_UID)
 D WRTOUT^MAGDQR21("SERIES_IEN|"_D0)
 ; Officially, there can be only one modality per series,
 ; so stop when the first modality is found...
 S X="",M=""
 F  S M=$O(^TMP("MAG",$J,"M",2,UID,M)) Q:M=""  D  Q:X'=""
 . S X=$S(X'="":"\",1:"")_M
 . Q
 D:X'="" WRTOUT^MAGDQR21("SERIES_MODALITY|"_X)
 Q
 ;
WASGNSER(SNUM,SERIESARRAY) ; Output SERIES_NUMBER line
 N SERIESNUM
 ; - get series no from study itself if possible, else generate
 D TSTSER^MAGDQR20(SNUM,.SERIESARRAY,.SERIESNUM)
 D:'$D(SERIESNUM)  ; still need to generate
 . F SERIESNUM=1:1 Q:'$D(SERIESARRAY(SERIESNUM))
 . Q
 ;
 D WRTOUT^MAGDQR21("SERIES_NUMBER|"_SERIESNUM)
 S SERIESARRAY(SERIESNUM)=""
 Q
 ;
TSTSER(SNUM,SERIESARRAY,SERIESNUM) ; Validate SERIES NUMBER
 N SERIESTEST,SGN
 S SERIESTEST=$P(SNUM,"_",2)
 Q:"+-1234567890"'[$E(SERIESTEST,1)  ; invalid number
 S:"+-"[$E(SERIESTEST,1) SGN=$E(SERIESTEST,1)
 S:$D(SGN) SERIESTEST=$E(SERIESTEST,2,$L(SERIESTEST))
 Q:SERIESTEST'?1.12N
 S SERIESTEST=$G(SGN)_SERIESTEST
 Q:$D(SERIESARRAY(SERIESTEST))
 S SERIESNUM=SERIESTEST
 Q
