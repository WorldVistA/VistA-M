ORMBLDOR ; SLC/MKB,ASMR/BL - Build outgoing OR msgs ; 10/16/15 1:36pm
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**97,390**;Dec 17, 1997;Build 425
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- Generic orders: Activity, Nursing, Diagnosis, Condition, Vitals
 N OI,START,STOP,SCH,TXT
 S OI=$G(ORDIALOG($$PTR("ORDERABLE ITEM"),1))
 S TXT=$G(ORDIALOG($$PTR("FREE TEXT 1"),1))
 S START=$P(OR0,U,8),STOP=$P(OR0,U,9),SCH=""
 S:ORDG=$O(^ORD(100.98,"B","V/M",0)) SCH=$$VALUE^ORCSAVE2(IFN,"SCHEDULE")
 S $P(ORMSG(4),"|",8)=U_SCH_"^^"_$$HL7DATE(START)_U_$$HL7DATE(STOP) ; QT
 S ORMSG(5)="OBR||||"_$$USID^ORMBLD(OI)
 S:$L(TXT) ORMSG(6)="NTE|1|L|"_TXT ; order text?
 Q
 ;
ADT ; -- M.A.S. event requests
 Q  N PROV,PROV1,ORIFN
 S PROV=+$G(ORDIALOG($$PTR("PROVIDER"),1)) I 'PROV D EN Q
 S PROV1=+$G(ORDIALOG($$PTR("PROVIDER 1"),1)),PKG="DGPM"
 S $P(ORMSG(1),"|",5)="M.A.S.",$P(ORMSG(1),"|",9)="ADT"
 K ORMSG(4) S ORMSG(4)=ORMSG(3),ORMSG(3)=ORMSG(2)
 S ORMSG(2)="EVN|A08|"_$$HL7DATE($$NOW^XLFDT)
 S $P(ORMSG(4),"|",8)=PROV
 S:PROV1 ORMSG(5)="ZDG|"_PROV1
 S ORIFN=+IFN D NW^ORMORG ; set status, start date
 Q
 ;
PTR(X) ; -- Returns ptr value of prompt X in #101.41
 Q +$O(^ORD(101.41,"AB",$E("OR GTX "_X,1,63),0))
 ;
HL7DATE(D) ; -- FM->HL7 format
 Q $$FMTHL7^XLFDT(D)  ;**97
 ;
COMP(IFN) ; -- send message for completed orders
 N OR0,ORMSG S OR0=$G(^OR(100,+IFN,0))
 S ORMSG(1)=$$MSH^ORMBLD("ORM","OR"),ORMSG(2)=$$PID^ORMBLD($P(OR0,U,2))
 S ORMSG(3)=$$PV1^ORMBLD($P(OR0,U,2),$P(OR0,U,12),+$P(OR0,U,10))
 S ORMSG(4)="ORC|SC|"_+IFN_"^OR|"_+IFN_"^OR||CM||||||"_DUZ_"||||"_$$FMTHL7^XLFDT($$NOW^XLFDT)
 D MSG^XQOR("OR EVSEND VPR",.ORMSG)
 Q
 ;
VER(IFN) ; -- Send msg for verified orders
 N OR0,ORMSG S OR0=$G(^OR(100,+IFN,0))
 S ORMSG(1)=$$MSH^ORMBLD("ORM","OR"),ORMSG(2)=$$PID^ORMBLD($P(OR0,U,2))
 S ORMSG(3)=$$PV1^ORMBLD($P(OR0,U,2),$P(OR0,U,12),+$P(OR0,U,10))
 S ORMSG(4)="ORC|ZV|"_IFN_"^OR|"_$G(^OR(100,+IFN,4))_U_$$NMSP^ORCD($P(OR0,U,14))_"||||||||"_DUZ_"||||"_$$FMTHL7^XLFDT($$NOW^XLFDT)
 D MSG^XQOR("OR EVSEND VPR",.ORMSG)
 Q
