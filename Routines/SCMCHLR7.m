SCMCHLR7 ;ALB/KCL - PCMM HL7 Error Code Report ;09-FEB-2000
 ;;5.3;Scheduling;**210**;AUG 13, 1993
 ;
ECRPRT ; Description: This entry point is used to print the PCMM HL7 Error
 ; Code Report.  This report is based on entries in the PCMM HL7
 ; ERROR CODE (#404.472) file and uses the FileMan EN1^DIP API for
 ; printing the report.
 ;
 ;  Input: None
 ; Output: None
 ;
 N BY,DHD,DIC,FLDS,FR,L,TO,%ZIS
 ;
 ;Required input for EN1^DIP call
 S DIC="^SCPT(404.472,"
 S L=0
 S BY=".01"  ; Sort criteria (BY ERROR CODE)
 S FR=""
 S TO=""
 ;
 ;Fields to be printed (in order listed)
 S FLDS=".01,.03,10"
 ;
 ;Report header
 S DHD="PCMM Transmission Error Code Report"
 ;
 ;Print report
 S %ZIS="QM"
 D EN1^DIP
 ;
 Q
