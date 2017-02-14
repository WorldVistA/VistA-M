EAS1146P ;ALB/BJR - EAS*1.0*146 PRE-INSTALL ; 1/24/17 5:03pm
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**146**;MAR 15,2001;Build 3
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
