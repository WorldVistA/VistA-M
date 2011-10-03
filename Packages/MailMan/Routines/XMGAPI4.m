XMGAPI4 ;(WASH ISC)/CAP-Get New Msg Info ;04/17/2002  09:01
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points (DBIA 1201 - Private!):
 ; $$NU   Get new message info
NU(XMFORCE,XMMOVE,XMOUT) ;API for new message display
 ;Usage:  S X=$$NU^XMGAPI4(1) = Display on screen
 ;        S X=$$NU^XMGAPI4(0) = Do not display
 ;        S X=$$NU^XMGAPI4(1,1,"ABC") Return displayable array "ABC"
 ;
 ;Inputs:  DUZ must exist
 ;         XMDUZ will exist if the context is in MailMan
 ;
 ;XMFORCE=1 to force new display
 ;       =0 for no display
 ;XMMOVE =1 will cause an array to be passed back in array XMOUT,
 ;          which should be passed in by value (as a quoted string).
 N XMARRAY,XMI,XMNEW
 D CHKMASTR($G(XMDUZ,DUZ),XMFORCE,.XMNEW,.XMARRAY,.XMI)
 I $G(XMMOVE),$G(XMOUT)?1.AN S XMARRAY=+$G(XMI) M @XMOUT=XMARRAY Q XMNEW
 ;Return values or write
 I XMFORCE S XMI=0 F  S XMI=$O(XMARRAY(XMI)) Q:'XMI  W !,XMARRAY(XMI)
 Q XMNEW
CHK ; Sets Y = number of new messages for the user.
 S:$G(XMDUZ)'=.6 Y=$$TNMSGCT^XMXUTIL($G(XMDUZ,DUZ))
 D CLEANUP^XMXADDR
 Q
CHKMASTR(XMUSER,XMFORCE,XMNEW,XMARRAY,XMI) ;
 D CHKUSER(XMUSER,XMFORCE,.XMNEW,.XMARRAY,.XMI)
 D CHKPRI(XMUSER,.XMARRAY,.XMI)
 Q:XMUSER=.5!'XMFORCE!'$D(^XMB(3.7,"AB",XMUSER,.5))
 Q:'$$TNMSGCT^XMXUTIL(.5)
 S XMI=$G(XMI)+1,XMARRAY(XMI)=""
 S XMI=XMI+1,XMARRAY(XMI)=$$EZBLD^DIALOG(38162) ; Checking POSTMASTER mailbox.
 D CHKUSER(.5,XMFORCE,.XMNEW,.XMARRAY,.XMI)
 Q
CHKUSER(XMUSER,XMFORCE,XMNEW,XMARRAY,XMI) ;
 I '$D(^XMB(3.7,XMUSER,0)) S XMNEW=0 Q
 N XMREC,XMPARM
 S XMREC=$$NEWS^XMXUTIL(XMUSER,$D(DUZ("SAV")))
 S XMNEW=$P(XMREC,U,1)  ; new messages
 Q:'XMFORCE!'XMNEW
 S XMPARM(1)=$P(XMREC,U,1) S:XMUSER=.5 XMPARM(2)=$$NAME^XMXUTIL(.5)
 S XMI=$G(XMI)+1,XMARRAY(XMI)=$$EZBLD^DIALOG($S(XMUSER=DUZ:38155,1:38156)+$S(XMPARM(1)>1:0,'XMPARM(1):.2,1:.1),.XMPARM) ; You have/|2| has |1|/no new message(s).
 I $P(XMREC,U,6) D  ; new messages in the default read (usually IN) basket.
 . S XMPARM(1)=$P(XMREC,U,6),XMPARM(2)=$P(XMREC,U,8)
 . S XMARRAY(XMI)=XMARRAY(XMI)_$$EZBLD^DIALOG(38157,.XMPARM) ; (|1| in the '|2|' basket)
 I $P(XMREC,U,5) D  ; if last arrival > latest notification...
 . S XMI=XMI+1,XMARRAY(XMI)=$$EZBLD^DIALOG(38158,$$MMDT^XMXUTIL1($P(XMREC,U,4))) ; (Last arrival: |1|)"
 Q:XMUSER=.5
 S XMI=XMI+1,XMARRAY(XMI)=""
 S XMI=XMI+1,XMARRAY(XMI)=$$EZBLD^DIALOG(38161) ; Enter '^NML' to read your new messages.
 Q
CHKPRI(XMUSER,XMARRAY,XMI) ;
 Q:'$D(^XMB(3.7,XMUSER,"N"))
 I '$D(IORVON) N IORVON,IORVOFF,IOBON,IOBOFF D ZIS^XM
 S XMI=$G(XMI)+1,XMARRAY(XMI)=$G(IORVON)_$$EZBLD^DIALOG(38159)_$G(IORVOFF) ; You've got PRIORITY mail!
 Q
 ; >>>> I don't think anything after here is used. <<<<
LST(A,X,Y) ;List NEW message (or any other) array
 ; A=Array to list
 ; X=X address of box
 ; Y=Y address of box
 N I,S
 S I="",$P(S," ",IOM+1)=""
 F  S I=$O(A(I)) Q:I=""  D
 . I $G(X) S DX=X,DY=Y X IOXY
 . E  W !
 . W $E(A(I)_S,1,IOM-$G(X))
 . I $D(Y) S Y=Y+1
 Q
PRIALRT ; Priority Mail Alert
 N XQAID
 S XQAID="XM-PRIOMESS" D ALERT
 I '$D(XMDUZ) N XMDUZ S XMDUZ=DUZ
 W !,"Select new PRIORITY messages (one at a time) from the list given."
 D INIT^XMVVITAE
 D LISTALL^XMJMLN(XMDUZ,"N")
 Q
NEWALRT ; Alert for NEW Mail
 N XQAID
 S XQAID="XM-NEWMESS" D ALERT
 I '$D(XMDUZ) N XMDUZ S XMDUZ=DUZ
 W !,"Select NEW messages (one at a time) from the list given."
 D INIT^XMVVITAE
 D LISTALL^XMJMLN(XMDUZ,"N0")
 Q
ALERT ;
 N X,XQAKILL
 S X=$$NU(1,1,"X")
 D LST(.X)
 S XQA($S($G(XMDUZ):XMDUZ,1:DUZ))="",XQAKILL=1
 D DELETEA^XQALERT
 Q
