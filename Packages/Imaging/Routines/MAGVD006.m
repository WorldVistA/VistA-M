MAGVD006 ;WOIFO/NST,MLH - Imaging functions for Query/Retrieve ; 03 Feb 2012 9:14 AM
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
ACCIEN(P,REQ,IARRAY,MAGD0,MAGD1,MAGD2,PROC)  ; Function to get IEN & procedure description of all images for an accession #
 ; Uses entries from "6" queue built by ACCNUM^MAGDQR07
 N TYPE
 S TYPE=$P(P,"^",1) Q:"^R^C^N^"'[("^"_TYPE_"^")  ; entry from "6" queue
 ; switch - build image / group array for old Rad, old Consult or new DB?
 D @($S(TYPE="R":"ACCOLD",TYPE="C":"ACCOLD",1:"ACCNEW")_"(.IARRAY,P,.MAGD0,.MAGD1,.MAGD2,.PROC)")
 Q
ACCOLD(IARRAY,P,MAGD0,MAGD1,MAGD2,PROC) ; old Rad or old Consult
 N TYPE,IMAGE
 S TYPE=$P(P,"^",1) I TYPE'="R",TYPE'="C" Q
 D  ; switch - Radiology or Consult?
 . I TYPE="R" D  Q  ; Radiology Images (old DB structure) case
 . . D GETSTDY^MAGVD005(.IARRAY,P,.MAGD0,.MAGD1,.MAGD2,.PROC)
 . . S IMAGE=$O(IARRAY(""))
 . . Q
 . I TYPE="C" D  Q  ; Consult Images (old DB structure) case
 . . ; P = C ^ DFN ^ File# ^ IEN ^ Image# ^ Accession#
 . . S IMAGE=$P(P,"^",5) Q:'IMAGE  S IARRAY(IMAGE)=""
 . . S MAGD0=+$P($G(^MAG(2005,+IMAGE,0)),"^",7)  ; Patient
 . . S (MAGD1,MAGD2)=0 ; Not a radiology study...
 . . Q
 . Q
 S:$G(IMAGE) PROC=$P($G(^MAG(2005,IMAGE,2)),"^",4)
 Q
ACCNEW(IARRAY,P,MAGD0,MAGD1,MAGD2,PROC) ; new DB structure case
 N TYPE,STUDYIX,SERIESIX,SOPIX
 S TYPE=$P(P,"^",1)
 Q:TYPE'="N"
 S STUDYIX=$P(P,"^",3) Q:STUDYIX=""
 S MAGD0=$P(P,"^",2)  ; Patient
 S SERIESIX=""
 F  S SERIESIX=$O(^MAGV(2005.63,"C",STUDYIX,SERIESIX)) Q:'SERIESIX  D
 . S SOPIX=""
 . F  S SOPIX=$O(^MAGV(2005.64,"C",SERIESIX,SOPIX)) Q:'SOPIX  D
 . . S IARRAY(SOPIX)=STUDYIX
 . . Q
 . Q
 S (MAGD1,MAGD2)=0 ; Not a radiology study in the old structure...
 S PROC=$P($G(^MAGV(2005.62,STUDYIX,3)),"^",1)
 Q
