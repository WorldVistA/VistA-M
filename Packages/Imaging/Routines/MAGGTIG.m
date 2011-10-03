MAGGTIG ;WOIFO/GEK/SG - MAGGT Image Get. Callbacks to Get Image lists ; 3/9/09 12:51pm
 ;;3.0;IMAGING;**8,48,93**;Dec 02, 2009;Build 163
 ;; Per VHA Directive 2004-038, this routine should not be modified.
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
GRPCOUNT(MAGRY,MAGIEN) ;
 S MAGRY=+$P($G(^MAG(2005,MAGIEN,1,0)),U,4)
 Q
IMAGES(MAGRY,MAGDFN) ;RPC [MAGG PAT IMAGES]
 ;  Call to return a list of images for a patient.
 ;   We are returning all images for a patient, Groups are returned
 ;   as one Image.
 ;   The Images are returned in Rev Chronological Order, latest image
 ;   first, oldest image last.
 ;   User can reorder at the workstation level.
 K MAGRY
 N Y,RDT,PRX,CT,IEN,GBLRET
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 S MAGDFN=+MAGDFN
 ;  if no Images for the patient, then quit.
 I '$D(^MAG(2005,"APDTPX",MAGDFN)) S MAGRY(0)="1^0" Q
 ;   the "APDTPX" cross reference is :
 ;     "APDTPX",DFN,Rev Date,Procedure,MAGIEN )
 ;
 ;  we'll use @ notation, this'll work if an Array or a Global Array is begin returned
 S GBLRET=0
 S MAGRY="MAGRY"
 S CT=0,RDT=""
 F  S RDT=$O(^MAG(2005,"APDTPX",MAGDFN,RDT)) Q:'RDT  D
 . S PRX="" F  S PRX=$O(^MAG(2005,"APDTPX",MAGDFN,RDT,PRX)) Q:PRX=""  D
 . . S IEN=""
 . . F  S IEN=$O(^MAG(2005,"APDTPX",MAGDFN,RDT,PRX,IEN)) Q:'IEN  D
 . . . Q:$P($G(^MAG(2005,IEN,0)),"^",10)  ; CHILD OF GROUP
 . . . Q:$$ISDEL^MAGGI11(IEN)             ; Deleted image
 . . . S CT=CT+1
 . . . I (CT>100),'GBLRET D ARY2GLB
 . . . ;S MAGXX=IEN D INFO^MAGGTII
 . . . S MAGXX=IEN,MAGFILE=$$INFO^MAGGAII(MAGXX,"E")
 . . . S @MAGRY@(CT)="B2^"_MAGFILE
 S @MAGRY@(0)="1^"_CT
 Q
PHOTOS(MAGRY,MAGDFN) ;RPC [MAGG PAT PHOTOS]
 ; Call to return list of all Photo ID's on file for a patient.
 ;   We are returning all Photo ID images for a patient.
 ;   The Images are returned in Rev Chronological Order, latest image
 ;   first, oldest image last.
 K MAGRY
 N Y,RDT,PRX,CT,IEN,IENS,GBLRET,MAGXX
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 S MAGDFN=+MAGDFN
 ;  if no Photo ID Images for the patient, then quit.
 I '$D(^MAG(2005,"APPXDT",MAGDFN,"PHOTO ID")) S MAGRY(0)="1^0" Q
 ;   the "APPXDT" cross reference is :
 ;     "APPXDT",DFN,Procedure,Rev Date,MAGIEN )
 ;
 ;  we'll use @ notation, this'll work if an Array or a Global Array is begin returned
 S GBLRET=0
 S MAGRY="MAGRY"
 S CT=0
 S RDT="" F  S RDT=$O(^MAG(2005,"APPXDT",MAGDFN,"PHOTO ID",RDT)) Q:RDT=""  D
 . S IEN=""
 . F  S IEN=$O(^MAG(2005,"APPXDT",MAGDFN,"PHOTO ID",RDT,IEN)) Q:'IEN  D
 . . ;Q:$P($G(^MAG(2005,IEN,0)),"^",10)  ; CHILD OF GROUP
 . . Q:$$ISDEL^MAGGI11(IEN)             ; Deleted image
 . . S IENS(IEN)=""
 . . Q
 . Q
 S IEN="" F  S IEN=$O(IENS(IEN),-1) Q:'IEN  D
 . S CT=CT+1
 . ;S MAGXX=IEN D INFO^MAGGTII
 . S MAGXX=IEN,MAGFILE=$$INFO^MAGGAII(MAGXX,"E")
 . S @MAGRY@(CT)="B2^"_MAGFILE
 . Q
 S @MAGRY@(0)="1^"_CT
 Q
EACHIMG(MAGRY,MAGDFN,MAX) ;RPC [MAGG PAT EACH IMAGE]
 ; Call Returns list of recent Patient images.
 ;   MAX = maximum number of images to return
 ;   MAGDFN = patient DFN
 ;   We are returning all images for a patient, and listing each image.
 ;   This is called from Capture Window where groups aren't listed.
 ;   The Images are returned in Rev Chronological Order, latest image
 ;   first, oldest image last.
 ;   User can decide how many of the most recent they want to list.
 K MAGRY
 N Y,RDT,PRX,CT,IEN,GBLRET
 S MAX=$S($G(MAX)>0:MAX,1:50) ; 50 IS DEFAULT
 N $ETRAP,$ESTACK S $ETRAP="D ERRG^MAGGTERR"
 S MAGDFN=+MAGDFN
 ;  if no Images for the patient, then quit.
 I '$D(^MAG(2005,"AC",MAGDFN)) S MAGRY(0)="1^0" Q
 ;   the "AC" cross reference is :
 ;     "AC",DFN,IEN )
 ;
 ;  we'll use @ notation, this'll work if an Array or a Global Array is begin returned
 S GBLRET=0
 S MAGRY="MAGRY"
 S CT=0,IEN=""
 F  S IEN=$O(^MAG(2005,"AC",MAGDFN,IEN),-1) Q:'IEN  D  Q:(CT>MAX)
 . Q:$P($G(^MAG(2005,IEN,0)),U,6)=11  ; NOT LISTING GROUP ENTRIES
 . Q:$$ISDEL^MAGGI11(IEN)             ; Skip deleted images
 . S CT=CT+1
 . I (CT>100),'GBLRET D ARY2GLB
 . S @MAGRY@(CT)=$$CAPINFO(IEN)
 S @MAGRY@(0)="1^"_CT
 Q
CAPINFO(IEN) ; RETURN A STRING OF INFORMATION ABOUT THE IMAGE
 ; This is for Capture App
 N RETY,N2,X
 ;S MAGXX=IEN D INFO^MAGGTII
 S MAGXX=IEN,MAGFILE=$$INFO^MAGGAII(MAGXX,"E")
 S RETY=$P(MAGFILE,U,1,7)_U
 S N2=$G(^MAG(2005,IEN,2))
 S RETY=RETY_$$FMTE^XLFDT($P(N2,U,1),"5P")_U
 S X=$P(RETY,U,5),X=$$FMTE^XLFDT(X,"5"),X=$P(X,"@")
 S $P(RETY,U,5)=X
 Q RETY
 Q
ARY2GLB ; Image count is getting big, switch from array to Global return type
 S GBLRET=1
 K ^TMP("MAGGTIG",$J)
 S MAGRY=""
 M ^TMP("MAGGTIG",$J)=MAGRY
 K MAGRY
 S X=$$RTRNFMT^XWBLIB("GLOBAL ARRAY",1)
 S MAGRY=$NA(^TMP("MAGGTIG",$J))
 Q
GROUP(MAGRY,MAGIEN,NOCHK) ;RPC [MAGG GROUP IMAGES]
 ; CalL to Return image list of a Group.
 ; MAGIEN        =  the entry in MAG(2005 we assume it is a group.
 ; NOCHK         =  flag - Do (or) Not Do QI Check.
 N Y,MAGDFN,I,MAGCHILD,MAGCT,MAGTMPAR,MSGX,MAGQI,MAGY
 N MAGNOCHK
 ;
 ;Test BigGroup S BKG=+$G(BKG)
 ;Test BigGroup K ^TMP("MAGBGRP")
 S MAGIEN=+MAGIEN,MSGX=""
 S NOCHK=+$G(NOCHK)
 I '$D(^MAG(2005,MAGIEN,0)) S MAGRY(0)="0^ERROR: Image entry "_MAGIEN_" Doesn't exist" Q
 I $O(^MAG(2005,MAGIEN,1,0))="" S MAGRY(0)="0^ERROR: There are NO Images defined for this Group" Q
 ;
 ;  we'll use @ notation, this'll work if an Array or a Global Array is being returned
 S MAGRY="MAGRY"
 ;
 ;  if we are switching to a Global Array because too many images, 
 ;  then set MAGRY and clean it up first
 ;I +$P($G(^MAG(2005,MAGIEN,1,0)),U,4)>100
 D
 . S X=$$RTRNFMT^XWBLIB("GLOBAL ARRAY",1)
 . S MAGRY=$NA(^TMP("MAGGTIG",$J))
 . K @MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ;
 ;Test BigGroup I $D(^TMP("MAGBGRP",MAGIEN)) D  Q
 ;Test BigGroup . M ^TMP("MAGGTIG",$J)=^TMP("MAGBGRP",MAGIEN)
 ;Test BigGroup . Q
 ; integrity check, stop if group entry is questionable
 ;  NOCHK is sent from Image Delete window (so user with DELETE and SYSTEM keys)
 ;    can see group abstracts before the group is deleted.
 I 'NOCHK D CHK^MAGGSQI(.MAGQI,MAGIEN) I 'MAGQI(0) D  Q
 . S @MAGRY@(0)=MAGQI(0)
 ;
 S MAGNOCHK=1
 S I=0,MAGCT=0,MAGDFN=$P(^MAG(2005,MAGIEN,0),"^",7)
 I $D(^MAG(2005,MAGIEN,1,"ADCM")) D
 . N INUM,SNUM
 . S INUM="" ; GEK 4/3/00  changed Q:'INUM  to  Q:INUM="" below
 . F  S INUM=$O(^MAG(2005,MAGIEN,1,"ADCM",INUM)) Q:INUM=""  D
 . . S SNUM=""
 . . F  S SNUM=$O(^MAG(2005,MAGIEN,1,"ADCM",INUM,SNUM)) Q:SNUM=""  D
 . . . S MAGCHILD=""
 . . . F  S MAGCHILD=$O(^MAG(2005,MAGIEN,1,"ADCM",INUM,SNUM,MAGCHILD)) Q:'MAGCHILD  D
 . . . . S MAGCT=MAGCT+1
 . . . . I '$D(^MAG(2005,MAGCHILD)) D INVALID(MAGCHILD,.MSGX) S @MAGRY@(MAGCT)=MSGX Q
 . . . . ; Added for MAGQI integrity check
 . . . . K MAGY
 . . . . D CHKGRPCH^MAGGSQI(.MAGY,MAGIEN,MAGDFN,MAGCHILD) I 'MAGY D INVCH(.MAGY,MAGCHILD) S @MAGRY@(MAGCT)=MAGY Q
 . . . . S MAGXX=MAGCHILD
 . . . . S MAGTMPAR(MAGXX)=""
 . . . . ;D INFO^MAGGTII
 . . . . S MAGFILE=$$INFO^MAGGAII(MAGXX,"E")
 . . . . S $P(MAGFILE,U,12,13)=INUM_U_SNUM
 . . . . S @MAGRY@(MAGCT)="B2^"_MAGFILE
 . . . . ;Test BigGroup I 'BKG S @MAGRY@(MAGCT)="B2^"_MAGFILE
 . . . . ;Test BigGroup E  S ^TMP("MAGBGRP",MAGIEN,MAGCT)="B2^"_MAGFILE
 ;GEK 4/8/99 MODIFIED, because now we have groups, that some entries 
 ;                     have dicom numbers and some don't.  So we have to go through the group again.
 ;Test BigGroup - Need a Pre/Post init, that fixes Groups where some entries have Dicom values, and some 
 ;         don't.  In such a group, we will make Dicom values for the images that don't have them.
 ;         Testing in Washington - this will take hours.
 ;
 S I=0
 F  S I=$O(^MAG(2005,MAGIEN,1,I)) Q:'I  D
 . S MAGCHILD=+^MAG(2005,MAGIEN,1,I,0)
 . I $D(MAGTMPAR(MAGCHILD)) Q
 . S MAGCT=MAGCT+1
 . I '$D(^MAG(2005,MAGCHILD)) D INVALID(MAGCHILD,.MSGX) S @MAGRY@(MAGCT)=MSGX Q
 . ;Added for MAGQI integrity check
 . K MAGY
 . D CHKGRPCH^MAGGSQI(.MAGY,MAGIEN,MAGDFN,MAGCHILD) I 'MAGY D INVCH(.MAGY,MAGCHILD) S @MAGRY@(MAGCT)=MAGY Q
 . S MAGXX=MAGCHILD
 . ;D INFO^MAGGTII
 . S MAGFILE=$$INFO^MAGGAII(MAGXX,"E")
 . S @MAGRY@(MAGCT)="B2^"_MAGFILE
 . ;Test BigGroup        I 'BKG S @MAGRY@(MAGCT)="B2^"_MAGFILE
 . ;Test BigGroup        E  S ^TMP("MAGBGRP",MAGIEN,MAGCT)="B2^"_MAGFILE
 S @MAGRY@(0)="1^"_MAGCT
 Q
INVALID(MAGX,MAGZ) ;
 ;
 I $$ISDEL^MAGGI11(MAGX)  S MAGZ="B2^"_MAGX_"^^^INVALID Reference to Deleted Image^^66^^^^^^^^"
 E  S MAGZ="B2^"_MAGX_"^^^INVALID Image ID (IEN)^^67^^^^^^^^"
 ;Added with MAGQI integrity check, 
 S MAGTMPAR(MAGX)=""
 Q
INVCH(MSG,CHILD) ;Added for MAGQI integrity check
 ; MSG is passed by reference, we create a MAGFILE equivalent and pass it back.
 N EMSG
 S EMSG=$P(MSG,U,2)
 K MSG
 S $P(MSG,U)=CHILD
 ; remove dependency on c:\program files.   with   .\bmp\
 S $P(MSG,U,2,3)="-1~Questionable Data Integrity^.\bmp\imageQA.bmp"
 S $P(MSG,U,4)=$P($G(^MAG(2005,CHILD,2)),U,4)
 S $P(MSG,U,6)=$S(($P(MSG,U,6)'=11):"99",1:11)
 ;this stops Delphi App from changing Abstract BMP to OFFLINE IMAGE
 S $P(MSG,U,10)="M"
 ;Send the error message
 S $P(MSG,U,17)=EMSG
 S MSG="B2^"_MSG
 S MAGTMPAR(CHILD)=""
 Q
