PXRMGECQ ;SLC/JVS GEC-QUEUE'D Reports ;7/14/05  10:44
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 Q
LOC ;by Location
 N CAT,HF,DATE,DFN,Y,HFN,DFNXX,PAGE,I
 D E^PXRMGECV("LOC",1,BDT,EDT,"F",0)
 D LOCCNT
 I FORMAT="F" S FOR=1
 I FORMAT="D" S FOR=0
 W @IOF
 F I=1:1:78 W "="
 ;==
 W !,"Complete GEC Referrals by Location"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 I FOR W !,"Location"
 I FOR W !,?5,"Patient",?50,"Finish Date",!
 I 'FOR W !,"Location^Location Count^Patient^SSN^Finish Date",!
 F I=1:1:78 W "="
 ;==
 S PAGE=1
 S LOCN="" F  S LOCN=$O(^TMP("PXRMGEC",$J,"TMPLOC",LOCN)) Q:LOCN=""  D
 .Q:LOCNP'=1&(LOCN'=LOCNP)
 .I FOR W !,LOCN,?30,"Total # Patients Evaluated= ",$G(^TMP("PXRMGEC",$J,"LOCBB",LOCN)) D PAGE^PXRMGECZ
 .I FOR W ! D PAGE^PXRMGECZ
 .S DFNXX="" F  S DFNXX=$O(^TMP("PXRMGEC",$J,"TMPLOC",LOCN,DFNXX)) Q:DFNXX=""  D
 ..S VDT=0 F  S VDT=$O(^TMP("PXRMGEC",$J,"TMPLOC",LOCN,DFNXX,VDT)) Q:VDT=""  D
 ...I VDT["0000" I FOR W !,?5,DFNXX,?50,"Incomplete" D PAGE^PXRMGECZ
 ...E  I FOR W !,?5,$P(DFNXX," ",1,$L(DFNXX," ")-1),"  ("_$P(DFNXX," ",$L(DFNXX," "))_")",?50,$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1) D PAGE^PXRMGECZ
 ...I 'FOR W !,LOCN,"^",$G(^TMP("PXRMGEC",$J,"LOCBB",LOCN)),"^",$P(DFNXX," ",1,$L(DFNXX," ")-1),"^",$P(DFNXX," ",$L(DFNXX," ")),"^",$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1)
 K ^TMP("PXRMGEC",$J)
 S ZTREQ="@"
 Q
DR ;by Date Range
 N CAT,HF,DATE,DFN,Y,HFN,CNTREF,DIF,DIFF,PAGE,I
 D E^PXRMGECV("HS1",INC,BDT,EDT,$S(INC=1:"F",1:"S"),DFNONLY)
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 W @IOF
 F I=1:1:78 W "="
 ;==
 W !,"Complete GEC Referrals by Date Range"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,$S(INC=0:"Incomplete",INC=1:"Complete",INC=2:"Complete and Incomplete",1:"")_" Referrals"
 I FOR W !,"Patient"
 I INC=1 I FOR W !,?5,"Start Date",?20,"",?35,"Elapsed Time"
 E  I FOR W !,?5,"Start Date",?20,"Finished",?35,"Elapsed Time",?50,"Incomplete Status",!
 I 'FOR W !,"Patient^SSN^Count^Start Date^Finished Date^Status",!
 F I=1:1:78 W "="
 ;==
 S PAGE=1
 S DFN="" F  S DFN=$O(^TMP("PXRMGEC",$J,"HS1",DFN)) Q:DFN=""  D
 .I FOR W ! D PAGE^PXRMGECZ
 .I FOR W !,$P(DFN," ",1,$L(DFN," ")-1)," ("_$P(DFN," ",$L(DFN," "))_")",?31,"Total= ",$G(^TMP("PXRMGEC",$J,"REFDFNN",$P(DFN," "))) D PAGE^PXRMGECZ
 .I FOR W ! D PAGE^PXRMGECZ
 .S CNTREF="" F  S CNTREF=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF)) Q:CNTREF=""  D
 ..S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE)) Q:DATE=""  D
 ...S VDT=0 F  S VDT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT)) Q:VDT=""  D
 ....S DIFF="" I VDT>0 S DIFF=$$FMDIFF^XLFDT(VDT,DATE,1)+1
 ....S DIF="" S DIF=$$FMDIFF^XLFDT(DT,DATE,1)+1
 ....I VDT["0000" I FOR W !,?5,$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1),?20,"",?35,$S(DIFF="":DIF_" Days",DIFF>0:DIFF_" Days",1:""),?50,$S(DIFF="":"Incomplete",1:"") D PAGE^PXRMGECZ
 ....E  I FOR W !,?5,$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1),?20,$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1),?35,$S(DIFF="":DIF_" Days",DIFF>0:DIFF_" Days",1:""),?50,$S(DIFF="":"Incomplete",1:"") D PAGE^PXRMGECZ
 ....I 'FOR W !,$P(DFN," ",1,$L(DFN," ")-1),"^",$P(DFN," ",$L(DFN," "))
 ....I 'FOR W "^",$G(^TMP("PXRMGEC",$J,"REFDFNN",$P(DFN," "))),"^",$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1),"^",$P($$FMTE^XLFDT(VDT,"5ZM"),"@",1),"^",$S(DIFF="":DIF,DIFF>0:DIFF,1:"") D PAGE^PXRMGECZ
 K ^TMP("PXRMGEC",$J)
 S ZTREQ="@"
 Q
HS1 ;By Patient
 N CAT,HF,DATE,DFN,Y,HFN,CNTREF,X,COMMENT,PAGE,DIV,NAME,DFNN,I
 D E^PXRMGECV("HS1",1,BDT,EDT,"F",DFNONLY)
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 W !
 F I=1:1:78 W "="
 ;==
 W !,"GEC Patient"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 I FOR W !,"Patient"
 I FOR W !," Category"
 I FOR W !,"    Health Factor",?44,"Value",?55,"Date of Evaluation",!
 I 'FOR W !,"Patient^SSN^Eval Count^Category^Health Factor^Value^Date of Evaluation",!
 F I=1:1:78 W "="
 ;==
 S PAGE=1,CNT=0
 S DFN="" F  S DFN=$O(^TMP("PXRMGEC",$J,"HS1",DFN)) Q:DFN=""  D
 .I FOR W ! D PAGE^PXRMGECZ
 .S NAME=$P(DFN," ",1,$L(DFN," ")-1)
 .S DFNN=$O(^DPT("B",NAME,0)) D
 ..Q:DFNN=""
 ..S STATUS=$S($D(^DPT(DFNN,.1)):"INPATIENT",1:"OUTPATIENT")
 ..S DIV=$$GET1^DIQ(2,DFNN,.19) I DIV="" S DIV="Unknown"
 .S CNT=CNT+1
 .I STATUS["IN" I FOR W !,CNT,") ",STATUS,", DIVISION:",DIV D PAGE^PXRMGECZ
 .I STATUS["OU" I FOR W !,CNT,") ",STATUS D PAGE^PXRMGECZ
 .I FOR W !,CNT,") ",$P(DFN," ",1,$L(DFN," ")-1),"  (",$P(DFN," ",$L(DFN," "))_")",?50,"Total Number of referrals: ",$G(^TMP("PXRMGEC",$J,"REFDFNN",$P(DFN," "))) D PAGE^PXRMGECZ
 .S CNTREF="" F  S CNTREF=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF)) Q:CNTREF=""  D
 ..I FOR W ! D PAGE^PXRMGECZ
 ..I FOR W !,"Next Referral" D PAGE^PXRMGECZ
 ..S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE)) Q:DATE=""  D
 ...S VDT=0 F  S VDT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT)) Q:VDT=""  D
 ....S CAT=0 F  S CAT=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT)) Q:CAT=""  D
 .....I FOR W !,?1,$P(CAT," ",3,6) D PAGE^PXRMGECZ
 .....S DATEV=0 F  S DATEV=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT,DATEV)) Q:DATEV=""  D
 ......S DA=0 F  S DA=$O(^TMP("PXRMGEC",$J,"HS1",DFN,CNTREF,DATE,VDT,CAT,DATEV,DA)) Q:DA=""  D
 .......S HFN=$$HFNAME(DA)
 .......I FOR W !,?4,$P(HFN,"^",1),?44,$P(HFN,"^",2),?55,$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1) D PAGE^PXRMGECZ
 .......S COMMENT=$G(^AUPNVHF(DA,811))
 .......I FOR I COMMENT'="" D COMQ^PXRMGECZ
 .......I 'FOR W !,$P(DFN," ",1,$L(DFN," ")-1),"^",$P(DFN," ",$L(DFN," "))
 .......I 'FOR W "^",$G(^TMP("PXRMGEC",$J,"REFDFNN",$P(DFN," "))),"^",$P(CAT," ",3,6),"^",$P(HFN,"^",1),"^",$P(HFN,"^",2),"^",$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1)
 K ^TMP("PXRMGEC",$J)
 S ZTREQ="@"
 D ^%ZISC
 Q
HFCD ;Health Factor Category Detailed
 N CAT,HF,DATE,DFN,DFN1,FOR,HFDA,COMMENT,PAGE,I
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 D E^PXRMGECV("HFCD",1,BDT,EDT,"F",DFNONLY)
 W !
 F I=1:1:78 W "="
 ;==
 W !,"GEC Health Factor Category Detailed Report"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 I FOR W !,"Category"
 I FOR W !,?2,"Patient Name"
 I FOR W !,?4,"Health Factors",?41,"Value",?47,"Date",!
 I 'FOR W !,"Category^Patient^SSN^Health Factor^Value^Date",!
 F I=1:1:78 W "="
 ;==
 S PAGE=1
 S CAT="" F  S CAT=$O(^TMP("PXRMGEC",$J,"HFCD",CAT)) Q:CAT=""  D
 .S DFN1=0
 .I FOR W !,$P(CAT," ",3,6) D PAGE^PXRMGECZ
 .S DFN=0 F  S DFN=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN)) Q:DFN=""  D
 ..S HF="" F  S HF=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN,HF)) Q:HF=""  D
 ...S DATE=0 F  S DATE=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN,HF,DATE)) Q:DATE=""  D
 ....I FOR I DFN'=DFN1 W ! D PAGE^PXRMGECZ
 ....I FOR I DFN'=DFN1 W !,?2,$P($G(^DPT(DFN,0)),"^",1)_" ("_$P($G(^DPT(DFN,0)),"^",9)_")"  W ! S DFN1=DFN D PAGE^PXRMGECZ
 ....S HFN=$$HFNAME(0,HF)
 ....S HFDA=$O(^TMP("PXRMGEC",$J,"HFCD",CAT,DFN,HF,DATE,0))
 ....I FOR W !,?4,$P(HFN,"^",1),?41,$P(HFN,"^",2),?47,$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1) D PAGE^PXRMGECZ
 ....S COMMENT=$G(^AUPNVHF(HFDA,811))
 ....I FOR I COMMENT'="" D COMQ^PXRMGECZ
 ....I 'FOR W !,$P(CAT," ",3,5),"^",$P($G(^DPT(DFN,0)),"^",1)_"^"_$P($G(^DPT(DFN,0)),"^",9),"^",$P(HFN,"^",1),"^",$P(HFN,"^",2),"^",$P($$FMTE^XLFDT(DATE,"5ZM"),"@",1) D PAGE^PXRMGECZ
 K ^TMP("PXRMGEC",$J)
 S ZTREQ="@"
 D ^%ZISC
 Q
DFN2 ;By Provider Report
 N DFN,DOCT,DIADA,DATEV,FLAG,REF,DFN1,PAGE,I
 S REF="^TMP(""PXRMGEC"",$J)",DFN1=0
 I FORMAT="D" S FOR=0
 I FORMAT="F" S FOR=1
 W @IOF
 F I=1:1:78 W "="
 ;==
 W !,"GEC Provider"
 W !,"From: "_$$FMTE^XLFDT(BDT,"5ZM")_" To: "_$$FMTE^XLFDT(EDT,"5ZM")
 W !,"Report Displays Counts of Complete Referrals Only"
 I FOR W !,"Provider"
 I FOR W !,"  Patient",?17,"Completion Date",?41,"Dialog",!
 I 'FOR W !,"Provider^IEN^Patient^SSN^Dialog^Completion Date",!
 F I=1:1:78 W "="
 ;==
 S PAGE=1
 D E^PXRMGECV("DFN",1,BDT,EDT,"F",0)
 S DOCT=0 F  S DOCT=$O(@REF@("DFN",DOCT)),FLAG=1 Q:DOCT=""  D
 .I PROV>0&('$D(PROVARY(DOCT))) Q
 .I FOR W:FLAG=1 !!,$$GET1^DIQ(200,DOCT,.01)_" ("_DOCT_")" D PAGE^PXRMGECZ
 .S DFN=0 F  S DFN=$O(@REF@("DFN",DOCT,DFN)) Q:DFN=""  D
 ..S DATEV=0 F  S DATEV=$O(@REF@("DFN",DOCT,DFN,DATEV)) Q:DATEV=""  D
 ...S DIADA=0 F  S DIADA=$O(@REF@("DFN",DOCT,DFN,DATEV,DIADA)) Q:DIADA=""  D
 ....I FOR W !,?2,$S(DFN'=DFN1!(FLAG=1):$P($G(^DPT(DFN,0)),"^",1)_" ("_$P($G(^DPT(DFN,0)),"^",9)_")"_" ("_$$CNT^PXRMGECL(DOCT,DFN)_" Evaluation(s) )",1:"") D PAGE^PXRMGECZ
 ....I FOR I DFN'=DFN1!(FLAG=1) W ! D PAGE^PXRMGECZ
 ....S FLAG=0
 ....W ?17,$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1,2),?41,$P($P($G(^PXRMD(801.41,DIADA,0)),"^",1)," ",3,6)
 ....S DFN1=DFN
 ....I 'FOR W !,$$GET1^DIQ(200,DOCT,.01),"^",DOCT,"^",$P($G(^DPT(DFN,0)),"^",1),"^",$P($G(^DPT(DFN,0)),"^",9)
 ....I 'FOR W "^",$P($P($G(^PXRMD(801.41,DIADA,0)),"^",1)," ",3,6),"^",$P($$FMTE^XLFDT(DATEV,"5ZM"),"@",1) D PAGE^PXRMGECZ
 K ^TMP("PXRMGEC",$J)
 S ZTREQ="@"
 Q
 ;
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
 S RESULT="^"
 S REF="YESNOSTAGE 1STAGE 2STAGE 3STAGE4"
 S REF2="12"
 S FIRST=$P(WHOLE,"-",1,$L(WHOLE,"-")-1)
 S SECOND=$P(WHOLE,"-",$L(WHOLE,"-"))
 I REF[SECOND S RESULT=FIRST_"^"_SECOND
 E  S RESULT=WHOLE_"^"
 I REF2[SECOND S RESULT=WHOLE_"^"
 Q RESULT
 ;
