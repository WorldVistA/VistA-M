IBJTRX ;ALB/ESG - TPJI ePharmacy ECME claim information ;22-Oct-2010
 ;;2.0;INTEGRATED BILLING;**435,452,494,521**;21-MAR-94;Build 33
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to $$CLAIM^BPSBUTL supported by IA# 4719
 ; Reference to BPS RESPONSES file# 9002313.03 supported by IA# 4813
 ; Reference to $$NPI^XUSNPI supported by IA# 4532
 ; Reference to ^BPSVRX supported by IA# 5723
 ;
 Q
 ;
EN ; -- main entry point for IBJT ECME RESP INFO
 N IBZ,IBRXDATA,IBRXIEN,X,Y
 D FULL^VALM1
 I '$G(IBIFN) W !!,"No Claim Defined!" D PAUSE^VALM1 G EX
 I '$$ISRX^IBCEF1(IBIFN) W !!,"Not available. This is not a Pharmacy Claim." D PAUSE^VALM1 G EX
 I $$ECME^IBTRE(IBIFN)="" W !!,"Not available. This is a Pharmacy Claim, but not an ECME Claim." D PAUSE^VALM1 G EX
 ;
 S IBZ=+$O(^IBA(362.4,"C",IBIFN,0))
 I 'IBZ W !!,"Rx data not found for this claim." D PAUSE^VALM1 G EX
 S IBRXDATA=$G(^IBA(362.4,IBZ,0))
 S IBRXIEN=+$P(IBRXDATA,U,5)            ; RX ien ptr file 52
 I 'IBRXIEN W !!,"Rx IEN cannot be determined." D PAUSE^VALM1 G EX
 ;
 D EN^VALM("IBJT ECME RESP INFO")
EX ;
 S VALMBCK="R"
 Q
 ;
HDR ; -- header code
 D HDR^IBJTU1(+IBIFN,+DFN,13)
 Q
 ;
INIT ; -- init variables and list array
 N IBM1,ECME,ECMEAP,RXORG,DOCIEN,PHARMNPI,DOCNPI,RESPIEN,ZR,RSPSUB,ZM,BPSM,BPSMCOB,IBLINE,ZC,ZCTOT,ZCN
 N IBZ,IBRXDATA,IBRXIEN,IBRXFILL,IBCOBN,IBBPS,IB0,IBS,IBHPD,IBVL,IBCPY,IBM0
 K ^TMP("IBJTRX",$J)
 S VALMCNT=0
 ;
 S IBZ=+$O(^IBA(362.4,"C",IBIFN,0))
 S IBRXDATA=$G(^IBA(362.4,IBZ,0))
 S IBRXIEN=+$P(IBRXDATA,U,5)            ; RX ien ptr file 52
 S IBRXFILL=+$P(IBRXDATA,U,10)          ; rx fill#
 S IBCOBN=+$$COBN^IBCEF(IBIFN)          ; current payer sequence #
 S IBBPS=$$CLAIM^BPSBUTL(IBRXIEN,IBRXFILL,IBCOBN)    ; DBIA 4719
 ;
 S IBM1=$G(^DGCR(399,IBIFN,"M1"))
 S IB0=$G(^DGCR(399,IBIFN,0))
 S IBS=$G(^DGCR(399,IBIFN,"S"))
 S ECME=$P($P(IBM1,U,8),";",1)               ; ECME#
 S ECMEAP=$P(IBM1,U,9)                       ; ECME approval number
 S RXORG=$$RXSITE^IBCEF73A(IBIFN)            ; pharmacy file 4 ien
 S DOCIEN=$$RXAPI1^IBNCPUT1(IBRXIEN,4,"I")   ; ien of doctor who wrote the Rx (52,4)
 S (PHARMNPI,DOCNPI)=""
 I RXORG S PHARMNPI=$P($$NPI^XUSNPI("Organization_ID",RXORG),U,1)   ; pharmacy NPI
 I DOCIEN S DOCNPI=$P($$NPI^XUSNPI("Individual_ID",DOCIEN),U,1)     ; doctor NPI
 I PHARMNPI'>0 S PHARMNPI="No NPI on file"
 I DOCNPI'>0 S DOCNPI="No NPI on file"
 ;
 S RESPIEN=+$P(IBBPS,U,3)    ; BPS response file ien
 I RESPIEN D
 . ; IB*2.0*521 - add HPID from response to TPJI screen
 . S IBM0=$G(^DGCR(399,IBIFN,"M")),IBCPY=$S($P(IB0,U,21)="P":$P(IBM0,U),$P(IB0,U,21)="S":$P(IBM0,U,2),1:$P(IBM0,"^",3))
 . I $P($G(^BPSR(RESPIEN,560)),U,8)="01" S IBHPD=$P($G(^BPSR(RESPIEN,560)),U,9) S IBVL=$$HOD^IBCNHUT1(IBHPD,IBCPY)
 . S ZR=RESPIEN_","
 . S RSPSUB=+$O(^BPSR(RESPIEN,1000,0))
 . I RSPSUB D
 .. S ZM=RSPSUB_","_RESPIEN_","
 .. D GETS^DIQ(9002313.0301,ZM,"129;133:137;505;506;507;509;517:520;571;572","IEN","BPSM")  ; get selected $ amount fields
 .. D GETS^DIQ(9002313.0301,ZM,"355.01*","IEN","BPSMCOB")  ; get cob/other payer data fields
 .. Q
 . Q
 ;
 S IBLINE=$$SETL("",ECME,"ECME No",25,11,1)
 S IBLINE=$$SETL(IBLINE,PHARMNPI,"Pharmacy NPI",14,15,40)
 D SET(IBLINE)
 ;
 S IBLINE=$$SETL("",ECMEAP,"ECME Ap No",25,11,1)
 S IBLINE=$$SETL(IBLINE,DOCNPI,"Provider NPI",14,15,40)
 D SET(IBLINE)
 ; IB*2.0*521 - add validated HPID from response to TPJI screen
 S:$G(IBVL)="" IBVL="^HPID/OEID" S IBLINE=$$SETL("",$G(IBHPD),$P(IBVL,U,2),25,11,1)
 D SET(IBLINE)
 ;
 D SET(" ")
 S IBLINE=$$SETL("",$P(IBRXDATA,U,1)_" / "_IBRXFILL,"Rx No",31,11,1)
 S IBLINE=$$SETL(IBLINE,$$FMTE^XLFDT($P(IBRXDATA,U,3),"2Z"),"Date of Svc",8,15,40)
 D SET(IBLINE)
 ;
 S IBLINE=$$SETL("",$$RXAPI1^IBNCPUT1(IBRXIEN,6,"E"),"Drug Name",36,11,1)
 S IBLINE=$$SETL(IBLINE,$P(IBRXDATA,U,8),"NDC #",24,15,40)
 D SET(IBLINE)
 ;
 S IBLINE=$$SETL("",$$AMT(+$P($G(^DGCR(399,IBIFN,"U1")),U,1)),"Billed Amt",36,11,1)
 S IBLINE=$$SETL(IBLINE,$S(IBCOBN=2:"Secondary",IBCOBN=3:"Tertiary",1:"Primary"),"COB",15,15,40)
 D SET(IBLINE)
 ;
 D SET(" ")
 ;
 ; For cancelled bills only, display the IB cancel status, date, and reason (IB*2*494)
 I $P(IB0,U,13)=7 D
 . S IBLINE=$$SETL("","CANCELLED ("_$$FMTE^XLFDT($P(IBS,U,17),"2DZ")_")","IB Status",20,11,1)
 . S IBLINE=$$SETL(IBLINE,$P(IBS,U,19),"Reason",100,6,36)
 . D SET(IBLINE),SET(" ")
 . Q
 ;
 ; if response data is not available, get out here
 ;
 I 'RESPIEN D  G INITX
 . D SET(" ECME Response Information is not on file.")
 . D SET(" No further information available for display.")
 . Q
 ;
 S IBLINE=$$SETL("",,"Payment Information",,20,1)
 D SET(IBLINE,"3;2;19")
 ;
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,506,"E"))),"Ingredient Cost Paid",15,26,1) D SET(IBLINE)
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,507,"E"))),"Dispensing Fee Paid",15,26,1) D SET(IBLINE)
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,505,"E")),,1),"Patient Resp (Ins)",15,26,1) D SET(IBLINE)
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,509,"E"))),"Expected Payment Amount",15,26,1) D SET(IBLINE)
 ;
 D SET(" ")
 S IBLINE=$$SETL("",,"Patient Responsibility Amounts",,31,1)
 D SET(IBLINE,"3;2;30")
 ;
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,517,"E"))),"Deductible",10,13,1)
 S IBLINE=$$SETL(IBLINE,$$AMT($G(BPSM(9002313.0301,ZM,572,"E"))),"Coinsurance",10,13,27)
 S IBLINE=$$SETL(IBLINE,$$AMT($G(BPSM(9002313.0301,ZM,518,"E"))),"Amount of Copay",9,18,52)
 D SET(IBLINE)
 ;
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,137,"E"))),"Coverage Gap",10,13,1)
 S IBLINE=$$SETL(IBLINE,$$AMT($G(BPSM(9002313.0301,ZM,571,"E"))),"Processor Fee",10,13,27)
 S IBLINE=$$SETL(IBLINE,$$AMT($G(BPSM(9002313.0301,ZM,520,"E"))),"Exceed Benefit Max",9,18,52)
 D SET(IBLINE)
 ;
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,129,"E"))),"Health Plan-funded Assistance Amount",15,39,1)
 D SET(IBLINE)
 ;
 D SET(" ")
 S IBLINE=$$SETL("",,"Product Selection Amounts",,26,1)
 D SET(IBLINE,"3;2;25")
 ;
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,519,"E"))),"Prod Sel Amt",12,21,1)
 S IBLINE=$$SETL(IBLINE,$$AMT($G(BPSM(9002313.0301,ZM,135,"E"))),"Prod Sel /Non-Pref Formulary",9,33,37)
 D SET(IBLINE)
 ;
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,134,"E"))),"Prod Sel/Brand Drug",12,21,1)
 S IBLINE=$$SETL(IBLINE,$$AMT($G(BPSM(9002313.0301,ZM,136,"E"))),"Prod Sel/Brand Non-Pref Formulary",9,33,37)
 D SET(IBLINE)
 ;
 S IBLINE=$$SETL("",$$AMT($G(BPSM(9002313.0301,ZM,133,"E"))),"Provider Network Adj",12,21,1)
 D SET(IBLINE)
 ;
 ; Display COB/Other Payer data
 I '$D(BPSMCOB(9002313.035501)) D  G INITX
 . D SET(" ")
 . D SET(" No COB/Other Payer Data on file in the ECME Response.")
 . Q
 ;
 S ZC="" F ZCTOT=0:1 S ZC=$O(BPSMCOB(9002313.035501,ZC)) Q:ZC=""     ; count how many entries exist
 S ZC="",ZCN=0 F  S ZC=$O(BPSMCOB(9002313.035501,ZC)) Q:ZC=""  D
 . S ZCN=ZCN+1
 . D SET(" ")
 . S IBLINE="COB/Other Payer ("_ZCN_" of "_ZCTOT_") (from other payer response message)"
 . D SET(" "_IBLINE,"3;2;"_$L(IBLINE))
 . S IBLINE=$$SETL("",$G(BPSMCOB(9002313.035501,ZC,356,"E")),"Other Payer Cardholder ID",40,27,1)
 . D SET(IBLINE)
 . S IBLINE=$$SETL("",$G(BPSMCOB(9002313.035501,ZC,144,"E")),"Other Payer Effective Date",10,27,1)
 . S IBLINE=$$SETL(IBLINE,$G(BPSMCOB(9002313.035501,ZC,145,"E")),"Other Payer Termination Date",10,32,38)
 . D SET(IBLINE)
 . S IBLINE=$$SETL("",$G(BPSMCOB(9002313.035501,ZC,142,"E")),"Other Payer Person Code",6,27,1)
 . S IBLINE=$$SETL(IBLINE,$G(BPSMCOB(9002313.035501,ZC,143,"E")),"Other Payer Pt Relationship Code",9,32,38)
 . D SET(IBLINE)
 . S IBLINE=$$SETL("",$G(BPSMCOB(9002313.035501,ZC,340,"E")),"Other Payer ID (BIN)",24,27,1)
 . S IBLINE=$$SETL(IBLINE,$G(BPSMCOB(9002313.035501,ZC,991,"E")),"Other Payer PCN",9,32,38)
 . D SET(IBLINE)
 . S IBLINE=$$SETL("",$G(BPSMCOB(9002313.035501,ZC,992,"E")),"Other Payer Group ID",40,27,1)
 . D SET(IBLINE)
 . S IBLINE=$$SETL("",$G(BPSMCOB(9002313.035501,ZC,127,"E")),"Other Payer Help Desk",40,27,1)
 . D SET(IBLINE)
 . Q
 ;
INITX ;
 D SET(" "),SET(" ")
 Q
 ;
VER ; Action to launch the View ePharmacy Rx report
 N BPSVRX
 K ^TMP("BPSVRX-TPJI",$J)
 D FULL^VALM1
 I $G(IBRXDATA)="" W !!,"System error. IBRXDATA missing." D PAUSE^VALM1 G VERX
 ;
 ; save the current TPJI display array data
 M ^TMP("BPSVRX-TPJI",$J,"IBJTCA")=^TMP("IBJTCA",$J)
 M ^TMP("BPSVRX-TPJI",$J,"IBJTRX")=^TMP("IBJTRX",$J)
 M ^TMP("BPSVRX-TPJI",$J,"IBTPJI")=^TMP($J,"IBTPJI")
 ;
 S BPSVRX("RXIEN")=+$P(IBRXDATA,U,5)            ; RX ien ptr file 52
 S BPSVRX("FILL#")=+$P(IBRXDATA,U,10)           ; rx fill#
 D ^BPSVRX                                      ; DBIA #5723
 ;
 ; After returning from this List Manager report, we need to rebuild
 ; the display array for the TPJI screens because they are killed by the report.
 I '$D(^TMP("IBJTCA",$J)) M ^TMP("IBJTCA",$J)=^TMP("BPSVRX-TPJI",$J,"IBJTCA")
 I '$D(^TMP("IBJTRX",$J)) M ^TMP("IBJTRX",$J)=^TMP("BPSVRX-TPJI",$J,"IBJTRX")
 I '$D(^TMP($J,"IBTPJI")) M ^TMP($J,"IBTPJI")=^TMP("BPSVRX-TPJI",$J,"IBTPJI")
 ;
VERX ;
 S VALMBCK="R"
 K ^TMP("BPSVRX-TPJI",$J)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("IBJTRX",$J)
 I $D(VALMEVL) D CLEAN^VALM10,KILL^VALM10()
 Q
 ;
SETL(TEXT,DATA,LABEL,LEND,LENL,COL) ; build line of text
 ;  TEXT - existing line of text data
 ;  DATA - field data
 ; LABEL - field label
 ;  LEND - max length of data
 ;  LENL - length of label (label will be right justified so the colons line up)
 ;   COL - starting column for insert
 ;
 N D1,STR S D1="",COL=$G(COL,1)
 I $G(LABEL)'="" S D1=$J(LABEL,+$G(LENL))
 I $D(DATA) S D1=D1_": "_$$FO^IBCNEUT1(DATA,+$G(LEND))
 S STR=$$SETSTR^VALM1(D1,$G(TEXT),COL,$L(D1))
 ;
 Q $E(STR,1,80)
 ;
SET(TEXT,VID) ; set data in variable TEXT into ListMan display
 ; VID is video attribute data of line if any
 ;      Format: type;start column;width
 ;      type=1 (reverse video)
 ;      type=2 (bold)
 ;      type=3 (underline)
 ;
 S VALMCNT=VALMCNT+1
 S ^TMP("IBJTRX",$J,VALMCNT,0)=$G(TEXT)    ; set text line into display array
 I $G(VID)="" G SETX
 ;
 ; video attributes
 N ON,OFF
 S ON=$S(+VID=1:IORVON,+VID=2:IOINHI,1:IOUON)
 S OFF=$S(+VID=1:IORVOFF,+VID=2:IOINORM,1:IOUOFF)
 D CNTRL^VALM10(VALMCNT,+$P(VID,";",2),+$P(VID,";",3),ON,OFF)
 ;
SETX ;
 Q
 ;
AMT(VAL,L,P) ; convert dollar amount to external display
 ; VAL can be a number or the Fileman external version of the number
 ;   L is the $J field length (default 8)
 ;   P is a flag indicating the number should be enclosed within parentheses
 ; strip $ and spaces
 S VAL=+$TR($G(VAL),"$ ")
 I '$G(L) S L=8
 I $G(P) Q $J($FN(-VAL,"P",2),L+1)
 Q $J(VAL,L,2)
 ;
