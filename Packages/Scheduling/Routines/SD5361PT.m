SD5361PT ;ALB/REW - SD*5.3*61 Post-init Checker ; 7 Aug 1996
 ;;5.3;Scheduling;**61**;SEP 25, 1993
EN ;entry point
 ;look through HOSPITAL LOCATION File (#44) to find any active
 ;clinics without a stop code
 N SCDAYS
 D INTRO
 D SEARCH
 D UPDATE
 D EXIT
 Q
 ;
INTRO ;header info for output
 D MES^XPDUTL("     The default number of days to wait for acknowledgements")
 D MES^XPDUTL("     to ACRP transmissions to Austin is too low.")
 D MES^XPDUTL("     If the AMB CARE LAG FOR ACK field (#704) of the")
 D MES^XPDUTL("     SCHEDULING PARAMETER File (#404.91) is less than")
 D MES^XPDUTL("     7 days, it will be set to 7 days.")
 Q
 ;
SEARCH ;look for active clinics without active stop codes
 D BMES^XPDUTL(">>>Searching SCHEDULING PARAMETER File...")
 S SCDAYS=$P($G(^SD(404.91,1,"AMB")),U,4)
 D BMES^XPDUTL("     Current Value of #704: "_+SCDAYS_" days.")
 Q
 ;
UPDATE ;display clinics with stop code problems
 N DIE,DR,DA,X,Y
 IF SCDAYS>6 D  Q
 .D MES^XPDUTL("The AMB CARE LAG FOR ACK field (#704) already exceeds 6 days.")
 .D MES^XPDUTL(" -- No update was done.")
 S DIE="^SD(404.91,",DR="704///7",DA=1
 D ^DIE
 Q
 ;
EXIT ;final cleanup
 D BMES^XPDUTL("This post-install output is saved in the INSTALL File (#9.7)")
 D MES^XPDUTL("under 'SD*5.3*61'")
 Q
