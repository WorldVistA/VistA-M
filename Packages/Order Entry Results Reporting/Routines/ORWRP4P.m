ORWRP4P  ; slc/dcm - OE/RR HDR Report Extract RPC's Outpatient Pharmacy ;9/21/05  13:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**215,243**;Dec 17, 1997;Build 242
PSO ;Outpatient RX for HDR
 N IFN,IFN1,IFN2,X,X1,X2,X3,X10,X16,X17,XIFN,ORX,COL,CODE,I1,CNT,%DT,Y,FAC,FACU
 K ^TMP("ORXS",$J)
 S IFN=""
 F  S IFN=$O(^XTMP(HANDLE,"D",IFN)) Q:IFN=""  S XIFN=^(IFN) D
 . S X16=$P(XIFN,"^",16),X17=$P(XIFN,"^",17),X2=$P(XIFN,"^",2),FACU=X17
 . I X17="",X16,X16'=200 S FACU=$O(^DIC(4,"D",X16,0)) I FACU S FACU=$P(^DIC(4,FACU,0),"^")
 . I '$L(FACU) S FACU=$S($L($P(XIFN,"^",2)):$P(XIFN,"^",2),1:"Unknown")
 . S $P(XIFN,"^",2)=FACU,X10=$P($P(XIFN,"^",10),":",1,2),X3=$P($P(XIFN,"^",3),"~",2)
 . I X3="" S X3=$P($P(XIFN,"^",4),"~",2) ;Get NDC name if Drug name not sent
 . I $L(X10),$L(X3) D
 .. S X10=9999999-$$SETDATE^ORWRP4(X10),^TMP("ORXS",$J,FACU,X10,X3,IFN)=XIFN
 K ^TMP("ORXS1",$J)
 S FAC="",CNT=-1
 F  S FAC=$O(^TMP("ORXS",$J,FAC)) Q:FAC=""  S IFN="" F  S IFN=$O(^TMP("ORXS",$J,FAC,IFN)) Q:IFN=""  D
 . S IFN1=""
 . F  S IFN1=$O(^TMP("ORXS",$J,FAC,IFN,IFN1)) Q:IFN1=""  S IFN2="" F  S IFN2=$O(^TMP("ORXS",$J,FAC,IFN,IFN1,IFN2)) Q:IFN2=""  S X=^(IFN2) D
 .. D XSET^ORWRP4("1^"_$P(X,"^",2)) ; Facility
 .. D XSET^ORWRP4("2^"_IFN1) ; Drug Name
 .. D XSET^ORWRP4("3^"_$P($P(X,"^",3),"~")) ; Drug IEN
 .. D XSET^ORWRP4("4^"_$P(X,"^",5)) ; RX # 
 .. D XSET^ORWRP4("5^"_$P($P(X,"^",6),"~",2)) ; Status
 .. D XSET^ORWRP4("6^"_$P(X,"^",7)) ; Qty
 .. S Y=$$SETDATE^ORWRP4($P(X,"^",9)) D XSET^ORWRP4("7^"_$$DATE^ORDVU(Y)) ; Exp/Canc Date
 .. S Y=$$SETDATE^ORWRP4($P(X,"^",10)) D XSET^ORWRP4("8^"_$$DATE^ORDVU(Y)) ; Issue Date
 .. S Y=$$SETDATE^ORWRP4($P(X,"^",11)) D XSET^ORWRP4("9^"_$$DATE^ORDVU(Y)) ; Last Fill Date
 .. D XSET^ORWRP4("10^"_$P(X,"^",12)) ; Refills
 .. D XSET^ORWRP4("11^"_$P(X,"^",13)) ; Provider
 .. D XSET^ORWRP4("12^"_$P(X,"^",14)) ; Cost/Fill
 .. D XSET^ORWRP4("13^"_$S($L($P(X,"^",15))>60:"[+]",1:"")) ; [+]
 .. D XSET^ORWRP4("14^"_$P(X,"^",15)) ; SIG
 K ^XTMP(HANDLE,"D") M ^XTMP(HANDLE,"D")=^TMP("ORXS1",$J) K ^TMP("ORXS",$J),^TMP("ORXS1",$J)
 Q
