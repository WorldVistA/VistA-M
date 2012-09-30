MAGGSIU4 ;WOIFO/NST/GEK - Utilities for Image Import API ; 22 Feb 2011 12:28 PM
 ;;3.0;IMAGING;**121**;Mar 19, 2002;Build 2340;Oct 20, 2011
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
 Q
 ; ----- Rescind images attached to a TIU note
 ; RESCIND(MAGRY,TIUDA)
 ;
 ; Input Parameters
 ; ================
 ; TIUDA = IEN of TIU note in TIU DOCUMENT file (#8925) 
 ;           
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = 0^Error message"
 ;   MAGRU(1..N) = messages describing the Error.
 ;   
 ; if success
 ;   MAGRY(0) = 1^Success
 ;   .. for each image queued we have 3 lines of info.
 ;   MAGRY(x)   = Image(1..n): Tracking ID: TRKID  
 ;   MAGRY(x+1) = Image(1..n): Queue: QUENUMBER
 ;   MAGRY(x+2) = Image(1..n): Image: MAGDA
 ;   
 ; if First image success, and subsequent image problem we Return
 ;   MAGRY(0) =  2^Warning message
 ;   for each successfully Queued image queued we have 3 lines of info as above
 ;   for any image that was a problem deleting (unlikely) we have MAGDA and 
 ;   error messages.  The Image is changed to status of "Needs Review", 
 ;     so it is blocked from view.
 ;   MAGRY(x) = Image(n): Image: MAGDA
 ;   MAGRY(x+1) = 
 ;   
 ;   
 ;   Tracking ID is a field in each file: 
 ;      IMAGE File (#2005) (Field #108) (index "ATRKID")
 ;      IMAGING WINDOWS SESSION File (#2006.82) (Field #8) (index "E")
 ;      ACQUISITION SESSION FILE File(#2006.041)(Field #.02) (index "C")
 ;
RESCIND(MAGRY,TIUDA) ; Main entry point to rescind images attached to a TIU note
 N IMGLIST,MAGA,QUECT
 N MAGIEN,REASON,REASDA,MERR
 N I,I2,S,ICT,N0,N2,N40,MPOS
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 K MAGRY
 ; check TIUDA
 I '$G(TIUDA) S MAGRY(0)="0^TIU Note is not valid: "_TIUDA Q
 I '$D(^TIU(8925,TIUDA)) S MAGRY(0)="0^TIU Note does not exist: "_TIUDA Q
 ;
 ; Does Note have any Images.  Quit if No.
 D GETILST^TIUSRVPL(.MAGA,TIUDA)
 I '$D(MAGA) S MAGRY(0)="1^No images found for TIU Note: "_TIUDA  Q  ; no images found 
 ;
 ;  Set the Reason text and Reason DA
 S REASON="Rescinded TIU Note"
 S REASDA=$O(^MAG(2005.88,"B",REASON,""))
 ;
 S MAGRY(0)="0^Processing Rescind request..."
 D IMAGES^MAGGNTI(.IMGLIST,TIUDA)  ; Get a list with images linked to TIU note
 ; format of result to IMAGES:  
 ; XX(1)="B2^20175^<FULL UNC PATCH to Full Res Image>^<FULL UNC PATCH to Abstract>
 ;  we know there are images (from above) so a '0^' means an error in this situation.
 I '$P(IMGLIST(0),"^",1) D  Q  ;
 . S MAGRY(0)="0^Error building Image list for TIU Note: "_TIUDA
 . S MAGRY($O(MAGRY(""),-1)+1)=IMGLIST(0)
 . D MAILERR("",TIUDA,.MAGRY) Q
 . Q
 ;
 S I=0,ICT=0,QUECT=0,MERR=""
 ; we are setting an Import Queue for each image attached to the Note.
 F  S I=$O(IMGLIST(I)) Q:I=""  D  I $L(MERR) S MAGRY(0)=MERR Q
 . S ICT=ICT+1 ; Image Counter.
 . ; example: (1)="B2^19412^c:\image\Q...\QRT00000019412.JPG^c:\image\Q...\QRT00000019412.ABS
 . S MAGIEN=$P(IMGLIST(I),U,2)
 . K MAGRY2
 . D RSND1^MAGGSIU5(.MAGRY2,MAGIEN,TIUDA,REASON)
 . ;
 . ; We need to build MAGRY with MAGRY2 from each image.
 . S I2="" F  S I2=$O(MAGRY2(I2)) Q:(I2="")  D
 . . S MAGRY($O(MAGRY(""),-1)+1)="Image("_ICT_") "_MAGRY2(I2)
 . . Q
 . ;   add the Image IEN to Result Array.
 . S MAGRY($O(MAGRY(""),-1)+1)="Image("_ICT_") IEN: "_MAGIEN
 . ; if success MAGRY2(0)= QueNumber ^Data has been Queued.
 . I MAGRY2(0)>0 S QUECT=QUECT+1
 . I 'MAGRY2(0) D  ;
 . . ; If Error after calling RSND1, then if Image ISN'T Deleted, we
 . . ; want to change it's status to 'Needs Review' to block it from view.
 . . D SETSTAT(MAGIEN,11,REASDA)
 . . ;
 . . ; if this is first image, we Quit the process.
 . . I ICT=1 S MERR=MAGRY2(0) Q
 . . ; if this is image other than first, we return Warning.
 . . S MAGRY(0)="2^Warning while creating Import Queue"
 . . Q
 . Q
 ; add TIUDA to the result Array.
 S MAGRY($O(MAGRY(""),-1)+1)="TIU Note: "_TIUDA
 ; Call MAILERR if needed  i.e if  MAGRY(0)=0 OR 2  .
 I $L(MERR)!(+MAGRY(0)=2) D MAILERR("","",.MAGRY) Q
 ;  Here.  Image has been queued.   If Group, check for QUECT not equal Image Count.
 S MPOS="" I QUECT>1 S MPOS="s"
 S MAGRY(0)="1^"_QUECT_" Image"_MPOS_" Queued for RESCINDED watermark"
 ; if only some of images queued for watermark, change status in 
 ; (0) node to warning '2' and add a line of text.
 I QUECT<ICT D
 . S $P(MAGRY(0),"^",1)="2"
 . S MAGRY($O(MAGRY(""),-1)+1)="Warning : Only "_QUECT_" of "_ICT_" images were Queued for Watermark"
 Q
 ;
 ; --------  TRKID()   Returns Unique Tracking ID for Import API --------
 ;   Imaging is now a 'user' of the Import API.  This API call will 
 ;   guarantee a unique Imaging Tracking ID number for Rescind "MAGRSND"
 ;   to be used when Imaging Calls the Import API.
 ;  ; e.g. MAGRSND;3110222.080459.344
TRKID() ; Returns a new unique Import API tracking id
 N TKI,EDT
 ; Set the required 0 node of XTMP.  
 S EDT=$$FMADD^XLFDT(DT,30)
 I $P($G(^XTMP("MAGTRKID",0)),"^",1)<EDT S $P(^XTMP("MAGTRKID",0),"^",1,2)=EDT_"^"_DT
 ;
 ; Need to use LOCKs and daily counter to assure we have unique TRKID
 ; Lock it, increment today's counter, use increment, update counter and UnLock it for next.  
 L +^XTMP("MAGTRKID"):4 E  Q 0
 S TKI=$G(^XTMP("MAGTRKID",DT))+1
 S ^XTMP("MAGTRKID",DT)=TKI
 L -^XTMP("MAGTRKID")
 ;
 Q "MAGRSND;"_$$NOW^XLFDT_"."_TKI
 ;
 ;
 ; --------  STATCB(STATARR) -----------
 ;   TAG^ROUTINE Receives the status array of the Import Process.
 ;   This is the Imaging Callback function required by the Import API.
 ;   This Status Callback is for the RESCIND Import function.
 ;   STATARR is the status array of the Import Process
 ;    ;   STATARR is the format
 ;   (0)=0|1|2     0=Error, 1=Success, 2=Warning
 ;   (1)=Tracking ID
 ;   (2)=Queue Number
 ;   (3..n)= any extra messages describing error or warning. 
 ;
STATCB(STATARR) ; CALLBACK function for IAPI Status array for Rescinded Import.
 ;   Tracking of Rescinded Image through IMAGE ACCESS LOG (#2006.95) 
 ;   For Rescinded Images : Set Delete Queue with File Name(s)
 ;   i.e. the Image Entry in 2005 is already deleted, now delete the Image Files
 ;   Email Status of Rescind to Mail Group.  Success, Warning or Error.
 ;   
 N IDATA,TRKID,I,SESS,SDATA
 N MAGDUZ,MAGO,MAGDFN,MAGAD
 S TRKID=$G(STATARR(1))
 I $L(TRKID) D
 . S SESS=$$SES4TRK^MAGGSIU3(TRKID)
 . I $L(SESS) D  ; Create Entry in IMAGE ACCESS LOG file (#2006.95)
 . . S SDATA=$G(^MAG(2006.82,SESS,0))
 . . S MAGDUZ=$P(SDATA,"^",2),MAGO=$P(SDATA,"^",7),MAGDFN=$P(SDATA,"^",6)
 . . ; set the Additional info (MAGAD) to the (0) node message or warning. 
 . . ;    get out "^" for storage.
 . . S MAGAD=$TR(STATARR(0),"^","~")
 . . ; Parameters needed:    (MAGAD optional)
 . . ; ENTRY^MAGLOG(MAGIMT     ,MAGDUZ         ,MAGO        ,MAGPACK,   MAGDFN   ,MAGCT,MAGAD)
 . . D ENTRY^MAGLOG("RESCIND",MAGDUZ,MAGO,"IAPI",MAGDFN,1,MAGAD)
 . . Q
 . ;  If there are Rescinded image files, we get a list of the files we need 
 . ;  to set Delete Queues for.  i.e. this is Abs, Full, Big and Alt (Alt is TXT File).
 . ;  In the Session File we saved the Place. Place is needed for the Delete function.
 . ;  So we get data from Session File (#2006.82) for the files to delete.
 . D GETIAPID^MAGGSIUI(.IDATA,TRKID) ; Data from (#2006.82) Session File.
 . S I=0 F  S I=$O(STATARR(I)) Q:'I  D  ;
 . . I $P(STATARR(I),"^",1)="RESCINDED IMAGE FILE" D DELFILES(.IDATA)
 . . Q
 . Q
 ; Mail Status.
 D MAILSTAT(.STATARR)
 Q
 ; --------  Notifies user of problems of the Rescind/Watermark attempt.
 ;      IEN : IMAGE File (#2005)
 ;      TIUDA : TIU DOCUMENT File (#8925)
 ;      STARR : Status array to send in message.
MAILERR(IEN,TIUDA,STARR) ;  Notifies user of problems.
 ; IEN = IEN of the image in IMAGE file (#2005)
 ; TIUDA = IEN of Note in TIU DOCUMENT File (#8925)
 ; Only add IEN, TIUDA if requested.
 I $G(IEN) S STARR($O(STARR(""),-1)+1)="Image IEN: "_$G(IEN)
 I $G(TIUDA) S STARR($O(STARR(""),-1)+1)="TIU Note: "_$G(TIUDA)
 D MAILSTAT(.STARR)
 Q
 ;
 ; ----- MAILSTAT -  Mail Msgs from RESCIND Function.--------
 ;      STATARR : Status Array to send to G.MAG SERVER mail group.
 ;      
MAILSTAT(STATARR) ;Status Callback (called by the import API)
 ;
 N I,MARR,CT
 N XMDUZ,XMSUB,XMTEXT,XMY
 ;  0 = error, 2 = Warning, 1 = Success.
 ; [  ] do we Always send email, Success or Not. ?
 ; or only sending Error and Warning, because too many emails ?  
 ; I $P(STATARR(0),"^",1)'=1 D  ;
 D  ; For now, Always send email, Success or Not.
 . ; send email to G.MAG SERVER and current user.
 . ;Send to:
 . S XMY("G.MAG SERVER")=""
 . S XMDUZ=DUZ ; Current User could be TIU User. Send DUZ also.
 . S XMSUB="Import API Report"
 . S XMTEXT="MARR("
 . ; XMD needs array to start with 1
 . S CT=0,I=""
 . F  S I=$O(STATARR(I)) Q:I=""  D
 . . S CT=CT+1,MARR(CT)=I_") "_STATARR(I)
 . . Q
 . S CT=CT+1,MARR(CT)=" "
 . S CT=CT+1,MARR(CT)="   The preceding array was generated by"
 . S CT=CT+1,MARR(CT)="   the VistA Imaging Import API while "
 . S CT=CT+1,MARR(CT)="   processing a 'RESCIND' Image action."
 . D ^XMD
 . Q
 Q
 ; -----    Set Status of Image and Status Reason.
 ;   MAGIEN = Internal entry number IMAGE File (#2005)
 ;   STAT   = Internal value for STATUS Field  (#113)
 ;   REASDA = Internal value for STATUS REASON Field (#113.3)
 ;   
SETSTAT(MAGIEN,STAT,REASDA) ;
 N MAGFDA,MAGERR,IENC,MSG
 S IENC=MAGIEN_","
 S MAGFDA(2005,IENC,113)=STAT
 ; This is computed: 113.1)=DT   Status Date
 ; This is computed:,113.2)=DUZ
 I $G(REASDA) S MAGFDA(2005,IENC,113.3)=REASDA
 D UPDATE^DIE("S","MAGFDA","","MAGERR")
 I $D(MAGERR) D 
 . D RTRNERR(.MSG)
 . S MAGRY($O(MAGRY(""),-1)+1)="Failed to Set Status: "_MSG
 . Q
 Q
 ; 
 ; ----- RTRNERR Catch FM error during processing of Rescind Image.
 ; Return the Error from FM Call in ETXT.
RTRNERR(ETXT) ; There was error from UPDATE^DIE quit with error text
 S ETXT="0^ERROR  "_MAGERR("DIERR",1,"TEXT",1)
 Q
 ; --------  DELETE - Delete Image entry. Rescind Function.--------
 ;   IEN : IMAGE FILE (#2005) Internal entry Number
 ;   REASON : Free text for (#30.2) DELETED REASON [3F] ^
DELETE(IEN,REASON) ; Delete Image by IEN
 N RSLT,IENDF
 L +^MAG(2005,IEN):4
 E  Q "0^Image ID# "_IEN_" is Locked. Delete is Canceled"
 ;  the call to DELETE has 3rd param =0  this means do not Set the Delete Queue to 
 ;  delete the file from Share.  We will set the Delete Queue to delete the file 
 ;  from share after the successful watermarking process.
 ; gek 121T2 This is the IEN + the Force Delete Flag.  User won't need MAG DELETE key.
 S IENDF=IEN_"^"_1
 ; '0' in 3rd param : this is a flag to tell function to NOT queue images for delete by 
 ;   the BP yet.
 D DELETE^MAGGTID(.RSLT,IENDF,0,1,REASON)
 L -^MAG(2005,IEN)
 Q RSLT(0)
 ;
 ; --------  DELFILES(IDATA)  After a Rescind Action.
 ;  IDATA : has filenames and file places, format is :
 ;  "FullFile^AbsFile^BigFile|FullPlace^AbsPlace^BigPlace"
 ;  
 ;   from the Status Callback call, if successful import and watermark,  then we
 ;  delete the Image Files associated with the Image that was Rescinded.
DELFILES(IDATA) ;This will format the data for the call to set the Delete Queue.
 N RSN1,RSN2,I,RSNF
 N MAGPLC,MAGFILE2,X,X2,ALTEXT,ALTPATH
 ; Only 1 image is in a Rescind Import.
 ; example : 
 ; ..IMAGE,1)=20467~c:\image\SLA0\00\00\02\04\SLA00000020467.TIF~c:\image\SLA0\00\00\02\04\SLA00000020467.ABS~|1~1~1
 ; RSNF= c:\image...\SLA00000020467.TIF~c:\image...\SLA00000020467.ABS~
 ; RSN2=1~1~1
 S RSN1=$P($G(IDATA("IMAGE",1)),"|",1)
 S RSNF=$P(RSN1,"~",2,4)
 S RSN2=$P($G(IDATA("IMAGE",1)),"|",2)
 F I=1,2,3 D 
 . ; Send the Full Path and Place : for Full, Abs, Big.
 . ; Don't set null values in the Queue
 . I ($P(RSNF,"~",I)="")!($P(RSN2,"~",I)="") Q
 . S X=$$DELETE^MAGBAPI($P(RSNF,"~",I),$P(RSN2,"~",I))
 . Q
 ;Delete any other ALTernate files. ( TXT) 
 ; -- code from MAGGTID, Can't call MAGGTID, because the 2005 entry is gone.
 ;    (gek 3/31/03) Since ALT files are (for now) always on same server as Full
 ;    We only attempt to delete them here  (If we have a path to FullRes on Magnetic)
 ;
 S MAGFILE2=$P(RSNF,"~",1),MAGPLC=$P(RSN2,"~",1)
 S X2=0
 ; Don't set null values in the Queue 
 I (MAGFILE2="")!(MAGPLC="") Q
 F  S X2=$O(^MAG(2006.1,MAGPLC,2,X2)) Q:'X2  D
 . S ALTEXT=^MAG(2006.1,MAGPLC,2,X2,0)
 . S ALTPATH=$P(MAGFILE2,".")_"."_ALTEXT
 . S X=$$DELETE^MAGBAPI(ALTPATH,MAGPLC)
 . Q
 Q
