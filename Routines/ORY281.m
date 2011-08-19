ORY281 ;SLC/JLC-Search through Radiology/Imaging Quick Orders ;11/07/07  09:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**281**;Dec 17, 1997;Build 14
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 ; -- tasked entry point
 I $G(DUZ)="" W "Your DUZ is not defined.",! Q
 N ZTDESC,ZTIO,ZTRTN,ZTSK,ZTSAVE,ORCDD,ORCES
 S (ORCDD,ORCES)="",ZTSAVE("ORCDD")="",ZTSAVE("ORCES")=""
EN1A ;ask if user wants to clear date desired
 S DIR(0)="FAO",DIR("A")="Clear Date Desired with a response of ""TODAY""? ",DIR("?")="Enter Y or N"
 D ^DIR Q:X=""!(X="^")  S ORCDD=$TR(X,"yn","YN") I ORCDD'="Y",ORCDD'="N" W "  Enter Y or N" G EN1A
 I ORCDD="N" G TASK
EN2A ;ask if user wants to exclude STAT quick orders
 S DIR(0)="FAO",DIR("A")="Exclude quick orders with STAT urgency? ",DIR("?")="Enter Y or N"
 D ^DIR G EN1A:X="" Q:X="^"  S ORCES=$TR(X,"yn","YN") I ORCES'="Y",ORCES'="N" W "  Enter Y or N" G EN2A
TASK S ZTRTN="EN^ORY281",ZTIO=""
 S ZTDESC="Check of Radiology/Imaging Quick Orders"
 D ^%ZTLOAD
 W !!,"The check of Radiology/Imaging Quick Orders is",$S($D(ZTSK):"",1:" NOT")," queued",!
 I $D(ZTSK) W " (to start NOW).",!!,"YOU WILL RECEIVE A MAILMAN MESSAGE WHEN TASK #"_ZTSK_" HAS COMPLETED."
 Q
 ;
EN ; -- main entry point
 S:$D(ZTQUEUED) ZTREQ="@"
 N CREAT,EXPR,ORMAG,ORRAD,OROD,ORDR,ORDU,ORDUO,ORDUV,I,S1,S2,NS1,A,B,%,OR,XRAY,ABBREV,DA,DG,DG0,DIK,DIR,X
 D NOW^%DTC S CREAT=$E(%,1,7),EXPR=$$FMADD^XLFDT(CREAT,30,0,0,0) K ^XTMP("ORY281"),^TMP($J)
 ;PXRMD(801.41 reference - DBIA # 4097
 N DIEN,AFIND,TEXT,TYPE
 F TYPE="G","E" D
 . S DIEN="" F  S DIEN=$O(^PXRMD(801.41,"TYPE",TYPE,DIEN)) Q:DIEN'>0  D
 .. S TEXT=$P($G(^PXRMD(801.41,DIEN,1)),U,5)
 .. I TEXT[101.41 S ^TMP($J,$P(TEXT,";"))=""
 .. S AFIND="" F  S AFIND=$O(^PXRMD(801.41,DIEN,3,"B",AFIND)) Q:AFIND=""  D
 ... I AFIND'[101.41 Q
 ... S ^TMP($J,$P(AFIND,";"))=""
 ; 9.4 reference - DBIA # 2058
 S ORMAG=$O(^DIC(9.4,"B","IMAGING","")),ORRAD=$O(^DIC(9.4,"B","RADIOLOGY/NUCLEAR MEDICINE",""))
 S OROD=$O(^ORD(101.41,"B","OR GTX WORD PROCESSING 1","")),ORDR=$O(^ORD(101.41,"B","OR GTX START DATE/TIME",""))
 S ORDU=$O(^ORD(101.41,"B","OR GTX URGENCY","")),ORDUV=$O(^ORD(101.42,"B","STAT","")) I ORDUV="" S ORDUV="ORY281"
 F I="ANGIO/NEURO/INTERVENTIONAL","CARDIOLOGY STUDIES (NUC MED)","CT SCAN","GENERAL RADIOLOGY","IMAGING" D A
 F I="MAGNETIC RESONANCE IMAGING","MAMMOGRAPHY","NUCLEAR MEDICINE","ULTRASOUND","VASCULAR LAB" D A
 S XRAY=$O(^ORD(100.98,"B","XRAY",0)),DA=0
 F  S DA=$O(^ORD(100.98,XRAY,1,DA)) Q:'DA  S DG=$G(^(DA,0)) D
 . S DG0=$G(^ORD(100.98,DG,0)),ABBREV=$P(DG0,"^",3)
 . I $$ACTIVE^ORCDRA(ABBREV) S OR(DG)=""
 S ORD=0
 F  S ORD=$O(^ORD(101.41,ORD)) Q:'ORD  S A=$G(^(ORD,0)) I $P(A,"^",4)="Q" S B=$P(A,"^",7) D
 . I $P(A,"^",5)]"",'$D(OR($P(A,"^",5))) Q
 . I B'=ORMAG,B'=ORRAD Q
 . S ORDUO=""
 . S S1=0 F  S S1=$O(^ORD(101.41,ORD,6,S1)) Q:'S1  S B=$G(^(S1,0)) I $P(B,"^",2)=OROD!($P(B,"^",2)=ORDR)!($P(B,"^",2)=ORDU) D
 .. I $P(B,"^",2)=ORDU S ORDUO=$G(^ORD(101.41,ORD,6,S1,1)) Q
 .. I $P(B,"^",2)=OROD D  Q
 ... S S2=0 F  S S2=$O(^ORD(101.41,ORD,6,S1,2,S2)) Q:'S2  I $G(^(S2,0))]"" S ^XTMP("ORY281",ORD,S1)=$P(A,"^")_"^"_$P(A,"^",3),^XTMP("ORY281",ORD,S1,S2)="T: "_$G(^ORD(101.41,ORD,6,S1,2,S2,0))
 .. I $P(B,"^",2)=ORDR D
 ... S ^XTMP("ORY281",ORD,S1)=$P(A,"^")_"^"_$P(A,"^",3),^XTMP("ORY281",ORD,S1,"DATE")="D: "_$G(^ORD(101.41,ORD,6,S1,1))
 ... Q:ORCDD="N"  S A=$G(^ORD(101.41,ORD,6,S1,1)) I A="T"!(A="TODAY") D
 .... I ORDUO="" S NS1=S1 F  S NS1=$O(^ORD(101.41,ORD,6,NS1)) Q:'NS1  S B=$G(^(NS1,0)) I $P(B,"^",2)=ORDU S ORDUO=$G(^ORD(101.41,ORD,6,NS1,1)) Q
 .... I ORCES="Y" Q:ORDUO=ORDUV
 .... S DA(1)=ORD,DA=S1,DIK="^ORD(101.41,"_DA(1)_",6," D ^DIK
 I $D(^XTMP("ORY281")) S ^XTMP("ORY281",0)=EXPR_"^"_CREAT
 D SEND
 K ZTQUEUED,ZTREQ Q
SEND ;Send message
 K ORMSG,XMY N OCNT,ORD,A,S1,XMDUZ,XMSUB,XMTEXT,H1,H2,H3
 S XMDUZ="CPRS, SEARCH",XMSUB="RADIOLOGY/IMAGING QUICK ORDERS",XMTEXT="ORMSG(",XMY(DUZ)=""
 S ORMSG(1,0)="  The check of Radiology/Imaging Quick Orders is complete."
 S ORMSG(2,0)=" ",ORMSG(3,0)="  Here is the list of all quick orders that should be reviewed: ",ORMSG(4,0)=" "
 S ORD=0,ORMSG(5,0)="Quick Order Name                       Disable Text     Text or Start Date/Time                 Ancestors/Menus or Reminders"
 S ORMSG(6,0)="  ",OCNT=6
 F  S ORD=$O(^XTMP("ORY281",ORD)) Q:ORD=""  S S1=$O(^XTMP("ORY281",ORD,0)) Q:S1=""  S A=^(S1) D
 . S OCNT=OCNT+1,ORMSG(OCNT,0)=$E($P(A,"^")_$J(" ",38),1,37)_"  "_$E($P(A,"^",2)_$J(" ",38),1,15)_"  ",(H1,H2,H3)=""
 . I $D(^TMP($J,ORD)) S H2="Used in Clinical Reminders Dialog"
 . I $D(^ORD(101.41,"AD",ORD)) S H3="On a menu or in an order set"
 . S S1=0 F  S S1=$O(^XTMP("ORY281",ORD,S1)) Q:S1=""  S A=^(S1) D
 .. S S2=0 F  S S2=$O(^XTMP("ORY281",ORD,S1,S2)) Q:S2=""  S A=^(S2) I $TR(A," ")]"" D
 ... I H1 S OCNT=OCNT+1,ORMSG(OCNT,0)=$J(" ",56)
 ... S ORMSG(OCNT,0)=ORMSG(OCNT,0)_$E($P(A,"^")_$J(" ",39),1,38)_"  ",H1=1
 ... I H2]"" S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H2 S H2="" Q
 ... I H3]"" S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H3 S H3=""
 . I H2]"" S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H2
 . I H3]"" S:$L(ORMSG(OCNT,0))>97 OCNT=OCNT+1,ORMSG(OCNT,0)=$J(" ",97) S ORMSG(OCNT,0)=ORMSG(OCNT,0)_H3
 . S OCNT=OCNT+1,ORMSG(OCNT,0)=" "
 D ^XMD
 Q
A ;
 S A=$O(^ORD(100.98,"B",I,"")) I A]"" S OR(A)=""
 Q
