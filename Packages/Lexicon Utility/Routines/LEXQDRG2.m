LEXQDRG2 ;ISL/KER - Query - DRG Calc. (PDX/SDX/PRO/PRE) ;12/19/2014
 ;;2.0;LEXICON UTILITY;**86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^ICD9(              ICR 4485
 ;    ^ICD0(              ICR 4486
 ;    ^XTMP(ID)           SACC 2.3.2.5.2
 ;               
 ; External References
 ;    EN^DDIOL            ICR  10142
 ;    ^DIC                ICR  10006
 ;    $$GET1^DIQ          ICR   2056
 ;    ^DIR                ICR  10026
 ;    $$HAC^ICDEX         ICR   5747
 ;    $$CODEC^ICDEX       ICR   5747
 ;    $$ROOT^ICDEX        ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;               
 ;   ICDDATE   Effective Date                         nnnnnnn
 ;   ICDEXP    Patient died during episode of care    1/0
 ;   ICDTRS    Was patient transferred to acute care  1/0
 ;   ICDDMS    Patient discharged against med advice  1/0
 ;   ICDPOA    Present on Admission                   Y/N/U/W
 ;   SEX       Patient's Sex (pre-surgical            M/F
 ;   AGE       Patient's Age                          Numeric
 ;               
 ; Get Codes
PDX(X) ;   Principal DX
 N DIC,DTOUT,DUOUT,LEXC,LEXF,LEXID,LEXIEN,LEXPDX,LEXN,LEXSYS,LEXPOA,LEXIT,Y,ICDDATE
 S LEXIT=0,ICDDATE=$G(X) Q:$P(ICDDATE,".",1)'?7N "0^Date not Passed"
 S LEXSYS="10D" S:ICDDATE<$$IMPDATE^LEXU(30) LEXSYS="ICD"
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60),LEXID="LEXQDRG "_$G(DUZ)_" DX1"_" "_LEXSYS
 S LEXIEN=$G(^XTMP(LEXID,"PRE")),LEXC=$$CODEC^ICDEX(80,LEXIEN)
 S:$L(LEXC)&(LEXC'["^") DIC("B")=LEXC
 S DIC=$$ROOT^ICDEX(80),DIC(0)="AEQMZI"
 S DIC("A")=" Enter the Principal Diagnosis: "
 S DIC("S")="I '$P($$ICDDX^ICDEX(+Y,$G(ICDDATE),,""I""),U,5),$$ISVALID^ICDEX(80,+Y,$G(ICDDATE))"
 D ^DIC I $G(X)["^^" D
 . S DUOUT=1 N LEXID,LEXB,LEXQ
 . S LEXID="LEXQDRG "_$G(DUZ)_" DX1"_" "_LEXSYS K ^XTMP(LEXID)
 . S LEXBG=2,LEXQ=0 F LEXS=LEXBG:1 D  Q:LEXQ
 . . N LEXID,LEXIEN S LEXID="LEXQDRG "_$G(DUZ)_" DX"_LEXS_" "_LEXSYS
 . . S LEXIEN=$G(^XTMP(LEXID,"PRE")) K:LEXIEN>0 ^XTMP(LEXID) S:LEXIEN'>0 LEXQ=1
 . S LEXBG=1,LEXQ=0 F LEXS=LEXBG:1 D  Q:LEXQ
 . . N LEXID,LEXIEN S LEXID="LEXQDRG "_$G(DUZ)_" PR"_LEXS_" "_LEXSYS
 . . S LEXIEN=$G(^XTMP(LEXID,"PRE")) K:LEXIEN>0 ^XTMP(LEXID) S:LEXIEN'>0 LEXQ=1
 Q:$D(DTOUT) "0^Principal diagnosis selection timed-out"
 Q:$D(DUOUT) "0^Principal diagnosis selection aborted"
 Q:+Y'>0 "0^Missing or invalid principal diagnosis"  S LEXPDX=+Y,LEXPOA="",LEXIT=0
 I LEXSYS="10D",+LEXPDX>0 S LEXPOA=$$POA(+LEXPDX) S:LEXPOA["^" LEXIT=1
 Q:LEXIT "0^Missing or invalid data"
 Q:LEXSYS="10D"&('$L($G(LEXPOA))) "0^Missing POA"
 Q:LEXSYS="10D"&($G(LEXPOA)["^") "0^Invalid POA"
 I +($G(LEXPDX))>0 D  Q 1
 . S ICDDX(1)=+($G(LEXPDX)),ICDDX("B",+($G(LEXPDX)))=1
 . S:$G(LEXSYS)="10D"&($L($G(LEXPOA))) ICDPOA(1)=LEXPOA
 . S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=+($G(LEXPDX))
 Q 0
SEC(X) ;   Seconary DX
 N DIC,DICA,DTOUT,DUOUT,LEXBG,LEXC,LEXF,LEXID,LEXIEN,LEXIT,LEXLS,LEXSYS,LEXN,LEXS,Y,ICDDATE
 S ICDDATE=$G(X) Q:$P(ICDDATE,".",1)'?7N "0^Date not Passed" K DICA
 S LEXSYS="10D" S:ICDDATE<$$IMPDATE^LEXU(30) LEXSYS="ICD"
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60)
 S LEXIT=0,LEXLS=1 F  S LEXLS=$O(ICDDX(LEXLS)) Q:+LEXLS'>0  D
 . N LEXIEN S LEXIEN=$G(ICDDX(LEXLS)) K:+LEXIEN>0 ICDDX("B",+LEXIEN),ICDDX(LEXLS)
 S LEXLS=0 F LEXS=2:1 D  Q:LEXIT
 . S:LEXS>5 LEXIT=1 Q:LEXIT  N DIC,LEXIEN,LEXC,LEXSEC,LEXPOA,LEXIT2
 . S DIC=$$ROOT^ICDEX(80),DIC(0)="AEQMZI"
 . S LEXID="LEXQDRG "_$G(DUZ)_" DX"_LEXS_" "_LEXSYS
 . S LEXIEN=$G(^XTMP(LEXID,"PRE"))
 . S LEXC=$$CODEC^ICDEX(80,LEXIEN) S:$L(LEXC)&(LEXC'["^") DIC("B")=LEXC
 . S DIC("A")=" Enter a Secondary Diagnosis: " S:$L($G(DICA)) DIC("A")=$G(DICA)
 . S DIC("S")="I $$ISVALID^ICDEX(80,+Y,$G(ICDDATE)),'$D(ICDDX(""B"",+Y))"
 . D ^DIC I $G(X)["^^" D
 . . S DUOUT=1 N LEXBG,LEXS,LEXQ S LEXBG=2,LEXQ=0 F LEXS=LEXBG:1 D  Q:LEXQ
 . . . N LEXID,LEXIEN S LEXID="LEXQDRG "_$G(DUZ)_" DX"_LEXS_" "_LEXSYS
 . . . S LEXIEN=$G(^XTMP(LEXID,"PRE")) K:LEXIEN>0 ^XTMP(LEXID) S:LEXIEN'>0 LEXQ=1
 . I '$L(X)!($D(DTOUT))!($D(DUOUT))!(+Y'>0) S LEXIT=1 Q
 . S DICA=" Enter another Secondary Diagnosis: "
 . S LEXSEC=+($G(Y)),LEXPOA="",LEXIT2=0 I LEXSYS="10D",+LEXSEC>0 D
 . . S LEXPOA=$$POA(+LEXSEC) S:LEXPOA["^" LEXIT2=1 Q:LEXIT
 . Q:LEXIT2  Q:LEXSYS="10D"&('$L($G(LEXPOA)))  Q:LEXSYS="10D"&($G(LEXPOA)["^")
 . S ICDDX(LEXS)=+Y,ICDDX("B",+Y)=LEXS,ICDPOA(LEXS)=LEXPOA
 . S LEXLS=LEXS S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=+Y
 Q:$D(DTOUT) "0^Secondary diagnosis selection timed-out"
 Q:$G(X)["^^" "0^Secondary diagnosis selection aborted"
 N LEXBG,LEXS,LEXIT S LEXBG=LEXLS+1,LEXIT=0 F LEXS=LEXBG:1 D  Q:LEXIT
 . Q:LEXS=1  N LEXID,LEXIEN,LEXAI S LEXID="LEXQDRG "_$G(DUZ)_" DX"_LEXS_" "_LEXSYS
 . S LEXIEN=$G(^XTMP(LEXID,"PRE")) K:LEXIEN>0 ^XTMP(LEXID) S:LEXIEN'>0 LEXIT=1
 . S LEXAI=$G(ICDDX("B",+LEXIEN)) K:+LEXAI>1 ICDDX(+LEXAI),ICDDX("B",+LEXIEN)
 Q 1
PRO(X) ;   Procedures
 N DIC,DICA,DTOUT,DUOUT,LEXBG,LEXC,LEXF,LEXID,LEXIEN,LEXIT,LEXLS,LEXSYS,LEXN,LEXS,Y,ICDDATE
 S ICDDATE=$G(X) Q:$P(ICDDATE,".",1)'?7N "0^Date not Passed" K DICA
 S LEXSYS="10P" S:ICDDATE<$$IMPDATE^LEXU(31) LEXSYS="ICP"
 S (LEXIT,LEXLS)=0 F  S LEXLS=$O(ICDPRC(LEXLS)) Q:+LEXLS'>0  D
 . N LEXIEN S LEXIEN=$G(ICDPRC(LEXLS)) K:+LEXIEN>0 ICDPRC("B",+LEXIEN),ICDPRC(LEXLS)
 S (LEXLS,LEXIT)=0 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60) F LEXS=1:1 D  Q:LEXIT
 . S:LEXS>5 LEXIT=1 Q:LEXIT  N DIC,LEXIEN,LEXC S DIC=$$ROOT^ICDEX(80.1),DIC(0)="AEQMZI"
 . S LEXID="LEXQDRG "_$G(DUZ)_" PR"_LEXS_" "_LEXSYS,LEXIEN=$G(^XTMP(LEXID,"PRE"))
 . S LEXC=$$CODEC^ICDEX(80.1,LEXIEN) S:$L(LEXC)&(LEXC'["^") DIC("B")=LEXC
 . S DIC("A")=" Enter an Operation/Procedure: " S:$L($G(DICA)) DIC("A")=DICA
 . S DIC("S")="I $$ISVALID^ICDEX(80.1,+Y,$G(ICDDATE)),'$D(ICDPRC(""B"",+Y))"
 . D ^DIC I $G(X)["^^" D
 . . S DUOUT=1 N LEXBG,LEXS,LEXQ S LEXBG=1,LEXQ=0 F LEXS=LEXBG:1 D  Q:LEXQ
 . . . N LEXID,LEXIEN S LEXID="LEXQDRG "_$G(DUZ)_" PR"_LEXS_" "_LEXSYS
 . . . S LEXIEN=$G(^XTMP(LEXID,"PRE")) K:LEXIEN>0 ^XTMP(LEXID) S:LEXIEN'>0 LEXQ=1
 . I '$L(X)!($D(DTOUT))!($D(DUOUT))!(+Y'>0) S LEXIT=1 Q
 . S DICA=" Enter another Operation/Procedure: "
 . S ICDPRC(LEXS)=+Y,ICDPRC("B",+Y)=LEXS,LEXID=("LEXQDRG "_$G(DUZ)_" PR"_LEXS_" "_LEXSYS)
 . S LEXLS=LEXS S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=+Y
 Q:$D(DTOUT) "0^Procedure selection timed-out"
 Q:$G(X)["^^" "0^Procedure selection aborted"
 N LEXBG,LEXS,LEXIT S LEXBG=LEXLS+1,LEXIT=0 F LEXS=LEXBG:1 D  Q:LEXIT
 . N LEXID,LEXIEN,LEXAI S LEXID="LEXQDRG "_$G(DUZ)_" PR"_LEXS_" "_LEXSYS
 . S LEXIEN=$G(^XTMP(LEXID,"PRE")) K:LEXIEN>0 ^XTMP(LEXID) S:LEXIEN'>0 LEXIT=1
 . S LEXAI=$G(ICDPRC("B",+LEXIEN)) K:+LEXAI>1 ICDPRC(+LEXAI),ICDPRC("B",+LEXIEN)
 Q 1
 ;
POA(X) ; Present On Admission
 N DIR,DUOUT,DTOUT,DIRUT,DIROUT,Y,LEXPR,LEXIEN,LEXHAC,LEXPOAE,LEXQ S LEXIEN=+($G(X)) Q:'$D(^ICD9(+LEXIEN,0)) "^"
 S LEXPOAE=$$POAE^ICDEX(LEXIEN) Q:LEXPOAE>0 "N"  S LEXHAC=+($$HAC^ICDEX(LEXIEN))
 K DIR S DIR("A")="     Present on Admission: ",DIR(0)="SOA^Y:YES;N:NO;U:Unknown;W:Clinically undetermined"
 S:LEXHAC'>0 DIR("B")="NO" S DIR("PRE")="S LEXQ=X S:X[""?"" X=""??"""
 S DIR("??")="^D POAH2^LEXQDRG2",DIR("?")="^D POAH1^LEXQDRG2"
 D ^DIR I ($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) Q "^"
 I X="" D
 . I $$GET1^DIQ(80,LEXIEN,1.9,"I")'=1 D
 . . S LEXPR(1)="         Diagnosis "_$$GET1^DIQ(80,LEXIEN,.01,"I")_" is not contained in the POA Exempt"
 . . S LEXPR(2)="         list so the POA field should not be blank. If left blank, it will be"
 . . S LEXPR(3)="         treated as if it were a No (""N"")" W !
 . . D EN^DDIOL(.LEXPR) W !
 . . K DIR S DIR(0)="YAO",DIR("A")="     Do you wish to continue? (Y/N)  ",DIR("B")="YES" D ^DIR I ($D(DTOUT))!($D(DUOUT))!($D(DIROUT)) S Y="^"
 . . S:Y=0 Y="^" Q:Y["^"  S Y="N"
 . E  S Y="Y"
 S X=$$UP^XLFSTR(Y)
 Q X
POAH1 ;   Present On Admission ? Help
 W !,?9,"Was the diagnosis present on admission?  Answer Yes, No,"
 W:+($G(LEXHAC))'>0 !,?9,"Unknown or Clinical undtermined"
 W:+($G(LEXHAC))>0 !,?9,"Unknown, Clinical undtermined or <enter>."
 Q
POAH2 ;   Present On Admission ?? Help
 I $G(LEXQ)["?",$G(LEXQ)'["??" D POAH1 S LEXQ="" Q
 W !,?9,"Apply the Present on Admission (POA) indicator for each diagnosis"
 W !,?9,"and external cause of injury code(s) reported as the final set of"
 W !,?9,"diagnosis codes assigned.  One of the following values should be"
 W !,?9,"assigned in accordance with the official coding guidelines:"
 W !,?9,""
 W !,?9,"Y = present at the time of inpatient admission;"
 W !,?9,"N = not present at the time of inpatient admission;"
 W !,?9,"U = documentation is insufficient to determine if"
 W !,?9,"    condition is present on admission;"
 W !,?9,"W = provider is unable to clinically determine"
 W !,?9,"    whether condition was present on admission or not"
 W:+($G(LEXHAC))>0 !,?9,"<enter> = use only if diagnosis is exempt from POA reporting"
 Q
 ;
 ; Previous Values
GETPRE(X) ;   Get Previous Values
 N LEXI,LEXS,LEXX,LEXSYS,LEXIMP K ICDDX,ICDPRC
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DATE"),"PRE"))
 S:$P(LEXX,".",1)'?7N LEXX=$$DT^XLFDT S ICDDATE=LEXX
 S LEXIMP=$$IMPDATE^LEXU(30),LEXSYS="10D" S:ICDDATE<LEXIMP LEXSYS="ICD"
 F LEXI=1:1 Q:'$D(^XTMP(("LEXQDRG "_$G(DUZ)_" DX"_LEXI_" "_LEXSYS)))  D
 . N LEXX S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DX"_LEXI_" "_LEXSYS),"PRE"))
 . I +LEXX>0 S LEXS=$O(ICDDX(" "),-1)+1,ICDDX(LEXS)=LEXX
 S LEXSYS="10P" S:ICDDATE<LEXIMP LEXSYS="ICP"
 F LEXI=1:1 Q:'$D(^XTMP(("LEXQDRG "_$G(DUZ)_" PR"_LEXI_" "_LEXSYS)))  D
 . N LEXX S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" PR"_LEXI_" "_LEXSYS),"PRE"))
 . I +LEXX>0 S LEXS=$O(ICDPRC(" "),-1)+1,ICDPRC(LEXS)=LEXX
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" AGE"),"PRE"))
 S:LEXX'>0 LEXX=40 S AGE=LEXX
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" SEX"),"PRE"))
 S:'$L(LEXX) LEXX="M" S SEX=LEXX
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DMS"),"PRE"))
 S:'$L(LEXX) LEXX=0 S ICDDMS=LEXX
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" TRS"),"PRE"))
 S:'$L(LEXX) LEXX=0 S ICDTRS=LEXX
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DATE"),"EXP"))
 S:'$L(LEXX) LEXX=0 S ICDEXP=LEXX
 Q:'$D(ICDDX(1)) "0^Missing Principal Diagnois"
 Q:$G(AGE)'?1N.N "0^Missing or invalid 'age'"
 Q:"^M^F^"'[("^"_$G(SEX)_"^") "0^Missing or invalid 'sex'"
 Q:"^1^0^"'[("^"_$G(ICDDMS)_"^") "0^Missing or invalid 'discharged against medical advice'"
 Q:"^1^0^"'[("^"_$G(ICDTRS)_"^") "0^Missing or invalid 'transferred to acute care facility'"
 Q:"^1^0^"'[("^"_$G(ICDEXP)_"^") "0^Missing or invalid 'died during episode of care'"
 Q 1
SETPRE ;   Set Previous Values
 N LEXF,LEXI,LEXID,LEXN,LEXV,LEXIMP,LEXSYS
 S LEXN=$$DT^XLFDT,LEXF=$$FMADD^XLFDT(LEXN,60) D PURPRE
 S LEXIMP=$$IMPDATE^LEXU(30),LEXSYS="10D" S:$G(ICDDATE)<LEXIMP LEXSYS="ICD"
 S LEXI=0 F  S LEXI=$O(ICDDX(LEXI)) Q:+LEXI'>0  D
 . N LEXV S LEXV=$P($G(ICDDX(LEXI)),"^",1)
 . Q:+LEXV'>0  S LEXID="LEXQDRG "_$G(DUZ)_" DX"_LEXI_" "_LEXSYS
 . S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 S LEXSYS="10P" S:$G(ICDDATE)<LEXIMP LEXSYS="ICP"
 S LEXI=0 F  S LEXI=$O(ICDPRC(LEXI)) Q:+LEXI'>0  D
 . N LEXV S LEXV=$P($G(ICDPRC(LEXI)),"^",1)
 . Q:+LEXV'>0  S LEXID="LEXQDRG "_$G(DUZ)_" PR"_LEXI_" "_LEXSYS
 . S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 S LEXV=$G(AGE) S:LEXV'>0 LEXV=40 S LEXID="LEXQDRG "_$G(DUZ)_" AGE"
 S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 S LEXV=$G(SEX) S:"^M^F^"'[("^"_LEXV_"^") LEXV="M" S LEXID="LEXQDRG "_$G(DUZ)_" SEX"
 S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 S LEXV=$G(ICDDATE) S:$P(LEXV,".",1)'?7N LEXV=$$NOW^XLFDT S LEXID="LEXQDRG "_$G(DUZ)_" DATE"
 S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 S LEXV=$G(ICDDMS) S:'$L(LEXV) LEXV=0 S LEXID="LEXQDRG "_$G(DUZ)_" DMS"
 S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 S LEXV=$G(ICDTRS) S:'$L(LEXV) LEXV=0 S LEXID="LEXQDRG "_$G(DUZ)_" TRS"
 S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 S LEXV=$G(ICDEXP) S:'$L(LEXV) LEXV=0 S LEXID="LEXQDRG "_$G(DUZ)_" EXP"
 S ^XTMP(LEXID,0)=LEXF_"^"_LEXN_"^Previous",^XTMP(LEXID,"PRE")=LEXV
 Q
PURPRE ;   Purge Saved Values
 N LEXI,LEXIMP,LEXSYS Q:+($G(ICDDATE))'>0  S LEXIMP=$$IMPDATE^LEXU(30),LEXSYS="10D"
 S:$G(ICDDATE)<LEXIMP LEXSYS="ICD" K ^XTMP(("LEXQDRG "_$G(DUZ)_" DX1 "_LEXSYS))
 F LEXI=2:1 Q:'$D(^XTMP(("LEXQDRG "_$G(DUZ)_" DX"_LEXI_" "_LEXSYS)))  K ^XTMP(("LEXQDRG "_$G(DUZ)_" DX"_LEXI_" "_LEXSYS))
 F LEXI=1:1 Q:'$D(^XTMP(("LEXQDRG "_$G(DUZ)_" PR"_LEXI)))  K ^XTMP(("LEXQDRG "_$G(DUZ)_" PR"_LEXI))
 Q
HASPRE(X) ;   User Has Previous Values
 N LEXX,LEX9 S LEX9=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DX1 ICD"),"PRE"))
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DX1 10D"),"PRE")) Q:+LEXX'>0&(+LEX9'>0) -1
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" AGE"),"PRE")) Q:+LEXX'>0 -2
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DATE"),"PRE")) Q:$P(LEXX,".",1)'?7N -3
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" SEX"),"PRE")) Q:"^M^F^"'[("^"_LEXX_"^") -4
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" EXP"),"PRE")) Q:"^1^0^"'[("^"_LEXX_"^") -5
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" DMS"),"PRE")) Q:"^1^0^"'[("^"_LEXX_"^") -6
 S LEXX=$G(^XTMP(("LEXQDRG "_$G(DUZ)_" TRS"),"PRE")) Q:"^1^0^"'[("^"_LEXX_"^") -7
 Q 1
