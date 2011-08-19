LRPXAPIU ; SLC/STAFF Lab Extract API Utilities ;1/29/04  14:32
 ;;5.2;LAB SERVICE;**295,315**;Sep 27, 1994;Build 25
 ;
 ; lab APIs
 ; dbia 4246
 ;
 ; ------------ internal number conversions -----------
 ;
LRDFN(DFN) ; API $$(dfn) -> lrdfn
 Q +$G(^DPT(+$G(DFN),"LR"))
 ;
DFN(LRDFN) ; API $$(lrdfn) -> dfn
 S LRDFN=+$G(LRDFN)
 I $P($G(^LR(LRDFN,0)),U,2)'=2 Q 0
 Q +$P(^LR(LRDFN,0),U,3)
 ;
LRIDT(DATETIME) ; API $$(datetime) -> lridt (or lridt to datetime)
 I +$G(DATETIME)'>0 Q 0
 Q 9999999-DATETIME
 ;
LRDN(TEST) ; API $$(test) -> data number (subscript for test in ^LR)
 Q +$P($P($G(^LAB(60,+$G(TEST),0)),U,5),";",2)
 ;
TEST(LRDN) ; API $$(lrdn) -> test
 Q +$O(^LAB(60,"C","CH;"_$G(LRDN)_";1",0))
 ;
AB(ABDN) ; API $$(antimicrobial data number) -> antimicrobial ien
 Q +$G(^LAB(62.06,"AI",+$G(ABDN)))
 ;
ABDN(AB) ; API $$(62.06 ien) -> antimicrobial data number
 N ABDN
 S ABDN=+$P($G(^LAB(62.06,+$G(AB),0)),U,2)
 I ABDN'["2." Q 0
 Q ABDN
 ;
TB(TBDN) ; API $$(mycobacteria data number) -> mycobacteria field number
 Q +$O(^DD(63.39,"GL",+$G(TBDN),1,0)) ; dbia 999
 ;
TBDN(TB) ; API $$(mycobacteria field number) -> mycobacteria data number
 N TBDN
 S TBDN=+$P($G(^DD(63.39,+$G(TB),0)),U,4) ; dbia 999
 I TBDN'["2." Q 0
 Q TBDN
 ;
CATEGORY(SUB,TYPE) ; API $$(subscript, type) -> Micro category [B P F M V], AP category [A C E M S]
 N CAT
 S SUB=+$G(SUB)
 I TYPE="M" D  Q CAT
 . I SUB=3 S CAT="B" Q
 . I SUB=6 S CAT="P" Q
 . I SUB=9 S CAT="F" Q
 . I SUB=12 S CAT="M" Q
 . I SUB=17 S CAT="V" Q
 . S CAT=-1
 I SUB="SP" Q "S"
 I SUB="CY" Q "C"
 I SUB="EM" Q "E"
 I SUB="AU" Q "A"
 I SUB="AY" Q "A"
 I SUB=33 Q "A"
 I SUB=80 Q "A"
 Q -1
 ;
CATSUB(CAT,TYPE) ; API $$(category letter, type) -> subscript
 N SUB
 S CAT=$G(CAT)
 I TYPE="M" D  Q SUB
 . I CAT="B" S SUB=3 Q
 . I CAT="P" S SUB=6 Q
 . I CAT="F" S SUB=9 Q
 . I CAT="M" S SUB=12 Q
 . I CAT="V" S SUB=17 Q
 . S SUB=-1
 I CAT="S" Q "SP"
 I CAT="C" Q "CY"
 I CAT="E" Q "EM"
 I CAT="A" Q "AU" ; must check - could be AY, 33, 80
 Q -1
 ;
 ; ----------- external names ---------------
 ;
DFNM(DFN) ; API $$(dfn) -> patient name
 Q $P($G(^DPT(+$G(DFN),0)),U)
 ;
LRDFNM(LRDFN) ; API $$(lrdfn) -> patient name
 Q $$DFNM($$DFN(+$G(LRDFN)))
 ;
TESTNM(TEST) ; API $$(test ien) -> test name
 Q $P($G(^LAB(60,+$G(TEST),0)),U)
 ;
LRDNM(LRDN) ; API $$(data number) -> test name
 Q $$TESTNM($$TEST($G(LRDN)))
 ;
SPECNM(SPEC) ; API $$(spec ien) -> specimen name
 Q $P($G(^LAB(61,+$G(SPEC),0)),U)
 ;
BUGNM(BUG) ; API $$(organism ien) -> organism name
 Q $P($G(^LAB(61.2,+$G(BUG),0)),U)
 ;
ABNM(AB) ; API $$(antimicrobial ien) -> antimicrobial name
 Q $P($G(^LAB(62.06,+$G(AB),0)),U)
 ;
TBNM(TB) ; API $$(mycobacteria field number) -> mycobacteria drug name
 Q $P($G(^DD(63.39,+$G(TB),0)),U) ; dbia 999
 ;
ORGNM(ORGAN) ; API $$(organ/tissue ien) -> organ/tissue name
 Q $P($G(^LAB(61,+$G(ORGAN),0)),U)
 ;
DISNM(DISEASE) ; API $$(disease ien) -> disease name
 Q $P($G(^LAB(61.4,+$G(DISEASE),0)),U)
 ;
ETINM(ETIOLOGY) ; API $$(etiology ien) -> etiology name
 Q $P($G(^LAB(61.2,+$G(ETIOLOGY),0)),U)
 ;
MORPHNM(MORPH) ; API $$(morphology ien) -> morphology name
 Q $P($G(^LAB(61.1,+$G(MORPH),0)),U)
 ;
FUNNM(FUNCTION) ; API $$(function ien) -> function name
 Q $P($G(^LAB(61.3,+$G(FUNCTION),0)),U)
 ;
PROCNM(PROC) ; API $$(procedure ien) -> procedure name
 Q $P($G(^LAB(61.5,+$G(PROC),0)),U)
 ;
ICD9(ICD9) ; API $$(icd9 ien) -> icd code^name
 N LRTMP
 S ICD9=$P($$ICDDX^ICDCODE(ICD9,,,1),U,2)
 S LRTMP=$$ICDD^ICDCODE(ICD9,"LRTMP")
 Q ICD9_U_$G(LRTMP(1))
 ;
DOD(DFN) ; API $$(dfn) -> date of death else 0
 Q +$G(^DPT(+$G(DFN),.35)) ; dbia 13
 ;
EXTVALUE(Y,REF) ; API $$(internal value,index ref) -> external value
 N C,FIELD
 I $P(REF,";",2)'="CH" Q Y
 S FIELD=+$P(REF,";",4)
 S C=$P(^DD(63.04,FIELD,0),U,2) ; dbia 999
 D Y^DIQ
 Q Y
 ;
ITEMNM(INFO) ; API $$(ap or micro item) -> item name
 N FILE,NAME,NUM,TYPE
 I INFO=+INFO Q $$TESTNM(INFO)
 S NAME=""
 S TYPE=$P(INFO,";") I '$L(TYPE) Q NAME
 S FILE=$P(INFO,";",2) I '$L(FILE) Q NAME
 S NUM=+$P(INFO,";",3) I 'NUM Q NAME
 I TYPE="M" D  Q NAME
 . I FILE="S" S NAME=$$SPECNM(NUM) Q
 . I FILE="T" S NAME=$$TESTNM(NUM) Q
 . I FILE="O" S NAME=$$BUGNM(NUM) Q
 . I FILE="A" S NAME=$$ABNM(NUM) Q
 . I FILE="M" S NAME=$$TBNM(NUM) Q
 I TYPE="A" D  Q NAME
 . I FILE="S" S NAME=$P(INFO,".",2) Q
 . I FILE="T" S NAME=$$TESTNM(NUM) Q
 . I FILE="O" S NAME=$$ORGNM(NUM) Q
 . I FILE="D" S NAME=$$DISNM(NUM) Q
 . I FILE="M" S NAME=$$MORPHNM(NUM) Q
 . I FILE="E" S NAME=$$ETINM(NUM) Q
 . I FILE="F" S NAME=$$FUNNM(NUM) Q
 . I FILE="P" S NAME=$$PROCNM(NUM) Q
 . I FILE="I" S NAME=$$ICD9^LRPXAPIU(NUM) Q
 Q NAME
 ;
 ; -------------- other utilities -------------
 ;
CONDOK(COND,TYPE) ; API $$(condition,type) -> 1 for valid condition, else 0
 Q $$CONDOK^LRPXAPI2($G(COND),$G(TYPE,"C"))
 ;
NORMALS(LOW,HIGH,TEST,SPEC) ; API return low and high ref range on test
 D NORMALS^LRPXAPI2(.LOW,.HIGH,TEST,SPEC)
 Q
 ;
DATES(DATE1,DATE2) ; API return proper date range
 ; DATE1 always returns oldest value
 N TEMP
 S DATE1=$$EXTTOFM($G(DATE1))
 S DATE2=$$EXTTOFM($G(DATE2))
 I 'DATE2 S DATE2=9999999
 I DATE1>DATE2 S TEMP=DATE1,DATE1=DATE2,DATE2=TEMP
 I DATE2=+DATE2,DATE2'=9999999,DATE2'["." S DATE2=DATE2+.25
 Q
 ;
EXTTOFM(X) ; $$(external date/time) -> FM date/time
 N %DT,Y
 S %DT="TS"
 D ^%DT
 I Y=-1 Q 0
 Q +Y
 ;
VRESULT(TEST,RESULT) ; $$(test,result) -> valid result
 Q $$STRIP($$RESULT(TEST,RESULT))
 ;
RESULT(TEST,RESULT) ; $$(test,result) -> result  Convert CH result to external format
 ;TEST=Test ptr to file 60
 ;RESULT=Test result
 N X,X1,LRCW
 S LRCW="",X1=$P($G(^LAB(60,TEST,.1)),U,3),X1=$S($L(X1):X1,1:"$J(X,8)"),X=RESULT,@("X="_X1)
 Q X
 ;
STRIP(TEXT) ; $$(text) -> stripped text  Strips white space from text
 N I,X
 S X="" F I=1:1:$L(TEXT," ") S:$A($P(TEXT," ",I))>0 X=X_$P(TEXT," ",I)
 Q X
 ;
