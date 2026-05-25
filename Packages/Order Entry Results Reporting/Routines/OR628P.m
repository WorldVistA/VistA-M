OR628P ;NA/AJB - Patient Updater for PACT Act ;Nov 06, 2024@12:58:46
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**628**;Dec 17, 1997;Build 13
 ;
 ; Reference to ^DIC in ICR #10006
 ; Reference to FIND1^DIC in ICR #2051
 ; Reference to UPDATE^DIE in ICR #2053
 ; Reference to ^DIR in ICR #10026
 ; Reference to FMTE^XLFDT in ICR #10103
 ; Reference to $$NOW^XLFDT in ICR #10103
 ; Reference to $$PROD^XUPROD in ICR #4440
 ;
 Q
PATIENT ; update patient data for PACT Act
 ; testing only/non-production accounts only
 I +$$PROD^XUPROD Q
 N DFN S DFN=$$GPT Q:DFN'>0
 N DATA S DATA=$G(^DPT(+DFN,.321))
 N PGI,DLU S PGI=$P(DATA,U,17),DLU=$P(DATA,U,18)
 W !!,$P(DFN,U,2)
 W !!,"Old Value:  ",$S(PGI="":"<no data>",1:PGI),?25,"Last Updated:  ",$S(DLU="":"<no data>",1:$$FMTE^XLFDT(DLU))
 S $P(^DPT(+DFN,.321),U,17)=$S('PGI:1,1:0),$P(^DPT(+DFN,.321),U,18)=$$NOW^XLFDT
 S DATA=$G(^DPT(+DFN,.321))
 S PGI=$P(DATA,U,17),DLU=$P(DATA,U,18)
 W !,"New Value:  ",$S(PGI="":"<no data>",1:PGI),?25,"Last Updated:  ",$S(DLU="":"<no data>",1:$$FMTE^XLFDT(DLU)),!
 D
 . N JOB S JOB=0 F  S JOB=$O(^TMP(JOB)) Q:'JOB  I $D(^TMP(JOB,"SVC",+DFN)) K ^TMP(JOB,"SVC",+DFN)
 I $$FMR("EA","Press <Enter> to continue.")
 Q
POST ; add option for test accounts only
 I +$$PROD^XUPROD Q
 I +$$LU^OR628P(19,"OR PACT ACT") Q
 N ERROR,OPT
 S OPT(19,"+1,",.01)="OR PACT ACT"
 S OPT(19,"+1,",1)="PACT Act Patient Updater"
 S OPT(19,"+1,",3.6)=DUZ
 S OPT(19,"+1,",4)="R"
 S OPT(19,"+1,",10.1)="Patient Updater"
 S OPT(19,"+1,",20)="W @IOF"
 S OPT(19,"+1,",25)="PATIENT^OR628P"
 D UPDATE^DIE("","OPT","","ERROR") I $D(ERROR) X "ZW ERROR"
 Q
FMR(DIR,PRM,DEF,HLP,SCR) ;
 N DILN,DILOCKTM,DISYS
 N DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)=DIR S:$G(PRM)'="" DIR("A")=PRM S:$G(DEF)'="" DIR("B")=DEF S:$G(SCR)'="" DIR("S")=SCR
 S X=+DIR("A"),Y=$P(DIR("A"),";",2) S:+X DIR("A")=$$SETSTR(Y,"",X,$L(Y))
 I $G(HLP)'="" S DIR("?")=HLP
 I $D(HLP)>1 M DIR=HLP
 D ^DIR
 Q $S(X="@":X,$D(DTOUT):U,$D(DUOUT):U,$D(DIROUT):U,$D(DIRUT):"",1:Y)
GPT() ; ask user for patient
 N %H,%I,DIC,DILOCKTM,DISYS,DTOUT,DUOUT,X,Y
 S DIC=2,DIC(0)="AEIMQ",DIC("A")=" Select PATIENT NAME: " W ! D ^DIC
 Q Y
LU(FILE,NAME,FLAGS,SCREEN,INDEXES) ;
 Q $$FIND1^DIC(FILE,"",$G(FLAGS),NAME,$G(INDEXES),$G(SCREEN))
SETSTR(S,V,X,L) ;
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
