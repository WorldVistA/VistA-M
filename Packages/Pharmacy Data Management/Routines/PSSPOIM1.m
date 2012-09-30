PSSPOIM1 ;BIR/RTR,WRT-Manual create of Orderable Item continued ; 4/28/09 4:36pm
 ;;1.0;PHARMACY DATA MANAGEMENT;**29,38,47,141,153,159**;9/30/97;Build 29
 ;
CHK S PSNO=0 I $G(PSMAN) W !!,"Matching ",PSNAME,!,"   to",!,SPHOLD," ",$P($G(^PS(50.606,+DOSEPTR,0)),"^"),!
 I '$G(PSMAN) S PSMC=$P($G(^PS(50.7,PSSP,0)),"^") W !!,"Matching ",PSNAME,!,"   to",!,PSMC," ",$P($G(^PS(50.606,+$P(^PS(50.7,PSSP,0),"^",2),0)),"^"),!
 K DIR S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK" D ^DIR
 K PSMAN S:Y=0 PSNO=1 I Y'=1,'PSNO S PSOUT=1
 Q
END K ^TMP($J,"PSSOO"),PSSSSS,PSCREATE,^TMP("PSSLOOP",$J)
 K AAA,ANS,APLU,COMM,DA,DIC,DIE,DOSEFORM,DOSEFV,DOSEPTR,DR,FFF,MATCH,NEWSP,NODE,NOFLAG,OTH,POINT,PSCNT,PSIEN,PSMAN,PSMC,PSNAME,PSNO,PSSP,PSND,PSOUT,SPHOLD,SPR,TMPTR,TT,VAGEN,X,Y,ZZ,PSOOOUT,PSXDATE,PSXADATE,PSXSDATE,AAAAA,BBBBB,ZXX,PSXDDATE Q
MESS W !!,"This option enables you to match Dispense Drugs to an entry in the Pharmacy",!,"Orderable Item file, or create a new Pharmacy Orderable Item entry for a",!,"Dispense Drug.",! Q
MESSZ S ^TMP("PSSLOOP",$J,DUZ)="" W !!,"This option is for matching IV Additives, IV Solutions, and all Dispense Drugs",!,"marked with an I, O, or U in the Application Packages' Use field to an",!,"Orderable Item."
 W !,"You will need to keep accessing this option until all drugs are matched.",!,"A check will be done every time this option is exited to see if the matching",!,"process is complete.",!!
 K DIR S DIR(0)="E" D ^DIR K DIR I X["^"!($D(DTOUT)) S PSOUT=1
 Q
CHECK W !!!,"Checking Drug files, please wait..."
 S X1=DT,X2=-365 D C^%DTC S PSZXDATE=X,DONEFLAG=1
 F FFFF=0:0 S FFFF=$O(^PSDRUG(FFFF)) Q:'FFFF!('DONEFLAG)  S QQNM=$P($G(^PSDRUG(FFFF,0)),"^") I QQNM'="",$D(^PSDRUG("B",QQNM)) D  I ZZG I USAGE["O"!(USAGE["I")!(USAGE["U") I '$P($G(^PSDRUG(FFFF,2)),"^") S DONEFLAG=0
 .S USAGE=$P($G(^PSDRUG(FFFF,2)),"^",3)
 .S ZZG=1 S PSZZDATE=+$P($G(^PSDRUG(FFFF,"I")),"^") I PSZZDATE,PSZZDATE<PSZXDATE S ZZG=0
 I DONEFLAG=1 D
 .F QQQ=0:0 S QQQ=$O(^PS(52.6,QQQ)) Q:'QQQ!('DONEFLAG)  S PSZNAME=$P($G(^PS(52.6,QQQ,0)),"^") I PSZNAME'="",$D(^PS(52.6,"B",PSZNAME)),$P($G(^PS(52.6,QQQ,0)),"^",2),'$P($G(^(0)),"^",11) D  I ZZG S DONEFLAG=0
 ..S ZZG=1 S PSZZDATE=+$P($G(^PS(52.6,QQQ,"I")),"^") I PSZZDATE,PSZZDATE<PSZXDATE S ZZG=0
 .I DONEFLAG F QQQ=0:0 S QQQ=$O(^PS(52.7,QQQ)) Q:'QQQ!('DONEFLAG)  S PSZNAME=$P($G(^PS(52.7,QQQ,0)),"^") I PSZNAME'="",$D(^PS(52.7,"B",PSZNAME)),$P($G(^PS(52.7,QQQ,0)),"^",2),'$P($G(^(0)),"^",11) D  I ZZG S DONEFLAG=0
 ..S ZZG=1 S PSZZDATE=+$P($G(^PS(52.7,QQQ,"I")),"^") I PSZZDATE,PSZZDATE<PSZXDATE S ZZG=0
MAIL I DONEFLAG W !!!,?3,"You are finished matching to the Orderable Item File!",!!,"A clean-up job is being queued now, and when it is finished, you will"
 I  W !,"receive a mail message informing you of its completion.",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 I $G(DONEFLAG) S PSSOMAIL=1,PSOUDUZ=DUZ S ZTRTN="DATE^PSSPOIM1",ZTIO="",ZTDTH=$H,ZTDESC="ORDERABLE ITEM CLEAN UP",ZTSAVE("DUZ")="",ZTSAVE("PSSOMAIL")="" D ^%ZTLOAD
 I 'DONEFLAG W $C(7),$C(7),!!?5,"There are still Drugs not matched, you will need to come back",!?5,"and continue matching Drugs!",! K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 K DONEFLAG,QQQ,QQNM,PSZZDATE,PSZXDATE,ZZG,USAGE,FFFF,PSZNAME Q
OTHER W @IOF W !,"There are other Dispense Drugs with the same VA Generic Name and same Dose",!,"Form already matched to orderable items. Choose a number to match, or enter",!,"'^' to enter a new one.",!!?6,"Disp. drug -> ",PSNAME,! Q
EN(PSVAR) ;
 W !?3,"Now editing Orderable Item:",!?3,$P(^PS(50.7,PSVAR,0),"^"),"   ",$P($G(^PS(50.606,+$P(^(0),"^",2),0)),"^")
 W ! K DIE N MFLG S PSBEFORE=$P(^PS(50.7,PSVAR,0),"^",4),PSBEFORE1=+$P(^PS(50.7,PSVAR,0),"^",2),PSAFTER=0,PSINORDE=""
 S PSSOTH=$P($G(^PS(59.7,1,40.2)),"^"),DIE="^PS(50.7,",DIE("NO^")="BACK"
 S DR="5;6;.04;.05;@3;.06;D DFR^PSSPOIMO(PSBEFORE1),DFRL^PSSPOIMO;10//YES;I X=""Y"" S Y=""@2"";D PDCHK^PSSPOIMO;I $$DP^PSSPOIMO(PSVAR) S Y=""@3"";@2;.07;.08;7;S:'$G(PSSOTH) Y=""@1"";7.1;@1",DA=PSVAR
 D ^DIE S PSAFTER=$P(^PS(50.7,PSVAR,0),"^",4) K DIE,PSSOTH
 S:PSBEFORE&('PSAFTER) PSINORDE="D" S:PSAFTER PSINORDE="I"
 I PSINORDE'="" D REST^PSSPOIDT(PSVAR)
 K PSBEFORE,PSBEFORE1,PSAFTER,PSINORDE
IMMUN ;PSS*1*141 FOR 'IMMUNIZATIONS DOCUMENTATION BY BCMA'
 I $O(^PSDRUG("AOC",PSVAR,"IM000"))'["IM" G SYN ;ASK WHEN APPROPRIATE
 W ! S DIE="^PS(50.7,",DA=PSVAR,DR=9 D ^DIE K DIE
SYN W ! K DIC S:'$D(^PS(50.7,PSVAR,2,0)) ^PS(50.7,PSVAR,2,0)="^50.72^0^0" S DIC="^PS(50.7,"_PSVAR_",2,",DA(1)=PSVAR,DIC(0)="QEAMZL",DIC("A")="Select SYNONYM: ",DLAYGO=50.72 D ^DIC K DIC
 I Y<0!($D(DTOUT))!($D(DUOUT)) K:'$O(^PS(50.7,PSVAR,2,0)) ^PS(50.7,PSVAR,2,0) G FIN
 W ! S DA=+Y,DIE="^PS(50.7,"_PSVAR_",2,",DA(1)=PSVAR,DR=.01 D ^DIE K DIE G SYN
FIN D EN^PSSPOIDT(PSVAR) I $G(PSVAR1) D EN2^PSSHL1(PSVAR,"MAD") G FINS
 D EN2^PSSHL1(PSVAR,"MUP")
FINS K PSVAR,PSVAR1 Q
 ;
DATE ;
 F ZZZ=0:0 S ZZZ=$O(^PS(50.7,ZZZ)) Q:'ZZZ  S PSOTYPE=$P($G(^PS(50.7,ZZZ,0)),"^",3) D
 .I PSOTYPE,'$D(^PS(52.6,"AOI",ZZZ)),'$D(^PS(52.7,"AOI",ZZZ)),'$P($G(^PS(50.7,ZZZ,0)),"^",4) K DIE S DIE="^PS(50.7,",DA=ZZZ,DR=".04////"_DT D ^DIE K DIE Q
 .Q:PSOTYPE
 .D SUPP
 .I '$D(^PSDRUG("ASP",ZZZ)),'$P($G(^PS(50.7,ZZZ,0)),"^",4) K DIE S DIE="^PS(50.7,",DA=ZZZ,DR=".04////"_DT D ^DIE K DIE Q
 .D:'$P($G(^PS(50.7,ZZZ,0)),"^",4)
 ..S PSDFLAG=0 F WW=0:0 S WW=$O(^PSDRUG("ASP",ZZZ,WW)) Q:'WW!(PSDFLAG)  S PSAPPL=$P($G(^PSDRUG(WW,2)),"^",3) I PSAPPL["I"!(PSAPPL["O")!(PSAPPL["U") S PSDFLAG=1
 ..I 'PSDFLAG K DIE S DIE="^PS(50.7,",DA=ZZZ,DR=".04////"_DT D ^DIE K DIE
 F ZZZ=0:0 S ZZZ=$O(^PS(52.7,ZZZ)) Q:'ZZZ  S RRRR=$P($G(^PS(52.7,ZZZ,0)),"^",11) I RRRR,'$P($G(^PS(50.7,RRRR,0)),"^",3) K DIE S DA=ZZZ,DIE="^PS(52.7,",DR="9////"_"@" D ^DIE K DIE
 F ZZZ=0:0 S ZZZ=$O(^PS(52.6,ZZZ)) Q:'ZZZ  S RRRR=$P($G(^PS(52.6,ZZZ,0)),"^",11) I RRRR,'$P($G(^PS(50.7,RRRR,0)),"^",3) K DIE S DA=ZZZ,DIE="^PS(52.6,",DR="15////"_"@" D ^DIE K DIE
 D:$G(PSCREATE) MAIL^PSSCREAT
 I '$G(PSSOMAIL) K PSOTYPE,DA,DIE,WW,RRRR,PSDFLAG,PSAPPL,GGG,HHH,ZZZZZ Q
 S PSOTEXT(1)="You have completed the matching process required for the installation of",PSOTEXT(2)="Outpatient V. 7.0 and Inpatient Medications V. 5.0!"
 S XMDUZ=.5,XMY(DUZ)="",XMTEXT="PSOTEXT(",XMSUB="Pharmacy Orderable Item File" D ^XMD
 S PSSITE=+$O(^PS(59.7,0)) S $P(^PS(59.7,PSSITE,80),"^",2)=3 K PSSITE
 D ^%ZISC K PSOTYPE,DA,DIE,WW,RRRR,PSDFLAG,PSAPPL,GGG,HHH,ZZZZZ,PSSOMAIL S:$D(ZTQUEUED) ZTREQ="@" Q
RMES W !!,"This report takes a long time to first build the data to print, then to",!,"actually print the data. To avoid tying up a terminal for a long period of time,",!,"the report must be QUEUED to a printer."
 W !!,"This report must be QUEUED to a printer!"
 Q
KMES W !!,"Due to the length of this report, and to avoid tying up a terminal for a long",!,"time, this report must be QUEUED to a printer!"
 Q
SUPP ;Mark as supply
 N SSSUP,SSSIN,SSSAP,SSLOOP,SSSQUE,SSSQUEY,SSSQDATE,SLIP,SLDO,SLDP
 S (SSSQUE,SSSQUEY)=0 F SSLOOP=0:0 S SSLOOP=$O(^PSDRUG("ASP",ZZZ,SSLOOP)) Q:'SSLOOP!(SSSQUEY)  D
 .I $P($G(^PSDRUG(SSLOOP,0)),"^",3)["S" S SSSAP=$P($G(^(2)),"^",3),SSSIN=$P($G(^("I")),"^") D
 ..I SSSAP["O"!(SSSAP["I")!(SSSAP["U") I 'SSSIN S $P(^PS(50.7,ZZZ,0),"^",9)=1 S (SSSQUEY,SSSQUE)=1 Q
 ..I SSSAP["O"!(SSSAP["I")!(SSSAP["U") I +SSSIN>DT S $P(^PS(50.7,ZZZ,0),"^",9)=1 S SSSQUE=1,SSSQDATE($E(SSSIN,1,7))=""
 I 'SSSQUEY,SSSQUE,$O(SSSQDATE(0)) F SLIP=0:0 S SLIP=$O(SSSQDATE(SLIP)) Q:'SLIP  D
 .S ZTRTN="ENT^PSSPOIDT",ZTDESC="Supply update for Orderable Item",ZTIO="",ZTDTH=SLIP_.01 S SLDO=$G(PSSORDIT),SLDP=$G(PSSCROSS) S PSSORDIT=ZZZ,PSSCROSS=1 S ZTSAVE("PSSORDIT")="",ZTSAVE("PSSCROSS")="" D ^%ZTLOAD D
 ..S PSSORDIT=$G(SLDO) K:'PSSORDIT PSSORDIT
 ..S PSSCROSS=$G(SLDP) K:'PSSCROSS PSSCROSS
