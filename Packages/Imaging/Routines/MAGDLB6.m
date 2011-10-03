MAGDLB6 ;WOIFO/LB,MLH - DICOM file utilities ; 12/16/2004  11:30
 ;;3.0;IMAGING;**21,10,11,51**;26-August-2005
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
 ;
XREF ; Set "F" xref for fields 36 and 9 - Gateway Location and Study UID
 N GWLOC ; -- location number of DICOM Gateway
 N ORIG ; --- Entry number for original image for this study
 N PREDA ; -- original DA value
 S GWLOC=$P(^MAGD(2006.575,DA,1),"^",5) Q:'GWLOC
 ;
 ; If this is the first one, create the "F" cross-reference
 ;
 I '$D(^MAGD(2006.575,"F",GWLOC,X)) D  Q
 . S ^MAGD(2006.575,"F",GWLOC,X,DA)=""
 . Q
 ;
 ; Otherwise, the image is "related" to the original one
 ; for this study.
 ;
 S ORIG=$O(^MAGD(2006.575,"F",GWLOC,X,0))
 Q:'$D(^MAGD(2006.575,ORIG,0))  ; No longer in database
 S PREDA=DA D
 . N D0,DA,DD,DIC,DIE,ERR,X,Y
 . S DIC="^MAGD(2006.575,"_ORIG_",""RLATE"","
 . S DIC(0)="L"
 . S DA(1)=ORIG,X=PREDA
 . S ERR="Related Image ("_X_") for image #"_ORIG_" not filed."
 . D FILE^DICN
 . I Y=-1 D EN^DDIOL(ERR,"","!")
 . Q
 Q
 ;
XREFK ; Kill "F" cross-reference
 N GWLOC
 Q:'DA
 S GWLOC=$P(^MAGD(2006.575,DA,1),"^",5) Q:'GWLOC
 K ^MAGD(2006.575,"F",GWLOC,X,DA)
 Q
 ;
