SDESBLKANDMOVE1 ;ALB/MGD/TAW - BLOCK AND MOVE CONT. ;Jan 21, 2022
 ;;5.3;Scheduling;**800,801,803,804**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
TOOVBCHECK(SDTOCLIEN,TODTFM,APPTARY,FN,SDECAPPTIENS,POP,SDAPPT,OVB) ; Check if new appt will be considered an overbook
 N OBM,SDECWKIN,SDDFN,SDECATID
 S SDECWKIN=""
 S SDECATID=$G(APPTARY(FN,SDECAPPTIENS,.13,"E")) ;WALKIN - WALKIN flag y=YES; n=NO default to NO
 S SDDFN=$G(APPTARY(FN,SDECAPPTIENS,.05,"I")) ;Patient ID/DFN
 I SDECATID=""!(SDECATID="NO") S SDECATID=$P($G(^DPT(SDDFN,"S",TODTFM,0)),U,7) ;get the purpose of visit in the patient file if NULL in file 409.84
 S SDECATID=$S(SDECATID="YES"!(SDECATID=4):"WALKIN",1:SDECATID)
 I SDECATID="WALKIN" S SDECWKIN=1
 ; check for max overbook and overbook keys. We assume yes if any check w/ user is needed.
 S OBM=$$OBM1^SDEC57(SDTOCLIEN,TODTFM,0,,+SDECWKIN) ; Passing MRTC (3rd param) in as 0:False
 I $E(OBM,1)=0 S POP=1 D ERRLOG^SDESJSON(.SDAPPT,52,"Overbook not allowed")
 ; OVB 1:should be flagged as Overbook 2:shouldn't be flagged as Overbook
 S OVB=$S($E(OBM,1)=2:1,1:2)
 Q
 ;
PREBLOCK(FROMDTFM,FROMTIMESCALE,FROMRES,SDORGCLIEN,SDDATA44SL,SDSEGMENTS) ;
 ; 1st call to block original slots
 N SDINDX,SLOTS,MOVINGSTRT,SDECEND,EVALSTRT,EVALSTOP
 S EVALSTRT=$P(SDSEGMENTS(SDORGCLIEN,"F","EVALUATE"),U,1)
 S EVALSTOP=$P(SDSEGMENTS(SDORGCLIEN,"F","EVALUATE"),U,2)
 S EVALSTRT=$$PADLENGTH^SDESUTIL(EVALSTRT,"0",4,"F")
 ; If orig appt occupied more than 1 slot in a variable length clinic, block the additional slots
 S MOVINGSTRT=$P(FROMDTFM,".",1)_"."_EVALSTRT
 F SLOTS=1:1 D  Q:EVALSTOP<=+$$PADFMTIME^SDESUTIL($P(MOVINGSTRT,".",2))
 .S SDECEND=$$FMADD^XLFDT(MOVINGSTRT,,,+FROMTIMESCALE)
 .D BLOCK($P(MOVINGSTRT,".",1),$P(MOVINGSTRT,".",2),$P(SDECEND,".",2),SDORGCLIEN,SDDATA44SL,FROMTIMESCALE)
 .S MOVINGSTRT=SDECEND
 Q
 ;
BLOCK(SDSTDATE,SDSTTIME,SDENDTIME,SDORGCLIEN,SDDATA44SL,TIMESCALE) ; Logic copied from routine SDC
 N A,CANREM,DA,DFN,DH,I,FR,NOAP,P,SD,SDCNT,SDDATA0,STARTDAY,SDDFR,SDHTO,SI,ST,TO,X,Y,%
 S SC=SDORGCLIEN
 ; If the resource on the new IEN = resource on origial IEN, no need to block
 ; Determine timeslot equivalent
 S %=$S(TIMESCALE=10:6,TIMESCALE=20:3,TIMESCALE=15:4,TIMESCALE=30:2,1:1)
 S SI=$S(%="":4,%<3:4,%:%,1:4)
 S %=$P(SDDATA44SL,U,3),STARTDAY=$S($L(%):%,1:8) D NOW^%DTC S SDTIME=%
 S (CANREM,I)="BLOCK AND MOVE"
 S SD=SDSTDATE
 ; If Start Time = midnight set to 0001 to pass TC
 I $E(SDSTTIME,1,2)=24 S SDSTTIME="0001"
 I +SDSTTIME=0 S SDSTTIME="0001"
 S X=SDSTTIME_"0000",X=$E(X,1,4) D TC
 S FR=Y,ST=%
 ; If End Time = midnight set to 2359 to pass TC
 I $E(SDENDTIME,1,2)=24 S SDENDTIME=2359
 I +SDENDTIME=0 S SDENDTIME=2359
 S X=SDENDTIME_"0000",X=$E(X,1,4) D TC
 S SDHTO=X,TO=Y,SDDFR=TO-FR
 I '$D(^SC(SC,"SDCAN",0)) S ^SC(SC,"SDCAN",0)="^44.05D^"_FR_"^1" G SKIP
 S A=^SC(SC,"SDCAN",0),SDCNT=$P(A,"^",4),^SC(SC,"SDCAN",0)=$P(A,"^",1,2)_"^"_FR_"^"_(SDCNT+1)
SKIP S ^SC(SC,"SDCAN",FR,0)=FR_"^"_SDHTO
 S NOAP=$S($O(^SC(SC,"S",(FR-.0001)))'>0:1,$O(^SC(SC,"S",(FR-.0001)))>TO:1,1:0) I 'NOAP S NOAP=$S($O(^SC(SC,"S",+$O(^SC(SC,"S",(FR-.0001))),0))="MES":1,1:0)
 S ^SC(SC,"S",FR,0)=FR,^SC(SC,"S",FR,"MES")="CANCELLED UNTIL "_X_$S(I?.P:"",1:" ("_I_")")
 D S S I=^SC(SC,"ST",SD,1),I=I_$J("",%-$L(I)),Y="" I $G(SDDFR)<100,$L(I)<77 S I=I_"    " ;SD*5.3*758 - pad 4 empty spaces needed for blocks < 60 minutes
 F X=0:2:% S DH=$E(I,X+SI+SI),P=$S(X<ST:DH_$E(I,X+1+SI+SI),X=%:$S(Y="[":Y,1:DH)_$E(I,X+1+SI+SI),1:$S(Y="["&(X=ST):"]",1:"X")_"X"),Y=$S(DH="]":"",DH="[":DH,1:Y),I=$E(I,1,X-1+SI+SI)_P_$E(I,X+2+SI+SI,999)
 S:'$F(I,"[") I5=$F(I,"X"),I=$E(I,1,(I5-2))_"["_$E(I,I5,999) K I5
 S DH=0,^SC(SC,"ST",SD,1)=I,FR=FR-.0001 D C Q
S S ^SC(SC,"ST",SD,"CAN")=^SC(SC,"ST",SD,1) Q
 ;
C S FR=$O(^SC(SC,"S",FR)) I FR<1!(FR'<TO) K SDX Q
 N TDH,TMPD,DIE,DR,NODE,SDI
 ; SD*724 - Replace 'I' with 'SDI'
 F SDI=0:0 S SDI=$O(^SC(SC,"S",FR,1,SDI)) Q:SDI'>0  D
 .I '$D(^SC(SC,"S",FR,1,SDI,0)) I $D(^("C")) S J=FR,J2=SDI D DELETE^SDC1 K J,J2 Q  ;SD*5.3*545 delete corrupt node
 .I '+$G(^SC(SC,"S",FR,1,SDI,0)) S J=FR,J2=SDI D DELETE^SDC1 K J,J2 Q  ;SD*5.3*545 if DFN is missing delete record
 .Q:$P(^SC(SC,"S",FR,1,SDI,0),"^",9)="C"  ;SD*5.3*758 - Quit processing if appointment already canceled.
 .S DFN=+^SC(SC,"S",FR,1,SDI,0),SDCNHDL=$$HANDLE^SDAMEVT(1)
 .D BEFORE^SDAMEVT(.SDATA,DFN,FR,SC,SDI,SDCNHDL)
 .S $P(^SC(SC,"S",FR,1,SDI,0),"^",9)="C"
 .S:$D(^DPT(DFN,"S",FR,0)) NODE=^(0)  ;added SD/523
 .Q:$P(NODE,U,1)'=SC                  ;added SD/523
 .S ^DPT("ASDCN",SC,FR,DFN)=""
 .S SDSC=SC,SDTTM=FR,SDPL=SDI,TDH=DH,TMPD=CANREM D CANCEL^SDCNSLT S DH=TDH ;SD/478
 .I $D(^DPT(DFN,"S",FR,0)),$P(^(0),"^",2)'["C" S $P(^(0),"^",2)="C",$P(^(0),"^",12)=DUZ,$P(^(0),"^",14)=SDTIME,DH=DH+1,TDH=DH,DIE="^DPT(DFN,"_"""S"""_",",DR="17///^S X=CANREM",DA=FR D ^DIE S DH=TDH D MORE
 .D SDEC^SDCNP0(DFN,FR,SC,"C","",$G(CANREM),SDTIME,DUZ)   ;alb/sat 627
 G C
 ;
MORE I $D(^SC("ARAD",SC,FR,DFN)) S ^(DFN)="N"
 N SDV1
 S SDIV=$S($P(^SC(SC,0),"^",15)]"":$P(^(0),"^",15),1:" 1"),SDV1=$S(SDIV:SDIV,1:+$O(^DG(40.8,0))) I $D(^DPT("ASDPSD","C",SDIV,SC,FR,DFN)) K ^(DFN)
 ; SD*724 - set SDPL with value from SDI
 S SDH=DH,SDTTM=FR,SDSC=SC,SDPL=SDI,SDRT="D" D RT^SDUTL
 S DH=SDH K SDH D CK1,EVT
 K SD1,SDIV,SDPL,SDRT,SDSC,SDTTM,SDX Q
CK1 S SDX=0 F SD1=FR\1:0 S SD1=$O(^DPT(DFN,"S",SD1)) Q:'SD1!((SD1\1)'=(FR\1))  I $P(^(SD1,0),"^",2)'["C",$P(^(0),"^",2)'["N" S SDX=1 Q
 Q:SDX  F SD1=2,4 I $D(^SC("AAS",SD1,FR\1,DFN)) S SDX=1 Q
 Q:SDX  IF $D(^SCE(+$$EXAE^SDOE(DFN,FR\1,FR\1),0)) S SDX=1
 Q:SDX  K ^DPT("ASDPSD","B",SDIV,FR\1,DFN) Q
 ;
EVT ; -- separate tag if need to NEW vars
 ; -- cancel event
 N FR,I,SDTIME,DH,SC
 D CANCEL^SDAMEVT(.SDATA,DFN,SDTTM,SDSC,SDPL,0,SDCNHDL) K SDATA,SDCNHDL
 Q
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDAPPT,.RETURN,.JSONERR)
 Q
 ;
TC N %DT S X=$$FMTE^XLFDT(SD)_"@"_X,%DT="T" D ^%DT I Y<0!(X["?") Q
 S X=$E($P(Y_"0000",".",2),1,4),%=$E(X,3,4),%=X\100-STARTDAY*SI+(%*SI\60)*2 I %<0 S Y=-1
 I %>72 S Y=-1
 Q
 ;
HASPATRN(SDTOCLIEN,SDDOW,TODTFM) ;find day template pattern
 N SDE,SDTP
 S SDTP=""
 S SDTP=$G(^SC(SDTOCLIEN,"ST",$P(TODTFM,".",1),1))
 S SDE=$O(^SC(SDTOCLIEN,"T"_SDDOW,TODTFM+1),-1)
 ; If never defined on a specific DOW, check continue indefintely node
 I 'SDE S SDE=9999999
 S SDTP=$G(^SC(SDTOCLIEN,"T"_SDDOW,SDE,1))
 Q $S(SDTP="":0,1:1)
 ;
IDTIMESLOT(CLIEN,MAXSLOTS,CLINID) ;
 ; CLIEN = IEN of clinic
 ; MAXSLOTS = Maximum # of slots to check allowable
 N SDINDX,SDINDXEND,POP
 S POP=0
 S SDINDX=$P(SDSEGMENTS(CLIEN,CLINID,"EVALUATE"),U,1)-.0001
 S SDINDXEND=$P(SDSEGMENTS(CLIEN,CLINID,"EVALUATE"),U,2)
 F  S SDINDX=$O(SDSEGMENTS(CLIEN,CLINID,"SCHEDULE",SDINDX)) Q:'SDINDX!(SDINDX>=+SDINDXEND)  D  Q:POP
 .I $P(SDSEGMENTS(CLIEN,CLINID,"SCHEDULE",SDINDX),U,2)>MAXSLOTS S POP=1
 Q POP
 ;
CHKAVAILABILITY(RES,CLIEN,APPTDTNET,CLINID,MOVE2DATE) ;Check the Clinic Resource and Appt Dt for slot availability
 ; RES - Clinic resource of the new appointment
 ; CLIEN - IEN of clinic being evaluated
 ; APPTDTNET - Appointment date/time in external format
 ; CLINID - F = From clinic, T = To clinic
 ; MOVE2DAT - The original appt date/tm or the new appt date/tm in FM format
 ;
 N RET,TEXT,I,DATA,SLOTS,CNT,EVALSTRT,EVALSTOP,APPTSTRT,APPTEND,EAPPTDATA
 S SLOTS="",CNT=0
 S EVALSTRT=+SDSEGMENTS(CLIEN,CLINID,"EVALUATE")
 S EVALSTOP=+$P(SDSEGMENTS(CLIEN,CLINID,"EVALUATE"),U,2)
 K ^TMP("SDEC57",$J)
 D APPSLOTS^SDEC57(.RET,RES,APPTDTNET,APPTDTNET)
 S TEXT=$G(^TMP("SDEC57",$J,"APPSLOTS",1))
 I $P(TEXT,"^",1)=-1 D  Q
 .S POP=1 D ERRLOG^SDESJSON(.SDAPPT,52,$P(TEXT,"^",2))
 I CLINID="T",TEXT="" S POP=1 D ERRLOG^SDESJSON(.SDAPPT,124,"Destination clinic is not open on this date") Q
 ;
 ;DATA = fm dt ^ fm time ^ ^# of slots
 S I=0
 F  S I=$O(^TMP("SDEC57",$J,"APPSLOTS",I)) Q:I=""  D  Q:POP
 .S DATA=^TMP("SDEC57",$J,"APPSLOTS",I)
 .S DATA=$$CTRL^XMXUTIL1(DATA)
 .I +$P(DATA,"^",2)<EVALSTRT Q
 .I +$P(DATA,"^",2)>=EVALSTOP Q
 .S SLOTS=$P(DATA,"^",4)
 .Q:SLOTS=""  ; Appears APPSLOTS^SDEC57 puts a "" to represent the period after the end of clinic availability
 .I CLINID="F" D  ; ### check order of next 2 lines
 ..I SLOTS'="0",SLOTS'="1",SLOTS'="*" S POP=1 D ERRLOG^SDESJSON(.SDAPPT,124,"appointment currently overbooked") Q
 ..;If orig appt slot is overbook, no B&M
 ..I +$P(DATA,U,2)=+$$PADFMTIME^SDESUTIL($P(FROMDTFM,".",2)) D
 ...I SLOTS'=0,SLOTS'="*" S POP=1 D ERRLOG^SDESJSON(.SDAPPT,124,"appointment currently overbooked")
 .I CLINID="T" D  Q:POP
 ..I SLOTS'>0 S POP=1 D ERRLOG^SDESJSON(.SDAPPT,124,"Destination clinic has no availability") Q
 ; Check for existing appts in clinic based on Start/End time of appt
 Q:POP
 N TIME,IEN
 S TIME=$$PADLENGTH^SDESUTIL(EVALSTOP,"0",4,"F")
 S TIME=$P(MOVE2DATE,".",1)_"."_TIME
 F  S TIME=$O(^SDEC(409.84,"ARSRC",RES,+TIME),-1) Q:TIME'[$P(MOVE2DATE,".",1)  D  Q:POP
 .S IEN=""
 .F  S IEN=$O(^SDEC(409.84,"ARSRC",RES,TIME,IEN)) Q:'IEN  D  Q:POP
 ..Q:IEN=APPTIEN
 ..S EAPPTDATA=$G(^SDEC(409.84,IEN,0))
 ..Q:EAPPTDATA=""
 ..; Skip cancelled appts
 ..I $P(EAPPTDATA,U,17)'=""&("C^CA^PC^PCA^"["^"_$P(EAPPTDATA,U,17)_"^") Q
 ..S APPTSTRT=$E($P($P(EAPPTDATA,"^",1),".",2)_"0000",1,4)
 ..S APPTEND=$E($P($P(EAPPTDATA,"^",2),".",2)_"0000",1,4)
 ..; The Appt start time > EVALUATE start time
 ..I APPTSTRT>EVALSTRT S POP=1 D ERRLOG^SDESJSON(.SDAPPT,124,"Existing scheduling conflict") Q
 ..; If any existing appt has a partial overlap within our EVALUATE Start/End - can't B&M
 ..I APPTEND>EVALSTRT,APPTEND<EVALSTOP S POP=1 D ERRLOG^SDESJSON(.SDAPPT,124,"Existing scheduling conflict") Q
 Q
