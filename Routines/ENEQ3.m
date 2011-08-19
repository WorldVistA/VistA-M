ENEQ3 ;WIRMFO/DH,SAB-Equipment Entry Functions ;3.31.98
 ;;7.0;ENGINEERING;**25,29,35,52**;Aug 17, 1993
EQMAS ; Multiple Equipment Subsequent (Similar) Records
 ; in
 ;   ENDAOLD - ien of record to be copied from
 ;   ENMA(   - array containing info on how FA Document and
 ;             incoming inspection w.o. should be handled
 ;   ENBULL( - (optional) array of mail group info
 ; out
 ;   ENNXL   - ien of new record, 0 if unsuccessful
 N EN
 S ENNXL=0
 ; lock master
 L +^ENG(6914,ENDAOLD):10 I '$T D  Q
 . W $C(7),!,"Another user is editing Entry# ",ENDAOLD,". Can't proceed."
 . S DIR(0)="E" D ^DIR K DIR
 ; create new record
 D ENR^ENEQ1 I 'ENNXL D  L -^ENG(6914,ENDAOLD) Q
 . W $C(7),!,ENERR S DIR(0)="E" D ^DIR K DIR,ENERR
 ; lock new record
 L +^ENG(6914,ENNXL):10 I '$T D  L -^ENG(6914,ENDAOLD) Q
 . W $C(7),!,"Another user is editing Entry# ",ENNXL,". Can't proceed."
 . S DIR(0)="E" D ^DIR K DIR
 ;
 ; copy master into local array
 M EN=^ENG(6914,ENDAOLD)
 ; modify local array for new record
 ;   set up .01 and triggered fields
 S $P(EN(0),U)=ENNXL
 S $P(EN(0),U,5,6)=$P(^ENG(6914,ENNXL,0),U,5,6)
 ;   remove data that should not be copied
 I $D(EN(1)) S $P(EN(1),U,3)=""
 I $D(EN(2)) F ENI=7,13 S $P(EN(2),U,ENI)=""
 I $D(EN(3)) F ENI=6,7,10,14 S $P(EN(3),U,ENI)=""
 K EN(6)
 I $D(EN(9)) S $P(EN(9),U,10)=""
 ; move local array to new record
 M ^ENG(6914,ENNXL)=EN K EN
 ; re-index new record
 S DIK="^ENG(6914,",DA=ENNXL D IX1^DIK K DIK
 ; unlock master
 L -^ENG(6914,ENDAOLD)
 ; user edit new record
 W !!,"Equipment ID: ",ENNXL
 S DIE="^ENG(6914,",DR="5;24;25;26",DA=ENNXL
 I $P(^ENG(6914,ENDAOLD,0),U,3)]"" S DR=DR_";2" ; parent system
 I $D(^ENG(6914,ENNXL,8)),$P(^(8),U,8)]"" S DR=DR_";51" ; replacing
 D ^DIE I $D(Y)!$D(DTOUT),$P($G(^ENG(6914,DA,1)),U,3)']"" D  Q
 . W $C(7),!,"Time Out or '^' entered and Serial Number was left blank."
 . W !,"Deleting last entry (",DA,")..."
 . S DIK="^ENG(6914," D ^DIK K DIK L -^ENG(6914,DA)
 . S ENNXL=0
 I $G(ENMA("IIWO")) D IIWO^ENWONEW3(ENNXL)
 I $G(ENMA("FAP")) S ENEQ("DA")=DA D ^ENFAACQ S DA=ENEQ("DA") K ENEQ("DA")
 S DA=ENNXL D BULL
 L -^ENG(6914,ENNXL)
 Q
 ;
BULL ;X-mit new equipment bulletin if mail group established
 ; Input
 ;   DA - ien of equipment entry
 ;   optional ENBULL( - array indicating mail group availabliity
 ;                      undefined nodes not yet evaluated
 ;            ENBULL = true(1) if 'EN NEW EQUIPMENT' established
 ;            ENBULL(station number)=true(1) if
 ;               'EN NEW EQUIPMENT station number' established 
 Q:'$D(DA)  Q:'$D(^ENG(6914,DA,0))
 N ENSN,XMB,XMDUZ,XMY
 ; determine station number of equipment entry
 S ENSN=$$GET1^DIQ(6914,DA,60)
 ; if blank use default station #
 I ENSN="" S ENSN=$$GET1^DIQ(6910,1,1)
 ; get status of station specific mail group if not already done
 I ENSN]"",'$D(ENBULL(ENSN)) S ENBULL(ENSN)=$$CHKMGRP("EN NEW EQUIPMENT "_ENSN)
 ; use station specific mail group if available
 I ENSN]"",ENBULL(ENSN) S XMY("G.EN NEW EQUIPMENT "_ENSN)=""
 ; if station specific mail group not established then use generic group
 I '$D(XMY) D
 . ; get staus of generic mail group if not already done
 . I $G(ENBULL)']"" S ENBULL=$$CHKMGRP("EN NEW EQUIPMENT")
 . I ENBULL S XMY("G.EN NEW EQUIPMENT")=""
 ; send bulletin if a mail group is established
 I $D(XMY) D
 . S XMB="EN NEW EQUIPMENT"
 . S XMB(1)=DA,XMB(2)=$P(^VA(200,DUZ,0),U),XMB(3)=$P(^ENG(6914,DA,0),U,2)
 . F X=4,5 S XMB(X)=""
 . I $D(^ENG(6914,DA,1)) S X=$P(^(1),U) S:X>0 XMB(4)=$P(^ENG(6911,X,0),U)
 . I $D(^ENG(6914,DA,3)) S X=$P(^(3),U,2) S:X>0 XMB(5)=$P(^DIC(49,X,0),U)
 . S:ENSN]"" XMB(6)=ENSN
 . F X=4,5,6 S:XMB(X)="" XMB(X)="MISSING"
 . S X="0^0"
 . I $P($G(^ENG(6914,DA,0)),U,4)="NX",$P($G(^(8)),U,2) S $P(X,U)=1 ;CapNX
 . I $P(X,U),+$$CHKFA^ENFAUTL(DA) S $P(X,U,2)=1 ; FAP
 . S XMB(7)="Item is"_$S($P(X,U):"",1:" NOT")_" capitalized NX."
 . I $P(X,U) S XMB(7)=XMB(7)_" It was"_$S($P(X,U,2):"",1:" NOT")_" reported to FAP."
 . S XMDUZ="AEMS/MERS"
 . D ^XMB
 Q
CHKMGRP(ENMG) ; Check Mail Group Extrinsic Variable
 ; true if mail group exists and has at least one member
 ; Input Variable
 ;   ENMG - name of mail group to check
 N ENI,ENOK,ENQ
 S ENOK=0 ; initialize result flag
 ; look for mail group
 S ENI=$$FIND1^DIC(3.8,"","X",ENMG,"B")
 ; if found look for a member
 I ENI D
 . D LIST^DIC(3.81,","_ENI_",","","",1,"","","","","","ENQ")
 . I $P(ENQ("DILIST",0),U) S ENOK=1 ; has at least one member
 Q ENOK
 ;
LAST ;Last service episode (including PMI)
 ; called by ENG DJ SCREENs
 ; in:  DA - ien of equipment entry
 ; out: displays date and work action of last service episode (if any)
 N ENA,ENB,ENI,ENX
 Q:'$D(DA)
 Q:'$D(^ENG(6914,DA,6))
 S ENI=0 F  S ENI=$O(^ENG(6914,DA,6,ENI)) Q:'ENI  S ENA=^(ENI,0) I $E($P(ENA,U,3))'="D" D  Q
 . S ENX="Last serviced: "_$E(ENA,4,5)_"/"_$E(ENA,6,7)_"/"_$E(ENA,2,3)
 . S ENB=$P($P(ENA,U),"-",2) D:ENB]""  S ENX=ENX_"   Work Action: "_ENB
 . . I $D(^ENG(6920.1,"D",ENB)) S ENB(0)=$O(^(ENB,0))
 . . I $D(ENB(0)),$D(^ENG(6920.1,ENB(0),0)) S ENB=$P(^(0),U)
 . W !!,ENX
 Q
 ;ENEQ3
