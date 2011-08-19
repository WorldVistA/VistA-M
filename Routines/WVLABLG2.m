WVLABLG2 ;HCIOFO/FT IHS/ANMC/MWR - DISPLAY LAB LOG; ;8/19/98  15:43
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  HELP PROMPTS FOR DISPLAYING LAB LOG.  CALLED BY WVLABLG.
 ;
HELP1 ;EP
 ;;Answer "ALL" to display ALL Procedures for the selected date range.
 ;;Answer "NO" to display only those Procedures that at this time
 ;;have NO RESULTS, within the selected date range.
 S WVTAB=5,WVLINL="HELP1" D HELPTX
 Q
 ;
HELP2 ;EP
 ;;Answer "EACH" to display the data for each individual Procedure,
 ;;in other words, show date, accession#, name, chart#, provider, etc.
 ;;Answer "TOTALS" to display only the total counts, in other words,
 ;;show only the number procedures with no results and the total
 ;;number of procedures (for the selected date range).
 S WVTAB=5,WVLINL="HELP2" D HELPTX
 Q
 ;
HELP3 ;EP
 ;;Answer "ACCESSION#" to display Procedures in order of ACCESSION#,
 ;;in other words, earliest ACCESSION# first.
 ;;Answer "PATIENT NAME" to display Procedures alphabetically by
 ;;patient name.
 S WVTAB=5,WVLINL="HELP3" D HELPTX
 Q
 ;
HELPTX ;EP
 ;---> CREATES DIR ARRAY FOR DIR.  REQUIRED VARIABLES: WVTAB,WVLINL.
 N I,T,X S T="" F I=1:1:WVTAB S T=T_" "
 F I=1:1 S X=$T(@WVLINL+I) Q:X'[";;"  S DIR("?",I)=T_$P(X,";;",2)
 S DIR("?")=DIR("?",I-1) K DIR("?",I-1)
 Q
