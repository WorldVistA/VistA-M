XMJMSO ;ISC-SF/GMB-Options at 'send' transmit prompt ;07/17/2003  14:06
 ;;8.0;MailMan;**20**;Jun 28, 2002
 ; Replaces ^XMA22 (ISC-WASH/CAP/THM)
SENDMSG(XMDUZ,XMZ,XMSUBJ,XMINSTR,XMRESTR,XMABORT) ;
 N XMFINISH,XMDIR,XMY,XMOPT,XMOX
 I $$BCAST,'$D(XMINSTR("VAPOR")),$$QVAPOR D V
 S XMFINISH=0
 F  D  Q:XMFINISH!XMABORT
 . D SENDSET(.XMINSTR,.XMOPT,.XMOX,.XMDIR)
 . D XMDIR^XMJDIR(.XMDIR,.XMOPT,.XMOX,.XMY,.XMABORT) Q:XMABORT
 . K XMDIR,XMOPT,XMOX
 . D @XMY
 Q
SENDSET(XMINSTR,XMOPT,XMOX,XMDIR) ;
 D OPTEDIT^XMXSEC2(.XMINSTR,.XMOPT,.XMOX,1)
 D SET^XMXSEC2("B",37331,.XMOPT,.XMOX) ; Backup to review message
 D SET^XMXSEC2("ER",37332,.XMOPT,.XMOX) ; Edit Recipients
 D SET^XMXSEC2("L",37333,.XMOPT,.XMOX) ; Transmit later
 D SET^XMXSEC2("IM",37445,.XMOPT,.XMOX) ; Include responses from another message
 D SET^XMXSEC2("T",37334,.XMOPT,.XMOX) ; Transmit now
 I $G(XMOPT("NS","?"))=37309.1 K XMOPT("NS","?") ; You have no Network Signature.
 S XMDIR("A")=$$EZBLD^DIALOG(34067) ; Select Message option:
 S XMDIR("B")=XMOX("O","T")_":"_XMOPT("T") ; Transmit now
 S XMDIR("??")="XM-U-MO-SEND"
 Q
B ; Backup to review message
 D BACKUP^XMJMP(XMDUZ,0,"",XMZ)
 ; OR D PRINTIT^XMJMP1(....)
 Q
FLAGTOGL(XMINSTR,XMFLAG,XMSET,XMREMOVE) ; Flag Toggle
 I $G(XMINSTR("FLAGS"))[XMFLAG D
 . S XMINSTR("FLAGS")=$TR(XMINSTR("FLAGS"),XMFLAG)
 . W !,$$EZBLD^DIALOG(XMREMOVE)
 E  D
 . S XMINSTR("FLAGS")=$G(XMINSTR("FLAGS"))_XMFLAG
 . W !,$$EZBLD^DIALOG(XMSET)
 Q
C ; Confidential msg
 D FLAGTOGL(.XMINSTR,"C",37301.9,37302.9)
 Q
D ; Deliver to recipient basket
 I $D(XMINSTR("RCPT BSKT")) D  Q
 . K XMINSTR("RCPT BSKT")
 . W !,$$EZBLD^DIALOG(37304.9) ; Delivery basket removed.
 N XMTEXT
 W !
 D BLD^DIALOG(37303.1,"","","XMTEXT","F")
 D MSG^DIALOG("WM","",80,"","XMTEXT")
 W !
 ;The delivery basket is the basket to which this message should be delivered
 ;for all recipients (even future ones, should the message be forwarded).
 ;Any message filters, which the recipient might have, are ignored."
 ;If the basket does not exist, it will be created."
 ;Note: The recipients must have chosen to allow delivery baskets by setting
 ;ACCEPT DELIVERY BASKET? under 'Personal Preferences|Delivery Basket Edit'
 ;to one of the following:
 ; YES    - If basket doesn't exist, create it, and deliver the message to it.
 ; EXIST  - If the basket already exists, then deliver the message to it.
 ;          Else, just deliver the message as usual.
 ; SELECT - If the basket already exists AND accepts such messages,
 ;          then deliver the message to it.
 ;          Else, just deliver the message as usual.
 ;If the recipient has not set this field or has set it to NO, then
 ;the message would be delivered as usual.
 N XMDIC,XMK,XMKN
 S XMDIC("B")="@"
 S XMDIC("S")="I Y>1"
 D SELBSKT^XMJBU(XMDUZ,$$EZBLD^DIALOG(37303.2),"L",.XMDIC,.XMK,.XMKN) ; Select delivery basket:
 Q:XMK=U
 S XMINSTR("RCPT BSKT")=XMKN
 Q
ER ; Additional Recipients
 D TOWHOM^XMJMT(XMDUZ,$$EZBLD^DIALOG(34110),.XMINSTR,.XMRESTR,.XMABORT) ; Send
 Q
ES ; Edit Subject
 N XMOLDSUB,XMABORT
 S XMOLDSUB=XMSUBJ,XMABORT=0
 D SUBJ^XMJMS(.XMSUBJ,.XMABORT) Q:XMABORT
 Q:XMSUBJ=XMOLDSUB
 N XMFDA
 S XMFDA(3.9,XMZ_",",.01)=XMSUBJ
 D FILE^DIE("","XMFDA")
 Q
ET ; Edit msg
 I $G(XMPAKMAN) Q:$$NOPAKEDT
 D BODY^XMJMS(XMDUZ,XMZ,XMSUBJ,.XMRESTR,.XMABORT)
 Q
NOPAKEDT() ; Function returns 0 if OK to edit; 1, if not OK.
 I $D(XMSECURE) W !,$$EZBLD^DIALOG(37405.4) Q 1  ; You may not edit a secure KIDS or PackMan message.
 N DIR,X,Y,DIRUT
 W @IOF
 N XMTEXT
 D BLD^DIALOG(37306.1,"","","XMTEXT","F")
 D MSG^DIALOG("WM","",80,"","XMTEXT")
 ;                    W A R N I N G
 ;  You are about to edit what appears to be a PackMan message.
 ;  Please note the following:
 ;  1. If you edit this message you may compromise its integrity.
 ;  2. If you must edit it,
 ;     - Do not edit the code.
 ;     - Confine your editing to the text (the lines between $TXT and $ENDTXT).
 ;     - You may insert lines in the text.
 ;     - Do not begin any line with a '$' (dollar sign).
 ;     - Be careful!
 S DIR(0)="Y"
 S DIR("A")=$$EZBLD^DIALOG(37306.2) ; Are you sure you want to edit this message
 S DIR("B")=$$EZBLD^DIALOG(39053) ; NO
 D ^DIR
 Q 'Y
I ; Information only msg
 D FLAGTOGL(.XMINSTR,"I",37307.9,37308.9)
 Q
IM ; Include responses from another message
 I $G(XMPAKMAN) D  Q
 . W !,$$EZBLD^DIALOG(37445.4) ; You may not Include anything into a KIDS or PackMan message.
 D INCL^XMJMRO(XMDUZ,XMZ,XMZ,XMSUBJ,.XMRESTR,2,.XMABORT)
 Q
L ; Transmit Later
 N DIR,X,Y,XMWHEN,ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTSK,XMROOT,I,DIRUT
 I $E($O(^TMP("XMY0",$J,"G.")),1,2)="G." D
 . ;Note: When you send a message Later, it is sent to all members of
 . ;the groups to which you addressed it, even if you 'minus'ed anyone.
 . ;To have your 'minus'es honored, you must ^-out of this and Transmit
 . ;Now, not Later.  If you didn't 'minus' anyone from the groups, just
 . ;ignore this note, and continue ...
 . N XMTEXT
 . W !
 . D BLD^DIALOG(37333.3,"","","XMTEXT","F")
 . D MSG^DIALOG("WM","",80,"","XMTEXT")
 . W !
 S DIR(0)="D^NOW:"_$$SCH^XLFDT("12M",DT)_":ETX"
 S DIR("A")=$$EZBLD^DIALOG(37333.1) ; Enter Date@time at which to send this message
 D ^DIR Q:$D(DIRUT)
 S XMWHEN=Y
 W !,$$EZBLD^DIALOG(37333.2) ;  Latering ...
 S ZTIO=""
 S ZTRTN="LATER^XMXSEND"
 S ZTDTH=$$FMTH^XLFDT(XMWHEN)
 S ZTDESC=$$EZBLD^DIALOG(39310) ; MailMan: Send Message Later
 S XMROOT=$$GET1^DIQ(3.9,XMZ_",",3,"","^TMP(""XM"",$J,""BODY"")")
 F I="DUZ","XMDUZ","XMSUBJ","^TMP(""XMY0"",$J,","^TMP(""XM"",$J,""BODY"",","XMINSTR(" S ZTSAVE(I)=""
 D ^%ZTLOAD
 ;D HOME^%ZIS call this only if preceded by call to ^%ZIS
 I $D(ZTSK) D
 . S XMFINISH=1
 . W $$EZBLD^DIALOG(37333.9,ZTSK) ;  Latered (Task #_ZTSK_)
 . D KILLMSG^XMXUTIL(XMZ)
 . D CLEANUP^XMXADDR
 E  D
 . W !,$C(7),$$EZBLD^DIALOG(37333.8) ; Latering was not successful.  Try again or transmit now.
 K ^TMP("XM",$J,"BODY")
 Q
NS ; Add Network Signature
 I '$$GOTNS^XMVVITA(XMDUZ) D  Q:'$$GOTNS^XMVVITA(XMDUZ)
 . W !!,$$EZBLD^DIALOG(37309.1) ; You have no Network Signature.
 . D CRE8NS^XMVVITA
 N XMMSG
 D NETSIG^XMXEDIT(XMDUZ,XMZ,.XMINSTR,.XMMSG)
 W !,XMMSG
 Q
P ; Priority msg
 D FLAGTOGL(.XMINSTR,"P",37311.9,37312.9)
 Q
R ; Confirm receipt of msg
 D FLAGTOGL(.XMINSTR,"R",37313.9,37314.9)
 Q
S ; Scramble text
 I $D(XMINSTR("SCR KEY")) D  Q
 . K XMINSTR("SCR KEY"),XMINSTR("SCR HINT")
 . W !,$$EZBLD^DIALOG(37316.8) ; Scramble removed
 N XMKEY,XMHINT,XMABORT
 S XMABORT=0
 D CRE8KEY^XMJMCODE(.XMKEY,.XMHINT,.XMABORT)
 I XMABORT W !,$$EZBLD^DIALOG(37315.8) Q  ; Scramble aborted.
 S XMINSTR("SCR KEY")=XMKEY
 S XMINSTR("SCR HINT")=XMHINT
 Q
T ; Transmit now
 S XMFINISH=1
 W $$EZBLD^DIALOG(34217,XMZ) ;   Sending [_XMZ_]...
 D MOVEPART^XMXSEND(XMDUZ,XMZ,.XMINSTR)
 D SEND^XMKP(XMDUZ,XMZ,.XMINSTR)
 D CHECK^XMKPL
 W !,$$EZBLD^DIALOG(34213) ;   Sent
 Q
V ; Vaporize date
 I $G(XMINSTR("VAPOR")) D  Q
 . K XMINSTR("VAPOR")
 . W !,$$EZBLD^DIALOG(37318.9) ; Vaporize Date removed
 N DIR,X,Y,DIRUT,XMTP1
 S XMTP1=$$FMADD^XLFDT($$NOW^XLFDT,,1)
 S DIR(0)="3.9,1.6"
 S DIR("A")=$$EZBLD^DIALOG(37317.1) ; Enter Vaporize Date
 S DIR("B")=$$MMDT^XMXUTIL1($$FMADD^XLFDT(DT,30))
V2 D ^DIR Q:$D(DIRUT)
 I Y<XMTP1 D  G V2
 . W " ??",$C(7),!,$$EZBLD^DIALOG(37317.2),! ; Must be no earlier than 1 hour from now.
 S XMINSTR("VAPOR")=Y
 Q
X ; Closed msg
 D FLAGTOGL(.XMINSTR,"X",37319.9,37320.9)
 Q
BCAST() ; Is this a broadcast (regular or limited)?
 N XMTO
 S XMTO=$O(^TMP("XMY0",$J,"*"))
 I $E(XMTO)="*" Q 1
 Q 0
QVAPOR() ;
 N DIR
 W !
 S DIR(0)="Y"
 D BLD^DIALOG(37350,"","","DIR(""A"")")
 D BLD^DIALOG(37351,"","","DIR(""?"")")
 S DIR("??")="XM-U-M-VAPORIZE DATE SEND"
 S DIR("B")=$$EZBLD^DIALOG(39054) ; Yes
 D ^DIR Q:$D(DIRUT) 0
 Q Y
