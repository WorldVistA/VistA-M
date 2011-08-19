BPSSCRDV ;BHAM ISC/SS - ECME SCREEN DEVELOPER LOG ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
DV ;entry point for LOG menu option of the main User Screen
 N BPRET,BPSEL
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Enter the line number for which you wish to print claim logs."
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","C","Please select SINGLE Rx Line.")
 I BPSEL<1 S VALMBCK="R" Q
 D CLAIMLOG^BPSOS6M(+$P(BPSEL,U,4))
 S VALMBCK="R"
 Q
 ;
