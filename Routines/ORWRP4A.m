ORWRP4A  ; slc/dcm - OE/RR HDR Report Extract RPC's Allergies ;9/21/05  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215**;Dec 17, 1997
ADR ;Allergy code for HDR
 N IFN,IFN1,IFN2,X,X1,X2,X5,X6,X10,XIFN,ORX,COL,CODE,I1,CNT,%DT,FAC,FACU,NKA
 K ^TMP("ORXS",$J)
 S IFN=""
 F  S IFN=$O(^XTMP(HANDLE,"D",IFN)) Q:IFN=""  S XIFN=^(IFN),X6=$P(XIFN,"^",6),X5=$P($P(XIFN,"^",5),"~",2),X2=$S($L($P(XIFN,"^",2)):$P(XIFN,"^",2),1:"Unknown") D
 . I $P(XIFN,"^",3)'="EE",$L(X5),X5'="YES",X5'="NO",X6'="ASSESSMENT" S NKA(X2)=1
 S IFN=""
 F  S IFN=$O(^XTMP(HANDLE,"D",IFN)) Q:IFN=""  S XIFN=^(IFN) D
 . S X2=$P(XIFN,"^",2),FACU=X2
 . I X2?1N.N S FACU=$O(^DIC(4,"D",X2,0)) I FACU S FACU=$P(^DIC(4,FACU,0),"^")
 . I '$L(FACU) S FACU=$S($L($P(XIFN,"^",2)):$P(XIFN,"^",2),1:"Unknown")
 . S $P(XIFN,"^",2)=FACU,X10=$P($P(XIFN,"^",10),":",1,2),X6=$P(XIFN,"^",6),X5=$P($P(XIFN,"^",5),"~",2)
 . I $P(XIFN,"^",3)'="EE",$L(X5),X5'="YES",X5'="NO" D
 .. I X6="ASSESSMENT" S $P(XIFN,"^",10)="" I $G(NKA(X2)) Q
 .. S X10=9999999-$$SETDATE^ORWRP4(X10),^TMP("ORXS",$J,FACU,$S($L(X10):X10,1:9999999),X6,IFN)=XIFN
 K ^TMP("ORXS1",$J)
 S FAC="",CNT=-1
 F  S FAC=$O(^TMP("ORXS",$J,FAC)) Q:FAC=""  S IFN="" F  S IFN=$O(^TMP("ORXS",$J,FAC,IFN)) Q:IFN=""  D
 . S IFN1=""
 . F  S IFN1=$O(^TMP("ORXS",$J,FAC,IFN,IFN1)) Q:IFN1=""  S IFN2="" F  S IFN2=$O(^TMP("ORXS",$J,FAC,IFN,IFN1,IFN2)) Q:IFN2=""  S X=^(IFN2) D
 .. D XSET^ORWRP4("1^"_$P(X,"^",2)) ; Facility
 .. D XSET^ORWRP4("2^"_$S(IFN1="ASSESSMENT":"NKA",1:IFN1)) ; Allergy Reactant
 .. D XSET^ORWRP4("3^"_$P($P(X,"^",4),"~",2)) ; Allergy Type
 .. I $L($P(X,"^",10)) S X10=$$SETDATE^ORWRP4($P(X,"^",10)) D XSET^ORWRP4("4^"_$$DATE^ORDVU(X10))
 .. I '$L($P(X,"^",10)) D XSET^ORWRP4("4^"_$P(X,"^",10))
 .. D XSET^ORWRP4("5^"_$P($P(X,"^",11),"~",2)) ; Observed/Historical
 .. D COM^ORWRP4(6,$P(X,"^",12)) ;Comments
 K ^XTMP(HANDLE,"D") M ^XTMP(HANDLE,"D")=^TMP("ORXS1",$J) K ^TMP("ORXS",$J),^TMP("ORXS1",$J)
 Q
