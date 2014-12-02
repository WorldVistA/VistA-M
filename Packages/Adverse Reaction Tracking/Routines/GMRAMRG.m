GMRAMRG ;ALB/RDK - GMRA*4.0*43; PRE MERGE ALLERGY VALIDATION ; 4/25/13 12:04pm
 ;;4.0;Adverse Reaction Tracking;**43**;Mar 29, 1996;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN(GMRAINPT) ; Entry point
 ; Called during patient (file #2) merge due to AFFECTS RECORD MERGE
 ;   in PACKAGE (#9.4) file.
 ; Input
 ;   GMRAINPT - name of array with the PATIENT (#2) From IENs and To IENs
 ;           format: name(ien_from,ien_to,"ien_from;DPT(","ien_to;DPT(")
 ;           example: TEST(1000,500,"1000;DPT(","500;DPT(")=""
 ;
 N GMRAFR,GMRATO,GMRAYES,GMRACHKF,GMRACHKT
 ; loop thru from ien of patients (file #2) being merged
 S GMRAFR=0 F  S GMRAFR=$O(@GMRAINPT@(GMRAFR)) Q:GMRAFR'>0  D
 . S GMRATO=$O(@GMRAINPT@(GMRAFR,0)) ; to ien
 . ; check to see if a patient has allergies and the flag is set
 . D ASSESS
 Q
 ;
ASSESS ; File 120.86 ADVERSE REACTION ASSESSMENT - 
 ;   The .01 field points to and is dinumed with the PATIENT (#2) file
 ; 
 ;   GMRAFR - ien of patient (files #2,120.86) being merged from
 ;   GMRATO - ien of patient (files #2,120.86) being merged to
 ;
 ;  if merge FROM or TO has allergies, set the TO assessment to
 ;  'has allergies' and quit
 S GMRACHKF=$$NKASCR^GMRANKA(GMRAFR),GMRACHKT=$$NKASCR^GMRANKA(GMRATO)
 I 'GMRACHKF!('GMRACHKT) S $P(^GMR(120.86,GMRATO,0),U,2)=1 Q
 ;
 ;  if merge FROM or TO does not have allergies and if either has an
 ;  assessment of 'NKA', set TO assessment to NKA and quit
 S GMRAYES=0
 I GMRACHKF,($P($G(^GMR(120.86,GMRAFR,0)),U,2)=1) S GMRAYES=1
 I GMRACHKT,($P($G(^GMR(120.86,GMRATO,0)),U,2)=1) S GMRAYES=1
 I GMRAYES S $P(^GMR(120.86,GMRATO,0),U,2)=1 Q
 ;
 ; if it falls through here, the patient doesn't have allergies and no
 ; assessment was set we will not alter any of this since an assessment
 ;  has not been performed
 Q
