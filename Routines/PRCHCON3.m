PRCHCON3 ;WISC/KMB CREATE PURCHASE CARD FROM TEMP REQ ;1/8/97
 ;;5.1;IFCAP;**92**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
START ;
SETUP ;create 442 entry
 D ENPO^PRCHUTL I '$D(DA) S OUT=1 W !,"Unable to create 442 entry.  Try later." H 3 Q
SETUP1 ;
 S (PRCHPO,PDA)=DA L +^PRC(442,PDA):15 E  W !!,$C(7),"Another user is editing this entry, try later." K PDA Q
 S DIE="^PRC(442,",DR="62////"_NDA_";"_"5.2///"_SERV_";"_".8///3" S:$G(FLAG)'=1 DR=DR_";"_".02///25"_";"_"48///P" D ^DIE
 I VENDOR'="" S DR="53////"_VENDOR_";"_"5////"_VENDOR D ^DIE
 I $G(FLAG)=1 S DR=".02///1"_";"_"47///Y"_";"_"48///D" D ^DIE
 S $P(^PRC(442,PDA,0),"^",3)=FCP,$P(^(0),"^",5)=CCEN,$P(^(23),"^",7)=PRC("SST")
 S DIE="^PRC(442,",DR=".03///"_SPEC_";"_".1///"_TDATE D ^DIE
 S $P(^PRC(442,PDA,1),"^",10)=DUZ,^PRC(442,"E",CP,PDA)=""
 ;
 S DR="52///"_CR_";"_"56///"_DUZ_";"_"63///1"_";"_"60///"_NCOST D ^DIE
 S $P(^PRC(442,PDA,23),U,13)=SG
 I $G(VENDOR)'="" D SETIT
 E  W !!,"This request has no entry in the Vendor File."
 L -^PRC(442,PDA)
 I $G(VENDOR)="" W !,"You must edit a request with no entry in the Vendor File.",! D LOOP1 Q 
 I REM1'=+$P(PRC("CP")," ") W !,"Since the control point is changed, you must edit this request." D LOOP1 Q
 L +^PRC(442,PDA):15 E  W !!,$C(7),"Another user is editing this entry, try later." K PDA Q 
 S $P(^PRC(442,PDA,1),"^")=VENDOR,$P(^(23),"^",14)=VENDOR,$P(^(23),"^",23)=NDA,^PRC(442,"D",$E(VENDOR,1,30),PDA)=""
 L -^PRC(442,PDA)
 D LOOP
 Q
 ;
SETIT ; set item data on 442 record
 Q:$G(CNNT)=""  F II=1:1:CNNT D
 .S ^PRC(442,PDA,2,II,0)=AA(II)
 .I $G(CNT) F J=1:1:CNT S ^PRC(442,PDA,2,II,1,J,0)=$G(BB(II,J))
 .S ^PRC(442,PDA,2,II,2)=CC(II)
 .I $G(CNT) S ^PRC(442,PDA,2,II,1,0)="^^"_CNT_"^"_CNT_"^"_TDATE_"^"
 .S ^PRC(442,PDA,2,"B",II,II)="",^PRC(442,PDA,2,"C",II,II)=""
 .S (PRCHCI,PRCHCII,X)=$P(AA(II),U,5) Q:PRCHCI=""  S (DA(1),PRCHCPO)=PDA,DA=II,PRCHCCP=CP,PRCHCPD=TDATE,PRCHCV=VENDOR D EN3^PRCHCRD S ^PRC(442,PDA,2,"AE",PRCHCII,II)=""
 S ^PRC(442,PDA,2,0)="^442.01IA^"_CNNT_"^"_CNNT
 K DIE
 Q
LOOP ;
 ;Correction for NOIS ISW-0599-21097
 S PRCHSY=NDA
 W ! D SPRMK^PRCHNPO6 W !
 ;End NOIS correction
 ;
 S %=1 W !,"Edit request ",$P(^PRC(442,PDA,0),"^") D YN^DICN G:%=0 LOOP Q:%=2
LOOP1 W @IOF S (PRCHPO,DA)=PDA,PRC("PER")=DUZ,X=1
 L +^PRC(442,PDA):15 E  W !!,$C(7),"Another user is editing this entry, try later." K PDA Q
 D ^PRCHNPO L -^PRC(442,PDA) K PRC("PER"),X,PRCHPO
 Q
