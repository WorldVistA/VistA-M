XMR4 ;ISC-SF/GMB-SMTP HELP ;04/17/2002  11:17
 ;;8.0;MailMan;;Jun 28, 2002
HELPME ;
 N XMALL
 S XMALL="HHHH^EXPN^HELO^HELP^MAIL^NOOP^QUIT^RCPT^RSET^TURN^VRFY"
 I XMP="ALL" D ALL G END
 I U_XMALL_U[(U_XMP_U) D SHOW(XMP) G END
 D SHOW("HHHH")
END I 'ER S XMSG="214 " X XMSEN
 Q
ALL ;
 N I,J
 F I=1:1:$L(XMALL,U) D SHOW($P(XMALL,U,I)) Q:ER
 Q
SHOW(XMCMD) ;
 N I
 F I=0:1 S XMSG="214-"_$P($T(@XMCMD+I),";",3,99) Q:$L(XMSG)=4  X XMSEN Q:ER
 Q
HHHH ;; 
 ;;This is the simple mail transfer protocol receiver
 ;;Commands currently understood are: 
 ;;HELO <domain> (which initiates a transaction)
 ;;MAIL FROM: <reverse-path>
 ;;RCPT TO: <forward-path>  (which names a recipient)
 ;;DATA (terminated with a single line of '.')
 ;;HELP (which displays this text)
 ;;NOOP (which does nothing)
 ;;RSET <reason for> which stops transmission of message
 ;;STAT (which displays the current status of the receiver)
 ;;VRFY <user> (which verifies the existence of a user)
 ;;TURN (Which turns around the line; Sender becomes receiver)
 ;;EXPN <mail group> (which lists the members of a group)
 ;;QUIT (which terminates the connection)
 ;; 
 ;;CHRS <domain> initialize a remote domain
 ;;Extensions:
 ;;MESS ID:XMREMID Sending message remote ID to allow processing to stop
 ;; 
 ;;Enter HELP ALL to see further discussion on all commands, or
 ;;HELP <command> to see further discussion of <command>.
 ;;
HELO ;; 
 ;;The HELO command is used to identify the sending host to the receiver:
 ;; 
 ;;   HELO <domain>
 ;; 
 ;; Where <domain> is the name of the sending host.
 ;; 
 ;;If the receiver will accept mail, it responds with its name.
 ;; 
 ;;The HELO command must be the first command of a mail sequence.
 ;;
MAIL ;; 
 ;;The MAIL command is used after a HELO command to ask a receiver to
 ;;accept a mail message.  The format is:
 ;; 
 ;;  MAIL FROM: <user>@<site>
 ;; 
 ;;where <user> is the name of the user sending the message, and <site>
 ;;is the name of the site sending the mail, in Internet domain
 ;;format.
 ;;
 ;;The receiver will respond with "250 OK" if accepted, and "501 Invalid
 ;;Reverse path specification" if not.
 ;; 
 ;;This command is followed with RCPT and DATA commands to name
 ;;and transfer the data, respectively.
 ;;
RCPT ;; 
 ;;This command is used to identify the recipients of the mail.
 ;;Its format is:
 ;; 
 ;;   RCPT TO: <user>
 ;; 
 ;;If the user is found, the receiver will respond with "250 OK";
 ;;Otherwise, it will say "501 Invalid forward path specification".
 ;; 
 ;;Each recipient of the message is named individually.  The VRFY
 ;;command can be used to confirm the existence of a user without
 ;;actually putting him on the recipient list. 
 ;;After recipients are specified, the DATA command is used to transfer
 ;;the body of the message.
 ;;
DATA ;; 
 ;;The DATA command is used after the MAIL and RCPT commands to transmit
 ;;the body of the message.  The command has no arguments.  The receiver's
 ;;response to the command is to either issue an error message:
 ;;"503 no recipients specified" or "354 Start mail input".
 ;; 
 ;;Data will be accepted until a line consisting of a single period is
 ;;detected.  If any line begins with a period, it must have an
 ;;additional period inserted at the beginning of the line.
 ;; 
 ;;After the DATA command is completed, the receiver will respond with
 ;;"250 OK" if the message was accepted, or an error message if 
 ;;otherwise.
 ;;
RSET ;; 
 ;;The RSET (Reset) command is used to reset the receiver to its initial
 ;;state and cancel any mail in progress.  The sender does not need to
 ;;issue HELO again.
 ;;
VRFY ;; 
 ;;The VRFY (Verify) command is used to verify the existence of a user
 ;;at the receiver.  The format is:
 ;; 
 ;;   VRFY <user>
 ;;  
 ;;The computer will respond with the user's full name if found, or
 ;;"550 User not found" if not.  This command can be issued at any 
 ;;time, and does not affect the recipient list.
 ;;
EXPN ;; 
 ;;The EXPN (Expand) command causes the receiver to expand a mailing
 ;;list, showing the sender the list of individuals in the list.
 ;;
HELP ;;
 ;;The HELP command displays user assistance information for interactive
 ;;users.  If issued without an argument, it gives a general introduction.
 ;;If given an argument naming a command, it gives further information
 ;;on that command.  If given an argument of "ALL", it displays 
 ;;help on all arguments.
 ;;
NOOP ;; 
 ;;The NOOP (no operation) command causes the receiver to respond with
 ;;a "250 OK" message.
 ;;
QUIT ;; 
 ;;The QUIT command is used to terminate the mail transfer process.
 ;;The connection will be closed, and any mail transfers not concluded
 ;;with a successful DATA command will be lost.
 ;;
TURN ;;  
 ;;
