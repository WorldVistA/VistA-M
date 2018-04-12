MAGNVQ05 ;WOIFO/NST - List images for a patient ; 28 Sep 2017 3:59 PM
 ;;3.0;IMAGING;**185**;Mar 19, 2002;Build 4525;May 01, 2013
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
PATIMG34(IARRAY,DFN,IMGLESS,FLAGS) ; Get images from P34 database by Patient
 ; IARRAY  = Output array with patient images
 ; DFN     = Patient DFN
 ; IMGLESS = 0|1 Include images
 ; [FLAGS] = for feature use
 ;
 N PATIX,PROCIX,STYIX,SERIX,SOPIX,IMAGE
 ;
 S PATIX=""
 F  S PATIX=$O(^MAGV(2005.6,"C",DFN,PATIX)) Q:'PATIX  D
 . S PROCIX=""
 . F  S PROCIX=$O(^MAGV(2005.61,"C",PATIX,PROCIX)) Q:'PROCIX  D
 . . Q:$P($G(^MAGV(2005.61,PROCIX,0)),"^",5)'="A"  ; not active
 . . S STYIX=""
 . . F  S STYIX=$O(^MAGV(2005.62,"C",PROCIX,STYIX)) Q:'STYIX  D
 . . . Q:$P($G(^MAGV(2005.62,STYIX,5)),"^",2)="I"  ; study marked inaccessible
 . . . S SERIX=""
 . . . F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D
 . . . . N ACTVIMG
 . . . . S ACTVIMG=0
 . . . . S SOPIX=""
 . . . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D  Q:IMGLESS&ACTVIMG
 . . . . . S IMAGE=""
 . . . . . F  S IMAGE=$O(^MAGV(2005.65,"C",SOPIX,IMAGE)) Q:'IMAGE  D
 . . . . . . I $P($G(^MAGV(2005.65,IMAGE,1)),"^",5)'="I" D
 . . . . . . . S IARRAY(STYIX,SERIX,SOPIX,IMAGE)="",ACTVIMG=1
 . . . . . . . Q
 . . . . . . Q
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
