DGPPRP3 ;LIB/MKN - PRESUMPTIVE PSYCHOSIS PATIENT PROFILES;08/02/2019
 ;;5.3;Registration;**977**August 02, 2019;;Build 177
 ;
 ;IA's
 ;   664 Sup DIVISION^VAUTOMA
 ; 10003 Sup ^%DT
 ; 10004 Sup ^DIQ:   $$GET1, GETS
 ; 10026 Sup ^DIR
 ; 10063 Sup ^%ZTLOAD
 ; 10086 Sup ^%ZIS:  HOME
 ; 10089 Sup ^%ZISC
 ; 10103 Sup ^XLFDT: $$FMTE, $$FMADD
 ;
 Q
 ;
EN ;entry point from Menu Option: PRESUMPTIVE PSYCHOSIS PATIENT PROFILE REPORT
 N DFN,DGCAT,DGDASH,DGDIV,DGDIVSEL,DGRET,DGDT,DGDTDEF,DGDTF,DGDTFRM,DGDTFSEL,DGDTSEL,DGDTT,DGDTTO,DGDTTSEL,DGRTYP
 N DGRES,DGSAVIOM,DGSELDIV,DGSET,DGTEMP,DGYN,IENDFN,POP,VAUTD,Y,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 S DGTEMP=$NA(^TMP("DGPPRP3",$J)) K @DGTEMP
 ;DG*5.3*977 PP
 ;B9S3
 W @IOF
 W !,"PRESUMPTIVE PSYCHOSIS PATIENT PROFILE REPORT"
 ;PRESUMPTIVE PSYCHOSIS PATIENT PROFILE REPORT help text
 D HELP(1)
 W !!,*7,!,"THIS REPORT REQUIRES 132 COLUMN OUTPUT"
ASKDIV ;Select Division
 Q:'$$SELDIV^DGPPRP1(.DGDIVSEL)
 ;
 S DGDTDEF=$$GETDEFD^DGPPRP1() I DGDTDEF="" W !!,"There is no record of patch DG*5.3*977 being installed!",!! Q
 S DGDTSEL=$$DTFRMTO^DGPPRP1("Select dates") ;G:'DGDTSEL ASKDIV
 Q:DGDTSEL=0
 S DGDTFSEL=$P(DGDTSEL,U,2),DGDTTSEL=$P(DGDTSEL,U,3)
 ; Allow queueing
 K IOP,IO("Q") S %ZIS="MQ",%ZIS("B")="" S POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q   ;Queued report settings
 .S ZTDESC="Presumptive Psychosis Report",ZTRTN="DQ^DGPPRP3"
 .S ZTSAVE("DGRTYP")="",ZTSAVE("DGDTFRMT")="",ZTSAVE("DGDTFRM")="",ZTSAVE("ZTREQ")="@",ZTSAVE("DGDTTO")=""
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR K DIR
DQ ;
 S DGDT=$$FMADD^XLFDT(DGDTFSEL,-1)_".2399" F  S DGDT=$O(^DGPP(33.1,"AC",DGDT)) Q:DGDT=""!(DGDT<DGDTFSEL&(DGDT>DGDTTSEL))  D
 . S DGCAT="" F  S DGCAT=$O(^DGPP(33.1,"AC",DGDT,DGCAT)) Q:DGCAT=""  D
 .. S IENDFN=0 F  S IENDFN=$O(^DGPP(33.1,"AC",DGDT,DGCAT,IENDFN)) Q:'IENDFN  D
 ... S DFN=$P($G(^DGPP(33.1,IENDFN,0)),U) Q:'DFN
 ... K DGRET D CHKTREAT^DGPPRP1(.DGRET,DFN,DGDTFSEL,DGDTTSEL,.DGDIVSEL) Q:'$D(DGRET)
 ... S DGDIV="" F  S DGDIV=$O(DGRET(DGDIV)) Q:DGDIV=""  D DQ1
 S DGDASH="",$P(DGDASH,"-",133)=""
 D PRINT,OUT
 I $E(IOST,1,2)="C-" R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 Q
 ;
DQ1 ;
 N DGDT1
 S DGDT1="" F  S DGDT1=$O(DGRET(DGDIV,DGDT1)) Q:DGDT1=""  D
 . I DGDIVSEL=1 D SET Q  ;If all Divisions selected
 . I $D(DGDIVSEL(DGDIV)) D SET  ;If selected Division match
 Q
 ;
SET ;
 N DGDISCH,DGDISCTY,DGENCAT,DGFAC,DGIEN2711,DGIEN2715,DFNS,DGN,DGOUT,DGOUTP,DGPATNA,DGPE,DGSERVDT,IEN3216,IENS3216
 S DFNS=DFN_"," ;,DGPATNA=$$GET1^DIQ(2,DFNS,.01)
 S IEN3216=$O(^DPT(DFN,.3216,"@"),-1),(DGDISCTY,DGSERVDT)=""
 K DGOUT I IEN3216 D GETS^DIQ(2.3216,IEN3216_","_DFNS,".02;.06","IE","DGOUT") D
 . S IENS3216=IEN3216_","_DFNS,DGSERVDT=$G(DGOUT(2.3216,IENS3216,.02,"I")) S:DGSERVDT?1.N DGSERVDT=$$FMTE^XLFDT(DGSERVDT,"5PZ")
 . S DGDISCTY=$G(DGOUT(2.3216,IENS3216,.06,"E"))
 D GETS^DIQ(2,DFNS,".01;.0905;.323;.361","","DGOUTP")
 S @DGTEMP@(DGDIV,DFN)=$G(DGOUTP(2,DFNS,.01))_U_$G(DGOUTP(2,DFNS,.0905))_U_DGSERVDT_U_DGDISCTY
 S @DGTEMP@(DGDIV,DFN)=@DGTEMP@(DGDIV,DFN)_U_$G(DGOUTP(2,DFNS,.323))_U_$G(DGOUTP(2,DFNS,.361))_U
 S DGIEN2711=$O(^DGEN(27.11,"C",DFN,"")),DGENCAT=""
 I DGIEN2711 S DGIEN2715=$$GET1^DIQ(27.11,DGIEN2711_",",.04,"I"),DGENCAT=$$GET1^DIQ(27.15,DGIEN2715_",",.02)
 S @DGTEMP@(DGDIV,DFN)=@DGTEMP@(DGDIV,DFN)_DGENCAT
 Q
 ;
PRINT ;Print out results
 N DGI,DGPATNA,DGX,DGY,PAGE,EXIT,DGHDRYN
 W @IOF I '$D(@DGTEMP) W !!?10," << None found >> ",!! G OUT
 S (EXIT,PAGE,DGHDRYN)=0
 S DGDIV="" F  S DGDIV=$O(@DGTEMP@(DGDIV)) Q:DGDIV=""!(EXIT)  D
 .S DGHDRYN=1
 .S DFN="" F  S DFN=$O(@DGTEMP@(DGDIV,DFN)) Q:DFN=""!(EXIT)  S DGX=@DGTEMP@(DGDIV,DFN) D PRINT2
 .Q
 W !
 I $E(IOST,1,2)="C-",'EXIT R !!?8,"End of the Report...Press Enter to Continue",X:DTIME W @IOF
 Q
 ;
PRINT2 ;
 I $Y+5>IOSL!DGHDRYN,PAGE>0 I ($E(IOST,1,2)="C-")&(IO=IO(0)) W ! S DIR(0)="E" D ^DIR K DIR D
 .I $D(DTOUT)!($D(DUOUT)) S EXIT=1 Q
 .W @IOF D HDR S DGHDRYN=0
 .Q
 Q:EXIT
 I DGHDRYN D HDR S DGHDRYN=0
 W !,$E($P(DGX,U),1,20),?22,$P(DGX,U,2),?29,$$FMTE^XLFDT($P(DGX,U,3)),?43,$E($P(DGX,U,4),1,14),?58,$E($P(DGX,U,5),1,20),?81,$E($P(DGX,U,6),1,19),?103,$E($P(DGX,U,7),1,29)
 Q
 ;
HDR ; Print page header
 N DGX
 S PAGE=PAGE+1
 S DGX="Presumptive Psychosis Patient Profile",DGX=$J(" ",132-$L(DGX)\2)_DGX
 W DGX,?120,"Page: ",PAGE
 S DGX="Division: "_$$GET1^DIQ(40.8,DGDIV_",",.01),DGX=$J(" ",132-$L(DGX)\2)_DGX W !,DGX
 S DGX="Date Range: "_$$FMTE^XLFDT(DGDTFSEL,"5PZ")_" to "_$$FMTE^XLFDT(DGDTTSEL,"5PZ"),DGX=$J(" ",132-$L(DGX)\2)_DGX W !,DGX
 W ?104,"Date Printed: ",$$FMTE^XLFDT($P($$NOW^XLFDT(),"."))
 W !,DGDASH,!,"PATIENT NAME",?22,"PID",?29,"  SERVICE",?43,"DISCHARGE",?58,"PERIOD OF SERVICE",?81,"PRIMARY ELIGIBILITY"
 W ?103,"ENROLLMENT CAT",!?27,"SEPARATION DATE",?43,"  TYPE",!,DGDASH
 ;
 Q
 ;
DTFRMTO(PROMPT)  ;Get from and to dates 
 N %DT,Y,X,DTOUT,OUT,DIRUT,DUOUT,STATUS,STDT,STATUS
 ;INPUT ;   PROMPT - Message to display prior to prompting for dates
 ;OUTPUT:     1^BEGDT^ENDDT - Data found
 ;            0             - User up arrowed or timed out
 ;If they want to show first available date for that set of Status, use this sub
INDT ;
 S OUT=0
 S DIR(0)="DO^"_DT_":"_DT_":EX"
 S %DT="AEX",%DT("A")="From date: " ;Enter Beginning Date: "
 W ! D ^%DT K %DT
 I Y<0 W !!,"No Date selected, quitting. ",!! Q OUT  ;Quit if user time out or didn't enter valid date
 I Y>DT W !!,"Future dates are not allowed, please re-enter" K Y,%DT G INDT  ;Future dates not allowed
 S DGDTFRM=+Y,%DT="AEX",%DT("A")="To date:   ",%DT("B")="T" ; Get end date, default is "TODAY"
 D ^%DT K %DT
 ;Quit if user time out or didn't enter valid date
 I Y<0 W !!,"No Date selected, quitting. ",!! Q OUT
 S DGDTTO=+Y,OUT=1_U_DGDTFRM_U_DGDTTO
 ;Switch dates if Begin Date is more recent than End Date
 S:DGDTFRM>DGDTTO OUT=1_U_DGDTTO_U_DGDTFRM
 Q OUT
 ;
 ;DG*5.3*977 PP
 ;B9S3
HELP(DGSEL) ;
 I DGSEL=1 D
 . W !!,"This option generates a report that prints a list of all patients treated"
 . W !,"under Presumptive Psychosis authority and who had an Outpatient Encounter"
 . W !,"with the STATUS=CHECKED OUT for Clinic(s) associated with the selected"
 . W !,"Division(s) within the user specified date range."
 Q
 ;
OUT ; KILL RETURN ARRAY QUIT
 D ^%ZISC
 K @DGTEMP
 Q
