ENFAXMTM ;WIRMFO/KLD,SAB-VALIDATE/TRANSMIT FAP EQUIPMENT; 6/9/97
 ;;7.0;ENGINEERING;**25,29,39**;Aug 17, 1993
 ;This routine should not be modified.
ST Q
 ;
EQUIP ;Validite/Transmit FA docs by Equipment
 ; Input
 ;   ENBAT("XMT") - flag; true (1) to transmit after validation
 ;                  not returned
 Q:$G(ENBAT("XMT"))=""  ; required
 W !!,"This option ",$S(ENBAT("XMT"):"TRANSMITS",1:"VALIDATES")," FA Documents (code sheets) for specified equipment.",!
EQUIPA ; ask equipment
 D GETEQ^ENUTL G:Y<1 EQUIPX
 S ENEQ("DA")=+Y
 S X=$$CHKFA^ENFAUTL(ENEQ("DA")) I +X D  G EQUIPA
 . S Y=$P(X,U,2) D DD^%DT S ENFADT("E")=Y
 . W !!,"FA document for ENTRY #",ENEQ("DA")," was processed on ",ENFADT("E"),"."
 . W !,"No action taken.",!,$C(7)
 . K DA,ENFADT,X,Y
 ; set variables for calls to ENFAVAL or ENFAACQ
 S:'ENBAT("XMT") ENFAP("DOC")="FA" ; validate for FA document
 S:ENBAT("XMT") ENBAT("SILENT")="" ; ENFAACQ will save problems in ^TMP
 K ^TMP($J)
 I 'ENBAT("XMT") D  ; validate only
 . F I=0,2,3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 . D ^ENFAVAL
 I ENBAT("XMT") D ^ENFAACQ ; transmit (includes validation)
 ; report results
 I '$D(^TMP($J)) W !!,"Equipment Entry #: ",ENEQ("DA")," ",$S(ENBAT("XMT"):"was transmitted.",1:"looks OK!")
 I $D(^TMP($J)) D LISTP W ! I ENBAT("XMT") W !,"Please correct the Equipment Record before sending a FA Document for this item.",!
 G EQUIPA ; ask for another item
EQUIPX ; exit point for EQUIP
 K DIC,DIR,DIRUT,DUOUT,ENBAT,ENFAP,I,X,Y
 Q
 ;
CMR ;Validite/Transmit FA docs by CMR
 ; Input
 ;   ENBAT("XMT") - flag; true (1) to transmit after validation
 ;                  not returned
 Q:$G(ENBAT("XMT"))=""  ; required
 W !!,"This option ",$S(ENBAT("XMT"):"TRANSMITS",1:"VALIDATES")," FA Documents (code sheets)"
 W !,"for all equipment that belongs to a specified CMR.",!
 ; ask cmr
 S DIC="^ENG(6914.1,",DIC(0)="QEAM" D ^DIC Q:Y<1
 S ENBAT("SEL","I")=+Y ; selected cmr
 ; ask device
 W !,"Now select the device to print results on."
 S %ZIS="Q" D ^%ZIS G:POP CMRX
 I $D(IO("Q")) D  G CMRX
 . S ZTRTN="CMRQ^ENFAXMTM"
 . S ZTDESC=$S(ENBAT("XMT"):"Transmit",1:"Validate")_" FA Doc. by CMR"
 . F I="ENBAT(" S ZTSAVE(I)=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Queued!  Task #",ZTSK K ZTSK
CMRQ ; queued entry point to process cmr
 ; Input
 ;   ENBAT("SEL","I") = ien of selected CMR
 ;   ENBAT("XMT") = flag; when true FA Documents will be transmitted
 ; set variables for calls to ENFAVAL or ENFAACQ
 S:'ENBAT("XMT") ENFAP("DOC")="FA" ; validate for FA document
 S:ENBAT("XMT") ENBAT("SILENT")="" ; ENFAACQ will save problems in ^TMP
 K ^TMP($J)
 S (ENT("BAT"),ENT("BAD"),ENT("FAP"),ENT("SENT"))=0
 ; loop thru equipment on cmr
 S ENEQ("DA")=0
 F  S ENEQ("DA")=$O(^ENG(6914,"AD",ENBAT("SEL","I"),ENEQ("DA"))) Q:'ENEQ("DA")  D
 . Q:'$P($G(^ENG(6914,ENEQ("DA"),8)),U,2)  ; not capitalized
 . S ENT("BAT")=ENT("BAT")+1
 . I +$$CHKFA^ENFAUTL(ENEQ("DA")) S ENT("FAP")=ENT("FAP")+1 Q  ; already
 . I 'ENBAT("XMT") D  ; validate only
 . . F I=0,2,3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 . . D ^ENFAVAL
 . I ENBAT("XMT") D ^ENFAACQ ; transmit (includes validation)
 ; report results
 S ENBAT("TYPE")="CMR"
 S ENBAT("SEL","E")=$P($G(^ENG(6914.1,ENBAT("SEL","I"),0)),U) ; cmr name
 D RPTB
CMRX ; exit point for CMR
 K DIC,ENBAT,ENFA,ENFAP,X,Y
 Q
 ;
STN ;Validite/Transmit FA Docs by Station
 ; Input
 ;   ENBAT("XMT") - flag; true (1) to transmit after validation
 ;                  not returned
 Q:$G(ENBAT("XMT"))=""  ; required
 W !!,"This option ",$S(ENBAT("XMT"):"TRANSMITS",1:"VALIDATES")," FA Documents (code sheets)"
 W !,"for all equipment that belongs to a specified Station.",!
 ; ask station
 S DIR(0)="F^3:5",DIR("A")="STATION NUMBER"
 S DIR("B")=$$GET1^DIQ(6910,"1,",1)
 D ^DIR K DIR G:$D(DIRUT) STNX
 S ENBAT("SEL","I")=Y ; selected station
 ; ask device
 W !,"Now select the device to print results on."
 S %ZIS="Q" D ^%ZIS G:POP STNX
 I $D(IO("Q")) D  G STNX
 . S ZTRTN="STNQ^ENFAXMTM"
 . S ZTDESC=$S(ENBAT("XMT"):"Transmit",1:"Validate")_" FA Doc. by Station"
 . F I="ENBAT(" S ZTSAVE(I)=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"Queued!  Task #",ZTSK K ZTSK
STNQ ; queued entry point to process station
 ; Input
 ;   ENBAT("SEL","I") =  selected Station Number (3-5 characters)
 ;   ENBAT("XMT") = flag; when true FA Documents will be transmitted
 ; set variables for calls to ENFAVAL or ENFAACQ
 S:'ENBAT("XMT") ENFAP("DOC")="FA" ; validate for FA document
 S:ENBAT("XMT") ENBAT("SILENT")="" ; ENFAACQ will save problems in ^TMP
 K ^TMP($J)
 S (ENT("BAT"),ENT("BAD"),ENT("FAP"),ENT("SENT"))=0
 ; loop thru equipment on station
 S ENSND=$$GET1^DIQ(6910,"1,",1) ; default station number
 S ENEQ("DA")=0
 F  S ENEQ("DA")=$O(^ENG(6914,ENEQ("DA"))) Q:'ENEQ("DA")  D
 . Q:'$P($G(^ENG(6914,ENEQ("DA"),8)),U,2)  ; not capitalized
 . S ENSN=$P($G(^ENG(6914,ENEQ("DA"),9)),U,5) S:ENSN="" ENSN=ENSND
 . Q:ENSN'=ENBAT("SEL","I")  ; not station
 . Q:$$GET1^DIQ(6914,ENEQ("DA"),19)']""  ; not on a CMR
 . ; included in batch
 . S ENT("BAT")=ENT("BAT")+1
 . I +$$CHKFA^ENFAUTL(ENEQ("DA")) S ENT("FAP")=ENT("FAP")+1 Q  ; already
 . I 'ENBAT("XMT") D  ; validate only
 . . F I=0,2,3,8,9 S ENEQ(I)=$G(^ENG(6914,ENEQ("DA"),I))
 . . D ^ENFAVAL
 . I ENBAT("XMT") D ^ENFAACQ ; transmit (includes validation)
 ; report results
 S ENBAT("TYPE")="STATION"
 S ENBAT("SEL","E")=ENBAT("SEL","I")
 D RPTB
 ;
STNX ; exit point for STN
 K DIC,ENBAT,ENFA,ENFAP,ENSN,ENSND,X,Y
 Q
 ;
RPTB ; Report of Batch Validate/Transmit FA Documents for Equipment
 ; Input - required
 ;   ENBAT("TYPE") = type of batch (CMR or STATION)
 ;   ENBA("SEL","E") = value specified (either a CMR or STATION NUMBER)
 ;   ENT("BAT") = count of equipment in batch (meets basic criteria)
 ;   ENT("FAP") = count of batch items already established in FAP
 ;   ENBAT("XMT") = flag (0 or 1), true for transmit options
 ; Input - optional
 ;   ^TMP($J,"BAD",equip entry #,line number) = validation problem
 ; Output
 ;   Kills ^TMP($J
 U IO
 S (END,ENPG)=0 D NOW^%DTC S Y=% D DD^%DT S ENFA("NOW")=Y
 D RPTBHD
 ; count batch items which failed validation
 S I=0 F  S I=$O(^TMP($J,"BAD",I)) Q:I'>0  S ENT("BAD")=ENT("BAD")+1
 S ENT("SENT")=ENT("BAT")-(ENT("FAP")+ENT("BAD"))
 ; summarize validate/transmit results
 W !!,+ENT("BAT")_" records have been processed from ",ENBAT("TYPE")
 W ": ",ENBAT("SEL","E")_"."
 W !!,ENT("SENT")_" record",$S(ENT("SENT")=1:" ",1:"s ")
 W $S('ENBAT("XMT"):"would have been",1:$S(ENT("SENT")=1:"was",1:"were"))_" sent to FAP."
 W !,ENT("FAP")_$S('ENBAT("XMT"):" would not have been",1:$S(ENT("FAP")=1:" was not",1:" were not"))_" sent due to already being established in FAP."
 W !,ENT("BAD")_$S('ENBAT("XMT"):" would not have been",1:$S(ENT("BAD")=1:" was not",1:" were not"))_" sent due to validation problems."
 ; detailed validation problems
 I ENT("BAD")>0 D
 . W !!,"Equipment Records not sent because of validation problems: "
 . W !!,"Entry #",?24,"Reason"
 . S I=0 F  S I=$O(^TMP($J,"BAD",I)) Q:'I  D  Q:END
 . . S II=0 F  S II=$O(^TMP($J,"BAD",I,II)) Q:'II  D  Q:END
 . . . I $Y+4>IOSL D RPTBHD Q:END  W !!,"Entry #",?24,"Reason"
 . . . W !,$J(I,11),"        ",^TMP($J,"BAD",I,II)
 . . W !
 I 'END,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR
 K ^TMP($J),DIR,DIROUT,DIRUT,DTOUT,DUOUT,I,II,X,Y
 K END,ENEQ,ENFA,ENFAP,ENPG,ENT
 S:$D(ZTQUEUED) ZTREQ="Q"
 D ^%ZISC
 Q
RPTBHD ; header for FA batch validate/transmit report
 I $E(IOST,1,2)="C-",ENPG S DIR(0)="E" D ^DIR I 'Y S END=1 Q
 I $E(IOST,1,2)="C-"!ENPG W @IOF
 S ENPG=ENPG+1
 W !,"FA DOCUMENT ",$S(ENBAT("XMT"):"TRANSMISSION",1:"VALIDITY CHECK")
 W " FOR ",ENBAT("TYPE"),": ",ENBAT("SEL","E")
 W ?49,ENFA("NOW"),?72,"page ",ENPG
 Q
LISTP ; List Problems with Equipment/Document
 ; Called from various FAP Document routines
 ; Input
 ;   ENEQ("DA") - equipment entry #
 ;   ^TMP($J,"BAD",ENEQ("DA")) - number of problems
 ;   ^TMP($J,"BAD",ENEQ("DA"),seqn #) - description of a problem
 ;   ENBAT("XMT") - optional, flag; true when transmitting (for FA only)
 ; Output
 ;   Problems are listed to the screen
 ;   ^TMP($J is killed
 N I
 W $C(7),!!,"This record "_$S($G(ENBAT("XMT"))=0:"would not have been",1:"was not")_" sent to FAP!"
 W !,"Reason" W:^TMP($J,"BAD",ENEQ("DA"))>1 "s" W ":"
 F I=1:1:^TMP($J,"BAD",ENEQ("DA")) W !?2,^TMP($J,"BAD",ENEQ("DA"),I)
 K ^TMP($J)
 Q
 ;ENFAXMTM
