MAGDIR8R ;WOIFO/PMK - Automatic Import Reconciliation Workflow ; 04 Feb 2009 10:18 AM
 ;;3.0;IMAGING;**53**;Mar 19, 2002;Build 1719;Apr 28, 2010
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
 ;
DISPLAY ;Display a study
 N HEADING ;-- title of display
 N IEN ;------ internal entry number in DATAFILE
 N MACHID ;--- machine id (hostname)
 N MODALITY ;- DICOM modality, for counting how many images
 N NONE ;----- flag indicating whether or not there are studies
 N PNAMEDCM ;- patient name in DICOM format
 N SERIEUID ;- DICOM series instance uid
 N STUDYUID ;- DICOM study instance uid array
 N I,J,K,X
 ;
 S IOF="#" ; remove this later
 ;
 S HEADING="DICOM Images that need to be Reconciled and Imported"
 S X=$$BUILD()
 S NONE=1,MACHID=""
 F  S MACHID=$O(^TMP("MAG",$J,"IRWF",MACHID)) Q:MACHID=""  D
 . D DISPLAY1
 . D CONTINUE
 . Q
 I NONE W !!,"No images to correct" D CONTINUE
 Q
 ;
DISPLAY1 ; Display for one machine 
 N DATA ;----- data about the entry
 D HEADING
 S I=0 F  S I=$O(^TMP("MAG",$J,"IRWF",MACHID,I)) Q:'I  D
 . I '$$GETDATA(I,"LIST",.DATA) Q
 . S NONE=0 ; there are studies to correct
 . I $Y>43 D CONTINUE,HEADING
 . W !,$J(I,3),")"
 . W ?5,$J(DATA("PID"),14) ; DoD pid is 14 characters: FP/123-45-6789
 . W ?20,$E($$NAME(DATA("PNAMEDCM")),1,25)
 . W ?47,DATA("ACNUMB"),?64,$$DATE(DATA("STUDYDAT"),"S")
 . W ?72
 . S MODALITY=""
 . F  S MODALITY=$O(^TMP("MAG",$J,"IRWF",MACHID,I,"MOD",MODALITY)) Q:MODALITY=""  D
 . . W " ",MODALITY,"=",^TMP("MAG",$J,"IRWF",MACHID,I,"MOD",MODALITY)
 . . Q
 . Q
 Q
 ;
HEADING ; output the heading
 N TAB,X
 S X=HEADING_" ("_MACHID_")"
 S TAB=(80-$L(X))/2
 W @IOF,?TAB,X
 W !?TAB,$TR($J("",$L(X))," ","-")
 W !!,"  #",?7,"Patient ID",?22,"DICOM Patient Name"
 W ?49,"Accession #",?66,"Date",?73,"Images"
 W !,"----",?5,"--------------",?20,"-------------------------",?47,"----------------"
 W ?64,"--------",?73,"------"
 Q
 ;
NAME(NAME) ; convert person name from DICOM format to displayable one
 N CHAR,I,X
 S X=""
 F I=1:1:$L(NAME) D
 . S CHAR=$E(NAME,I)
 . I CHAR="^" D
 . . ; the first "^" becomes a comma, while the others become spaces
 . . S X=X_$S($F(NAME,"^")=(I+1):",",1:" ")
 . . Q
 . E  S X=X_$E(NAME,I)
 Q X
 ;
DATE(YYYYMMDD,FORMAT) ; convert date from DICOM format to displayable one
 ; FORMAT: B for birthday mm/dd/yyyy, S for short mm/dd/yy, L for long
 N M
 S FORMAT=$G(FORMAT)
 I FORMAT'="B",FORMAT'="S",FORMAT'="L" Q "Wrong format: "_FORMAT
 I YYYYMMDD="" Q ""
 I YYYYMMDD="<unknown>" Q YYYYMMDD
 I FORMAT="B" Q $E(YYYYMMDD,5,6)_"/"_$E(YYYYMMDD,7,8)_"/"_$E(YYYYMMDD,1,4)
 I FORMAT="S" Q $E(YYYYMMDD,5,6)_"/"_$E(YYYYMMDD,7,8)_"/"_$E(YYYYMMDD,3,4)
 S M=+$E(YYYYMMDD,5,6),M=(3*(M-1))+1
 S M=$E("JanFebMarAprMayJunJulAugSepOctNovDec",M,M+2)
 Q M_" "_(+$E(YYYYMMDD,7,8))_", "_$E(YYYYMMDD,1,4)
 ;
CONTINUE ; prompt
 R !!,"Press <Enter> to continue...",X:$G(DTIME,1E5)
 Q
 ;
BUILD() ;
 N COUNT ;---- count of images
 N DATA ;----- data about the entry
 ;
 K ^TMP("MAG",$J,"IRWF")
 S COUNT=0
 ; prevent update of DATAFILE while someone is starting Importer
 L +^MAGD(2006.5752,0):1E9
 S IEN=0 F  S IEN=$O(^MAGD(2006.5752,IEN)) Q:'IEN  D
 . S X=$$GETDATA(IEN,"IEN",.DATA)
 . S MACHID=DATA("MACHID")
 . S MODALITY=DATA("MODALITY")
 . S STUDYUID=DATA("STUDYUID")
 . S SERIEUID=DATA("SERIEUID")
 . S I=$G(STUDYUID(STUDYUID))
 . I I="" S (I,COUNT)=COUNT+1,STUDYUID(STUDYUID)=COUNT
 . S ^TMP("MAG",$J,"IRWF",MACHID,I,"IEN",SERIEUID,IEN)=""
 . S ^(MODALITY)=$G(^TMP("MAG",$J,"IRWF",MACHID,I,"MOD",MODALITY))+1
 . Q
 L -^MAGD(2006.5752,0)
 Q COUNT
 ;
GETDATA(I,MODE,DATA) ; get the data from the I-th entry in the DATAFILE
 ; if MODE="LIST", then I is the index into the LIST
 ; if MODE="IEN", then I is the actual internal entry number
 N IEN,J,K,SERIEUID,VARS,X
 K DATA Q:'$G(I) 0  Q:'$D(MODE) 0
 I MODE="LIST" D
 . S SERIEUID=$O(^TMP("MAG",$J,"IRWF",MACHID,I,"IEN",""))
 . S IEN=$O(^TMP("MAG",$J,"IRWF",MACHID,I,"IEN",SERIEUID,""))
 . Q
 E  I MODE="IEN" S IEN=I
 E  Q 0
 M X=^MAGD(2006.5752,IEN)
 F J=0:1:3 F K=1:1:$L(X(J),"^") I $P(X(J),"^",K)="<unknown>" S $P(X(J),"^",K)=""
 S VARS(0)="PNAME^PID^MACHID" ; 0 = patient level
 S VARS(1)="STUDYDAT^ACNUMB^STUDYUID" ; 1 = study level
 S VARS(2)="MODALITY^SERIEUID" ; 2 = series level
 S VARS(3)="FROMPATH^IMAGEUID" ; 3 = instance level
 F J=0:1:3 D  ; iterate through the levels
 . F K=1:1:$L(VARS(J),"^") S DATA($P(VARS(J),"^",K))=$P(X(J),"^",K)
 . Q
 S DATA("PNAMEDCM")=$TR(DATA("PNAME"),"|","^") K DATA("PNAME")
 Q 1
 ;
STORE ;  store an entry
 N I,IEN,PNAME,X
 ; patient data
 S PNAME=$TR(PNAMEDCM,"^","|")
 ; patient data
 S X(0)=PNAME_"^"_PID_"^"_MACHID
 ; study data
 S X(1)=STUDYDAT_"^"_ACNUMB_"^"_STUDYUID
 ; series data
 S X(2)=MODALITY_"^"_SERIEUID
 ; object data
 S X(3)=FROMPATH_"^"_IMAGEUID
 ;
 ; prevent update of DATAFILE while someone is starting Importer
 L +^MAGD(2006.5752,0):1E9 ; serialize name generation code
 I '$D(^MAGD(2006.5752,0)) S ^MAGD(2006.5752,0)="Importable DICOM Objects^^0^0"
 S IEN=$P(^MAGD(2006.5752,0),"^",3)+1
 S $P(^MAGD(2006.5752,0),"^",3,4)=IEN_"^"_IEN
 M ^MAGD(2006.5752,IEN)=X
 L -^MAGD(2006.5752,0)
 S ^MAGD(2006.5752,"C",IMAGEUID,IEN)="" ; index by SOP Instance UID
 S ^MAGD(2006.5752,"D",MACHID,FROMPATH,IEN)="" ; index by file path
 Q
 ;
DELETE(IMAGEUID,MACHID,OLDPATH) ; remove an entry
 N RETURN
 L +^MAGD(2006.5752,0):1E9 ; serialize name generation code
 S RETURN=$$DELETE1(IMAGEUID,MACHID,OLDPATH)
 L -^MAGD(2006.5752,0)
 Q RETURN
 ;
DELETE1(IMAGEUID,MACHID,OLDPATH) ; remove the single entry
 N EXIST,IEN,X
 S IEN=$O(^MAGD(2006.5752,"D",MACHID,OLDPATH,"")) Q:'IEN 0
 M X=^MAGD(2006.5752,IEN)
 ; image uid's should match (defined as zero for MAGDRPCA call)
 I IMAGEUID'=$P(X(3),"^",2) D  Q -99
 . K I,MSG
 . S I=0
 . S I=I+1,MSG(I)="IMPORT RECONCILIATION DATABASE FILE DELETION ERROR:"
 . S I=I+1,MSG(I)="The DICOM SOP Instance UIDs don't agree."
 . S I=I+1,MSG(I)="Current UID: "_IMAGEUID
 . S I=I+1,MSG(I)="Previous UID: "_$P(X(3),"^",2)
 . S I=I+1,MSG(I)="Dump of File ^MAGD(2006.5752,"_IEN_")"
 . S I=I+1,MSG(I)="^MAGD(2006.5752,"_IEN_",0)="_X(0)
 . S I=I+1,MSG(I)="^MAGD(2006.5752,"_IEN_",1)="_X(1)
 . S I=I+1,MSG(I)="^MAGD(2006.5752,"_IEN_",2)="_X(2)
 . S I=I+1,MSG(I)="^MAGD(2006.5752,"_IEN_",3)="_X(3)
 . S I=I+1,MSG(I)="Argument 1: "_ARGS
 . S I=I+1,MSG(I)="Argument 2: "_ARG2
 . D BADERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . Q 
 ; remove the entry
 S EXIST=$D(^MAGD(2006.5752,IEN))
 K ^MAGD(2006.5752,IEN)
 K ^MAGD(2006.5752,"C",IMAGEUID,IEN) ; index by SOP Instance UID
 K ^MAGD(2006.5752,"D",MACHID,OLDPATH,IEN) ; index by file path
 L +^MAGD(2006.5752,0):1E9 ; serialize name generation code
 ; Only subtract 1 from #entries, if we're actually deleting one
 I EXIST S $P(^(0),"^",4)=$P(^MAGD(2006.5752,0),"^",4)-1
 L -^MAGD(2006.5752,0)
 Q 0
