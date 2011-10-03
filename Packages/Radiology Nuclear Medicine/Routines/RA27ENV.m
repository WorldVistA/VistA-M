RA27ENV ;HIRMFO/SWM-Environment Check routine ;10/19/01  09:08
VERSION ;;5.0;Radiology/Nuclear Medicine;**27**;Mar 16, 1998
 ; check that the installer has a mailbox
 I '$D(DUZ) G ABEND1
 S XMDUZ=DUZ D INIT^XMVVITAE I $D(XMV("ERROR",4))#2 G ABEND2
 D EN^DDIOL("The postinit, RA27PST, will send a mail msg to your mailbox",,"!!?5")
 D EN^DDIOL("after the cleanup of duplicate clinical history from file #74.",,"!?5")
 D EN^DDIOL("If you do not receive that message, please check the Taskman list.",,"!?5")
 D EN^DDIOL("The task description is:",,"!!?5")
 D EN^DDIOL("RA*5.0*27 Cleanup Duplicate Clin. Hist. from File 74",,"!?5")
 D EN^DDIOL(" ",,"!!")
 Q
ABEND1 ;
 D EN^DDIOL("There's no DUZ defined",,"!!?5")
 G SETABND
ABEND2 ;
 D EN^DDIOL(XMV("ERROR",4),,"!!?5")
SETABND S XPDABORT=2 Q
