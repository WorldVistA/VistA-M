PSOPMPPF ;BIRM/MFR - Patient Medication Profile - Preferences ;04/28/05
 ;;7.0;OUTPATIENT PHARMACY;**260**;DEC 1997;Build 84
 ;
EN ; - Menu option entry point
 N PSOCHNG,PSOQUIT,DIR,DIRUT,DIROUT
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! Q
 ;
 D LOAD(PSOSITE),LST(PSOSITE)
 I '$G(PSOQUIT),$G(PSOCHNG) D SAVE(PSOSITE)
 ;
 G END
 ;
LST(PSOSITE,PSOUSER) ; - Listmanager entry point
 N DIR,DIRUT,DIROUT
 S (PSOCHNG,PSOQUIT)=0,PSOUSER=+$G(PSOUSER) D FULL^VALM1 W !
 ;
 ; - Reset user/division preferences
 I (PSOUSER&$D(^PS(52.85,PSOSITE,"USER",PSOUSER)))!('PSOUSER&($$GET1^DIQ(52.85,PSOSITE,1)'="")) D
 . D DISPLAY(PSOSITE,PSOUSER)
 . S DIR("A")="     Delete this default view? "
 . S DIR(0)="YA",DIR("B")="NO" D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I Y=1 D DELETE(PSOSITE,PSOUSER),LOAD(PSOSITE,PSOUSER)
 . W !
 E  W !,"Division: ",$$GET1^DIQ(59,PSOSITE,.01),!
 I PSOQUIT Q
 ;
EXPDC ; - Expiration/Discontinued Cutoff Date
 K DIR,DIRUT,DIROUT,SAVEX
 S DIR(0)="NA^0:9999",DIR("A")="EXP/CANCEL CUTOFF: ",DIR("B")=PSOEXDCE
 S DIR("?",1)="Enter the maximum number of days for an expired and/or"
 S DIR("?")="discontinued prescription to be cut from the profile."
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"EXPDC")
 W " DAYS" S PSOEXDCE=X,X="T"_$S(X:"-"_X,1:"") D ^%DT S PSOEXPDC=Y
 D CHANGED(PSOSITE,PSOUSER,"EXPDC",PSOEXDCE)
 ;
SRTBY ; - Sort By 
 K DIR,DIRUT,DIROUT
 S DIR(0)="SA^RX:Rx#;DR:DRUG NAME;ID:ISSUE DATE;LF:LAST FILL DATE",DIR("B")=PSOSRTBY
 S DIR("A")="SORT BY: " D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"SRTBY")
 S PSOSRTBY=Y D CHANGED(PSOSITE,PSOUSER,"SRTBY",PSOSRTBY)
 ;
ORDER ; - Sort Order 
 K DIR,DIRUT,DIROUT
 S DIR(0)="SA^A:ASCENDING;D:DESCENDING",DIR("B")=$S(PSORDER="A":"ASCENDING",1:"DESCENDING")
 S DIR("A")="SORT ORDER: " D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"ORDER")
 S PSORDER=Y D CHANGED(PSOSITE,PSOUSER,"ORDER",PSORDER)
 ;
SIGDP ; - Display SIG 
 K DIR,DIRUT,DIROUT
 S DIR(0)="SA^ON:ON;OFF:OFF",DIR("B")=$S(PSOSIGDP=1:"ON",1:"OFF")
 S DIR("A")="DISPLAY SIG: " D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"SIGDP")
 S Y=$S(X="ON":1,1:0),PSOSIGDP=Y D CHANGED(PSOSITE,PSOUSER,"SIGDP",PSOSIGDP)
 ;
STSGP ; - Group By Status 
 K DIR,DIRUT,DIROUT
 S DIR(0)="SA^ON:ON;OFF:OFF",DIR("B")=$S(PSOSTSGP=1:"ON",1:"OFF")
 S DIR("A")="GROUP BY STATUS: " D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"STSGP")
 S Y=$S(X="ON":1,1:0),PSOSTSGP=Y D CHANGED(PSOSITE,PSOUSER,"STSGP",PSOSTSGP)
 ;
ORDCNT ; - Display Order Count 
 K DIR,DIRUT,DIROUT
 S DIR(0)="SA^ON:ON;OFF:OFF",DIR("B")=$S(PSORDCNT=1:"ON",1:"OFF")
 S DIR("A")="DISPLAY ORDER COUNT: " D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"ORDCNT")
 S Y=$S(X="ON":1,1:0),PSORDCNT=Y D CHANGED(PSOSITE,PSOUSER,"ORDCNT",PSORDCNT)
 ;
EXIT ; Exit
 ;
 ; - Save view?
 I $G(PSOCHNG),PSOUSER D
 . W ! S DIR(0)="YA",DIR("B")="NO",DIR("A")="Save as your default View? "
 . D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y=0) Q
 . D SAVE(PSOSITE,PSOUSER)
 ;
 S VALMBCK="R"
 ;
END Q
 ;
DISPLAY(SITE,USER) ; - Displays the current view
 N X,Z,FLG,LN
 S (X,Z,FLG)=""
 I $G(USER),$D(^PS(52.85,SITE,"USER",+$G(USER))) D
 . S X=$$GET1^DIQ(200,USER,.01),Z=^PS(52.85,SITE,"USER",+$G(USER),0),FLG=1
 E  D
 . S X=$$GET1^DIQ(59,SITE,.01),Z=$G(^PS(52.85,SITE,0))
 I Z="" Q
 S X=X_"'s current default view"_$S(FLG:" ("_$$GET1^DIQ(59,SITE,.01)_")",1:"")_":"
 S $P(LN,"-",$L(X))="" W !?5,X,!?5,LN
 W !?5,"EXP/CANCEL CUTOFF  : ",$P(Z,"^",2)," DAYS"
 S X=$P(Z,"^",3) W !?5,"SORT BY            : "
 W $S(X="RX":"Rx#",X="DR":"DRUG NAME",X="ID":"ISSUE DATE",X="LF":"LAST FILL DATE",1:"??")
 W !?5,"SORT ORDER         : ",$S($P(Z,"^",4)="A":"ASCENDING",1:"DESCENDING")
 W !?5,"DISPLAY SIG        : ",$S($P(Z,"^",5):"ON",1:"OFF")
 W !?5,"GROUP BY STATUS    : ",$S($P(Z,"^",6):"ON",1:"OFF")
 W !?5,"DISPLAY ORDER COUNT: ",$S($P(Z,"^",7):"ON",1:"OFF")
 W !
 Q 
 ;
GOTO(INPUT,HOME) ; - Directed up-arrow
 N GOTO,TAG,TRGT
 I $P(INPUT,"^",2)="" S PSOQUIT=1 Q "EXIT"
 ;
 S TRGT=$P(INPUT,"^",2)
 S TAG("EXP/CANCEL CUTOFF")="EXPDC"
 S TAG("SORT BY")="SRTBY"
 S TAG("SORT ORDER")="ORDER"
 S TAG("DISPLAY SIG")="SIGDP"
 S TAG("GROUP BY STATUS")="STSGP"
 S TAG("DISPLAY ORDER COUNT")="ORDCNT"
 ;
 S GOTO=HOME
 S TAG="" F  S TAG=$O(TAG(TAG)) Q:TAG=""  I $E(TAG,1,$L(TRGT))=TRGT S GOTO=TAG(TAG) Q
 I GOTO=HOME W "   ??",$C(7)
 ;
 Q GOTO
 ;
LOAD(SITE,USER) ; Loading Factory/Division/User preferences
 ;Input : SITE     - Pointer to OUTPATIENT SITE file (#59)
 ;        USER     - Pointer to NEW PSERON file (#200)
 ;Output: PSOEXPDC - Expiration Cutoff Date
 ;        PSOEXDCE - Expiration Cutoff Date (External)
 ;        PSOSRTBY - Sort By
 ;        PSORDER - Sort Order ("A":Asc,"D":Desc)
 ;        PSOSIGDP - Display SIG (1:ON/0:OFF)
 ;        PSORDCNT - Display Order Count (1:ON/0:OFF)
 ;        PSOSTSGP - Group by Status (1:ON/0:OFF)
 ;        PSOSTSEQ - Status Display Order Array
 ;        PSORDSEQ - Group Display Order Array
 ;
 K PSOEXPDC,PSOEXDCE,PSOSRTBY,PSORDER,PSOSTSGP,PSOSIGDP,PSOSTSEQ,PSORDSEQ
 ;
 N X,Y,Z,TMP,STSGRP,STS,ORDGRP,GRPNAM
 ;
 ; - Factory Defaults
 S PSOEXDCE=120,X="T-120" D ^%DT S PSOEXPDC=Y
 S PSOSRTBY="DR",PSORDER="A",PSORDCNT=1,(PSOSTSGP,PSOSIGDP)=0
 ; 
 S PSOSTSEQ("A")="1^ACTIVE^A"             ; Active
 S PSOSTSEQ("S")="1^ACTIVE^S"             ; Suspended
 S PSOSTSEQ("E")="1^ACTIVE^E"             ; Expired
 S PSOSTSEQ("DC")="2^DISCONTINUED^DC"     ; Discontinued
 S PSOSTSEQ("DP")="2^DISCONTINUED^DP"     ; Discontinued by Provider
 S PSOSTSEQ("DE")="2^DISCONTINUED^DE"     ; Discontinued on Edit
 S PSOSTSEQ("H")="3^HOLD^H"               ; Hold
 S PSOSTSEQ("PH")="3^HOLD^PH"             ; Provider Hold
 S PSOSTSEQ("N")="4^NON-VERIFIED^N"       ; Non-Verified
 ;
 S PSORDSEQ("T")="1^REFILL TOO SOON/DUR REJECTS(Third Party)"
 S PSORDSEQ("R")="2^CURRENT ORDERS"
 S PSORDSEQ("P")="3^PENDING"
 S PSORDSEQ("N")="4^NON-VA MEDS (Not dispensed by VA)"
 ;
 ; - User's preferences
 I $G(USER),$D(^PS(52.85,SITE,"USER",USER,0)) D SET(^PS(52.85,SITE,"USER",USER,0)) Q
 ;
 ; - Division's preferences
 I $D(^PS(52.85,SITE,0)) D SET(^PS(52.85,SITE,0)) Q
 ;
 Q
 ;
CHANGED(SITE,USER,FIELD,VALUE) ; - Sets PSOCHNG so the list can be refreshed
 I $G(PSOCHNG) Q
 ;
 ; - Saved User's preferences
 S Z=""
 I '$G(USER),$P($G(^PS(52.85,SITE,0)),"^",2) S Z=^PS(52.85,SITE,0)
 I $G(USER),$D(^PS(52.85,SITE,"USER",USER,0)) S Z=^PS(52.85,SITE,"USER",USER,0)
 ;
 I FIELD="EXPDC",VALUE'=$P(Z,"^",2) S PSOCHNG=1 Q
 I FIELD="SRTBY",VALUE'=$P(Z,"^",3) S PSOCHNG=1 Q
 I FIELD="ORDER",VALUE'=$P(Z,"^",4) S PSOCHNG=1 Q
 I FIELD="SIGDP",VALUE'=+$P(Z,"^",5) S PSOCHNG=1 Q
 I FIELD="STSGP",VALUE'=+$P(Z,"^",6) S PSOCHNG=1 Q
 I FIELD="ORDCNT",VALUE'=+$P(Z,"^",7) S PSOCHNG=1 Q
 ;
 Q
 ;
 ;
SET(ZNODE) ;
 N X,Y
 S X=+$P(ZNODE,"^",2) I X S PSOEXDCE=X,X="T-"_X D ^%DT S PSOEXPDC=Y
 S X=$P(ZNODE,"^",3) I X'="" S PSOSRTBY=X
 S X=$P(ZNODE,"^",4) I X'="" S PSORDER=X
 S X=$P(ZNODE,"^",5) I X'="" S PSOSIGDP=X
 S X=$P(ZNODE,"^",6) I X'="" S PSOSTSGP=X
 S X=$P(ZNODE,"^",7) I X'="" S PSORDCNT=X
 Q
 ;
SAVE(SITE,USER) ; - Saves preferences by Site and/or User
 N DIE,DR,DA
 ;
 W !!,"Saving..."
 ;
 I '$D(^PS(52.85,SITE)) D
 . N %,DIC,DR,DA,X,DINUM,DLAYGO,DD,DO
 . S DIC="^PS(52.85,",(DINUM,X)=SITE,DIC(0)=""
 . K DD,DO D FILE^DICN K DD,DO
 ;
 I $G(USER),'$D(^PS(52.85,SITE,"USER",USER,0)) D
 . N %,DIC,DR,DA,X,DINUM,DLAYGO,DD,DO
 . S DIC="^PS(52.85,"_SITE_",""USER"",",DA(1)=SITE,(DINUM,X)=USER,DIC(0)=""
 . K DD,DO D FILE^DICN K DD,DO
 ;
 S DR="1///"_PSOEXDCE_";2///"_PSOSRTBY_";3///"_PSORDER
 S DR=DR_";4///"_PSOSIGDP_";5///"_PSOSTSGP_";6///"_PSORDCNT
 ;
 I '$G(USER) S DIE="^PS(52.85,",DA=SITE
 I $G(USER) S DIE="^PS(52.85,"_SITE_",""USER"",",DA(1)=SITE,DA=USER
 ;
 D ^DIE H 2 W "OK!"
 ;
 Q
 ;
DELETE(SITE,USER) ; - Deletes user/division preferences
 N DIK,DA,DIE,DR,FLD
 ;
 W !!,"Deleting..."
 ;
 I '$G(SITE) Q
 I $G(USER) S DIK="^PS(52.85,"_SITE_",""USER"",",DA(1)=SITE,DA=USER D ^DIK H 1 W "OK!" Q
 I '$D(^PS(52.85,SITE,"USER")) S DIK="^PS(52.85,",DA=SITE D ^DIK H 1 W "OK!" Q
 S DR="" F FLD=1:1:8 S $P(DR,";",FLD)=FLD_"///@"
 S DIE="^PS(52.85,",DA=SITE D ^DIE H 1 W "OK!"
 Q
