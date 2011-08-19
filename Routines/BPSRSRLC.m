BPSRSRLC ;BHAM ISC/SS - ECME RESEARCH SCREEN RELEASE COPAY ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
RH ;
 N BPRET,BPSEL,DFN,BPRXRF
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Patient Line item or a SINGLE Rx Line item when accessing Release Copay from Hold."
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","PC","Please select a SINGLE Patient Line item or a SINGLE Rx Line item")
 I BPSEL<1 S VALMBCK="R" Q
 S DFN=+$P(BPSEL,U,2)
 I DFN=0 S VALMBCK="R" Q
 I +$P(BPSEL,U,7)>0 D
 . ;RX was selected
 . S BPRXRF=$$RXREF^BPSSCRU2(+$P(BPSEL,U,4))
 . I BPRXRF'>0 Q
 . D RELH^IBNCPDPR(DFN,+$P(BPRXRF,U),+$P(BPRXRF,U,2),"C")
 I +$P(BPSEL,U,7)=0 D
 . ;patient was selected
 . D RELH^IBNCPDPR(DFN,0,0,"P")
 D QUIT
 Q
 ;
QUIT ;
 S VALMBCK="R"
 Q
 ;
