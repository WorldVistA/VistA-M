BPS34PRE ;AITC/PED - Pre-install routine for BPS*1*34 ;08/2022
 ;;1.0;E CLAIMS MGMT ENGINE;**34**;JUN 2004;Build 11
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; MCCF EDI TAS ePharmacy - BPS*1*34 patch pre-install
 ;
 Q
 ;
PRE ; Entry Point for pre-install
 ;
 D MES^XPDUTL("  Starting pre-install for BPS*1*34")
 ;
 ; Update BPS NCPDP Other Payer Amt Paid Qual in file #9002313.2
 ;
 D PDQUAL
 ;
 D MES^XPDUTL("  Finished pre-install of BPS*1*34")
 ;
 Q
 ;
PDQUAL ; Update Other Payer Amt Paid Qual
 ;
 N BPSA,BPSFN,BPSID,BPSREC
 ;
 S BPSID=$O(^BPS(9002313.2,"B",10,""))
 I BPSID="" Q
 S BPSFN=9002313.2
 S BPSREC=BPSID_","
 S BPSA(BPSFN,BPSREC,.02)="SALES TAX"
 D FILE^DIE("","BPSA","")
 ;
 Q
 ;
