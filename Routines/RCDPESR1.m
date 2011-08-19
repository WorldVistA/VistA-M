RCDPESR1 ;ALB/TMP - Server interface to AR from Austin ;06/03/02
 ;;4.5;Accounts Receivable;**173,214,208,202**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
PERROR(RCERR,RCEMG,RCXMZ) ; Process Errors - Send bulletin to mail group
 ; RCERR = Error text array
 ; RCEMG = name of the mail group to which these errors should be sent
 ; RCXMZ = internal entry # of the mailman msg
 ; RCTYPE = msg type, if known
 N CT,XMDUZ,XMSUBJ,XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,RCXM,XMZ,XMERR,Z
 ;
 S CT=0
 ;
 I $G(RCEMG)="" S CT=CT+1,RCXM(CT)=$P($T(ERROR+2),";;",2),XMTO(.5)=""
 ;
 I $D(RCEMG) D
 . S:RCEMG="" RCEMG="RCDPE PAYMENTS EXCEPTIONS"
 . S:$E(RCEMG,1,2)'="G." RCEMG="G."_RCEMG
 . S XMTO("I:"_RCEMG)=""
 ;
 S Z=$O(XMTO("")) I Z=.5,'$O(XMTO(.5)) S XMTO("I:G.RCDPE PAYMENTS EXCEPTIONS")=""
 D EMFORM(CT,.RCERR,.RCXM,RCXMZ)
 ;
 S XMDUZ=""
 S XMSUBJ="EDI LBOX SERVER OPTION ERROR",XMBODY="RCXM"
 D
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,XMSUBJ,XMBODY,.XMTO,,.XMZ)
 K ^TMP("RCRAW",$J)
 Q
 ;
EMFORM(CT,RCERR,RCXM,RCXMZ) ; Format error msgs
 ; INPUT:
 ;   CT = # of lines previously populated in error msg
 ;   RCERR = array of errors
 ;   RCXMZ = internal entry # of mailman msg
 ;
 ; OUTPUT:
 ;   RCXM = array containing the complete error msg text
 ;
 N TTYPE,TDATE,TTIME,Z
 ;
 S TDATE=$G(^TMP("RCERR",$J,"DATE")),TTIME=$P(TDATE,".",2)_"000000",TDATE=$$FMTE^XLFDT($P(TDATE,"."),"2D")
 S TTYPE=$G(^TMP("RCMSG",$J))
 ;
 S CT=CT+1
 S RCXM(CT)="** AN EXCEPTION HAS BEEN DETECTED FOR AN EDI LOCKBOX RETURN MESSAGE **",CT=CT+1,RCXM(CT)=" "
 S CT=CT+1
 S RCXM(CT)="             Return Message Code: "_$S(TTYPE="":$S($G(^TMP("RCERR",$J,"TYPE"))'="":^("TYPE"),1:"Cannot be determined"),1:TTYPE)
 ;
 S CT=CT+2
 S RCXM(CT-1)=" ",RCXM(CT)=$J("",13)_"Return Message Date: "_TDATE_"    Message Time: "_$E(TTIME,1,2)_":"_$E(TTIME,3,4)_":"_$E(TTIME,5,6),CT=CT+1
 ;
 S CT=CT+2,RCXM(CT-1)=" ",RCXM(CT)=$J("",15)_"Mailman Message #: "_$G(RCXMZ)
 ;
 I $G(RCERR)'="",RCERR?1A.E S CT=CT+2,RCXM(CT-1)=" ",RCXM(CT)=RCERR
 I $G(^TMP("RCERR",$J,"TEXT"))'="" S CT=CT+2,RCXM(CT)=^("TEXT"),RCXM(CT-1)=" "
 ;
 S Z="" F  S Z=$O(RCERR(Z)) Q:Z=""  S:$G(^TMP("RCERR",$J,"TEXT"))="" CT=CT+1,RCXM(CT)=" " I $G(RCERR(Z))'="",RCERR(Z)'=" " S CT=CT+1,RCXM(CT)=RCERR(Z)
 S Z=0 F  S Z=$O(^TMP("RCERR",$J,"MSG",Z)) Q:'Z  S CT=CT+1,RCXM(CT)=^(Z)
 ;
 Q
 ;
EXTERR(RCERR,RCE) ; Put error into error array
 ; Returns: (must be passed by reference)
 ;   RCERR = specific error encountered, returned as 4
 ;   RCE = error text from the word processing field update error global
 N RCZ,Q
 S RCE="",RCERR=4 ; error reported as 'record was partially stored'
 S RCZ=0 F  S RCZ=$O(RCE("DIERR",RCZ)) Q:'RCZ  S Q=$G(RCE("DIERR",RCZ,"TEXT",1)) I $L(Q),$L(Q)+$L(RCE)<99 S RCE=RCE_Q_";;"
 Q
 ;
ERRUPD(RCGBL,RCD,RCTYPE,RCERR) ; Set up global array to hold msg data
 ; RCGBL = name of the global or array where msg data is found
 ; RCD = array containing mail header data for the msg
 ; RCTYPE = type of msg (835ERA/835XFR/etc)
 ; RCERR = error array - text or reference to error tables below
 ;
 ; Returns ^TMP("RCERR",$J,"MSG" array with formatted error text
 ;
 N Z,Z0,Z1,Z2,CT,RCE
 ;
 Q:$G(RCERR)<0
 K ^TMP("RCERR",$J)
 S CT=0
 ;
 S ^TMP("RCERR",$J,"DATE")=$G(RCD("DATE"))
 S ^TMP("RCERR",$J,"TYPE")=$G(RCTYPE)
 S ^TMP("RCERR",$J,"SUBJ")=$G(RCD("SUBJ"))
 ;
 I $G(RCERR)>0,RCERR<20 D
 . S Z="ERROR2+"_RCERR
 . S RCE=$P($T(@Z),";;",2)
 . I RCE'="" S ^TMP("RCERR",$J,"TEXT")=RCE
 ;
 S Z="" F  S Z=$O(RCERR(Z)) Q:Z=""  S Z0="" F  S Z0=$O(RCERR(Z,Z0)) Q:Z0=""  S RCE=$G(RCERR(Z,Z0)) D
 . I $L(RCE) S CT=CT+1,^TMP("RCERR",$J,"MSG",CT)=$S(RCE:$P($T(ERROR+RCE),";;",2),1:RCE)
 . S RCTYPE=$P($G(@RCGBL@(0)),U)
 . S:$G(^TMP("RCERR",$J,"TYPE"))="" ^("TYPE")=RCTYPE
 . S Z1=""
 . F  S Z1=$O(@RCGBL@(1,"D",Z1)) Q:Z1=""  S CT=CT+1,^TMP("RCERR",$J,"MSG",CT)=$G(@RCGBL@(1,"D",Z1))
 ;
 I $D(@RCGBL@(2,"D")) D
 . S CT=CT+2,^TMP("RCERR",$J,"MSG",CT-1)=" ",^TMP("RCERR",$J,"MSG",CT)="**** RAW MESSAGE DATA ****:"
 . I $G(^TMP("RCMSGH",$J,0))'="" S CT=CT+1,^TMP("RCERR",$J,"MSG",CT)=^TMP("RCMSGH",$J,0)
 . S Z2="" F  S Z2=$O(@RCGBL@(2,"D",Z2)) Q:Z2=""  S CT=CT+1,^TMP("RCERR",$J,"MSG",CT)=$G(@RCGBL@(2,"D",Z2))
 E  D
 . Q:'$D(^TMP("RCRAW",$J))
 . S CT=CT+2,^TMP("RCERR",$J,"MSG",CT-1)=" ",^TMP("RCERR",$J,"MSG",CT)="**** RAW MESSAGE DATA ****:"
 . I $G(^TMP("RCMSGH",$J,0))'="" S CT=CT+1,^TMP("RCERR",$J,"MSG",CT)=^TMP("RCMSGH",$J,0)
 . S Z2="" F  S Z2=$O(^TMP("RCRAW",$J,Z2)) Q:Z2=""  S CT=CT+1,^TMP("RCERR",$J,"MSG",CT)=$G(^TMP("RCRAW",$J,Z2))
 ;
 Q
 ;
DKILL(RCXMZ) ; Delete server mail msg from postmaster mailbox
 ; RCXMZ = ien of mailman msg
 ;
 D ZAPSERV^XMXAPI("S.RCDPE EDI LOCKBOX SERVER",RCXMZ)
 Q
 ;
TEMPDEL(DA) ; Delete msg from temporary msg file
 ; DA = ien of the entry in file 344.5
 ;
 N DIK,Y,X
 S DIK="^RCY(344.5," D ^DIK
 L -^RCY(344.5,DA,0)
 Q
 ;
RESTMSG(RCD,RCARRAY,XMZ) ; Read rest of msg, store in array
 ; RCD = last line # already in the msg
 ; RCARRAY = name of the array to store the data in
 ; XMZ = ien of the mailman msg
 ;
 F  X XMREC Q:XMER<0  S RCD=RCD+1,@RCARRAY@(RCD)=XMRG
 Q
 ;
TAXERR(RCTYPE,RCINS,RCTID,RCCHG) ; Send a bulletin for a bad tax id
 ; RCTYPE = "ERA" for an ERA record,  "EFT" for an EFT record
 ; RCINS = name and id to identify the ins co
 ; RCTID = tax id sent in error
 ; RCCHG = code describing how correction was made
 ;         'E'=EPHRA, 'C'=Changed by looking at claim #'s
 ;
 N XMBODY,XMB,XMINSTR,XMTYPE,XMFULL,XMTO,RCDXM,XMZ,XMERR,RCCT,RCDXM,RCCT
 S RCCT=0
 S RCCT=RCCT+1,RCDXM(RCCT)="An "_RCTYPE_" was received at your site "_$$FMTE^XLFDT($$NOW^XLFDT(),2)_" with an invalid tax id.",RCCT=RCCT+1,RCDXM(RCCT)=" From: "_RCINS
 S RCCT=RCCT+1,RCDXM(RCCT)=" The tax id sent was: "_RCTID_" and it was corrected by: "
 S RCCT=RCCT+1,RCDXM(RCCT)=" "_$S(RCCHG="E":"EPHRA",1:"Extracting it based on bill numbers in the ERA")
 S RCCT=RCCT+2,RCDXM(RCCT-1)=" ",RCDXM(RCCT)="If your site continues to receive these bulletins for this payer,",RCCT=RCCT+1,RCDXM(RCCT)="contact the payer and request they correct their tax id for your site"
 ;
 S XMTO("I:G.RCDPE PAYMENTS")="",XMBODY="RCDXM"
 D
 . N DUZ S DUZ=.5,DUZ(0)="@"
 . D SENDMSG^XMXAPI(.5,"EDI LBOX ERRONEOUS TAX ID ON "_RCTYPE,XMBODY,.XMTO,,.XMZ)
 Q
 ;
BILL(X,RCDT,RCIB) ; Returns ien of bill in X or -1 if not valid
 ; RCDT = the Statement from date (used for Rx bills)
 ; and, if passed by reference, RCIB = 1 if an insurance bill
 N DIC,Y
 S RCIB=0
 S X=$TR(X," "),X=$TR(X,"O","0") ; Remove spaces, change ohs to zeroes
 I X'["-",$E(X,1,3)?3N,$L(X)>7 S X=$E(X,1,3)_"-"_$E(X,4,$L(X))
 S DIC="^PRCA(430,",DIC(0)="MZ" D ^DIC
 I Y<0,X?1.7N D  ; Rx lookup
 . N ARRAY
 . S ARRAY("ECME")=X,ARRAY("FILLDT")=$G(RCDT)
 . S Y=$$RXBIL^IBNCPDPU(.ARRAY)
 . I Y>0 S Y(0)=$G(^PRCA(430,+Y,0))
 I Y>0 S RCIB=($P($G(^RCD(340,+$P(Y(0),U,9),0)),U)["DIC(36,")
 Q +Y
 ;
FMDT(X) ; Format date (X) in YYYYMMDD to Fileman format
 I $L(X)=8 D
 . S X=$E(X,1,4)-1700_$E(X,5,8)
 Q X
 ;
ERROR ; Top level error msgs for msgs
 ;;Invalid mailgroup designated for EDI Lockbox errors
 ;;Message header error
 ;
ERROR2 ; Error condition msgs for msgs
 ;;Message code is invalid for EDI Lockbox.
 ;;This message has no ending $ or 99 record.
 ;;Message file problem - no message stored.
 ;;Message file problem - message partially stored.
 ;;No valid claims for the site found on the ERA.
 ;
