MAGDSTD3 ; OI&T-Clin3/DWM,WOIFO/PMK - rad exams w/o VI images; Jul 06, 2021@08:27:03
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
 ; Supported IA #2056 reference $$GET1^DIQ function call;
 ; Controlled Subscription IA #10035 for Fileman reads of ^DPT
 ; Supported IA #10026 reference ^DIR subroutine call
 ; Supported IA #1519 reference EN^XUTMDEVQ subroutine call
 ; Controlled IA #4110 to read REQUEST/CONSULTATION file (#123)
 ; Supported IA #10035 to read PATIENT file (#2)
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ;
 ; Original: MAGWOVI by Dave Massey
 ;
 ; This is the CONSULT version of MAGDSTD2
 ;
DATES ; enter date range to search
 N CONSULTSERVICES,DIR,DTFR,DTTO,SERVICE,Y,X
 ;
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 ;
 ;
 W !!!,"Search for Clinical Specialty Exams Lacking Images"
 W !,"--------------------------------------------------"
 D BEGDATE^MAGDSTA2
 S DTFR=$G(^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE"))
 I DTFR="" G EXIT
 D ENDDATE^MAGDSTA2
 S DTTO=$G(^TMP("MAG",$J,"BATCH Q/R","END DATE"))
 I DTTO="" G EXIT
 W ! S X=$$SERVICES^MAGDSTA8(.CONSULTSERVICES)
 I X<0 W !,"Exiting" Q
 ;
QUE ; queue to run report
 W !!,"Recommend report output of 132 columns",!!
 ;
 N %ZIS,ZTDESC,ZTSAVE
 S ZTDESC="Clinical Specialty Exams w/o VI Images"
 S ZTSAVE("DTFR")=""
 S ZTSAVE("DTTO")=""
 S ZTSAVE("CONSULTSERVICES(")=""
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
 S SERVICE="" F  S SERVICE=$O(CONSULTSERVICES(SERVICE)) Q:SERVICE=""  D
 . D COUNTS(DTFR,DTTO,.SERVICE)
 . Q
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
COUNTS(DTFR,DTTO,SERVICE) ; build list of exams w/o images
 ;     ^TMP("MAG",$J,SERVICE,EXAMDATE,ACNUMB)=PNAME_"^"_SSN_"^"_PROC
 N COMPLETE,EXAMDATE,GMRCIEN,REVDATE,XDTFR,XDTTO
 ;
 S XDTFR=DTFR-.0001,XDTTO=DTTO+.9999
 ; S XDTFR=9999999.9999-XDTFR ; reverse date & time
 S XDTFR=$$GMRCDATE^MAGDSTA7(XDTFR) ; reverse date & time
 ; S XDTTO=9999999.9999-XDTTO ; reverse date & time
 S XDTTO=$$GMRCDATE^MAGDSTA7(XDTTO) ; reverse date & time
 ;
 ; search completed consult/procedure request
 S COMPLETE=2 ; ORDER STATUS file (#100.01) COMPLETE status
 S REVDATE=XDTFR
 F  S REVDATE=$O(^GMR(123,"AE",SERVICE,COMPLETE,REVDATE),-1) Q:REVDATE=""  Q:REVDATE<DTTO  D
 . S EXAMDATE=9999999.9999-REVDATE ; get regular FM date/time from reverse date/time
 . S GMRCIEN=""
 . F  S GMRCIEN=$O(^GMR(123,"AE",SERVICE,COMPLETE,REVDATE,GMRCIEN)) Q:GMRCIEN=""  D
 . . D LOOKUP(GMRCIEN)
 . . Q
 . Q
 Q
 ;
LOOKUP(GMRCIEN) ;
 N DFN,GMRCACN,FOUND,PNAME,PROC,SENDIT,SSN
 S DFN=$$GET1^DIQ(123,GMRCIEN,.02,"I") Q:DFN=""
 S PNAME=$$GET1^DIQ(2,DFN,.01,"E") Q:PNAME=""
 S SSN=$$GET1^DIQ(2,DFN,.09,"E") Q:SSN=""
 ;
 ; check if the consult is supported by a DICOM modality worklist
 I '$$SERVICE^MAGDHOW1(SERVICE,GMRCIEN) Q  ; no worklist defined
 ;
 ; worklist defined - check if the consult/procedure has images
 ; 
 S GMRCACN=$$GMRCACN^MAGDFCNV(GMRCIEN)
 S FOUND=$$LEGACY(GMRCIEN) ; lookup in legacy database
 I 'FOUND D
 . S FOUND=$$NEWSOP^MAGDSTD2(GMRCACN) ; lookup in new sop class database
 . Q
 I 'FOUND D  ; image(s) not found (or maybe incorrect)
 . S PROC=$$GET1^DIQ(123,GMRCIEN,4,"E") I PROC="" S PROC="CONSULT"
 . S ^TMP("MAG",$J,CONSULTSERVICES(SERVICE),EXAMDATE,GMRCACN)=PNAME_"^"_SSN_"^"_PROC
 . Q
 Q
 ;
LEGACY(GMRCIEN) ; lookup in legacy database
 N FOUND,I,MAGIEN,TIU892591,TIU91NODE,TIUIEN,TIUNODE
 S (FOUND,I)=0
 F  S I=$O(^GMR(123,GMRCIEN,50,I)) Q:'I  D
 . S TIUNODE=$G(^GMR(123,GMRCIEN,50,I,0))
 . I $P(TIUNODE,";",2)="TIU(8925," S TIUIEN=$P(TIUNODE,";",1) D
 . . Q:'TIUIEN
 . . S TIU892591=""
 . . F  S TIU892591=$O(^TIU(8925.91,"B",TIUIEN,TIU892591)) Q:'TIU892591  D
 . . . S TIU91NODE=^TIU(8925.91,TIU892591,0),MAGIEN=$P(TIU91NODE,"^",2)
 . . . I MAGIEN S FOUND=FOUND+$$CHECKMAG(MAGIEN,TIUIEN,TIU892591)
 . . . Q
 . . Q
 . Q
 Q FOUND
 ;
CHECKMAG(MAGIEN,TIUIEN,TIU892591) ;
 ; -- ensure #2005 entry exists --
 I '$D(^MAG(2005,MAGIEN,0)) Q 0 ; no entry in file #2005
 ; -- check if image valid --
 I '$$MAG^MAGDSTD2(MAGIEN) Q 0 ; invalid patient or child entry
 ; -- check #2005 pointer back to #8925.91 --
 I '$$PARENT(MAGIEN,TIUIEN,TIU892591) Q 0 ; bad pointer
 Q 1
 ;
PARENT(MAGIEN,TIUIEN,TIU892591) ; check #2005 pointer back to #8925
 N MAG2,PARENTDFIP,PARENTDFNU,PARENTGRD0
 S MAG2=$G(^MAG(2005,MAGIEN,2)) Q:MAG2="" 0
 S PARENTDFNU=$P(MAG2,"^",6) ; parent data file number
 S PARENTGRD0=$P(MAG2,"^",7) ; parent global root D0
 S PARENTDFIP=$P(MAG2,"^",8) ; parent data file image pointer
 I PARENTDFNU'=8925 Q 0 ; parent file is not TIU
 I PARENTGRD0'=TIUIEN Q 0 ; parent global root D0 not TIUIEN
 I PARENTDFIP'=TIU892591 Q 0 ; parent data file image pointer not TIU892591
 Q 1
 ;
DISPLAY ;
 N ACNUMB,ANS,EXAMDATE,FDATE,LOC,NODE,PNAME,PROC,SSN,STOP,TDATE,X,Y
 S STOP=0,Y=DTFR X ^DD("DD") S FDATE=Y,Y=DTTO X ^DD("DD") S TDATE=Y
 S LOC="" F  S LOC=$O(^TMP("MAG",$J,LOC)) Q:LOC=""  D
 . D HDR I STOP Q
 . S EXAMDATE=0 F  S EXAMDATE=$O(^TMP("MAG",$J,LOC,EXAMDATE)) Q:'EXAMDATE  Q:STOP=1  D
 . . S ACNUMB="" F  S ACNUMB=$O(^TMP("MAG",$J,LOC,EXAMDATE,ACNUMB)) Q:ACNUMB=""  Q:STOP=1  D
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
 W !,?37,"Clinical Specialty Exams without Images in VistA Imaging"
 W !,?93,"From "_FDATE_" to "_TDATE
 W !!,"Medical Service: "_LOC,!
 W !,"Accession",?20,"Patient Name",?53,"Last4",?60,"Exam Date"
 W ?75,"Procedure",!,LN
 Q
