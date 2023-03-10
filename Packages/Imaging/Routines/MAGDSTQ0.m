MAGDSTQ0 ;WOIFO/PMK - Study Tracker - Query/Retrieve user ; Aug 16, 2020@17:57:20
 ;;3.0;IMAGING;**231**;Mar 19, 2002;Build 9;Jun 29, 2011
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
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #10103 reference $$FMADD^XLFDT function call
 ;
 Q
 ;
INITXTMP() ; initialize ^XTMP
 N MAGXTMP,PURGE,TODAY
 S MAGXTMP="MAG Q/R Client"
 S TODAY=$$NOW^XLFDT()\1
 D KILLXTMP(MAGXTMP,TODAY)
 S PURGE=$$FMADD^XLFDT(TODAY,7) ; keep a week's worth for debug purposes
 S MAGXTMP=MAGXTMP_" "_TODAY
 I '$D(^XTMP(MAGXTMP,0)) S ^(0)=PURGE_"^"_TODAY_"^DICOM Q/R Client"
 K ^XTMP(MAGXTMP,HOSTNAME,$J)
 Q MAGXTMP
 ;
KILLXTMP(MAGXTMP,TODAY) ; remove old ^XTMP files
 N X
 F  S MAGXTMP=$O(^XTMP(MAGXTMP)) Q:MAGXTMP'?1"MAG".E  D
 . ; check purge date against today's - keep a week's worth for debug purposes
 . S X=$G(^XTMP(MAGXTMP,0)) I $P(X,"^",1)<TODAY  K ^XTMP(MAGXTMP)
 . Q
 Q
 ;
KEYLIST(KEYLIST) ; initialize KEYLIST
 N I,LINETAG,T
 S QRROOT=$G(^TMP("MAG",$J,"Q/R PARAM","ROOT"))
 S QUERYLEVEL=$G(^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL"))
 S LINETAG=$E(QRROOT,1)_QUERYLEVEL
 S T=$T(@LINETAG) I T="" Q 0 ; not a valid Q/R Root/Level pair
 K KEYLIST
 S KEYCOUNT=0
 F I=1:1 S T=$P($T(@LINETAG+I),";;",2) Q:T="END"  D
 . S KEYCOUNT=KEYCOUNT+1
 . S KEYLIST(KEYCOUNT)=T
 . Q
 Q KEYCOUNT
 ;
PPATIENT ; patient root patient level query keys
 ;;PATIENT NAME|PNAME^MAGDSTQ1
 ;;PATIENT ID|PID^MAGDSTQ1
 ;;PATIENT BIRTH DATE|BIRTHDAT^MAGDSTQ1
 ;;PATIENT'S SEX|SEX^MAGDSTQ1
 ;;END
 ;;
PSTUDY ; patient root study level query keys
 ;;PATIENT NAME|PNAME^MAGDSTQ1
 ;;PATIENT ID|PID^MAGDSTQ1
 ;;PATIENT BIRTH DATE|BIRTHDAT^MAGDSTQ1
 ;;PATIENT'S SEX|SEX^MAGDSTQ1
 ;;ACCESSION NUMBER|ACNUMB^MAGDSTQ1
 ;;STUDY DATE|STDYDATE^MAGDSTQ1
 ;;STUDY TIME|STDYTIME^MAGDSTQ1
 ;;STUDY ID|STUDYID^MAGDSTQ1
 ;;STUDY INSTANCE UID(0001)|STUDYUID^MAGDSTQ1
 ;;MODALITY|MODALITY^MAGDSTQ1
 ;;REFERRING PHYSICIAN|REFDOC^MAGDSTQ1
 ;;END
 ;;
PSERIES ; patient root series level query keys
 ;;PATIENT NAME|PNAME^MAGDSTQ1
 ;;PATIENT ID|PID^MAGDSTQ1
 ;;PATIENT BIRTH DATE|BIRTHDAT^MAGDSTQ1
 ;;PATIENT'S SEX|SEX^MAGDSTQ1
 ;;ACCESSION NUMBER|ACNUMB^MAGDSTQ1
 ;;STUDY DATE|STDYDATE^MAGDSTQ1
 ;;STUDY TIME|STDYTIME^MAGDSTQ1
 ;;STUDY ID|STUDYID^MAGDSTQ1
 ;;STUDY INSTANCE UID(0001)|STUDYUID^MAGDSTQ1
 ;;MODALITY|MODALITY^MAGDSTQ1
 ;;REFERRING PHYSICIAN|REFDOC^MAGDSTQ1
 ;;SERIES NUMBER|SERIESNO^MAGDSTQ1
 ;;SERIES INSTANCE UID(0001)|SERIEUID^MAGDSTQ1
 ;;END
 ;;
PIMAGE ; patient root image level query keys
 ;;PATIENT NAME|PNAME^MAGDSTQ1
 ;;PATIENT ID|PID^MAGDSTQ1
 ;;PATIENT BIRTH DATE|BIRTHDAT^MAGDSTQ1
 ;;PATIENT'S SEX|SEX^MAGDSTQ1
 ;;ACCESSION NUMBER|ACNUMB^MAGDSTQ1
 ;;STUDY DATE|STDYDATE^MAGDSTQ1
 ;;STUDY TIME|STDYTIME^MAGDSTQ1
 ;;STUDY ID|STUDYID^MAGDSTQ1
 ;;STUDY INSTANCE UID(0001)|STUDYUID^MAGDSTQ1
 ;;MODALITY|MODALITY^MAGDSTQ1
 ;;REFERRING PHYSICIAN|REFDOC^MAGDSTQ1
 ;;SERIES NUMBER|SERIESNO^MAGDSTQ1
 ;;SERIES INSTANCE UID(0001)|SERIEUID^MAGDSTQ1
 ;;SOP INSTANCE UID(0001)|SOPUID^MAGDSTQ1
 ;;END
 ;;
SSTUDY ; study root study level query keys
 ;;PATIENT NAME|PNAME^MAGDSTQ1
 ;;PATIENT ID|PID^MAGDSTQ1
 ;;PATIENT BIRTH DATE|BIRTHDAT^MAGDSTQ1
 ;;PATIENT'S SEX|SEX^MAGDSTQ1
 ;;ACCESSION NUMBER|ACNUMB^MAGDSTQ1
 ;;STUDY DATE|STDYDATE^MAGDSTQ1
 ;;STUDY TIME|STDYTIME^MAGDSTQ1
 ;;STUDY ID|STUDYID^MAGDSTQ1
 ;;STUDY INSTANCE UID(0001)|STUDYUID^MAGDSTQ1
 ;;MODALITY|MODALITY^MAGDSTQ1
 ;;REFERRING PHYSICIAN|REFDOC^MAGDSTQ1
 ;;END
 ;;
SSERIES ; study root series level query keys
 ;;PATIENT NAME|PNAME^MAGDSTQ1
 ;;PATIENT ID|PID^MAGDSTQ1
 ;;PATIENT BIRTH DATE|BIRTHDAT^MAGDSTQ1
 ;;PATIENT'S SEX|SEX^MAGDSTQ1
 ;;ACCESSION NUMBER|ACNUMB^MAGDSTQ1
 ;;STUDY DATE|STDYDATE^MAGDSTQ1
 ;;STUDY TIME|STDYTIME^MAGDSTQ1
 ;;STUDY ID|STUDYID^MAGDSTQ1
 ;;STUDY INSTANCE UID(0001)|STUDYUID^MAGDSTQ1
 ;;MODALITY|MODALITY^MAGDSTQ1
 ;;REFERRING PHYSICIAN|REFDOC^MAGDSTQ1
 ;;SERIES NUMBER|SERIESNO^MAGDSTQ1
 ;;SERIES INSTANCE UID(0001)|SERIEUID^MAGDSTQ1
 ;;END
 ;;
SIMAGE ; study root image level query keys
 ;;PATIENT NAME|PNAME^MAGDSTQ1
 ;;PATIENT ID|PID^MAGDSTQ1
 ;;PATIENT BIRTH DATE|BIRTHDAT^MAGDSTQ1
 ;;PATIENT'S SEX|SEX^MAGDSTQ1
 ;;ACCESSION NUMBER|ACNUMB^MAGDSTQ1
 ;;STUDY DATE|STDYDATE^MAGDSTQ1
 ;;STUDY TIME|STDYTIME^MAGDSTQ1
 ;;STUDY ID|STUDYID^MAGDSTQ1
 ;;STUDY INSTANCE UID(0001)|STUDYUID^MAGDSTQ1
 ;;MODALITY|MODALITY^MAGDSTQ1
 ;;REFERRING PHYSICIAN|REFDOC^MAGDSTQ1
 ;;SERIES NUMBER|SERIESNO^MAGDSTQ1
 ;;SERIES INSTANCE UID(0001)|SERIEUID^MAGDSTQ1
 ;;SOP INSTANCE UID(0001)|SOPUID^MAGDSTQ1
 ;;END
 ;;
 ;
ASKDASH ; ask the dash question 
 N PIDDASHES
 S PIDDASHES=$G(^TMP("MAG",$J,"Q/R PARAM","PATIENT ID DASHES"))
 I PIDDASHES="" D
 . ; set the patient lookup CLIENT for manual Q/R client
 . N X,DEFAULT
 . D DASHES(.DEFAULT) ; get VistA setting for dashes in PID
 . I $$YESNO^MAGDSTQ("Include dashes in the PATIENT ID key?",DEFAULT,.X)<0 Q
 . S (^TMP("MAG",$J,"Q/R PARAM","PATIENT ID DASHES"),PIDDASHES)=$E(X,1)
 . Q
 Q
 ;
DASHES(OUTPUT) ; lookup whether or not PID should contain dashes - returns Y or N
 I $$VISTA^MAGDSTQ D  ; VistA code - call API
 . D DASHES^MAGDSTA3(.OUTPUT)
 . Q
 E  D  ; DICOM Gateway code - call RPC
 . N RPCERR
 . S RPCERR=$$CALLRPC^MAGM2VCU("MAG DICOM GET PT ID DASHES","M",.OUTPUT)
 . I RPCERR<0 D  S OUTPUT(0)=-1 Q
 . . D ERRORMSG^MAGDSTQ0(1,"Error in MAG DICOM GET PT ID DASHES rpc",.OUTPUT)
 . . Q
 . Q
 Q
 ;
PUSH(QRSTACK) ; push the query down onto the stack
 S QRSTACK=QRSTACK+1
 ; remove any previous query results
 K ^TMP("MAG",$J,"Q/R QUERY",QRSTACK) ; remove any previous query results
 K ^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK) ; remove any previous query results
 ; copy the previous stack results to the new stack
 M ^TMP("MAG",$J,"Q/R QUERY",QRSTACK)=^TMP("MAG",$J,"Q/R QUERY",QRSTACK-1)
 M ^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK)=^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK-1)
 Q
 ;
POP(QRSTACK) ; remove the old query from the stack
 K ^TMP("MAG",$J,"Q/R QUERY",QRSTACK) ; remove any old query results
 K ^XTMP(MAGXTMP,HOSTNAME,$J,QRSTACK) ; remove any old query results
 I QRSTACK>1 S QRSTACK=QRSTACK-1
 E  D
 . S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"ROOT")=QRROOT
 . S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY LEVEL")=QRROOT
 . S ^TMP("MAG",$J,"Q/R QUERY",QRSTACK,"QUERY USER APPLICATION")=QRSCP
 . Q
 D KEYLIST^MAGDSTQ0(.KEYLIST)
 Q
 ;
ERRORMSG(PAUSE,TEXT,INFO) ; display error message to user called from MAGDSTQA
 N COMEFROM,I,J,MAXLEN,MSG,X
 S COMEFROM=$P($STACK($STACK-1,"PLACE")," ",1)
 S I=0,MAXLEN=36+$L(COMEFROM) ; max length of last line
 I $L($G(TEXT)) S I=I+1,MSG(I)=TEXT
 S I=I+1,MSG(I)=""
 I $D(INFO)=1 D ERRMSG1(.MSG,.I,INFO)
 E  F J=1:1 Q:'$D(INFO(J))  D ERRMSG1(.MSG,.I,INFO(J))
 F J=1:1:I I $L(MSG(J))>MAXLEN S MAXLEN=$L(MSG(J))
 S I=I+1,MSG(I)=""
 S I=I+1,MSG(I)="Message generated at MUMPS line tag "_COMEFROM
 W ! F J=1:1:MAXLEN+8 W "*"
 F J=1:1:I W !,"*** ",MSG(J),?MAXLEN+4," ***"
 W ! F J=1:1:MAXLEN+8 W "*"
 I $G(PAUSE) D CONTINUE^MAGDSTQ
 Q
 ;
ERRMSG1(MSG,I,INFO) ; split long lines into shorter ones
 N J,K,X
 I $L(INFO)'>75 S I=I+1,MSG(I)=INFO Q
 ; split the line up into shorter ones
 S K=1,X=$P(INFO," ",1)
 F J=2:1:$L(INFO," ") D
 . I ($L(X)+$L($P(INFO," ",J)))>75 D  ; output short line
 . . S I=I+1,MSG(I)=X,X="",K=0
 . . Q
 . S K=K+1,$P(X," ",K)=$P(INFO," ",J)
 . Q
 I X'="" S I=I+1,MSG(I)=X ; flush buffer
 Q
