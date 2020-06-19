DGPPRP2 ;LIB/MKN - PRESUMPTIVE PSYCHOSIS STATISTICAL REPORT ;08/02/2019
 ;;5.3;Registration;**977**August 02, 2019;;Build 177
 ;
 ;IA's
 ; 10004 Sup ^DIQ:   $$GET1, GETS
 ; 10026 Sup ^DIR
 ; 10063 Sup ^%ZTLOAD
 ; 10086 Sup ^%ZIS:  HOME
 ; 10089 Sup ^%ZISC
 ; 10103 Sup ^XLFDT: $$FMTE, $$FMADD
 ;
 Q
 ;
EN ;entry point from Menu Option: PRESUMPTIVE PSYCHOSIS STATISTICAL REPORT
 N DFN,DGCAT,DGDIV,DGDT,DGDTDEF,DGDTF,DGDTT,DGHDRDT,DGI,DGSTD,DGTEMP,DGY,IENDFN,POP,X,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
SELDATES ;
 S DGDTDEF=$$GETDEFD^DGPPRP1() I DGDTDEF="" W !!,"There is no record of patch DG*5.3*977 being installed!",!! Q
 S DGDT=$$DTFRMTO^DGPPRP1("Select dates")
 Q:+DGDT=0
 S DGDTF=$P(DGDT,U,2),DGDTT=$P(DGDT,U,3)
 S DGTEMP=$NA(^TMP("DGPPRP2",$J)) K @DGTEMP
 ; Allow queueing
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q   ;Queued report settings
 .S ZTDESC="Presumptive Psychosis Statistical Report",ZTRTN="DQ^DGPPRP2"
 .S ZTSAVE("DGRTYP")="",ZTSAVE("DGDTFRMT")="",ZTSAVE("DGDTFRM")="",ZTSAVE("ZTREQ")="@",ZTSAVE("DGDTTO")=""
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
DQ ;
 S DGDT=$$FMADD^XLFDT(DGDTF,-1)_".2399" F  S DGDT=$O(^DGPP(33.1,"AC",DGDT)) Q:'DGDT!(DGDT>DGDTT)  D
 . S DGCAT="" F  S DGCAT=$O(^DGPP(33.1,"AC",DGDT,DGCAT)) Q:DGCAT=""  D
 .. S IENDFN=0 F  S IENDFN=$O(^DGPP(33.1,"AC",DGDT,DGCAT,IENDFN)) Q:'IENDFN  D
 ... S DFN=$P($G(^DGPP(33.1,IENDFN,0)),U) Q:'DFN
 ... S @DGTEMP@(0)=$G(@DGTEMP@(0))+1,@DGTEMP@(DGCAT)=$G(@DGTEMP@(DGCAT))+1
 D PRINT,OUT
 I $E(IOST,1,2)="C-" R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 Q
 ;
PRINT ;Print out results
 N DASH,DGCAT,DGCATL,DGX,Y
 S DGX=$P(^DD(2,.5601,0),U,3),DASH="",$P(DASH,"-",81)=""
 F DGI=1:1:$L(DGX,";")-1 S DGY=$P(DGX,";",DGI) S DGCATL($P(DGY,":"))=$P(DGY,":",2)
 S DGHDRDT="Date Range: "_$$FMTE^XLFDT(DGDTF)_" - "_$$FMTE^XLFDT(DGDTT)
 W @IOF D HELP
 S DGX="Presumptive Psychosis Statistical Report" W !!,$J(" ",80-$L(DGX)\2),DGX
 W !,$J(" ",80-$L(DGHDRDT)\2),DGHDRDT,! S DGX="Date Report Printed: " S Y=DT X ^DD("DD") S DGX=DGX_Y
 W $J(" ",80-$L(DGX)\2),DGX
 W !!,"Patients registered under different Presumptive Psychosis Categories",!,DASH
 S DGCAT=0 F  S DGCAT=$O(DGCATL(DGCAT)) Q:DGCAT=""  D
 . S DGX=DGCATL(DGCAT)
 . S DGX=DGX_$J(" ",28-$L(DGX))_" : "_$J($FN(+$G(@DGTEMP@(DGCAT)),","),6) W !!,DGX
 W !,DASH,!!,"TOTAL NUMBER OF PATIENTS REGISTERED UNDER PRESUMPTIVE PSYCHOSIS AUTHORITY: ",$FN(+$G(@DGTEMP@(0)),",")
 W !! D HELP
 Q
 ;
SET ;
 N DFNS,DGOUT
 S DFNS=DFN_"," D GETS^DIQ(2,DFNS,".01;.0905",,"DGOUT")
 S @DGTEMP@(DGDIV,DGCAT,DGDT,DFN,DGI)=$G(DGOUT(2,DFNS,.01))_U_$G(DGOUT(2,DFNS,.0905))_U_DGSTD
 Q
 ;
HELP ;
 W "This report reflects the number of Veterans registered under Presumptive"
 W !,"Psychosis authority, not necessarily treated."
 Q
 ;
OUT ; KILL RETURN ARRAY QUIT
 D ^%ZISC
 K @DGTEMP
 Q
