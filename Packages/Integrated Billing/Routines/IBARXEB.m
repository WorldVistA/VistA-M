IBARXEB ;ALB/AAS - RX COPAY EXEMPTION BULLETIN PROCESSOR ; 15-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
% N IBP,IBALERT
 Q:IBEVTP=""  ; no prior exemption
 Q:IBEVTP=IBEVTA
 S IBCODA=$$ACODE^IBARXEU0(IBEVTA),IBCODP=$$ACODE^IBARXEU0(IBEVTP)
 Q:$L(IBCODA)=2  ;  -went to automatic exemption
 ;
 K IBT
 I IBCODA=2010 D  ; -went to hardship
 .S IBALERT=1
 .S IBT(9)="Patient has been given a Hardship Exemption."
 .Q
 I IBCODP=2010 D  ; -went from hardship
 .S IBALERT=2
 .S IBT(9)="Patient's Hardship exemption has been removed."
 .Q
 I IBCODA=210,$L(IBCODP)=3,$P(IBEVTP,"^",4)=1 D  ; -went to no income data from exempt income
 .S IBALERT=3
 .S IBT(9)="Patient's exemption based on Income has expired."
 .Q
 ;
 Q:'$D(IBT)  ; no alert needed
 ;
 S IBP=$$PT^IBEFUNC(DFN)
 I $$ALERT^IBAUTL7 D SEND^IBAERR3 G BQ
 D BULL
BQ K IBEXERR Q
 ;
ALERT ; -- use kernel alerts
 ;
ALERTQ Q
 ;
BULL ; -- send bulletin
 ;
 S XMSUB="Medication Copayment Exemption Status Change"
 S IBT(1)="The following Patient's Medication Copayment Exemption Status has changed:"
 S IBT(2)="    Patient: "_$E($P(IBP,"^")_"               ",1,25)_"  PT. ID: "_$P(IBP,"^",2)
 S IBT(3)=""
 S IBT(4)=" Old Status: "_$E($$TEXT^IBARXEU0($P(IBEVTP,"^",4))_"    ",1,10)_" - "_$P($G(^IBE(354.2,+$P(IBEVTP,"^",5),0)),"^")_"  Dated "_$$DAT1^IBOUTL(+IBEVTP)
 S IBT(5)=" New Status: "_$E($$TEXT^IBARXEU0($P(IBEVTA,"^",4))_"    ",1,10)_" - "_$P($G(^IBE(354.2,+$P(IBEVTA,"^",5),0)),"^")_"  Dated "_$$DAT1^IBOUTL(+IBEVTA)
 S IBT(6)="" I $D(IBARCAN) S IBT(6)="Past charges were canceled in AR."
 S IBT(7)=""
 S IBT(8)=""
 S IBT(10)="    by: "_$P($G(^VA(200,+$P(IBEVTA,"^",7),0)),"^")_"/"_$S($P(IBEVTA,"^",6)=1:"(System)",1:"(Manual)")
 S Y=$P(IBEVTA,"^",8) D D^DIQ S IBT(11)="    on: "_$P(Y,"@")_" @ "_$P(Y,"@",2)
 S IBT(12)="Option: " I $D(XQY0) S IBT(12)=IBT(12)_$P($G(XQY0),"^",2)
 I $D(ZTQUEUED),$P($G(XQY0),"^",2)="" S IBT(12)=IBT(12)_"Queued Job - "_$G(ZTDESC)
 D SEND
BULLQ Q
 ;
SEND S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 K XMY S XMN=0
 ;S XMY(DUZ)="" ;don't send to user, is annoying to pharmacy.
 S IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,0)),"^",13),0)),"^")
 I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 ;S IBGRP=$P(^IBE(350.9,1,0),"^",9)
 ;F IBI=0:0 S IBI=$O(^XMB(3.8,+IBGRP,1,"B",IBI)) Q:'IBI  S XMY(IBI)=""
 D ^XMD
 K X,Y,IBI,IBT,IBGRP,XMDUZ,XMTEXT,XMY,XMSUB
 Q
