MAGDQR10 ;WOIFO/MLH - Accession # search logic for C-FIND ; 30 Dec 2011 04:32 PM
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
ACCSID(P,REQ,RESULT,MAGDUZ,PAT,SSN,UID,FD,LD) ; Return from accession no. / study ID query - called from MAGDQR02
 N TYPE,IMAGE,IARRAY,MAGD0,MAGD1,MAGD2,ACCNUM,STUDYIX,SERIESIX,SOPIX
 S TYPE=$P(P,"^",1)
 D  ; switch - build image / group array for old Rad, old Consult or new DB?
 . I TYPE="R" D ACCSIDRA^MAGDQR11(.IARRAY,P,PAT,SSN,UID,.MAGD0,.MAGD1,.MAGD2) Q  ; Radiology Images (old DB structure) case
 . I TYPE="C" D  Q  ; Consult Images (old DB structure) case
 . . ; P = C ^ DFN ^ File# ^ IEN ^ Image# ^ Accession#
 . . S IMAGE=$P(P,"^",5) Q:'IMAGE  S IARRAY(IMAGE)=""
 . . S MAGD0=+$P($G(^MAG(2005,+IMAGE,0)),"^",7)
 . . S (MAGD1,MAGD2)=0 ; Not a radiology study...
 . . S ACCNUM=$P(P,"^",6)
 . . Q
 . I TYPE="N" D  Q  ; New database structure case
 . . S STUDYIX=$P(P,"^",3),MAGD0=$P(P,"^",2)
 . . S SERIESIX=""
 . . F  S SERIESIX=$O(^MAGV(2005.63,"C",STUDYIX,SERIESIX)) Q:'SERIESIX  D  Q:$D(IARRAY)  ; only study level for now
 . . . S SOPIX=""
 . . . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIESIX,SOPIX)) Q:'SOPIX  S IARRAY(SOPIX)=STUDYIX Q  ; only study level for now
 . . . Q
 . . S (MAGD1,MAGD2)=0 ; Not a radiology study in the old structure...
 . . Q
 . Q
 S IMAGE=""
 F  S IMAGE=$O(IARRAY(IMAGE)) Q:'IMAGE  D
 . D RESULT^MAGDQR03(TYPE,.REQ,RESULT,IMAGE,MAGDUZ,MAGD0,MAGD1,MAGD2)
 . Q
 Q
