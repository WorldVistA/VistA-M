GMPLEDT2 ; SLC/MKB/KER -- Problem List edit actions ; 04/15/2002
 ;;2.0;Problem List;**26,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10003  ^%DT
 ;   DBIA 10006  ^DIC
 ;   DBIA 10026  ^DIR
 ;   DBIA 10103  $$HTFM^XLFDT
 ;   DBIA 10104  $$UP^XLFSTR
 ;                   
EDITED() ; Returns 1 if problem has been altered
 N FLD,NOTE,DIFFRENT S DIFFRENT=0
 F FLD=0:0 S FLD=$O(GMPORIG(FLD)) Q:(FLD'>0)!(FLD'<10)  I GMPORIG(FLD)'=GMPFLD(FLD) S DIFFRENT=1 Q
 G:DIFFRENT EDQ
 I $D(GMPFLD(10,"NEW"))>9 S DIFFRENT=1 G EDQ
 F NOTE=0:0 S NOTE=$O(GMPORIG(10,NOTE)) Q:NOTE'>0  I $P(GMPORIG(10,NOTE),U,3)'=$P(GMPFLD(10,NOTE),U,3) S DIFFRENT=1 Q
EDQ Q DIFFRENT
 ;
SUREDEL(NUM) ; -- sure you want to delete problems?
 N DIR,X,Y
 W !!,"CAUTION:  "_$S(NUM=1:"This problem",1:"These "_NUM_" problems")_" will be completely removed",!,"          from this patient's list!!",!
 S DIR(0)="YA",DIR("A")="Are you sure? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to delete "_$S(NUM=1:"this problem",1:"these problems")_" from the current patient's list."
 S DIR("?",2)="DO NOT use this option to remove problems from your currently"
 S DIR("?")="displayed view of the Problem List!!"
 W $C(7) D ^DIR
 Q +Y
 ;
DELETE ; Remove current problem from patient's list
 N CHNGE S VALMBCK=$S(VALMCC:"",1:"R") Q:'$$SUREDEL(1)
 S CHNGE=GMPIFN_"^1.02^"_$$HTFM^XLFDT($H)_U_DUZ_"^P^H^Deleted^"_+$G(GMPROV) W "."
 S $P(^AUPNPROB(GMPIFN,1),U,2)="H",GMPSAVED=1,VALMBCK="Q" W "."
 D AUDIT^GMPLX(CHNGE,""),DTMOD^GMPLX(GMPIFN) W "."
 W "... removed!",!!,"Returning to Problem List.",! H 1
 Q
 ;
VERIFY ; Mark current problem as verified
 I GMPFLD(1.02)'="T" W $C(7),!!,"This problem does not require verification.",! H 1 Q
 S GMPFLD(1.02)="P" W !,"."
 W "... verified!" H 1
 Q
 ;
NPERSON ; look up into #200, given PROMPT,HELPMSG,DEFAULT (returns X, Y)
 N DIC
NP W !,PROMPT_$S(+DEFAULT:$P(DEFAULT,U,2)_"//",1:"")
 R X:DTIME S:'$T DTOUT=1 I $D(DTOUT)!(X="^") S GMPQUIT=1 Q
 I X?1"^".E D JUMP^GMPLEDT3(X) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G NP
 I X="" S Y=DEFAULT Q
 I X="@" G:'$$SURE^GMPLX NP S Y="" Q
 I X="?" W !!,HELPMSG,! G NP
 I X["??" D NPHELP G NP
 S DIC="^VA(200,",DIC(0)="EMQ" D ^DIC
 I Y'>0 W !!,HELPMSG,!,$C(7) G NP
 Q
 ;
NPHELP ; List names in New Person file
 N NM,CNT,I,Y S CNT=0,(NM,Y)="" W !,"Choose from: "
 F  S NM=$O(^VA(200,"B",NM)) Q:NM=""  D  Q:Y'=""
 . S CNT=CNT+1 I '(CNT#9) D  Q:Y="^"
 . . W "      ... more, or ^ to stop: " R Y:DTIME S:'$T Y="^"
 . S I=$O(^VA(200,"B",NM,0)) W !,"   "_$P($G(^VA(200,I,0)),U)
 W !
 Q
 ;
DATE ; Edit date fields given PROMPT,HELPMSG,DEFAULT (ret'ns X,Y)
 N %DT S %DT="EP"
D1 W !,PROMPT_$S(+DEFAULT:$P(DEFAULT,U,2)_"//",1:"")
 R X:DTIME S:'$T DTOUT=1 I $D(DTOUT)!(X="^") S GMPQUIT=1 Q
 I X?1"^".E D JUMP^GMPLEDT3(X) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G D1
 I X="" S Y=DEFAULT Q
 I X="@" G:'$$SURE^GMPLX D1 S Y="" Q
 I X="?" W !!,HELPMSG,! G D1
 I X["??" D DTHELP G D1
 D ^%DT I Y<1 W "  INVALID DATE" D DTHELP W !,HELPMSG G D1
 I Y>DT W !!,"Date cannot be in the future!",!,$C(7) G D1
 Q
 ;
DTHELP ; Date help
 W !!,"Examples of valid dates:"
 W !,"   Jan 20 1957 or 20 Jan 57 or 1/20/57 or 012057"
 W !,"   T   (for TODAY),  T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc."
 W !,"You may omit the precise day, such as Jan 1957, or"
 W !,"If the year is omitted, a date in the PAST will be assumed.",!
 Q
 ;
SPEXP ; Edit Fields 1.11, 1.12, 1.13, 1.15, 1.16, 1.17, 1.18
 D:GMPAGTOR SP(1.11,"Agent Orange") Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S:$G(GMPFLD(1.11)) $P(GMPFLD(1.11),U,2)="AGENT ORANGE"
 D:GMPION SP(1.12,"Radiation") Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S:$G(GMPFLD(1.12)) $P(GMPFLD(1.12),U,2)="RADIATION"
 D:GMPGULF SP(1.13,"Environmental Contaminants") Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S:$G(GMPFLD(1.13)) $P(GMPFLD(1.13),U,2)="ENV CONTAMINANTS"
 D:GMPHNC SP(1.15,"Head and/or Neck Cancer") Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S:$G(GMPFLD(1.15)) $P(GMPFLD(1.15),U,2)="HEAD/NECK CANCER"
 D:GMPMST SP(1.16,"Military Sexual Trauma") Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S:$G(GMPFLD(1.16)) $P(GMPFLD(1.16),U,2)="MIL SEXUAL TRAUMA"
 D:GMPCV SP(1.17,"Combat Veteran") Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S:$G(GMPFLD(1.17)) $P(GMPFLD(1.17),U,2)="COMBAT VET"
 D:GMPSHD SP(1.18,"Shipboard Hazard and Defense") Q:$D(GMPQUIT)!($G(GMPLJUMP))
 S:$G(GMPFLD(1.18)) $P(GMPFLD(1.18),U,2)="SHAD"
 Q
SP(FLD,NAME) ; edit exposure fields -- Requires FLD number & field NAME
 N DIR,X,Y,GMPLN S DIR(0)="YAO",GMPLN=$$UP^XLFSTR(NAME)
 S DIR("A")="Is this problem related to "_GMPLN
 S:GMPLN'["SEXUAL"&(GMPLN'["CANCER") DIR("A")=DIR("A")_" EXPOSURE" S DIR("A")=DIR("A")_"? "
 S DIR("?",1)="Enter YES if this problem is related in some way to the patient's"
 S DIR("?")="diagnosed "_NAME_"." S:GMPLN["SEXUAL" DIR("?")="reported "_NAME_"." S:GMPLN'["SEXUAL"&(GMPLN'["CANCER") DIR("?")="exposure to "_NAME_"."
 S:$L($G(GMPFLD(FLD))) DIR("B")=$S(+GMPFLD(FLD):"YES",1:"NO")
SP1 D ^DIR I $D(DTOUT)!(Y="^") S GMPQUIT=1 Q
 I Y?1"^".E D JUMP^GMPLEDT3(Y) Q:$D(GMPQUIT)!($G(GMPLJUMP))  K:$G(GMPIFN) GMPLJUMP G SP1
 I X="@" G:'$$SURE^GMPLX SP1 S Y=""
 S GMPFLD(FLD)=Y S:Y'="" GMPFLD(FLD)=GMPFLD(FLD)_U_$S(Y:"YES",1:"NO")
 Q
