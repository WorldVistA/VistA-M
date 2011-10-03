PSBMLTS ;BIRMINGHAM/EFC-BCMA MEDICATION LOG FUNCTIONS ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;;Mar 2004
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; EN^PSJBCMA1/2829
 ; File 50/221
 ;
EN ;
 N DFN,PSBCNT,PSBDT,PSBERR,PSBMED,PSBNOW,PSBSCHD,PSBVDT
 K ^TMP("PSB",$J),^TMP("PSJ",$J),PSBORD,PSBREC
 W @IOF,!,"Manual Medication Log Trouble Shooter",!!
 S DIC="^DPT(",DIC(0)="AEQM",DIC("A")="Select PATIENT: "
 D ^DIC K DIC Q:+Y<1  S DFN=+Y
 K DIR S DIR(0)="DO^",DIR("A")="Select Date To Validate"
 D ^DIR Q:+Y<1
 S PSBVDT=+Y
 W !,"Searching for Orders..."
 K ^TMP("PSJ",$J)
 D EN^PSJBCMA(DFN,PSBVDT,"")
 Q:$G(^TMP("PSJ",$J,1,0))=-1
 S PSBERR=0
 D NOW^%DTC S PSBNOW=%
 F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:'PSBX  D
 .Q:$P(^TMP("PSJ",$J,PSBX,0),U,3)?.N1"P"  ; No Pending Yet
 .K PSBORD,^TMP("PSBTMP",$J)
 .M PSBORD=^TMP("PSJ",$J,PSBX)
 .S PSBSCHD=$P(PSBORD(1),U,2)
 .I PSBSCHD="" D  Q
 .I PSBSCHD="C"&($P(PSBORD(1),U,6)="") D  Q
 ..W !!,"Notice: Order #",+$P(PSBORD(0),U,3)
 ..W $S($P(PSBORD(0),U,3)?.N1"U":" (UNIT DOSE) ",$P(PSBORD(0),U,3)?.N1"V":" (IV) ",1:"")
 ..W " doesn't have administration times"
 .S ^TMP("PSB",$J,PSBSCHD,$P(PSBORD(3),U,2),PSBX)=$P(PSBORD(0),U,3)_U_$P(PSBORD(1),U,6)
 D EN1 G EN
 ;
EN1 ;
 W $$HDR() I '$D(^TMP("PSB",$J)) W !!?5,"No Med Orders Found!",! Q
 S PSBSCHD="",PSBCNT=0
 F  S PSBSCHD=$O(^TMP("PSB",$J,PSBSCHD)) Q:PSBSCHD=""  D
 .W !  ; Line between order types
 .S PSBMED=""
 .F  S PSBMED=$O(^TMP("PSB",$J,PSBSCHD,PSBMED)) Q:PSBMED=""  D
 ..F PSBX=0:0 S PSBX=$O(^TMP("PSB",$J,PSBSCHD,PSBMED,PSBX)) Q:'PSBX  D
 ...I $Y>(IOSL-6) W ! K DIR S DIR(0)="E" D ^DIR W:Y $$HDR() I 'Y S PSBSCHD="Z" Q
 ...S PSBCNT=PSBCNT+1
 ...W !,$J(PSBCNT,2),". ",PSBSCHD,?8,PSBMED
 ...W ?40,$P(^TMP("PSB",$J,PSBSCHD,PSBMED,PSBX),U,1),?50,$P(^(PSBX),U,2)
 ...S ^TMP("PSBTMP",$J,PSBCNT)=$P(^TMP("PSB",$J,PSBSCHD,PSBMED,PSBX),U,1)
 F  Q:$Y>(IOSL-5)  W !
 K DIR S DIR(0)="NO^1:"_PSBCNT_":0" D ^DIR
 I Y S Y=^TMP("PSBTMP",$J,Y) D NEW(Y) K ^TMP("PSBTMP",$J) G EN1
 Q
 ;
NEW(Y) ; Create the new entry
 N PSBREC
 K ^TMP("PSJ",$J),RESULTS
 W @IOF D EN^PSJBCMA1(DFN,Y)
 K PSBORD M PSBORD=^TMP("PSJ",$J)
 W !,"Order:       ",$P(PSBORD(0),U,3)
 W !,"Medication:  ",$P(PSBORD(2),U,2)
 W !,"Dosage:      ",$P(PSBORD(2),U,3)
 W !,"Schedule:    ",$P(PSBORD(4),U,2)
 W !,"Admin Times: ",$P(PSBORD(4),U,9)
 W !,"Start D/T:   "
 W !,"Stop D/T:    "
 W !!,"Is this the correct Order" S %=1 D YN^DICN Q:%'=1
 ;
 ; PRN, One-Time, On Call orders
 ;
 I $P(PSBORD(4),U,1)'="C" D
 .W ! S %DT="AEQR",%DT("A")="Enter the DATE/TIME of Administration: "
 .S %DT("B")="Now" D ^%DT Q:Y<1  S PSBDT=Y D D^DIQ
 .D FILE
 ;
 ; Continuous Meds
 ;
 I $P(PSBORD(4),U,1)="C" D
 .W ! S %DT="AEQ",%DT("A")="Enter the DATE of Administration: "
 .S %DT("B")="Today" D ^%DT Q:Y<1  S PSBDT=Y D D^DIQ
 .S X="",Y=$P(PSBORD(4),U,9)
 .F Z=1:1:$L(Y,"-") D
 ..S X=X_$S(X]"":";",1:"")_Z_":"_$P(Y,"-",Z)
 .K DIR S DIR(0)="S^"_X,DIR("A")="Select Administration Time"
 .D ^DIR Q:Y<1
 .S PSBDT=+(PSBDT_"."_Y(0))
 .S Y=PSBDT D D^DIQ
 .D FILE
 Q
 ;
FILE ; Call the med log RPC to validate and order
 I $D(^PSB(53.79,"AORD",DFN,$P(PSBORD(0),U,3),PSBDT)) W !,"-1^Medication is already logged!"
 E  D VAL^PSBMLVAL(.RESULTS,DFN,+$P(PSBORD(0),U,3),$E($P(PSBORD(0),U,3),$L($P(PSBORD(0),U,3))),PSBDT) S X="" F  S X=$O(RESULTS(X)) Q:X=""  W !,RESULTS(X)
 K DIR S DIR(0)="E" D ^DIR
 Q
 ;
HDR() ;
 W @IOF,"Medication Log Trouble Shooter",!,"  #  "
 W !,$TR($J("",IOM)," ","-")
 Q ""
 ;
SCANNER ; This checks the scanning mechanism
 N PSBVAL,PSBSCAN,PSBX,PSBFLD
 W ! K DIR
 S DIR(0)="FO^1:45",DIR("A")="Scan Medication" D ^DIR Q:Y["^"!(Y="")
 S PSBVAL=X K DIR
 W !!,"Performing 'Exact Matches' scan of Drug File..."
 K PSBSCAN D SMED(.PSBSCAN,X)
 W !!,"Results of Scan:"
 W $S(+PSBSCAN(0)>0:" Good",1:" Invalid")," scan value."
 S X="" F  S X=$O(PSBSCAN(X)) Q:X=""  W !!?5,PSBSCAN(X)
 G:+PSBSCAN(0)>0 SCANNER
 W !!,"Performing 'Non-Exact Match' scan on the Drug File...",!
 K ^TMP("DILIST",$J)
 ;
 D FIND^DIC(50,"","","AX",PSBVAL,"*","B^C")
 ;
 I +$G(^TMP("DILIST",$J,0))<1 W !!,"Nothing found in drug file matching '",PSBVAL,"'." G SCANNER
 W !,"There are ",+^TMP("DILIST",$J,0)," matches to '",PSBVAL,"'."
 F PSBX=0:0 S PSBX=$O(^TMP("DILIST",$J,2,PSBX)) Q:'PSBX  D
 .W !!,"MATCH #:..................",PSBX
 .W !,"IEN:......................",^TMP("DILIST",$J,2,PSBX)
 .W !,"NAME:.....................",^TMP("DILIST",$J,1,PSBX)
 .S PSBFLD=0
 .F  S PSBFLD=$O(^TMP("DILIST",$J,"ID",PSBX,PSBFLD)) Q:'PSBFLD  D
 ..D FIELD^DID(50,PSBFLD,"","LABEL","PSBFLD")
 ..W !,PSBFLD("LABEL"),":" F  Q:$X>25  W "."
 ..W ^TMP("DILIST",$J,"ID",PSBX,PSBFLD)
 K ^TMP("DILIST",$J)
 Q
 ;
SMED(RESULTS,PSBDATA) ; Lookup Medication
 I $$GET^XPAR("DIV","PSB ROBOT RX"),PSBDATA?1"3"15N!(PSBDATA?1"3"17N),123[$E(PSBDATA,12) S PSBDATA=$E(PSBDATA,2,11)
 S X=$$FIND1^DIC(50,"","AX",PSBDATA,"B^C")
 I X<1 S RESULTS(0)="-1^Invalid Medication Lookup"
 E  S RESULTS(0)=X_U_$$GET1^DIQ(50,X_",",.01)
 Q
