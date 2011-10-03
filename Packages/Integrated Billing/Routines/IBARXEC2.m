IBARXEC2 ;ALB/AAS - SEND CONVERSION COMPLETION BULLETIN ; 13-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N IBX,X
% S IBX=$G(^IBE(350.9,1,3)) Q:'$P(IBX,"^",14)
 ;
 S XMSUB="Medication Copayment Exemption Conversion Complete"
 S IBT(1)="The Medication Copayment Exemption Conversion has Completed at "_$P($$SITE^VASITE,"^",2,3)
 I $D(^%ZOSF("UCI")) X ^("UCI") S IBT(1)=IBT(1)_" ("_Y_")"
 S IBT(2)=""
 S Y=$P(IBX,"^",13) D D^DIQ
 S IBT(3)="Conversion started on:    "_Y
 S Y=$P(IBX,"^",14) D D^DIQ
 S IBT(4)="Conversion finished on:   "_Y
 S IBT(5)="Conversion was started "_$P(IBX,"^",3)_" time"_$S($P(IBX,"^",3)>1:"s.",1:".")
 D ELAP^IBARXEC1
 S IBT(6)=" "
 S IBT(7)=Y
 S IBT(8)=" "
 S X3=10
 S X=$P(IBX,"^",5),X2=0 D COMMA^%DTC
 S IBT(9)="   1.              Total Patients Checked  ==  "_X
 S X=$P(IBX,"^",6),X2=0 D COMMA^%DTC
 S IBT(10)="                          Exempt Patients  ==  "_X
 S X=$P(IBX,"^",7),X2=0 D COMMA^%DTC
 S IBT(11)="                      Non-Exempt Patients  ==  "_X
 S IBT(12)=" "
 S X=$P(IBX,"^",16),X2=0 D COMMA^%DTC
 S IBT(13)="   2.  Total Number of Rx Charges Checked  ==  "_X
 S X=$P(IBX,"^",9),X2="0$" D COMMA^%DTC
 S IBT(14)="                    Dollar Amount Checked  ==  "_X
 S X=$P(IBX,"^",8),X2=0 D COMMA^%DTC
 S IBT(15)="         No. of Exempt Rx Charges Checked  ==  "_X
 S X=$P(IBX,"^",10),X2="0$" D COMMA^%DTC
 S IBT(16)="                     Exempt Dollar Amount  ==  "_X
 S X=$P(IBX,"^",15),X2=0 D COMMA^%DTC
 S IBT(17)="     No. of Non-Exempt Rx Charges Checked  ==  "_X
 S X=$P(IBX,"^",11),X2="0$" D COMMA^%DTC
 S IBT(18)="                 Non-Exempt Dollar Amount  ==  "_X
 S IBT(19)=" "
 S X=$P(IBX,"^",17),X2=0 D COMMA^%DTC
 S IBT(20)="   3.  Total Rx Charges Actually Canceled  ==  "_X
 S X=$P(IBX,"^",12),X2="0$" D COMMA^%DTC
 S IBT(21)="                 Amount Actually Canceled  ==  "_X
 ;
SEND S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 K XMY S XMN=0
 S X="G.IB COPAY CONVERSION@ISC-ALBANY.VA.GOV" D INST^XMA21
 S XMY(DUZ)=""
 S IBGRP=$P(^IBE(350.9,1,0),"^",9)
 F IBI=0:0 S IBI=$O(^XMB(3.8,+IBGRP,1,"B",IBI)) Q:'IBI  S XMY(IBI)=""
 D ^XMD
 K X,Y,IBI,IBT,IBGRP,XMDUZ,XMTEXT,XMY
 Q
