VAFHPST2 ;ALB/JRP,PKE - KIDS PRE INSTALL ROUTINE;07-JUN-1996
 ;;5.3;Registration;**179**;AUG 13, 1993
 ;
 I $G(XPDQUES("POS1"))=1 DO
 .;  I $$PRODE^XPDUTL("VAFC HL7 INPATIENT CAPTURE","0-disable")
 .;  IF  D BMES^XPDUTL("VAFC HL7 INPATIENT CAPTURE Protocol...Disabled")
 .;
 .;  I $$PRODE^XPDUTL("VAFC HL7 OUTPATIENT CAPTURE","0-disable")
 .;  IF  D BMES^XPDUTL(" VAFC HL7 OUTPATIENT CAPTURE Protocol...Disabled")
 .;  I $$PRODE^XPDUTL("VAFC HL7 INPATIENT CAPTURE","1-enable") DO
 . DO DISABLE
 . DO UNSUB
 .;  .;  D BMES^XPDUTL(" VAFC HL7 INPATIENT CAPTURE Protocol...Enabled")
 .;  E  D BMES^XPDUTL(" VAFC HL7 INPATIENT CAPTURE Protocol was not Enabled")
 .;
 .;  I $$PRODE^XPDUTL("VAFC HL7 OUTPATIENT CAPTURE","1-enable") DO
 .;  .  D BMES^XPDUTL(" VAFC HL7 OUTPATIENT CAPTURE Protocol...Enabled")
 .;  E  D BMES^XPDUTL(" VAFC HL7 OUTPATIENT CAPTURE Protocol was not Enabled")
 ;
 I $G(XPDQUES("POS2"))=1 D STATION
 ;
 Q
 ;
DISABLE ;disable server protocols to prevent unwanted messages
 ;a04,a08 remain enabled for cirn
 N DIC,DIR,DA,DR,C,D,DI,D0,DQ,%,X,Y,DTOUT,DUOUT
 ;
 F VAFZ=1,2,3,6,7,8,9 S VAFS=$T(SPROTO+VAFZ),VAFC=$T(CPROTO+VAFZ)  DO
 . S VAFS=$P(VAFS,";",3)
 .;
 .;look up server entry
 . S DIC="^ORD(101,",DIC(0)="X"
 . S X=VAFS D ^DIC
 . I Y<1 DO  QUIT
 . . D BMES^XPDUTL(">>> "_VAFS_" entry NOT found in File #101")
 . . D BMES^XPDUTL("...  ")
 .;
 .;
 .;check if already disabled---less confusing if patch is re-run.
 . I $P($G(^ORD(101,+Y,0)),"^",3)]""
 . E  Q
 .;
 .;disable server
 . S DIE="^ORD(101,"
 . S DR="2///Disabld DG53*179, enable to activate"
 . S DA=+Y D ^DIE
 . K DA,DIE
 . D BMES^XPDUTL("> "_VAFS_" protocol was disabled")
 ;
 ;now do erroneous noww in vafh a01, vafc adt-a08-sched server
 ;look up server entry
 F VAFZ="VAFH A01","VAFC ADT-A08-SCHED SERVER" DO
 .
 . S DIC="^ORD(101,",DIC(0)="X"
 . S X=VAFZ D ^DIC
 . I Y<1 DO  QUIT
 . . D BMES^XPDUTL(">>> "_VAFZ_" entry NOT found in File #101 <<<")
 . . D BMES^XPDUTL("...  ")
 .;
 .;check if erroneous distribution
 . I $E($P($G(^ORD(101,+Y,0)),"^",3),1,4)="NOWW"
 . E  Q
 .;disable server
 . S DIE="^ORD(101,"
 . S DR="2///@"
 . S DA=+Y D ^DIE
 . K DA,DIE
 . D BMES^XPDUTL(">>> "_VAFZ_" protocol was enabled <<<")
 Q
 ;
UNSUB ;remove a04, a08 items from VAFC server protocols to unsubscribe clients
 ;CIRN has its own clients for A04, A08
 N DIC,DIK,DA,DR,C,D,DI,D0,DQ,%,X,Y,DTOUT,DUOUT
 F VAFZ=4,5 S VAFS=$T(SPROTO+VAFZ),VAFC=$T(CPROTO+VAFZ)  DO
 . S VAFS=$P(VAFS,";",3),VAFC=$P(VAFC,";",3)
 .;look up server entry
 . S DIC="^ORD(101,",DIC(0)="X"
 . S X=VAFS D ^DIC
 . I Y<1 DO  QUIT
 . . D BMES^XPDUTL(">>> "_VAFS_" entry NOT found in File #101")
 . . D BMES^XPDUTL("...  ")
 .;
 .;look up client item
 . S DA(1)=+Y
 . S DIC="^ORD(101,"_DA(1)_",10,",DIC(0)="XZ"
 . S X=VAFC D ^DIC
 . I Y<1 DO  QUIT
 . . D BMES^XPDUTL(">>> "_VAFC_" entry NOT found in ITEM subfile #101.01")
 . . D BMES^XPDUTL("...  ")
 .;
 .;delete client item
 . S DIK="^ORD(101,"_DA(1)_",10,"
 . S DA=+Y D ^DIK
 . K DA,DIK
 .D BMES^XPDUTL("> "_$G(Y(0,0))_" deleted from "_VAFS_" protocol")
 ;
 Q
 ;
SPROTO ;; server protocols
 ;;VAFC ADT-A01 SERVER;1
 ;;VAFC ADT-A02 SERVER;2 
 ;;VAFC ADT-A03 SERVER;3 
 ;;VAFC ADT-A04 SERVER;4
 ;;VAFC ADT-A08 SERVER;5
 ;;VAFC ADT-A11 SERVER;6 
 ;;VAFC ADT-A12 SERVER;7 
 ;;VAFC ADT-A13 SERVER;8 
 ;;VAFC ADT-A19 SERVER;9 
 ;
 ; client protocols to unsubscribe, remove
CPROTO ;; from item subfield of corresponding server protocol.
 ;;VAFC ADT-A01 CLIENT;1
 ;;VAFC ADT-A02 CLIENT;2
 ;;VAFC ADT-A03 CLIENT;3
 ;;VAFC ADT-A04 CLIENT;4
 ;;VAFC ADT-A08 CLIENT;5
 ;;VAFC ADT-A11 CLIENT;6
 ;;VAFC ADT-A12 CLIENT;7
 ;;VAFC ADT-A13 CLIENT;8
 ;;VAFC ADT-A19 CLIENT;9
 ;
 ;
 ;
STATION ;set facility name in HL7 APPLICATIONS #771
 ;
 ;input  : None
 ;ouput  : None
 D BMES^XPDUTL(">>> Adding Facility-Station number to 'VAFH PIMS' entry in File #771")
 N DIC,DIE,DA,DR,C,D,DI,D0,DQ,%,X,Y,DTOUT,DUOUT
 S X="VAFH PIMS",DIC(0)="MZ" S (DIE,DIC)="^HL(771,"
 D ^DIC
 I Y<1 DO  QUIT
 . D BMES^XPDUTL(">>> 'VAFH PIMS' entry NOT found in File #771")
 . D BMES^XPDUTL("...  ")
 S DA=+Y
 I +($P($$SITE^VASITE(),U,3))=+($$SITE^VASITE()) Q
 S DR="3///^S X=+($P($$SITE^VASITE(),U,3))"
 D ^DIE
 ;
 D BMES^XPDUTL(">>> Adding Facility-Station number to 'VAFC PIMS' entry in File #771")
 N DIC,DIE,DA,DR,C,D,DI,D0,DQ,%,X,Y,DTOUT,DUOUT
 S X="VAFC PIMS",DIC(0)="MZ" S (DIE,DIC)="^HL(771,"
 D ^DIC
 I Y<1 DO  QUIT
 . D BMES^XPDUTL(">>> 'VAFC PIMS' entry NOT found in File #771")
 . D BMES^XPDUTL("...  ")
 S DA=+Y,DR="3///^S X=+($P($$SITE^VASITE(),U,3))"
 D ^DIE
 Q
 ;
