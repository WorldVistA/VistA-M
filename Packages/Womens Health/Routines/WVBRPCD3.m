WVBRPCD3 ;HCIOFO/FT,JR IHS/ANMC/MWR - BROWSE PROCEDURES; ;8/10/98  16:12
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  HELP PROMPTS FOR BROWSING PROCEDURES.  CALLED BY BRBRPCD.
 ;
HELP1 ;EP
 ;;Procedures with a result of "ABNORMAL" require further follow-up
 ;;and diagnosis.  Procedures with a result of "NORMAL" require a
 ;;letter of notification to be sent to the patient.
 ;;
 ;;Enter "A" to see only Procedures with ABNORMAL results.
 ;;   (Selecting ABNORMAL will include procedures with a result of
 ;;    INSUFFICIENT TISSUE and procedures with no result entered yet.)
 ;;
 ;;Enter "B" to see BOTH ABNORMAL and NORMAL results.
 ;;  (Selecting NORMAL will include procedures with a result of
 ;;   ERROR/DISREGARD.)
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
HELP2 ;EP
 ;;Answer "ONE" to browse Procedures for ONE particular patient.
 ;;Answer "ALL" to browse Procedures for ALL patients.
 S WVTAB=5,WVLINL="HELP2" D HELPTX
 Q
 ;
HELP3 ;EP
 ;;Enter "DATE" to list Procedures in chronological order beginning
 ;;   with the oldest first.
 ;;Enter "NAME" to list Procedures by Patient Name in alphabetical
 ;;   order.
 ;;Enter "PRIORITY" to list Procedures by degree of urgency of the 
 ;;   Result/Diagnosis, beginning with the most urgent first.
 S WVTAB=5,WVLINL="HELP3" D HELPTX
 Q
 ;
HELP4 ;EP
 ;;"DELINQUENT Procedures" are OPEN Procedures that have remained
 ;;     open past the date they were due to be closed (as determined by
 ;;     the "COMPLETE BY (DATE)" field in the Edit Procedure screen).
 ;;
 ;;"OPEN Procedures" are any Procedures that have not yet been closed.
 ;;     (DELINQUENT and NEW Procedures will be included.)
 ;;
 ;;"ALL Procedures" includes DELINQUENT, NEW, OPEN and CLOSED.
 ;;     CLOSED Procedures are ones that have been brought to closure;
 ;;     in other words, a final diagnosis has been entered, the
 ;;     procedure has been completed, and the patient has been notified.
 S WVTAB=5,WVLINL="HELP4" D HELPTX
 Q
 ;
HELP5 ;EP
 ;;Answer "ONE" to browse Procedures for ONE particular Case Manager.
 ;;Answer "ALL" to browse Procedures for ALL Case Managers.
 S WVTAB=5,WVLINL="HELP5" D HELPTX
 Q
 ;
HELPTX ;EP
 ;---> CREATES DIR ARRAY FOR DIR.  REQUIRED VARIABLES: WVTAB,WVLINL.
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
