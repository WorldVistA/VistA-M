RCDPESR4 ;ALB/TMK - Server interface 835ERA processing ;06/03/02
 ;;4.5;Accounts Receivable;**173,216,208,230**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ERAEOBIN(RCTXN,RCD,RCGBL,RCEFLG) ; Store/process 835ERA or 835XFR
 ;  transaction coming into the site
 ; RCTXN = data on the hdr record of the msg text
 ; RCD = array with formatted hdr data
 ; RCGBL = name of the array or global where the msg is stored
 ; RCEFLG = error flag returned if passed by REF
 ;
 N RCLAST,RCBILL,RCTDA,RCMSG,RCERR
 S (RCTDA,RCEFLG)=0
 ;
 L +^RCY(344.5,"AMSEQ",+$P(RCTXN,U,13))
 S RCMSG=$$EXTERA(RCTXN,.RCLAST,.RCBILL) ; Extract from mail msg
 ;
 ; If full msg received (99^$ record exists), file it
 I 'RCLAST,'$G(RCERR) D  ;No $ as last character of msg
 . S RCERR=2
 ;
 I RCLAST S RCTDA=+$$ADD(RCGBL,RCD("MSG#"),RCMSG,.RCBILL,.RCERR,.RCD)
 ;
 I $G(RCERR)>0 D
 . D ERRUPD^RCDPESR1(RCGBL,.RCD,$P(RCTXN,U),.RCERR)
 . I RCTDA D  ; Store exception msgs in file 344.5
 .. N A,C,Z
 .. S C=1,A(1)="Date: "_$$FMTE^XLFDT($$NOW^XLFDT(),2)
 .. I $G(^TMP("RCERR",$J,"TEXT"))'="" S C=C+1,A(C)=^TMP("RCERR",$J,"TEXT"),C=C+1,A(C)=" "
 .. S Z=0 F  S Z=$O(^TMP("RCERR",$J,"MSG",Z)) Q:'Z  S C=C+1,A(C)=^(Z)
 .. I $O(A(0)) D WP^DIE(344.5,RCTDA_",",5,"A","A")
 . S RCEFLG=1
 ;
 L -^RCY(344.5,"AMSEQ",+$P(RCTXN,U,13))
 I $P(RCTXN,U)'["XFR",$P(RCTXN,U,12)'="" D TAXERR^RCDPESR1("ERA",$P(RCTXN,U,6)_"  Payer ID: "_$P(RCTXN,U,7),$P(RCTXN,U,11),$P(RCTXN,U,12)) ; Send bad tax id bulletin
 ;
 Q
 ;
EXTERA(RCTXN,RCLAST,RCBILL) ;Extract 835ERA or 835XFR transaction
 ;INPUT:
 ; RCTXN = data on 835ERA/835XFR hdr record
 ; RCLAST = passed by REF and returned=1 if entire record exists
 ;
 ;OUTPUT:
 ; ^TMP("RCMSG",$J,1,"D",line #)=formatted hdr data
 ; ^TMP("RCMSG",$J,2,"D",line #)=raw msg data
 ;  if passed by ref, RCLAST = 1 if '99' record found
 ;  if passed by ref, RCBILL(AR bill number) is returned
 ;    with a 'list' of bills included in the ERA.  If an
 ;    entry = 1, 3rd party bill was found in file 430.
 ;    If the entry = 2, the 3rd party bill found was not active
 ; Function returns existing ien in file 344.5 for multi part ERAs
 ;
 N CT,CT1,LINE,HCT,RCH,RCMSG,RCREFORM,RCINS,RCSTAT,B,RCSD,C5
 S (HCT,RCH)=0
 ;
 ; Check if sequence control # already exists or if a new record needed
 S RCMSG=+$O(^RCY(344.5,"AMSEQ",+$P(RCTXN,U,13),0))
 S CT=0
 I 'RCMSG D  ; Build display data for the first sequence only
 . S HCT=HCT+1 S LINE(HCT)="Payer Name: "_$P(RCTXN,U,6)_"    Payer ID: "_$P(RCTXN,U,7)
 . S HCT=HCT+1,LINE(HCT)="Trace #: "_$P(RCTXN,U,8)
 . S HCT=HCT+1,LINE(HCT)="Date Paid: "_$$FDT^RCDPESR9($P(RCTXN,U,9))_"    Total Amt Paid: "_$J($P(RCTXN,U,10)/100,0,2)
 . I $P(RCTXN,U)["XFR",$P(RCTXN,U,16)'="" S HCT=HCT+1,LINE(HCT)="Contact Info: "_$P(RCTXN,U,16)
 . M ^TMP("RCMSG",$J,1,"D")=LINE
 . S CT=CT+1,^TMP("RCMSG",$J,2,"D",CT)=RCTXN
 ;
 S CT1=CT
 S ^TMP("RCMSG",$J,0)=RCTXN
 ;
 S RCSD=$NA(^TMP($J,"RCSRVDT")) K @RCSD ;service dates
 S C5=0
 S RCLAST=0
 F  X XMREC Q:XMER<0  D  Q:RCLAST
 . Q:XMRG=""
 . I +XMRG=99,$P(XMRG,U,2)="$" S RCLAST=1 Q
 . S CT=CT+1
 . I +XMRG=5,$P(XMRG,U,2)'="" S C5=CT
 . I +XMRG=40,$P(XMRG,U,2)?1.7N,C5,$P(XMRG,U,19),'$D(@RCSD@(C5)) S ^(C5)=+$P(XMRG,U,19)
 . S ^TMP("RCMSG",$J,2,"D",CT)=XMRG
 ;
 ; reformat bill# if needed
 S RCREFORM=""
 S CT=CT1
 F  S CT=$O(^TMP("RCMSG",$J,2,"D",CT)) Q:'CT  S XMRG=$G(^(CT)) D
 . Q:XMRG=""
 . I +XMRG=5,$P(XMRG,U,2)'="" D
 .. S RCREFORM="",RCSTAT=1
 .. ; Check if bill is in AR & is a 3rd party bill
 .. S RCBILL=$$BILL^RCDPESR1($P(XMRG,U,2),$G(@RCSD@(CT)),.RCINS)
 .. I '$G(RCINS)!(RCBILL<0) S (RCBILL,RCSTAT)=0
 .. I RCBILL S B=$P($G(^PRCA(430,RCBILL,0)),U) I B'=$P(XMRG,U,2) S $P(XMRG,U,2)=B,RCREFORM=B
 .. I RCBILL,$P(^PRCA(430.3,+$P($G(^PRCA(430,+RCBILL,0)),U,8),0),U,3)'=102 S RCSTAT=2
 .. S RCBILL($P(XMRG,U,2))=RCSTAT
 . I RCREFORM'="",+XMRG>5 S $P(XMRG,U,2)=RCREFORM,^TMP("RCMSG",$J,2,"D",CT)=XMRG
 ;
 K @RCSD
 Q RCMSG
 ;
ADD(RCGBL,RCDMSG,RCMSG,RCBILL,RCERR,RCD) ; Add msg(s) in @RCGBL to
 ;  file 344.5
 ; RCGBL = name of the global used to store the msg data
 ; RCDMSG = Mailman msg number the ERA arrived in.
 ; RCMSG = ien of the existing entry in file 344.5 for multipart ERAs
 ; RCBILL(AR bill number) = list of bills included, pass by REF
 ; RCD = array with formatted hdr data
 ;
 ; Errors returned in RCERR and RCERR(n)
 ; Function returns entry # of msg added or "" if none added
 ;
 N RCHDR,RCTYP,RCIEN
 S RCHDR=$G(^TMP("RCMSGH",$J,0))
 S RCTYP=$P(RCHDR,U)
 S RCIEN=$S($G(RCMSG):RCMSG,1:$$ADDTXN(RCHDR,RCDMSG)) ;File msg hdr
 I RCIEN'>0 S RCERR=3 ;msg hdr can't be filed
 I '$G(RCERR) D LOADDET(RCIEN,RCGBL,RCHDR,.RCBILL,.RCD,.RCERR)
 I '$G(RCERR),'$O(RCERR(0)),RCTYP["835ERA",'$P($G(^RCY(344.5,RCIEN,0)),U,8) D TASKERA^RCDPESR2(RCIEN) ;Task to upd VistA for complete 835ERA only
 ;
 Q $S($G(RCIEN)>0&'$G(RCERR):RCIEN,1:"")
 ;
ADDTXN(RCDATA,RCDMSG) ; Add a trxn for msg in RCDATA to file 344.5
 ; RCDATA = data on the msg hdr record
 ; RCDMSG = Mailman msg number the ERA arrived in
 ;Function returns ien of the new entry in file 344.5 or "" if an error
 ;
 N A,RCY,DLAYGO,DIC,DD,DO,DA,X,Y,Z
 ;
 S (X,A)=RCDMSG ;Use msg ID as basis for the .01 field
 F Z=1:1 Q:'$D(^RCY(344.5,"B",A))  S A=X_"."_Z
 S X=A
 S DIC(0)="L",DIC="^RCY(344.5,",DLAYGO=344.5
 S DIC("DR")=".02////"_$E($P(RCDATA,U),1,6)_";.03///^S X=""NOW"";.04////0;.06////"_$S($P(RCDATA,U)'["XFR":1,1:0)_$S($P(RCDATA,U,13)'="":";.09////"_+$P(RCDATA,U,13)_";.08////1",1:"")_";.1////2;.11////"_RCDMSG
 I $P(RCDATA,U,6)'="" S DIC("DR")=DIC("DR")_";3.01////"_$P(RCDATA,U,6)
 D FILE^DICN K DO,DD,DLAYGO,DA,DIC
 S RCY=+Y
 Q $S(RCY>0:+RCY,1:"")
 ;
LOADDET(RCTDA,RCGBL,RCHDR,RCBILL,RCD,RCERR) ; Load the rest of the text
 ; into the msg
 ; RCTDA = ien in file 344.5
 ; RCGBL = name of the array holding the detail msg text to be loaded
 ; RCHDR = data on ERA hdr record
 ; RCBILL(AR bill number) = list of bills included, pass by REF
 ; RCD = array with formatted hdr data
 ;
 ; OUTPUT: RCERR if any errors found, pass by REF
 ;
 N RCE,RCDATA,RCMSG,RCFROM,Z,Z0
 K ^TMP("RCTEXT",$J),^TMP("RCRAW",$J)
 M ^TMP("RCTEXT",$J)=@RCGBL@(1,"D")
 M ^TMP("RCRAW",$J)=@RCGBL@(2,"D")
 ;
 S RCDATA=$G(^RCY(344.5,RCTDA,0)),RCMSG=$G(RCD("MSG#")),RCFROM=$G(RCD("FROM"))
 ;
 ; For multi-part ERA, don't update if sequence already filed
 ; Add seq # if not already there
 I $P(RCHDR,U)'["XFR",$P(RCHDR,U,13) Q:$D(^RCY(344.5,RCTDA,"S","B",+$P(RCHDR,U,14)))
 ;
 D STOREM(+$G(RCTDA),"^TMP(""RCTEXT"",$J)","^TMP(""RCRAW"",$J)",.RCE)
 ;
 I $D(RCE("DIERR")) D  ; Extract error
 . N DIE,DA,DR,X,Y
 . D EXTERR^RCDPESR1(.RCERR,.RCE)
 . S:$L($G(RCE)) RCERR(+$O(RCERR(""),-1)+1)=RCE
 . I $D(^RCY(344.5,RCTDA,0)) S DIE="^RCY(344.5,",DR=".1////4",DA=RCTDA D ^DIE
 E  D  ; No error - store rest of data
 . N Z,RCT,RCCT,RCX,RCB ; Add bills included in ERA
 . S RCT=0,RCCT=0,RCX=$J("",4)
 . S Z="" F  S Z=$O(RCBILL(Z)) Q:Z=""  D
 .. N DO,DD,DIC,DLAYGO,X,Y
 .. S:RCT=4 RCCT=RCCT+1,RCB(RCCT)=RCX,RCT=0,RCX=$J("",4) S RCX=RCX_$E($S(+RCBILL(Z):"",1:"*")_Z_$J("",15),1,15),RCT=RCT+1
 .. S DIC(0)="L",DIC("DR")=".02////"_$S($G(RCBILL(Z)):1,1:0),X=Z,DA(1)=RCTDA,DIC="^RCY(344.5,"_DA(1)_",""B"",",DLAYGO=344.54 D FILE^DICN K DO,DD,DLAYGO,DIC
 .. ;
 . I $L(RCX)>4 S RCCT=RCCT+1,RCB(RCCT)=RCX
 . ; Add list of bills to display data
 . I $O(RCB(0)) D WP^DIE(344.5,RCTDA_",",1,"A","RCB")
 . ; Add seq #
 . S DA(1)=RCTDA,DIC="^RCY(344.5,"_DA(1)_",""S"",",DIC(0)="L",X=$P(RCHDR,U,14),DIC("DR")=".02////"_$S($P(RCHDR,U,15)="Y":1,1:0)_";.03///^S X=""NOW"";.04////"_RCMSG,X=+$P(RCHDR,U,14),DLAYGO=344.53
 . D FILE^DICN K DO,DD,DLAYGO,DIC
 . ;
 . I $P(RCHDR,U)["835XFR" D XFR^RCDPESR5(RCTDA,RCFROM,RCMSG,.RCD) Q
 . ;
 . ; Proceed only if not a transfer record
 . I $P(RCDATA,U,9)'="" D  ; Determine if all sequences received yet
 .. N RCOK,RCLAST
 .. S RCOK=1,RCLAST=0
 .. F Z=1:1 Q:'RCOK!RCLAST  D
 ... I 'RCLAST,'$D(^RCY(344.5,RCTDA,"S","B",Z)) S RCOK=0 Q
 ... S Z0=+$O(^RCY(344.5,RCTDA,"S","B",Z,0)),Z0=$G(^RCY(344.5,RCTDA,"S",Z0,0))
 ... I Z0="" S RCOK=0 Q
 ... I $P(Z0,U,2) S RCLAST=1 ; Last sequence received and all before it
 .. ;
 .. I RCOK D
 ... N DA,DIE,DR,X,Y
 ... S DA=RCTDA,DR=".08////0;.1///@",DIE="^RCY(344.5," D ^DIE
 ... I '$O(^RCY(344.5,RCTDA,"B","AV",1,0)) D  ; No valid bills found
 .... N RCE
 .... S RCE(1)="No valid bills for this site were found in this ERA"
 .... S RCE(2)="Review/correct the bill #'s on this ERA in your transmission exceptions"
 .... S RCE(3)="Please contact the Implementation Manager group to report this situation",RCE(4)=" "
 .... D BULLERA^RCDPESR0("D"_$S($O(^RCY(344.5,RCTDA,2,0)):"F",1:""),RCTDA,$G(RCD("MSG#")),"EDI LBOX - NO VALID BILLS ON ERA "_$E($G(RCD("PAYFROM")),1,20),.RCE,0)
 .... S DA=RCTDA,DR=".08////1;.1////6",DIE="^RCY(344.5," D ^DIE
 ;
 K ^TMP("RCTEXT",$J),^TMP("RCRAW",$J)
 Q
 ;
STOREM(RCTDA,RCDISP,RCTEXT,RCE) ;Store msg text in file 344.5
 ;INPUT:
 ; RCTDA = ien of the entry in file 344.5
 ; RCDISP = name of the array where display msg text is retrieved from
 ;   or "@" to delete the text from the display text field
 ; RCTEXT = name of the array where raw msg text is retrieved from
 ;   or "@" to delete the text from the raw msg field
 ;OUTPUT:
 ; RCE = array of errors (RCE("DIERR")) returned, pass by REF
 ;
 N RCZ,X,Y,DIE
 K RCE("DIERR")
 ;
 I $S($G(RCDISP)="@":1,1:$D(@RCDISP)'<10) D
 . F RCZ=1:1:20 D WP^DIE(344.5,RCTDA_",",1,"AK",""_RCDISP_"","RCE") Q:$S('$D(RCE("DIERR")):1,+RCE("DIERR")=1:$G(RCE("DIERR",1))'=110,1:1)  K:RCZ<20 RCE("DIERR") ; On lock error, retry up to 20 times
 ;
 I '$O(RCE("DIERR",0)),$S($G(RCTEXT)="@":1,1:$D(@RCTEXT)'<10) D
 . F RCZ=1:1:20 D WP^DIE(344.5,RCTDA_",",2,"AK",""_RCTEXT_"","RCE") Q:$S('$D(RCE("DIERR")):1,+RCE("DIERR")=1:$G(RCE("DIERR",1))'=110,1:1)  K:RCZ<20 RCE("DIERR") ; On lock error, retry up to 20 times
 Q
