DG702PRE ;BAY/JAT;
 ;;5.3;Registration;**702**;Aug 13,1993
 ;
 ; This is a pre-init routine for DG*5.3*702
 ; The purpose is to fix dd for file 46
 ;
EN ;
 D BMES^XPDUTL("Updating data dictionary for file #46")
 K ^DD(46,"GL",0,"3 ",.03)
 S ^DD(46,"GL",0,3,.03)=""
 Q
