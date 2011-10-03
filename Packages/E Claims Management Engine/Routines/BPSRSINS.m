BPSRSINS ;BHAM ISC/SS - ECME RESEARCH SCREEN INSURANCE VIEW ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
VI ;
 ;entry point for VI View Insurance menu option of the main User Screen
 N BPRET,BPSEL
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Patient Line item for viewing Insurance"
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","P","Please select SINGLE patient summary line.")
 I BPSEL<1 S VALMBCK="R" Q
 N DFN
 S DFN=+$P(BPSEL,U,2)
 D EN1^IBNCPDPI(DFN)
 S VALMBCK="R"
 Q
 ;
