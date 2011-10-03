BPSRSPRS ;BHAM ISC/SS - ECME RESEARCH SCREEN PRESCRIPTION VIEW ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
VP ;
 ;entry point for VP View Prescription menu option of the main User Screen
 N BPRET,BPSEL,BPRXIEN,DA,PSOVDA,PS
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Rx Line item for viewing a Prescription"
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","C","Please select SINGLE RX line.")
 I BPSEL<1 S VALMBCK="R" Q
 S BPRXIEN=+$$RXREF^BPSSCRU2(+$P(BPSEL,U,4))
 I BPRXIEN=0 S VALMBCK="R" Q
 S PS=""
 S (DA,PSOVDA)=BPRXIEN D DP^PSORXVW
 S VALMBCK="R"
 Q
 ;
