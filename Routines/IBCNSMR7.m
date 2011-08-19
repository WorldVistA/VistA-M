IBCNSMR7 ;ALB/TJK - MRA EXTRACT ;2/20/01  9:55 AM ;2/14/01  10:25 AM
 ;;2.0;INTEGRATED BILLING;**146**;21-MAR-94
 ;Compiles MRA Extract data
DQ ; -- entry point from task manager
 N IBINSCO,DFN,DATACNT,SSN,PATNM,DOB,DIQ,DA,DIC,DR,ININSCON,INS,IBTR
 N IBINSCON,Y2 K ^TMP("IBCNSMR7",$J)
 ;Loop through list of insurance companies involved
 S IBINSCO=0
 F  S IBINSCO=$O(^IBE(350.9,1,99,"B",IBINSCO)) Q:'IBINSCO  D
    .S DIC=36,DA=IBINSCO,DR=.01,DIQ="INS(" D EN^DIQ1
    .S IBINSCON=INS(36,IBINSCO,.01) K INS
    .;Get subscribers for insurance company
    .S DFN=0 F  S DFN=$O(^DPT("AB",IBINSCO,DFN)) Q:'DFN  D
       ..; Gather patient infor
       ..D ^VADPT S PATNM=VADM(1),SSN=+VADM(2),DOB=$P(VADM(3),"^")
       ..K VADM
       ..N IBN,IBX,IBCNT,IBFLG,Y,Y1,CHG,TCHG,ARBILL,EVDATE,PAREVENT,NEV
       ..N IBCHDT
       ..S NEV="" F  S NEV=$O(^IB("AFDT",DFN,NEV)) Q:'NEV  I -NEV'>IBAEND S PAREVENT=0 F  S PAREVENT=$O(^IB("AFDT",DFN,NEV,PAREVENT)) Q:'PAREVENT  D
         ...S (TCHG,IBN,IBFLG,IBCNT,ARBILL)=0,EVDATE=-NEV
         ...S IBN=0 F  S IBN=$O(^IB("AF",PAREVENT,IBN)) Q:'IBN  D
            ....Q:'$D(^IB(IBN,0))  S IBX=^(0)
            ....Q:$P(IBX,"^",8)["ADMISSION"
            ....Q:$P(IBX,"^",10)
            ....Q:$P(IBX,"^",11)=""
            ....Q:$P(IBX,"^",17)<IBABEG
            ....N DIC,Y
            ....S DIC=430,X=$P(IBX,"^",11),DIC(0)="MZ" D ^DIC Q:'Y
            ....I ($P(Y(0),U,8)=39)!($P(Y(0),U,8)=26) Q
            ....S ARBILL=+Y
            ....Q:$D(^TMP("IBCNSMR7",$J,"BILL",ARBILL))
            ....S (Y,Y2)=0
            ....;check for valid insurance
             ....F  S Y=$O(^DPT(DFN,.312,"B",IBINSCO,Y)) Q:'Y  S Y1=$G(^DPT(DFN,.312,Y,0)),Y2=$$CHK^IBCNS1(Y1,EVDATE,2) Q:Y2
            ....Q:'Y2
            ....D TRANS
            ....Q
        ...Q
       ..Q
    .Q
 ;calls IBCSNMR8 to make .dat file and send completion message to user
 K ^TMP("IBCNSMR7",$J,"BILL") D ^IBCNSMR8
END K ^TMP("IBCNSMR7",$J)
 Q
TRANS ;
 N T1,T0,TRAN,TDATA,TTYPE,TAMT,TCNT,IBCHDT,PAYM,DATA,EVNO,TOTP,PDATE
 S (TRAN,TOTP)=0
 F  S TRAN=$O(^PRCA(433,"C",ARBILL,TRAN)) Q:'TRAN  D
    .S (IBCHDT,PDATE)=0
    .S T0=$G(^PRCA(433,TRAN,0)),T1=$G(^(1))
    .Q:$P(T0,"^",4)'=2
    .S TTYPE=$P(T1,"^",2)
    .S TAMT=$P(T1,"^",5)
    .I (TTYPE=2)!(TTYPE=34) S TOTP=TOTP+TAMT,PDATE=+T1
    .S EVNO=$O(^IB("AT",TRAN,0)) S:'EVNO IBX=""
    .I EVNO D
       ..S IBX=$G(^IB(EVNO,0))
       ..S IBCHDT=$P(IBX,"^",17),IBX=$P(IBX,"^")
       ..Q
    .I 'IBCHDT S IBCHDT=+T1
    .;sets data in global ^TMP("IBCNSMR7",$J,"DATA")
    .S DATACNT=$G(DATACNT)+1
    .S DATA=SITE_TRAN_"^"_PATNM_"^"_SSN_"^"_IBINSCON_"^"_$$DTCONV(IBCHDT)
    .S DATA=DATA_"^"_$J(TAMT,0,2)_"^"_$S(PDATE:$$DTCONV(PDATE),1:"")
    .S DATA=DATA_"^"_$S(PDATE:$J(TAMT,0,2),1:"")_"^"_$$DTCONV(DOB)_"^"_SITE
    .S DATA=DATA_"^"_$P(^PRCA(430,ARBILL,0),"^")_"^"_IBX
    .S DATA=DATA_"^"_$P(^PRCA(430.3,TTYPE,0),"^")_"^"
    .I '$O(^PRCA(433,"C",ARBILL,TRAN)) S DATA=DATA_$J(TOTP,0,2)
    .S ^TMP("IBCNSMR7",$J,"DATA",DATACNT)=DATA
    .Q
 S ^TMP("IBCNSMR7",$J,"BILL",ARBILL)=""
 Q
DTCONV(DATE)    ;Converts dates from Fileman to Oracle format
 N MON
 S MON=+$E(DATE,4,5),MON=$S(MON=1:"JAN",MON=2:"FEB",MON=3:"MAR",MON=4:"APR",MON=5:"MAY",MON=6:"JUN",MON=7:"JUL",MON=8:"AUG",MON=9:"SEP",MON=10:"OCT",MON=11:"NOV",1:"DEC")
 S DATE=$E(DATE,6,7)_"-"_MON_"-"_($E(DATE,1,3)+1700)
 Q DATE
