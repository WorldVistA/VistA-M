MAGNVQ05 ;WOIFO/NST - List images for a patient ; OCT 18, Sep 2017 3:59 PM
 ;;3.0;IMAGING;**185,221**;Mar 19, 2002;Build 4525;May 01, 2013
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
QUERY34(IARRAY,DFN,IMGLESS,FROMDATE,TODATE,MAGDATA) ; Query P34 database
 I DFN D PATIMG34(.IARRAY,DFN,IMGLESS,FROMDATE,TODATE,.MAGDATA) Q
 ;
 D STUDYQRY(.IARRAY,IMGLESS,FROMDATE,TODATE,.MAGDATA) ; Get images from P34 database by Study query
 Q
 ;
PATIMG34(IARRAY,DFN,IMGLESS,FROMDATE,TODATE,MAGDATA) ; Get images from P34 database by Patient
 ; IARRAY  = Output array with patient images
 ; DFN     = Patient DFN
 ; IMGLESS = 0|1 Include images
 ; FROMDATE,TODATE = Capture date range of images 
 ; .MAGDATA = Filters
 ;
 N PATIX,PROCIX,STYIX,SERIX,SOPIX,IMAGE,MAGCAPDT
 N ACTVIMG,CLASS,CPTCODE,EVT,FOUND,PROC,SPEC,PKG,ORIG,TYPE,TMP
 ;
 S PATIX=""
 F  S PATIX=$O(^MAGV(2005.6,"C",DFN,PATIX)) Q:'PATIX  D
 . S PROCIX=""
 . F  S PROCIX=$O(^MAGV(2005.61,"C",PATIX,PROCIX)) Q:'PROCIX  D
 . . S TMP=$G(^MAGV(2005.61,PROCIX,0))
 . . Q:$P(TMP,"^",5)'="A"  ; not active
 . . I $D(MAGDATA("CPTCODE")) D  Q:'FOUND   ; CPT Code doesn't match
 . . . S CPTCODE=""
 . . . S ACCNUM=$P(TMP,"^",1)    ; Accession number
 . . . S PROCTYPE=$P(TMP,"^",3)  ; Procedure Type
 . . . S CPTCODE=$$CPTCODE(ACCNUM,PROCTYPE)
 . . . S FOUND=$S(CPTCODE="":0,1:$D(MAGDATA("CPTCODE",CPTCODE)))
 . . . Q
 . . S STYIX=""
 . . F  S STYIX=$O(^MAGV(2005.62,"C",PROCIX,STYIX)) Q:'STYIX  D
 . . . Q:$P($G(^MAGV(2005.62,STYIX,5)),"^",2)="I"  ; study marked inaccessible
 . . . S MAGCAPDT=$P($G(^MAGV(2005.62,STYIX,2)),"^",1)  ; study date time
 . . . Q:(MAGCAPDT<FROMDATE)!(MAGCAPDT>TODATE)          ; study out of date range
 . . . Q:'$$FLTRSTUD(STYIX,.MAGDATA)  ; Filter on study level
 . . . S SERIX=""
 . . . F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D
 . . . . Q:'$$FLTRSER(SERIX,.MAGDATA)  ; Filter on series level
 . . . . ;
 . . . . S ACTVIMG=0
 . . . . S SOPIX=""
 . . . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D  Q:IMGLESS&ACTVIMG
 . . . . . I $D(MAGDATA("TYPE")) S TYPE=$P($G(^MAGV(2005.64,SOPIX,5)),"^",1) Q:TYPE=""  Q:'$D(MAGDATA("TYPE",TYPE))  ; Type Index
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
 ;
CPTCODE(ACCNUM,PROCTYPE) ; Get CPT by Accession number
 N OSEP,ISEP,SSEP,OUT,CPTCODE,I,FOUNDC,FOUNDT
 I PROCTYPE'="RAD" Q ""
 S OSEP=$$OUTSEP^MAGVRS41,ISEP=$$INPUTSEP^MAGVRS41,SSEP=$$STATSEP^MAGVRS41
 D GETRPROC^MAGVRS81(.OUT,ACCNUM)  ; Get radiology exam details
 S (FOUNDC,FOUNDT)=0
 S CPTCODE=""
 S I=""
 F  S I=$O(OUT(I)) Q:(FOUNDC&FOUNDT)!'I  D
 . I $P(OUT(I),OSEP,1)="PROCEDURE CODE" S CPTCODE=$P($P(OUT(I),OSEP,2),SSEP),FOUNDC=1 Q
 . I ($P(OUT(I),OSEP,1)="TERMINOLOGY"),($P($P(OUT(I),OSEP,2),SSEP)="CPT") S FOUNDT=1 Q
 . Q
 Q CPTCODE
 ;
FLTRSER(SERIX,MAGDATA) ; Filter on Series level
 N CLASS,MODALITY,PROC,SPEC,TMP
 ;
 I $D(MAGDATA("MODALITY")) S MODALITY=$P($G(^MAGV(2005.63,SERIX,1)),"^") Q:MODALITY="" 0 Q:'$D(MAGDATA("MODALITY",MODALITY)) 0
 ;
 S TMP=$G(^MAGV(2005.63,SERIX,10))
 I $D(MAGDATA("CLS")) S CLASS=$P(TMP,"^",1) Q:CLASS="" 0 Q:'$D(MAGDATA("CLS",CLASS)) 0 ; CLASS INDEX
 I $D(MAGDATA("PROC")) S PROC=$P(TMP,"^",2) Q:PROC="" 0 Q:'$D(MAGDATA("PROC",PROC)) 0 ; PROC/EVENT INDEX
 I $D(MAGDATA("SPEC")) S SPEC=$P(TMP,"^",2) Q:SPEC="" 0 Q:'$D(MAGDATA("SPEC",SPEC)) 0 ; SPEC/SUBSPEC INDEX
 Q 1
 ;
FLTRSTUD(STYIX,MAGDATA)  ; Filter on Study level
 N TMP,ORIG,PKG
 S TMP=$G(^MAGV(2005.62,STYIX,3))
 I $D(MAGDATA("GDESC")) Q:$$UP^XLFSTR($P(TMP,U,1))'[MAGDATA("GDESC") 0   ; Short description
 I $D(MAGDATA("ORIG")) S ORIG=$P(TMP,"^",2) Q:ORIG="" 0 Q:'$D(MAGDATA("ORIG",ORIG)) 0  ; Origin Index
 I $D(MAGDATA("PKG")) S PKG=$$GET1^DIQ(2005.62,STYIX,"11:40","I") Q:PKG="" 0 Q:'$D(MAGDATA("PKG",PKG)) 0
 Q 1
 ;
STUDYQRY(IARRAY,IMGLESS,FROMDATE,TODATE,MAGDATA) ; Get images from P34 database by Study query
 ; IARRAY  = Output array with patient images
 ; IMGLESS = 0|1 Include images
 ; FROMDATE,TODATE = Capture date range of images 
 ; .MAGDATA = Filters
 N ACTVIMG,DATEIX,IMAGE,STYIX,SERIX,SOPIX,TYPE
 ;
 S DATEIX=FROMDATE-1
 F  S DATEIX=$O(^MAGV(2005.62,"J",DATEIX)) Q:'DATEIX!(DATEIX>TODATE)  D
 . S STYIX=""
 . F  S STYIX=$O(^MAGV(2005.62,"J",DATEIX,STYIX)) Q:'STYIX  D
 . . Q:$P($G(^MAGV(2005.62,STYIX,5)),"^",2)="I"  ; study marked inaccessible
 . . Q:'$$FLTRSTUD(STYIX,.MAGDATA)  ; Filter on study level
 . . S SERIX=""
 . . F  S SERIX=$O(^MAGV(2005.63,"C",STYIX,SERIX)) Q:'SERIX  D
 . . . Q:'$$FLTRSER(SERIX,.MAGDATA)  ; Filter on series level
 . . . ;
 . . . S ACTVIMG=0
 . . . S SOPIX=""
 . . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIX,SOPIX)) Q:'SOPIX  D  Q:IMGLESS&ACTVIMG
 . . . . I $D(MAGDATA("TYPE")) S TYPE=$P($G(^MAGV(2005.64,SOPIX,5)),"^",1) Q:TYPE=""  Q:'$D(MAGDATA("TYPE",TYPE))  ; Type Index
 . . . . S IMAGE=""
 . . . . F  S IMAGE=$O(^MAGV(2005.65,"C",SOPIX,IMAGE)) Q:'IMAGE  D
 . . . . . I $P($G(^MAGV(2005.65,IMAGE,1)),"^",5)'="I" D
 . . . . . . S IARRAY(STYIX,SERIX,SOPIX,IMAGE)="",ACTVIMG=1
 . . . . . . Q
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . Q
 Q
