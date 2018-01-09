EAS1154P ;DEV/BJR - EAS*1.0*154 PRE-INSTALL ;10/13/17 10:46am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**154**;MAR 15,2001;Build 4
 ;
 Q
 ;
EN ; Display a message to inform the user that there will be a slight
 ; delay when installing the patch.
 ;
 N EASMESS
 N EASMESS
 S EASMESS(1)="PRE-INSTALLATION PROCESSING"
 S EASMESS(2)="---------------------------"
 S EASMESS(3)="This installation will take some time due to the large size of the file."
 S EASMESS(4)="Please be patient and allow the process to complete.  Thank you!"
 S EASMESS(5)=""
 D BMES^XPDUTL(.EASMESS)
 Q
