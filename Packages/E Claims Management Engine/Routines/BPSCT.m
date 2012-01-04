BPSCT ;BHAM ISC/SS - ECME CT EDIT SCREEN ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,10**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to CT^IBNCPDPC supported by DBIA 4693
 ;
 Q
CT ;to run from research menu
 N BPRET,BPSEL,BP59,BPZ
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Rx Line item when accessing Claims Tracking."
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","C","Please select SINGLE RX line.")
 I BPSEL<1 S VALMBCK="R" Q
 ;
 S BP59=+$P(BPSEL,U,4)
 S BPZ=$$RXREF^BPSSCRU2(BP59)
 D CT^IBNCPDPC(+$P(BPZ,U,1),+$P(BPZ,U,2))   ; call IB with Rx ien and fill# (IA 4693)
 S VALMBCK="R"
 Q
 ;
