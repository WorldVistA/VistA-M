PSSHL1 ;BIR/RLW/WRT-BUILD HL7 MESSAGE TO POPULATE ORDERABLE ITEM FILE ;09/08/97
 ;;1.0;PHARMACY DATA MANAGEMENT;**38,68,125**;9/30/97;Build 2
 ;External reference to ORD(101 supported by DBIA 872
 ; PSJEC=event code from HL7 table 8.4.2.1
 ; PSJSPIEN=ien to super-primary drug file (#50.7)
 ; SPDNAME=.01 field (name) of super-primary drug
 ; LIMIT=number of fields in HL7 segment being built
 ;
 W !!?3,"This routine should not be accessed through programmer mode!",!
 Q
EN1 ; start here for pre-install auto load
 N MENU,MENUP,ITEM
 D PRO Q:$G(XPDABORT)
 S PSSMFU=+$O(^PS(59.7,0)) I $P(^PS(59.7,PSSMFU,80),"^",2)=4 K PSSMFU Q
 N APPL,CODE,FIELD,LIMIT,MFE,PSJI,SEGMENT,SPDNAME,SYN,SYNONYM,USAGE,X
 I '$D(^XTMP("PSO_V7 INSTALL",0)) S X1=DT,X2=+7 D C^%DTC S ^XTMP("PSO_V7 INSTALL",0)=DT_"^"_X_"^OUTPATIENT V7 KIDS INSTALL" L +^XTMP("PSO_V7 INSTALL",0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) G SKIP
 F  Q:'$D(^XTMP("PSO_V7 INSTALL",0))  L +^XTMP("PSO_V7 INSTALL",0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) Q:$T
 I '$D(^XTMP("PSO_V7 INSTALL",0)) S X1=DT,X2=+7 D C^%DTC S ^XTMP("PSO_V7 INSTALL",0)=DT_"^"_X_"^OUTPATIENT V7 KIDS INSTALL" L +^XTMP("PSO_V7 INSTALL",0):$S($G(DILOCKTM)>0:DILOCKTM,1:3)
 I $P(^PS(59.7,PSSMFU,80),"^",2)=4 L -^XTMP("PSO_V7 INSTALL",0) K ^XTMP("PSO_V7 INSTALL",0) Q
SKIP ;
 S PSJEC="MAD",CODE="REP"
 D INIT
 D LOOP,MF^PSSHLU(PSJI)
 S PSLSITE=+$O(^PS(59.7,0)) S $P(^PS(59.7,PSLSITE,80),"^",2)=4 K PSLSITE
 L -^XTMP("PSO_V7 INSTALL",0) K ^XTMP("PSO_V7 INSTALL",0)
 K ^TMP("HLS",$J,"PS"),PSJEC,PSJSPIEN,PSJCLEAR,PSSMFU Q
 ;
EN2(PSJSPIEN,PSJEC) ; start here for "manual" update
 S PSLSITE=+$O(^PS(59.7,0)) I +$P($G(^PS(59.7,PSLSITE,80)),"^",2)<4 K PSLSITE Q
 ; passed in: internal entry # of super-primary drug, entry code
 S:'$P($G(^PS(50.7,PSJSPIEN,0)),"^",4) PSJEC="MAC"
 K PSLSITE N APPL,CODE,FIELD,PSJI,LIMIT,MFE,SEGMENT,SPDNAME,SYN,SYNONYM,USAGE,X,ZCOUNT,ZUSAGE
 S CODE="UPD"
 D INIT
 D MFE(PSSIVID),MF^PSSHLU(PSJI)
 K ^TMP("HLS",$J,"PS")
 Q
 ;
 ;
INIT ; initialize HL7 variables, set master file identification segment fields
 S PSJI=0,LIMIT=6,HLMTN="MFN",PSSIVID=$$GTIVID()
 D INIT^PSSHLU X PSJCLEAR
 S FIELD(0)="MFI"
 S FIELD(1)="50.7^PHARMACY ORDERABLE ITEM^99DD"
 S FIELD(3)=CODE
 S FIELD(6)="NE"
 D SEGMENT^PSSHLU(LIMIT)
 Q
 ;
LOOP ; loop through PHARMACY ORDERABLE ITEM file
 ;F  L +^PS(59.7,PSSIVID,31) Q:$T  H 1
 S PSJSPIEN=0 F  S PSJSPIEN=$O(^PS(50.7,PSJSPIEN)) Q:'PSJSPIEN  D MFE(PSSIVID)
 ;L -^PS(59.7,PSSIVID,31)
 Q
 ;
MFE(PSSIVID) ; set master file entry segment fields
 ; Input: PSSIVID-IV Identifier
 S LIMIT=4 X PSJCLEAR
 S X=$G(^PS(50.7,PSJSPIEN,0))
 S FIELD(0)="MFE"
 S FIELD(1)=PSJEC
 S FIELD(3)=$P($G(^PS(50.7,PSJSPIEN,0)),"^",4) I FIELD(3) S FIELD(3)=$$HLDATE^HLFNC(FIELD(3))
 S FIELD(4)="^^^"_PSJSPIEN_"^"_$P(X,"^")_"~"_$P($G(^PS(50.606,$P(X,"^",2),0)),"^")_"~"_$S($P($G(^PS(50.7,PSJSPIEN,0)),"^",3):$G(PSSIVID),1:"")_"^99PSP"
 D SEGMENT^PSSHLU(LIMIT)
 D ZPS,ZSY
 Q
 ;
ZPS ; get USAGE from dispense drug(s), set ZPS segment
 S LIMIT=2 X PSJCLEAR
 S FIELD(0)="ZPS"
 S USAGE=$$USAGE^PSSHLU(PSJSPIEN)
 Q:USAGE=""&('$P($G(^PS(50.7,PSJSPIEN,0)),"^",9))&('$P($G(^PS(50.7,PSJSPIEN,0)),"^",12))
 F I="I","O","A","B","V" S:+$P(USAGE,I,2)>0 FIELD(1)=FIELD(1)_I
 S:$P($G(^PS(50.7,PSJSPIEN,0)),"^",9) FIELD(1)=FIELD(1)_"S"
 S:$P($G(^PS(50.7,PSJSPIEN,0)),"^",10) FIELD(1)=FIELD(1)_"N"
 S:$P($G(^PS(50.7,PSJSPIEN,0)),"^",12) FIELD(2)=1
 D SEGMENT^PSSHLU(LIMIT)
 Q
 ;
ZSY ; get SYNONYMs
 S LIMIT=2 X PSJCLEAR
 S FIELD(0)="ZSY"
 S SYNONYM="",(J,SYNIEN)=0 F  S SYNIEN=$O(^PS(50.7,PSJSPIEN,2,SYNIEN)) Q:'SYNIEN  S SYNONYM=$P($G(^(SYNIEN,0)),"^") Q:SYNONYM=""  D
 .S FIELD(1)="1",FIELD(2)=SYNONYM D SEGMENT^PSSHLU(LIMIT)
 Q
PRO ;Check for protocols
 S MENU="PS MFSEND OR",ITEM="OR ITEM RECEIVE",MENUP=$O(^ORD(101,"B",MENU,0))
 S X=$O(^ORD(101,"B",ITEM,0)) I 'X W !!?5,"Sorry, you need the OR ITEM RECEIVE protocol to proceed,",!?5,"which is exported with Order Entry/Results Reporting V3!",! S XPDABORT=1 Q
 Q:$D(^ORD(101,MENUP,10,"B",X))
 I $D(^ORD(101,MENUP,10,0))[0 S ^ORD(101,MENUP,10,0)="^"_"101.01PA"
 K DD,DA,DO,DIC S DIC="^ORD(101,"_MENUP_",10,",DIC(0)="L",DLAYGO=101.01,DA(1)=MENUP D FILE^DICN K DD,DO
 K DIC I Y<0 W !!?5,"Sorry, unable to add OR ITEM RECEIVE protocol as an Item to the PS MFSEND",!,"protocol, cannot proceed!",! S XPDABORT=1
 Q
ENIVID ; Edit IV Identifier field to be displayed with IV Orderable Items.
 Q
 N DA,DIC,DIE,DRG,PSSOI,PSSIVID,PSSFIL,PSSDRG,X,Y
 S DIC=59.7,DIC(0)="AEMQ" D ^DIC Q:Y<0
 W !!!,"Changing the IV Identifier will update the name of ALL Orderable Items",!,"marked as an IV!",!!
 S PSSIVID=$P($G(^PS(59.7,+Y,31)),U,2),DIE=59.7,(DA,PSSSITE)=+Y,DR=32 D ^DIE
 Q:PSSIVID=$P($G(^PS(59.7,PSSSITE,31)),U,2)
 W !!,"Updating Orderable Item names in OE/RR"
 F PSSOI=0:0 S PSSOI=$O(^PS(50.7,"AIV",1,PSSOI)) Q:'PSSOI  D:$D(^PS(50.7,PSSOI)) EN2^PSSHL1(PSSOI,"MUP") W "."
 ;F PSSFIL=52.6,52.7 F PSSOI=0:0 S PSSOI=$O(^PS(PSSFIL,"AOI",PSSOI)) Q:'PSSOI  D:$D(^PS(50.7,PSSOI)) EN2^PSSHL1(PSSOI,"MUP") W "."
 Q
 ;
GTIVID() ; Return IV Identifier. If being edited, wait until edit is done.
 N X,PX S (X,PX)=$O(^PS(59.7,0)) Q:'X
 F  L +^PS(59.7,X,31):$S($G(DILOCKTM)>0:DILOCKTM,1:3) Q:$T  H 2
 S X=$P($G(^PS(59.7,X,31)),U,2)
 L -^PS(59.7,PX,31)
 Q X
