LEXQDRG ;ISL/KER - Query - DRG Calc. ;12/19/2014
 ;;2.0;LEXICON UTILITY;**86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^XTMP(ID)           SACC 2.3.2.5.2
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    ^ICDDRG             ICR    371
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Non-Namespaced variables used
 ; 
 ;   ICDDATE    Effective Date                         nnnnnnn
 ;   ICDEXP     Patient died during episode of care    1/0
 ;   ICDTRS     Was patient transferred to acute care  1/0
 ;   ICDDMS     Patient discharged against med advice  1/0
 ;   SEX        Patient's Sex (pre-surgical)           M/F
 ;   AGE        Patient's Age                          Numeric
 ;   ICDDX(1)   ICD Principal Diagnosis file 80        IEN
 ;   ICDDX(n)   ICD Secondary Diagnosis file 80        IENs
 ;   ICDPRC(n)  ICD Procedures file 80.1               IENs
 ;   ICDPOA(n)  Presence on Admission     (Y,N,W,U or BLANK)
 ; 
EN ; Main Entry Point
 N AGE,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ICDDATE,ICDDMS,ICDDRG,ICDDX,ICDEXP,ICDPOA
 N ICDPRC,ICDTRS,LEX,LEXB,LEXBG,LEXC,LEXCUR,LEXENV,LEXF,LEXGDAT,LEXHAS
 N LEXI,LEXID,LEXIEN,LEXIT,LEXLS,LEXN,LEXOK,LEXPTF,LEXS,LEXV,LEXX,SEX,X,Y
 S LEXENV=$$EV Q:'$L(LEXENV)
 S U="^",(LEXOK,LEXPTF,LEXCUR)=0 S:$D(LEXDEV) LEXPTF=$$PAT
 I +LEXPTF'>0,$L($P(LEXPTF,"^",2)) W !!,"   ",$P(LEXPTF,"^",2) Q
 I LEXPTF>0 D EN^LEXQDRG3  Q
 S LEXHAS=$$HASPRE^LEXQDRG2 S:LEXHAS>0 LEXCUR=$$UC S:LEXCUR>0 LEXOK=$$GETPRE^LEXQDRG2
 I LEXCUR>0,LEXOK'>0,$L($P(LEXOK,"^",2)) W !!,"   ",$P(LEXOK,"^",2) Q
 I LEXCUR>0,LEXOK'>0 W !!,"   Missing or invalid input variables" Q
 S:LEXCUR'>0 LEXOK=$$ASK I +LEXOK'>0 D  Q
 . I $L($P(LEXOK,"^",2)) W !!,"   ",$P(LEXOK,"^",2) Q
 . W !!,"   Missing or invalid input variables"
 D ^ICDDRG I +($G(ICDDRG))>0 D
 . W:$L($G(IOF)) @IOF D DCD^LEXQDRG4,WRT^LEXQDRG4($G(ICDDRG),$G(ICDDATE))
 Q
UC(X) ; Use Previously Saved Values
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXN,LEXV,Y
 S LEXID="LEXQDRG "_$G(DUZ)_" UC"
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60)
 S DIR(0)="YAO",DIR("A")=" Use previously saved values:  (Y/N)  "
 S (X,DIR("PRE"))="S X=$$UCP^LEXQDRG($G(X))"
 S LEXB=$G(^XTMP(LEXID,"UC")) S:$L(LEXB) DIR("B")=LEXB
 D ^DIR Q:$D(DTOUT) "-1^'Use previously saved values' selection timed-out"
 I $D(DIROUT)!($D(DIRUT))!($D(DUOUT)) D  Q X
 . S X="-1^'Use previously saved values' selection aborted"
 S:"^0^1^"'[("^"_Y_"^") Y="^"
 Q:"^0^1^"'[("^"_Y_"^") "-1^'Use previously saved values' selection aborted"
 S X=Y,LEXV=$S(Y="0":"No",Y="1":"Yes",1:"") I $L(LEXV) D
 . S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Use Previous"
 . S ^XTMP(LEXID,"UC")=LEXV
 Q X
UCP(X) ; Use Previously Saved Values (Preprocess)
 S X=$G(X) Q:'$L(X) ""  Q:X["?" "??"
 I $G(DIR(0))["YAO",$E(X,1)'="^","^Y^N^"'[("^"_$$UP^XLFSTR($E(X,1)_"^")) Q "??"
 Q X
ASK(X) ; Ask for input parameters
 N LEXIMP S LEXIMP=$$IMPDATE^LEXU(30)
 S X=$$EFF^LEXQDRG3 Q:X'?7N X S (LEXGDAT,ICDDATE)=X
 I ICDDATE<LEXIMP S X=$$AGE Q:X'?1N.N!(X["^") X S AGE=X
 S X=$$SEX Q:"^M^F^"'[("^"_X_"^") X S SEX=X
 S X=$$EXP Q:"^1^0^"'[("^"_X_"^") X S ICDEXP=X
 S:$G(ICDEXP)>0 (ICDDMS,ICDTRS)=0
 I $G(ICDEXP)'>0 S X=$$DMS Q:"^1^0^"'[("^"_X_"^") X S ICDDMS=X
 I $G(ICDEXP)'>0 S X=$$TRS Q:"^1^0^"'[("^"_X_"^") X S ICDTRS=X
 K ICDDX W ! S X=$$PDX^LEXQDRG2(ICDDATE) Q:+X'>0 X  W ! S X=$$SEC^LEXQDRG2(ICDDATE) Q:+X'>0 X
 K ICDDX("B") K ICDPRC W ! S X=$$PRO^LEXQDRG2(ICDDATE) Q:+X'>0 X  K ICDPRC("B")
 Q 1
AGE(X) ;   What is the patient's age
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXN,LEXX,Y
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" AGE"
 S LEXB=$G(^XTMP(LEXID,"PRE")) S:LEXB>0 DIR("B")=LEXB
 S DIR(0)="NOA^0:124:0",DIR("A")=" Enter the patient's age:  (0-124)  "
 S (DIR("?"),DIR("??"))="^D AGEH^LEXQDRG"
 S DIR("PRE")="S:X[""?"" X=""??"" S LEXX=X"
 D ^DIR Q:X["^"!($D(DIROUT))!($D(DIRUT))!($D(DTOUT))!($D(DUOUT)) "^"
 W:'$L($G(LEXX))&(+Y>0)&(+Y<125) +Y," year",$S(X>1:"s",1:"")," old"
 W:$L($G(LEXX))&(+Y>0)&(+Y<125) " year",$S(X>1:"s",1:"")," old"
 I +Y>0 S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=Y
 S X=Y
 Q X
AGEH ;   What is the patient's age Help
 W !,"   Enter the patient's age, 0-124."
 Q
SEX(X) ;   What is the sex of the patient
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXN,Y
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" SEX"
 S LEXB=$G(^XTMP(LEXID,"PRE")) S:'$L(LEXB) LEXB="Male"
 S LEXB=$S(LEXB="M":"Male",LEXB="F":"Female",1:"") S:$L(LEXB) DIR("B")=LEXB
 S DIR(0)="SAO^M:Male;F:Female",DIR("A")=" Enter the patient's sex:  (M/F)  "
 S (DIR("??"),DIR("?"))="^D SEXH^LEXQDRG"
 S DIR("PRE")="S X=$$UP^XLFSTR(X) S:$E(X,1)'=""M""&($E(X,1)'=""F"")&($L(X)) X=""??"" S:X[""?"" X=""??"""
 D ^DIR Q:X["^"!($D(DIROUT))!($D(DIRUT))!($D(DTOUT))!($D(DUOUT)) "^"
 I "^M^F^"[("^"_Y_"^") S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=Y
 S X=Y
 Q X
SEXH ;   What is the sex of the patient Help
 W !,"   Answer M for Male or F for Female."
 Q
DMS(X) ;   Discharged against medical advice
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXN,Y
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" DMS"
 S LEXB=$G(^XTMP(LEXID,"PRE")),LEXB=$S(LEXB="1":"YES",LEXB="0":"NO",1:"") S:$L(LEXB) DIR("B")=LEXB
 S DIR(0)="YAO",DIR("A")=" Was the patient discharged against medical advice?  (Y/N)  "
 S DIR("?")="   Answer YES if the patient was discharged against medical advice."
 S DIR("PRE")="S:X[""?"" X=""?""" D ^DIR
 Q:$D(DTOUT) "0^'Discharged against medical advice' selection timed-out"
 I $D(DIROUT)!($D(DIRUT))!($D(DUOUT))!("^1^0^"'[("^"_Y_"^")) D  Q X
 . S X="0^'Discharged against medical advice' selection aborted"
 I "^1^0^"[("^"_Y_"^") S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=Y
 S X=Y
 Q X
TRS(X) ;   Was the patient transferred to acute care
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXN,Y
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" TRS"
 S LEXB=$G(^XTMP(LEXID,"PRE")),LEXB=$S(LEXB="1":"YES",LEXB="0":"NO",1:"") S:$L(LEXB) DIR("B")=LEXB
 S DIR(0)="YAO",DIR("A")=" Was the patient transferred to an acute care facility?  (Y/N)  "
 S DIR("?")="   Answer YES if the patient was transferred to an acute care facility."
 S DIR("PRE")="S:X[""?"" X=""?"""
 D ^DIR Q:$D(DTOUT) "0^'Was the patient transferred to acute care' selection timed-out"
 I $D(DIROUT)!($D(DIRUT))!($D(DUOUT))!("^1^0^"'[("^"_Y_"^")) D  Q X
 . S X="0^'Was the patient transferred to acute care' selection aborted"
 I "^1^0^"[("^"_Y_"^") S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=Y
 S X=Y
 Q X
EXP(X) ;   Did the patient die during episode of care
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXN,Y
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" EXP"
 S LEXB=$G(^XTMP(LEXID,"PRE")),LEXB=$S(LEXB="1":"YES",LEXB="0":"NO",1:"") S:$L(LEXB) DIR("B")=LEXB
 S DIR(0)="YAO",DIR("A")=" Did the patient die during this episode of care?    (Y/N)  "
 S DIR("?")="   Answer YES if the patient died during this episode of care."
 S DIR("PRE")="S:X[""?"" X=""?""" D ^DIR
 Q:$D(DTOUT) "0^'Did the patient die during episode of care' selection timed-out"
 I $D(DIROUT)!($D(DIRUT))!($D(DUOUT))!("^1^0^"'[("^"_Y_"^")) D  Q X
 . S X="0^'Did the patient die during episode of care' selection aborted"
 I "^1^0^"[("^"_Y_"^") S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=Y
 S X=Y
 Q X
PAT(X) ;   Patient
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXN,Y
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" PAT"
 S LEXB=$G(^XTMP(LEXID,"PRE")),LEXB=$S(LEXB="1":"YES",1:"NO") S:$L(LEXB) DIR("B")=LEXB
 S DIR(0)="YAO",DIR("A")=" Calculate DRGs for a Registered Patient?  (Y/N)  "
 S DIR("?")="Enter 'Yes' if the patient has been previously registered, enter 'No' for other patient."
 S DIR("PRE")="S:X[""?"" X=""?""" D ^DIR
 Q:$D(DTOUT) "0^'Calculate DRGs for a Registered Patient' selection timed-out"
 I $D(DIROUT)!($D(DIRUT))!($D(DUOUT))!("^1^0^"'[("^"_Y_"^")) D  Q X
 . S X="0^'Calculate DRGs for a Registered Patient' selection aborted"
 I "^1^0^"[("^"_Y_"^") S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=Y
 S X=Y
 Q X
SXTMP ;   Show ^XTMP DX/PR
 N LEXSYS F LEXSYS="ICD","ICP","10D","ICP" D
 . N LEXCT,LEXIN S LEXCT=0
 . F LEXIN=1:1:10 D
 . . N LEXNN,LEXNC,LEXID
 . . S LEXID="LEXQDRG "_+($G(DUZ))_" DX"_LEXIN_" "_LEXSYS
 . . S LEXNN="^XTMP("""_LEXID_""")",LEXNC="^XTMP("""_LEXID_""","
 . . F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . . . S LEXCT=LEXCT+1 W:LEXCT=1 ! W !,LEXNN,"=",@LEXNN
 . F LEXIN=1:1:10 D
 . . N LEXNN,LEXNC,LEXID S LEXID="LEXQDRG "_+($G(DUZ))_" PR"_LEXIN_" "_LEXSYS
 . . S LEXNN="^XTMP("""_LEXID_""")",LEXNC="^XTMP("""_LEXID_""","
 . . F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . . . S LEXCT=LEXCT+1 W:LEXCT=1 ! W !,LEXNN,"=",@LEXNN
 W !
 Q
EV(X) ;   Check environment
 N LEX,LEXDEV S DT=$$DT^XLFDT D HOME^%ZIS S U="^" I +($G(DUZ))=0 W !!,?5,"DUZ not defined" Q 0
 S LEX=$$GET1^DIQ(200,(DUZ_","),.01) I '$L(LEX) W !!,?5,"DUZ not valid" Q 0
 Q 1
