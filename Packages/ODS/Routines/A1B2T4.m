A1B2T4 ;ALB/EG - XM UTILITY ;FEB 7 1991
 ;;Version 1.55 (local for MAS v5 sites);;
 ;;V1.0
 ;XMTEXT array must have closed form, i.e. XMTEXT="AX" or "AX(1)"
 ;"AX(2," is not allowed.  Local or global are allowed.
 ;XMDUZ must be valid DUZ or POSTMASTER.  Returned variables
 ;Y > 0:Message filed, Y < 0:Message not filed
 ;XMZ defined:Message delivered, XMZ not defined:No delivery.
 ;A1B2XMY array contains network recipients which must be resolved.
 ;
EN1 Q:(XMSUB="")!(XMDUZ="")!(XMTEXT="")!('$D(XMY))
 S XMN=0,AJ="" F I=0:0 S AJ=$O(A1B2XMY(AJ)) Q:AJ=""  S X=AJ D WHO^XMA21
 K XMZ S U="^",DIC="^XMB(3.9,",DIC(0)="L",DLAYGO=3.9,X=XMSUB D FILE^DICN K DIC G:Y<0 END
EN2 S DA=$P(Y,U,1),K=0 L ^XMB(3.9,DA):1 G:'$T EN2 F I=1:1 S K=$O(@XMTEXT@(K)) Q:K=""  S ^XMB(3.9,DA,2,I,0)=$S($D(@XMTEXT@(K))=10:@XMTEXT@(K,0),1:@XMTEXT@(K))
 S ^XMB(3.9,DA,2,0)="^3.91^"_I_U_I
 D NOW^%DTC S DIE="^XMB(3.9,",DR="1////"_XMDUZ_";1.4////"_% D ^DIE K DIE,DR,DLAYGO
 S XMCHAN=1,XMDUN=$S($D(^DIC(3,XMDUZ,0)):$P(^(0),U,1),1:"POSTMASTER"),XMZ=DA K XMTEXT D ENT1^XMD
 L  D END
 Q
END ;
 K %,A1B2XMY,DA,I,K,X,XMCHAN,XMDUN,XMDUZ,XMN,XMSUB,XMTEXT,XMY
 Q
