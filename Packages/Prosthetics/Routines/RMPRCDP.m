RMPRCDP ;PHX/DWL,HNB-PURGE FILE 664 ;8/29/1994
 ;;3.0;PROSTHETICS;**3,173**;Feb 09, 1996;Build 29
 ;
 ;RMPR*3.0*173 Added purge for file 664 to remove aged orders that are 
 ;             no longer defined in IFCAP file 442.  The purge will be
 ;             controlled to ONLY allow orders for a fiscal year greater
 ;             than 6 years ago to be entered and should be run AFTER
 ;             the IFCAP annual purging process and use the same fiscal
 ;             year that purge process used.
 ;
EN1 ;Purge 664, Canceled Transactions
 D DIV4^RMPRSIT Q:$D(X)
EN4 K IOP,ZTIO,%ZIS S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP END
 ;I IOST["C-" W !,$C(7),"YOU MAY NOT SELECT YOUR TERMINAL" G EN4
 I $D(IO("Q")) D
 .S ZTRTN="EN11^RMPRCDP"
 .S ZTDESC="CANCEL TRANSACTIONS IN FILE 664 FOR A STATION/DIVISION"
 .F RD="I","RMPRIEN","RMPRDT","RMPRSITE","RMPR(" S ZTSAVE(RD)=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"<REQUEST QUEUED!>",1:"<REQUEST NOT QUEUED!>") G END
EN11 S (I,RMPRIEN)=0,RMPRDT=$P(^RMPR(669.9,RMPRSITE,0),U,10) G:RMPRDT'>89 END
 S X1=DT,X2=-RMPRDT D C^%DTC S RMPRDT=X D NOW^%DTC S Y=% X ^DD("DD")
 U IO W !!,"Purge Canceled Prosthetic Purchasing Transactions For: ",!,$P(^RMPR(669.9,RMPRSITE,0),U,1)," On ",Y,!!
 F  S RMPRIEN=$O(^RMPR(664,RMPRIEN)) Q:RMPRIEN'>0  D
 .;quit if it is a purchase card transaction, non get purged
 .Q:$D(^RMPR(664,RMPRIEN,4))
 .I ($P(^RMPR(664,RMPRIEN,0),U,5))&($P(^(0),U,5)<RMPRDT&($P(^(0),U,14)=RMPR("STA"))) D
 ..S DA=RMPRIEN,DIC="^RMPR(664," D EN^DIQ
 ..S DA=RMPRIEN,DIK=DIC D ^DIK W "Deleted...",! S RDEL=1
 I '$D(RDEL) S $P(L,"-",IOM)="" W !,L,!,?5,"NO CANCELED PURCHASING TRANSACTIONS DELETED"
 G END
EN ;PURGE 664 FILE OF ENTRIES CLOSED OUT FOR A STATION/DIVISION
 D DIV4^RMPRSIT Q:$D(X)
EN5 K IOP,%ZIS,ZTIO S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP END
 ;I IOST["C-" W !,$C(7),"YOU MAY NOT SELECT YOUR OWN TERMINAL" G EN5
 I $D(IO("Q")) S ZTRTN="EN2^RMPRCDP",ZTDESC="PURGE 664 OF CLOSED OUT ENTRIES" F RD="I","RMPRIEN","RMPRDT","RMPRSITE","RMPR(" S ZTSAVE(RD)=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"<REQUEST QUEUED!>",1:"<REQUEST NOT QUEUED>") G END
EN2 S (I,RMPRIEN)=0,RMPRDT=$P(^RMPR(669.9,RMPRSITE,0),U,9) G:RMPRDT'>89 END
 S X1=DT,X2=-RMPRDT D C^%DTC S RMPRDT=X D NOW^%DTC S Y=% X ^DD("DD")
 U IO W !!,"Purge Closed Prosthetic Purchasing Transactions For",!,$P(^RMPR(669.9,RMPRSITE,0),U,1)," On ",Y,!!
 F  S RMPRIEN=$O(^RMPR(664,RMPRIEN)) Q:RMPRIEN'>0  D
 .;quit if it is a purchase card transaction, non get purged
 .Q:$D(^RMPR(664,RMPRIEN,4))
 .I ($P(^RMPR(664,RMPRIEN,0),U,8))&($P(^(0),U,8)<RMPRDT&($P(^(0),U,14)=RMPR("STA"))) D
 ..S DA=RMPRIEN,DIC="^RMPR(664," D EN^DIQ
 ..S DA=RMPRIEN,DIK=DIC D ^DIK W "Deleted",! S RDEL=1
 I '$D(RDEL) S $P(L,"-",IOM)="" W !,L,!,?5,"NO CLOSED PURCHASING TRANSACTIONS DELETED",!
END K I,RD,RMPRIEN,RMPRDT,RMPR,DIR,DIK,DA,DIC,X1,X2,L,RDEL,ZTSK D ^%ZISC
 Q
EN3 ;Purge Non-Obligated Transactions
 ;IF C.P. and Reference Number missing, transaction not obligated to IFCAP
 D DIV4^RMPRSIT Q:$D(X)
 K IOP,%ZIS,ZTIO S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP END
 I $D(IO("Q")) S ZTRTN="EN3A^RMPRCDP",ZTDESC="Purge Non-Obligated Transactions For Station # "_RMPR("STA"),ZTSAVE("RMPR*")=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"<REQUEST QUEUED!>",1:"<REQUEST NOT QUEUED>")
 G END
EN3A ;
 S RMPRA=0 F  S RMPRA=$O(^RMPR(664,RMPRA)) Q:RMPRA'>0  D
 .;quit if this is a purchase card transaction, non should be purged
 .Q:$D(^RMPR(664,RMPRA,4))
 .I '$P(^RMPR(664,RMPRA,0),U,6)&('$P(^(0),U,7))&($P(^(0),U,14)=RMPR("STA")) D
 ..S DA=RMPRA,DIC="^RMPR(664," D EN^DIQ
 ..S DA=RMPRA,DIK=DIC D ^DIK W "Deleted...",! S RDEL=1
 I $G(RDEL)'=1 W !!,"No Non-Obligated Transactions deleted."
 K RMPRA,DIK,DA,I,DIC D ^%ZISC
 Q
 ;
 ;RMPR*3.0*173 File 664 Aged Order Purge
EN20 ;Purge 664, Aged order transactions based on file 442 purge history for closed/cancelled orders
 S DIR("?")="Enter 'YES' or 'Y' to continue processing."
 S DIR(0)="Y",DIR("A")="Purge MUST follow the IFCAP annual purge process, OK to continue? ",DIR("B")="NO" D ^DIR I $D(DIRUT)!($D(DTOUT))!(+Y'=1) Q
 D DIV4^RMPRSIT G END1:$D(X)
EN21 ;Select Fiscal Year
 D:'$D(DT) DT^DICRW
 S RMPRFYT=1700+$E(DT,1,3)+$E(DT,4),RMPRFY=RMPRFYT
 S DIR("?")="Fiscal year.  Should be same year (or prior) as used in IFCAP annual purge."
 S DIR("A")="Enter FISCAL YEAR (YYYY) to purge",DIR(0)="N^1990:2100",DIR("B")=RMPRFYT-8 D ^DIR K DIR G END1:$D(DIRUT) S RMPRFY=Y
 I RMPRFY>(RMPRFYT-8) W "  You CANNOT purge Prosthetics order data for a fiscal year LESS than 8 years ago!!" G EN21
 S DIR("?")="Enter 'YES' or 'Y' to continue processing."
 S DIR(0)="Y",DIR("A")="Purging closed PROS orders prior to FY end 09/30/"_RMPRFY_", OK? ",DIR("B")="NO" D ^DIR G:$D(DIRUT)!($D(DTOUT)) EN21 I +Y'=1 Q
 S RMPRFYDT=(RMPRFY-1700)_1001
EN25 K IOP,ZTIO,%ZIS S %ZIS="MQ",%ZIS("B")="" D ^%ZIS G:POP END1
 ;I IOST["C-" W !,$C(7),"YOU MAY NOT SELECT YOUR TERMINAL" G EN4
 I $D(IO("Q")) D
 .S ZTRTN="EN26^RMPRCDP"
 .S ZTDESC="PURGE ALL ORDERS IN FILE 664 FOR A STATION/DIVISION THAT ARE SAME/PRIOR TO CURRENT IFCAP PURGE YEAR"
 .S ZTSAVE("RMPR*")=""
 I $D(IO("Q")) K IO("Q") D ^%ZTLOAD W !,$S($D(ZTSK):"<REQUEST QUEUED!>",1:"<REQUEST NOT QUEUED!>") G END1
EN26 S (I,RMPRIEN,RMPRTOTD)=0
 D NOW^%DTC S Y=% X ^DD("DD")
 U IO W !!,"Purge Prosthetic Purchasing Transactions For: ",RMPRFY,"      On ",Y,!!
 F  S RMPRIEN=$O(^RMPR(664,RMPRIEN)) Q:RMPRIEN'>0  D
 . S RMPRDEL=0,RMPRODT=$P(^RMPR(664,RMPRIEN,0),U),RMPROSIT=$P(^RMPR(664,RMPRIEN,0),U,14),RMPRORD=$P($G(^RMPR(664,RMPRIEN,4)),U,5),RMPROIEN=$P($G(^RMPR(664,RMPRIEN,4)),U,6)
 . I RMPRODT<RMPRFYDT,(RMPROSIT=RMPR("STA")!(RMPROSIT="")) D
 ..I RMPRORD=""!(RMPROIEN="") S RMPRDEL=1
 .. I RMPRDEL=0,'$D(^PRC(442,"B",RMPROSIT_"-"_RMPRORD,RMPROIEN)) S RMPRDEL=1
 .. I RMPRDEL=1 D
 ... S DA=RMPRIEN,DIC="^RMPR(664," D EN^DIQ
 ... S DIK=DIC D ^DIK K DIK,DIC
 ... W !,"Deleted...",! S RMPRTOTD=RMPRTOTD+1
 S $P(RMPRL,"-",IOM)="" W !!,RMPRL,!!,?5,"TOTAL PROSTHETICS PURCHASING TRANSACTIONS DELETED: ",RMPRTOTD,!
END1 K I,RD,RMPRIEN,RMPRDT,RMPR,DIR,DIK,DA,DIC,X,X1,X2,RMPRL,RMPRTOTD,ZTSK,RMPRFYT,RMPRDEL,RMPRFY,RMPRFYDT,RMPRODT,RMPROSIT,RMPRORD,RMPROIEN,DIRUT,DTOUT D ^%ZISC
 Q
