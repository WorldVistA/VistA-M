PSJRXLAB ;ALB/RTW -  drug+lab result print ; 12/8/18 10:36am
 ;;5.0;INPATIENT MEDICATIONS;**327**;DEC 1997;Build 114
 ;RTW copied from routine PSORXLAB and modified for the Inpatient NCC Clozapine inpatient pharmacy project
 ;FSIG and FSIG2(formerly EN2), are brought in from PSOUTLA and PSOUTLA1 
 ;a routine which loop thru the last fill order of ^PS(55 and gets
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
PSJSITE K ^UTILITY("DIQ1",$J),DIQ,^TMP($J,"ORDERNUM") S DA=$P($$SITE^VASITE(),"^")
 N PSCNT S PSCNT=0
 I $G(DA) D
 .S DIC=4,DIQ(0)="I",DR=".01;99" D EN^DIQ1
 .S SITE=$G(^UTILITY("DIQ1",$J,4,DA,.01,"I"))_" "_$G(^UTILITY("DIQ1",$J,4,DA,99,"I"))
 .K ^UTILITY("DIQ1",$J),DA,DR,DIQ,DIC
 S Y=DT X ^DD("DD") S SITE=$G(SITE)_" "_Y
BDATE S %DT="EXTA",%DT("A")="Beginning fill date: " D ^%DT G CLEAN:Y<0 S PSJBD=Y X ^DD("DD") S PSJBDR=Y
EDATE S %DT("A")="Ending last fill date: " D ^%DT G CLEAN:Y<0 S PSJED=Y X ^DD("DD") S PSJEDR=Y
LDATE S %DT("A")="Earliest date for lab results: " D ^%DT G CLEAN:Y<0 S LDATE=Y X ^DD("DD") S LDATER=Y
DRUG R !,"Enter the key word in the Drug Generic name: ",PSJDRUG:DTIME G CLEAN:'$T I "^"[PSJDRUG G CLEAN
 N DRGARRAY D LIST^DIC(50,,.01,"I",,,$$UP^XLFSTR(PSJDRUG),"B",,,"DRGARRAY")
 I 'DRGARRAY("DILIST",0) W !,"No corresponding entry, try again or type return to exit" G DRUG
 S PSJDRUG=$$UP^XLFSTR(PSJDRUG)
LABT S DIC="^LAB(60,",DIC(0)="QEAM" D ^DIC K DIC G:Y<0 CLEAN S PSJLBT=$P(Y,"^"),PSJLABTN=$P(Y,"^",2) G:PSJLBT="" CLEAN
 ;I '$D(^LAB(60,PSJLBT,.2)) W !!,$C(7),"Data Name missing !!",! K Y,PSJLBT G LABT
 S PSJLABT=$$GET1^DIQ(60,PSJLBT,400,"I")
 W !,"Enter the specimen used in the lab for this test, serum, plasma, blood etc."
PSJSP S DIC="^LAB(61,",DIC(0)="QEAM" D ^DIC G:Y<0 CLEAN S PSJSP=$P(Y,"^") G:PSJSP="" CLEAN ;;I $P($G(^LAB(60,PSJLBT,1,PSJSP,0)),"^",7)']"" W !!,$C(7),"Specimen data missing !!",! ;K Y,PSJSP G PSJSP
PSJUNIT S PSJUNIT=$S($G(PSJSP)]"":$$GET1^DIQ(60.01,PSJSP_","_PSJLBT,6),1:"")
PSJANS R !,"Do you want Order info? N// ",PSJANS:DTIME G CLEAN:'$T S:PSJANS="" PSJANS="N" G:PSJANS="^" CLEAN2 I "YNyn"'[$E(PSJANS) W !,"ANSWER YES OR NO" G PSJANS
DEVICE K IOP S %ZIS="MQ" D ^%ZIS G:POP CLEAN2
 I $D(IO("Q")) K IO("Q") S ZTSAVE("*")="",ZTRTN="DQ^PSJRXLAB",ZTDESC="LAB LIST" D ^%ZTLOAD K ZTSK G CLEAN
DQ S PSJLABQ=0 S PSJBD=PSJBD-1,PAGE=0 U IO W @IOF D HDR
LOOP1 ;
 K ^TMP($J,"PSORDT") D LIST^DIC(100,"",.01,"I",,PSJBD,,"AD",,,"^TMP($J,""PSORDT"")")
 N PSJ F PSJ=1:1 Q:'$D(^TMP($J,"PSORDT","DILIST",1,PSJ))  S PSJBD=^TMP($J,"PSORDT","DILIST",1,PSJ) Q:PSJBD>PSJED  S PSJORDN=0 D LOOP2 Q:$G(PSJLABQ)
 G CLEAN
LOOP2 S PSJORDN=^TMP($J,"PSORDT","DILIST",2,PSJ) D CHECK1
 Q
CHECK1 ;
 N PSJNUM
 S PSJNUM=$$FIND1^DIC(100.045,","_PSJORDN_",","X","DRUG","ID") Q:'PSJNUM
 S PSCNT=PSCNT+1
 S ^TMP($J,"ORDERNUM",PSCNT)=PSJORDN
 S PSJDGN=$$GET1^DIQ(100.045,PSJNUM_","_PSJORDN,1,"I"),PSJDRUGN=$$GET1^DIQ(50,PSJDGN,.01)
 Q:'$G(PSJDGN)  I PSJDRUGN'[PSJDRUG Q
 S PSJPROV=$$GET1^DIQ(100,PSJORDN,1,"I") Q:'PSJPROV
 S PSJPROVN=$$GET1^DIQ(200,PSJPROV,.01),PSJPROT=$$GET1^DIQ(200,PSJPROV,9.21,"I")
 S PSJTYPE="NONE" I PSJPROT S PSJTYPE=$P("FULL TIME^PART TIME^C & A^FEE^STAFF","^",PSJPROT)
CHECK2 ;
 S PSJPT=+$$GET1^DIQ(100,PSJORDN,.02,"I") Q:'PSJPT  W ! S DFN=PSJPT D PID^VADPT,PRINT2
 S LRDFN=$$GET1^DIQ(2,PSJPT,63,"I")
 I 'LRDFN W ?55,"No lab data exists",?81,$E(PSJPROVN,1,20),?106,PSJTYPE,! D:PSJANS["Y"!(PSJANS["y") PSJORDNI Q
 S PSJLBENT=0,PSJINDIC=0
LOOP3 ;
 N LRARRAY,RESULT D LIST^DIC(63.04,","_LRDFN_",",,"I",,LDATE,,,,,"LRARRAY")
 F J2=1:1 Q:'$D(LRARRAY("DILIST",1,J2))  S PSJLDATE=LRARRAY("DILIST",1,J2) Q:PSJLDATE>PSJBD
 I J2>1 S J2=J2-1,PSJLDATE=LRARRAY("DILIST",1,J2),PSJLBENT=LRARRAY("DILIST",2,J2) D CHECK3 Q:$G(PSJLABQ)
 I PSJINDIC=0 W ?55,"NO LAB DATA IN RANGE",?81,$E(PSJPROVN,1,20),?106,PSJTYPE,!
 D:PSJANS["Y" PSJORDNI
 I $D(RESULT(3)) F J4=3:1 Q:'$D(RESULT(J4))  W ?55,RESULT(J4),! I $Y>(IOSL-6) D  Q:$G(PSJLABQ)  W @IOF,SITE,! D HDR2
 .I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSJLABQ=1
 Q
CHECK3 ;
 N ARR,KEY,TERM K RESULT S RESULT="",KEY=PSJLBENT_","_LRDFN D GETS^DIQ(63.04,KEY,"*","I","ARR") S KEY=KEY_","
 ; Loading of multiple results commented out MZR
 ;S J3=1 F  S J3=$O(ARR(63.04,KEY,J3)) Q:'J3  I ARR(63.04,KEY,J3,"I") D
 ;.I RESULT'="" S RESULT($I(TERM))=$P(^DD(63.04,J3,0),"^")_":"_ARR(63.04,KEY,J3,"I") Q
 ;.S RESULT=$P(^DD(63.04,J3,0),"^")_":"_ARR(63.04,KEY,J3,"I")
 I $D(ARR(63.04,KEY,PSJLABT,"I")) S RESULT=$P(^DD(63.04,PSJLABT,0),"^")_":"_ARR(63.04,KEY,PSJLABT,"I")
 I RESULT'="" D RESULT
 Q
RESULT Q:ARR(63.04,KEY,.05,"I")'=PSJSP  Q:'ARR(63.04,KEY,.03,"I")
 S Y=PSJLDATE X ^DD("DD") W ?55,$E(Y,1,11),?68,RESULT,! ;$P(^LR(LRDFN,"CH",PSJLBENT,PSJLABT),"^")_" "_PSJUNIT,?81,$E(PSJPROVN,1,20),?106,PSJTYPE W !
 S PSJINDIC=1 Q
 Q
PRINT2 I $Y>(IOSL-6) D  Q:$G(PSJLABQ)  W @IOF,SITE,! D HDR2
 .I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSJLABQ=1
 W ?1,$E($$GET1^DIQ(2,PSJPT,.01),1,20),?25,VA("PID") S Y=PSJBD X ^DD("DD") W ?37,Y
 Q
HDR W SITE,!!,"Patients receiving "_PSJDRUG_" with fills between "_PSJBDR_" and "_PSJEDR,!," with date of collection and results for lab test "_PSJLABTN_" after ",LDATER,!
HDR2 S PAGE=PAGE+1 W !,"Name",?25,"ID#",?37,"Fill Date",?55,"Lab Date",?68,"Results",?81,"Order Provider",?106,"Type",?116,"Page "_PAGE,!
 F J=1:1:IOM-1 W "_"
 W ! Q
PSJORDNI N DTOUT,DUOUT Q:$G(PSJLABQ)  W "Order #: "_$$GET1^DIQ(100,PSJORDN,.01)_"   Drug: "_$$GET1^DIQ(50,PSJDGN,.01)
 I $D(RESULT)>1 W ?55,RESULT(1)
 N SIGNUM S SIGNUM=$$FIND1^DIC(100.045,","_PSJORDN_",","X","SIG","ID")
 W !?1,"Sig: ",$$GET1^DIQ(100.0451,"1,"_SIGNUM_","_PSJORDN,.01)
 I $D(RESULT(2)) W ?55,RESULT(2)
 I $Y>(IOSL-6) D  Q:$G(PSJLABQ)  W @IOF,SITE,! D HDR2
 .I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) PSJLABQ=1
 W ! Q
CLEAN I $L($G(IOF)) W @IOF
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
CLEAN2 K PSJINDIC,PSJPT,PSJLDATE,PAGE,PSJBD,PSJBDR,PSJLBENT,PSJLABT,PSJDGN,PSJDRUGN,PSJDRUG,J,J1,J2,PSJORDN,PSJPROV,PSJPROVN,LDATE,LDATER,PSJED,PSJEDR,PSJPROT,PSJTYPE,PSJLABTN,PSJLBT,PSJSP,PSJUNIT,PSJANS,DIC,LRDFN,POP,SITE,Y,%DT,PSJLABQ
 K ZTDESC,ZTRTN,ZTSAVE,%ZIS,^TMP($J,"ORDERNUM"),^TMP($J,"PSORDT") Q
 ;
FQUIT Q
