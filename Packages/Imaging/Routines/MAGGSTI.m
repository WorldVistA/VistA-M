MAGGSTI ;WOIFO/GEK - Imaging interface to TIU RPC Calls etc. ; 01 Nov 2001 12:32 PM 
 ;;3.0;IMAGING;**7**;Jul 12, 2002
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
LISTC(ATMP,PROC,MAGDFN,BDT,EDT,NUM,DETAILS) ;Get Short list of TIU notes 
 ; given a CLASS in PROC parameter
 ; The compressed listing, 4 columns  "Date^Spec^Desc^Img Count^procedure info"
 N MAGX,I,ACT,NODE,TMP
 D CONTEXT^TIUSRVLO(.MAGX,PROC,1,MAGDFN)
 I '$D(@MAGX) Q
 S ACT=+$O(@ATMP@(""),-1)
 S I="" F  S I=$O(@MAGX@(I)) Q:I=""  D
 . ;
 . S X=$S(DETAILS:$$DETINF(@MAGX@(I)),1:$$CMPINF(@MAGX@(I)))
 . S ACT=ACT+1
 . S @ATMP@(ACT)=X
 I DETAILS S @ATMP@(1)="Date^Title^Images^Author^Status^Visit" ;^|TIUDA^
 Q
CMPINF(NODE) ;
 N RY
 S RY=$$EXTDT^MAGGSU1($P(NODE,U,3))_U_"TIU"_U_$P(NODE,U,2)_U
 S RY=RY_$$IMGCT($P(NODE,U))_U_$P($P(NODE,U,5),";",2)_U
 S RY=RY_"|TIU^"_$P(NODE,U)
 Q RY
 ;
DETINF(NODE) ;
 ; The node info from TIUSRVLO is
 ;   TIUDA    Desc        date          patient              duz;author          status
 ;  x)=2452^General Note^2910528.1533^HOOD, ROBIN  (H2591)^10;MELANIE BUECHLER
 ;     service      status   visit info       ?      ? ?
 ;    ^CARDIOLOGY^completed^Visit: 05/28/91^        ^^0^
 N RY
 ;  DATE^DESC^IMGCT^AUTHOR^STATUS^VISIT^|"TIU^"TIUDA^
 S RY=$$EXTDT^MAGGSU1($P(NODE,U,3))_U_$P(NODE,U,2)_U_$$IMGCT($P(NODE,U))_U
 S RY=RY_$P($P(NODE,U,5),";",2)_U_$P(NODE,U,7)_U_$P(NODE,U,8)
 S RY=RY_U_"|TIU"_U_$P(NODE,U)_U
 Q RY
IMGCT(TIUDA) ;  Get count of images for this TIU Document
 ;  If more than one group (or image) is pointing to this Document
 ;    then return "Group count : total images"  i.e.   "3:134"
 ; 
 N MAGARR,MAGIEN,CT,GCT,ICT,I
 S I="",CT=0,GCT=0
 D GETILST^TIUSRVPL(.MAGARR,TIUDA)
 F  S I=$O(MAGARR(I)) Q:'I  D
 . S ICT=+$P($G(^MAG(2005,MAGARR(I),1,0)),U,4)
 . S ICT=$S(ICT:ICT,1:1) ;If no group images, set count =1 (single image)
 . S GCT=GCT+1
 . S CT=CT+ICT
 I (GCT>1) Q GCT_":"_CT
 Q CT
FILE(MAGRY,MAGDA,TIUDA) ; RPC Call to file TIU and Imaging Pointers
 ; TIU API to add image to TIU
 ; TODO; have to validate that the Imaging patient matches the TIU patient.
 D PUTIMAGE^TIUSRVPL(.MAGRY,TIUDA,MAGDA) ;
 I 'MAGRY Q
 ; Now SET the Parent fields in the Image File
 S $P(^MAG(2005,MAGDA,2),U,6,8)=8925_U_TIUDA_U_+MAGRY
 ; DONE.
 S MAGRY="1^Image pointer filed successfully"
 Q
DATA(MAGRY,TIUDA) ;RPC Call to get TIU data from the TIUDA
 ; Return =     TIUDA^Document Type ^Document Date^DFN
 ; returning DFN is new, We'll need IA for it ;TODO
 ;
 S MAGRY=TIUDA_U_$$GET1^DIQ(8925,TIUDA,".01","E")_U_$$GET1^DIQ(8925,TIUDA,"1201","I")_U_$$GET1^DIQ(8925,TIUDA,".02","I")
 ;
 Q
IMAGES(MAGRY,TIUDA) ;RPC Call to get all images for a given TIU DA
 ; We first get all Image IEN's breaking groups into seperate images
 ; Then get Image Info for each one.
 ; MAGRY    -     Return array of Image Data entries
 ; MAGRY(0)    is   1 ^ message  if successful
 ;                  0 ^ Error message if error;
 ; TIUDA  is IEN in ^TIU(8925
 ;
 ; Call TIU API to get list of Image IEN's
 N MAGARR,CT K ^TMP("MAGGX",$J)
 N MAGZZ
 D GETILST^TIUSRVPL(.MAGARR,TIUDA)
 S CT=0
 K ^TMP("MAGGX",$J)
 ; Now get all images for all groups and single images.
 S I="" F  S I=$O(MAGARR(I)) Q:'I  S DA=MAGARR(I) D
 . I $O(^MAG(2005,DA,1,0)) D  Q
 . . S J=0 F  S J=$O(^MAG(2005,DA,1,J)) Q:'J  S CT=CT+1,^TMP("MAGGX",$J,CT)=^(J,0)
 . S CT=CT+1
 . S ^TMP("MAGGX",$J,CT)=DA
 ; Now get image info for each image
 ;
 S CT=0,Z=""
 S MAGQUIET=1
 F  S Z=$O(^TMP("MAGGX",$J,Z)) Q:Z=""  D
 . S CT=CT+1,MAGXX=^TMP("MAGGX",$J,Z)
 . ;GEK 8/24/00 Stoping the Invalid Image IEN's and Deleted Images
 . I '$D(^MAG(2005,MAGXX)) D  Q
 . . D INVALID^MAGGTIG(MAGXX,.MSGX) S MAGRY(CT)=MSGX
 . D BOTH^MAGFILEB
 . S MAGRY(CT)="B2^"_MAGFILE
 K MAGQUIET
 S MAGRY(0)=CT_"^"_CT_" Images for the selected TIU NOTE"
 ; PUT THE Image IEN of the last image into the group ien field.
 Q:'CT
 S $P(MAGRY(0),U,3)=TIUDA
 D DATA(.MAGZZ,TIUDA)
 S $P(MAGRY(0),U,4)=$$GET1^DIQ(8925,TIUDA,".02","E")_"  "_$P(MAGZZ,U,2)_"  "_$$FMTE^XLFDT($P(MAGZZ,U,3),"8")
 ;
 S $P(MAGRY(0),U,5)=$S($P($G(MAGFILE),U):$P(MAGFILE,U),1:MAGXX)
 Q
 ;
