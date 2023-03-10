MAGDSTQ6 ;WOIFO/PMK - Study Tracker - Patient Level Query/Retrieve Display; Sep 02, 2020@11:29:05
 ;;3.0;IMAGING;**231**;Mar 19, 2002;Build 9;Aug 30, 2013
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
 ; Notice: This routine is on both VistA and the DICOM Gateway
 ;
 ;
 Q
 ;
PATIENT() ;
 N VAR S VAR=""
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"PATIENT",JPATIENT,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 W "Name: ",$$NAME^MAGDSTQ6(PNAME)
 W ?47,"DOB: ",$$DATE^MAGDSTQ6(DOB,"SHORT")
 W ?65,"Sex: ",SEX
 W !?2,"ID: ",PID
 W ?47,"Ethnicity: ",ETHNICITY
 W !,"Other PID: ",PIDOTHER
 W !
 ;
 ; quit at this point if there are studies for the patient
 I $G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",JPATIENT)) Q 0
 ;
 D NUMBERS
 ;
 I $$YESNO^MAGDSTQ("Is this the correct Patient?","n",.X)<0 Q CARET
 I "Yy"'[$E(X) Q INCORRECT
 ;
 D SETKEYS(LEVEL)
 Q JPATIENT
 ;
STUDY() ; display a study and select it
 N PROMPT
 S RETURN=$$PATIENT() ; ignore RETURN
 ;
 N VAR S VAR=""
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",JPATIENT,JSTUDY,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 W !,"Accession No: ",ACNUMB
 W ?55,"Study Date: ",$$DATE^MAGDSTQ6(STUDYDATE,"SHORT")
 W !,"Description: ",DESCRIPTION
 W ?55,"Study Time: ",$$TIME^MAGDSTQ6(STUDYTIME)
 W !,"Study ID: ",STUDYID
 I CPTCODE W ?55,"CPT Code: ",CPTCODE,?72,CPTNAME
 ;
 W !!,"Requesting Physician: ",$$NAME^MAGDSTQ6(REQDOC)
 W !,"Referring  Physician: ",$$NAME^MAGDSTQ6(REFDOC)
 W !,"Institution: ",INSTNAME
 W !
 I REASON'="" W !,"Reason for Study:",REASON,!
 ;
 ; quit at this point if there are series for the patient and study
 I $G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,JSTUDY)) Q 0
 ;
 D NUMBERS
 W !
 I MODALITIES'="" D  ; Modalities in Study (0008,0061)
 . W !,$S(MODALITIES[",":"Modalities",1:"Modality")
 . W ": ",MODALITIES,!
 . Q
 ;
 D UID
 ;
 I $$YESNO^MAGDSTQ("Is this the correct Patient and Study?","n",.X)<0 Q CARET
 I "Yy"'[$E(X) Q INCORRECT
 ; 
 D SETKEYS(LEVEL)
 Q JSTUDY
 ;
SERIES() ;
 N PROMPT
 S RETURN=$$STUDY()   ; ignore RETURN
 ;
 N VAR S VAR=""
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,JSTUDY,JSERIES,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 ;
 ; quit at this point if there are images for the patient, study, and series
 I $G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",JPATIENT,JSTUDY,JSERIES)) D  Q 0
 . S MODALITY=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"MODALITY"))
 . W !,"Modality: ",MODALITY,"        Series Number: ",SERIESNO
 . Q
 D NUMBERS
 W !!,"Modality: ",MODALITY,"        Series Number: ",SERIESNO,!
 D UID
 ;
 I $$YESNO^MAGDSTQ("Is this the correct Patient, Study, and Series?","n",.X)<0 Q CARET
 I "Yy"'[$E(X) Q INCORRECT
 ;
 D SETKEYS(LEVEL)
 Q JSERIES
 ;
IMAGE() ;
 S RETURN=$$SERIES()  ; ignore RETURN
 ;
 W !!,"Image attributes:"
 N VAR S VAR=""
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",JPATIENT,JSTUDY,JSERIES,JIMAGE,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 W !,"Image Number: ",IMAGENO
 D UID
 ;
 I $$YESNO^MAGDSTQ("Is this the correct Patient, Study, Series, and Image?","n",.X)<0 Q CARET
 I "Yy"'[$E(X) Q INCORRECT
 ;
 D SETKEYS(LEVEL)
 Q JIMAGE
 ;
SETKEYS(LEVEL) ; set query/retrieve keys
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE LEVEL")=LEVEL ; retrieve at same level
 ; save patient q/r keys
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"PATIENT",JPATIENT,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT NAME")=PNAME
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID")=PID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT BIRTH DATE")=DOB
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT'S SEX")=SEX
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"OTHER PATIENT IDS")=PIDOTHER
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ETHNICITY")=ETHNICITY
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"NPATIENTRST")=NPATIENTRST
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"NPATIENTRSE")=NPATIENTRSE
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"NPATIENTRI")=NPATIENTRI
 I LEVEL="PATIENT" S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="STUDY" Q
 ;
 ; save study q/r keys
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",JPATIENT,JSTUDY,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ACCESSION NUMBER")=ACNUMB
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"DESCRIPTION")=DESCRIPTION
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"INSTITUTION NAME")=INSTNAME
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY ID")=STUDYID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)")=STUDYUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY DATE")=STUDYDATE
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY TIME")=STUDYTIME
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"REFERRING PHYSICIAN")=REFDOC
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"NSTUDYRS")=NSTUDYRS
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"NSTUDYRI")=NSTUDYRI
 I LEVEL="STUDY" S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="SERIES" Q
 ; 
 ; save series q/r keys
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,JSTUDY,JSERIES,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"MODALITY")=MODALITY ; (0008,0060) Modality
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES NUMBER")=SERIESNO
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES INSTANCE UID(0001)")=SERIESUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"NSERIESRI")=NSERIESRI
 I LEVEL="SERIES" S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="IMAGE" Q
 ; 
 ; save image q/r keys
 F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",JPATIENT,JSTUDY,JSERIES,JIMAGE,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SOP INSTANCE UID(0001)")=SOPUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="IMAGE"
 Q 
 ;
NUMBERS ; output patient, study, and series related counts
 N NPATIENTRST,NPATIENTRSE,NPATIENTRI,NSTUDYRS,NSTUDYRI,NSERIESRI
 I $G(JPATIENT) D
 . I LEVEL="PATIENT" D
 . . S NPATIENTRST=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"PATIENT",JPATIENT,"NPATIENTRST"))
 . . S NPATIENTRSE=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"PATIENT",JPATIENT,"NPATIENTRSE"))
 . . S NPATIENTRI=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"PATIENT",JPATIENT,"NPATIENTRI"))
 . . W !,"Number of Patient Related Studies: ",NPATIENTRST
 . . W ",  Series: ",NPATIENTRSE
 . . W ",  Images: ",NPATIENTRI
 . . Q
 . I $G(JSTUDY) D
 . . I LEVEL="STUDY" D
 . . . S NSTUDYRS=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",JPATIENT,JSTUDY,"NSTUDYRS"))
 . . . S NSTUDYRI=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",JPATIENT,JSTUDY,"NSTUDYRI"))
 . . . W !,"Number of Study Related Series: ",NSTUDYRS
 . . . W ",  Images: ",NSTUDYRI
 . . . Q
 . . I $G(JSERIES) D
 . . . I LEVEL="SERIES" D
 . . . . S NSERIESRI=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,JSTUDY,JSERIES,"NSERIESRI"))
 . . . . W !,"Number of Series Related Images: ",NSERIESRI
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
UID ;
 I $G(STUDYUID)'="" D
 . W !,"Study UID: ",STUDYUID
 . Q
 I $G(SERIESUID)'="" D
 . W !,"Series UID:",SERIESUID
 . Q
 I $G(SOPUID)'="" D
 . W !,"SOP UID: ",SOPUID
 . I SOPCLASS'="" D
 . . W !,"SOP Class: "
 . . I $$VISTA^MAGDSTQ D  ; code for VistA
 . . . N IPTR
 . . . S IPTR=$O(^MAGDICOM(2006.539,"B",SOPCLASS,""))
 . . . I IPTR="" W "*** Unknown UID: <<",SOPCLASS,">> ***"
 . . . E  W $P(^MAGDICOM(2006.539,IPTR,0),"^",2)
 . . . Q
 . . E  I '$$VISTA^MAGDSTQ D  ; code for DICOM Gateway
 . . . W $$GETNAME^MAGDUID2(SOPCLASS)
 . . . Q
 . . Q
 . Q
 W !
 Q
 ;
NAME(DCMNAME) ; convert a DICOM person name to a readable format
 N FIRST,LAST,MIDDLE,NAME,PREFIX,SUFFIX
 I DCMNAME="" Q ""  ; no name
 I DCMNAME="<unknown>" Q DCMNAME
 S LAST=$P(DCMNAME,"^",1),FIRST=$P(DCMNAME,"^",2)
 S MIDDLE=$P(DCMNAME,"^",3)
 S PREFIX=$P(DCMNAME,"^",4),SUFFIX=$P(DCMNAME,"^",5)
 S NAME=LAST I (FIRST'="")!(MIDDLE'="") S NAME=NAME_","
 I FIRST'="" S NAME=NAME_FIRST
 E  S NAME=NAME_" <no first name>"
 I MIDDLE'="" S NAME=NAME_" "_MIDDLE
 I PREFIX'="" S NAME="("_PREFIX_") "_NAME
 I SUFFIX'="" S NAME=NAME_" ("_SUFFIX_")"
 Q NAME
 ;
DATE(DCMDATE,FORMAT) ; convert a DICOM date to a readable date
 N DATE,DAY,MONTH,YEAR
 I DCMDATE="<unknown>" Q "???"
 S FORMAT=$G(FORMAT,"LONG")
 S YEAR=$E(DCMDATE,1,4),MONTH=+$E(DCMDATE,5,6),DAY=+$E(DCMDATE,7,8)
 I FORMAT="SHORT" D
 . S:MONTH<10 MONTH="0"_MONTH S:DAY<10 DAY="0"_DAY
 . S DATE=MONTH_"/"_DAY_"/"_YEAR
 . Q
 E  D
 . S MONTH=$P("January,February,March,April,May,June,July,August,September,October,November,December",",",MONTH)
 . S DATE=DAY_" "_MONTH_" "_YEAR
 . Q
 Q DATE
 ;
TIME(DCMTIME) ; convert a DICOM time to a readable time
 N HOUR,MINUTE,SECOND,TIME
 S HOUR=$E(DCMTIME,1,2),MINUTE=$E(DCMTIME,3,4),SECOND=$E(DCMTIME,5,6)
 S TIME=HOUR_":"_MINUTE_":"_SECOND
 Q TIME
