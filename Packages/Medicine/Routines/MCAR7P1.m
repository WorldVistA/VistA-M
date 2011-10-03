MCAR7P1 ; HIRMFO/REL-Sensormedics Pulmonary ;3/3/00  09:55
 ;;2.3;Medicine;**24**;09/13/1996
 S TCNT=0
OBX ; Process OBX
 S X=$G(MSG(NUM)) G:X="" UPDATE I $E(X,1,3)'="OBX" S ERRTX="OBX not found when expected" G ^MCAR7X
 S SEG("OBX")=X
 S STYP=$P(X,"|",3) I STYP="TX" G IMP
 S ID=$P(X,"|",5),CODE=$P(X,"|",4),VAL=$P(X,"|",6),UNITS=$P(X,"|",7) I CODE["^" S CODE=$P(CODE,"^",1)
 I CODE=""!(VAL="") G NEXT
 S CODE=$$UP^XLFSTR(CODE)
 I $E(CODE,1,3)'?2.3U G NEXT
 S STR=$P($T(@$E(CODE,1,3)),";;",2) I STR="" G NEXT
 S S=$P(STR,"^",2),P=$P(STR,"^",3),EXE=$P(STR,"^",4) I EXE'="" X EXE I VAL="" G NEXT
 I S="P" S $P(SET(S,+P),"^",$P(P,";",2))=VAL G NEXT
 I ID<4 S $P(SET(S,ID-1),"^",$P(P,";",2))=VAL I S="V",$P(CODE," ",1)="FRC" S VAL=$P($P(X,"|",4)," ",2) I VAL'="" S $P(SET(S,ID-1),"^",1)=$S(VAL["Dil":"N",1:"B")
NEXT S NUM=NUM+1 G OBX
IMP ; Get Impression
 S NUM=NUM+1,CODE=$P(X,"|",4)
 I CODE["Interp" S ICNT=ICNT+1,IMP("I",ICNT)=$P(X,"|",6) G OBX
 I CODE["Tech" S TCNT=TCNT+1,IMP("T",TCNT)=$P(X,"|",6) G OBX
 G OBX
UPDATE ; Update File
 S FIL=700 D PROC^MCAR7A ; Set Procedure Entry
 S P="" F  S P=$O(SET("P",P)) Q:P=""  F K=1:1:$L(SET("P",P),"^") S VAL=$P(SET("P",P),"^",K) I VAL'="" S $P(^MCAR(700,DA,P),"^",K)=VAL
 F ID="F","V" I $D(SET(ID)) D U1
 I ICNT F P=1:1:ICNT S ^MCAR(700,DA,25,P,0)=IMP("I",P)
 I ICNT S ^MCAR(700,DA,25,0)="^^"_ICNT_"^"_ICNT_"^"_DT
 I TCNT F P=1:1:TCNT S ^MCAR(700,DA,16,P,0)=IMP("T",P)
 I TCNT S ^MCAR(700,DA,16,0)="^^"_TCNT_"^"_TCNT_"^"_DT
 S DIK="^MCAR(700," D IX1^DIK
 D GENACK^MCAR7X
 Q
U1 ; Set Study values
 S S=$S(ID="F":4,ID="V":3,1:"") Q:'S
 I ID="F" F P=1,2 I $D(SET(ID,P)) S $P(SET(ID,P),"^",1)=$S(P=1:"S",1:"B")
 I ID="V" F P=1,2 I $D(SET(ID,P)) I $P(SET(ID,P),"^",1)="" S $P(SET(ID,P),"^",1)="B"
 I '$D(^MCAR(700,DA,S,0)) S ^MCAR(700,DA,S,0)="^"_$S(S=3:"700.017SA",1:"700.018SA")_"^0^0"
 S P=0 F  S P=$O(SET(ID,P)) Q:P=""  F K=1:1:$L(SET(ID,P),"^") S VAL=$P(SET(ID,P),"^",K) I VAL'="" S $P(^MCAR(700,DA,S,P,0),"^",K)=VAL
 S P=$O(SET(ID,""),-1),$P(^MCAR(700,DA,S,0),"^",3,4)=(P_"^"_P)
 Q
VARS ;;
FVC ;;FVC^F^0;2
FEV ;;FEV1^F^0;3
FEF ;;FEF25-75%^F^0;5
PEF ;;PEF^F^0;4
MVV ;;MVV^F^0;7
TLC ;;TLC^V^0;2
RV ;;RV^V^0;5
FRC ;;FRC^V^0;4
DLC ;;DLCO^P^5;1^I ID'=2 S VAL=""
HEI ;;HEIGHT^P^0;4
WEI ;;WEIGHT^P^0;5
SMO ;;SMOKER^P^0;8^S VAL=$E($G(VAL),1)
TEM ;;TEMP^P^0;12
PBA ;;PBAR^P^0;7
VC ;;VC^V^0;3
