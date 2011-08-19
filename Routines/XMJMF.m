XMJMF ;ISC-SF/GMB-Find messages based on criteria ;07/10/2002  09:58
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMA03,^XMAL0,^XMAL0A (ISC-WASH/CAP/THM)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; FIND     XMSEARCH
 ; SUPER    XM SUPER SEARCH
FINDBSKT(XMDUZ,XMK,XMKN) ; Find messages in a particular basket
 D FIND^XMJMF1(XMDUZ,XMK,0,XMKN)
 Q
FIND ; Find messages in any basket or find any message
 N XMDIR,XMOX,XMOPT,XMY,XMABORT
 D CHECK^XMVVITAE
 S XMABORT=0
 S XMDIR("A")=$$EZBLD^DIALOG(34410) ; Select message search method:
 D SET^XMXSEC1("S",34411,.XMOPT,.XMOX) ; S:Search all messages by subject only
 D SET^XMXSEC1("A",34413,.XMOPT,.XMOX) ; A:Search all messages by multiple criteria
 D SET^XMXSEC1("M",34412,.XMOPT,.XMOX) ; M:Search my Mailbox by multiple criteria
 S XMDIR(0)="S" ; show the choices
 S XMDIR("?")=34414
 S XMDIR("??")="XM-U-Q-SEARCH"
 D XMDIR^XMJDIR(.XMDIR,.XMOPT,.XMOX,.XMY,.XMABORT) Q:XMABORT
 K XMOX,XMOPT,XMDIR
 D @XMY
 Q
S ; Search all existing messages by subject
 N DIR,Y,DIRUT
 S DIR(0)="FO^3:30"
 S DIR("A")=$$EZBLD^DIALOG(34415) ; Enter the string that the subject starts with
 D BLD^DIALOG(34416,"","","DIR(""?"")")
 ;The string may be from 3 to 30 characters.
 ;We will find all messages whose subject starts with the string you enter.
 ;We will search all existing messages which you have ever had access to,
 ;whether they are in your mailbox or not.
 ;The search is case-sensitive.
 S DIR("??")="XM-U-Q-SEARCH SYSTEM"
 D ^DIR Q:$D(DIRUT)
 W !,$$EZBLD^DIALOG(34417) ; Searching...
 D FIND^XMJMFA(XMDUZ,Y)
 Q
A ; Search all existing messages by multiple criteria
 D ALL(XMDUZ)
 Q
ALL(XMDUZ,XMFLAG) ;
 N XMTEXT
 W !
 ;                      * * * * * WARNING * * * * *
 I $G(XMFLAG)="U" D
 . D BLD^DIALOG(34418.5,"","","XMTEXT","F")
 . ;This is the Super Search which looks at all messages
 . ;in the MESSAGE file which were sent by anyone and everyone during the
 . ;entire time period you select, regardless of whether or not you are
 . ;party to the messages.  This is a very powerful search and should not
 . ;be abused.  You should have good reason and authorization to be here.
 E  D
 . D BLD^DIALOG(34418,"","","XMTEXT","F")
 . ;This search looks at all messages in the MESSAGE file which were sent
 . ;to you or by you during the entire time period you select.
 D BLD^DIALOG(34419,"","","XMTEXT","F")
 ;This search can take a very long time, depending on how many messages
 ;were sent at this site during the time period you select, and how many
 ;search criteria you specify.  The more messages to search, the more
 ;search criteria you specify, the longer the search will take.
 ;             This search can be VERY SLOW.  Be forewarned!
 D MSG^DIALOG("WM","",IOM,"","XMTEXT")
 W !
 D WAIT^XMXUTIL
 D FIND^XMJMF1(XMDUZ,"!",$G(XMFLAG))
 Q
M ; Search my mailbox by multiple criteria
 D FIND^XMJMF1(XMDUZ,"*",1)
 Q
SUPER ; Super Search all messages in the Message file
 N XMDUZ,XMV
 D INITAPI^XMVVITAE
 I $D(XMV("ERROR")) D ERROR^XM(.XMV,"ERROR") Q
 D ALL(DUZ,"U")
 Q
