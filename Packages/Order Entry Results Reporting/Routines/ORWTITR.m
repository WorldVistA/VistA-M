ORWTITR ;ISP/LMT - Titrating RX Renewals ;Jul 27, 2018@06:49
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**405**;Dec 17, 1997;Build 211
 ;
 ;
 ; Reference to DOSE^PSSORUTL supported by ICR #3233
 ;
 Q
 ;
 ; *******************************************************
 ; Edits Order Dialog Responses for titration renews.
 ; Only use responses after last "then".
EDTDLG(ORDIALOG,ORIFN) ;
 ;
 N ORCHILD,ORCONJ,ORI,ORINSTR,ORLASTTHEN,ORM,ORSEQ,ORSIG
 ;
 I '$G(ORDIALOG) S ORDIALOG=+$P($G(^OR(100,+ORIFN,0)),U,5)
 ;
 S ORINSTR=$$PTR^ORCD("OR GTX INSTRUCTIONS")
 S ORCONJ=$$PTR^ORCD("OR GTX AND/THEN")
 S ORSIG=$$PTR^ORCD("OR GTX SIG")
 ;
 ; Find last "then" conjunction
 S ORLASTTHEN=0
 S ORI="00"
 F  S ORI=$O(ORDIALOG(ORCONJ,ORI),-1) Q:'ORI!(ORLASTTHEN)  D
 . I ORDIALOG(ORCONJ,ORI)="T" S ORLASTTHEN=ORI
 I 'ORLASTTHEN Q
 ;
 ; Remove all responses for OR GTX INSTRUCTIONS that precede last "then"
 D DELRESP(.ORDIALOG,ORINSTR,ORLASTTHEN)
 ;
 ; Remove all responses for children of OR GTX INSTRUCTIONS that precede last "then"
 S ORSEQ=0
 F  S ORSEQ=$O(^ORD(101.41,ORDIALOG,10,"DAD",ORINSTR,ORSEQ)) Q:ORSEQ=""  D
 . S ORM=0
 . F  S ORM=$O(^ORD(101.41,ORDIALOG,10,"DAD",ORINSTR,ORSEQ,ORM)) Q:'ORM  D
 . . S ORCHILD=$P($G(^ORD(101.41,ORDIALOG,10,ORM,0)),U,2)
 . . D DELRESP(.ORDIALOG,ORCHILD,ORLASTTHEN)
 ;
 ; recalculate QTY
 ; ** TODO - We might need to allow provider to change the QTY we calculate; need to ask Rob**
 D QTY(.ORDIALOG,+ORIFN)
 ;
 ;Remove Titration response
 D REMTITR(.ORDIALOG,+ORIFN)
 ;
 ; recalculate SIG
 K ORDIALOG(ORSIG,1)
 D SIG(.ORDIALOG,+ORIFN)
 ;
 Q
 ;
 ;**********************
 ; deletes all dialog responses <= ORNUM
DELRESP(ORDIALOG,ORPTR,ORNUM) ;
 ;
 N ORCNT,ORI,ORNEW
 ;
 I '$D(ORDIALOG(ORPTR)) Q
 ;
 ; only keep responses > ORNUM
 S ORCNT=0
 S ORI=0
 F  S ORI=$O(ORDIALOG(ORPTR,ORI)) Q:'ORI  D
 . I ORI>ORNUM D
 . . S ORCNT=ORCNT+1
 . . S ORNEW(ORCNT)=ORDIALOG(ORPTR,ORI)
 . K ORDIALOG(ORPTR,ORI)
 M ORDIALOG(ORPTR)=ORNEW
 ;
 ; if there are no more responses left, kill the entire ORDIALOG entry
 I '$O(ORDIALOG(ORPTR,0)) D  Q
 . S ORI=$$UP^XLFSTR($P($G(ORDIALOG(ORPTR,"A")),":",1))
 . I ORI'="" K ORDIALOG("B",ORI)
 . K ORDIALOG(ORPTR)
 ;
 Q
 ;
 ;************************************
 ; Recalculates SIG
SIG(ORDIALOG,ORIFN) ;
 ;
 N ORDOSE,ORDRUG,ORCAT,ORVP,ORWPSOI,PROMPT,DRUG
 ;
 S ORVP=$P($G(^OR(100,+ORIFN,0)),U,2)
 S ORCAT=$P($G(^OR(100,+ORIFN,0)),U,12)
 S PROMPT=$$PTR^ORCD("OR GTX INSTRUCTIONS")
 S ORDRUG=$G(ORDIALOG($$PTR^ORCD("OR GTX DISPENSE DRUG"),1))
 S ORWPSOI=+$G(ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1))
 I ORWPSOI S ORWPSOI=+$P($G(^ORD(101.43,+ORWPSOI,0)),U,2)
 D DOSE^PSSORUTL(.ORDOSE,ORWPSOI,$S(ORCAT="I":"U",1:"O"),ORVP)  ; ICR #3233
 D D1^ORCDPS2  ; set up ORDOSE
 S DRUG=$G(ORDOSE("DD",+ORDRUG))
 I DRUG,ORCAT="O" D RESETID^ORCDPS
 D SIG^ORCDPS2
 ;
 Q
 ;
 ;************************************
 ; Recalculates QTY
QTY(ORDIALOG,ORIFN) ;
 ;
 N ORDRUG,ORDSUP,ORQTY,ORVP
 ;
 S ORVP=$P($G(^OR(100,+ORIFN,0)),U,2)
 S ORDRUG=$G(ORDIALOG($$PTR^ORCD("OR GTX DISPENSE DRUG"),1))
 S ORDSUP=$G(ORDIALOG($$PTR^ORCD("OR GTX DAYS SUPPLY"),1))
 ;
 S ORQTY=+$$QTY^ORCDPS1
 ;I ORQTY>0 S ORDIALOG($$PTR^ORCD("OR GTX QUANTITY"),1)=ORQTY
 S ORDIALOG($$PTR^ORCD("OR GTX QUANTITY"),1)=ORQTY
 ;
 Q
 ;
 ;************************************
 ; remove Titration response
REMTITR(ORDIALOG,ORIFN) ;
 ;
 N ORTITR
 ;
 S ORTITR=$$PTR^ORCD("OR GTX TITRATION")
 D DELRESP(.ORDIALOG,ORTITR,1)
 ;
 Q
 ;
 ; *************************************
 ; return Order Text based off updated ORDIALOG
ORDTXT(ORTXT,ORIFN,ORDIALOG) ;
 ;
 N ORTX
 ;
 D ORTX^ORCSAVE1(240)
 M ORTXT=ORTX
 ;
 Q
 ;
 ; *******************************************
 ; For renewals, Return new Order Text for titration order
 ; and new Qty
RNWFLDS(ORTX,ORMSG,ORIFN) ;
 ;
 N ORDIALOG,ORFIRST,ORI,ORNEWQTY,OROLDQTY,ORTMP,WIDTH,X
 ;
 S ORDIALOG=$P($G(^OR(100,ORIFN,0)),U,5)
 I ORDIALOG'["101.41," Q ""
 S ORDIALOG=+ORDIALOG
 D GETDLG^ORCD(ORDIALOG)
 D GETORDER^ORCD(+ORIFN)
 S OROLDQTY=$G(ORDIALOG($$PTR^ORCD("OR GTX QUANTITY"),1))
 D EDTDLG(.ORDIALOG,ORIFN)
 S ORNEWQTY=$G(ORDIALOG($$PTR^ORCD("OR GTX QUANTITY"),1))
 ;
 ; Return Order Text
 D ORDTXT(.ORTMP,ORIFN,.ORDIALOG)
 S WIDTH=255
 S ORTX=1
 S ORTX(ORTX)=""
 S ORFIRST=+$O(ORTMP(0))
 S ORI=0
 F  S ORI=$O(ORTMP(ORI)) Q:'ORI  D
 . S X=$G(ORTMP(ORI))
 . I ORFIRST=ORI,$E(X,1,3)=">> " S X=$E(X,4,999)
 . I $L(X) D ADD^ORQ12
 ;
 ; Return message to the user
 S ORMSG(1)="** This is a titrating RX; only the maintenance portion of the RX is being renewed. "
 I ORNEWQTY>0 D
 . S ORMSG(1)=ORMSG(1)_"Quantity has been changed from "_OROLDQTY_" to "_ORNEWQTY_". **"
 E  D
 . S ORMSG(1)=ORMSG(1)_"Please enter the updated Quantity. **"
 ;
 K ^TMP("ORWORD",$J)
 ;
 Q ORNEWQTY
 ;
 ; *******************************************
 ; Returns TMP with dialog responses after editing them for titration renews.
 ; Save responses in ORDIALOG() into ^TMP("ORWTITR",$J,ORIFN,4.5).
 ;
GETTMP(ORIFN) ;
 ;
 N CNT,INST,ITM,ORDIALOG,ORROOT,PROMPT,TYPE,VALUE
 ;
 K ^TMP("ORWTITR",$J)
 ;
 S ORDIALOG=$P($G(^OR(100,ORIFN,0)),U,5)
 I ORDIALOG'["101.41," Q ""
 S ORDIALOG=+ORDIALOG
 D GETDLG^ORCD(ORDIALOG)
 D GETORDER^ORCD(ORIFN)
 D EDTDLG(.ORDIALOG,ORIFN)
 ;
 ;for the most part, copied this code from RESPONSE^ORCSAVE
 S (PROMPT,CNT)=0
 F  S PROMPT=$O(ORDIALOG(PROMPT)) Q:PROMPT'>0  D
 . S ITM=$G(ORDIALOG(PROMPT)) Q:'ITM
 . S TYPE=$E($G(ORDIALOG(PROMPT,0))) Q:'$L(TYPE)
 . S INST=0
 . F  S INST=$O(ORDIALOG(PROMPT,INST)) Q:INST'>0  D
 . . S VALUE=$G(ORDIALOG(PROMPT,INST))
 . . I VALUE="" Q
 . . S CNT=CNT+1
 . . S ^TMP("ORWTITR",$J,ORIFN,4.5,CNT,0)=+ITM_U_PROMPT_U_INST_U_$P(ITM,U,2)
 . . S:$L($P(ITM,U,2)) ^TMP("ORWTITR",$J,ORIFN,4.5,"ID",$P(ITM,U,2),CNT)=""
 . . I VALUE<1,TYPE="N" S VALUE=0_+VALUE I VALUE="00" S VALUE=0
 . . S:TYPE'="W" ^TMP("ORWTITR",$J,ORIFN,4.5,CNT,1)=VALUE
 . . M:TYPE="W" ^TMP("ORWTITR",$J,ORIFN,4.5,CNT,2)=@VALUE ; array root
 ;
 K ^TMP("ORWORD",$J)
 S ORROOT=$NA(^TMP("ORWTITR",$J,ORIFN,4.5))
 ;
 Q ORROOT
