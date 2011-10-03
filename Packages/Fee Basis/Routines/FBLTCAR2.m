FBLTCAR2 ;WOIFO/SS-LTC AUTHORIZATIONS REPORTS ;11/20/02
 ;;3.5;FEE BASIS;**49**;JAN 30, 1995
 ;
EN ;ask program
 N FBLTCAR
 S DIC("B")=$S(FBLTCPR="CONTRACT NURSING HOME":FBLTCPR,1:"OUTPATIENT")
 S DIC="^FBAA(161.8,",DIC(0)="AQEM",DIC("S")="S FBLTCAR=$P(^(0),U,1) I FBLTCAR=""OUTPATIENT""!(FBLTCAR=""CONTRACT NURSING HOME"")"
 D ^DIC K DIC I Y'>0 G EXIT
 S FBPROG=+Y
 ;
 ; ask purpose of visit(s)
 S DIR(0)="Y",DIR("A")="For ALL LTC Purpose of Visits? Y/N",DIR("B")="YES"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBPOV=Y
 I 'FBPOV D  G:'$D(FBPOV) EXIT S FBPOV=0
 . K FBPOV
 . W !,"Select one or more LTC Purpose of Visits"
 . S DIC="^FBAA(161.82,",DIC(0)="AQEM",DIC("S")="I $P(^(0),U,2)=FBPROG&(+$P(^(0),U,4)>0)"
 . F  D  Q:Y'>0
 . . D ^DIC I Y>0 S FBPOV(+Y)=$P(Y,U,2)
 . K DIC
 ;
 ; ask dates
 S DIR(0)="D^::EX",DIR("A")="From Date"
 ;   default from date is first day of previous month
 S DIR("B")=$$FMTE^XLFDT($E($$FMADD^XLFDT($E(DT,1,5)_"01",-1),1,5)_"01")
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT1=Y
 S DIR(0)="DA^"_FBDT1_"::EX",DIR("A")="To Date: "
 ;   default to date is last day of specified month
 S X=FBDT1 D DAYS^FBAAUTL1
 S DIR("B")=$$FMTE^XLFDT($E(FBDT1,1,5)_X)
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBDT2=Y
 ;
 ; ask if remarks should be printed
 S DIR(0)="Y",DIR("A")="Print authorization remarks",DIR("B")="NO"
 D ^DIR K DIR G:$D(DIRUT) EXIT
 S FBAR=Y
 ;
 ; ask device
 S %ZIS="QM" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="QEN^FBLTCAR2",ZTDESC="LTC Authorizations Report"
 . F FBX="FBLTCRT","FBPROG","FBPOV*","FBDT*","FBAR" S ZTSAVE(FBX)=""
 . D ^%ZTLOAD,HOME^%ZIS K ZTSK,ZTDESC,ZTREQ,ZTRTN,ZTSAVE,ZTSTOP,ZTQUEUED
 ;
QEN ; queued entry
 U IO
 ;
GATHER ; collect and sort data
 N FBVN
 K ^TMP($J)
 ; loop thru Fee Basis Patients
 S FBDFN=0 F  S FBDFN=$O(^FBAAA(FBDFN)) Q:'FBDFN  D
 . S FBPNAME=$$GET1^DIQ(161,FBDFN,.01)
 . S:FBPNAME="" FBPNAME="UNKNOWN"
 . ; loop thru authorizations
 . S FBAU=0 F  S FBAU=$O(^FBAAA(FBDFN,1,FBAU)) Q:'FBAU  D
 . . S FBA=$G(^FBAAA(FBDFN,1,FBAU,0))
 . . Q:$P(FBA,U,3)'=FBPROG  ; not program
 . . Q:$P($G(^FBAAA(FBDFN,1,FBAU,"ADEL")),U)  ; austin deleted
 . . Q:$P(FBA,U,7)=""  ; blank purpose of visit
 . . I 'FBPOV Q:'$D(FBPOV($P(FBA,U,7)))  ; not selected POV
 . . Q:+$P($G(^FBAA(161.82,+$P(FBA,U,7),0)),U,4)=0  ;non-LTC
 . . ; ensure authorization is not outside the period of interest
 . . I +$G(FBLTCRT)=0 Q  ;FBLTCRT should be defined
 . . I +$G(FBLTCRT)>0 Q:$$LTCRPT^FBLTCAR($P(FBA,U),$P(FBA,U,2),FBDT1,FBDT2,+$G(FBLTCRT))  ;for LTC reports FBLTCRT is difined in ^FBLTCAR
 . . ; passed all criteria
 . . S FBVN=$S($P(FBA,U,4):$P($G(^FBAAV($P(FBA,U,4),0)),U),1:"")
 . . I FBVN="" S FBVN="not specified"
 . . ; sort by purpose of visit,vendor,name^dfn,auth from date^auth ien
 . . S ^TMP($J,$P(FBA,U,7),FBVN,FBPNAME_U_FBDFN,$P(FBA,U)_U_FBAU)=FBA
 ;
PRINT ; report data
 N FBVN,FBD
 S (FBQUIT,FBPG)=0 D NOW^%DTC S Y=% D DD^%DT S FBDTR=Y
 K FBDL S FBDL="",$P(FBDL,"-",IOM)=""
 ;
 ; build page header text for selection criteria
 K FBHDT
 S FBHDT(1)="  FROM "_$$FMTE^XLFDT(FBDT1)_" TO "_$$FMTE^XLFDT(FBDT2)
 S FBHDT(1)=FBHDT(1)_"  FOR THE "_$$GET1^DIQ(161.8,FBPROG,.01)_" PROGRAM"
 S FBHDT(2)="  FOR "_$S(FBPOV:"ALL ",1:"")_"PURPOSE OF VISIT(S)"
 I 'FBPOV D
 . S FBL=2,FBHDT(FBL)=FBHDT(FBL)_": "
 . S (FBC,FBI)=0 F  S FBI=$O(FBPOV(FBI)) Q:'FBI  D
 . . I $L(FBHDT(FBL))+2+$L(FBPOV(FBI))>75 D
 . . . I FBC S FBHDT(FBL)=FBHDT(FBL)_","
 . . . S FBL=FBL+1
 . . . S FBC=0,FBHDT(FBL)="    "
 . . S FBHDT(FBL)=FBHDT(FBL)_$S(FBC:", ",1:"")_FBPOV(FBI)
 . . S FBC=FBC+1 ; count of POVs on current line (FBL)
 ;
 ; determine if DAYS column should be displayed (true/false)
 S FBDD=$$GET1^DIQ(161.8,FBPROG,.01)="STATE HOME"
 ;
 D HD
 I '$D(^TMP($J)) W !,"No authorizations found during period."
 S FBC("TOT")=0 ; initialize count of authorizations on report
 ; loop thru purpose of visit
 S FBPOV=0 F  S FBPOV=$O(^TMP($J,FBPOV)) Q:'FBPOV  D  Q:FBQUIT
 . S FBPOV("E")=$$GET1^DIQ(161.82,FBPOV,.01)
 . I $Y+9>IOSL D HD Q:FBQUIT
 . W !!,"POV: ",FBPOV("E")
 . S FBC("POV")=0 ; initialize count of authorizations for POV
 . S:FBDD FBD("POV")=0 ; initialize count of days for POV
 . ; loop thru vendors
 . S FBVN="" F  S FBVN=$O(^TMP($J,FBPOV,FBVN)) Q:FBVN=""  D  Q:FBQUIT
 . . I $Y+7>IOSL D HD Q:FBQUIT  D HDPOV
 . . W !!,"  Vendor: ",FBVN,!
 . . S FBC("VEN")=0 ; initialize count of auth for vendor (in POV)
 . . S:FBDD FBD("VEN")=0 ; initialize count of days for vendor (in POV)
 . . ; loop thru veterans
 . . S FBPAT=""
 . . F  S FBPAT=$O(^TMP($J,FBPOV,FBVN,FBPAT)) Q:FBPAT=""  D  Q:FBQUIT
 . . . S FBPNAME=$P(FBPAT,U)
 . . . S FBDFN=$P(FBPAT,U,2)
 . . . D
 . . . . N DFN S DFN=FBDFN D DEM^VADPT ; obtain patient demographics
 . . . ; loop thru authorizations
 . . . S FBAUT=""
 . . . F  S FBAUT=$O(^TMP($J,FBPOV,FBVN,FBPAT,FBAUT)) Q:FBAUT=""  D  Q:FBQUIT
 . . . . S FBDTF=$P(FBAUT,U)
 . . . . S FBAU=$P(FBAUT,U,2)
 . . . . S FBA=^TMP($J,FBPOV,FBVN,FBPAT,FBAUT)
 . . . . S:FBDD FBDAYS=$$DOC^FBSHUTL($P(FBA,U),$P(FBA,U,2),FBDT1,FBDT2)
 . . . . S FBC("VEN")=FBC("VEN")+1
 . . . . S:FBDD FBD("VEN")=FBD("VEN")+FBDAYS
 . . . . I $Y+6>IOSL D HD Q:FBQUIT  D HDPOV,HDVEN
 . . . . W !,?4,FBPNAME,?35,$P(VADM(2),U,2)
 . . . . W:FBDD ?48,$J(FBDAYS,3)
 . . . . W ?53,$$FMTE^XLFDT($P(FBA,U)),?67,$$FMTE^XLFDT($P(FBA,U,2))
 . . . . W !,?6,"DOB: ",$P(VADM(3),U,2)
 . . . . I +VADM(6) W ?25,"*** Patient Died on ",$P(VADM(6),U,2)
 . . . . ; print remarks (optional)
 . . . . I $G(FBAR),$O(^FBAAA(FBDFN,1,FBAU,2,0)) D
 . . . . . N DIWL,DIWR,DIWF,FBRR
 . . . . . K ^UTILITY($J,"W") S DIWL=7,DIWR=(IOM-5),DIWF="W"
 . . . . . S X="REMARKS: ",FBRR=0
 . . . . . F  S FBRR=$O(^FBAAA(FBDFN,1,FBAU,2,FBRR)) Q:'FBRR  S X=X_^(FBRR,0) D ^DIWP S X="" I $Y+6>IOSL D HD Q:FBQUIT  D HDPOV,HDVEN,HDPAT
 . . . . . D:'FBQUIT ^DIWW
 . . . . ; print additional information for LTC reports
 . . . . I +$G(FBLTCRT)>0 D PRNVIS^FBLTCAR(+FBDFN,+FBAU,FBVN,+FBDT1,+FBDT2,+$P(FBA,U),+$P(FBA,U,2))
 . . . D KVA^VADPT ; clean up patient demographics
 . . Q:FBQUIT
 . . S FBC("POV")=FBC("POV")+FBC("VEN")
 . . S:FBDD FBD("POV")=FBD("POV")+FBD("VEN")
 . . I $Y+5>IOSL D HD Q:FBQUIT  D HDPOV,HDVEN
 . . W !,?32,"----"
 . . W:FBDD ?47,"----"
 . . W !,"  Vendor Subtotal:",?25,"Count: ",$J(FBC("VEN"),4)
 . . W:FBDD ?41,"Days: ",$J(FBD("VEN"),4)
 . Q:FBQUIT
 . S FBC("TOT")=FBC("TOT")+FBC("POV")
 . I $Y+5>IOSL D HD Q:FBQUIT  D HDPOV
 . W !,?32,"===="
 . W:FBDD ?47,"===="
 . W !,"POV Subtotal: ",?25,"Count: ",$J(FBC("POV"),4)
 . W:FBDD ?41,"Days: ",$J(FBD("POV"),4)
 ;
 I FBQUIT W !!,"REPORT STOPPED AT USER REQUEST"
 E  W !!,FBC("TOT")," Authorization",$S(FBC("TOT")=1:"",1:"s")," on report"
 I 'FBQUIT,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR
 D ^%ZISC
 ;
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"
 K ^TMP($J)
 K FBA,FBAR,FBAU,FBAUT,FBC,FBDAYS,FBDD,FBDFN,FBDL,FBDT1,FBDT2,FBDTF
 K FBDTR,FBHDT,FBI,FBL,FBPAT,FBPG,FBPNAME,FBPOV,FBPROG,FBSSN,FBQUIT,FBX
 K DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,POP,VADM
 Q
HD ; page header
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1,FBQUIT=1 Q
 I $E(IOST,1,2)="C-",FBPG S DIR(0)="E" D ^DIR K DIR I 'Y S FBQUIT=1 Q
 I $E(IOST,1,2)="C-"!FBPG W @IOF
 S FBPG=FBPG+1
 W !,$S(FBLTCRT=1:"ENDING ",1:"ACTIVE "),"AUTHORIZATIONS by POV, Vendor, Patient"
 W ?49,FBDTR,?72,"page ",FBPG
 S FBI=0 F  S FBI=$O(FBHDT(FBI)) Q:'FBI  W !,FBHDT(FBI)
 W !!,?4,"VETERAN",?35,"Pt. ID"
 W:FBDD ?47,"DAYS"
 W ?56,"AUTHORIZATION"
 W !,?53,"FROM DATE",?67,"TO DATE"
 W !,FBDL
 Q
HDPOV ; page header for continued POV
 W !,"POV:",FBPOV("E")," (continued)"
 Q
HDVEN ; page header for continued Vendor
 W !,"  Vendor: ",FBVN," (continued)"
 Q
HDPAT ; page header for continued Patient
 W !,"    Patient: ",FBPNAME," (continued)"
 Q
 ;
 ;FBLTCAR2
