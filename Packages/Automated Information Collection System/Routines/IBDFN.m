IBDFN ;ALB/CJM - ENCOUNTER FORM - INTERFACE ROUTINES ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**11,36**;APR 24, 1997
VADPT ;returns patient demographic data
 ;input variables - DFN
 N ARY
 S ARY="^TMP(""IB"",$J,""INTERFACES"",+$G(DFN))"
 D DEM^VADPT
 I VAERR S (@ARY@("DPT PATIENT'S NAME"),@ARY@("DPT PATIENT'S DOB/AGE"),@ARY@("DPT PATIENT'S SEX"),@ARY@("DPT PATIENT'S PID"),@ARY@("DPT PATIENT'S MARITAL STATUS"))=""  Q
 S @ARY@("DPT PATIENT'S NAME")=VADM(1),@ARY@("DPT PATIENT'S SEX")=$P(VADM(5),"^",2)_"^"_$E($P(VADM(5),"^",2)),@ARY@("DPT PATIENT'S DOB/AGE")=$P(VADM(3),"^",2)_"^"_VADM(4),@ARY@("DPT PATIENT'S PID")=VA("PID")
 S @ARY@("DPT PATIENT'S MARITAL STATUS")=$P(VADM(10),"^",2)
 S @ARY@("DPT PATIENT'S RACE")=$P(VADM(8),"^",2)
 S @ARY@("DPT PATIENT'S REMARKS")=$P($G(^DPT(+$G(DFN),0)),"^",10)
 K VADM,VA,VAERR,VAEL
 Q
EMPLMNT ;returns patient's employment status
 ;input variables - DFN
 D OPD^VADPT
 I VAERR S @IBARY=""  Q
 S @IBARY=$P(VAPD(7),"^",2)
 K VAPD,VA,VAERR,VAEL
 Q
 ;
DATE(Y) ; Y=date in FM form, this function translates the date to its 
 ;external form
 D DD^%DT
 Q Y
 Q
 ;
ELIG ;for output of eligibility information & service connected conditions
 N COUNT,ARY,VAEL,VAERR,NODE0,COND,DESCR,PERC,EC,VASV,DATA,I,SARY
 S ARY="^TMP(""IB"",$J,""INTERFACES"",+$G(DFN))"
 S SARY="^TMP(""IB"",$J,""INTERFACES"")"
 D ELIG^VADPT
 I VAERR F I=1:1:6 S VAEL(I)=""
 S PERC=$P(VAEL(3),"^",2),PERC=$S(PERC="":"",1:$J(PERC,3,0))
 S @ARY@("DPT PATIENT ELIGIBILITY DATA")=$P(VAEL(1),"^",2)_"^"_$P(VAEL(2),"^",2)_"^"_$S(VAEL(3):"YES",VAEL(3)=0:"NO",1:"")_"^"_$S(VAEL(4):"YES",VAEL(4)=0:"NO",1:"")_"^"_$S(VAEL(5):"YES",VAEL(5)=0:"NO",1:"")_"^"_$P(VAEL(6),"^",2)_"^"_PERC
 S @ARY@("DPT SC HIDDEN LABELS")=$S(((+VAEL(3))!($O(^DPT(DFN,.372,0)))):"%^% - SERVICE CONNECTED^SERVICE CONNECTED:^SC CONDITIONS:^S/C",1:"  ^  ^  ^  ^  ")
 I $O(^DPT(DFN,.372,0)),VAEL(4)!$$GET1^DIQ(391,+VAEL(6),.02) S (COUNT,COND)=0 F  S COND=$O(^DPT(DFN,.372,COND)) Q:COND=""  D
 .S NODE0=$G(^DPT(DFN,.372,COND,0)) Q:'$P(NODE0,"^",3)  S DESCR=$G(^DIC(31,+NODE0,0)),COUNT=COUNT+1
 .S PERC=$P(NODE0,"^",2),PERC=$S(PERC="":"",1:$J(PERC,3,0))
 .S @SARY@("DPT PATIENT'S SC CONDITIONS",COUNT)=$S($P(DESCR,"^",4)'="":$P(DESCR,"^",4),1:$P(DESCR,"^",1))_"^"_PERC_"^"_PERC_"%"_"^"_PERC_"%SC"_"^"_PERC_"% - SERVICE CONNECTED"
 ;
 ;get service data
 D SVC^VADPT
 I VAERR S DATA="^^^^"
 E  S DATA=$S(VASV(1):"YES",1:"NO")_"^"_$S(VASV(2):"YES",1:"NO")_"^"_$S(VASV(3):"YES",1:"NO")_"^"_$S(VASV(4):"YES",1:"NO")_"^"_$S(VASV(5):"YES",1:"NO")
 ;
 ;get the persian gulf indicator - not returned by VADPT
 S EC=$$EC^SDCO22(DFN,0)
 ;S EC=$P($G(^DPT(DFN,.322)),"^",13)
 S @ARY@("DPT SERVICE HISTORY RELATED DATA")=DATA_"^"_$S(EC=1:"YES",1:"NO")
 ;
 ;displays questions concerning treatment related to service only
 ;if they apply
 ;
 S DATA=$S(VAEL(3):"Was treatment for a SC condition? __ YES __ NO",1:"")_"^"
 S DATA=DATA_$S(VASV(2):"Was treatment related to exposure to Agent Orange? __ YES __ NO",1:"")_"^"
 S DATA=DATA_$S(VASV(3):"Was treatment related to exposure to Ionization Radiation? __ YES __ NO",1:"")
 S @ARY@("DPT SC TREATMENT QUESTIONS")=DATA
 ;
 ;note: must store the 4th question in an annex node
 S DATA="^^^"_$S(EC=1:"Was treatment related to exposure to Environmental Contaminants? __ YES __ NO",1:"")_"^"
 I VASV(2)!VASV(3)!(EC=1) D
 .S DATA=DATA_"Was treatment related to: "_$S(VASV(2):"AO __ ",1:"")_$S(VASV(3):"IR __ ",1:"")_$S(EC=1:"EC __ ",1:"")
 S @ARY@("DPT SC TREATMENT QUESTIONS",1)=DATA
 Q
 ;
BLANKS ;returns NOTHING for printing blank lines
 S @IBARY=""
 Q
LABELS ;returns NOTHING for printing labels only, ie, no data
 S @IBARY=""
 Q
ELIG1 ;for output of hidden service connected conditions
 N COUNT,ARY,VAEL,VAERR,VASV,EC
 S ARY="^TMP(""IB"",$J,""INTERFACES"")",COUNT=0
 D ELIG^VADPT
 I 'VAERR,(VAEL(3)) S COUNT=COUNT+1,@ARY@("DPT SC HIDDEN TREATMENT QUESTIONS",COUNT)="SC^Was treatment for an SC condition?"
 ;
 ;get service data
 D SVC^VADPT
 I 'VAERR D
 .I VASV(2) S COUNT=COUNT+1,@ARY@("DPT SC HIDDEN TREATMENT QUESTIONS",COUNT)="AO^Was treatment related to exposure to Agent Orange?"
 .I VASV(3) S COUNT=COUNT+1,@ARY@("DPT SC HIDDEN TREATMENT QUESTIONS",COUNT)="IR^Was treatment related to exposure to Ionization Radiation?"
 ;
 ;get the persian gulf indicator - not returned by VADPT
 ;S EC=$P($G(^DPT(DFN,.322)),"^",13)
 I $$EC^SDCO22(DFN,0) S COUNT=COUNT+1,@ARY@("DPT SC HIDDEN TREATMENT QUESTIONS",COUNT)="EC^Was treatment related to exposure to Environmental Contaminants?"
 Q
 ;
ELIG2 ; -- for output of hidden classification questions
 N COUNT,ARY
 I $G(IBCLINIC) I '$$REQ^IBDFDE0(DFN,IBAPPT,IBCLINIC,0) Q
 ;
 S ARY="^TMP(""IB"",$J,""INTERFACES"")",COUNT=0
 ;
 I $$SC^SDCO22(DFN,0) D SETARY(ARY,.COUNT,"SC^Was treatment for an SC condition?")
 I $$AO^SDCO22(DFN,0) D SETARY(ARY,.COUNT,"AO^Was treatment related to exposure to Agent Orange?")
 I $$IR^SDCO22(DFN,0) D SETARY(ARY,.COUNT,"IR^Was treatment related to exposure to Ionization Radiation?")
 I $$EC^SDCO22(DFN,0) D SETARY(ARY,.COUNT,"EC^Was treatment related to exposure to Environmental Contaminants?")
 ;
ELIG2Q Q
 ;
SETARY(ARY,CNT,TEXT) ; -- build array
 S CNT=CNT+1
 S @ARY@("DPT SC HIDDEN TREATMENT QUESTIONS",CNT)=TEXT
 Q
 ;
ELIGMST ;-- Adds the MST indicator to existing hidden classification questions
 ;   (patch IBD*3*36)
 ;
 N ARY,DATA,MST,MSTSTAT
 D ELIG
 S ARY="^TMP(""IB"",$J,""INTERFACES"",+$G(DFN))"
 S MST=$$MST^SDCO22(DFN,0)
 S MSTSTAT=$P($$GETSTAT^DGMSTAPI(DFN),"^",2),MSTSTAT=$S(MSTSTAT="Y":"YES",MSTSTAT="N":"NO",MSTSTAT="U":"UNKNOWN",MSTSTAT="D":"DECLINED",1:"")
 I $D(@ARY@("DPT SERVICE HISTORY RELATED DATA")) S @ARY@("DPT SERVICE HISTORY RELATED DATA (MST)")=$G(@ARY@("DPT SERVICE HISTORY RELATED DATA"))_"^"_MSTSTAT
 ;
 I $D(@ARY@("DPT SC TREATMENT QUESTIONS")) S @ARY@("DPT SC TREATMENT QUESTIONS (MST)")=$G(@ARY@("DPT SC TREATMENT QUESTIONS"))
 I $D(@ARY@("DPT SC TREATMENT QUESTIONS",1)) D
 . S DATA=$G(@ARY@("DPT SC TREATMENT QUESTIONS",1))
 . I MST D
 .. S DATA=DATA_$S($L($P(DATA,"^",5))>1:"MST __",1:"Was treatment related to: MST __")
 .. S $P(DATA,"^",6)=$S(MST:"Was treatment related to MST? __ YES __ NO",1:"")
 . S @ARY@("DPT SC TREATMENT QUESTIONS (MST)",1)=DATA
 Q
 ;
ELIG1MST ;-- Similar to ELIG1 but adds MST indicator (if applicable) to hidden classification questions array
 ;
 K ^TMP("IB",$J,"INTERFACES","DPT SC HIDDEN TREATMENT QUESTIONS")
 K ^TMP("IB",$J,"INTERFACES","DPT SC HIDDEN TREATMENT QUESTIONS (MST)")
 D ELIG1
 D ELIGSET
 Q
 ;
ELIG2MST ;-- Similar to ELIG2 but adds MST indicator (if applicable) to hidden classification questions array
 ;
 K ^TMP("IB",$J,"INTERFACES","DPT SC HIDDEN TREATMENT QUESTIONS")
 K ^TMP("IB",$J,"INTERFACES","DPT SC HIDDEN TREATMENT QUESTIONS (MST)")
 D ELIG2
 D ELIGSET
 Q
 ;
ELIGSET ;-- Checks for MST and adds MST question to hidden classification array
 ;
 N ARY,COUNT,I
 S ARY="^TMP(""IB"",$J,""INTERFACES"")"
 S (COUNT,I)=0
 M @ARY@("DPT SC HIDDEN TREATMENT QUESTIONS (MST)")=@ARY@("DPT SC HIDDEN TREATMENT QUESTIONS")
 I $$MST^SDCO22(DFN,0) D
 . F  S I=$O(@ARY@("DPT SC HIDDEN TREATMENT QUESTIONS (MST)",I)) Q:'I  S COUNT=I
 . S COUNT=COUNT+1,@ARY@("DPT SC HIDDEN TREATMENT QUESTIONS (MST)",COUNT)="MST^Was treatment related to MST?  (Ask provider only)"
 Q
