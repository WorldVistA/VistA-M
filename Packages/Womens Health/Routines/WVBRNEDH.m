WVBRNEDH ;HCIOFO/FT,JR IHS/ANMC/MWR - BROWSE TX NEEDS PAST DUE;
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  HELP TEXT FOR SELECTING CRITERIA WHEN BROWSING TX NEEDS.
 ;;  CALLED BY WVBRNED.
 ;
HELP1 ;EP
 ;;Answer "YES" to include in the report those patients whose
 ;;Breast or Cervical Treatment Needs are undetermined.
 ;;Answer "NO" to report only those patients whose Breast and
 ;;Cervical Treatment Needs are known and past their due dates.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
HELP2 ;EP
 ;;Answer "DATE DELINQUENT" to display Procedures in order of
 ;;DATE DELINQUENT in other words, earliest DATE first.
 ;;Answer "PATIENT NAME" to display Procedures alphabetically by
 ;;patient name.
 S WVTAB=5,WVLINL="HELP2" D HELPTX
 Q
 ;
HELP3 ;EP
 ;;Answer "ONE" to browse Procedures for ONE particular Case Manager.
 ;;Answer "ALL" to browse Procedures for ALL Case Managers.
 S WVTAB=5,WVLINL="HELP3" D HELPTX
 Q
 ;
HELP4 ;EP
 ;;The date you select will be the date against which patients' Tx Needs
 ;;Due Dates will be checked.  If you choose a date in the future,
 ;;patients with Tx Needs past due on that future date will be included
 ;;in the report.  Choosing a future date in this report may be of help
 ;;in anticipating which patients' Tx Needs are about to become past due
 ;;before they actually become delinquent.
 S WVTAB=5,WVLINL="HELP4" D HELPTX
 Q
 ;
HELPTX ;EP
 ;---> CREATES DIR ARRAY FOR DIR.  REQUIRED VARIABLES: WVTAB,WVLINL.
 N I,T,X S T=$$REPEAT^XLFSTR(" ",WVTAB)
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
