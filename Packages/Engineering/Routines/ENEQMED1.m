ENEQMED1 ;WISC/SAB-Multiple Equipment Edit, Continued ;5/19/1998
 ;;7.0;ENGINEERING;**35,39,51**;Aug 17, 1993
FLD ; get fields and values
 ; dic("s") contains national fields that can be edited and also
 ;          allows any local fields (Y>1000) to be selected
 W !
 S DIC="^DD(6914,",DIC(0)="AQE"
 I ENFA D
 . W !,"Note: Some fields can not be modified because one or more of the"
 . W !,"selected equipment items are reported to Fixed Assets (FMS)."
 . S DIC("S")="I Y>1000!(""^1^2^3^4^5^6^10^11^12.5^13.5^14^17^19.5^19.6^20^21^24^25^26^27^33^40^51^52^53^70^""[(U_Y_U))"
 I 'ENFA S DIC("S")="I Y>1000!(""^1^2^3^4^5^6^7^10^11^12^12.5^13^13.5^14^^15^16^17^18^19^19.5^19.6^20^20.1^20.5^21^22^24^25^26^27^31^32^33^34^35^38^40^51^52^53^60^61^62^63^64^70^""[(U_Y_U))"
 D ^DIC K DIC G:$D(DTOUT)!$D(DUOUT) EXIT G:Y'>0 FLDEND
 S ENFLD=+Y,ENFLDN=$P(Y,U,2)
 K ^TMP($J,"ENFLD",ENFLD)
 ; special handling for serial #, nxrn #, va pm number, replacing
 I "^5^17^25^51^"[(U_ENFLD_U) D  G:$D(DIRUT) EXIT G FLD
 . W !,"This option requires that the ",ENFLDN," be individually entered"
 . W !,"for each equipment item."
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Should "_ENFLDN_" be asked for each of the "_ENC("SEL")_" items"
 . D ^DIR K DIR I 'Y W !,ENFLDN," will not be changed." Q
 . S ^TMP($J,"ENFLD",ENFLD)=""
 ; special handling for parent system, location, local identifier
 I "^2^24^26^"[(U_ENFLD_U) D  G:$D(DIRUT) EXIT G:Y FLD
 . W !,ENFLDN," can be individually entered for each equipment item."
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Should "_ENFLDN_" be asked for each of the "_ENC("SEL")_" items"
 . D ^DIR K DIR Q:$D(DIRUT)  I Y S ^TMP($J,"ENFLD",ENFLD)=""
 ; special handling for comments wp
 I "^40^"[(U_ENFLD_U) D  G FLD
 . K ^TMP($J,"ENCOM")
 . S DIC="^TMP($J,""ENCOM"",",DIWESUB="COMMENTS" D EN^DIWE K DIWESUB
 . I $D(^TMP($J,"ENCOM")) S ^TMP($J,"ENFLD",ENFLD)="^TMP($J,""ENCOM"","
 ; special handling for spex wp
 I "^70^"[(U_ENFLD_U) D  G FLD
 . I '$D(^XUSEC("ENEDSPEX",DUZ)) D  Q
 . . W $C(7),!,"Can't edit SPEX. Security key ENEDSPEX is required."
 . K ^TMP($J,"ENSPEX")
 . S DIC="^TMP($J,""ENSPEX"",",DIWESUB="SPEX" D EN^DIWE K DIWESUB
 . I $D(^TMP($J,"ENSPEX")) S ^TMP($J,"ENFLD",ENFLD)="^TMP($J,""ENSPEX"","
 ; special handling fields requiring ENEDNX key
 I 'ENEDNX,ENNX,"^7^12^12.5^18^19^20.1^33^34^35^36^38^52^60^61^62^63^64^"[(U_ENFLD_U) D  G FLD
 . W $C(7),!,ENFLDN," can not be modified because some of the selected"
 . W !,"equipment items are NX and you do not hold security key ENEDNX."
VAL ;
 K DA S DA=ENDAT,DIR(0)="6914,"_ENFLD
 D ^DIR K DIR G:$D(DTOUT) EXIT I $D(DUOUT) W !,ENFLDN," will not be changed." G FLD
 S ENVALI=$P(Y,U)
 S ENVALE=$P($G(Y(0)),U) S:ENVALE']"" ENVALE=$P(Y,U)
 I X="@" D
 . S DIR(0)="Y",DIR("A")="Do you want to delete "_ENFLDN
 . D ^DIR K DIR Q:$D(DIRUT)  I Y S ENVALI="@",ENVALE="(deleted)"
 I ENVALI']"" W !,"You must enter a value (or '^' to skip field)" G VAL
 S ^TMP($J,"ENFLD",ENFLD)=ENVALI_U_ENVALE
 G FLD
FLDEND ;
 ; special handling for PM data
 I $D(^XUSEC("ENEDPM",DUZ)) D  G:$D(DIRUT) EXIT
 . S DIR(0)="Y",DIR("B")="NO"
 . S DIR("A")="Do you want to replace any existing PM data"
 . D ^DIR K DIR Q:$D(DIRUT)!'Y
 . S ENCATI=$P($G(^TMP($J,"ENFLD",6)),U)
 . I ENCATI="" D
 . . S ENC("CAT")=0
 . . F ENI=1:1 S ENL=$P(ENL("SEL"),",",ENI) Q:'ENL  D  Q:ENC("CAT")>1
 . . . I $P(ENL(ENL),U),ENCATI'=$P(ENL(ENL),U) S ENCATI=$P(ENL(ENL),U),ENC("CAT")=ENC("CAT")+1
 . . I ENC("CAT")'=1 S ENCATI=""
 . S ^ENG(6914,ENDAT,1)=ENCATI
 . S DIE=6914,DA=ENDAT,ENXP=2 D XNPMSE^ENEQPMP
 . K ENA,ENB,ENDA,ENDTYP,ENDVTYP,ENSH,ENSHOP
 . S ^TMP($J,"ENFLD",30)=ENDAT
 I '$D(^TMP($J,"ENFLD")) D  G:Y FLD G EXIT
 . W !,"No fields were specified!"
 . S DIR(0)="Y",DIR("A")="Do you want to modify some fields"
 . S DIR("B")="YES" D ^DIR K DIR
 ; get values for individually asked fields (if any)
 S ENASK=0
 S ENFLD=0  F  S ENFLD=$O(^TMP($J,"ENFLD",ENFLD)) Q:'ENFLD!ENASK  I ^(ENFLD)="" S ENASK="1"
 I ENASK W !,"Now enter data for fields which are asked for each item."
 I ENASK S ENDA=0 F  S ENDA=$O(^TMP($J,"ENSEL",ENDA)) Q:'ENDA  D  G:$D(DIRUT) EXIT
 . W !!,"CONTROL #: ",ENDA
 . S ENFLD=0
 . F  S ENFLD=$O(^TMP($J,"ENFLD",ENFLD)) Q:'ENFLD  I ^(ENFLD)="" D  Q:$D(DIRUT)
 . . S ENFLDN=$$GET1^DID(6914,ENFLD,"","LABEL")
 . . S ENGOT=0 F  D  Q:ENGOT!$D(DTOUT)!$D(DUOUT)
 . . . K DA S DA=ENDA S DIR(0)="6914,"_ENFLD
 . . . D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)
 . . . S ENVALI=$P(Y,U)
 . . . S ENVALE=$P($G(Y(0)),U) S:ENVALE']"" ENVALE=$P(Y,U)
 . . . I X="@" D
 . . . . S DIR(0)="Y",DIR("A")="Do you want to delete "_ENFLDN
 . . . . D ^DIR K DIR Q:$D(DIRUT)  I Y S ENVALI="@",ENVALE="(deleted)"
 . . . I ENVALI']"" D  I Y!$D(DIRUT) Q
 . . . . S DIR(0)="Y",DIR("B")="YES"
 . . . . S DIR("A")="Do you want to enter a "_ENFLDN_" for this item"
 . . . . D ^DIR K DIR
 . . . I ENFLD=25,ENVALI]"",ENVALI'="@" D  Q:ENI  ; unique VA PM NUMBER
 . . . . S ENI=0
 . . . . F  S ENI=$O(^TMP($J,"ENFLD",25,ENI)) Q:'ENI  Q:$P($G(^(ENI)),U)=ENVALI
 . . . . I ENI W $C(7),!,"IN USE (Entry Number: ",ENI,")"
 . . . S ^TMP($J,"ENFLD",ENFLD,ENDA)=ENVALI_U_ENVALE
 . . . S ENGOT=1
 G UPD^ENEQMED2
EXIT ;
 G EXIT^ENEQMED2
 ;ENEQMED1
