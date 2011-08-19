PRCALST1 ;SF-ISC/YJK-AR LIST,REPORT ;7/14/93  8:46 AM
V ;;4.5;Accounts Receivable;**72,104**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN N CAT,CAT1,CAT2,CNO,CNT,CT3,CT4,DAT,DHD,DHIT,DISUPNO,DIOBEG
 N DT1,DT2,FT,FT2,IOP,LST,LST2,OT,PAGE,POP,PRCA,PRCAE,SAVIOP
 N SC1,SC2,SCT,SDT,SER,SRT,ST,STT,ST2,ST3,TMP,X,Y,ZTSK
 K ^TMP($J)
 S (CAT,OT)="",CNT=0
 S DAT=$$DATE^RCEVUTL1("^^^P^")
 S DT1=$S($P(DAT,"^")=0:"",1:+DAT)
 Q:+DT1<0
 S DT2=$P(DAT,"^",2),DT2=$S(DT2=0:"",1:DT2)
 Q:+DT2<0
 S SC1=$S(DT1="":"First",1:DT1) I +SC1>0 S Y=SC1 X ^DD("DD") S SC1=Y
 S SC2=$S(DT2="":"Last",1:DT2) I +SC2>0 S Y=SC2 X ^DD("DD") S SC2=Y
CAT K DIC S Y=0
 W !,"CATEGORY OF BILL: "_$S('$O(^TMP($J,"PRCAT",0)):"ALL// ",1:"")
 R X:DTIME I '$T!(X="^") Q
 I ((X="")!(X="ALL")),'$O(^TMP($J,"PRCAT",0)) S (CAT,X)="ALL" D ST Q:X="^"  G MAS
 S DIC="^PRCA(430.2,",DIC(0)="QEMZ"
 D ^DIC S CAT=+Y
 I X["?" W !!,"Enter 'ALL' categories or bills.",! G CAT
 I CAT'="ALL",(+CAT>0) S ^TMP($J,"PRCAT",+CAT)="" G CAT
 I X="" D ST Q:X="^"  G MAS
 G:+CAT<0 CAT
MAS N CT3
 D NOW^%DTC S Y=% X ^DD("DD") S SDT=Y,PAGE=1
 D PRINT Q:OT="^"
 I POP!($D(IO("Q"))) K IO("Q") D ^%ZISC Q
 D EN^PRCAREPC
 D ^%ZISC
 Q
PRINT ;Print or Queue report.
 W !! S IOP="Q",POP=0,%ZIS="MQ0"
 D ^%ZIS Q:POP
 S SAVIOP=$G(IOP)
 I $D(IO("Q")) D
    .S ZTRTN="EN^PRCAREPC",(ZTSAVE("CAT"),ZTSAVE("DT1"),ZTSAVE("DT2"))=""
    .S (ZTSAVE("OT"),ZTSAVE("PAGE"),ZTSAVE("SAVIOP"),ZTSAVE("SC1"))=""
    .S (ZTSAVE("SC2"),ZTSAVE("SCT"),ZTSAVE("SDT"),ZTSAVE("ST"))=""
    .S (ZTSAVE("^TMP($J,"))=""
    .S ZTDESC="Category Listing" D ^%ZTLOAD
    .I $G(ZTSK) W !!,"Request Queued"
    .Q
 Q
ST N DIC,Y
 S DIC="^PRCA(430.3,",DIC(0)="QEMZ",DIC("S")="I $P(^(0),""^"",3)>100"
 S Y=0 W !,"STATUS: "_$S('$O(^TMP($J,"PRCAST",0)):"ALL// ",1:"")
 R X:DTIME I '$T!(X="^") S X="^" Q
 I X=""!(X="ALL"),'$O(^TMP($J,"PRCAST",0)) S (ST,X)="ALL" Q
 I X="" Q
 D ^DIC S ST=+Y,SER=$G(SER)
 I X["?" W !!,"Enter 'ALL' for all status types.",! G ST
 I ST'="ALL",(+ST>0) S ^TMP($J,"PRCAST",+ST)="" G ST
 G:+ST<0 ST
 Q
