ORCACT02        ;SLC/MKB-Validation dose conversion for POE
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141**;Dec 17, 1997
 ;
DOSES(IFN) ; -- Convert outpt doses, if needed
 N ORIT,ORPSOI,ORDRUG,ORDOSE,CONJ,DOSE,ORP,ORI,ORX,UD,UNT,IDX,X,Y,DA,DIK,MATCH,DRUG,STR,MED
 S ORIT=+$$VALUE^ORX8(+IFN,"ORDERABLE"),ORDRUG=+$$VALUE^ORX8(+IFN,"DRUG")
 S ORPSOI=+$P($G(^ORD(101.43,ORIT,0)),U,2),DOSE=$$PTR^ORCD("OR GTX DOSE")
 D DOSE^PSSORUTL(.ORDOSE,ORPSOI,"O",+ORVP)
 S CONJ=$P($G(ORDOSE("MISC")),U,3) S:$L(CONJ) CONJ=" "_CONJ
 F ORP="INSTR","MISC" S ORI=0 D  ;setup ORX(instance,ID)=DA ^ value
 . F  S ORI=$O(^OR(100,+IFN,4.5,"ID",ORP,ORI)) Q:ORI'>0  D
 .. S X=$G(^OR(100,+IFN,4.5,ORI,0)),ORX($P(X,U,3),ORP)=ORI_U_$G(^(1))
 ;
D1 S ORI=0 F  S ORI=$O(ORX(ORI)) Q:ORI'>0  D
 . S UD=$P($G(ORX(ORI,"INSTR")),U,2),UNT=$P($G(ORX(ORI,"MISC")),U,2)
 . S:UD="1/2" UD=.5 S:UD="1/3" UD=.33 S:UD="1/4" UD=.25 S:UD="3/4" UD=.75
 . S:UNT?1.U1"(S)" UNT=$P(UNT,"(")_$S(UD>1:"S",1:"") ;strip trailing (s)
 . K MATCH S MATCH=0,IDX="ORDOSE(0)"
 . F  S IDX=$Q(@IDX) Q:IDX'?1"ORDOSE("1.N.",".N1")"  D
 .. S Y=@IDX I $P(Y,U,3)?1"0."1.N,UD?1"."1.N S UD="0"_UD ;add leading 0 ;134
 .. S X=UD_$S('$L(UNT):"",$P(Y,U,3):U_UNT,1:" "_UNT) S X=$$UP^XLFSTR(X)
 .. I $P(Y,U,3,4)'=X,$P(Y,U,5)'=X Q  ;no match
 .. I ORDRUG,$P(Y,U,6)'=ORDRUG Q  ;diff disp drug - no match
 .. S MATCH=MATCH+1,MATCH(MATCH)=Y
 . ;save re-formatted instructions
 . I MATCH=1 D  Q
 .. S Y=MATCH(1),X=$P(Y,U,5),DRUG=$G(ORDOSE("DD",+$P(Y,U,6)))
 .. S:'Y X=X_CONJ_" "_$S($P(DRUG,U,5):$TR($P(DRUG,U,5,6),"^"),1:$P(DRUG,U))
 .. S DA=+$G(ORX(ORI,"INSTR")) S:DA ^OR(100,+IFN,4.5,DA,1)=X
 .. S Y=$P(Y,U,1,6)_U_$P(DRUG,U,5,6),Y=$TR(Y,"^","&")
 .. S DA=+$G(ORX(ORI,"MISC")) Q:'DA  K ^OR(100,+IFN,4.5,"ID","MISC",DA)
 .. S ^OR(100,+IFN,4.5,DA,0)="15^"_DOSE_U_ORI_"^DOSE",^(1)=Y
 .. S ^OR(100,+IFN,4.5,"ID","DOSE",DA)=""
 . S X=UD_$S($L(UNT):" "_UNT,1:""),Y=""
 . S DA=+$G(ORX(ORI,"INSTR")) S:DA ^OR(100,+IFN,4.5,DA,1)=X
 . S DA=+$G(ORX(ORI,"MISC")),DIK="^OR(100,"_+IFN_",4.5,",DA(1)=+IFN
 . D:DA ^DIK ;remove old units prompt
D2 ; -- set STR or DRUGNAME, convert DAYS
 I ORDRUG D
 . S DRUG=$G(ORDOSE("DD",+ORDRUG)),STR=$P(DRUG,U,5)_$P(DRUG,U,6)
 . I STR'>0 D:'$G(ORDOSE(1)) ADD("DRUG NAME",18,$P(DRUG,U)) Q
 . S MED=$P($G(^ORD(101.43,+$G(ORIT),0)),U)
 . I MED'[STR D ADD("STRENGTH",7,STR)
 S ORI=+$O(^OR(100,+IFN,4.5,"ID","DAYS",0)),X=$G(^OR(100,+IFN,4.5,ORI,1))
 S:+X=X ^OR(100,+IFN,4.5,ORI,1)=+X_" DAYS"
 Q
 ;
ADD(PRMT,DA,VAL)        ; -- Add new value to Responses
 N HDR,TOT,I,ID,PTR
 S HDR=$G(^OR(100,+IFN,4.5,0)),TOT=+$P(HDR,U,4)+1
 S I=+$O(^OR(100,+IFN,4.5,"ID"),-1),I=I+1,$P(HDR,U,3,4)=I_U_TOT
 S PTR=+$$PTR^ORCD("OR GTX "_PRMT),ID=$P($G(^ORD(101.41,PTR,1)),U,3)
 S ^OR(100,+IFN,4.5,0)=HDR,^(I,0)=DA_U_PTR_"^1^"_ID,^(1)=VAL
 S:$L(ID) ^OR(100,+IFN,4.5,"ID",ID,I)=""
 Q
