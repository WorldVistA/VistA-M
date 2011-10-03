SDPBP ; BP-IOFO/OWAIN ; Pharmacy Benefits Print. ;  ; Compiled November 13, 2003 09:55:19
 ;;5.3;Scheduling;**318**; SEP 29, 2003
 ;
EN0 ; Inquire date range.
 K %DT
 S %DT="AEX",%DT("A")="Appointment start date for report: "
 D ^%DT Q:Y=-1
 K %DT
 S (SDT,%DT(0))=Y K Y
 S %DT="AEX",%DT("A")="Appointment end date for report: "
 D ^%DT Q:Y=-1
 S EDT=Y
 S DIR("?",1)="Enter YES to show only summary totals.",DIR("?")="Enter NO to list patient level details as well."
 S DIR("A")="Summary?",DIR(0)="Y",DIR("B")="YES" D ^DIR
 K DIR
 Q:Y="^"
 S SDSUMM=Y
 D DEV
 Q
 ;
EN ;
 N SDCL,SDSS,NAME,DFN,INST,LINE,MAXLEN,PAGE,TODAY,CTR,SDCUTOFF,SDCUTOFD,TDAYS,TRSA
 D INIT(.SDSS)
 S (SDCL,CTR)=0,(SDCUTOFF,Y)=3031022 D DD^%DT S SDCUTOFD=Y
 D SCH^PSOTPCAN  ; Pharmacy call to generate ^TMP global of eligible patients.
 D NOW^%DTC S TODAY=X
 S NAME=""
 F  S NAME=$O(^TMP($J,"PSODFN",NAME)) Q:NAME=""  D
 .S DFN=0
 .F  S DFN=$O(^TMP($J,"PSODFN",NAME,DFN)) Q:+DFN'=DFN  D
 ..N SDAPDTT,SSN,SSNP,SEL,RESCHED
 ..D DEM^VADPT
 ..S (SSN,SSNP)="" S SSN=$P($G(VADM(2)),"^") I SSN["P" S SSNP="P",SSN=$E(SSN,1,9)  ; Social security number.
 ..Q:$E(SSN,1,5)="00000"  ; Exclude test patients.
 ..S SDAPDTT=$O(^DPT(DFN,"S",SDT),-1)
 ..F  S SDAPDTT=$O(^DPT(DFN,"S",SDAPDTT)) Q:+SDAPDTT'=SDAPDTT!(SDAPDTT>(EDT+.24))  D
 ...N SDAP0,SDCL0,SDCP,SDST,SDNAPDT,DAYS
 ...S SDAP0=^DPT(DFN,"S",SDAPDTT,0),SDCL=+SDAP0
 ...S SDCL0=$G(^SC(SDCL,0)) Q:'$L(SDCL0)  ; Get clinic 0 node.
 ...S SDCP=$$CPAIR(SDCL0)  ; Get DSS credit pair.
 ...Q:'$D(SDSS(SDCP))  ; Not a primary care appointment.
 ...S SDST=$P(SDAP0,U,2),SDCDTT=$P(SDAP0,U,14)
 ...S INST=$$DIV(SDCL0) 
 ...I 'INST S INST(0)="*NO INSTITUTION"
 ...E  S INST(INST)=$$GET1^DIQ(4,INST_",",.01)
 ...S RESCHED=$$RESCHED(DFN,SDAPDTT,SDCL,SDST,.SDNAPDT)
 ...I 'RESCHED S SEL(INST,SDAPDTT)=SDCL Q
 ...S:'$D(RESCHED(INST)) RESCHED(INST)=2
 ...S X1=SDNAPDT,X2=SDAPDTT D ^%DTC S DAYS=X
 ...S Y=SDAPDTT\1 D DD^%DT S SDAPDTT0=Y
 ...I SDNAPDT'="" S Y=SDNAPDT\1 D DD^%DT S SDNAPDT=Y
 ...S ^TMP($J,"SDOUT",INST(INST),"PT",NAME,DFN,SDAPDTT)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)_U_$$GET1^DIQ(44,SDCL_",",.01)_U_SDAPDTT0_U_$S($E(SDST)="N":"No-Show",1:"Canc by Patient")_U_SDNAPDT_U_DAYS
 ...Q:SDAPDTT<SDCUTOFF!(RESCHED=2)
 ...S RESCHED(INST)=1
 ...S ^TMP($J,"SDOUT",INST(INST),"CAN")=$G(^TMP($J,"SDOUT",INST(INST),"CAN"))+1
 ...S ^TMP($J,"SDOUT",INST(INST),"RSA")=$G(^TMP($J,"SDOUT",INST(INST),"RSA"))+1
 ...S ^TMP($J,"SDOUT",INST(INST),"DAYS")=$G(^TMP($J,"SDOUT",INST(INST),"DAYS"))+DAYS
 ...Q
 ..; For episodes that were not no-show or cancelled by patient, show the first 
 ..; future appointment or if there is not a future appointment the nearest 
 ..; previous appointment.
 ..S INST=""
 ..S SSN=SSN_SSNP
 ..F  S INST=$O(SEL(INST)) Q:INST=""  D:'$D(^TMP($J,"SDOUT",INST(INST),"PT",NAME,DFN))
 ...S SDAPDTT="" D
 ....S SDAPDTT1=$O(SEL(INST,TODAY))
 ....S SDAPDTT0=$O(SEL(INST,TODAY),-1)
 ....I SDAPDTT0="" S SDAPDTT=SDAPDTT1 Q
 ....I SDAPDTT1="" S SDAPDTT=SDAPDTT0 Q
 ....S X1=SDAPDTT0,X2=TODAY D ^%DTC S X0=X
 ....S X1=TODAY,X2=SDAPDTT1 D ^%DTC
 ....S SDAPDTT=$S(X0<X:SDAPDTT0,1:SDAPDTT1)
 ....Q
 ...I SDAPDTT'="" D
 ....S Y=SDAPDTT\1 D DD^%DT S SDNEAPT=Y
 ....S ^TMP($J,"SDOUT",INST(INST),"PT",NAME,DFN,SDAPDTT)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)_U_$$GET1^DIQ(44,SEL(INST,SDAPDTT)_",",.01)_U_U_U_SDNEAPT
 ....Q
 ...Q
 ..S INST=""
 ..F  S INST=$O(RESCHED(INST)) Q:INST=""  I RESCHED(INST)=1 S ^TMP($J,"SDOUT",INST(INST),"RSP")=$G(^TMP($J,"SDOUT",INST(INST),"RSP"))+1
 ..Q
 .Q
 ;
 S PAGE=0,(TDAYS,TRSA)=0
 I 'SDSUMM D
 .D HEAD10
 .I '$D(^TMP($J,"SDOUT")) W !!!?47,"********** NO DATA TO PRINT **********" Q
 .D HEAD20
 .S INSTX=""
 .F  S INSTX=$O(^TMP($J,"SDOUT",INSTX)) Q:INSTX=""  D  Q:CTR
 ..I LINE+5>IOSL D HEAD10 Q:CTR  D HEAD20
 ..W !!,"Institution : ",INSTX,! S LINE=LINE+3
 ..S NAME=""
 ..F  S NAME=$O(^TMP($J,"SDOUT",INSTX,"PT",NAME)) Q:NAME=""  D  Q:CTR
 ...S DFN=0
 ...F  S DFN=$O(^TMP($J,"SDOUT",INSTX,"PT",NAME,DFN)) Q:+DFN'=DFN  D
 ....S SDAPDT=0
 ....F  S SDAPDT=$O(^TMP($J,"SDOUT",INSTX,"PT",NAME,DFN,SDAPDT)) Q:+SDAPDT'=SDAPDT  D
 .....N REC
 .....S REC=^TMP($J,"SDOUT",INSTX,"PT",NAME,DFN,SDAPDT)
 .....I LINE+($P(REC,U,6)'="")+2>IOSL D HEAD10 Q:CTR  D HEAD20
 .....W !,$E(NAME,1,33),?38,$P(REC,U),?52,$E($P(REC,U,2),1,33),?89,$P(REC,U,3),?103,$P(REC,U,4),?120,$P(REC,U,5)
 .....S LINE=LINE+1
 .....I $P(REC,U,6)'="" W !?8,"Deferred Number of Days: ",$P(REC,U,6) S LINE=LINE+1
 .....Q
 ....Q
 ...Q
 ..I LINE+5>IOSL D HEAD10
 ..D HEAD21,SUMMARY
 ..Q
 .Q
 I SDSUMM D
 .N INSTX,X,CAN
 .D HEAD10,HEAD21
 .S (INSTX,X)=""
 .F  S INSTX=$O(^TMP($J,"SDOUT",INSTX)) Q:INSTX=""  S CAN=+$G(^TMP($J,"SDOUT",INSTX,"CAN")) D SUMMARY Q:CTR
 .I X="" W !!!?21,"********** NO DATA TO PRINT **********"
 .E  W !!,"Overall average time between appointments : ",$S(TRSA=0:$J(TDAYS,2),1:$J(TDAYS/TRSA,2))
 .Q
 ;
 K ^TMP($J,"PSODFN"),^TMP($J,"SDOUT")
 Q:CTR
 I $E(IOST)="C" S DIR(0)="E" D ^DIR
 Q
 ;
SUMMARY ;
 ; In - INSTX, IOSL
 ; Out - TRSA, TDAYS
 ;
 N RSA,DAYS
 S X=INSTX
 S RSA=+$G(^TMP($J,"SDOUT",INSTX,"RSA")),TRSA=TRSA+RSA
 S DAYS=+$G(^TMP($J,"SDOUT",INSTX,"DAYS")),TDAYS=TDAYS+DAYS
 I LINE+2>IOSL D HEAD10 Q:CTR  D HEAD21
 W !
 W:SDSUMM X,?9,INST
 W ?41,+$G(^TMP($J,"SDOUT",INSTX,"CAN"))
 W ?52,RSA
 W ?62,+$G(^TMP($J,"SDOUT",INSTX,"RSP"))
 W ?71,$S(RSA=0:"0.00",1:$J(DAYS/RSA,"",2))
 S LINE=LINE+1
 Q
 ;
BUILD(NAME,SSN,SDCL,SDST,SDCAPDTT,SDNEAPT) ;
 N DAYS,INST
 S DAYS=""
 I SDCAPDTT'="" D
 .S X1=SDNEAPT,X2=SDAPDTT D ^%DTC S DAYS=X
 .S Y=SDCAPDTT\1 D DD^%DT S SDCAPDTT=Y
 .Q
 I SDNEAPT'="" S Y=SDNEAPT\1 D DD^%DT S SDNEAPT=Y
 ; Get institution for 3rd node. 
 ; The patient names are already in alphabetical order so a numeric index is sufficient.
 S UNQ=$O(^TMP($J,"SDOUT",INST,"PT",NAME,":"),-1)+1
 S ^TMP($J,"SDOUT",INST,"PT",NAME,UNQ)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,10)_U_$$GET1^DIQ(44,SDCL_",",.01)_U_SDCAPDTT_U_$S(SDST="N":"No-Show",SDST="P":"Canc by Patient",1:"")_U_SDNEAPT_U_DAYS
 Q
 ;
RESCHED(DFN,SDAPDTT,SDCL,SDST,SDNAPDT) ; Search for a subsequent appointment at the same clinic.
 ; 0 - no rescheduled appointment
 ; 1 - cancelled by patient and rescheduled
 ; 2 - no-show and rescheduled
 N SDOK
 I SDST="NA"!(SDST="PCA") S SDNAPDT=$P(^DPT(DFN,"S",SDAPDTT,0),U,10) Q:SDNAPDT>SDAPDTT SDST="NA"+1
 Q:SDST'="N"&(SDST'="PC") 0
 S SDOK=0,SDNAPDT=""
 F  S SDAPDTT=$O(^DPT(DFN,"S",SDAPDTT)) Q:+SDAPDTT'=SDAPDTT  S SDOK=$P(^DPT(DFN,"S",SDAPDTT,0),U)=SDCL I SDOK S SDNAPDT=SDAPDTT Q
 Q (SDST="NA"+1)*SDOK
 ;
HEAD10 ;
 S PAGE=PAGE+1
 I PAGE>1,$E(IOST)="C" S DIR(0)="E" D ^DIR I $D(DIRUT) S CTR=1 Q
 S SDTTL="Transitional Pharmacy Benefit Deferred Appointment Report"
 I SDSUMM S SDTTL=SDTTL_" (Summary)"
 W @IOF,!?IOM-$L(SDTTL)\2,SDTTL
 I 'SDSUMM W ?122,"Page : "_PAGE
 S Y=SDT D DD^%DT
 S SDTTL="Report for the period of "_Y_" and "
 S Y=EDT D DD^%DT
 S SDTTL=SDTTL_Y
 W !?IOM-$L(SDTTL)\2,SDTTL
 W !
 S LINE=4
 Q
 ;
HEAD20 ;
 W !?89,"Cancelled",?103,"Reason for",?120,"New/Closest"
 W !,"Patient",?38,"SSN",?52,"Clinic",?89,"Appt. Date",?103,"Cancellation",?120,"Appt. Date"
 W !,"=======",?38,"===",?52,"======",?89,"==========",?103,"============",?120,"==========="
 S LINE=LINE+3
 Q
 ;
HEAD21 ;
 W !!
 W:'SDSUMM "Count for appts. after "_SDCUTOFD
 W ?41,"Appts",?52,"Appts",?62,"Patients",?71,"Ave time"
 W !
 W:SDSUMM "Institution"
 W ?41,"Cancelled",?52,"Deferred",?62,"Deferred",?71,"/appts"
 W !
 W:SDSUMM "==========="
 W ?41,"=========",?52,"========",?62,"========",?71,"========"
 S LINE=LINE+4
 Q
 ;
INIT(SDSS) ;
 N SDI,SDII
 F SDI=322,323,350 F SDII="000",185,186,187 S SDSS(SDI_SDII)=""
 K ^TMP($J,"SDOUT")
 Q
 ;
CPAIR(SDCL0)   ; Get credit pair
 ; Input: SDCL0=hospital location zeroeth node
 N SDX
 S SDX=$P($G(^DIC(40.7,+$P(SDCL0,U,7),0)),U,2)
 S SDX=SDX_$P($G(^DIC(40.7,+$P(SDCL0,U,18),0)),U,2)
 S SDX=$E(SDX_"000000",1,6)
 Q SDX
 ;
DIV(SDCL0) ;Get facility division name and number
 ;Input: SDCL0=hospital location zeroeth node
 N SDIVV,SDHOLD S SDIVV=$P(SDCL0,U,15)
 S SDHOLD=0
 I SDIVV>0 S SDHOLD=$P($$SITE^VASITE(,SDIVV),"^")
 I SDHOLD>0 Q SDHOLD
 S SDHOLD=$P(SDCL0,"^",4)
 I 'SDHOLD Q 0
 I SDHOLD,'$D(^DIC(4,SDHOLD,0)) S SDHOLD=0
 Q SDHOLD
 ;
DEV ;
 K %ZIS,IOP,POP,ZTSK S SDDIO=ION,%ZIS="QM" D ^%ZIS K %ZIS
 S IOM=$S(SDSUMM:80,1:132)
 I POP S IOP=SDDIO D ^%ZIS K IOP,SDDIO W !,"Please try later!" G END
 K SDDIO I $D(IO("Q")) K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK D  G END
 .S ZTRTN="EN^SDPBP",ZTDTH=$H,ZTDESC="TRANSITIONAL PHARMACY BENEFITS ELIGIBILITY PRINT"
 .S ZTSAVE("SDT")=""
 .S ZTSAVE("EDT")=""
 .S ZTSAVE("SDSUMM")=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!" K ZTSK
 .Q
 D EN
END ;
 W ! D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J)
 Q
