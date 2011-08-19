XMGAPI2 ;(WASH ISC)/JKL-Get Msg Header Info API ;04/17/2002  08:57
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points (DBIA 1144):
 ; $$HDR  Get message header information
 ;
 ;USAGE:  S X=$$HDR^XMGAPI2(A,.B,C)
 ;WHERE: A=message or response #
 ;      .B=array into which data is placed
 ;       C=flag that determines what data is returned as follows:
 ;Not defined or 0 = returns a function value of 0 if successful, an
 ;   error message if unsuccessful, and a value array:
 ;   L("BROADCAST")= 1 if the message was broadcast; 0 otherwise
 ;   L("BSKT") = basket (of local user)
 ;   L("BSKT IEN") = basket IEN (of local user)
 ;   L("DATE") = origination date
 ;   L("DATE FM") = origination date in FileMan format
 ;   L("LINES") = number of lines in the original message
 ;   L("NEW") = 1 if the message is new; 0 otherwise
 ;   L("PXMZ") = pointer to the original message
 ;   L("SENDER") = sender name
 ;   L("SENDER DUZ") = sender DUZ
 ;   L("SUBJ") = subject
 ;   L("SURROG") = surrogate (DUZ if local user or string if not)
 ;   L("TYPE") = message type(s)
 ;   L("XMZ") = message or response number
 ;1 = returns function value and value array above, also
 ;    additional value array as follows:
 ;   L("RRED") = responses read
 ;   L("RRCV") = responses received
 ;   L("BLOBCNT") = number of non-textual body parts attached
 ;91= returns function value, value array as with flag 1,
 ;    and an array of response nodes and values as follows:
 ;   L("RSP",counter)= (pointer to 3.9 file) / array of responses
 ;92= returns function value, value array as with flag 1,
 ;    and an array of non-textual body parts as follows:
 ;   L("BLOB",counter) = (pointer to 2005 file) array of BLOBS
 ;93= returns function value, value array as with flag 1,
 ;    response node array, and an array of non-textual body parts.
HDR(XMZ,L,F) ;Entry for non-MailMan (documented)
GO N %,%0,D,XMBCAST
 S %=$G(XMZ) I +%'=%!(%<1) S %="1-Undefined message number" G ERR
 I XMZ="" S %="1-No message number" G ERR
 S %0=$G(^XMB(3.9,XMZ,0)) I %0="" S %="1-No such message" G ERR
 S D=$S($G(XMDUZ):XMDUZ,1:DUZ)
 I $S(+D'=D:1,D'>0:1,'$D(^XMB(3.7,D,0)):1,1:0) S %="4-Invalid user" G ERR
 S %=$P(%0,U,8),%=$S(%:%,1:XMZ)
 S XMBCAST=$S($D(^XMB(3.9,%,1,"C","* (Broadcast to all local users)")):1,$D(^XMB(3.9,%,1,"C","* (Broadcast to all local user")):1,1:0)
 I $S($P(%0,U,2)=D:0,$D(^XMB(3.9,%,1,"C",D)):0,XMBCAST:0,1:1) S %="2-User is not a sender or recipient." G ERR
 I $G(F)=""!'$G(F) S F=0   ;Default FLAG
 N %1,%2,XMK
 S %1=$$NET^XMRENT(XMZ)    ;get message information
 I %1="" S %="4-Message not defined" G ERR
 S L("BROADCAST")=XMBCAST
 S L("XMZ")=XMZ            ;set message number into array
 S L("DATE")=$P(%1,U)      ;get origination date
 S %2=$P(%0,U,3)
 S L("DATE FM")=$S(%2?7N1".".N:%2,%2?7N:%2,1:$$CONVERT^XMXUTIL1(%2))
 S:L("DATE FM")<2000000 L("DATE FM")=""
 S L("SENDER")=$P(%1,U,3)  ;get sender
 S L("SENDER DUZ")=$S($P(%0,U,2):$P(%0,U,2),1:"")
 S L("PXMZ")=$P(%1,U,7)    ;get pointer to original message
 S L("TYPE")=$P(%1,U,8)    ;Message Type(s)
 ;get number of message lines
 S L("LINES")=$S($D(^XMB(3.9,XMZ,2,0)):$P(^(0),U,4),1:"")
 S L("SUBJ")=$P(%1,U,6)    ;get subject
 S L("SURROG")=$P(%1,U,5)  ;get surrogate
 S XMK=$O(^XMB(3.7,"M",XMZ,D,0))  ;get basket
 I XMK,$D(^XMB(3.7,D,2,XMK,0)) D
 . S L("BSKT")=$P(^(0),U)
 . S L("BSKT IEN")=XMK
 E  D
 . S L("BSKT")=""
 . S L("BSKT IEN")=""
 I $G(XMK) S L("NEW")=$S($D(^XMB(3.7,D,"N0",XMK,XMZ)):1,1:0)
 G Q:F=0
 ;get responses read/received
 S L("RRED")="",L("RRCV")="",%1=$O(^XMB(3.9,XMZ,1,"C",D,0))
 I %1 S L("RRED")=$P(^XMB(3.9,XMZ,1,%1,0),U,2)
 I $D(^XMB(3.9,XMZ,3,0)) S L("RRCV")=$P(^(0),U,4)
 S L("BLOBCNT")=0          ;get blob count
 I $D(^XMB(3.9,XMZ,2005,0)) S L("BLOBCNT")=$P(^(0),U,3)
 G Q:F=1,BLOB:F=92
 ;flag=91 - get response numbers and values
 S %1=0 F  S %1=$O(^XMB(3.9,XMZ,3,%1)) Q:'%1  S L("RSP",%1)=^(%1,0)
 I F=91 G Q
 ;flag=92 - get nodes and values of non-textual body parts
BLOB S %1=0 F  S %1=$O(^XMB(3.9,XMZ,2005,%1)) Q:'%1  S L("BLOB",%1)=^(%1,0)
Q Q 0
ERR Q %
