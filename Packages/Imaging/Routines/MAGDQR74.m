MAGDQR74 ;WOIFO/NST - Imaging Utilities for Query/Retrieve - acc# scan (new); 16 Apr 2013 1:08 PM
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
ADD1STD(ACCN,TMPQ)  ; Add one Study to temp global by accession number
 ; Input parameters
 ; ================
 ;
 ; ACCN - Accession Number
 ;
 ; Return 0 - nothing added
 ;        1 - a record was added
 ; 
 ;        TMPQ - reference to an array with studies in format
 ;        TMPQ("N^"_MAGD0_"^"_STUDYIX)=""
 ;              where MAGD0 is patient DFN
 ;                    STUDYIX is IEN in IMAGE STUDY file (#2005.62)
 ;
 N STUDYIX,MAGD0,PATREFIX,PATREFDTA,PROCIX,RESULT
 S RESULT=0
 S PROCIX=""
 F  S PROCIX=$O(^MAGV(2005.61,"B",ACCN,PROCIX)) Q:PROCIX=""  D
 . S PATREFIX=$P($G(^MAGV(2005.61,PROCIX,6)),"^",1) ; Patient Reference
 . Q:'PATREFIX  ; Quit if there is no Patient Reference
 . S PATREFDTA=$G(^MAGV(2005.6,PATREFIX,0))
 . Q:$P(PATREFDTA,"^",3)'="D"  ; Quit if it is not DFN
 . S MAGD0=$P(PATREFDTA,"^",1)  ; DFN
 . D:MAGD0'=""
 . . S STUDYIX="" F  S STUDYIX=$O(^MAGV(2005.62,"C",PROCIX,STUDYIX)) Q:'STUDYIX  D
 . . . Q:$P($G(^MAGV(2005.62,STUDYIX,5)),"^",2)="I"  ; study marked inaccessible
 . . . S @TMPQ@("N^"_MAGD0_"^"_STUDYIX)="",RESULT=1
 . . . Q
 . . Q
 . Q
 Q RESULT
 ;
ADDSTUDY(ACCN,TMPQ,TMPQACCN) ; Add all Studies to temp global by accession number
 ; Input parameters
 ; ================
 ;
 ; ACCN - Accession Number
 ;
 ; Return 0 - nothing added
 ;        1 - a record was added
 ; 
 ;        TMPQ - reference to array with studies in format
 ;          TMPQ("N^"_MAGD0_"^"_STUDYIX)=""
 ;              where MAGD0 is patient DFN
 ;                    STUDYIX is IEN in IMAGE STUDY file (#2005.62)
 ;        TMPQACCN - reference to array with accession numbers in format
 ;          TMPQACCN(V) where V is accession number
 ;
 N ACNLIST,I,RESULT,V
 S ACNLIST=$$DAYCASE2^MAGJUTL6(ACCN) ; Get Radiology accession numbers
 S:ACNLIST="" ACNLIST=ACCN  ; not a Radiology accession number
 S RESULT=0
 F I=1:1:$L(ACNLIST,U) D 
 . S V=$P(ACNLIST,U,I)  ; Accesion Number
 . S:TMPQACCN'="" @TMPQACCN@(V)=""  ; Add it to an accession numbers list
 . S:$$ADD1STD^MAGDQR74(V,TMPQ) RESULT=1
 . Q
 Q RESULT
