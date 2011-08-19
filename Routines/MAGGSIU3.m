MAGGSIU3 ;WOIFO/GEK - Utilities 
 ;;3.0;IMAGING;**7,8,48**;Jan 11, 2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
LOG(MAGRY,MAGIX,IMAGES,PAT,WRKS,TRKID) ;Utilities for Import API, logging data for tracking and debugging 
 ; into Imaging Windows Session and Imaging Windows Workstation files.
 N WRKSIEN,WRKSN0,USERSRV,MAGSTART,I,SESSIEN,X,Z,DIERR
 I '$L($G(WRKS)) S WRKS="NULL WORKSTATION NAME"
 S WRKSIEN=0
 S SESSIEN=0
 S WRKSIEN=$O(^MAG(2006.81,"B",WRKS,""))
 I 'WRKSIEN D NEWWRKS^MAGGTAU(WRKS,"",.WRKSIEN) I WRKSIEN<1 S MAGRY="0^Error Creating Workstation Entry." Q 0
 ;
 S WRKSN0=^MAG(2006.81,WRKSIEN,0) ; '0' node for use later.
 S WRKSIEN=+WRKSIEN_","
 S MAGGFDA(2006.81,WRKSIEN,.01)=WRKS ; Computer Name
 S MAGGFDA(2006.81,WRKSIEN,8)=0 ; Active or not.
 S MAGGFDA(2006.81,WRKSIEN,3)="@" ; delete logoff time for this job.
 S MAGGFDA(2006.81,WRKSIEN,10)="@" ; delete session pointer
 S MAGGFDA(2006.81,WRKSIEN,11)="@" ; reset the session error count.
 ;
 ;
 S MAGGFDA(2006.81,WRKSIEN,12.5)=$P(WRKSN0,U,14)+1 ; total Import Sessions for workstation
 ;
 S X=$$NOW^XLFDT
 S MAGSTART=$E(X,1,12)
 I $G(DUZ) D 
 . S MAGGFDA(2006.81,WRKSIEN,1)=DUZ
 . S MAGGFDA(2006.81,WRKSIEN,2)=MAGSTART
 ;
 D UPDATE^DIE("S","MAGGFDA","MAGXIEN","MAGXERR")
 I $D(DIERR) D RTRNERR^MAGGTAU(.MAGRY) Q 0
 ; 
 S MAGRY="1^"
 ;
 ; SESSION : Now here we have to create a new session entry;
 ; //TODO, make a generic call to create a Session entry, this is 
 ;   a duplicate of code in MAGGTAU
 D GETS^DIQ(200,DUZ_",","29","I","Z","") ; service/section
 S USERSRV=$G(Z(200,DUZ_",",29,"I"))
 ;
 K MAGGFDA,MAGXERR,MAGXIEN
 S MAGGFDA(2006.82,"+1,",.01)=$P(^VA(200,DUZ,0),U,1) ; User
 S MAGGFDA(2006.82,"+1,",1)=DUZ ; USER
 S MAGGFDA(2006.82,"+1,",2)=MAGSTART ; Session Start Time
 S MAGGFDA(2006.82,"+1,",4)=+WRKSIEN ; Workstation 
 I $D(^DPT(+PAT,0)) S MAGGFDA(2006.82,"+1,",5)=+PAT ; Patient 
 S MAGGFDA(2006.82,"+1,",7)=+USERSRV ; User's Service/Section pointer
 S MAGGFDA(2006.82,"+1,",13)=3 ; 1=normal 2= started by CPRS 3= Import API session.
 S MAGGFDA(2006.82,"+1,",8)=$G(TRKID) ; Tracking ID
 ;
 D UPDATE^DIE("","MAGGFDA","MAGXIEN","MAGXERR")
 I $D(DIERR) D RTRNERR^MAGGTAU(.MAGRY) Q 0
 S MAGRY="1^"
 I '+MAGXIEN(1) S MAGRY="0^" Q 0
 S SESSIEN=+MAGXIEN(1)
 S MAGRY=SESSIEN_"^Session # "_SESSIEN_" Started."
 S MAGGFDA(2006.81,+WRKSIEN_",",10)=SESSIEN
 D UPDATE^DIE("","MAGGFDA","MAGXIEN","MAGXERR")
 D ACTION^MAGGTAU("IMPORT^",0,SESSIEN)       ;
 S I="" F  S I=$O(MAGIX(I)) Q:I=""  D ACTION^MAGGTAU("Data:|"_"("_I_"): "_$TR(MAGIX(I),"^","~"),0,SESSIEN)
 S I="" F  S I=$O(IMAGES(I)) Q:I=""  D ACTION^MAGGTAU("Image:|"_"("_I_"): "_$TR(IMAGES(I),"^","~"),0,SESSIEN)
 Q SESSIEN
LOGRES(RES,LOGTM,MAGSESS) ;
 N I
 S LOGTM=+$G(LOGTM)
 I '$G(MAGSESS) Q
 D ACTION^MAGGTAU("RESULTS^",1,MAGSESS)       ;
 S I="" F  S I=$O(RES(I)) Q:I=""  D ACTION^MAGGTAU("Result:|"_"("_I_"): "_$TR(RES(I),"^","~"),LOGTM,MAGSESS)
 Q
INPRC(RET,ARR) ; gek/Duplicate Import check
 ; gek/stop duplicates. Import now has a status in the Session File.
 ; ^MAG(2006.82,"STATUS",TRKID,SESSION IEN)= status
 ; INPRC tells if the Session (by Tracking ID) is in process  or not.
 ; if In Process, we won't return the data.
 ; INPRC will set the status to In Process if not currently in process.
 ; P48T1  This function is not called in P48.
 ;   Possible use in future.
 N I,SESS,STAT,TRKID
 S TRKID=0
 S I="" F  S I=$O(ARR(I)) Q:I=""  D
 . S FLD=$P(ARR(I),"^",1) I (FLD=108)!(FLD="TRKID") D
 . . S TRKID=$P(ARR(I),"^",2)
 . . Q
 . Q
 I TRKID="" S RET="0^Null value for Tracking ID." Q 0
 S RET="0^This tracking ID: "_TRKID_" isn't being processed"
 I '$D(^MAG(2006.82,"E",TRKID)) Q 0
 S SESS=$$SES4TRK(TRKID) Q:'SESS 0  ; This tracking ID isn't being processed yet.
 S STAT=$$GETSTAT(TRKID,SESS)
 I 'STAT D SETSTAT(TRKID,SESS,"-5") Q 0  ; -5 means In Process
 ; If in process we return 1
 I (+STAT=-5) D  Q 1
 . S RET="0^Import for Tracking ID: "_TRKID_" has been processed."
 Q 0
SES4TRK(TRKID) ; Returns the Session ID for a Tracking ID
 Q +$O(^MAG(2006.82,"E",TRKID,""),-1)
 ;
GETSTAT(TRKID,SESS) ; Get Status for given Tracking ID and Session ID
 Q $G(^MAG(2006.82,"STATUS",TRKID,SESS))
 ;
SETSTAT(TRKID,SESS,STAT) ; Set Status for given Tracking ID and Session ID
 S ^MAG(2006.82,"STATUS",TRKID,SESS)=STAT
 Q
