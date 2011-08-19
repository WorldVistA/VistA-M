BPSRSELG ;BHAM ISC/SS - ECME RESEARCH SCREEN ELIGIBILITY VIEW ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
VE ;
 ; -- main entry point for BPS LSTMN RSCH ELIGIBILITY
 ;entry point for VE View Eligibility menu option of the main User Screen
 N BPRET,BPSEL,BPDFN
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Patient Line item for viewing Eligibility"
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","P","Please select SINGLE patient summary line.")
 I BPSEL<1 S VALMBCK="R" Q
 S BPDFN=+$P(BPSEL,U,2)
 D EN1^IBNCPDPL(BPDFN)
 S VALMBCK="R"
 Q
 ;
 ;
