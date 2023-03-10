RAIPS187 ;WOIFO/KLM - PostInit 187; Feb 24, 2022@09:24:47
 ;;5.0;Radiology/Nuclear Medicine;**187**;Mar 16, 1998;Build 1
 ;This post-init routine updates the DICOM Modality terms in file
 ;RAD MODALITY DEFINED TERMS (#73.1) per the DICOM STANDARD(PS 3.3 - 2022a)
 ;
 ;
EN ;post-init entry point
 N RAI,RA01,RA1,RA2,RA3,RADATA,RATXT,RAMSG
 F RAI=1:1 S RADATA=$T(DATA+RAI) Q:RADATA=""  D
 .S RA01=$P($P(RADATA,";",3),"^"),RA1=$P(RADATA,"^",2),RA2=$P(RADATA,"^",3),RA3=$P(RADATA,"^",4)
 .N RAFDA,RAR S RAR="RAFDA(73.1,""?+1,"")" ;FDA root -Check for existing entry to update
 .S @RAR@(.01)=RA01 ;MODALITY ABBREVIATION
 .S:$D(RA1) @RAR@(1)=RA1    ;MODALITY NAME
 .S:$D(RA2) @RAR@(2)=RA2    ;STATUS
 .S:$D(RA3) @RAR@(3)=RA3    ;REPLACED BY
 .D UPDATE^DIE("E","RAFDA","","RAMSG") K RAFDA
 .I $D(RAMSG(1,"DIERR"))#2 D MES^XPDUTL("An error occured filing data for "_RA1)
 .Q
 Q
DATA ;data
 ;;ANN^Annotation^^
 ;;AR^Autorefraction^^
 ;;ASMT^Content Assessment Results^^
 ;;AU^Audio^^
 ;;BDUS^Bone Densitometry (ultrasound)^^
 ;;BI^Biomagnetic Imaging^^
 ;;BMD^Bone Densitometry (X-Ray)^^
 ;;CR^Computed Radiography^
 ;;CT^Computed Tomography^^
 ;;CTPROTOCOL^CT Protocol (Performed)^^
 ;;DMS^Dermoscopy^^
 ;;DG^Diaphanography^^
 ;;DOC^Document^^
 ;;DX^Digital Radiography^^
 ;;ECG^Electrocardiography^^
 ;;EEG^Electroencephalography^^
 ;;EMG^Electromyography^^
 ;;EOG^Electrooculography^^
 ;;EPS^Cardiac Electrophysiology^^
 ;;ES^Endoscopy^^
 ;;FID^Fiducials^^
 ;;GM^General Microscopy^^
 ;;HC^Hard Copy^^
 ;;HD^Hemodynamic Waveform^^
 ;;IO^Intra-Oral Radiography^^
 ;;IOL^Intraocular Lens Data^^
 ;;IVOCT^Intravascular Optical Coherence Tomography^^
 ;;IVUS^Intravascular Ultrasound^^
 ;;KER^Keratometry^^
 ;;KO^Key Object Selection^^
 ;;LEN^Lensometry^^
 ;;LS^Laser Surface Scan^^
 ;;MG^Mammography^^
 ;;MR^Magnetic Resonance^^
 ;;M3D^Model for 3D Manufacturing^^
 ;;NM^Nuclear Medicine^^
 ;;OAM^Ophthalmic Axial Measurements^^
 ;;OCT^Optical Coherence Tomography (non-Ophthalmic)^^
 ;;OP^Ophthalmic Photography^^
 ;;OPM^Ophthalmic Mapping^^
 ;;OPT^Ophthalmic Tomography^^
 ;;OPTBSV^Ophthalmic Tomography B-scan Volume Analysis^^
 ;;OPTENF^Ophthalmic Tomography En Face^^
 ;;OPV^Ophthalmic Visual Field^^
 ;;OSS^Optical Surface Scan^^
 ;;OT^Other^^
 ;;PLAN^Plan^^
 ;;POS^Position Sensor^^
 ;;PR^Presentation State^
 ;;PT^Positron Emission Tomography (PET)^^
 ;;PX^Panoramic X-Ray^^
 ;;REG^Registration^^
 ;;RESP^Respiratory Waveform^^
 ;;RF^Radio Fluoroscopy^^
 ;;RG^Radiographic Imaging (conventional film/screen)^^
 ;;RTDOSE^Radiotherapy Dose^^
 ;;RTIMAGE^Radiotherapy Image^^
 ;;RTINTENT^Radiotherapy Intent^^
 ;;RTPLAN^Radiotherapy Plan^^
 ;;RTRAD^RT Radiation^^
 ;;RTRECORD^RT Treatment Record^^
 ;;RTSEGANN^Radiotherapy Segment Annotation^^
 ;;RTSTRUCT^Radiotherapy Structure Set^^
 ;;RWV^Real World Value Map^^
 ;;SEG^Segmentation^^
 ;;SM^Slide Microscopy^^
 ;;SMR^Stereometric Relationship^^
 ;;SR^SR Document^^
 ;;SRF^Subjective Refraction^^
 ;;STAIN^Automated Slide Stainer^^
 ;;TEXTUREMAP^Texture Map^^
 ;;TG^Thermography^^
 ;;US^Ultrasound^^
 ;;VA^Visual Acuity^^
 ;;XA^X-Ray Angiography^^
 ;;XAPROTOCOL^XA Protocol (Performed)^^
 ;;XC^External-Camera Photography^^
 ;;AS^Angioscopy^R^
 ;;CD^Color Flow Doppler^R^US
 ;;CF^Cinefluorography^R^RF
 ;;CP^Culposcopy^R^
 ;;CS^Cystoscopy^R^
 ;;DD^Duplex Doppler^R^US
 ;;DF^Digital Fluoroscopy^R^RF
 ;;DM^Digital Microscopy^R^
 ;;DS^Digital Subtraction Angiography^R^XA
 ;;EC^Echocardiography^R^US
 ;;FA^Fluorescein Angiography^R^
 ;;FS^Fundoscopy^R^
 ;;LP^Laparoscopy^R^
 ;;MA^Magnetic Resonance Angiography^R^MR
 ;;MS^Magnetic Resonance Spectroscopy^R^MR
 ;;OPR^Ophthalmic Refraction^R^
 ;;ST^Single-Photon Emission Computed Tomography (SPECT)^R^NM
 ;;VF^Videofluorography^R^RF
