MAGTP007 ;WOIFO/FG - TELEPATHOLOGY TAGS ; 25 Jul 2013 5:38 PM
 ;;3.0;IMAGING;**138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
 Q  ;
 ;
 ;***** GET LAB INFO FOR A CASE AS SHOWN IN CPRS
 ; RPC: MAGTP GET CPRS REPORT
 ;
 ; .MAGRY        Reference to a local variable where the results
 ;               are returned to.
 ;
 ; LRSS          AP Section
 ;
 ; YEAR          Accession Year (Two figures)
 ;
 ; LRAN          Accession Number
 ;
 ; Return Values
 ; =============
 ; 
 ; If MAGRY(0) 1st '^'-piece is 0, then an error
 ; occurred during execution of the procedure: 0^0^ ERROR explanation
 ;
 ; Otherwise, the output array reproduces the structure
 ; of global ^TMP("ORDATA",$J), containing the CPRS report:
 ;
 ; MAGRY(0)     Description
 ;                ^01: 1
 ;                ^02: Number of Lines 
 ;
 ; MAGRY(i)     Description
 ;                ^01: Text from CPRS Report
 ;
 ; Notes
 ; =====
 ;
 ; The ^TMP("ORDATA",$J) global node is used by this procedure
 ;
GETREP(MAGRY,LRSS,YEAR,LRAN)                   ; RPC [MAGTP GET CPRS REPORT]
 K MAGRY
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I $G(LRSS)=""!($G(YEAR)="")!($G(LRAN)="") D  Q
 . S MAGRY(0)="0^0^One or more input parameters are missing"
 N INPUT
 S INPUT=$$CONTEXT^MAGTP006(.MAGRY,LRSS,YEAR,LRAN) Q:'MAGRY(0)
 N LRI,LRDFN,DFN,FIELD,LABEL,RPTID,ROOT,TEMP,CT,I,J
 S LRI=$P(INPUT,",",2),LRDFN=$P(INPUT,",",3)
 S DFN=$$GET1^DIQ(63,LRDFN_",",".03","I")      ; Internal Patient ID
 S FIELD=$S(LRSS="CY":9,LRSS="EM":2,1:8)
 S LABEL=$$GET1^DID(63,FIELD,"","LABEL")       ; Name (label) of AP Section
 S RPTID="OR_"_LRSS_":"_LABEL_"~"_LRSS_";ORDV02A;0;1000"
 D RPT^ORWRP(.ROOT,DFN,RPTID)                  ; Get all reports for a patient
 M TEMP=@($P(ROOT,")")_","""_LRI_LRSS_""",""WP"")")  ; Select only one case report
 ; Strip line numbers, set MAGRY
 S (CT,I)=0
 F  S I=$O(TEMP(I)) Q:I=""  D
 . S J=""
 . F  S J=$O(TEMP(I,J)) Q:J=""  D
 . . S CT=CT+1
 . . S MAGRY(CT)=$P(TEMP(I,J),U,2)
 . . Q
 . Q
 S MAGRY(0)="1^"_CT
 K ^TMP("ORDATA",$J),^TMP("LRC",$J)            ; Clean up temporary globals
 Q  ;
