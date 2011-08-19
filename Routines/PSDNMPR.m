PSDNMPR ;DOIFO/CMS - CSM Partial Request ;18 Dec 02
 ;;3.0; CONTROLLED SUBSTANCES ;*41*;13 Feb 97
 ;Reference to ^PSDRUG( supported by IA #221
 ;Reference to ^PS(59 supported by IA #2621
 ;Reference to ^PSRX( supported by IA #1977
 Q
 ;
ST ;CS Monitoring OPTION ENTRY
 N PSDODIV,PSDCII,PSDED,PSDFED,PSDFSD,PSDOUT,PSDDTN,PSDSD,X,Y,%
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,POP,ZTIO,ZTSAVE,ZTSK,ZTRTN,ZTDESC,%ZIS
 W !!,?5,"This report lists CS Prescriptions with Partial Fill"
 W !,?5,"request activity within the fill date range entered.",!!
 W ! D DIV^PSDNMU I '$O(PSDODIV(0))!($G(PSDOUT)) G END
 S PSDDTN="Fill" D DATE^PSDNMU I '$G(PSDSD)!($G(PSDOUT)) G END
 S PSDFSD=PSDSD,PSDFED=PSDED
 W ! D CII^PSDNMU I $G(PSDOUT) G END
 ;
 W ! S DIR("A")="Okay to Continue",DIR("B")="No",DIR(0)="Y" D ^DIR
 I Y'=1 W "     <No report>",! G END
 W !!,?9,"This report should be queued to run during non-peak hours.",!
 K IO("Q") S %ZIS="MQ" D ^%ZIS I POP W "  <No device selected.>" G END
 I $D(IO("Q")) D
 .S ZTRTN="DQ^PSDNMPR",ZTDESC="CS Monitoring - PSDNMPR"
 .S ZTSAVE("PSDODIV(")="",ZTSAVE("PSDCII")="",ZTSAVE("PSDFSD")="",ZTSAVE("PSDFED")=""
 .D ^%ZTLOAD W !!?5,"TASK #",$G(ZTSK)," QUEUED!",!
 I '$D(IO("Q")) U IO D DQ
 K IOP,IO("Q")
END Q
 ;
HD ;Report heading
 N PSDD,PSDL,X,Y,%
 W @IOF,$$CJ^XLFSTR("CS Monitoring - Partial Request Report",IOM)
 S PSDL="Outpatient Division(s): "
 S PSDD=0
 F  S PSDD=$O(PSDODIV(PSDD)) Q:'PSDD  S PSDL=PSDL_$P($G(PSDODIV(PSDD)),U,2) I $O(PSDODIV(PSDD)) S PSDL=PSDL_", "
 W !,$$CJ^XLFSTR(PSDL,IOM)
 W !,$$CJ^XLFSTR("Fill Date range: "_$P(PSDFSD,U,2)_" thru "_$P(PSDFED,U,2),IOM)
 S PSDL="Controlled Substance schedule(s): "
 F PSDD=1:1:4 I $P(PSDCII,",",PSDD) S PSDL=PSDL_$P(PSDCII,",",PSDD) I $P(PSDCII,",",(PSDD+1)) S PSDL=PSDL_", "
 I +PSDCII W !,$$CJ^XLFSTR(PSDL,IOM)
 W !,"Division: ",$E($G(PSDIV),1,13),?25,"Report Run Date: "
 S PSDPG=PSDPG+1
 D NOW^%DTC W $$FMTE^XLFDT(%),?70,"PAGE: ",PSDPG
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
DQ ;Report Run
 N PSDA,PSDFD,PSDI,PSDIDT,PSDIV,PSDOUT,PSDP,PSDPG,PSDRG,PSDUZ,PSDX,PSDX0,PSDX2,PSDXOR1,PSDY,X,Y,%
 K ^TMP("PSDNMPR",$J)
 I IOST?1"C-".E W !!,?10,"Compiling report, please wait ..."
 S PSDFD=+PSDFSD
 F  S PSDFD=$O(^PSRX("AD",PSDFD)) Q:('PSDFD)!(PSDFD]+PSDFED)  D
 . S PSDX=0
 . F  S PSDX=$O(^PSRX("AD",PSDFD,PSDX)) Q:'PSDX  D
 . . S PSDX0=$G(^PSRX(PSDX,0)) I PSDX0']"" Q
 . . S PSDX2=$G(^PSRX(PSDX,2))
 . . I '$D(PSDODIV(+$P(PSDX2,U,9))) Q
 . . S PSDRG=$G(^PSDRUG(+$P(PSDX0,U,6),0))
 . . S PSDP=0
 . . F PSDY=1:1:4 S PSDA=+$P(PSDCII,",",PSDY) I PSDA,$P(PSDRG,U,3)[PSDA S PSDP=1 Q
 . . I 'PSDP Q
 . . S PSDI=0
 . . F  S PSDI=$O(^PSRX(PSDX,"A",PSDI)) Q:'PSDI  D
 . . . S PSDA=$G(^PSRX(PSDX,"A",PSDI,0))
 . . . I $P(PSDA,U,2)'="P" Q
 . . . S Y=+PSDA D D^DIQ S $P(PSDA,U,1)=Y
 . . . S PSDUZ=$P($G(^VA(200,+$P(PSDA,U,3),0)),U,1)
 . . . S ^TMP("PSDNMPR",$J,$S(+$P(PSDX2,U,9):$P($G(^PS(59,+$P(PSDX2,U,9),0)),U,1),1:"UNKNOWN"),$P(PSDRG,U,1),PSDX,PSDI)=$P(PSDX0,U,1)_U_$P(PSDA,U,1)_U_PSDUZ_U_$P(PSDA,U,5)
 ;
PRT ;Report print
 S PSDPG=0,PSDOUT=0
 I '$D(^TMP("PSDNMPR",$J)) D  G DQQ
 . S PSDIV="" D HD,PHD
 . W !!,?10,"<<<< NO DATA FOUND >>>>",!
 S PSDIV=""
 F  S PSDIV=$O(^TMP("PSDNMPR",$J,PSDIV)) Q:(PSDIV="")!(PSDOUT)  D
 .  S PSDPG=0 D HD,PHD
 .  S PSDRG=""
 .  F  S PSDRG=$O(^TMP("PSDNMPR",$J,PSDIV,PSDRG)) Q:(PSDRG="")!(PSDOUT)  D
 .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  W !!,PSDRG
 .  .  S PSDX=0
 .  .  F  S PSDX=$O(^TMP("PSDNMPR",$J,PSDIV,PSDRG,PSDX)) Q:('PSDX)!(PSDOUT)  D
 .  .  .  S PSDA=0
 .  .  .  F  S PSDA=$O(^TMP("PSDNMPR",$J,PSDIV,PSDRG,PSDX,PSDA)) Q:('PSDA)!(PSDOUT)  D
 .  .  .  .  S PSDY=$G(^TMP("PSDNMPR",$J,PSDIV,PSDRG,PSDX,PSDA))
 .  .  .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  .  .  W !,$P(PSDY,U,1),?15,$P(PSDY,U,2),?40,$P(PSDY,U,3)
 .  .  .  .  W !,?15,$P(PSDY,U,4)
 .  I '$G(PSDOUT),$O(^TMP("PSDNMPR",$J,PSDIV))]"" D PAGE
 ;
DQQ W ! K PSDCII,PSDFED,PSDFSD,PSDODIV,^TMP("PSDNMPR",$J) D ^%ZISC Q
 ;
PHD ;
 W !,"RX#",?15,"Activity Log Date",?40,"Initiator of Activity"
 W !,?15,"Activity Log Comment"
 W !,$$REPEAT^XLFSTR("_",IOM)
 Q
PAGE ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 I IOST?1"C-".E S DIR(0)="E" D ^DIR W !
 I ($D(DTOUT))!($D(DIRUT)) S PSDOUT=1 Q:$G(PSDOUT)=1
 Q
 ;
EOR ;PSDNMPR - CSM Partial Request; 18 DEC 02
