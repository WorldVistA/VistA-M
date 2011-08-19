SDWLAHR2 ;;IOFO BAY PINES/TEH - EWL REPORT - REPORT VERSION 2;06/12/2002 ; 20 Aug 2002 2:10 PM
 ;;5.3;scheduling;**419**;AUG 13 1993;Build 16
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 Q
EN ;ENTRY POINT
 D HD
 S DHD="EWL AD HOC REPORT - VERSION 1"
 S DIC=409.3 D EN1^DIP
END K DIC,DHD Q
HD ;
 W:$D(IOF) @IOF W !,?80-$L("Custom AD HOC Report - VERSION 1")\2,"Custom AD HOC Report - VERSION 1",!
 Q
