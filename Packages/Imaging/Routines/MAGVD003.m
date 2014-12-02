MAGVD003 ;WOIFO/NST - Utilities for RPC calls for deletion ; 03 Apr 2012 1:54 PM
 ;;3.0;IMAGING;**118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 ;+++++  Get Accession number by IEN in IMAGE file (#2005)
 ; 
 ; Input Parameters
 ; ================
 ; MAGDA - IEN in IMAGE file (#2005)
 ; 
 ; Return Values
 ; =============
 ; if error OUT = Failed Status^Error message
 ; if success OUT = Success status^^Accession number
 ; 
GETACN(OUT,MAGDA) ; get accession number
 N PARENTFN,PARENTD0,MAGD2,CONSIX,ERR,ACN
 N RESDEL
 S RESDEL=$$RESDEL^MAGVAF02()  ; Result delimiter
 I '$$ISGRP^MAGGI11(MAGDA,.ERR) D  Q
 . S:$G(ERR)'="" OUT=$$FAILED^MAGVAF02()_RESDEL_$P(ERR,"^",2)
 . S:$G(ERR)="" OUT=$$FAILED^MAGVAF02()_RESDEL_"Image "_MAGDA_" is not a group image"
 . Q
 S MAGD2=$G(^MAG(2005,MAGDA,2))
 S PARENTFN=$P(MAGD2,"^",6)  ; Parent Data File
 S PARENTD0=+$P(MAGD2,"^",7)  ; Parent Global Root D0
 S ACN=""
 I (PARENTFN=74),PARENTD0 D  ; Radiology Image
 . S ACN=$P($G(^RARPT(PARENTD0,0)),"^") ; IA # 1171    ; Get Accession number
 . Q
 I (PARENTFN=8925),PARENTD0 D
 . S CONSIX=$$GET1^DIQ(8925,PARENTD0,1405,"I")  ; #1405 REQUESTING PACKAGE REFERENCE
 . S:$P(CONSIX,";",2)="GMR(123," ACN=$$GMRCACN^MAGDFCNV($P(CONSIX,";",1))
 . Q
 I (PARENTFN=2006.5839),PARENTD0 D  ; Consult Image
 . S ACN=$$GMRCACN^MAGDFCNV(PARENTD0)
 . Q
 S:ACN="" OUT=$$FAILED^MAGVAF02()_RESDEL_"Accession number not found"
 D:ACN'="" SETOKVAL^MAGVAF02(.OUT,ACN)
 Q
