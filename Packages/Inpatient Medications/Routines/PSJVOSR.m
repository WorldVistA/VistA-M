PSJVOSR ;BIR/DRF-PRINT ACTIVE ORDER SCHEDULE VALIDATION ;13 APR 09 / 5:26 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**113**;16 DEC 97;Build 63
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^%ZTLOAD is supported by DBIA 10063.
 ; Reference to ^%DTC is supported by DBIA 10000.
 ; Reference to ^%ZIS is supported by DBIA 10086.
 ; Reference to ^%ZISC is supported by DBIA 10089.
 ; Reference to ^DIR is supported by DBIA 10026.
 ;
SELDEV ;Ask for device type for report to output to
 K IOP,%ZIS,POP,IO("Q")
 W ! S %ZIS("A")="Select output device: ",%ZIS("B")="",%ZIS="Q"
 D ^%ZIS I POP W !,"** No device selected **" G EXIT
 W:'$D(IO("Q")) !,"this may take a while...(you should QUEUE this report)",!
 I $D(IO("Q")) D  G EXIT
 . S XDESC="Problem Schedules on Orders"
 . S ZTRTN="START^PSJVOSR"
 . K IO("Q"),ZTSAVE,ZTDTH,ZTSK
 . S ZTDESC=XDESC,PSGIO=ION,ZTIO=PSGIO,ZTDTH=$H,ZTSAVE("PSJSORT")="",%ZIS="QN",IOP=PSGIO
 . D ^%ZIS,^%ZTLOAD
 ;
START ;Loop through open orders.
 D NOW^%DTC S UL132="",$P(UL132,"-",132)="",PSJDATE=$$ENDTC^PSGMI(%),PSJPTR=$E(IOST)'="C",PG=0,PSIVAC="PH",PSJPAG=0
 U IO
 D HEAD
 S PSJTYP="U"
 S STPDT=$P(%,".")-1 F  S STPDT=$O(^PS(55,"AUD",STPDT)) Q:STPDT=""  D
 . S D0="" F  S D0=$O(^PS(55,"AUD",STPDT,D0)) Q:D0=""  D
 .. S D1=""  F  S D1=$O(^PS(55,"AUD",STPDT,D0,D1)) Q:D1=""  D
 ... D TEST
 S PSJTYP="V"
 S STPDT=$P(%,".")-1 F  S STPDT=$O(^PS(55,"AIV",STPDT)) Q:STPDT=""  D
 . S D0="" F  S D0=$O(^PS(55,"AIV",STPDT,D0)) Q:D0=""  D
 .. S D1=""  F  S D1=$O(^PS(55,"AIV",STPDT,D0,D1)) Q:D1=""  D
 ... D TEST
EXIT ;Kill and exit.
 K %,%H,%I,%ZIS,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN
 K D0,D1,DONE,ERR,NAME,PG,PSGAT,PSGIO,PSGS0XT,PSGSCH,PSGSSP,PSGSST,PSGST
 K PSIVAC,PSJDATE,PSJPAG,PSJPTR,PSJTYP,SPD,SSN,STD,STPDT,UL132,X,XDESC,Y
 K ZTQUEUED,ZTREQ
 W:$E(IOST)="C"&($Y) @IOF
 S:$D(ZTQUEUED) ZTREQ="@"
 S IOP="HOME" D ^%ZISC
 Q
 ;
DISPLAY ;Display Name, last 4 of SS, order number, start date, stop date, schedule, schedule type, admin times, error.
 S NAME=$$GET1^DIQ(2,D0,.01,"O")
 S SSN="XXX-XX-"_$E($$GET1^DIQ(2,D0,.09,"O"),6,9)
 S Y=PSGSST D DD^%DT S STD=Y
 S Y=PSGSSP D DD^%DT S SPD=Y
 D:($Y+5)>IOSL HEAD
 W !,NAME,?20,SSN,?33,STD,?52,SPD,?71,PSGSCH,?91,$S(+PSGS0XT:"C",1:PSGS0XT),?96,PSGAT,!,ERR
 Q
 ;
PAUSE ;Hold screen.
 K DIR S DIR(0)="E" D ^DIR S:$D(DTOUT)!($D(DUOUT)) DONE=1
 Q
 ;
TEST ;Check for errors.
 N D12,MAX
 I PSJTYP="U" D
 . S D12=$G(^PS(55,D0,5,D1,2))
 . S PSGSCH=$P(D12,"^",1),(X,PSGAT)=$P(D12,"^",5),PSGS0XT=$P(D12,"^",6),PSGSST=$P(D12,"^",2),PSGSSP=$P(D12,"^",4)
 I PSJTYP="V" D
 . S D12=$G(^PS(55,D0,"IV",D1,0))
 . S PSGSCH=$P(D12,"^",9),(X,PSGAT)=$P(D12,"^",11),PSGS0XT=$P(D12,"^",15),PSGSST=$P(D12,"^",2),PSGSSP=$P(D12,"^",3)
 I PSGSCH[" PRN" S PSGS0XT="P"
 I PSGS0XT="P" D  Q  ;No times required or allowed for PRN
 . I X="" Q
 . S ERR="Admin times not permitted for PRN schedule"
 . D DISPLAY
 I PSGS0XT="D"!(PSGS0XT)="OC" Q
 S PSGST=$S(PSGS0XT?1.N:"C",1:PSGS0XT)
 S ERR="" D
 . I X="" S ERR="This order requires at least one administration time" Q
 . I $G(PSGS0XT)="O",$L(X,"-")>1 S ERR="This is a One Time Order - only one admin time is permitted." Q
 . I +PSGS0XT=0 Q  ;No frequency - can not check frequency related items
 . S MAX=1440/PSGS0XT
 . I MAX<1 D  Q
 .. I $L(X,"-")'=1 S ERR="This order requires one admin time." Q
 . I MAX'<1,$L(X,"-")>MAX S ERR="The number of admin times entered is greater than indicated by the schedule." Q  ;Too many times
 . I MAX'<1,$L(X,"-")<MAX S ERR="The number of admin times entered is fewer than indicated by the schedule." Q  ;Too few times
 I ERR]"" D DISPLAY Q
 D ENCHK^PSGS0
 I '$D(X) S ERR="Schedule/Admin times failed validation" D DISPLAY
 Q
 ;
HEAD ;Header.
 W:$Y @IOF S PSJPAG=PSJPAG+1
 W PSJDATE,?47,"Inpatient Medications Schedule Issues",?120,"PAGE: ",PSJPAG,!! W !,"PATIENT",?20,"SSN",?33,"START DATE",?52,"STOP DATE",?71,"SCHEDULE",?91,"TYPE",?96,"ADMIN TIMES"
 W !,UL132
 Q
