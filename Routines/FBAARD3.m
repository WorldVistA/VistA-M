FBAARD3 ;AISC/GRR-VOUCHER AUDIT DELETE REJECTS ENTERED IN ERROR ;08JAN86
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
STUFF S (FBAAMT,FBAAAP)=+$P(^FBAAC(J,1,K,1,L,1,M,0),"^",3) D POST G PROB^FBAARD1:$D(FBERR)
 S $P(^FBAAC(J,1,K,1,L,1,M,0),"^",8)=$P(^FBAAC(J,1,K,1,L,1,M,"FBREJ"),"^",3),FBAARA=FBAARA+FBAAAP,FBIN=$P(^FBAAC(J,1,K,1,L,1,M,0),"^",16)
 S ^FBAAC("AC",B,J,K,L,M)="",^FBAAC("AJ",B,FBIN,J,K,L,M)="" K ^FBAAC("AH",B,J,K,L,M) S $P(FZ,"^",9)=($P(FZ,"^",9)+FBAAAP),$P(FZ,"^",11)=($P(FZ,"^",11)+1)
 K ^FBAAC(J,1,K,1,L,1,M,"FBREJ")
 I '$D(^FBAAC("AH",B)) S $P(FZ,"^",17)=""
 Q
 ;
POST ;entry point to put dollars back into an authorization on the 1358
 ;if rejected in error
 ;first will locate interface ID from PRC(424,"E",IEN of 161.7)
 ;if interface not exist use old call to POST^FBAASCB
 ;I '$$VER^FBAAUTL1() D POST^FBAASCB Q
 I '$O(^PRC(424,"E",+$G(FBN),0)) D POST^FBAASCB Q
 D ADD^FBAAUTL1 Q
 ;
INPOST ;call to put money back into 1358 for inpatient invoices
 ;call will handle both v4 and v3.6 of ifcap
 ;I $G(FBCNH),'$$VER^FBAAUTL1() D POST^FBAASCB Q
 I FBII78["FB583(" D POST Q
 ;find 7078 entry and build variables needed for call
 I '$D(^FB7078(+FBII78,0)) W !,"No 7078 on file for invoice ",J,".  Could not determine 1358.",! S FBERR=1 Q
 S FBI78=$P(^FB7078(+FBII78,0),"^"),DFN=+$P(^(0),"^",3),FBI78=$P(FZ,"^",8)_"-"_$P(FBI78,".")_"-"_$P(FBI78,".",2) D
 .I $D(FBCNH),'$D(^PRC(424,"E",DFN_";"_+FBII78_";"_FBAAON_";"_FBMM)) D POST Q
 .D INPOST^FBAASCB0:$$INTER^FBAASCB0()
 Q
