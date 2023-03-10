MAGDSTAB ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Mar 04, 2022@14:35:44
 ;;3.0;IMAGING;**231,306,305**;Mar 19, 2002;Build 3
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
 ; Supported IA #10061 reference DEM^VADPT subroutine call
 ; Supported IA #2541 reference $$KSP^XUPARAM function call
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ;
 Q
 ;
 ; QUERY and RETRIEVE are called by MAGDSTAA when
 ; there are no images for the study on VistA
 ; 
 ; They is used to retrieve all the images for a study.
 ; 
 ; There are two steps to the process.
 ; First, a query is performed to obtain the Study Instance UID
 ; Second, the retrieve is performed using the Study Instance UID
 ; 
 ; If it is "query only mode" then, just the first step is done.
 ; 
 ; Study Root Study Level query and retrieve are used,
 ; so ALL the images for the study are retrieved.
 ; 
 ; Note: Patient identification information is not used
 ;
FINDSUID(ACNUMB,SSN,PACSSTUDYUID,SERIESCOUNT,IMAGECOUNT) ; get study instance uid
 N I,L,RETURN
 ;
 ; check that accession number exists
 I $G(ACNUMB)="" Q "-1,No Accession Number" ; nope
 ;
 K ^TMP("MAG",$J,"Q/R QUERY")
 I IMAGINGSERVICE="RADIOLOGY" D  ; add accession number prefix to legacy radiology acn's
 . S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ACCESSION NUMBER")=$S($L(ACNUMB,"-")<3:$$ANPREFIX_ACNUMB,1:ACNUMB)
 . Q
 E  S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ACCESSION NUMBER")=ACNUMB
 ;
 ; P305 PMK 11/17/2021 - make last four digits optional
 ; 
 I $$ACNLAST4="Y" D  ; default is NO
 . ; P306 PMK 06/11/2021 - add last four digits of SSN (MRN) to PATIENT ID to make query unique
 . ;   when there are multiple studies with same accession because of PACS merges
 . S L=$L(SSN) ; length of SSN=9; MRN may have a different length
 . S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID")="*"_$E(SSN,L-3,L) ; * + last four digits
 . Q
 ;
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=$$QRSCP^MAGDSTA8
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")="STUDY"
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")="STUDY"
 D SOPUIDQ^MAGDSTV1 ; C-FIND
 ; 
 ; Note: There may be multiple study instance UIDs for a study
 S (SERIESCOUNT,IMAGECOUNT)=0
 F I=1:1 Q:'$D(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,I))  D
 . ; get PACS Study UIDs
 . S PACSSTUDYUID(I)=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,I,"STUDYUID"))
 . ; get number of study related series and study related sop instances
 . S SERIESCOUNT=SERIESCOUNT+$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,I,"NSTUDYRS"))
 . S IMAGECOUNT=IMAGECOUNT+$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,I,"NSTUDYRI"))
 . Q
 Q ""
 ;
 ;
MOVEALL() ; retrieve all the images for the study
 N ERROR,I
 ;
 S ERROR=""
 ; Note: There may be multiple study instance UIDs for a study
 F I=1:1 Q:'$D(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,I))  D  Q:ERROR
 . ; get the Study Instance UID needed to perform the retrieve
 . S STUDYUID=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1,I,"STUDYUID"))
 . S ERROR=$$MOVEALL1(STUDYUID)
 . I ERROR Q
 . Q 
 Q ERROR
 ;
MOVEALL1(STUDYUID) ; retrieve all the images for the Study Instance UID
 ; retrieve the whole study
 S STUDYUID=$G(STUDYUID)
 I STUDYUID="" Q "-1,No Study UID"
 ;
 K ^TMP("MAG",$J,"Q/R QUERY")
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)")=STUDYUID
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=$$QRSCP^MAGDSTA8
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE LEVEL")="STUDY"
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")="STUDY"
 D SOPUIDR^MAGDSTV1 ; C-MOVE
 Q ""
 ;
PARM ; set query/retrieve site parameters
 N ANPREFIX,IEN,KSITEPAR
 S KSITEPAR=$$KSP^XUPARAM("INST")
 S IEN=$O(^MAG(2006.1,"B",KSITEPAR,""))
 ;
 ; get the accession number prefix, if there is one
 S ANPREFIX=$$GETANPFX^MAGDSTQ1($$ANPREFIX)
 S $P(^MAG(2006.1,IEN,7),"^",3)=ANPREFIX
 ;
 ; get the patient identifier dash or no dash
 S DEFAULT=$$DASHES
 I $$YESNO^MAGDSTQ("Include dashes in the DICOM Patient Identifier?",DEFAULT,.X)<0 Q
 S $P(^MAG(2006.1,IEN,7),"^",4)=$E(X)
 ;
 ; get the patient identifier last 4 or no last 4
 S DEFAULT=$$ACNLAST4
 I $$YESNO^MAGDSTQ("Use LAST 4 in the PID with Accession Number in the automatic query?",DEFAULT,.X)<0 Q
 S $P(^MAG(2006.1,IEN,7),"^",7)=$E(X)
 ;
 ; get the check study division switch
 N HELP
 S HELP(1)="If there are VistA Imaging file servers at other divisions, answer ""Y""."
 S HELP(2)="  Then only studies for this division will be processed,"
 S HELP(3)="  and those for the other divisions will be ignored."
 S HELP(4)=""
 S HELP(5)="If there is only one VistA Imaging file server for all divisions, answer ""N""."
 S HELP(6)="  Then all the studies will be processed."
 S DEFAULT=$$CHECKDIV
 I $$YESNO^MAGDSTQ("Select only studies for the current division for auto compare/retrieve?",DEFAULT,.X,.HELP)<0 Q 
 S $P(^MAG(2006.1,IEN,8),"^",1)=$E(X)
 ;
 D CONTINUE^MAGDSTQ
 Q
 ;
ANPREFIX() ; Get the value of the accession number prefix
 N IEN,KSITEPAR
 S KSITEPAR=$$KSP^XUPARAM("INST")
 S IEN=$O(^MAG(2006.1,"B",KSITEPAR,""))
 Q $$GET1^DIQ(2006.1,IEN,206)
 ;
DASHES() ; Get the value of the patient identifier dashes
 N IEN,KSITPAR
 S KSITEPAR=$$KSP^XUPARAM("INST")
 S IEN=$O(^MAG(2006.1,"B",KSITEPAR,""))
 Q $$GET1^DIQ(2006.1,IEN,207,"I")
 ;
ACNLAST4() ; Get the value of the last 4 query key
 N IEN,KSITEPAR
 S KSITEPAR=$$KSP^XUPARAM("INST")
 S IEN=$O(^MAG(2006.1,"B",KSITEPAR,""))
 Q $$GET1^DIQ(2006.1,IEN,210,"I")
 ;
CHECKDIV() ; Get the value of the check study division switch
 N IEN,KSITEPAR
 S KSITEPAR=$$KSP^XUPARAM("INST")
 S IEN=$O(^MAG(2006.1,"B",KSITEPAR,""))
 Q $$GET1^DIQ(2006.1,IEN,211,"I")
 ;
