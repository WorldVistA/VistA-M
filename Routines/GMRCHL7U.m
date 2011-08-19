GMRCHL7U ;SLC/DCM,MA - Utilities assoc. with HL7 messages ;04/29/09  09:04
 ;;3.0;CONSULT/REQUEST TRACKING;**1,5,12,21,22,29,66**;DEC 27, 1997;Build 30
 ; Patch #21 added more variables to in line tage EXIT.
 ;
 ; This routine invokes IA #872(FILE 101 ^ORD(100)), #2053(DIE), #10103(XLFDT), #10101(XQOR)
 ;
INIT(MSH) ;break out MSH segment separators and set other needed variables
 ;MSH = MSH segment of the HL-7 message
 N X
 S (SEP1,SEP2,SEP3,SEP4,SEP5)=""
 S SEP1=$E(MSH,4),X=$P(MSH,SEP1,2)
 S SEP2=$E(X,1),SEP3=$E(X,2),SEP4=$E(X,3),SEP5=$E(X,4)
 Q
PID(GMRCPID) ;Get fields from PID segment and set into GMRC variables.
 S DFN=$P(GMRCPID,SEP1,4),GMRCPNM=$P(GMRCPID,SEP1,6)
 Q
NTE(MSG,GMRCNTE,GMRCNODE,CTRLCODE) ;set NTE segments of HL-7 message into variables and globals
 ;MSG = whole HL-7 array.
 ;GMRCNTE = Node in array where NTE message begins
 ;CTRLCODE = segment 1 of the ORC segment of HL-7 message
 ;GMRCNODE = IEN of entry int file ^GMR(123,
 N GMRCACT ;not sure why this is newed here
 S GMRCAD=$G(GMRCAD),GMRCORNP=$G(GMRCORNP),GMRCFF=$G(GMRCFF),GMRCPA=$G(GMRCPA),GMRCDEV=$G(GMRCDEV)
 S GMRCACT=$S(CTRLCODE="CA":19,CTRLCODE="DC":6,CTRLCODE="NW":1,1:$O(^GMR(123.1,"D",CTRLCODE,0)))
 S GMRCNTC(1)=$P(MSG(GMRCNTE),SEP1,4)
 S LN=0,LN1=2 F  S LN=$O(MSG(GMRCNTE,LN)) Q:LN=""  S GMRCNTC(LN1)=MSG(GMRCNTE,LN),LN1=LN1+1
 K LN,LN1
 Q
PV1(GMRCPV1) ;Get fields from PV1 segment of HL-7 message and set into GMRC variables
 ;GMRCRB  = patients room/bed            GMRCWARD=patients ward
 ;GMRCSBR = service basis to be rendered (Inpatient or Outpatient)
 N X
 S X=$P(GMRCPV1,SEP1,3),GMRCSBR=$S(X]"":X,1:"")
 S X=$P(GMRCPV1,SEP1,4),GMRCWARD=$S($P(X,SEP2,1)]"":$P(X,SEP2,1),1:""),VISIT=$S($P(GMRCPV1,SEP1,20)]"":$P(GMRCPV1,SEP1,20),1:"")
 S GMRCRB=$S($P(X,SEP2,2)]"":$P(X,SEP2,2),1:"")
 S:VISIT]"" GMRCVSIT=$$FMDATE^GMRCHL7(VISIT)
 Q
 ;
REJECT(GMRCMSG,REAS) ;action can't be filed send reject message
 N MSH,ORC,I ;GMRCMESS
 S I=0 F  S I=$O(GMRCMSG(I)) Q:'I  D
 . I $P(GMRCMSG(I),"|")="PID" S PID=GMRCMSG(I)
 . I $P(GMRCMSG(I),"|")="ORC" D
 .. N ORFN,GMRCFN,P17,CTRLCD
 .. S ORFN=$P(GMRCMSG(I),"|",3),GMRCFN=$P(GMRCMSG(I),"|",4)
 .. S CTRLCD=$P(GMRCMSG(I),"|",2)
 .. S ORC="ORC|"_$S(CTRLCD="NW":"UA",1:"UD")_"|"_ORFN_"|"_GMRCFN
 .. S P17=$S($D(REAS):REAS,1:"UNABLE TO FILE ACTION")
 .. S $P(ORC,"|",17)="X^REJECTED^99ORN^^"_P17
 S MSH=$$MSH^GMRCHL7
 S $P(MSH,SEP1,9)="ORR"
 S GMRCMESS(1)=MSH
 S GMRCMESS(2)=PID
 S GMRCMESS(3)=ORC
 D MSG^XQOR("GMRC EVSEND OR",.GMRCMESS)
 Q
 ;
RETURN(GMRCIEN,GMRCTRLC) ;return IEN of record in ^GMR(123,IEN, to OERR
 ;GMRCIEN = internal record number of record in ^GMR(123,
 ;GMRCTRLC=Control code from HL-7 Table 119
 N MSH,PID,ORC,GMRCORCC
 S SEP1="|",GMRCORCC=$S(GMRCTRLC="NW":"OK",GMRCTRLC="DC":"DR",1:"OK")
 S MSH=$$MSH^GMRCHL7($G(X)) S $P(MSH,SEP1,9)="ORR"
 S PID=$$PID^GMRCHL7(GMRCIEN)
 D ORC^GMRCHL7(GMRCIEN,GMRCORCC,"") S ORC=$P(ORC,"|",1,4)
 D BLD^GMRCHL7(MSH,PID,"",ORC,"","",,"",GMRCTRLC)
 D MSG^XQOR("GMRC EVSEND OR",.GMRCMSG)
 Q
FILE(GMRCO,DR) ;File data into ^GMR(123,IEN,40 using ^DIE
 N DIE,DA,GMRCACTI
 ;GMRCO = IEN of record from file ^GMR(123,
 ;DR = DR string required by ^DIE
 Q:'$G(GMRCO)
 L +^GMR(123,+GMRCO,40):$S($G(DILOCKTM)>0:DILOCKTM,1:5) S:'$D(^GMR(123,+GMRCO,40,0)) ^(0)="^123.02DA^^" ;wat/66 added lock timeout
 S (DA,GMRCACTI)=$S($P(^GMR(123,+GMRCO,40,0),"^",3):$P(^(0),"^",3)+1,1:1),DA(1)=+GMRCO
 S DIE="^GMR(123,"_GMRCO_",40,"
 S $P(^GMR(123,+GMRCO,40,0),"^",3,4)=DA_"^"_DA
 D ^DIE
 I $D(GMRCNTC) D COMMENT^GMRCHL7B(.GMRCNTC)
 I $D(GMRCCMT) D COMMENT^GMRCHL7B(.GMRCCMT)
 D  ; if record is an IFC build and send update
 . I '$D(^GMR(123,GMRCO,12)) Q
 . D TRIGR^GMRCIEVT(GMRCO,GMRCACTI)
 L -^GMR(123,+GMRCO,40)
 Q
EXIT ;Kill variables and exit
 K HLQ,J,LN,ND,ND1,ND2,SEP1,SEP2,SEP3,SEP4,SEP5
 K GMRCA,GMRCACT,GMRCAD,GMRCAP,GMRCAPP,GMRCATN,GMRCDA,GMRCDEV,GMRCFAC,GMRCFF,GMRCINTR,GMRCMTP,GMRCMSG,GMRCMSH,GMRCNOD,GMRCNTC,GMRCODT,GMRCOID,GMRCORFN,GMRCPA,GMRCPLCR,GMRCPLI,GMRCPNM,GMRCPR,GMRCPRI,GMRCFQ
 K GMRCPRDG,GMRCSEND,GMRCSTDT,GMRCSTS,GMRCURGI,GMRCVAL,GMRCVTYP,GMRCWARD,GMRCPRV,GMRCTYPE,GMRCND,GMRCND1,VISIT
 K GMRCRB,GMRCPRA,GMRCRFQ,MSH,OBXND,PID,GMRCORPV,GMRCOTXT,GMRCNATO,GMRCERDT ;WAT/66
 K GMRCOFN,GMRCS123,GMRCS38,GMRCCMT
 K GMRCTRLC,GMRCSS,GMRCO,GMRCORNP
 Q
AUDIT0 ;place activity audit tracking info into global ^GMR(123,IEN,40,
 ;GMRCACT=processing activity (from ^GMR(123.1,
 ;GMRCDA=date/time file entered     GMRCAD=date/time activity took place
 ;GMRCORNP=name of provider         GMRCFF=forwared from (if forwarded)
 ;GMRCPA=provider previously assigned
 ;GMRCDEV=device printed to        GMRCCMT=comment array from OBX segment
 N GMRCDA
 S GMRCDA=$$NOW^XLFDT
 L +^GMR(123,+GMRCO,40):$S($G(DILOCKTM)>0:DILOCKTM,1:5) S:'$D(^GMR(123,+GMRCO,40,0)) ^GMR(123,+GMRCO,40,0)="^123.02DA^^" ;wat/66 added lock timeout
 S GMRCAD=$S($D(GMRCAD):GMRCAD,1:GMRCDA),GMRCORNP=$G(GMRCORNP),GMRCFF=$G(GMRCFF),GMRCPA=$G(GMRCPA),GMRCDEV=$G(GMRCDEV),GMRCPLCR=$G(GMRCPLCR)
 ;Use the Control code from CPRS in 123.1 to determine the action.
 ;If action undefined, then use "ADDED COMMENT", entry 20.
 S GMRCACT=$O(^GMR(123.1,"D",GMRCTRLC,0))
 S:'GMRCACT GMRCACT=20
 S DR=".01////^S X=GMRCDA;1////^S X=GMRCACT;2////^S X=GMRCAD;3////^S X=GMRCORNP;4////^S X=GMRCPLCR;6////^S X=GMRCFF;7////^S X=GMRCPA;8////^S X=GMRCDEV"
 D FILE(GMRCO,DR)
 L -^GMR(123,+GMRCO,40)
 Q
ALERT(GMRCDFN,GMRCSS,GMRCPR,GMRCFN,GMRCURG,GMRCORA) ;generate an alert when receiving a consult
 ;GMRCDFN=patient DFN from file 2
 ;GMRCSS=Service
 ;GMRCPR=procedure being ordered
 ;GMRCFN=File 123 IEN
 ;GMRCURG=urgency of request from protocol file
 ;GMRCADUZ=array of those who receive alerts
 ;GMRCORA=action to take on alert: 27 is for new alert
 N GMRCORTX
 S GMRCORTX="New consult "_$$ORTX^GMRCAU(+GMRCO)_$S(+GMRCURG:" ("_$P(^ORD(101,+GMRCURG,0),"^",2)_")",1:"")
 S:'$D(GMRCORA) GMRCORA=27 S:GMRCORA="" GMRCORA=27
 D MSG^GMRCP(GMRCDFN,GMRCORTX,GMRCFN,GMRCORA,.GMRCADUZ,1)
 K GMRCADUZ
 Q
