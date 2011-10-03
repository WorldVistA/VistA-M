PSDORM ;BIR/LTL-Send MM about one-time request, PSDORNO (cont'd) ; 20 Jan 95
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 N PSD D KILL^XM
 S XMSUB="One Time Request",XMDUZ="NAOU Monitor" D XMZ^XMA2
 I XMZ<1 D KILL^XM Q
 S XMY(DUZ)="",PSD=0
 F  S PSD=$O(^XUSEC("PSDMGR",PSD)) Q:'PSD  S XMY(PSD)=""
 S PSD(1)=$P($P($G(^VA(200,DUZ,0)),U),",",2)_" "_$P($P($G(^(0)),U),",")
 S PSD(1)=PSD(1)_" has placed a one time request.",(PSD(2),PSD(4))=""
 S PSD(3)="The drug ordered was "_$G(PSDRN)_"."
 S PSD(5)="This drug is INACTIVE on "_NAOUN_"."
 S XMTEXT="PSD(" D ^XMD,KILL^XM Q
