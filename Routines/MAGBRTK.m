MAGBRTK ;WOIFO/EdM - Routing - Keywords ; 17 Mar 2008 12:25 PM
 ;;3.0;IMAGING;**51,53**;Mar 19, 2002;Build 1719;Apr 28, 2010
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
 ; This routine is needed on the DICOM Gateway while importing
 ; new rules, and on the VistA system while evaluating the rules.
 ;
KEYWORD ; build the KEYWORD array
 N C,CD,D,KW,M,V,X
 S CD="CONDITION" K KEYWORD
 ; Actions
 F X="SEND","BALANCE","DICOM" S KEYWORD("ACTION",X)="-"
 F X="DESTINATION","HOLIDAY" S KEYWORD("ACTION",X)="I"
 ;
 F X="HIGH","NORMAL","LOW" S KEYWORD("PRIORITY",X)="-"
 F X="YES","NO" S KEYWORD("PRIORSTUDY",X)="-"
 ;
 ; Fields in ^MAG(2005,
 S M="LO^MAG^MAGBRTE3(IMAGE,"
 S KEYWORD(CD,"ABSTRACT_REF")=M_"0,0,4,.VAL)"
 S KEYWORD(CD,"ACQUISITION_DEVICE")=M_"2006.04,100,4,.VAL)"
 S KEYWORD(CD,"BIG_JUKEBOX_PATH")=M_"2005.2,""FBIG"",2,.VAL)"
 S KEYWORD(CD,"BIG_MAGNETIC_PATH")=M_"2005.2,""FBIG"",1,.VAL)"
 S KEYWORD(CD,"CLASS")=M_"2005.82,40,2,.VAL)"
 S KEYWORD(CD,"CLINIC")=M_"44,100,2,.VAL)"
 S KEYWORD(CD,"CREATE_METHOD")=M_"0,""METHOD"",1,.VAL)"
 S KEYWORD(CD,"DESCRIPTIVE_CATEGORY")=M_"2005.81,100,1,.VAL)"
 S KEYWORD(CD,"EXPORT_REQUEST_STATUS")=M_"0,2,9,.VAL)"
 S KEYWORD(CD,"FILE_REF")=M_"0,0,2,.VAL)"
 S KEYWORD(CD,"IQ")=M_"0,0,11,.VAL)"
 S KEYWORD(CD,"MAGNETIC_REF")=M_"0,0,3,.VAL)"
 S KEYWORD(CD,"MICROSCOPIC_OBJECTIVE")=M_"0,""PATH"",5,.VAL)"
 S KEYWORD(CD,"MODALITY")=M_"0,0,8,.VAL)"
 S KEYWORD(CD,"OBJECT_NAME")=M_"0,0,1,.VAL)"
 S KEYWORD(CD,"OBJECT_TYPE")=M_"2005.02,0,6,.VAL)"
 S KEYWORD(CD,"ORIGIN_INDEX")=M_"0,40,6,.VAL)"
 S KEYWORD(CD,"PACKAGE")=M_"0,40,1,.VAL)"
 S KEYWORD(CD,"PACS_PROCEDURE")=M_"71,""PACS"",3,.VAL)"
 S KEYWORD(CD,"PACS_UID")=M_"0,""PACS"",1,.VAL)"
 S KEYWORD(CD,"PARENT_DATA")=M_"2005.03,2,6,.VAL)"
 S KEYWORD(CD,"PARENT_DATA_FILE_IMAGE_POINTER")=M_"0,2,8,.VAL)"
 S KEYWORD(CD,"PARENT_GLOBAL_ROOT_D0")=M_"0,2,7,.VAL)"
 S KEYWORD(CD,"PARENT_GLOBAL_ROOT_D1")=M_"0,2,10,.VAL)"
 S KEYWORD(CD,"PATH_ACCESSION_NUMBER")=M_"0,""PATH"",1,.VAL)"
 S KEYWORD(CD,"PATIENT")=M_"2,0,7,.VAL)"
 S KEYWORD(CD,"PROCEDURE")=M_"0,0,8,.VAL)"
 S KEYWORD(CD,"PROCEDURE_OR_EVENT")=M_"2005.85,40,4,.VAL)"
 S KEYWORD(CD,"RADIOLOGY_REPORT")=M_"74,""PACS"",2,.VAL)"
 S KEYWORD(CD,"SAVED_BY")=M_"200,2,2,.VAL)"
 S KEYWORD(CD,"SHORT_DESCRIPTION")=M_"0,2,4,.VAL)"
 S KEYWORD(CD,"SPECIALTY")=M_"2005.84,40,5,.VAL)"
 S KEYWORD(CD,"SPECIMEN")=M_"0,""PATH"",3,.VAL)"
 S KEYWORD(CD,"SPECIMEN_DESCRIPTION")=M_"0,""PATH"",2,.VAL)"
 S KEYWORD(CD,"STAIN")=M_"0,""PATH"",4,.VAL)"
 S KEYWORD(CD,"SUMMARY")=M_"0,2,3,.VAL)"
 S KEYWORD(CD,"SUMMARY_OBJECT")=M_"0,2,3,.VAL)"
 S KEYWORD(CD,"TRACKING_ID")=M_"0,100,5,.VAL)"
 S KEYWORD(CD,"TYPE")=M_"2005.83,40,3,.VAL)"
 S KEYWORD(CD,"WORM_REF")=M_"0,0,5,.VAL)"
 ;
 ; Date and time fields
 S M="DT^MAG^MAGBRTE3(IMAGE,"
 S KEYWORD(CD,"EXAM_TIME")=M_"0,2,5,.VAL)"
 S KEYWORD(CD,"IMAGE_SAVED")=M_"0,2,1,.VAL)"
 S KEYWORD(CD,"LAST_ACCESS")=M_"0,0,9,.VAL)"
 S KEYWORD(CD,"PROCEDURE_TIME")=M_"0,2,5,.VAL)"
 ;
 S M="DT^DATE^MAGBRTE3(IMAGE,"
 S KEYWORD(CD,"EXAM_TIME_FIRST")=M_"0,2,5,1,.VAL)"
 S KEYWORD(CD,"EXAM_TIME_LAST")=M_"0,2,5,2,.VAL)"
 S KEYWORD(CD,"IMAGE_SAVED_FIRST")=M_"0,2,1,1,.VAL)"
 S KEYWORD(CD,"IMAGE_SAVED_LAST")=M_"0,2,1,2,.VAL)"
 S KEYWORD(CD,"LAST_ACCESS_FIRST")=M_"0,0,9,1,.VAL)"
 S KEYWORD(CD,"LAST_ACCESS_LAST")=M_"0,0,9,2,.VAL)"
 S KEYWORD(CD,"PROCEDURE_TIME_FIRST")=M_"0,2,5,1,.VAL)"
 S KEYWORD(CD,"PROCEDURE_TIME_LAST")=M_"0,2,5,2,.VAL)"
 S KEYWORD(CD,"STUDY_TIME")=M_"0,2,5,1,.VAL)"
 ;
 ; Built-in Fields
 S KEYWORD(CD,"NOW")="DT^NOW^MAGBRTE3(.VAL)"
 S KEYWORD(CD,"SOURCE")="SH^SOURCE^MAGBRTE3(IMAGE,.VAL)"
 S KEYWORD(CD,"URGENCY")="SH^URGENCY^MAGBRTE3(IMAGE,.VAL)"
 Q
 ;
