RCDPESR3 ;ALB/TMK/PJH - Server auto-update utilities - EDI Lockbox ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**173,214,208,255,269,283,298,321,345,349,380**;Mar 20, 1995;Build 14
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
EFTIN(RCTXN,RCD,XMZ,RCGBL,RCEFLG) ; Adds a new EFT record to AR file 344.3
 ;  from Lockbox EFT msg
 ; Input:   RCTXN   - Data on the header record of the message text
 ;          RCD     - Array containing formatted mail message header data
 ;          XMZ     - Mail message number
 ;          RCGBL   - Name of the array or global where the message is stored
 ; Output:  RCEFLG  - Error flag returned if passed by reference
 ;
 N CT,DA,DIK,DLAYGO,RC,RC1,RCLAST,RCDEPAMT,RCEFT,RCMEFTS,RCTDA,RCERR,RCTYP1,RCZ,XX,Z,Z0
 ;
 ; Take data out of mail message
 S (RCEFLG,RCLAST)=0,CT=0,RCTYP1="835EFT"
 F  X XMREC Q:XMER<0  D  Q:RCLAST
 . I +XMRG=99,$P(XMRG,U,2)="$" S RCLAST=1 Q
 . S:XMRG'="" CT=CT+1,@RCGBL@(2,"D",CT)=XMRG
 ;
 ; PRCA*4.5*349 - Removed killing of RCGBL to ensure raw data gets sent in error message
 I 'RCLAST,'$G(RCERR) S RCERR=2    ; No $ as last character of msg
 ;
 I $G(RCERR)>0 D  G EFTQ
 . D ERRUPD^RCDPESR1(RCGBL,.RCD,RCTYP1,.RCERR)
 . S RCEFLG=1
 ;
 ; Add top-level entry to file 344.3
 S RCEFT=$$ADDEFT(RCTXN,XMZ,RCGBL,.RCERR)
 ;
 I $G(RCERR) D  G EFTQ                      ; 'BAD' EFT's
 . D ERRUPD^RCDPESR1(RCGBL,.RCD,RCTYP1,.RCERR)
 . S RCEFLG=1
 ;
 G:'RCEFT EFTQ
 ;
 ; PRCA*4.5*380 - No longer deleting EFT Details
 ;
 S (RC,RC1,RCZ)=0
 F  S RCZ=$O(@RCGBL@(2,"D",RCZ)) Q:'RCZ  S Z0=$G(^(RCZ)) I Z0'="" D  Q:$G(RCERR)
 . I $P(Z0,U)="01" D  ; Each payer's data
 . . N DA,DD,DIC,DIE,DO,DR,X,Y
 . . S X=RCEFT
 . . S DIC("DR")=".11////0;.04////"_$P(Z0,U,2)_";.08////0"
 . . S DIC("DR")=DIC("DR")_$S($P(Z0,U,5)'="":";.02////"_$P(Z0,U,5),1:"")
 . . S DIC("DR")=DIC("DR")_$S($P(Z0,U,6)'="":";.03////"_$P(Z0,U,6),1:"")
 . . S DIC("DR")=DIC("DR")_";.07////"_$J(+$P(Z0,U,4)/100,"",2)
 . . S DIC("DR")=DIC("DR")_";.06////"_$S($P(Z0,U,8)'="":1,1:0)
 . . S DIC("DR")=DIC("DR")_";.12///"_$$FDT^RCDPESR9($P(Z0,U,3))
 . . S DIC("DR")=DIC("DR")_";.13////"_DT_$S($P(Z0,U,7)'="":";.05////"_$P(Z0,U,7),1:"")
 . . S DIC("DR")=DIC("DR")_$S($P(Z0,U,9)'="":";.15////"_$P(Z0,U,9),1:"")
 . . S XX=$S($P(Z0,U,10)="D":"D",$P(Z0,U,10)="-":"D",1:"")
 . . S DIC("DR")=DIC("DR")_";3////"_XX      ; PRCA*4.5*321 added filing of this field
 . . ;
 . . I $P(Z0,U,8)'="" D                     ; Tax id error
 . . . S XX=$P(Z0,U,5)_"  Payer ID: "_$P(RCTXN,U,6)
 . . . D TAXERR^RCDPESR1("EFT",XX,$P(RCTXN,U,7),$P(RCTXN,U,8)) ; Send bad tax id bulletin
 . . ;
 . . S DIC(0)="L",DIC="^RCY(344.31,",DLAYGO=344.31
 . . D FILE^DICN
 . . K DIC,DLAYGO,DO,DD
 . . I Y'>0 D  ; Error filing data
 . . . S DIK="^RCY(344.3,",DA=RCEFT D ^DIK
 . . . S Z=0 F  S Z=$O(^RCY(344.31,"B",RCEFT,Z)) Q:'Z  S DIK="^RCY(344.31,",DA=Z D ^DIK
 . . . S RCEFLG=1,RCERR=3
 . . . D ERRUPD^RCDPESR1(RCGBL,.RCD,RCTYP1,RCERR)
 ;
 I '$G(RCEFLG) D
 . S DIE="^RCY(344.3,",DA=RCEFT,DR=".09////"_$$CHKSUM(RCEFT) D ^DIE
 ;
EFTQ ;
 D CLEAN^DILF
 Q
 ;
ADDEFT(RCTXN,RCXMZ,RCGBL,RCERR) ; File EFT TOTAL record in file 344.3
 ; RCTXN = the data on the header record of the message text
 ; RCXMZ = the mail message number
 ; RCGBL = the name of the array or global where the message is stored
 ; Function returns the ien of the total record found/added
 ;    and also returns RCERR if passed by reference
 ;
 N RCTDA,RCRCPT,RCDUP,RCHAC,Z,Z0
 S (RCERR,RCTDA)=""
 ;
 ;----- changed for PRCA*4.5*283
 ;I $E($P(RCTXN,U,6),1,3)'="469",$E($P(RCTXN,U,6),1,3)'="569",$E($P(RCTXN,U,6),1,3)'="HAC" D  G ADDQ ; Invalid EFT deposit number
 ;. N RCDXM,RCCT
 ;. S RCCT=0
 ;. S RCCT=RCCT+1,RCDXM(RCCT)="This EFT has an invalid deposit number for EDI Lockbox and has been rejected.",RCCT=RCCT+1,RCDXM(RCCT)=" "
 ;. S RCCT=RCCT+1,RCDXM(RCCT)=" ",RCCT=RCCT+1,RCDXM(RCCT)="Here are the contents of this message:"
 ;. D DISP("EDI LBOX INVALID EFT DEPOSIT #",RCCT,.RCDXM,RCXMZ)
 ;-----
 ;
 ; Make sure it's not already there or if so, it has no ptr to a deposit
 ; or if a deposit exists, that the deposit does not yet have a receipt
 S RCDUP=0,RCHAC=$E($P(RCTXN,U,6),1,3)="HAC" ; This is a HAC deposit
 I $P(RCTXN,U,6)'="" D
 . ;Format Deposit Date as FM date
 . N RCDDAT
 . S X=$$FDT^RCDPESR9($P(RCTXN,U,7))
 . S RCDDAT=0,%DT="X" D ^%DT S:Y>0 RCDDAT=Y
 . S Z=0 ; Lookup deposit by deposit #
 . ; PRCA*4.5*380 - Don't quit now until we've either gone through all the records or found a valid match, since we might be matching
 . ;                a duplicate record now
 . F  S Z=$O(^RCY(344.3,"ADEP",RCDDAT,$P(RCTXN,U,6),Z)) Q:'Z  S Z0=$G(^RCY(344.3,Z,0)) S:'$P(Z0,U,3) RCTDA=Z Q:RCTDA  D  Q:RCTDA
 .. ; Deposit found - find receipt
 .. I $O(^RCY(344,"AD",$P(Z0,U,3),0)) S RCDUP=Z Q
 .. S RCTDA=Z
 ;
 ;-----
 ; PRCA*4.5*298 - MailMan message disabled, logic retained - 14 Feb 2014
 ;I RCDUP D  ; Send bulletin that duplicate EFT received
 ;. N RCDXM,RCCT
 ;. S RCCT=0
 ;. S RCCT=RCCT+1,RCDXM(RCCT)="This EFT appears to be a duplicate transaction and has been rejected.",RCCT=RCCT+1,RCDXM(RCCT)=" "
 ;. S RCCT=RCCT+1,RCDXM(RCCT)=" ",RCCT=RCCT+1,RCDXM(RCCT)="Here are the contents of this message:"
 ;. D DISP("EDI LBOX DUP EFT DEPOSIT RECEIVED",RCCT,.RCDXM,RCXMZ)
 ;-----
 ;
 ; PRCA*4.5*380 - Removed check for dup; will now just create new transaction, instead
 N %DT,DA,DD,DEPAMT,DIC,DIE,DINUM,DLAYGO,DO,DR,RCDTTM,RCX,X,Y
 ;
 S X=$$FDT^RCDPESR9($P(RCTXN,U,3))_"@"_$P(RCTXN,U,4)
 S %DT="XTS" D ^%DT S:Y>0 RCDTTM=Y
 ;
 ;PRCA*4.5*380 - If updating an existing deposit, add new deposit amount to existing total
 S DEPAMT=$S(RCTDA:+$$GET1^DIQ(344.3,RCTDA_",",.08),1:0)+$$ZERO^RCDPESR9($P(RCTXN,U,8),1)
 ;
 S DIC("DR")=""
 S DIC("DR")=$S(RCDTTM'="":".02////"_RCDTTM,1:"")
 S DIC("DR")=DIC("DR")_$S(DIC("DR")'="":";",1:"")_".06////"_$P(RCTXN,U,6)_";.07///"_$$FDT^RCDPESR9($P(RCTXN,U,7))
 ;PRCA*4.5*380 - If updating an existing deposit, add new deposit amount to existing total
 S DIC("DR")=DIC("DR")_";.08////"_DEPAMT_";.13////"_$$NOW^XLFDT()_$S('RCTDA:";.05////"_RCXMZ,1:"")_";.14////0;.12////0"
 ;
 I RCTDA D  ; Update the data already there
 . L +^RCY(344.3,RCTDA):1 I '$T S RCTDA=-1 Q
 . S DIE="^RCY(344.3,",DA=RCTDA,DR=DIC("DR") K DIC D ^DIE
 . K DIE,DA,DR
 . ; PRCA*4.5*380 - Add an entry to the subsequent mail messages multiple
 . S DIC="^RCY(344.3,"_RCTDA_",3,",DIC(0)="L",DA(1)=RCTDA,X=RCXMZ
 . D FILE^DICN K DA,DIC
 . L -^RCY(344.3,RCTDA)
 ;
 I 'RCTDA D
 . S RCX=+$O(^RCY(344.3," "),-1)
 . F RCX=RCX+1:1 I '$D(^RCY(344.3,RCX,0)) L +^RCY(344.3,RCX,0):1 I $T S X=RCX Q
 . S DIC(0)="L",DIC="^RCY(344.3,",DLAYGO=344.3,DINUM=RCX
 . D FILE^DICN K DO,DD,DLAYGO,DIC,DINUM
 . L -^RCY(344.3,RCX,0)
 . S RCTDA=$S(Y<0:"",1:+Y)
 ;
 I 'RCTDA S RCERR=3 ; Error in add of EFT record to file 344.3 
 ;
ADDQ Q $S(RCTDA>0:RCTDA,1:"")
 ;
CHKSUM(RCTDA) ; Calc the checksum for EFT record stored in RCTDA in 344.3
 ;
 N RCDPCSUM,RCDPDATA,X,Y,Z,Z0
 ;
 S (RCDPCSUM,X)=0,Z0=$G(^RCY(344.3,RCTDA,0))
 ; Use pcs 1-8, leaving out piece 3
 S RCDPDATA=$P(Z0,U,1,8),$P(RCDPDATA,U,3)=""
 S X=RCDPCSUM_RCDPDATA X $S($G(^%ZOSF("LPC"))'="":^("LPC"),1:"S Y=""""") S RCDPCSUM=Y
 ; Use detail iens and pieces 3,4,7 to complete the checksum
 S Z=0 F  S Z=$O(^RCY(344.31,"B",RCTDA,Z)) Q:'Z  S Z0=$G(^RCY(344.31,Z,0)),RCDPDATA=Z_U_$P(Z0,U,3,4)_U_$P(Z0,U,7),X=RCDPCSUM_RCDPDATA X $S($G(^%ZOSF("LPC"))'="":^("LPC"),1:"S Y=""""") S RCDPCSUM=Y
 Q RCDPCSUM
 ;
DISP(RCTIT,RCCT,RCDXM,RCXMZ) ; Sends bulletin with formatted data from message
 ; RCTIT = title of bulletin
 ; RCCT = # of lines previously populated
 ; RCXDM = array containing the text of the bulletin
 N RC,Z
 K ^TMP("RC1",$J),^TMP("RC",$J),^TMP("RCTEMP",$J)
 S RC=1,^TMP("RCTEMP",$J,RC)=$G(^TMP("RCMSGH",$J,0))
 S Z=0 F  S Z=$O(^TMP("RCMSG",$J,2,"D",Z)) Q:'Z  S RC=RC+1,^TMP("RCTEMP",$J,RC)=$G(^TMP("RCMSG",$J,2,"D",Z))
 D DISP^RCDPESR8("^TMP(""RCTEMP"",$J)","^TMP(""RC1"",$J)",1,"^TMP(""RC"",$J)",75)
 S Z=0 F  S Z=$O(^TMP("RC",$J,Z)) Q:'Z  S RCCT=RCCT+1,RCDXM(RCCT)=$G(^TMP("RC",$J,Z))
 D BULLEFT^RCDPESR0("",RCXMZ,RCTIT,.RCDXM)
 K ^TMP("RC1",$J),^TMP("RC",$J),^TMP("RCTEMP",$J)
 Q
 ;
DUP(RCM,RCIFN,RCAMT,RCAMT1) ; EOB in mail message already stored in 361.1?
 ; RCM = msg # EOB was received in
 ; RCIFN = bill ien
 ; RCAMT = amt pd
 ; RCAMT1 = amt reported billed
 ; Returns 0 if none found, entry #^message checksum on file if found
 N Z,DUP,DUP1
 S (DUP,DUP1,Z)=0
 F  S Z=$O(^IBM(361.1,"AC",RCM,Z)) Q:'Z  I +$G(^IBM(361.1,Z,0))=RCIFN D  Q:DUP
 . I '$P($G(^IBM(361.1,Z,100)),U,5) S DUP1=Z Q  ; Partially filed before
 . I +$G(^IBM(361.1,Z,1))=+RCAMT,+$P($G(^IBM(361.1,1,Z,2)),U,4)=+RCAMT1 S DUP=Z_U_+$P($G(^IBM(361.1,Z,100)),U,5) Q
 I 'DUP,DUP1 S DUP=DUP1_"^0"
 Q DUP
 ;
DUPERA(DUP,RCNOUPD) ; Msg for duplicate ERA
 ; RCNOUPD = # of message with duplicate data
 ; DUP = flag = -1 if duplicate message received in same mail msg #
 K ^TMP("RCERR1",$J)
 S ^TMP("RCERR1",$J,1)=$S(DUP>0:"This an exact duplicate of an ERA received previously in mail msg "_RCNOUPD,1:"This ERA message was already fully processed - message was ignored")
 Q
 ;
BULLS(RCFILE,RCTDA,DUP,RCXMSG) ; Error bulletins for ERA
 ; PRCA*4.5*298 - DUPLICATE TRANSMISSION MSG AND EEOB - EXCEPTIONS message disabled - 14 Feb 2014
 ;I RCFILE=5 D BULL1^RCDPESR5(RCTDA,"^TMP(""RCERR1"",$J)",$S($G(DUP)>0:$G(DUP),1:""))
 I RCFILE=4 D BULL2^RCDPESR5(RCTDA,"^TMP(""RCERR1"",$J)",RCXMSG)
 Q
 ;
ADJERR(RCERR) ; Set up adj error text in RCERR(n) - pass by ref
 ; Function returns # of lines for error text
 S RCERR(1)="At least 1 adjustment transaction has been found on this ERA.  Before the",RCERR(2)="   receipt for this ERA can be processed, the appropriate adjustments",RCERR(3)="   must be made using the EEOB Worklist",RCERR(4)=" "
 Q 4
 ;
