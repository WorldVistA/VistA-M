PRCFACS2 ;WISC/PL-BULLETIN FOR CHANGED DELIVERY DATE FOR P.O. ;1/4/94
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 K ^UTILITY($J),MSG S DIWL=0,DIWR=79,DIWF=""
 S PRCHDT=$E(PRCHDT,4,5)_"/"_$E(PRCHDT,6,7)_"/"_$E(PRCHDT,2,3)
 S PRCHDTT=$E(PRCHDTT,4,5)_"/"_$E(PRCHDTT,6,7)_"/"_$E(PRCHDTT,2,3)
 S PRCHPOEX=$P(^PRC(442,PRCHPO,0),U,1)
 S PRCHPOTY=$S($P(^PRC(442,PRCHPO,0),U,2)=8:"Requisition # ",1:"P.O # ")
 S PRCFCP=+($P(^PRC(442,PRCHPO,0),U,3))
 S PRCSRV=$P($G(^PRC(420,PRC("SITE"),1,PRCFCP,0)),U,10)
 I PRCSRV]"" S PRCSRV=$P($G(^DIC(49,PRCSRV,0)),U,1)
 S MSG(1,0)="The delivery date for "_PRCHPOTY_PRCHPOEX
 S MSG(2,0)="has been changed from "_PRCHDT_" to "_PRCHDTT
 I PRCFCP]"" S MSG(3,0)="by the above Purchasing Agent for control point "_PRCFCP_$S(PRCSRV="":".",1:"")
 I PRCSRV]"" S MSG(4,0)="for "_PRCSRV_" Service."
 S MSG(5,0)="Please note this change."
 S XMSUB="Notification for delivery date change on a P.O."
 D MSG S X="Delivery date changed ! Bulletin transmitted.*" D MSG^PRCFQ
EXIT ;
 K DIWF,DIWL,DIWR,X,M,N,PRCHPOEX,PRCHPOTY,PRCHDT,PRCHDTT,PRCFCP,PRCFCPN,PRCFCPM,PRCSRV,XMDUZ,XMSUB,XMTEXT,XMY
 Q
 ;
MSG ;SET VARIABLES AND CALL XMD
 ; sent to members of mail group "FISCAL NOTIFICATION"
 S N=$O(^XMB(3.8,"B","FISCAL NOTIFICATION","")) Q:N=""
 S M="" F  S M=$O(^XMB(3.8,N,1,"B",M)) Q:M=""  S XMY(+M)=""
 Q:'$O(XMY(""))  S XMDUZ=DUZ,XMTEXT="MSG("
 D WAIT^PRCFYN,^XMD
 Q
