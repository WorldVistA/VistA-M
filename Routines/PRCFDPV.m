PRCFDPV ;WISC/LEM-PAYMENT ERROR PROCESSING ;12/15/94  09:59
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
V ;
TPVI ; Entry point for Payment Voucher Inquiry
 D HILO^PRCFQ,SCREEN
 S TXT="Payment Voucher Number: ",PRCFA("ERROR")=0
 D EN^PRC0E("PV:Payment Voucher^"_TXT,"D TYPE^PRCFDPVI(.X)")
 D OUT
 QUIT
TPVR ; Entry point for Payment Voucher Rebuild/Retransmit
 D HILO^PRCFQ,SCREEN
 S TXT="Select Payment Voucher Number: ",PRCFA("ERROR")=0
 ;D EN^PRC0E("PV^MO^SO~"_TXT,"D TYPE^PRCFDPVT(.X)")
 ;D EN^PRC0E("PV:Payment Voucher^"_TXT_"^R","D TYPE^PRCFDPVT(.X)")
 D EN^PRC0E("PV:Payment Voucher^"_TXT_"^~R~N~E~T~~^","D TYPE^PRCFDPVT(.X)")
 D OUT
 QUIT
 ;
OUT K GECSDATA,FMSTYPE,FMSNO,STATUS,DIC,PATNUM,PONUM,MOP,LOOP,POIEN,TXT
 K PRCFA,IOINHI,IOINLOW,IOINORM
 Q
SCREEN ; Control screen display;
 I $D(IOF) W @IOF
HDR ; Write Option Header
 I $D(XQY0) W IOINHI,$P(XQY0,U,2),IOINORM
 Q
