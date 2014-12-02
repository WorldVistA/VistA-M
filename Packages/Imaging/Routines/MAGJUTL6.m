MAGJUTL6 ;WOIFO/JHC,NST - Imaging Utility for getting Radiology Printset; 14 Mar 2013 2:45 PM
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
DAYCASE(RADFN,RADTI,RACNI) ; return Acn # (or  "^" delimited list of for PRINTSET) for exam
 ; RADFN,RADTI,RACNI -- Pointers to Rad Exam
 N ACNLIST,DAYCASE,I,LONGACN,PSET,RACN,RACNE,RADTE,RAPRTSET,X
 S DAYCASE=""
 I $G(RADFN),$G(RADTI),$G(RACNI) D
 . S X=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ; ICR 65
 . Q:X=""
 . S RACN=$P(X,U)  ; Case Number
 . S LONGACN=$P(X,U,31)  ; Site Accesion Number
 . S RADTE=9999999.9999-RADTI
 . ; use site accesion number if it is defined or create the short one
 . S DAYCASE=$S(LONGACN]"":LONGACN,1:$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_RACN)
 S ACNLIST=DAYCASE
 I DAYCASE]"" D
 . D EN2^RAUTL20(.PSET) ; get info re rad PrintSet
 . Q:'RAPRTSET
 . S RACNE=$S(LONGACN]"":DAYCASE,1:$P(DAYCASE,"-",2)) ; SSAN/OLDACN
 . S X="",ACNLIST=""
 . F  S X=$O(PSET(X)) Q:'X  S:RACNE'=$P(PSET(X),U) ACNLIST=ACNLIST_U_$P(PSET(X),U)
 . I LONGACN="" F I=2:1:$L(ACNLIST,U) S X=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_$P(ACNLIST,U,I),$P(ACNLIST,U,I)=X
 . S ACNLIST=DAYCASE_ACNLIST
 Q ACNLIST
 ;
DAYCASE2(ACCN) ; return Acn # (or "^" delimited list of for PRINTSET) for exam
 ; ACCN -- Radiology Accession Number
 N ACNLIST,RAA,X,Y
 N RADFN,RADTI,RACNI
 ;
 S ACNLIST=""
 S X=$$ACCFIND^RAAPI(ACCN,.RAA) ; Private IA (#5020)
 I X>0 D  ; accession number found
 . ; For a given accession number, there will never be more than one set of values
 . ; for RADFN/RADTI/RACNI in RAA array
 . S Y=RAA(1)
 . S RADFN=$P(Y,"^",1),RADTI=$P(Y,"^",2),RACNI=$P(Y,"^",3)
 . S ACNLIST=$$DAYCASE^MAGJUTL6(RADFN,RADTI,RACNI)  ; get all accession numbers
 . Q
 Q ACNLIST
