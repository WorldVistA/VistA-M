ECXCBFK ;ALB/DAN - Cost by feeder key ;6/20/19  08:43
 ;;3.0;DSS EXTRACTS;**174**;Dec 22, 1997;Build 33
 ;
 N QFLG,ECXOPT,EXTRACT,FY,FP
 S QFLG=0
 D BEGIN
 D SELECT Q:QFLG
 K ^TMP($J,"ECXCBFK"),^TMP($J,"ECXPORT")
 D GET
 D DISPLAY K ^TMP($J,"ECXCBFK"),^TMP($J,"ECXPORT")
 Q
 ;
BEGIN ;Give report details
 W @IOF
 W !,"This report prints costs by feeder key for a selected extract",!,"from PRE, UDP, IVP or BCM."
 W !!,"**This report is export only so after making your selections, the",!,"results will be displayed to the screen for capture.",!
 Q
 ;
SELECT ;Select extract system and extract number
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIC,STDT
 S DIR(0)="SO^1:PRE;2:IVP;3:UDP;4:BCM",DIR("A")="Select extract type" D ^DIR K DIR I $G(DIRUT) S QFLG=1 Q
 S ECXOPT=Y(0)
 S DIC=727,DIC(0)="AEMQ",DIC("S")="I $P($G(^(""HEAD"")),U)=ECXOPT&($P($G(^(0)),U,6)>0)"
 S DIC("W")="W:$G(DZ)[""?"" ?12,""Date range: "",$$FMTE^XLFDT($P(^(0),U,4),""2Z""),"" to "",$$FMTE^XLFDT($P(^(0),U,5),""2Z""),?48,""Records Extracted: "",$S($P(^(0),U,6)'="""":$P(^(0),U,6),1:""Inc."")"
 D ^DIC
 S EXTRACT=+Y I EXTRACT'>0 S QFLG=1 Q
 S STDT=$P(^ECX(727,EXTRACT,0),U,4) ;Get extract start date
 S FY=$$FISCAL^ECXUTL1(STDT) ;Get FY from start date
 S FP=$S($E(STDT,4,5)>9:$E(STDT,4,5)-9,1:$E(STDT,4,5)+3) ;Set Fiscal Period based on month
 Q
 ;
GET ;Find data
 N FK,NODE,FILE,FILEAC,SEQ,VAP,NDC,STA,NODE0,NODE1,NODE2,NODE3,TYPE,DESC
 W !!,"Gathering data..."
 S FILE=$S(ECXOPT="PRE":"^ECX(727.81,",ECXOPT="UDP":"^ECX(727.809,",ECXOPT="IVP":"^ECX(727.819,",1:"^ECX(727.833,")
 S FILEAC=FILE_"""AC"""_","_EXTRACT_")"
 S SEQ=0 F  S SEQ=$O(@FILEAC@(SEQ)) Q:'+SEQ  D
 .I SEQ#10000=0 W "."
 .S NODE0=@(FILE_SEQ_",0)") ;Set 0 node
 .S:ECXOPT="PRE" NODE2=@(FILE_SEQ_",2)") ;If PRE get 2 node
 .S FK=$S(ECXOPT="PRE":$P(NODE0,U,28),ECXOPT="UDP":$P(NODE0,U,18),ECXOPT="IVP":$P(NODE0,U,19),1:"BCM") ;BCM doesn't have a feeder key, need to build it
 .I FK="BCM" D  ;Build feeder key for BCM
 ..S NODE1=$G(^ECX(727.833,SEQ,1)),NODE2=$G(^(2)),NODE3=$G(^(3))
 ..S VAP=$$RJ^XLFSTR($P(NODE2,U,6),5,0) ;Set 5 digit VA Product code, padded with zeroes in needed
 ..S NDC=$TR($P(NODE2,U,7),"-","") ;Remove hyphens from NDC (if it exists) 
 ..S FK=VAP_$S(NDC="":"000000000000",1:NDC) ;Pad with zeroes if missing
 .S UNIT=$$INFO(FK,"UNIT",ECXOPT) ;Get units
 .S DESC=$$INFO(FK,"DESC",ECXOPT) ;Get description
 .S STA=$$GET1^DIQ($S(ECXOPT="PRE":727.81,ECXOPT="UDP":727.809,ECXOPT="IVP":727.819,1:727.833),SEQ_",","PRODUCTION DIVISION CODE") S:STA="" STA="Unresolved Station"
 .S $P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U)=+$P($G(^TMP($J,"ECXCBFK",STA,FK,UNIT)),U)+1 ;Increment counter
 .I ECXOPT="BCM" D  Q
 ..S $P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,2)=$P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,2)+$P(NODE1,U,7) ;add units
 ..S TYPE=$P(NODE1,U,9)
 ..S $P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,3)=$P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,3)+$S(TYPE="D":$P(NODE3,U,14),TYPE="A":$P(NODE3,U,12),TYPE="S":$P(NODE3,U,13),1:0) ;Get cost, use 0 if not found
 ..S ^TMP($J,"ECXCBFK",STA,FK,UNIT,"DESC")=DESC
 .S $P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,2)=$P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,2)+$S(ECXOPT="PRE":$P(NODE0,U,17),ECXOPT="UDP":$P(NODE0,U,11),1:$P(NODE0,U,20)) ;Count quantity/doses given
 .S $P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,3)=$P(^TMP($J,"ECXCBFK",STA,FK,UNIT),U,3)+$S(ECXOPT="PRE":$P(NODE0,U,18),ECXOPT="UDP":$P(NODE0,U,14),1:$P(NODE0,U,13)) ;Get cost of medication
 .S ^TMP($J,"ECXCBFK",STA,FK,UNIT,"DESC")=DESC
 Q
 ;
INFO(FK,FIELD,OPTION) ;Get information from drug identified in feeder key
 N DRUG,UNITS,NDC,DIC,X,D,VALUE
 I FK["LCD" D  Q VALUE  ;If no VA product, use Drug file IEN from feeder key
 .S DRUG=+$P(FK,"LCD",2) S VALUE=$$VALUE(DRUG,FIELD,FK)
 .Q
 I FK["LCL" D  Q VALUE
 .S DRUG=+$P(FK,"LCL",2) S VALUE=$$VALUE(DRUG,FIELD,FK)
 .Q
 S NDC=$S(OPTION="IVP":$TR($P(NODE0,U,16),"-",""),OPTION="UDP":$TR($P(NODE0,U,17),"-",""),OPTION="PRE":"PRE",1:$E(FK,6,30))
 I OPTION'="PRE" D
 .S:NDC="000000000000" NDC="" ;Set NDC to blank if all zeroes to avoid incorrect lookup on drugs with all zeroes as NDC
 .S DIC=50,DIC(0)="M",D="NDC^C" ;Use NDC and C xrefs for lookup
 .D MIX^PSSDI(50,"ECX",.DIC,D,NDC)
 .I Y'>0,NDC'="" S NDC=$$RJ^XLFSTR(NDC,12,0) D MIX^PSSDI(50,"ECX",.DIC,D,NDC) ;If drug not found, try padding NDC with leading zeroes
 .S DRUG=+Y S:DRUG'>0 DRUG=0
 I OPTION="PRE" D
 .S DIC=52,DIC(0)="",X=$P(NODE2,U,8) D ^DIC
 .S DRUG=$$GET1^DIQ(52,+Y,6,"I")
 S VALUE=$$VALUE(DRUG,FIELD,FK)
 Q VALUE
 ;
DISPLAY ;Put results in exportable format
 N STA,FK,UNI,CNT,DATA,DESC
 S ^TMP($J,"ECXPORT",0)="STATION^FY^FP^DESCRIPTION^FEEDER KEY^UNIT^ENCOUNTERS^"_$S(ECXOPT="BCM":"COMPONENT DOSES GIVEN",ECXOPT="IVP":"TOTAL DOSES",1:"QUANTITY")_"^TOTAL COST^UNIT COST"
 S CNT=1
 S STA="" F  S STA=$O(^TMP($J,"ECXCBFK",STA)) Q:STA=""  S FK="" F  S FK=$O(^TMP($J,"ECXCBFK",STA,FK)) Q:FK=""  S UNIT="" F  S UNIT=$O(^TMP($J,"ECXCBFK",STA,FK,UNIT)) Q:UNIT=""  D
 .S DATA=^TMP($J,"ECXCBFK",STA,FK,UNIT)
 .S DESC=^TMP($J,"ECXCBFK",STA,FK,UNIT,"DESC")
 .S ^TMP($J,"ECXPORT",CNT)=STA_U_FY_U_FP_U_DESC_U_FK_U_UNIT_U_$P(DATA,U)_U_+$P(DATA,U,2)_U_$FN(+$P(DATA,U,3),",",2)_U_$S(+$P(DATA,U,2)=0:"--",1:$FN($P(DATA,U,3)/$P(DATA,U,2),",",4))
 .S CNT=CNT+1
 D EXPDISP^ECXUTL1
 Q
 ;
VALUE(DRUG,FIELD,FK) ;Get unit or name from drug
 S VALUE=$$GET1^DIQ(50,DRUG_",",$S(FIELD="UNIT":14.5,1:.01)) S:VALUE="" VALUE="Not Found"
 I VALUE="Not Found",FIELD="UNIT" S VALUE=$$GET1^DIQ(50,DRUG_",",902) S:VALUE="" VALUE="Not Found"
 I VALUE="Not Found" D
 .S DRUG=+$E(FK,1,5)
 .I DRUG S VALUE=$$GET1^DIQ(50.68,DRUG_",",$S(FIELD="UNIT":8,1:.01)) S:VALUE="" VALUE="Not Found"
 .I DRUG,FIELD="UNIT",VALUE="Not Found" S VALUE=$$GET1^DIQ(50.68,DRUG_",",3) S:VALUE="" VALUE="Not Found" ;if unit not found in 'unit' field then look in 'VA dispense unit' field
 Q VALUE
