BPSRSEV ;BHAM ISC/SS - ECME RESEARCH SCREEN EVENT LOG ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
EVNT ;
 ;entry point for VE View Eligibility menu option of the main User Screen
 N BPRET,BPSEL,BPMODE,BPRXIEN,BPPAT
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 ;
 W !,"Please select a SINGLE Patient Line item or a SINGLE Rx Line item when accessing the IB Events Report"
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","PC","Please select SINGLE patient summary or SINGLE RX line.")
 I BPSEL<1 S VALMBCK="R" Q
 S BPPAT=+$P(BPSEL,U,2)
 I BPPAT=0 W !,"Invalid Patient Internal Number." D QUIT Q
 ;
 S BPMODE=$S($P(BPSEL,U,7)>0:"R",1:"P")
 ;
 I BPMODE="P" D  D QUIT Q
 . D USRSCREN^IBNCPDPE("P",BPPAT)
 ;
 S BPRXIEN=+$$RXREF^BPSSCRU2(+$P(BPSEL,U,4))
 I BPRXIEN=0 S VALMBCK="R" Q
 ;
 I BPMODE="R" D  D QUIT Q
 . D USRSCREN^IBNCPDPE("R",BPRXIEN)
 ;
 D QUIT
 Q
 ;
QUIT ;
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
