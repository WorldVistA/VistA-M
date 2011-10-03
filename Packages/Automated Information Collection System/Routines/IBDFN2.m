IBDFN2 ;ALB/CJM - ENCOUNTER FORM - INTERFACE ROUTINES ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**29,31,36,43**;APR 24, 1997
APPT ;returns appt date@time^date^time
 N Y
 S Y="" I IBAPPT S Y=IBAPPT K %DT D DD^%DT
 S @IBARY=Y_"^"_$P(Y,"@")_"^"_$P(Y,"@",2)
 Q
NOW ;returns date and time
 ;FORMATS:
 ; MMM DD, YYYY@HH:MM:SS at the "IB DATE@TIME" subscript
 ; MMM DD,YYYY at the "IB DATE" subscript
 ; HH:MM:SS at the "IB TIME" subscript      
 N Y,%,%H,%I,X
 D NOW^%DTC S Y=% K %DT D DD^%DT
 S ^TMP("IB",$J,"INTERFACES",+$G(DFN),"IB CURRENT DATE@TIME")=Y
 S ^TMP("IB",$J,"INTERFACES",+$G(DFN),"IB CURRENT TIME")=$P(Y,"@",2)
 S ^TMP("IB",$J,"INTERFACES",+$G(DFN),"IB CURRENT DATE")=$P(Y,"@")
 Q
 ;
SPSEMPLR ;returns spouse's employer,address, telephone
 ;input variables - DFN
 N ARY,CNT S CNT=1
 S ARY="^TMP(""IB"",$J,""INTERFACES"",+$G(DFN))"
 S VAOA("A")=6 D OAD^VADPT
 I VAERR S (@ARY@("DPT SPOUSE'S EMPLOYER NAME"),@ARY@("DPT SPOUSE'S EMPLOYER TELEPHONE"),@ARY@("DPT SPOUSE'S EMPLOYER ADDRESS LINES"))=""  Q
 I VAOA(1)'="" S @ARY@("DPT SPOUSE'S EMPLOYER ADDRESS LINES",CNT)=VAOA(1),CNT=CNT+1
 I VAOA(2)'="" S @ARY@("DPT SPOUSE'S EMPLOYER ADDRESS LINES",CNT)=VAOA(2),CNT=CNT+1
 I VAOA(3)'="" S @ARY@("DPT SPOUSE'S EMPLOYER ADDRESS LINES",CNT)=VAOA(3),CNT=CNT+1
 S @ARY@("DPT SPOUSE'S EMPLOYER ADDRESS LINES",CNT)=VAOA(4)_", "_$P(VAOA(5),"^",2)_" "_VAOA(6)
 S @ARY@("DPT SPOUSE'S EMPLOYER TELEPHONE")=VAOA(8)
 S @ARY@("DPT SPOUSE'S EMPLOYER NAME")=VAOA(9)
 K VAOA,VAERR
 Q
EMPLOYER ;returns employer,address, telephone
 ;input variables - DFN
 N ARY,CNT S CNT=1
 S ARY="^TMP(""IB"",$J,""INTERFACES"",DFN)"
 S VAOA("A")=5 D OAD^VADPT
 I VAERR S (@ARY@("DPT PATIENT'S EMPLOYER NAME"),@ARY@("DPT PATIENT'S EMPLOYER TELEPHONE"),@ARY@("DPT PATIENT'S EMPLOYER ADDRESS LINES"))=""  Q
 I VAOA(1)'="" S @ARY@("DPT PATIENT'S EMPLOYER ADDRESS LINES",CNT)=VAOA(1),CNT=CNT+1
 I VAOA(2)'="" S @ARY@("DPT PATIENT'S EMPLOYER ADDRESS LINES",CNT)=VAOA(2),CNT=CNT+1
 I VAOA(3)'="" S @ARY@("DPT PATIENT'S EMPLOYER ADDRESS LINES",CNT)=VAOA(3),CNT=CNT+1
 S @ARY@("DPT PATIENT'S EMPLOYER ADDRESS LINES",CNT)=VAOA(4)_", "_$P(VAOA(5),"^",2)_" "_VAOA(6)
 S @ARY@("DPT PATIENT'S EMPLOYER TELEPHONE")=VAOA(8)
 S @ARY@("DPT PATIENT'S EMPLOYER NAME")=VAOA(9)
 K VAOA,VAERR
 Q
MT ;returns means test data
 N Y,RET,GET
 S GET=$$LST^DGMTU(DFN)
 S RET=$P(GET,"^",3)_"^"
 S Y=$P(GET,"^",2) D DD^%DT
 S RET=RET_Y_"^"_$P(GET,"^",4)
 S @IBARY=RET
 Q
ENROLL ;returns enrollment priority code and copay information
 ;
 N IBEP,IBEP1
 ; --get enrollment priority code
 S IBEP=$$PRIORITY^DGENA(DFN)
 ;
 ; --get copay information  (yes or not)
 S IBEP1=$$BIL^DGMTUB(DFN,DT)
 S $P(IBEP,"^",2)=$S(IBEP1=1:"Y",1:"N")
 S @IBARY=IBEP
 Q
ALLERGY ;outputs a list of the patient's allergies
 ;piece #1=allergy name,#2=type of allergy(FOOD/DRUG/OTHER),#3=type of allergy(F/D/O),#4=VERFIED?(YES/NO),#5=TRUE ALLERGEN(YES/NO)
 N GMRA,GMRAL,NODE,I,COUNT,TYPE
 D:$L($T(GMRADPT^GMRADPT)) ^GMRADPT
 I GMRAL=0 S COUNT=1,@IBARY@(COUNT)="NKA" Q
 S (COUNT,I)=0 F  S I=$O(GMRAL(I)) Q:'I  D
 .S COUNT=COUNT+1
 .S NODE=$G(GMRAL(I))
 .S TYPE=$P(NODE,"^",3)
 .S @IBARY@(COUNT)=$P(NODE,"^",2)_"^"_$S(TYPE="D":"DRUG",TYPE="F":"FOOD",TYPE="O":"OTHER",1:"")_"^"_TYPE_"^"_$S($P(NODE,"^",4)=1:"YES",1:"NO")_"^"_$S($P(NODE,"^",5)=0:"YES",$P(NODE,"^",5)=1:"NO",1:"")
 Q
 ;
PRMT ; -- print a 1010f if required or will expire in 357.09;.1 days
 ;    called from print manger
 ;    requires dfn, ibappt=appointment date
 ;
 N IBDMT,IBDMT1,IBDMT2,DGMTI,DGMTDT,DGMTYPT,DGOPT
 S IBDMT1=$$LST^DGMTU(DFN,DT,1) ; means test
 S IBDMT2=$$LST^DGMTU(DFN,DT,2) ; copay test
 I IBDMT2="",IBDMT1="" G PRMTQ
 S IBDMT=$S(IBDMT2="":IBDMT1,IBDMT1="":IBDMT2,$P(IBDMT1,"^",2)'<$P(IBDMT2,"^",2):IBDMT1,1:IBDMT2)
 S DGMTYPT=$S(IBDMT=IBDMT2:2,1:1) ; set type of test
 S DGMTI=+IBDMT,DGMTDT=$P(IBDMT,"^",2)
 S DGOPT=1 ;pretend were from registration, don't close device when done
 S STATUS=$P(IBDMT,"^",4)
 I $S(STATUS="R":0,STATUS="N":1,STATUS="L":1,STATUS="I":0,$$FMDIFF^XLFDT(IBAPPT,DGMTDT,1)>(365-$S($P($G(^IBD(357.09,1,0)),"^",10):$P(^(0),"^",10),1:30)):0,1:1) G PRMTQ ;not required within params
 ;
 I STATUS="R" D GETMT I IBDMT1="" Q
 D START^DGMTP
PRMTQ Q
 ;
GETMT ;Since status is required find last valid means test
 ;
 S IBDMT=$$LVMT^DGMTU(DFN,DT) ; means test
 S DGMTYPT=1 ; set type of test
 S DGMTI=+IBDMT,DGMTDT=$P(IBDMT,"^",2)
 Q
 ;
 ;
MSTSTAT ;-- Get patient's MST status for EF display block
 ;     Input: 
 ;       DFN
 ;
 ;    Output: 
 ;       Calls API $$GETSTAT^DGMSTAPI(DFN):
 ;         Piece 1 -- MST Status Code (Y, N, D, or U)
 ;         Piece 2 -- MST Status Description
 ;
 N ARY,MST
 S ARY="^TMP(""IB"",$J,""INTERFACES"",DFN)"
 I '$G(DFN) Q
 S MST=$$GETSTAT^DGMSTAPI(DFN)
 I +MST=0!(+MST>0) S @ARY@("DGMST STATUS")=$P(MST,"^",2)_"^"_$S(+MST>0:$P(MST,"^",6),1:"Unknown, not screened")
 Q
 ;
 ;
ASKMST ;-- Ask if patient's treatment is related to SC and MST (if applicable)
 ;
 N ARY,COUNT
 Q:'$G(DFN)
 S ARY="^TMP(""IB"",$J,""INTERFACES"")"
 S COUNT=1
 I $$SC^SDCO22(DFN,0) S @ARY@("DGMST SELECT MST CLASSIFICATN",COUNT)="SC^Was treatment for an SC condition?",COUNT=COUNT+1
 I $$MST^SDCO22(DFN,0) S @ARY@("DGMST SELECT MST CLASSIFICATN",COUNT)="MST^Was treatment related to MST?  (Ask provider only)"
 Q
