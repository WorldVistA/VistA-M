MAGDSTQ ;WOIFO/PMK - Study Tracker - Query/Retrieve user ; Oct 27, 2020@15:45:29
 ;;3.0;IMAGING;**231**;Mar 19, 2002;Build 9;Feb 27, 2015
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
 ;
ENTRYQ ; query only
 N OPTION S OPTION="Q"
 ; setup error trap on VistA. DICOM Gateway already has it.
 I $$VISTA N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 D ENTRY
 Q
 ;
ENTRYQR ; query and retrieve
 N OPTION S OPTION="QR"
 ; setup error trap on VistA. DICOM Gateway already has it.
 I $$VISTA N $ETRAP,$ESTACK S $ETRAP="D ERROR^MAGDSTA"
 D ENTRY
 Q
 ;
ENTRY ; entry point to generate a Query/Retrieve C-FIND-RQ
 N ATTRIB,CHANNEL,DEBUG,DEFAULT,DONE,DONEFLAG,FBSWITCH,FILEMODE,HELP,HOSTNAME,I,INCOMING
 N LOGDIR,KEYCOUNT,KEYLIST,MAGXTMP,MESSAGE,MSGDATE,MSGTIME,MSGHANDL,MULTIMSG
 N ODEVNAME,ODEVTYPE,OUTGOING,PATLKUPMODE,PDUIN,PDUOUT,PORT,PRIORITY,QUEUEIN,QUEUEOUT
 N QUERYLEVEL,QRROOT,QRSCP,QRSTACK,RETRIEVELEVEL,RETURN,ROLE,RUNNING,SAVENODE,SEQNUMB,SEQUENCE
 N SHOWRRSL,SRRDEFAULT,STATNUMB,UID,UIDTYPE,Y,Y1,Y2
 ;
 K ^TMP("MAG",$J,"Q/R QUERY") ; remove all previous query results
 S QRSTACK=1 ; initialize push down stack pointer
 ;
 W !!,$S(OPTION="Q":"Q/R Query",1:"Q/R Query and Retrieve"),!
 ;
 ; get HOSTNAME
 I $$VISTA D
 . S HOSTNAME=$$HOSTNAME^MAGDFCNV
 . Q
 E  D
 . S HOSTNAME=$$HOSTNAME^MAGOSMSC
 . Q
 ;
 S DEFAULT=$G(^TMP("MAG",$J,"Q/R PARAM","QUERY USER APPLICATION"))
 I $L(DEFAULT) D
 . W !,"The PACS Query/Retrieve Provider is """,DEFAULT,"""."
 . I $$YESNO^MAGDSTQ("Do you wish to change it?","n",.X)<0 S QRSCP="" Q
 . I X="YES" D
 . . W !!,"Please select the PACS Query/Retrieve Provider"
 . . S QRSCP=$$QRSCP(DEFAULT)
 . . Q
 . E  S QRSCP=DEFAULT
 . Q
 E  D  ; no default
 . W !,"Please select the PACS Query/Retrieve Provider"
 . S QRSCP=$$QRSCP()
 . Q
 I QRSCP="" Q
 ;
 S MAGXTMP=$$INITXTMP^MAGDSTQ0
 ;
 S ^TMP("MAG",$J,"Q/R PARAM","QUERY USER APPLICATION")=QRSCP
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=QRSCP
 ;
 ; get Q/R root and set default level
 I '$D(^TMP("MAG",$J,"Q/R PARAM","ROOT")) S ^("ROOT")="PATIENT"
 ; ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")is needed as a Q/R key
 S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")=^TMP("MAG",$J,"Q/R PARAM","ROOT")
 S ATTRIB="ROOT" D QRROOT^MAGDSTQ1
 S (QRROOT,^("QUERY LEVEL"))=^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")
 S ^TMP("MAG",$J,"Q/R PARAM","ROOT")=QRROOT
 ;
 ;
 S DONE=0
 F  D  Q:DONE
 . S KEYCOUNT=$$KEYLIST^MAGDSTQ0(.KEYLIST) ; initialize KEYLIST
 . S RETURN=$$GETKEYS
 . I RETURN<0 S DONE=1 Q
 . ;
 . I RETURN=1 D  ; query
 . . D PUSH^MAGDSTQ0(.QRSTACK) ; add the q/r key entry to the stack
 . . I $$VISTA D  ; code for VistA
 . . . D ENTRY^MAGDSTV1("Q")
 . . . Q
 . . E  D  ; code for DICOM Gateway
 . . . W !,"Performing Query..."
 . . . D ^MAGDSTQ2 ; do the query
 . . . D ENTRY^MAGDSTQ3("GATEWAY") ; process the results
 . . . Q
 . . Q
 . ;
 . I RETURN=2 D  ; retrieve
 . . K ^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"Q/R RETRIEVE STATUS")
 . . S SRRDEFAULT=$G(SRRDEFAULT,"n")
 . . W !!,"Show Retrieve Results?  ",SRRDEFAULT,"// "
 . . R X:DTIME E  S X="^"
 . . I X="" S X=SRRDEFAULT W X
 . . I "^"[X Q
 . . S SHOWRRSL=$S("Yy"[X:1,1:0)
 . . S SRRDEFAULT=$S(SHOWRRSL:"y",1:"n")
 . . I $$VISTA D  ; code for VistA
 . . . D ENTRY^MAGDSTV1("R",.SHOWRRSL)
 . . . Q
 . . E  D  ; code for DICOM Gateway
 . . . S RUNNING=$$ENTRY^MAGDSTR1(SHOWRRSL,"GATEWAY",MAGXTMP,$$HOSTNAME^MAGOSMSC,$J,QRSTACK)
 . . . I 'RUNNING D
 . . . . W !!,"*** Please start ""2-14-2 Execute C-MOVE Request to Retrieve Images"" ***"
 . . . . D CONTINUE
 . . . . S SHOWRRSL=0
 . . . . Q
 . . . Q
 . . I SHOWRRSL D
 . . . D RETRIEVE^MAGDSTQ8
 . . . Q
 . . Q
 . ;
 . I RETURN=3 D  ; back
 . . D DISPLAY^MAGDSTQ5
 . . Q
 . Q
 Q
 ;
QRSCP(DEFAULT) ; get the PACS Q/R Provider
 S DEFAULT=$G(DEFAULT)
 I $$VISTA D
 . S QRSCP=$$PICKSCP^MAGDSTQ9(DEFAULT,"Q/R")
 . Q
 E  D  ; ^MAGDACU routine on DICOM Gateway only
 . S QRSCP=$$PICKSCP^MAGDACU(DEFAULT,"Q/R")
 . Q
 Q QRSCP
 ;
GETKEYS() ; get the keys for Q/R query
 N DONE,I,N,T
 S DONE=0 F  D  Q:DONE
 . D DISPLAY
 . W !!!,"Enter 1-",KEYCOUNT," " I OPTION="QR" D
 . . W "for key, ""B"" for back, ""Q"" to query, ""R"" to retrieve, ""^"" to exit: "
 . . Q
 . E  D
 . . W "to change a key, ""B"" for back, ""Q"" to query, ""^"" to exit: "
 . . Q
 . R N:DTIME E  S N="^"
 . I N?1N.N,N>0,N<(KEYCOUNT+1) D
 . . S ATTRIB=$P(KEYLIST(N),"|",1)
 . . S DEFAULT=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB))
 . . D @$P(KEYLIST(N),"|",2)
 . . Q
 . I N="^" D  Q
 . . K ^TMP("MAG",$J,"Q/R QUERY")
 . . K ^XTMP(MAGXTMP,HOSTNAME,$J)
 . . S DONE=-1
 . . Q
 . I (N="B")!(N="b") D
 . . K ^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE") ; remove any previous query error message
 . . S DONE=3
 . . Q
 . ;
 . I QRROOT="" D  Q
 . . W !!,"Query/Retrieve Root must be defined"
 . . Q
 . ;
 . I (N="Q")!(N="q") D
 . . S QUERYLEVEL=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL"))
 . . I $$CHECKQRY^MAGDSTQ S DONE=1
 . . Q
 . I (N="R")!(N="r") D
 . . I OPTION'="QR" W !,"Retrieve requires query/retrieve menu option" R X:DTIME Q
 . . S RETRIEVELEVEL=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"RETRIEVE LEVEL"))
 . . I $$CHECKRTV^MAGDSTQ S DONE=2
 . . Q
 . Q
 Q DONE
 ;
DISPLAY ;
 N ATTRIB,I,TAB,X
 S X="SELECT QUERY"
 I OPTION="QR" S X=X_"/RETRIEVE"
 S X=X_" KEYS"
 ; S X=X_"  STACK: "_QRSTACK ; SHOW QRSTACK
 S TAB=27-($L(X)/2)
 W @IOF,?TAB,X,?66," Root: ",QRROOT
 W !?TAB F I=1:1:$L(X) W "-"
 W ?66,"Level: ",QUERYLEVEL
 F I=1:1:KEYCOUNT D
 . S ATTRIB=$P(KEYLIST(I),"|",1)
 . W !,$J($P(ATTRIB,"(",1),25) W:I<10 " " W " (",I,") : "
 . W $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,ATTRIB))
 . Q
 Q
 ;
 ; Check query keys for minimum required values
 ;
CHECKQRY() ; check query keys to prevent broad queries
 N OK S OK=0
 I QUERYLEVEL="" D
 . W !!,"QUERY LEVEL must be defined"
 . Q
 E  I QUERYLEVEL="PATIENT" D
 . I $$CHECKPTQ S OK=1
 . E  W !!,"Patient Root Patient Level queries requires either the patient name, ID, or DOB."
 . Q
 E  I QUERYLEVEL="STUDY" D
 . I $$CHECKSTQ S OK=1
 . E  D
 . . I QRROOT="PATIENT" D
 . . . W !!,"Study queries require the Patient ID and accession number, study date, or UID."
 . . . Q
 . . E  D  ; QRROOT="STUDY"
 . . . W !!,"Study queries require patient info, accession number, study date or Study UID."
 . . . Q
 . . Q
 . Q
 E  I QUERYLEVEL="SERIES" D
 . I $$CHECKSEQ S OK=1
 . E  D
 . . I QRROOT="PATIENT" D
 . . . W !!,"Series queries require the Patient ID and the Study Instance UID."
 . . . Q
 . . E  D  ; QRROOT="STUDY"
 . . . W !!,"Series queries require the Study Instance UID."
 . . . Q
 . . Q
 . Q
 E  I QUERYLEVEL="IMAGE" D
 . I $$CHECKIMQ S OK=1
 . E  D
 . . I QRROOT="PATIENT" D
 . . . W !!,"Image queries require the Patient ID and the Study and Series Instance UIDs."
 . . . Q
 . . E  D  ; QRROOT="STUDY"
 . . . W !!,"Image queries require the Study and Series Instance UIDs."
 . . . Q
 . . Q
 . Q
 I 'OK D CONTINUE^MAGDSTQ
 Q OK
 ;
CHECKPTQ() ; check attributes for a patient level query
 N OK S OK=0
 I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT NAME"))'="" S OK=1
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID"))'="" S OK=1
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT BIRTH DATE"))'="" S OK=1
 Q OK
 ;
CHECKSTQ() ; check attributes for a study level query
 N OK S OK=0
 I $$CHECKPTQ() S OK=1
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ACCESSION NUMBER"))'="" S OK=1
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY DATE"))'="" S OK=1
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)"))'="" S OK=1
 Q OK
 ;
CHECKSEQ() ; check attributes for a series level query
 N OK S OK=0
 I QRROOT="STUDY" S OK=1 ; study root doesn't need patient id
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID"))'="" S OK=1
 I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)"))'="" S OK=OK+1
 Q OK=2
 ;
CHECKIMQ() ; check attributes for an image level query
 N OK S OK=0
 I QRROOT="STUDY" S OK=1 ; study root doesn't need patient id
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID"))'="" S OK=1
 I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)"))'="" S OK=OK+1
 I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES INSTANCE UID(0001)"))'="" S OK=OK+1
 Q OK=3
 ;
 ;
 ; Check retrieve keys for minimum required values
 ;
CHECKRTV() ; check retrieve keys to prevent broad retrieves
 N OK,X S OK=0
 I RETRIEVELEVEL="" D
 . W !!,"RETRIEVE LEVEL must be defined"
 . Q
 E  I RETRIEVELEVEL="PATIENT" D
 . I $$CHECKPTR D
 . . W !!,"This will retrieve all of the images for all the studies for this patient."
 . . I $$YESNO("Are you sure that you want to do this?","NO!",.X)<0 Q
 . . I X="YES" S OK=1
 . . Q
 . E  W !!,"Patient Root Patient Level retrieves require the PATIENT ID."
 . Q
 E  I RETRIEVELEVEL="STUDY" D
 . I $$CHECKPTR,$$CHECKSTR S OK=1
 . E  D
 . . I QRROOT="PATIENT" D
 . . . W !!,"Study Level retrieves require the Patient ID and STUDY INSTANCE UID."
 . . . Q
 . . E  D  ; QRROOT="STUDY"
 . . . W !!,"Study Level retrieves require the STUDY INSTANCE UID."
 . . . Q
 . . Q
 . Q
 E  I RETRIEVELEVEL="SERIES" D
 . I $$CHECKPTR,$$CHECKSTR,$$CHECKSER S OK=1
 . E  D
 . . I QRROOT="PATIENT" D
 . . . W !!,"Series retrieves require the Patient ID and STUDY and Series INSTANCE UIDs."
 . . . Q
 . . E  D  ; QRROOT="STUDY"
 . . . W !!,"Series retrieves requires the STUDY and SERIES INSTANCE UIDs."
 . . . Q
 . . Q
 . Q
 E  I RETRIEVELEVEL="IMAGE" D
 . I $$CHECKPTR,$$CHECKSTR,$$CHECKSER,$$CHECKIMR S OK=1
 . E  D
 . . I QRROOT="PATIENT" D
 . . . W !!,"Image retrieves require the Patient ID and STUDY, Series, and SOP INSTANCE UIDs."
 . . . Q
 . . E  D  ; QRROOT="STUDY"
 . . . W !!,"Image retrieve requires the STUDY, SERIES, and SOP INSTANCE UIDs."
 . . . Q
 . . Q
 . Q
 I 'OK D CONTINUE^MAGDSTQ
 Q OK
 ;
CHECKPTR() ; check attributes for a patient level retrieve
 N OK S OK=0
 I QRROOT="STUDY" S OK=1 ; study root doesn't need patient id
 E  I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"PATIENT ID"))'="" S OK=1
 Q OK
 ;
CHECKSTR() ; check attributes for a study level retrieve
 N OK S OK=0
 I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"STUDY INSTANCE UID(0001)"))'="" S OK=1
 Q OK
 ;
CHECKSER() ; check attributes for a series level retrieve
 N OK S OK=0
 I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SERIES INSTANCE UID(0001)"))'="" S OK=1
 Q OK
 ;
CHECKIMR() ; check attributes for an image level retrieve
 N OK S OK=0
 I $G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"SOP INSTANCE UID(0001)"))'="" S OK=1
 Q OK
 ;
 ;
 ;
YESNO(PROMPT,DEFAULT,CHOICE,HELP) ; generic YES/NO question driver
 N I,OK,X
 S OK=0 F  D  Q:OK
 . W !!,PROMPT," " I $L($G(DEFAULT)) W DEFAULT,"// "
 . R X:DTIME E  S X="^"
 . I X="",$L($G(DEFAULT)) S X=DEFAULT W X
 . I X="",'$L($G(DEFAULT)) S X="*" ; fails Y/N tests
 . I X["^" S CHOICE="^",OK=-1 Q
 . I "Yy"[$E(X) S CHOICE="YES",OK=1 Q
 . I "Nn"[$E(X) S CHOICE="NO",OK=1 Q
 . I X["?",$D(HELP) D
 . . W !
 . . F I=1:1 Q:'$D(HELP(I))  W !,HELP(I)
 . . Q
 . E  W "   ??? - Please enter ""Yes"" or ""No"""
 . Q
 Q OK
 ;
CONTINUE(ERASE) ; used by several routines on VistA and DICOM Gateway
 N X
 I $E(IOST,1,2)'="C-" Q  ; only ask for terminal I/O jobs
 S ERASE=$G(ERASE,0) I 'ERASE W !!
 W "Press <Enter> to continue..."
 R X:$G(DTIME,300)
 I ERASE D
 . F  Q:$X=0  W @IOBS," ",@IOBS ; erase the line
 . Q
 Q
 ;
VISTA() ;
 ; return 1 for running in VistA namespace, 0 otherwise
 Q $D(^MAG(2005,0)) ; this should exist only on VistA
