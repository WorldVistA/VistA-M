BPSCT ;BHAM ISC/SS - ECME CT EDIT SCREEN ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;USER SCREEN
 Q
CT ;to run from research menu
 N BPRET,BPSEL,BP59,BPREFIL
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Rx Line item when accessing Claims Tracking."
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","C","Please select SINGLE RX line.")
 I BPSEL<1 S VALMBCK="R" Q
 N DFN,BPECMEN,IEN356
 S DFN=+$P(BPSEL,U,2)
 S BP59=+$P(BPSEL,U,4)
 S BPREFIL=$P($$RXREF^BPSSCRU2(BP59),U,2)
 S BPECMEN=$$ECMENUM^BPSSCRU2(BP59) ;ECME number
 D CT^IBNCPDPC(DFN,BPECMEN,BPREFIL)
 S VALMBCK="R"
 Q
 ;
