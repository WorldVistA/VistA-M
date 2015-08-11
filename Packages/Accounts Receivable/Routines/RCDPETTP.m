RCDPETTP ; ePayments/CNF, hrubovcak - EDI Testing Tool ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**; 20 Dec 2013;Build 121
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
USRPREF ; edit user preferences in file #344.82
 ;
 D DONOTUSE^RCDPETTU
 ;
 N D,D0,DA,DDH,DI,DIC,DIE,DQ,DR,DZ,RCFLNO,X,Y
 S RCFLNO=344.82
 I '$D(^RCY(RCFLNO,0)) W !,"File "_RCFLNO_" not found."_$C(7),! Q
 I '$D(^RCY(RCFLNO,DUZ)) D  ; create new entry
 .N RCDIERR,RCIENRT,RCIENS
 .S RCIENS(RCFLNO,"+1,",.01)=DUZ
 .S RCIENS(RCFLNO,"+1,",.02)=$$NOW^XLFDT
 .S RCIENRT(1)=DUZ  ; DINUM to NEW PERSON file
 .D UPDATE^DIE("","RCIENS","RCIENRT","RCDIERR")
 ;
 ; user interaction to edit allowed fields
 W ! S DIE=RCFLNO,DA=DUZ,DR="1.01;1.02" D ^DIE,UPDT
 ;
 Q
 ;
LKUP102 ; called from inside FileMan for file #344.82 field #1.02
 Q:X=""  S X=$$UP^RCDPETTU(X)
 N J,S,T,V
 ; build array in V
 F J=1:1 S T=$P($T(VAL102+J),";;",2) Q:T=""  S S=$P(T,U),V(S)=$P(T,U,2)
 ; check to see if text matches
 I '$D(V(X)) S S="" F  S S=$O(V(S)) Q:$D(V(X))!(S="")  I $E($$UP^RCDPETTU(V(S)),1,$L(X))=X S X=S
 I '$D(V(X)) K X Q  ; invalid selection
 W "   "_V(X)  ; echo back to user
 ;
 Q
 ;
FLD101 ; XECUTEable help for field 1.01 PAYER ID DEFAULT
 ; called by FileMan, so NEW all variables
 W !,"Enter a value for PAYER ID DEFAULT to be used for testing."
 W !,"It cannot start with a space.",!
 ;
 Q
 ;
FLD102 ; XECUTEable help for field 1.02 PAYMENT METHOD CODE
 ; called by FileMan, so NEW all variables
 W !,"Enter a PAYMENT METHOD CODE for editing an EEOB list."
 W !," Choose from:"
 N J,T
 F J=1:1 S T=$P($T(VAL102+J),";;",2) Q:T=""  W !,"   "_$P(T,U)_"    "_$P(T,U,2)
 W ! Q
 ;
UPDT ; UPDATED field (#.02)
 S $P(^RCY(344.82,DUZ,0),U,2)=$$NOW^XLFDT Q
 ;
VAL102 ; values for field 1.02
 ;;ACH^Automated Clearing House
 ;;BOP^Financial Institution Option
 ;;CHK^Check
 ;;FWT^Federal Reserve Funds /Wire Transfer
 ;;NON^Non-Payment Data
 ;
