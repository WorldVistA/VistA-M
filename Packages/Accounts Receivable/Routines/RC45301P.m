RC45301P ;ALB/BDB - CROSS-SERVICING PROJECT POST-INSTALL;3/31/15
 ;;4.5;Accounts Receivable;**301**;Mar 20, 1995;Build 144
 ;;Per VA Directive 6402, this routine should not be modified.
 ; 1) This routine sets the Cross-Servicing Start Date into the
 ;       AR SITE PARAMETER file (#342)
 ; 2) Runs the Due Process Notification initialization process
 ;
ENTER ; Entry point for post-install
 D CS
 D DPNINIT
 Q
 ;
CS ; Set the Cross-Servicing Start Date equal to DT
 D BMES^XPDUTL(">>>Cross-Servicing Start Date set to "_DT_".")
 S ^RC(342,1,"CS")=DT
 Q
 ;
DPNINIT ;
 D BMES^XPDUTL(">>>Begin the Due Process Initialization.")
 D BMES^XPDUTL(">>>The Initialization may take up to 8 hours.")
 D ENTER^RCTCSP3
 D BMES^XPDUTL(">>>Due Process Initialization is complete.")
 K DPNINIT
 Q
 ;
