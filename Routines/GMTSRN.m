GMTSRN ;SLC/JER - Renumber Selected Health Summary Type ; 08/27/2002
 ;;2.7;Health Summary;**36,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10026  ^DIR
 ;   DBIA 10076  ^XUSEC(
 ;   DBIA 10076  ^XUSEC("GMTSMGR")
 ;   DBIA 10013  ^DIK  (file #142)
 ;                     
MAIN ; Initializes Variables and Controls Branching
 N CHANGE,GMTSIFN,GMTSUM,GMTSEG,GMTSI,GMTSJ,GMTSQIT F  D SELECT Q:$D(GMTSQIT)  D COPY,RNMBR:CHANGE W !
 Q
SELECT ; Select Health Summary Type
 N DIR,GMTSKEY,GMTSMGR,GMTSOWN,X,Y
 W ! S DIR(0)="PO^142:AEMQZ" D ^DIR K DIR I $D(DIRUT) S GMTSQIT="" Q
 S GMTSIFN=+Y,GMTSUM=$P(Y,U,2)
 S GMTSKEY=$S($P(^GMT(142,GMTSIFN,0),U,2)]"":$P(^(0),U,2),1:" ZZZ"),GMTSOWN=$S($P(^(0),U,3)>0:$P(^(0),U,3),1:DUZ)
 S GMTSMGR=$S($D(^XUSEC("GMTSMGR",DUZ)):1,$D(^XUSEC(GMTSKEY,DUZ)):1,GMTSOWN=DUZ:1,1:0)
 I GMTSMGR Q
 I '$D(^XUSEC(GMTSKEY,DUZ)) W !,$C(7),"This summary is currently locked to prevent alteration.",! S GMTSQIT="" Q
 I GMTSOWN'=DUZ W !,$C(7),"Alteration of this summary is restricted to its owner.",!,"See the Clinical Coordinator if you need additional help." S GMTSQIT=""
 Q
COPY ; Copies Structure Multiple into GMTSEG(SEQ,
 N GMTSI,SEQ K GMTSEG S (CHANGE,GMTSI)=0 I '$D(^GMT(142,GMTSIFN,1,5)) S CHANGE=1
 F  S GMTSI=$O(^GMT(142,GMTSIFN,1,GMTSI)) Q:GMTSI'>0  W "." I GMTSI#5'=0 S CHANGE=1
 I 'CHANGE Q
 S (SEQ,GMTSI)=0 F  S GMTSI=$O(^GMT(142,GMTSIFN,1,GMTSI)) Q:GMTSI'>0  I $P(^(GMTSI,0),U,2) S SEQ=SEQ+1,GMTSEG(SEQ)=^(0) D GETSEL,PURGE W "."
 Q
GETSEL ; Gets Selection Items from Multiple
 N SN S SN=0 F  S SN=$O(^GMT(142,GMTSIFN,1,GMTSI,1,SN)) Q:SN'>0  S GMTSEG(SEQ,SN)=^(SN,0)
 Q
PURGE ; Deletes Old Node from ^GMT(142,GMTSIFN,1,GMTSI, using ^DIK
 N DA,DIK S DA(1)=GMTSIFN,DA=GMTSI,DIK="^GMT(142,"_GMTSIFN_",1," D ^DIK
 Q
RNMBR ; Traverses GMTSEG(SEQ) - Resets ^GMT(142,GMTSIFN,1,
 N DA,DR,DIE,ISEQ,SEQ,CCT S (CCT,SEQ)=0 F  S SEQ=$O(GMTSEG(SEQ)) Q:SEQ'>0  K DA S DIE="^GMT(142,"_GMTSIFN_",1,",DA(1)=GMTSIFN D LOADCMP^GMTSRM5 S CCT=CCT+1 W:CCT#2=0 "."
 Q
