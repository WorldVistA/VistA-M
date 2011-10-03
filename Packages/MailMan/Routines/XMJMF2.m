XMJMF2 ;ISC-SF/GMB-XMJMF (cont.) ;07/12/2002  10:11
 ;;8.0;MailMan;;Jun 28, 2002
B ; Search one basket
 N XMDIC,XMFBSKT
 S XMDIC("B")=$G(XMFBSKTN,$$EZBLD^DIALOG(37005)) ; IN
 D SELBSKT^XMJBU(XMDUZ,34439,"",.XMDIC,.XMFBSKT,.XMFBSKTN) I XMFBSKT=U S XMABORT=1 Q  ; Select basket to search:
 S XMF("BSKT")=XMFBSKT
 Q
BA ; Search all baskets
 S XMF("BSKT")="*"
 Q
DA ; Message sent on or after date
 N DIR,Y,X
 S DIR(0)="DO^:"_$G(XMF("TDATE"),DT)_":EX"
 S DIR("A")=$$EZBLD^DIALOG(34444) ; Message sent on or after
 D BLD^DIALOG(34444.1,"","","DIR(""?"")")
 ; Enter a date.  It must include day, month, and year.
 S:$D(XMF("FDATE")) DIR("B")=XMFFDTX
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 I X="@" D  Q
 . I XMK="!" D NODELETE Q
 . K XMF("FDATE")
 Q:Y=""
 S XMF("FDATE")=Y
 S XMFFDTX=$$MMDT^XMXUTIL1(XMF("FDATE"))
 Q
NODELETE ;This search requires a date range.
 ;You may change the dates, but you may not delete them.
 N XMTEXT
 D BLD^DIALOG(34444.5,"","","XMTEXT","F")
 D MSG^DIALOG("WE","","","","XMTEXT")
 D WAIT^XMXUTIL
 Q
DB ; Message sent on or before date
 N DIR,Y,X
 S DIR(0)="DO^"_$G(XMF("FDATE"))_":DT:EX"
 S DIR("A")=$$EZBLD^DIALOG(34445) ; Message sent on or before
 D BLD^DIALOG(34444.1,"","","DIR(""?"")")
 ; Enter a date.  It must include day, month, and year.
 S:$D(XMF("TDATE")) DIR("B")=XMFTDTX
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 I X="@" D  Q
 . I XMK="!" D NODELETE Q
 . K XMF("TDATE")
 Q:Y=""
 S XMF("TDATE")=Y
 S XMFTDTX=$$MMDT^XMXUTIL1(XMF("TDATE"))
 Q
F ; Message from
 D GETPERS(XMDUZ,.XMF,"FROM",.XMFFRN,34440,34441,.XMABORT)
 Q
G ; Go search
 W !,$$EZBLD^DIALOG(34417) ; Searching...
 I XMK="!" D FIND^XMJMFC(XMDUZ,.XMF,1) Q
 I $G(XMF("BSKT"))="*" D FINDALL^XMJMFB(XMDUZ,.XMF) Q
 D FIND1^XMJMFB(XMDUZ,.XMF,1)
 Q
LM ; Message has this many lines or more
 N DIR,Y,X
 S DIR(0)="FO^1:12^K:'$$LMOK^XMJMF2(X) X"
 S DIR("A")=$$EZBLD^DIALOG(34449) ; Lines of text, minimum
 D BLD^DIALOG(34449.1,"","","DIR(""?"")")
 ; Enter a number from 100 to 100,000.
 ; We will find all messages with that many lines of text or more.
 S:$D(XMF("FLINE")) DIR("B")=XMF("FLINE")
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 I X="@" K XMF("FLINE") Q
 I Y S XMF("FLINE")=Y
 Q
LMOK(X) ;
 I X="@" Q 1
 I X'?1N.N Q 0
 I $G(XMF("TLINE")),X>XMF("TLINE") Q 0
 I X<100 Q 0
 I X>100000 Q 0
 Q 1
LX ; Message has this many lines or less
 N DIR,Y,X
 S DIR(0)="FO^1:12^K:'$$LXOK^XMJMF2(X) X"
 S DIR("A")=$$EZBLD^DIALOG(34450) ; Lines of text, maximum
 D BLD^DIALOG(34450.1,"","","DIR(""?"")")
 ; Enter a number from 100 to 100,000.
 ; We will find all messages with that many lines of text or less.
 S:$D(XMF("TLINE")) DIR("B")=XMF("TLINE")
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 I X="@" K XMF("TLINE") Q
 I Y S XMF("TLINE")=Y
 Q
LXOK(X) ;
 I X="@" Q 1
 I X'?1N.N Q 0
 I $G(XMF("FLINE")),X<XMF("FLINE") Q 0
 I X<100 Q 0
 I X>100000 Q 0
 Q 1
Q ; Quit
 S XMABORT=1
 Q
R ; Response from
 D GETPERS(XMDUZ,.XMF,"RFROM",.XMFRFRN,34440.1,34441.1,.XMABORT)
 Q
S ; Subject contains
 N DIR,Y,X
 S DIR(0)="FO^3:30"
 S DIR("A")=$$EZBLD^DIALOG(34438) ; Subject contains
 S:$D(XMF("SUBJ")) DIR("B")=XMF("SUBJ")
 D BLD^DIALOG(34438.1,"","","DIR(""?"")")
 ;Enter the string that the subject contains.
 ;It may be from 3 to 30 characters.
 ;The search is NOT case-sensitive.
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 I X="@" K XMF("SUBJ") Q
 Q:Y=""
 S XMF("SUBJ")=Y
 Q
T ; Message to
 D GETPERS(XMDUZ,.XMF,"TO",$G(XMF("TO")),34440.2,34441.2,.XMABORT)
 Q
X ; Message contains
 N DIR,Y,X
 S DIR(0)="FO^3:30"
 S DIR("A")=$$EZBLD^DIALOG(34446.1) ; Message contains
 S:$D(XMF("TEXT")) DIR("B")=XMF("TEXT")
 D BLD^DIALOG(34446.4,"","","DIR(""?"")")
 ;Enter the string to search for.  It may be from 3 to 30 characters.
 ;Note that if the string you are searching for is not all on one line
 ;in the message, the search will not be able to find it.
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 I X="@" K XMF("TEXT") Q
 Q:Y=""
 S XMF("TEXT")=Y
 K DIR,X,Y
 S DIR(0)="Y"
 S DIR("A")=$$EZBLD^DIALOG(34447) ; Should the search be case-sensitive
 S DIR("B")=$$EZBLD^DIALOG($S($G(XMF("TEXT","C"),1):39054,1:39053)) ; Yes/No
 D BLD^DIALOG(34447.1,"","","DIR(""?"")")
 ;Your answer determines whether case (upper/lower) matters in the search.
 ;It also affects the speed of the search.
 ;A case-sensitive search (one in which case matters) is faster.
 ;A case-insensitive search (one in which case does not matter) may find
 ;more matches, but will be slower.
 ;Answer YES for a faster search, when case matters.
 ;Answer NO for a slower search, when case does not matter.
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 S XMF("TEXT","C")=Y
 K DIR,X,Y N I
 S DIR("A")=$$EZBLD^DIALOG(34448) ; Where should we search
 ; x.1:Message only / x.2:Message and Responses / x.3:Responses only
 S DIR(0)=""
 F I=1,2,3 S DIR(0)=DIR(0)_";"_I_":"_$$EZBLD^DIALOG(34448+(I/10))
 S DIR(0)="S^"_$E(DIR(0),2,999)
 ; x.1:Message only / x.2:Message and Responses / x.3:Responses only
 S DIR("B")=$$EZBLD^DIALOG(34448+($G(XMF("TEXT","L"),1)/10))
 D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 S XMF("TEXT","L")=Y
 Q
GETPERS(XMDUZ,XMF,XMWHICH,XMNAME,XMPROMPT,XMHELP,XMABORT) ;
 N DIR,Y,X,XMOK
 S DIR(0)="FO^1:30"
 S DIR("A")=$$EZBLD^DIALOG(XMPROMPT) ; Message from / Message to / Response from
 S DIR("?")="^D HGETPERS^XMJMF2"
 I $D(XMF(XMWHICH)) D
 . S DIR("B")=XMNAME
 . I XMNAME'["@" S DIR(0)="FrO^1:30" ; ('r' means no 'replace...with...' prompt)
 . Q:XMWHICH'="TO"
 . Q:"^G.^g.^"'[(U_$E(XMNAME,1,2)_U)
 . N XMPRIVAT
 . S XMPRIVAT=$$EZBLD^DIALOG(39135) ; " [Private Mail Group]"
 . I XMNAME[XMPRIVAT S DIR("B")=$P(XMNAME,XMPRIVAT)
 F  D  Q:XMABORT!XMOK
 . S XMOK=1
 . D ^DIR I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 . I X="@" K XMF(XMWHICH),XMNAME Q
 . I Y="" Q
 . I X["@" S (XMNAME,XMF(XMWHICH))=$$UP^XLFSTR(Y) Q
 . I XMWHICH="TO" D  Q
 . . N XMINSTR
 . . K XMNAME
 . . S XMINSTR("ADDR FLAGS")="X"  ; don't create ^TMP("XMY" globals
 . . D ADDR^XMXADDR(XMDUZ,X,.XMINSTR,"",.XMNAME)
 . . I '$D(XMNAME) S XMOK=0 Q
 . . S XMF(XMWHICH)=XMNAME
 . N DIC,X
 . S X=Y
 . S DIC="^VA(200,",DIC(0)="MNEQ"
 . D ^DIC I $D(DUOUT)!$D(DTOUT) S XMABORT=1 Q
 . I Y=-1 S XMOK=0 Q
 . S XMF(XMWHICH)=+Y
 . S XMNAME=$$NAME^XMXUTIL(+Y)
 Q
HGETPERS ;
 N XMTEXT
 D BLD^DIALOG(XMHELP,"","","XMTEXT","F")
 ;Enter the name of the person who sent the message/response.
 ; - or -
 ;Enter the message addressee.  It may be a person, group, device, or server.
 I XMWHICH'="TO" D BLD^DIALOG(34441.3,"","","XMTEXT","F")
 ;If it's from a local VistA package/fake sender, just put '@' after
 ;the sender, like ACCOUNTS RECEIVABLE@
 D BLD^DIALOG(34442,"","","XMTEXT","F")
 ;For remote users, enter name@, name@domain, or @domain.
 ;'Name' must be found somewhere in the user's name.
 ;'Domain' must be found somewhere in the user's domain.
 ;The more characters you provide, the narrower the search will be.
 ;MailMan may capitalize some names to facilitate filtering.
 D MSG^DIALOG("WH","",IOM,"","XMTEXT")
 Q
