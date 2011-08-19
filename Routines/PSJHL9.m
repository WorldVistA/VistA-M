PSJHL9 ;BIR/LDT-VALIDATE INCOMING HL7 DATA/CREATE NEW ORDER ;08 Jul 99 / 10:50 AM
 ;;5.0; INPATIENT MEDICATIONS ;**1,18,31,42,47,50,63,72,75,58,80,110,111,134**;16 DEC 97;Build 124
 ;
 ; Reference to ^PSDRUG is supported by DBIA# 2192.
 ; Reference to ^PS(50.7 is supported by DBIA# 2180.
 ; Reference to ^PS(51.2 is supported by DBIA# 2178.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^ORERR is supported by DBIA# 2187.
 ; Reference to ^ORHLESC is supported by DBIA# 4922.
 ;
VALID ;
 I APPL="",PSITEM="" S PSREASON="Missing or invalid Orderable Item" D ERROR Q
 I PSITEM]"",'$D(^PS(50.7,+PSITEM,0)) S PSREASON="Missing or invalid Orderable Item" D ERROR Q
 I $G(APPL)'["B",$G(APPL)'["A",+$G(ROUTE)'>0 S PSREASON="Missing or invalid Med Route" D ERROR Q
 S APPL=$S($G(APPL)["B":"F",$G(APPL)["A":"F",$G(DISPENSE)]"":$$ORTYP(ROUTE,DISPENSE),1:$$TRYAGAIN(ROUTE,PSITEM))
 S:APPL="" APPL="IP"
 I APPL'="F" D
 .I $G(SCHEDULE)]"" N X S X=SCHEDULE D  S SCHEDULE=X
 ..I X[""""!($A(X)=45)!(X?.E1C.E)!($L(X," ")>3)!($L($P(X,"@"))>70)!($L($P(X,"@",2))>119)!($L(X)<1)!(X["P RN")!(X["PR N") S X="" Q
 ..I X?.E1L.E S X=$$ENLU^PSGMI(X)
 ..S X=$$TRIM^XLFSTR(X,"R"," ")
 ..I X["Q0" S X="" Q
 .I APPL["U",$G(SCHEDULE)="" S PSREASON="Missing or invalid schedule" D ERROR Q
 .N DFN S DFN=PSJHLDFN D IN5^VADPT I 'VAIP(5) D:APPT=""  I APPL="UN",APPT="" S PSREASON="Cannot place Unit Dose orders for an Outpatient" D ERROR Q
 .. I APPL="UP" S APPL="IN" Q
 .. I APPL="IP" S APPL="IN" Q
 .I $G(ROC)'="R",$G(ROUTE)'>0 S PSREASON="Missing or invalid Med Route" D ERROR Q
 I APPL="F" D
 .I '$O(^TMP("PSJNVO",$J,"SOL",0))&('$O(^TMP("PSJNVO",$J,"AD",0))) S PSREASON="IV Fluid orders must have at least one additive or solution" D ERROR Q
 .I $G(IVCAT)="I",$G(INFRT)="" Q  ;Allow intermittent IV orders to have a null infusion rate.
 .I $G(INFRT)="" S PSREASON="Invalid Infusion Rate" D ERROR Q
 Q
 ;
ERROR ;Sends error msg to CPRS, logs error in OE/RR Errors file
 S X="ORERR" X ^%ZOSF("TEST") I  D EN^ORERR(PSREASON,.PSJMSG)
 D EN1^PSJHLERR(PSJHLDFN,$S(PSOC="XO":"UX",1:"OC"),$P(ORDER,U),PSREASON) S QFLG=1 K ^TMP("PSJNVO",$J)
 Q
 ;
NVO ; put new orders in non-verified orders file
 I '$D(ROUTE) S ROUTE=""
 I $G(ROUTE)="" S:APPL="F" ROUTE=$O(^PS(51.2,"B","INTRAVENOUS",0))
 N DA,DR,DIE D ENGNN^PSGOETO S DIE="^PS(53.1,"
 S DR="1////"_PROVIDER_";3////"_$$ESC^ORHLESC(ROUTE)_";4////"_$E(APPL)_";28////P"_";108////"_PSITEM_";27.1////"_LOGIN_";27////"_LOGIN_";.5////"_PSJHLDFN_";.24////"_PRIORITY_";125////"_$G(PRNTON)
 I $G(LOC)]"" S:$P($G(^SC(+LOC,0)),U,3)="C" DR=DR_";113////"_LOC_";126////"_$G(APPT)
 I $G(IVCAT)]"" S DR=DR_";128////"_IVCAT S ADMINS=""
 S:$G(SCHTYP)]"" DR=DR_";7////"_SCHTYP
 D ^DIE K PSJHLSKP S NEWORDER=DA,PSJORDER=DA_"P"
 S $P(^PS(55,PSJHLDFN,5.1),"^",2)=PROVIDER
 S:$G(ORDER)]"" $P(^PS(53.1,DA,0),"^",21)=$P(ORDER,"^")
 S:$G(APPL)["P" $P(^PS(53.1,DA,0),"^",13)=1
 S $P(^PS(53.1,DA,0),"^",18)=DA
 S:$G(ROC)]"" $P(^PS(53.1,DA,0),"^",24)=ROC
 S:$G(PREON)]"" $P(^PS(53.1,DA,0),"^",25)=PREON
 S:$G(ADMINS) $P(^PS(53.1,DA,2),"^",5)=ADMINS
 S:$G(REQST)]"" $P(^PS(53.1,DA,2.5),"^")=REQST
 ; Transform duration units of doses to a for administrations
 S:$E(DURATION,1,5)="doses" DURATION=$TR(DURATION,"doses","a")
 S:$G(DURATION)]"" $P(^PS(53.1,DA,2.5),"^",2)=DURATION
 S:$G(IVLIMIT)]"" $P(^PS(53.1,DA,2.5),"^",4)=IVLIMIT
 I $G(REQST)]"",$G(DURATION)]"" S $P(^PS(53.1,DA,2.5),"^",3)=$$STOP(REQST,DURATION)
 S:$G(INSTR)]"" $P(^PS(53.1,DA,.3),"^")=INSTR
 I $G(INFRT)]"" D
 .I INFRT S:(INFRT["Minutes"!(INFRT["Hours")) INFRT="INFUSE OVER "_INFRT
 .S ^PS(53.1,DA,8)=IVTYP_"^^^^"_INFRT
 S:$G(FREQ)]"" $P(^PS(53.1,DA,2),"^",6)=FREQ
 S:$G(SCHTYP)]"" $P(^PS(53.1,DA,0),"^",7)=SCHTYP
 I $G(APPL)'="I" I $G(INSTR)]"" N X S X=INSTR D STRIP I $S(X?.E1C.E:0,$L(X)>60:0,X="":0,X["^":0,X?1.P:1,1:1) S $P(^PS(53.1,DA,.2),"^",2)=X,$P(^PS(53.1,DA,.2),"^",5,6)=$G(DOSE)_"^"_$$UNESC^ORHLESC($G(UNIT))
 S $P(^PS(53.1,DA,.2),"^",3)=ORDCON
 I $G(SCHEDULE)]"" S $P(^PS(53.1,DA,2),"^")=$$UNESC^ORHLESC(SCHEDULE)
 I $G(APPL)="I" I $G(UNITS)]"" S $P(^PS(53.1,DA,.3),"^")=$$UNESC^ORHLESC(UNITS)
 S ^PS(53.1,DA,4)="^^^^^^"_CLERK
 I $G(DISPENSE) S ^PS(53.1,DA,1,0)="^53.11P^1^1",^PS(53.1,DA,1,1,0)=DISPENSE_"^"_$$UNESC^ORHLESC(UNITS),^PS(53.1,DA,1,"B",$E(DISPENSE,1,30),1)=""
 I $D(PROCOM) D
 .I '$D(^PS(53.1,DA,12,0)) S ^(0)="^53.1012^0^0"
 .S JJ=0 F  S JJ=$O(PROCOM(JJ)) Q:'JJ  S $P(^PS(53.1,DA,12,0),"^",3,4)=JJ_"^"_JJ,^PS(53.1,DA,12,JJ,0)=$$UNESC^ORHLESC(PROCOM(JJ))
 I $D(ADMINSTR) D
 .I '$D(^PS(53.1,DA,3,0)) S ^(0)="^53.12^0^0"
 .S JJ=0 F  S JJ=$O(ADMINSTR(JJ)) Q:'JJ  S $P(^PS(53.1,DA,3,0),"^",3,4)=JJ_"^"_JJ,^PS(53.1,DA,3,JJ,0)=ADMINSTR(JJ)
 I $D(^TMP("PSJNVO",$J,"AD")) D
 .S ^PS(53.1,DA,"AD",0)="^53.157PA^0^0"
 .S JJ=0 F  S JJ=$O(^TMP("PSJNVO",$J,"AD",JJ)) Q:'JJ  S $P(^PS(53.1,DA,"AD",0),"^",3,4)=JJ_"^"_JJ,^PS(53.1,DA,"AD",JJ,0)=^TMP("PSJNVO",$J,"AD",JJ,0),^PS(53.1,DA,"AD","B",$$UNESC^ORHLESC($P(^TMP("PSJNVO",$J,"AD",JJ,0),"^")),JJ)=""
 I $D(^TMP("PSJNVO",$J,"SOL")) D
 .S ^PS(53.1,DA,"SOL",0)="^53.158PA^0^0"
 .S JJ=0 F  S JJ=$O(^TMP("PSJNVO",$J,"SOL",JJ)) Q:'JJ  S $P(^PS(53.1,DA,"SOL",0),"^",3,4)=JJ_"^"_JJ,^PS(53.1,DA,"SOL",JJ,0)=^TMP("PSJNVO",$J,"SOL",JJ,0),^PS(53.1,DA,"SOL","B",$P(^TMP("PSJNVO",$J,"SOL",JJ,0),"^"),JJ)=""
 I $O(^TMP("PSJNVO",$J,10,0)) D
 .S ^PS(53.1,DA,10,0)="^53.1112A^0^0"
 .S JJ=0 F  S JJ=$O(^TMP("PSJNVO",$J,10,JJ)) Q:'JJ  S $P(^PS(53.1,DA,10,0),"^",3,4)=JJ_"^"_JJ,^PS(53.1,DA,10,JJ,0)=$$UNESC^ORHLESC(^TMP("PSJNVO",$J,10,JJ,0)),^PS(53.1,DA,10,"B",$$UNESC^ORHLESC($E(^TMP("PSJNVO",$J,10,JJ,0),1,30)),JJ)="" D
 ..S ^PS(53.1,DA,10,JJ,1)=$P($G(^VA(200,+CLERK,0)),"^")
 ..I $O(^TMP("PSJNVO",$J,10,JJ,2,0)) S ^PS(53.1,DA,10,JJ,2,0)="^53.11122^0^0" D
 ...S QQ=0 F  S QQ=$O(^TMP("PSJNVO",$J,10,JJ,2,QQ)) Q:'QQ  S $P(^PS(53.1,DA,10,JJ,2,0),"^",3,4)=QQ_"^"_QQ,^PS(53.1,DA,10,JJ,2,QQ,0)=$$UNESC^ORHLESC(^TMP("PSJNVO",$J,10,JJ,2,QQ,0))
 Q
STRIP ;Strips spaces off the end of instructions.
 I $E(X,$L(X))=" " F  S X=$E(X,1,$L(X)-1) Q:$E(X,$L(X))'=" "
 Q
 ;
ORTYP(MDRT,DDRG)        ;Entry point to determine order type for 53.1
 ;MDRT=Med Route from 51.2, DDRG=Dispense Drug
 I '$G(DDRG) S ORTYP="" Q ORTYP
 I '$D(^PSDRUG(+DDRG,2)) S ORTYP="" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)'["I",$P(^PSDRUG(DDRG,2),"^",3)'["U" S ORTYP="" Q ORTYP
 I '$G(MDRT) S ORTYP="" Q ORTYP
 I '$D(^PS(51.2,+MDRT,0)) S ORTYP="" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["I",$P(^PSDRUG(DDRG,2),"^",3)'["U",$P(^PS(51.2,MDRT,0),"^",6)=1 S ORTYP="IN" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)'["I",$P(^PS(51.2,MDRT,0),"^",6)=1 S ORTYP="UP" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["I",$P(^PS(51.2,MDRT,0),"^",6)=1 S ORTYP="IP" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["I",$P(^PSDRUG(DDRG,2),"^",3)'["U",$P(^PS(51.2,MDRT,0),"^",6)'=1 S ORTYP="IP" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["U",$P(^PSDRUG(DDRG,2),"^",3)'["I",$P(^PS(51.2,MDRT,0),"^",6)'=1 S ORTYP="UN" Q ORTYP
 I $P(^PSDRUG(DDRG,2),"^",3)["U",$P(^PS(51.2,MDRT,0),"^",6)'=1 S ORTYP="UP" Q ORTYP
 S ORTYP="" Q ORTYP
 ;
TRYAGAIN(MDRT,OI)       ;
 ;MDRT=Med Route from 51.2, OI=Orderable Item
 N ORTYPI,ORTYPU,ORTYPP
 S ORTYP="",ORTYPI=0,ORTYPU=0,ORTYPP=0
 N DDRG S DDRG=0 F  S DDRG=$O(^PSDRUG("ASP",OI,DDRG)) Q:'DDRG  D 
 .I $G(^PSDRUG(DDRG,"I"))]"" Q:^PSDRUG(DDRG,"I")'>DT
 .S ORTYP=$$ORTYP(MDRT,DDRG)  D
 ..I ORTYP["I" S ORTYPI=ORTYPI+1
 ..I ORTYP["U" S ORTYPU=ORTYPU+1
 ..I ORTYP["P" S ORTYPP=ORTYPP+1
 S ORTYP=$S(ORTYPU>ORTYPI:"U",1:"I") S ORTYP=ORTYP_$S(ORTYPP>0:"P",1:"N")
 Q ORTYP
 ;
STOP(REQST,DURA)   ;
 ;REQST=Requested start date, DURA=Duration from CPRS
 I DURA["L",DURA?1A1".".N S DAYS=$$DAY($E(REQST,1,5)),DURA="H"_((DAYS*$P(DURA,"L",2))*24)
 I DURA["L",DURA?1A.1N.N1"."1N.N D  Q STOP
 .S NUM=$E(REQST,4,5)+$P($P(DURA,"."),"L",2),NUM=$S(NUM<10:"0"_NUM,NUM<13:NUM,1:$S((NUM-12)<10:"0"_(NUM-12),1:(NUM-12))),DATE=$E(REQST,1,3)_NUM
 .S DAYS=$$DAY(DATE),STOP=$$SCH^XLFDT($P($P(DURA,"."),"L",2)_"M",$P(REQST,"."))_"."_$P(REQST,".",2),DEL=$P($P(DURA,"L",2),"."),STOP=$$FMADD^XLFDT(STOP,"",((DAYS*$P(DURA,DEL,2))*24))
 I DURA["L" S STOP=$P($$SCH^XLFDT($P(DURA,"L",2)_"M",$P(REQST,".")),".")_"."_$P(REQST,".",2) Q STOP
 I DURA["W",DURA["." S DURA="H"_(($P(DURA,"W",2)*7)*24)
 I DURA["D",DURA["." S DURA="H"_($P(DURA,"D",2)*24)
 I +DURA=DURA,DURA["." S DURA="H"_(DURA*24)
 S STOP=$$FMADD^XLFDT(REQST,$S(DURA["W":$P(DURA,"W",2)*7,DURA["D":$P(DURA,"D",2),+DURA=DURA:+DURA,1:""),$S(DURA["H":$P(DURA,"H",2),1:""),$S(DURA["M":$P(DURA,"M",2),1:""),$S(DURA["S":$P(DURA,"S",2),1:""))
 Q STOP
ZQDATE(DATE,MONTHS)  ;BUMP DATE BY A MONTH (OR SO)
 ;;
 S X=$E($P(DATE,"."),1,5)+($E($P(DATE,"."),4,5)>(12-MONTHS)*88+MONTHS)_$E($P(DATE,"."),6,7) F  D ^%DT Q:Y>0  S X=X-1
 S NEWDATE=X_"."_$P(DATE,".",2)
 Q NEWDATE
DAY(DATE) ;DATE=FIRST FIVE DIGITS OF FM DATE
 N X
 I DATE'?5N Q -1
 S X=$E(DATE,4,5) I X<1!(X>12) Q -1
 S X=DATE+1+(X=12*88)_"01"
 Q $E($$FMADD^XLFDT(X,-1),6,7)
