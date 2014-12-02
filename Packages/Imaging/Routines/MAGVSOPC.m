MAGVSOPC ;WOIFO/DAC - Update file (#2006.532)  ; 5 Nov 2012 12:12 PM
 ;;3.0;IMAGING;**118**;Mar 19, 2002;Build 4525;May 01, 2013
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
UPDATE ; Update DICOM SOP CLASS file (#2006.532)
 N MAGN
 ;
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.5.4^Ophthalmic Tomography Image Storage")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.1^Encapsulated PDF Storage")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.2^Encapsulated CDA Storage")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.131^Basic Structured Display Storage")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.8^RT Ion Plan Storage")=""
 ;
 N MAGNFDA,MAGNIEN,MAGNXE,I
 N UID,SOPNAME,ACTIVE
 S I=""
 S ACTIVE="A"
 F  S I=$O(MAGN(I)) Q:I=""  D
 . K MAGNFDA,MAGNIEN,MAGNXE
 . S UID=$P(I,"^",1)
 . Q:$D(^MAG(2006.532,"B",UID))
 . S SOPNAME=$P(I,"^",2)
 . S MAGNFDA(2006.532,"?+1,",.01)=UID
 . S MAGNFDA(2006.532,"?+1,",2)=SOPNAME
 . S MAGNFDA(2006.532,"?+1,",4)=ACTIVE
 . D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 . I $D(MAGNXE("DIERR","E")) W !,"Error updating DICOM SOP CLASS file (#2006.532): ",I
 . Q
 W !,"Update of DICOM SOP CLASS file (#2006.532) is done"
 Q
