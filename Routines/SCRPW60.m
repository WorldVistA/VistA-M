SCRPW60 ;BP-CIOFO/KEITH - Patient Appointment Statistics ; 19 Nov 98 10:34 AM
 ;;5.3;Scheduling;**163**;AUG 13, 1993
 ;Prompt for report parameters
 D TITL^SCRPW50("Patient Appointment Statistics")
 N SDDIV G:'$$DIVA^SCRPW17(.SDDIV) EXIT
DTR ;Date range selection
 D SUBT^SCRPW50("*** Date Range Selection ***")
FDT W ! S %DT="AEX",%DT("A")="Beginning date: " D ^%DT G:X=U!($D(DTOUT)) EXIT G:X="" EXIT
 G:Y<1 FDT S SDBDAY=Y X ^DD("DD") S SDPBDA=Y
LDT W ! S %DT("A")="   Ending date: " D ^%DT G:X=U!($D(DTOUT)) EXIT G:X="" EXIT
 I Y<SDBDAY W !!,$C(7),"Ending date must be after beginning date!" G LDT
 G:Y<1 LDT S SDEDAY=Y_.9999 X ^DD("DD") S SDPEDA=Y
TYP ;Report format selection
 D SUBT^SCRPW50("*** Report Format Selection ***")
 S SDQUIT=0,DIR(0)="S^AC:ALL CLINICS;SC:SELECTED CLINICS;RC:RANGE OF CLINICS;SS:SELECTED STOP CODES;RS:RANGE OF STOP CODES;CG:CLINIC GROUP"
 W ! D ^DIR G:($D(DTOUT)!$D(DUOUT)) EXIT S SDF=Y I Y="SC" D SEL G:(SDQUIT!'$D(SDCL)) EXIT
 I SDF="RC" D SRC S SDCL="",SDCL=$O(SDCL(SDCL)) G:SDCL="" EXIT S SDCL=$O(SDCL(SDCL)) G:SDCL="" EXIT
 I SDF="SS" D SSS G:'$O(SDCL(0)) EXIT
 I SDF="RS" D SRS G:'$O(SDCL(0)) EXIT
 I SDF="CG" D SCG G:'$O(SDCL(0)) EXIT
 K DIR S DIR(0)="Y",DIR("A")="Include list of patient names",DIR("B")="NO",DIR("?")="Specify if you would like to see a list of patient names for each clinic."
 S SDOUT=0 W ! D ^DIR G:$D(DUOUT)!$D(DTOUT) EXIT S SDPL=Y I Y D  G:SDOUT EXIT
 .K DIR S DIR(0)="S^A:ALPHABETIC;D:DATE/TIME;T:TERMINAL DIGIT",DIR("A")="Within clinic, print patients in what order",DIR("B")="ALPHABETIC"
 .D ^DIR I $D(DTOUT)!$D(DUOUT) S SDOUT=1 Q
 .S SDPLO=Y Q
 ;
QUE N Z,ZTSAVE F Z="SDPL","SDPLO","SDDIV","SDDIV(","SDBDAY","SDEDAY","SDPBDA","SDPEDA","SDF","SDCL(" S ZTSAVE(Z)=""
 W ! D EN^XUTMDEVQ("START^SCRPW60","Patient Appointment Statistics",.ZTSAVE)
 G EXIT
 ;
START ;Initialize variables, gather information
 K ^TMP("SCRPW",$J) S SDCOL=$S(IOM=80:0,1:26),SDOUT=0,SDMD="",SDMD=$O(SDDIV(SDMD)),SDMD=$O(SDDIV(SDMD)) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDMD=1
 D @(SDF_"^SCRPW61") G:SDOUT EXIT D CNT^SCRPW61 G:SDOUT EXIT
 S SDPAGE=1,SDLINE="",$P(SDLINE,"-",(IOM+1))="",SDTLINE=$TR(SDLINE,"-","=") D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDT(1)="<*>  PATIENT APPOINTMENT STATISTICS  <*>"
 S SDT(2)=$S(SDF="AC":"FOR ALL ACTIVE CLINICS",SDF="SC":"FOR SELECTED CLINICS",SDF="RC":"FOR RANGE OF ACTIVE CLINICS",SDF="SS":"FOR SELECTED STOP CODES",SDF="RS":"FOR RANGE OF STOP CODES",SDF="CG":"FOR CLINIC GROUP")
 I SDF="RC" S SDCLN=$O(SDCL("")),SDECL=$O(SDCL(SDCLN)),SDT(3)=SDCLN_" TO "_SDECL
 I SDF="RS" S SDBCS=$O(SDCL(0)),SDECS=$O(SDCL(SDBCS)) S:SDECS="" SDECS=SDBCS S SDT(2)=SDT(2)_":  "_SDBCS_" TO "_SDECS
 I SDF="CG" S SDI=$O(SDCL(0)),SDT(2)=SDT(2)_": "_SDCL(SDI)
 ;Print report
 D:$E(IOST)="C" DISP0^SCRPW23 I '$D(^TMP("SCRPW",$J)) S SDIV=0 D DHDR^SCRPW40(4,.SDT),HDR S SDX="No appointments found for the specified date range." W !!?(IOM-$L(SDX)\2),SDX D FOOT^SCRPW61 G EXIT
 S SDIV="" F  S SDIV=$O(SDDIV(SDIV)) Q:'SDIV  S SDIV(SDDIV(SDIV))=SDIV
 I 'SDDIV,$P(SDDIV,U,2)'="ALL DIVISIONS" S SDIV($P(SDDIV,U,2))=$$PRIM^VASITE()
 I $P(SDDIV,U,2)="ALL DIVISIONS" S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDI)) Q:'SDI  S SDX=$P($G(^DG(40.8,SDI,0)),U) S:$L(SDX) SDIV(SDX)=SDI
 S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  S SDIV=SDIV(SDIVN) D DPRT^SCRPW61(.SDIV)
 S SDI=0,SDI=$O(^TMP("SCRPW",$J,SDI)),SDMD=$O(^TMP("SCRPW",$J,SDI))
 G:SDOUT EXIT I SDMD S SDIV=0 D DPRT^SCRPW61(.SDIV)
 I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 ;
EXIT K %,%DT,DFN,DIC,DIR,DTOUT,DUOUT,SDAC,SDAPP,SDBCS,SDBDAY,SDCG,SDCL,SDCL0,SDCLN,SDCOL,SDCP0,SDCSC,SDCTOT,SDDAY,SDDIV,SDECL,SDECS,SDEDAY,SDF
 K SDH,SDI,SDIV,SDIVN,SDLINE,SDMD,SDORD,SDOUT,SDPAGE,SDPBDA,SDPEDA,SDPL,SDPLO,SDPNOW,SDTLINE,SDPTNA,SDQUIT,SDSSN,SDT,SDTOT,SDX,X,Y,Z
 D END^SCRPW50 Q
 ;
SEL ;Pick selected clinics
 W ! F  D ASK Q:(SDQUIT!(X=""))
 Q
ASK K DIC S DIC(0)="AEMQ",DIC="^SC(",DIC("S")="I $P(^(0),U,3)=""C""" S:SDDIV DIC("S")=DIC("S")_",$D(SDDIV(+$P(^(0),U,15)))" D ^DIC
 I ($D(DTOUT)!$D(DUOUT)) S SDQUIT=1
 S:Y>0 SDCL(+Y)="" Q
 ;
SRC ;Select clinic range
 W ! K DIC S DIC="^SC(",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,3)=""C"""_$S(SDDIV:",$D(SDDIV(+$P(^(0),U,15)))",1:""),DIC("A")="Select BEGINNING Clinic: " D ^DIC Q:($D(DTOUT)!$D(DUOUT)!(X=""))  S SDCL($P(Y,U,2))=$P(Y,U)
C2 W ! S DIC("A")="Select ENDING Clinic: " D ^DIC Q:($D(DTOUT)!$D(DUOUT)!(X=""))  I $P(Y,U,2)]$O(SDCL("")) S SDCL($P(Y,U,2))=$P(Y,U) Q
 W !!,$C(7),"Ending clinic must collate after beginning clinic!" G C2
 ;
SSS ;Pick selected Stop Codes
 W ! K DIC S DIC="^DIC(40.7,",DIC(0)="AEMQZ",DIC("A")="Select Stop Code: "
 F  D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  S SDCL($P(Y(0),U,2))=""
 Q
 ;
SRS ;Select Stop Code range
 W ! K DIC S DIC="^DIC(40.7,",DIC(0)="AEMZQ",DIC("A")="Select BEGINNING Stop Code: " D ^DIC Q:($D(DTOUT)!$D(DUOUT))  G:Y<1 SRS S SDCL=$P(Y(0),U,2),SDCL(SDCL)=""
SRSE S DIC("A")="Select ENDING Stop Code: "
 W ! D ^DIC I ($D(DTOUT)!$D(DUOUT)) K SDCL Q
 G:Y<1 SRSE
 I SDCL]$P(Y(0),U,2) W !!,$C(7),"Ending Stop Code must collate after beginning Stop Code!" G SRSE
 S SDCL($P(Y(0),U,2))="" Q
 ;
SCG ;Select clinic group
 W ! K DIC S DIC="^SD(409.67,",DIC(0)="AEMQ" D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  S SDCL(+Y)=$P(Y,U,2) Q
 ;
HDR ;Print report header
 I $E(IOST)="C",SDPAGE>1 N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP^SCRPW61 Q:SDOUT
 W:SDPAGE>1!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0) W SDLINE S X=0 F  S X=$O(SDT(X)) Q:'X  W !?(IOM-$L(SDT(X))\2),SDT(X)
 W !,SDLINE,!,"For date range: ",SDPBDA," to ",SDPEDA,!,"Date printed: ",SDPNOW,?((IOM-6)-$L(SDPAGE)),"Page: ",SDPAGE
 W !,SDLINE S X=0 F  S X=$O(SDH(X)) Q:'X  X SDH(X)
 W !,SDLINE S SDPAGE=SDPAGE+1 Q
