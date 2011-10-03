PSOHLDIS ;BIR/PWC,SAB - Automated Dispense Completion HL7 v.2.4 ;8/28/07 5:00pm
 ;;7.0;OUTPATIENT PHARMACY;**156,189,193,209,148,259,200,330**;DEC 1997;Build 5
 ;Reference to ^PSDRUG supported by DBIA #221
 ;Reference to $$NDCFMT^PSSNDCUT supported by IA 4707
 ;This routine is called by FACK1^PSOHLDS
 ;
 ;*209 add Drug accountability & fix Copay for refills
 ;*259 check for refill node to exist before updating the Release msg
 ;*330 send variable PSOSITE when updating drug accountability
 ;
EN ;main entry and process
 N NONODE
 D GETHL7,GETPID,GETORC,GETRXD
 ;
 ;Begin Updating files           ;*259
 I MEDDISP  D                    ;if dispensed
 . I FLL="F",'FLLN D FILL              ;orig fill
 . I FLL="F",FLLN D REFILL             ;refill
 . I FLL="P" D PARTIAL                 ;partial fill
 . D ACTLOG                            ;activity log
 . Q:$G(NONODE)                        ;quit, no refill node to update
 . I $D(BGRP),$D(BNAM),$D(BDIV) D BINGREL^PSOHLDI1    ;bingo board rel
 . D DRGACCT^PSOHLDI1(RXID,PSOSITE)     ;drug accountability *209,*330
 . I '$G(PRT) D CHKADDR^PSODISPS(RXID)
 E  D                            ;else not dispensed
 . D ACTLOG                            ;activity log no release
 ;
 ;if label was printed
 I PRT D
 . S LBI=0 F LB=0:0 S LB=$O(^PSRX(RXID,"L",LB)) Q:'LB  S LBI=LBI+1
 . S LBI=LBI+1,^PSRX(RXID,"L",0)="^52.032DA^"_LBI_"^"_LBI
 . S ^PSRX(RXID,"L",LBI,0)=NOW_"^"_$S(FLL="F":FLLN,1:(99-FLLN))_"^"_"From Rx # "_$P(^PSRX(RXID,0),"^")_$S(FLL="P":" (Partial)",1:"")_$S($G(HLRPT):" (Reprint)",1:"")_" (External Interface)"_"^"_HLUSER
 ;
 D END
 Q
 ;
GETHL7 ;get HL7 segments from msg
 K OK
 F I=0:0 S I=$O(PSOMSG(I)) Q:'I  D
 .I $P(PSOMSG(I),"|")="MSH" S NODE1=PSOMSG(I) Q
 .I $P(PSOMSG(I),"|")="MSA" S NODE2=PSOMSG(I) Q
 .I $P(PSOMSG(I),"|")="PID" S NODE3=PSOMSG(I) Q
 .I $P(PSOMSG(I),"|")="ORC" S NODE4=PSOMSG(I) Q
 .I $P(PSOMSG(I),"|")="RXD" S NODE5=PSOMSG(I) Q
 Q
 ;
GETPID ;get PID segment data
 S PID=$P($G(NODE3),"|",4)   ;this contains all the patient id numbers
 F XX=1:1 S PIDD=$P(PID,"^",XX) Q:PIDD=""  D
 . S PIDID=$P(PIDD,"~",5)
 . I PIDID="NI" S PICN=$P(PIDD,"~",1)   ;ICN #
 . I PIDID="SS" S PSSN=$P(PIDD,"~",1)   ;SSN #
 . I PIDID="PI" S PPID=$P(PIDD,"~",1)   ;patient ID
 . I PIDID="PN" S PCLM=$P(PIDD,"~",1)   ;claim #
 Q
GETORC ;get ORC segment data
 S RXID=$P($P($G(NODE4),"|",3),"^")    ;RX #
 S DFN=$P(^PSRX(RXID,0),"^",2) D DEM^VADPT
 S NAME=VADM(1),DOB=$P(VADM(3),"^"),SEX=$P(VADM(5),"^") K VADM
 S FPER=$P($P($G(NODE4),"|",11),"~")   ;filling person
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=+FPER D
 .D ^DIC I +Y>0 S FPER=+Y,FPERN=$P(Y,"^",2) Q
 .S FPER="",FPERN="UNKNOWN"
 S CPHARM=$P($P($G(NODE4),"|",12),"~") ;checking pharmacist
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=+CPHARM D  K DIC,X,Y
 .D ^DIC I +Y>0 S CPHARM=+Y,CPHARMN=$P(Y,"^",2) Q
 .S CPHARM="",CPHARMN="UNKNOWN"
 Q
GETRXD ;get RXD segment data
 S FILL=$P($P($G(NODE5),"|",2),"^")         ;fill #
 S GIVECOD=$P($P($G(NODE5),"|",3),"^")      ;give code
 S X=$P($P($G(NODE5),"|",4),"^"),DISPDT=$$FMDATE^HLFNC(X) K X  ;dispense date
 S PSORX=$P($P($G(NODE5),"|",8),"^")        ;prescription #
 S NDC=$P($P($G(NODE5),"|",10),"^")  ;NDC #
 K F I NDC]"" D  K L,F
 .S F=""
 .F L=1:1:$L(NDC,"^") I $P(NDC,"^",L)'=""  S F=$G(F)_$P(NDC,"^",L)_$S($P(NDC,"^",(L+1))]"":",",1:"")
 .S NDC=F
 S X=$P($P($G(NODE5),"|",10),"^",2),RELDT=$S($$FMDATE^HLFNC(X)>0:$$FMDATE^HLFNC(X),1:"") K X  ;release dt
 S PRT=$S($P($P($G(NODE5),"|",10),"^",3)=1:1,$P($P($G(NODE5),"|",10),"^",3)=2:1,1:0)  ;label printed by vendor
 S MEDDISP=$S($P($P($G(NODE5),"|",10),"^",3)=1:1,$P($P($G(NODE5),"|",10),"^",3)=4:1,1:0)  ;med dispensed by vendor
 S RPHARM=$P($P($G(NODE5),"|",11),"~",1)      ;releasing pharmacist
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=+RPHARM D
 .D ^DIC I +Y>0 S RPHARM=+Y Q
 .S RPHARM=""
 S LOT=$P($G(NODE5),"|",19)
 I LOT]"" D  K L,F
 .S F=""
 .F L=1:1:$L(LOT,"^") I $P(LOT,"^",L)'=""  S F=$G(F)_$P(LOT,"^",L)_$S($P(LOT,"^",(L+1))]"":",",1:"")
 .S LOT=F
 S X=$P($P($G(NODE5),"|",20),"^"),EXPDT=$S($$FMDATE^HLFNC(X)>0:$$FMDATE^HLFNC(X),1:"") K X   ;expiration date
 S MFG=$P($P($G(NODE5),"|",21),"^")         ;manufacturer
 K F I MFG]"" D  K L,F
 .F L=1:1:$L(MFG) Q:$P(MFG,"^",L)=""  S F=$G(F)_$P(MFG,"^",L)_$S($P(MFG,"^",(L+1))]"":",",1:"")
 .S MFG=F
 S EXRX=^PS(52.51,EIN,0)
 S IRX=$P(EXRX,"^"),FLL=$P(EXRX,"^",8),FLLN=$P(EXRX,"^",9),RPT=$P(EXRX,"^",5),(DIV,PSOSITE)=$P(EXRX,"^",11),PSOPAR=$G(^PS(59,DIV,0))
 S PSOPAR7=$G(^PS(59,PSOSITE,"IB")),PSOSYS=$G(^PS(59.7,1,40.1))
 S RXN=$P(^PSRX(IRX,0),"^"),DRG=$P(^(0),"^",6),QTY=$P(^(0),"^",7)
 Q
FILL ;Orig fill
 S $P(^PSRX(IRX,2),"^",4)=LOT,$P(^(2),"^",8)=MFG,$P(^(2),"^",11)=EXPDT,$P(^PSRX(IRX,"OR1"),"^",6)=FPER,$P(^("OR1"),"^",7)=CPHARM
 S:$G(^PSDRUG(DRG,660.1))]"" ^PSDRUG(DRG,660.1)=^PSDRUG(DRG,660.1)-QTY
 ;if auto release & rel dt
 I $P($G(^PS(59,DIV,"DISP")),"^",2),$G(RELDT) D
 .S DIE="^PSRX(",DA=IRX,DR="31///"_RELDT_";23////"_RPHARM_";32.1///@;32.2///@" D ^DIE K DIE,DR,DA
 .I $P(^PSRX(IRX,0),"^",11)["W" S BRT="W",BNAM=$P(^PSRX(IRX,0),"^",2),BDIV=$P(^(2),"^",9) S:BDIV'="" BGRP=$P($G(^PS(59,BDIV,1)),"^",20)
 .S PSOCPRX=$P(^PSRX(IRX,0),"^"),RXP=IRX D CP^PSOCP
 .D EN^PSOHLSN1(IRX,"ZD"),AUTOREL^PSOBPSUT(IRX,FLLN,RELDT,NDC,"A",,30)
 ;else if not auto release nor rel dt
 E  I $$NDCFMT^PSSNDCUT(NDC)'="",$$STATUS^PSOBPSUT(IRX,FLLN)="" D SAVNDC^PSONDCUT(IRX,FLLN,NDC)
 Q
REFILL ;refill
 I '$D(^PSRX(IRX,1,FLLN,0)) S NONODE=1 Q
 S $P(^PSRX(IRX,1,FLLN,0),"^",6)=LOT,$P(^(0),"^",14)=MFG,$P(^(0),"^",15)=EXPDT,$P(^(1),"^",4)=FPER,$P(^(1),"^",5)=CPHARM
 S:$G(^PSDRUG(DRG,660.1))]"" ^PSDRUG(DRG,660.1)=^PSDRUG(DRG,660.1)-$P(^PSRX(IRX,1,FLLN,0),"^",4)
 I $P($G(^PS(59,DIV,"DISP")),"^",2),$G(RELDT) D
 .S DIE="^PSRX("_IRX_","""_1_""",",DA(1)=IRX,DA=FLLN
 .S DR="17///"_RELDT_";4////"_RPHARM D ^DIE K DIE,DR,DA
 .I $P(^PSRX(IRX,1,FLLN,0),"^",2)["W" S BRT="W",BDIV=$P(^PSRX(IRX,1,FLLN,0),"^",9),BNAM=$P(^PSRX(IRX,0),"^",2) S:BDIV'="" BGRP=$P($G(^PS(59,BDIV,1)),"^",20)
 .N YY S YY=FLLN        ;*209
 .S PSOCPRX=$P(^PSRX(IRX,0),"^"),RXP=IRX D CP^PSOCP
 .D EN^PSOHLSN1(IRX,"ZD"),AUTOREL^PSOBPSUT(IRX,FLLN,RELDT,NDC,"A",,30)
 ;else if not auto release nor rel dt
 E  I $$NDCFMT^PSSNDCUT(NDC)'="",$$STATUS^PSOBPSUT(IRX,FLLN)="" D SAVNDC^PSONDCUT(IRX,FLLN,NDC)
 Q
PARTIAL ;partial fill dispensed
 I '$D(^PSRX(IRX,"P",FLLN,0)) S NONODE=1 Q
 S $P(^PSRX(IRX,"P",FLLN,0),"^",6)=LOT,$P(^(0),"^",12)=NDC,$P(^PSRX(IRX,"P",FLLN,1),"^")=MFG,$P(^(1),"^",3)=FPER,$P(^(1),"^",4)=CPHARM
 S:$G(^PSDRUG(DRG,660.1))]"" ^PSDRUG(DRG,660.1)=^PSDRUG(DRG,660.1)-$P(^PSRX(IRX,"P",FLLN,0),"^",4)
 I $P($G(^PS(59,DIV,"DISP")),"^",2),$G(RELDT) D
 .S DIE="^PSRX("_IRX_","""_"P"_""",",DA(1)=IRX,DA=FLLN
 .S DR="8///"_RELDT_";.05////"_RPHARM D ^DIE K DIE,DR,DA
 .I $P(^PSRX(IRX,"P",FLLN,0),"^",2)["W" S BRT="W",BDIV=$P(^PSRX(IRX,"P",FLLN,0),"^",9),BNAM=$P(^PSRX(IRX,0),"^",2) S:BDIV'="" BGRP=$P($G(^PS(59,BDIV,1)),"^",20)
 Q
ACTLOG ;activity log entry
 N ATXT,ACTN,RXF
 S:FLL="F" RXF=$S(FLLN>5:FLLN+1,1:FLLN)
 S:FLL="P" RXF=6
 S ACL=0 F I=0:0 S I=$O(^PSRX(RXID,"A",I)) Q:'I  S ACL=(ACL+1)
 D NOW^%DTC S NOW=%,ACL=ACL+1,^PSRX(RXID,"A",0)="^52.3DA^"_ACL_"^"_ACL
 I 'MEDDISP S ATXT="Medication WAS NOT Dispensed through Interface!"
 ;
 ;create activity log text
 I MEDDISP D
 . S ATXT="External Interface Dispensing is Complete."
 . I $G(NONODE) D  Q                                ;node was deleted
 . . S ATXT="External Interface attempted to Release, but "
 . . S ATXT=ATXT_$S(FLL="P":"Partial fill",1:"Refill")_" NOT on file."
 . . S ACTN="No update performed."
 . . D MAIL^PSOHLDI1
 . I $G(^PSRX(RXID,"STA"))>11 D  Q                  ;non-active status
 . . S ATXT="Ext. Disp. Released this Rx, which is Status of "
 . . S ATXT=ATXT_$$GET1^DIQ(52,RXID,100)
 . . S ACTN=""
 . . D MAIL^PSOHLDI1
 S ^PSRX(RXID,"A",ACL,0)=NOW_"^N^"_RPHARM_"^"_RXF_"^"_ATXT
 ;
 ;other comments - additional info when dispensed
 I MEDDISP D
 .S ^PSRX(RXID,"A",ACL,2,0)="^52.34A^2^2"
 .S ^PSRX(RXID,"A",ACL,2,1,0)="Filled By: "_FPERN
 .S ^PSRX(RXID,"A",ACL,2,2,0)="Checking Pharmacist: "_CPHARMN
 Q
ERROR ;sends the error message back to the sending station
 ;parse the data from the msh segment in order to send back the error message release
 ;OK=1 - segment missing
 ;OK=2 - Rx does not exists
 D NOW^%DTC
 S REJ=$S(OK=1:"MISSING SEGMENT(S)",OK=2:"PRESCRIPTION "_$S($G(PSORX):"#: "_PSORX,1:"")_" DOES NOT EXISTS",1:"")
 S ACKDATE=$P($$FMTHL7^XLFDT(%),"-",1)
 S ^TMP("PSO2",$J,1)="MSH|^~\&|PSO VISTA||PSO DISPENSE||"_$G(ACKDATE)_"||RDS^013|10001|P|2.4|||NE|NE"
 ;S ^TMP("PSO2",$J,2)="MFE|MUP|"_$G(J)_"|"_$G(ACKDATE)_"|"_$G(SITE)_"|CE"
 ;S ^TMP("PSO2",$J,3)="ZLF|4|^"_$G(USER)_"||"_$G(REJ)
 K %,ACKDATE,USER,Y,REJ,OK
 Q
END K ACL,I,NOW,LBI,LB,PRT,MEDDISP
 K ADA,BDA,BDIV,BNGRXP,BNGSUS,BNAME,BRX,CNT1,CT,DA,DD,DIC,DIE,DIK,DIR,DO,DR,DTOUT,DUOUT,GRP,GRTP,JOES
 K NAM,NDA,NFLAG,NME,ODA,PSZ,RXO,SSN,TDFN,TFLAG,TIC,TICK,TIEN,TM,TM1,TSSN,X,Y,XX,BNAM,BRT,BGRP
 K Y,OK,XQADATA,SITEN,RDOM,CMOP,REQT,RTDTM,SITENUM,XQSOP,XQMSG,SITEN,NAME,XQAMSG,SITEN
 K XQAROU,XQAID,RDTM,NODE1,NODE2,NODE3,NODE4,NODE5,PIDID,PIDD,PICN,PSSN,PPID,PCLM
 K CPHARM,CPHARMN,FPER,FPERN,RPHARM
 Q
