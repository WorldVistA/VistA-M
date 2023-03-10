MAGDSTQ5 ;WOIFO/PMK - Study Tracker - Patient Level Query/Retrieve Display; Jul 23, 2020@07:39:54
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
DISPLAY ;
 ; the values of the following four status is important
 N INCORRECT S INCORRECT=-1 ; incorrect selection
 N NOTSELECTED S NOTSELECTED=-2 ; proposed selection not selected
 N CARET S CARET=-3 ; caret (^) indicator
 ;
 N JPATIENT,JSTUDY,JSERIES,JIMAGE ; IENs
 N SETKEYS S SETKEYS=0 ; query keys are set for the next operation
 N HIT ; flag indicated that a patient, study, series, image(s) were selected
 N REPEAT ; loop control
 N RETURN
 ;
 I $D(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE","MSG",0)) D  Q
 . ; display the message, decrement QRSTACK and quit
 . N I
 . F I=1:1:^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"MESSAGE","MSG",0) W !,^(I)
 . D CONTINUE^MAGDSTQ
 . D POP^MAGDSTQ0(.QRSTACK) ; remove the last q/r key entry from the stack
 . Q
 ;
 S HIT=0,REPEAT=1
 F  D  Q:'REPEAT
 . S RETURN=$$DISPLAY1()
 . I HIT S REPEAT=0 Q
 . ; check for going back - RETURN should be 0 for QRSTACK=1
 . I 'RETURN S X="YES" ; ignore prompt
 . E  D  ; do prompt
 . . W !!,"Nothing selected -- Exit display of query results?"
 . . R "  y// ",X:DTIME E  S X="^"
 . . Q
 . I X="" S X="y" W X
 . I "Yy"[$E(X) D
 . . S REPEAT=0
 . . D POP^MAGDSTQ0(.QRSTACK) ; remove the last q/r key entry from the stack
 . . Q
 . Q
 Q
 ;
DISPLAY1() ; select the patient
 N N,REPEAT,RETURN1,RETURN2
 S N=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"PATIENT"),0)
 I N=0 Q 0 ; no patient data
 ;
 S REPEAT=1
 F  D  Q:'REPEAT
 . I N=1,$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",1),0) D
 . . S JPATIENT=1
 . . S RETURN1=0
 . . Q
 . E  D  Q:'REPEAT  ; N>1
 . . S RETURN1=$$MULTIPLE("PATIENT",N)
 . . I RETURN1=INCORRECT Q
 . . I RETURN1>0 S HIT=1 ; patient selected
 . . I RETURN1'=0 S REPEAT=0 Q
 . . Q
 . S RETURN2=$$DISPLAY2()
 . I HIT S REPEAT=0
 . I RETURN2=NOTSELECTED,N=1 S REPEAT=0,RETURN1=NOTSELECTED
 . Q
 Q RETURN1
 ;
DISPLAY2() ; select the study
 N N,REPEAT,RETURN1,RETURN2
 I '$D(JPATIENT) Q 0 ; no patient selected
 S N=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",JPATIENT),0)
 I N=0 Q 0 ; no study data
 ;
 S REPEAT=1
 F  D  Q:'REPEAT
 . I N=1,$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,1),0) D
 . . S JSTUDY=1
 . . S RETURN1=0
 . . Q
 . E  D  Q:'REPEAT  ; N>1
 . . S RETURN1=$$MULTIPLE("STUDY",N)
 . . I RETURN1=INCORRECT Q
 . . I RETURN1>0 S HIT=1 ; study selected
 . . I RETURN1'=0 S REPEAT=0 Q
 . . Q
 . S RETURN2=$$DISPLAY3()
 . I HIT S REPEAT=0
 . I RETURN2=NOTSELECTED,N=1 S REPEAT=0,RETURN1=NOTSELECTED
 . Q
 Q RETURN1
 ;
DISPLAY3() ; select the series
 N N,REPEAT,RETURN1,RETURN2
 I '$D(JSTUDY) Q 0 ; no study selected
 S N=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,JSTUDY),0)
 I N=0 Q 0 ; no series data
 ;
 S REPEAT=1
 F  D  Q:'REPEAT
 . I N=1,$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",JPATIENT,JSTUDY,1),0) D
 . . S JSERIES=1
 . . S RETURN1=0
 . . Q
 . E  D  Q:'REPEAT  ; N>1
 . . S RETURN1=$$MULTIPLE("SERIES",N)
 . . I RETURN1=INCORRECT Q
 . . I RETURN1>0 S HIT=1 ; series selected
 . . I RETURN1'=0 S REPEAT=0 Q
 . . Q
 . S RETURN2=$$DISPLAY4()
 . I HIT S REPEAT=0
 . I RETURN2=NOTSELECTED,N=1 S REPEAT=0,RETURN1=NOTSELECTED
 . Q
 Q RETURN1
 ; 
DISPLAY4() ; select the image
 N N,REPEAT,RETURN1
 I '$D(JSERIES) Q 0 ; no series selected
 S N=$G(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",JPATIENT,JSTUDY,JSERIES),0)
 I N=0 Q 0 ; no image data
 ;
 S REPEAT=1
 F  D  Q:'REPEAT
 . S RETURN1=$$MULTIPLE("IMAGE",N)
 . I RETURN1=INCORRECT Q
 . I RETURN1>0 S HIT=1 ; image selected
 . I RETURN1'=0 S REPEAT=0 Q
 . Q
 Q RETURN1
 ;
 ;
 ;
MULTIPLE(LEVEL,N) ; display information for multiple entries
 N DONE,IBEGIN,IEND,INCREMENT,PROMPT,SELECT
 S DONE=0
 ;
 I N=1 D
 . S SELECT=$$SINGLE(LEVEL,1)
 . I SELECT=INCORRECT S SELECT=NOTSELECTED
 . Q
 E  D  ; multiple matches, select one
 . S IBEGIN=1 F  D MULTI Q:DONE  D  Q:DONE
 . . S IBEGIN=IBEGIN+INCREMENT
 . . I IBEGIN>N S SELECT=NOTSELECTED,DONE=1
 . . Q
 . Q
 Q SELECT
 ;
MULTI ; display one set of information
 N FIRSTLINE,FINISHED,I,OLDMODALITY,RETURN
 S FINISHED=0 F  D  Q:FINISHED
 . I IBEGIN=1 D
 . . D MULTITOP
 . . S FIRSTLINE=0
 . . Q
 . E  D
 . . W @IOF
 . . S FIRSTLINE=1
 . . Q
 . ;
 . S INCREMENT=(IOSL-4)-$Y
 . I INCREMENT<5 S INCREMENT=22
 . S IEND=IBEGIN+INCREMENT-1 I IEND>N S IEND=N
 . F I=IBEGIN:1:IEND D MULTIONE
 . W !!,"Enter 1-",IEND," to see the ",PROMPT(1)," details"
 . I IEND<N W ", <Enter> to see more ",PROMPT(2)
 . R ": ",I:DTIME E  D MULTIEND S FINISHED=1 Q
 . I I="" S SELECT=NOTSELECTED S FINISHED=1 Q
 . I I["^" D MULTIEND S FINISHED=1 Q
 . I I?1N.N,I'<1,I'>IEND S SELECT=$$SINGLE(LEVEL,I) S DONE=1,FINISHED=1 Q
 . R " ???",X:DTIME E  D MULTIEND S FINISHED=1 Q
 . Q
 Q
 ;
MULTIEND ; set loop end variables
 S DONE=1,I="",SELECT=NOTSELECTED
 Q
 ;
MULTITOP ; display the MULTI header
 I LEVEL="PATIENT" D
 . W @IOF,?4,"Identifier ",?17,"Patient Name",?60,"Birth Date",?75,"Sex"
 . W !?4,"-----------",?17,"------------",?60,"----------",?75,"---"
 . S PROMPT(1)="patient",PROMPT(2)="patients"
 . S (JPATIENT,JSTUDY,JSERIES)=""
 . Q
 E  I LEVEL="STUDY" D
 . D HEADER
 . S RETURN=$$PATIENT^MAGDSTQ6() ; ignore RETURN
 . W !!?4,"Accession Number",?22,"Study Date",?34,"Description"
 . W !?4,"----------------",?22,"----------",?34,"-----------"
 . S PROMPT(1)="study",PROMPT(2)="studies"
 . S (JSTUDY,JSERIES)=""
 . Q
 E  I LEVEL="SERIES" D
 . D HEADER
 . S RETURN=$$STUDY^MAGDSTQ6() ; ignore RETURN
 . S PROMPT(1)="series",PROMPT(2)="series"
 . Q
 E  D  ; image (composite SOP object)
 . D HEADER
 . S RETURN=$$SERIES^MAGDSTQ6() ; ignore RETURN
 . S PROMPT(1)="image",PROMPT(2)="images"
 . Q
 Q
 ;
MULTIONE ; display one line of data for each patient, study, series, or image
 N VAR
 S VAR=""
 W:'FIRSTLINE !
 I LEVEL="SERIES" D
 . N MODALITY
 . S MODALITY=^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,JSTUDY,I,"MODALITY")
 . I MODALITY=$G(OLDMODALITY) Q
 . W "Modality: ",MODALITY,!
 . S OLDMODALITY=MODALITY
 . Q
 W $J(I,3),")",?5 S FIRSTLINE=0
 I LEVEL="PATIENT" D
 . F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"PATIENT",I,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 . W PID,?17,$E($$NAME^MAGDSTQ6(PNAME),1,40),?60,$$DATE^MAGDSTQ6(DOB,"SHORT"),?76,SEX
 . Q
 E  I LEVEL="STUDY" D
 . F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"STUDY",JPATIENT,I,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 . W ACNUMB
 . W ?22,$$DATE^MAGDSTQ6(STUDYDATE,"SHORT")
 . W ?34,$E(DESCRIPTION,1,80-34) ; output to end of 80 character line
 . Q
 E  I LEVEL="SERIES" D
 . F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"SERIES",JPATIENT,JSTUDY,I,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 . I $G(SERIESDESC)'="",SERIESDESC'="<unknown>" W SERIESDESC
 . E  W "Series UID: ",SERIESUID
 . Q
 E  I LEVEL="IMAGE" D
 . F  S VAR=$O(^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK,"IMAGE",JPATIENT,JSTUDY,JSERIES,I,VAR)) Q:VAR=""  N @VAR S @VAR=^(VAR)
 . W "SOP Instance UID: ",SOPUID
 . Q
 Q
 ;
SINGLE(LEVEL,I) ; display detailed information for one entity
 N RETURN,X
 D HEADER
 I LEVEL="PATIENT" D
 . S JPATIENT=I,RETURN=$$PATIENT^MAGDSTQ6()
 . Q
 E  I LEVEL="STUDY" D
 . S JSTUDY=I,RETURN=$$STUDY^MAGDSTQ6()
 . Q
 E  I LEVEL="SERIES" D
 . S JSERIES=I,RETURN=$$SERIES^MAGDSTQ6()
 . Q
 E  D
 . S JIMAGE=I,RETURN=$$IMAGE^MAGDSTQ6()
 . Q
 Q RETURN
 ;
HEADER ; display the header
 N I,J,X
 S X=$S(OPTION="QR":"QUERY/RETRIEVE",1:"QUERY")_" RESULTS"
 S J=80-$L(X)/2
 W @IOF,?J,X
 W !,?J F I=1:1:$L(X) W "-"
 W !
 Q
