XMUTERM ;ISC-SF/GMB-Delete Mailbox/Delete Message ;04/17/2002  12:08
 ;;8.0;MailMan;;Jun 28, 2002
 ; Taken from XUSTERM (SEA/AMF/WDE)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; ALL1     XMMGR-TERMINATE-MANY
 ; ALL2     XMMGR-TERMINATE-SUGGEST
 ; CHOOSE   XMMGR-TERMINATE-ONE
 ; MESSAGE  XMMGR-PURGE-MESSAGE
MESSAGE ; Manager chooses messages to purge
 N DIR,XMABORT,XMZ,XMKILL,XMPARM
 Q:$$NOTAUTH()
 W @IOF
 D BLD^DIALOG(36301,"","","","F")
 D MSG^DIALOG("WM","",IOM)
 ;This option enables you to purge any message.
 ;Purge means:
 ;-delete the message from all user mailboxes
 ;-delete the message from the MESSAGE file ^XMB(3.9
 ;-delete all responses from the MESSAGE file ^XMB(3.9
 ;-delete the message from the MESSAGES TO BE NEW AT A LATER DATE file ^XMB(3.73
 ;Purge is not reversible.  The message is gone forever.
 F  S XMZ=$O(^XMB(3.9,":"),-1) Q:XMZ?1N.N  K ^XMB(3.9,XMZ) ; kill bogus nodes
 S (XMABORT,XMKILL)=0
 F  D  Q:XMABORT
 . W !
 . S DIR(0)="NO^1:"_$O(^XMB(3.9,":"),-1)_":0^D CHKMSG^XMUTERM(Y)",DIR("A")=$$EZBLD^DIALOG(36302) ; Purge MESSAGE
 . S DIR("?")=$$EZBLD^DIALOG(36303) ; This response must be a message number
 . D ^DIR K DIR I $D(DIRUT) S XMABORT=1 Q
 . S XMZ=+Y
 . S DIR(0)="Y",DIR("A")=$$EZBLD^DIALOG(36304),DIR("B")=$$EZBLD^DIALOG(39053) ; Are you sure / NO
 . D ^DIR K DIR I 'Y!$D(DIRUT) W !,$$EZBLD^DIALOG(36305) Q  ;Message not purged.
 . S (XMKILL("MSG"),XMKILL("RESP"))=0
 . D KILL^XMA32A(XMZ,.XMKILL,XMABORT)
 . S XMPARM(1)=XMKILL("MSG"),XMPARM(2)=XMKILL("RESP")
 . W !!,$$EZBLD^DIALOG(36306,.XMPARM) ; XMKILL("MSG") message and XMKILL("RESP") response(s) purged.
 . S XMKILL=XMKILL+XMKILL("MSG")+XMKILL("RESP")
 Q
CHKMSG(XMZ) ;
 I '$D(^XMB(3.9,XMZ)) K X Q
 W "  ",$P($G(^XMB(3.9,XMZ,0)),U,1)
 Q
ALL1 ; MailMan chooses users to remove from MailMan
 ; (Users who shouldn't have mailboxes.)
 N XMTEST,DIR,XMABORT,XMCUTOFF,XMGRACE
 Q:$$NOTAUTH()
 S XMABORT=0
 W @IOF
 D BLD^DIALOG(36309,"","","","F")
 ;This option goes through the MailBox global and deletes the user's mailbox if
 D HELP1
 D BLD^DIALOG(36309.5,"","","","F")
 ;However, if the user meets one of the last two conditions above, but has a
 ;forwarding address, the user's mailbox will not be deleted.  The fact will be
 ;noted, and the user should be investigated further.  
 ;
 D MSG^DIALOG("WM","",IOM)
 D CUTOFF(1,.XMGRACE,.XMCUTOFF,.XMABORT) Q:XMABORT
 S DIR(0)="SO^"_$$EZBLD^DIALOG(36321)_";"_$$EZBLD^DIALOG(36322) ; T:Test Mode only;R:Real Mode
 S DIR("B")=$P($$EZBLD^DIALOG(36321),":",2) ; Test Mode only
 S DIR("A")=$$EZBLD^DIALOG(36323) ; Select Run Option
 D BLD^DIALOG(36324,"","","DIR(""?"")","F")
 ;'Real Mode' will remove qualifying users from MailMan.
 ;'Test Mode' will not.
 ;Select 'Test Mode' to see who would be removed.
 ;Select 'Real Mode' to remove them.
 D ^DIR Q:$D(DIRUT)
 S XMTEST=$S(X="R":0,1:1)
 S (ZTSAVE("XMTEST"),ZTSAVE("XMCUTOFF"),ZTSAVE("XMGRACE"))=""
 W !
 D BLD^DIALOG(36325,"","","","F")
 D MSG^DIALOG("WM","",IOM)
 ;This report may take a while.  You might consider spooling it.
 D EN^XUTMDEVQ("ALL1TASK^XMUTERM1",$$EZBLD^DIALOG(36326),.ZTSAVE) ; MailMan: Remove user Mailboxes
 Q
ALL2 ; MailMan reports on users who maybe should be removed from MailMan
 ; (Users who haven't logged on in a while.)
 N XMTEST,DIR,XMABORT,XMCUTOFF,XMGRACE
 Q:$$NOTAUTH()
 S XMABORT=0
 W @IOF
 D BLD^DIALOG(36312,"","","","F")
 ;This option goes through the MailBox global and reports if
 D HELP2
 D BLD^DIALOG(36314,"","","","F")
 ;This option does not delete any mailboxes.  Use the XM-TERMINATE-ONE-USER
 ;option to delete any user mailboxes identified in this report.
 D MSG^DIALOG("WM","",IOM)
 D CUTOFF(2,.XMGRACE,.XMCUTOFF,.XMABORT) Q:XMABORT
 S ZTSAVE("XMCUTOFF")=""
 W !
 D BLD^DIALOG(36325,"","","","F")
 D MSG^DIALOG("WM","",IOM)
 ;This report may take a while.  You might consider spooling it.
 D EN^XUTMDEVQ("ALL2TASK^XMUTERM1",$$EZBLD^DIALOG(36327),.ZTSAVE) ; MailMan: Suggest Remove user Mailboxes
 Q
NOTAUTH() ;
 Q:$D(^XUSEC("XMMGR",DUZ)) 0
 W !,$C(7)
 D BLD^DIALOG(36300,"","","","F")
 D MSG^DIALOG("WE","",IOM)
 ;You must hold the XMMGR key to run this option.
 Q 1
HELP1 ;
 D BLD^DIALOG(36311,"","","","SF")
 ;- the user is not in the NEW PERSON file.
 ;- the user has no access code and was not terminated.
 ;- the user has no access code and was terminated w/o mailbox retention.
 ;- the user has an access code, but no primary menu.
 ;- the user has an access code and primary menu, but no verify code AND
 ;  - has never signed on or used mail, since being added before a cutoff date.
 ;  OR
 ;  - last signed on or used mail before a cutoff date.
 ;'Delete mailbox' includes:
 ;- Delete user's private mail groups
 ;- Remove user from membership in any group
 ;- Remove user as authorized sender from any group
 ;- Remove user from anyone's list of surrogates
 ;- Delete user's mailbox
 ;As a result, the user will not receive any mail.
 Q
HELP2 ;
 D BLD^DIALOG(36313,"","","","SF")
 ;- the user was DISUSER'd.
 ;- the user was terminated before a cutoff date and allowed to keep a mailbox.
 ;- the user has an access code, verify code, and primary menu, AND
 ;  - has never signed on or used mail, since being added before a cutoff date.
 ;  OR
 ;  - last signed on or used mail before a cutoff date.
 Q
CUTOFF(XMWHICH,XMGRACE,XMCUTOFF,XMABORT) ;
 N DIR
 W !
 S XMGRACE=$$FMADD^XLFDT(DT,-30)
 S DIR(0)="D^:"_XMGRACE_":EP"
 S DIR("A")=$$EZBLD^DIALOG(36315) ; Logon cutoff date
 S DIR("B")=$$FMTE^XLFDT(DT-10000)
 S DIR("??")="^D HCUTOFF^XMUTERM(XMWHICH)"
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 S XMCUTOFF=Y
 Q
HCUTOFF(XMWHICH) ;
 D BLD^DIALOG(36316,"","","","F")
 ;The cutoff date must be more than 30 days ago.
 ;It is used during the check to see if
 I XMWHICH="*"!(XMWHICH=1) D
 . D BLD^DIALOG(36317,"","","","SF")
 . ;- the user has an access code and primary menu, but no verify code, AND
 . ;  - has never signed on or used mail, since being added before a cutoff date.
 . ;  OR
 . ;  - last signed on or used mail before a cutoff date.
 I XMWHICH="*"!(XMWHICH=2) D
 . D BLD^DIALOG(36318,"","","","SF")
 . ;- the user has an access code, verify code, and primary menu, AND
 . ;  - has never signed on or used mail, since being added before a cutoff date.
 . ;  OR
 . ;  - last signed on or used mail before a cutoff date.
 D BLD^DIALOG(36319,"","","","F")
 ;(If you do not wish to check mailboxes based on a cutoff date, enter '1900'.)
 ;Please enter that cutoff date.
 D MSG^DIALOG("WH","",IOM)
 Q
CHOOSE ; Manager chooses user to remove from MailMan
 N XMCUTOFF,XMABORT,XMI,XMGRACE
 S XMABORT=0
 Q:$$NOTAUTH()
 W @IOF
 D BLD^DIALOG(36310,"","","","F")
 ;This option lets you delete the mailbox of a user if
 D HELP2
 D HELP1
 D MSG^DIALOG("WM","",IOM)
 D CUTOFF("*",.XMGRACE,.XMCUTOFF,.XMABORT) Q:XMABORT
 N DIR
 S DIR(0)="SO^"_$$EZBLD^DIALOG(36330) ; M:MailMan presents;I:I select
 D BLD^DIALOG(36332,"","","DIR(""?"")","F")
 ;Select 'M' if you want MailMan to $order through the MailBox file and
 ;present to you candidates for mailbox deletion.
 ;Select 'I' if you want to do the selection directly.
 D ^DIR Q:$D(DIRUT)
 I Y="M" D MMCHOOSE^XMUTERM2(XMGRACE,XMCUTOFF) Q
 D ICHOOSE^XMUTERM2(XMGRACE,XMCUTOFF)
 Q
