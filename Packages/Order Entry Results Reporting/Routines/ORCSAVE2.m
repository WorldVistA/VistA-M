ORCSAVE2 ;SLC/MKB-Utilities to update an order ;01/05/17  14:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,27,56,70,94,116,190,157,215,265,243,293,280,346,269,421,382**;Dec 17, 1997;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;Nov 12, 2015 PB - modified to do a sync for a saved order
 ;
STATUS(IFN,ST) ; -- Update status of order
 Q:'$G(IFN)  Q:'$D(^OR(100,+IFN,0))  Q:$P($G(^(3)),U,3)=$G(ST)  ;no change
 Q:'$G(ST)  Q:'$D(^ORD(100.01,+ST,0))
 N NODE0,NODE3,ORNOW,DA,XACT,PROV,ORVP
 S NODE3=$G(^OR(100,+IFN,3)),ORVP=$P($G(^(0)),U,2),ORNOW=$$NOW^XLFDT
 S $P(NODE3,U)=ORNOW,$P(NODE3,U,3)=ST,^OR(100,+IFN,3)=NODE3
 I (ST<3)!(ST=12)!(ST=13),$G(ORDCNTRL)'="ZC" D DATES(+IFN,,+$E(ORNOW,1,12))
 I "^1^2^7^12^13^15^"[(U_ST_U) D CANCEL^ORCSEND(+IFN),UNOTIF^ORCSIGN
 I $P(NODE3,U,9) D CKPARENT($P(NODE3,U,9)) ; ck siblings to update parent
 D SETALL^ORDD100(+IFN)
 Q
 ;
CKPARENT(ORIFN) ; -- Update status of parent order, if appropriate
 N ORSTS,ALLRELSD,ALLDONE,DC,COMP,CH,CHSTS,ACTIVE,LAPS
 Q:'$D(^OR(100,ORIFN,0))  S ORSTS=$P($G(^(3)),U,3)
 I (ORSTS=11)!(ORSTS=10) S ALLRELSD=1 D  Q  ;Parent unrel'd - ck children
 . F CH=0:0 S CH=$O(^OR(100,ORIFN,2,CH)) Q:CH'>0  D  Q:'ALLRELSD
 . . I '$D(^OR(100,CH)) K ^OR(100,ORIFN,2,CH) Q
 . . S CHSTS=$P($G(^OR(100,CH,3)),U,3) S:CHSTS=11 ALLRELSD=0
 . I ALLRELSD D STATUS(ORIFN,5) ; update Parent order to pending
 S ALLDONE=1,(DC,COMP,LAPS,ACTIVE)=0
 F CH=0:0 S CH=$O(^OR(100,ORIFN,2,CH)) Q:CH'>0  D  Q:'ALLDONE
 . I '$D(^OR(100,CH)) K ^OR(100,ORIFN,2,CH) Q
 . S CHSTS=$P($G(^OR(100,CH,3)),U,3) I CHSTS=14 S LAPS=1 Q
 . I "^1^12^13^"[(U_CHSTS_U) S DC=1 Q
 . I "^2^7^"[(U_CHSTS_U) S COMP=1 Q
 . S ALLDONE=0 S:CHSTS=6 ACTIVE=1
 I ALLDONE S ORSTS=$S(COMP:2,DC:1,LAPS:14,1:"") D:ORSTS STATUS(ORIFN,ORSTS) Q
 I ACTIVE,ORSTS'=6 D STATUS(ORIFN,6) ;at least child active
 Q
 ;
RELEASE(ORDER,ACTION,WHEN,WHO,NATURE) ; -- Mark order as released to service
 S:'$G(ACTION) ACTION=1 S:'$G(WHEN) WHEN=+$E($$NOW^XLFDT,1,12) S:'$G(WHO) WHO=DUZ
 Q:'$G(ORDER)  N OR0 S OR0=$G(^OR(100,ORDER,8,ACTION,0))
 S:$L($G(NATURE)) $P(OR0,U,12)=$S(NATURE:NATURE,1:+$O(^ORD(100.02,"C",NATURE,0)))
 S:($P(OR0,U,15)=10)!($P(OR0,U,15)=11) $P(OR0,U,15)=""
 ;S $P(OR0,U,16,17)=WHEN_U_WHO,^OR(100,"AR",ORVP,9999999-WHEN,ORDER,ACTION)=""
 S $P(OR0,U,16,17)=WHEN_U_WHO
 S ^OR(100,ORDER,8,ACTION,0)=OR0
 I $P(OR0,U,2)="NW",'$P(^OR(100,ORDER,0),U,8) D STARTDT(ORDER)
 ;Set the "AR" index.
 D RS^ORDD100(ORDER,ACTION,ORVP,WHEN)
 Q
 ;
STARTDT(DA) ; -- resolve Start and Stop dates from Responses
 N X,Y,%DT,ORDG,ORT,ORLAB
 S ORDG=$P($G(^ORD(100.98,+$P(^OR(100,DA,0),U,11),0)),U,3)
 S ORLAB="^LAB^CH^HEMA^MI^AP^AU^EM^SP^CY^BB^"[(U_ORDG_U),ORT=""
 S:ORDG="E/L T" ORT=$$VALUE(DA,"TIME") S:ORDG="MEAL" ORT=$$MEALTIME^ORCDFHO(DA)
STRT S X=$$VALUE(DA,"START") I '$L(X) D WS^ORDD100 Q  S:$L(ORT) X=X_"@"_ORT
 D AM:X="AM",NEXT:X="NEXT",ADMIN("NEXT"):X="NEXTA",ADMIN("CLOSEST"):X="CLOSEST"
 S %DT="T" D ^%DT Q:Y'>0  S:$E($P(Y,".",2),1,2)=24 Y=$P(Y,".")_".2359"
 S $P(^OR(100,DA,0),U,8)=Y D SS^ORDD100,WS^ORDD100,OI1^ORDD100A(DA)
STOP I ORLAB S X=$$VALUE(DA,"DAYS") Q:X'>1  S X=$$FMADD^XLFDT(Y,(X-1))
 I 'ORLAB S X=$$VALUE(DA,"STOP") Q:'$L(X)  S:$L(ORT) X=X_"@"_ORT
 S %DT="T" D ^%DT Q:Y'>0  S:$E($P(Y,".",2),1,2)=24 Y=$P(Y,".")_".2359"
 S $P(^OR(100,DA,0),U,9)=Y D ES^ORDD100A
 Q
 ;
NEXT ; -- Resolve next lab collection to FM date/time
 N ORTIME,ORDAY,NOW,NEXT,ENT
 ;is referenced by DBIA #964
 S ENT=$S($P($G(^SC(+$G(ORL),0)),U,4):+$P(^(0),U,4),1:+$G(DUZ(2)))_";DIC(4," S:ENT'>0 ENT="ALL"
 D GETLST^XPAR(.ORTIME,ENT,"LR PHLEBOTOMY COLLECTION","N")
 S NOW=$P($H,",",2),ORDAY=$S($O(ORTIME(NOW)):"T",1:"T+1")
 S ORDAY=$$NEXTCOLL^ORCDLR1(ORDAY) S:ORDAY["+" NOW=0
 S NEXT=$O(ORTIME(NOW)),X=ORDAY_"@"_$P($G(ORTIME(+NEXT)),U)
 Q
 ;
AM ; -- Resolve AM lab collection to FM date/time
 N ORTIME,ORDAY,AM,NOW,ENT
 ;is referenced by DBIA #964
 S ENT=$S($P($G(^SC(+$G(ORL),0)),U,4):+$P(^(0),U,4),1:+$G(DUZ(2)))_";DIC(4," S:ENT'>0 ENT="ALL"
 D GETLST^XPAR(.ORTIME,ENT,"LR PHLEBOTOMY COLLECTION","N")
 S AM=$O(ORTIME(0)),NOW=$P($H,",",2)
 S ORDAY=$S(AM=$O(ORTIME(NOW)):"T",1:"T+1")
 S X=$$NEXTCOLL^ORCDLR1(ORDAY)_"@"_$P($G(ORTIME(+AM)),U)
 Q
 ;
ADMIN(START) ; -- Resolve next/closest administration times to FM date/time
 N PAT,SCH,OI,LOC,Y,I
 I $G(DA) D  ;get data from order DA
 . S PAT=+$P($G(^OR(100,DA,0)),U,2),LOC=""
 . S I=+$O(^OR(100,DA,4.5,"ID","INSTR",0)),I=+$P($G(^OR(100,DA,4.5,I,0)),U,3) ;first
 . S SCH=$$VALUE(DA,"SCHEDULE",I),OI=$$VALUE(DA,"ORDERABLE")
 I '$G(DA) D  ;or look in ORDIALOG() instead
 . S I=+$O(ORDIALOG($$PTR^ORCD("OR GTX INSTRUCTIONS"),0))
 . S PAT=$G(ORVP),SCH=$G(ORDIALOG($$PTR^ORCD("OR GTX SCHEDULE"),I))
 . S OI=$G(ORDIALOG($$PTR^ORCD("OR GTX ORDERABLE ITEM"),1)),LOC=""
 S OI=+$P($G(^ORD(101.43,+OI,0)),U,2) ;PSOI
 ;is referenced by DBIA #3167
 S Y=$$RESOLVE^PSJORPOE(PAT,SCH,OI,START,LOC),X=$P(Y,U,2)
 Q
 ;
SIGN(DA,WHO,WHEN,HOW,WHAT) ; -- affix ES to order
 Q:'$G(DA)  S:'$G(WHAT) WHAT=1
 N X S X=$G(^OR(100,DA,8,WHAT,0)) D S2^ORDD100(DA,WHAT) ; kill AS xref
 S $P(X,U,4,7)=$G(HOW)_U_$G(WHO)_U_$E($G(WHEN),1,12)_U_$S(HOW=0:DUZ,1:"")
 ; S:$G(WHO) $P(X,U,3)=WHO ; reset provider to signer
 S ^OR(100,DA,8,WHAT,0)=X
 D  ; DE3504 Jan 19, 2016, US10045 - PB - Nov 2, 2015 modification to capture order create date/time with seconds in HMP(800000 orders multiple
 . N HMDFN,HMORIFN,HMORIS,HMSTATUS,NOW,RSLT,VALS
 . S HMDFN=+$P(^OR(100,DA,0),U,2),HMORIFN=+DA
 . S HMSTATUS=$P($G(^OR(100,DA,8,WHAT,0)),U,2),NOW=$$NOW^XLFDT
 . S:$G(WHO)]"" VALS(.03)=WHO
 . S:HMSTATUS'=2 VALS(.04)=NOW  ; if=2 order not signed  ; SIGNED DATE/TIME only updated when order is signed
 . S:$L(HMSTATUS) VALS(.14)=HMSTATUS,VALS(.15)=NOW
 . S HMORIS=$$ORDRCHK^HMPOR(HMORIFN,HMDFN)  ; does order exist?  ; Jan 26, 2016 - DE3584
 . D:HMORIS UPDTORDR^HMPOR(.RSLT,.VALS,HMORIFN,HMDFN)  ; order exists update it
 . D:'HMORIS ADDORDR^HMPOR(.RSLT,.VALS,HMORIFN,HMDFN)  ; create new order in HMP(800000)
 ;
 D:$G(HOW)=2 S1^ORDD100(DA,WHAT) ; reset AS xref
 Q
 ;
SIGSTS(IFN,ACT) ; -- Set SigSts for backdoor orders [Called from ^ORM* rtns]
 ; Expects ORNATR, ORVP, ORNP to be defined
 Q:'$G(IFN)  Q:'$G(ACT)  N X,OR0 S OR0=+$P($G(^OR(100,+IFN,8,ACT,0)),U)
 S X=$S($$SIGNREQD^ORCACT1(+IFN):$$SIGSTS^ORX1(ORNATR),1:3)
 K ^OR(100,"AS",ORVP,9999999-OR0,+IFN,ACT)
 S $P(^OR(100,+IFN,8,ACT,0),U,4)=X
 I X=2 S ^OR(100,"AS",ORVP,9999999-OR0,+IFN,ACT)="" D NOTIF^ORCSIGN
 Q
 ;
UNVEIL(IFN) ; -- unveil new order
 S $P(^OR(100,IFN,3),U,8)=""
 Q
 ;
DELETE(ORDER) ; -- delete order [action]
 N DIK,DA,DAD
 I $P(ORDER,";",2)>1 S DA=+$P(ORDER,";",2),DA(1)=+ORDER,DIK="^OR(100,"_DA(1)_",8," D:DA ^DIK Q
 S DAD=+$P($G(^OR(100,+ORDER,3)),U,9) I DAD S DIK="^OR(100,"_DAD_",2,",DA(1)=DAD,DA=+ORDER D ^DIK ; remove link to child from parent
 K DA S DA=+ORDER,DIK="^OR(100," D ^DIK ;remove order, text
 D DELETE^OROCAPI1(+ORDER)
 Q
 ;
VERIFY(IFN,DA,TYPE,WHO,WHEN) ; -- order verified
 Q:'$G(IFN)  Q:'$G(DA)  Q:"^N^C^R^"'[(U_$G(TYPE)_U)
 I $G(^TMP($J,"OR MOB APP"))="CPRS" Q
 N FLD S FLD=$S(TYPE="N":8,TYPE="C":10,1:18)
 S:'$G(WHO) WHO=DUZ S:'$G(WHEN) WHEN=+$E($$NOW^XLFDT,1,12)
 S $P(^OR(100,IFN,8,DA,0),U,FLD,FLD+1)=WHO_U_WHEN
 D  ; US10045 - PB - Jan 7, 2016 capture the order verify or review date/time with seconds in HMP(800000 orders multiple
 . N FLD,ORDFN,SRVRNUM,RSLT,VALS
 . S ORDFN=+$P(^OR(100,+ORIFN,0),U,2),SRVRNUM=$$SRVRNO^HMPOR(ORDFN)
 . Q:'SRVRNUM  ; patient not in the HMP(800000 file
 . S FLD=$S(TYPE="N":.05,TYPE="C":.07,1:.09)
 . ;^(#.05)VERIFYING NURSE^(#.06)NURSE VERIFY DATE/TIME^(#.07)VERIFYING CLERK^(#.08)CLERK VERIFY DATE/TIME^(#.09)REVIEWED BY^(#.1)REVIEWED DATE/TIME
 . S VALS(FLD)=$G(WHO),VALS(FLD+.01)=$$NOW^XLFDT D UPDTORDR^HMPOR(.RSLT,.VALS,+ORIFN,ORDFN) Q:RSLT<0  ; quit if order not found
 D:$L($T(VER^EDPFMON)) VER^EDPFMON(IFN)
 Q
 ;
COMP(IFN,WHO,WHEN) ; -- order completed
 Q:'$G(IFN)  S:'$G(WHO) WHO=DUZ S:'$G(WHEN) WHEN=+$E($$NOW^XLFDT,1,12)
 D DATES(+IFN,,WHEN),STATUS(+IFN,2)
 S $P(^OR(100,+IFN,6),U,6,7)=WHEN_U_WHO
 D:$L($T(COMP^EDPFMON)) COMP^EDPFMON(IFN)
 Q
 ;
DATES(DA,START,STOP) ; -- Update start/stop dates for order DA
 Q:'$G(DA)  I $G(START) D
 . Q:START=$P(^OR(100,DA,0),U,8)
 . D SK^ORDD100,WK^ORDD100,OI2^ORDD100A(DA)
 . S $P(^OR(100,DA,0),U,8)=START
 . D SS^ORDD100,WS^ORDD100,OI1^ORDD100A(DA)
 I $G(STOP) D
 . ;Q:STOP=$P(^OR(100,DA,0),U,9)  ;ck xref anyway
 . D EK^ORDD100A S $P(^OR(100,DA,0),U,9)=STOP D ES^ORDD100A
 Q
 ;
OC ; -- Save order checks in ORCHECK() in ^OR(100,+ORIFN,9) ON SIGNATURE IN CPRS
 Q:'$G(ORIFN)  Q:'$D(^OR(100,+ORIFN,0))
 D DELOCC^OROCAPI1(+ORIFN,"SIGNATURE_CPRS")
 N I,J,ORK,CNT,OC,OROCRET,ORKI,ORCROC
 S CNT=0
 S I=0 F  S I=$O(ORCHECK(+ORIFN,I)) Q:'I  D
 . S J=0 F  S J=$O(ORCHECK(+ORIFN,I,J)) Q:'J  D
 . . S OC=ORCHECK(+ORIFN,I,J)
 . . S CNT=CNT+1
 . . S ORK(CNT,1)=+ORIFN_U_"SIGNATURE_CPRS"_U_DUZ_U_$$NOW^XLFDT_U_+OC_U_I
 . . S ORK(CNT,2,1)=$P(OC,U,3)
 . . S ORK(CNT,3)=$S(I=1:$G(ORCHECK("OK")),1:"")
 . . I $E(ORK(CNT,2,1),0,2)="||" D
 . . . N ORGLOB,ORRULE,ORI,ORICNT
 . . . S ORGLOB=$P($P(ORK(CNT,2,1),"||",2),"&"),ORRULE=$P($P(ORK(CNT,2,1),"||",2),"&",2)
 . . . S ORCROC(CNT)=$P($P(ORK(CNT,2,1),"||",2),"&",3)_U_$P($P(ORK(CNT,2,1),"||",2),"&",4)
 . . . S ORK(CNT,2,1)=ORRULE,ORICNT=2,ORI=1
 . . . F  S ORI=$O(^TMP($J,"ORK XTRA TXT",ORGLOB,ORRULE,ORI)) Q:'ORI  S ORK(CNT,2,ORICNT)=^TMP($J,"ORK XTRA TXT",ORGLOB,ORRULE,ORI),ORICNT=ORICNT+1
 I $D(ORK) D
 . D SAVEOC^OROCAPI1(.ORK,.OROCRET)
 . I $D(ORCROC) D
 . . N ORCROCI S ORCROCI=0 F  S ORCROCI=$O(ORCROC(ORCROCI)) Q:'ORCROCI  D
 . . . N OCINST S OCINST=$O(OROCRET(ORCROCI,"")) Q:'OCINST  D
 . . . . S ^ORD(100.05,OCINST,12)=ORCROC(ORCROCI)
 S ORKI=0 F  S ORKI=$O(ORK(ORKI)) Q:'ORKI  D
 . N OCINST,OCTXT S OCTXT=$G(ORK(ORKI,2,1))
 . S OCINST=$O(OROCRET(ORKI,0))
 . N ORMONOI,ORMONOQ S ORMONOI=0,ORMONOQ=0 F  Q:ORMONOQ=1  S ORMONOI=$O(^TMP($J,"ORMONOGRAPH",ORMONOI)) Q:'ORMONOI  D
 . . I OCTXT[$G(^TMP($J,"ORMONOGRAPH",ORMONOI,"OC")) D
 . . . S ORMONOQ=1
 . . . S ^ORD(100.05,OCINST,17)=^TMP($J,"ORMONOGRAPH",ORMONOI,"INT")
 . . . M ^ORD(100.05,OCINST,16)=^TMP($J,"ORMONOGRAPH",ORMONOI,"DATA")
 . . . S ^ORD(100.05,OCINST,16,0)="^^"_$O(^ORD(100.05,OCINST,16,""),-1)_U_$O(^ORD(100.05,OCINST,16,""),-1)_U_+$$NOW^XLFDT_U
 K ^TMP($J,"ORMONOGRAPH")
 Q
 ;
VALUE(IFN,ID,INST) ; -- Returns value of prompt by identifier ID
 I '$G(IFN)!('$D(^OR(100,+$G(IFN),0)))!($G(ID)="") Q ""
 N I,Y S I=0,Y="" S:'$G(INST) INST=1
 F  S I=$O(^OR(100,IFN,4.5,"ID",ID,I)) Q:I'>0  I $P($G(^OR(100,IFN,4.5,+I,0)),U,3)=INST S Y=$G(^(1)) Q
 Q Y
 ;
SC(ORX,ORIFN) ; -- save responses to SC questions
 Q:'$G(ORIFN)  Q:'$D(^OR(100,+ORIFN,0))  ;invalid order number
 N OR5,I,P S OR5=$G(^OR(100,+ORIFN,5)),P=0
 F I="SC","MST","AO","IR","EC","HNC","CV","SHD" S P=P+1 S:$D(ORX(I)) $P(OR5,U,P)=ORX(I)
 S ^OR(100,+ORIFN,5)=OR5
 Q
 ;
CANCEL(ORDER) ; -- cancel order [action]
 N ORA,DIE,DA,DR,ORX
 S ORDER=$G(ORDER),ORA=+$P(ORDER,";",2) Q:'ORA!('ORDER)
 I $D(^OR(100,+ORDER,8,ORA)) D
 .S ORX="Unsigned/unreleased order cancelled by provider"
 .S DIE="^OR(100,"_+ORDER_",8,",DA=ORA,DA(1)=+ORDER
 .S DR="4////5;15////13;1////^S X=ORX" D ^DIE
 I ORA=1 D
 .K DA S DIE="^OR(100,",DA=+ORDER,DR="5////13" D ^DIE
 Q
 ;
LAPSE(ORDER) ; -- lapse order [action]
 N ORA S ORA=+$P(ORDER,";",2)
 Q:'$D(^OR(100,+ORDER,0))  Q:'ORA!('ORDER)
 I $D(^OR(100,+ORDER,8,ORA)) D
 .N DIE,DA,DR
 .S DIE="^OR(100,"_+ORDER_",8,",DA=ORA,DA(1)=+ORDER
 .S DR="4////5;15////14" D ^DIE,DELALRT^ORCSAVE1(ORDER) ; DELALRT call added to fix CQ #17536 (TC). [v28.1]
 I ORA=1 D
 .N DIE,DA,DR
 .S DIE="^OR(100,",DA=+ORDER,DR="5////14"
 .D ^DIE,ALPS(DA,ORA)
 Q
ALPS(DA,ORACT,TYPE) ;set the lapse index ^OR(100,"ALPS")
 N ORVP,X,OR0,ORLOG
 S OR0=$G(^OR(100,DA,8,ORACT,0))
 S ORLOG=$P(OR0,U),ORVP=$P($G(^OR(100,DA,0)),U,2)
 I ORVP,ORLOG S ^OR(100,"ALPS",ORVP,9999999-ORLOG,DA,ORACT)=$G(TYPE)
 S ^OR(100,DA,10)=$$NOW^XLFDT
 Q
 ;
RESP(IFN,PRMT,VAL,INST) ; -- update a single Response VALue
 S IFN=+$G(IFN),VAL=$G(VAL),PRMT=+$O(^ORD(101.41,"AB",PRMT,0))
 N ID,DA,DIK S:'$G(INST) INST=1
 S ID=$P($G(^ORD(101.41,PRMT,1)),U,3) Q:'$L(ID)
 S DA=0 F  S DA=$O(^OR(100,IFN,4.5,"ID",ID,DA)) Q:DA<1  Q:$P($G(^OR(100,IFN,4.5,DA,0)),U,3)=INST
 I 'DA D:$L(VAL)  Q  ;add
 . N DO,DIC,DLG,X
 . S DIC="^OR(100,"_IFN_",4.5,",DA(1)=IFN,DIC(0)="FL"
 . S DIC("DR")=".02///"_PRMT_";.03///"_INST_";.04///"_ID
 . S DLG=+$P($G(^OR(100,IFN,0)),U,5)
 . S X=+$O(^ORD(101.41,DLG,10,"D",PRMT,0))
 . D FILE^DICN S:Y ^OR(100,IFN,4.5,+Y,1)=VAL
 I $L(VAL) S ^OR(100,IFN,4.5,DA,1)=VAL Q  ;change
 S DIK="^OR(100,"_IFN_",4.5,",DA(1)=IFN D ^DIK ;delete
 Q
