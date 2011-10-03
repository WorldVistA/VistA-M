RCTOP1 ;WASH IRMFO@ALTOONA,PA/TJK-TOP TRANSMISSION ;2/11/00  9:36 AM
V ;;4.5;Accounts Receivable;**141**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified
EN1(DEBTOR,AMOUNT,CODE,EFFDT,BILL,FILE) ;ENTRY POINT TO COMPILE TYPE 1 DOCUMENTS INTO GLOBAL
 ;NEEDS DEBTOR INTERNAL NUMBER,AMOUNT  AND CODE:"M","U","Y","R","RV"
 ;BILL WILL BE 0 FOR "M","U","Y" DOCUMENTS
 Q:'DEBTOR  Q:'FILE
 N DEBTOR0,DEBTOR1,REC,DEBNR,ACTION,TAXID,OTAXID,NAME,ONAME,DEBTOR4
 N DEBTOR6
 ;
 ;set debtor record in temporary global
 ;
 S DEBTOR0=$G(^RCD(340,DEBTOR,0)),DEBTOR4=$G(^(4)),DEBTOR6=$G(^(6))
 S REC="04      "_$P(^RC(342,1,3),U,5)_"      "
 S DEBNR=$E(SITE,1,3)_$S(FILE=2:0,FILE=440:"V",1:"E")_$TR($J(DEBTOR,14)," ",0),REC=REC_DEBNR
 S:CODE="M" ACTION="A"
 S:CODE="Y" ACTION="Y"
 I CODE="U" S ACTION=$S(AMOUNT>0:"I",1:"S")
 I $E(CODE)="R" S ACTION=$$REFCD(CODE,BILL) Q:ACTION=""
 S TAXID=$$TAXID(DEBTOR,FILE),OTAXID=$P(DEBTOR4,U)
 S REC=REC_ACTION_1_$S(CODE="M":TAXID,1:OTAXID)
 S NAME=$$NAME(+DEBTOR0,FILE),NM=$P(NAME,U,2),NAME=$P(NAME,U)
 S ONAME=$P(DEBTOR4,U,2),REC=REC_$S(CODE="M":NAME,1:ONAME)
 I CODE="U" D
    .I NAME=ONAME,TAXID=OTAXID Q
    .;
    .;COMPILES ALIAS DOCUMENT IF NECESSARY
    .;
    .D EN1^RCTOP4(NAME,TAXID,DEBTOR4,DEBTOR,FILE)
    .Q
 S REC=REC_$$DATE8(EFFDT)_"          "_$$AMOUNT(AMOUNT)_"MO"_$S(FILE=440:"B",1:"I")_" "
 S REC=REC_$S('BILL:"          ",1:$P(^PRCA(430,BILL,14),U,3))_$$BLANK(40)
 S CNTR(1)=CNTR(1)+1,^XTMP("RCTOPD",$J,1,CNTR(1))=REC
 S ^XTMP("RCTOPD",$J,"REC",NM_TAXID_"#:"_CNTR(1))=$$LJ^XLFSTR($E(NM,1,30),30)_"   "_TAXID_"   "_CODE_"   "_$J(AMOUNT,12,2)
 ;
 ;set debtor, bill file data
 ;
 I CODE="M" S $P(^RCD(340,DEBTOR,4),U)=TAXID,$P(^(4),U,2)=NAME,$P(^(4),U,3)=AMOUNT,$P(^(4),U,6)=EFFDT,$P(^(6),U)=DT,^RCD(340,"TOP",DEBTOR,DT)=""
 I CODE="U" S $P(^(4),U,3)=$P(^RCD(340,DEBTOR,4),U,3)+AMOUNT,$P(^(4),U,6)=EFFDT
 I $E(CODE)="R" S DIE="^PRCA(430,",DA=BILL,DR="142///^S X=$S(CODE=""R"":2,1:4)" D ^DIE
 S I=0 F  S I=$O(^TMP("RCTOPD",$J,"BILL",I)) Q:I'?1N.N  S:'$P($G(^PRCA(430,I,14)),U) $P(^(14),U)=DT
 Q
 ;
DATE8(X) ;changes fileman date into 8 digit date yyyymmdd
 S X=DT+17000000
 Q X
 ;
AMOUNT(X) ;changes amount to zero filled, right justified
 S:X<0 X=-X
 S X=$TR($J(X,0,2),".")
 S X=$E("000000000000",1,12-$L(X))_X
 Q X
 ;
NAME(DEBTOR,FILE) ;returns name for document and name in file
 N FN,LN,MN,NM,DOCNM
 I FILE=440 S NM=$P($G(^PRC(440,DEBTOR,0)),U),MN="",LN=$E(NM,1,35),FN=$E(NM,36,70) G DOCNM
 S NM=$S(FILE=2:$P($G(^DPT(DEBTOR,0)),"^"),1:$P($G(^VA(200,DEBTOR,0)),U))
 S LN=$TR($P(NM,",")," .'-"),MN=$P($P(NM,",",2)," ",2)
 I ($E(MN,1,2)="SR")!($E(MN,1,2)="JR")!(MN?2.3"I")!(MN?0.1"I"1"V"1.3"I") S MN=""
 S FN=$P($P(NM,",",2)," ")
DOCNM S DOCNM=$$LJ^XLFSTR($E(LN,1,35),35)_$$LJ^XLFSTR($E(FN,1,35),35)_$S(MN="":" ",1:$E(MN))
QNM Q DOCNM_U_NM
 ;
BLANK(X) ;returns 'x' blank spaces
 N BLANK
 S BLANK="",$P(BLANK," ",X+1)=""
 Q BLANK
 ;
TAXID(DEBTOR,FILE) ;computes tax id (tid) to place on documents
 N TAXID,DIC,DA,DR,DIQ
 I FILE'=440 S TAXID=$$SSN^RCFN01(DEBTOR) G TAXIDQ
 S DIC="^PRC(440,",DA=+^RCD(340,DEBTOR,0),DR="38",DIQ="TAXID(",DIQ(0)="E"
 D EN^DIQ1 S TAXID=TAXID(440,DA,38,"E")
TAXIDQ S:$L(TAXID)'=9 TAXID="         "
 Q TAXID
 ;
REFCD(CODE,BILL) ;computes action code for refund/refund reversal documents
 N REFYR,REFCD,X
 S REFCD="",REFYR=$P($G(^PRCA(430,BILL,14)),U,4)
 S:'REFYR REFYR=$E(DT,1,3)+1700
 S X="",X=$O(^RC(348.2,"B",REFYR,X)) G REFCDQ:'X
 S REFCD=$S(CODE="R":$P(^RC(348.2,X,0),U,2),1:$P(^RC(348.2,X,0),U,3))
REFCDQ Q REFCD
