DGPFRDB ;SHRPE/SGM - DBRS HISTORY REPORT ; Aug 07, 2018 09:45
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;     Last Edited: SHRPE/SGM - Aug 17,2018 10:16
 ;
 ; ICR# TYPE DESCRIIPTION
 ;----- ---- ----------------------------
 ; 1519 Sup  EN^XUTMDEVQ
 ;10006 Sup  ^DIC
 ;10086 Sup  HOME^%ZIS
 ;      Sup  $$FMTE^XLFDT
 ;
 QUIT
 ;
 ; 1. Select one Category I Behavioral flag assignment
 ; 2. Enter starting and ending dates.  These dates will be checked
 ;    against the DATE/TIME field in file 26.14
 ;
EN ;Entry point
 N X,Y,DGSRC,ZTSAVE,ZTREQ,ZTSK
 ;
 ;--- select a patient, behavioral flag assignment
 S X=$$SELASGN^DGPFUT6("BEH","Z") Q:X<1
 S DGSRC("ASGN")=+X
 S DGSRC("DFN")=$P(X,U,2)
 ;
 ;--- select beginning date
 W ! S X=$$DATEBEG Q:X<1
 ;
 ;--- select end date
 Q:$$DATEEND<1
 ;
 ;--- prompt for device
 S ZTSAVE("DGSRC(")=""
 S X="PRF DBRS Numbers Report"
 D EN^XUTMDEVQ("START^DGPFRDB1",X,.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
 ;------------------------ PRIVATE SUBROUTINES ------------------------
 ;
DATEBEG() ;-- prompt for beginning date
 N X,Y,DGDIRA,DGDIRB
 S DGDIRA="Select Beginning Date"
 S DGDIRB=""
 S DGDIRO="DO"
 S X=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO)
 I X>0 S DGSRC("BEG")=X
 Q X>0
 ;
DATEEND() ;-- prompt for ending date
 N X,Y,DGDIRA,DGDIRB,DGDIRO
 S Y=$$FMTE(DGSRC("BEG"))_" - "_$$FMTE(DT)
 S DGDIRA="Select Ending Date ("_Y_"): "
 S DGDIRB=$$FMTE(DT,"1Z")
 S DGDIRO="DOA^"_DGSRC("BEG")_":DT:EX"
 S X=$$ANSWER^DGPFUT(DGDIRA,DGDIRB,DGDIRO)
 I X>0 S DGSRC("END")=X
 Q X>0
 ;
FMTE(DATE,FMT) ;
 S:$G(FMT)="" FMT="2Z"
 Q $$FMTE^XLFDT(DATE,FMT)
 ;
 ; **** REPORT FORMAT ****
 ;         1         2         3         4         5         6         7         8
 ;12345678901234567890123456789012345678901234567890123456789012345678901234567890
 ;BEHAVIORAL PRF DISRUPTIVE BEHAVIOR DATA REPORT                         Page: 1
 ;Patient: [-----patient name-----------] (6890)        Dates: 01/01/18 - 03/09/18
 ;================================================================================
 ;
 ;   DBRS Number        Date    DBRS Other Information
 ;------------------  --------  --------------------------------------------------
 ;294AC Batavia NY VAMC              03/07/18    Rupert, Connie
 ;------------------  --------  --------------------------------------------------
 ;294AC.484744        03/07/18  Secondary DBRS Case opened for Patient.
 ;345.484744          03/07/18  Patient threatened clinician at outpatient appointm
 ;                              ent.  DBRS case opened.
 ;673AA.180320        02/12/18  Patient admitted and was belligerent and said he wou
 ;                              Ld like to talk with doctor.
 ;673AB.180310        02/12/18  Patient first came to 673AB
 ;_______________________________________________________________________________
