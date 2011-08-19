ENBCPM6 ;(WASH ISC)/DH-Bar Coded PMI Utilities ;4.9.97
 ;;7.0;ENGINEERING;**14,35**;Aug 17, 1993
MSG ;Opening message to user
 W !!,"The system is now ready to update the Equipment File on the basis of",!,"data acquired from the portable bar code reader."
 W !!,"Data that cannot be processed normally will be reported as Exception Messages."
 W !,"These messages will provide notification of such things as missing bar code",!,"labels and database inconsistencies."
 W !!,"Exception Messages will also be printed for devices that FAIL their PM"
 W !,"inspection.  Regular work orders will be automatically generated.  The PM work",!,"order will be closed with a reference to the regular work order."
 W !!,"You must now select a hard copy device (printer) to receive PMI Exception",!,"Messages."
 W !!,"You may enter the letter 'Q' and then select a device if you wish to",!,"schedule this data processing task for some later time. You may enter the"
 W !,"caret key ('^') to abort this update with the intention of manually re-",!,"starting it at some later date.",!
 Q
 ;
WOCHK ;  Has PM already been posted?
 ;    Expects ENEQ as IEN to Equipment File
 ;
 F I=0:0 S I=$O(^ENG(6914,ENEQ,6,I)) Q:I'>0  I $P(^ENG(6914,ENEQ,6,I,0),U,2)[ENPMWO S ENWOX=1
 I 'ENWOX Q  ;Nothing recorded
 S ENMSG="PM Work Order already posted for Equipment ID#: "_ENEQ D XCPTN^ENBCPM2
 Q
 ;
POST ;  Retain PM work order
 N ENDA
 S ENPMWO(0)=$O(^ENG(6920,"B",ENPMWO_"-9999"),-1) S:ENPMWO(0)'[ENPMWO ENPMWO(0)=ENPMWO_"-001"
 L +^ENG(6920,"B"):30 I '$T K ENPMWO(0) Q
POST1 I $D(^ENG(6920,"B",ENPMWO(0)))!($D(^ENG(6920,"H",ENPMWO(0)))) S J=+$P(ENPMWO(0),"-",3)+1 S:J?1.2N J=$S(J?1N:"00"_J,1:"0"_J) S ENPMWO(0)=ENPMWO_"-"_J G POST1
 K DD,DO S DIC="^ENG(6920,",DIC(0)="LX",X=ENPMWO(0) D FILE^DICN S DA=+Y
 L -^ENG(6920,"B")
 I DA'>0 K ENPMWO(0) Q
 S ENWP="UNSCHEDULED PMI (Bar Code Reader)"
 S DIE="^ENG(6920,",DR=".05///^S X=ENPMWO(0);1///^S X=DT;3///^S X=ENLOC;6///^S X=""PM Inspection (Unscheduled)"";9///^S X=ENSHKEY;10///^S X=DT;18///^S X=ENEQ;35.2///^S X=""P"";39///^S X=ENWP"
 D ^DIE
 S ^ENG(6920,DA,8,0)="^6920.035PA^1^1",DIE="^ENG(6920,DA(1),8,",(ENDA,DA(1))=DA,DA=1,DR=".01///^S X=""PREVENTIVE MAINTENANCE""" D ^DIE K DA S DA=ENDA
 I $G(EN)=21 D  Q
 . S ^ENG(6920,DA,7,0)="^6920.02PA^1^1",DIE="^ENG(6920,DA(1),7,",(ENDA,DA(1))=DA,DA=1,DR=".01///^S X=ENTEC;2///^S X=ENSHKEY" D ^DIE K DA S DA=ENDA
 . K DR S DIE="^ENG(6920,",DR="36///^S X=DT;32///^S X=""COMPLETED""" D ^DIE
 S ENTIME=+$E(ENLKAHD,6,30) I ENTIME]"" S X=ENTIME,X(0)=2 D ROUND^ENLIB S ENTIME=+Y S:ENTIME<0 ENTIME="" S:ENTIME>0 $P(^ENG(6920,DA,5),U,3)=ENTIME
 S ENX=ENX1,^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENLKAHD,ENX1=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)) S ENLKAHD=$S(ENX1]"":^(ENX1,0),1:"")
        S ENMATRL="" I $E(ENLKAHD,1,5)="MATRL" D
        . S ENX=ENX1,^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENLKAHD,ENMATRL=+$E(ENLKAHD,7,30) S:ENMATRL<0 ENMATRL=""
 . I ENMATRL=+ENMATRL S X=ENMATRL,X(0)=2 D ROUND^ENLIB S ENMATRL=+Y
        . S ENX1=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX)),ENLKAHD=$S(ENX1]"":^(ENX1,0),1:"")
        . I $E(ENLKAHD,1,5)="CODE:" D
        .. S ENX=ENX1,^PRCT(446.4,ENCTID,2,ENCTTI,1,ENX,0)="*"_ENLKAHD
        .. I $P(ENLKAHD,":",2)?1N N DIE,DA D
        ... S DA=ENEQ,DIE="^ENG(6914,",DR="53///"_$P(ENLKAHD,":",2) D ^DIE
        ... Q
 S X=ENX,ENWP=""
 F  S X=$O(^PRCT(446.4,ENCTID,2,ENCTTI,1,X)) Q:X=""  S X1=^(X,0) Q:($E(X1)="*")!($E(X1,1,2)="SP")!($E(X1,1,4)="MOD:")!($E(X1,1,4)="PM:")!($E(X1,3,8)[" EE")  D
 . S ENX=X,ENWP=ENWP_X1
 . S ^PRCT(446.4,ENCTID,2,ENCTTI,1,X,0)="*"_X1
 I ENWP]"",$L(ENWP)<130 S ENWP=ENWP_" (Bar Code)"
 I ENWP="" S ENWP="UNSCHEDULED PMI (Bar Code Reader)"
 I ENTIME>0 S ENW=$P($G(^ENG("EMP",ENTEC,0)),U,3) D
 . I ENW'>0 S ENW=$P($G(^DIC(6910,1,0)),U,4)
 . I ENW>0 S $P(^ENG(6920,DA,5),U,6)=ENW*ENTIME
 S ^ENG(6920,DA,7,0)="^6920.02PA^1^1",DIE="^ENG(6920,DA(1),7,",(ENDA,DA(1))=DA,DA=1,DR=".01///^S X=ENTEC;1///^S X=ENTIME;2///^S X=ENSHKEY" D ^DIE K DA S DA=ENDA
 K DR S DIE="^ENG(6920,",DR="38///^S X=ENMATRL;39///^S X=ENWP;36///^S X=DT;32///^S X=""COMPLETED""" D ^DIE
 I $G(ENTIME)>0 S PMTOT(ENSHKEY,ENTEC)=$G(PMTOT(ENSHKEY,ENTEC))+ENTIME
 Q
 ;ENBCPM6
