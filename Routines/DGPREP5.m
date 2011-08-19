DGPREP5 ;ALB/SCK - PreRegistration Audit field totals ; 10/10/03 3:16pm
 ;;5.3;Registration;**109,555**;Aug 13, 1993
 Q
EN ;  Entry point for audit totals by user
 N DGPBEG,DGPEND,VAUTD,DGPFLD1,DGPDSH,DGPABRT,DGPLN
 K DIR,DIRUT
 ;
 S DIR(0)="DA^::EX"
 S X1=$P($$NOW^XLFDT,".")
 S DIR("?",1)="Enter the beginning or ending date in an acceptable format"
 S DIR("?")="The ending date cannot be before the beginning date."
 S DIR("B")=$$FMTE^XLFDT(X1,1)
 S DIR("A")="Enter beginning date for report: "
 D ^DIR
 I $D(DIRUT) G EXIT
 S DGPBEG=Y
 S DIR("A")="Enter ending date for report: "
 ;
AGN D ^DIR
 I $D(DIRUT) G EXIT
 S DGPEND=Y
 I DGPEND<DGPBEG D  G AGN
 . W !,"The ending date for this report cannot be earlier then the beginning date"
 ;
 K DIR
 ;
 S %ZIS="Q" D ^%ZIS G:POP EXIT
 I $D(IO("Q")) D  G EXIT
 . S ZTRTN="RPT^DGPREP5",ZTDESC="DISPLAY AUDIT FILE TOTALS BY USER"
 . S ZTSAVE("DGPBEG")="",ZTSAVE("DGPEND")=""
 . S ZTSAVE("VAUTD(")="",ZTSAVE("VAUTD")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"TASK #: ",ZTSK
 . D HOME^%ZIS
 . K IO("Q"),ZTSK,ZTDESC,ZTRTN,ZTSAVE
 ;
 D WAIT^DICD
 ;
RPT ; Call procedures to build the data arrays, and then call the print procedure
 U IO
 S $P(DGPDSH,"=",79)=""
 S $P(DGPLN,"-",60)=""
 ;
 K ^TMP("DGPAUD",$J)
 K ^TMP("DGPTOT",$J)
 ;
 D BLD2
 D BLD3
 ;
 D PRNT(2)
 G:$G(DGPABRT) EXIT
 D PRNT(2.312)
 G:$G(DGPABRT) EXIT
 D TOT
 ;
EXIT ;  Clean up and exit
 D:'$D(ZTQUEUED) ^%ZISC
 K ^TMP("DGPAUD",$J),POP,ZTQUEUED
 Q
 ;
BLD2 ;  Build array of audit data for the PATIENT File, #2
 N DGPN1,DGPFLD,DGPDATA,DGPDUZ,DGPN2
 ;
 S DGPN1=0
 F  S DGPN1=$O(^DD(2,DGPN1)) Q:'DGPN1  D
 . I $G(^DD(2,DGPN1,"AUDIT"))="y" S DGPFLD(DGPN1)=""
 ;
 S DGPN1=DGPBEG-.1
 S DGPE=DGPEND+.999999
 F  S DGPN1=$O(^DIA(2,"C",DGPN1)) Q:'DGPN1!(DGPN1>DGPE)  D
 . S DGPN2="" F  S DGPN2=$O(^DIA(2,"C",DGPN1,DGPN2)) Q:'DGPN2  D
 .. S DGPDATA=$G(^DIA(2,DGPN2,0))
 .. Q:$P(DGPDATA,U,3)=""
 .. Q:'$D(DGPFLD(+$P($G(DGPDATA),U,3)))
 .. S DGPDUZ=+$P($G(DGPDATA),U,4) Q:DGPDUZ'>0
 .. Q:'($D(^XUSEC("DGPRE EDIT",DGPDUZ))!($D(^XUSEC("DGPRE SUPV",DGPDUZ))))
 .. S ^TMP("DGPAUD",$J,2,+$P(DGPDATA,U,3),DGPDUZ)=+$G(^TMP("DGPAUD",$J,2,+$P(DGPDATA,U,3),DGPDUZ))+1
 .. S ^TMP("DGPTOT",$J,DGPDUZ)=+$G(^TMP("DGPTOT",$J,DGPDUZ))+1
 Q
 ;
BLD3 ;  Build array of audit data for file 2.312
 N DGPN1,DGPE,DGPDATA,DGPDUZ,DGPN2
 ;
 S DGPN1=0
 F  S DGPN1=$O(^DD(2.312,DGPN1)) Q:'DGPN1  D
 . I $G(^DD(2.312,DGPN1,"AUDIT"))="y" S DGPFLD(".3121,"_DGPN1)=""
 ;
 S DGPN1=DGPBEG-.1
 S DGPE=DGPEND+.999999
 F  S DGPN1=$O(^DIA(2,"C",DGPN1)) Q:'DGPN1!(DGPN1>DGPE)  D
 . S DGPN2="" F  S DGPN2=$O(^DIA(2,"C",DGPN1,DGPN2)) Q:'DGPN2  D
 .. S DGPDATA=$G(^DIA(2,DGPN2,0))
 .. Q:$P(DGPDATA,U,3)=""
 .. Q:'$D(DGPFLD($P($G(DGPDATA),U,3)))
 .. S DGPDUZ=+$P($G(DGPDATA),U,4) Q:DGPDUZ'>0
 .. Q:'($D(^XUSEC("DGPRE EDIT",DGPDUZ))!($D(^XUSEC("DGPRE SUPV",DGPDUZ))))
 .. S ^TMP("DGPAUD",$J,2.312,$P(DGPDATA,U,3),DGPDUZ)=+$G(^TMP("DGPAUD",$J,2.312,$P(DGPDATA,U,3),DGPDUZ))+1
 .. S ^TMP("DGPTOT",$J,DGPDUZ)=+$G(^TMP("DGPTOT",$J,DGPDUZ))+1
 ;
 Q
 ;
PRNT(DGPDD) ;  Print the report
 N DGPFLDX,DGPIENX,DGPTOT
 ;
 S X=$$NEWPGE Q:$G(DGPABRT)
 D HDR(DGPDD)
 I '$D(^TMP("DGPAUD",$J,DGPDD)) D  Q
 . W !!?5,"No audit data for this date range"
 ;
 S DGPFLDX=""
 F  S DGPFLDX=$O(^TMP("DGPAUD",$J,DGPDD,DGPFLDX)) Q:'DGPFLDX  D  Q:$G(DGPABRT)
 . D HDR1(DGPDD,DGPFLDX)
 . S DGPIENX="" F  S DGPIENX=$O(^TMP("DGPAUD",$J,DGPDD,DGPFLDX,DGPIENX)) Q:'DGPIENX  D  Q:$G(DGPABRT)
 .. I $Y>(IOSL-8) D:$$NEWPGE HDR(DGPDD) Q:$G(DGPABRT)
 .. W !?5,$P(^VA(200,DGPIENX,0),U),": ",?50,$J(^TMP("DGPAUD",$J,DGPDD,DGPFLDX,DGPIENX),6)
 .. S DGPTOT=$G(DGPTOT)+$G(^TMP("DGPAUD",$J,DGPDD,DGPFLDX,DGPIENX))
 . Q:$G(DGPABRT)
 . W !!?5,$P(^DD(DGPDD,$S(DGPDD=2:DGPFLDX,1:$P(DGPFLDX,",",2)),0),U)_" (TOTAL): ",?50,$J(DGPTOT,6)
 . S DGPTOT=0
 . W !?5,DGPLN,!
 Q
 ;
TOT ; Display totals by user
 S X=$$NEWPGE Q:$G(DGPABRT)
 D HDR(0)
 W !!,?2,"User Totals"
 W !?2,DGPDSH
 S DGPIENX="",DGPTOT=0
 F  S DGPIENX=$O(^TMP("DGPTOT",$J,DGPIENX)) Q:'DGPIENX  D  G:$G(DGPABRT) EXIT
 . I $Y>(IOSL-8) D:$$NEWPGE HDR(0) Q:$G(DGPABRT)
 . W !?5,$P(^VA(200,DGPIENX,0),U),?50,$J(+$G(^TMP("DGPTOT",$J,DGPIENX)),5)
 . S DGPTOT=$G(DGPTOT)++$G(^TMP("DGPTOT",$J,DGPIENX))
 ;
 W !!?5,"Total Changes: ",?50,$J(DGPTOT,5)
 ;
 Q
 ;
HDR(DGPDD) ;  Page header
 W @IOF
 W !?2,"Pre-Registration Audit Totals"
 W !?2,"For Period Covering "_$$FMTE^XLFDT(DGPBEG,"2D")_" to "_$$FMTE^XLFDT(DGPEND,"2D")
 W !?2,DGPDSH
 W !!,?2,$S(DGPDD=2:"Patient Demographic Data --",DGPDD=2.312:"Patient Insurance Data",1:"")
 ;
 Q
 ;
HDR1(DGPDD,DFLD) ;  Field header
 I $Y>(IOSL-8) D:$$NEWPGE HDR(DGPDD) G:$G(DGPABRT) EXIT
 W !!?5,"**** Field: ",$P(^DD(DGPDD,$S(DGPDD=2.312:$P(DFLD,",",2),1:DFLD),0),U)," ****",!
 Q
 ;
NEWPGE() ;  Check for device and execute header if user does not quit
 N DIR,DGOK
 I IOST?1"C-".E D
 . S DIR(0)="E" D ^DIR S DGPABRT='+$G(Y)
 . I 'DGPABRT S DGOK=1
 Q +$G(DGOK)
