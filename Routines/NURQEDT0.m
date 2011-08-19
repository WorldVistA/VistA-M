NURQEDT0 ;HIRMFO/MH,RM,YH-EDIT NURQ QI SUMMARY FILE, 217 ;1/22/97  15:30
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ; Entry from Important Functions [NURQA-PT-KEYFUNC] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM(1)
 I DA>0 D E1
 D Q
 Q
E1 ; Edit Important Functions Data
 S DIE="^NURQ(217,"_DA(1)_",2,",DR="2" D ^DIE K DIE,DR
 I $D(Y) S NURQOUT=1
 Q
EN2 ; Entry from Receiver of Results [NURQA-PT-ROFR] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM(0)
 I DA>0 S DA(1)=DA D E2
 D Q
 Q
E2 ; Edit Receiver of Results
 N X,NURQSDA S NURQSDA=DA(1)
 S X=$P($G(^NURQ(217,DA(1),8,+$P($G(^NURQ(217,DA(1),8,0)),U,3),0)),U)
 I X]"" S DIC("B")=X
ROR ; Come back here to edit a new receiver of results.
 S DA(1)=NURQSDA,DLAYGO=217,DIC(0)="AEQL",DIC="^NURQ(217,"_DA(1)_",8,",DIC("P")="217.08" W ! D ^DIC K DIC
 I +Y'>0 S NURQOUT=$S($D(DTOUT)!$D(DUOUT):1,1:0) Q
 S DA=+Y,DIE="^NURQ(217,"_DA(1)_",8,",DR=".01;.02" D ^DIE
 I $D(Y) S NURQOUT=1 Q
 K DIE,DR G ROR
 Q
EN3 ; Entry from Data [NURQA-PT-DATA] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM(0)
 I DA>0 D E3
 D Q
 Q
E3 ; Edit Data
 S DR="5;7.1;6;7.2;7.3",DIE="^NURQ(217," D ^DIE K DIE,DR
 I $D(Y) S NURQOUT=1
 Q
EN4 ; Entry from Survey Generator [NURQA-PT-INDIC] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM(1)
 I DA>0 S DA(2)=DA(1),DA(1)=DA D RELIND^NURQEDT1
 D Q
 Q
EN5 ; Entry from Disciplines [NURQA-PT-RESP] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM(0)
 I DA>0 D E5
 D Q
 Q
E5 ; Edit Disciplines
 S DR="3;2",DIE="^NURQ(217," D ^DIE K DIE,DR
 I $D(Y) S NURQOUT=1
 Q
EN7 ; Entry from References [NURQA-PT-REFR] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM(0)
 I DA>0 D E7
 D Q
 Q
E7 ; Edit References
 S DR="9",DIE="^NURQ(217," D ^DIE K DIE,DR
 I $D(Y) S NURQOUT=1
 Q
EN8 ; Entry from Other QI Summary Data [NURQA-PT-OTHER] option.
 Q:'$$SURGENVR^NURQUTL1(2,1)
 D EDTCOMM(0)
 I DA>0 D E8
 D Q
 Q
E8 ; Edit Other QI Summary Data
 S DR="11",DIE="^NURQ(217," D ^DIE K DIE,DR
 I $D(Y) S NURQOUT=1
 Q
Q ; Clean up and exit
 K DA,NURQOUT,NURQSDA,NSW
 Q
EDTCOMM(NURQIP) ; Select Survey and Location and edit common fields.
 ;  Input Parameters: NURQIP = 0 if just query for survey
 ;                             1 if query for survey and location
 ;  Output variables: NURQOUT = 0 initialize this variable
 ;                     Var.  NURQIP  Value of variable
 ;                     ----  ------  -----------------
 ;                     DA       0    IEN of 217, or -1 if failed
 ;                              1    IEN of 217.04, or -1 if failed
 ;                     DA(1)    0    Not returned.
 ;                              1    IEN of 217, or undefined if failed
 ;
 K DA N NURQWRD,NURDICS,NURDFLT,NURSZLO,Y S NURQOUT=0
 S DIC("A")="Select SURVEY: ",DIC=217,DIC(0)="AELMQ",DLAYGO=217
 D ^DIC K DIC,DLAYGO
 I +Y'>0 S DA=-1 Q
 S DA=+Y,DIE="^NURQ(217,",DR="1///^S X=DUZ" D ^DIE K DIE,DR
 I $D(Y) S DA=-1 Q
 Q:'$G(NURQIP)  S DA(1)=DA S DA=$$GETLOC(DA(1)) I DA<0 K DA(1)
 Q
GETLOC(NURQSURV) ; This function will return a Location (217.04)
 ; multiple IEN.
 ;  Input parameter: NURQSURV = NURQ QI Summary (217) file IEN.
 ;
 N DA S NUROUT=0,DA(1)=NURQSURV
 D GETDF I NUROUT K NUROUT Q -1
 S DIC("S")=NURDICS S:NURDFLT'="" DIC("B")=NURDFLT
 S DIC("A")="Select LOCATION: ",DIC(0)="AEMQ",DIC="^NURSF(211.4,"
 W ! D ^DIC K DIC,NUROUT I +Y'>0 Q -1
 S NURQWRD=$P(Y,U,2) I NURQWRD'>0 Q -1
 S DA=$O(^NURQ(217,DA(1),2,"B",NURQWRD,0)) I DA>0 Q DA
 S X=NURQWRD,DIC="^NURQ(217,"_DA(1)_",2,",DIC(0)="L",DLAYGO=217,DIC("P")="217.04P"
 K DD,DO D FILE^DICN K DIC,DLAYGO S DA=+Y I DA'>0 S DA=-1
 Q DA
GETDF ; This procedure will get the default location (if any) and the
 ; screen for a lookup on Nurs Location.
 ;  Input Variable: DUZ = user doing lookup
 ;  Output Variables:  NURDICS = M code for screen on lookup.
 ;                     NURDFLT = Default location (text) or null if
 ;                               no default exists.
 ;                     NURSZLO( = array of locations set from NURSAUTL.
 ;                     NUROUT = 1 if security not proper, else 0.
 ;
 N X
 D EN1^NURSAUTL I NUROUT G QDF ; needs DUZ
 S NURDICS="I $S('$D(^(""I"")):1,$P(^(""I""),U)=""A"":1,1:0)"_$S(NURSZAP>6:",$D(NURSZLO(Y))",1:""),NURDFLT=""
 I NURSZAP>6,$D(NURSZLO) D
 .  S X=0 F  S X=$O(NURSZLO(X)) Q:X'>0  S NURQ44=$P($G(^NURSF(211.4,X,0)),U),NURQ=$O(^NURQ(217,DA(1),2,"B",NURQ44,0)) I NURQ>0 S NURDFLT=NURQ44 Q
 .  Q
 E  S X=+$P($G(^NURQ(217,DA(1),2,0)),U,3),NURDFLT=+$G(^NURQ(217,DA(1),2,X,0))
 I NURDFLT]"" S X=$P($G(^SC(+NURDFLT,0)),U),NURDFLT=$S($P(X,U)["NUR ":$P($P(X,U),"NUR ",2),1:$P(X,U))
QDF ; Quit GETDF procedure and clean up variables
 K NURSZFAC,NURSZDA,NURSZAP,NURSZSP,NURQ44 ; set by EN1^NURSAUTL
 Q
