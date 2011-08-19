BPSRSTPJ ;BHAM ISC/SS - ECME RESEARCH SCREEN TPJI ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;DBIA2328
TPJI ;
 N BPRET,BPSEL
 I '$D(@(VALMAR)) Q
 D FULL^VALM1
 W !,"Please select a SINGLE Patient Line item when accessing TPJI"
 S BPSEL=$$ASKLINE^BPSSCRU4("Select item","P","Please select SINGLE patient summary line.")
 I BPSEL<1 S VALMBCK="R" Q
 N BPDFN
 S BPDFN=+$P(BPSEL,U,2)
 I BPDFN>0 D TPJI^IBNCPDPI(BPDFN)
 S VALMBCK="R"
 Q
 ;
