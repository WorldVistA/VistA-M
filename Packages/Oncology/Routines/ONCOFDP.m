ONCOFDP ;Hines OIFO/GWB - FOLLOW DEAD PATIENTS ;07/12/00
 ;;2.11;ONCOLOGY;**1,5,16,22,25,26,47**;Mar 07, 1995;Build 19
DEAD ;Death information
 K DXS,DIOT S D0=ONCOD0,DIR("A")=" Edit Data",DIR("B")="Y",DIR(0)="Y"
 D ^ONCOXDI,^DIR G ED:Y,RC:'Y,EX
 ;
ED W !! S DA=ONCOD0,DR="[ONCO DEATH]",DIE="^ONCO(160," D ^DIE
 W !! K DXS,DIOT D ^ONCOXDI
 S DIR("A")=" Data OK",DIR("B")="Yes",DIR(0)="Y" D ^DIR G ED:'Y,RC:Y,EX
 ;
RC W !!,"First Recurrence Information..."
 S XD1=0,UPOUT=""
 F  S XD1=$O(^ONCO(165.5,"C",ONCOD0,XD1)) Q:XD1'>0  D  Q:UPOUT="Y"
 .S ONCOX2=$G(^ONCO(165.5,XD1,2)),ONCOTOP=$P(ONCOX2,U,1)
 .S TOP=$P($G(^ONCO(164,+ONCOTOP,0)),U,1)
 .S SITEGP=$P(^ONCO(165.5,XD1,0),U,1)
 .S ACCNO=$P(^ONCO(165.5,XD1,0),U,5),SEQNO=$P(^ONCO(165.5,XD1,0),U,6)
 .W !!,"Primary: ",$E(ACCNO,1,4),"-",$E(ACCNO,5,9),"/",SEQNO,"  ",TOP,!
 .S DIE="^ONCO(165.5,",DA=XD1,DR="71;D CHECK^ONCOFDP;70;@1" D ^DIE I $D(Y) S UPOUT="Y"
 D CHKCHG^ONCOAIF
 ;
DC ;Delete Contacts
 Q:'$D(^ONCO(160,"APC",ONCOD0))
H W @IOF,!!!?15,"--------------DELETE PATIENT'S CONTACTS---------------"
 S D0=ONCOD0 K DXS,DIOT D ^ONCOXCL
 W !!?5,"Patient is dead - please delete contacts as soon as possible."
 W !?5,"Deletion will affect this patient's contacts only.",!
 S DIR("A")="     Delete Contacts",DIR(0)="Y",DIR("B")="Yes" D ^DIR,KC:Y
 Q
 ;
KC ;Delete FOLLOW-UP CONTACT (160.03) sub-file and CONTACT (165) file
 ;entries
 D WAIT^DICD W !?5,"Deleting contacts..." D EN1 G EX
EN1 S XDC=0 F  S XDC=$O(^ONCO(160,"APC",ONCOD0,XDC)) Q:XDC'>0  S ONCOC0=XDC D  I C=0 S DIK="^ONCO(165,",DA=ONCOC0 D ^DIK W "*"
 .S C=0
 .S XDP=0 F  S XDP=$O(^ONCO(160,"ACP",ONCOC0,XDP)) Q:XDP'>0  I XDP'=ONCOD0 S C=1 Q
 .I C=1 Q
 .S XDP=0 F  S XDP=$O(^ONCO(160,"AC",ONCOC0,XDP)) Q:XDP'>0  I XDP'=ONCOD0 S C=1 Q
 .I C=1 Q
 .S XDP=0 F  S XDP=$O(^ONCO(160,"AE",ONCOC0,XDP)) Q:XDP'>0  I XDP'=ONCOD0 S C=1 Q
 .I C=1 Q
 .I $D(^ONCO(165.5,"APS",ONCOC0)) S C=1 Q
 .I $D(^ONCO(165.5,"AFP",ONCOC0)) S C=1 Q
 .I $D(^ONCO(165.5,"AMP",ONCOC0)) S C=1 Q
 .I $D(^ONCO(165.5,"AOP3",ONCOC0)) S C=1 Q
 .I $D(^ONCO(165.5,"AOP4",ONCOC0)) S C=1 Q
 .I $D(^ONCO(165.5,"APST",ONCOC0)) S C=1 Q
 ;Delete FOLLOW-UP CONTACT (160,420) sub-file (160.03)
 S DA=0,DA(1)=ONCOD0 F  S DA=$O(^ONCO(160,DA(1),"C",DA)) Q:DA'?1.N  S DIK="^ONCO(160,"_DA(1)_",""C""," D ^DIK
 I '$D(ONCODAC) S D0=ONCOD0 D ^ONCOXCL W ?35,"(None - Patient is Deceased)"
 N ONCOC0 S ONCOC0=$P(^ONCO(160,ONCOD0,1),U,6) G KA:ONCOC0="",KA:$D(^ONCO(165,ONCOC0,0))
CD S X="<CONTACT DELETED>",Y=$O(^ONCO(165,"B",X,0))
 I Y="" S (DIC,DLAYGO)="^ONCO(165,",DIC(0)="ZL" D FILE^DICN
 S OLDLFC=$P($G(^ONCO(160,ONCOD0,1)),U,6)
 K:OLDLFC'="" ^ONCO(160,"AC",OLDLFC,ONCOD0)
 S $P(^ONCO(160,ONCOD0,1),U,6)=+Y
 S ^ONCO(160,"AC",+Y,ONCOD0)=""
 K OLDLFC
KA ;Delete FOLLOW-UP ATTEMPTS (160,410) sub-file (160.06)
 W:'$D(ONCODAC) !!?5,"Deleting Follow-up Attempts..."
 S XX=$P($G(^ONCO(160,ONCOD0,"A",0)),U,3) I XX'="" S DIK="^ONCO(160,"_DA(1)_",""A""," F DA=1:1:XX I $D(^(DA)) D ^DIK
 F I="A","C" K ^ONCO(160,DA(1),I)
 Q
 ;
DAC ;Delete dead patients's Contacts
 W @IOF,"ARCHIVING of Contact File, Attempts and Contacts"
 W !!?5,"For dead patients - clean out unnecessary data.",!!!
 W ?5,"Working..."
 S XD0=0 F  S XD0=$O(^ONCO(160,"AS",0,XD0)) Q:XD0'>0  S ONCOD0=XD0,ONCODAC=1 D EN1 W:'(XD0#100) "."
EX ;RETURN from calling program, ONCOAIF/ONCOFUL
 K RC,RT,XD0,XX,XD1,XDC,I,DIK,DIC,XDP,ONCOD1
 Q
CHECK ;Check TYPE of FIRST RECURRENCE
 ;If 99, stuff 99/99/9999 into DATE of FIRST RECURRENCE
 ;If 00 or 70, stuff 00/00/0000 into DATE of FIRST RECURRENCE
 S TOFR=$P($G(^ONCO(165.5,XD1,5)),U,2)
 Q:TOFR=""
 I $P($G(^ONCO(160.12,TOFR,0)),U,1)=99 D
 .S $P(^ONCO(165.5,XD1,5),U,1)=9999999
 .W !,"DATE of FIRST RECURRENCE: 99/99/9999//"
 .S Y="@1"
 I ($P($G(^ONCO(160.12,TOFR,0)),U,1)="00")!($P($G(^ONCO(160.12,TOFR,0)),U,1)=70) D
 .S $P(^ONCO(165.5,XD1,5),U,1)="0000000"
 .W !,"DATE of FIRST RECURRENCE: 00/00/0000//"
 .S Y="@1"
