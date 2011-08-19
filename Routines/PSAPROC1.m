PSAPROC1 ;BIR/JMB-Process Uploaded Prime Vendor Invoice Data - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**12,21,50,60,70**; 10/24/97;Build 12
 ;
 ;This routine processes uploaded invoices.
 ;
 ;;References to ^PSDRUG( are covered by IA #2095
 ;
CHK ;Check for invoices with a status of "OK" (uploaded & error free)
 ;& status of "" (uploaded & errors). 
 K PSA,PSAOK S (PSACNTOK,PSACNTER,PSACTRL)=0
 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:PSACTRL=""  D
 .;DAVE B (PSA*3*12 13MAY99) Restrict to appropriate division
 .I $G(PSASORT)'=0,$G(PSASORT)'="",$D(^XTMP("PSAPV",PSACTRL,"ST")),$P(^XTMP("PSAPV",PSACTRL,"ST"),"^",1)'=PSASORT Q
 .Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))  S PSAIN=^XTMP("PSAPV",PSACTRL,"IN")
 .I $P(PSAIN,"^",8)="OK"!($P(PSAIN,"^",13)="SUP") D  Q
 ..I $P(PSAIN,"^",10)="ALL CS",$P(PSAIN,"^",12)'="" D OK Q
 ..I $P(PSAIN,"^",10)'="ALL CS",$P(PSAIN,"^",9)="CS",$P(PSAIN,"^",12)'="",$P(PSAIN,"^",7)'="" D OK Q
 ..I $P(PSAIN,"^",10)'="ALL CS",$P(PSAIN,"^",9)'="CS",$P(PSAIN,"^",7)'="" D OK Q
 ..S PSACNTER=PSACNTER+1,PSAERR(PSACNTER)=$P(PSAIN,"^",4)_"^"_$P(PSAIN,"^",2)_"^"_PSACTRL_"^"_$P(PSAIN,"^",7)
 .I $P(PSAIN,"^",8)="" S PSACNTER=PSACNTER+1,PSAERR(PSACNTER)=$P(PSAIN,"^",4)_"^"_$P(PSAIN,"^",2)_"^"_PSACTRL_"^"_$P(PSAIN,"^",7)
 S PSA=+$O(PSAOK(0))
 G:'PSA ^PSAPROC2
 ;
NOERROR ;Display list of invoices that can be processed by selecting
 ;invoice number.
 W @IOF,!?21,"<<< PROCESS ENTIRE INVOICE SCREEN >>>"
 W !!?2,"No errors have been detected on the following invoices. If there are no",!?2,"corrections, you can change the invoices' status to ""Processed"" by"
 W !?2,"selecting them from the list. If you do have corrections, press the return",!?2,"key then a second list will be displayed. You will be able to choose the",!?2,"invoices from that list and enter corrections."
 W !!?2,"Choose the invoices from the list you want to process.",!,PSADLN
 S (PSACNT,PSASTOP)=0,PSAMENU=""
 F  S PSAMENU=$O(PSAOK(PSAMENU)) Q:PSAMENU=""!(PSAOUT)  D  Q:PSASTOP
 .I $Y+4>IOSL D HEADER Q:PSASTOP
 .S PSAORD=$P(PSAOK(PSAMENU),"^"),PSAINV=$P(PSAOK(PSAMENU),"^",2),PSACTRL=$P(PSAOK(PSAMENU),"^",3),PSACNT=PSACNT+1
 .W !?2,PSAMENU_". ",?4,"Order#: "_PSAORD_"  Invoice#: "_PSAINV_"  Invoice Date: "_$$FMTE^XLFDT(+^XTMP("PSAPV",PSACTRL,"IN"))
 K PSASTOP W !,PSADLN
 S DIR(0)="LO^1:"_PSACNT,DIR("A")="Select invoices to process",DIR("?",1)="Enter the number to the left of the invoice",DIR("?")="data to be processed or a range of numbers." W !
 S DIR("??")="^D SEL^PSAPROC1" D ^DIR K DIR G:Y="" EDIT I $G(DIRUT) S PSAOUT=1 Q
 S PSASEL=Y
 D PLOCK^PSAPROC8(1)  ;; < PSA*3*70 RJS
 I '$G(PSASEL) G EXIT^PSAPROC
INVSEL F PSAPC=1:1 S PSA=+$P(PSASEL,",",PSAPC) Q:'PSA  D  Q:PSAOUT
 .I '$D(PSAOK(PSA)) Q  ;*50
 .S PSACTRL=$P(PSAOK(PSA),"^",3) Q:'$D(^XTMP("PSAPV",PSACTRL,"IN"))
 .S PSAIN=^XTMP("PSAPV",PSACTRL,"IN"),PSARECD=+$P(PSAIN,"^",6),PSALINES=0
 .D PROCESS
 Q:PSAOUT  G:'+$O(PSAOK(0)) PROC2
EDIT ;Edit error free invoices
 S PSA=0 F  S PSA=$O(PSAOK(PSA)) Q:'PSA  D
 .I $P($G(^XTMP("PSAPV",$P(PSAOK(PSA),"^",3),"IN")),"^",8)="OK"!($P($G(^("IN")),"^",13)="SUP") D
 ..S PSACNTER=PSACNTER+1,PSAERR(PSACNTER)=$P(^XTMP("PSAPV",$P(PSAOK(PSA),"^",3),"IN"),"^",4)_"^"_$P(^("IN"),"^",2)_"^"_$P(PSAOK(PSA),"^",3)_"^"_$P(^("IN"),"^",7)
 ;
PROC2 I +$O(PSAERR(0)) D ^PSAPROC2
 Q
 ;
HEADER S PSASS=21-$Y F PSAKK=1:1:PSASS W !
 S DIR(0)="E" D ^DIR K DIR I $G(DIRUT) S PSASTOP=1 Q
 W @IOF,!?21,"<<< PROCESS ENTIRE INVOICE SCREEN >>>",!!,PSADLN
 Q
 ;
PROCESS ;Get date recd & line item data
 I $P(PSAIN,"^",13)="SUP" D HDR,SUPPLY^PSAPROC6 Q
 D HDR,RECD^PSAPROC3 Q:PSAOUT  S (PSACS,PSALNCNT)=0,PSALINE=""
 F  S PSALINE=$O(^XTMP("PSAPV",PSACTRL,"IT",PSALINE)) Q:PSALINE=""  D  Q:PSAOUT
 .K PSAPHARM,PSAMV
 .S PSALNCNT=PSALNCNT+1,(PSADISP,PSADU,PSAHDR)=0
 .S PSADATA=^XTMP("PSAPV",PSACTRL,"IT",PSALINE),PSAIEN=$S(+$P(PSADATA,"^",15):+$P(PSADATA,"^",15),+$P(PSADATA,"^",6):+$P(PSADATA,"^",6),1:0),PSASUB=+$P(PSADATA,"^",7)
 .S:$P(PSADATA,"^",19)="CS" PSAMV=+$P(PSAIN,"^",12) S:$P(PSADATA,"^",19)'="CS" PSAPHARM=+$P(PSAIN,"^",7)
 .S PSALOC=+$S($P(PSADATA,"^",19)="CS":PSAMV,1:PSAPHARM)
 .I $P($G(^PSDRUG(PSAIEN,660)),"^",8)="" D:'PSAHDR HDR D:'PSADISP DISPLAY^PSAUTL1 D DU^PSAPROC8 Q:PSAOUT
 .I '+$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",7),$P($G(^PSDRUG(PSAIEN,660)),"^",8)'="" D:'PSAHDR HDR D:'PSADISP DISPLAY^PSAUTL1 D:PSASUB DUOU^PSAPROC8 D:'PSASUB DUOU^PSAPROC3 Q:PSAOUT
 .I +$P($G(^PSDRUG(PSAIEN,1,PSASUB,0)),"^",6)'=+$P(PSADATA,"^",3) D:'PSAHDR HDR D:'PSADISP DISPLAY^PSAUTL1 D PRICE^PSAPROC8 Q:PSAOUT
 .I +$P($G(^PSD(58.8,PSALOC,0)),"^",14) D  Q:PSAOUT
 ..I '+$P($G(^PSD(58.8,PSALOC,1,PSAIEN,0)),"^",3),'+$P(PSADATA,"^",27) D:'PSAHDR HDR D:'PSADISP DISPLAY^PSAUTL1 D STOCK^PSAPROC8 Q:PSAOUT
 ..I '+$P($G(^PSD(58.8,PSALOC,1,PSAIEN,0)),"^",5),'+$P(PSADATA,"^",21) D:'PSAHDR HDR D:'PSADISP DISPLAY^PSAUTL1 D REORDER^PSAPROC8
 .D SETLINE^PSAPROC3 S:$P(^XTMP("PSAPV",PSACTRL,"IT",PSALINE),"^",19)="CS" PSACS=PSACS+1
 S PSAOK=0
CS I PSACS D  Q:PSAOUT
 .S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",9)="CS"
 .I $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)="" S PSACS(PSACTRL)="" D MASTER^PSAPROC9 Q:PSAOUT  S:$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",12)'="" PSAOK=1 ;PSA*60
 .I PSACS=PSALNCNT S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",10)="ALL CS" Q
 .I PSACS'=PSALNCNT S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",10)=""
NCS I 'PSACS S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",9)="",$P(^("IN"),"^",10)="",$P(^("IN"),"^",12)="" D:$P(^("IN"),"^",7)="" GETLOC^PSAPROC9 Q:PSAOUT  S:$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",7)'="" PSAOK=1
 ;
 I PSALNCNT=PSALINES S $P(^XTMP("PSAPV",PSACTRL,"IN"),"^",8)="P" K PSAOK(PSA) W !!,"The invoice status has been changed to Processed!" D ^PSAPROC7 I 1 ;PSA*3*21 (1/3/01- file immediately);*50 
 E  W !!,"** The invoice has not been placed in a Processed status!"
 D END^PSAPROC
 Q
 ;
HDR ;Header for editing line items with missing data
 S PSAHDR=1
 W @IOF,!?21,"<<< PROCESS ENTIRE INVOICE SCREEN >>>",!,"Order#: "_$P(PSAIN,"^",4)_"  Invoice#: "_$P(PSAIN,"^",2)_"  Invoice Date: "_$$FMTE^XLFDT(+PSAIN),!,PSADLN
 Q
OK ;Sets okay array
 S PSACNTOK=PSACNTOK+1,PSAOK(PSACNTOK)=$P(^XTMP("PSAPV",PSACTRL,"IN"),"^",4)_"^"_$P(^("IN"),"^",2)_"^"_PSACTRL_"^"_$P(^("IN"),"^",7)
 Q
 ;
SEL ;Extended help to 'Select invoices'
 W !?5,"Enter the number to the left of the invoice data that you want to process."
 Q
