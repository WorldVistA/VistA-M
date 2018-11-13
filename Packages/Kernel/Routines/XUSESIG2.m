XUSESIG2 ;EPIP/LLB - ROUTINE TO ENTER OR CHNAGE ELECTRONIC SIGNATURE REVISED; 10 Feb 2017  11:15 AM ; 09 Mar 2017  10:09 AM
 ;;8.0;KERNEL;**679**;02/02/2017;Build 27
 ;
 ; ^XUSEC(KEY,DUZ) is supported by ICR #10076
 ;
 Q  ;Must be called from a tag.
 ; Function to test if patch XU*8.0*679 is active and if the user has the proper credentials
 ; to edit field 10.6 (Degree) in the NEW PERSON file (#200).
EN ;
 I '$G(DUZ) W "USER NOT SIGNED IN" Q  ; Test if user is signed in
 ; Test if the system parameter "Electronic Signature Block Edit" is on
 ;
 S DA=DUZ
 ; If the switch is ON then check user and is security key XUSIG is present.
 ; $$GET^XPAR does not error if the system parameter does not exist. Returns null
 I '$$GET^XPAR("ALL","XU SIG BLOCK DISABLE") D
 . N DIC K DIC
 . S DIC="^VA(200,",DIC(0)="AEMQ"
 . D ^DIC S DA=+Y
 . S DIE=DIC K DIC S DR="20.2;10.6" D ^DIE
 E  D  ; Get person to lookup and check for security key.
 . N DIC,DIR
 . ;check for security key. If not present denie access and quit.
 . I '$D(^XUSEC("XUSIG",DUZ)) D  Q
 . . ;W !,"Edit Access Denied. Press <ENTER> to Continue. "
 . . S DIR(0)="FO^1",DIR("A")="Edit Access Denied. Contact your CAC/ADPAC for assistance. Press <ENTER> to Continue. "
 . . D ^DIR K DIR
 . K DIC
 . S DIC="^VA(200,",DIC(0)="QEAL",DIC("A")="Enter Person to Edit: "
 . D ^DIC
 . K DIC
 . S DA=+Y
 . D PNM^XUSESIG3 ; Edit Signature Block Printed Name & Title
 . D DEGREE^XUSESIG3 ; Edit DEGREE field in NEW PERSON (#200) file
 Q
 ;
