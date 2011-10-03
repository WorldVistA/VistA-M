XMJDIR ;ISC-SF/GMB- MailMan's DIR ;10/31/2001  12:33
 ;;8.0;MailMan;;Jun 28, 2002
XMDIR(XMDIR,XMOPT,XMOX,XMY,XMABORT) ;
 ; XMDIR("A")   User prompt
 ; XMDIR("B")   Default choice
 ; XMDIR(0)     Special instructions
 ;              S - Show the choices
 ;              C - Show choices in 2 columns, if necessary
 ; XMDIR("?")   Help text for 1 ?
 ; XMDIR("??")  Help text for 2 or more ?
 N XMX
 K XMY
 I +XMDIR("A")=XMDIR("A") S XMDIR("A")=$$EZBLD^DIALOG(XMDIR("A"))
 I $D(XMDIR("B")),+XMDIR("B")=XMDIR("B") S XMDIR("B")=$$EZBLD^DIALOG(XMDIR("B"))
 I $G(XMDIR(0))["S" D
 . W !!,?5,$$EZBLD^DIALOG(37008),! ; Select one of the following:
 . D HELPCMD(.XMOPT,.XMOX,$S(XMDIR(0)["C":IOSL-$Y-3,1:IOSL-4))
 F  D  Q:$D(XMY)!XMABORT
 . W !!,XMDIR("A"),$S($D(XMDIR("B")):$P(XMDIR("B"),":",2,99)_"// ",1:"")
 . R XMX:DTIME I '$T S XMABORT=DTIME Q
 . I XMX[U S XMABORT=1 Q
 . I XMX="" D  Q
 . . I '$D(XMDIR("B")) S XMABORT=1 Q
 . . S XMY=$P(XMDIR("B"),":",1)
 . I $E(XMX)="?" D QHELP Q
 . I $D(XMDIR("PRE")) X XMDIR("PRE")
 . S XMY=$$COMMAND(.XMOPT,.XMOX,XMX)
 . I $D(XMOPT(XMY)),'$D(XMOPT(XMY,"?")) Q
 . I XMY=-1 D
 . . W $C(7) D HELPSCR(.XMOPT,.XMOX)
 . E  D SHOWERR(.XMOPT,XMY) I $D(XMOPT(XMY,"?X")) X XMOPT(XMY,"?X") I $T Q
 . K XMY
 Q
SHOWERR(XMOPT,XMY) ; Show error message
 W $C(7),!
 I +XMOPT(XMY,"?")=XMOPT(XMY,"?") D  Q
 . N XMTEXT
 . D BLD^DIALOG(XMOPT(XMY,"?"),"","","XMTEXT","F")
 . D MSG^DIALOG("WE","",IOM,"","XMTEXT")
 I $D(XMOPT(XMY,"?",1)) D
 . N I
 . S I=0
 . F  S I=$O(XMOPT(XMY,"?",I)) Q:'I  W !,XMOPT(XMY,"?",I)
 W !,XMOPT(XMY,"?")
 Q
QHELP ;
 I XMX="?" D HELPSCR(.XMOPT,.XMOX) Q
 N XQH
 S XQH=$G(XMDIR("??"),"XM-U-MO-READ")
 I "@"[XQH D HELPSCR(.XMOPT,.XMOX) Q
 I $E(XQH,1,2)="D " X XQH Q
 D EN^XQH
 Q
HELPSCR(XMOPT,XMOX) ;
 I $D(XMDIR("?")) D
 . N XMTEXT
 . W !
 . D BLD^DIALOG(XMDIR("?"),"","","XMTEXT","F")
 . D MSG^DIALOG("WH","",IOM,"","XMTEXT")
 W !!,$$EZBLD^DIALOG(34054),! ; Enter a code from the list.
 D HELPCMD(.XMOPT,.XMOX)
 Q
HELPCMD(XMOPT,XMOX,XMPMAX) ;
 N XMCNT,XMCMD,XMROWS,I,XMHELP,XMLEN
 S (XMCNT,XMLEN)=0,XMCMD=""
 F  S XMCMD=$O(XMOPT(XMCMD)) Q:XMCMD=""  I '$D(XMOPT(XMCMD,"?")) S XMCNT=XMCNT+1 I $L(XMOX("O",XMCMD))>XMLEN S XMLEN=$L(XMOX("O",XMCMD))
 I XMCNT<$G(XMPMAX,IOSL-4) D  Q
 . F  S XMCMD=$O(XMOX("X",XMCMD)) Q:XMCMD=""  D
 . . Q:$D(XMOPT(XMOX("X",XMCMD),"?"))
 . . W !,?9,$E(XMCMD_"         ",1,10)_XMOPT(XMOX("X",XMCMD))
 S XMROWS=XMCNT+1\2
 S I=0
 F  D  Q:I=XMROWS
 . S XMCMD=$O(XMOX("X",XMCMD))
 . Q:$D(XMOPT(XMOX("X",XMCMD),"?"))
 . S I=I+1
 . S XMHELP(I)=" "_$E(XMCMD_"      ",1,XMLEN+2)_XMOPT(XMOX("X",XMCMD))
 S I=0
 F  S XMCMD=$O(XMOX("X",XMCMD)) Q:XMCMD=""  D
 . Q:$D(XMOPT(XMOX("X",XMCMD),"?"))
 . S I=I+1
 . W !,$E(XMHELP(I)_"                                   ",1,39)_"  "_$E(XMCMD_"      ",1,XMLEN+2)_$E(XMOPT(XMOX("X",XMCMD)),1,37-XMLEN)
 S I=I+1
 W:$D(XMHELP(I)) !,XMHELP(I)
 Q
COMMAND(XMOPT,XMOX,XMY) ; Check what the user enters against the list of
 ; acceptable choices.  If the user enters something ambiguous,
 ; ^DIR is called to ask the user to choose one.
 I XMY?.E1C.E Q -1
 I $L(XMY)>64 Q -1
 N XMX,XMCD,XMLEN
 S XMX=XMY
 S XMLEN=$L(XMX)
 S XMY=$$UP^XLFSTR(XMY)
 I $D(XMOX("X",XMY)) D  Q XMCD
 . S XMCD=XMOX("X",XMY)
 . D PARROT
 N XMTXT,XMC,XMT,XMCHOOSE
 S XMCD=""
 F  S XMCD=$O(XMOPT(XMCD)) Q:XMCD=""  S:'$D(XMOPT(XMCD,"?")) XMTXT(XMOPT(XMCD))=XMCD
 S XMT=$CHAR($A($E(XMY))-1)_"~"
 F  S XMT=$O(XMTXT(XMT)) Q:XMT=""!($E(XMT)'=$E(XMY))  I $$UP^XLFSTR($E(XMT,1,XMLEN))=XMY S XMCHOOSE(XMT)=""
 S XMC=$CHAR($A($E(XMY))-1)_"~"
 F  S XMC=$O(XMOX("X",XMC)) Q:XMC=""!($E(XMC)'=$E(XMY))  I $$UP^XLFSTR($E(XMC,1,XMLEN))=XMY S:'$D(XMOPT(XMOX("X",XMC),"?")) XMCHOOSE(XMOPT(XMOX("X",XMC)))=""
 I '$D(XMCHOOSE) Q -1
 N I,DIR,Y,X
 S I=0,(DIR(0),XMT)=""
 F  S XMT=$O(XMCHOOSE(XMT)) Q:XMT=""  S I=I+1,DIR(0)=DIR(0)_I_":"_XMT_";",XMCD(I)=XMTXT(XMT)
 I I=1 D  Q $P(XMCD," ")  ; (for Q xxx)
 . S XMCD=XMCD(I)
 . D PARROT
 S DIR(0)="SO^"_$E(DIR(0),1,$L(DIR(0))-1)
 ;S DIR("A")="Choose 1-"_I
 D ^DIR Q:$D(DIRUT) -1
 Q $P(XMCD(Y)," ")  ; (for Q xxx)
PARROT ;
 I $E(XMOPT(XMCD),1,XMLEN)=XMX W $E(XMOPT(XMCD),XMLEN+1,99) Q
 W "  ",XMOPT(XMCD)
 Q
