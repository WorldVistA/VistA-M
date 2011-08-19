ENEQRPI ;(WCIOFO)/DH,SAB-Equipment Inventory Listings ;10/12/1999
 ;;7.0;ENGINEERING;**19,21,39,50,60,63**;Aug 17, 1993
 ;
HDR W @IOF,!!,"INVENTORY LISTING",!,"Version ",^ENG("VERSION"),! Q
OUT K EN,ENSND Q
 ;
COM S DIC="^ENG(6914,",L=0
 S DIOEND="I IO=IO(0),$E(IOST,1,2)=""C-"" R !,""Press <RETURN> to continue..."",X:DTIME"
 I $D(^ENG(6910.2,"B","INVENTORY TEMPLATE")) S I=$O(^("INVENTORY TEMPLATE",0)) I I>0,$P(^ENG(6910.2,I,0),U,2)="L",$D(^DIPT("B","ENZEQ EQUIP. LIST")) S FLDS="[ENZEQ EQUIP. LIST]"
 E  S FLDS="[ENEQ EQUIP. LIST]"
 Q
 ;
DTYP ;List by EQUIPMENT CATEGORY
 D COM S BY="#6" D EN1^DIP G OUT
 ;
LOC ;List by LOCATION
 D COM S BY=$S($D(^DIBT("B","ENZ LOCATION")):"[ENZ LOCATION]",1:"[EN LOCATION]") D EN1^DIP G OUT
 ;
SRV ;List by SERVICE POINTER
 D COM S BY="#21" D EN1^DIP G OUT
 ;
SHOP ;List by RESPONSIBLE SHOP
 W !!,"Important note: SHOP NAME(S) MUST BE ENTERED IN RESPONSE TO THE 'START WITH'",!,"AND 'GO TO' PROMPTS. NUMBERS WILL NOT BE UNDERSTOOD BY THE SORT LOGIC."
 D COM S BY="#30,.01" D EN1^DIP G OUT
 ;
STUS ;List by USE STATUS
 D COM S BY="#19,20" D EN1^DIP G OUT
CMR ;Official CMR listing
 ; input- (optional) $D(ENNXEXP) true when Non-Expendable Expensed rpt
 S ENSND=$P($G(^DIC(6910,1,0)),U,2) ; default station #
 I ENSND="" W !!,*7,"The Eng Init Parameters File must contain a STATION NUMBER. Can't proceed." G OUT
 S DIC="^ENG(6914.1,",DIC(0)="AEQM",DIC("A")="Start WITH: "
 D ^DIC K DIC G:+Y'>0 OUT
 S EN("FR")=$P(^ENG(6914.1,+Y,0),U),EN("CMR",0)=+Y
CMR1 ; ask go to
 K EN("TO")
 R !,"Go TO: ",X:DTIME G:X=""!($E(X)=U) OUT
 I X=" " S EN("TO")=EN("FR") W "  "_EN("TO")
 I '$D(EN("TO")),$E(X)'="?" S:X]EN("FR")!(X=EN("FR")) EN("TO")=X
 I '$D(EN("TO")) W $C(7),!!,"Please enter a CMR that does not preceed "_EN("FR")_"." G CMR1
 ; if range then ask station number
 S EN("STA")="ALL" I EN("TO")]EN("FR") D  G:$D(DIRUT) OUT
 . S DIR(0)="Y"
 . S DIR("A")="Do you want to just print CMRs for a specific station"
 . S DIR("B")="NO"
 . S DIR("?",1)="Answer YES if you only want to print CMRs that have a"
 . S DIR("?",2)="specific value in their station number field. If the"
 . S DIR("?",3)="CMR's station number is blank, then it will be assumed"
 . S DIR("?",4)="to be "_ENSND_"."
 . S DIR("?",5)=" "
 . S DIR("?")="Enter either 'Y' or 'N'."
 . D ^DIR K DIR Q:'Y!$D(DIRUT)
 . S DIR(0)="6914.1,5",DA=EN("CMR",0)
 . D ^DIR K DIR Q:$D(DIRUT)
 . S EN("STA")=Y
 ; ask comments
 S DIR(0)="Y",DIR("A")="Should the COMMENTS field be printed"
 S DIR("B")="NO"
 D ^DIR K DIR G:$D(DIRUT) OUT S EN("COM")=Y
 ; ask device
 D DEV^ENLIB G:POP OUT
 I $D(IO("Q")) D  G OUT
 . S ZTRTN="CMR1A^ENEQRPI",ZTDESC="CMR LISTING"
 . S ZTSAVE("ENNXEXP")=""
 . S ZTSAVE("EN(""FR"")")="",ZTSAVE("EN(""TO"")")=""
 . S ZTSAVE("EN(""STA"")")="",ZTSAVE("EN(""COM"")")=""
 . S ZTSAVE("ENSND")="",ZTSAVE("EN(""CMR"",0)")=""
 . D ^%ZTLOAD K ZTSK D HOME^%ZIS
CMR1A ; queued entry point
 S EN("IOP")=ION
 S EN("CMR")=EN("FR")
 I EN("STA")'="ALL" D  I EN("CMR",5)'=EN("STA") G CMR2A
 . S EN("CMR",5)=$$GET1^DIQ(6914.1,EN("CMR",0),5) ; station number
 . I EN("CMR",5)="" S EN("CMR",5)=ENSND ; default station #
CMR2 ; cmr loop
 S DIC="^ENG(6914,",L=0
 S IOP=EN("IOP"),BY=$S($D(^DIBT("B","ENZCMR")):"[ENZCMR]",1:"[ENCMR]")
 I '$D(ENNXEXP) D  ; CMR report
 . I EN("COM") S FLDS=$S($D(^DIPT("B","ENZCMRC")):"[ENZ",1:"[EN")_"CMRC]"
 . E  S FLDS=$S($D(^DIPT("B","ENZCMR")):"[ENZ",1:"[EN")_"CMR]"
 . S DHD=$S($D(^DIPT("B","ENZCMR HD")):"[ENZCMR HD]",1:"[ENCMR HD]")
 . S DHIT="D CMRCMP^ENEQRPI,CMRTOT^ENEQRPI"
 . S DIOEND="D:$D(ENT) SUM^ENEQCMR D:$D(ENCSN) SIG^ENEQCMR I IO=IO(0),$E(IOST,1,2)=""C-"" R !,""Press <RETURN> to continue..."",X:DTIME"
 . ; accountable equipment only (patch EN*7*63)
 . S DIS(0)="I ""^1^A^""[(U_$P($G(^ENG(6914,D0,8)),U,2)_U)"
 . ;S DIS(0)="I $P($G(^ENG(6914,D0,8)),U,2)!(""^10^23^70^""[(U_$S($P($G(^ENG(6914,D0,2)),U,8):$E($P($G(^ENCSN(6917,$P(^ENG(6914,D0,2),U,8),0)),U),1,2),1:"""")_U))" ; capitalized or adp, vech, or firearm
 I $D(ENNXEXP) D  ; NON-EXPENDABLE (EXPENSED) report
 . I EN("COM") S FLDS=$S($D(^DIPT("B","ENZEXPC")):"[ENZ",1:"[EN")_"EXPC]"
 . E  S FLDS=$S($D(^DIPT("B","ENZEXP")):"[ENZ",1:"[EN")_"EXP]"
 . S DHD=$S($D(^DIPT("B","ENZEXP HD")):"[ENZEXP HD]",1:"[ENEXP HD]")
 . S DHIT="D CMRCMP^ENEQRPI"
 . S DIOEND="I IO=IO(0),$E(IOST,1,2)=""C-"" R !,""Press <RETURN> to continue..."",X:DTIME"
 . ; only not accountable (patch EN*7*63)
 . S DIS(0)="I ""^1^A^""'[(U_$P($G(^ENG(6914,D0,8)),U,2)_U)"
 . ;S DIS(0)="I '$P($G(^ENG(6914,D0,8)),U,2)&'(""^10^23^70^""[(U_$S($P($G(^ENG(6914,D0,2)),U,8):$E($P($G(^ENCSN(6917,$P(^ENG(6914,D0,2),U,8),0)),U),1,2),1:"""")_U))" ; not capitalized and not adp, vech, or firearm
 S (TO,FR)=EN("CMR")
 S EN("CMR",0)=$O(^ENG(6914.1,"B",EN("CMR"),0)) ; CMR ien
 S EN("CMR",.5)=$$GET1^DIQ(6914.1,EN("CMR",0),.5) ; service
 S EN("CMR",.6)=$$GET1^DIQ(6914.1,EN("CMR",0),.6) ; brief desc
 S EN("CMR",1)=$$GET1^DIQ(6914.1,EN("CMR",0),1) ; resp official
 S EN("CMR",5)=$$GET1^DIQ(6914.1,EN("CMR",0),5) ; station number
 I EN("CMR",5)="" S EN("CMR",5)=ENSND ; default station #
 S EN("CMR","HD")=EN("CMR")
 S:EN("CMR",.5)]"" EN("CMR","HD")=EN("CMR","HD")_"   "_EN("CMR",.5)_" SERVICE"
 S:EN("CMR",.6)]"" EN("CMR","HD")=EN("CMR","HD")_"  "_EN("CMR",.6)
 S:EN("CMR",1)]"" EN("CMR","HD")=EN("CMR","HD")_"  "_EN("CMR",1)
 K ENCSN,ENT D EN1^DIP K ENCSN,ENT
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 G OUT ; aborted by user request
CMR2A ; determine next CMR in loop (use B1 x-ref for acsii collating sequence)
 S EN("X")=$O(^ENG(6914.1,"B1",$E(EN("CMR"),1,29)_" "))
 S EN("I")=$S(EN("X")]"":$O(^ENG(6914.1,"B1",EN("X"),0)),1:"")
 S EN("CMR")=$S(EN("I"):$P($G(^ENG(6914.1,EN("I"),0)),U),1:"")
 I EN("CMR")=""!(EN("CMR")]EN("TO")) G OUT
 I EN("STA")'="ALL" D  I EN("STA")'=EN("CMR",5) G CMR2A
 . S EN("CMR",5)=$$GET1^DIQ(6914.1,EN("I"),5) ; station #
 . I EN("CMR",5)="" S EN("CMR",5)=ENSND ; default station #
 I ION=EN("IOP"),$E(IOST,1,2)="C-" S DIR(0)="Y",DIR("A")="Continue to another EIL ("_EN("CMR")_")",DIR("B")="YES" D ^DIR K DIR G:'Y OUT
 G CMR2
 ;
CMRNOM ; Print CSN Nomenclature on CMR (called from ENCMR print template)
 Q:'$D(D0)
 I '$D(ENCSN) S ENCSN=$P($G(^ENG(6914,D0,2)),U,8) D CMRNOMP Q
 Q:$P($G(^ENG(6914,D0,2)),U,8)=ENCSN
 S ENCSN=$P($G(^ENG(6914,D0,2)),U,8) D CMRNOMP
 Q
CMRNOMP ; prints nomenclature when CSN changes
 Q:ENCSN=""
 Q:'$D(^ENCSN(6917,ENCSN,0))
 N X,DIWL,DIWR,DIWF,ENI
 K ^UTILITY($J,"W") S DIWL=1,DIWR=IOM,DIWF="W"
 W !!,"CATEGORY STOCK NUMBER: ",$P(^ENCSN(6917,ENCSN,0),U)
 W "  (",$P(^ENCSN(6917,ENCSN,0),U,3),")"
 S ENI=0
 F  S ENI=$O(^ENCSN(6917,ENCSN,1,ENI)) Q:'ENI  I $D(^(ENI,0)) S X=^(0) D ^DIWP
 D ^DIWW
 Q
CMRCMP ; List components of equipment on CMR (called by DHIT)
 Q:'$D(D0)
 N ENDA,ENVAL
 ; print components
 S ENDA=0
 F  S ENDA=$O(^ENG(6914,"AE",D0,ENDA)) Q:'ENDA  D
 . W ?9,"COMPONENT ENTRY #: ",ENDA
 . W ?40,$E($P($G(^ENG(6914,ENDA,0)),U,2),1,20)
 . S ENVAL=$P($G(^ENG(6914,ENDA,2)),U,3)
 . I ENVAL]"" W ?61,$J("$"_$FN(ENVAL,"",2),12) W ! Q
 . S ENVAL=$P($G(^ENG(6914,ENDA,2)),U,12)
 . I ENVAL]"" W ?61,$J("$"_$FN(ENVAL,"",2),12)," LEASE"
 . W !
 Q
CMRTOT ; Maintain totals for CMR (called by DHIT)
 ; add value to totals
 ; input
 ;   D0 - ien of equipment entry
 ;   ENSND - default station number (from 6910)
 ;   optional ENT(station,fund,sgl)=count^lease cost^asset value
 ; output
 ;   ENT(
 Q:'$D(D0)
 N ENSN,ENFUND,ENSGL,ENY
 S ENY(2)=$G(^ENG(6914,D0,2))
 S ENY(8)=$G(^ENG(6914,D0,8))
 S ENY(9)=$G(^ENG(6914,D0,9))
 S ENSN=$P(ENY(9),U,5)
 I $P(ENY(8),U,2) S ENFUND=$P(ENY(9),U,7),ENSGL=$P(ENY(8),U,6)
 I '$P(ENY(8),U,2) S ENFUND="<null>",ENSGL=10
 I ENSN="",$G(ENSND)]"" S ENSN=ENSND
 S:ENSN="" ENSN="<null>"
 S:ENFUND="" ENFUND="<null>"
 S:ENSGL="" ENSGL="<null>"
 S $P(ENT(ENSN,ENFUND,ENSGL),U)=$P($G(ENT(ENSN,ENFUND,ENSGL)),U)+1
 S $P(ENT(ENSN,ENFUND,ENSGL),U,2)=$P($G(ENT(ENSN,ENFUND,ENSGL)),U,2)+$P(ENY(2),U,12)
 S $P(ENT(ENSN,ENFUND,ENSGL),U,3)=$P($G(ENT(ENSN,ENFUND,ENSGL)),U,3)+$P(ENY(2),U,3)
 Q
 ;
 ;ENEQRPI
