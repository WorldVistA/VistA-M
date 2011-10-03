IBCOPP ;ALB/NLR - LIST INS. PLANS BY CO. (DRIVER) ; 08-SEP-94
 ;;Version 2.0 ; INTEGRATED BILLING ;**28,62**; 21-MAR-94
 ;
EN ; Describe report 
 W !!?5,"This report will generate a list of insurance plans by company."
 W !?5,"It will help you identify duplicates and verify patient coverage."
 W !?5,"You must select one, many (up to 20) or all of the insurance companies;"
 W !?5,"anywhere from one to all of the plans under each company; and whether to"
 W !?5,"include the patient policies (subscribers) under each plan.  The number of"
 W !?5,"plans you select is independent for each company you are including, but"
 W !?5,"subscriber selection is the same (all or none) for all companies and"
 W !?5,"plans within a report.  Regardless of how you run the report, the"
 W !?5,"number of subscribers per plan will be included.",!!
 ;
 ; Prompt user to select report type, insurance companies, plans
 ;
 ; Output from user selections:
 ;
 ; IBAPA=0 -- list insurance plans by company
 ; IBAPA=1 -- list Insurance plans by company with subscriber information
 ; IBAI=0  -- user selects insurance companies
 ; IBAI=1  -- run report for all insurance companies with plans
 ; IBAPL=0 -- whether some or all ins. co's., user selects plans (may be
 ;            all for certain companies, some for other companies)
 ; IBAPL=1 -- whether some or all ins. co's., run report for all plans
 ;            associated with those co's.
 ;
 S IBAPA=$$SELR^IBCOPP1 I IBAPA<0 G ENQ
 S IBAI=$$SELI^IBCOPP1 I IBAI<0 G ENQ
 S IBAPL=$$SELP^IBCOPP1 I IBAPL<0 G ENQ
 ;
 ; obtain plans for selected insurance companies
 ;
 I IBAI,IBAPL G DEVICE
 D START I IBQUIT G ENQ
 I '$D(^TMP("IBINC",$J)) W !!,"No plans selected!" G ENQ
 ;
DEVICE ; Ask user to select device
 ;
 W !!,"*** You will need a 132 column printer for this report. ***",!
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="^IBCOPP2",ZTDESC="IB - LIST OF PLANS BY INSURANCE COMPANY"
 .F I="^TMP(""IBINC"",$J,","IBAPA","IBAI","IBAPL" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q")
 ;
 ; Compile and print report
 ;
 U IO D ^IBCOPP2
 ;
ENQ K DIRUT,DIROUT,DUOUT,DTOUT,IBAPA,IBAI,IBAPL,IBQUIT,X,Y,^TMP("IBINC",$J)
 Q
 ;
 ;
START ; Gather plans for all selected companies.
 S (IBCT,IBQUIT)=0 K ^TMP("IBINC",$J)
 ;
 ; - allow user selection of companies if required
 I 'IBAI D  I Y<0 S IBQUIT=1 G STARTQ
 .S DIC="^DIC(36,",DIC("S")="I $D(^IBA(355.3,""B"",Y))"
 .S VAUTSTR="insurance company",VAUTNI=2,VAUTVB="VAUTI",VAUTNALL=1
 .D FIRST^VAUTOMA K DIC,VAUTSTR,VAUTNI,VAUTVB,VAUTNALL Q:Y<0
 .S IBCNS="" F  S IBCNS=$O(VAUTI(IBCNS)) Q:IBCNS=""  S ^TMP("IBINC",$J,$E(VAUTI(IBCNS),1,25),IBCNS)=""
 I IBAPL G STARTQ
 ;
 ; - gather all companies if required
 I IBAI S A=0 F  S A=$O(^IBA(355.3,"B",A)) Q:'A  S ^TMP("IBINC",$J,$E($P($G(^DIC(36,A,0)),"^"),1,25),A)=""
 ;
 ; - gather plans for selected companies
 S IBIC="" F  S IBIC=$O(^TMP("IBINC",$J,IBIC)) Q:IBIC=""!IBQUIT  D
 .S IBCNS="" F  S IBCNS=$O(^TMP("IBINC",$J,IBIC,IBCNS)) Q:IBCNS=""!(IBQUIT)  D
 ..S IBCT=IBCT+1 W !!,"Insurance Company # "_IBCT_": "_IBIC
 ..D OK^IBCNSM3 Q:IBQUIT  I 'IBOK K ^TMP("IBINC",$J,IBIC,IBCNS) S IBAI=0 Q
 ..W "   ...building a list of plans..."
 ..K IBSEL,^TMP($J,"IBSEL") D LKP^IBCNSU2(IBCNS,1,1,.IBSEL,0,1) Q:IBQUIT
 ..I '$O(^TMP($J,"IBSEL",0)) K ^TMP("IBINC",$J,IBIC,IBCNS) S IBAI=0 Q
 ..;
 ..; - set plans into an array
 ..S IBPN=0 F  S IBPN=$O(^TMP($J,"IBSEL",IBPN)) Q:'IBPN  S ^TMP("IBINC",$J,IBIC,IBCNS,IBPN)=""
 ;
STARTQ K IBCNS,IBIC,IBJJ,IBCT,IBLCT,IBOK,IBPN,IBSEL,VAUTI,VAUTP,^TMP($J,"IBSEL")
 Q
