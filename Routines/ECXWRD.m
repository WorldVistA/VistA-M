ECXWRD ;BIR/CML,ALB/JAP  Print Active Wards for Fiscal Year ;9/17/10  15:10
 ;;3.0;DSS EXTRACTS;**2,8,127**;Dec 22, 1997;Build 36
 ;
EN ;entry point from option
 N DATE,YR,MON,FY,POP,ZTSK
 D NOW^%DTC S DATE=$$FMTE^XLFDT(%,"5D"),YR=+$P(DATE,"/",3),MON=+$P(DATE,"/",1),FY=$S(MON<10:YR,1:YR+1)
 W !!,"This option prints a list of all MAS wards that were active at any time"
 W !,"during FY",FY,".  The list is sorted by Medical Center Division and displays"
 W !,"the pointer to the Hospital Location file (#44) and DSS Department data"
 W !,"if available."
 W !!,"This report requires a print width of 132 characters.",!!
 S ECXPGM="START^ECXWRD",ECXDESC="DSS-Print Active Wards for Fiscal Year",ECXSAVE("FY")=""
 W ! D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !,"No device selected... try again later.!!"
 I ECXSAVE("ZTSK")=0 U IO D START^ECXWRD
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 K ECXSAVE,ECXPGM,ECXDESC
 K ECXDIVN,ECFYB,ECFYE,ECXWD,ECXWDN,ECXDEPT,ECXDESC,FY,^TMP("ECXWRD",$J)
 Q
START ;
 N QFLG,%,%H,%I,JJ,SS,HDT,DATA
 K ^TMP("ECXWRD",$J)
 S ECXFY=FY-1700
 S ECFYB=ECXFY-1_"1000",ECFYE=ECXFY_"1001"
 ;gather data
 S ECXWD=0
 F  S ECXWD=$O(^DIC(42,ECXWD)) Q:'ECXWD  I $D(^DIC(42,ECXWD,0))  D
 .S EC=^DIC(42,ECXWD,0) D CHK Q:X=1
 .S DR=".01;.03;.015;.017;44",DIQ(0)="IE",DIQ="ECX",DA=ECXWD,DIC="^DIC(42," K ECX D EN^DIQ1
 .S ECXWDN=$G(ECX(42,ECXWD,.01,"E"))
 .S ECXDIVN=$G(ECX(42,ECXWD,.015,"E")) S:ECXDIVN="" ECXDIVN="UNKNOWN"
 .S ^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)=$G(ECX(42,ECXWD,44,"I"))_U_$G(ECX(42,ECXWD,.03,"E"))_U_$G(ECX(42,ECXWD,.017,"E"))_U
 .I $D(^ECX(727.4,ECXWD)) D
 ..S ECXDEPT=$P(^ECX(727.4,ECXWD,0),U,2) Q:ECXDEPT=""
 ..D REVERSE^ECXDSSD(ECXDEPT,.ECXDESC)
 ..S ^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)=^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)_ECXDEPT_U_ECXDESC
 ;print the report
 S (PG,QFLG)=0,$P(LN,"-",130)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y
 D HDR
 I '$D(^TMP("ECXWRD",$J)) W !!,"NO DATA FOUND FOR THIS REPORT" Q
 S ECXDIVN=""
 F  S ECXDIVN=$O(^TMP("ECXWRD",$J,ECXDIVN)) Q:ECXDIVN=""  Q:QFLG  D
 .D:$Y+4>IOSL HDR Q:QFLG
 .W !!,"DIVISION: ",ECXDIVN S ECXWDN="" D
 ..F  S ECXWDN=$O(^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)) Q:ECXWDN=""  Q:QFLG  D
 ...S DATA=^TMP("ECXWRD",$J,ECXDIVN,ECXWDN),ECXDEPT=$P(DATA,U,4)
 ...D:$Y+4>IOSL HDR Q:QFLG  W !?5,$E(ECXWDN,1,20),?30,ECXDEPT,?45,$P(DATA,U,1),?60,$E($P(DATA,U,2),1,18),?80,$P(DATA,U,3)
 ...Q:ECXDEPT=""
 ...D:$Y+4>IOSL HDR Q:QFLG
 ...;W !?30,"[Svc: "_$E($P(DATA,U,5),1,20)_"   "_"Prod. Unit: "_$E($P(DATA,U,6),1,40)_"   "_"Div: "_$P(DATA,U,7)_"]",!
 I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K ECXDIVN,ECFYB,ECFYE,ECXWD,ECXWDN,ECXDEPT,ECXDESC,FY,^TMP("ECXWRD",$J)
 Q
 ;
CHK ;has this ward been active?
 ; output      
 ; X = 1 if inactive (out-of-service), 0 otherwise
 ;
 N ECX,ECY
 S X=1 Q:'$D(ECXWD)  S ECY=ECFYB
 I '$O(^DIC(42,ECXWD,"OOS",0)) S X=0 Q
 S ECX=+$O(^DIC(42,ECXWD,"OOS","AINV",9999998.9-ECY)),ECX=$S($D(^DIC(42,ECXWD,"OOS",+$O(^(+ECX,0)),0)):^(0),1:"")
 I '$P(ECX,U,6) S X=0 Q
 I $P(ECX,U,6),'$P(ECX,U,4) S X=1 Q
 I $P(ECX,U,6),$P(ECX,U,4)<ECFYE S X=0 Q
 S X=1
 Q
 ;
HDR ;header and page control
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,"Active Wards for FY",FY,!,"Printed on ",HDT,!
 W !?30,"DSS",?45,"Pointer",?60,"Ward",?80,"Ward"
 W !?5,"WARD",?30,"Department",?45,"to File #44",?60,"Service",?80,"Specialty"
 W !,LN
 Q
