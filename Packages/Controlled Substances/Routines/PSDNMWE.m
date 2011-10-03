PSDNMWE ;DOIFO/CMS - CSM No Visits within 12 Months ;18 Dec 02
 ;;3.0; CONTROLLED SUBSTANCES;**41,42**;13 Feb 97
 ;Reference to ^DPT( supported by IA #10035
 ;Reference to ^PSDRUG( supported by IA #2621
 ;Reference to ^PSRX( supported by IA #1977
 Q
 ;
ST ;CS Monitoring OPTION ENTRY
 N PSDODIV,PSDCII,PSDDTN,PSDED,PSDISA,PSDISB,PSDOUT,PSDSD,X,Y,%,%ZIS
 N DIC,DIR,DIRUT,DIROUT,DTOUT,DUOUT,POP,ZTIO,ZTSAVE,ZTSK,ZTRTN,ZTDESC
 W !!,?5,"This report lists released RXs without a visit within 12 months of the"
 W !,?5,"RX Release date.  Excluding RXs released on the same day as a discharge"
 W !,?5,"and within a user defined discharge date range.",!!
 W ! D DIV^PSDNMU I '$O(PSDODIV(0))!($G(PSDOUT)) G END
 S PSDDTN="RX Release" D DATE^PSDNMU I '$G(PSDSD)!($G(PSDOUT)) G END
 W ! D DISD^PSDNMU I $G(PSDOUT) G END
 W ! S DIR("A")="Screen for controlled substance RXs"
 S DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR I X="^"!($D(DTOUT)) G END
 I Y=1 W ! D CII^PSDNMU I '+$G(PSDCII)!($G(PSDOUT)) G END
 I Y'=1 S PSDCII=""
 ;
 W ! S DIR("A")="Okay to Continue",DIR("B")="No",DIR(0)="Y" D ^DIR
 I Y'=1 W "     <No report>",! G END
 W !!,?9,"This report should be queued to run during non-peak hours.",!
 K IO("Q") S %ZIS="MQ" D ^%ZIS I POP W "  <No device selected.>" G END
 I $D(IO("Q")) D
 .S ZTRTN="DQ^PSDNMWE",ZTDESC="CS Monitoring - PSDNMWE"
 .S ZTSAVE("PSDSD")="",ZTSAVE("PSDODIV(")="",ZTSAVE("PSDCII")="",ZTSAVE("PSDED")="",ZTSAVE("PSDISA")="",ZTSAVE("PSDISB")=""
 .D ^%ZTLOAD W !!?5,"TASK #",$G(ZTSK)," QUEUED!",!
 I '$D(IO("Q")) U IO D DQ
 K IOP,IO("Q")
END Q
 ;
HD ;Report heading
 N PSDD,PSDL,X,Y,%
 W @IOF,$$CJ^XLFSTR("CS Monitoring - No Visits within 12 months of RX Release Report",IOM)
 S PSDL="Outpatient Division(s): "
 S PSDD=0
 F  S PSDD=$O(PSDODIV(PSDD)) Q:'PSDD  S PSDL=PSDL_$P($G(PSDODIV(PSDD)),U,2) I $O(PSDODIV(PSDD)) S PSDL=PSDL_", "
 W !,$$CJ^XLFSTR(PSDL,IOM)
 W !,$$CJ^XLFSTR("Prescriptions released: "_$P(PSDSD,U,2)_" thru "_$P(PSDED,U,2),IOM)
 I $G(PSDISA)!($G(PSDISB)) D
 . S PSDL="Exclude RXs released: "
 . I $G(PSDISB) S PSDL=PSDL_+PSDISB_" day(s) before "
 . I $G(PSDISA) S PSDL=PSDL_+PSDISA_" day(s) after "
 . S PSDL=PSDL_"a discharge date"
 . W !,$$CJ^XLFSTR(PSDL,IOM)
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
 N D0,DA,DFN,DIC,DIQ,DR
 N PSDA,PSDD,PSDFD,PSDI,PSDIDT,PSDIV,PSDO,PSDOUT,PSDP,PSDPG,PSDS,PSDRG
 N PSDUZ,PSDY,PSDX,PSDX0,PSDX2,PSDXOR1,PSDY,X,X1,X2,Y,%,%DT
 K ^TMP("PSDNMWE",$J)
 I IOST?1"C-".E W !!,?10,"Compiling report, please wait ..."
 S PSDFD=+PSDSD
 F  S PSDFD=$O(^PSRX("AL",PSDFD)) Q:('PSDFD)!(PSDFD]+PSDED)  D
 . S PSDX=0
 . F  S PSDX=$O(^PSRX("AL",PSDFD,PSDX)) Q:'PSDX  D
 . . D KVA^VADPT
 . . S PSDX0=$G(^PSRX(PSDX,0)) I PSDX0']"" Q
 . . S PSDX2=$G(^PSRX(PSDX,2))
 . . I '$D(PSDODIV(+$P(PSDX2,U,9))) Q
 . . S PSDRG=$G(^PSDRUG(+$P(PSDX0,U,6),0))
 . . I +$G(PSDCII) S PSDP=0 D  I 'PSDP Q
 . . . F PSDY=1:1:4 S PSDA=$P(PSDCII,",",PSDY) I PSDA,$P(PSDRG,U,3)[PSDA S PSDP=1 Q
 . . I +$G(PSDCII),'PSDP Q
 . . ;Check Discharge Date
 . . S DFN=+$P(PSDX0,U,2) D DEM^VADPT
 . . S VAIP("D")=+$P(PSDFD,".",1),PSDP=0
 . . I $D(^TMP("PSDNMWE",$J,1,DFN,VAIP("D"))) Q
 . . D IN5^VADPT D  I $G(PSDP) Q
 . . . I +$G(VAIP(17,2))[VAIP("D") S ^TMP("PSDNMWE",$J,1,DFN,VAIP("D"))="" S PSDP=1 Q
 . . . I +$G(VAIP(17,2)),$G(PSDISA) D  I $G(PSDP) Q
 . . . . S X1=+$G(VAIP(17,2)),X2=+PSDISA D C^%DTC S PSDD=X
 . . . . I VAIP("D")'>PSDD S PSDP=1 Q
 . . . I +$G(VAIP(17,2)),$G(PSDISB) D  I $G(PSDP) Q
 . . . . S X1=+$G(VAIP(17,2)),X2=-PSDISB D C^%DTC S PSDD=X
 . . . . I VAIP("D")'<PSDD S PSDP=1 Q
 . . ;
 . . ;Check Visits within 12 months
 . . S PSDD="",X1=+PSDFD,X2=-365 D C^%DTC S PSDY=X
 . . K VASD S VASD("W")=1,VASD("F")=PSDY,VASD("T")=PSDFD
 . . D SDA^VADPT
 . . S PSDY=0
 . . F  S PSDY=$O(^UTILITY("VASD",$J,PSDY)) Q:'PSDY  D
 . . . S PSDI=$G(^UTILITY("VASD",$J,PSDY,"I"))
 . . . I $P(PSDI,U,3)="" K PSDP Q
 . . . S PSDP=1
 . . I $G(PSDP)=1!('$O(^UTILITY("VASD",$J,0))) D
 . . . I +$G(VADM(6)),+$G(VADM(6))']VAIP("D") S PSDD=$P($G(VADM(6)),U,2)
 . . . S Y=+PSDFD D D^DIQ S PSDA=Y
 . . . S PSDUZ=$P($G(^DPT(DFN,0)),U,1)_"  ("_$E(VA("PID"),5,12)_")"
 . . . S DIC="^PSRX(",DA=PSDX,DR="3;20",DIQ(0)="E",DIQ="PSDO"
 . . . K PSDO D EN^DIQ1
 . . . S ^TMP("PSDNMWE",$J,$S($G(PSDO(52,PSDX,20,"E"))]"":$G(PSDO(52,PSDX,20,"E")),1:"UNKNOWN"),$S($G(PSDO(52,PSDX,3,"E"))]"":$G(PSDO(52,PSDX,3,"E")),1:"UNKNOWN"),PSDUZ,PSDX)=$P(PSDX0,U,1)_U_PSDA_U_$P(PSDRG,U,1)_U_$G(PSDD)
 D KVA^VADPT
 ;
PRT ;Report print
 S PSDPG=0,PSDOUT=0
 I '$D(^TMP("PSDNMWE",$J)) D  G DQQ
 . S PSDIV="",PSDPG=0 D HD,PHD
 . W !!,?10,"<<<< NO DATA FOUND >>>>",!
 S PSDIV=""
 F  S PSDIV=$O(^TMP("PSDNMWE",$J,PSDIV)) Q:(PSDIV="")!(PSDOUT)  D
 .  S PSDPG=0 D HD,PHD
 .  S PSDS=""
 .  F  S PSDS=$O(^TMP("PSDNMWE",$J,PSDIV,PSDS)) Q:(PSDS="")!(PSDOUT)  D
 .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  W !!,?12,"RX PATIENT STATUS: ",PSDS
 .  .  S PSDRG=""
 .  .  F  S PSDRG=$O(^TMP("PSDNMWE",$J,PSDIV,PSDS,PSDRG)) Q:(PSDRG="")!(PSDOUT)  D
 .  .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  .  W !!,"PATIENT NAME: ",PSDRG
 .  .  .  S PSDX=0
 .  .  .  F  S PSDX=$O(^TMP("PSDNMWE",$J,PSDIV,PSDS,PSDRG,PSDX)) Q:('PSDX)!(PSDOUT)  D
 .  .  .  .  S PSDY=$G(^TMP("PSDNMWE",$J,PSDIV,PSDS,PSDRG,PSDX))
 .  .  .  .  I ($Y+3)>IOSL D PAGE Q:PSDOUT  D HD,PHD
 .  .  .  .  W !,$P(PSDY,U,1),?12,$P(PSDY,U,2),?40,$P(PSDY,U,3)
 .  .  .  .  I $P(PSDY,U,4)]"" W !,?12,"*Date of Death "_$P(PSDY,U,4)_" before RX Release Date!"
 .  I '$G(PSDOUT),$O(^TMP("PSDNMWE",$J,PSDIV))]"" D PAGE
 ;
DQQ W ! K PSDCII,PSDODIV,PSDSD,PSDED,PSDISA,PSDISB,^TMP("PSDNMWE",$J) D ^%ZISC Q
 ;
PHD ;
 W !,"RX#",?12,"Release Date",?40,"Drug"
 W !,$$REPEAT^XLFSTR("_",IOM)
 Q
PAGE ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 I IOST?1"C-".E S DIR(0)="E" D ^DIR W !
 I ($D(DTOUT))!($D(DIRUT)) S PSDOUT=1 Q:$G(PSDOUT)=1
 Q
 ;
EOR ;PSDNMWE - CSM No Visits in 12 Months; 18 DEC 02
