RGPDPST ;SF/CMC,PTD-CIRN build post-init ;11/24/98
 ;;1.0; CLINICAL INFO RESOURCE NETWORK ;;30 Apr 99
PD ;Post-init called by CIRN PD - updating facility in the HL7 application parameter file
 N SITE,DIE,X,Y,DR,DIC,DA
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3),SITE=SITE\1
 ; ^ SITE is Station Number of site doing install
 S DIC="^HL(771,",DIC(0)="XQZ",X="RG CIRN"
 D ^DIC
 Q:+Y<0
 S DA=+Y
 S DIE="^HL(771,",DR="3///^S X=SITE"
 D ^DIE
 K SITE,DIC,X,Y,DA,DIE,DR
 Q
 ;
MC ;Post-init called by Messaging Components - updating facility in the HL7 application parameter file
 N SITE,DIE,X,Y,DR,ENT,DIC,DA,I
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3),SITE=SITE\1
 ; ^ SITE is Station Number of site doing install
 S DIC="^HL(771,",DIC(0)="XQZ",X="RG SUBSCRIPTION"
 D ^DIC
 Q:+Y<0
 S DA=+Y
 S DIE="^HL(771,",DR="3///^S X=SITE"
 D ^DIE
 K SITE,DIC,X,Y,DA,DIE,DR
 Q
 ;
