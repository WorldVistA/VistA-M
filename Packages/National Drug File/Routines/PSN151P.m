PSN151P ;BIR/DMA-RESET GNCSEQNO FOR 4 ENTRIES ; 08 Aug 2007  10:13 AM
 ;;4.0; NATIONAL DRUG FILE;**151**; 30 Oct 98;Build 2
 N DA,DATA,J,PSN
 F J=1:1 S PSN=$T(LIST+J) Q:PSN=""  S DA=$P(PSN," "),DATA=$P(PSN,";",3),$P(^PSNDF(50.68,DA,1),"^",5,7)=DATA
 K DA,DATA,J,PSN Q
LIST ;
15572 ;;000018^000018^
15573 ;;000019^000019^
15574 ;;000018^^
15575 ;;000019^000019^