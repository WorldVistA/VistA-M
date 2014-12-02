MAGVSOPU ;WOIFO/NST,DAC - Update file (#2006.539)  ; 31 Oct 2012 12:12 PM
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
UPDATE ; Update DICOM UID SPECIFIC ACTION file (#2006.539)
 N MAGN
 ;
 S MAGN("1.2.840.10008.1.1^Verification SOP Class^0^Echo")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.1^Computed Radiography Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.1.1^Digital X-Ray Image Storage - For Presentation^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.1.1.1^Digital X-Ray Image Storage - For Processing^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.1.2^Digital Mammography X-Ray Image Storage - For Presentation^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.1.2.1^Digital Mammography X-Ray Image Storage - For Processing^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.1.3^Digital Intra-oral X-Ray Image Storage - For Presentation^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.1.3.1^Digital Intra-oral X-Ray Image Storage - For Processing^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.2^CT Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.2.1^Enhanced CT Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.3^Ultrasound Multi-frame Image Storage (Retired)^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.3.1^Ultrasound Multi-frame Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.4^MR Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.4.1^Enhanced MR Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.4.2^MR Spectroscopy Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.4.3^Enhanced MR Color Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.5^Nuclear Medicine Image Storage (Retired)^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.6^Ultrasound Image Storage (Retired)^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.6.1^Ultrasound Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.6.2^Enhanced US Volume Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.7^Secondary Capture Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.7.1^Multi-frame Single Bit Secondary Capture Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.7.2^Multi-frame Grayscale Byte Secondary Capture Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.7.3^Multi-frame Grayscale Word Secondary Capture Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.7.4^Multi-frame True Color Secondary Capture Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.8^Standalone Overlay Storage^3^Unknown|iconovl.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9^Standalone Curve Storage^3^Unknown|iconcurve.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.1^Waveform Storage - Trial (Retired)^3^Unknown|absekg.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.1.1^12-lead ECG Waveform Storage^3^Unknown|absekg.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.1.2^General ECG Waveform Storage^3^Unknown|absekg.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.1.3^Ambulatory ECG Waveform Storage^3^Unknown|absekg.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.2.1^Hemodynamic Waveform Storage^3^Unknown|absekg.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.3.1^Cardiac Electrophysiology Waveform Storage^3^Unknown|absekg.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.4.1^Basic Voice Audio Waveform Storage^3^Unknown|magwav.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.4.2^General Audio Waveform Storage^3^Unknown|magwav.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.5.1^Arterial Pulse Waveform Storage^3^Unknown|magwav.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.9.6.1^Respiratory Waveform Storage^3^Unknown|magwav.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.10^Standalone Modality LUT Storage^3^Unknown|iconlut.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.11^Standalone VOI LUT Storage^3^Unknown|iconlut.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.11.1^Grayscale Softcopy Presentation State Storage SOP Class^3^Unknown|iconpstate.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.11.2^Color Softcopy Presentation State Storage SOP Class^3^Unknown|iconpstate.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.11.3^Pseudo-Color Softcopy Presentation State Storage SOP Class^3^Unknown|iconpstate.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.11.4^Blending Softcopy Presentation State Storage SOP Class^3^Unknown|iconpstate.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.11.5^XA/XRF Grayscale Softcopy Presentation State Storage^3^Unknown|iconpstate.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.12.1^X-Ray Angiographic Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.12.1.1^Enhanced XA Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.12.2^X-Ray Radiofluoroscopic Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.12.2.1^Enhanced XRF Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.12.3^X-Ray Angiographic Bi-Plane Image Storage (Retired)^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.13.1.1^X-Ray 3D Angiographic Image Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.13.1.2^X-Ray 3D Craniofacial Image Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.13.1.3^Breast Tomosynthesis Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.20^Nuclear Medicine Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66^Raw Data Storage^3^Unknown|iconraw.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.1^Spatial Registration Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.2^Spatial Fiducials Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.3^Deformable Spatial Registration Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.4^Segmentation Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.66.5^Surface Segmentation Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.67^Real World Value Mapping Storage^3^Unknown|icon3d.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1^VL Image Storage - Trial (Retired)^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.2^VL Multi-frame Image Storage - Trial (Retired)^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.1^VL Endoscopic Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.1.1^Video Endoscopic Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.2^VL Microscopic Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.2.1^Video Microscopic Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.3^VL Slide-Coordinates Microscopic Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.4^VL Photographic Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.4.1^Video Photographic Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.5.1^Ophthalmic Photography 8 Bit Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.5.2^Ophthalmic Photography 16 Bit Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.5.3^Stereometric Relationship Storage^3^Unknown|iconeyes.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.5.4^Ophthalmic Tomography Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.78.1^Lensometry Measurements Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.78.2^Autorefraction Measurements Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.78.3^Keratometry Measurements Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.78.4^Subjective Refraction Measurements Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.78.5^Visual Acuity Measurements^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.78.6^Spectacle Prescription Reports Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.79.1^Macular Grid Thickness and Volume Report Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.1^Text SR Storage - Trial (Retired)^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.2^Audio SR Storage - Trial (Retired)^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.3^Detail SR Storage - Trial (Retired)^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.4^Comprehensive SR Storage - Trial (Retired)^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.11^Basic Text SR Storage^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.22^Enhanced SR Storage^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.33^Comprehensive SR Storage^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.40^Procedure Log Storage^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.50^Mammography CAD SR^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.59^Key Object Selection Document^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.65^Chest CAD SR^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.67^X-Ray Radiation Dose SR Storage^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.88.69^Colon CAD SR Storage^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.1^Encapsulated PDF Storage^1^Known|magpdf.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.104.2^Encapsulated CDA Storage^3^Unknown|iconcda.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.128^Positron Emission Tomography Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.129^Standalone PET Curve Storage^1^Known|iconcurve.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.130^Enhanced PET Image Storage^3^Unknown|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.131^Basic Structured Display Storage^3^Unknown|iconsr.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.1^RT Image Storage^1^Known|createIcon")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.2^RT Dose Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.3^RT Structure Set Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.4^RT Beams Treatment Record Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.5^RT Plan Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.6^RT Brachy Treatment Record Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.7^RT Treatment Summary Record Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.8^RT Ion Plan Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.481.9^RT Ion Beams Treatment Record Storage^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.34.1^RT Beams Delivery Instruction Storage (Supplement 74 Frozen Draft)^3^Unknown|iconrt.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.38.1^Hanging Protocol Storage^3^Unknown|iconpstate.JPG")=""
 S MAGN("1.2.840.10008.5.1.4.1.1.77.1.6^VL Whole Slide Microscopic Image Storage^3^Unknown|createIcon")=""
 ;
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
 . I $D(MAGNXE("DIERR","E")) W !,"Error updating DICOM UID SPECIFIC ACTION file (#2006.539): ",I
 . Q
 W !,"Update of DICOM UID SPECIFIC ACTION file (#2006.539) is done"
 Q
