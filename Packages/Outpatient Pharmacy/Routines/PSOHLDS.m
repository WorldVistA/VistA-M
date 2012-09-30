PSOHLDS ;BIR/PWC-HL7 V.2.4 AUTOMATED DISPENSE INTERFACE ;03/01/96 09:45
 ;;7.0;OUTPATIENT PHARMACY;**156,312,354**;DEC 1997;Build 16
 ;External reference to GETAPP^HLCS2  supported by DBIA 2887
 ;External reference to INIT^HLFNC2   supported by DBIA 2161
 ;External reference to GENERATE^HLMA supported by DBIA 2164
 ;External reference to SETUP^XQALERT supported by DBIA 10081
 ;External reference to ^XUSEC("PSOINTERFACE" supported by DBIA 10076
 ;External reference to ^ORD(101 supported by DBIA 872
 ;External reference to ^PSDRUG supported by DBIA 221
 ;
INIT ;initialize variables and build outgoing message
 N DFLAG,HLRESLT,HLP,PSLINK,PSOHLSER,PSOHLCL,PSOHLINX,DDNS,PSOENH,PSOADD,ADDCAT,PSOMES,OPADD,OPNAM
 S PSOHLINX=$$GETAPP^HLCS2("PSO EXT SERVER") Q:$P($G(PSOHLINX),"^",2)="i"
 K ^TMP("PSO",$J),^TMP("PSOADD",$J)
 S PIEN=$O(^ORD(101,"B","PSO EXT SERVER",0)) G:'PIEN EXIT
 S PSI=1,HLPDT=DT D INIT^HLFNC2(PIEN,.HL1) I $G(HL1) G EXIT
 S FS=HL1("FS"),HL1("ECH")="~^\&",HLECH=HL1("ECH")
 S CS=$E(HL1("ECH")),RS=$E(HL1("ECH"),2),EC=$E(HL1("ECH"),3),SCS=$E(HL1("ECH"),4)
 I '$G(PSODTM) D NOW^%DTC S DTME=%
 I $G(PSODTM) S DTME=PSODTM
 S DDNS=$$GET1^DIQ(59,PSOSITE_",",2006)
 S PSOENH=0 D GETDEV,ALLADD
 F II=0:0 S II=$O(^UTILITY($J,"PSOHL",II)) Q:'II  S ODR=^UTILITY($J,"PSOHL",II) D
 .S IRXN=$P(ODR,"^"),IDGN=$P(ODR,"^",2),FP=$P(ODR,"^",3),FPN=$P(ODR,"^",4),DAW=$P(ODR,"^",5),DIN=$P(ODR,"^",6)
 .S ^TMP("PSOMID",$J,II)=IRXN_"^"_FP_"^"_FPN I DIN=1 D   ;;*312 - ADDED IRXN AS 4TH PIECE
 ..F JJ=0:0 S JJ=$O(^UTILITY($J,"PSOHL",II,JJ)) Q:'JJ  S ING(JJ)=^UTILITY($J,"PSOHL",II,JJ)
 .S SDI=$P(ODR,"^",7) I SDI=1 S DRI=^UTILITY($J,"PSOHL",II,"DRI")
 .S CPY=$P(ODR,"^",8),RPRT=$P(ODR,"^",9),PRSN=$P(ODR,"^",10),DIV=$G(PSOSITE),DFN=$P(^PSRX(IRXN,0),"^",2),STPMTR=$P($G(^PS(59,DIV,1)),"^",30)
 .I $G(STPMTR)>1&($P($G(^PSRX(IRXN,"STA")),"^")=5) D
 ..N PSOHLSPZ,PSOHLNDA S PSOHLSPZ=$O(^PS(52.5,"B",IRXN,0)),PSOHLNDA=""
 ..I PSOHLSPZ S PSOHLNDA=$G(^PS(52.5,PSOHLSPZ,0))
 ..I $G(RXPR(IRXN)),+$G(RXPR(IRXN))'=$P(PSOHLNDA,"^",5) Q
 ..I '$G(RXRP(IRXN)),'$G(RXPR(IRXN)),$D(RXFL(IRXN)),$P(PSOHLNDA,"^",13)'="",$P($G(RXFL(IRXN)),"^")'=$P(PSOHLNDA,"^",13) Q
 ..D SUS^PSOLBL4(IRXN,FP,FPN,RPRT)
 .S PSOADD=""
 .I PSOENH D CHKCAT I PSOADD="" Q
 .I PSOADD="" S PSOADD=DDNS
 .D LOGMSG
 .S PSI=$P(OPADD(PSOADD),"^",2) I PSI="" S PSI=1 K PAS,PAS1,PAS2,PAS3
 .D START^PSOHLDS1
 .M ^TMP("PSOADD",$J,PSOADD)=^TMP("PSO",$J) S $P(OPADD(PSOADD),"^",2)=PSI
 .I $D(ADDCAT("S")) D STRAGE
 .K ^TMP("PSO",$J)
 I $D(ADDCAT("S")) D MORSTG
 S PSLINK=$O(^UTILITY($J,"PSOHL",0))
 S DDNS="" F  S DDNS=$O(^TMP("PSOADD",$J,DDNS)) Q:DDNS=""  D
 .K ^TMP("HLS",$J)
 .M ^TMP("HLS",$J)=^TMP("PSOADD",$J,DDNS)
 .S DPORT=$P(OPADD(DDNS),"^")
 .K HLP,HLMID,HLERR,HLRESLT
 .S HLP("CONTPTR")="",HLP("SUBSCRIBER")="^^^^~"_DDNS_":"_DPORT_"~DNS"
 .D GENERATE^HLMA(PIEN,"GM",1,.HLRESLT,"",.HLP)
 .K HLL S HLMID=$P($G(HLRESLT),"^"),HLERR=$P($G(HLRESLT),"^",2)
 .I '$G(HLMID) S XQAMSG="Error transmitting "_$P(^DPT(DFN,0),"^")_" order to external interface"_$S(PSOENH:" TO "_DDNS,1:"") D ALERT Q
 .I $G(HLMID),$P($G(HLERR),"^")'="" S XQAMSG="Error transmitting batch "_HLMID_" to the external interface"_$S(PSOENH:" TO "_DDNS,1:""),MESS="TRANSMISSION FAILED"_$S(PSOENH:" TO "_DDNS,1:""),STA=3 D UFILE,ALERT Q
 .I $G(HLMID),$P($G(HLERR),"^")="" S MESS="MESSAGE TRANSMITTED"_$S(PSOENH:" TO "_$G(OPNAM(DDNS))_" ("_DDNS_")",1:""),STA=1 D UFILE
 G EXIT
LOGMSG ;build status of message in log file (#52.51)
 N PSODEV,PSOMES,STR
 S PSODEV=PSOADD
 D LOGBLD
 S $P(^TMP("PSOMID",$J,II),"^",4)=PSOMES
 ;build message for the storage devices
 I PSOENH D
 .S PSODEV="" F  S PSODEV=$O(ADDCAT("S",PSODEV)) Q:PSODEV=""  I PSODEV'=PSOADD D
 ..D LOGBLD
 ..S STR=$P(^TMP("PSOMID",$J,II),"^",4),STR=$S(STR'="":STR_";",1:"")_PSOMES
 ..S $P(^TMP("PSOMID",$J,II),"^",4)=STR
 Q
LOGBLD ;audit log file #52.51
 N DIK,DIC,DA,DD,DO
 S DIC="^PS(52.51,",X=IRXN,DIC(0)=""
 S DIC("DR")="2////"_DFN_";3////"_DTME_";4////"_PRSN_";5////"_RPRT_";6////"_STPMTR_";8////"_FP_";9////"_FPN_";15////"_DIV_";13////"_"BUILDING MESSAGE"_$S(PSOENH:" TO SEND TO "_PSODEV,1:"")_";14////1"
 D FILE^DICN K DD,DO,DIC
 S PSOMES=$P(Y,"^")
 K Y
 Q
UFILE F II=0:0 S II=$O(^TMP("PSOMID",$J,II)) Q:'II  S III=$G(^(II)) D
 .S PRXX=$P(III,"^",4),PFP=$P(III,"^",2),PFPN=$P(III,"^",3)
 .F XX=1:1 S PRX=$P(PRXX,";",XX) Q:PRX=""  D
 ..Q:'$D(^PS(52.51,PRX))
 ..I $P($G(^PS(52.51,PRX,0)),"^",8)=PFP,$P($G(^PS(52.51,PRX,0)),"^",9)=PFPN D
 ...I PSOENH,$G(^PS(52.51,PRX,1))'[DDNS Q
 ...S DA=PRX,DIE="^PS(52.51,",DR="10////"_HLMID_";13////"_MESS_";14////"_STA_"" D ^DIE
 ...I PSOENH D ACLOG
 Q
 ;
EXIT S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP("PSOMID",$J),MESS,PSODTM,STA,HLMID,PRX,PFP,PFPN,CS,CPY,DAW,DIN,DRI,EC,FP,FPN,FS,ING,IRXN,IDGN,II,JJ,ODR,PSI,RS,SCS,SDI,%
 K DA,DIE,DIV,DR,DTME,HL1,HLERR,HLPDT,XXX,DFN,PAS,STPMTR,X,III,PIEN,PRSN,RPRT,PAS1,PAS2,PAS3,PRXX,XX,J
 K ^TMP("HLS",$J),^TMP("PSO",$J),^TMP("PSOADD",$J)
 Q
 ;
ERRMSG S EMSG=""
 F AA=1:1 X HLNEXT Q:HLQUIT'>0  S EMSG=EMSG_"&&"_HLNODE
 S ^TMP("PSO2",$J)=EMSG
 Q
ACK ;process MSA received from the dispense machine (client)
 ;
 S:'$D(HL("APAT")) HL("APAT")="AL"
 S AACK=HL("APAT"),DTM=HL("DTM"),ETN=HL("ETN"),CMID=HL("MID")
 S MTN=HL("MTN"),RAN=HL("RAN"),SAN=HL("SAN"),VER=HL("VER")
 S EID=HL("EID"),EIDS=HL("EIDS"),FS=HL("FS")
 I $G(VER)'="2.4" G EXT
 N ORC K PSOMSG F I=1:1 X HLNEXT Q:HLQUIT'>0  S PSOMSG(I)=HLNODE,J=0 D
 .I $P(PSOMSG(I),"|")="MSA" S MSACDE=$P(PSOMSG(I),"|",2),SMID=$P(PSOMSG(I),"|",3) S:$P(PSOMSG(I),"|",4)]"" ERRMSG=$P(PSOMSG(I),"|",4)
 .I $P(PSOMSG(I),"|")="ORC" S ORC=1_"^"_+$P(PSOMSG(I),"|",3)
 .F  S J=$O(HLNODE(J)) Q:'J  S PSOMSG(I,J)=HLNODE(J)
 ;
 S ^TMP("PSO1",$J,CMID)=CMID_"^"_AACK_"^"_DTM_"^"_ETN_"^"_MTN_"^"_RAN_"^"_SAN_"^"_VER_"^"_EID_"^"_EIDS
 ;
 S (DIV1,SP1,SP2)="" F  S DIV1=$O(^PS(52.51,"AM",SMID,DIV1)) Q:'DIV1  F  S SP1=$O(^PS(52.51,"AM",SMID,DIV1,SP1)) Q:'SP1!(SP1=2)  S SP2=$P($G(^PS(52.51,SP1,0)),"^",6)
 I '$D(MSACDE) G EXT
 I $G(MSACDE)="AA" D ACK1
 I $G(MSACDE)="AE"!$G(MSACDE)="AR" D ACK2
 ;
EXT ;
 K ^TMP("PSO1",$J),AACK,DTM,ETN,CMID,MTN,RAN,SAN,VER,EID,EIDS,FS,MSA,AA,RPT
 K MSA1,MSACDE,SMID,ERRMSG,DIV1,SP1,SP2,HL,UID,FLL,FLLN,IRX,FLD12,FLD13
 K DIE,EMSG,HLQUIT,HLNEXT,HLNODE,PSOMSG,ORC,EIN
 Q
 ;
ACK1 ;
 S FLD13=$S($G(ORC):"MEDICATION DISPENSED",1:"TO BE PROCESSED") D FACK1
 Q
 ;
ACK2 S XQAMSG="Error processing batch "_SMID_". Interface will continue to transmit.",FLD13="PROCESS FAILED" S:$G(ERRMSG) FLD12=ERRMSG
 D FACK2,ALERT
 Q
 ;
ALERT ;send alert to key holders
 K XQA,XQAOPT,XQAROU,XQAID,XQADATA,XQAFLAG
 F UID=0:0 S UID=$O(^XUSEC("PSOINTERFACE",UID)) Q:'UID  S XQA(UID)=""
 D SETUP^XQALERT
 Q
UDFILE ;updates from vendor
 S (DIV1,SP1)="" F  S DIV1=$O(^PS(52.51,"AM",SMID,DIV1)) Q:'DIV1  F  S SP1=$O(^PS(52.51,"AM",SMID,DIV1,SP1)) Q:'SP1  S (EIN,DA)=SP1 D
 .S DIE="^PS(52.51,",DR="7////"_SAN_";11////"_CMID_";13////"_FLD13_";14////2" D ^DIE
 Q
FACK1 ;
 D:'$G(ORC) UDFILE
 I $G(ORC) D
 .S RXN=$P(ORC,"^",2),RX=0 F  S RX=$O(^PS(52.51,"B",RXN,RX)) Q:'RX  S (EIN,DA)=RX
 .I $G(DA) D
 ..I $P($G(^PS(52.51,DA,1)),"^",4)="MEDICATION DISPENSED",$P(^PS(52.51,DA,0),"^",10)=2 S MDUP=1 D ^PSOHLDIS K EIN,MDUP Q
 ..S HLUSER=$P(^PS(52.51,DA,0),"^",4),HLRPT=$P(^(0),"^",5)
 ..S DIE="^PS(52.51,",DR="7////"_SAN_";11////"_CMID_";13////"_FLD13_";14////2" D ^DIE,^PSOHLDIS K EIN,HLUSER,HLRPT
 Q
 ;
FACK2 ;
 D UDFILE Q:'$G(^PSRX($P(^PS(52.51,EIN,0),"^"),0))
 S ACL=0,IRX=$P(^PS(52.51,EIN,0),"^"),FLL=$P(^(0),"^",8),FLLN=$P(^(0),"^",9),RXN=$P(^PSRX(IRX,0),"^")
 F I=0:0 S SUB=$O(^PSRX(IRX,"A",I)) Q:'I  S ACL=(ACL+1)
 D NOW^%DTC S ACL=ACL+1,^PSRX(IRX,"A",0)="^52.3DA^"_ACL_"^"_ACL
 S ^PSRX(IRX,"A",ACL,0)=%_"^N^^"_$S(FLL="F":FLLN,1:(99-FLLN))_"^External Interface Rx NOT Dispensed." K ACL,I,RXN
 Q
 ;
GETDEV ;get devices associated with dispensing printer
 ;Create array OPADD & ADDCAT
 ; Output: OPADD(dns)=port
 ;         ADDCAT(category,dns)=""
 ;
 N DDNS,DPORT,PIO,PN,DN,DEV,DAT,DAT1
 K OPADD,ADDCAT
 S PN=$G(^UTILITY($J,"PSOPAI")),PIO=$O(^PS(59,PSOSITE,"P","B",+PN,""))
 S DN=$O(^PS(59,PSOSITE,"P",+PIO,"OPAI",0))
 I ('PIO)!(DN="") D  Q
 .S DDNS=$$GET1^DIQ(59,PSOSITE_",",2006),DPORT=$$GET1^DIQ(59,PSOSITE_",",2007),OPADD(DDNS)=DPORT
 S PSOENH=1,DEV=0 F  S DEV=$O(^PS(59,PSOSITE,"P",PIO,"OPAI",DEV)) Q:'DEV  D
 .S DAT=$G(^PS(59,PSOSITE,"P",PIO,"OPAI",DEV,0)) I $P(DAT,"^",2)="" Q
 .S DAT1=$$ADDCHK($P(DAT,"^")) I DAT1 D
 ..S OPADD($P(DAT1,"^",3))=$P(DAT1,"^",4),ADDCAT($P(DAT,"^",2),$P(DAT1,"^",3))=""
 Q
 ;
CHKCAT ;checks the ADD category to determine if and where the prescription should be routed.
 N PDAT,DRG,DRG0,DDEV,RTE,CSB,MTH,DEV53
 S PSOADD=""
 S PDAT=$G(^PSRX(IRXN,0)),DRG=$P(PDAT,"^",6),RTE=$$RTE()
 S DRG0=$G(^PSDRUG(+DRG,0)),DDEV=$G(^PSDRUG(DRG,"OPAI",PSOSITE,0))
 I DDEV'="" S DEV53=$$ADDCHK($S(RTE="W":$P(DDEV,"^",2),RTE="M":$P(DDEV,"^",3),1:"")) I DEV53 D  Q
 .I $D(OPADD($P(DEV53,"^",3))) S PSOADD=$P(DEV53,"^",3) Q
 .S OPADD($P(DEV53,"^",3))=$P(DEV53,"^",4),PSOADD=$P(DEV53,"^",3)
 I $D(ADDCAT("A")) S PSOADD=$O(ADDCAT("A","")) Q
 S CSB=+$P(DRG0,"^",3),CSB=$S((CSB>0)&(CSB<6):"CS",1:"NCS")
 I $D(ADDCAT(CSB)) S PSOADD=$O(ADDCAT(CSB,"")) Q
 I $D(ADDCAT(RTE_CSB)) S PSOADD=$O(ADDCAT(RTE_CSB,"")) Q
 S MTH=$S(RTE="W":"WIND",RTE="M":"MAIL",1:"") I MTH'="",$D(ADDCAT(MTH)) S PSOADD=$O(ADDCAT(MTH,"")) Q
 I $D(ADDCAT("S")) S PSOADD=$O(ADDCAT("S","")) Q
 Q
 ;
STRAGE ;set HL7 entries in ^TMP global to be sent to the storage device.
 N DNS,CNT,CNT1,STR
 S DNS=$O(ADDCAT("S","")) I DNS="" Q
 I DNS=PSOADD Q
 I '$D(^TMP("PSOADD",$J,DNS)) D  Q
 .M ^TMP("PSOADD",$J,DNS)=^TMP("PSO",$J) S $P(OPADD(DNS),"^",2)=PSI
 S CNT=0 F  S CNT=$O(^TMP("PSO",$J,CNT)) Q:'CNT  D
 .S STR=$G(^TMP("PSO",$J,CNT))
 .I "^PID^PV1^PV2^IAM^"[("^"_$E(STR,1,3)_"^") Q
 .S CNT1=+$P(OPADD(DNS),"^",2)
 .M ^TMP("PSOADD",$J,DNS,CNT1)=^TMP("PSO",$J,CNT)
 .S CNT1=CNT1+1,$P(OPADD(DNS),"^",2)=CNT1
 Q
MORSTG ;if more than one storage device is defined, add the others to the ^TMP global
 N RDNS,DNS
 S DNS=$O(ADDCAT("S","")) I DNS="" Q
 S RDNS=DNS F  S RDNS=$O(ADDCAT("S",RDNS)) Q:RDNS=""  D
 .M ^TMP("PSOADD",$J,RDNS)=^TMP("PSOADD",$J,DNS)
 Q
 ;
ADDCHK(DEV) ;check ADD in file #52.53 and return status and the zero node
 ; 1 - valid or 0 - invalid
 I $G(DEV)="" Q 0
 N DEVD
 S DEVD=$G(^PS(52.53,DEV,0))
 I ($P(DEVD,"^")="")!($P(DEVD,"^",2)="")!($P(DEVD,"^",3)="") Q 0_"^"_DEVD
 I $P(DEVD,"^",4),$P(DEVD,"^",4)'>DT Q 0_"^"_DEVD
 Q 1_"^"_DEVD
 ;
ALLADD ;get all active ADDs in #52.53
 ;  OPNAM(dns)=dns name
 N X,XD
 K OPNAM
 S X=0 F  S X=$O(^PS(52.53,X)) Q:'X  D
 .S XD=$G(^PS(52.53,X,0))
 .Q:($P(XD,"^")="")!($P(XD,"^",2)="")!($P(XD,"^",3)="")
 .I $P(XD,"^",4),$P(XD,"^",4)'>DT Q
 .S OPNAM($P(XD,"^",2))=$P(XD,"^")
 Q
 ;
ACLOG ;activity log (HL7 message transmitted to the interface)
 N DTTM,HCOM,HCNT,HJJ,IEN52
 S IEN52=$P($G(^PS(52.51,PRX,0)),"^")
 D NOW^%DTC S DTTM=%,HCOM=MESS
 S HCNT=0 F HJJ=0:0 S HJJ=$O(^PSRX(IEN52,"A",HJJ)) Q:'HJJ  S HCNT=HJJ
 S HCNT=HCNT+1,^PSRX(IEN52,"A",0)="^52.3DA^"_HCNT_"^"_HCNT S ^PSRX(IEN52,"A",HCNT,0)=DTTM_"^X^"_$S($G(PDUZ):PDUZ,1:.5)_"^"_"^"_$S($G(HLMID):"HL7 ID - "_HLMID,1:"")_" "_HCOM
 Q
RTE() ;get RX route
 N MW
 I $G(FP)="F"&('$G(FPN)) S MW=$P($G(^PSRX(IRXN,0)),"^",11)       ;original
 I $G(FP)="F"&($G(FPN)) S MW=$P($G(^PSRX(IRXN,1,FPN,0)),"^",2)   ;refill
 I $G(FP)="P"&($G(FPN)) S MW=$P($G(^PSRX(IRXN,"P",FPN,0)),"^",2) ;partial
 Q $G(MW)
