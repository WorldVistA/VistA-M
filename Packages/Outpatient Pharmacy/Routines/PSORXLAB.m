PSORXLAB ;BHAM ISC/SAB - drug+lab result print ; 11/19/92 14:04
 ;;7.0;OUTPATIENT PHARMACY;**29**;DEC 1997
 ;a routine which loop thru the last fill x-ref of ^psrx and gets
 ;patients with a specific drug. then gets the lrdfn from the 
 ;patient file and loops thru the patients lab data to find
 ;results within the date range you specify for the lab test
 ;used to minitor the drug. it then prints the patient's name
 ;ssn, last fill date, and the lab test results if any.
 ;this is intended as a qa minitor and should not be run for
 ;more than a 30 day fill date interval, or 1 year lab test interval.
 ;External ref. to ^LAB(60, is supp. by DBIA# 333
 ;External ref. to ^LR(LRDFN,"CH", is supp. by DBIA# 844
 ;External ref. to ^PSDRUG( is supp. by DBIA# 221
 ;External ref. to ^VA(200, is supp. by DBIA# 10060
ANQSITE K ^UTILITY("DIQ1",$J),DIQ S DA=$P($$SITE^VASITE(),"^")
 I $G(DA) D
 .S DIC=4,DIQ(0)="I",DR=".01;99" D EN^DIQ1
 .S SITE=$G(^UTILITY("DIQ1",$J,4,DA,.01,"I"))_" "_$G(^UTILITY("DIQ1",$J,4,DA,99,"I"))
 .K ^UTILITY("DIQ1",$J),DA,DR,DIQ,DIC
 S Y=DT X ^DD("DD") S SITE=$G(SITE)_" "_Y
BDATE S %DT="EXTA",%DT("A")="Beginning fill date: " D ^%DT G CLEAN:Y<0 S ANQBD=Y X ^DD("DD") S ANQBDR=Y
EDATE S %DT("A")="Ending last fill date: " D ^%DT G CLEAN:Y<0 S ANQED=Y X ^DD("DD") S ANQEDR=Y
LDATE S %DT("A")="Earliest date for lab results: " D ^%DT G CLEAN:Y<0 S LDATE=Y X ^DD("DD") S LDATER=Y
DRUG R !,"Enter the key word in the Drug Generic name: ",ANQDRUG:DTIME G CLEAN:'$T I "^"[ANQDRUG G CLEAN
 I $O(^PSDRUG("B",$E(ANQDRUG,1,$L(ANQDRUG)-1)))'[ANQDRUG W !,"No corresponding entry, try again or type return to exit" G DRUG
LABT S DIC="^LAB(60,",DIC(0)="QEAM" D ^DIC K DIC G:Y<0 CLEAN S ANQLBT=$P(Y,"^"),ANQLABTN=$P(Y,"^",2) G:ANQLBT="" CLEAN I $G(^LAB(60,ANQLBT,.2))']"" W !!,$C(7),"Data Name missing !!",! K Y,ANQLBT G LABT
 S ANQLABT=^LAB(60,ANQLBT,.2)
 W !,"Enter the specimen used in the lab for this test, serum,plasma,blood etc."
ANQSP S DIC="^LAB(61,",DIC(0)="QEAM" D ^DIC G:Y<0 CLEAN S ANQSP=$P(Y,"^") G:ANQSP="" CLEAN ;;I $P($G(^LAB(60,ANQLBT,1,ANQSP,0)),"^",7)']"" W !!,$C(7),"Specimen data missing !!",! ;K Y,ANQSP G ANQSP
ANQUNIT S ANQUNIT=$S($G(ANQSP)]"":$P($G(^LAB(60,ANQLBT,1,ANQSP,0)),"^",7),1:"")
ANQANS R !,"Do you want Rx info? N// ",ANQANS:DTIME G CLEAN:'$T S:ANQANS="" ANQANS="N" G:ANQANS="^" CLEAN2 I "YN"'[ANQANS W !,"ANSWER YES OR NO" G ANQANS
DEVICE K IOP S %ZIS="MQ" D ^%ZIS G:POP CLEAN2
 I $D(IO("Q")) K IO("Q") S ZTSAVE("*")="",ZTRTN="DQ^PSORXLAB",ZTDESC="LAB LIST" D ^%ZTLOAD K ZTSK G CLEAN
DQ S PSOLABQ=0 K ^TMP($J) S ANQBD=ANQBD-1,PAGE=0 U IO W @IOF D HDR
LOOP1 F J=0:0 S ANQBD=$O(^PSRX("AD",ANQBD)) Q:ANQBD=""!($G(PSOLABQ))  Q:ANQBD>ANQED  S ANQRX=0 D LOOP2
 G CLEAN
LOOP2 F J2=0:0 S ANQRX=$O(^PSRX("AD",ANQBD,ANQRX)) Q:ANQRX=""!($G(PSOLABQ))  D:$G(^PSRX(ANQRX,0))]"" CHECK1
 Q
CHECK1 S ANQDGN=+$P($G(^PSRX(ANQRX,0)),"^",6),ANQDRUGN=$P($G(^PSDRUG(ANQDGN,0)),"^")
 I ANQDRUGN'[ANQDRUG Q
 Q:'$P($G(^PSRX(ANQRX,0)),"^",4)  S ANQPROV=$P(^PSRX(ANQRX,0),"^",4),ANQPROVN=$P(^VA(200,ANQPROV,0),"^"),ANQPROT=$P(^VA(200,ANQPROV,0),"^",5)
 S ANQTYPE="NONE" I ANQPROT S ANQTYPE=$P("FULL TIME^PART TIME^C & A^FEE^STAFF","^",ANQPROT)
CHECK2 Q:'$P($G(^PSRX(ANQRX,0)),"^",2)
 S (DFN,ANQPT)=$P(^PSRX(ANQRX,0),"^",2) W ! D PID^VADPT,PRINT2
 I '$D(^DPT(ANQPT,"LR")) W ?55,"No lab data exists",?81,$E(ANQPROVN,1,20),?106,ANQTYPE,! D:ANQANS["Y" ANQRXI Q
 S LRDFN=$P(^DPT(ANQPT,"LR"),"^"),ANQLBENT=0,ANQINDIC=0
LOOP3 F J2=0:0 S ANQLBENT=$O(^LR(LRDFN,"CH",ANQLBENT)) Q:ANQLBENT=""!($G(PSOLABQ))  S ANQLDATE=$P(^LR(LRDFN,"CH",ANQLBENT,0),"^") Q:ANQLDATE<LDATE  D CHECK3
 I ANQINDIC=0 W ?55,"NO LAB DATA IN RANGE",?81,$E(ANQPROVN,1,20),?106,ANQTYPE,!
 D:ANQANS["Y" ANQRXI
 Q
CHECK3 I $D(^LR(LRDFN,"CH",ANQLBENT,ANQLABT)) D RESULT
 Q
RESULT Q:$P(^LR(LRDFN,"CH",ANQLBENT,0),"^",5)'=ANQSP  Q:'$P(^(0),"^",3)
 S Y=ANQLDATE X ^DD("DD") W ?55,$E(Y,1,11),?70,$P(^LR(LRDFN,"CH",ANQLBENT,ANQLABT),"^")_" "_ANQUNIT,?81,$E(ANQPROVN,1,20),?106,ANQTYPE W !
 S ANQINDIC=1 Q
 Q
PRINT2 I $Y>(IOSL-6) D  Q:$G(PSOLABQ)  W @IOF,SITE,! D HDR2
 .I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSOLABQ=1
 W ?1,$E($P(^DPT(ANQPT,0),"^"),1,20),?25,VA("PID") S Y=ANQBD X ^DD("DD") W ?43,Y Q
HDR W SITE,!!,"Patients receiving "_ANQDRUG_" with fills between "_ANQBDR_" and "_ANQEDR,!," with date of collection and results for lab test "_ANQLABTN_" after ",LDATER,!
HDR2 S PAGE=PAGE+1 W !,"Name",?25,"ID#",?43,"Fill Date",?55,"Lab Date",?71,"Results",?81,"Rx Provider",?106,"Type",?116,"Page "_PAGE,!
 F J=1:1:IOM-1 W "_"
 W ! Q
ANQRXI Q:$G(PSOLABQ)  W "Rx #: "_$P(^PSRX(ANQRX,0),"^")_"   Drug: "_$P(^PSDRUG(ANQDGN,0),"^")
 K FSIG,BSIG I $P($G(^PSRX(ANQRX,"SIG")),"^",2) D FSIG^PSOUTLA("R",ANQRX,72) F PSREV=1:1 Q:'$D(FSIG(PSREV))  S BSIG(PSREV)=FSIG(PSREV)
 K FSIG,PSREV I '$P($G(^PSRX(ANQRX,"SIG")),"^",2) D EN2^PSOUTLA1(ANQRX,72)
 W !?1,"Sig: ",$G(BSIG(1))
 I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  W !?6,$G(BSIG(PSREV))
 I $Y>(IOSL-6) D  Q:$G(PSOLABQ)  W @IOF,SITE,! D HDR2
 .I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSOLABQ=1
 W ! Q
CLEAN W @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
CLEAN2 K ANQINDIC,ANQPT,ANQLDATE,PAGE,ANQBD,ANQBDR,ANQLBENT,ANQLABT,ANQDGN,ANQDRUGN,ANQDRUG,J,J1,J2,ANQRX,ANQPROV,ANQPROVN,LDATE,LDATER,ANQED,ANQEDR,ANQPROT,ANQTYPE,ANQLABTN,ANQLBT,ANQSP,ANQUNIT,ANQANS,DIC,LRDFN,POP,SITE,Y,%DT,PSOLABQ
 K ZTDESC,ZTRTN,ZTSAVE,%ZIS Q
