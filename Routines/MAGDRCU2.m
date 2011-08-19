MAGDRCU2 ;WOIFO/PMK - List entries in ^MAG(2006.5839) ; 05/18/2007 11:23
 ;;3.0;IMAGING;**10,11,51,54**;03-July-2009;;Build 1424
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
 ; This routine lists the entries in the temporary Imaging/CPRS Consult
 ; Request Tracking association file
 ;
 ;     XXXX                                         XXX       X
 ;    XX  XX                                         XX      XX
 ;   XX         XXXX    XX XXX  XXXXXXX  XX  XXX     XX     XXXXX
 ;   XX        XX  XX   XXX XX  XX       XX  XX      XX      XX
 ;   XX    X   XX  XX   XX  XX  XXXXXXX  XX  XX      XX      XX
 ;    XX  XX   XX  XX   XX  XX       XX  XX  XX      XX      XX XX
 ;     XXXX     XXXX    XX  XX  XXXXXXX   XXX XX    XXXX      XXX
 ;
 ; Routine 2/2 in for application
 ;
REPORT ; now scan the database and generate the report
 N D0,DATE,DFN,DOB,EXAMDATE,GMRCDFN,GMRCIEN,I,LASTDFN,LASTEXAM
 N MAGIEN,MAGIEN1,NOW,ORDRDATE,PAGE,PID,PNAME,REQTYPE
 N SEX,STATUS,STOP,VA,VAERR,VADM,WRK,X,Y,Z
 ;
 S WRK=$NA(^TMP("MAG",$J,"GMRC"))
 S NOW=$$HTE^XLFDT($H,0)
 K @WRK
 ;
 S D0=0
 I $E(IOST)="C" W !,"Building"
 F  S D0=$O(^MAG(2006.5839,D0)) Q:'D0  S X=^(D0,0) D
 . I $P(X,"^",1)'="123" D
 . . N MSG
 . . S MSG(1)="Problem with Temporary Imaging/CPRS file"
 . . S MSG(2)="Entry #"_D0_" in ^MAG(2006.5839) does not begin"
 . . S MSG(3)="with 123 - it doesn't point to CPRS Consult Request Tracking"
 . . S MSG(4)="Bad record: <<"_X_">>"
 . . D ERROR(.MSG)
 . . Q
 . E  D
 . . S GMRCIEN=$P(X,"^",2),MAGIEN=$P(X,"^",3)
 . . S DFN=$P(^MAG(2005,MAGIEN,0),"^",7)
 . . S GMRCDFN=$$GET1^DIQ(123,GMRCIEN,.02,"I")
 . . I DFN'=GMRCDFN D
 . . . N MSG
 . . . S MSG(1)="DICOM IMAGE PROCESSING ERROR - CONSULT/IMAGING PATIENT MISMATCH"
 . . . S MSG(2)="The image and the consult point to different patients."
 . . . S MSG(3)=""
 . . . S MSG(4)="The Image points to PATIENT file internal entry number "_DFN
 . . . S MSG(5)=$$PATDEMO^MAGDIRVE(DFN)
 . . . S MSG(6)=""
 . . . S MSG(7)="The Consult points to PATIENT file internal entry number "_GMRCDFN
 . . . S MSG(8)=$$PATDEMO^MAGDIRVE(GMRCDFN)
 . . . S MSG(9)=""
 . . . D ERROR(.MSG)
 . . . Q
 . . E  D
 . . . ; check that this is a service of interest
 . . . S SERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . . . I '$D(SERVICE("S",SERVICE)) Q
 . . . ; check cutoff date
 . . . S I=$O(^MAG(2005,MAGIEN,1,0)),MAGIEN1=$P(^(I,0),"^",1)
 . . . S EXAMDATE=$P(^MAG(2005,MAGIEN1,2),"^",1) I EXAMDATE>CUTOFF Q
 . . . S ORDRDATE=$$GET1^DIQ(123,GMRCIEN,.01)
 . . . S ORDRDATE=$P(ORDRDATE,",",1)_","_$E($P(ORDRDATE,",",2),4,5)
 . . . S STATUS=$$GET1^DIQ(123,GMRCIEN,8,"I")
 . . . I '$D(STATUS(STATUS)) D
 . . . . S STATUS(STATUS)=$$GET1^DIQ(100.01,STATUS,.1)
 . . . . Q
 . . . S REQTYPE=$$GET1^DIQ(123,GMRCIEN,13,"I")
 . . . D DEM^VADPT
 . . . S PNAME=VADM(1),PID=VA("PID")
 . . . S DOB=$P(VADM(3),"^",2),SEX=$P(VADM(5),"^",2)
 . . . S (I,@WRK@(0))=$G(@WRK@(0))+1
 . . . S Z=DFN_"^"_PNAME_"^"_PID_"^"_SEX_"^"_DOB
 . . . S Z=Z_"^"_GMRCIEN_"^"_SERVICE_"^"_ORDRDATE_"^"_STATUS
 . . . S Z=Z_"^"_REQTYPE_"^"_EXAMDATE
 . . . S @WRK@(I)=Z
 . . . S @WRK@("P",PNAME,DFN,I)=""
 . . . S @WRK@("D",EXAMDATE\1,PNAME,DFN,I)=""
 . . . I $E(IOST)="C" W:$X>79 ! W "."
 . . . Q
 . . Q
 . Q
 ;
 ; output the report
 ;
 U IO D HEADING
 S STOP=0
 ;
 I "Dd"[SORT D  ; output sorted by examination date
 . S DATE="" F  S DATE=$O(@WRK@("D",DATE)) Q:DATE=""!STOP  D
 . . D NEWLINE(5)
 . . K LASTDFN ; force output of name
 . . S PNAME="" F  S PNAME=$O(@WRK@("D",DATE,PNAME)) Q:PNAME=""!STOP  D
 . . . S DFN="" F  S DFN=$O(@WRK@("D",DATE,PNAME,DFN)) Q:DFN=""!STOP  D
 . . . . S I="" F  S I=$O(@WRK@("D",DATE,PNAME,DFN,I)) Q:I=""!STOP  D
 . . . . . D ONELINE
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 E  D  ; output sorted by name
 . S PNAME="" F  S PNAME=$O(@WRK@("P",PNAME)) Q:PNAME=""!STOP  D
 . . S DFN="" F  S DFN=$O(@WRK@("P",PNAME,DFN)) Q:DFN=""!STOP  D
 . . . S I="" F  S I=$O(@WRK@("P",PNAME,DFN,I)) Q:I=""!STOP  D
 . . . . K LASTEXAM ; force output of examination date
 . . . . D ONELINE
 . . . . Q
 . . . Q
 . . Q
 . Q
 ;
 D ^%ZISC I $D(ZTQUEUED) S ZTREQ="@" ; standard kernel exit
 K @WRK
 Q
 ;
ONELINE ; output one line of the report
 S X=@WRK@(I)
 I DFN'=$G(LASTDFN) D
 . S PID=$P(X,"^",3),SEX=$P(X,"^",4),DOB=$P(X,"^",5)
 . D NEWLINE(4),NEWLINE(3)
 . W PNAME,"   ",PID,"   (",SEX,")   ",DOB
 . S LASTDFN=DFN
 . Q
 S GMRCIEN=$P(X,"^",6),SERVICE=$P(X,"^",7),ORDRDATE=$P(X,"^",8)
 S STATUS=$P(X,"^",9),REQTYPE=$P(X,"^",10),EXAMDATE=$P(X,"^",11)
 S REQTYPE=$S(REQTYPE="C":"Consult",REQTYPE="P":"Procedure",1:"Unknown")
 D NEWLINE(1)
 W "  ",ORDRDATE," (",STATUS(STATUS),") ",$E(SERVICE("S",SERVICE),1,30)
 W "  ",REQTYPE," #",GMRCIEN
 S Y=$$FMTE^XLFDT(EXAMDATE,1),EXAMDATE=$P(Y,",",1)_","_$E($P(Y,",",2),4,5)
 I EXAMDATE'=$G(LASTEXAM) D
 . W ?65,"Exam: ",EXAMDATE
 . S LASTEXAM=EXAMDATE
 . Q
 Q
 ;
NEWLINE(J) ; output a <cr> <lf> with scrolling control or pagination
 N I
 W !
 I $Y<(IOSL-J) Q  ; nothing else to do
 I $E(IOST)="C" D  ; scrolling for a crt
 . N I,X
 . W "more..." R X:DTIME F I=1:1:$X W $C(8,32,8)
 . S $Y=0 Q:X=""
 . S:$TR(X,"quitexnQUITEXN","^^^^^^^^^^^^^^")["^" STOP=1
 . Q
 E  D  ; pagination for a file or a printer
 . F Y=$Y:1:(IOSL-1) W !
 . S PAGE=$G(PAGE)+1 W ?IOM-10,"Page ",PAGE,!
 . D HEADING
 . Q
 Q
 ;
HEADING ; print heading
 W @IOF,TITLE,?IOM-$L(NOW),NOW,!
 I ($L(SUBTITLE(1))+$L(SUBTITLE(2)))<(IOM-4) D
 . W SUBTITLE(1)," -- ",SUBTITLE(2)
 . Q
 E  D
 . W SUBTITLE(1),!,SUBTITLE(2)
 . Q
 W !
 Q
 ;
ERROR(MSG) ; Error Message
 N I
 W ! F I=1:1:80 W "*"
 F I=1:1 Q:'$D(MSG(I))  W !,"*** ",MSG(I),?76," ***"
 W ! F I=1:1:80 W "*"
 Q
 ;
