BPSRSHLD ;BHAM ISC/SS - ECME RESEARCH SCREEN ON HOLD ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
OH ;
 ;
 N BPRET,BPSEL
 N IBIBRX
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Patient Line item when accessing the On Hold Copay Listing"
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","P","Please select SINGLE patient summary line.")
 I BPSEL<1 S VALMBCK="R" Q
 N DFN
 S DFN=+$P(BPSEL,U,2)
 D ONHOLD^IBNCPDPH(DFN)
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
 ;
