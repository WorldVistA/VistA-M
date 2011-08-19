SDWLIFT7 ; bp-oifo/og ; Print reports  ; Compiled April 11, 2005 16:10:09
 ;;5.3;Scheduling;**415**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;
 ;
 ; Print coversheet, dialog.
 D DIALOG("EN1^"_$T(+0),"SDWL TRANSFER COVERSHEET")
 S VALMBCK="R"
 Q
REQS ; All transfer requests
 N SDWLSPS  ; Required as this is called from a menu option.
 S SDWLSPS=$J("",80)
 D DIALOG("EN2^"_$T(+0),"SDWL TRANSFER PRINT REQUESTS")
 Q
HEAD ; Write header.
 S SDWLLINE=3,SDWLPAGE=SDWLPAGE+1
 W !?80-$L(SDWLTTL)\2,SDWLTTL,?75-$L(SDWLPAGE),"PAGE ",SDWLPAGE,!
 Q
EN1 ; Print coversheet.
 N SDWLTTL,SDWLINFO,SDWLPAGE,SDWLLINE,SDWLI
 D GETINFO^SDWLIFT6(.SDWLINFO)
 S SDWLTTL="SDWL TRANSFER - COVERSHEET",SDWLPAGE=0
 D HEAD
 F SDWLI=1:1:SDWLINFO(0) D
 .S SDWLLINE=SDWLLINE+1
 .I SDWLLINE+3>IOSL D HEAD
 .W !,SDWLINFO(SDWLI,0)
 .Q
 Q
EN2 ; Print requests
 N SDWLINFO,SDWLTTL,SDWLPAGE,SDWLLINE,SDWLI
 D GETDATA^SDWLIFT5(.SDWLINFO,1)
 S SDWLTTL="SDWL TRANSFER - TRANSFER REQUESTS",SDWLPAGE=0
 D HEAD
 F SDWLI=1:1:SDWLINFO(0) D
 .I SDWLLINE+8>IOSL D HEAD
 .W !,"Name: ",$E($P(SDWLINFO(SDWLI,0),U)_SDWLSPS,1,32)
 .W "Sex: ",$P(SDWLINFO(SDWLI,0),U,8)
 .W "  SSN: ",$E($P(SDWLINFO(SDWLI,0),U,2)_SDWLSPS,1,14)
 .W !,"Wait List Type: ",$P(SDWLINFO(SDWLI,0),U,6)
 .W " : ",$P(SDWLINFO(SDWLI,0),U,7)
 .W !,"Status: ",$E($P(SDWLINFO(SDWLI,0),U,4)_SDWLSPS,1,14)
 .W "Transmission time: ",$P(SDWLINFO(SDWLI,0),U,9)
 .W !,"Requestor: ",$P(SDWLINFO(SDWLI,0),U,10),!
 .S SDWLLINE=SDWLLINE+5
 .Q
 Q
DIALOG(ZTRTN,SDWLDESC) ; Required variable - SDWLIFTN: SDWL Transfer id.
 N DIE,DA,DR
 K %ZIS,IOP,POP,ZTSK,SDWLIO
 S ZTDESC=SDWLDESC
 D FULL^VALM1
 S SDWLIO=ION,%ZIS="Q"
 D ^%ZIS
 K %ZIS
 S IOM=80
 I POP D  ; Do-dots preserve $T
 .S IOP=SDWLIO
 .D ^%ZIS
 .K IOP,SDWLIO
 .W !,"Please try later!"
 .Q
 E  D  I $G(SDWLDESC)="SDWL TRANSFER COVERSHEET" S DIE="^SDWL(409.36,",DA=SDWLIFTN,DR=".3///Y" D ^DIE
 .K SDDIO
 .I '$D(IO("Q")) D @ZTRTN Q
 .K IO("Q"),ZTIO,ZTSAVE,ZTDTH,ZTSK
 .S ZTDTH=$H S:$D(SDWLIFTN) ZTSAVE("SDWLIFTN")=SDWLIFTN,ZTSAVE("SDWLSPS")=SDWLSPS
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report is queued to print !!" K ZTSK
 .Q
END ; Tidy up.
 W ! D ^%ZISC
 Q
