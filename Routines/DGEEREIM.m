DGEEREIM ;ALB/BRM;Reimbursable Primary Eligibility Code Report ; 5/23/05 11:04am
 ;;5.3;Registration;**672,706**;Aug 13,1993
 ;;
 ; This routine will identify and report any veteran who has a
 ; Reimbursable Insurance Primary Eligibility Code and who is not
 ; deceased.
 ;
QUETASK ; Queue the DMZ/Reimbursable Stats job
 N TXT,ZTRTN,ZTDESC,ZTSK,ZTIO,ZTDTH,POP,IO,IOBS,IOF,IOHG,IOM,ION,IOPAR
 N IOS,IOSL,IOST,IOT,IOUPAR,IOXY,%ZIS,ZTSAVE
 K ^TMP($J,"DGEEREIM")
 S %ZIS="QM" D ^%ZIS I $G(POP) W !,"Job Terminated!" Q
 I $D(IO("Q")) D  Q
 .S ZTRTN="LOOP^DGEEREIM",ZTDTH=$$NOW^XLFDT()
 .S ZTDESC="REIMBURSABLE INSURANCE PRIMARY ELIG CODE JOB"
 .D ^%ZTLOAD
 .S TXT=$S($G(ZTSK):"Task: "_ZTSK_" Queued.",1:"Error: Process not queued!")
 .D HOME^%ZIS
 .W !,TXT
 ;
LOOP ; entry point
 N QFLG,DFN,ELIG,QUIT,RCNT,RDT,ZZ
 N X,X1,X2,EC81,PRIMEC,%,CRT,DATA,DIRUT,EC8,LINE,NAME,PAGE
 ; get local codes assigned to the national Reimbursible code
 S EC8=$O(^DIC(8.1,"B","REIMBURSABLE INSURANCE",""))
 S EC81=""
 F  S EC81=$O(^DIC(8,"D",EC8,EC81)) Q:'EC81  S ELIG(EC81)=""
 ; loop through patient records
 S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .; quit if deceased
 .Q:$P($G(^DPT(DFN,.35)),"^")
 .;check for Primary EC of Reimbursable Insurance
 .S PRIMEC=$P($G(^DPT(DFN,.36)),"^"),EC81="",QFLG=0
 .F  S EC81=$O(ELIG(EC81)) Q:(QFLG!'EC81)  D
 ..Q:PRIMEC'=EC81
 ..S ^TMP($J,"DGEEREIM","RCNT")=$G(^TMP($J,"DGEEREIM","RCNT"))+1,QFLG=1
 ..S SSN=$P($G(^DPT(DFN,0)),"^",9),NAME=$P($G(^DPT(DFN,0)),"^")
 ..S ^TMP($J,"DGEEREIM","DATA",SSN)=NAME_"^"_$$EXTERNAL^DILFD(2,.361,"",PRIMEC)
 U IO
 D PSET,REPORT
 D ^%ZISC,HOME^%ZIS
 Q
PSET ; set up printer variables
 N ZZ
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 S (RDT,Y)=""
 F ZZ=1:1:IOM S $P(LINE,"-",ZZ)=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S RDT=$P(Y,"@",1)_" @ "_$P($P(Y,"@",2),":",1,2)
 S RCNT=+$G(^TMP($J,"DGEEREIM","RCNT"))
 Q
HDR ; Report Header
 W !,?((IOM-40)\2),"Reimbursable Insurance Primary EC Report"
 W !,?((IOM-22-$L(RDT))\2),"Date/Time Report Run: ",RDT
 W !!,?((IOM-35-$L(RCNT))\2),"Total Patients with RI Primary EC: ",RCNT
 W !,LINE
 W !!,?5,"SSN",?17,"NAME",?50,"PRIMARY ELIG. CODE"
 W !,?5,"---------",?17,"------------------------------"
 W ?50,"-------------------"
 Q
REPORT ;report results
 N SSN
 I CRT,+$G(PAGE)=0 W @IOF
 S PAGE=1 D HDR
 S SSN="" F  S SSN=$O(^TMP($J,"DGEEREIM","DATA",SSN)) Q:SSN']""!($G(QUIT))  D
 .S DATA=$G(^TMP($J,"DGEEREIM","DATA",SSN))
 .I $Y>(IOSL-5) W:'$G(CRT) !,?68,"Page: "_PAGE D:$G(CRT) PAUSE Q:$G(QUIT)  W @IOF D HDR S PAGE=PAGE+1
 .W !?5,SSN,?17,$P(DATA,"^"),?50,$P(DATA,"^",2)
 Q
 ;
PAUSE ;  Screen pause.  Sets QUIT=1 if user decides to quit.        
 N DIR,X,Y
 F  Q:$Y>(IOSL-5)  W !
 W !,?68,"Page: "_PAGE,!
 S DIR(0)="E" D ^DIR I ('(+Y))!$D(DIRUT) S QUIT=1
 Q
