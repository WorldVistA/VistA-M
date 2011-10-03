MAGSDEL2 ;WOIFO/SRR/RED - Delete parent pointers ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**10**;Nov 06, 2003
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
DELPAR ; delete parent pointers
 I '$D(^MAG(2005,MAGIEN,2)) S DELMSG="Image IEN doesn't Exist in Image File" G ERROR
 S MAGTMP=^MAG(2005,MAGIEN,2),MAGSTORE=$P(MAGTMP,"^",6)_":"_$P(MAGTMP,"^",7)_":"_$P(MAGTMP,"^",8)_":"_$P(MAGTMP,"^",10)
 S MAGPARRT=$P(MAGTMP,"^",6) I MAGPARRT="" G EXIT ;No parent pointer
 I '$D(^MAG(2005.03,MAGPARRT,0)) S DELMSG="Image Entry has INVALID Pointer to Imaging Parent Data File " G ERROR
 S MAGPAR=^MAG(2005.03,MAGPARRT,0)
 S MAGTYP=$P(MAGPAR,"^",3)
 S MAGPARRT=$P(MAGPAR,"^",4) I MAGPARRT="" S DELMSG="Parent Data File entry is missing field 'File Pointer'" G ERROR
 S DA=$P(MAGTMP,"^",8) ;G:DA="" ERROR
 ; /GEK added next 2 lines, comment out G:DA in line above
 ; this will catch PACS images that don't send IEN of the 2005 Multiple
 ; in the parent file.
 N MAGRT,MAGROOT
 I 'DA,MAGPARRT[2006.5839 S DA=123
 ; Setting DA to 123 is for the DICOM TEMP file.
 I 'DA D GETDA^MAGSDEL4(MAGPARRT,$P(MAGTMP,"^",7),MAGIEN,.DA)
 I 'DA I '$P(^MAG(2005,MAGIEN,0),"^",10) D  G ERROR
 . S DELMSG="Image entry invalid field: PARENT DATA FILE IMAGE POINTER"
 I 'DA I $P(^MAG(2005,MAGIEN,0),"^",10) G EXIT
 ;G:'DA ERROR
 D FILE^DID(MAGPARRT,"","GLOBAL NAME","MAGRT")
 S MAGROOT=$G(MAGRT("GLOBAL NAME")) Q:MAGROOT=""
 I MAGTYP<3 S DA(1)=$P(MAGTMP,"^",7),DIK=MAGROOT_DA(1)_",2005," K DA(2) G CHECK
 S DA(2)=$P(MAGTMP,"^",7),DA(1)=$P(MAGTMP,"^",10)
 S DIK=MAGROOT_DA(2)_","""_$E($P(MAGPAR,"^",2),1,2)_""","_DA(1)_","_2005_","
CHECK I DIK'["^" S DELMSG="Can't resolve 'DIK' Global Node. " G ERROR
 ;I $D(MAGVERB) W !,"Ready to delete ",DIK,DA R !,"ok? ",ANS:DTIME Q:ANS="N"
 ;if medicine, call medicine api
 I MAGPARRT>690,MAGPARRT<705 G DELMED
 ;if TIU goto call TIU api
 I MAGPARRT=8925 G DELTIU
 ;if lab, call lab api
 I MAGPARRT["63" G DELLAB
 I MAGPARRT["2006.5839" G DELHCP
 D ^DIK
 I $D(MAGVERB) W !,"Parent pointer deleted from ",$P(MAGPAR,"^",1),"..."
EXIT K DA,DA(1),DIK,DA(2) Q
DELMED ;
 D KILL^MCUIMAG0(MAGPARRT,DA(1),DA,.MAGSTAT)
 I +MAGSTAT=1 G EXIT
 E  S DELMSG="Error calling Medicine Routine to Delete Pointer." G ERROR
 Q
DELTIU ;  Delete the TIU pointers
 Q:$P(^MAG(2005,MAGIEN,0),"^",10)
 ; Quit if image is a child of a group.
 D DELIMAGE^TIUSRVPL(.MAGY,DA(1),MAGIEN)
 I 'MAGY S DELMSG="Error calling TIU API : "_$P(MAGY,"^",2) G ERROR
 G EXIT
DELLAB ; delete lab pointer entries
 D EN^MAGSDEL3(MAGIEN,.MAGRES)
 I '+MAGRES S DELMSG="Error calling Lab Routine to Delete Pointer." G ERROR
 Q
DELHCP ;Delete the DICOM GMRC TEMP file entry pointers
 D DCMTEMP^MAGSDHCP(.MAGY,MAGIEN)
 I '+MAGY S DELMSG=$G(MAGY(0)) G ERROR
 G EXIT
ERROR I $D(MAGVERB) W !,"The backwards pointers are not correct.  Image pointers cannot be removed from parent file."
 S MAGERR=1 G EXIT
