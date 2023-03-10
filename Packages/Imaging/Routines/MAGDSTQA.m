MAGDSTQA ;WOIFO/PMK - Study Tracker - Query/Retrieve user patient lookup ; Aug 30, 2020@17:57:08
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
 ; RPC version of ^MAGDSTA3 on VistA
 ;
 ; Supported IA #3027 reference DG SENSITIVE RECORD ACCESS rpc
 ; Supported IA #3027 reference PTSEC^DGSEC4 subroutine call
 ; Supported IA #3027 reference DG SENSITIVE RECORD BULLETIN rpc
 ; Supported IA #3027 reference NOTICE^DGSEC4 subroutine call
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 Q
 ;
 ; Entry point from ^MAGDSTA1 for automatic (batch) Q/R client
PATIENTA ; need just DFN for current patient, no previous PII
 N CLIENT S CLIENT="AUTOMATIC"
 N CHANGED,CHANGEDATE,DFN,DOB,DOD,FINIS,IPATINFO,K,PATINFO,PROMPT
 ;
 ; IPATINFO and PATINFO are not used in this subroutine
 ;
 S DFN=$G(^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN"))
 S PROMPT="patient"
 S IPATINFO=$$PATIENT(.PATINFO,DFN)
 Q
 ;
PATIENT(PATINFO,DFN) ; look up the patients
 N DOB,DONE,I,NAME,RETURN,RPCERR,SENSITIVE,SEX,SSN,VA,VADM,VAERR,X
 S DFN=$G(DFN),RETURN=0
 I DFN'="" D
 . W !!,"The patient is currently defined as follows: "
 . I $$VISTA^MAGDSTQ D  ; VistA code - call API
 . . D PAT^MAGDRPC1(.VAINFO,DFN)
 . . Q
 . E  D  ; DICOM Gateway code - call RPC
 . . S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM GET PATIENT","M",.VAINFO,DFN)
 . . I RPCERR<0 D  S RETURN=-1 Q
 . . . D ERRORMSG^MAGDSTQ0(1,"Error in MAG DICOM GET PATIENT rpc",.VAINFO)
 . . . Q
 . . Q
 . I RETURN Q
 . D VADPT^MAGDRPC0(.VAINFO)
 . S VAICN=$G(VAICN)
 . D SCREEN(.SENSITIVE,DFN)
 . S NAME=VADM(1),DOB=$P(VADM(3),"^",2),SSN=$P(VADM(2),"^",2)
 . S SEX=$P(VADM(5),"^",1)
 . K PATINFO
 . D SAVEINFO(.PATINFO,DFN,NAME,DOB,SSN,SEX,,SENSITIVE)
 . W !! D PRINTHDR
 . D PRINTPAT(.PATINFO,1)
 . I $$YESNO^MAGDSTQ("Do you wish to change it?","n",.X)<0 S QUIT=1 Q
 . I X="YES" D
 . . S RETURN=$$PATIENT1(.PATINFO)
 . . Q
 . E  D  ; save info 
 . . S RETURN=1
 . Q
 E  D
 . S RETURN=$$PATIENT1(.PATINFO)
 . Q
 Q RETURN
 ;
PATIENT1(PATINFO) ; lookup patient
 N I,IN,OK,RETURN,X
 S OK=0 F  D  Q:OK
 . W !!,"Enter Patient: "
 . R X:DTIME E  S X="^"
 . I X["^" S OK=-1 Q
 . I X="@" D  Q
 . . F I="PATIENT NAME","PATIENT ID","PATIENT BIRTH DATE","PATIENT'S SEX","PATIENT DFN" D
 . . . K ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,I)
 . . . Q
 . . K ^TMP("MAG",$J,"Q/R PARAM","PATIENT LOOKUP MODE") ; reset VistA/Manual Mode
 . . S DFN="",OK=-2
 . . Q
 . I "?"[X D  Q
 . . W !!,"Enter either the Patient Name (last,first), the Social Security Number,"
 . . W !,"or the Quick PID (initial + last four).  You may use ""@"" to remove it."
 . . Q
 . S X=$TR(X,"-") ; remove dashes in SSN for lookup
 . D PATLKUP(.PATINFO,X)
 . S RETURN=$$PATIENT2("PATIENTS",.PATINFO,"") ; no default (3rd argument)
 . Q
 I OK<0 D
 . S QUIT=1
 . S RETURN=0
 . Q
 Q RETURN
 ;
PATIENT2(LISTMODE,INFO,DEFAULT) ; called to display a list of patients or a list of PII changes
 ; INFO can be either PATINFO or HISTINFO, same format
 N COUNT
 S COUNT=$G(INFO(0)),DEFAULT=$G(DEFAULT)
 I LISTMODE="PATIENTS" D  I 'COUNT Q 0
 . I 'COUNT W " -- NO MATCH"
 . E  W " -- ",COUNT," MATCH" W:COUNT>1 "ES"
 . Q
 I COUNT=1 D
 . S RETURN=$$SINGLE(LISTMODE,.INFO,1)
 . Q
 E  D
 . S RETURN=$$MULTIPLE(LISTMODE,.INFO,DEFAULT)
 . Q
 Q RETURN
 ;
SINGLE(LISTMODE,INFO,I) ; single match
 N DATETIME,FIRSTDAY,FIRSTIEN,LASTDAY,LASTIEN,RETURN,STUDYCOUNT
 S DFN=$P(INFO(I),"^",1),SENSITIVE=$P(INFO(I),"^",7)
 W !! D PRINTHDR
 D PRINTPAT(.INFO,I)
 I SENSITIVE D  I 'RETURN Q RETURN
 . S RETURN=$$PATCHECK(DFN) Q:'RETURN
 . W !! D PRINTHDR
 . D PRINTPAT(.INFO,I,1)
 . W ?65,"*SENSITIVE*"
 . Q
 I CLIENT="AUTOMATIC" D
 . S RETURN=$$SINGLEA
 . Q
 E  D  ; CLIENT="MANUAL"
 . S RETURN=$$SINGLEQ
 . Q
 Q RETURN
 ;
SINGLEA() ; automatic (batch) query retrieve
 ; check for radiology or consults
 I IMAGINGSERVICE="RADIOLOGY" D  ; look for radiology reports in the range
 . D RADLKUP^MAGDSTA4(DFN,.STUDYCOUNT,.FIRSTDAY,.LASTDAY,.FIRSTIEN,.LASTIEN)
 . Q
 E  D  ; look for consults/procedures in the range
 . D CONLKUP^MAGDSTA6(DFN,.STUDYCOUNT,.FIRSTDAY,.LASTDAY,.FIRSTIEN,.LASTIEN)
 . Q
 ;
 I 'STUDYCOUNT S RETURN=0
 E  D
 . I $$YESNO^MAGDSTQ("Is this the correct "_PROMPT_"?","n",.X)>0,X="YES" D
 . . S RETURN=I
 . . S ^TMP("MAG",$J,"BATCH Q/R","PATIENT DFN")=$P(INFO(I),"^",1)
 . . S ^TMP("MAG",$J,"BATCH Q/R","BEGIN DATE")=FIRSTDAY
 . . S ^TMP("MAG",$J,"BATCH Q/R","END DATE")=LASTDAY+.235959 ; end of day
 . . S (DONE,FINIS,OK)=1
 . . Q
 . E  S RETURN=0
 . Q
 Q RETURN
 ;
SINGLEQ() ; manual query retrieve
 I $$YESNO^MAGDSTQ("Is this the correct "_PROMPT_"?","n",.X)>0,X="YES" D
 . S RETURN=I
 . S (DONE,FINIS,OK)=1
 . Q
 E  S RETURN=0
 Q RETURN
 ;
PATCHECK(DFN) ; check patient sensitivity
 N NOTICE,SECINFO,PATCHECK,X
 I $D(PATCHECKED(DFN)) Q 1 ; patient already checked
 ;
 I $$VISTA^MAGDSTQ D  ; VistA code
 . D PTSEC^DGSEC4(.SECINFO,DFN,1,"^VistA Query/Retrieve Client") ; ICR #3027
 . Q
 E  D  I SECINFO(1)=-1 D  Q 0 ; DICOM Gateway code
 . S X=$$CALLRPC^MAGM2VCU("DG SENSITIVE RECORD ACCESS","M",.SECINFO,DFN,1,"^DICOM Gateway Query/Retrieve Client")
 . I SECINFO(1)=-1 D  Q  ; RPC failed
 . . D ERRORMSG^MAGDSTQ0(1,"Error in DG SENSITIVE RECORD ACCESS rpc",.SECINFO)
 . . Q
 . Q
 I SECINFO(1) D  I 'PATCHECK Q 0
 . N I
 . W ! S I=1 F  S I=$O(SECINFO(I)) Q:I=""  D
 . . ; write sensitive patient warning message
 . . W !?(IOM-$L(SECINFO(I))/2),SECINFO(I)
 . . Q
 . I SECINFO(1)=1 D CONTINUE^MAGDSTQ S PATCHECK=1 Q
 . I SECINFO(1)'=2 D CONTINUE^MAGDSTQ S PATCHECK=0 Q
 . I $$YESNO^MAGDSTQ("Do you want to continue processing this patient record?","n",.X)<0 S PATCHECK=0 Q
 . I X="NO" S PATCHECK=0 Q
 . I $$VISTA^MAGDSTQ D  ; VistA code
 . . D NOTICE^DGSEC4(.NOTICE,DFN,"^VistA Query/Retrieve Client",1) ; ICR #3027
 . . Q
 . E  D  ; DICOM Gateway code
 . . S X=$$CALLRPC^MAGM2VCU("DG SENSITIVE RECORD BULLETIN","M",.NOTICE,DFN,"^DICOM Gateway Query/Retrieve Client",1)
 . . I 'NOTICE D  S PATCHECK=0 Q  ; RPC error
 . . . D ERRORMSG^MAGDSTQ0(1,"Error in DG SENSITIVE RECORD BULLETIN rpc",.NOTICE)
 . . . Q
 . . Q
 . S PATCHECK=1
 . Q
 E  S PATCHECK=1
 I PATCHECK S PATCHECKED(DFN)=1
 Q PATCHECK
 ;
MULTIPLE(LISTMODE,INFO,DEFAULT) ; display information for multiple patients/pii changes
 N DONE,RETURN
 S (DONE,RETURN)=0
 I LISTMODE="PATIENTS" W !!,"There are ",COUNT," matches"
 E  W !!,"There are changes in the patient identification"
 R "...  Press <Enter> for list",X:$G(DTIME,300)
 I COUNT>20 D  ; more than twenty patients/pii changes
 . F K=1:20:COUNT S RETURN=$$MULTI(DEFAULT) Q:DONE
 . Q
 E  D  ; twenty or less patients
 . S K=1 S RETURN=$$MULTI(DEFAULT) Q:DONE
 Q RETURN
 ;
MULTI(DEFAULT) ; display one set of patients
 N I,K20,FINIS,RETURN
 S RETURN=0
 S K20=K+19 I K20>COUNT S K20=COUNT
 S FINIS=0 F  D  Q:FINIS
 . W @IOF D PRINTHDR
 . F I=K:1:K20 D 
 . . D PRINTPAT(.INFO,I)
 . W !!,"Enter 1-",K20," to select the ",PROMPT
 . I K20<COUNT W ", or <Enter> to see more ",PROMPT,"s"
 . W ": " I DEFAULT'="" W DEFAULT,"// "
 . R I:$G(DTIME,300) E  S I="^"
 . I I="" W DEFAULT S I=DEFAULT
 . I I="" S FINIS=1 Q
 . I I["^" S DONE=1,I="",FINIS=-1 Q
 . I I?1N.N,I'<1,I'>K20 S RETURN=$$SINGLE(LISTMODE,.INFO,I) Q
 . W " ???" R X:$G(DTIME,300)
 . Q
 Q RETURN
 ;
PRINTHDR ; print column header
 W ?4,"Social Sec#",?16,"Sex",?21,"Patient's Name",?53,"Birth Date"
 I $G(LISTMODE)="PII CHANGES" W ?65,"Change  Date"
 W !?4,"-----------",?16,"---",?21,"--------------",?53,"----------"
 I $G(LISTMODE)="PII CHANGES" W ?65,"---------------"
 Q
 ;
PRINTPAT(INFO,I,SENSITIVEOK) ; print patient information
 N X
 D GETINFO(.INFO,I)
 ;
 I '$G(SENSITIVEOK),SENSITIVE D
 . W !,$J(I,2),")",?4,"*SENSITIVE*",?17,$E(SEX,1),?21,$E(NAME,1,30),?53,"*SENSITIVE*"
 . Q
 E  D
 . W !,$J(I,2),")",?4,SSN,?17,$E(SEX,1),?21,$E(NAME,1,30),?53,DOB
 . Q
 I $G(LISTMODE)="PII CHANGES" D
 . I CHANGED'="" D
 . . W ?65,CHANGED,?70,"- ",$$CHANGEDT(CHANGEDATE)
 . . Q
 . E  W ?72,$$CHANGEDT(CHANGEDATE)
 . Q
 Q
 ;
SAVEINFO(INFO,DFN,NAME,DOB,PID,SEX,DOD,SENSITIVE,CHANGED,CHANGEDATE) ; save pii
 ; DFN^patient name^DOB^PID^SEX^DOD^Sensitive^Changed Field^Change date & time
 ;  1        2       3   4   5   6      7           8              9
 N X
 I DOB?1"00/00/"4N S DOB=$E(DOB,7,10) ; only year
 S X=DFN_"^"_NAME_"^"_DOB_"^"_PID_"^"_SEX_"^"_$G(DOD)
 S X=X_"^"_$G(SENSITIVE)_"^"_$G(CHANGED)_"^"_$G(CHANGEDATE)
 S INFO(0)=$G(INFO(0))+1
 S INFO(INFO(0))=X
 Q
 ;
GETINFO(INFO,I) ; retrieve pii
 S X=INFO(I),DFN=$P(X,"^",1),NAME=$P(X,"^",2),DOB=$P(X,"^",3)
 S SSN=$P(X,"^",4),SEX=$P(X,"^",5),DOD=$P(X,"^",6)
 S SENSITIVE=$P(X,"^",7),CHANGED=$P(X,"^",8),CHANGEDATE=$P(X,"^",9)
 Q
 ;
CHANGEDT(X) ; return change date in mm/dd/yy format
 S X=$$FMTE^XLFDT(X,"5Z")
 Q $E(X,1,6)_$E(X,9,10)
 ;
PATLKUP(OUTPUT,INPUT) ; patient lookup
 ;   INPUT = value to lookup
 ;     Lookup uses multiple index lookup of File #2
 ;     
 ;   OUTPUT = data
 ;     OUTPUT(0) = number of records
 ;     for i=1:number of records returned: 
 ;      DFN^patient name^DOB^PID^SEX^DOD^Sensitive
 ;       1        2       3   4   5   6      7
 ;       
 ;       (DOD = Date of Death)
 ;       
 I $$VISTA^MAGDSTQ D  ; VistA code - call API
 . D PATLKUP^MAGDSTA3(.OUTPUT,INPUT)
 . Q
 E  D  ; DICOM Gateway code - call RPC
 . N ARRAY,COUNT,I,RPCERR
 . K OUTPUT
 . S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM PATIENT LOOKUP","MT",.ARRAY,INPUT)
 . I RPCERR<0 D  S OUTPUT(0)=-1 Q
 . . D ERRORMSG^MAGDSTQ0(1,"Error in rpc MAG DICOM PATIENT LOOKUP",.ARRAY)
 . . Q
 . S COUNT=ARRAY(1)
 . F I=0:1:COUNT S OUTPUT(I)=ARRAY(I+1)
 . Q
 Q
 ;
SCREEN(SCREEN,DFN) ; Screening logic sensitive patients
 ; Input  : DFN - Pointer to PATIENT file (#2)
 ; Output : 0 - Don't apply screen
 ;          1 - Apply screen - sensitive patient
 ;          2 - Apply screen - employee
 ; Notes  : Screen applied if patient is sensitive or an employee
 ;
 I $$VISTA^MAGDSTQ D  ; VistA code - call API
 . D SCREEN^MAGDSTA3(.SCREEN,DFN)
 . Q
 E  D  ; DICOM Gateway code - call RPC
 . N RPCERR
 . S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM GET PT SENSITIVITY","M",.SCREEN,DFN)
 . I RPCERR<0 D  S SCREEN=-1
 . . D ERRORMSG^MAGDSTQ0(1,"Error in MAG DICOM GET PT SENSITIVITY rpc",.SCREEN)
 . . Q
 . Q
 Q
 ;
 ;
 ;
HISTLKUP(OUTPUT,DFN) ; look up historical patient changes in the audit archive
 ;   INPUT = value to lookup
 ;     Lookup uses multiple index lookup of File #2
 ;     
 ;   OUTPUT = data
 ;     OUTPUT(0) = number of records
 ;     for i=1:number of records returned: 
 ;      DFN^Patient Name^DOB^PID^SEX^DOD^Sensitive^Changed Field^Change date & time
 ;       1        2       3   4   5   6      7           8              9
 ;       
 ;       (DOD = Date of Death; DOD and Sensitive are null)
 ;
 I $$VISTA^MAGDSTQ D  ; VistA code - call API
 . D HISTLKUP^MAGDSTA3(.OUTPUT,DFN)
 . Q
 E  D  ; DICOM Gateway code - call RPC
 . N ARRAY,COUNT,I,RPCERR
 . K OUTPUT
 . S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM PATIENT HISTORY","MT",.ARRAY,DFN)
 . I RPCERR<0 D  S OUTPUT(0)=-1 Q
 . . D ERRORMSG^MAGDSTQ0(1,"Error in MAG DICOM PATIENT HISTORY rpc",.ARRAY)
 . . Q
 . S COUNT=ARRAY(1)
 . F I=0:1:COUNT S OUTPUT(I)=ARRAY(I+1)
 . Q
 Q
