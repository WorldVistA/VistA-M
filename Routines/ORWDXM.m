ORWDXM  ; SLC/KCM/JLI - Order Dialogs, Menus;10:42 AM  3/29/02 10:47AM  4/3/2002 11AM  4/5/2002 4:30PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,132**;Dec 17, 1997
 ;
MENU(LST,DLG)   ; Return menu contents for an order dialog
 ; LST(0)=name^# cols^path switch^^^ Key Variables (pieces 6-20)
 ; LST(n)=col^row^type^ien^formid^autoaccept^display text^mnemonic
 ;        ^displayonly
 N ILST,I,COL,ROW,IEN,TYP,FID,AUT,MNE,DON,X,X0,X5,NUMCOL
 S X0=$G(^ORD(101.41,DLG,0)),X5=$G(^(5)),ILST=0,NUMCOL=1
 ;S COL=$P(X5,U) S:'COL COL=80 S COL=80\COL
 S LST(0)=$P(X0,U,2)_U_NUMCOL_U_$P(X5,U,3)
 S $P(LST(0),U,6)=$$KEYVAR^ORWDXM3(DLG) ; key vars start at 6th piece
 S I=0 F  S I=$O(^ORD(101.41,DLG,10,I)) Q:'I  D
 . S X=$G(^ORD(101.41,DLG,10,I,0))
 . S ROW=$P(X,U),COL=$P(ROW,".",2),ROW=$P(ROW,".",1)
 . I COL>NUMCOL S NUMCOL=COL
 . S IEN=+$P(X,U,2),MNE=$P(X,U,3),DON=$P(X,U,5),X=$P(X,U,4)
 . S X0=$G(^ORD(101.41,IEN,0)),X5=$G(^(5))
 . S TYP=$P(X0,U,4),FID=+$P(X5,U,5),AUT=$P(X5,U,8)
 . I '$L(X) S X=$P($G(^ORD(101.41,IEN,0)),U,2)
 . S ILST=ILST+1,LST(ILST)=COL_U_ROW_U_TYP_U_IEN_U_FID_U_AUT_U_X_U_MNE_U_DON
 S $P(LST(0),U,2)=NUMCOL
 Q
PROMPTS(LST,DLG)        ; Return prompting info for generic dialog
 ; LST(n)=ID^REQ^HID^PROMPT^TYPE^DOMAIN^DEFAULT^IDFLT^HELP^XREF^SCR
 N I,X,ILST,SEQ,REQ,HID,ITM,IDX,PRMT,HLP,DFLT,IDFLT,TYP,DOM,ID,WP,SCR
 S ILST=0
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,DLG,10,"B",SEQ)) Q:'SEQ  D
 . S I=0 F  S I=$O(^ORD(101.41,DLG,10,"B",SEQ,I)) Q:'I  D
 . . S X=$G(^ORD(101.41,DLG,10,I,0))
 . . S ITM=$P(X,U,2),REQ=+$P(X,U,6),IDX=$P(X,U,10),PRMT=$P(X,U,14)
 . . I '$L(PRMT) S PRMT=$P(X,U,4)
 . . S HLP=$P($G(^ORD(101.41,DLG,10,I,1)),U,1)
 . . S HID=$E($G(^ORD(101.41,DLG,10,I,3)),1,3)="I 0"
 . . S SCR="" I $L($G(^ORD(101.41,DLG,10,I,4))) S SCR=DLG_":"_I
 . . S X=$G(^ORD(101.41,ITM,0)) I '$L(PRMT) S PRMT=$P(X,U,2)
 . . S X=$G(^ORD(101.41,ITM,1)),TYP=$P(X,U),DOM=$P(X,U,2),ID=$P(X,U,3)
 . . S X=$G(^ORD(101.41,DLG,10,I,7)) D XDFLT(X,TYP,DOM,.IDFLT,.DFLT)
 . . I '$L(ID) S ID="ID"_ITM
 . . S ILST=ILST+1
 . . S LST(ILST)="~"_ID_U_REQ_U_HID_U_PRMT_U_TYP_U_DOM_U_DFLT_U_IDFLT_U_HLP_U_IDX_U_SCR
 . . ; loop here to append any default word processing
 . . S WP=0 F  S WP=$O(^ORD(101.41,DLG,10,I,8,WP)) Q:'WP  D
 . . . S ILST=ILST+1,LST(ILST)="t"_$G(^ORD(101.41,DLG,10,I,8,WP,0))
 Q
XDFLT(CODE,TYPE,DOMAIN,IVAL,EVAL) ; return internal, external default values
 S (IVAL,EVAL)="" Q:'$L(CODE)
 ; set err trap here?
 N ID,REQ,HID,PRMT,TYP,DOM,DFLT,IDFLT,HLP,Y  ; to protect PROMPTS
 X CODE
 S IVAL=$G(Y),EVAL=IVAL
 I TYPE="D",IVAL S EVAL=$$FMTE^XLFDT(IVAL)
 I TYPE="P",IVAL,DOMAIN S EVAL=$$GET1^DIQ(+DOMAIN,IVAL_",",.01)
 I TYPE="S",$L(IVAL) S EVAL=$P($P(DOMAIN,IVAL_":",2),";",1)
 I TYPE="Y",$L(IVAL) S EVAL=$S(IVAL=1:"YES",1:"NO")
 Q
DLGNAME(VAL,DLG)        ; Return name(s) of dialog & base dialog given IEN
 ; VAL=InternalName^DisplayName^BaseDialogIEN^BaseDialogName
 N INT,EXT,BIEN,BNAM
 S INT=$P($G(^ORD(101.41,DLG,0)),U),EXT=$P($G(^(0)),U,2)
 S BNAM=INT,BIEN=DLG
 I $P(^ORD(101.41,DLG,0),U,4)="Q" D
 . N DGRP S DGRP=$P($G(^ORD(101.41,DLG,0)),U,5) Q:'DGRP
 . S BIEN=$$DEFDLG^ORWDXQ(DGRP),BNAM=$P(^ORD(101.41,BIEN,0),U)
 S VAL=INT_U_EXT_U_BIEN_U_BNAM
 Q
FORMID(VAL,DLG) ; Return the FormID for a dialog
 S VAL=+$P($G(^ORD(101.41,DLG,5)),U,5) Q:VAL
 I $P($G(^ORD(101.41,DLG,0)),U,4)="Q" D
 . N DGRP S DGRP=$P($G(^ORD(101.41,DLG,0)),U,5) Q:'DGRP
 . S DLG=$$DEFDLG^ORWDXQ(DGRP) Q:'DLG
 . S VAL=+$P($G(^ORD(101.41,DLG,5)),U,5)
 I 'VAL,$P($G(^ORD(101.41,DLG,0)),U,7)=$O(^DIC(9.4,"C","OR",0)) D
 . S VAL=152  ; use generic "on the fly" form
 Q
MSTYLE(VAL)     ; Return the menu style for the system
 S VAL=+$$GET^XPAR("SYS","ORWDXM ORDER MENU STYLE",1,"I")
 Q
LOADSET(LST,DLG)        ; Return the contents of an order set
 ; LST(0): SetDisplayText^Key Variables
 ; LST(n): DlgIEN^DlgType^DisplayText^OrderableItemIENs(OIIEN;OIIEN;..)
 N SEQ,DA,ITM,TYP,ILST,X,OIENS,PKGINFO
 S LST(0)=$P(^ORD(101.41,DLG,0),U,2)_U_$$KEYVAR^ORWDXM3(DLG),ILST=0
 S SEQ="" F  S SEQ=$O(^ORD(101.41,DLG,10,"B",SEQ)) Q:SEQ=""  D
 . S DA=0 F  S DA=$O(^ORD(101.41,DLG,10,"B",SEQ,DA)) Q:'DA  D
 . . S X=$G(^ORD(101.41,DLG,10,DA,0)),ITM=$P(X,U,2),X=$P(X,U,4)
 . . Q:'ITM  Q:'$D(^ORD(101.41,+ITM,0))
 . . S (OIENS,PKGINFO)=""
 . . S TYP=$P(^ORD(101.41,ITM,0),U,4)
 . . S OIENS=$$OIIFN(+ITM)
 . . S PKGINFO=$$PKGINF(+ITM)
 . . I '$L(X) S X=$P($G(^ORD(101.41,ITM,5)),U,4)
 . . I '$L(X) S X=$P($G(^ORD(101.41,ITM,0)),U,2)
 . . I '$L(X) S X="Display Name Missing"
 . . S ILST=ILST+1,LST(ILST)=ITM_U_TYP_U_X_U_OIENS_U_PKGINFO
 Q
PKGINF(DLG) ; Get Package based on the DLG ID
 N PKGID,PKGNM
 S PKGID="",PKGNM=""
 S:$D(^ORD(101.41,DLG,0)) PKGID=$P(^(0),U,7)
 I PKGID D
 . S:$D(^DIC(9.4,PKGID,0)) PKGNM=$P(^(0),U,2)
 Q PKGNM
OIIFN(DLG) ; Get Orderable Item IENs based on the DLG
 N OIDX,OINODE,OINUM,OIIENS,OI0
 S (OIIENS,OINODE,OIIENS)=""
 S OINUM=0
 S OIDX=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 S:$D(^ORD(101.41,DLG,6,"D",OIDX)) OINODE=$O(^(OIDX,0))
 S:OINODE OINUM=$P(^ORD(101.41,DLG,6,OINODE,0),U,3)
 I OINUM  F OI0=1:1:OINUM  S OIIENS=OIIENS_^(OI0)_";"
 Q OIIENS
AUTOACK(REC,ORVP,ORNP,ORL,ORIT)       ; Place a quick order without verify step
 N ORDG,ORDUZ,ORSTS,OREVENT,ORCAT,ORDA,ORTS,ORNEW,ORCHECK,ORLOG
 N ORDIALOG,ORIFN,ORLEAD,ORTRAIL
 S ORVP=ORVP_";DPT(",ORL(2)=ORL_";SC(",ORL=ORL(2)
 S DGRP=$P($G(^ORD(101.41,ORIT,0)),U,5) Q:'DGRP
 S ORDIALOG=$$DEFDLG^ORWDXQ(DGRP)
 I ORDIALOG=$O(^ORD(101.41,"B","PSO OERR",0)) S ORCAT="O"      ; temp
 I ORDIALOG=$O(^ORD(101.41,"B","PSJ OR PAT OE",0)) S ORCAT="I" ; temp
 D GETDLG1^ORCD(ORDIALOG)
 D GETORDER^ORCD("^ORD(101.41,"_ORIT_",6)")
 ; check required fields?
 D EN^ORCSAVE
 S REC="" I ORIFN D GETBYIFN^ORWORR(.REC,ORIFN)
 Q
ALLRSP(QUIK)    ; Return 1 if quick order has values for all responses
 N ALLOK,DLG,ITM,PRMT
 S ALLOK=1,DLG=+$$DEFDLG^ORWDXQ(+$P($G(^ORD(101.41,QUIK,0)),U,5))
 S ITM=0 F  S ITM=$O(^ORD(101.41,DLG,10,ITM)) Q:'ITM  D  Q:'ALLOK
 . Q:$P($G(^ORD(101.41,DLG,10,ITM,0)),U,8)=1
 . S PRMT=$P(^ORD(101.41,DLG,10,ITM,0),U,2)
 . I '$$HASRSP(QUIK,PRMT) S ALLOK=0
 Q ALLOK
HASRSP(QUIK,PRMT)    ; Return 1 if quick order has response for prompt
 N FND,RSP S FND=0
 S RSP=0 F  S RSP=$O(^ORD(101.41,QUIK,6,RSP)) Q:'RSP  D  Q:FND
 . I $P(^ORD(101.41,QUIK,6,RSP,0),U,2)=PRMT S FND=1
 Q FND
  
