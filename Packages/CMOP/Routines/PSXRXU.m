PSXRXU ;BIR/WPB,HTW,BAB-Remote Facility File Utilities ;14 Dec 2001
 ;;2.0;CMOP;**3,28,41,57,48**;11 Apr 97
 ; Reference to ^PS(52.5,  supported by DBIA #1978
 ; Reference to ^PSOHLSN1  supported by DBIA #2385
 ; Reference to ^PSRX(     supported by DBIA #1977
 ; Reference to ^XTMP("ORLK-" supported by DBIA #4001
 ; Reference to $$GETNDC^PSONDCUT supported by DBIA #4705
START ;files transmission data in file 52 52.5 after transmission is sent
 ; and clear OERR lock ^XTMP("ORLK-"
 ; setup error trap for updating RXs in 52 & 52.5
 D
 . I '$D(^XTMP("PSXAUTOERR")) N $ETRAP,$ESTACK S $ETRAP="D RXERR^PSXRXU"
 . D START1
 Q
START1 ;
 S PSXNM="",PSXMSG=0
 F  S PSXNM=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM)) Q:PSXNM']""  D
 . S DFN="" F  S DFN=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM,DFN)) Q:DFN'>0  D
 .. S RX=0,PSXMSG=PSXMSG+1 F  S RX=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM,DFN,RX)) Q:RX'>0  D
 ... S RXF=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM,DFN,RX,0))
 ... D FILE
 Q
F D FILE^DICN
 Q
FILE ;files the data in the CMOP event multiple of PSRX(
 ;update 52, 52.5 called from PSXBLD RX loop
 S FILL=+RXF
 S:$G(PSXTDT)="" PSXTDT=$P(^PSX(550.2,PSXBAT,0),"^",6)
 Q:'$D(^PSRX(RX,0))
 ;S PSXMSG=$P(^PSX(550.1,XX,0),"^")
 ; update RX, RX:CMOP multiple
 ;If Rx status = suspended (5) set to active (0)
 I $P(^PSRX(RX,"STA"),U,1)=5 S $P(^PSRX(RX,"STA"),U,1)=0
 D EN^PSOHLSN1(RX,"SC","ZU","Transmitted to CMOP","")
 S:'$D(^PSRX(RX,4,0)) ^PSRX(RX,4,0)="^52.01DA^^"
 K DD,DO,DIE,DA,DIC,DR
 ;VMP OIFO BAY PINES;ELR;PSX*2*57 REMOVE LOCK AND UNLOCK OF PSRX(4
 ;L +^PSRX(RX,4,0):600 Q:'$T
 S DA(1)=RX,DIC="^PSRX("_RX_",4,",DIC(0)="Z",X=PSXBAT
 S DIC("DR")="1////"_$G(PSXMSG)_";2////"_$G(FILL)_";3////0;12///"_$S($$PATCH^XPDUTL("PSO*7.0*148"):$$GETNDC^PSONDCUT(RX,FILL),1:"")
 D:'$D(^PSRX(RX,4,"B",PSXBAT)) FILE^DICN I 1
 E  S DIE=DIC,DR=DIC("DR"),DA=$O(^PSRX(RX,4,"B",PSXBAT,0)) K DIC D ^DIE
 K DIC,DA,DR,DIE
 ;L -^PSRX(RX,4,0)
 K FAC
 S FAC=$$GET1^DIQ(550.2,PSXBAT,3)
 S COM=$S($G(PSXRTRN):"Re-",1:"")_"Transmitted to "_FAC_" CMOP"
 S:$G(FILL)>5 FILL=$G(FILL)+1
 S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(RX,"A",JJ)) Q:'JJ  S CNT=JJ
 S CNT=CNT+1,^PSRX(RX,"A",0)="^52.3DA^"_CNT_"^"_CNT
 ;VMP OIFO BAY PINES;ELR;PSX*2*57 REMOVE LOCK AND UNLOCK OF PSRX
 ;L +^PSRX(RX):600 Q:'$T
 S ^PSRX(RX,"A",CNT,0)=PSXTDT_"^B^"_DUZ_"^"_$G(FILL)_"^"_COM
 ;L -^PSRX(RX)
 S IN525=$O(^PS(52.5,"B",RX,""))
 I $G(IN525)]"" K DIE,DA,DR,DIE,DIC S DIE="^PS(52.5,",DR="3////X",DA=IN525 L +^PS(52.5,IN525):600 Q:'$T  D ^DIE L -^PS(52.5,IN525) K DA,DIE,DA,IN525
 K DIE,DR,DA
 S DA=PSXMSG,DIE="^PSX(550.1,",DR="1////5"
 L +^PSX(550.1,PSXMSG):600 Q:'$T
 D ^DIE L -^PSX(550.1,PSXMSG) K DA,DR,DIE
OERR ;clear ^XTMP("ORLK-" if it is CPRS/CMOP
 N ORD S ORD=+$P($G(^PSRX(+$G(RX),"OR1")),"^",2)
 I ORD,$D(^XTMP("ORLK-"_ORD,0)),^XTMP("ORLK-"_ORD,0)["CPRS/CMOP" K ^XTMP("ORLK-"_ORD)
 Q
PRINT D NOW^%DTC S DTTM=% S COM="CMOP Suspense Label "_$S($G(^PS(52.5,REC,"P"))=0:"Printed",1:"RePrinted")_$S($G(^PSRX(PTR,"TYPE"))>0:" (PARTIAL)",1:"")
 S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(PTR,"A",JJ)) Q:'JJ  S CNT=JJ
 S $P(^PSRX(PTR,"STA"),"^",1)=0,^PS(52.5,REC,"P")=1
 S CNT=CNT+1,^PSRX(PTR,"A",0)="^52.3DA^"_CNT_"^"_CNT L +^PSRX(PTR):600 Q:'$T  S ^PSRX(PTR,"A",CNT,0)=DTTM_"^S^"_DUZ_"^"_FILL_"^"_COM L -^PSRX(PTR)
 K DTTM,%,COM,CNT,JJ
 Q
SUSPS ;goes through the PS(550.1 file and gets the pointer for each rx in PSRX
 ;CMOP Event entry
 S XXX=0 F  S XXX=$O(^PSX(550.1,REC,2,XXX)) Q:XXX'>0  D ACLOG
 K XXX
 Q
ACLOG ;
 D NOW^%DTC
 S PSXPTR=$P($G(^PSX(550.1,REC,2,XXX,0)),U,1)
 F RCC=0:0 S RCC=$O(^PSRX(+PSXPTR,4,"B",OLDBAT,RCC)) Q:RCC=""  S RC=RCC
 S TRNN=$P($G(^PSRX(+PSXPTR,4,RC,0)),"^",1)
 S FAC=$$GET1^DIQ(550.2,TRNN,3)
 S FILL=$P($G(^PSRX(+PSXPTR,4,RC,0)),"^",3)
 S CNT=0 F JJ=0:0 S JJ=$O(^PSRX(+PSXPTR,"A",JJ)) Q:'JJ  S CNT=JJ
 S COMMENT="Retransmitted to "_FAC_" CMOP"
 S CNT=CNT+1,^PSRX(+PSXPTR,"A",0)="^52.3DA^"_CNT_"^"_CNT
 L +^PSRX(+PSXPTR):600 Q:'$T
 S ^PSRX(+PSXPTR,"A",CNT,0)=%_U_"B"_U_DUZ_U_$S(FILL>5:(FILL+1),1:FILL)_U_COMMENT
 L -^PSRX(+PSXPTR)
 L +^PSRX(+PSXPTR,4,0):600 Q:'$T
 S DA(1)=+PSXPTR,DIE="^PSRX("_+PSXPTR_",4,",DA=RC,DR="3////2"
 D ^DIE K DIE,DA,DR,DD,DO
 S:'$D(^PSRX(+PSXPTR,4,0)) ^PSRX(+PSXPTR,4,0)="^52.01DA^^"
 S DA(1)=+PSXPTR,DIC="^PSRX("_+PSXPTR_",4,",DIC(0)="Z",X=PSXBAT
 S DIC("DR")="1////"_REC_";2////"_$G(FILL)_";3////0" D F
 L -^PSRX(+PSXPTR,4,0)
 K PSXPTR,COMMENT,CNT,JJ,FILL,REF,%,DIC,DA,DIE,DR
 S DA=REC,DIE="^PSX(550.1,",DR="1////5" L +^PSX(550.1,REC):600 Q:'$T
 D ^DIE L -^PSX(550.1,REC) K DIE,DA,DR,FAC,TRNN
 Q
RXERR ;auto error processing of RX updating 52 & 52.5
 S XXERR=$$EC^%ZOSV
 S PSXDIVNM=$$GET1^DIQ(59,PSOSITE,.01)
 ;save an image of the transient file 550.1 for 2 days
 D NOW^%DTC S DTTM=%
 ;VMP OIFO BAY PINES;ELR;PSX*2*57 CHANE PURGE DATE TO T+12 FROM T+2
 S X=$$FMADD^XLFDT(DT,+12) S ^XTMP("PSXERR "_DTTM,0)=X_U_DT_U_"CMOP "_XXERR
 M ^XTMP("PSXERR "_DTTM,550.1)=^PSX(550.1)
 S XMSUB="CMOP Error "_PSXDIVNM_" "_$$GET1^DIQ(550.2,+$G(PSXBAT),.01)
 D GRP1^PSXNOTE
 ;S XMY(DUZ)=""
 S XMTEXT="TEXT("
 S TEXT(1,0)=$S($G(PSXCS):"",1:"NON-")_"CS CMOP transmission encountered the following error. Please investigate"
 S TEXT(2,0)="Division:         "_PSXDIVNM
 S TEXT(3,0)="Type/Batch        "_$S($G(PSXCS):"CS",1:"NON-CS")_" / "_$$GET1^DIQ(550.2,$G(PSXBAT),.01)
 S TEXT(4,0)="Error:            "_XXERR
 S TEXT(5,0)=">>>This batch has been sent <<<"
 S TEXT(6,0)="Call NVS to investigate which prescriptions have been updated"
 S TEXT(7,0)="or not updated in files Prescription #52 & Suspense 52.5 ."
 S TEXT(8,0)="A copy of file 550.1 can be found in ^XTMP(""PSXERR "_DTTM_""")"
 D ^%ZTER
 D ^XMD
 G UNWIND^%ZTER
