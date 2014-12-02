MAGVIM08 ;;WOIFO/NST - Imaging RPCs for Importer II ; 16 Feb 2012 12:51 PM
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
 ;
 ;*****  Return number of records in MAG WORK ITEM file (#2006.941)
 ;       by TYPE, SUBTYPE, and STATUS
 ;    
 ; RPC:MAGV WORK ITEMS COUNT
 ; 
 ; Input Parameters
 ; ================
 ;   TYPE    = External value of TYPE field (#2006.941,1)
 ;   [SUBTYPE] = External value of SUBTYPE field (#2006.941,2)
 ;   [STATUS]  = External value of STATUS field (#2006.941,3) 
 ;
 ; Return Values
 ; =============
 ; if error MAGRY(0) = Error number `` Error message
 ; if success MAGRY(0) = 0` Number of records
 ;            MAGRY(1) = "SUBTYPE`STATUS`COUNT"   
 ;            MAGRY(1..n) = SUBTYPE  ` STATUS ` COUNT
 ;
CNTWI(MAGRY,TYPE,SUBTYPE,STATUS) ; RPC [MAGV WORK ITEMS COUNT]
 N SSEP,MAGRESA,MAGNXE,I,OUT,TOTAL,TYPEIEN,VSUB,VSTAT
 S SSEP=$$STATSEP^MAGVIM01
 I $G(TYPE)="" S MAGRY(0)=-1_SSEP_"No type provided" Q
 S SUBTYPE=$G(SUBTYPE)
 S STATUS=$G(STATUS)
 ;
 S TYPEIEN=$$FIND1^DIC(2006.9412,"","BX",TYPE,"","","MAGNXE") ; Find the IEN for TYPE
 I $D(MAGNXE("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY(0)=-1_SSEP_MAGRESA(1)
 . Q
 ;
 I TYPEIEN'>0 S MAGRY(0)=-2_SSEP_"Type is not found" Q
 ; 
 D FIND^DIC(2006.941,"","@;2;3","QX",TYPEIEN,"","T","","","OUT","MAGNXE")
 I $D(MAGNXE("DIERR")) D  Q
 . D MSG^DIALOG("A",.MAGRESA,245,5,"MAGNXE")
 . S MAGRY(0)=-3_SSEP_MAGRESA(1) Q  ; Error getting the list
 . Q
 ; Output the result
 ; 
 S I=0
 F  S I=$O(OUT("DILIST","ID",I)) Q:I'>0  D
 . S VSUB=OUT("DILIST","ID",I,2)
 . I (SUBTYPE'=""),(VSUB'=SUBTYPE) Q
 . S VSTAT=OUT("DILIST","ID",I,3)
 . I (STATUS'=""),(VSTAT'=STATUS) Q
 . S TOTAL(VSUB,VSTAT)=$G(TOTAL(VSUB,VSTAT))+1
 . Q
 ;
 D OUTRES(.MAGRY,.TOTAL)  ; Output the totals
 Q
 ;
OUTRES(MAGRY,TOTAL)  ; Output the final result by SUBTYPE and STATUS
 ; TOTAL - Input totals
 ;     TOTAL("DirectImport","New")=3
 ;     .....
 ; MAGRY - Output array
 ;   MAGRY(0)=0`Total pairs (SUBTYPE,STATUS)
 ;   MAGRY(1)="SUBTYPE`STATUS`COUNT"
 N SSEP,CNT,SUBVAL,STATVAL
 S SSEP=$$STATSEP^MAGVIM01
 K MAGRY
 S MAGRY(1)="SUBTYPE`STATUS`COUNT"
 S CNT=1
 S (SUBVAL,STATVAL)=""
 F  S SUBVAL=$O(TOTAL(SUBVAL)) Q:SUBVAL=""  D
 . F  S STATVAL=$O(TOTAL(SUBVAL,STATVAL)) Q:STATVAL=""  D
 . . S CNT=CNT+1,MAGRY(CNT)=SUBVAL_SSEP_STATVAL_SSEP_TOTAL(SUBVAL,STATVAL)
 . . Q
 . Q
 S MAGRY(0)=0_SSEP_(CNT-1)
 Q
