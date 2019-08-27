MAGNVQ04 ;WOIFO/NST - List images for a patient ; OCT 17, 2018@3:59 PM
 ;;3.0;IMAGING;**185,221**;Mar 19, 2002;Build 4525;May 01, 2013
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
 ;*****  List Images by Patient
 ;       
 ; RPC: MAGN PATIENT IMAGE LIST
 ; 
 ; Input Parameters
 ; ================
 ; 
 ; IDTYPE = "DFN"or "ICN"
 ; ID     = Patient ID  
 ; [IMGLESS]  flag to speed up queries: if=1 (true), just get study-level data
 ; [FLAGS]  for feature use
 ; [FROMDATE],[TODATE],[MISCPRMS] - see GETIMGS^MAGSIXG1 for discription
 ;           
 ; Return Values
 ; =============
 ; 
 ; if error MAGRY(0) = 0 ^Error message^
 ; if success MAGRY(0) = 1
 ;            MAGRY(1..n) = images in format defined in RPC [MAGN CPRS IMAGE LIST]
 ;
IMAGEL(MAGRY,IDTYPE,ID,IMGLESS,FLAGS,FROMDATE,TODATE,MISCPRMS) ;RPC [MAGN PATIENT IMAGE LIST]
 N DFN,MAGRY2005,MAGRYP34,MAGDATA,ERROR,FOUND
 ;
 N $ETRAP,$ESTACK S $ETRAP="D AERRA^MAGGTERR"
 D CLEAR^MAGUERR(1)
 S IMGLESS=$S($D(IMGLESS):+IMGLESS,1:1)  ; Default is IMAGELESS
 S FLAGS=$G(FLAGS)
 ;
 S MAGRY=$NA(^TMP("MAGNVQ04",$J))
 K @MAGRY
 S @MAGRY@(0)=0
 S IDTYPE=$G(IDTYPE)
 I (IDTYPE'="DFN")&(IDTYPE'="ICN") S @MAGRY@(0)="0^Invalid IDTYPE "_IDTYPE Q
 ;
 I IDTYPE="DFN" D  I DFN'>0 S @MAGRY@(0)="0^Invalid patient ID: "_DFN Q
 . S DFN=$G(ID)
 . Q
 I IDTYPE="ICN" D  I DFN'>0 S @MAGRY@(0)="0^Error: "_DFN Q
 . S DFN=$S($T(GETDFN^MPIF001)'="":$$GETDFN^MPIF001(ID),1:"-1^NO MPI") ; Supported IA (#2701)
 . Q
 ;
 S FLAGS=$S($G(FLAGS)="":"E",1:FLAGS)
 ;
 I DFN'>0 S @MAGRY@(0)="0^Invalid patient ID: "_DFN Q
 ;
 S I=""
 S FOUND=0
 F  S I=$O(MISCPRMS(I)) Q:FOUND!'I  I $P(MISCPRMS(I),"^")="IDFN" S FOUND=I
 I 'FOUND D
 . S I=$O(MISCPRMS(""),-1)+1  ; set next parameter counter
 . S MISCPRMS(I)="IDFN^^"_DFN
 . Q
 ;
 ;=== Validate parameters
 S ERROR=$$VALPARAM^MAGSIXG1(.MAGDATA,FLAGS,.FROMDATE,.TODATE,"",.MISCPRMS)
 ;
 ;--- Check for errors
 I ERROR D ERROR^MAGUERR(-30),ERRORS^MAGSIXG1(.MAGRY) Q
 ;
 D IMG2005(MAGRY,DFN,IMGLESS,FLAGS,FROMDATE,TODATE,.MAGDATA) ; Get #2005 images 
 ;
 D IMAGEP34(MAGRY,DFN,IMGLESS,FLAGS,FROMDATE,TODATE,.MAGDATA)  ; Get P34 images
 ;
 S @MAGRY@(0)=1
 Q
 ;
IMG2005(MAGRYOUT,DFN,IMGLESS,FLAGS,FROMDATE,TODATE,MAGDATA) ; Get images from #2005
 ; DFN     = Patient DFN
 ; IMGLESS = 0|1 Include images
 ; [FLAGS] = for feature use
 ;
 N I,IMAGE,GROUPS,OUT,QF,RC,TMP
 ;
 ;=== Query the image file(s)
 S MAGDATA("FLAGS")=FLAGS,MAGDATA("MAXNUM")=""
 S TMP=$S(TODATE<9999999:$$FMADD^XLFDT(TODATE,1),1:TODATE)
 S QF=$$TRFLAGS^MAGUTL05(FLAGS,"CDEG")
 ;
 K ^TMP("MAGNVQ07",$J,"QRY2005")
 S RC=$$QUERY^MAGGI13("$$QRY2005^MAGNVQ07",QF,.MAGDATA,FROMDATE,TMP,DFN)
 I RC<0 D  Q
 . D ERRORS^MAGSIXG1(.OUT,RC)
 . M @MAGRYOUT=OUT
 . Q
 ;
 K ^TMP("MAGNVQ07",$J,"QRY2005",0)  ; remove the counter
 M GROUPS=^TMP("MAGNVQ07",$J,"QRY2005")
 K ^TMP("MAGNVQ07",$J,"QRY2005")
 D STUDY2^MAGDQR21(.OUT,.GROUPS,DFN,IMGLESS)  ; MAG DOD GET STUDIES IEN
 ;
 D UPD2005(MAGRYOUT,.OUT,IMGLESS)
 S MAGRYOUT=OUT
 S @MAGRYOUT@(0)=1
 Q
 ;
UPD2005(MAGOUT,MAGIN,IMGLESS) ; Add Additional study information
 N MAGI,IMGIEN,MAGNCNT,MAGSTUDY
 S MAGNCNT=0
 S MAGI=1 ; start from line number 2. Line number 1 is a records count
 F  S MAGI=$O(@MAGIN@(MAGI)) Q:'MAGI  D
 . S MAGNCNT=MAGNCNT+1
 . S @MAGOUT@(MAGNCNT)=@MAGIN@(MAGI)
 . I $P(@MAGIN@(MAGI),"|")="STUDY_IEN" D   ; Add STUDY_INFO. Better place will be MAGDQR21
 . . S MAGNCNT=MAGNCNT+1
 . . S IMGIEN=$P(@MAGIN@(MAGI),"|",2)  ; IEN of the group
 . . S @MAGOUT@(MAGNCNT)="STUDY_INFO|"_$$STDINFO(IMGIEN)
 . . S MAGSTUDY=@MAGIN@(MAGI)
 . . Q
 . I IMGLESS,($P(@MAGIN@(MAGI),"|")="STUDY_PAT") D INSFIMG^MAGNU003(MAGSTUDY,.MAGNCNT,MAGOUT)  ; Append First Image Info
 . Q
 Q
 ;
IMAGEP34(MAGRY,DFN,IMGLESS,FLAGS,FROMDATE,TODATE,MAGDATA) ; Get P34 images
 ; DFN     = Patient DFN
 ; IMGLESS = 0|1 Include images
 ; [FLAGS] = for feature use
 ;
 N IARRAY
 S MAGDATA("FLAGS")=FLAGS,MAGDATA("MAXNUM")=""
 S TMP=$S(TODATE<9999999:$$FMADD^XLFDT(TODATE,1),1:TODATE)
 D PATIMG34^MAGNVQ05(.IARRAY,DFN,IMGLESS,FROMDATE,TODATE,.MAGDATA)  ; Get patient images
 ;
 D GETSTUDY^MAGNVQ01(MAGRY,.IARRAY,"","","") ; Get Study by graph ien
 Q
 ;
STDINFO(IMGIEN)  ; Get Study Info by IEN in IMAGE file (#2005)
 N IMGNODE,X2,PFILE,REFTYPE,REFIEN
 ;
 S IMGNODE=$$NODE^MAGGI11(IMGIEN)
 Q:IMGNODE="" ""
 ;
 S X2=$G(@IMGNODE@(2))
 ;
 S PFILE=$P(X2,U,6)  ; PARENT DATA FILE# 
 S REFTYPE=$$GET1^DIQ(2005.03,PFILE,.02)
 ;
 S REFIEN=$P(X2,U,7) ;PARENT GLOBAL ROOT D0
 ;
 Q $$STDINFO^MAGNU003(IMGIEN,REFTYPE,REFIEN,"")
