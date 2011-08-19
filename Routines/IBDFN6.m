IBDFN6 ;ALB/CJM - ENCOUNTER FORM - INTERFACE ROUTINES ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
ADDRESS ;returns address, telephone
 ;input variables - DFN
 N ARY,CNT,LINE S CNT=1
 S ARY="^TMP(""IB"",$J,""INTERFACES"",+$G(DFN))"
 D ADD^VADPT
 I VAERR S (@ARY@("DPT PATIENT ADDRESS LINES"),@ARY@("DPT PATIENT'S TELEPHONE NUMBER"),@ARY@("DPT PATIENT SHORT ADDRESS"))=""  Q
 I VAPA(1)'="" S @ARY@("DPT PATIENT ADDRESS LINES",CNT)=VAPA(1),CNT=CNT+1
 I VAPA(2)'="" S @ARY@("DPT PATIENT ADDRESS LINES",CNT)=VAPA(2),CNT=CNT+1
 I VAPA(3)'="" S @ARY@("DPT PATIENT ADDRESS LINES",CNT)=VAPA(3),CNT=CNT+1
 S @ARY@("DPT PATIENT ADDRESS LINES",CNT)=VAPA(4)_", "_$P(VAPA(5),"^",2)_" "_$P(VAPA(11),"^",2)
 ;
 ;short address
 F CNT=1:1:3 S LINE=VAPA(CNT) Q:LINE'=""
 S @ARY@("DPT PATIENT SHORT ADDRESS")=LINE_","_VAPA(4)_", "_$P(VAPA(5),"^",2)_" "_$P(VAPA(11),"^",2)
 ;
 S @ARY@("DPT PATIENT'S TELEPHONE NUMBER")=VAPA(8)
 K VAPA,VA,VAERR,VAEL
 Q
 ;
INSURANC ;returns all sorts of insurance information
 ;input - DFN,ACT
 ;ACT="" to return all insurance, ACT=1 to return only active insurance, ACT=2 to return active insurance and insurance that will not reimburse (Medicare)
 ;
 Q:'$G(DFN)
 N NODE,SUB,ITEM,ENTRY,DATE,ARY,WHO
 I $L($T(ALL^IBCNS1)) D
 .S ARY="^TMP(""IBDF"",$J,""INSURANCE"")"
 .K @ARY
 .D ALL^IBCNS1(DFN,ARY,$G(ACT))
 ;
 S SUB=0,ITEM=1,ENTRY="" F  S SUB=$O(@ARY@(SUB)) Q:'SUB  D
 .S NODE=$G(@ARY@(SUB,0)) Q:NODE=""
 .S:$P(NODE,"^") ENTRY=$P($G(^DIC(36,$P(NODE,"^"),0)),"^")
 .S Y=$P(NODE,"^",4) I Y>0 D DD^%DT S $P(ENTRY,"^",2)=Y
 .S $P(ENTRY,"^",3)=$P(NODE,"^",2)
 .S $P(ENTRY,"^",4)=$P(NODE,"^",3)
 .S $P(ENTRY,"^",5)=$P(NODE,"^",15)
 .S $P(ENTRY,"^",6)=$P(NODE,"^",17)
 .S WHO=$P(NODE,"^",6)
 .S $P(ENTRY,"^",7)=$S(WHO="v":"APPLICANT",WHO="s":"SPOUSE",WHO="o":"OTHER",1:"")
 .S @IBARY@(ITEM)=ENTRY
 .S ITEM=ITEM+1
 K @ARY
 Q
 ;
INSURED ;is the patient insured?
 ;input - DFN
 Q:'$G(DFN)
 N INS S INS=""
 ;do it the new way?
 I $L($T(INSURED^IBCNS1)) D
 .S INS=$$INSURED^IBCNS1(DFN)
 S @IBARY=$S(INS=1:"YES",INS=0:"NO",1:"UNKNOWN")
 Q
