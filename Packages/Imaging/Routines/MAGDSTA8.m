MAGDSTA8 ;WOIFO/PMK - Q/R Retrieve of DICOM images from PACS to VistA ; Feb 15, 2022@10:50:15
 ;;3.0;IMAGING;**231,305**;Mar 19, 2002;Build 3
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
 ; Supported IA #2056 reference $$GET1^DIQ function call
 ; Controlled IA #4171 to read REQUEST SERVICES file (#123.5)
 ; Controlled IA #7095 to read GMRC PROCEDURE file (#123.3)
 ; Controlled IA #4110 to read REQUEST/CONSULTATION file (#123)
 ;
 Q
 ;
LEGACY(GROUPIEN,SERIESCOUNT,IMAGECOUNT) ; get all the UIDs for the imaging group
 N I,IMAGEIEN,VISTASTUDYUID,SERIESUID,SOPUID,X,Y,Z
 S (SERIESCOUNT,IMAGECOUNT)=0 ; want series/image counts for this group ien
 S X=$G(^MAG(2005,GROUPIEN,"PACS"))
 S VISTASTUDYUID=$P(X,"^",1)
 I VISTASTUDYUID="" Q  ; invoked for a group without a study uid
 ; there may be multiple study instance uids
 I '$D(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID)) D
 . ; increment study uid count for PACS lookup, if needed
 . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",0))+1)_" ; legacy study count"
 . Q
 S I=0 ; skip zero-node of group multiple
 F  S I=$O(^MAG(2005,GROUPIEN,1,I)) Q:'I  D
 . S Y=$G(^MAG(2005,GROUPIEN,1,I,0))
 . S IMAGEIEN=$P(Y,"^",1)
 . S Z=$G(^MAG(2005,IMAGEIEN,"PACS")),SERIESUID=$G(^("SERIESUID"))
 . S SOPUID=$P(Z,"^",1)
 . ; require both series instance uid and sop instance uid
 . Q:SERIESUID=""  Q:SOPUID=""  ; can't do PACS lookup
 . D SERIES(VISTASTUDYUID,SERIESUID,.SERIESCOUNT)
 . D IMAGE(VISTASTUDYUID,SERIESUID,SOPUID,.IMAGECOUNT)
 . Q
 Q
 ;
NEWSOPDB(ACNUMB,SERIESCOUNT,IMAGECOUNT) ; look for UIDs in the P34 database for the new SOP Classes
 ; Rules:
 ; 1) the Attribute On File field is not checked at all.
 ; 2) for the Procedure Reference file (#2005.61), there has to be a pointer to the Patient
 ;    Reference file (#2005.6) and the patient id type in file #2005.6 needs to be "DFN".
 ; 3) for the Image Study file (#2005.62), the study must be "accessible" and AOF
 ; 4) for the Image Series file (#2006.63), the series must be  "accessible" and AOF
 ; 5) for the SOP Instance file ("2006.64), the SOP instance must be "accessible" and AOF
 ;
 ; Rules 1, 2, and 3 are from the logic in ADD1STD^MAGDQR74
 ; Rules 4 and 5 are from the logic in STYSERKT^MAGVD010
 ;  
 N PROCIX,SERIESDATA0,SERIESIX,SERIESUID,STUDYDATA0,STUDYIX
 N SOPDATA0,SOPIX,SOPUID,VISTASTUDYUID
 ;
 S (SERIESCOUNT,IMAGECOUNT)=0 ; want series/image counts for this accession number
 I $G(ACNUMB)="" Q  ; invoked without an accession number
 ;
 S PROCIX="" ; procedure level indexed by accession number
 F  S PROCIX=$O(^MAGV(2005.61,"B",ACNUMB,PROCIX)) Q:'PROCIX  D
 . I $$PROBLEM61(PROCIX) Q  ; patient not available - quit
 . ;
 . S STUDYIX="" ; study level
 . F  S STUDYIX=$O(^MAGV(2005.62,"C",PROCIX,STUDYIX)) Q:'STUDYIX  D
 . . I $$PROBLEM62(STUDYIX) Q  ; study not available - quit
 . . S STUDYDATA0=$G(^MAGV(2005.62,STUDYIX,0))
 . . S VISTASTUDYUID=$P(STUDYDATA0,"^",1)
 . . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",0))+1)_" ; new sop class db study count" ; increment study count
 . . ;
 . . S SERIESIX="" ; series level
 . . F  S SERIESIX=$O(^MAGV(2005.63,"C",STUDYIX,SERIESIX)) Q:'SERIESIX  D
 . . . I $$PROBLEM63(SERIESIX) Q  ; if the series is not available, don't count it - quit
 . . . S SERIESDATA0=$G(^MAGV(2005.63,SERIESIX,0))
 . . . S SERIESUID=$P(SERIESDATA0,"^",1)
 . . . D SERIES(VISTASTUDYUID,SERIESUID,.SERIESCOUNT)
 . . . ;
 . . . S SOPIX="" ; sop instance level
 . . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIESIX,SOPIX)) Q:'SOPIX  D
 . . . . I $$PROBLEM64(SOPIX) Q  ; if the sop instance is not available, don't count it - quit
 . . . . S SOPDATA0=^MAGV(2005.64,SOPIX,0)
 . . . . S SOPUID=$P(SOPDATA0,"^",1)
 . . . . ;
 . . . . S IMAGEIX="" ; image instance level
 . . . . F  S IMAGEIX=$O(^MAGV(2005.65,"C",SOPIX,IMAGEIX)) Q:'IMAGEIX  D
 . . . . . I $$PROBLEM65(IMAGEIX) Q  ; if the original image is not available, don't count it - quit
 . . . . . D IMAGE(VISTASTUDYUID,SERIESUID,SOPUID,.IMAGECOUNT)
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
 ;
PROBLEM61(PROCIX) ; check both file 2005.6 and 2005.61
 N ARTIFACTONFILE,DFN,PATREFDATA,PATREFIX,PROCREFDATA0,PROCREFDATA6,RETURN,STATUS,STUDYIX
 S RETURN=1 D
 . ; check IMAGING PROCEDURE REFERNCE file 
 . S PROCREFDATA0=$G(^MAGV(2005.61,PROCIX,0))
 . S STATUS=$P(PROCREFDATA0,"^",5) I STATUS'="A" Q  ; imaging procedure not accessible
 . S ARTIFACTONFILE=$P(PROCREFDATA0,"^",6) I 'ARTIFACTONFILE Q  ; artifact not on file 
 . S PROCREFDATA6=$G(^MAGV(2005.61,PROCIX,6))
 . S PATREFIX=$P(PROCREFDATA6,"^",1) I 'PATREFIX Q  ; No Patient Reference
 . ;
 . ; check IMAGING PATIENT REFERENCE file
 . S PATREFDATA=$G(^MAGV(2005.6,PATREFIX,0))
 . S DFN=$P(PATREFDATA,"^",1) I DFN="" Q  ; no DFN
 . I $P(PATREFDATA,"^",3)'="D" Q  ; Quit if Patient ID Type is not DFN
 . S ARTIFACTONFILE=$P(PATREFDATA,"^",4) I 'ARTIFACTONFILE Q  ; artifact not on file
 . S STATUS=$P(PATREFDATA,"^",5) I STATUS'="A" Q  ; patient not accessible
 . ;
 . ; check that there is at least one good study
 . S STUDYIX="" ; study level
 . F  S STUDYIX=$O(^MAGV(2005.62,"C",PROCIX,STUDYIX)) Q:'STUDYIX  D
 . . I $$PROBLEM62^MAGDSTA8(STUDYIX) Q  ; study not available - quit
 . . S RETURN=0
 . . Q
 . Q
 Q RETURN ; 0=OK, no problem, 1=fails, not available
 ;
PROBLEM62(STUDYIX) ; check file 2005.62
 N ARTIFACTONFILE,RETURN,STATUS,STUDYDATA5,STUDYDATA6
 S RETURN=1 D
 . ; check IMAGE STUDY file
 . S STUDYDATA5=$G(^MAGV(2005.62,STUDYIX,5))
 . S STATUS=$P(STUDYDATA5,"^",2) I STATUS'="A" Q  ; study not accessible
 . S STUDYDATA6=$G(^MAGV(2005.62,STUDYIX,6))
 . S ARTIFACTONFILE=$P(STUDYDATA6,"^",2) I 'ARTIFACTONFILE Q  ; artifact not on file
 . S RETURN=0
 . Q
 Q RETURN ; 0=OK, no problem, 1=fails, not available
 ;
PROBLEM63(SERIESIX) ; check file 2005.63
 N ARTIFACTONFILE,RETURN,SERIESDATA6,SERIESDATA9,STATUS
 S RETURN=1 D
 . ; check IMAGE SERIES file
 . S SERIESDATA6=$G(^MAGV(2005.63,SERIESIX,6))
 . S ARTIFACTONFILE=$P(SERIESDATA6,"^",2) I 'ARTIFACTONFILE Q  ; artifact not on file
 . S SERIESDATA9=$G(^MAGV(2005.63,SERIESIX,9))
 . S STATUS=$P(SERIESDATA9,"^",1) I STATUS'="A" Q  ; series not accessible
 . S RETURN=0
 . Q
 Q RETURN ; 0=OK, no problem, 1=fails, not available
 ;
PROBLEM64(SOPIX) ; check file 2005.64
 N ARTIFACTONFILE,RETURN,SOPDATA6,SOPDATA11,STATUS
 S RETURN=1 D
 . ; check IMAGE SOP INSTANCE file
 . S SOPDATA6=$G(^MAGV(2005.64,SOPIX,6))
 . S ARTIFACTONFILE=$P(SOPDATA6,"^",2) I 'ARTIFACTONFILE Q  ; artifact not on file
 . S SOPDATA11=$G(^MAGV(2005.64,SOPIX,11))
 . S STATUS=$P(SOPDATA11,"^",1) I STATUS'="A" Q  ; SOP instance not accessible
 . S RETURN=0
 . Q
 Q RETURN ; 0=OK, no problem, 1=fails, not available
 ;
PROBLEM65(IMAGEIX) ; check file 2005.65
 N ARTIFACTIX,DELETED,IMAGEDATA0,IMAGEDATA1,IMAGEDATA4,ORIGINAL,RETURN,STATUS
 S RETURN=1 D
 . ; check IMAGE INSTANCE file
 . S IMAGEDATA0=$G(^MAGV(2005.65,IMAGEIX,0))
 . S ARTIFACTIX=$P(IMAGEDATA0,"^",2) I 'ARTIFACTIX="" Q  ; no artifact reference
 . S IMAGEDATA1=$G(^MAGV(2005.65,IMAGEIX,1))
 . S ORIGINAL=$P(IMAGEDATA1,"^",2) I 'ORIGINAL Q  ; only want original DICOM object
 . S STATUS=$P(IMAGEDATA1,"^",5) I STATUS'="A" Q  ; image not accessible
 . S IMAGEDATA4=$G(^MAGV(2005.65,IMAGEIX,4))
 . S DELETED=$P(IMAGEDATA4,"^",1,3) I DELETED'="",DELETED'="^^" Q  ; deleted image
 . S RETURN=0
 . Q
 Q RETURN ; 0=OK, no problem, 1=fails, not available
 ;
SERIES(VISTASTUDYUID,SERIESUID,SERIESCOUNT) ; increment series counters
 I '$D(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID)) D
 . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,0))+1)_" ; series count" ; increment series count
 . ; don't count a series uid if it was under a previous study uid
 . I '$D(^TMP("MAG",$J,"UIDS","VISTA SERIES UID",SERIESUID)) D  ; new series uid, count it
 . . S SERIESCOUNT=SERIESCOUNT+1 ; count of series instance uids, for all study uids
 . . Q
 . Q
 S ^TMP("MAG",$J,"UIDS","VISTA SERIES UID",SERIESUID,"STUDY UID",VISTASTUDYUID)=""
 Q
 ;
IMAGE(VISTASTUDYUID,SERIESUID,SOPUID,IMAGECOUNNT) ; increment image counters
 I '$D(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,SOPUID)) D
 . ; increment image count and save image in ^TMP
 . S ^(0)=($G(^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,0))+1)_" ; image count" ; increment image count
 . S IMAGECOUNT=IMAGECOUNT+1 ; count of sop instance uids, for all study & series uids
 . S ^TMP("MAG",$J,"UIDS","VISTA",VISTASTUDYUID,SERIESUID,SOPUID)=""
 . Q
 Q
 ;
 ;
SERVICES(CONSULTSERVICES,GETQRSCP) ; get services to query
 N ALPHA,DONE,I,IBEGIN,IEND,INCRMENT,ISCREEN,KEEPSCREEN
 N LIST,NPICK,NSCREENS,PROCNAME,QUIT,SERVICE,SERVICENAME,RETURN,X
 S GETQRSCP=$G(GETQRSCP,"NO")
 I GETQRSCP'="NO",GETQRSCP'="YES" D  Q -1
 . W !,"SERVICES^",$T(+0)," invoked with unrecognized GETQRSCP parameter: """,GETQRSCP,"""",!
 . Q
 K CONSULTSERVICES
 S SERVICE="" ; alpha sort services
 F I=1:1 S SERVICE=$O(^MAG(2006.5831,"B",SERVICE)) Q:'SERVICE  D
 . S SERVICENAME=$$GET1^DIQ(123.5,SERVICE,.01,"E")
 . S ALPHA(SERVICENAME)=SERVICE
 . Q
 S SERVICENAME="" ; put sorted services into LIST
 F I=1:1 S SERVICENAME=$O(ALPHA(SERVICENAME)) Q:SERVICENAME=""  D
 . S SERVICE=ALPHA(SERVICENAME)
 . S LIST(I)=SERVICENAME_"^"_SERVICE
 . I $D(^TMP("MAG",$J,"BATCH Q/R","CONSULT SERVICES",SERVICE)) S PICK(I)=1
 . Q
 ;
 S N=I-1,(QUIT,RETURN)=0
 ;
 I $D(PICK) D  Q:QUIT -1 W !
 . W !!,"CPRS Consult/Procedure Service(s) from Previous Run"
 . W !,"---------------------------------------------------"
 . S INCREMENT=IOSL-5
 . S NSCREENS=((N-1)\INCREMENT)+1
 . F ISCREEN=1:1:NSCREENS D
 . . S IBEGIN=1+((ISCREEN-1)*INCREMENT)
 . . S IEND=INCREMENT*ISCREEN
 . . S IEND=$S(IEND>N:N,1:IEND)
 . . W @IOF,"CPRS Consult/Procedure Service(s) from Previous Run"
 . . W !,"---------------------------------------------------"
 . . F I=IBEGIN:1:IEND D
 . . . W !?5
 . . . D SERVICE3
 . . . Q
 . . I ISCREEN<NSCREENS D CONTINUE^MAGDSTQ
 . . Q
 . I $$YESNO^MAGDSTQ("Do you wish to change this?","n",.X)<0 S QUIT=1 Q
 . I X="YES" D SERVICE1
 . Q
 E  D 
 . D SERVICE1
 . Q
 ;
 I RETURN'<0 D  ; build list of selected services, by ien
 . D SERVICE4(.CONSULTSERVICES,GETQRSCP,.LIST,.PICK)
 . Q
 I '$D(CONSULTSERVICES) D
 . W !!,"*** No consult/procedure service was selected ***"
 . D CONTINUE^MAGDSTQ
 . S RETURN=-2
 . Q
 Q RETURN
 ;
SERVICE1 ; present selection screen(s)
 S INCREMENT=IOSL-7,DONE=0
 S NSCREENS=((N-1)\INCREMENT)+1
 F ISCREEN=1:1:NSCREENS D  Q:DONE
 . S IBEGIN=1+((ISCREEN-1)*INCREMENT)
 . S IEND=INCREMENT*ISCREEN
 . S IEND=$S(IEND>N:N,1:IEND)
 . D SERVICE2
 . Q
 I 'DONE G SERVICE1 ; go back to first screen and repeat
 Q
 ;
SERVICE2 ; select the service from a screen full  
 S KEEPSCREEN=0
 W @IOF,"Select CPRS Consult/Procedure Service(s) with DICOM Imaging Capabilities"
 W !,"------------------------------------------------------------------------",!
 ; instructions
 W "There are ",N," services.  Enter a number to select or deselect each service,"
 W !,"enter ""A"" for all, and enter ""D"" when done with the selection.",!
 F I=IBEGIN:1:IEND D  Q:DONE
 . W !,$J(I,3),") "
 . D SERVICE3
 . Q
 ;
 ; process user selection(s)
 W !!,"Please enter ",IBEGIN,"-",IEND," to select/deselect a service (and ""D"" when done): "
 R X:DTIME E  S X="^"
 I "?"[$E(X) S X="?" ; <null> or "?..." becomes "?"
 I "^"[$E(X) S RETURN=-1,DONE=1 Q
 I "Dd"[$E(X) S DONE=1 Q
 I "Aa"[$E(X) D  Q
 . F I=1:1:N S PICK(I)=1
 . Q
 I X?1N.N,X>0,X'<IBEGIN,X'>IEND D
 . I $G(PICK(X)) S PICK(X)=0 ; deselect PICK(I)
 . E  S PICK(X)=1 ; select PICK(I)
 . S KEEPSCREEN=1
 . Q
 E  D
 . I X'="?" W " ???" R X:DTIME S KEEPSCREEN=1
 . Q
 ;
 I KEEPSCREEN=1 G SERVICE2 ; keep the same screen, don't go to next one
 Q
 ;
SERVICE3 ; output one service
 W $S($G(PICK(I)):"-->",1:"   "),$P(LIST(I),"^",1)
 Q
 ;
SERVICE4(CONSULTSERVICES,GETQRSCP,LIST,PICK) ; build list of selected services, by ien
 N I,IEN,MAGIEN0,N,PROCEDURE,QRPROVIDER,SERVICE,SVCNAME
 S N=$O(LIST(""),-1)
 F I=1:1:N I $G(PICK(I)) D
 . S SVCNAME=$P(LIST(I),"^",1),SERVICE=$P(LIST(I),"^",2)
 . S CONSULTSERVICES(SERVICE)=SVCNAME
 . I GETQRSCP="NO" Q  ; ignore Q/R Provider 
 . ; check each service for QUERY/RETRIEVE PROVIDER value
 . S IEN="" F  S IEN=$O(^MAG(2006.5831,"B",SERVICE,IEN)) Q:'IEN  D
 . . S MAGIEN0=$G(^MAG(2006.5831,IEN,0))
 . . S PROCEDURE=+$P(MAGIEN0,"^",2) ; null becomes 0
 . . ; check for a special Q/R provider
 . . S QRPROVIDER=$P(MAGIEN0,"^",8)
 . . I QRPROVIDER'="" D
 . . . S PROCNAME=$S(PROCEDURE:$$GET1^DIQ(123.3,PROCEDURE,.01,"E"),1:"CONSULT")
 . . . S CONSULTSERVICES(SERVICE,PROCEDURE)=PROCNAME_"^"_QRPROVIDER
 . . . Q
 . . Q
 . Q
 Q
 ;
QRSCP() ; get the q/r scp for the consult
 N MAG5831,QRSCP,TOSERVICE,X
 ;
 S QRSCP=^TMP("MAG",$J,"BATCH Q/R","PACS Q/R RETRIEVE SCP")
 ;
 ; does the consult modality worklist have a designated q/r scp?
 I IMAGINGSERVICE="CONSULTS" D
 . S TOSERVICE=$$GET1^DIQ(123,GMRCIEN,1,"I")
 . S MAG5831=$$MWLFIND^MAGDHOW1(TOSERVICE,GMRCIEN)
 . I MAG5831 D  ; get designated q/r scp for the worklist
 . . S X=$$GET1^DIQ(2006.5831,MAG5831,8,"E")
 . . I X'="" S QRSCP=X W !?20,"<<< Q/R SCP: ",QRSCP," >>>"
 . . Q
 . Q
 ;
 Q QRSCP
