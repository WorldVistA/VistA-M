MAGNDCMC ;WOIFO/NST - Imaging Capture DICOM utilities  ; 09 Oct 2010 3:52 AM
 ;;3.0;IMAGING;**106**;Mar 19, 2002;Build 2002;Feb 28, 2011
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
 ;***** Returns all records in IMAGING DICOM FIELDS file (#2005.71)
 ;      per SOP type  (e.g. "TELEDERM")
 ; RPC: MAG3 DICOM CAPTURE GE LIST
 ;
 ; Input Parameters
 ; ================
 ;  MAGSOP = SOP type (e.g. "TELEDERM")
 ;  
 ; Return Values
 ; =============
 ; if error found during execution
 ;   MAGRY(0) = "0^Error"
 ; if success
 ;   MAGRY(0)    = "1^#CNT" - where #CNT is a number of records returned
 ;   MAGRY(1)    = "MODULE^ELEMENT^ELEMENT NAME^VALUE MULTIPLICITY^VALUE REPRESENTATION^GUI CONTROL"
 ;   MAGRY(2..n) = "^" delimited string with values of fields listed in MAGRY(1) 
 ;
GGELIST(MAGRY,MAGSOP)  ;RPC [MAG3 DICOM CAPTURE GE LIST]
 N OUT,OUT1,CNT,DA0,DA1,MODULE
 N X,I,J,ERR,CNT
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 ;
 S MAGRY(0)="0^Error"
 S MAGRY(1)="MODULE^ELEMENT^ELEMENT NAME^VALUE MULTIPLICITY^VALUE REPRESENTATION^GUI CONTROL"
 S CNT=1
 S DA0=$$FIND1^DIC(2005.71,"","X",MAGSOP,"","","ERR") ; Find "SOP type" IEN
 I DA0=0 S MAGRY(0)="1^"_(CNT-1) Q  ; nothing found
 I $D(ERR) Q  ; Error
 D LIST^DIC(2005.712,","_DA0_",",";@;.01","P","*","","","#","","","OUT","OUT") ; Get all modules 
 S I=0
 F  S I=$O(OUT("DILIST",I)) Q:I=""  D
 . S X=OUT("DILIST",I,0)
 . S DA1=$P(X,"^",1),MODULE=$P(X,"^",2) D
 . K OUT1
 . D LIST^DIC(2005.713,","_DA1_","_DA0_",",";@;.01;2;3;4;5I","P","*","","","#","","","OUT1","OUT1") ; Get all elements 
 . S J=0
 . F  S J=$O(OUT1("DILIST",J)) Q:J=""  D
 . . S X=OUT1("DILIST",J,0)
 . . S CNT=CNT+1
 . . S MAGRY(CNT)=MODULE_"^"_$P(X,"^",2,6)
 . . Q
 . Q
 S MAGRY(0)="1^"_(CNT-1)
 Q
 ;
 ;***** Returns SOP CLASS UID per SOP type  (e.g. "TELEDERM")
 ;
 ; RPC: MAG3 DICOM CAPTURE SOP CLASS
 ;
 ; Input Parameters
 ; ================
 ;  MAGSOP = SOP type (e.g. "TELEDERM")
 ;  
 ; Return Values
 ; =============
 ; If error found during execution
 ;   MAGRY(0) = "0^Error Message"
 ; If success
 ;   MAGRY(0)    = "1^IEN^SOP CLASS UID
 ;     where IEN is the IEN of the SOP CLASS UID in DICOM SOP CLASS file (#2006.532)
 ;
GSOPCLAS(MAGRY,MAGSOP)  ;RPC [MAG3 DICOM CAPTURE SOP CLASS]
 N IEN,SOPCLASS
 I MAGSOP="TELEDERM" D  Q
 . ; SOP CLASS should come from IMAGING DICOM FIELDS file (#2005.71)
 . ; SOP CLASS field should be added to (#2005.71)
 . S SOPCLASS="1.2.840.10008.5.1.4.1.1.77.1.4"   ; VL Photographic Image Storage
 . S IEN=$$FIND1^DIC(2006.532,"","BX",SOPCLASS)
 . I IEN'>0 S MAGRY="0^Error getting SOP CLASS UID IEN" Q
 . S MAGRY="1^"_IEN_"^"_SOPCLASS
 . Q
 S MAGRY="0^Error SOP type is not found"
 Q
