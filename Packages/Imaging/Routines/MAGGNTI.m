MAGGNTI ;WOIFO/GEK/SG/NST/JSL - Imaging interface to TIU RPC Calls etc. ; 20 Jan 2010 10:08 AM
 ;;3.0;IMAGING;**10,8,59,93,108,122**;Mar 19, 2002;Build 92;Aug 02, 2012
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
FILE(MAGRY,MAGDA,TIUDA) ;RPC [MAG3 TIU IMAGE]
 ; Call to file TIU and Imaging Pointers
 ; TIU API to add image to TIU
 N X
 ;Patch 108
 ; Create a new TIU note if TIUDA equals zero
 I (TIUDA=0),'$$SETTIUDA(.MAGRY,MAGDA,.TIUDA) Q
 I $P(^TIU(8925,TIUDA,0),U,2)'=$P(^MAG(2005,MAGDA,0),U,7) S MAGRY="0^Patient Mismatch." Q
 D PUTIMAGE^TIUSRVPL(.MAGRY,TIUDA,MAGDA) ;
 I 'MAGRY Q
 ; Now SET the Parent fields in the Image File
 S $P(^MAG(2005,MAGDA,2),U,6,8)=8925_U_TIUDA_U_+MAGRY
 ; DONE.
 S MAGRY="1^Image pointer filed successfully"
 ; Now we save the PARENT ASSOCIATION Date/Time 
 D LINKDT^MAGGTU6(.X,MAGDA)
 Q
DATA(MAGRY,TIUDA) ;RPC [MAG3 TIU DATA FROM DA]
 ; Call to get TIU data from the TIUDA
 ; MAGRY: returns data from fields .01,1201,.02,1202 , .05
 ;           .01            1201         .02   1202 
 ;    TIUDA^Document Type ^Document Date^DFN^Author DUZ^Status
 ;
 ;  - old code
 ;S MAGRY=TIUDA_U_$$GET1^DIQ(8925,TIUDA,".01","E")_U_$$GET1^DIQ(8925,TIUDA,"1201","I")_U_$$GET1^DIQ(8925,TIUDA,".02","I")_U_$$GET1^DIQ(8925,TIUDA,"1202","I")_U
 ;
 ;P122 we need 1 if Status is Complete 0 otherwise. Status is field .05
 ; reformat code for easier reading, and add the 1 or 0 as 6th piece.
 ;
 N RES,CDA,ST
 D GETS^DIQ(8925,TIUDA,".01;1201;.02;1202;.05","EI","RES")
 I '$D(RES) S MAGRY="" Q  ;no TIU data
 S CDA=TIUDA_","
 S $P(MAGRY,U,1)=TIUDA
 S $P(MAGRY,U,2)=RES(8925,CDA,".01","E") ; Document Type
 S $P(MAGRY,U,3)=RES(8925,CDA,"1201","I") ;Document Date
 S $P(MAGRY,U,4)=RES(8925,CDA,".02","I") ;DFN
 S $P(MAGRY,U,5)=RES(8925,CDA,"1202","I") ;Author DUZ
 ; P122 Return Status  as 6th piece of Result String
 S $P(MAGRY,U,6)=RES(8925,CDA,".05","E") ; Status
 S $P(MAGRY,U,7)="" ; put's "^" on end of string.
 Q
IMAGES(MAGRY,TIUDA) ;RPC [MAG3 CPRS TIU NOTE]
 ; Call to get all images for a given TIU DA
 ; We first get all Image IEN's breaking groups into separate images
 ; Then get Image Info for each one.
 ; MAGRY    -     Return array of Image Data entries
 ; MAGRY(0)    is   1 ^ message  if successful
 ;                  0 ^ Error message if error;
 ; TIUDA  is IEN in ^TIU(8925
 ;
 ; Call TIU API to get list of Image IEN's
 N MAGARR,CT,TCT,I,J,Z K ^TMP($J,"MAGGX")
 N DA,MAGQI,MAGNCHK,MAGXX,MAGRSLT
 N TIUDFN,MAGQUIT ; MAGQI 8/22/01
 N MAGFILE ; MAGFILE is returned from MAGGTII
 ; 
 S MAGQUIT=0 ; MAGQI 8/22/01
 S TIUDFN=$P($G(^TIU(8925,TIUDA,0)),U,2) ;MAGQI 8/22/01
 I 'TIUDFN S MAGRY(0)="0^Invalid Patient DFN for Note ID: '"_TIUDA_"'"
 D GETILST^TIUSRVPL(.MAGARR,TIUDA)
 S CT=0,TCT=0
 ; Now get all images for all groups and single images.
 S I="" F  S I=$O(MAGARR(I)) Q:'I  S DA=MAGARR(I) D  ;Q:MAGQUIT
 . S Z=$$ISDELIMG(DA) I Z S TCT=TCT+1,MAGRY(TCT)="B2^"_Z Q
 . ; Check that array of images from selected TIUDA have 
 . ;     same patient's and valid backward pointers
 . I $P($G(^MAG(2005,DA,0)),U,7)'=TIUDFN S MAGQUIT=1,MAGNCHK="Patient Mismatch. TIU: "_TIUDA
 . I $P($G(^MAG(2005,DA,2)),U,7)'=TIUDA S MAGQUIT=1,MAGNCHK="Pointer Mismatch. TIU: "_TIUDA
 . I MAGQUIT S MAGXX=DA,MAGFILE=$$INFO^MAGGAII(MAGXX,"E") D  Q  ; D INFO^MAGGTII 
 . . ; remove the Abstract and Image File Names  ; 2/14/03 p8t14  remove c:\program files.  with   .\bmp\
 . . S $P(MAGFILE,U,2,3)="-1~Questionable Data Integrity^.\bmp\imageQA.bmp"
 . . ;this stops Delphi App from changing Abstract BMP to OFFLINE IMAGE
 . . S $P(MAGFILE,U,6)=$S(($P(MAGFILE,U,6)'=11):"99",1:11)
 . . S $P(MAGFILE,U,10)="M"
 . . ;Send the error message
 . . S $P(MAGFILE,U,17)=MAGNCHK
 . . S TCT=TCT+1,MAGRY(TCT)="B2^"_MAGFILE
 . ;
 . I $O(^MAG(2005,DA,1,0)) D  Q
 . . ; Integrity check, if group is questionable, add it's ien to list, not it's 
 . . ;   children.  Later when list is looped through, it's $$INFO^MAGGAII(MAGXX,"E") will be in 
 . . ;   list.  Have to do this to allow other images in list from TIU to be processed.
 . . D CHK^MAGGSQI(.MAGQI,DA) I 'MAGQI(0) S CT=CT+1,^TMP($J,"MAGGX",CT)=DA Q
 . . S J=0 ; the following line needs to take only the first piece of the node - PMK 4/4/02
 . . F  S J=$O(^MAG(2005,DA,1,J)) Q:'J  S CT=CT+1,^TMP($J,"MAGGX",CT)=$P(^(J,0),"^")
 . S CT=CT+1
 . S ^TMP($J,"MAGGX",CT)=DA
 ; Now get image info for each image
 ;
 S Z=""
 S MAGQUIET=1
 F  S Z=$O(^TMP($J,"MAGGX",Z)) Q:Z=""  D
 . S TCT=TCT+1,MAGXX=^TMP($J,"MAGGX",Z)
 . ;GEK 8/24/00 Stopping the Invalid Image IEN's and Deleted Images
 . I '$D(^MAG(2005,MAGXX)) D  Q
 . . D INVALID^MAGGTIG(MAGXX,.MAGRSLT) S MAGRY(CT)=MAGRSLT
 . ;D INFO^MAGGTII
 . S MAGFILE=$$INFO^MAGGAII(MAGXX,"E")
 . S MAGRY(TCT)="B2^"_MAGFILE
 K MAGQUIET
 S MAGRY(0)=TCT_"^"_TCT_" Images for the selected TIU NOTE"
 ; Put the Image IEN of the last image into the group IEN field.
 Q:'TCT
 S $P(MAGRY(0),U,3)=TIUDA
 K MAGRSLT
 D DATA(.MAGRSLT,TIUDA)
 S $P(MAGRY(0),U,4)=$$GET1^DIQ(8925,TIUDA,".02","E")_"  "_$P(MAGRSLT,U,2)_"  "_$$FMTE^XLFDT($P(MAGRSLT,U,3),"8")
 ;
 S $P(MAGRY(0),U,5)=$S($P($G(MAGFILE),U):$P(MAGFILE,U),$G(MAGXX):MAGXX,1:0)
 Q
 ;
ISDELIMG(MAGIEN) ; Is this a deleted Image.
 N ERR,MAGR,MAGT,Z
 ;--- Check the image status
 I '$$ISDEL^MAGGI11(MAGIEN,.ERR)  D  Q:$G(MAGT)="" MAGR
 . I ERR'<0    S MAGR="0^Valid Image"  Q
 . I +ERR=-43  S MAGR="0^Image IEN exists, and is Deleted !"  Q
 . S MAGR="Invalid Image pointer",MAGT=67
 . Q
 E  S MAGR="Deleted Image",MAGT=66
 ;--- Special processing for deleted images and errors
 S $P(Z,U,1,4)=MAGIEN_U_"-1~"_MAGR_U_"-1~"_MAGR_U_MAGR
 S $P(Z,U,6)=MAGT
 ;--- This stops client from changing Abstract BMP to OFFLINE IMAGE
 S $P(Z,U,10)="M"
 ;--- Return the error message
 S $P(Z,U,17)=$P(MAGR,U,2)
 Q Z
 ;
ISDOCCL(MAGRY,IEN,TIUFILE,CLASS) ;RPC [MAGG IS DOC CLASS]
 ;Checks to see if IEN of TIU Files 8925 or 8925.1 is of a certain Doc Class 
 ;MAGRY  = Return String  
 ;                 for Success   "1^message"
 ;                 for Failure   "0^message"
 ;IEN    = Internal Entry Number in the TIUFILE
 ;TIUFILE = either 8925   if we need to see if a Note is of a Document Class 
 ;            or   8925.1 if we need to see if a Title is of a Document Class
 ;CLASS  = Text Name of the Document Class   example: "ADVANCE DIRECTIVE"
 ;
 S MAGRY="0^Unknown Error checking TIU Document Class"
 K MAGTRGT,DEFIEN,DOCCL,RES,DONE,NTTL
 S DONE=0
 ; If we're resolving a Title
 I TIUFILE="8925.1" D  Q:DONE
 . S DEFIEN=IEN,NTTL="Title"
 . I '$D(^TIU(8925.1,DEFIEN,0)) S MAGRY="0^Invalid Title IEN",DONE=1 Q
 . Q
 ; If we're resolving a Note
 I TIUFILE="8925" D  Q:DONE
 . S NTTL="Note"
 . I '$D(^TIU(8925,IEN)) S MAGRY="0^Invalid Note IEN",DONE=1 Q
 . ; Get Title IEN from Note IEN
 . S DEFIEN=$$GET1^DIQ(8925,IEN_",",.01,"I")
 . I DEFIEN="" S MAGRY="0^Error resolving Document Class from Note IEN" S DONE=1 Q
 . Q
 ;
 ; Find the IEN in 8925.1 for Document Class (CLASS) 
 D FIND^DIC(8925.1,"","@;.001","X",CLASS,"","","I $P(^(0),U,4)=""DC""","","MAGTRGT")
 S DOCCL=$G(MAGTRGT("DILIST",2,1))
 ;
 ; See if ^TIU(8925.1,DEFIEN is of Document Class DOCCL
 S RES=$$ISA^TIULX(DEFIEN,DOCCL)
 I RES S MAGRY="1^The "_NTTL_" is of Document Class "_CLASS Q
 S MAGRY="0^The "_NTTL_" is Not of Document Class "_CLASS
 Q
 ;
 ; *******************
 ; Patch 108
 ; Create a new TIU stub using data in ^MAG(2006.82 by Tracking ID
 ; In this way BP doesn't need to be recompiled
 ;
 ; Return Values
 ; =============
 ;  0 for failure
 ;  1 for success
 ;  
 ;  MAGRY 
 ;     for failure   "0^message"
 ;     for success   "TIU Note IEN^message"
 ;  TIUDA - TIU Note IEN
 ;   
 ; Input Parameters
 ; ================
 ;  MAGDA - Image IEN in file #2005
 ; 
SETTIUDA(MAGRY,MAGDA,TIUDA) ;
 N TRKID,TIUTTL,TIUTCNT
 N MAGTEXT,MAGDFN,MAGADCL,MAGMODE,MAGES,MAGESBY,MAGDATE
 N MAGIAPI,TIUIEN
 S TRKID=$$GET1^DIQ(2005,MAGDA,"108")  ; Tracking ID - it is unique
 I TRKID="" S MAGRY="0^TIUDA equals zero and Tracking ID is not found." Q 0
 ; Get import data
 D GETIAPID^MAGGSIUI(.MAGIAPI,TRKID)
 I '$D(MAGIAPI) S MAGRY="0^TIUDA equals zero and no data found by Tracking ID." Q 0  ; no data quit
 S TIUTTL=$G(MAGIAPI("PXTIUTTL")) ; Get TIU Title
 ; Validate TIU Title
 I '$$GETTIUDA^MAGGSIV(.MAGRY,TIUTTL,.TIUIEN) Q 0
 S TIUTTL=TIUIEN  ; set TIUTTL to internal TIU Title in case the external value is provided
 ; Get Text
 S TIUTCNT=+$G(MAGIAPI("PXTIUTCNT"))  ; TIU note Text Lines Count
 F I=0:1:TIUTCNT-1 D
 . S MAGTEXT(I)=$G(MAGIAPI("PXTIUTXT"_$TR($J(I,5)," ",0)))  ; Get Text Lines
 . Q
 S MAGTEXT(TIUTCNT)="   VistA Imaging Import API - Imported Document"
 S MAGDFN=$$GET1^DIQ(2005,MAGDA,"5","I")  ; Patient DFN
 S MAGADCL=+$G(MAGIAPI("PXSGNTYP"))  ; Signature Type - 0 unsigned/ 1 Admin closed/ 2 Signed
 S MAGMODE="E"
 S MAGES=""
 S MAGESBY=$$GET1^DIQ(2005,MAGDA,"8","I")   ; Image Capture by ( Signed)
 S MAGDATE=$G(MAGIAPI("PXDT")) ; TIU note Date
 ; Create a new TIU note
 D NEW^MAGGNTI1(.MAGRY,MAGDFN,TIUTTL,MAGADCL,MAGMODE,MAGES,MAGESBY,"",MAGDATE,"",.MAGTEXT)
 I $P(MAGRY,"^") S TIUDA=+MAGRY  D UPDPKG^MAGGNTI(MAGDA,TIUDA) Q 1
 Q 0
 ;
 ; *******************
 ; Patch 108
 ; Update Package Index (#40) in #2005 based on TIU Note info.
 ; 
 ; Input Parameters
 ; ================
 ;  MAGDA - Image IEN in file #2005
 ;  PXIEN - TIU Note IEN in file #8925
 ;
UPDPKG(MAGDA,PXIEN) ;Patch 108: Update Package Index (#40) in #2005 based on TIU Note info.
 N PKG,MAGRY,OK,MAGGFDA,MAGGXE,MAGNOFMAUDIT
 S PKG=$$GET1^DIQ(2005,MAGDA_",",40)
 I PKG'="NONE" Q  ; Quit if the package is already set to something else than "NONE"
 S PKG=""
 D DATA^MAGGNTI(.MAGRY,PXIEN)
 D ISCP^TIUCP(.OK,$P(MAGRY,U,2)) I OK S PKG="CP"
 I PKG="" D ISCNSLT^TIUCNSLT(.OK,$P(MAGRY,U,2)) I OK S PKG="CONS"
 I PKG="" S PKG="NOTE"
 S MAGGFDA(2005,MAGDA_",",40)=PKG
 S MAGNOFMAUDIT=1  ; Do not file the changes in Audit file.
 ;                   We are not done with initial setup
 D UPDATE^DIE("","MAGGFDA","","MAGGXE")
 Q
