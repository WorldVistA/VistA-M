PSAOUT ;BHM/DB/PWC - Return Drugs to Manufacturer ;23 FEB 04
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**51,64,68,70**; 10/24/97;Build 12
 ;References to ^PSDRUG( are covered by IA #2095
 ;References to ^DIC(51.5 are covered by DBIA # 1931
 ;References to ^PSRX( are covered by DBIA # 254
 ;References to ^PSD(58.86 are covered by DBIA # 4472
 S PSACNT=0
 D Q
 K DIR S DIR(0)="S^1:Print Report;2:Enter drugs Return to Manufacturer" D ^DIR K DIR G Q:$D(DIRUT) I +Y=1 G RPT
 D ORDER^PSALOC   ; PSA*3*68 will now ask the Dispense Location
1 ;Select Drug
 K PSAINDX,PSADRG
 R !!,"Scan Drug barcode or enter a drug name : ",AN:DTIME S PSACNT=$G(PSACNT)+1 G DONE:AN["^" G DONE:AN="" I AN=" " W "??" G 1
 I $D(^PSDRUG("NDC",AN)) S PSANDC=AN D NDC G:$G(DUOUT) DONE G:$G(PSADRG) FOUND
 I $D(^PSDRUG("C",AN)),$G(PSAINDX)'="NDC" D INDEX G:$G(DUOUT) DONE G:$G(PSADRG) FOUND
 I AN["-",$P(AN,"-",3)'="",$G(PSAINDX)'="NDC" D NDC G:$G(DUOUT) DONE G:$G(PSADRG) FOUND
 I AN["-",$P(AN,"-",2)'="",$P(AN,"-",3)="" S PSARX=$P(AN,"-",2),PSADRG=$P($G(^PSRX(PSARX,0)),"^",6) I $G(PSADRG)>0 G FOUND
 I AN?.AN,$D(^PSDRUG(AN,0)) S PSADRG=AN G FOUND
 I $G(PSAINDX)'["C" D  G:$G(DUOUT) DONE G:$G(PSADRG) FOUND
 .S X=AN,DIC(0)="EQMZ",DIC("A")="Select Drug : ",DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0),$P($G(^(2)),""^"",3)'[""N""",DIC="^PSDRUG(" D ^DIC S:+Y>0 PSADRG=+Y K DIC
 W !!,"Sorry, I could not find a match. Please enter the drug name.",!! G 1
FOUND ;Might have match
 S PSADRUGN=$P($G(^PSDRUG(PSADRG,0)),"^") W " ",$G(PSADRUGN) S DIC("B")=PSADRUGN
 I $P($G(^PSDRUG(PSADRG,2)),"^",3)["N" W !!,"Sorry, Controlled Substances cannot be selected through this option." K PSADRG,PSADRUGN,X,AN G 1
OK K DIR S DIR("A")="Is this correct",DIR(0)="Y",DIR("B")="YES" D ^DIR G DONE:$D(DIRUT)
 I +Y>0 G PROCEED
 G 1
 Q
PROCEED ;On to the next series of questions
CON K DIR S DIR(0)="N",DIR("A")="Number of containers " D ^DIR K DIR S PSACON=+Y I $D(DIRUT) G DONE
 K PSAOU
 S PSAOU=$P($G(^PSDRUG(PSADRG,"660")),"^",2) I $G(PSAOU)>0 S PSAOU(1)=$P(^DIC(51.5,PSAOU,0),"^")
 S PSAPDUOU=$P($G(^PSDRUG(PSADRG,660)),"^",6)
QTY K DIR S DIR(0)="N",DIR("A")="Number of Dispense units being returned: " D ^DIR G DONE:$D(DIRUT)>0 S PSAQTY=Y
OU K DIC,Y,X S DIC(0)="QAEMZ",DIC="^DIC(51.5,",DIC("A")="Package type: ",DR=.01 S:$G(PSAOU(1))'="" DIC("B")=PSAOU(1) D ^DIC K DIC I +Y<0 G DONE
 S PSAOU(1)=Y(0)
 K DIR S DIR("A")="Is it ok to file the data entered",DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR G Q:$D(DIRUT) I Y'>0 W !,"ok, try again,",! G CON
 W !,"Updating Destruction holding file."
 F  L +^PSD(58.86,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSAHLD=$P(^PSD(58.86,0),"^",3)+1 I $D(^PSD(58.86,PSAHLD)) S $P(^PSD(58.86,0),"^",3)=PSAHLD G FIND
 D NOW^%DTC S PSADT=%
 K DA,DIC,DLAYGO S (DIC,DLAYGO)=58.86,DIC(0)="L",(X,DINUM)=PSAHLD D ^DIC K DIC,DINUM,DLAYGO
 L -^PSD(58.86,0)
 W !,"Updating Drug Accountability Transaction file."
PSTRAN S PSAIEN=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSAIEN)) S $P(^PSD(58.81,0),"^",3)=PSAIEN G PSTRAN
 S DIC="^PSD(58.81,",DIC(0)="L",DLAYG0=58.81,(DINUM,X)=PSAIEN D ^DIC K DIC,DLAYGO
 S DIE="^PSD(58.81,",DA=PSAIEN,DR="1////^S X=10;3////^S X=PSADT;4////^S X=PSADRG;6////^S X=DUZ;47////^S X=PSAHLD" D ^DIE
UPDT K DA,DIE,DR S DIE=58.86,DA=PSAHLD,DR="1////"_+PSADRG_";2////"_PSAQTY_";11////"_PSACON_";12////"_$P(PSAOU(1),U,1)_";9////^S X=DUZ;10////^S X=PSADT;6////^S X=PSALOC;19////^S X=$G(PSAPDUOU)"
 I +PSADRG=99999999 S ^PSD(58.86,DA,1)=PSADRUGN
 D ^DIE K DIE,DA,DR S ^PSD(58.86,PSAHLD,2)="Returned to Manufacturer"
 S ^XTMP("PSAOUT",$J,PSACNT)=PSADRG_"^"_PSAQTY_"^"_PSAOU_"^"_PSACON
 W !!!!!!! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y G DONE
 G 1
 Q
NDC ;DRUG LOOKUP USING THE NDC INDEX
 N PSAOUT,TMP1,Y,DIR
 S PSAINDX="NDC"
 I '$G(PSANDC),AN["-" S PSANDC=$P(AN,"-")_$P(AN,"-",2)_$P(AN,"-",3)
 Q:'$O(^PSDRUG("NDC",PSANDC,0))
 D FIND^DIC(50,"","","",PSANDC,"","NDC","","","PSAOUT")
 I $P(PSAOUT("DILIST","0"),"^")=1 S PSADRG=$G(PSAOUT("DILIST","2",1))
 I $P(PSAOUT("DILIST","0"),"^")>1 D
 .S TMP1=0
 .F  S TMP1=$O(PSAOUT("DILIST",1,TMP1)) Q:TMP1=""  D
 ..W !,?5,TMP1,?9,AN,"  ",$G(PSAOUT("DILIST",1,TMP1)),"            ",$G(PSAOUT("DILIST","ID",TMP1,25))
 .S DIR(0)="NO^1:"_$P(PSAOUT("DILIST","0"),"^") D ^DIR
 .I '$G(DUOUT),$G(Y)>0 S PSADRG=$P(PSAOUT("DILIST",2,+Y),"^")
 Q
INDEX ;DRUG FILE LOOKUP USING "C" INDEX
 N PSAOUT,TMP1,Y,DIR
 S PSAINDX="C"
 D FIND^DIC(50,"","","",AN,"","C","","","PSAOUT")
 I $P(PSAOUT("DILIST","0"),"^")=1 S PSADRG=$G(PSAOUT("DILIST","2",1))
 I $P(PSAOUT("DILIST","0"),"^")>1 D
 .S TMP1=0
 .F  S TMP1=$O(PSAOUT("DILIST",1,TMP1)) Q:TMP1=""  D
 ..W !,?5,TMP1,?9,AN,"  ",$G(PSAOUT("DILIST",1,TMP1)),"            ",$G(PSAOUT("DILIST","ID",TMP1,25))
 .S DIR(0)="NO^1:"_$P(PSAOUT("DILIST","0"),"^") D ^DIR
 .I '$G(DUOUT),$G(Y)>0 S PSADRG=$P(PSAOUT("DILIST",2,+Y),"^")
 I $G(Y)'>0 S X=AN,DIC(0)="EQMZ",DIC("A")="Select Drug : ",DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0),$P($G(^(2)),""^"",3)'[""N""",DIC="^PSDRUG(" D ^DIC Q:+Y'>0  S PSADRG=+Y K DIC
 Q
DONE I $G(PSACNT)'>0 G Q
 K DIR S DIR("A")="Would you like to print the returns report ",DIR(0)="Y",DIR("B")="YES" D ^DIR G Q:$D(DIRUT)>0 I Y'>0 G Q
RPT ;print report
 W !,"If you are returning the items to the manufacturer at this time, the program",!,"will add today's date to the item to show when it was actually returned.",!
 K DIR S DIR("A")="Are you returning items to the manufacturer at this time",DIR(0)="Y",DIR("B")="YES" D ^DIR G Q:$D(DIRUT)>0 I Y>0 S PSARET=1
 D NOW^%DTC S X1=X,X2=-90 D C^%DTC S Y=X D DD^%DT S %DT("B")=Y
BGNDT S %DT="AEP",%DT("A")="Beginning Date: " D ^%DT I +Y<1!($D(DTOUT))!(X["^")!(X']"") G Q
 S PSABEG=+Y
ENDDT D NOW^%DTC S Y=+% D DD^%DT S %DT("B")=$P(Y,"@"),%DT="AE",%DT("A")="Ending Date   : " D ^%DT I +Y<1!($D(DTOUT))!(X["^")!(X']"") S PSAOUT=1 G Q
 I Y<PSABEG W !!,"Ending Date cannot be before the Start Date." G ENDDT
 S PSAEND=+Y
 K IO("Q") S %ZIS="Q" W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED.",! G Q
 I $D(IO("Q")) K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSAOUT",ZTDTH=$H,ZTDESC="PSA OUTDATED REPORT" F X="PSARET","PSABEG","PSAEND" S ZTSAVE(X)=""
 I  D ^%ZTLOAD,HOME^%ZIS G Q
 U IO
START ;
 K ^XTMP("PSAOUT",$J) S PG=0
 S Y=PSABEG,PSADT=PSABEG-.1 D DD^%DT S PSABEG(1)=Y
 S Y=PSAEND D DD^%DT S PSAEND(1)=Y,PSAEND=PSAEND+.999999
 D NOW^%DTC S PSARETD=$P(%,"."),^XTMP("PSAOUT",$J,0)=PSARETD_"^"_PSARETD,Y=PSARETD
 D DD^%DT S PSARETD=Y K Y
LOOP ;Loop through "AC" xref
 ;^PSD(58.86,"AC",DATE/TIME DESTROYED,DISPENSING SITE,DRUG,DA)=""
 S PSADT=$O(^PSD(58.86,"AC",PSADT)) G BEGIN:PSADT'>0 G BEGIN:PSADT>PSAEND
 S PSALOC1=0
LOC S PSALOC1=$O(^PSD(58.86,"AC",PSADT,PSALOC1)) G LOOP:PSALOC1'>0 G LOOP:PSALOC1'>0 S PSADRG=0
DRG S PSADRG=$O(^PSD(58.86,"AC",PSADT,PSALOC1,PSADRG)) G LOC:PSADRG'>0 S PSAIEN=0
IEN S PSAIEN=$O(^PSD(58.86,"AC",PSADT,PSALOC1,PSADRG,PSAIEN)) G DRG:PSAIEN'>0
 S PSADATA=$G(^PSD(58.86,PSAIEN,0)),PSADATA2=$G(^PSD(58.86,PSAIEN,2))
 I $E(PSADATA2,1,3)'="Ret" G IEN
 F X=1:1:14 S PSA(X)=$P(PSADATA,"^",X)
 I $G(PSA(2))=99999999 S PSA(2)=$G(^PSD(58.86,PSAIEN,1))
 S ^XTMP("PSAOUT",$J,PSA(7),PSA(1))=PSA(8)_"^"_PSA(2)_"^"_PSA(3)_"^"_PSA(10)_"^"_PSA(9)_"^"_PSADT_"^"_$G(^PSD(58.86,PSAIEN,2))_"^"_PSA(12)_"^"_PSA(14)
 I $G(PSARET)=1,$G(^PSD(58.86,PSAIEN,2))'["on" S ^PSD(58.86,PSAIEN,2)=^PSD(58.86,PSAIEN,2)_" on "_PSARETD
 G IEN
PRINT ;Print data
 S PG=$G(PG)+1 W @IOF,!!!,?25,"Items to be Returned Report",?70,"Page : ",$G(PG)
 W !,?24,PSABEG(1)," thru ",PSAEND(1)
 I $G(PSALOC) S PSALL1=$P(^PSD(58.8,PSALOC,0),"^",3),PSALOCM=$P(^PSD(58.8,PSALOC,0),"^",1)_" - "_$S(PSALL1'="":$P(^PS(59.4,PSALL1,0),"^"),1:"") W !,?40-($L(PSALOCM)/2),PSALOCM
 W !,"Printed on: ",PSADT(1),?50,"Printed by: ",$P($G(^VA(200,DUZ,0)),"^"),!
 F X=1:1:((IOM/2)-2) W "- "
 W !,?50,"Total Dispense"
 W !,"Drug Name",?30,"Containers",?50,"Units / Cost",?66,"Entered by",! F X=1:1:(IOM-1) W "-"
 Q
BEGIN D NOW^%DTC S Y=+% D DD^%DT S PSADT(1)=Y
 ; added to print by location and then date PSA*3*68
 ; Changed ^XTMP("PSA" to ^XTMP("PSAOUT"  PSA*3*70
 S PSALOC=0 F X=1:1 S PSALOC=$O(^XTMP("PSAOUT",$J,PSALOC)) Q:PSALOC'>0  G EORPT:$G(PSAOUT)=1  D
 . S PSAIEN=0,PG=0 D PRINT
 . F XX=1:1 S PSAIEN=$O(^XTMP("PSAOUT",$J,PSALOC,PSAIEN)) Q:PSAIEN'>0  D
 .. S PSADATA=^XTMP("PSAOUT",$J,PSALOC,PSAIEN),PSADRUGN=$P(PSADATA,"^",2)
 .. W !,$S('$D(^PSDRUG(PSADRUGN,0)):PSADRUGN,1:$P(^PSDRUG(PSADRUGN,0),"^"))
 .. I $L(PSADRUGN)>37 W !
 .. W ?38,$J($P(PSADATA,"^",1),2)," (",$P(PSADATA,"^",8),")",?50,$J($P(PSADATA,"^",3),3)
 .. I $P(PSADATA,"^",9)]"",$P(PSADATA,"^",1)]"" W ?55,$J(($P(PSADATA,"^",3)*$P(PSADATA,"^",9)),5,2)
 .. S PSANAME=$S($P(PSADATA,"^",4)']"":"",1:$P($G(^VA(200,$P(PSADATA,"^",4),0)),"^"))
 .. I PSANAME'="" S PSANM1=$P(PSANAME,",",1),PSANM2=$P(PSANAME,",",2),PSANAME=$E(PSANM2,1)_$E(PSANM1,1)
 .. W ?64,PSANAME S DATA=$P(PSADATA,"^",6),X2=$E(DATA,1,3)+1700
 .. W " (",$E(DATA,4,5),"/",$E(DATA,6,7),"/",$E(X2,3,4),")"
 .. I $Y>(IOSL-5) D HDR
 . I $O(^XTMP("PSAOUT",$J,PSALOC)),($E(IOST,1,2)="C-") W ! K DIR S DIR(0)="E" D ^DIR K DIR
EORPT W !!,"End of report" D ^%ZISC
Q K AN,DA,DATA,DIC,DIR,DIE,DIRUT,DLAYG0,DR,DTOUT,DUOUT,PG,PSA,PSABEG,PSACHK,PSACNT,PSACOMB,PSACON,PSADATA,PSADATA2,PSADRG
 K PSADRUGN,PSADT,PSAEND,PSAHLD,PSAIEN,PSAINDX,PSAISITN,PSAITY,PSALOC,PSALOCA,PSALOC1,PSALOCN,PSAMNU,PSANAME,PSANDC,PSANM1,PSANM2
 K PSANUM,PSAONE,PSAOU,PSALOCM,PSAPDUOU,PSAOUT,PSAQTY,PSARET,PSARETD,PSARX,PSAOSITN,PSALOCM,PSALL1,X,XX,X1,X2,Y,^XTMP("PSAOUT",$J) Q
NONDRUG W !,"The item could not be found in the drug file.",!
 K DIR S DIR("A")="Is this a non-va drug",DIR(0)="Y",DIR("B")="NO" D ^DIR K DIR G Q:$D(DIRUT)=1
 I +Y'>0 G 1
 S PSADRG=99999999,PSADRUGN=AN
ASKD W !,PSADRUGN," //" R AN:DTIME I AN="" G CON
 G Q:AN["^" S PSADRUGN=AN W " ok, press ENTER to confirm.",! G ASKD
HDR I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSAOUT=1 Q
 D PRINT Q
