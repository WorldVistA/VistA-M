MPIFPST ;CMC/SF-MPI VISTA build post-init ;DEC 12, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;;30 Apr 99
 ;
EN ;
 D MAIL
 D MAIL2
 D HL7SITE
 D CHECKMPI
 D REMOVE
 Q
REMOVE ;
 S $P(^RGSITE(991.8,1,1),"^",2)=""
 S DIK="^RGSITE(991.8,",DA=36,DA(1)=991.8
 D ^DIK
 K DIK,DA
 Q
 ;
CHECKMPI ; checking to see if MPI Institition is defined
 N DIC,DA,DIE,DR,X,Y
 S DIC="^DIC(4,",DIC(0)="XZ",X="MPI"
 D ^DIC
 I +Y<0 D BMES^XPDUTL("Missing MPI in Institution file, need to update before proceeding.")
 Q
MAIL2 ;add mail group to 991.8
 N DIC,GROUP,DIC,DA,DIE,DR,X,Y
 S DIC="^XMB(3.8,",DIC(0)="XQZ",X="MPIF CMOR REQUEST"
 D ^DIC
 Q:+Y<0
 S GROUP=+Y
 S DA=1,DIE="^RGSITE(991.8,",DR=".03///^S X=GROUP" D ^DIE
 D BMES^XPDUTL("Adding MPIF CMOR REQUEST mailgroup to file 991.8")
 Q
 ;add mail group to exception file
MAIL ;
 N DIC,GROUP,DIC,DA,DIE,X,Y,DR,ENT
 S DIC="^XMB(3.8,",DIC(0)="XQZ",X="MPIF EXCEPTIONS"
 D ^DIC
 Q:+Y<0
 S GROUP=+Y
 F ENT=200:1:208,210:1:212,220:1:222,224 D
 .S DIC="^RGHL7(991.11,",DIC(0)="XQZ",X=ENT
 .D ^DIC
 .Q:+Y<0
 .S DA=+Y,DIE="^RGHL7(991.11,",DR="6///^S X=GROUP"
 .D ^DIE
 Q
 ;
HL7SITE ;updating Facility in the MPIF-Startup HL7 Application Parameter file
 N SITE,DIE,X,Y,DR,ENT,DIC,DA,I
 S SITE=$$SITE^VASITE,SITE=$P(SITE,"^",3),SITE=SITE\1
 ; ^ SITE is Station Number of site doing install
 F I="MPIF-STARTUP","MPIF CMOR RSLT","MPIF CMOR COMP","MPIF A29 SERVER","MPIF A30 SERVER","MPIF MPI","MPIF LOC/MIS" D
 . S DIC="^HL(771,",DIC(0)="XQZ",X=I
 . D ^DIC
 . Q:+Y<0
 . S DA=+Y
 . S DIE="^HL(771,",DR="3///^S X=SITE"
 . D ^DIE
 Q
 ;
