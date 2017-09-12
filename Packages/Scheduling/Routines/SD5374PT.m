SD5374PT ;ALB/SEK - POST-INSTALL FOR PATCH SD*5.3*74 ; 31 Oct 1996
 ;;5.3;Scheduling;**74**;SEP 25, 1993
EN ; This routine will be executed upon installation of the KIDS build.
 ;
 ; This routine will change the AMB CAR CLOSE OUT field (#703) in the
 ; SCHEDULING PARAMETER file (#404.91) to November 15, 1996.
 ;
 N DIE,DR,DA,X
 D BMES^XPDUTL("The AMB CARE CLOSE OUT field (#703) in the SCHEDULING")
 D MES^XPDUTL("PARAMETER file (#404.91) is being changed to November 15, 1996.")
 S DIE="^SD(404.91,",DR="703////2961115",DA=1
 D ^DIE
 Q
