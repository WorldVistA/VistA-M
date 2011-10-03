ORWDPS4 ;; SLC/JDL - Order Dialogs CO-PAY and Other;[12/31/01 6:38pm]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**116,125,131,141,173,187,190,195,215,243**;Dec 17, 1997;Build 242
 ;
CPLST(TEST,PTIFN,ORIFNS) ; --Get CP questions
 N ORIFN,ORDA,ORI,ORPSO,CPX
 S ORI=0,ORPSO=+$O(^DIC(9.4,"C","PSO",0))
 F  S ORI=$O(ORIFNS(ORI)) Q:'ORI  D
 .S ORIFN=+ORIFNS(ORI),ORDA=$P(ORIFNS(ORI),";",2)
 .I $D(^OR(100,ORIFN,0)),($P(^OR(100,ORIFN,0),U,14)=ORPSO) D
 ..N PRIO S PRIO=0
 ..I $D(^OR(100,ORIFN,4.5,"ID","URGENCY")) S PRIO=$O(^("URGENCY",0))
 ..S PRIO=$G(^OR(100,ORIFN,4.5,+PRIO,1))
 ..Q:PRIO=99
 ..S CPX=$$SC(ORIFN)
 ..I $L(CPX)>1 S TEST(ORIFN)=ORIFN_";"_ORDA_CPX
 K PTIFN,ORIFN,ORDA,ORI,CPX
 Q
 ;
CPINFO(Y,ORINFO) ; -- Save reponses to CP questions
 Q:'$D(ORINFO)
 N ORIFN,ORI,ORX,ANS S ORI=0
 F  S ORI=$O(ORINFO(ORI)) Q:'ORI  D
 .S ORIFN=$P($P(ORINFO(ORI),U,1),";",1)
 .S ANS=$P(ORINFO(ORI),U,2)
 .D REFMT(.ORX,ANS)
 .D SC^ORCSAVE2(.ORX,ORIFN)
 S Y=1
 K ORIFN,ORX,ORI,ANS
 Q
 ;
SC(ORIFN) ; -- Dialog validation, to ask CP questions
 ;Expects ORIFN and ORDA
 ;
 N DR S DR=""
 I '$L($T(SCNEW^PSOCP))!('$G(ORIFN))!('$G(ORDA)) Q DR
 I $P($G(^OR(100,ORIFN,8,ORDA,0)),U,2)'="NW" Q DR
 ;
 N OR3,ORDRUG,ORENEW,ORX,I,XACT,YACT,CPNODE,ASC,AAO,AIR,AEC,AMST,AHNC,ACV,ASHD
 S ORX="",XACT=""
 ;--Only new, renew, edited, copied outpatient order can continue...
 ;AGP CHANGE 26.65, will returned service connection data for change orders
 S OR3=$G(^OR(100,ORIFN,3)),XACT=$P(OR3,U,11) I (XACT'=0)&(XACT'=1)&((XACT'=2)&(XACT'="C")) Q DR
 I (XACT=1)&($D(^OR(100,ORIFN,5))=0) Q DR
 I $D(^OR(100,ORIFN,5))>0 D
 .S CPNODE=$G(^OR(100,ORIFN,5))
 .S ASC=$S($L($P(CPNODE,"^",1)):"SC;"_$P(CPNODE,"^",1),1:"")
 .S DR=$S($L(ASC):DR_U_ASC,1:DR)
 .S AAO=$S($L($P(CPNODE,"^",3)):"AO;"_$P(CPNODE,"^",3),1:"")
 .S DR=$S($L(AAO):DR_U_AAO,1:DR)
 .S AIR=$S($L($P(CPNODE,"^",4)):"IR;"_$P(CPNODE,"^",4),1:"")
 .S DR=$S($L(AIR):DR_U_AIR,1:DR)
 .S AEC=$S($L($P(CPNODE,"^",5)):"EC;"_$P(CPNODE,"^",5),1:"")
 .S DR=$S($L(AEC):DR_U_AEC,1:DR)
 .S AMST=$S($L($P(CPNODE,"^",2)):"MST;"_$P(CPNODE,"^",2),1:"")
 .S DR=$S($L(AMST):DR_U_AMST,1:DR)
 .S AHNC=$S($L($P(CPNODE,"^",6)):"HNC;"_$P(CPNODE,"^",6),1:"")
 .S DR=$S($L(AHNC):DR_U_AHNC,1:DR)
 .S ACV=$S($L($P(CPNODE,"^",7)):"CV;"_$P(CPNODE,"^",7),1:"")
 .S DR=$S($L(ACV):DR_U_ACV,1:DR)
 .S ASHD=$S($L($P(CPNODE,"^",8)):"SHD;"_$P(CPNODE,"^",8),1:"")
 .S DR=$S($L(ASHD):DR_U_ASHD,1:DR)
 .D CPCOMP(.DR)
 .K ASC,AAO,AIR,AEC,AMST,AHNC,CPNODE
 I $L(DR)>0 Q DR
 I XACT=2 S YACT=$P(OR3,U,5),ORENEW=$G(^OR(100,YACT,4)) ;get PS# if renewal
 S ORDRUG=$$VALUE^ORCSAVE2(ORIFN,"DRUG")
 D SCNEW^PSOCP(.ORX,+PTIFN,ORDRUG,$G(ORENEW)) I '$D(ORX) Q DR
 F I="SC","AO","IR","EC","MST","HNC","CV","SHD" D
 . I $D(ORX(I)) S DR=DR_U_I_$S($L(ORX(I)):";"_ORX(I),1:"")
 Q DR
REFMT(ORX,INFO) ;
 ;"U": Unchecked ("NO") 
 ;"C": Checked ("YES")
 ;"N" : Question not asked
 N RST,RST1
 S RST=""
 F I=1:1:$L(INFO)  S RST=RST_U_$S($E(INFO,I)="U":0,$E(INFO,I)="C":1,1:"")
 S RST1=$E(RST,2,$L(RST))
 S ORX("SC")=$P(RST1,U,1)
 S ORX("MST")=$P(RST1,U,5)
 S ORX("AO")=$P(RST1,U,2)
 S ORX("IR")=$P(RST1,U,3)
 S ORX("EC")=$P(RST1,U,4)
 S ORX("HNC")=$P(RST1,U,6)
 S ORX("CV")=$P(RST1,U,7)
 S ORX("SHD")=$P(RST1,U,8)
 K RST,RST1
 Q
CPCOMP(PREX) ; -- Compare the existed exemptions with new exemption questions
 N ORX1,ORDRUG1,CPI,LSTCP,TMPVAL
 S LSTCP=""
 S ORDRUG1=$$VALUE^ORCSAVE2(ORIFN,"DRUG")
 D SCNEW^PSOCP(.ORX1,+PTIFN,ORDRUG1,$G(ORENEW)) I '$D(ORX1) Q
 F CPI="SC","AO","IR","EC","MST","HNC","CV","SHD" D
 . I $D(ORX1(CPI)) D
 . . S TMPVAL=""
 . . I $F(PREX,CPI) D
 . . . S TMPVAL=+$E(PREX,$F(PREX,CPI)+1)
 . . . I $L(TMPVAL),((TMPVAL=0)!(TMPVAL=1)) S TMPVAL=CPI_";"_TMPVAL
 . . . E  S TMPVAL=CPI
 . . E  S TMPVAL=CPI
 . . S LSTCP=LSTCP_U_TMPVAL
 S PREX=LSTCP
 Q
IPOD4OP(ORY,ORID) ;True: is an Inpt (IV OI) order on an OutPatient
 Q:'$D(^OR(100,+ORID,0))
 S ORY=0
 N APKG,ADLG,ADG,APTCLS,RXDG,UDDLG,IPPKG
 S (RXDG,UDDLG,IPPKG)=0
 S RXDG=+$O(^ORD(100.98,"B","O RX",0))
 S UDDLG=+$O(^ORD(101.41,"B","PSJ OR PAT OE",0))
 S IPPKG=+$O(^DIC(9.4,"B","INPATIENT MEDICATIONS",0))
 S ADLG=+$P($G(^OR(100,+ORID,0)),U,5)
 S ADG=$P($G(^OR(100,+ORID,0)),U,11)
 S APKG=$P($G(^OR(100,+ORID,0)),U,14)
 S APTCLS=$P($G(^OR(100,+ORID,0)),U,12)
 I ADG=RXDG,(ADLG=UDDLG),(APKG=IPPKG),(APTCLS="I") S ORY=1
 Q
 ;
UPDTDG(ORY,ORID) ;Update Inpt order for outpatient DG to Inpt DG
 Q:'$D(^OR(100,+ORID,0))
 N UDDG
 S UDDG=$O(^ORD(100.98,"B","UD RX",0))
 S $P(^OR(100,+ORID,0),U,11)=UDDG
 Q
ISUDIV(ORY,ORIFN) ;True: OI of the order is for both UD and IV
 N OI
 S (OI,ORY)=0
 S OI=+$O(^OR(100,+$G(ORIFN),.1,"B",0)) Q:OI<1
 I $O(^ORD(101.43,OI,9,"B","IVM RX",0)) S ORY=1
 Q
