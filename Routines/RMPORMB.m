RMPORMB ;HIN/RVD - Home Oxygen Monthly Billing Report ;12/13/99
 ;;3.0;PROSTHETICS;**29,43,44,49,55,159**;Feb 09, 1996;Build 2
 ;ODJ - 5/17/00 - fix FCP problem (patch 49)
 ;      5/25/00 - fix crash if FCP in ^RMPO(665.72) and not ^RMPR(669.9)
 ;      5/31/00 - fix crash if FCP is null
 ;
 ;ODJ - 10/31/00 - patch 55 - fix problem where totals not being
 ;                            displayed when page contains 16 pats.
START ;
 K RQUIT,RSP,RCNT,RPAGE,RDASH,RPTDT,RSHODT,VA,VADM,DFN,RNAM,RMNADFN
 K Y,RAMT,RLINE,ROVNDR,^TMP($J),RMEND,QUIT
 ;
SITE ;Intialize site variables.
 D HOSITE^RMPOUTL0 I '$D(RMPOXITE) Q
 ;
FROM ; Get billing month
 ; specify start/end site & bill month
 D MONTH^RMPOBIL0() Q:'$D(RMPODATE)!QUIT
DEV S %ZIS="MQ" K IOP D ^%ZIS G:POP EXIT I '$D(IO("Q")) U IO G PROC
 K IO("Q") S ZTDESC="HOME OXYGEN MONTHLY BILLING",ZTRTN="PROC^RMPORMB",ZTIO=ION,ZTSAVE("RMPODATE")="",ZTSAVE("RMPO(""STA"")")="",ZTSAVE("RMPOXITE")=""
 S ZTSAVE("RMPO(""NAME"")")=""
 D ^%ZTLOAD W:$D(ZTSK) !,"REQUEST QUEUED!" H 1 G EXIT
PROC ;
 S (RPAGE,RMEND,RMPORPT,RVCNT,RPCNT,RVPRCNT)=0
 S Y=RMPODATE D DD^%DT S RSHODT=Y
 S $P(RSP," ",79)=" ",RCNT=0,$P(RDASH,"-",80)=""
 D NOW^%DTC S Y=% X ^DD("DD")
 S RPTDT=$P(Y,"@",1)_"  "_$P($P(Y,"@",2),":",1,2)
 F I="T9","TS","TO","SP",1,2,3 S RAMT(I)=0
 K RFCPT S RFCPI=""
 F  S RFCPI=$O(^RMPR(669.9,RMPOXITE,"RMPOFCP","B",RFCPI)) Q:RFCPI=""  D
 . S RFCPIEN=$O(^RMPR(669.9,RMPOXITE,"RMPOFCP","B",RFCPI,0))
 . S RPSASFLG=$P(^RMPR(669.9,RMPOXITE,"RMPOFCP",RFCPIEN,0),U,2)
 . ;S RFCPT(RFCPI)=$S(+RFCPI=910:1,RPSASFLG="Y":2,1:3)
 . ;p49 replaces above logic - if PSAS then col 1 else col 2
 . S RFCPT(RFCPI)=$S(RPSASFLG="Y":1,1:2)
 . Q
 D LINE
 D PRINT G:$G(RMEND) EXIT
 I $E(IOST)["C",(RVCNT=1),(RVPRCNT=1) D  ; if terminal
 .K DIR S DIR("A")="Enter RETURN to continue or '^' to QUIT",DIR(0)="E"
 .D ^DIR S:$G(X)[U RMEND=1
EXIT ;clean-up local variables and close device
 D ^%ZISC K ^TMP($J)
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
 ;
NAME ;Write out the name
 S RLINE=RLINE_$E($P(RNAM,U,1)_RSP,1,14)
 S RLINE=RLINE_$E($P(RNAM,U,2)_RSP,1,6)
 Q
 ;
LINE ;Process entire line (one for each patient)
 W:$E(IOST)["C" "processing..."
 F RV=0:0 S RV=$O(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RV)) Q:RV'>0  D SETRV F RN=0:0 S RN=$O(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RV,"V",RN)) Q:RN'>0  D
 .K VA,VADM S DFN=RN D ^VADPT
 .S RNAM=$E(VADM(1),1,12)_"^"_$P(VA("PID"),"-",3)
 .S RACPT=$P(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RV,"V",RN,0),U,2)
 .S RPSTD=$P(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RV,"V",RN,0),U,3)
 .S RAMT(RV,1)=0,RAMT(RV,2)=0,RAMT(RV,3)=0,RAMT(RV,"SUSP")=0
 .F RI=0:0 S RI=$O(^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RV,"V",RN,1,RI)) Q:RI'>0  D
 ..S RD=^RMPO(665.72,RMPOXITE,1,RMPODATE,1,RV,"V",RN,1,RI,0)
 ..S RCOST=$P(RD,U,5),RTOTAL=$P(RD,U,6),RFCP=$P(RD,U,3),RSUSP=$P(RD,U,11)
 ..S:RFCP="" RFCP="???"
 ..I '$D(RFCPT(RFCP)) S RFCPT(RFCP)=2 ;p49 fix problem where FCP not in site file ^RMPR(669.9) (use the OTHER col. in this case)
 ..S RX=RFCPT(RFCP),RAMT(RV,RX)=$G(RAMT(RV,RX))+RTOTAL,RAMT(RV,"SUSP")=$G(RAMT(RV,"SUSP"))+RSUSP
 .S RLINE=$S(RACPT="Y":"a",1:" ")_$S(RPSTD="Y":"#",RPSTD="P":"p",1:" ")
 .S RLINE=$E(RLINE_RSP,1,4) D NAME
 .S RLINE=RLINE_$E($P(^PRC(440,RV,0),U)_RSP,1,8)_" "
 .S RMT1=$G(RAMT(RV,1))
 .S RMT2=$G(RAMT(RV,2))
 .S RMT3=$G(RAMT(RV,3))
 .S RMTP=$G(RAMT(RV,"SUSP"))
 .D AMTS(RMT1,RMT2,RMT3,RMTP)
 .S RTMT(RV,"T9")=RTMT(RV,"T9")+RMT1,RTMT(RV,"TS")=RTMT(RV,"TS")+RMT2
 .S RTMT(RV,"TO")=RTMT(RV,"TO")+RMT3,RTMT(RV,"SP")=RTMT(RV,"SP")+RMTP
 .S RMNADFN=RNAM_"^"_RN,^TMP($J,RV,RMNADFN)=RLINE
 Q
 ;
PRINT ;print report
 I '$D(^TMP($J)) W !,"***** No RECORDS to Print *****" Q 
 S (RVPRCNT,RPCNT,RCNT)=0
 F RV=0:0 S RV=$O(^TMP($J,RV)) Q:RV'>0!($G(RMEND))  D RPTHDR S RN="" F  S RN=$O(^TMP($J,RV,RN)) Q:$G(RMEND)  D:RN="" DND Q:RN=""  D
 .W !,$G(^TMP($J,RV,RN)) S RPCNT=RPCNT+1,RCNT=RCNT+1 D:IOSL<(RCNT+9) PAGE Q:$G(RMEND)
 D GTOTAL
 Q
 ;
SETRV ;
 F I=1,2,3 S RAMT(RV,I)=0
 F I="T9","TS","TO","SP" S RTMT(RV,I)=0
 S RVCNT=RVCNT+1
 Q
 ;
AMTS(C,Y,Z,S) ; Amounts
 S RLINE=RLINE_$E($$AMT(C)_RSP,1,9)
 S RLINE=RLINE_$E($$AMT(Y)_RSP,1,9)
 S RLINE=RLINE_$E($$AMT(Z)_RSP,1,9)
 S RLINE=RLINE_$E($$AMT(S)_RSP,1,9)
 S RLINE=RLINE_" "_$$AMT(C+Y+Z)
 Q
AMT(C) ; Format Amounts
 I C,C'["." S C=+C_".00"
 I C?.N1"."1N  S C=C_0
 S:C=0 C="-" S C=$E("     ",1,8-$L(C))_C
 Q C
 ;
PAGE ;Print page
 I $E(IOST)["C",IOSL<(RCNT+9) D  ; if terminal
 . K DIR S DIR("A")="Enter RETURN to continue or '^' to QUIT",DIR(0)="E"
 . D ^DIR S:$G(X)[U RMEND=1
 D:'$G(RMEND) RPTHDR
 Q
RPTHDR ; Print out the report header
 Q:$G(RMEND)  K RA
 S RA=RMPO("NAME"),RPAGE=RPAGE+1,RCNT=0
 I $E(IOST)["C"!(RPAGE>1) W @IOF
 W RPTDT,?(40-($L(RA)/2)),RA,?68,"Page: "_RPAGE
 W !?15,RSHODT_" Monthly Home Oxygen Billing",!
 W ?50,"Station",!?50,"Fund Control"
 W !,"ACC",?4,"Name",?18,"SSN",?24,"Vendor"
 W ?37,"910     Point     Other    Susp     Total"
 W !,RDASH
 Q
 ;
DND ; Print REPORT totals
 Q:$G(RMEND)  K RA
 S RLINE="     ",RA=RTMT(RV,"T9")+RTMT(RV,"TS")+RTMT(RV,"TO")-RTMT(RV,"SP")
 I RA D
 . S RMTT9=RTMT(RV,"T9"),RMTTS=RTMT(RV,"TS"),RMTTO=RTMT(RV,"TO")
 . S RMTSP=RTMT(RV,"SP")
 . D AMTS(RMTT9,RMTTS,RMTTO,RMTSP)
 . W !,?20,"Totals: ",RLINE
 S RPCNT=$E("  ",1,(6-$L(RPCNT)))_RPCNT
 W !!,?30,"Total Patients: ",RPCNT
 S RVPRCNT=RVPRCNT+1,RPCNT=0
 I $E(IOST)["C",(RVCNT'=RVPRCNT) D  ; if terminal
 .K DIR S DIR("A")="Enter RETURN to continue or '^' to QUIT",DIR(0)="E"
 .D ^DIR S:$G(X)[U RMEND=1
 Q
 ;
GTOTAL ; Print REPORT totals for all VENDORS.
 Q:$G(RMEND)  K RA
 ;S RLINE="     ",RA=RTMT(RV,"T9")+RTMT(RV,"TS")+RTMT(RV,"TO")-RTMT(RV,"SP")
 S RLINE="     "
 S (RMTT9,RMTTS,RMTTO,RMTSP)=0
 I RVCNT>1 D
 .F RI=0:0 S RI=$O(RTMT(RI)) Q:RI'>0  D
 .. S RMTT9=RMTT9+RTMT(RI,"T9"),RMTTS=RMTTS+RTMT(RI,"TS"),RMTTO=RMTTO+RTMT(RI,"TO")
 .. S RMTSP=RMTSP+RTMT(RI,"SP")
 .D AMTS(RMTT9,RMTTS,RMTTO,RMTSP)
 .W !!,?14,"Grand Totals: ",RLINE,!
 .I $E(IOST)["C" D  ; if terminal
 ..K DIR S DIR("A")="Enter RETURN to continue or '^' to QUIT",DIR(0)="E"
 ..D ^DIR S:$G(X)[U RMEND=1
 Q
