PSALOGON ;BIR/JMB-Logon Utility ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;; 10/24/97
 ;This routine displays the number of invoices the user needs to process
 ;or verify when the user signs on the system. The PSALOGON option needs
 ;to be placed on the system that the users signon to. Then PSA ORDERS
 ;ALERT option needs to be added as an item to the XU USER SIGN-ON
 ;option.
 ;
SIGNON Q:'$D(^XUSEC("PSA ORDERS",DUZ))
 S (PSACNTP,PSACTRL)=0
 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:'PSACTRL  D
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .S:$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",8)'="P" PSACNTP=PSACNTP+1
VERIFY S (PSACNTV,PSAORD)=0
 F  S PSAORD=$O(^PSD(58.811,"ASTAT","P",PSAORD)) Q:'PSAORD  D
 .S PSAINV=0 F  S PSAINV=$O(^PSD(58.811,"ASTAT","P",PSAORD,PSAINV)) Q:'PSAINV  D
 ..Q:+$P($G(^PSD(58.811,PSAORD,1,PSAINV,0)),"^",10)=DUZ
 ..I $P($G(^PSD(58.811,PSAORD,1,PSAINV,0)),"^",8)="S"!($P($G(^PSD(58.811,PSAORD,0)),"^",8)="A"),'$D(^XUSEC("PSJ RPHARM",DUZ)) Q
 ..S PSACNTV=PSACNTV+1
 G:'PSACNTP&('PSACNTV) EXIT
 I PSACNTP,PSACNTV S PSAMSG="!There "_$S(PSACNTP>1:"are "_PSACNTP_" invoices",1:"is 1 invoice")_" to process and "_$S(PSACNTV>1:PSACNTV_" invoices",1:"1 invoice")_" to verify." G SEND
 I PSACNTP S:PSACNTP>1 PSAMSG="!There are "_PSACNTP_" invoices to process." S:PSACNTP=1 PSAMSG="!There is 1 invoice to process." G SEND
 I PSACNTV S:PSACNTV>1 PSAMSG="!There are "_PSACNTV_" invoices to verify." S:PSACNTV=1 PSAMSG="!There is 1 invoice to verify." G SEND
 Q
 ;
SEND D SET^XUS1A(PSAMSG)
 ;
EXIT K PSACNTP,PSACNTV,PSACTRL,PSAINV,PSAMSG,PSAORD
 Q
