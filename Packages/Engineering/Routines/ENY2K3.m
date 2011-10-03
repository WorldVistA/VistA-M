ENY2K3 ;(WASH ISC)/DH-Select Equipment for Y2K Worklist ;5.19.98
 ;;7.0;ENGINEERING;**51**;Aug 17, 1993
 ;  called by ENY2K2
ENTRY ;  select IENs for Y2K worklist
 ;  store in ^TMP($J,
 K ^TMP($J) N NODE,SUB
 S X=$$UP^XLFSTR($E($P($G(^DIC(6922,35,0)),U),1,10)) I X["BIO" S ENY2K("BME")=35
 I '$G(ENY2K("BME")) D
 . S DA=0 F  S DA=$O(^DIC(6922,DA)) Q:'DA!($G(ENY2K("BME")))  S X=$$UP^XLFSTR($E($P(^(DA,0),U),1,10)) I X["BIO" S ENY2K("BME")=DA
 I '$G(ENY2K("BME")) W !!,"Cannot find the BIOMEDICAL ENGINEERING shop. Can't proceed.",*7 G OUT
 S ENSHKEY("SEL")=ENSHKEY
 I ENSHKEY'="ALL" D
 . S DA=0 F  S DA=$O(^ENG(6914,"AK","CC",DA)) Q:'DA  D
 .. Q:'$D(^ENG(6914,DA,11))  S X=^(11)
 .. Q:$P(X,U,2)>ENY2DT  ;check estimated compliance date
 .. I $P(X,U,7)=ENSHKEY S ^TMP($J,ENSHKEY,DA)="" Q
 .. I $P(X,U,7)="" D
 ... S X(1)=$O(^ENG(6914,DA,4,0)) I X(1)>0 S X(2)=$P(^(X(1),0),U) S:X(2)=ENSHKEY ^TMP($J,ENSHKEY,DA)="" Q
 ... I ENSHKEY=ENY2K("BME") S ^TMP($J,ENSHKEY,DA)=""
 I ENSHKEY="ALL" D
 . S DA=0 F  S DA=$O(^ENG(6914,"AK","CC",DA)) Q:'DA  D
 .. Q:'$D(^ENG(6914,DA,11))  S X=^(11)
 .. Q:$P(X,U,2)>ENY2DT  ;check estimated compliance date
 .. I $P(X,U,7) S ^TMP($J,$P(X,U,7),DA)="" Q
 .. S X(1)=$O(^ENG(6914,DA,4,0)) I X(1)>0 S X(2)=$P(^(X(1),0),U),^TMP($J,X(2),DA)="" Q
 .. S ^TMP($J,ENY2K("BME"),DA)=""
 D LST2,PR^ENY2K5
 G OUT
 ;
LST2 N EN,A,B,C,X,TAG
 S ENSHKEY=0 F  S ENSHKEY=$O(^TMP($J,ENSHKEY)) Q:'ENSHKEY  S DA=0 F  S DA=$O(^TMP($J,ENSHKEY,DA)) Q:'DA  D LST3
 Q
 ;
LST3 S X=$P($G(^ENG(6914,DA,3)),U) I "^4^5^"[(U_X_U) Q  ;check use status
 I 'ENSRT("OOS"),X=2 Q  ;is OUT OF SERVICE an issue?
 S EN("NEXT")="A" F X="A","B","C" S @X=""
 I 'ENTECH("ALL"),$P(^ENG(6914,DA,11),U,5)'=ENTECH Q  ;check for assigned tech
 S X=$P(^ENG(6914,DA,11),U,5) I X>0 D
 . I $D(^ENG("EMP",X,0)) S X(1)=""""_$P(^(0),U)_"""" Q
 . S X(1)=""""_"DELETED"_""""
 I X'>0 S X(1)=""""_"UNASSIGNED"_""""
 S @EN("NEXT")=X(1)
 S EN("NEXT")=$C($A(EN("NEXT"))+1)
 S TAG="LST"_ENSRT D @TAG Q:$G(X)=-1
 S SUB="" F X(1)="A","B","C" Q:$G(@X(1))=""  S SUB=SUB_@X(1)_","
 D BLD
 Q
 ;
LSTE ;  By ENTRY NUMBER
 I ENSRT("ALL") Q
 I ENSRT("FR")]DA!(DA]ENSRT("TO")) S X=-1
 Q
LSTP ;  By PM NUMBER
 S X(1)=$P($G(^ENG(6914,DA,3)),U,6) S:X(1)="" X(1)=0
 S:X(1)'=0 X(1)=""""_X(1)_""""
 S @EN("NEXT")=X(1)
 Q
LSTI ;  By LOCAL ID
 S X(1)=$P($G(^ENG(6914,DA,3)),U,7) S:X(1)="" X(1)=0
 S X(2)=$S(X(1)?.N:X(1),1:""""_X(1)_"""")
 I ENSRT("ALL") S @EN("NEXT")=X(2),EN("NEXT")=$C($A(EN("NEXT"))+1)
 E  S X="" D
 . I ENSRT("FR")]X(1)!(X(1)]ENSRT("TO")) S X=-1 Q
 . S @EN("NEXT")=X(2),EN("NEXT")=$C($A(EN("NEXT"))+1)
 I ENSRT("LOC"),$G(X)'=-1 D
 . S X(1)=$$LOC^ENEQPMS8(DA) I X(1)=-1 S X=-1 Q
 . I $P(X(1),U)=-2,ENSRT("LOC","ALL") D
 .. S X(1)=""""_$P(X(1),U,2)_""""
 .. F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 . I $P(X(1),U)=-2 S X=-1 Q
 . I X(1)=-3,ENSRT("LOC","ALL") D
 .. S X(1)=0 F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 . I X(1)=-3 S X=-1 Q
 . S @EN("NEXT")=X(1)
 Q
LSTL ;  By LOCATION
 S X(1)=$$LOC^ENEQPMS8(DA) I X(1)=-1 S X=-1 Q
 I $P(X(1),U)=-2,ENSRT("LOC","ALL") D
 . S X(1)=""""_$P(X(1),U,2)_""""
 . F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 I $P(X(1),U)=-2 S X=-1 Q
 I X(1)=-3,ENSRT("LOC","ALL") D
 . S X(1)=0 F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 I X(1)=-3 S X=-1 Q
 S @EN("NEXT")=X(1)
 Q
LSTC ;  By EQUIPMENT CATEGORY
 S X(2)=$P($G(^ENG(6914,DA,1)),U) S:X(2)="" X(1)=0
 I X(2)>0 S X(1)=$P($G(^ENG(6911,X(2),0)),U) S:X(1)="" X(1)=0
 S:X(1)'?.N X(1)=""""_X(1)_""""
 I 'ENSRT("ALL"),X(2)'=ENSRT("FR") S X=-1 Q
 S @EN("NEXT")=X(1),EN("NEXT")=$C($A(EN("NEXT"))+1)
 I ENSRT("LOC") D
 . S X(1)=$$LOC^ENEQPMS8(DA) I X(1)=-1 S X=-1 Q
 . I $P(X(1),U)=-2,ENSRT("LOC","ALL") D
 .. S X(1)=""""_$P(X(1),U,2)_""""
 .. F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 . I $P(X(1),U)=-2 S X=-1 Q
 . I X(1)=-3,ENSRT("LOC","ALL") D
 .. S X(1)=0 F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 . I X(1)=-3 S X=-1 Q
 . S @EN("NEXT")=X(1)
 Q
LSTS ;  By OWNING SERVICE
 S X(2)=$P($G(^ENG(6914,DA,3)),U,2) S:X(2)="" X(1)=0
 I X(2)>0 S X(1)=$P($G(^DIC(49,X(2),0)),U) S:X(1)="" X(1)=0
 S:X(1)'?.N X(1)=""""_X(1)_""""
 I 'ENSRT("ALL"),X(2)'=ENSRT("FR") S X=-1 Q
 S @EN("NEXT")=X(1),EN("NEXT")=$C($A(EN("NEXT"))+1)
 I ENSRT("LOC") D
 . S X(1)=$$LOC^ENEQPMS8(DA) I X(1)=-1 S X=-1 Q
 . I $P(X(1),U)=-2,ENSRT("LOC","ALL") D
 .. S X(1)=""""_$P(X(1),U,2)_""""
 .. F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 . I $P(X(1),U)=-2 S X=-1 Q
 . I X(1)=-3,ENSRT("LOC","ALL") D
 .. S X(1)=0 F J=1:1:($L(ENSRT("BY"))-1) S X(1)="0,"_X(1)
 . I X(1)=-3 S X=-1 Q
 . S @EN("NEXT")=X(1)
 Q
 ;
BLD ;   build ^TMP global from which to print Y2K worklist
 S NODE="^TMP($J,""ENY2"","_ENSHKEY_","_SUB_DA_")"
 S @NODE=""
 Q
 ;
OUT K K,S,ENPM,ENPMDT,ENA,ENHZS,ENPMWK,ENSHOP,ENSHKEY,ENPMMN,ENSTMN,ENSTYR,ENCRIT,ENSRT,ENTECH,ENY,ENERR,ENMN,ENMNTH,ENI,ENLID
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;ENY2K3
