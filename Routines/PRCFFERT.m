PRCFFERT ;WISC/SJG-OBLIGATION ERROR PROCESSING REBUILD/RETRANSMIT ;7/24/00  23:20
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
TYPE(X) N FMSNO,STATUS
 S PRC("SITE")=$P(X,U)
 I ("^AR^MO^SO^"'[("^"_$P(X,U,2)_"^")) D MSG1^PRCFFERM,OUT Q
 S STATUS=$G(GECSDATA(2100.1,GECSDATA,3,"E"))
 D MSG^PRCFFER2($E(STATUS,1),.PRCFA) ; display transaction status info
 D NUM^PRCFFERU ; put external PO# from GECSDATA into PONUM
 D GET^PRCFFERU(442,PONUM) ; DIC call
 I Y<0 D MSG2^PRCFFERM Q
 S PO=Y,PO(0)=Y(0),PO(0,0)=Y(0,0)
 S POIEN=+Y
 K MOP S MOP=$P(Y(0),U,2) I MOP="" D MSG3^PRCFFERM Q
 D GECS ; save selected txn's type & action in PRCFA("GECS")
 I ("^1^2^3^4^7^8^26^"[("^"_MOP_"^")) I PRCFA("ERROR") D TPO
 I MOP=21 I PRCFA("ERROR") D T1358
 D OUT
 D SCREEN
 QUIT
 ;
TPO ; Purchase Order Error Processing when MOP = Invoice/Rec Rep,CI,Req
 I $D(PRCFA("ERTYP")),PRCFA("ERTYP")'="POREQ" W !! D MSG5^PRCFFERM H 3 Q
 S D0=+Y D STATR1^PRCFFERU(2)
 S X=$P($G(RESP),U) I X D ^PRCHDP1
 W ! S RETRAN=$$RETRANS^PRCFFERU(.RETRAN)
 S X=$P($G(RETRAN),U) I 'X D MSG4^PRCFFERM H 3 Q
TPO1 D
 .S PRCFA("RETRAN")=1
 .S PRCFA("PODA")=+PO,PCP=$P(PO(0),U,3)
 .S $P(PCP,U,2)=$S($D(^PRC(420,PRC("SITE"),1,+PCP,0)):$P(^(0),U,12),1:"")
 .I '$D(PRC("FY")) D
 ..N FYQ S FYQ=$$FYQ^PRCFFERU(.FYQ)
 ..S PRC("FY")=$P(FYQ,U),PRC("QTR")=$P(FYQ,U,2)
 ..Q
 .I '$D(PRC("PARAM")) S PRC("PARAM")=$$NODE^PRC0B("^PRC(411,PRC(""SITE""),",0)
 .N PRCRGS,MODDOC S FLG=0
 .S MODDOC=$P($G(PRCFA("GECS")),"^",3)
 .S PRCRGS=$S(MODDOC="":1,MODDOC]"":2)
 .I MODDOC="" D RETRAN^PRCFFMO Q
 .I MODDOC]"" D  Q
 ..N RBLD S RBLD=$G(GECSDATA(2100.1,GECSDATA,26,"E"))
 ..I RBLD]"" S (PRCFA("AMEND#"),PRCFAA)=$P(RBLD,"/",2),PRCFPODA=+PO
 ..I RBLD="" D
 ...S (PRCFA("AMEND#"),X)=0
 ...F  S X=$O(^PRC(442,+PO,6,X)) Q:X'>0  S PRCFAA=X
 ...S PRCFA("AMEND#")=PRCFAA,PRCFPODA=+PO
 ...Q
 ..D SETAM,RETRAN^PRCFFMOM
 ..Q
 .Q
 Q
SETPO ;
 S FMSSEC=$$SEC1^PRC0C(PRC("SITE"))
 S DESC="Purchase Order Obligation Rebuild/Transmit"
 S:MODDOC]"" DESC="Purchase Order Amendment Rebuild/Transmit"
 D REBUILD^GECSUFM1(GECSDATA,"I",FMSSEC,"Y",DESC)
 S GECSFMS("DA")=GECSDATA
 Q
SETAM ;
 N DIC S DIC="^PRC(442,"_+PO_",6,",DIC(0)="MNZ",X=PRCFA("AMEND#")
 D ^DIC I +Y>0 S PO(6)=Y(0),PO(6,1)=^PRC(442,+PO,6,PRCFA("AMEND#"),1)
 Q
T1358 ; 1358 Error Processing when MOP = MISC OBL(1358)
 I $D(PRCFA("ERTYP")),PRCFA("ERTYP")'="MISCOBL" W !! D MSG5^PRCFFERM H 3 Q
 D STATR1^PRCFFERU(2)
 D GENDIQ^PRCFFU7(442,+POIEN,".07","I","")
 S (OB,DA)=$G(PRCTMP(442,+POIEN,".07","I"))
 D NODE^PRCS58OB(DA,.TRNODE)
 I '$D(PRC("CP")) S PRC("CP")=$P(TRNODE(0),"-",4)
 S X=$P($G(RESP),U) I X D
 .D PAUSE1^PRCFFERU
 .S IOP="HOME" D ^%ZIS,^PRCE58P0
 .Q
 W ! S RETRAN=$$RETRANS^PRCFFERU(.RETRAN)
 S X=$P($G(RETRAN),U) I 'X D MSG4^PRCFFERM H 3 Q
T13581 D
 .S PRCFA("RETRAN")=1,DA=OB
 .I '$D(PRC("FY")) D
 ..N FYQ S FYQ=$$FYQ^PRCFFERU(.FYQ)
 ..S PRC("FY")=$P(FYQ,U),PRC("QTR")=$P(FYQ,U,3)
 ..Q
 .I '$D(PRC("PARAM")) S PRC("PARAM")=$$NODE^PRC0B("^PRC(411,PRC(""SITE""),",0)
 .N PRCRGS,MODDOC
 .S MODDOC=$P($G(PRCFA("GECS")),"^",3)
 .S PRCRGS=$S(MODDOC="":1,MODDOC]"":2)
 .I MODDOC="" D SC^PRCESOE Q
 .I MODDOC]"" D  Q
 ..N RBLD S RBLD=$G(GECSDATA(2100.1,GECSDATA,26,"E"))
 ..I RBLD]"" S Y=$P(RBLD,"/",4)
 ..I RBLD="" D
 ...S PATNUM=$$STRIP^PRCFFERU(PATNUM)
 ...S Y=$O(^PRCS(410,"D",PATNUM,0))
 ...Q
 ..W ! D RETRAN^PRCEADJ1 Q
 Q
 ;
SET1358 S FMSSEC=$$SEC1^PRC0C(PRC("SITE"))
 S DESC="1358 Obligation Rebuild/Transmit"
 S:MODDOC]"" DESC="1358 Obligation Adjustment Rebuild/Transmit"
 D REBUILD^GECSUFM1(GECSDATA,"I",FMSSEC,"Y",DESC)
 S GECSFMS("DA")=GECSDATA
 Q
 ;
 ; get current txn's type, action & amendment/adjustment #
GECS N LOOP,NODE,X
 S LOOP=0,PRCFA("GECS")=""
 F  S LOOP=$O(^PRC(442,+PO,10,LOOP)) Q:LOOP'>0!($G(PRCFA("GECS"))'="")  D
 . S NODE=^PRC(442,+PO,10,LOOP,0)
 . I GECSDATA(2100.1,GECSDATA,.01,"E")=$P(NODE,"^",4) D
 . . S PRCFA("GECS")=$E(NODE,1,2)_"^"_$E(NODE,4)_"^"_$P(NODE,"^",10)_"^"_$P(NODE,"^",9)
 . . I MOP=21 S $P(PRCFA("GECS"),"^",3)=$P(NODE,"^",11) ; 1358s
 Q
 ;
 ; find all FMS txn associated with the amendment/adjustment #
 ; PO = purchase order ien
 ; VER = amendment/adjustment #
 ; MOP = method of processing
 ; returns DOC IDs for SO, AR.E, AR.M codesheets on same amend/adjust#
GETTXNS(PO,VER,MOP) N LOOP,NODE,PRCSOE,PRCSOM,PRCARE,PRCARM,PRCCAN,TYPE,X
 S TYPE=10 I MOP=21 S TYPE=11 ; piece holding amend/adjust#
 S LOOP=0,(PRCSOE,PRCSOM,PRCARE,PRCARM,PRCCAN)=""
 F  S LOOP=$O(^PRC(442,+PO,10,LOOP)) Q:LOOP'>0  D
 . S NODE=^PRC(442,+PO,10,LOOP,0)
 . I $E(NODE,1,4)="SO.E",VER=$P(NODE,"^",TYPE) S PRCSOE=$P(NODE,"^",4)
 . I $E(NODE,1,4)="SO.M",VER=$P(NODE,"^",TYPE) S PRCSOM=$P(NODE,"^",4)
 . I $E(NODE,1,4)="AR.E",VER=$P(NODE,"^",TYPE) S PRCARE=$P(NODE,"^",4)
 . I $E(NODE,1,4)="AR.M",VER=$P(NODE,"^",TYPE) S PRCARM=$P(NODE,"^",4)
 . I $E(NODE,4)="X",VER=$P(NODE,"^",TYPE) S PRCCAN=1 ; canceled amend#
 S X=PRCSOE_"^"_PRCSOM_"^"_PRCARE_"^"_PRCARM_"^"_PRCCAN
 Q X
 ;
 ;
 ; Compares transaction types passed to string of existing transactions
 ;  returns .01 field of file 2100.1 if transaction type is in string
 ;           zero, if types are not in string
 ; 
 ; TXNTP = Transaction Type
 ; TXNAC = Transaction Action
 ; STRING (Of 2100.1 doc id's) = SOE ^ SOM ^ ARE ^ ARM ^ flag for cancel
 ; 
NEWCHK(TXNTP,TXNAC,STRING) N DOCID
 S DOCID=0
 I $P(TXNTP,"^",5)'=1 D  ; amend# canceled
 . I $P(TXNTP,":")="SO",TXNAC="E",$P(STRING,"^",1)]"" S DOCID=$P(STRING,"^",1)
 . I $P(TXNTP,":")="SO",TXNAC="M",$P(STRING,"^",2)]"" S DOCID=$P(STRING,"^",2)
 . I $P(TXNTP,":")="AR",TXNAC="E",$P(STRING,"^",3)]"" S DOCID=$P(STRING,"^",3)
 . I $P(TXNTP,":")="AR",TXNAC="M",$P(STRING,"^",4)]"" S DOCID=$P(STRING,"^",4)
 Q DOCID
 ;
 ; Check the selected transaction
 ; if unavailable, give message & return '^'
 ; if available, set up GECSDATA array and return 1
SWITCH(DOCID,MP,GECSDATA) ;
 N STATUS,X
 D EN^DDIOL("Document exists for "_DOCID_".  Attempting to rebuild.")
 D EN^DDIOL(" ")
 S STATUS=$$STATUS^GECSSGET(DOCID)
 I "RENT"'[$E(STATUS) D
 . D EN^DDIOL("Unable to rebuild now -- document has status of "_STATUS_".")
 . S X=$S($E(DOCID,1,2)="AR":"AR",MP=21:"SO",1:"MO/SO")
 . D EN^DDIOL("Please rebuild "_DOCID_" later using the "_X_" option.")
 . S X="^"
 I "RENT"[$E(STATUS) D
 . D DATA^GECSSGET(DOCID,0)
 . D EN^DDIOL("Rebuild will continue using "_DOCID_".")
 . S X=1
 Q X
 ;
OUT K GECSDATA,FMSNO,STATUS,DIC,FMSSEC,DESC
 Q
SCREEN ; Control screen display
 I $D(IOF) W @IOF
HDR ; Write Option Header
 I $D(XQY0) W IOINHI,$P(XQY0,U,2),IOINORM
 Q
