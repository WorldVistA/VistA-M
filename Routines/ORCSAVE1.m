ORCSAVE1 ; SLC/MKB - Save Order Text ;02/24/09  13:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**92,132,141,163,187,223,243,280**;Dec 17, 1997;Build 85
 ;
 ; ^ORD(101.41,+ORDIALOG,10,ITM,2)=Seq#^Format^Omit^Lead Text^Trail Text
 ; ^ORD(101.41,+ORDIALOG,10,"ATXT",Seq#,ITM)=""
 ;
ORDTEXT(ORDER) ; -- Build and save order text from ORDIALOG() into ORDER
 N ORTX,I,IFN,ACT,ORSET
 D ORTX(240) Q:'$G(ORTX)
 S IFN=+ORDER,ACT=+$P(ORDER,";",2) S:ACT'>0 ACT=1
 F I=1:1:ORTX S ^OR(100,IFN,8,ACT,.1,I,0)=ORTX(I)
 S ^OR(100,IFN,8,ACT,.1,0)=U_U_ORTX_U_ORTX_U_DT_U
 I $E($G(ORDEA))=2 D  ;PKI Drug Schedule - in future may allow 2-5
 . S ORSET=0
 . D DIGTEXT(IFN,ORDEA)
 . F I=1:1:ORSET S ^OR(100,IFN,8,ACT,.2,I,0)=ORSET(I)
 . I ORSET>0 S ^OR(100,IFN,8,ACT,.2,0)=U_U_ORSET_U_ORSET_U_DT_U
 Q
 ;
ORTX(WIDTH) ; -- May enter here to return order text in ORTX()
 N ORP,SEQ,ITEM,ORMAX,IVIEN,IVITEM,IVTYPE,RATE
 K ORTX S ORMAX=$S(+$G(WIDTH):WIDTH,1:240)
 D EXT ; get external form of values
 S SEQ=0 F  S SEQ=$O(^ORD(101.41,+ORDIALOG,10,"ATXT",SEQ)) Q:SEQ'>0  D
 . S ITEM=0 F  S ITEM=$O(^ORD(101.41,+ORDIALOG,10,"ATXT",SEQ,ITEM)) Q:ITEM'>0  D TEXT(ITEM)
 Q
 ;
TEXT(DA) ; -- Includes text of item DA
 Q:$P(^ORD(101.41,ORDIALOG,10,DA,0),U,11)  Q:'$O(ORP(DA,0))
 N NEWLN,INST,TYPE,PTR,CHSEQ,CHILD,ORI,X,Y
 S:'$G(ORTX) ORTX=1,ORTX(1)=""
 S NEWLN=+$P(ORP(DA),U,4),INST=$O(ORP(DA,0)),Y=""
 I NEWLN,$L(ORTX(ORTX)) S ORTX=ORTX+1,ORTX(ORTX)="",Y=" "
 S X=$$GETXT($P(ORP(DA),U,2)) I $L(X) S X=Y_X,Y="" D TXT^ORCHTAB ;lead tx
 S PTR=+ORP(DA),TYPE=$E(ORDIALOG(PTR,0))
TXT1 I TYPE'="W" S X=Y_ORP(DA,INST),Y="" D TXT^ORCHTAB
 I TYPE="W" S ORI=0 F  S ORI=$O(ORP(DA,INST,ORI)) Q:ORI'>0  D  S Y=""
 . S Y=$S(Y=" ":" ",$P(ORP(DA),U,5):" ",1:"") ;new line, or as stored
 . S X=Y_ORP(DA,INST,ORI,0),Y=""
 . I $E(X)'=" " D TXT^ORCHTAB Q  ; wrap
 . S:$L(ORTX(ORTX)) ORTX=ORTX+1,ORTX(ORTX)="" ; force new line
 . I X?1." " S ORTX(ORTX)=" ",ORTX=ORTX+1,ORTX(ORTX)="" ; blank line
 . E  D TXT^ORCHTAB
 D:$D(^ORD(101.41,+ORDIALOG,10,"DAD",PTR)) CHILD(PTR)
 S INST=$O(ORP(DA,INST)) ; multiple?
 I INST S ORTX(ORTX)=ORTX(ORTX)_",",Y="" S:NEWLN ORTX=ORTX+1,ORTX(ORTX)="",Y=" " G TXT1
 S X=$$GETXT($P(ORP(DA),U,3)) D:$L(X) TXT^ORCHTAB ; trailing text
 Q
 ;
CHILD(PARENT) ; -- add child values
 N CHSEQ,CHILD S CHSEQ=0
 F  S CHSEQ=$O(^ORD(101.41,+ORDIALOG,10,"DAD",PARENT,CHSEQ)) Q:CHSEQ'>0  S CHILD=$O(^(CHSEQ,0)) D
 . Q:'$L($G(ORP(CHILD,INST)))
 . S X=$$GETXT($P(ORP(CHILD),U,2)) D:$L(X) TXT^ORCHTAB ; lead text
 . S X=ORP(CHILD,INST) D TXT^ORCHTAB
 . S X=$$GETXT($P(ORP(CHILD),U,3)) D:$L(X) TXT^ORCHTAB ; trail text
 Q
 ;
GETXT(X) ; -- Returns text of X
 I $E(X)="@" N VAR S VAR=$E(X,2,99),X=$G(@VAR) K @VAR ; variable w/text
 Q X
 ;
EXT ; -- Build ORP(DA) array of external forms
 N PROMPT,INST,DA,NODE,FORMAT,OMIT,X,Y,TYPE,PTR
 S PROMPT=0 F  S PROMPT=$O(ORDIALOG(PROMPT)) Q:PROMPT'>0  D
 . S DA=+$G(ORDIALOG(PROMPT)),TYPE=$E($G(ORDIALOG(PROMPT,0))) Q:'$L(TYPE)
 . Q:'DA  S NODE=$G(^ORD(101.41,ORDIALOG,10,DA,2)),FORMAT=$P(NODE,U,2),OMIT=$P(NODE,U,3)
 . S:$D(ORDIALOG(PROMPT,"FORMAT")) FORMAT=ORDIALOG(PROMPT,"FORMAT")
 . I $E(FORMAT)="@" S PTR=+$E(FORMAT,2,99) Q:'PTR  ; Don't include
 . S INST=0 F  S INST=$O(ORDIALOG(PROMPT,INST)) Q:INST'>0  D
 . . Q:ORDIALOG(PROMPT,INST)=""
 . . I $E(FORMAT)="@",$L($G(ORDIALOG(PTR,INST))) Q  ; use PTR instead
 . . I $E(FORMAT)="*" S PTR=+$E(FORMAT,2,99) I '$L($G(ORDIALOG(PTR,INST))) Q  ; must have PTR too
 . . I $E(FORMAT)="=" S PTR=+$E(FORMAT,2,99) I PTR,$L($G(ORDIALOG(PTR,INST))) S Y=$$EXT^ORCD(PTR,INST),X=$$EXT^ORCD(PROMPT,INST) I (X=Y)!(X[Y)!(Y[X) Q
 . . I TYPE="W" M ORP(DA,INST)=@ORDIALOG(PROMPT,INST)
 . . E  S X=$$EXT^ORCD(PROMPT,INST,FORMAT) Q:X=""  Q:OMIT[X  S ORP(DA,INST)=X
 . . S ORP(DA)=PROMPT_U_$P(NODE,U,4,7) ; ptr^lead^trail^new line^wrap
 Q
DIGTEXT(ORDER,ORDEA,ORSIGNER)  ;Build text used to create Digital Signature
 ;ORDER = ifn of order # (file 100)
 ;ORDEA = Controlled substance schedule of drug (2-5)
 ;ORSIGNER = DUZ of sigining physician
 ;ORSET(1)=1)Date of Prescription (RX) -Date Ordered HL7 format 2)Full Patient Name 3)Patient SSN 4)DFN
 ;ORSET(2)=5)Patient Street1 6)Patient Street2 7)Patient Street3 8)Patient City 9)Patient State 10)Patient Zip 11)???
 ;ORSET(3)=12)Drug name (From Dispense Drug or Orderable Item) 13)Variable ptr for Drug (file 50 or 101.43) 14)Drug quantity prescribed 15)Schedule of medication 16)DEA Schedule
 ;ORSET(4)=17)Direction for use
 ;ORSET(5)=18)Practitioner's name 19)DUZ 20)Practitioner's (DEA) registration number
 ;ORSET(6)=22)SiteName 23)SiteStreet1 24)SiteStreet2 25)SiteCity 26)SiteState 27)SiteZip
 ;ORSET(7)=28)$H
 N I,DFN,OR80,ORPNM,ORSSN,ORXDT,VAERR,VAPA,X0,X1,X4,X5,X6,X8,X9,X10,X11,X12,X13,X14,SIG
 S OR80=$G(^OR(100,ORDER,8,1,0))
 Q:'$L(OR80)
 S:'$G(ORSIGNER) ORSIGNER=$P(OR80,"^",3)
 Q:'ORSIGNER
 S $P(^OR(100,ORDER,8,1,2),"^",4,5)=ORDEA_"^"_1 ;Flag to signing process to get digital signature
 S ORXDT=$P(OR80,"^"),X1=$$FMTHL7^XLFDT(ORXDT),X4="",X14="",X10=""
 I '$D(ORVP) S ORVP=$P(^OR(100,ORDER,0),"^",2)
 S DFN=+ORVP
 D ADD^VADPT
 S ORPNM=^DPT(+ORVP,0),ORSSN=$P(ORPNM,"^",9),ORPNM=$P(ORPNM,"^")
 F I=1:1:6 S X4=X4_$S($L($G(VAPA(I))):$S((I=5):$P(VAPA(I),"^",2),1:VAPA(I)),1:"")_"^"
 S X11=$$GET1^DIQ(200,ORSIGNER,.01,"E") Q:'$L(X11)
 S X12=$$DEA^XUSER(,ORSIGNER)
 S X0=$$GET1^DIQ(4,+$G(DUZ(2)),.01,"E")
 I $L(X0) S X14=X0_"^"_$$GET1^DIQ(4,DUZ(2),1.01,"E")_"^"_$$GET1^DIQ(4,DUZ(2),1.02,"E")_"^"_$$GET1^DIQ(4,DUZ(2),1.03,"E")_"^"_$$GET1^DIQ(4,DUZ(2),.02,"E")_"^"_$$GET1^DIQ(4,DUZ(2),1.04,"E")
 S X5=$$VALUE^ORX8(ORDER,"DRUG",,"E"),X6=$$VALUE^ORX8(ORDER,"DRUG")_";50"
 I '$L(X5) S X5=$$VALUE^ORX8(ORDER,"ORDERABLE",,"E"),X6=$$VALUE^ORX8(ORDER,"ORDERABLE")_";101.43"
 S X8=$$VALUE^ORX8(ORDER,"QTY",,"E"),X9=$$VALUE^ORX8(ORDER,"SCHEDULE",,"E")
 S SIG=+$O(^OR(100,ORDER,4.5,"ID","SIG",0)) I SIG,$L($G(^OR(100,ORDER,4.5,SIG,2,1,0))) S X10=^(0)
 S ORSET(1)=X1_"^"_ORPNM_"^"_ORSSN_"^"_+ORVP_"^"
 S ORSET(2)=X4_"^"
 S ORSET(3)=X5_"^"_X6_"^"_X8_"^"_X9_"^"_ORDEA_"^"
 S ORSET(4)=X10_"^"
 S ORSET(5)=X11_"^"_ORSIGNER_"^"_X12_"^"
 S ORSET(6)=X14
 S ORSET(7)=$H
 S ORSET=7
 Q
DELALRT(ORDER) ; deletes "Order requires electronic signature" alert for all intended recipients after all orders have lapsed
 ; Fixes CQ #17536: When orders are lapsed, the unsigned order notification does NOT go away (TC). [v28.1]
 N ORPROV,ORATIFN S ORATIFN=0
 S ORPROV=$P(^OR(100,+ORDER,8,1,0),U,3) Q:'ORPROV
 F  S ORATIFN=$O(^XTV(8992.1,"R",ORPROV,ORATIFN)) Q:ORATIFN'>0  D
 .N ORDNUM S ORDNUM=$$GET1^DIQ(8992.1,ORATIFN,2,"I") ;DBIA #2818
 .I $D(ORDNUM)&($P(ORDNUM,"@")=+ORDER) D
 ..N ORXQAID,XQAID,XQAKILL S ORXQAID=$$GET1^DIQ(8992.1,ORATIFN,.01,"I"),XQAID=ORXQAID,XQAKILL=0
 ..D DELETE^XQALERT K ORXQAID,XQAID,XQAKILL
 K ORPROV,ORATIFN,ORDNUM
 Q
 ;
