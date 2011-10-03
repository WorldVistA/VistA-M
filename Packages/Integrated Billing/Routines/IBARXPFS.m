IBARXPFS ;OAK/ELZ - PFSS ROUTINE FOR INTER-FACILITY RX COPAY ;23-MAR-05
 ;;2.0;INTEGRATED BILLING;**308**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
NEW(DFN) ; this entry point will check patient cap knowledge status and queue to look up as necessary
 N ZTSK,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSAVE,X,Y,POP
 I $D(^IBAM(354.7,DFN,0)) Q
 L +^IBAM(DFN):5 I '$T Q
 S ZTRTN="DQNEW^IBARXPFS",ZTDESC="IB INTER-FACILITY CAP QUERY",ZTDTH=$$NOW^XLFDT,(ZTIO,ZTSAVE("DFN"),ZTSAVE("IBADT"))=""
 D ^%ZTLOAD
 L -^IBAM(DFN)
 Q
 ;
DQNEW ; tasked entry point for cap information query
 I $D(^IBAM(354.7,DFN,0)) Q
 L +^IBAM(DFN):5 I '$T Q
 D ADD^IBARXMU(DFN)
BBE ; back billing entry assumes IBADT
 N IBDT,IBT,IBX,IBS,IBD,IBB,DIE,DA,DR,X,IBA,IBP,IBZ,IBY,IBFD,IBTD
 S IBDT=$E($S($G(IBADT):IBADT,1:DT),1,5)_"00"
 S IBB=0,IBP=$$PRIORITY^IBARXMU(DFN)
 S IBT=$$TFL^IBARXMU(DFN,.IBT) G:'IBT DQNEWQ
 D CAP^IBARXMC(IBDT,IBP,.IBZ,.IBY,.IBFD,.IBTD) I 'IBY,'IBZ G DQNEWQ
 I 'IBFD!('IBTD) G DQNEWQ
 S IBX=0 F  S IBX=$O(IBT(IBX)) Q:IBX<1  D
 . ;
 . ; need to query every month in the cap billing period
 . S IBDT=IBFD D  F  S IBDT=$$NEXTMO^IBARXMC(IBDT) Q:IBDT>IBTD  D
 .. D UQUERY^IBARXMU(DFN,$E(IBDT,1,5)_"00",IBX,.IBD)
 .. ;
 .. ; error returned
 .. I -1=+$G(IBD,"-1") Q
 .. ;
 .. ; loop through query and file data
 .. S X=0 F  S X=$O(IBD(X)) Q:X<1  S:$E(IBD(X),1,4)=(+IBT(IBX)_"-") IBA=$$ADD^IBARXMN(DFN,IBD(X)),IBB=IBB+$P(IBD(X),"^",11)
 .. K IBD
DQNEWQ ;
 L -^IBAM(DFN)
 ;
 Q
 ;
MSG ; receives HL7 message from COTS product and files in 354.71 or others
 N IBMSG,IBHEADER,IBICN,IBDFN,IBSSN,IBCLAIM,IBALIAS,IBSTAT,IBTYPE,IBINST
 N IBRXDAT,IBRESLT,IB35471,IB351,IB35181,IB350,IBMTDT21,IBCODE,SEG,DFN,HLA
 ;
 ;parse message
 S IBSTAT=$$STARTMSG^HLPRS(.IBMSG,HLMTIENS,.IBHEADER)
 I 'IBSTAT S HLERR="Unable to start parse of message" G NEWTRANQ
 ;
 F  Q:'$$NEXTSEG^HLPRS(.IBMSG,.SEG)  D
 . F IBT=3:1 S IBD=$P($T(HL7DATA+IBT),";",4) Q:IBD=""  D
 . . I $P(IBD,"^",2)=SEG("SEGMENT TYPE") D
 . . . S @$P(IBD,"^")=$$GET^HLOPRS(.SEG,$P(IBD,"^",3),$P(IBD,"^",4),$P(IBD,"^",5),$P(IBD,"^",6))
 . . . S IBCODE=$P(IBD,"^",7,99)
 . . . I $L(IBCODE),$L(@$P(IBD,"^")) S X=@$P(IBD,"^") X IBCODE S @$P(IBD,"^")=X
 ;
 ;check out data received from message
 S DFN=$$PATIENT($G(IBICN),$G(IBDFN),$G(IBSSN),$G(IBVACLM),$G(IBALIAS))
 G:'DFN NEWTRANQ
 S IBTYPE=$G(IBTYPE)
 ;
 D @($S(IBTYPE="IN":"35471",IBTYPE="MT":"351",IBTYPE="LB":"35181",IBTYPE="ML":"350",IBTYPE="ST":"QUERYVA",IBTYPE="BL":"BILLVA",1:"ERR")_"^IBARXMI")
 ;
 ;
NEWTRANQ ;
 S HLA("HLA",1)="MSA"_HL("FS")_$S('$D(HLERR):"AA",1:"AE")_HL("FS")_HL("MID")
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"LM",1,.IBRESLT)
 Q
 ;
PATIENT(IBICN,IBDFN,IBSSN,IBVACLM,IBALIAS) ; this function will receive
 ; several patient data elements and validate them.  Assuming the data
 ; meets expected requirements, the function will return the patient's
 ; DFN.  The requirement is ICN is a must, the patient must also match
 ; at least 2 other data elements.
 ;
 N DFN,IBMATCH,IBX
 S (IBMATCH,IBX)=0,HLERR=""
 S DFN=$$DFN^IBARXMU(IBICN) I 'DFN S HLERR="Invalid ICN: "_IBICN G PATQ
 ;
 I DFN=IBDFN S IBMATCH=1
 E  S HLERR=DFN_" Doesn't match ICN DFN "_IBDFN
 ;
 I IBSSN,$P($G(^DPT(DFN,0)),"^",9)=IBSSN S IBMATCH=IBMATCH+1
 E  S HLERR=HLERR_" SSN Mismatch:"_IBSSN
 I IBMATCH>1 G PATQ
 ;
 I $L(IBVACLM),$P($G(^DPT(DFN,.31)),"^",3)=IBVACLM S IBMATCH=IBMATCH+1
 E  S:$L(IBVACLM) HLERR=HLERR_" VA Claim Mismatch:"_IBVACLM
 I IBMATCH>1 G PATQ
 ;
 F  S IBX=$O(^DPT(DFN,.01,IBX)) Q:'IBX!(IBMATCH>1)  I $L(IBALIAS),$P($G(^DPT(DFN,.01,IBX,0)),"^",2)=IBALIAS S IBMATCH=IBMATCH+1 Q
 I IBMATCH<2 S DFN=0,HLERR=HLERR_" ALIAS Mismatch"
PATQ ;
 I DFN K HLERR
 Q DFN
 ;
HL7DATA ; hl7 data mapping
 ; format:  description ; IB Variable ^ segment ^ seq ^ comp ^ subcomp ^
 ;          extract code
 ;;patient icn;IBICN^PID^3^1^1^1
 ;;patient dfn;IBDFN^PID^3^1^1^2^S IBINST=$E(X,1,3),X=$E(X,4,99)
 ;;patient ssn;IBSSN^PID^3^1^1^3
 ;;patient va claim;IBVACLM^PID^3^1^1^4
 ;;patient alias ssn;IBALIAS^PID^3^1^1^5
 ;;receiver trans type;IBTYPE^FT1^6
 ;;transaction number;IB35471(.01)^FT1^2
 ;;trans eff date;IB35471(.03)^FT1^4^1^1^^S X=$$FMDATE^HLFNC(X)
 ;;trans status;IB35471(.05)^FT1^8
 ;;rx number;IB35471(.091)^RXE^15
 ;;refill number;IB35471(.092)^RXE^12
 ;;units;IB35471(.07)^FT1^12^5^1
 ;;total charge;IB35471(.08)^FT1^12^1^1
 ;;parent transaction;IB35471(.1)^FT1^9
 ;;billed amount;IB35471(.11)^FT1^11^1^1
 ;;unbilled amount;IB35471(.12)^FT1^15^1^1
 ;;mt clock begin date;IB351(.03)^ZMT^35^^^^S X=$$FMDATE^HLFNC(X)
 ;;mt clock status;IB351(.04)^ZMT^36
 ;;1st 90 day amt;IB351(.05)^ZMT^37
 ;;2nd 90 day amt;IB351(.06)^ZMT^38
 ;;3rd 90 day amt;IB351(.07)^ZMT^39
 ;;4th 90 day amt;IB351(.08)^ZMT^40
 ;;number of inpt days;IB351(.09)^ZMT^41
 ;;mt clock end date;IB351(.1)^ZMT^42^^^^S X=$$FMDATE^HLFNC(X)
 ;;ltc clock begin date;IB35181(.03)^ZMT^43^^^^S X=$$FMDATE^HLFNC(X)
 ;;ltc clock end date;IB35181(.04)^ZMT^44^^^^S X=$$FMDATE^HLFNC(X)
 ;;ltc clock status;IB35181(.05)^ZMT^45
 ;;ltc 21 exempt dates;IBMTD21^ZMT^46^^^^S IBMTDT21=$G(IBMTDT21)+1,IBMTDT21(IBMTDT21)=$$FMDATE^HLFNC(X)
 ;;charege type;IB350("TYP")^ZMT^47
 ;;patient type;IB350("IO")^PV1^2
 ;;event date/time;IB350("EDT")^PV1^44^1^^^S X=$$FMDATE^HLFNC(X)
 ;;bed section;IB350("BS")^ZMT^48
 ;;units;IB350(.06)^ZMT^49
 ;;total charge;IB350(.07)^ZMT^50
 ;;event date;IB350(.17)^ZMT^51^^^^S X=$$FMDATE^HLFNC(X)
 ;;from date;IB350(.14)^ZMT^52^^^^S X=$$FMDATE^HLFNC(X)
 ;;to date;IB350(.15)^ZMT^53^^^^S X=$$FMDATE^HLFNC(X)
 ;;stop code;IB350(.2)^ZMT^54
 ;;trans status;IB350(.05)^ZMT^55
 ;;idx visit number;IB350("IDX")^PV1^19^1
 ;;
 ;
