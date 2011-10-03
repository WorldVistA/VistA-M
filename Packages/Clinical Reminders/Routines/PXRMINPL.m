PXRMINPL ;SLC/RMS,PKR - List computed findings for inpatient info. ; 09/08/2008
 ;;2.0;CLINICAL REMINDERS;**12**;Feb 04, 2005;Build 73
 ;=====================================
ADM(NGET,BDT,EDT,PLIST,PARAM) ;All admissions during a date range.
 D ADMDISCH(BDT,EDT,PLIST,PARAM,"ATT1")
 Q
 ;
 ;=====================================
ADMDISCH(BDT,EDT,PLIST,PARAM,SUB) ;Build admission and discharge lists.
 ;Admissions when SUB="ATT1" and discharges when SUB="ATT3"
 ;DBIAs (^DIC(4: #2251,#10090), (^DIC(42: #10039),
 ;(^DGPM: #1480), (^DPT: #187), (^SC: #10040)
 N CNT,DATA,DATE,DFN,HLOC,IEN,LOCLIST,OK,WARD,WARDP
 K ^TMP($J,PLIST),^TMP($J,"CNT")
 S DATE=BDT-.000001
 S OK=1
 S LOCLIST=$S(PARAM'="":+$O(^PXRMD(810.9,"B",PARAM,0)),1:0)
 F  S DATE=$O(^DGPM(SUB,DATE)) Q:(DATE>EDT)!(DATE="")  D
 . S IEN=""
 . F  S IEN=$O(^DGPM(SUB,DATE,IEN)) Q:IEN=""  D
 .. S DATA=^DGPM(IEN,0)
 .. S DFN=$P(DATA,U,3)
 .. I SUB="ATT1" D
 ...;WARD is a required field but it may not exist for older entries.
 ... S WARDP=+$P(DATA,U,6)
 ... S WARD=WARDP_";"_$S(WARDP>0:$P($G(^DIC(42,WARDP,0)),U,1),1:0)
 .. I SUB="ATT3" D
 ... S WARD=$$GET1^DIQ(405,IEN,200)
 ... S WARDP=$S(WARD'="":$O(^DIC(42,"B",WARD,"")),1:0)
 ... S WARD=WARDP_";"_WARD
 ..;If a location list has been passed in make sure the hospital
 ..;location for the ward is on the list.
 .. S HLOC=$S(WARDP>0:^DIC(42,WARDP,44),1:0)
 .. I LOCLIST>0 S OK=$S($D(^PXRMD(810.9,LOCLIST,44,"B",HLOC)):1,1:0)
 .. I 'OK Q
 .. S (CNT,^TMP($J,"CNT",DFN))=+$G(^TMP($J,"CNT",DFN))+1
 .. S ^TMP($J,PLIST,DFN,CNT)=U_DATE_U_405_U_DFN_U_WARD
 .. S INST=$S(HLOC>0:+$P(^SC(HLOC,0),U,4),1:0)
 .. S INSTNM=INST_";"_$S(INST>0:$P(^DIC(4,INST,0),U,1),1:0)
 .. S INSTNM=INSTNM_";"_$S(INST>0:$P($G(^DIC(4,INST,99)),U,1),1:0)
 .. S ^TMP($J,PLIST,DFN,CNT,"VALUE")=WARD
 .. S ^TMP($J,PLIST,DFN,CNT,"INSTITUTION")=INSTNM
 .. S ^TMP($J,PLIST,DFN,CNT,"TYPE_OF_MVMT")=$$GET1^DIQ(405.1,$P(DATA,U,4),.01)
 K ^TMP($J,"CNT")
 Q
 ;
 ;=====================================
CURR(NGET,BDT,EDT,PLIST,PARAM) ;Current inpatients.
 ; DBIAs #10035, #10039, #10040, #10061, #10090
 N CNT,DFN,HLOC,INST,INSTNM,LOCLIST,OK,WARD,WARDP,WARDSUB,VAIN,VAERR
 K ^TMP($J,PLIST),^TMP($J,"CNT")
 S OK=1
 S LOCLIST=$S(PARAM'="":+$O(^PXRMD(810.9,"B",PARAM,0)),1:0)
 S WARD=""
 F  S WARD=$O(^DPT("CN",WARD)) Q:WARD=""  D
 . S DFN=0
 . F  S DFN=$O(^DPT("CN",WARD,DFN)) Q:'+DFN  D
 ..;If a location list has been passed in make sure the hospital
 ..;location for the ward is on the list.
 .. S WARDP=+$O(^DIC(42,"B",WARD,""))
 .. S HLOC=+$G(^DIC(42,WARDP,44))
 .. I LOCLIST>0 S OK=$S($D(^PXRMD(810.9,LOCLIST,44,"B",HLOC)):1,1:0)
 .. I 'OK Q
 .. K VAIN,VAERR D INP^VADPT
 .. S WARDSUB=+VAIN(4)_";"_WARD
 .. S (CNT,^TMP($J,"CNT",DFN))=+$G(^TMP($J,"CNT",DFN))+1
 .. S ^TMP($J,PLIST,DFN,CNT)=U_+VAIN(7)_U_2_U_DFN_U_WARDSUB
 .. S INST=$S(HLOC>0:+$P(^SC(HLOC,0),U,4),1:0)
 .. S INSTNM=INST_";"_$S(INST>0:$P(^DIC(4,INST,0),U,1),1:0)
 .. S INSTNM=INSTNM_";"_$S(INST>0:$P($G(^DIC(4,INST,99)),U,1),1:0)
 .. S ^TMP($J,PLIST,DFN,CNT,"VALUE")=WARDSUB
 .. S ^TMP($J,PLIST,DFN,CNT,"INSTITUTION")=INSTNM
 .. S ^TMP($J,PLIST,DFN,CNT,"ADMIT DATE")=VAIN(7)
 K ^TMP($J,"CNT")
 Q
 ;
 ;=====================================
DISCH(NGET,BDT,EDT,PLIST,PARAM) ;Discharges during a date range.
 ;NOTE: ASIH is not accounted for in this version.
 D ADMDISCH(BDT,EDT,PLIST,PARAM,"ATT3")
 Q
 ;
