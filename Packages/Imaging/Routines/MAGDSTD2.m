MAGDSTD2 ; OI&T-Clin3/DWM,WOIFO/PMK - rad exams w/o VI images; Jul 06, 2021@08:21:46
 ;;3.0;Support;**231,306**;11/13/2018;Build 1
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
 ;
 ; Supported IA #10026 reference ^DIR subroutine call
 ; Controlled Subscription IA #10035 for Fileman reads of ^DPT
 ; Controlled Subscription IA #1171 to read RAD/NUC MED REPORTS file (#74)
 ; Supported IA #1519 reference EN^XUTMDEVQ subroutine call
 ; Private IA #7111 reference ^RARTFLDS subroutine call
 ; Supported IA #10035 to read PATIENT file (#2)
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ;
 ; Original: MAGWOVI by Dave Massey
 ;
DATES ; enter date range to search
 N DIR,DTFR,DTTO,Y,X
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 ;
 W !!!,"Search for Radiology Exams Lacking Images"
 W !,"------------------------------------------"
 D BEGDATE^MAGDSTA2
 S DTFR=$G(^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE"))
 I DTFR="" G EXIT
 D ENDDATE^MAGDSTA2
 S DTTO=$G(^TMP("MAG",$J,"BATCH Q/R","END DATE"))
 I DTTO="" G EXIT
 ;
QUE ; queue to run report
 W !!,"Recommend report output of 132 columns",!!
 ;
 N %ZIS,ZTDESC,ZTSAVE
 S ZTDESC="Radiology Exams w/o VI Images"
 S ZTSAVE("DTFR")=""
 S ZTSAVE("DTTO")=""
 D EN^XUTMDEVQ("EN^"_$T(+0),ZTDESC,.ZTSAVE,.%ZIS)
 G EXIT
 Q
 ;
EN ;entry point
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 ;
 S X=132 X ^%ZOSF("RM") ; set right margin to 132
 ;
 K ^TMP("MAG",$J)
 ;
 D COUNTS(DTFR,DTTO)
 ;
 ; display results
 I '$D(^TMP("MAG",$J)) W !!,"No data for display!",!! G EXIT
 D DISPLAY
 W !!,"RUN COMPLETED at ",$$FMTE^XLFDT($$NOW^XLFDT,1)
 D CONTINUE^MAGDSTQ
 ;
EXIT ;
 K ^TMP("MAG",$J)
 Q
 ;
COUNTS(DTFR,DTTO) ; build list of exams w/o images
 ;     ^TMP("MAG",$J,LOC,RPTDATE,ACNUMB)=PNAME_"^"_SSN_"^"_PROC
 N RARPT,REVDATE,RPTDATE,XDTFR,XDTTO
 ;
 S XDTFR=DTFR-.0001,XDTTO=DTTO+.9999
 S XDTFR=9999999.9999-XDTFR ; reverse date & time
 S XDTTO=9999999.9999-XDTTO ; reverse date & time
 ;
 S REVDATE=XDTFR
 F  S REVDATE=$O(^RARPT("AA",REVDATE),-1) Q:REVDATE=""  Q:REVDATE<DTTO  D
 . S RPTDATE=9999999.9999-REVDATE ; get regular FM date/time from reverse date/time
 . S RARPT=""
 . F  S RARPT=$O(^RARPT("AA",REVDATE,RARPT))  Q:RARPT=""  D
 . . D LOOKUP(RARPT)
 . . Q
 . Q
 Q
 ;
LOOKUP(RARPT) ;
 N ACNUMB,DFN,EXAMDATE,FOUND,LOC,RARPT0,OUT,PNAME,PROC,RARPT0,SSN
 S RARPT0=$G(^RARPT(RARPT,0)) I RARPT0="" Q  ; no zero-node
 S ACNUMB=$P(RARPT0,"^",1) I ACNUMB="" Q  ; null accession number
 I $P(RARPT0,"^",5)="X" Q  ; deleted report
 S EXAMDATE=$P(RARPT0,"^",3) ; exam date/time
 ; -- patient demographics --
 S DFN=$P(RARPT0,"^",2) I DFN="" Q  ; null patient field
 S PNAME=$$GET1^DIQ(2,DFN,.01,"E") Q:PNAME=""
 S SSN=$$GET1^DIQ(2,DFN,.09,"E") Q:SSN=""
 ; -- check for #74 file 2005 node --
 ;       if not present, check new sop database
 S FOUND=$$LEGACY(RARPT)
 I 'FOUND D
 . S FOUND=$$NEWSOP(ACNUMB)
 . Q
 I 'FOUND D
 . ; -- lookup report's procedure & imaging location --
 . D PROLOC(.OUT,RARPT) S PROC=$P(OUT,"^",1),LOC=$P(OUT,"^",2)
 . I PROC="" Q  ; no report procedure
 . I LOC="" Q  ; no imaging location 
 . S ^TMP("MAG",$J,LOC,EXAMDATE,ACNUMB)=PNAME_"^"_SSN_"^"_PROC
 . Q
 Q
 ;
LEGACY(RARPT) ; check for "2005" node
 N FOUND,J,MAGIEN
 S (FOUND,J)=0
 ; -- loop #74 "2005" node to validate images --
 F  S J=$O(^RARPT(RARPT,"2005",J)) Q:'J  D
 . S MAGIEN=$G(^RARPT(RARPT,"2005",J,0)) Q:'MAGIEN
 . S FOUND=FOUND+$$CHECKMAG(MAGIEN,RARPT)
 . Q
 Q FOUND
 ;
CHECKMAG(MAGIEN,RARPT) ;
 ; -- ensure #2005 entry exists --
 I '$D(^MAG(2005,MAGIEN,0)) Q 0 ; no entry in file #2005
 ; -- check if image valid --
 I '$$MAG(MAGIEN) Q 0 ; invalid patient or child entry
 ; -- check #2005 pointer back to #74 --
 I '$$PARENT(MAGIEN,RARPT) Q 0 ; bad pointer
 Q 1
 ;
MAG(MAGIEN) ; validate parent or child image
 ; called by ^MAGDSTD3 for consults
 N CHECK,CHILDIEN,J
 S CHECK=0
 ; -- parent #2005 entry --
 I $D(^MAG(2005,MAGIEN,1)) D
 . S J=0 F  S J=$O(^MAG(2005,MAGIEN,1,J)) Q:'J  Q:CHECK  D
 . . S CHILDIEN=$P(^MAG(2005,MAGIEN,1,J,0),"^",1)
 . . Q:'$D(^MAG(2005,CHILDIEN,0))
 . . S CHECK=$$IMAGE(CHILDIEN)
 . . Q
 . Q
 E  D  ; -- child #2005 entry --
 . S CHILDIEN=MAGIEN,CHECK=$$IMAGE(CHILDIEN)
 . Q
 Q CHECK
 ;
IMAGE(CHILDIEN) ; called from within 'MAG' subroutine
 N MAG0,REF,OBJ,TYPE
 S MAG0=$G(^MAG(2005,CHILDIEN,0)) Q:MAG0="" 0
 ; -- file reference and object type
 S REF=$P(MAG0,"^",2),OBJ=$P(MAG0,"^",6)
 Q:REF="" 0 Q:OBJ="" 0
 S TYPE=$P(^MAG(2005.02,OBJ,0),"^",1)
 ;  .dcm, .pdf, & .tga files
 I TYPE="DICOM IMAGE" Q 1
 I TYPE="ADOBE" Q 1 ; for consults
 I TYPE="XRAY" Q 1 ; for old pre-DICOM TGA's
 Q 0
 ;
PARENT(MAGIEN,RARPT) ; check #2005 pointer back to #74
 N REPORT
 I '$D(^MAG(2005,MAGIEN,"PACS")) Q 0
 S REPORT=$P(^MAG(2005,MAGIEN,"PACS"),"^",2)
 I REPORT'=RARPT Q 0
 Q 1
 ;
NEWSOP(GMRCACN) ; lookup in new sop class database
 ; called by ^MAGDSTD3 for consults
 N FIELD,FOUND,FNUM,IEN,IMAGES,J,OUT,OVERRIDE,STATUS
 S FOUND=0
 I $G(GMRCACN)="" Q FOUND
 S OVERRIDE=1
 I '$D(^MAGV(2005.62,"D",GMRCACN)) Q FOUND
 S IEN=0 F  S IEN=$O(^MAGV(2005.62,"D",GMRCACN,IEN)) Q:'IEN  D
 . ;  RPC - MAGV GET STUDY
 . D GETSTUDY^MAGVRS04(.OUT,,IEN,OVERRIDE) Q:'$D(OUT)
 . S J=" " F  S J=$O(OUT(J),-1) Q:'J  Q:FOUND=1  D
 . . S FIELD=$P(OUT(J),"|")
 . . Q:FIELD'="NUMBER OF SOP INSTANCES"
 . . S IMAGES=$P(OUT(J),"|",2)
 . . S:IMAGES>0 FOUND=1
 . . Q
 . Q
 Q FOUND
 ;
PROLOC(OUT,D0) ; return report's procedure & imaging location
 N RACN,RAEXFLD,X,LOC,PROC
 S OUT="^" I D0="" Q
 S RAEXFLD="PROC" D ^RARTFLDS S PROC=X K X Q:PROC=""
 S RAEXFLD="LOC" D ^RARTFLDS S LOC=X K X Q:LOC=""
 S OUT=PROC_"^"_LOC
 Q
 ;
DISPLAY ;
 N ACNUMB,ANS,EXAMDATE,FDATE,LOC,NODE,PNAME,PROC,SSN,STOP,TDATE,X,Y
 S STOP=0,Y=DTFR X ^DD("DD") S FDATE=Y,Y=DTTO X ^DD("DD") S TDATE=Y
 S LOC="" F  S LOC=$O(^TMP("MAG",$J,LOC)) Q:LOC=""  D
 . D HDR I STOP Q
 . S EXAMDATE=0 F  S EXAMDATE=$O(^TMP("MAG",$J,LOC,EXAMDATE)) Q:'EXAMDATE!(STOP=1)  D
 . . S ACNUMB="" F  S ACNUMB=$O(^TMP("MAG",$J,LOC,EXAMDATE,ACNUMB)) Q:ACNUMB=""!(STOP=1)  D
 . . . S NODE=^TMP("MAG",$J,LOC,EXAMDATE,ACNUMB),Y=$P(EXAMDATE,".") X ^DD("DD")
 . . . S PNAME=$P(NODE,"^",1),SSN=$P(NODE,"^",2),PROC=$P(NODE,"^",3)
 . . . W !,ACNUMB,?20,$E(PNAME,1,30),?53,$E(SSN,6,9),?60,Y,?75,PROC
 . . . I $E(IOST,1,2)="C-",$Y+5>IOSL D
 . . . . R !!,"Press RETURN to continue or '^' to exit: ",ANS:DTIME E  S ANS="^"
 . . . . S STOP=$S(ANS="^":1,1:0)
 . . . . W @IOF
 . . . . Q
 . . . Q
 . . Q
 . ; stop after each imaging location displayed
 . I $E(IOST,1,2)="C-" D
 . . R !!,"Press RETURN to continue or '^' to exit: ",ANS:DTIME E  S ANS="^"
 . . S STOP=$S(ANS="^":1,1:0)
 . . Q
 . ; new page after each imaging location displayed
 . W @IOF
 . Q
 Q
 ;
HDR ; header
 N LN,ANS,I
 S LN="-" F I=1:1:131 S LN=LN_"-"
 I $E(IOST,1,2)="C-",$Y+10>IOSL D
 . R !!,"Press RETURN to continue or '^' to exit: ",ANS:DTIME E  S ANS="^"
 . S STOP=$S(ANS="^":1,1:0)
 . W @IOF
 . Q
 I STOP Q
 I $E(IOST,1,2)="C-",$Y>1 W @IOF
 W !,?42,"Radiology Exams without Images in VistA Imaging"
 W !,?93,"From "_FDATE_" to "_TDATE
 W !!,"Imaging Location: "_LOC,!
 W !,"Accession",?20,"Patient Name",?53,"Last4",?60,"Exam Date"
 W ?75,"Procedure",!,LN
 Q
