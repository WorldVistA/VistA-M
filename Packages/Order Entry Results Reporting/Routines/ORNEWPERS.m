ORNEWPERS ; NA/AJB - NEW PERSON RPC ;02/09/23  06:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**596**;Dec 17, 1997;Build 7
 ;
 ; External reference to $$DT^XLFDT supported by IA 10103
 ; External reference to $$ALL^VASITE suppored by IA 10112
 ; External reference to $$SCRDFCS^TIULA3 supported by IA 3976
 ; External reference to $$DIV4^XUSER supported by 2343
 ; External reference to $$PROVIDER^XUSER supported by IA 2343
 ; External reference to $$GET^XUA4A72 supported by IA 1625
 ; External reference to $$GET1^DIQ supported by IA 2056
 ; External reference to $$ACCESS^XQCHK supported by IA 10078
 ; External reference to $$NPI^XUSNPI supported by IA 4532
 ; External reference to $$ISA^USRLM supported by IA 1544
 ; External reference to $$REQCOSIG^TIULP supported by IA 2322
 ; External reference to $$ISA^USRLM supported by 1544
 ; External reference to GETLST^XPAR supported by IA 2263
 ; External reference to File ^DIC(49 supported by IA 4330
 ; External reference to File ^TIU(8925 supported by IA 2937
 ; External reference to File ^VA supported by IA 4329
 ; External reference to File ^VA supported by IA 10060
 ; External reference to File ^XUSEC supported by IA 10076
 ;
 Q
PARAMETERS ; FROM^DIR^KEY^DATE^RDV^ALL^PDMP^SPN^EXC^NVAP^DFC^TIUDA^TYPE^HELP^DEBUG
NEWPERSON(ORY,PARAMS) ; all parameters passed by reference
 S DT=$G(DT,$$DT^XLFDT),U="^",DUZ=$G(DUZ)
 N GBL,I,INF,J,MAX,P,PARAMETERS,PRM,TAG,XEC
 S PARAMETERS=$P($T(PARAMETERS),"; ",2) F I=1:1:$L(PARAMETERS,U) S PRM=$P(PARAMETERS,U,I) N @(PRM) D  ;   setup parameters
 . S (@(PRM),P(PRM))=$G(PARAMS(PRM)) ;                                                                    set variables & parameters
 . S INF(I,PRM)=$S($D(PARAMS(PRM)):PARAMS(PRM),1:"") ;                                                    set for help
 I EXC S P("ORUCE")=$$GET^XPAR("SYS","OR CPRS USER CLASS EXCLUDE",1,"B") ;                                set OR CPRS USER CLASS EXCLUDE parameter
 S DIR=$S('DIR:1,1:DIR),MAX=44 ;                                                                          direction & max results
 S GBL=$S((ALL!RDV):$NA(^VA(200,"B")),1:$NA(^VA(200,"AUSER"))) ;                                          search global
 S TAG=$S(TYPE:"COS",DFC:"DFC",PDMP:"PDM",RDV:"RDV",ALL:"ALL",1:"USR") ;                                  tag for criteria
 I TAG="COS" S P("DSC")=$$FIND1^DIC(8925.1,"","","DISCHARGE SUMMARY","","I $P(^(0),U,4)=""CL""","") ;     discharge summary class
 F I=0:1 S J=$P($T(@TAG+I),";;",2,3) Q:J=""  S XEC(I)=J ;                                                 execution criteria [evaluated reverse order]
 I HELP'=0 D HELP(.ORY,.INF,.XEC) Q  ;                                                                    REMOTE PROCEDURE information
 ; similiar provider name lookup receives IEN, returns all users that match LAST,FI [ignores max limit]
 ; example:  CPRSPROVIDER,FIRSTNAME becomes CPRSPROVIDER,FH~
 I SPN N SPNQ D SPN(.FROM,.SPNQ) ;                                                                        similar provider name lookup
 S I=0 F  Q:$S(SPN:0,1:(I'<MAX))  S FROM=$O(@GBL@(FROM),DIR) Q:$S(SPN:'(FROM[SPNQ),1:FROM="")  D  ;       main loop
 . N IEN S IEN=0 F  Q:$S(SPN:0,1:I'<MAX)  S IEN=$O(@GBL@(FROM,IEN)) Q:'IEN  D
 . . N DIV,NODE0 S NODE0=$G(^VA(200,IEN,0)) Q:NODE0=""  ;                                                 set zero node
 . . I PDMP D  S P("DIV")=DIV ;                                                                           ISAUTH^ORPDMP->$$DEA^XUSER - uses DUZ(2) of current user, not of evaluated user
 . . . S DIV=$$DIV4^XUSER(.DIV,IEN) I DIV=0 S DIV="" Q  ;                                                 get division(s), quit if none
 . . . S DIV=$O(DIV(0))_U_$$GET1^DIQ(4,$O(DIV(0)),.01) ;                                                  set division
 . . . N X S X=0 F  S X=$O(DIV(X)) Q:'+X  I +DIV(X) S DIV=X_U_$$GET1^DIQ(4,X,.01) ;                       set default division if designated
 . . S P("IEN")=IEN,P("NODE0")=NODE0 ;                                                                    set parameters
 . . I '$$EVALUATE(.XEC,.P) Q  ;                                                                          evaluate user
 . . N MORE S MORE=$S(SPN:1,+$O(@GBL@(FROM,IEN),1):1,+$O(@GBL@(FROM,IEN),-1):1,1:0) ;                     add service/section,division for user
 . . S I=I+1,ORY(I)=$$DETAILS(NODE0,IEN,MORE,.DIV) ;                                                      user details
 Q
EVALUATE(XEC,P) ;
 N CODE,RES,VAL S RES=1,VAL="" F  S VAL=$O(P(VAL)) Q:VAL=""  N @(VAL) S @(VAL)=P(VAL) ;                   set variables
 F VAL="COR","NVA" N @(VAL) S @(VAL)=$$CPRSTAB(IEN,$O(^ORD(101.13,"B",VAL,0)),DATE) ;                     set user CPRS TAB status
 I PDMP N PDMPDIV S PDMPDIV=$G(DUZ(2)),DUZ(2)=+DIV ;                                                      ISAUTH^ORPDMP->$$DEA^XUSER - uses DUZ(2) of current user, not of evaluated user
 S CODE="" F  Q:'RES&('DEBUG)  S CODE=$O(XEC(CODE),-1) Q:CODE=""  X $P(XEC(CODE),";;") I $T D  ;          execute evaluation
 . W:DEBUG&RES=1 !!,"Verifying "_$P(NODE0,U)_"...",!!,IOUON_"Reason(s) for exclusion"_IOUOFF
 . S RES=0 W:DEBUG !,?2,@$P(XEC(CODE),";;",2) ;                                                           display exclusion description
 I PDMP S DUZ(2)=PDMPDIV ;                                                                                revert DUZ(2)
 Q RES
SPN(FROM,SPNQ) ; similar provider name lookup
 N NODE0 S NODE0=$G(^VA(200,FROM,0)) I NODE0="" S ORY(1)="-1^Invalid IEN" Q
 S FROM=$P(NODE0,U),FROM=$E(FROM,1,($L($P(FROM,","))+3)),SPNQ=FROM N FNM S FNM=$P(FROM,",",2)
 S $P(FROM,",",2)=$E(FNM,1,$L(FNM)-1)_$C($A(FNM,$L(FNM))-1)_"~" ;                                         set FROM
 Q
DETAILS(NODE0,IEN,MORE,DIV) ; get user information
 N DTL,ENTRY S DIV=$G(DIV),DTL="",ENTRY=IEN_"^"_$$NAMEFMT^XLFNAME($P(NODE0,U),"F","DcMPC")_"^",MORE=$G(MORE,0) ;         IEN^user name
 S:$P(NODE0,U,9) DTL(1)=$$TITLE^XLFSTR($G(^DIC(3.1,$P(NODE0,U,9),0))) ;                                                  title
 I MORE D
 . N SRV S SRV=$P($G(^VA(200,IEN,5)),U) S:SRV SRV=$$TITLE^XLFSTR($P($G(^DIC(49,SRV,0)),U)) S:SRV'="" DTL(2)=SRV ;        service/section
 . I +DIV S DIV=$S($P(DIV,U,2)'="":$P(DIV,U,2),1:$$GET1^DIQ(4,+DIV,.01)) S:DIV'="" DTL(3)=DIV Q  ;                       division
 . S DIV=$$DIV4^XUSER(.DIV,IEN) Q:'DIV  S DIV=$$GET1^DIQ(4,$O(DIV(0)),.01) ;                                             get division
 . N X S X=0 F  S X=$O(DIV(X)) Q:'+X  I +DIV(X) S DIV=$$GET1^DIQ(4,X,.01) ;                                              default division
 . S:DIV'="" DTL(3)=DIV ;                                                                                                division
 N NPI S NPI=+$$NPI^XUSNPI("Individual_ID",IEN) S:+NPI>0 DTL(4)="[NPI: "_NPI_"]" ;                                       NPI
 N X S X=0 F  S X=$O(DTL(X)) Q:'X  S:$O(DTL(0))=X DTL="- " S DTL=DTL_DTL(X)_$S($O(DTL(X))=4:" ",$O(DTL(X)):", ",1:"") ;  set details
 Q ENTRY_DTL
CPRSTAB(USER,TAB,DATE) ; return tab status
 ; 0 missing/expired, 1 assigned & current
 N RESULT S DATE=$S(+DATE:DATE,1:DT),RESULT=0
 Q:'$D(^VA(200,USER,"ORD","B",TAB)) RESULT ; quit, tab not assigned
 S TAB=$O(^VA(200,USER,"ORD","B",TAB,0)) Q:'+TAB RESULT ; get tab #
 S TAB=$G(^VA(200,USER,"ORD",TAB,0)) ; tab node=tab#^effective date^expiration date
 I DATE'<$P(TAB,U,2),DATE<$P(TAB,U,3)!($P(TAB,U,3)="") S RESULT=1
 Q RESULT
DIC(DIC) ; basic lookup
 N DTOUT,DUOUT,X,Y S DIC=^DIC(DIC,0,"GL"),DIC(0)="AE" D ^DIC
 Q $S(+Y>0:Y,X=U:U,+$G(DTOUT):U,Y'>0:0,1:Y)
DIR(DIR) ; basic reader
 N DIRUT,DTOUT,DUOUT,X,Y D ^DIR
 Q $S(+Y:Y,X=U:U,+$G(DTOUT):U,1:Y)
HELP(ORY,INF,XEC) ; return detailed parameter &  user evaluation information
 N GBL,I,IEN,J,NODE,X S IEN=$$FIND1^DIC(8994,,,"ORNEWPERS NEWPERSON"),X=0 Q:'IEN
 F NODE=2,3 S GBL=$S(NODE=2:$NA(^XWB(8994,IEN,2,1,1)),1:$NA(^XWB(8994,IEN,3))) D
 . S I=0 F  S I=$O(@GBL@(I)) Q:'I  S X=X+1,ORY(X)=@GBL@(I,0)
 S X=X+1,ORY(X)="",X=X+1,ORY(X)="Parameter       Value"
 S I=0 F  S I=$O(INF(I)) Q:'I  S X=X+1,ORY(X)=$O(INF(I,"")),J=INF(I,$O(INF(I,""))),ORY(X)=$$SETSTR(J,ORY(X),17,$L(J))
 S X=X+1,ORY(X)="",X=X+1,ORY(X)="COR=CPRS GUI ""core"" tab status",X=X+1,ORY(X)="NVA=Non-VA Providers tab staus"
 S X=X+1,ORY(X)="",X=X+1,ORY(X)="Current Evaluation Criteria"
 S I="" F  S I=$O(XEC(I),-1) Q:I=""  S X=X+1,ORY(X)=$P(XEC(I),";;")
 Q
SETSTR(S,V,X,L) ; insert text(S) into variable(V) at position (X) with length of (L)
 Q $E(V_$J("",X-1),1,X-1)_$E(S_$J("",L),1,L)_$E(V,X+L,999)
USRCLEX(IEN,CLASS,ERR,DATE) ; NSR 20120101
 Q $$ISA^USRLM(IEN,CLASS,.ERR,DATE)
 ; criteria to screen users, evaluated in reverse order [bottom to top]
 ; code;;exclusion description (debug mode)
COS ;;I $$REQCOSIG^TIULP(TYPE,TIUDA,IEN,DATE);;"User requires co-signature for a:",!,?4,$E($$GET1^DIQ(8925.1,TYPE,.01),1,67)
 ;;I TYPE=DSC!($$ISA^TIULX(TYPE,DSC)),'$$ISA^USRLM(IEN,"PROVIDER",,DATE);;"Not a PROVIDER User Class for a title in DISCHARGE SUMMARY Class"
DFC ;;I DFC,'$$PROVIDER^TIUPXAP1(IEN,DATE);;"Not a member of a Provider 'Person Class' for default co-signer selection"
 ;;I DFC,DUZ=IEN;;"Cannot assign youself as default co-signer"
USR ;;I EXC,+ORUCE,$$USRCLEX(IEN,+ORUCE,"ERR",DATE);;"Member of "_$P(ORUCE,U,2)_" user class excluded via parameter"
 ;;I EXC,NVA;;"Non-VA Provider excluded for Additional Signer selection"
 ;;I COR,VAL=-3;;"OR CPRS GUI CHART option missing"
 ;;S VAL=$$ACCESS^XQCHK(IEN,"OR CPRS GUI CHART") I COR,VAL=0;;"Not assigned OR CPRS GUI CHART option [any menu tree]"
 ;;I 'NVAP,NVA;;"Non-VA Provider excluded via parameter"
PDM ;;I PDMP,'$$ISAUTH^ORPDMP(IEN);;"Not authorized for PDMP access"
 ;;I NVA,COR;;"Non-VA and 'core' CPRS TAB ACCESS "_$S(DATE:"active on "_$$FMTE^XLFDT(DATE),1:"currently active")
 ;;I 'NVA,'COR;;"No CPRS TAB ACCESS assigned"
 ;;I +$P(NODE0,U,7);;"DISUSER status YES"
RDV ;;I $P(NODE0,U,11)>0,$P(NODE0,U,11)'>$S(DATE:DATE,1:DT);;"Termination date reached "_$$FMTE^XLFDT($P(NODE0,U,11))
ALL ;;I DATE,$$GET^XUA4A72(IEN,DATE)'>0;;"No active 'Person Class' for "_$$FMTE^XLFDT(DATE)
 ;;I KEY'="",'$D(^XUSEC(KEY,IEN));;"Not assigned "_KEY_" Security Key"
 ;;
DEBUG ; evaluate a specific user, list below prompts user to determine RPC criteria entry point
 ;;ALL^YE^NO^Terminated or DISUSER allowed
 ;;RDV^YE^NO^Visitor only [for Remote Data View]
 ;;PDM^YE^NO^Must be authorized PDMP user
 ;;DFC^YE^NO^Screen for default co-signer selection
 ;;COS^YE^NO^Verify co-signature authorization for a document title
 ;;
 N DIC,DIR,DIV,I,J,NODE0,P,PRM,TAG,VAL,XEC,X,Y
 S DT=$G(DT,$$DT^XLFDT),U="^" D HOME^%ZIS,PREP^XGF W IOCUON
 S P=$P($T(PARAMETERS),"; ",2) F I=1:1:$L(P,U) S PRM=$P(P,U,I) N @(PRM) D  ;                                       setup parameters
 . S (@(PRM),P(PRM))=$G(PARAMS(PRM)) ;                                                                             set variables & parameters
 S DIC=200,DIC("A")="Enter NEW PERSON to evaluate: ",VAL=+$$DIC(.DIC) G EXIT:'VAL ;                                ask for NEW PERSON
 S P("DEBUG")=1,P("IEN")=VAL,(NODE0,P("NODE0"))=^VA(200,+VAL,0)
 S DIV=$$DIV4^XUSER(.DIV,VAL) D:+DIV  S P("DIV")=DIV ;                                                             check division
 . S DIV=$O(DIV(0))_U_$$GET1^DIQ(4,$O(DIV(0)),.01) ;                                                               set division
 . N X S X=0 F  S X=$O(DIV(X)) Q:'+X  I +DIV(X) S DIV=X_U_$$GET1^DIQ(4,X,.01) Q  ;                                 set default division
 W !!,IOUON_"Required Parameters"_IOUOFF F I=1:1 S J=$P($T(DEBUG+I),";;",2) Q:J=""  D  Q:VAL'=""  ;                prompt user from debug list
 . N DIR S DIR(0)=$P(J,U,2),DIR("A")=$P(J,U,4),DIR("B")=$P(J,U,3)
 . S VAL=$$DIR(.DIR) S:+VAL P($P(J,U)_$S($P(J,U)="PDM":"P",1:""))=1 S VAL=$S(+VAL:$P(J,U),VAL=U:U,1:"") ;          ask & set tag for criteria
 G EXIT:VAL=U  S TAG=$S(VAL="":"USR",1:VAL),VAL=1 ;                                                                set criteria entry point
 I TAG="COS" S DIC=8925.1,DIC("A")="  Enter a DOCUMENT DEFINITION: ",DIC("S")="I $P(^(0),U,4)=""DOC""" D  K DIC ;  document definition for evaluation
 . S VAL=$$DIC(.DIC) Q:'VAL  S P("TYPE")=+VAL ;                                                                    ask for document definition
 . S P("DSC")=$$FIND1^DIC(8925.1,"","","DISCHARGE SUMMARY","","I $P(^(0),U,4)=""CL""","") ;                        set discharge summary class
 G EXIT:'VAL  W !!,IOUON_"Optional Parameters"_IOUOFF
 S DIC=19.1,DIC("A")="Enter a SECURITY KEY: ",VAL=$$DIC(.DIC) G EXIT:VAL=U  S P("KEY")=$S(+VAL:$P(VAL,U,2),1:"") ; security key
 S DIR(0)="DO",DIR("A")="Enter a DATE",VAL=$$DIR(.DIR) G EXIT:VAL=U  S P("DATE")=$S(+VAL:VAL,1:"") ;               date for evaluation
 I $S(TAG="ALL":0,TAG="RDV":0,TAG="PDM":0,1:1) D  G EXIT:VAL=U
 . S DIR(0)="YE",DIR("A")="Include Non-VA Providers",DIR("B")="NO",VAL=$$DIR(.DIR) Q:VAL=U  S P("NVAP")=VAL ;      ask Non-VA Provider
 . S DIR(0)="YE",DIR("A")="Screen for OR CPRS USER CLASS EXCLUDE parameter",DIR("B")="NO",VAL=$$DIR(.DIR) Q:VAL=U  S P("EXC")=VAL ; ask parameter definition
 I P("EXC") S P("ORUCE")=$$GET^XPAR("SYS","OR CPRS USER CLASS EXCLUDE",1,"B") ;                                    set ASU class
 F I=0:1 S J=$P($T(@TAG+I),";;",2,5) Q:J=""  S XEC(I)=J ;                                                          execution criteria [evaluated reverse order]
 S X=$$EVALUATE(.XEC,.P) W !!,$P(NODE0,U),$S(X:" would be selectable.",1:" would NOT be selectable.") ;            display results
 W ! K DIR S DIR(0)="E" D ^DIR
EXIT D CLEAN^XGF
 Q
