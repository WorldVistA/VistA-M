XMXLIST ;ISC-SF/GMB-List message: multiple conditions ;03/01/2001  09:40
 ;;8.0;MailMan;;Jun 28, 2002
LISTMSGS(XMDUZ,XMK,XMFLDS,XMFLAGS,XMAMT,XMSTART,XMF,XMTROOT) ;
 ; XMDUZ is the user doing the search
 ; XMK is the place to look
 ;              =number - Look in this basket of the mailbox of XMDUZ
 ;              =*      - Look in all baskets of the mailbox of XMDUZ
 ;              =!      - Look in the MESSAGE file for all messages
 ;                        that XMDUZ sent or received.  If XMFLAGS["U"
 ;                        and the user (DUZ) holds the XM SUPER SEARCH
 ;                        key, ALL messages are examined,
 ;                        regardless of ownership.
 ; XMFLDS is a list, separated by ';', of fields to retrieve.
 ; e.g. XMFLDS="SUBJ;DATE" means retrieve subject and date.
 ;       "BSKT" = basket (default: <basket ien>^<basket name>)
 ;                optionally followed by ":" and
 ;                "I" for basket IEN only (no 2nd piece)
 ;                "X" adds basket name xref
 ;                (If XMK="!", and msg is not in user's mailbox, will be:
 ;                 "0^* N/A *")
 ;       "DATE" = date sent (default: <internal date>^<dd mmm yy hh:mm>)
 ;                optionally followed by ":" and
 ;                "I" for internal date only (no 2nd piece)
 ;                "F" for FileMan date as the 2nd piece
 ;                "X" adds FileMan date xref
 ;       "FROM" = message from (default: <internal from>^<external from>)
 ;                optionally followed by ":" and
 ;                "I" for internal from only (no 2nd piece)
 ;                "X" adds external from xref
 ;       "LINE" = number of lines in the message
 ;       "NEW"  = is the msg new? (0=no; 1=yes; 2=yes, and priority, too)
 ;       "PRI"  = is the message priority? (0=no; 1=yes)
 ;       "READ" = how much of the message has the user read?
 ;                null   = has not read the message at all
 ;                0      = has read the message, but no responses
 ;                number = has read through this response
 ;       "RESP" = how many responses does the message have?
 ;                0      = none
 ;                number = this many
 ;       "SEQN" = sequence number in basket (If XMK="!", and msg is not
 ;                in user's mailbox, will not be returned at all.)
 ;       "SUBJ" = message subject (always external)
 ;                optionally followed by ":" and
 ;                "X" adds subject xref
 ; XMFLAGS are used to control processing
 ;              =B Backwards order (Default is traverse forward)
 ;              =U Ignore the file screen on file 3.9 so that all
 ;                 messages can be examined.  (valid only if user holds
 ;                 XM SUPER SEARCH key and XMK="!")
 ;              If XMK="!", the following flags are ignored:
 ;              =C Use basket C-xref (Default is message IEN)
 ;              =N New messages only (C flag ignored)
 ;              =P New Priority messages only (C, N flags ignored)
 ; XMAMT        How many?
 ;              =number - Get this many
 ;              =*      - Get all (default)
 ; XMSTART is used to start the lister going.  The lister will keep it
 ; updated from call to call.  (If XMK="!", FileMan handles XMSTART,
 ; and you should look at FM documentation for an explanation.)
 ; XMSTART("XMK")  Start with this basket IEN (valid only if XMK="*")
 ;                 Continues from there, with each successive call,
 ;                 to the end.
 ;                 (Default is to start with basket .5, the WASTE basket)
 ; XMSTART("XMZ")  Start AFTER this message IEN (valid only if no C flag)
 ;                 Continues from there, with each successive call,
 ;                 to the end.
 ;                 (Default is to start at the beginning (or end) of the
 ;                 basket)
 ; XMSTART("XMKZ") Start AFTER this message C-xref (valid only if C flag)
 ;                 Continues from there, with each successive call,
 ;                 to the end.
 ;                 (Default is to start at the beginning (or end) of the
 ;                 basket)
 ; XMF contains conditions which are 'and'ed together to select only
 ; those messages which meet the conditions.
 ; XMF("FROM")  Message is from this person
 ; XMF("FDATE") Message was sent on or after this date
 ;              (If XMK="!", make sure this doesn't conflict w/XMF("PD"))
 ; XMF("FLINE") Message has this many or more lines
 ; XMF("PD")    Message was sent in this period (FM equiv. of yyy/yyymm)
 ;              (default is current month) (valid only if XMK="!")
 ; XMF("RFROM") Message has a response from this person
 ; XMF("SUBJ")  Subject contains this string
 ; XMF("SUBJ","C") =0 - Search is not case-sensitive (default)
 ;                 =1 - Search is case-sensitive
 ; XMF("TDATE") Message was sent on or before this date
 ;              (If XMK="!", make sure this doesn't conflict w/XMF("PD"))
 ; XMF("TEXT")  Message contains this string
 ; XMF("TEXT","L") =1 - Look in message only (default)
 ;                 =2 - Look in both message and responses
 ;                 =3 - Look in responses only
 ; XMF("TEXT","C") =0 - Search is not case-sensitive (default)
 ;                 =1 - Search is case-sensitive
 ; XMF("TLINE") Message has this many or fewer lines
 ; XMF("TO")    Message is to this person
 ; XMTROOT is the target root to receive the message list.
 ;              (default is ^TMP("XMLIST",$J))
 ;
 ; Variables set and used by the routine:
 ; XMF("SUBJ","S") Look for this string in the subject
 ; XMF("TEXT","S") Look for this string in the message
 ; XMF("PD","S")   Look for messages created during this period
 N XMORDER
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC Q
 D INIT(.XMFLDS,.XMFLAGS,.XMAMT,.XMORDER,.XMF,.XMTROOT)
 I XMK="!" D ALLMSGS(XMDUZ,$G(XMFLAGS),XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT) Q
 I XMK="*" D  Q
 . I XMFLAGS["P" D NEWA^XMXLIST1(XMDUZ,"N",XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT) Q
 . I XMFLAGS["N" D NEWA^XMXLIST1(XMDUZ,"N0",XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT) Q
 . I XMFLAGS["C" D REGAC^XMXLIST1(XMDUZ,XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT) Q
 . D REGAZ^XMXLIST1(XMDUZ,XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT)
 N XMKN
 S XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)
 I XMFLAGS["P" D NEW1^XMXLIST2(XMDUZ,XMK,XMKN,"N",XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT) Q
 I XMFLAGS["N" D NEW1^XMXLIST2(XMDUZ,XMK,XMKN,"N0",XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT) Q
 I XMFLAGS["C" D REG1C^XMXLIST2(XMDUZ,XMK,XMKN,XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT) Q
 D REG1Z^XMXLIST2(XMDUZ,XMK,XMKN,XMORDER,.XMFLDS,XMAMT,.XMSTART,.XMF,XMTROOT)
 Q
INIT(XMFLDS,XMFLAGS,XMAMT,XMORDER,XMF,XMTROOT) ;
 I $D(XMFLDS),XMFLDS="" K XMFLDS
 I $D(XMTROOT),XMTROOT'="" D
 . K @$$CREF^DILF(XMTROOT)
 . S XMTROOT=$$OREF^DILF(XMTROOT)_"""XMLIST"","
 E  D
 . K ^TMP("XMLIST",$J)
 . S XMTROOT="^TMP(""XMLIST"",$J,"
 I $D(XMF) D
 . I $D(XMF)'>9 K XMF Q
 . S:$D(XMF("SUBJ")) XMF("SUBJ","S")=$S('$G(XMF("SUBJ","C")):$$UP^XLFSTR(XMF("SUBJ")),1:XMF("SUBJ"))
 . I $D(XMF("TEXT")) D
 . . S XMF("TEXT","S")=$S('$G(XMF("TEXT","C")):$$UP^XLFSTR(XMF("TEXT")),1:XMF("TEXT"))
 . . I '$D(XMF("TEXT","L")) S XMF("TEXT","L")=1
 . I $D(XMF("PD")) S XMF("PD","S")=$S($E(XMF("PD"),4,5)="00":$E(XMF("PD"),1,3),1:$E(XMF("PD"),1,5))
 . I $D(XMF("FROM")) S XMF("FROM")=$$UP^XLFSTR(XMF("FROM"))
 . I $D(XMF("RFROM")) S XMF("RFROM")=$$UP^XLFSTR(XMF("RFROM"))
 . I $D(XMF("TO")),XMF("TO")["@" S XMF("TO")=$$UP^XLFSTR(XMF("TO"))
 S XMFLAGS=$G(XMFLAGS)
 S XMORDER=$S(XMFLAGS["B":-1,1:1)
 I $G(XMAMT)="" S XMAMT="*"
 Q
ALLMSGS(XMDUZ,XMFLAGS,XMORDER,XMFLDS,XMAMT,XMSTART,XMF,XMTROOT) ; Look in the entire MESSAGE file.
 N XMSCREEN,XMK,XMKN,XMZ,I,XMNA,XMCNT
 I XMFLAGS["U",'$$SSPRIV^XMXSEC1 Q
 S XMFLAGS=$TR(XMFLAGS,"CNP")
 I XMFLAGS["U" D AUDIT^XMJMFC(.XMF) Q:$D(XMERR)
 S XMSCREEN=$$SCREEN^XMJMFC(XMDUZ)
 ; File screen ^DD(3.9,0,"SCR") insists that user be author or recipient.
 ; If FLAGS["U", then file screen is ignored.
 D LIST^DIC(3.9,"","@",XMFLAGS,XMAMT,.XMSTART,$G(XMF("PD","S"),$E(DT,1,5)),"C",XMSCREEN)
 S I="",XMCNT=0,XMNA=$$EZBLD^DIALOG(34014) ; * N/A *
 F  S I=$O(^TMP("DILIST",$J,2,I),XMORDER) Q:I'>0  D
 . S XMZ=^TMP("DILIST",$J,2,I)
 . S XMCNT=XMCNT+1
 . S @(XMTROOT_XMCNT_")")=XMZ
 . Q:'$D(XMFLDS)
 . I $S(XMFLDS["BSKT":1,XMFLDS["NEW":1,XMFLDS["SEQN":1,1:0) D
 . . S XMK=+$O(^XMB(3.7,"M",XMZ,XMDUZ,0))
 . . S XMKN=$S(XMK:$P(^XMB(3.7,XMDUZ,2,XMK,0),U),1:XMNA)
 . . Q:'XMK
 . . I '$D(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)) D ADDITM^XMUT4A(XMDUZ,XMK,XMZ)
 . . I XMFLDS["SEQN" D KSEQN^XMXLIST1(XMDUZ,XMK,XMZ,.XMFLDS,XMTROOT,XMCNT)
 . D FIELDS^XMXLIST1(XMDUZ,.XMK,.XMKN,XMZ,.XMFLDS,XMTROOT,XMCNT)
 S @(XMTROOT_"0)")=$G(^TMP("DILIST",$J,0)) ; # found^# requested^more?
 K ^TMP("DILIST",$J)
 Q
