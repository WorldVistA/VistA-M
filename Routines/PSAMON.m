PSAMON ;BIR/LTL,JMB-Monthly Summary ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**15**; 10/24/97
 ;
 ;References to ^PSDRUG( are covered by IA #2095
 ;
 ;This routine allows the user to print a report per pharmacy location
 ;of the drug, beginning balance, ending balance, total received, total
 ;dispensed, and total adjustments. Specific or all drugs can be selected
 ;for the report. The report can be sent to the screen and printer.
 ;
LOC K ^TMP("PSAD",$J) S PSAHIS=1,(PSACNT,PSAOUT)=0
 D LOC^PSALEVRP I $G(DIRUT) S PSAOUT=1 G END1
 S PSACHK=$O(PSALOC(""))
 I 'PSACNT,PSACHK="" W !,"There are no active pharmacy locations." G END1
 I PSACNT=1 D
 .S PSALOCN=$O(PSALOCA("")),PSALOC=$O(PSALOCA(PSALOCN,0)),PSALOC(PSALOCN,PSALOC)=PSALOCA(PSALOCN,PSALOC),PSAMENU(1,PSALOCN,PSALOC)="",PSASEL=1,PSATOT=0
 .W:$L(PSALOCN)>76 !,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<77 !,PSALOCN
 D DT^DICRW S Y=$E(DT,1,5) X ^DD("DD") S PSAMON=Y
 S DIR(0)="D:AEP",DIR("A")="Select month and year: ",DIR("B")=PSAMON D ^DIR K DIR I $D(DIRUT) S PSAOUT=1 G END1
 S PSAMON=+($E(Y,1,5)*100),PSA=0,Y=PSAMON X ^DD("DD") S PSAMONN=Y,PSACNT=0
 W ! F PSAPC=1:1 S PSAPICK=+$P(PSASEL,",",PSAPC) Q:'PSAPICK  D
 .S PSALOCN="" F  S PSALOCN=$O(PSAMENU(PSAPICK,PSALOCN)) Q:PSALOCN=""!(PSAOUT)  S PSALOC=0 F  S PSALOC=$O(PSAMENU(PSAPICK,PSALOCN,PSALOC)) Q:'PSALOC!(PSAOUT)  D
 ..S PSACNT=PSACNT+1
 ..W @IOF W:$L(PSALOCN)>79 !,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2) W:$L(PSALOCN)<80 !,PSALOCN
 ..I '$O(^PSD(58.8,+PSALOC,1,0)) W !!,"There are no drugs in ",$G(PSALOCN) S PSAOUT=1 Q
 ..D DRUG Q:PSAOUT
 I PSACNT=1!(PSAOUT) S PSATOT=0 G DEV
 W ! S DIR(0)="Y",DIR("A")="Print summary report",DIR("B")="Y",DIR("?",1)="Enter YES to print a report of the total figures for each selected",DIR("?",2)="drug in all selected pharmacy locations."
 S DIR("?")="Enter NO to print only the report per pharmacy location.",DIR("??")="^D SUMHELP^PSAMON" D ^DIR K DIR G:$G(DIRUT) END1 S PSATOT=+Y
 G DEV
 ;
DRUG W !!,"Select one, several, or ^ALL drugs.",!
 S PSADONE=0,DIC="^PSD(58.8,+PSALOC,1,",DIC(0)="AEMQ",DIC("A")="Select Drug: "
 F  D ^DIC S:$G(DTOUT)!(X="^") PSAOUT=1 Q:Y=-1&(X'="^A")&(X'="^ALL")  D  Q:PSAOUT!(PSADONE)
 .I X'="^A",X'="^ALL",'+Y S PSAOUT=1 Q
 .I X="^A"!(X="^ALL") D  Q
 ..W !,"Please wait." S PSA=0 F  S PSA=$O(^PSD(58.8,+PSALOC,1,PSA)) Q:'PSA  S:$G(^PSD(58.8,+PSALOC,1,+PSA,5,PSAMON,0))'="" ^TMP("PSAD",$J,PSALOCN,PSA)="" W:(PSA#500) "."
 ..D END^PSAPROC S PSADONE=1
 .I +Y,$G(^PSD(58.8,+PSALOC,1,+Y,5,PSAMON,0))="" W !!,"Sorry, no history for that month." Q
 .S ^TMP("PSAD",$J,PSALOCN,+Y)=""
 K DIC
 Q
 ;
DEV ;asks device and queueing info
 S PSA=$O(^TMP("PSAD",$J,"")) G:PSA=""!(PSAOUT) END1
 K IO("Q") N IOP,POP S %ZIS="Q" W ! D ^%ZIS I POP W !,"NO DEVICE SELECTED OR OUTPUT PRINTED!" G END1
 I $D(IO("Q")) D  G END1
 .K ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTDTH,ZTSK
 .S ZTRTN="START^PSAMON",ZTDESC="Drug Accountability Monthly Summary Report",ZTSAVE("PSA*")="",ZTSAVE("^TMP(""PSAD"",$J,")=""
 .D ^%ZTLOAD,HOME^%ZIS
 ;
START ;compiles and prints output
 S PSARPDT=$E($$HTFM^XLFDT($H),1,12),PSADT=$P(PSARPDT,".")
 S PSARPDT=$E(PSADT,4,5)_"/"_$E(PSADT,6,7)_"/"_$E(PSADT,2,3)_"@"_$P(PSARPDT,".",2)
 S (PSAOUT,PSAPG)=0,$P(PSADLN,"=",81)="",$P(PSASLN,"-",81)="",PSATABH=(66-($L(PSAMONN)+$L($E(PSALOCN,1,20))))/2
 K ^TMP("PSAMON",$J)
LOOP S PSALOCN="" F  S PSALOCN=$O(^TMP("PSAD",$J,PSALOCN)) Q:PSALOCN=""!(PSAOUT)  D
 .D HEADER S PSALOC=$O(PSALOC(PSALOCN,0))
 .F PSA=0:0 S PSA=+$O(^TMP("PSAD",$J,PSALOCN,PSA)) Q:'PSA  D
 ..I $D(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)) S ^TMP("PSAMON",$J,$P($G(^PSDRUG(PSA,0)),U))=PSA
 .D PRINT K ^TMP("PSAMON",$J)
 .I 'PSAOUT D:$Y+4>IOSL HEADER Q:PSAOUT  W !,"TOTAL",?36,$J(PSATREC,6,0),?49,$J(PSATDISP,6,0),?60,$J(PSATADJ,6,0),?73,$J(PSATTF,6,0),!,PSADLN,!
 G END
 ;
PRINT ;Prints in drug order.
 S PSAX="",PSAX=$O(^TMP("PSAMON",$J,PSAX)) I PSAX="" W !!,"<< NO DATA WAS FOUND. >>" G END
 S (PSATREC,PSATDISP,PSATADJ,PSATTF)=0
 S PSADRUG="" F  S PSADRUG=$O(^TMP("PSAMON",$J,PSADRUG)) Q:PSADRUG=""  D  Q:PSAOUT
 .D:$Y+4>IOSL HEADER Q:PSAOUT  S PSA=+^TMP("PSAMON",$J,PSADRUG)
 .W !,PSADRUG
 .W !?17 W:+$P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,2) $J($P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,2),6,0)
 .I '+$P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,2) S PSABAL=$P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,4) W $J($S($G(PSABAL):PSABAL,1:0),6,0)
 .W ?26,$J($S($P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,4)]"":$P($G(^(0)),U,4),1:$P($G(^PSD(58.8,PSALOC,1,PSA,0)),U,4)),6,0)
 .S PSAREC=$P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,3),PSATREC=PSATREC+PSAREC W ?36,$J(PSAREC,6,0)
 .S PSADISP=$P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,6),PSATDISP=PSATDISP+PSADISP W ?49,$J(PSADISP,6,0)
 .S PSADJ=$P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,5),PSATADJ=PSATADJ+PSADJ W ?60,$J(PSADJ,6,0)
 .S PSATF=$P($G(^PSD(58.8,PSALOC,1,PSA,5,PSAMON,0)),U,9),PSATTF=PSATTF+PSATF W ?73,$J(PSATF,6,0),!
 .W:$O(^TMP("PSAMON",$J,PSADRUG))'="" PSASLN W:$O(^TMP("PSAMON",$J,PSADRUG))="" PSADLN
 .I PSATOT D
 ..S $P(^TMP("PSAG",$J,PSADRUG),"^")=$P($G(^TMP("PSAG",$J,PSADRUG)),"^")+PSAREC,$P(^(PSADRUG),"^",2)=$P($G(^(PSADRUG)),"^",2)+PSADISP
 ..S $P(^TMP("PSAG",$J,PSADRUG),"^",3)=$P($G(^TMP("PSAG",$J,PSADRUG)),"^",3)+PSADJ,$P(^(PSADRUG),"^",4)=$P($G(^(PSADRUG)),"^",4)+PSATF
 Q
 ;
END ;End of page
 I $E($G(IOST))="C",'$G(PSAOUT) D
 .S PSAS=22-$Y F PSASS=1:1:PSAS W !
 .S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR K DIR I $G(DIRUT) S PSAOUT=1
 W @IOF I 'PSAOUT,PSATOT D ^PSAMON1
 ;
END1 ;Kills variables at end of report
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K IO("Q"),^TMP("PSAD",$J),^TMP("PSAG",$J),^TMP("PSAMON",$J)
 K %ZIS,DIC,DIRUT,DTOUT,DUOUT,PSA,PSABAL,PSACHK,PSACNT,PSACOMB,PSAD,PSADISP,PSADJ,PSADLN,PSADONE,PSADRUG,PSADT,PSAGADJ,PSAGDISP,PSAGREC,PSAGTF,PSAHIS
 K PSAISIT,PSAISITN,PSALOC,PSALOCA,PSALOCN,PSAMENU,PSAMON,PSAMONN,PSANODE,PSANUM,PSAOSIT,PSAOSITN,PSAOUT,PSAPC,PSAPC1,PSAPCS,PSAPICK
 K PSAREC,PSAPG,PSARPDT,PSAS,PSASEL,PSASLN,PSAS,PSASS,PSASUB,PSATABH,PSATADJ,PSATDISP,PSATF,PSATOT,PSATREC,PSATTF,PSAX,X,Y,ZTDESC,ZTRTN
 Q
 ;
HEADER ;prints header info
 I $E(IOST,1,2)="C-",PSAPG S DIR(0)="E" D  Q:PSAOUT
 .S PSAS=22-$Y F PSASS=1:1:PSAS W !
 .S DIR(0)="E" D ^DIR K DIR I $G(DIRUT) S PSAOUT=1
 I $$S^%ZTLOAD W !!,"Task #",$G(ZTSK),", ",$G(ZTDESC)," was stopped by ",$P($G(^VA(200,+$G(DUZ),0)),U),"." S PSAOUT=1 Q
 I $E(IOST,1,2)="C-" W @IOF
 I $E(IOST)'="C",PSAPG W @IOF
 S PSAPG=PSAPG+1 W:$E(IOST)'="C" !,PSARPDT W:$E(IOST,1,2)="C-" !
 W ?20,"DRUG ACCOUNTABILITY/INVENTORY INTERFACE",?71,"PAGE: ",PSAPG
 W !?22,"MONTHLY SUMMARY REPORT FOR "_PSAMONN
 W:$L(PSALOCN)>79 !!,$P(PSALOCN,"(IP)",1)_"(IP)",!?17,$P(PSALOCN,"(IP)",2)
 W:$L(PSALOCN)<80 !?((80-$L(PSALOCN))/2),PSALOCN
 W !!,?14,"BEGINNING",?26,"ENDING",?36,"TOTAL",?48,"TOTAL",?60,"TOTAL",?72,"TOTAL"
 W !,"DRUG",?16,"BALANCE",?25,"BALANCE",?34,"RECEIVED",?46,"DISPENSED",?58,"ADJUSTED",?69,"TRANSFERRED"
 W !,PSADLN
 Q
 ;
SUMHELP ;Extended help to 'Print summary report?'
 W !!?5,"Enter YES to print a report with the totals for each selected drug",!?5,"in all the pharmacy locations that were selected. A total line will"
 W !?5,"print for the total dispense units received, dispensed, adjusted,",!?5,"and transferrred during the selected month."
 W !!?5,"Enter NO to print each pharmacy location's report without the",!?5,"summary report."
 Q
