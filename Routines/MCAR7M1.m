MCAR7M1 ; HIRMFO/REL-Muse EKG ;6/7/00  10:11
 ;;2.3;Medicine;**24**;09/13/1996
 S EXAM=$P($P(SEG("OBR"),"|",5),"^",1) S:EXAM="" EXAM=99999
 S X=$T(@EXAM),FIL=$P(X,";",4),SUB=$P(X,";",5) I FIL=""!(SUB="") S ERRTX="Unknown Exam Type" G ^MCAR7X
 F P=1:1 S VAL=$T(VARS+P) Q:VAL=""  S SET($P(VAL,";",3))=$P(VAL,";",4,5)
 S X=$P($P(SEG("OBR"),"|",33),"^",1)
 I +X,$$GET1^DIQ(200,X,.01,"I")'="" S $P(SET("Interpreter"),";",3)=X
OBX ; Process OBX
 S X=$G(MSG(NUM)) G:X="" UPDATE I $E(X,1,3)'="OBX" S ERRTX="OBX not found when expected" G ^MCAR7X
 S SEG("OBX")=X
 S STYP=$P(X,"|",3) I STYP'="ST" G IMP
 S CODE=$P(X,"|",4),VAL=$P(X,"|",6),UNITS=$P(X,"|",7) I CODE["^" S CODE=$P(CODE,"^",2)
 I CODE=""!(VAL="") G NEXT
 I $D(SET(CODE)) S $P(SET(CODE),";",3)=VAL
NEXT S NUM=NUM+1 G OBX
IMP ; Get Impression
 S NUM=NUM+1,VAL=$P(X,"|",6) I STYP="CE" S VAL=$P(VAL,"^",2)
 S ICNT=ICNT+1,IMP(ICNT)=VAL G OBX
UPDATE ; Update File
 D PROC^MCAR7A ; Set Procedure Entry
 I EXAM=93000 S ID="" F  S ID=$O(SET(ID)) Q:ID=""  S P=$P(SET(ID),";",1) I P'="" S K=$P(SET(ID),";",2) I K'="" S VAL=$P(SET(ID),";",3) S:VAL'="" $P(^MCAR(FIL,DA,P),"^",K)=VAL
 I $D(IMP) F P=1:1:ICNT S ^MCAR(FIL,DA,SUB,P,0)=IMP(P)
 I  S ^MCAR(FIL,DA,SUB,0)="^^"_ICNT_"^"_ICNT_"^"_DT
 S DIK="^MCAR("_FIL_"," D IX1^DIK
 D GENACK^MCAR7X
 Q
93000 ;;EKG;691.5;9
93040 ;;Pacemaker;698.3;10
93015 ;;Exercise;691.7;6
93266 ;;Holter;691.6;7
93529 ;;Cath;691.1;43
93307 ;;Echo;691;3
93619 ;;Electrophysiology;691.8;12
VARS ;;
 ;;Interpreter;0;13
 ;;Systolic Blood Pressure;4;2
 ;;Diastolic Blood Pressure;4;1
 ;;Ventricular Rate;0;4
 ;;Atrial Rate;
 ;;P-R Interval;0;5
 ;;QRS Duration;0;6
 ;;QT;0;7
 ;;QTc;0;8
 ;;P Axis;0;9
 ;;QRS Axis;
 ;;T Axis;0;11
