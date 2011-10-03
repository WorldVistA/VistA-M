PSJHL4A ;BIR/RLW-CONTINUE DECODE HL7 /MESSSAGE FROM OE/RR ;16 Mar 99 / 4:55 PM
 ;;5.0;INPATIENT MEDICATIONS ;**105,111,154,170,159,134,197,226,263**;16 DEC 97;Build 51
 ;
 ; Reference to ^PS(52.6 is supported by DBIA# 1231.
 ; Reference to ^PS(52.7 is supported by DBIA# 2173.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ; Reference to ^PS(59.7 supported by DBIA #2181.
 ; Reference to ^ORHLESC is supported by DBIA# 4922.
 ; Reference to ^SC( is supported by DBIA# 10040.
 ; Reference to ^PS(51.1 is supported by DBIA# 2177.
 ; Reference to ^PS(50.7 is supported by DBIA #2180.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ;
RXC ; IV order
 N IVFL
 S APPL=FIELD(1)
 I APPL["B" S SOLCNT=SOLCNT+1,PTR=$P(FIELD(2),"^",4) Q:'PTR  S VOLUME=+FIELD(3)_" ML" D  I '$D(^TMP("PSJNVO",$J,"SOL",SOLCNT,0)) D SOLSRCH
 .S SOLUTION="" F  S SOLUTION=$O(^PS(52.7,"AOI",PTR,SOLUTION)) Q:'SOLUTION  S INACT=$G(^PS(52.7,SOLUTION,"I")) I 'INACT!(INACT>DT) I VOLUME=$P(^PS(52.7,SOLUTION,0),U,3) D
 ..S ^TMP("PSJNVO",$J,"SOL",0)=SOLCNT
 ..S ^TMP("PSJNVO",$J,"SOL",SOLCNT,0)=SOLUTION_"^"_VOLUME,TVOLUME=TVOLUME+(+VOLUME)
 I $G(INFRT)]"" S X=INFRT D ENI^PSJHLU S INFRT=$G(X)
 I APPL="A" S ADCNT=ADCNT+1,PTR=$P(FIELD(2),"^",4) Q:'PTR  S STRENGTH=$G(FIELD(3))_" "_$P($G(FIELD(4)),"^",5) D  I '$D(^TMP("PSJNVO",$J,"AD",ADCNT,0)) S PSREASON="Can't find matching additive" D ERROR^PSJHL9 Q
 .S ADDITIVE="" F  S ADDITIVE=$O(^PS(52.6,"AOI",PTR,ADDITIVE)) Q:'ADDITIVE  S INACT=$G(^PS(52.6,ADDITIVE,"I")),IVFL=$P($G(^(0)),"^",13) I 'INACT!(INACT>DT),IVFL'=0 Q:$G(^PS(52.6,ADDITIVE,0))']""  D  Q:ADDITIVE
 ..I $G(PSITEM)="" S PSITEM=PTR
 ..S ^TMP("PSJNVO",$J,"AD",0)=ADCNT
 ..;Store the bag data ("" = all bag, "S" = See comment, Numeric valure = bottle #)
 ..S ^TMP("PSJNVO",$J,"AD",ADCNT,0)=ADDITIVE_"^"_STRENGTH_"^"_$S($P($G(FIELD(5)),U)="S":"See Comments",('+$P($G(FIELD(5)),U)):"",1:$P($G(FIELD(5)),U))
 Q
 ;
RXO ;
 I $O(PSJMSG(II,0)) D
 .K SEGMENT
 .N KK,JJ,XX
 .S SEGMENT(1)=$G(PSJMSG(II))
 .S KK=1,JJ="" F  S JJ=$O(PSJMSG(II,JJ)) Q:'JJ  S KK=KK+1,SEGMENT(KK)=$G(PSJMSG(II,JJ))
 .S KK=1,JJ=0
 .F  Q:'$D(SEGMENT(KK))  D
 ..I SEGMENT(KK)["|" S FIELD(JJ)=$P(SEGMENT(KK),"|"),SEGMENT(KK)=$E(SEGMENT(KK),$L(FIELD(JJ))+2,$L(SEGMENT(KK))),JJ=JJ+1 Q
 ..I SEGMENT(KK)'["|" S FIELD(JJ)=SEGMENT(KK),KK=KK+1 Q:'$D(SEGMENT(KK))  D
 ...S XX=$P(SEGMENT(KK),"|"),SEGMENT(KK)=$E(SEGMENT(KK),$L(X)+2,$L(SEGMENT(KK))),FIELD(JJ)=FIELD(JJ)_XX,JJ=JJ+1
 S APPL="",PSITEM=$S($P(FIELD(1),"^",5)="IV":"",1:$P(FIELD(1),"^",4))
 S:$P(FIELD(1),"^",6)="ORD" PSITEM=""
 S:$P(FIELD(1),"^",5)="IV" IVTYP="A",SCHTYP="C",INFRT=$G(FIELD(2))
 S DISPENSE=$P($G(FIELD(10)),"^",4)
 S IVLIMIT=$P($G(PSJMSG(II)),"^",3)
 S:IVLIMIT["doses" IVLIMIT=$TR(IVLIMIT,"doses","a")
 Q
 ;
OBX ;
 S OBXFL=1,OCNARR=FIELD(5),OCPROV=CLERK,OCCNT=OCCNT+1
 S ^TMP("PSJNVO",$J,10,0)=OCCNT
 S ^TMP("PSJNVO",$J,10,OCCNT,0)=OCNARR
 S ^TMP("PSJNVO",$J,10,OCCNT,1)=$$UNESC^ORHLESC($P($G(^VA(200,+OCPROV,0)),"^"))
 Q
 ;
NTE ;
 S TEXT=$S((FIELD(1)=6)&('OBXFL):"PROCOM",(FIELD(1)=7)&('OBXFL):"ADMINSTR",1:"OCRSN")
 S @TEXT@(1)=$$UNESC^ORHLESC($G(FIELD(3)))
 S K=1,J="" F  S J=$O(PSJMSG(II,J)) Q:'J  S K=K+1,@TEXT@(K)=$G(PSJMSG(II,J))
 D:$D(OCRSN)
 .S QQ=0 F  S QQ=$O(OCRSN(QQ)) Q:'QQ  S ^TMP("PSJNVO",$J,10,OCCNT,2,QQ,0)=OCRSN(QQ)
 S OBXFL=0
 Q
 ;
ZRX ;
 N ND,ND2,CHK,FOLOR,STDT
 S PREON=$G(FIELD(1)),ROC=$G(FIELD(3)),IVCAT=$G(FIELD(6))
 S IVCAT=$S(",I,C,"[(","_IVCAT_","):IVCAT,1:"") S IVTYP=$S($G(PSGS0XT):"P",1:"A") S IVTYP=$S(IVCAT="I":"P",IVCAT="C":"A",1:$G(IVTYP))
 ; HD281238 - No longer checked for PREON before setting IVTYP
 S ND=$S((PREON["N")!(PREON["P"):$G(^PS(53.1,+PREON,0)),PREON["V":$G(^PS(55,PSJHLDFN,"IV",+PREON,0)),1:$G(^PS(55,PSJHLDFN,5,+PREON,0)))
 S ND2=$S((PREON["N")!(PREON["P"):$G(^PS(53.1,+PREON,2)),PREON["V":$G(^PS(55,PSJHLDFN,"IV",+PREON,2)),1:$G(^PS(55,PSJHLDFN,5,+PREON,2)))
 I 'ND I ROC'="N" S PSREASON="Invalid Pharmacy order number" D ERROR^PSJHL9 Q
 I ND I ROC="R" S FOLOR=$S(PREON["V":$P(ND2,U,6),1:$P(ND,U,26)) I FOLOR S PSREASON="Duplicate Renewal Request" D ERROR^PSJHL9 Q
 I ND I ROC="R" S CHK=$S(PREON["V":$P(ND,U,17),1:$P(ND,U,9)) I "AE"'[CHK S PSREASON="Pharmacy orders with a status of "_CHK_" may not be renewed" D ERROR^PSJHL9 Q
 I $G(CHK)="E" I PREON'["V" D NOW^%DTC S X1=+$E(%,1,12),X2=-4 D C^%DTC S STDT=$S(PREON["V":$P(ND,U,3),1:$P(ND2,U,4)) I STDT'>X S PSREASON="Pharmacy orders expired longer than 4 days may not be renewed" D ERROR^PSJHL9 Q
 I ND I ROC="E" S FOLOR=$S(PREON["V":$P(ND2,U,6),1:$P(ND,U,26)) I FOLOR S PSREASON="Pharmacy orders may only be edited ONCE" D ERROR^PSJHL9 Q
 I ND I ROC="E" S CHK=$S(PREON["V":$P(ND,U,17),1:$P(ND,U,9)) I "DEHO"[CHK N CHKRTN S CHKRTN=CHK_"^PSJHL6" D @CHKRTN S PSREASON=PSREASON_" orders may not be edited" D ERROR^PSJHL9 Q
 D:ROC'="R" VALID^PSJHL9 Q:QFLG
 I $G(PSITEM)="",$D(^TMP("PSJNVO",$J,"SOL",1,0)) S PSITEM=$P($G(^PS(52.7,+^TMP("PSJNVO",$J,"SOL",1,0),0)),"^",11)
 I PRIORITY="ZD" D VALID^PSJHL10 S QFLG=1 Q
 I (PREON]"")&(ROC="E") D EDITCK^PSJHL5 Q:QFLG
 D NVO^PSJHL9
 I (PREON]"")&(ROC="R") D RENEW^PSJHL7 Q
 I (PREON]"")&(ROC="E") D EDIT^PSJHL5
 Q
 ;
SOLSRCH ;Find solution
 N SSSS,SEG,ON,ROC,SOL,SOL2
 F SSSS=II:0 S SSSS=$O(PSJMSG(SSSS)) Q:'SSSS  I $P(PSJMSG(SSSS),"|")="ZRX" D  Q
 .S SEG=$G(PSJMSG(SSSS)),ON=$P(SEG,"|",2),ROC=$P(SEG,"|",4)
 I $G(ROC)'="N" F SOL=0:0 S SOL=$O(^PS(55,PSJHLDFN,"IV",+ON,"SOL",SOL)) Q:'SOL  S SOL2=$G(^PS(55,PSJHLDFN,"IV",+ON,"SOL",SOL,0)) I $D(^PS(52.7,"AOI",PTR,+SOL2))&($P(SOL2,U,2)=VOLUME) S SOLUTION=+SOL2 D SET Q
 I 'SOLUTION S SOLUTION=$O(^PS(52.7,"AOI",PTR,SOLUTION)) D SET
 Q
SET ;Set solution tmp nodes
 Q:'+SOLUTION
 S ^TMP("PSJNVO",$J,"SOL",0)=SOLCNT
 S ^TMP("PSJNVO",$J,"SOL",SOLCNT,0)=SOLUTION_"^"_VOLUME,TVOLUME=TVOLUME+(+VOLUME)
 Q
 ;
SNDTSTW(PRIO,PSJSCHED,WARD) ; Test to determine if mail message should be sent.
 N SNPRIO,SNSCHD,SNOPT
 S SNPRIO=$S(PRIO="S":"S",PRIO="A":"A",1:"R")
 S SNSCHD=$S(PSJSCHED="STAT":"S",PSJSCHED="NOW":"N",1:"R")
 S SNOPT=$P($G(^PS(59.6,WARD,0)),"^",32)
 S:SNOPT="" SNOPT=$P($G(^PS(59.7,1,27)),"^",1)
 Q:SNOPT="" 0
 Q:SNOPT[SNPRIO 0
 Q:SNOPT[SNSCHD 0
 Q 1
 ;
SNDTSTP(PRIO,PSJSCHED) ; Test to determine if mail message should be sent.
 N SNPRIO,SNSCHD,SNOPT
 S SNPRIO=$S(PRIO="S":"S",PRIO="A":"A",1:"R")
 S SNSCHD=$S(PSJSCHED="STAT":"S",PSJSCHED="NOW":"N",1:"R")
 S SNOPT=$P($G(^PS(59.7,1,27)),"^",1)
 Q:SNOPT="" 1
 Q:SNOPT[SNPRIO 0
 Q:SNOPT[SNSCHD 0
 Q 1
 ;
SNDTSTA(PRIO,PSJSCHED) ; Test to determine if mail message should be sent.
 N SNPRIO,SNSCHD,SNOPT
 S SNPRIO=$S(PRIO="S":"S",PRIO="A":"A",1:"R")
 S SNSCHD=$S(PSJSCHED="STAT":"S",PSJSCHED="NOW":"N",1:"R")
 S SNOPT=$P($G(^PS(59.7,1,27)),"^",2)
 S:SNOPT="" SNOPT=$P($G(^PS(59.7,1,27)),"^",1)
 Q:SNOPT="" 1
 Q:SNOPT[SNPRIO 0
 Q:SNOPT[SNSCHD 0
 Q 1
 ;
TMPAT(SCHEDULE) ; Extract admin times from schedule in format schedule@schedule
 S TMPAT="" I SCHEDULE'["@" Q TMPAT
 S TMPAT=$P(SCHEDULE,"@",2) I TMPAT]"" D
 .N WARD S WARD=$G(^DPT(PSJHLDFN,.1)) I WARD]"" D
 ..N DIC,X,Y S DIC="^DIC(42,",DIC(0)="BOXZ",X=WARD D ^DIC S WARD=+Y Q:WARD=0
 ..S WARD=$O(^PS(59.6,"B",WARD,0))
 .I '$D(^PS(51.1,"AC","PSJ",TMPAT)) S TMPAT="" Q
 .N II I '$$DOW^PSIVUTL($P(SCHEDULE,"@")) S TMPAT="" Q
 .N TMPIEN S TMPIEN=$O(^PS(51.1,"AC","PSJ",TMPAT,0)),TMPAT=$P($G(^PS(51.1,+TMPIEN,0)),"^",2) D
 ..I $P($G(^PS(51.1,+TMPIEN,1,+$G(WARD),0)),"^",2) S TMPAT=$P($G(^(0)),"^",2)
 Q TMPAT
 ;
XMD ; Mailman call for NOTIFY^PSJHL4
 ; Input - PNAME  = Patient Name
 ;         RTE    = Route
 ;         DRUG   = Drug Name
 ;         WARD   = Ward Name
 ;         CLINIC = Clinic Location Name
 ;         PRIO   = CPRS Order Priority
 S PNAME=$P($G(^DPT(+PSJHLDFN,0)),"^") S:$G(RTE) RTE=$P(^PS(51.2,+RTE,0),"^",3)
 S DRUG=$S(DRIEN:$P($G(^PS(50.7,+DRIEN,0)),"^"),1:""),WARD=$G(^DPT(PSJHLDFN,.1))
 I $G(CLINIC)'="" S CLINIC=$P($G(^SC(CLINIC,0)),"^",2) I CLINIC'="" S WARD=CLINIC
 S XMDUZ="MEDICATIONS,INPATIENT",XMSUB=$G(WARD)
 S XMSUB=XMSUB_"-"_NTFSTAT_" "_$S($G(PRIO)="A":"ASAP",$G(PRIO)="S":"STAT",$G(NTFYREAS)=2:"NOW",$G(NTFYREAS)=3:"STAT",1:"")_"-"
 S XMSUB=XMSUB_$E(PNAME,1,65-$L(XMSUB))
 S XMTEXT="PSG("
 S PSG(1,0)="Inpatient Medications has received the following "_$S($G(PRIO)="A":"ASAP",$G(PRIO)="S":"STAT",$G(NTFYREAS)=2:"NOW",1:"")_" order ("_NTFSTAT_")"
 S PSG(2,0)=""
 S PSG(3,0)="          Patient:     "_PNAME I $G(LASTFOUR) S PSG(3,0)=PSG(3,0)_"  ("_LASTFOUR_")"
 S PSG(4,0)="Order Information:     "_DRUG_" "_DO_" "_RTE_" "_$G(PSJSCHED)
 S PSG(5,0)="       Order Date:     "_$$ENDTC^PSGMI(ORDATE)
 D ^XMD
 Q
