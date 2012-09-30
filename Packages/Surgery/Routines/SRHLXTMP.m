SRHLXTMP ;B'HAM ISC/DLR - Surgery Interface Purge ^XTMP("SRHL7"_CASE# ; 9/3/10 10:04am
 ;;3.0; Surgery ;**41,173**;24 Jun 93;Build 8
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;this routine is used to purge entries from the XTMP global
 N SRX,SRX1
 S SRX="" F  S SRX=$O(^XTMP(SRX)) Q:SRX=""  I SRX["SRHL7" S SRX1=0 F  S SRX1=$O(^XTMP(SRX,SRX1)) Q:'SRX1  D
 .I '$D(^XTMP(SRX,SRX1,0)) K ^XTMP(SRX,SRX1) Q
 .S X1=DT,X2=-1 D C^%DTC I +$G(^XTMP(SRX,SRX1,0))'>X K ^XTMP(SRX,SRX1)
 Q
