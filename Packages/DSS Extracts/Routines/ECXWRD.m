ECXWRD ;BIR/CML,ALB/JAP  Print Active Wards for Fiscal Year ;11/8/17  14:59
 ;;3.0;DSS EXTRACTS;**2,8,127,149,166,169,181,184**;Dec 22, 1997;Build 124
 ;
 ; Reference to ^DG(40.8) in ICR #417
 ; Reference to ^DIC(42) in ICR #1848
 ;
EN ;entry point from option
 N DATE,YR,MON,FY,POP,ZTSK,ECXPORT,CNT ;149
 D NOW^%DTC S DATE=$$FMTE^XLFDT(%,"5D"),YR=+$P(DATE,"/",3),MON=+$P(DATE,"/",1),FY=$S(MON<10:YR,1:YR+1)
 W !!,"This option prints a list of all wards that were active at any time" ;184 Removed MAS/HAS
 W !,"during FY",FY,".  The list is sorted by Medical Center Division and displays"
 W !,"the pointer to the Hospital Location file (#44) and DSS Department data"
 W !,"if available."
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  ;149
 I ECXPORT D  Q  ;149 Section added
 .K ^TMP($J)
 .S ^TMP($J,"ECXPORT",0)="Expected Divisions with Active Ward/s: " ;181 - Add header to export format
 .S ^TMP($J,"ECXPORT",1)="DIVISION NUMBER^DIVISION^WARD^DSS DEPT^POINTER TO FILE 44^WARD SERVICE^WARD SPECIALTY",CNT=2 ;181 -Add DIVISION Number 
 .D START
 .D EXPDISP^ECXUTL1
 .K ^TMP($J),^TMP("ECXWRD",$J)
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
 N QFLG,%,%H,%I,JJ,SS,HDT,DATA,ECXFY,EC,DR,DIQ,DA,DIC,ECX,PG,LN,Y ;149 adding vars to new line
 N ECXDIV,ECXINST,ECXSTA,ECXDIVNO,ECXHDR,ECXFACN,ECXOFAC ;181 
 K ^TMP("ECXWRD",$J)
 S ECXFY=FY-1700
 S ECFYB=ECXFY-1_"1000",ECFYE=ECXFY_"1001"
 ;gather data
 S ECXWD=0,ECXHDR="" ;181 - Added ECXHDR
 S ECXWD=0
 F  S ECXWD=$O(^DIC(42,ECXWD)) Q:'ECXWD  I $D(^DIC(42,ECXWD,0))  D
 .S EC=^DIC(42,ECXWD,0) D CHK Q:X=1
 .S DR=".01;.03;.015;.017;44",DIQ(0)="IE",DIQ="ECX",DA=ECXWD,DIC="^DIC(42," K ECX D EN^DIQ1
 .S ECXWDN=$G(ECX(42,ECXWD,.01,"E"))
 .;181 - Begins
 .S ECXDIVNO=$G(ECX(42,ECXWD,.015,"I")) ;181 - Get DIV ien
 .S ECXDIVN=$G(ECX(42,ECXWD,.015,"E")) S:ECXDIVN="" ECXDIVN="UNKNOWN"
 .S ECXFACN=""
 .I ECXDIVNO'="" D
 ..S DIC="^DG(40.8,",DR="1",DIQ(0)="I",DIQ="ECXDIV",DA=ECXDIVNO K ECXDIV D EN^DIQ1
 ..S ECXFACN=ECXDIV(40.8,ECXDIVNO,1,"I")
 .S ECXDIVN=ECXDIVN_"  -  "_ECXFACN ;Facility Number of the Medical Center Division
 .;181 - Ends
 .S ^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)=$G(ECX(42,ECXWD,44,"I"))_U_$G(ECX(42,ECXWD,.03,"E"))_U_$G(ECX(42,ECXWD,.017,"E"))_U
 .I ECXFACN'="" S ECXHDR(ECXFACN)="" ;181 
 .I $D(^ECX(727.4,ECXWD)) D
 ..S ECXDEPT=$P(^ECX(727.4,ECXWD,0),U,2) Q:ECXDEPT=""
 ..D REVERSE^ECXDSSD(ECXDEPT,.ECXDESC)
 ..S ^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)=^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)_ECXDEPT_U_ECXDESC
 D GETOFAC(.ECXHDR,.ECXOFAC) ; 181 - Get other Facility Number contains 9A,"B" or "P"
 S (ECXHDR,ECXSTA,ECXFACN)="" ;181
 F  S ECXFACN=$O(ECXHDR(ECXFACN)) Q:ECXFACN=""  S ECXHDR=ECXHDR_ECXFACN_"," ;181
 S ECXHDR=ECXHDR_ECXOFAC ;181
 ;print the report
 S (PG,QFLG)=0,$P(LN,"-",130)="" D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S HDT=Y
 I '$G(ECXPORT) D HDR ;149
 I '$G(ECXPORT) I '$D(^TMP("ECXWRD",$J)) W !!,"NO DATA FOUND FOR THIS REPORT" Q  ;149
 I $G(ECXPORT) S ^TMP($J,"ECXPORT",0)=^TMP($J,"ECXPORT",0)_ECXHDR  ;181
 S ECXDIVN=""
 F  S ECXDIVN=$O(^TMP("ECXWRD",$J,ECXDIVN)) Q:ECXDIVN=""  Q:QFLG  D
 .I '$G(ECXPORT) D:$Y+4>IOSL HDR Q:QFLG  ;149
 .W:'$G(ECXPORT) !!,"DIVISION: ",ECXDIVN S ECXWDN="" D  ;149 
 ..F  S ECXWDN=$O(^TMP("ECXWRD",$J,ECXDIVN,ECXWDN)) Q:ECXWDN=""  Q:QFLG  D
 ...S DATA=^TMP("ECXWRD",$J,ECXDIVN,ECXWDN),ECXDEPT=$P(DATA,U,4)
 ...I $G(ECXPORT) S ^TMP($J,"ECXPORT",CNT)=$P(ECXDIVN,"  -  ",2)_U_$P(ECXDIVN,"  -  ")_U_ECXWDN_U_ECXDEPT_U_$P(DATA,U,1,3),CNT=CNT+1 Q  ;149,181 - Add Station Number as the first column
 ...D:$Y+4>IOSL HDR Q:QFLG  W !?5,$E(ECXWDN,1,20),?30,ECXDEPT,?45,$P(DATA,U,1),?60,$E($P(DATA,U,2),1,18),?80,$P(DATA,U,3)
 ...Q:ECXDEPT=""
 ...I '$G(ECXPORT) D:$Y+4>IOSL HDR Q:QFLG  ;149
 ...;W !?30,"[Svc: "_$E($P(DATA,U,5),1,20)_"   "_"Prod. Unit: "_$E($P(DATA,U,6),1,40)_"   "_"Div: "_$P(DATA,U,7)_"]",!
 I '$G(ECXPORT) I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR ;149
 .S SS=22-$Y F JJ=1:1:SS W !
 I '$G(ECXPORT) W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" ;149
 K ECXDIVN,ECFYB,ECFYE,ECXWD,ECXWDN,ECXDEPT,ECXDESC,FY,^TMP("ECXWRD",$J)
 Q
 ;
CHK ;has this ward been active?
 ; output      
 ; X = 1 if inactive (out-of-service), 0 otherwise
 ;
 N ECX,ECY
 N DR,DIQ,DIC,ECXWARD ;181
 S X=1 Q:'$D(ECXWD)  S ECY=ECFYB
 S DR=400,DA=ECXWD,DIQ="ECXWARD",DIC="^DIC(42," K ECXWARD D EN^DIQ1 ;181
 I $G(ECXWARD(42,ECXWD,400))="" S X=1 Q  ;181
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
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,"Active Wards for FY",FY,!,"Printed on ",HDT,! ;181 - Update the header
 W !,"Expected Divisions with Active Ward/s: ",ECXHDR,! ;181 
 W !?30,"DSS",?45,"Pointer",?60,"Ward",?80,"Ward"
 W !?5,"WARD",?30,"Department",?45,"to File #44",?60,"Service",?80,"Specialty"
 W !,LN
 Q
 ;
GETSTAT(DIVNUM,STATNO,FACNUM) ; 181 - Added the following sections
 ;Get Station number from the Institution file #4
 ;Get Facility Number from Medical Division file #40.8
 N DIQ,DR,DA,DIC,INST,ECX
 S DIC="^DG(40.8,",DR="1;.07",DIQ(0)="I",DIQ="ECX",DA=DIVNUM K ECX D EN^DIQ1
 S FACNUM=ECX(40.8,DIVNUM,1,"I")
 K DIQ
 S DIC=4,DR="99",DIQ(0)="I",DIQ="ECX",DA=ECX(40.8,DIVNUM,.07,"I") K ECX D EN^DIQ1
 S STATNO=$G(ECX(4,DA,99,"I"))
 Q
GETOFAC(HDR,OFAC) ;181
 ;Get Facility Number which contains "9A","B" or "P" from Medical Division file #40.8
 N DIC,DIVNUM,ECX,FACNUM
 N DIC,ECXDIV,ECXFAC,ECX,TMPFAC
 S ECXDIV=0,OFAC=""
 F  S ECXDIV=$O(^DG(40.8,ECXDIV)) Q:'ECXDIV  D
 .S DIC="^DG(40.8,",DR="1;.07",DIQ(0)="I",DIQ="ECX",DA=ECXDIV K ECX D EN^DIQ1
 .S ECXFAC=$G(ECX(40.8,ECXDIV,1,"I"))
 .S TMPFAC=$S($E(ECXFAC,4,5)="9A":ECXFAC,($E(ECXFAC,4)="B"):ECXFAC,($E(ECXFAC,4)="P"):ECXFAC,1:"")
 .I TMPFAC="" Q
 .S ECXINST=$G(ECX(40.8,ECXDIV,.07,"I"))
 .I ECXINST="" Q
 .K DIQ
 .S DIC=4,DR="101",DIQ(0)="I",DIQ="ECX",DA=ECXINST K ECX D EN^DIQ1
 .I $G(ECX(4,ECXINST,101,"I")) Q  ;Medical Division points to Inactive Institution
 .I '$D(HDR(ECXFAC)) S OFAC=OFAC_TMPFAC_","
 S OFAC=$E(OFAC,1,$L(OFAC)-1)
 Q
