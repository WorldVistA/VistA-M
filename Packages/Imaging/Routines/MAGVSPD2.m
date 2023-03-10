MAGVSPD2 ;WOIFO/NST,DAC - SOP Mass Disable Utility; Jan 14, 2021@07:53:47
 ;;3.0;IMAGING;**271**;Mar 19, 2002;Build 10
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
DISABLE(MAGN)  ; Update DICOM UID SPECIFIC ACTION file (#2006.539)
 ; P271 DAC - Unknown SOP Classes
 S MAGN("1.2.840.10008.5.1.4.1.1.78.7^Ophthalmic Axial Measurements Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.78.8^Intraocular Lens Calculations Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.79.1^Macular Grid Thickness and Volume Report Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.80.1^Ophthalmic Visual Field Static Perimetry Measurements Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.81.1^Ophthalmic Thickness Map Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.82.1^Corneal Topography Map Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.3^Deformable Spatial Registration Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.4^Segmentation Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.5^Surface Segmentation Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.6^Tractography Results Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.67^Real World Value Mapping Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.68.1^Surface Scan Mesh Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.68.2^Surface Scan Point Cloud Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.34^Comprehensive 3D SR Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.35^Extensible SR Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.70^Implantation Plan SR Document Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.71^Acquisition Context SR Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.72^Simplified Adult Echo SR Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.73^Patient Radiation Dose SR Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.74^Planned Imaging Agent Administration SR Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.75^Performed Imaging Agent Administration SR Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.2^Encapsulated CDA Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.3^Encapsulated STL Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.4^Encapsulated OBJ Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.5^Encapsulated MTL Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.9^RT Ion Beams Treatment Record Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.10^RT Physician Intent Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.11^RT Segment Annotation Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.12^RT Radiation Set Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.13^C-Arm Photon-Electron Radiation Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.14^Tomotherapeutic Radiation Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.15^Robotic-Arm Radiation Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.16^RT Radiation Record Set Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.17^RT Radiation Salvage Record Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.18^Tomotherapeutic Radiation Record Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.19^C-Arm Photon-Electron Radiation Record Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.20^Robotic Radiation Record Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.34.7^RT Beams Delivery Instruction Storage^3^Unknown|dicom.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.34.10^RT Brachy Application Setup Delivery Instruction Storage^3^Unknown|dicom.JPG")=""
 N MAGNFDA,MAGNIEN,MAGNXE,I
 N PURPOSE,TYPE,SUBTYPE
 N UID,UIDDESCR,ACTION,COMMENT
 S I=""
 S PURPOSE="Storage SCP"
 S TYPE="SOP Class"
 S SUBTYPE="Storage"
 F  S I=$O(MAGN(I)) Q:I=""  D
 . K MAGNFDA,MAGNIEN,MAGNXE
 . S UID=$P(I,"^",1)
 . S UIDDESCR=$P(I,"^",2)
 . S ACTION=$P(I,"^",3)
 . S COMMENT=$P(I,"^",4)
 . S MAGNFDA(2006.539,"?+1,",.01)=UID
 . S MAGNFDA(2006.539,"?+1,",2)=UIDDESCR
 . S MAGNFDA(2006.539,"?+1,",3)=TYPE
 . S MAGNFDA(2006.539,"?+1,",4)=SUBTYPE
 . S MAGNFDA(2006.5391,"?+2,?+1,",.01)=PURPOSE
 . S MAGNFDA(2006.5391,"?+2,?+1,",2)=ACTION
 . S MAGNFDA(2006.5391,"?+2,?+1,",3)=COMMENT
 . D UPDATE^DIE("S","MAGNFDA","MAGNIEN","MAGNXE")
 . I $D(MAGNXE("DIERR","E")) W !!,"Error updating DICOM UID SPECIFIC ACTION file (#2006.539) :",I
 . Q
 W !!,"Update of DICOM UID SPECIFIC ACTION file (#2006.539) is done"
 Q
