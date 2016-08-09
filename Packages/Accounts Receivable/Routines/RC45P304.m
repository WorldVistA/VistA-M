RC45P304 ;ALB/SAB - POST-INSTALL PRCA*4.5*304 ;02-APR-15
 ;;4.5;Accounts Receivable;**304**;Mar 20, 1995;Build 104
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
POST ;This will rename two options and Reindex 344.4 for the updated indexes
 ;
 D BMES^XPDUTL(" Post-install for PRCA*4.5*304 Starting.")
 ;
 ; Updating AR parameter file
 D MES^XPDUTL("      >> Updating parameters in the AR SITE PARAMETER file (#342) ...")
 ;
 D UPD342   ; Update the AR Site Parameter file with the correct starting values.
 ;
 ; Updating EDI Parameter file
 D MES^XPDUTL("      >> Updating parameters in the RCDPE PARAMETER file (#344.61) ...")
 ;
 D UPD34461 ; Update the RCDPE Parameter file with the correct starting values.
 ;
 D BMES^XPDUTL(" Post-install for PRCA*4.5*304 Complete.")
 ;
 Q
 ;
UPD342 ;
 ;
 N X,Y,DIE,DA,DR,DTOUT,DATA
 ;
 S DR=""
 S DATA=$G(^RC(342,1,7))
 S:$P(DATA,U,4)="" DR=DR_"7.04////45;"
 S:$P(DATA,U,4)="" DR=DR_"7.05////N;"
 S:$P(DATA,U,4)="" DR=DR_"7.06////N"
 Q:DR=""
 S DIE="^RC(342,",DA=1
 D ^DIE
 Q
 ;
UPD34461 ;
 ;
 N X,Y,DIE,DA,DR,DTOUT,DATA
 S DR=""
 S DATA=$G(^RCY(344.61,1,1))
 S:$P(DATA,U,1)="" DR=DR_"1.01////N;"
 S:$P(DATA,U,2)="" DR=DR_"1.02////N"
 ;
 Q:DR=""
 ;
 S DIE="^RCY(344.61,",DA=1
 D ^DIE
 Q
 ;
