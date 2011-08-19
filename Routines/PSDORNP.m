PSDORNP ;BIR/LTL-Nurse CS Order Entry Print Priority Order (cont'd) ; 17 Feb 95
 ;;3.0; CONTROLLED SUBSTANCES ;**20**;13 Feb 97
 ;
 ; Reference to DD(58.8 supported by DBIA # 10154
 ; Reference to $$FMTE^XLFDT( supported by DBIA # 10103
 ; Reference to VA(200 supported by DBIA # 10060
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ; 
 N Y,ZTRTN,ZTDTH,ZTSK,ZTDESC,ZTIO,ZTSAVE
 S ZTRTN="PRINT^PSDORNP",ZTDESC="Print a Controlled Subs order"
 S ZTDTH=$H,Y=$P($G(^PSD(58.8,+PSDS,2)),U,11),C=$P(^DD(58.8,29,0),U,2)
 D Y^DIQ I Y']"" W !!,"Pharmacy has not set up a priority order printer, you'll need to call." Q
 S ZTIO=Y,ZTSAVE("PSD*")="",ZTSAVE("REQD")="",ZTSAVE("NAOU*")=""
 W ?40,"Printing on ",Y,"..." D ^%ZTLOAD,HOME^%ZIS Q
PRINT W:$Y&(IOF]"") @IOF W "* PRIORITY CONT. SUBS. ORDER *"
 W !!,"Date/Time Needed: ",$$FMTE^XLFDT($G(PSDT(9)),2)
 W !,"Location",?14,": ",NAOUN
 W !,"Drug",?14,": ",!,PSDRN,!,"Quantity",?14,": ",PSDQTY
 W:'$P($G(^PSD(58.8,+PSDS,1,PSDR,0)),U,4) "  ZERO IN VAULT"
 W !,"Requested by",?14,": ",$P($G(^VA(200,PSDUZ,0)),"^")
 W !,"Worksheet #",?14,": ",PSDREC
 W !,"Comments:"
 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,0)) K ^UTILITY($J,"W") F TEXT=0:0 S TEXT=$O(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,TEXT)) Q:'TEXT  D
 .S X=$G(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,TEXT,0)),DIWL=5,DIWR=75,DIWF="W" D ^DIWP
 I  D ^DIWW
 W:$Y&(IOF]"") @IOF
 S DIE="^PSD(58.85,",DA=PSDREC,DR="13////"_1 D ^DIE K DIE,DA,DR
 S ZTREQ="@" Q
