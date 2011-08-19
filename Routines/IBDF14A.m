IBDF14A ;ALB/CJM - AICS LIST CLINIC SETUP ; JUL 20,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25**;APR 24, 1997
 ;
% ; -- entry point from ibdf14
 I '$D(VAUTD) G ^IBDF14
 D CLINICS,PRINT
 Q
 ;
CLINICS ; -- get a list of clinics with setups defined
 S CNT=0
 S CLINIC="" F  S CLINIC=$O(^SD(409.95,"B",CLINIC)) Q:'CLINIC  D
 .S SETUP=$O(^SD(409.95,"B",CLINIC,""))
 .S NAME=$P($G(^SC(CLINIC,0)),"^")
 .S DIVIS=$P($G(^SC(CLINIC,0)),"^",15)
 .I DIVIS="" S DIVIS=$S(MULTI=0:$$PRIM^VASITE,MULTI=1:"Unknown",1:1)
 .I 'VAUTD,'$D(VAUTD(DIVIS)) Q  ;if not all divisions or select div.
 .S:+DIVIS DIVIS=$P($G(^DG(40.8,+DIVIS,0)),"^")
 .I DIVIS="" S DIVIS="Unknown"
 .S:NAME]"" ^TMP($J,"IBCS",DIVIS,NAME)=CLINIC_"^"_SETUP,CNT(DIVIS)=$G(CNT(DIVIS))+1
 Q
 ;
PRINT ; -- Main print driver for output
 W:$E(IOST,1,2)="C-" @IOF
 S NEWDIV=0
 S DIVIS="" F  S DIVIS=$O(^TMP($J,"IBCS",DIVIS)) Q:DIVIS=""!IBQUIT  S NEWDIV=1 D
 .S NAME="" F  S NAME=$O(^TMP($J,"IBCS",DIVIS,NAME)) Q:NAME=""!IBQUIT  S CLINIC=+^(NAME),SETUP=$P(^(NAME),"^",2) D  Q:IBQUIT
 ..Q:'SETUP
 ..I $G(NEWDIV) D HEADER Q:IBQUIT  W !?9,"Division: ",DIVIS,! S NEWDIV=0
 ..I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 ..W !,"Clinic: ",NAME I '$$ACLN^IBDFCNOF(CLINIC) W "    (Clinic Currently Inactive)"
 ..D FORMS Q:IBQUIT
 ..D REPORTS Q:IBQUIT
 ..D EXCLUDE Q:IBQUIT
 ..W !
 .I 'VAUTD,$G(CNT(DIVIS))<1 D HEADER W !,"No clinics found for division '",DIVIS,"'",!
 I $E(IOST,1,2)="C-",'IBQUIT D PAUSE
 Q
 ;
FORMS ; -- prints the clinic's encounter forms to the report
 S NODE=$G(^SD(409.95,SETUP,0))
 I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 S FORM=$P(NODE,"^",2) I FORM W !,?5,"BASIC DEFAULT FORM:  ..........................",$P($G(^IBE(357,FORM,0)),"^")
 S FORM=$P(NODE,"^",5) I FORM W !,?5,"FORM WITH NO PRE-PRINTED PATIENT DATA:  .......",$P($G(^IBE(357,FORM,0)),"^")
 I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 S FORM=$P(NODE,"^",3) I FORM W !,?5,"SUPPLEMENTAL FORM - PATIENT WITH PRIOR VISITS: ",$P($G(^IBE(357,FORM,0)),"^")
 I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 S FORM=$P(NODE,"^",4) I FORM W !,?5,"SUPPLEMENTAL FORM - FIRST TIME PATIENT:  ......",$P($G(^IBE(357,FORM,0)),"^")
 I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 S FORM=$P(NODE,"^",6) I FORM W !,?5,"SUPPLEMENTAL FORM - ALL PATIENTS:  ............",$P($G(^IBE(357,FORM,0)),"^")
 I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 S FORM=$P(NODE,"^",8) I FORM W !,?5,"SUPPLEMENTAL FORM - ALL PATIENTS:  ............",$P($G(^IBE(357,FORM,0)),"^")
 I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 S FORM=$P(NODE,"^",9) I FORM W !,?5,"SUPPLEMENTAL FORM - ALL PATIENTS:  ............",$P($G(^IBE(357,FORM,0)),"^")
 I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 S FORM=$P(NODE,"^",7) I FORM W !,?5,"RESERVED FOR FUTURE USE:  .....................",$P($G(^IBE(357,FORM,0)),"^")
 Q
 ;
REPORTS ; -- prints the clinic's reports
 Q:'$O(^SD(409.95,SETUP,1,0))
 I ($Y>(IOSL-5)) D HEADER Q:IBQUIT
 W !!,?5,"REPORTS",?50,"PRINT CONDITION",!,?5,"=======",?50,"==============="
 S REPORT=0 F  S REPORT=$O(^SD(409.95,SETUP,1,REPORT)) Q:'REPORT  D  Q:IBQUIT
 .I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 .S NODE=$G(^SD(409.95,SETUP,1,REPORT,0))
 .S INTRFACE=$P(NODE,"^"),COND=$P(NODE,"^",2)
 .I INTRFACE,COND S INTRFACE=$P($G(^IBE(357.6,INTRFACE,0)),"^"),COND=$P($G(^IBE(357.92,COND,0)),"^") W:INTRFACE]"" !,?5,INTRFACE,?50,COND
 Q
 ;
EXCLUDE ; -- prints the division reports excluded from clinic
 Q:'$O(^SD(409.95,SETUP,2,0))
 I ($Y>(IOSL-5)) D HEADER Q:IBQUIT
 W !!,?5,"EXCLUDED REPORTS",!,?5,"================"
 S REPORT=0 F  S REPORT=$O(^SD(409.95,SETUP,2,REPORT)) Q:'REPORT  D  Q:IBQUIT
 .I ($Y>(IOSL-3)) D HEADER Q:IBQUIT
 .S NODE=$G(^SD(409.95,SETUP,2,REPORT,0))
 .S INTRFACE=$P(NODE,"^")
 .I INTRFACE S INTRFACE=$P($G(^IBE(357.6,INTRFACE,0)),"^") W:INTRFACE]"" !,?5,INTRFACE
 Q
 ;
HEADER ; -- writes the report header
 I $E(IOST,1,2)="C-",$Y>1,PAGE>1 D PAUSE Q:IBQUIT
 I PAGE>1 W @IOF
 W !,"AICS Print Manager Clinic Setup Report",?IOM-32,IBHDT,"   PAGE ",PAGE
 W !,"For Division: ",DIVIS
 W !,$TR($J(" ",IOM)," ","-")
 S PAGE=PAGE+1
 Q
 ;
PAUSE ; -- hold screen
 N DIR,X,Y
 F  Q:$Y>(IOSL-2)  W !
 S DIR(0)="E" D ^DIR S IBQUIT=$S(+Y:0,1:1)
 Q
