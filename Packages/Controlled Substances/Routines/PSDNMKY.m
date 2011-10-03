PSDNMKY ;DOIFO/CMS - CSM Security Key Print ;18 Dec 02
 ;;3.0; CONTROLLED SUBSTANCES ;*41*;13 Feb 97
 ;Reference to ^XUSEC( supported by IA #1095
 Q
 ;
ST ;CS Monitoring OPTION ENTRY
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,POP,X,Y,ZTIO,ZTSK,ZTRTN,ZTDESC,%,%ZIS
 W !!,?5,"This report lists current holders of the"
 W !,?5,"PSJ RPHARM and/or PSDMGR security keys.",!!
 S DIR("A")="Okay to Continue",DIR("B")="No",DIR(0)="Y" D ^DIR
 I Y'=1 W "     <No report>",! G END
 ;
 K IO("Q") S %ZIS="MQ" D ^%ZIS I POP W "  <No device selected.>" G END
 I $D(IO("Q")) D
 .S ZTRTN="DQ^PSDNMKY",ZTDESC="CS Monitoring - PSDNMKY"
 .D ^%ZTLOAD W !!?5,"TASK #",$G(ZTSK)," QUEUED!",!
 I '$D(IO("Q")) U IO D DQ
 K IOP,IO("Q")
END Q
 ;
 ;
HD ;Report heading
 N PSDH,X,Y,%
 W @IOF,$$CJ^XLFSTR("CS Monitoring - Security Key Report",IOM)
 S PSDH="SECURITY KEY: "_$S(PSDK="BOTH":"PSDMGR & PSJ RPHARM",1:PSDK)
 W !,$$CJ^XLFSTR(PSDH,IOM)
 W !,"Station: ",$G(PSDIV),?20,"Report Run Date: "
 S PSDPG=PSDPG+1
 D NOW^%DTC W $$FMTE^XLFDT(%),?65,"PAGE: ",PSDPG
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
DQ ;Report Run
 N D0,DA,DIC,DIQ,DR
 N PSDIV,PSDK,PSDN,PSDO,PSDOUT,PSDPG,PSDS,PSDT,PSDTI,PSDX,PSDY,X,Y,%
 K ^TMP("PSDNMKY",$J)
 I IOST?1"C-".E W !!,?10,"Compiling report, please wait ..."
 S PSDX=0
 F  S PSDX=$O(^XUSEC("PSDMGR",PSDX)) Q:'PSDX  D
 . S PSDN=$G(^VA(200,PSDX,0)) I PSDN']"" Q
 . S DA=PSDX,DR=".01;8;9.2;29",DIQ="PSDO",DIQ(0)="E",DIC="^VA(200,"
 . K PSDO D EN^DIQ1
 . S PSDN=$G(PSDO(200,PSDX,.01,"E"))
 . S PSDN=$S(PSDN]"":PSDN,1:"NO NAME (ien="_+PSDX_")")
 . S PSDTI=$G(PSDO(200,PSDX,8,"E"))
 . S PSDTI=$S(PSDTI]"":PSDTI,1:"UNKNOWN")
 . S PSDT=$G(PSDO(200,PSDX,9.2,"E"))
 . S PSDS=$G(PSDO(200,PSDX,29,"E"))
 . S PSDS=$S(PSDS]"":PSDS,1:"UNKNOWN")
 . I $D(^XUSEC("PSJ RPHARM",PSDX)) D  Q
 . . S ^TMP("PSDNMKY",$J,"BOTH",PSDS,$P(PSDN,U,1),PSDX)=PSDTI_U_PSDT
 . S ^TMP("PSDNMKY",$J,"PSDMGR",PSDS,$P(PSDN,U,1),PSDX)=PSDTI_U_PSDT
 ;
 S PSDX=0
 F  S PSDX=$O(^XUSEC("PSJ RPHARM",PSDX)) Q:'PSDX  D
 . S PSDN=$G(^VA(200,PSDX,0)) I PSDN']"" Q
 . S DA=PSDX,DR=".01;8;9.2;29",DIQ="PSDO",DIQ(0)="E",DIC="^VA(200,"
 . K PSDO D EN^DIQ1
 . S PSDN=$G(PSDO(200,PSDX,.01,"E"))
 . S PSDN=$S(PSDN]"":PSDN,1:"NO NAME (ien="_+PSDX_")")
 . S PSDTI=$G(PSDO(200,PSDX,8,"E"))
 . S PSDTI=$S(PSDTI]"":PSDTI,1:"UNKNOWN")
 . S PSDT=$G(PSDO(200,PSDX,9.2,"E"))
 . S PSDS=$G(PSDO(200,PSDX,29,"E"))
 . S PSDS=$S(PSDS]"":PSDS,1:"UNKNOWN")
 . I $D(^XUSEC("PSDMGR",PSDX)) D  Q
 . .  S ^TMP("PSDNMKY",$J,"BOTH",PSDS,$P(PSDN,U,1),PSDX)=PSDTI_U_PSDT
 . S ^TMP("PSDNMKY",$J,"PSJ RPHARM",PSDS,$P(PSDN,U,1),PSDX)=PSDTI_U_PSDT
 ;
 ;Report print
 S PSDPG=0,PSDOUT=0,PSDIV=+$$SITE^VASITE
 I '$D(^TMP("PSDNMKY",$J)) S PSDK="BOTH" D HD,PHD W !!,?10,"<<<< NO DATA FOUND >>>>",! G DQQ
 S PSDK=""
 F  S PSDK=$O(^TMP("PSDNMKY",$J,PSDK)) Q:(PSDK="")!(PSDOUT)  D
 .  S PSDPG=0 D HD,PHD
 .  S PSDS=""
 .  F  S PSDS=$O(^TMP("PSDNMKY",$J,PSDK,PSDS)) Q:(PSDS="")!(PSDOUT)  D
 . . I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 . . W !!,"SERVICE/SECTION: ",PSDS
 .  .  S PSDN=""
 .  .  F  S PSDN=$O(^TMP("PSDNMKY",$J,PSDK,PSDS,PSDN)) Q:(PSDN="")!(PSDOUT)  D
 .  .  .  S PSDX=0
 .  .  .  F  S PSDX=$O(^TMP("PSDNMKY",$J,PSDK,PSDS,PSDN,PSDX)) Q:('PSDX)!(PSDOUT)  D
 .  .  .  .  S PSDY=$G(^TMP("PSDNMKY",$J,PSDK,PSDS,PSDN,PSDX))
 .  .  .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  .  .  W !,?3,PSDN,?35,$P(PSDY,U,1),?65,$P(PSDY,U,2)
 .  I '$G(PSDOUT),$O(^TMP("PSDNMKY",$J,PSDK))]"" D PAGE
 ;
DQQ K ^TMP("PSDNMKY",$J) D ^%ZISC Q
 ;
PHD W !,?3,"Name",?35,"Title",?64,"Termination Date"
 W !,$$REPEAT^XLFSTR("_",IOM)
 Q
PAGE ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 I IOST?1"C-".E S DIR(0)="E" D ^DIR W !
 I ($D(DTOUT))!($D(DIRUT)) S PSDOUT=1 Q:$G(PSDOUT)=1
 Q 
 ;
EOR ;PSDNMKY - CSM Security Key Print; 18 DEC 02
