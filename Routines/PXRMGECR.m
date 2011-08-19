PXRMGECR ;SLC/JVS GEC-Reports ;7/14/05  10:44
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
LOC ;Referrals by Location
 N CAT,HF,DATE,DFN,Y,HFN,DFNXX
 D E^PXRMGECV("LOC",1,BDT,EDT,"F",0)
 I FORMAT="F" S FOR=1
 I FORMAT="D" S FOR=0
 W @IOF
 W "=============================================================================="
 W !,"Complete GEC Referrals by Location"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 I FOR W !,"Location"
 I FOR W !,?5,"Patient",?50,"Finish Date"
 I 'FOR W !,"Location^Location Count^Patient^SSN^Finish Date"
 W !,"=============================================================================="
 W ! D PB Q:Y=0
 S LOCN="" F  S LOCN=$O(^TMP("PXRMGEC",$J,"TMPLOC",LOCN)) Q:LOCN=""!(Y=0)  D
 .Q:LOCNP'=1&(LOCN'=LOCNP)
 .I FOR W ! D PB Q:Y=0
 .I FOR W !,IOUON,LOCN,IOUOFF,?30,"Total # Patients Evaluated= ",$G(^TMP("PXRMGEC",$J,"REFLOCC",LOCN)) D PB Q:Y=0
 .I FOR W ! D PB Q:Y=0
 .S DFNXX="" F  S DFNXX=$O(^TMP("PXRMGEC",$J,"TMPLOC",LOCN,DFNXX)) Q:DFNXX=""!(Y=0)  D
 ..S VDT=0 F  S VDT=$O(^TMP("PXRMGEC",$J,"TMPLOC",LOCN,DFNXX,VDT)) Q:VDT=""!(Y=0)  D
 ...I VDT["0000" I FOR W !,?5,DFNXX,?50,"Incomplete"
 ...E  I FOR W !,?5,$P(DFNXX," ",1,$L(DFNXX," ")-1),"  ("_$P(DFNXX," ",$L(DFNXX," "))_")",?50,$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1)
 ...I FOR D PB Q:Y=0
 ...I 'FOR W !,LOCN,"^",$G(^TMP("PXRMGEC",$J,"REFLOCC",LOCN)),"^",$P(DFNXX," ",1,$L(DFNXX," ")-1),"^",$P(DFNXX," ",$L(DFNXX," ")),"^",$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1)
 K ^TMP("PXRMGEC",$J)
 Q
 ;_______
DR ;Referrals by Date Range
 N CAT,HF,DATE,DFN,Y,HFN,CNTREF,DIF,DIFF
 D E^PXRMGECV("HS1",INC,BDT,EDT,$S(INC=1:"F",1:"S"),DFNONLY)
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 W @IOF
 W "=============================================================================="
 W !,"Complete and/or Incomplete GEC Referrals by Date Range"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,$S(INC=0:"Incomplete",INC=1:"Complete",INC=2:"Complete and Incomplete",1:"")_" Referrals"
 I FOR W !,"Patient"
 I INC=1 I FOR W !,?5,"Start Date",?20,"Finished",?35,"Elapsed Time"
 E  I FOR W !,?5,"Start Date",?20,"Finished",?35,"Elapsed Time",?50,"Incomplete Status"
 I 'FOR W !,"Patient^SS#^Count^Start Date^Finished Date^Elapsed Time"
 W !,"=============================================================================="
 W ! D PB Q:Y=0
 S DFN="" F  S DFN=$O(^TMP("PXRMGEC",$J,"HS1",DFN)) Q:DFN=""!(Y=0)  D
 .I FOR W ! D PB Q:Y=0
 .I FOR W !,IOUON,$P(DFN," ",1,$L(DFN," ")-1)," ("_$P(DFN," ",$L(DFN," "))_")"," ",IOUOFF
 .I FOR W ?44,$G(^TMP("PXRMGEC",$J,"REFDFNN",$P(DFN," ",1,($L(DFN," ")-1))))," Referral(s)" D PB Q:Y=0
 .I FOR W ! D PB Q:Y=0
 .S CNTREF="" F  S CNTREF=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF)) Q:CNTREF=""!(Y=0)  D
 ..S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE)) Q:DATE=""!(Y=0)  D
 ...S VDT=0 F  S VDT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT)) Q:VDT=""!(Y=0)  D
 ....S DIFF="" I VDT>0 S DIFF=$$FMDIFF^XLFDT(VDT,DATE,1)+1
 ....S DIF="" S DIF=$$FMDIFF^XLFDT(DT,DATE,1)+1
 ....I VDT["0000" I FOR W !,?5,$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1),?20,"",?35,$S(DIFF="":DIF_" Days",DIFF>0:DIFF_" Days",1:""),?50,$S(DIFF="":"Incomplete",1:"")
 ....E  I FOR W !,?5,$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1),?20,$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1),?35,$S(DIFF="":DIF_" Days",DIFF>0:DIFF_" Days",1:""),?50,$S(DIFF="":"Incomplete",1:"")
 ....I FOR D PB Q:Y=0
 ....I 'FOR W !,$P(DFN," ",1,$L(DFN," ")-1),"^",$P(DFN," ",$L(DFN," ")),"^"
 ....I 'FOR W $G(^TMP("PXRMGEC",$J,"REFDFNN",$P(DFN," ",1,$L(DFN," ")-1))),"^",$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1),"^",$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1),"^",$S(DIFF="":DIF,DIFF>0:DIFF,1:"")
 K ^TMP("PXRMGEC",$J)
 Q
 ;_____
HS1 ;By Patient
 N CAT,HF,DATE,DFN,Y,HFN,CNTREF,X,REFNUM,CNT,STATUS,NAME,DIV
 D E^PXRMGECV("HS1",1,BDT,EDT,"F",DFNONLY)
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 W @IOF
 W "=============================================================================="
 W !,"GEC Patient"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 I FOR W !,"Patient"
 I FOR W !," Category"
 I FOR W !,"    Health Factor",?44,"Value",?55,"Date of Evaluation"
 I 'FOR W !,"Patient^Category^Health Factor^Value^Date of Evaluation"
 W !,"=============================================================================="
 S CNT=0
 S Y=1
 S DFN="" F  S DFN=$O(^TMP("PXRMGEC",$J,"HS1",DFN)) Q:DFN=""!(Y=0)  D
 .N NAME,DFNN,STATUS,DIV
 .I FOR W ! D PB Q:Y=0
 .S NAME=$P(DFN," ",1,$L(DFN," ")-1)
 .S DFNN=$O(^DPT("B",NAME,0)) D
 ..Q:DFNN=""
 ..S STATUS=$S($D(^DPT(DFNN,.1)):"INPATIENT",1:"OUTPATIENT")
 ..S DIV=$$GET1^DIQ(2,DFNN,.19) I DIV="" S DIV="Unknown"
 .S CNT=CNT+1
 .I STATUS["IN" I FOR W !,CNT,") ",STATUS,", DIVISION:",DIV D PB Q:Y=0
 .I STATUS["OU" I FOR W !,CNT,") ",STATUS D PB Q:Y=0
 .I FOR W !,CNT,") ",IOUON,$P(DFN," ",1,$L(DFN," ")-1)," (",$P(DFN," ",$L(DFN," "))_")",IOUOFF,?48,"Total # Complete referrals: ",$G(^TMP("PXRMGEC",$J,"REFDFNN",$P(DFN," ",1,$L(DFN," ")-1))) D PB Q:Y=0
 .S CNTREF="",REFNUM=0 F  S CNTREF=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF)) Q:CNTREF=""!(Y=0)  D
 ..I FOR W ! D PB Q:Y=0
 ..S REFNUM=REFNUM+1
 ..I FOR W !,IOUON,"Referral #"_REFNUM,IOUOFF D PB Q:Y=0
 ..S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE)) Q:DATE=""!(Y=0)  D
 ...S VDT=0 F  S VDT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT)) Q:VDT=""!(Y=0)  D
 ....S CAT=0 F  S CAT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT)) Q:CAT=""!(Y=0)  D
 .....I FOR W !,?1,$P(CAT," ",3,6) D PB Q:Y=0
 .....S DATEV=0 F  S DATEV=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT,DATEV)) Q:DATEV=""!(Y=0)  D
 ......S DA=0 F  S DA=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT,DATEV,DA)) Q:DA=""!(Y=0)  D
 .......S HFN=$$HFNAME(DA)
 .......I FOR W !,?4,$P(HFN,"^",1),?44,$P(HFN,"^",2),?55,$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1)
 .......I FOR D PB Q:Y=0
 .......S COMMENT=$G(^AUPNVHF(DA,811))
 .......I FOR I COMMENT'="" D COM^PXRMGECZ
 .......I 'FOR W !,$P(DFN," ",1,$L(DFN," ")-1)_"^"_$P(DFN," ",$L(DFN," ")),"^",$P(CAT," ",3,6),"^",$P(HFN,"^",1),"^",$P(HFN,"^",2),"^",$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1),"^",REFNUM
 K ^TMP("PXRMGEC",$J)
 Q
 ;______
HFCD ;Health Factor Category Detailed
 N CAT,HF,DATE,DFN,DFN1,FOR,HFDA,COMMENT
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 K ^TMP("PXRMGEC",$J,"HFCD")
 D E^PXRMGECV("HFCD",1,BDT,EDT,"F",DFNONLY)
 W @IOF
 W "=============================================================================="
 W !,"GEC Health Factor Category Detailed Report"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Complete and Incomplete Referrals"
 I FOR W !,"Category"
 I FOR W !,?2,"Patient Name"
 I FOR W !,?4,"Health Factors",?45,$S($D(RPT7):"",1:"Value"),?52,"Date"
 I 'FOR W !,"Category^Patient^SSN^Health Factor^"_$S($D(RPT7):"Date",1:"Value^Date")
 W !,"=============================================================================="
 D PB Q:Y=0
 S CAT="" F  S CAT=$O(^TMP("PXRMGEC",$J,"HFCD",CAT)) Q:CAT=""!(Y=0)  D
 .S DFN1=0
 .I FOR W ! D PB Q:Y=0
 .I FOR W !,IOUON,$P(CAT," ",3,6),IOUOFF D PB Q:Y=0
 .S DFN=0 F  S DFN=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN)) Q:DFN=""!(Y=0)  D
 ..S HF="" F  S HF=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN,HF)) Q:HF=""!(Y=0)  D
 ...S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN,HF,DATE)) Q:DATE=""!(Y=0)  D
 ....I FOR I DFN'=DFN1 W ! D PB Q:Y=0
 ....I FOR I DFN'=DFN1 W !,?2,$P($G(^DPT(DFN,0)),"^",1)_" ("_$P($G(^DPT(DFN,0)),"^",9)_")" D PB Q:Y=0  W ! D PB Q:Y=0  S DFN1=DFN
 ....S HFN=$$HFNAME(0,HF)
 ....S HFDA=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN,HF,DATE,0))
 ....I FOR W !,?4,$P(HFN,"^",1),?45,$S($D(RPT7):"",1:$P(HFN,"^",2)),?52,$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1)
 ....I FOR D PB Q:Y=0
 ....S COMMENT=$G(^AUPNVHF(HFDA,811))
 ....I FOR I COMMENT'="" D COM^PXRMGECZ
 ....I 'FOR W !,$P(CAT," ",3,5),"^",$P($G(^DPT(DFN,0)),"^",1)_"^"_$P($G(^DPT(DFN,0)),"^",9),"^",$P(HFN,"^",1),$S($D(RPT7):"",1:"^"_$P(HFN,"^",2)),"^",$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1)
 K ^TMP("PXRMGEC",$J)
 D ^%ZISC
 Q
 ;____
LOCCNT ;Count Locations of Referrals
 N LOC,VDT
 S LOC="" F  S LOC=$O(^TMP("PXRMGEC",$J,"LOCB",LOC)) Q:LOC=""  D
 .S VDT="" F  S VDT=$O(^TMP("PXRMGEC",$J,"LOCB",LOC,VDT)) Q:VDT=""  D
 ..I $D(^TMP("PXRMGEC",$J,"LOCBB",LOC)) S ^TMP("PXRMGEC",$J,"LOCBB",LOC)=$G(^TMP("PXRMGEC",$J,"LOCBB",LOC))+1
 ..E  S ^TMP("PXRMGEC",$J,"LOCBB",LOC)=1
 Q
 ;
HFNAME(DA,NAME) ;Decide to split name into columns
 N WHOLE,FIRST,SECOND,REF,REF2,RESULT
 I DA>0 D
 .S WHOLE=$P($G(^AUTTHF($P($G(^AUPNVHF(DA,0)),"^",1),0)),"^",1)
 E  S WHOLE=NAME
 I $D(RPT7) D
 .I WHOLE["(REFERRED TO)" D
 ..S WHOLE=$P(WHOLE," (",1)
 S RESULT="^"
 S REF="YESNOSTAGE 1STAGE 2STAGE 3STAGE 4"
 S REF2="12"
 S FIRST=$P(WHOLE,"-",1,$L(WHOLE,"-")-1)
 S SECOND=$P(WHOLE,"-",$L(WHOLE,"-"))
 I REF[SECOND S RESULT=FIRST_"^"_SECOND
 E  S RESULT=WHOLE_"^"
 I REF2[SECOND S RESULT=WHOLE_"^"
 Q RESULT
 ;=====
PB ;PAGE BREAK
 S Y=""
 I $Y=(IOSL-2)!($Y=(IOSL-3)) D
 .K DIR
 .S DIR(0)="E"
 .D ^DIR
 .I Y=1 W @IOF S $Y=0
 K DIR
 Q
 ;
