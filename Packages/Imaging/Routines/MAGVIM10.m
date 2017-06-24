MAGVIM10 ;WOIFO/PMK/MLS/SG/DAC/JSL/MAT - Imaging RPCs for Importer ; 30 Jul 2013  7:28 PM
 ;;3.0;IMAGING;**118,138,164**;Mar 19, 2002;Build 35;Nov 03, 2016
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
 ;***** RETURNS THE LIST OF RADIOLOGY PROCEDURES
 ; RPC: MAGV GET RADIOLOGY PROCEDURES
 ;
 ;      Modified from PROC^MAGDRPCA (RPC: MAG DICOM RADIOLOGY PROCEDURES)
 ;        for MAG*3.0*118.
 ;
 ; .ARRAY        Reference to a local variable where results
 ;               are returned to.
 ;
 ; STATIONUM     STATION NUMBER (#99) of an INSTITUTION file (#4) entry.
 ;
 ; IENMAGLOC     IEN of an entry in the IMAGING LOCATIONS file(#79.1)
 ;
 ; [IENRAPROC]   IEN of an entry in the RAD/NUC MED PROCEDURES file (#71)
 ;
 ; NOTE
 ; ====
 ;
 ;  Does not return procedure types of "B"road or "P"arent if a list is
 ;    requested (vs. a single procedure).
 ; 
 ;  The call to $$IEN^XUAF4() is Supported IA#1271.
 ;  Direct reads of ^RAMIS(71, via Private IA#1174.
 ;
GETPROCS(ARRAY,STATIONUM,IENMAGLOC,IENRAPROC) ;
 ;
 ;--- Initialize.
 N IMAGTYPE      ; IEN of the imaging type (file #79.2)
 N INACTDAT      ; Inactivation date of the procedure
 N RADPROC       ; Radiology procedure data (file #71)
 N TODAY         ; today's date in Fileman format
 N PROCTYPE      ; Type of procedure
 ;
 N IEN
 N MAGX S MAGX=""
 K ARRAY
 S (ARRAY(1),IEN)=0,TODAY=$$DT^XLFDT()
 ;
 ;--- Validate parameters
 S IENRAPROC=$G(IENRAPROC)
 ;;S STATIONUM=$G(STATIONUM)  ;;P164 took out STATIONUM, IENINST by David M (#I10555403FY16)
 ;;I (STATIONUM'>0) D  Q      ;;P164 RPC is based on the RA Imaging Location selected by the user, not the arbitrary check on Institution .vs Imaging Location Division
 ;;. S ARRAY(1)="-1,Invalid STATION NUMBER: '"_STATIONUM_"'."
 ;;. Q
 ;
 ;;--- Get IEN of INSTITUTION file (#4) from STATION NUMBER (Supported IA# 2171).
 ;;N IENINST S IENINST=$$IEN^XUAF4(STATIONUM)  ;P164 took out STATIONUM, IENINST
 ;;
 ;;I IENINST=""  D  Q
 ;;. S ARRAY(1)="-2,Could not resolve Institution from STATION NUMBER '"_STATIONUM_"'."
 ;;. Q
 ;
 ;--- Output a single RAD/NUC MED PROCEDURE file (#71) entry.
 I IENRAPROC'="" S IEN=IENRAPROC D
 . S RADPROC=^RAMIS(71,IEN,0),IMAGTYPE=+$P(RADPROC,U,12)
 . S MAGX=$O(^RA(79.1,"BIMG",IMAGTYPE,""))
 . Q:MAGX=""
 . D OUTPUT(MAGX)
 . Q
 ;--- Loop through the RAD/NUC MED PROCEDURES file (#71).
 E  D
 . F  S IEN=$O(^RAMIS(71,IEN))  Q:'IEN  D CHEKINST
 . Q
 Q
 ;
 ;+++++ Internal entry point: Validate a procedures' institution matches.
 ;
CHEKINST ;
 S RADPROC=^RAMIS(71,IEN,0),IMAGTYPE=+$P(RADPROC,U,12)
 ;
 ;--- Select by input IMAGING LOCATION (#79.1).
 N MAGXX,MATCH S (MAGXX,MATCH)=0
 F  S MAGXX=$O(^RA(79.1,"BIMG",IMAGTYPE,MAGXX)) Q:MAGXX=""  Q:MATCH>0  D
 . ;
 . ;--- Resolve HOSPITAL LOCATION file IEN from IMAGING LOCATION.
 . N IENHSPLOC S IENHSPLOC=$$GET1^DIQ(79.1,MAGXX,.01,"I")
 . ;
 . ;--- Resolve the INSTITUTION file (#4) IEN.
 . N IENINSPRC S IENINSPRC=$$GET1^DIQ(44,IENHSPLOC,3,"I")
 . ;
 . ;--- Quit if not in the same INSTITUTION.
 . ;;Q:IENINSPRC'=IENINST     ;;p164 David M took out IENINST
 . S:MAGXX=IENMAGLOC MATCH=MATCH+1,MAGX=MAGXX
 . Q
 Q:MATCH=0  D OUTPUT(MAGX)
 Q
 ;
 ;+++++ Internal entry point: Assemble output for one record.
 ;
OUTPUT(MAGX) ;
 N BUF S BUF=$P(RADPROC,U)_U_IEN  ; Procedure Name and IEN
 S PROCTYPE=$P(RADPROC,U,6)       ; Type of Procedure
 ;
 ;--- Iff list output (LOCATION was input), filter out 'B'road, 'P'arent.
 N FILTER S FILTER=$S(IENMAGLOC'="":1,1:0)
 I FILTER=1,(PROCTYPE="B")!(PROCTYPE="P") Q
 S $P(BUF,U,3)=PROCTYPE         ; Type of Procedure
 S $P(BUF,U,4)=$P(RADPROC,U,9)  ; CPT Code (file #81)
 S $P(BUF,U,5)=IMAGTYPE         ; Type of Imaging (file #79.2)
 S INACTDAT=$P($G(^RAMIS(71,IEN,"I")),U)
 I INACTDAT,INACTDAT<TODAY Q    ; ignore inactive procedures
 S $P(BUF,U,6)=INACTDAT         ; Inactivation Date
 S $P(BUF,U,7)=$S(IENMAGLOC="":MAGX,1:IENMAGLOC) ; Imaging Location (file #79.1)
 ;
 ;--- Resolve HOSPITAL LOCATION file IEN from IMAGING LOCATION.
 N IENHSPLOC S IENHSPLOC=$$GET1^DIQ(79.1,MAGX,.01,"I")
 S $P(BUF,U,8)=IENHSPLOC                    ; Hospital Location file (#44) - IEN
 S $P(BUF,U,9)=$$GET1^DIQ(44,IENHSPLOC,.01) ; Hospital Location file (#44) - NAME
 ;
 ;--- Add the descriptor to the result array
 S ARRAY(1)=ARRAY(1)+1,ARRAY(ARRAY(1)+1)=BUF
 Q
 ;
 ; MAGVIM10
