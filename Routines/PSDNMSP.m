PSDNMSP ;DOIFO/CMS - CSM RX Processed by Same Person ;18 Dec 02
 ;;3.0; CONTROLLED SUBSTANCES ;*41*;13 Feb 97
 ;Reference to ^PSDRUG( supported by IA #221
 ;Reference to ^PS(59 supported by IA #2621
 ;Reference to ^PSRX( supported by IA #1977
 Q
 ;
ST ;CS Monitoring OPTION ENTRY
 N PSDODIV,PSDCII,PSDED,PSDOUT,PSDDTN,PSDSD,X,Y,%
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,POP,ZTIO,ZTSAVE,ZTSK,ZTRTN,ZTDESC,%ZIS
 W !!,?5,"This report lists CS prescriptions that were entered,"
 W !,?5,"finished and released by the same person.",!!
 W ! D DIV^PSDNMU I '$O(PSDODIV(0))!($G(PSDOUT)) G END
 S PSDDTN="Fill" D DATE^PSDNMU I '$G(PSDSD)!($G(PSDOUT)) G END
 W ! D CII^PSDNMU I $G(PSDOUT)!($G(PSDCII)']"") G END
 ;
 W ! S DIR("A")="Okay to Continue",DIR("B")="No",DIR(0)="Y" D ^DIR
 I Y'=1 W "     <No report>",! G END
 W !!,?9,"This report should be queued to run during non-peak hours.",!
 K IO("Q") S %ZIS="MQ" D ^%ZIS I POP W "  <No device selected.>" G END
 I $D(IO("Q")) D
 .S ZTRTN="DQ^PSDNMSP",ZTDESC="CS Monitoring - PSDNMSP"
 .S ZTSAVE("PSDED")="",ZTSAVE("PSDSD")="",ZTSAVE("PSDODIV(")="",ZTSAVE("PSDCII")=""
 .D ^%ZTLOAD W !!?5,"TASK #",$G(ZTSK)," QUEUED!",!
 I '$D(IO("Q")) U IO D DQ
 K IOP,IO("Q")
END Q
 ;
HD ;Report heading
 N PSDD,PSDL,X,Y,%
 W @IOF,$$CJ^XLFSTR("CS Monitoring - RX by Same Person Report",IOM)
 S PSDL="Outpatient Division(s): "
 S PSDD=0
 F  S PSDD=$O(PSDODIV(PSDD)) Q:'PSDD  S PSDL=PSDL_$P($G(PSDODIV(PSDD)),U,2) I $O(PSDODIV(PSDD)) S PSDL=PSDL_", "
 W !,$$CJ^XLFSTR(PSDL,IOM)
 W !,$$CJ^XLFSTR("Fill Date range: "_$P(PSDSD,U,2)_" thru "_$P(PSDED,U,2),IOM)
 S PSDL="Controlled Substance schedule(s): "
 F PSDD=1:1:4 I $P(PSDCII,",",PSDD) S PSDL=PSDL_$P(PSDCII,",",PSDD) I $P(PSDCII,",",(PSDD+1)) S PSDL=PSDL_", "
 I +PSDCII W !,$$CJ^XLFSTR(PSDL,IOM)
 W !,"Station: ",$E($G(PSDIV),1,13),?25,"Report Run Date: "
 S PSDPG=PSDPG+1
 D NOW^%DTC W $$FMTE^XLFDT(%),?70,"PAGE: ",PSDPG
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
DQ ;Report Run
 N PSDA,PSDFD,PSDIDT,PSDIV,PSDOUT,PSDP,PSDPG,PSDRG,PSDUZ,PSDX,PSDX0,PSDX2,PSDXOR1,PSDY,X,Y,%
 K ^TMP("PSDNMSP",$J)
 I IOST?1"C-".E W !!,?10,"Compiling report, please wait ..."
 S PSDFD=+PSDSD
 F  S PSDFD=$O(^PSRX("AD",PSDFD)) Q:('PSDFD)!(PSDFD]+PSDED)  D
 . S PSDX=0
 . F  S PSDX=$O(^PSRX("AD",PSDFD,PSDX)) Q:'PSDX  D
 . . S PSDX0=$G(^PSRX(PSDX,0)) I PSDX0']"" Q
 . . S PSDX2=$G(^PSRX(PSDX,2))
 . . I '$D(PSDODIV(+$P(PSDX2,U,9))) Q
 . . S PSDRG=$G(^PSDRUG(+$P(PSDX0,U,6),0))
 . . S PSDP=0
 . . F PSDY=1:1:4 S PSDA=+$P(PSDCII,",",PSDY) I PSDA,$P(PSDRG,U,3)[PSDA S PSDP=1 Q
 . . I 'PSDP Q
 . . S PSDUZ=+$P(PSDX0,U,16) I 'PSDUZ Q
 . . I PSDUZ'=+$P(PSDX2,U,3) Q
 . . S PSDXOR1=$G(^PSRX(PSDX,"OR1"))
 . . I PSDUZ'=+$P(PSDXOR1,U,5) Q
 . . S Y=PSDFD D D^DIQ S PSDIDT=Y
 . . S ^TMP("PSDNMSP",$J,$S(+$P(PSDX2,U,9):$P($G(^PS(59,+$P(PSDX2,U,9),0)),U,1),1:"UNKNOWN"),$P($G(^VA(200,+PSDUZ,0)),U,1),PSDX)=$P(PSDX0,U,1)_U_PSDIDT_U_$P(PSDRG,U,1)
 ;
PRT ;Report print
 S PSDPG=0,PSDOUT=0
 I '$D(^TMP("PSDNMSP",$J)) D  G DQQ
 . S PSDIV="" S PSDPG=0 D HD,PHD
 . W !!,?10,"<<<< NO DATA FOUND >>>>",!
 S PSDIV=""
 F  S PSDIV=$O(^TMP("PSDNMSP",$J,PSDIV)) Q:(PSDIV="")!(PSDOUT)  D
 .  S PSDPG=0 D HD,PHD
 .  S PSDUZ=""
 .  F  S PSDUZ=$O(^TMP("PSDNMSP",$J,PSDIV,PSDUZ)) Q:(PSDUZ="")!(PSDOUT)  D
 .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  W !!,PSDUZ
 .  .  S PSDX=0
 .  .  F  S PSDX=$O(^TMP("PSDNMSP",$J,PSDIV,PSDUZ,PSDX)) Q:('PSDX)!(PSDOUT)  D
 .  .  .  S PSDY=$G(^TMP("PSDNMSP",$J,PSDIV,PSDUZ,PSDX))
 .  .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  .  W !,$P(PSDY,U,1),?25,$P(PSDY,U,2),?40,$P(PSDY,U,3)
 .  I '$G(PSDOUT),$O(^TMP("PSDNMSP",$J,PSDIV))]"" D PAGE
 ;
DQQ W ! K PSDCII,PSDED,PSDODIV,PSDSD,^TMP("PSDNMSP",$J) D ^%ZISC Q
 ;
PHD W !,"Pharmacy User"
 W !,"RX#",?25,"Fill Date",?40,"Drug Name"
 W !,$$REPEAT^XLFSTR("_",IOM)
 Q
PAGE ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 I IOST?1"C-".E S DIR(0)="E" D ^DIR W !
 I ($D(DTOUT))!($D(DIRUT)) S PSDOUT=1 Q:$G(PSDOUT)=1
 Q
 ;
EOR ;PSDNMSP - CSM RX Processed by Same Person; 18 DEC 02
