SCAPMCA1 ;BP-CIOFO/KEITH - Get all assignment info. (cont.) ; 30 Jul 99  3:29 PM
 ;;5.3;Scheduling;**177**;AUG 13, 1993
 ;
GETDAT ;Get assignment data
 ;
GETTM ;Get team information
 S SCI=$$TMPT^SCAPMC(DFN,.SCDT,,SCRATCH1)
 S SCI=0 F  S SCI=$O(^TMP("SCRATCH1",$J,SCI)) Q:'SCI  D
 .S SCTMD=^TMP("SCRATCH1",$J,SCI),SCTM=+SCTMD,SCPTA=+$P(SCTMD,U,3)
 .Q:SCTM'>0  ;invalid TEAM ifn
 .Q:SCPTA'>0  ;invalid PATIENT TEAM ASSIGNMENT ifn
 .S @SCARR@(DFN,"TM",SCTM,SCPTA)=SCTMD
 .Q
 K @SCRATCH1
 ;
GETPOS ;Get position information
 S SCI=$$TPPT^SCAPMC(DFN,.SCDT,,,,,,SCRATCH1)
 S SCI=0 F  S SCI=$O(^TMP("SCRATCH1",$J,SCI)) Q:'SCI  D
 .S SCPOSD=^TMP("SCRATCH1",$J,SCI)
 .S SCTM=$P(SCPOSD,U,3),SCPTPA=$P(SCPOSD,U,4),SCPOS=+SCPOSD
 .Q:SCPOS'>0  ;invalid TEAM POSITION ifn
 .Q:SCTM'>0  ;invalid TEAM ifn
 .Q:SCPTPA'>0  ;invalid PATIENT TEAM POSITION ASSIGNMENT ifn
 .S SCPTPA0=$G(^SCPT(404.43,SCPTPA,0))
 .S SCPTA=+SCPTPA0,SCPCPOSF=$P(SCPTPA0,U,5)
 .Q:SCPTA'>0  ;invalid PATIENT TEAM ASSIGNMENT ifn
 .S @SCARR@(DFN,"TM",SCTM,SCPTA,"POS",SCPTPA)=SCPOSD
 .D SETF(SCPCPOSF,"POS",SCPOSD)
 .S SCADT=$P(SCPOSD,U,5)  ;position activate date
 .S:'SCADT SCADT=SCDT("BEGIN")
 .S SCIDT=$P(SCPOSD,U,6)  ;position inactivate date
 .S:'SCIDT SCIDT=SCDT("END")
 .;xref team pc position assignments
 .I SCPCPOSF S @SCARR@(DFN,"TM",SCTM,SCPTA,"PC",SCADT,SCIDT)=""
 .K SCDT2 D DTRADJ(SCADT,SCIDT,.SCDT,.SCDT2)
 .;
 .;Get provider information
 .K @SCRATCH2
 .S SCII=$$PRTPC^SCAPMC(SCPOS,.SCDT2,SCRATCH2,"ERR",1,1),SCII=0
 .F  S SCII=$O(^TMP("SCRATCH2",$J,SCII)) Q:'SCII  D
 ..F SCSUB="PROV-U","PROV-P" S SCIII="" D
 ...F  S SCIII=$O(^TMP("SCRATCH2",$J,SCII,SCSUB,SCIII)) Q:SCIII=""  D
 ....S SCPRD=^TMP("SCRATCH2",$J,SCII,SCSUB,SCIII)
 ....S SCPAH=+$P(SCPRD,U,11)  ;position assignment history ifn
 ....S @SCARR@(DFN,"TM",SCTM,SCPTA,"POS",SCPTPA,"PROV",SCPAH)=SCPRD
 ....D SETF(SCPCPOSF,$S(SCSUB="PROV-P"&SCPCPOSF:"AP",1:"PR"),SCPRD)
 ....Q
 ...Q
 ..S SCIII=""
 ..F  S SCIII=$O(^TMP("SCRATCH2",$J,SCII,"PREC",SCIII)) Q:SCIII=""  D
 ...S SCPRD=^TMP("SCRATCH2",$J,SCII,"PREC",SCIII)
 ...S SCPPOS=+$P(SCPRD,U,3),SCPPOSD=$$PPOS(SCPRD,SCPPOS)
 ...S @SCARR@(DFN,"TM",SCTM,SCPTA,"POS",SCPTPA,"PPOS",SCPPOS)=SCPPOSD
 ...D SETF(SCPCPOSF,"PPOS",SCPPOSD) S SCPAH=+$P(SCPRD,U,11)
 ...S @SCARR@(DFN,"TM",SCTM,SCPTA,"POS",SCPTPA,"PPOS",SCPPOS,"PPROV",SCPAH)=SCPRD
 ...D SETF(SCPCPOSF,$S(SCPCPOSF:"PR",1:"PPR"),SCPRD)
 ...Q
 ..Q
 .Q
 ;Set team "flat" nodes
 S SCTM=0 F  S SCTM=$O(@SCARR@(DFN,"TM",SCTM)) Q:'SCTM  S SCPTA=0 D
 .F  S SCPTA=$O(@SCARR@(DFN,"TM",SCTM,SCPTA)) Q:'SCPTA  D
 ..S SCTMD=$G(@SCARR@(DFN,"TM",SCTM,SCPTA)) Q:'$L(SCTMD)
 ..D SETF($P(SCTMD,U,8)=1,"TM",SCTMD)
 ..Q
 .Q
 Q
 ;
GAP(SCTAC,SCTINAC,SCADT,SCIDT) ;Determine if a gap exists in pc assignments
 N GAP
 S GAP=0 D G1(SCADT,SCIDT)
 Q GAP
 ;
G1(SCADT,SCIDT) ;Loop through position assignments
 N X1,X2,X
 S SCADT=$O(@SCARR@(DFN,"TM",SCTM,SCPTA,"PC",SCIDT-1))
 I 'SCADT S GAP=(SCIDT<SCTINAC) Q
 S X1=SCADT,X2=SCIDT D ^%DTC I X>1 S GAP=1 Q
 S SCIDT=$O(@SCARR@(DFN,"TM",SCTM,SCPTA,"PC",SCADT,""),-1)
 I SCIDT'<SCTINAC Q
 D G1(SCADT,SCIDT) Q
 ;
PPOS(SCSTR,SCPPOS) ;Get preceptor position information
 ;Input: SCSTR=preceptor data string from PRTP^SCAPMC
 ;Input: SCPPOS=preceptor TEAM POSITION ifn
 ;Output: position information data string as defined in ^SCAPMCA
 ;
 N SCX,SCI,SCPPOS0
 S SCPPOS0=$G(^SCTM(404.57,+SCPPOS,0))
 Q:'$L(SCPPOS0) ""
 S SCX(1)=SCPPOS  ;position ifn
 S SCX(2)=$P(SCPPOS0,U)  ;position name
 S SCX(3)=$P(SCPPOS0,U,2)  ;team ifn
 S SCX(4)=$P(SCPOSD,U,4)  ;patient team position assignment ifn
 S SCX(5)=$P(SCSTR,U,5)  ;effective date
 S SCX(6)=$P(SCSTR,U,6)  ;inactive date
 S SCX(7)=$P(SCPPOS0,U,3)  ;role ifn
 S SCX(8)=$P($G(^SD(403.46,+SCX(7),0)),U)  ;role name
 S SCX(9)=$P(SCPPOS0,U,13)  ;user class ifn
 S SCX(10)=$P($G(^USR(8930,+SCX(9),0)),U)  ;user class name
 S SCX(11)=$P(SCPOSD,U,11)  ;patient team assignment ifn
 S SCX(12)=""  ;preceptor position
 S SCX="" F SCI=1:1:12 S $P(SCX,U,SCI)=SCX(SCI)
 Q SCX
 ;
DTRADJ(ADT,IDT,SCDT,SCDT2) ;Adjust dates for provider information
 ;Input: ADT=activate date for patient team position assignment
 ;Input: IDT=inactivate date for patient team position assignment
 ;Input: SCDT=array of dates from calling program (pass by reference)
 ;Input: SCDT2=array to return adjusted dates (pass by reference)
 ;
 S SCDT2("BEGIN")=$S(SCADT>SCDT("BEGIN"):SCADT,1:SCDT("BEGIN"))
 S SCDT2("END")=$S('SCIDT:SCDT("END"),SCIDT<SCDT("END"):SCIDT,1:SCDT("END"))
 S SCDT2("INCL")=SCDT("INCL"),SCDT2="SCDT2"
 Q
 ;
SETF(SCPC,SUB,DATA) ;Set "flat" array node
 ;Input: SCPC=PC/NPC flag
 ;Input: SUB=subscript value
 ;Input: DATA=data string
 N X,CT
 S X=$S(SCPC>0:"PC",1:"NPC"),SUB=X_SUB
 S @SCARR@(DFN,SUB,0)=@SCARR@(DFN,SUB,0)+1
 S CT=@SCARR@(DFN,SUB,0),@SCARR@(DFN,SUB,CT)=DATA
 Q
