SD53P779 ;MS/SA - POST INSTALL FOR PATCH SD*5.3*779;Jun 21, 2021
 ;;5.3;Scheduling;**779**;May 29, 2018;Build 7
 ;
 ;
 Q
POST ; Perform post-install updates
 N OPT
 D BMES^XPDUTL("Description Updates for the 'SD TELE TOOLS' menu options")
 S OPT=$$LKOPT^XPDMENU("SD TELE TOOLS") G:'OPT 1
 S ^DIC(19,OPT,1,0)="^19.06^2^2"
 S ^DIC(19,OPT,1,1,0)="This is the primary menu option which allows the user access to all"
 S ^DIC(19,OPT,1,2,0)="Telehealth Management options."
 ;
1 S OPT=$$LKOPT^XPDMENU("SD TELE INQ") G:'OPT 2
 S ^DIC(19,OPT,1,0)="^19.06^3^3"
 S ^DIC(19,OPT,1,1,0)="This option allows the Scheduling Supervisor to inquire using the Clinic, "
 S ^DIC(19,OPT,1,2,0)="Medical Center Division, Institution, Patient, List Telehealth Stop Codes,"
 S ^DIC(19,OPT,1,3,0)="and Telehealth Stop Code Lookup. "
 ;
2 S OPT=$$LKOPT^XPDMENU("SD TELE CLN UPDATE") G:'OPT EX
 S ^DIC(19,OPT,1,0)="^19.06^2^2"
 S ^DIC(19,OPT,1,1,0)="This option allows the Scheduling Supervisor to send clinic update"
 S ^DIC(19,OPT,1,2,0)="message(s) from VistA to TMP without a need to edit the Clinic Profile."
 ;
EX D MES^XPDUTL("Update successful.")
 Q
