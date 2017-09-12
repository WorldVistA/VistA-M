EAS1048P ;ALB/PHH - EAS*1*48 PRE-INSTALL ;12-18-2003
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**48**;MAR 15,2001
EN ; Display a message to inform the user that there will be a slight
 ; delay when installing the patch.
 ;
 N MESS
 S MESS(1)="PRE-INSTALLATION PROCESSING"
 S MESS(2)="---------------------------"
 S MESS(3)="This installation will take some time due to the large size of the file."
 S MESS(4)="Please be patient and allow the process to complete.  Thank you!"
 S MESS(5)=""
 D BMES^XPDUTL(.MESS)
 Q
