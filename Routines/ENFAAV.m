ENFAAV ;IRMFO/SAB-ADJUSTMENT VOUCHER ENTRY ;6.30.97
 ;;7.0;ENGINEERING;**39**;AUG 17, 1993
EN ; Entry point for option
 ; load table for converting FA Type to SGL
 K ENFAPTY S ENDA=0 F   S ENDA=$O(^ENG(6914.3,ENDA)) Q:'ENDA  D
 . S ENY0=$G(^ENG(6914.3,ENDA,0))
 . I $P(ENY0,U,3)]"" S ENFAPTY($P(ENY0,U,3))=$P(ENY0,U)
ASKDOC ; ask FAP Document
 W !
 S DIR(0)="SBO^FA:FA DOCs;FB:FB DOCs;FC:FC DOCs;FD:FD DOCs;FR:FR DOCs"
 S DIR("A")="Select Type of FAP Document"
 S DIR("?",1)="Choose the type of FAP Document for which an Adjustment"
 S DIR("?",2)="Voucher should be created. After the type is chosen, you"
 S DIR("?",3)="will be asked to select the specific FAP Document."
 S DIR("?")=" "
 D ^DIR K DIR G:Y']""!$D(DIRUT) EXIT
 S ENFILE="6915."_$F("ABCDR",$E(Y,2,2))
 ;
 S DIC="^ENG("_ENFILE_",",DIC(0)="AQEM"
 S DIC("A")="Select "_Y_" DOCUMENT (by Transaction Number or Equipment ENTRY #): "
 D ^DIC G:Y'>0 EXIT
 S ENDA("F?")=+Y
SHOWDOC ; show info for FAP Document/Adjustment Voucher
 S ENDT=$$GET1^DIQ(ENFILE,ENDA("F?"),301,"I")
 S ENY0=$G(^ENG(ENFILE,ENDA("F?"),0))
 S ENY1=$G(^ENG(ENFILE,ENDA("F?"),1))
 S ENDA=$P($G(^ENG(ENFILE,ENDA("F?"),0)),U)
 S ENDA("FA")=$$AFA^ENFAR5A(ENFILE,ENDA("F?")) ; associated FA
 S ENFAY3=$G(^ENG(6915.2,ENDA("FA"),3))
 S ENSN=$TR($E($P(ENFAY3,U,5),1,5)," ","")
 S:ENFILE=6915.2 ENFUND=$P(ENFAY3,U,10)
 S:ENFILE'=6915.2 ENFUND=$$FUND^ENFAR5A(ENFILE,ENDA("F?"),ENDA("FA"))
 S ENSGL=$S($P(ENFAY3,U,6)]"":$G(ENFAPTY($P(ENFAY3,U,6))),1:"")
 S ENAMT=0
 I ENFILE=6915.2 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,27)
 I ENFILE=6915.3 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,4)
 I ENFILE=6915.4 S ENX=$P($G(^ENG(ENFILE,ENDA("F?"),4)),U,6),ENAMT=$S(ENX="":0,1:ENX-$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,4))
 I ENFILE=6915.5 S ENAMT="-"_$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,2)
 I ENFILE=6915.6 S ENAMT=$P($G(^ENG(ENFILE,ENDA("F?"),100)),U,8)
 W @IOF,!,"ADJ. VOUCHER",?16,"TRANSACTION .............",?43,"STN"
 W ?50,"FUND",?58,"SGL",?63,"NET AMOUNT"
 W !,"DATE/TIME",?16,"CODE NUMBER      DATE"
 W !,"--------------",?16,"---- ----------- --------",?43,"-----"
 W ?50,"------",?58,"----",?63,"----------------"
 W !,$E($TR($$FMTE^XLFDT(ENDT,"2F")," ",0),1,14)
 W ?16,$P(ENY1,U,6),?21,$P(ENY1,U,9)
 W ?33,$TR($$FMTE^XLFDT($P(ENY0,U,2),"2DF")," ",0)
 W ?43,ENSN,?50,ENFUND,?58,ENSGL
 I ENFILE=6915.6 D  ; check FR doc for FUND change
 . S ENFUNDNW=$P($G(^ENG(ENFILE,ENDA("F?"),3)),U,9)
 . I ENFUND=ENFUNDNW S ENAMT=0 Q  ; fund didn't change
 . S ENAMT=-ENAMT ; subtract from old fund
 W ?63,$J($FN(ENAMT,",",2),16)
 I ENFILE=6915.6,ENFUND'=ENFUNDNW D
 . ; show addition to new fund
 . W !,?43,ENSN,?50,ENFUNDNW,?58,ENSGL
 . W ?63,$J($FN(-ENAMT,",",2),16)
 W !,?5,"EQUIP #: ",ENDA,?26,$$GET1^DIQ(6914,ENDA,3)
 S ENX=$$GET1^DIQ(ENFILE,ENDA("F?"),303)
 I ENX]"" W !,?5,"REASON: ",ENX
 I $O(^ENG(ENFILE,ENDA("F?"),301,0)) D  G:$D(DIRUT) EXIT
 . K ^UTILITY($J,"W") S DIWL=6,DIWR=(IOM-5),DIWF="W|"
 . S X="COMMENTS: ",ENI=0
 . F  S ENI=$O(^ENG(ENFILE,ENDA("F?"),301,ENI)) Q:'ENI  S X=X_^(ENI,0) D ^DIWP S X="" I $Y+4>IOSL S DIR(0)="E" D ^DIR K DIR Q:$D(DIRUT)!'Y  W @IOF
 . D ^DIWW
CHECKAV ;
 I $$GET1^DIQ(ENFILE,ENDA("F?"),301)]"" D  G ASKDOC
 . W $C(7),!,"This FAP Document already has an Adjustment Voucher!",!
EDITAV ;
 W !
 S ENAV=$$AVP(ENFILE,ENDA("F?"))
 I 'ENAV W !,"Adjustment voucher was NOT created." I $G(ENUT) G EXIT
 I ENAV D
 . S DIE="^ENG("_ENFILE_",",DR="301///NOW",DA=ENDA("F?") D ^DIE
 . W !,"Adjustment Voucher was created.",!
 G ASKDOC
EXIT ;
 K DA,DIC,DIE,DIR,DIRUT,DIROUT,DR,DTOUT,DUOUT,X,Y
 K ENAMT,ENAV,ENDA,ENDT,ENFAPTY,ENFAY3,ENFILE,ENFUND,ENFUNDNW
 K ENSGL,ENSN,ENUT,ENY0,ENY1
 Q
 ;
AVP(ENF,ENDA) ; adjustment voucher preparation
 ; This program gathers all the information required for an adjustment
 ; voucher. The calling program must evaluate the return value and
 ; actually create the adjustment voucher at the appropriate time
 ; by storing NOW in the appropriate A.V. DATE field.
 ;
 ; Called by this routine for existing FAP Documents or by routines
 ; ENFAACQ, ENFABETR, ENFACHG, ENFADEL, ENFAXF during creation of
 ; new FAP Documents
 ;
 ; in
 ;   ENF  - # of file (e.g. 6915.2 for FA DOCUMENT LOG)
 ;   ENDA - ien of entry in ENF to create adjustment voucher for
 ; out
 ;   $D(ENUT) true if time-out or uparrow '^' during call
 ; returns 0 (cancelled) or 1 (fully prepared)
 ;
 N DA,DIE,DIR,DR,ENAV,X,Y
 K ENUT S ENAV=0
 ;
 S DIR(0)="Y"
 S DIR("A")="Should an Adjustment Voucher be created",DIR("B")="YES"
 S DIR("?",1)="Adjustment Vouchers are used to inform Fiscal personnel"
 S DIR("?",2)="of FAP transactions that Fiscal must take action on."
 S DIR("?",3)=" "
 S DIR("?")="Enter YES or NO"
 D ^DIR K DIR S:$D(DIRUT) ENUT=1 G:'Y!$D(DIRUT) AVPX
 ;
AVPED S DIE="^ENG("_ENF_",",DR="303R;310R",DA=ENDA D ^DIE
 S DIR(0)="Y",DIR("A")="Is adjustment voucher correct"
 D ^DIR K DIR I $D(DIRUT) S ENUT=1 G AVPX
 I 'Y D  G:Y AVPED S Y=$$AVC(ENF,ENDA) G AVPX
 . S DIR(0)="Y",DIR("A")="Do you want to re-edit it"
 . D ^DIR K DIR I $D(DIRUT) S ENUT=1
 I $P($G(^ENG(ENF,ENDA,300)),U,3)=""!'$O(^ENG(ENF,ENDA,301,0)) D  G AVPED
 . W $C(7),!,"Both Reason Code and Comments are required!"
 S ENAV=1
 ;
AVPX ; exit
 Q ENAV
 ;
AVC(ENF,ENDA) ; Adjustment Voucher Clean Up
 ; This code is used to clean up an aborted adjustment voucher.
 ; in
 ;   ENF -  file number (e.g. 6915.2)
 ;   ENDA - ien
 ; returns 1 (done) or 0 (can't because a.v. completed)
 ;
 I ENF'?1"6915."1N Q 0
 I $$GET1^DIQ(ENF,ENDA,301)]"" Q 0
 S DIE="^ENG("_ENF_",",DR="303///@;310///@",DA=ENDA D ^DIE Q 1
 ;
 ;ENFAAV
