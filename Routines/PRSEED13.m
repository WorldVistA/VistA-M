PRSEED13 ;HISC/MD-EMPLY MANDATORY TRAINING GRP/CLAS ENTER/EDIT ;12/93
 ;;4.0;PAID;;Sep 21, 1995
EN1 ; OPTION PRSE-MI
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!(X=1) D MSG6^PRSEMSG Q
 D EN2^PRSEUTL3($G(DUZ)) I PRSESER'>0 D MSG3^PRSEMSG S POUT=1 G QQ
 S PSPC=$G(PRSESER),PSPC("TX")=$G(PRSESER("TX"))
SELECT S DIR(0)="SO^A:(A)ll Employees For a Service;"_$S((+$$EN4^PRSEUTL3($G(DUZ))!(DUZ(0)["@")):"M:(M)ultiple Services - All Employees;",1:"")_"S:(S)elected Service Employees",DIR("A")="Select ASSIGNMENT OPTION"
 D ^DIR K DIR G QQ:$G(DIRUT) S PRSESEL=Y
 I PRSESEL="M" D EN1^PRSEUTL6 G:+$G(POUT) QQ
 S DIR(0)="SO^A:(A)dd Group(s);D:(D)elete Group(s)"_$S(PRSESEL="S":";E:(E)nter/Edit Class(es)",1:""),DIR("A")="Select ACTION" D ^DIR K DIR G:$G(DIRUT) QQ S PRSEACT=Y
 I ($G(PRSESEL)="S"!($G(PRSESEL)="A")),(DUZ(0)["@"!(+$$EN4^PRSEUTL3($G(DUZ)))) D  G:$G(DIRUT) QQ
 .W ! S DIC=454.1,DIC(0)="AEQZ",DIC("S")="I $P(^(0),U)'=""MISCELLANEOUS"""
 .S DIC("A")="Select SERVICE: " S:$G(PRSESER("TX"))'="" DIC("B")=PRSESER("TX") D ^DIC K DIC S PSPC=+Y,PSPC("TX")=$P($G(Y),U,2)
 I PRSEACT="A" W ! S %DT("A")="DATE ASSIGNED: ",%DT("B")="TODAY",%DT="AE" D ^%DT G:Y'>0 QQ S PRSEDT=Y
 I '(PRSEACT="E") D DISP^PRSEUTL4 I $G(POUT) S POUT=0 G SELECT
 I PRSESEL="S" W ! K PRSEXMY F  K POUT S Y=-1 W !,$S($O(PRSEXMY(0))>0:"Select Another Employee: ",1:"Select EMPLOYEE: ") R X:DTIME S:'$T X="^^" S:X="" Y="" Q:"^^"[X  D  Q:(Y<0)
 .I X["?" D
 ..D MSG21^PRSEMSG I '($O(PRSEXMY(0))>0) S Y=1
 ..I Y'=1 D MSG2^PRSEMSG S Y=1
 ..Q
 .S PRSEN=0 S:"'-"[$E(X) X=$E(X,2,999),PRSEN=1
 .S DIC("S")="I $P($G(^PRSPC(+Y,1)),U,33)'=""Y""&($G(PSPC(""TX""))=$$EN2^PRSEUTL4(+$G(Y)))!($$EN4^PRSEUTL3($G(DUZ)))",DIC="^PRSPC(",DIC(0)="EQZ" D ^DIC I Y'>0,X]"" S Y=0 Q
 .I Y>0,PRSEN W $S($D(PRSEXMY(+Y)):"  Deleted.",1:"  Not a current recipient") K PRSEXMY(+Y) Q
 .S (X,PRSEXMY(+Y))=""
 .Q
 G:X["^" QQ
 I PRSESEL="S",'$D(PRSEXMY) G QQ
 I PRSESEL="S" W ! F PRSEDA=0:0 S PRSEDA=$O(PRSEXMY(PRSEDA)) Q:PRSEDA'>0  D
 .;GRP EDIT
 .S DA=PRSEDA I $D(^PRSPC(DA,0)) W:PRSEACT="E" @IOF,$P($G(^(0)),U) S:'$D(^PRSPC(DA,6,0)) ^(0)="^450.0633PA^^"
 .I PRSEACT="E" D 
 ..;CLAS EDIT
 ..S:'$D(^PRSPC(DA,6,0)) ^(0)="^450.0633PA^^" S DR="633",DR(2,450.0633)=".01;S:$P($G(^PRSPC(DA(1),6,DA,0)),U,3) Y=""@3"";.03///TODAY;S X=X;@3;.03",DIE="^PRSPC(" D ^DIE,EN1^PRSEUTL5(PRSEDA) K DR
 ..Q
 .Q:PRSEACT="E"  S PRSEROUT=$S(PRSEACT="A":"ADD",PRSEACT="D":"DEL",1:"") D:$G(PRSEROUT)'="" @(PRSEROUT)
 .Q
 I ($G(PRSESEL)="A"!($G(PRSESEL)="M")) D
 .F X="PRSEDT","PRSEMI(","PRSEACT","PRSESEL","PSPC","PSPC(","^TMP(""PRSEMP"",$J,","^TMP(""PRSESRV"",$J,","^TMP(""PRSEGRP"",$J," S ZTSAVE(X)=""
 .S ZTRTN="START^PRSEED13",ZTIO="",ZTDTH=$H,ZTDESC="Education Tracking Employee Mandatory Grp Update" D ^%ZTLOAD
 .K ZTDTH,ZTDESC,ZTRTN,ZTSAVE,ZTIO
 .I $D(ZTSK) W !!,"This/These group(s) will be "_$S(PRSEACT="A":"assigned",1:"deleted")_" by a background Job."
 .Q
 W ! G SELECT
ADD ;ADD MI GRP
 S DA(1)=PRSEDA F PRSEX=0:0 S PRSEX=$O(^TMP("PRSEGRP",$J,PRSEX)) Q:PRSEX'>0  D
 .I $E(IOST)="C",$D(^PRSPC(DA(1),5,"B",PRSEX)) W $C(7),!,$P($G(^PRSPC(DA(1),0)),U)," is assigned the ",$P($G(^PRSE(452.3,+PRSEX,0)),U,1)," group!" Q
 .I '$D(^PRSPC(DA(1),5,"B",PRSEX)),$P($G(^PRSPC(DA(1),1)),U,33)'="Y" K DD,DO S DA(1)=PRSEDA,DLAYGO=450.0632,DIC="^PRSPC(DA(1),5,",X=PRSEX,DIC(0)="EL",DIC("P")="450.0632P",DIC("DR")=".02///^S X=PRSEDT" D FILE^DICN K DIC D EN1^PRSEUTL5(PRSEDA)
 .Q
 Q
DEL ;REMOVE MI GRP
 S DA(1)=PRSEDA F PRSEX=0:0 S PRSEX=$O(^TMP("PRSEGRP",$J,PRSEX)) Q:PRSEX'>0  D
 .W:$E(IOST)="C" "." I $D(^PRSPC(DA(1),5,"B",PRSEX)) S DA=$O(^PRSPC(DA(1),5,"B",PRSEX,0)),DIK="^PRSPC(DA(1),5," D ^DIK K DIK D EN1^PRSEUTL5(PRSEDA)
 .I $O(^PRSPC("ARG",PRSEX,0))'>0,'$D(ZTQUEUED) D
 ..W !!,$P($G(^PRSE(452.3,+PRSEX,0)),U),!,"There are no assignees for this training group do you want to delete it"
 ..S %=2 D YN^DICN
 ..I %=1 S DIK="^PRSE(452.3,",DA=PRSEX D ^DIK
 ..Q
 .Q
 Q
QQ K ^TMP("PRSESRV",$J),^TMP("PRSEMP",$J),^TMP("PRSEGRP",$J) D ^PRSEKILL
 Q
START ;TASKMAN ENTRY POINT
 K ^TMP("PRSEMP",$J) S:PRSESEL="A" ^TMP("PRSESRV",$J,PSPC)="" F PSPC(1)=0:0 S PSPC(1)=$O(^TMP("PRSESRV",$J,PSPC(1))) Q:PSPC(1)'>0  D
 .S PRS454=0
 .F  S PRS454=$O(^PRSP(454,1,"ORG","C",PSPC(1),PRS454)) Q:PRS454'>0  D
 ..S CORGCODE=$TR($P($G(^PRSP(454,1,"ORG",PRS454,0)),U),":")
 ..I CORGCODE]"" D
 ...S DA=0 F  S DA=$O(^PRSPC("ACC",CORGCODE,DA)) Q:DA'>0   S:$G(^PRSPC(DA,0))'="" ^TMP("PRSEMP",$J,DA)=""
 ...Q
 ..Q
 .Q
 F PRSEDA=0:0 S PRSEDA=$O(^TMP("PRSEMP",$J,PRSEDA)) Q:PRSEDA'>0  S PRSEROUT=$S(PRSEACT="A":"ADD^PRSEED13",PRSEACT="D":"DEL^PRSEED13",1:"") D @(PRSEROUT)
 S XQAMSG="Mandatory Training Group(s) "_$S(PRSEACT="A":"assigned",1:"deleted")_" for "_$S(PRSESEL="A":PSPC("TX"),1:"Selected Service(s)"),XQA(DUZ)="" D SETUP^XQALERT
 D QQ
 Q
