PRCABARP ;EDE/YMG - BILLING ADDRESS DISCREPANCY REPORT; 04/10/2022
 ;;4.5;Accounts Receivable;**403**;Mar 20, 1995;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to BADADR^DGUTL3 in ICR #7321
 ; Reference to FILE #5 in ICR #10056
 ;
 Q
 ;
EN ; entry point
 N FILTER,POP,ZTDESC,ZTRTN,ZTSAVE,ZTSK,%ZIS
 K ^TMP("PRCABARP",$J)
 W !!,"Billing Address Discrepancy Report",!
 ; filter by?
 S FILTER=$$ASKFLTR() I FILTER=-1 Q
 D EXCMSG^RCTCSJR    ; Display Excel display message
 ; ask for device
 K IOP,IO("Q")
 S %ZIS="MQ",%ZIS("B")="",POP=0 D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q  ; queued report
 .S ZTDESC="Billing Address Discrepancy Report",ZTRTN="COMPILE^PRCABARP"
 .S ZTSAVE("FILTER")="",ZTSAVE("ZTREQ")="@"
 .D ^%ZTLOAD,HOME^%ZIS
 .I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! D PAUSE^RCRPRPU
 .Q
 D COMPILE
 ;
 Q
 ;
ASKFLTR() ; display "filter by debtor name" prompt
 ;
 ; returns "1 ^ start name ^ end name" for filtering by debtor name
 ;            (2nd piece = null to start at the 1st available name; 3rd piece = null to end with the last available name),
 ;         0 for no filter,
 ;         -1 for user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 N ENM,SNM
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Filter By Debtor Name (Y/N)"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1  ; user exit / timeout
 I Y=0 Q 0  ; response is "No"
 S DIR(0)="F^1:",DIR("B")="FIRST"
 S DIR("A")="Start with name"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1  ; user exit / timeout
 S SNM=$S(Y="FIRST":"",1:Y)
 ;
 S DIR(0)="F^1:^K:SNM]X X",DIR("B")="LAST"
 S DIR("A")="Go to name"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1  ; user exit / timeout
 S ENM=$S(Y="LAST":"",1:Y)
 Q "1"_U_SNM_U_ENM
 ;
COMPILE ; compile report
 N BADADDR,CNT,CADDR,DADDR,DBTR,DCSD,DFN,DIEN,ENM,N1,PADDR,PATID,SITE,SNM,TADDR,TMP,UNKADDR,VADM,VAPA,Z
 ;
 S CNT=0,(SNM,ENM)=""
 I $P(FILTER,U) S SNM=$P(FILTER,U,2),ENM=$P(FILTER,U,3)
 S SITE=+$$SITE^VASITE()
 S DBTR=0 F  S DBTR=$O(^RCD(340,"B",DBTR)) Q:DBTR=""  D
 .I $P(DBTR,";",2)'="DPT(" Q  ; only include patients
 .S DIEN="" F  S DIEN=$O(^RCD(340,"B",DBTR,DIEN)) Q:'DIEN  D
 ..S N1=$G(^RCD(340,DIEN,1)) I $TR($P(N1,U,1,6),U,"")="" Q  ; quit if no address in file 340
 ..S DFN=$P(DBTR,";"),DCSD=0
 ..D DEM^VADPT
 ..; make sure that name is wihtin filtering range
 ..I SNM'="",VADM(1)'=SNM,VADM(1)']SNM Q
 ..I ENM'="",VADM(1)'=ENM,ENM']VADM(1) Q
 ..S PATID=$E(VADM(1))_$E($P(VADM(2),U),6,10)
 ..S DCSD=+VADM(6)>0  ; 1 if patient is deceased, 0 otherwise
 ..S UNKADDR=$P(N1,U,9)  ; unknown address: 1 = yes, 0 = no
 ..; get debtor address
 ..S DADDR=$P(N1,U) I DADDR'="" D  ; addr line 1
 ...F Z=2:1:3 S TMP=$P(N1,U,Z) S:TMP'="" DADDR=DADDR_" "_TMP  ; addr lines 2,3
 ...S DADDR=DADDR_", "_$P(N1,U,4)_", "_$$GET1^DIQ(5,$P(N1,U,5)_",",1)_" "_$P(N1,U,6)  ; city, state, zip
 ...Q
 ..; get patient addresses
 ..D ADD^VADPT
 ..; get confidential address, if exists
 ..S CADDR="" I VAPA(12),$P($G(VAPA(22,3)),U,3)="Y" S CADDR=VAPA(13) D:CADDR'=""  ; addr line 1
 ...F Z=14:1:15 S:VAPA(Z)'="" CADDR=CADDR_" "_VAPA(Z)  ; addr lines 2,3
 ...S CADDR=CADDR_","_VAPA(16)_", "_$$GET1^DIQ(5,$P(VAPA(17),U)_",",1)_" "_$P(VAPA(18),U)  ; city, state, zip
 ...Q
 ..; get temporary / permanent address
 ..S TMP=VAPA(1) D:TMP'=""  ; adr line 1
 ...F Z=2:1:3 S:VAPA(Z)'="" TMP=TMP_" "_VAPA(Z)  ; addr lines 2,3
 ...S TMP=TMP_","_VAPA(4)_", "_$$GET1^DIQ(5,$P(VAPA(5),U)_",",1)_" "_$P(VAPA(6),U)  ; city, state, zip
 ...; check if this is the permanent address
 ...I '+VAPA(9) S TADDR="",PADDR=TMP Q
 ...; it was temporary address, if we got here - need to get permanent address separately.
 ...S TADDR=TMP K VAPA S VAPA("P")="" D ADD^VADPT
 ...S PADDR=VAPA(1) D:PADDR'=""  ; adr line 1
 ....F Z=2:1:3 S:VAPA(Z)'="" PADDR=PADDR_" "_VAPA(Z)  ; addr lines 2,3
 ....S PADDR=PADDR_","_VAPA(4)_", "_$$GET1^DIQ(5,$P(VAPA(5),U)_",",1)_" "_$P(VAPA(6),U)  ; city, state, zip
 ....Q
 ...Q
 ..S TMP=$$BADADR^DGUTL3(DFN),BADADDR=$S(TMP=1:"UNDELIVERABLE",TMP=2:"HOMELESS",TMP=3:"OTHER",TMP=4:"ADDRESS NOT FOUND",1:"N/A")
 ..S BADADDR=$$GET1^DIQ(2,DFN_",",.121,"E")  ; bad address indicator (external)
 ..S CNT=CNT+1
 ..; add a new entry to ^TMP global
 ..S ^TMP("PRCABARP",$J,CNT)=SITE_U_VADM(1)_U_PATID_U_DCSD_U_BADADDR_U_UNKADDR  ; station # ^ debtor name ^ patient id ^ deceased? (1/0) ^ bad address (2/.121) ^ unknown address (340/1.09)
 ..S ^TMP("PRCABARP",$J,CNT,"CADDR")=CADDR     ; Confidential address
 ..S ^TMP("PRCABARP",$J,CNT,"DADDR")=DADDR     ; AR address
 ..S ^TMP("PRCABARP",$J,CNT,"TADDR")=TADDR     ; Temporary address
 ..S ^TMP("PRCABARP",$J,CNT,"PADDR")=PADDR     ; Permanent address
 ..S ^TMP("PRCABARP",$J,"IDX",VADM(1),CNT)=""  ; index on debtor name
 ..K VADM,VAPA
 ..Q
 .Q
 D PRINT
 K ^TMP("PRCABARP",$J)
 Q
 ;
PRINT ; print report
 N BADADDR,CADDR,CNT,DATA,DADDR,EXTDT,NAME,PADDR,TADDR
 ;
 U IO
 S EXTDT=$$FMTE^XLFDT(DT)
 W !,"Billing Address Discrepancy Report",U,EXTDT,U,$$FLTRSTR(FILTER)
 W !,"Facility^Debtor^ID No.^Deceased?^Confidential Address^AR Debtor Address^Temporary Address^Permanent Address^Unknown AR Address?^Bad Address Indicator"
 I '$D(^TMP("PRCABARP",$J)) W !!,"No records found." Q
 S NAME="" F  S NAME=$O(^TMP("PRCABARP",$J,"IDX",NAME)) Q:NAME=""  D
 .S CNT=0 F  S CNT=$O(^TMP("PRCABARP",$J,"IDX",NAME,CNT)) Q:'CNT  D
 ..S DATA=^TMP("PRCABARP",$J,CNT)
 ..S CADDR=$TR(^TMP("PRCABARP",$J,CNT,"CADDR"),U," ")
 ..S DADDR=$TR(^TMP("PRCABARP",$J,CNT,"DADDR"),U," ")
 ..S TADDR=$TR(^TMP("PRCABARP",$J,CNT,"TADDR"),U," ")
 ..S PADDR=$TR(^TMP("PRCABARP",$J,CNT,"PADDR"),U," ")
 ..S BADADDR=$P(DATA,U,5)
 ..W !,$P(DATA,U),U,NAME,U,$P(DATA,U,3),U,$S($P(DATA,U,4):"Y",1:"N"),U,CADDR,U,DADDR,U,TADDR,U,PADDR,U,$S($P(DATA,U,6):"Y",1:"N"),U,BADADDR
 ..Q
 .Q
 Q
 ;
FLTRSTR(FILTER) ; returns "Filtered by" string to print
 Q "Filtered by: "_$S($P(FILTER,U)=1:"Debtor name (from "_$P(FILTER,U,2)_" to "_$P(FILTER,U,3)_")",1:"No filter")
