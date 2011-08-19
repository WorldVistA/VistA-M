PRSEPOL0 ;HISC/DAD,MD-OLDE TRAINING CODING REPORT ;3/31/94
 ;;4.0;PAID;;Sep 21, 1995
EN1 ; ENTRY POINT FROM OPTION 
 S X=$G(^PRSE(452.7,1,"OFF")) I X=""!(X=1) D MSG6^PRSEMSG Q
 D EN2^PRSEUTL3($G(DUZ))
 I PRSESER'>0,'(DUZ(0)="@") D MSG3^PRSEMSG S PRSEQUIT=1 G EXIT
 K PSP,PSPC S PSPC=PRSESER,PSPC("TX")=PRSESER("TX"),PSP=0
 I (DUZ(0)["@"!(+$$EN4^PRSEUTL3($G(DUZ)))) D  G:PRSEQUIT EXIT
 . K POUT D EN3^PRSEUTL1 S PRSEQUIT=$S($D(POUT):1,1:0)
 . S PSP=+$G(PSP),PSPC("TX")=$G(PSPC),PSPC=+$G(PSPC(1))
 . Q
 I PSP S PRSESEL="A" G CONT
SELECT K DIR S DIR(0)="SO^A:(A)ll Employees For a Service;S:(S)elected Service Employees",DIR("A")="Select ASSIGNMENT OPTION" D ^DIR
 S PRSESEL=Y I $D(DIRUT) S PRSEQUIT=1 G EXIT
 I PRSESEL="S" W ! K PRSEXMY F  S Y=-1 W !,$S($O(PRSEXMY(0))>0:"Select Another Employee: ",1:"Select EMPLOYEE: ") R X:DTIME S:'$T X="^^" S:X="" Y="" Q:"^^"[X  D  Q:(Y<0)
 . I X["?" D
 .. D MSG21^PRSEMSG I '($O(PRSEXMY(0))>0) S Y=1
 .. I Y'=1 D MSG2^PRSEMSG S Y=1
 .. Q
 . S PRSEN=0 S:"'-"[$E(X) X=$E(X,2,999),PRSEN=1
 . S DIC("S")="I $P($G(^PRSPC(+Y,1)),U,33)'=""Y"",$S($G(PSPC)&($G(PSPC(""TX""))=$$EN2^PRSEUTL4(+$G(Y))):1,1:"""")"
 . S DIC="^PRSPC(",DIC(0)="ZEQ" D ^DIC K DIC I Y'>0,X]"" S Y=0 Q
 . I Y>0,PRSEN W $S($D(PRSEXMY(+Y)):"  Deleted.",1:"  Not selected.") K PRSEXMY(+Y) Q
 . S (X,PRSEXMY(+Y))=""
 . Q
 I PRSESEL="S",'$D(PRSEXMY) S PRSEQUIT=1 G EXIT
CONT ;
 K POUT S DATSEL="N+" D DATSEL^PRSEUTL I $D(POUT) S PRSEQUIT=1 G EXIT
 K DIR S DIR(0)="SOM^C:Complete records;I:Incomplete records;"
 S DIR("A")="Select records to print"
 S DIR("?",1)="'Complete' will only print those records with full OLDE data."
 S DIR("?",2)="'Incomplete' will only print those records without full OLDE data."
 S DIR("?")=" Enter either 'Complete' or 'Incomplete'."
 D ^DIR S PRSETYPE=Y I $D(DIRUT) S PRSEQUIT=1 G EXIT
DEV ;
 S ZTRTN="ENTSK^PRSEPOL1" S (ZTSAVE("PSP"),ZTSAVE("PRSESEL"),ZTSAVE("PRSEXMY("),ZTSAVE("PSPC("),ZTSAVE("PYR"),ZTSAVE("TYP"),ZTSAVE("YRST("),ZTSAVE("YREND("),ZTSAVE("PSPC"),ZTSAVE("YRST"),ZTSAVE("YREND"),ZTSAVE("PRSETYPE"))=""
 S ZTDESC="Education Tracking report for OLDE training coding input"
 K %ZIS,IOP D DEV^PRSEUTL G:POP!($D(ZTSK)) EXIT
 D ENTSK^PRSEPOL1
EXIT ;
 S POUT=$G(PRSEQUIT) D CLOSE^PRSEUTL
 K ^TMP("PRSE",$J) D ^PRSEKILL
 Q
