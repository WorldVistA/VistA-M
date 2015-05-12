LEXQDRG3 ;ISL/KER - Query - DRG Calc. (DGPT) ;12/19/2014
 ;;2.0;LEXICON UTILITY;**86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^XTMP(ID)           SACC 2.3.2.5.2
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$FIND1^DIC         ICR   2051
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    ^ICDDRG             ICR    371
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; ICDDATE     Date
 ; ICDEXP      Patient died during episode of care        1/0
 ; ICDTRS      Was patient transferred to acute care      1/0
 ; ICDDMS      Patient discharged against medical advice  1/0
 ; SEX         Patient's Sex (pre-surgical                M/F
 ; AGE         Patient's Age                              Numeric
 ; 
 ; ICDDX(1)    Array of ICD Principal Diagnosis
 ; ICDDX(n)    Array of ICD Secondary Diagnosis
 ; ICDPRC(n)   Array of ICD Procedures
 ; 
EN ; Main Entry Point
 N AGE,DFN,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ICDDATE,ICDDMS,ICDDRG,ICDDX,ICDEXP
 N ICDPRC,ICDTRS,LEX1,LEXB,LEXC,LEXCODE,LEXD,LEXDCH,LEXDES,LEXDFN,LEXDOB
 N LEXDRG,LEXDT,LEXDX,LEXLEXP,LEXF,LEXFL,LEXFLG,LEXGDAT,LEXI,LEXI1,LEXI2,LEXI3
 N LEXID,LEXIEN,LEXIENS,LEXIPT,LEXIT,LEXMN,LEXMNE,LEXMX,LEXMXE,LEXN,LEXNAM
 N LEXOK,LEXOUT,LEXPDX,LEXPR,LEXPR1,LEXPRDT,LEXPRE,LEXPRS,LEXPTF,LEXSCC
 N LEXSDX,LEXSR,LEXSR1,LEXSRDT,LEXSRS,LEXT,LEXTD,LEXTMP,LEXVAP,SEX,X,Y
 S LEXVAP=$$VAP I +LEXVAP'>0,$L($P(LEXVAP,"^",2)) W !!,"   ",$P(LEXVAP,"^",2) Q
 I +LEXVAP'>0 W !!,"   Patient not selected" Q
 S X=$P($$EFF,".",1) I X'?7N,$L($P(X,"^",2)) W !!,"   ",$P(X,"^",2) Q
 I X'?7N W !!,"   'Effective date' missing or invalid" Q
 S (LEXGDAT,ICDDATE)=X,LEXVAP=+($G(LEXVAP)) S LEXOK=$$GETPAT(LEXVAP)
 I LEXOK'>0,$L($P(LEXOK,"^",2)) W !!,"   ",$P(LEXOK,"^",2) Q
 I LEXOK'>0 W !!,"   'Patient treatment information' missing or invalid" Q
 D ^ICDDRG I +($G(ICDDRG))>0 W:$L($G(IOF)) @IOF D DCD^LEXQDRG4,WRT^LEXQDRG4(ICDDRG,ICDDATE)
 Q
EFF(X) ;   Effective date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LEXB,LEXF,LEXID,LEXMN,LEXMNE,LEXMX,LEXMXE,LEXN,Y,LEXIMP
 S LEXIMP=$$IMPDATE^LEXU(30),LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" DATE"
 S LEXB=$P($G(^XTMP(LEXID,"PRE")),".",1) S:LEXB?7N DIR("B")=$$UP^XLFSTR($$FMTE^XLFDT(LEXB,"1D"))
 S LEXMN=2781001,LEXMX=DT S:LEXMX'>LEXIMP LEXMX=LEXIMP S LEXMX=$$FMADD^XLFDT(LEXMX,730)
 S LEXMNE=$$FMTE^XLFDT(+($G(LEXMN)),"1D"),LEXMXE=$$FMTE^XLFDT(+($G(LEXMX)),"1D")
 S LEXMNE=$$UP^XLFSTR(LEXMNE),LEXMXE=$$UP^XLFSTR(LEXMXE) S DIR(0)="DAO^"_LEXMN_":"_LEXMX
 S DIR("?")="^D EFH1^LEXQDRG3" S DIR("??")="^D EFH2^LEXQDRG3"
 S DIR("A")=" Enter the diagnosis effective date:  "
 W:+($G(LEXHAS))'>0&('$D(DFN)) ! D ^DIR Q:$D(DTOUT) "0^'Effective date' selection timed-out"
 I $D(DIROUT)!($D(DIRUT))!($D(DUOUT)) D  Q X
 . S X="0^'Effective date' selection aborted"
 S Y=$P(Y,".",1) Q:Y'?7N "0^Missing or invalid 'effective date'"
 I Y?7N S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=Y N DFN
 S X=Y Q:X?7N X
 Q "0^Invalid 'effective date'"
EFH1 ;   Effective Date Help #1
 W !,"   Enter the effective date of the patient's diagnosis"
 I $L($G(LEXMXE)),$L($G(LEXMNE)) D
 . W !!,"   Select a date from ",LEXMNE," to ",LEXMXE
 Q
EFH2 ;   Effective Date Help #2
 D EFH1 W !
 W !,"   JAN 20 2012 or 20 JAN 12 or 1/20/12 or 012012"
 W !,"   T   (for TODAY),  T+1 (for TOMORROW),  T+2, etc."
 W !,"   T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc."
 W !,"   If the year is omitted, the computer uses CURRENT"
 W !,"   YEAR.  Two digit year assumes no more than 20 "
 W !,"   years in the future, or 80 years in the past."
 W:$L($G(DIR("B"))) !,"   Press return to accept the default date."
 W !,"   Enter ""^"" to abort."
 Q
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
VAP(X) ;   VA Patient File #2
 N DIC,DTOUT,DUOUT,LEXB,LEXDFN,LEXLEXP,LEXF,LEXID,LEXN,LEXNAM,LEXSCC,Y
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" VAP"
 S LEXB=$G(^XTMP(LEXID,"PRE")),LEXB=$$GET1^DIQ(2,(+LEXB_","),.01)
 S DIC="^DPT(",DIC(0)="AEQMZ",DIC("A")=" Select VA Patient:  ",DIC("S")="I +($$VAS^LEXQDRG3)>0"
 D ^DIC Q:$D(DTOUT) "0^'VA Patient' selection timed-out"
 I $D(DUOUT) S X="0^'VA Patient' selection aborted" Q X
 I +Y'>0 S X="0^'VA Patient' not selected" Q X
 S X=Y I +Y>0 S DFN=+Y,^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=+Y
 Q X
VAS(X) ;   VA Patient File #2 Screen (live/service connected)
 N LEXDFN,LEXNAM,LEXLEXP,LEXSCC S LEXDFN=+($G(Y)) Q:LEXDFN'>0 0
 S LEXNAM=$$GET1^DIQ(2,(+($G(Y))_","),.01) Q:'$L(LEXNAM) 0
 S LEXLEXP=$$GET1^DIQ(2,(+($G(Y))_","),.351,"I") Q:+LEXLEXP>0 0
 S LEXSCC=$$GET1^DIQ(2,(+($G(Y))_","),.301,"I") Q:$E(LEXSCC,1)'="Y" 0
 Q 1
 ;
GETPAT(X) ; Get Patient Values
 N LEXDCH,LEXDFN,LEXDOB,LEXNAM,LEXOUT,LEXPTF
 K AGE,ICDDMS,ICDDX,ICDEXP,ICDPRC,ICDTRS,SEX
 S LEXOUT=1,LEXDFN=+($G(X))
 Q:$G(LEXDFN)'>0 "0^Patient (DFN) undefined"
 S LEXNAM=$$GET1^DIQ(2,(+($G(LEXDFN))_","),.01)
 Q:'$L(LEXNAM) "0^Patient (DFN) not found"
 S LEXPTF=$$FIND1^DIC(45,,"B",LEXNAM,"B")
 Q:LEXPTF'>0 "0^Patient Treatment Record not found"
 ;   ICDEXP    Did patient die during care         1/0
 S ICDEXP=$$GET1^DIQ(45,(+($G(LEXPTF))_","),72,"I"),ICDEXP=$S(ICDEXP>5:1,1:0)
 ;   ICDDSM    Discharged against medical advice   1/0
 S ICDDMS=$$GET1^DIQ(45,(+($G(LEXPTF))_","),72,"I"),ICDEXP=$S(ICDDMS=4:1,1:0)
 ;   ICDTRS    Transfer to acute care facility     1/0
 S ICDTRS=$$GET1^DIQ(45,(+($G(LEXPTF))_","),76.2),ICDTRS=$S(ICDEXP:1,1:0)
 ;   SEX       Sex                                 M/F
 S SEX=$$GET1^DIQ(2,(+($G(LEXDFN))_","),.02,"I")
 ;   AGE       Age                                 Numeric
 S LEXDCH=$$GET1^DIQ(45,(+($G(LEXPTF))_","),70,"I")
 S LEXDOB=$$GET1^DIQ(2,(+($G(LEXDFN))_","),.03,"I")
 S AGE=$S(LEXDCH:LEXDCH,1:DT)-LEXDOB\10000
 K LEXDX S LEXDX=$$DX^LEXQDRG4(LEXPTF)
 K LEXSR S LEXSR=$$SR^LEXQDRG4(LEXPTF)
 K LEXPR S LEXPR=$$PR^LEXQDRG4(LEXPTF)
 D ICDDXPR^LEXQDRG4
 S LEXOUT=1 S:"^1^0^"'[("^"_ICDEXP_"^") LEXOUT=-1
 S:"^1^0^"'[("^"_ICDTRS_"^") LEXOUT=-2
 S:"^1^0^"'[("^"_ICDDMS_"^") LEXOUT=-3
 S:"^M^F^"'[("^"_SEX_"^") LEXOUT=-4
 S:AGE'?1N.N LEXOUT=-5
 S:$O(ICDDX(0))'>0 LEXOUT=-6
 K:LEXOUT'>0 AGE,SEX,ICDDMS,ICDDX,ICDEXP,ICDPRC,ICDTRS
 S X=LEXOUT S:X'>0 X="0^Error extracting patient treatment information"
 Q X
