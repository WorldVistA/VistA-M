MAGDIR9B ;WOIFO/PMK - Read a DICOM image file ; 19 Nov 2007 07:10 AM
 ;;3.0;IMAGING;**11,51,50,54,53**;Mar 19, 2002;Build 1719;Apr 28, 2010
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
 ; Create an image entry in ^MAG(2005)
 ;
IMAGE() ; entry point from ^MAGDIR81 to create an image entry in ^MAG(2005)
 N I ;-------- scratch counter
 N IMAGE ;---- image array for ^MAGGTIA
 N IMAGECNT ;- counter of image in the group
 N IMAGEPTR ;- value returned by ^MAGGTIA
 ;
 ; check that the group has right object type and is for the same person
 I $P($G(^MAG(2005,MAGGP,0)),"^",6)'=11 D  Q -101 ; fatal error
 . D OBJECT^MAGDIRVE($T(+0),MAGGP)
 . Q
 ;
 ; check that the group patient DFN matches the image patient DFN
 I $P(^MAG(2005,MAGGP,0),"^",7)'=DFN D  Q -102 ; fatal error
 . D MISMATCH^MAGDIRVE($T(+0),DFN,MAGGP)
 . Q
 ;
 ; get the next file number and create the entry for this image
 ;
 S IMAGECNT=$P($G(^MAG(2005,MAGGP,1,0)),"^",4)+1 ; next image # in group
 ;
 K IMAGE S I=0
 S I=I+1,IMAGE(I)=".01^"_PNAMEVAH_"  "_DCMPID_"  "_PROCDESC ; used in ^MAGDIR8
 S I=I+1,IMAGE(I)="5^"_DFN
 I $D(FILEDATA("SHORT DESCRIPTION")) D  ; set in ^MAGDIR7F
 . S I=I+1,IMAGE(I)="10^"_FILEDATA("SHORT DESCRIPTION")
 . Q
 E  S I=I+1,IMAGE(I)="10^"_PROCDESC_" (#"_IMAGECNT_")" ; used in ^MAGDIR81
 S I=I+1,IMAGE(I)="14^"_MAGGP
 S I=I+1,IMAGE(I)="15^"_DATETIME
 S I=I+1,IMAGE(I)="60^"_IMAGEUID
 S I=I+1,IMAGE(I)=FILEDATA("EXTENSION") ; specify the image file extension
 S:$D(FILEDATA("ABSTRACT")) I=I+1,IMAGE(I)=FILEDATA("ABSTRACT")
 S I=I+1,IMAGE(I)="WRITE^PACS" ; select the PACS Image write location
 S I=I+1,IMAGE(I)="3^"_FILEDATA("OBJECT TYPE")
 S I=I+1,IMAGE(I)="6^"_FILEDATA("MODALITY")
 S I=I+1,IMAGE(I)="16^"_FILEDATA("PARENT FILE")
 S I=I+1,IMAGE(I)="17^"_FILEDATA("PARENT IEN")
 S:$D(FILEDATA("PARENT FILE PTR")) I=I+1,IMAGE(I)="18^"_FILEDATA("PARENT FILE PTR")
 S:$D(FILEDATA("RAD REPORT")) I=I+1,IMAGE(I)="61^"_FILEDATA("RAD REPORT")
 S:$D(FILEDATA("RAD PROC PTR")) I=I+1,IMAGE(I)="62^"_FILEDATA("RAD PROC PTR")
 S:MODPARMS["/" I=I+1,IMAGE(I)="BIG^1" ; big file will be output
 S I=I+1,IMAGE(I)="DICOMSN^"_SERINUMB ; series number
 S I=I+1,IMAGE(I)="DICOMIN^"_IMAGNUMB ; image number
 S I=I+1,IMAGE(I)=".05^"_INSTLOC
 S I=I+1,IMAGE(I)="40^"_FILEDATA("PACKAGE")
 S I=I+1,IMAGE(I)="41^"_$O(^MAG(2005.82,"B","CLIN",""))
 S I=I+1,IMAGE(I)="42^"_FILEDATA("TYPE")
 S I=I+1,IMAGE(I)="43^"_FILEDATA("PROC/EVENT")
 S I=I+1,IMAGE(I)="44^"_FILEDATA("SPEC/SUBSPEC")
 S I=I+1,IMAGE(I)="45^"_ORIGINDX
 S I=I+1,IMAGE(I)="107^"_FILEDATA("ACQUISITION DEVICE")
 S I=I+1,IMAGE(I)="110^"_STAMP
 S I=I+1,IMAGE(I)="251^"_FILEDATA("SOP CLASS POINTER")
 S I=I+1,IMAGE(I)="253^"_SERIEUID
 D ADD^MAGGTIA(.RETURN,.IMAGE)
 ;
 S IMAGEPTR=+RETURN
 I 'IMAGEPTR D  Q -103 ; fatal error
 . K MSG
 . S MSG(1)="IMAGE FILE CREATION ERROR:"
 . S MSG(2)=$P(RETURN,"^",2,999)
 . D BADERROR^MAGDIRVE($T(+0),"DICOM IMAGE PROCESSING ERROR",.MSG)
 . Q
 ;
 I IMAGEPTR<LASTIMG D  Q -104 ; fatal last image pointer error
 . D IMAGEPTR^MAGDIRVE($T(+0),IMAGEPTR,LASTIMG)
 . Q
 ;
 S $P(RETURN,"^",4)=$$CHKPATH() ; hierarchal file patch check
 ;
 Q 0
 ;
CHKPATH() ; determine if the path is hierarchal (true) or not (false)
 N D0,PATH
 S D0="",PATH=$P(RETURN,"^",2)
 I $D(^MAG(2005.2,"AC")) S D0=$O(^MAG(2005.2,"AC",PATH,""))
 E  D
 . N PLACE
 . S PLACE=""
 . F  S PLACE=$O(^MAG(2005.2,"E",PLACE)) Q:PLACE=""  D  Q:D0
 . . S D0=$O(^MAG(2005.2,"E",PLACE,PATH,""))
 . . Q
 . Q
 Q 'D0 ; network location file
 ;
