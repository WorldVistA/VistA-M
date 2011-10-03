MAGDOD01 ;WOIFO/EdM - VistA DOD Exchange Utilities ; 29 Apr 2008 10:56 AM
 ;;3.0;IMAGING;**98**;Mar 19, 2002;Build 1849;Sep 22, 2010
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
 ;
STOREUID(OUT,IMAGE,SERIES,SNUM,INUM,IMGUID,STUID,DOCDAT) ; RPC = MAG STORE TEXT FILE DETAILS
 N D0,D1,FM,I,IMG,LI,LS,X,XI,XS
 I '$$KEY() S OUT="-13,No permission to call this Remote Procedure" Q
 S FM=""
 I '$G(IMAGE) S OUT="-5,No valid image number specified." Q
 D CHK^MAGGSQI(.X,IMAGE) I +$G(X(0))'=1 D  Q
 . S OUT=IMAGE_"-14,Questionable Integrity"
 . Q
 K X
 S:$G(^MAG(2005,IMAGE,0))'="" FM=2005
 S:$G(^MAG(2005.1,IMAGE,0))'="" FM=2005.1
 I FM="" S OUT="-1,No such image """_IMAGE_"""." Q
 S OUT=-13,(D0,D1)=0,(IMG,LS,LI,XS,XI)=""
 D:$TR($G(SNUM)_$G(INUM),0)'=""
 . S D0=+$P(^MAG(FM,IMAGE,0),"^",10) Q:'D0
 . S I=0 F  S I=$O(^MAG(FM,D0,1,I)) Q:'I  D  Q:D1
 . . S X=$G(^MAG(FM,D0,1,I,0)) Q:+X'=IMAGE
 . . S D1=I,IMG=$P(X,"^",1),(LS,XS)=$P(X,"^",2),(LI,XI)=$P(X,"^",3)
 . . Q
 . S:'D0 OUT=OUT_", image is not part of series ("_SNUM_"/"_INUM_")"
 . S:'D1 OUT=OUT_", image is not in series "_D0_" ("_SNUM_"/"_INUM_")"
 . Q
 D:$G(SERIES)'=""
 . S X=$G(^MAG(FM,IMAGE,"SERIESUID")) Q:X=SERIES
 . I X'="" S OUT=OUT_", cannot enter Series Instance UID"_$C(13,10)_"Current: "_X_$C(13,10)_"New:     "_SERIES Q
 . S ^MAG(FM,IMAGE,"SERIESUID")=SERIES
 . S ^MAG(FM,"SERIESUID",SERIES,IMAGE)=""
 . Q
 D:$G(SNUM)'=""
 . Q:LS=SNUM
 . I LS'="" S OUT=OUT_", cannot enter Series Number """_LS_"""'="""_SNUM_"""." Q
 . S $P(^MAG(FM,D0,1,D1,0),"^",2)=SNUM
 . I IMG'="",LS'="",LI'="" K ^MAG(FM,D0,1,"ADCM",LS,LI,IMG,D1)
 . S XS=SNUM
 . Q
 D:$G(INUM)'=""
 . Q:LI=INUM
 . I LI'="" S OUT=OUT_", cannot enter Instance Number"""_LI_"""'="""_INUM_"""." Q
 . S $P(^MAG(FM,D0,1,D1,0),"^",3)=INUM
 . I IMG'="",LS'="",LI'="" K ^MAG(FM,D0,1,"ADCM",LS,LI,IMG,D1)
 . S XI=INUM
 . Q
 I IMG'="",XS'="",XI'="" S ^MAG(FM,D0,1,"ADCM",XS,XI,IMG,D1)=""
 D:$G(IMGUID)'=""
 . S X=$P($G(^MAG(FM,IMAGE,"PACS")),"^",1)
 . Q:X=IMGUID
 . I X'="",X'=IMGUID S OUT=OUT_", cannot enter Instance UID"_$C(13,10)_"Current: "_X_$C(13,10)_"New:     "_IMGUID Q
 . S $P(^MAG(FM,IMAGE,"PACS"),"^",1)=IMGUID
 . S ^MAG(FM,"P",IMGUID,IMAGE)=""
 . Q
 D:$G(STUID)'=""
 . N PARENT
 . S PARENT=$P($G(^MAG(FM,IMAGE,0)),"^",10)
 . I 'PARENT S OUT=OUT_", cannot find parent for image "_IMAGE Q
 . S X=$P($G(^MAG(FM,PARENT,"PACS")),"^",1)
 . Q:X=STUID
 . I X'="",X'=STUID S OUT=OUT_", cannot enter Study UID"_$C(13,10)_"Current: "_X_$C(13,10)_"New:     "_STUID Q
 . S $P(^MAG(FM,PARENT,"PACS"),"^",1)=STUID
 . S ^MAG(FM,"P",STUID,PARENT)=""
 . Q
 D:$G(DOCDAT)'=""  ;//110 CREATION DATE
 . N PARENT,CHILD
 . S PARENT=+$P($G(^MAG(FM,IMAGE,0)),"^",10) D:PARENT
 . . I $P($G(^MAG(FM,PARENT,100)),"^",6)="" D
 . . . S CHILD=$O(^MAG(FM,PARENT,1,0)) Q:'CHILD
 . . . S X=$G(^MAG(FM,PARENT,1,CHILD,0)) Q:+X'=IMAGE
 . . . S $P(^MAG(FM,PARENT,100),"^",6)=DOCDAT  ;set parent
 . . . Q
 . . Q
 . S X=$P($G(^MAG(FM,IMAGE,100)),"^",6)
 . Q:X=DOCDAT
 . I X'="",X'=DOCDAT S OUT=OUT_", cannot enter Document Date"_$C(13,10)_"Current: "_X_$C(13,10)_"New:     "_DOCDAT Q
 . S $P(^MAG(FM,IMAGE,100),"^",6)=DOCDAT  ;set child
 . Q
 S:OUT=-13 OUT="0,OK"
 Q
 ;
SCANIMG(OUT,ACTION,IMAGE,DIR) ; RPC = MAG SCAN IMAGE TEXT FILES
 N F1,F2,F3,X
 I '$$KEY() S OUT="-13,No permission to call this Remote Procedure" Q
 S ACTION=$G(ACTION)
 I ACTION="Init" D  Q
 . S X=$G(^MAGDICOM(2006.563,1,"SCAN")) S:X="" X=" ^-1"
 . S OUT=X
 . Q
 I ACTION="Restart" D  Q
 . S (^MAGDICOM(2006.563,1,"SCAN"),OUT)=" ^-1"
 . Q
 I ACTION="Scan" D  Q
 . S DIR=$S($G(DIR)<0:-1,1:1)
 . S IMAGE=+$G(IMAGE) I 'IMAGE,DIR<0 S IMAGE=" "
 . S ^MAGDICOM(2006.563,1,"SCAN")=IMAGE_"^"_DIR
 . S IMAGE=$O(^MAG(2005,IMAGE),DIR)
 . I 'IMAGE S OUT="-1,Done" Q
 . D FILEFIND^MAGDFB(IMAGE,"TEXT",0,0,.F1,.F2,.F3)
 . S OUT=IMAGE_","_F2_","_$$NEARFMT^MAGUF(IMAGE)
 . Q
 S OUT="-13,Cannot perform requested action: """_ACTION_"""."
 Q
 ;
FINDFIL(OUT,IMAGE) ; RPC = MAG FIND IMAGE TEXT FILE
 N F1,F2,F3,IEN
 N FM ; ------- file on which the image record exists (2005 or 2005.1)
 N IM0 ; ------ zero node of this image record (not parent)
 N CANUPD ; --- flag indicating that there are fields to be updated on the record
 N PDLIM ; ---- primary delimiter
 S PDLIM="|"
 I '$$KEY() S $P(OUT,PDLIM,2)="-12,No permission to call this Remote Procedure" Q
 I IMAGE="" S $P(OUT,PDLIM,2)="-21,Image file name must be specified" Q
 I IMAGE?.E1C.E S $P(OUT,PDLIM,2)="-22,Invalid filename format (no control characters allowed)" Q
 S FM=2005,IEN=$O(^MAG(FM,"F",IMAGE,"")) ; scan active image records
 I 'IEN S FM=2005.1,IEN=$O(^MAG(FM,"F",IMAGE,""))
 I 'IEN S $P(OUT,PDLIM,2)="-23,Image filename not found on VistA" Q
 D FILEFIND^MAGDFB(IEN,"TEXT",0,0,.F1,.F2,.F3)
 S OUT=IEN_PDLIM_F2_PDLIM_$$NEARFMT^MAGUF(IEN)
 S IM0=$G(^MAG(FM,IEN,0))
 ; check for dupes and integrity problems
 S:$P(IM0,"^",12) $P(OUT,PDLIM,4)="D" ; dupe
 S:$P(IM0,"^",11) $P(OUT,PDLIM,5)="IQ" ; integrity
 ; can this record be updated?
 S CANUPD=0 ; assume all updatable fields are populated, so not
 D  ; check to see if there are any updatable fields
 . N PARENT ; --- parent record of the study of which this image is a member
 . D  Q:CANUPD  ; check Series Instance UID
 . . I $P($G(^MAG(FM,IEN,"SERIESUID")),"^",1)="" S CANUPD=1
 . . Q
 . D  Q:CANUPD  ; check Image Instance UID
 . . I $P($G(^MAG(FM,IEN,"PACS")),"^",1)="" S CANUPD=1
 . . Q
 . S PARENT=$P($G(^MAG(FM,IEN,0)),"^",10)
 . D:PARENT  ; check attributes of parent study
 . . D  Q:CANUPD  ; check Study Instance UID
 . . . I $P($G(^MAG(FM,PARENT,"PACS")),"^",1)="" S CANUPD=1
 . . . Q
 . . D  Q:CANUPD  ; check Document Date
 . . . I $P($G(^MAG(FM,PARENT,100)),"^",6)="" S CANUPD=1
 . . . Q
 . . D  Q:CANUPD  ; check DICOM series and image number
 . . . N CHILD ; ---- what child this image is of the parent
 . . . N I ; -------- scratch loop index
 . . . S CHILD=0
 . . . F  S CHILD=$O(^MAG(FM,PARENT,1,CHILD)) Q:'CHILD  I $P($G(^(CHILD,0)),"^",1)=IEN Q
 . . . Q:'CHILD  ; image not found in study
 . . . F I=2,3 I $P($G(^MAG(FM,PARENT,1,CHILD,0)),"^",I)="" S CANUPD=1 Q
 . . . Q
 . . Q
 . Q
 S $P(OUT,PDLIM,6)=CANUPD
 Q
KEY() N KEY,PRIV
 S KEY(1)="MAG DOD FIX"
 D OWNSKEY^XUSRB(.PRIV,.KEY)
 Q PRIV(1)
 ;
