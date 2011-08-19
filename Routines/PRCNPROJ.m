PRCNPROJ ;SSI/ALA-Special Project Help Program ;[ 03/18/96  11:31 AM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
LKUP ;  Special help for Projects
 W !,"Must begin with station number.  Enter '??' for more help text."
 W !!,"Projects currently in the Project File:"
 S DUOUT=0,PRCNCT=0,PL=""
 F  S PL=$O(^ENG("PROJ","B",PL)) Q:PL=""  D  I $G(DUOUT)=1 S DUOUT=0 Q
 . S L=$O(^ENG("PROJ","B",PL,""))
 . S PRCNPJT=$P(^ENG("PROJ",L,0),U,3)
 . S LL=PL_"  "_PRCNPJT
  . D T I $G(DUOUT)=1 Q
 K L,PRCNA,PRCNCT
 Q
INP ;  Input transform check
 I X'?3N1"-"3N&(X'?3N1"-"2NA1"-"3N) K X Q
 S PRJNM=$O(^ENG("PROJ","B",X,"")) I PRJNM="" K PRJNM Q
 S PRJMR=$P($G(^ENG("PROJ",PRJNM,33)),U,2)
 I PRJMR'="",PRJMR?.N S PRJMR=$P(^VA(200,PRJMR,0),U)
 Q
PROJ ; Make a request number into a project number
 S (R,R2)=$P(^PRCN(413,D0,0),U) G EX:R["P" S $P(R2,"-",4)="P"_$P(R2,"-",4)
 K ^PRCN(413,"B",R) S ^PRCN(413,"B",R2,D0)="",$P(^PRCN(413,D0,0),U)=R2
EX K R,R2
 Q
T S PRCNCT=PRCNCT+1
 I PRCNCT<10 W !,LL Q
 R !,"'^' TO STOP: ",PRCNA:DTIME S:'$T PRCNA=U
 I $G(PRCNA)[U S DUOUT=1 Q
 S PRCNCT=0 Q
