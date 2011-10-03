PSDNMBA ;DOIFO/CMS - CSM Balance Adjustments ;18 Dec 02
 ;;3.0; CONTROLLED SUBSTANCES ;*41*;13 Feb 97
 ;Reference to ^PSD(58.81 supported by IA #2808
 ;Reference to ^PSDRUG( supported by IA #221
 ;Reference to ^PSD(58.84 supported by IA #3485
 Q
 ;
ST ;CS Monitoring OPTION ENTRY
 N PSDA,PSDIDIV,PSDPLOC,PSDCII,PSDED,PSDOUT,PSDDTN,PSDSD,PSDSITE,X,Y,%
 N DIC,DIR,DIRUT,DIROUT,DTOUT,DUOUT,POP,ZTIO,ZTSAVE,ZTSK,ZTRTN,ZTDESC,%ZIS
 W !!,?5,"This report lists Drug Accountability Balance Adjustments"
 W !,?5,"made for the Inpatient Site Pharmacy Location(s) entered.",!!
 S PSDA=$O(^PSD(58.84,"B","BALANCE ADJUSTMENT",0))
 I 'PSDA W !!,"<< Drug Accountability Transaction Type, Balance Adjustment, not defined! >>" G END
 D INPS^PSDNMU I '$G(PSDIDIV)!($G(PSDOUT)) G END
 W ! S DIR("A")="Select 'ALL' "_$P(PSDIDIV,U,2)_" Pharmacy locations"
 S DIR("B")="Yes",DIR(0)="Y" D ^DIR I X="^"!($D(DTOUT)) G END
 I Y'=1 W ! D PLOC^PSDNMU I '$O(PSDPLOC(0))!($G(PSDOUT)) G END
 I Y=1 D PLOCA^PSDNMU
 ;
 S PSDDTN="Balance Adjustment" D DATE^PSDNMU I '$G(PSDSD)!($G(PSDOUT)) G END
 W ! K DIR S DIR("A")="Okay to Continue",DIR("B")="No",DIR(0)="Y" D ^DIR
 I Y'=1 W "     <No report>",! G END
 W !!,?9,"This report should be queued to run during non-peak hours.",!
 K IO("Q") S %ZIS="MQ" D ^%ZIS I POP W "  <No device selected.>" G END
 I $D(IO("Q")) D
 .S ZTRTN="DQ^PSDNMBA",ZTDESC="CS Monitoring - PSDNMBA"
 .S ZTSAVE("PSDSD")="",ZTSAVE("PSDPLOC(")="",ZTSAVE("PSDED")="",ZTSAVE("PSDIDIV")=""
 .D ^%ZTLOAD W !!?5,"TASK #",$G(ZTSK)," QUEUED!",!
 I '$D(IO("Q")) U IO D DQ
 K IOP,IO("Q")
END Q
 ;
HD ;Report heading
 N PSDY,X,Y,%
 W @IOF,$$CJ^XLFSTR("CS Monitoring - Balance Adjustments Report",IOM)
 S PSDY="Inpatient site: "_$P(PSDIDIV,U,2)
 I $G(PSDPLOC)="^ALL" S PSDY=PSDY_" all Pharmacy Locations"
 W !,$$CJ^XLFSTR(PSDY,IOM)
 W !,$$CJ^XLFSTR("Balance Adjustments made: "_$P(PSDSD,U,2)_" thru "_$P(PSDED,U,2),IOM)
 S PSDPG=PSDPG+1
 D NOW^%DTC W !,"Report Run: "_$E($$FMTE^XLFDT(%),1,18),?70,"PAGE: ",PSDPG
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
DQ ;Report Run
 N DFN,PSDA,PSDFD,PSDI,PSDIDT,PSDIV,PSDOUT,PSDP,PSDPG,PSDS,PSDRG,PSDUZ
 N PSDX,PSDX0,PSDX2,PSDXOR1,PSDY,X,Y,%
 K ^TMP("PSDNMBA",$J)
 I IOST?1"C-".E W !!,?10,"Compiling report, please wait ..."
 S PSDA=$O(^PSD(58.84,"B","BALANCE ADJUSTMENT",0)) I 'PSDA G DQQ
 S PSDP=0
 F  S PSDP=$O(PSDPLOC(PSDP)) Q:'PSDP  S ^TMP("PSDNMBA",$J,PSDPLOC(PSDP))=""
 S PSDFD=+PSDSD
 F  S PSDFD=$O(^PSD(58.81,"AF",PSDFD)) Q:('PSDFD)!(PSDFD]+PSDED)  D
 . S PSDP=0
 . F  S PSDP=$O(PSDPLOC(PSDP)) Q:'PSDP  D
 . . S PSDX=0
 . . F  S PSDX=$O(^PSD(58.81,"AF",PSDFD,PSDP,PSDA,PSDX)) Q:'PSDX  D
 . . . S PSDX0=$G(^PSD(58.81,PSDX,0)) I PSDX0']"" Q
 . . . S PSDRG=$G(^PSDRUG(+$P(PSDX0,U,5),0))
 . . . S PSDUZ=+$P(PSDX0,U,7),PSDUZ=$P($G(^VA(200,+PSDUZ,0)),U,1)
 . . . S Y=PSDFD D D^DIQ S PSDS=Y
 . . . S ^TMP("PSDNMBA",$J,PSDPLOC(PSDP),PSDUZ,PSDX)=$P(PSDX0,U,1)_U_$E(PSDS,1,18)_U_$P(PSDX0,U,6)_U_$P(PSDRG,U,1)_U_$P(PSDX0,U,16)
 ;
PRT ;Report print
 S PSDPG=0,PSDOUT=0
 I '$D(^TMP("PSDNMBA",$J)) D  G DQQ
 . S PSDIV="",PSDPG=1 D HD,PHD
 . W !!,?10,"<<<< NO DATA FOUND >>>>",!
 S PSDIV=""
 D HD,PHD
 F  S PSDIV=$O(^TMP("PSDNMBA",$J,PSDIV)) Q:(PSDIV="")!(PSDOUT)  D
 .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  W !!,"Pharmacy Location: ",PSDIV
 .  S PSDS=""
 .  I $O(^TMP("PSDNMBA",$J,PSDIV,PSDS))']"" W !,?19,"NO DATA FOUND" Q
 .  F  S PSDS=$O(^TMP("PSDNMBA",$J,PSDIV,PSDS)) Q:(PSDS="")!(PSDOUT)  D
 .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  W !!,"TRANSACTOR: ",PSDS
 .  .  S PSDX=0
 .  .  F  S PSDX=$O(^TMP("PSDNMBA",$J,PSDIV,PSDS,PSDX)) Q:('PSDX)!(PSDOUT)  D
 .  .  .  S PSDY=$G(^TMP("PSDNMBA",$J,PSDIV,PSDS,PSDX))
 .  .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  .  W !,$P(PSDY,U,1),?10,$P(PSDY,U,2),?33,$P(PSDY,U,3),?40,$P(PSDY,U,4)
 .  .  .  W !,?10,"Reason: ",$P(PSDY,U,5)
 ;
DQQ W ! K PSDCII,PSDIDIV,PSDPLOC,PSDSD,PSDED,^TMP("PSDNMBA",$J) D ^%ZISC Q
 ;
PHD ;
 W !,"Trans. #",?10,"Date",?28,"Quantity",?40,"Drug"
 W !,$$REPEAT^XLFSTR("_",IOM)
 Q
PAGE ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 I IOST?1"C-".E S DIR(0)="E" D ^DIR W !
 I ($D(DTOUT))!($D(DIRUT)) S PSDOUT=1 Q:$G(PSDOUT)=1
 Q
 ;
EOR ;PSDNMBA - CSM Balance Adjustments; 18 DEC 02
