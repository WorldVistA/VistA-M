IBARXEC1 ;ALB/AAS - RX CO-PAY EXEMPTION REPORT GENERATOR ; 04-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% ;
START ; -- entry point for running conversion report from option
 D HOME^%ZIS W @IOF,?15,"Medication Copayment Charges Retroactively Canceled",!!
 ;
 I '$P(^IBE(350.9,1,3),"^",14) W !!,"This report cannot be run until the conversion has completed." G END
 ;
BDT ;  -get beginning date
 S (IBBDT,IBEDT)=""
 S Y=$$STDATE^IBARXEU D D^DIQ S %DT("B")=Y
 S %DT="AEPX",%DT("A")="Start with DATE: " D ^%DT K %DT G END:Y<0 S IBBDT=Y
 K %DT W !
 ;
EDT ;  -get ending date
 S Y=$P($P(^IBE(350.9,1,3),"^",14),".") D D^DIQ S %DT("B")=Y
 S %DT="APEX",%DT("A")="Go to DATE: " D ^%DT G END:Y<0 S IBEDT=Y I Y<IBBDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G BDT
 K %DT W !
 ;
 S DIR("A")="Print Conversion Quick Status Report with listing",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT) END S IBQUIC=Y
 ;
DEV W !!,"You will need a 132 column printer for this report!",!
 S %ZIS="QM" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="REPORT^IBARXEC1",ZTSAVE("IB*")="",ZTDESC="IB Medication Copayment Exemption Conversion Report" D ^%ZTLOAD K ZTSK D HOME^%ZIS G END
 ;
REPORT ; -- run report for conversion
 I $D(IBCONVER) D
 .D QUIC
 .Q:IO'=IO(0)
 .I '$D(ZTQUEUED) W !!,"Please wait while I compile the report by patient...."
 .W !!,"This report can be re-run by re-running the conversion",!,"or using the option provided."
 .S IBBDT=$$STDATE^IBARXEU
 .S IBEDT=$P(^IBE(350.9,1,3),"^",14)
 .Q
 ;
 U IO
 Q:'$P(^IBE(350.9,1,3),"^",14)
 ;
 S IBQUIT=0
 I $G(IBQUIC)=1 D QUIC
 D BUILD^IBARXEC4
 D PRINT^IBARXEC5
 ;
END K ^TMP("IBCONV",$J)
 I $D(ZTQUEUED) S ZTREQ="@" Q
 K N,N1,O,O1,X,X1,X2,Y,DFN,IBAMT,IBBCNT,IBBDT,IBDT,IBEDT,IBJ,IBN,IBNAM,IBOK,IBP,IBPAG,IBCNT,IBPDAT,IBPCNT,IBQUIC,IBTAMT,IBTCNT,IBX
 D END^IBARXEC
 Q
 ;
QUIC ; -- quick summary
 I '$D(IOF) D HOME^%ZIS
 N IBX,X,X1,X2,X3,Y
 S IBX=$G(^IBE(350.9,1,3)),X3=10
 ;
 W @IOF,?20,"Medication Copayment Exemption Conversion Status"
 I '$P(IBX,"^",3),'$P(IBX,"^",13) W !!,"Conversion has not been started" Q
 I $P(IBX,"^",3)>1 W !!,"The conversion has been started ",$P(IBX,"^",3)," times"
 I $P(IBX,"^",13) W !!,"Conversion was started on:   " S Y=$P(IBX,"^",13) D DT^DIQ
 I $P(IBX,"^",14) W !,"The conversion completed on: " S Y=$P(IBX,"^",14) D DT^DIQ,ELAP W !,Y
 W !!,"                 Last Patient DFN Checked  ==  ",$J(+$P(IBX,"^",4),10)
 W !!,"  1.                Total Patients Checked  ==  " S X=+$P(IBX,"^",5),X2=0 D COMMA^%DTC W X
 W !,"                           Exempt Patients  ==  " S X=+$P(IBX,"^",6),X2=0 D COMMA^%DTC W X
 W !,"                       Non-Exempt Patients  ==  " S X=+$P(IBX,"^",7),X2=0 D COMMA^%DTC W X
 W !!,"  2.  Total Number of Rx Charges checked    ==  " S X=+$P(IBX,"^",16),X2=0 D COMMA^%DTC W X
 W !,"                     Dollar Amount Checked  ==  " S X=+$P(IBX,"^",9),X2="0$" D COMMA^%DTC W X
 W !,"          No. of Exempt Rx Charges Checked  ==  " S X=+$P(IBX,"^",8),X2=0 D COMMA^%DTC W X
 W !,"                      Exempt Dollar amount  ==  " S X=+$P(IBX,"^",10),X2="0$" D COMMA^%DTC W X
 W !,"      No. of Non-Exempt Rx Charges Checked  ==  " S X=+$P(IBX,"^",15),X2=0 D COMMA^%DTC W X
 W !,"                  Non-exempt Dollar amount  ==  " S X=+$P(IBX,"^",11),X2="0$" D COMMA^%DTC W X
 W !!,"  3.    Total Rx Charges Actually canceled  ==  " S X=+$P(IBX,"^",17),X2=0 D COMMA^%DTC W X
 W !,"                  Amount Actually canceled  ==  " S X=+$P(IBX,"^",12),X2="0$" D COMMA^%DTC W X
QUICQ Q
 ;
ELAP ; -- calcualate elaplse running time
 N X,IBBDT,IBEDT,IBDAY
 S X=$P(IBX,"^",13) D H^%DTC S IBBDT=%H_","_%T
 S X=$P(IBX,"^",14) D H^%DTC S IBEDT=%H_","_%T
 S IBDAY=+IBEDT-(+IBBDT)*86400 S X=IBDAY+$P(IBEDT,",",2)-$P(IBBDT,",",2) S Y="Elapsed time for Conversion was: "_(X\3600)_" Hours,  "_(X\60-(X\3600*60))_" Minutes,  "_(X#60)_" Seconds"
 Q
