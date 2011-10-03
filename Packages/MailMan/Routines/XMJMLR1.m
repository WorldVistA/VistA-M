XMJMLR1 ;ISC-SF/GMB-List/Read messages in basket (cont.) ;05/20/2002  15:15
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces 1^XMAL0 (ISC-WASH/THM/CAP)
XMDIR(XMDUZ,XMLO,XMHI,XMPAGE,XMMORE,XMHELP,XMINSTR,XMOPT,XMOX,XMY,XMABORT) ;
 N XMX K XMY
 D ZOOMOPT(.XMOPT)
 F  D  Q:$D(XMY)!XMABORT
 . W !,$$EZBLD^DIALOG(34050) ; Enter message number or command:
 . R XMX:DTIME I '$T S XMABORT=1 Q
 . I XMX[U S XMABORT=1 Q
 . I "="[XMX S XMY=XMX Q
 . I XMX?.E1C.E D HELPSCR Q
 . I $E(XMX)="?" D QUESTION Q
 . I '$$OK K XMY D HELPSCR Q
 . Q:'$D(XMOPT(XMY,"?"))
 . D SHOWERR
 I $G(XMY)="=" K XMY
 Q
OK() ;
 N XMLO
 S XMLO=0
 I XMX?1N.N Q $$NUMBERZ
 I $E(XMX)="." Q $$DOT
 S XMY=XMX
 I XMX?1(1"+",1"-").N Q $L(XMX)<26
 S XMY=$$COMMAND^XMJDIR(.XMOPT,.XMOX,XMX)
 Q XMY'=-1
NUMBERZ() ;
 Q:$L(XMX)>25 0
 S (XMX,XMY)=+XMX
 I XMX'<XMLO,XMX'>XMHI Q 1
 I $D(^XMB(3.9,XMX,0)) Q 1
 Q 0
DOT() ;
 N XMXR,I,XMOK,XMSTRIKE
 S XMOK=1
 S XMX=$TR(XMX," ")
 I $E(XMX,2)="-" S XMSTRIKE=1,XMX=$E(XMX,3,999)
 E  S XMSTRIKE=0,XMX=$E(XMX,2,999)
 I XMX="*" S XMY="."_$S(XMSTRIKE:"-",1:"")_XMX Q 1
 F I=1:1:$L(XMX,",") D  Q:'XMOK
 . S XMXR=$P(XMX,",",I)
 . I XMXR?1.25N1"-"1.25N D  Q
 . . I $P(XMXR,"-",1)<XMLO S XMOK=0 Q
 . . I $P(XMXR,"-",2)>XMHI S XMOK=0 Q
 . . I $P(XMXR,"-",1)>$P(XMXR,"-",2) S XMOK=0
 . I XMXR?1.25N D  Q
 . . I XMXR<XMLO S XMOK=0 Q
 . . I XMXR>XMHI S XMOK=0
 . I XMXR?1.25N1"-" D  Q
 . . I $P(XMXR,"-",1)<XMLO S XMOK=0 Q
 . . I $P(XMXR,"-",1)>XMHI S XMOK=0
 . S XMOK=0
 I XMOK S XMY="."_$S(XMSTRIKE:"-",1:"")_XMX Q 1
 Q 0
SHOWERR ;
 D SHOWERR^XMJDIR(.XMOPT,XMY)
 D WAIT^XMXUTIL
 S XMY="="
 Q
QUESTION ;
 I XMX="?" D HELPSCR Q
 I XMX?2."?"!("?HELP"[$$UP^XLFSTR(XMX)) S XQH=XMHELP D EN^XQH S XMY="=" Q
 I $L(XMX)>64 D HELPSCR Q
 I XMX?2"?"1N.N,$D(^XMB(3.9,$E(XMX,3,99),0)) S XMY=$E(XMX,3,99) Q
 I '$D(XMOPT("Q")) D HELPSCR Q
 S XMY="Q"
 I $D(XMOPT("Q","?")) D SHOWERR Q
 N I F I=1,2 Q:$E(XMX,I+1)'="?"
 S XMY=XMY_I,XMY(0)=$E(XMX,I+1,99)
 Q
HELPSCR ;
 N XMTEXT,XMPARM,XMLINES
 W !
 S XMPARM(1)=XMLO,XMPARM(2)=XMHI
 D BLD^DIALOG($S($G(XMINSTR("GOTO")):34051,1:34051.1),.XMPARM,"","XMTEXT","F") ; Enter a message number (_XMLO_-_XMHI_) to read a message.
 I $D(XMOPT("Q")),'$D(XMOPT("Q","?")) D BLD^DIALOG(34052,"","","XMTEXT","FS")
 ; ?string             Search for messages in this basket whose subject
 ;                     contains the specified string
 ; ??string            Search for messages you once sent or received
 ;                     whose subject begins with the specified string
 D BLD^DIALOG(34053,"","","XMTEXT","FS")
 ; .(-)n or n-m,a,c-d  (de)select message n or a list of messages
 ; .(-)*               (de)select all messages
 S XMLINES=IOSL-DIHELP-5
 D MSG^DIALOG("WH","",$G(IOM),"","XMTEXT")
 D HELPCMD^XMJDIR(.XMOPT,.XMOX,.XMLINES)
 I XMMORE D
 . I XMPAGE D BLD^DIALOG($S($G(XMINSTR("GOTO")):34055,1:34056),"","","XMTEXT","FS") Q
 . D BLD^DIALOG($S($G(XMINSTR("GOTO")):34057,1:34058),"","","XMTEXT","FS")
 E  D
 . I XMPAGE D BLD^DIALOG($S($G(XMINSTR("GOTO")):34060,1:34061),"","","XMTEXT","FS") Q
 . D BLD^DIALOG(34059,"","","XMTEXT","FS")
 ; Press ENTER or + to go to the next page.  Enter +n to page forward n pages.
 ; Enter - to go to the previous page.  Enter -n to page back n pages.
 ; Enter 0 to go to the first page; = to refresh this page; ^ to exit.
 D MSG^DIALOG("WH","",$G(IOM),"","XMTEXT")
 W !
 Q
SETOPT(XMDUZ,XMK,XMOPT,XMOX) ;
 D OPTGRP^XMXSEC1(XMDUZ,XMK,.XMOPT,.XMOX,1)
 D SET^XMXSEC1("CD",37221,.XMOPT,.XMOX) ; Change Detail
 D SET^XMXSEC1("O",37222,.XMOPT,.XMOX) ; Opposite selection toggle
 D SET^XMXSEC1("Z",37223,.XMOPT,.XMOX) ; Zoom selection toggle
 Q
ZOOMOPT(XMOPT) ;
 N I
 I $D(^TMP("XM",$J,".")) D  Q
 . I $D(XMOPT("Z","?")) K XMOPT("O","?"),XMOPT("Z","?")
 . I $D(XMOPT("Q")) F I="Q","N","R" S XMOPT(I,"?")=37232 ; You can't do this with messages selected.
 F I="O","Z" S XMOPT(I,"?")=37231 ; You can't do this unless messages are selected.
 I $D(XMOPT("Q")) K XMOPT("Q","?"),XMOPT("N","?"),XMOPT("R","?")
 Q
FWD(XMDUZ,XMZ,XMZREC,XMWAIT,XMOK) ; User is trying to access a message.
 N X        ; User (XMDUZ) is not authorized to see it.  If user (DUZ)
 S XMOK=0   ; is, then we'll give him a chance to forward it.
 I '$D(^TMP("XMERR",$J,"E",37103)) D  Q
 . D SHOW^XMJERR ; User (XMDUZ and/or DUZ) is not authorized to see it.
 . D:XMWAIT WAIT^XMXUTIL
 ; User is trying to access a message as a surrogate for someone else.
 ; User (DUZ) is authorized to see the message, but the someone else
 ; (XMDUZ) isn't.  We must check to see if we can allow the user to
 ; forward the message to XMDUZ. 
 D NOGOID^XMJMP2(XMZ,XMZREC,1) ; Show 'subject' & 'from'
 D SHOW^XMJERR
 S X=$$FORWARD^XMXSEC(DUZ,XMZ,XMZREC)
 I XMDUZ=.6 D
 . I $$CLOSED^XMXSEC(XMZREC) D ERRSET^XMXUTIL(39020) Q
 . I $$CONFID^XMXSEC(XMZREC) D ERRSET^XMXUTIL(39021)
 I $D(XMERR) D  Q
 . D SHOW^XMJERR
 . D:XMWAIT WAIT^XMXUTIL
 N DIR,X,Y
 W !
 S DIR(0)="Y"
 ;Do you want to forward this message to |1|
 D BLD^DIALOG(37104,XMV("NAME"),"","DIR(""A"")","F")
 S DIR("B")=$$EZBLD^DIALOG(39053) ; No
 D ^DIR Q:'Y!$D(DIRUT)
 K DIR,X,Y
 N XMERROR,XMINSTR,XMMSG
 I XMDUZ=.6 D ASKSHARE^XMXADDR1(.XMINSTR) Q:$D(XMERROR)
 S XMINSTR("FWD BY")=XMV("DUZ NAME")
 D FWDMSG^XMXMSGS(DUZ,"",XMZ,XMDUZ,.XMINSTR,.XMMSG)
 I $D(XMERR) D  Q
 . D SHOW^XMJERR
 . D:XMWAIT WAIT^XMXUTIL
 I $D(XMMSG) D
 . W !,XMMSG
 . D:XMWAIT WAIT^XMXUTIL
 S XMOK=1
 Q
