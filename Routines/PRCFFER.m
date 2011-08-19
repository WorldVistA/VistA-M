PRCFFER ;WISC/SJG-OBLIGATION ERROR PROCESSING ;6/3/94  9:25 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
 ; No top level entry
TPOI ; Entry point for Purchase Orders Inquiry
 D HILO^PRCFQ,SCREEN
 S TXT1="Purchase Order Number",PRCFA("ERROR")=0,PRCFA("ERTYP")="POREQ"
 S TXT2="Select Stack Document for Inquiry: "
 D EN^PRC0E("MO:Miscellaneous Order;SO:Service Order^"_TXT2,"D TYPE^PRCFFERI(.X)")
 D OUT
 QUIT
TPOR ; Entry point for Purchase Order Rebuild/Retransmit
 D HILO^PRCFQ,SCREEN
 S TXT1="Purchase Order Number",PRCFA("ERROR")=0,PRCFA("ERTYP")="POREQ"
 S TXT2="Select Stack Document for Rebuild/Retransmit: "
 D EN^PRC0E("MO:Miscellaneous Order;SO:Service Order^"_TXT2_"^~R~N~E~T~~^","D TYPE^PRCFFERT(.X)")
 D OUT
 QUIT
T1358I ; Entry point for 1358 Inquiry
 D HILO^PRCFQ,SCREEN
 S TXT1="1358 Obligation Number",PRCFA("ERROR")=0,PRCFA("ERTYP")="MISCOBL"
 S TXT2="Select Stack Document for Inquiry: "
 D EN^PRC0E("SO:Service Order^"_TXT2,"D TYPE^PRCFFERI(.X)")
 D OUT
 QUIT
T1358R ; Entry point for 1358 Rebuild/Retransmit
 D HILO^PRCFQ,SCREEN
 S TXT1="1358 Obligation Number",PRCFA("ERROR")=0,PRCFA("ERTYP")="MISCOBL"
 S TXT2="Select Stack Document for Rebuild/Transmit: "
 D EN^PRC0E("SO:Service Order^"_TXT2_"^~R~E~N~T~~^","D TYPE^PRCFFERT(.X)")
 D OUT
 QUIT
 ;
 ; Entry point for Inquiry for AR documents
TARI D HILO^PRCFQ,SCREEN
 S TXT1="Purchase Order/Obligation Number",PRCFA("ERROR")=0
 S TXT2="Select Stack Document for Inquiry: "
 D EN^PRC0E("AR:Receiver Accrual^"_TXT2,"D TYPE^PRCFFERI(.X)")
 D OUT
 QUIT
 ; Entry point for Rebuild/Retransmit AR documents
TARR D HILO^PRCFQ,SCREEN
 S TXT1="AR Number",PRCFA("ERROR")=0
 S TXT2="Select Stack Document for Rebuild/Retransmit: "
 D EN^PRC0E("AR:Receiver Accrual^"_TXT2_"^~R~E~N~T~~^","D TYPE^PRCFFERT(.X)")
 D OUT
 QUIT
 ;
OUT K GECSDATA,FMSNO,STATUS,DIC,PATNUM,PONUM,MOP,LOOP,POIEN,TXT1,TXT2
 K PRCFA,IOINHI,IOINLOW,IOINORM
 Q
SCREEN ; Control screen display;
 I $D(IOF) W @IOF
HDR ; Write Option Header
 I $D(XQY0) W IOINHI,$P(XQY0,U,2),IOINORM
 Q
