ORWRP4V ; slc/dcm - OE/RR HDR Report Extract RPC's Vitals;9/21/05  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,243**;Dec 17, 1997;Build 242
VS ;Vitals code for HDR
 N I,IFN,IFN1,IFN2,X,X1,X2,X4,X5,XIFN,ORX,COL,CODE,I1,CNT,%DT,FAC,FACU,NODE,QUALIF,METHOD,UNIT
 K ^TMP("ORXS",$J)
 S IFN=""
 F  S IFN=$O(^XTMP(HANDLE,"D",IFN)) Q:IFN=""  S XIFN=^(IFN) D
 . S X11=$P(XIFN,"^",11),X12=$P(XIFN,"^",12),X2=$P(XIFN,"^",2),FACU=X12
 . I X12="",X11,X11'=200 S FACU=$O(^DIC(4,"D",X11,0)) I FACU S FACU=$P(^DIC(4,FACU,0),"^")
 . I '$L(FACU) S FACU=$S($L($P(XIFN,"^",2)):$P(XIFN,"^",2),1:"Unknown")
 . S $P(XIFN,"^",2)=FACU,X4=$P($P(XIFN,"^",4),":",1,2),X5=$P($P(XIFN,"^",5),"~",2)
 . I $P(XIFN,"^",10)'="W",$L(X5) D
 .. S X4=9999999-$$SETDATE^ORWRP4(X4)
 .. I X4=9999999 F I=.01:.01 S X4=X4+I I '$D(^TMP("ORXS",$J,FACU,X4)) Q
 .. S ^TMP("ORXS",$J,FACU,X4)=$P(XIFN,"^",2),^TMP("ORXS",$J,FACU,X4,X5,IFN)=XIFN
 K ^TMP("ORXS1",$J),^TMP("ORXS2",$J)
 S FAC="",CNT=-1
 F  S FAC=$O(^TMP("ORXS",$J,FAC)) Q:FAC=""  S IFN="" F  S IFN=$O(^TMP("ORXS",$J,FAC,IFN)) Q:IFN=""  S NODE=^(IFN) D
 . D XVSET("1^"_$P(NODE,"^"),1,FAC,IFN,NODE) ;Facility
 . I $P(IFN,".")'=9999999 D XVSET("2^"_$$DATE^ORDVU(9999999-IFN),2,FAC,IFN,NODE) ; Measurement Date/Time
 . I $P(IFN,".")=9999999 D XVSET("2^"_" ",2,FAC,IFN,NODE) ; Measurement Date/Time = ""
 . S IFN1=""
 . F  S IFN1=$O(^TMP("ORXS",$J,FAC,IFN,IFN1)) Q:IFN1=""  S IFN2="" F  S IFN2=$O(^TMP("ORXS",$J,FAC,IFN,IFN1,IFN2)) Q:IFN2=""  S X=^(IFN2) D
 .. I $$UPPER^ORU(IFN1)="TEMPERATURE" D XVSET("3^"_$P(X,"^",6),3,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="PULSE" D XVSET("4^"_$P(X,"^",6),4,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="RESPIRATION" D XVSET("5^"_$P(X,"^",6),5,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="BLOOD PRESSURE" D XVSET("6^"_$P(X,"^",6),6,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="HEIGHT" D XVSET("7^"_$P(X,"^",6),7,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="WEIGHT" D XVSET("8^"_$P(X,"^",6),8,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="PAIN" D XVSET("9^"_$P(X,"^",6),9,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="PULSE OXIMETRY" D
 ... D XVSET("10^"_$P(X,"^",6),10,FAC,IFN,X) D METH(X)
 ... F I=1:1:2 D
 .... I $L($P(X,"^",13)),$P($P($P(X,"^",13),"|",I)," ",2)["l/min" D XVSET("13^"_$P($P($P(X,"^",13),"|",I)," "),13,FAC,IFN,X) ;Flow Rate
 .... I $L($P(X,"^",13)),$P($P($P(X,"^",13),"|",I)," ",2)["%" D XVSET("14^"_$P($P($P(X,"^",13),"|",I)," "),14,FAC,IFN,X) ;O2 Concentration
 .. I $$UPPER^ORU(IFN1)="CENTRAL VENOUS PRESSURE" D XVSET("11^"_$P(X,"^",6),11,FAC,IFN,X) D METH(X)
 .. I $$UPPER^ORU(IFN1)="CIRCUMFERENCE/GIRTH" D XVSET("12^"_$P(X,"^",6),12,FAC,IFN,X) D METH(X)
 S FAC=""
 F  S FAC=$O(^TMP("ORXS2",$J,"METH",FAC)) Q:FAC=""  S IFN="" F  S IFN=$O(^TMP("ORXS2",$J,"METH",FAC,IFN)) Q:IFN=""  S METHOD=^(IFN,1),DATA=^(0) D
 .I $L(METHOD) S X=METHOD D
 .. D XVSET("16^"_X,16,FAC,IFN,DATA) ;Methods
 S FAC=""
 F  S FAC=$O(^TMP("ORXS2",$J,"QUAL",FAC)) Q:FAC=""  S IFN="" F  S IFN=$O(^TMP("ORXS2",$J,"QUAL",FAC,IFN)) Q:IFN=""  S QUALIF=^(IFN,1),DATA=^(0) D
 .I $L(QUALIF) S X=QUALIF D
 .. D XVSET("15^"_X,15,FAC,IFN,DATA) ;Qualifiers
 S FAC=""
 F  S FAC=$O(^TMP("ORXS2",$J,"UNIT",FAC)) Q:FAC=""  S IFN="" F  S IFN=$O(^TMP("ORXS2",$J,"UNIT",FAC,IFN)) Q:IFN=""  S UNIT=^(IFN,1),DATA=^(0) D
 .I $L(UNIT) S X=UNIT D
 .. D XVSET("17^"_X,17,FAC,IFN,DATA) ;Units
 K ^XTMP(HANDLE,"D")
 S FAC="",CNT=-1
 F  S FAC=$O(^TMP("ORXS1",$J,FAC)) Q:FAC=""  S IFN="" F  S IFN=$O(^TMP("ORXS1",$J,FAC,IFN)) Q:IFN=""  S IFN1="" D
 . F  S IFN1=$O(^TMP("ORXS1",$J,FAC,IFN,IFN1)) Q:IFN1=""  S X=^(IFN1) D
 .. S CNT=CNT+1,^XTMP(HANDLE,"D",CNT)=X
 K ^TMP("ORXS",$J),^TMP("ORXS1",$J),^TMP("ORXS2",$J)
 Q
METH(DATA) ;Get Methods, Units & Qualifiers
 Q:'$D(DATA)
 N X,D,T
 S X=$P($P(DATA,"^",3),"~",2),D=$P($G(DATA),"^",4),T=$P($P(DATA,"^",5),"~",2)
 I $L(X),$L(T),$L(D) S METHOD=$G(^TMP("ORXS2",$J,"METH",FAC,IFN,1)),METHOD=$S($L(METHOD):METHOD_" | "_T_":",1:T_":")_X,^TMP("ORXS2",$J,"METH",FAC,IFN,1)=METHOD,^(0)=DATA
 S X=$P($P(DATA,"^",8),"~",2)
 I $L(X),$L(T),$L(D) S QUALIF=$G(^TMP("ORXS2",$J,"QUAL",FAC,IFN,1)),QUALIF=$S($L(QUALIF):QUALIF_" | "_T_":",1:T_":")_X,^TMP("ORXS2",$J,"QUAL",FAC,IFN,1)=QUALIF,^(0)=DATA
 S X=$P($P(DATA,"^",7),"~",2)
 I $L(X),$L(T),$L(D) S UNIT=$G(^TMP("ORXS2",$J,"UNIT",FAC,IFN,1)),UNIT=$S($L(UNIT):UNIT_" | "_T_":",1:T_":")_X,^TMP("ORXS2",$J,"UNIT",FAC,IFN,1)=UNIT,^(0)=DATA
 Q
XVSET(X,IFN,FAC,IDT,NODE) ;Setup Vitals nodes
 Q:'$D(X)  Q:'$L($G(IDT))
 N SAVE,OIDT
 S SAVE=X
 I '$L($G(IFN)) S CNT=CNT+1,^TMP("ORXS1",$J,IDT,FAC,CNT)=$$ESCP^ORWRP4(SAVE) Q
 I $D(^TMP("ORXS1",$J,IDT,FAC,IFN)) D  Q  ;Get data where item, facility, date/time are the same
 . S OIDT=IDT
 . F  S IDT=IDT+.0001 Q:'$D(^TMP("ORXS1",$J,IDT,IFN))
 . I '$D(^TMP("ORXS1",$J,IDT,FAC,IFN)) D
 .. S ^TMP("ORXS1",$J,IDT,FAC,1)=$$ESCP^ORWRP4("1^"_$P($G(NODE),"^",2)) ;Facility
 .. S ^TMP("ORXS1",$J,IDT,FAC,2)=$$ESCP^ORWRP4("2^"_$$DATE^ORDVU($$SETDATE^ORWRP4($P($G(NODE),"^",4)))) ;Date/Time
 . S ^TMP("ORXS1",$J,IDT,FAC,IFN)=$$ESCP^ORWRP4(SAVE),IDT=OIDT
 S ^TMP("ORXS1",$J,IDT,FAC,IFN)=$$ESCP^ORWRP4(SAVE)
 Q
