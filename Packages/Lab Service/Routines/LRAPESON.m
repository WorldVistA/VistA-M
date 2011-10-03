LRAPESON ;DALOI/WTY- AP TURN ESIG ON;10/25/01
 ;;5.2;LAB SERVICE;**259**;Sep 27, 1994
 ;
 ;This routine is used to activate the electronic signature flag
 ;for Anatomic Pathology
 ;
 N LRAPES,LRAPESON,LRMSG,LRQUIT,LRFDA
 S LRQUIT=0
MAIN ;
 D CHKSEC Q:LRQUIT
 D GETDATA(.LRAPESON)
 D INPUT Q:LRQUIT
 D UPDATE
 Q
CHKSEC ;
 I '$D(^XUSEC("LRAPSUPER",DUZ)) D  Q
 .S LRMSG="You do not hold the appropriate security key "
 .S LRMSG=LRMSG_"to use this option."
 .D EN^DDIOL(LRMSG,"","!!")
 .W !
 .S LRQUIT=1
 Q
GETDATA(LRAPESON) ;
 S LRAPESON=+$$GET1^DIQ(69.9,"1,",619,"I")
 Q
INPUT ;
 S LRMSG="AP electronic signature is "
 S:'LRAPESON LRMSG=LRMSG_"in"
 S LRMSG=LRMSG_"active."
 D EN^DDIOL(LRMSG,"","!!")
 W !
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A")="Do you wish to "
 S:LRAPESON DIR("A")=DIR("A")_"de"
 S DIR("A")=DIR("A")_"activate electronic signature for AP? "
 D ^DIR
 I 'Y S LRQUIT=1
 Q
UPDATE ;
 L +^LAB(69.9,1,15):5 I '$T D  Q
 .S LRMSG="This record is locked by another user.  "
 .S LRMSG=LRMSG_"Please wait and try again."
 .D EN^DDIOL(LRMSG,"","!!")
 S LRFDA(69.9,"1,",619)=$S('LRAPESON:1,1:0)
 D FILE^DIE("","LRFDA")
 W "...Done"
 L -^LAB(69.9,1,15)
 Q
