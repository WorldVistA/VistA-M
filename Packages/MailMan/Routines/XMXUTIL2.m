XMXUTIL2 ;ISC-SF/GMB-Message info ;04/19/2002  13:34
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2736.
QRESP(XMZ,XMZREC,XMWHICH) ; Function returns 0 if message XMZ is a message.
 ; If message XMZ is a response, returns XMZ of original message
 ; and, optionally, the response number as the second piece.
 ; in:
 ; XMZ     XMZ of the message to be checked
 ; XMZREC  (optional) 0-node of the message
 ; XMWHICH (optional) If the message is a response, should MailMan also
 ;         return the response number as the second piece?
 ;         (0=no (default); 1=yes)
 N XMZO
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 S XMZO=$S($P(XMZREC,U,8):$P(XMZREC,U,8),$P(XMZREC,U)?1"R"1.N:+$E(XMZREC,2,99),1:"")
 ; The following test (XMZO'=XMZ) is necessary,
 ; because some old messages point to themselves as responses.
 I XMZO,XMZO'=XMZ Q:'$G(XMWHICH) XMZO  D  Q XMZO_U_XMWHICH
 . S XMWHICH=0 ; This is a response to message XMZO.
 . F  S XMWHICH=$O(^XMB(3.9,XMZO,3,XMWHICH)) Q:'XMWHICH  Q:^(XMWHICH,0)=XMZ
 Q 0  ; This is a message.
INMSG(XMDUZ,XMK,XMZ,XMZREC,XMFLAGS,XMIM,XMINSTR,XMIU) ;
 ; Should NOT be called for responses!
 ; XMFLAGS        If XMFLAGS["I" return internal only
 ;                          ["F" return FM date
 ; XMIU("KVAPOR") If applicable, user-specified vaporize date for message in basket
 ; XMIU("NEW")    Is message new? (0=no; 1=yes; 2=yes, and priority, too)
 D INMSG1(XMDUZ,XMZ,.XMZREC,.XMFLAGS,.XMIM,.XMIU)
 D INMSG2(XMDUZ,XMZ,XMZREC,.XMIM,.XMINSTR,.XMIU)
 Q:'XMK
 N XMKREC
 S XMKREC=$G(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0))
 I $P(XMKREC,U,5) S XMIU("KVAPOR")=$P(XMKREC,U,5)
 S XMIU("NEW")=$$NEW(XMDUZ,XMK,XMZ)
 Q
INMSG1(XMDUZ,XMZ,XMZREC,XMFLAGS,XMIM,XMIU) ; (Should NOT be called for responses!)
 ; XMIM("RESPS")
 ; XMIU("IEN")
 ; XMIU("RESP")
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 S XMFLAGS=$G(XMFLAGS)
 D INM(XMZ,XMZREC,XMFLAGS,.XMIM)
 I $D(XMIU) K XMIU
 S XMIU("IEN")=+$O(^XMB(3.9,XMZ,1,"C",XMDUZ,0))
 D INRESPS(XMZ,.XMIM,.XMIU)
 Q
INM(XMZ,XMZREC,XMFLAGS,XMIM) ; For internal MailMan use only.
 ; XMIM and XMIU are killed first
 ; out:
 ; Always returned:
 ; XMIM("XMZ")
 ; XMIM("SUBJ")
 ; XMIM("FROM")
 ; XMIM("DATE")
 ; XMIM("CRE8")
 ; XMIM("SENDR")
 ; XMIM("LINES")
 ; XMIM("ENV FROM") 'Envelope From' returned only if it exists
 ; Returned if XMFLAGS'["I":
 ; XMIM("FROM DUZ")
 ; XMIM("FROM NAME")
 ; XMIM("DATE FM")     Returned if XMFLAGS["F"
 ; XMIM("DATE MM")     Returned if XMFLAGS'["F"
 ; XMIM("CRE8 MM")     Returned if XMFLAGS'["F"
 ; XMIM("SENDR DUZ")
 ; XMIM("SENDR NAME")
 I $D(XMIM) K XMIM
 S XMIM("XMZ")=XMZ
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 S XMIM("SUBJ")=$$SUBJ^XMXUTIL2(XMZREC)
 S XMIM("FROM")=$P(XMZREC,U,2)
 S XMIM("DATE")=$P(XMZREC,U,3)
 S XMIM("SENDR")=$P(XMZREC,U,4)
 S XMIM("CRE8")=$P($G(^XMB(3.9,XMZ,.6)),U)
 S XMIM("LINES")=+$P($G(^XMB(3.9,XMZ,2,0)),U,4)
 I $D(^XMB(3.9,XMZ,.7)) D
 . N XMNVFROM
 . S XMNVFROM=$P($G(^XMB(3.9,XMZ,.7)),U,1)
 . I XMNVFROM'="" S XMIM("ENV FROM")=XMNVFROM
 Q:XMFLAGS["I"
 I +XMIM("FROM")'=XMIM("FROM") S XMIM("FROM NAME")=XMIM("FROM")
 E  S XMIM("FROM DUZ")=XMIM("FROM"),XMIM("FROM NAME")=$$NAME^XMXUTIL(XMIM("FROM"))
 I XMIM("SENDR")'="" D
 . I +XMIM("SENDR")'=XMIM("SENDR") S XMIM("SENDR NAME")=XMIM("SENDR")
 . E  S XMIM("SENDR DUZ")=XMIM("SENDR"),XMIM("SENDR NAME")=$$NAME^XMXUTIL(XMIM("SENDR"))
 I XMFLAGS["F" D  Q
 . I XMIM("DATE")?7N.E S XMIM("DATE FM")=XMIM("DATE") Q
 . S XMIM("DATE FM")=$$CONVERT^XMXUTIL1(XMIM("DATE"),1)
 S XMIM("DATE MM")=$$DATE(XMZREC,1) ; MailMan date
 S XMIM("CRE8 MM")=$$MMDT^XMXUTIL1(XMIM("CRE8")) ; MailMan date
 Q
INRESPS(XMZ,XMIM,XMIU) ; How many responses?  What's the user read?
 ; In:
 ; XMZ
 ; XMIU("IEN")   ien of user's record in recipient multiple
 ; Out:
 ; XMIM("RESPS") message has this many responses
 ; XMIU("RESP")  last response read by the user
 ;               (null=not read at all; 0=original msg only; number=resp)
 S XMIM("RESPS")=+$P($G(^XMB(3.9,XMZ,3,0)),U,4)
 S XMIU("RESP")=$P($G(^XMB(3.9,XMZ,1,XMIU("IEN"),0)),U,2)
 Q
INRESP(XMZ,XMIEN,XMFLAGS,XMIR) ; Get info on a response to a message.
 ; In:
 ; XMZ     XMZ of original message
 ; XMIEN   Which response (1 thru # of responses)
 ; XMFLAGS If XMFLAGS["I" return internal only
 ;                   ["F" return FM date
 ; Out:
 ; XMIR   
 N XMZREC,XMZR
 K XMIR
 I '$D(^XMB(3.9,XMZ,3,XMIEN)) Q
 S XMZR=$G(^XMB(3.9,XMZ,3,XMIEN,0)) Q:'XMZR
 S XMZREC=$G(^XMB(3.9,XMZR,0))
 D INM(XMZR,XMZREC,XMFLAGS,.XMIR)
 ;Q:XMIR("SUBJ")'?1"R".N
 ;Q:XMFLAGS["I"
 ;S XMZREC=$G(^XMB(3.9,XMZ,0)) Q:XMZREC=""
 ;S XMIR("SUBJ X")="Re: "_$P(XMZREC,U,1)
 ;I XMIR("SUBJ X")["~U~" S XMIR("SUBJ")=$$DECODEUP^XMXUTIL1(XMIR("SUBJ X"))
 Q
INMSG2(XMDUZ,XMZ,XMZREC,XMIM,XMINSTR,XMIU) ;
 ; Should NOT be called for responses!
 ; Does not kill XMIM, XMINSTR, or XMIU first
 ; XMIM("RECIPS")   number of recipients of the message
 ; XMIU("ORIGN8")   user sent message (0=no; 1=yes)
 ; The following are set only if applicable:
 ; XMINSTR("FLAGS")
 ; XMINSTR("RCPT BSKT")
 ; XMINSTR("TYPE")
 ; XMINSTR("VAPOR")
 ; XMINSTR("SCR HINT")
 S XMIM("RECIPS")=$P($G(^XMB(3.9,XMZ,1,0)),U,4)
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 S XMIU("ORIGN8")=$$ORIGIN8R^XMXSEC(XMDUZ,XMZREC)
 S:$P(XMZREC,U,6)'="" XMINSTR("VAPOR")=$P(XMZREC,U,6)
 S XMINSTR("TYPE")=$P(XMZREC,U,7)  ; Msg type (regular, KIDS, etc.)
 I $$PAKMAN^XMXSEC1(XMZ,XMZREC) D
 . Q:XMINSTR("TYPE")["K"  ; KIDS
 . S:XMINSTR("TYPE")'["X" XMINSTR("TYPE")=XMINSTR("TYPE")_"X" ; PackMan
 S XMINSTR("FLAGS")=""
 S:"^Y^y^"[(U_$P(XMZREC,U,5)_U) XMINSTR("FLAGS")=XMINSTR("FLAGS")_"R" ; confirmation requested
 S:"^Y^y^"[(U_$P(XMZREC,U,9)_U) XMINSTR("FLAGS")=XMINSTR("FLAGS")_"X" ; closed
 S:"^Y^y^"[(U_$P(XMZREC,U,11)_U) XMINSTR("FLAGS")=XMINSTR("FLAGS")_"C" ; confidential
 S:"^Y^y^"[(U_$P(XMZREC,U,12)_U) XMINSTR("FLAGS")=XMINSTR("FLAGS")_"I" ; information only
 I $P(XMZREC,U,10)'="" S XMINSTR("SCR HINT")=$P(XMZREC,U,10)
 I $D(^XMB(3.9,XMZ,.5)) D
 . N XMZBSKT
 . S XMZBSKT=$P(^XMB(3.9,XMZ,.5),U,1)
 . S:XMZBSKT'="" XMINSTR("RCPT BSKT")=XMZBSKT
 Q:XMINSTR("TYPE")'["P"
 S XMINSTR("FLAGS")=XMINSTR("FLAGS")_"P" ; priority
 S XMINSTR("TYPE")=$TR(XMINSTR("TYPE"),"P")
 S:'$P($G(^XMB(3.9,XMZ,1,XMIU("IEN"),0)),U,9) XMINSTR("FLAGS")=XMINSTR("FLAGS")_"K" ; priority responses
 Q
ZNODE(XMZ) ; Returns the zero node of the message.
 Q $G(^XMB(3.9,XMZ,0))
ZDATE(XMZ,XMTIME) ; What is the message date? (Formatted by $$MMDT^XMXUTIL1)
 ; XMTIME =0 Date only
 ;        =1 Date and time (default)
 Q $$DATE($G(^XMB(3.9,XMZ,0)),.XMTIME)
DATE(XMZREC,XMTIME) ; What is the message date? (Formatted by $$MMDT^XMXUTIL1)
 ; XMTIME =0 Date only
 ;        =1 Date and time (default)
 N XMDATE
 S XMDATE=$P(XMZREC,U,3)
 S XMTIME=+$G(XMTIME,1)
 I XMDATE?7N.E Q $$MMDT^XMXUTIL1($S(XMTIME:XMDATE,1:$E(XMDATE,1,7)))
 N XMFM
 S XMFM=$$CONVERT^XMXUTIL1(XMDATE,XMTIME)
 I XMFM=-1 Q XMDATE
 Q $$MMDT^XMXUTIL1(XMFM)
ZSUBJ(XMZ) ; What is the message subject?
 Q $$SUBJ($G(^XMB(3.9,XMZ,0)))
SUBJ(XMZREC) ; What is the message subject?
 N XMSUBJ
 S XMSUBJ=$P(XMZREC,U,1)
 I XMSUBJ="" Q $$EZBLD^DIALOG(34012) ;* No Subject *
 I XMSUBJ["~U~" Q $$DECODEUP^XMXUTIL1(XMSUBJ)
 Q XMSUBJ
ZFROM(XMZ) ; Who sent the message?
 Q $$FROM($G(^XMB(3.9,XMZ,0)))
FROM(XMZREC) ; Who sent the message?
 Q $$NAME^XMXUTIL($P(XMZREC,U,2))
ZPRI(XMZ) ; Is the message priority?
 Q $$PRI($G(^XMB(3.9,XMZ,0)))
PRI(XMZREC) ; Is the message priority?
 Q $P(XMZREC,U,7)["P"
LINE(XMZ) ; How many lines does the message have?
 Q +$P($G(^XMB(3.9,XMZ,2,0)),U,4)
RESP(XMZ) ; How many responses does this message have?
 Q +$P($G(^XMB(3.9,XMZ,3,0)),U,4)
ZREAD(XMDUZ,XMZ) ; How many responses has the user read?
 ; null   = the user has not read the message
 ; 0      = the user has read the original message only
 ; number = the user has read through this response
 N XMUPTR
 ;S XMUPTR=$O(^XMB(3.9,XMZ,1,"C",$S(XMDUZ=.6:DUZ,1:XMDUZ),0))
 S XMUPTR=+$O(^XMB(3.9,XMZ,1,"C",XMDUZ,0))
 ;Q:'XMUPTR ""
 Q $$READ($G(^XMB(3.9,XMZ,1,XMUPTR,0)))
READ(XMZUREC) ; How many responses has the user read?
 ; null   = the user has not read the message
 ; 0      = the user has read the original message only
 ; number = the user has read through this response
 Q $P(XMZUREC,U,2)
BSKT(XMDUZ,XMZ,XMNAME) ; Which basket is the message in for this user?
 ; in:
 ; XMDUZ,XMZ
 ; XMNAME Return basket name as second piece? 0=no (default); 1=yes
 ; returns:
 ; 0           = it's not in any basket
 ; number      = it's in this basket ien      ($G(XMNAME)=0)
 ; number^name = it's in this basket ien^name (XMNAME=1)
 N XMK
 S XMK=+$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 I 'XMK Q XMK
 I '$G(XMNAME) Q XMK
 Q XMK_U_$P($G(^XMB(3.7,XMDUZ,2,XMK,0)),U,1)
NEW(XMDUZ,XMK,XMZ) ; Is the message new for this user?
 ; 0 = no; 1 = yes; 2 = yes, and it's priority, too.
 Q:$D(^XMB(3.7,XMDUZ,"N",XMK,XMZ)) 2
 Q:$D(^XMB(3.7,XMDUZ,"N0",XMK,XMZ)) 1
 Q 0
KSEQN(XMDUZ,XMK,XMZ) ; What's the seqence number for this message in this user's basket?
 Q $$SEQN($G(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)))
SEQN(XMKZREC) ; What's the seqence number for this message in this user's basket?
 Q $P(XMKZREC,U,2)
