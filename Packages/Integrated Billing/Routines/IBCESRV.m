IBCESRV ;ALB/TMP - Server interface to IB from Austin ;8/6/03 10:04am
 ;;2.0;INTEGRATED BILLING;**137,181,196,232,296,320,407,623**;21-MAR-94;Build 70
 ;;Per VA Directive 6402, this routine should not be modified.
SERVER ; Entry point for server option to process EDI msgs received from Austin
 ;
 N IBEFLG,IBERR,IBTDA,XMER,IBXMZ,IBHOLDCT
 K ^TMP("IBERR",$J),^TMP("IBMSG",$J),^TMP("IBMSGH",$J),^TMP("IB-HOLD",$J),^TMP("IBMSG-H",$J)
 S IBXMZ=$G(XMZ)
 S IBEFLG=$$MSG(.XMER,.IBTDA,IBXMZ)
 D:$G(IBEFLG) PERROR^IBCESRV1(.IBERR,.IBTDA,"G.IB EDI",IBXMZ)
 N ZTREQ
 D DKILL^IBCESRV1(IBXMZ) S ZTREQ="@"
 K ^TMP("IBERR",$J),^TMP("IBMSG",$J),^TMP("IBMSGH",$J),^TMP("IB-HOLD",$J),^TMP("IBMSG-H",$J)
 Q
 ;
MSG(XMER,IBTDA,IBXMZ) ; Read/Store message lines
 ;
 I '$D(XMER) S XMER=""  ;JWS IB*2.0*623
 ;     Return message formats:
 ;        Ref:  Your <queue name> message #<msg#> with Austin ID #<id #>,
 ;              is assigned confirmation number <confirmation #>.
 ;              Generates an 837REC0 message
 ;        277STAT - claim status messages - Generates one or more 837REC1
 ;                                          837REC2 or 837REJ1 messages
 ;        837DEL - bill entry # from File 364
 ;        835EOB - Explanation of Benefits messages
 ;        REPORT - Free text Envoy report file - may contain one or more
 ;                 reports that are turned into bulletins
 ;
 ; OUTPUT:
 ;  Function returns flag ... 0 = no errors    1 = errors
 ;  IBTDA - array subscripted by ien of message file entries created
 ;          If array entry = 1, the message was only partially stored
 ;
 N IBLAST,IBTYP,IBTYP1,IB0,IBBTCH,IBDATE,IBHD,IBMG,IBRTN,IBTXN,IBTXND,XMDUZ,IBGBL,IBD,IBEFLG,IBHOLDCT,IBWANT,X,Y,Z
 K ^TMP("IBERR",$J),^TMP("IBMSG",$J),^TMP("IBMSGH",$J),^TMP("IB-HOLD",$J)
 ;
 S (IBEFLG,IBERR,IBTXN)="",IBGBL="IBTXN",IBLAST=0
 S IBD("MSG#")=IBXMZ
 S IBHD=$$NET^XMRENT(IBXMZ)
 S IBD("SUBJ")=$P(IBHD,U,6)
 S (X,IBDATE)=$P(IBHD,U)
 I X'="" D  ;Reformat date, if needed
 . I X'["@" S X=$P(X," ",1,3)_"@"_$P(X," ",4)
 . N %DT
 . S %DT="XTS" D ^%DT S:Y>0 IBDATE=Y\.0001*.0001
 ;
 K ^TMP("IB-HOLD",$J) N IBHOLDCT S IBHOLDCT=0
 S IBD("Q")=$E(IBD("SUBJ"),1,3)
 I $G(IBD("SUBJ"))?.E1(1" MCR",1" MCT",1" MCH")1" Confirmation" D  G MSGQ:$G(IBERR),MSG1
 . S IBD("Q")="MC"_$E($P(IBD("SUBJ")," MC",2))
 . ;Austin confirmation
 . X XMREC ; Line 1 of message
 . S:XMER'<0 IBHOLDCT=IBHOLDCT+1,^TMP("IB-HOLD",$J,IBHOLDCT)=XMRG
 . I XMER<0 D  Q
 .. S IBERR=3
 .. S ^TMP("IBERR",$J,"MSG",1)=IBHD
 .. S ^TMP("IBERR",$J,"MSG",2)=$G(XMRG)
 . S IBTXN=XMRG
 . S IBBTCH=+$O(^IBA(364.1,"MSG",+$P(IBTXN,"#",2)\1,""),-1)
 . ;;JWS IB*2.0*623 - looking for original message #, but there won't be one, so check if FHIR
 . I 'IBBTCH S IBBTCH=$P($P(IBTXN,"#",2),")")
 . I 'IBBTCH S IBERR=6 D REST(.IBTXN,IBGBL) Q  ;No msgs match conf recpt
 . S IBTXN("BATCH",IBBTCH,0)="837REC0^"_IBD("MSG#")_U_+$E($P(IBD("SUBJ")," "),4,14)_"^^"_IBBTCH_U_IBDATE
 . X XMREC ;Get second line of the message
 . I XMER<0 S IBERR=2 Q
 . S IBTXN("BATCH",IBBTCH,1)=IBTXN_" "_XMRG_"$",IBTXN=IBTXN("BATCH",IBBTCH,0)
 . S IBHOLDCT=IBHOLDCT+1,^TMP("IB-HOLD",$J,IBHOLDCT)=XMRG
 . S IBLAST=1
 . Q
 ; Read header line of non-confirmation message (line 1)
 F  X XMREC Q:$S(XMER<0:1,1:$E(XMRG,1,13)'="RACUBOTH RUCH")
 S:XMER'<0 IBHOLDCT=IBHOLDCT+1,^TMP("IB-HOLD",$J,IBHOLDCT)=XMRG
 I XMER<0 D  G MSGQ
 . S IBERR=3
 . S ^TMP("IBERR",$J,"MSG",1)=IBHD
 . S ^TMP("IBERR",$J,"MSG",2)=$G(XMRG)
 ;
 S IBTXN=XMRG
MSG1 I $E(IBTXN,$L(IBTXN)-3,$L(IBTXN))?3A1"."!(IBTXN="NNNN"),IBHOLDCT>1 S XMER=-1,IBLAST=1 G MSGQ
 ;
 S IBTYP1=$S($P(IBTXN,U)="277STAT":"837REC1",1:$P(IBTXN,U))
 S IBTYP=$S(IBTYP1="":"",1:$O(^IBE(364.3,"B",IBTYP1,"")))
 I IBTYP="" S IBERR=1 D REST(.IBTXN,IBGBL) G MSGQ ;Bad msg type
 ;
 S IB0=$G(^IBE(364.3,IBTYP,0)),IBRTN=$P(IB0,U,3,4),IBMG=$P(IB0,U,2)
 I $TR(IBRTN,U)="" S IBERR=5 D REST(.IBTXN,IBGBL) G MSGQ ;No routine defined
 ;
 S IBWANT=1
 I 'IBLAST,XMER'<0 D  G:IBLAST&(XMER<0) MSGQ ;Message is other than Austin confirmation
 . S IBGBL="^TMP(""IBMSG"","_$J_")"
 . S @IBGBL=$P(IBTXN,U),^TMP("IBMSGH",$J,0)=IBTXN
 . ;
 . I $P(IBTXN,U)="277STAT" D  Q  ;Claim status message
 .. F  X XMREC Q:XMER<0  D  Q:IBLAST  ;Extract rest of message
 ... S IBHOLDCT=IBHOLDCT+1,^TMP("IB-HOLD",$J,IBHOLDCT)=XMRG
 ... I +XMRG=99,$P(XMRG,U,2)="$" S IBLAST=1 Q
 ... S IBD=XMRG,Z=+XMRG_"^IBCE277(.IBD)"
 ... S IBTXN=XMRG
 ... I '$$CKLABEL(Z,.IBTXN,IBGBL) S IBLAST=1,IBWANT=0,XMER=-1,IBERR=7 Q
 ... D @Z
 . ;
 . I $P(IBTXN,U)="835EOB" D  Q  ;Explanation of Benefits message
 .. F  X XMREC Q:XMER<0  D  Q:IBLAST  ;Extract rest of message
 ... S IBHOLDCT=IBHOLDCT+1,^TMP("IB-HOLD",$J,IBHOLDCT)=XMRG
 ... I +XMRG=99,$P(XMRG,U,2)="$" S IBLAST=1 Q
 ... S IBD=XMRG,Z=+XMRG_"^IBCE835(.IBD)"
 ... S IBTXN=XMRG
 ... I '$$CKLABEL(Z,.IBTXN,IBGBL) S IBLAST=1,IBWANT=0,XMER=-1,IBERR=7 Q
 ... D @Z
 . ;
 . I $P(IBTXN,U)="REPORT" D  Q  ; Report file
 .. D REPORT^IBCERPT(IBHD,IBDATE,.IBD,IBTXN)
 .. I '$O(^TMP("IBMSG",$J,"REPORT",0,"D",0,0)) S IBWANT=0
 . ;
 . ; ****** Insert code for additional message types here and in ^IBCEM
 ;
 I IBLAST,IBWANT D ADD(IBGBL,.IBTDA,.IBERR)
 ;
 I 'IBLAST,'$G(IBERR) K @IBGBL S IBERR=2 ;No $ as last character of message
MSGQ I $G(IBERR) D ERRUPD^IBCESRV1(IBGBL,.IBERR) S IBEFLG=1
 Q IBEFLG
 ;
REST(IBTXN,IBGBL) ;Extract raw message data if not id-ed or can't process
 N CT,Z
 S CT=0
 S Z=0 F  S Z=$O(^TMP("IB-HOLD",$J,Z)) Q:'Z  S CT=CT+1,@IBGBL@("BATCH",0,"D",0,CT)="##RAW DATA: "_$G(^TMP("IB-HOLD",$J,Z))
 F  X XMREC Q:XMER<0  S:XMRG'="" CT=CT+1,@IBGBL@("BATCH",0,"D",0,CT)="##RAW DATA: "_XMRG
 Q
 ;
ADD(IBGBL,IBTDA,IBERR) ; Add message(s) in @IBGBL to file #364.2
 ;   Errors returned in IBERR
 ;   Message entry #'s are returned in IBTDA(ien)=""
 ;
 N IB,IBA,IBB,IBC,IBDATA,IBHDR,IBLINE,IBTYP,IBRTN
 S IBA="" F  S IBA=$O(@IBGBL@(IBA)) Q:IBA=""!(IBERR=3)  S IBB="" F  S IBB=$O(@IBGBL@(IBA,IBB)) Q:IBB=""!(IBERR=3)  D
 . S IBHDR=$G(@IBGBL@(IBA,IBB,0))
 . Q:IBHDR=""
 . S IBTYP=$S($P(IBHDR,U)="":"",1:$O(^IBE(364.3,"B",$P(IBHDR,U),""))),IBRTN=$P($G(^IBE(364.3,IBTYP,0)),U,3,4)
 . S IBTDA=$$ADDTXN(IBHDR) ;File message hdr data
 . I IBTDA'>0 S IBERR=3 Q  ;msg hdr can't be filed
 . S IBTDA(IBTDA)=""
 . D LOADDET(IBA,IBB,.IBTDA,IBGBL,.IBERR,$P(IBHDR,U,1))
 . Q:$G(IBERR)  ;Message not completely filed
 . D TRTN^IBCESRV1(IBTDA):$TR(IBRTN,U)'="" ;Task update to run
 Q
 ;
ADDTXN(IBDATA,REPORT) ; Add a trxn for msg in IBDATA to file 364.2
 ; REPORT = 1 if storing a report format message
 ;Function returns ien of the new entry in file 364.2 or "" if an error
 ;
 N A,IBDA,IBBTCH,IBBILL,IBDT,IBTEST,DLAYGO,DIC,DD,DO,X,Y,Z,IBIFN
 ;
 S IBDA="",IBBTCH=$P(IBDATA,U,5),IBBILL=$P(IBDATA,U,4),IBIFN=0
 I IBBILL S IBIFN=+$G(^IBA(364,IBBILL,0))
 S IBDT=$P(IBDATA,U,6)
 S IBTEST=0
 I $E($G(IBD("Q")),1,3)="MCT" D
 . I IBBILL,'$P($G(^IBA(364,IBBILL,0)),U,7),$D(^IBM(361.4,IBIFN,0)) S IBTEST=1 Q  ; Resubmit live claim for test (make sure 361.4 exists)
 . I IBBTCH,$O(^IBM(361.4,"C",IBBTCH,0)) S IBTEST=1 Q  ; Resubmit live claim as test batch
 ;
 S (X,A)=$G(IBD("MSG#")) ; Use msg ID for .01 field
 F Z=1:1 Q:'$D(^IBA(364.2,"B",A))  S A=X_"."_Z
 S X=A
 S DIC(0)="L",DIC="^IBA(364.2,",DLAYGO=364.2
 S DIC("DR")=".02///"_$P(IBDATA,U)_";.03///^S X=""NOW"";.08////"_($P(IBDATA,U,7)="Y")_";.13////"_$P(IBDATA,U,8)_$S(IBBILL="":"",1:";.05////"_IBBILL)_";.06////P;.1////"_IBDT_$S(IBBTCH="":"",1:";.04////"_IBBTCH)_";.14////"_IBTEST
 D FILE^DICN
 S:Y>0 IBDA=+Y
 ;
 Q IBDA
 ;
LOADDET(IB1,IB2,IBTDA,IBGBL,IBERR,IBTNM) ; Load the rest of the message text into the message
 ; IB1 = "BATCH" or "CLAIM" or "REPORT"
 ; IB2 = batch # or claim # or 0
 ; IBTDA = ien in file 364.2 being updated
 ; IBGBL = name of the array holding the detail message text to be loaded
 ; IBTNM = message name (i.e. "835EOB","837REC0","REPORT",etc.)
 ;
 ; OUTPUT: IBERR if any errors found, pass by reference
 ;         IBTDA(IBTDA)=1 if errors - pass by reference
 ;
 S IBTDA=+$G(IBTDA)
 N CT,IB3,IBE,IBZ,Q
 ;
 K ^TMP("IBTEXT",$J)
 ;
 S (CT,IB3)=0 ;Put formatted data into msg
 F  S IB3=$O(@IBGBL@(IB1,IB2,IB3)) Q:'IB3  S CT=CT+1,^TMP("IBTEXT",$J,CT)=@IBGBL@(IB1,IB2,IB3)
 ; Add identifying data from hdr record
 S IB3=0 F  S IB3=$O(^TMP("IBMSG-H",$J,IB1,IB2,IB3)) Q:'IB3  S CT=CT+1,^TMP("IBTEXT",$J,CT)=^TMP("IBMSG-H",$J,IB1,IB2,IB3)
 ;
 ; Put raw data into msg
 I $G(IBTNM)'="835EOB" D
 . S IBZ="" F  S IBZ=$O(@IBGBL@(IB1,IB2,"D",IBZ)) Q:IBZ=""  S IB3=0 F  S IB3=$O(@IBGBL@(IB1,IB2,"D",IBZ,IB3)) Q:'IB3  S CT=CT+1,^TMP("IBTEXT",$J,CT)=@IBGBL@(IB1,IB2,"D",IBZ,IB3)
 I $G(IBTNM)="835EOB" D
 . S IB3=0 F  S IB3=$O(@IBGBL@(IB1,IB2,"D1",IB3)) Q:'IB3  S IBZ="" F  S IBZ=$O(@IBGBL@(IB1,IB2,"D1",IB3,IBZ)) Q:IBZ=""  S CT=CT+1,^TMP("IBTEXT",$J,CT)=@IBGBL@(IB1,IB2,"D1",IB3,IBZ)
 ;
 D STOREM^IBCESRV2(IBTDA,"^TMP(""IBTEXT"",$J)",.IBE)
 ;
 I $D(IBE("DIERR")) D  S:$L($G(IBE)) IBERR(IBTDA,IB1,IB2)=IBE ; Extract error
 . D EXTERR^IBCESRV1(.IBERR,.IBTDA,.IBE)
 K ^TMP("IBTEXT",$J)
 Q
 ;
CKLABEL(Z,IBTXN,IBGBL) ;  Checks to be sure label in Z exists.
 ; If it doesn't exist, files an error and returns 0 
 ;  OR  returns 1 if it does exist
 N X,LAB
 S X=1,LAB=$P(Z,"(")
 I $S('LAB!($L($P(LAB,U))>8):1,1:$T(@LAB)="") S X=0 D REST(.IBTXN,IBGBL)
 Q X
 ;
ERROR ; Error condition messages
 ;;Message code does not exist in IB MESSAGE ROUTER file (364.3).
 ;;This message has no ending $.
 ;;Message file problem - no message stored.
 ;;Message file problem - message partially stored.
 ;;Routine to process this message type does not exist.
 ;;Batch does not exist for this confirmation message.
 ;;Bad message format found - cannot store message.
 ;
