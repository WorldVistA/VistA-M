SCRPW2 ;RENO/KEITH - Clinic Utilization Statistical Summary ; 16 May 99  6:19 PM
 ;;5.3;Scheduling;**139,144,163,184,194**;AUG 13, 1993
 ;
 D TITL^SCRPW50("Clinic Utilization Statistical Summary")
 N SDDIV G:'$$DIVA^SCRPW17(.SDDIV) EXIT
DTR D SUBT^SCRPW50("*** Date Range Selection ***")
FDT W ! S %DT="AEX",%DT("A")="Beginning date: " D ^%DT G:X=U!($D(DTOUT)) EXIT G:X="" EXIT
 G:Y<1 FDT S SDBDAY=Y X ^DD("DD") S SDPBDA=Y
LDT W ! S %DT("A")="   Ending date: " D ^%DT G:X=U!($D(DTOUT)) EXIT G:X="" EXIT
 I Y<SDBDAY W !!,$C(7),"Ending date must be after beginning date!" G LDT
 G:Y<1 LDT S SDEDAY=Y_.9999 X ^DD("DD") S SDPEDA=Y
TYP D SUBT^SCRPW50("*** Report Format Selection ***")
 S SDQUIT=0,DIR(0)="S^AC:ALL CLINICS;SC:SELECTED CLINICS;RC:RANGE OF CLINICS;RS:RANGE OF STOP CODES;CG:CLINIC GROUP"
 W ! D ^DIR G:($D(DTOUT)!$D(DUOUT)) EXIT S SDF=Y I Y="SC" D SEL G:(SDQUIT!'$D(SDCL)) EXIT
 I SDF="RC" D SRC S SDCL="",SDCL=$O(SDCL(SDCL)) G:SDCL="" EXIT S SDCL=$O(SDCL(SDCL)) G:SDCL="" EXIT
 I SDF="RS" D SRS G:'$O(SDCL(0)) EXIT
 I SDF="CG" D SCG G:'$O(SDCL(0)) EXIT
 N Z,ZTSAVE F Z="SDDIV","SDDIV(","SDBDAY","SDEDAY","SDPBDA","SDPEDA","SDF","SDCL(" S ZTSAVE(Z)=""
 W !!,"This report requires 132 column output.",! D EN^XUTMDEVQ("START^SCRPW2","Clinic Util. Stat. Summary",.ZTSAVE)
 G EXIT
 ;
START ;Gather data and print report
 K ^TMP("SCRPW",$J) S SDOUT=0,SDMD="",SDMD=$O(SDDIV(SDMD)),SDMD=$O(SDDIV(SDMD)) S:$P(SDDIV,U,2)="ALL DIVISIONS" SDMD=1
 S X1=SDEDAY,X2=SDBDAY D ^%DTC S SDMAX=X+1 D INIT
 S SDSUB="SDTMP" D @(SDF_"^SCRPW3") K ^TMP(SDSUB,$J)
 S SDPAGE=1,SDLINE="",$P(SDLINE,"-",133)="" D NOW^%DTC S Y=% X ^DD("DD") S SDPNOW=$P(Y,":",1,2),SDT(1)="<*>  CLINIC UTILIZATION STATISTICAL SUMMARY  <*>"
 S SDT(2)=$S(SDF="AC":"FOR ALL ACTIVE CLINICS",SDF="SC":"FOR SELECTED CLINICS",SDF="RC":"FOR RANGE OF ACTIVE CLINICS",SDF="RS":"FOR RANGE OF STOP CODES",SDF="CG":"FOR CLINIC GROUP")
 I SDF="RC" S SDCLN=$O(SDCL("")),SDECL=$O(SDCL(SDCLN)),SDT(3)=SDCLN_" TO "_SDECL
 I SDF="RS" S SDBCS=$O(SDCL(0)),SDECS=$O(SDCL(SDBCS)) S:SDECS="" SDECS=SDBCS S SDT(2)=SDT(2)_":  "_SDBCS_" TO "_SDECS
 I SDF="CG" S SDI=$O(SDCL(0)),SDT(2)=SDT(2)_": "_SDCL(SDI)
 S SDH(1)="W !?31,""Scheduled"",?45,""Addl."",?65,""Addl."",!?37,""and"",?42,""Variable"",?62,""Variable"",?114,""Percent"",?125,""Percent"""
 S SDH(2)="W !?29,""Unscheduled"",?45,""Appt."",?63,""No-show"",?76,""Over"",?86,""Open"",?92,""Adjusted"",?104,""Clinic"",?115,""Sched."",?126,""Actual"""
 S SDH(3)="W !?28,""Appointments"",?45,""Slots"",?52,""No-shows"",?65,""Slots"",?75,""Books"",?85,""Slots"",?94,""Avail."",?102,""Capacity"",?116,""Util."",?127,""Util."""
 D:$E(IOST)="C" DISP0^SCRPW23 I '$D(^TMP("SCRPW",$J)) S SDIV=0 D DHDR^SCRPW40(4,.SDT),HDR S SDX="No availability found for the specified date range." W !!?(132-$L(SDX)\2),SDX D FOOT G EXIT
 S SDIV="" F  S SDIV=$O(SDDIV(SDIV)) Q:'SDIV  S SDIV(SDDIV(SDIV))=SDIV
 I 'SDDIV,$P(SDDIV,U,2)'="ALL DIVISIONS" S SDIV($P(SDDIV,U,2))=$$PRIM^VASITE()
 I $P(SDDIV,U,2)="ALL DIVISIONS" S SDI=0 F  S SDI=$O(^TMP("SCRPW",$J,SDI)) Q:'SDI  S SDX=$P($G(^DG(40.8,SDI,0)),U) S:$L(SDX) SDIV(SDX)=SDI
 S SDIVN="" F  S SDIVN=$O(SDIV(SDIVN)) Q:SDIVN=""!SDOUT  S SDIV=SDIV(SDIVN) D DPRT(.SDIV)
 S SDI=0,SDI=$O(^TMP("SCRPW",$J,SDI)),SDMD=$O(^TMP("SCRPW",$J,SDI))
 G:SDOUT EXIT I SDMD S SDIV=0 D DPRT(.SDIV)
 I $E(IOST)="C",'SDOUT N DIR S DIR(0)="E" D ^DIR
 ;
EXIT K SDA,SDAVA,SDMAX,SDC,SDCL,SDCL0,SDCLI,SDCLN,SDCT,SDDAY,SDEDAY,SDF,SDF1,SDH,SDI,SDL,SDAP,SDCAP,SDLINE,SDTAP,SDTOB,SDTSL,DTOUT,SDCP0,SDNS,SDPAS,SDTNS
 K SDCG,SDPAGE,SDDIV,SDAC,SDBDAY,SDEDAY,SDPBDA,SDPEDA,SDPNOW,SDLINE,%,%H,%I,%DT,SDIVN,SDLAP,SDMD,SDNSVS,SDOUT,SDPESL,SDPLAP,SDTNSVS,SDTVSL,SDVSL,SDX
 K SDSUB,SDS,SDTOS,SD,SDBCS,SDCSC,SDECS,SDECL,SDOB,SDOS,SDPCT,SDPR,SDPRN,SDQUIT,SDSL,SDT,SDTITL,DGPGM,DGVAR,DIC,DIR,STOUT,DUOUT,POP,X,X1,X2,Y,%Y
 D END^SCRPW50
 Q
 ;
INIT ;Initialize array for counting patterns
 K SD N I
 S SD="123456789jklmnopqrstuvwxyz"
 F I=1:1:26 S SD($E(SD,I))=I
 Q
 ;
DPRT(SDIV) ;Print report for a division
 D DHDR^SCRPW40(4,.SDT),HDR I '$D(^TMP("SCRPW",$J,SDIV)) S SDX="No availability found for this division within report parameters!" W !!?(132-$L(SDX)\2),SDX D FOOT Q
 W !!,"*** CLINIC SUMMARY ***" S SDCLN="",(SDTAP,SDTOB,SDTSL,SDTNS,SDTVSL,SDTNSVS,SDTOS)=0 D START^SCRPW3
 Q
 ;
SEL ;Select clinics
 W ! F  D ASK Q:(SDQUIT!(X=""))
 Q
ASK K DIC S DIC(0)="AEMQ",DIC="^SC(",DIC("S")="I $P(^(0),U,3)=""C""" S:SDDIV DIC("S")=DIC("S")_",$D(SDDIV(+$P(^(0),U,15)))" D ^DIC
 I ($D(DTOUT)!$D(DUOUT)) S SDQUIT=1
 S:Y>0 SDCL(+Y)=""
 Q
 ;
SRC ;Select range of clinics
 W ! K DIC S DIC="^SC(",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,3)=""C"""_$S(SDDIV:",$D(SDDIV(+$P(^(0),U,15)))",1:""),DIC("A")="Select BEGINNING Clinic: " D ^DIC Q:($D(DTOUT)!$D(DUOUT)!(X=""))  S SDCL($P(Y,U,2))=$P(Y,U)
C2 W ! S DIC("A")="Select ENDING Clinic: " D ^DIC Q:($D(DTOUT)!$D(DUOUT)!(X=""))  I $P(Y,U,2)]$O(SDCL("")) S SDCL($P(Y,U,2))=$P(Y,U) Q
 W !!,$C(7),"Ending clinic must collate after beginning clinic!" G C2
 ;
SRS ;Select range of stop codes
 W ! K DIR S DIR(0)="N^100:999",DIR("A")="Select BEGINNING Stop Code: " D ^DIR Q:($D(DTOUT)!$D(DUOUT))  S SDCL(Y)="",DIR(0)="N^"_Y_":999",DIR("A")="Select ENDING Stop Code: "
 W ! D ^DIR Q:($D(DTOUT)!$D(DUOUT))  S SDCL(Y)=""
 Q
 ;
SCG ;Select clinic group
 W ! K DIC S DIC="^SD(409.67,",DIC(0)="AEMQ" D ^DIC Q:$D(DTOUT)!$D(DUOUT)  Q:Y<1  S SDCL(+Y)=$P(Y,U,2)
 Q
 ;
HDR ;Print report header
 I $E(IOST)="C",SDPAGE>1 N DIR S DIR(0)="E" D ^DIR S SDOUT=Y'=1 Q:SDOUT
 D STOP^SCRPW3 Q:SDOUT
 W:SDPAGE>1!($E(IOST)="C") $$XY^SCRPW50(IOF,1,0) W:$X $$XY^SCRPW50("",0,0) W SDLINE S X=0 F  S X=$O(SDT(X)) Q:'X  W !?(132-$L(SDT(X))\2),SDT(X)
 W !,SDLINE,!,"For date range: ",SDPBDA," to ",SDPEDA,!,"Date printed: ",SDPNOW,?(126-$L(SDPAGE)),"Page: ",SDPAGE
 W !,SDLINE S X=0 F  S X=$O(SDH(X)) Q:'X  X SDH(X)
 W !,SDLINE S SDPAGE=SDPAGE+1
 Q
 ;
FOOT ;Print footer
 N SDI
 F SDI=1:1:80 Q:$Y>(IOSL-8)  W !
 W SDLINE,!,"NOTE: Appointment totals include no-shows, overbooks, sched. and unsched. appts.  Overbooks = sched. and unsched. appts. - clinic"
 W !?6,"capacity (or 0 if greater).  Open slots = regular (untaken) appt. slots.  Adjusted availability = clinic capacity - sched. and"
 W !?6,"unsched. appts. - additional variable appt. slots.  Percent scheduling utilization = sched. and unsched. appts. + additional"
 W !?6,"variable appt. slots (times 100) divided by clinic capacity.  Percent actual utilization = sched. and unsched. appts. + addl."
 W !?6,"variable appointment slots - no-shows - additional variable no-show slots (times 100) divided by clinic capacity.",!,SDLINE
 Q
