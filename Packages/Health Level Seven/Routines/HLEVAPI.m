HLEVAPI ;O-OIFO/LJA - Event Monitor APIs ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; Routine   Supported APIs...
 ; -----------------------------------------------------------------
 ; HLEVAPI   START(VAR)
 ; HLEVAPI   CHECKIN
 ; HLEVAPI   CHECKOUT
 ; HLEVAPI   ABORT(STATUS,APPLSTAT)
 ; HLEVAPI   MAILIT
 ; HLEVAPI   VARIABLE
 ; -----------------------------------------------------------------
 ; HLEVAPI0  ONOFFM(HLEVIENE) 
 ; -----------------------------------------------------------------
 ; HLEVAPI1  APPSTAT(STATUS)
 ; HLEVAPI1  MSGTEXT(GBL)
 ; HLEVAPI1  RUNDIARY(GBL)
 ;
 ;
 ; Test server code with TEST^HLEVSRV1 (Also HLEVMNU)
 ; Test monitor code with TEST^HLEVUTI1 (Also HLEVMNU)
 ;
 ;
 ;                     EVENT CODE 
 ;
VARIABLE(HLEVIENJ,HLVAR) ; Store passed in variables...
 ; HLVAR can be the name of a variable, like "CT", or it can be
 ; a list of variables passed by reference.
 N VAL,VAR
 ;
 D DEBUG^HLEVAPI2("VARIABLE") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 QUIT:$G(^HLEV(776,+$G(HLEVIENJ),0))']""  ;->
 ;
 ; Loop thru array...
 S VAR=""
 F  S VAR=$O(HLVAR(VAR)) Q:VAR']""  D
 .  I $E(VAR,$L(VAR))="*" D  QUIT  ;->
 .  .  QUIT:VAR="*"  ;->
 .  .  D VARSTAR(HLEVIENJ,VAR)
 .  D STOREIT(HLEVIENJ,VAR,$S($D(@VAR):@VAR,1:"---"),$G(HLVAR(VAR)))
 ;
 Q
 ;
VARSTAR(HLEVIENJ,VAR) ; Store VAR* variables...
 N GBL,LP,REF,ROOT,X,X1
 ;
 KILL ^TMP("HLORDER",$J)
 S GBL=$NA(^TMP("HLORDER",$J)),ROOT=$E(GBL,1,$L(GBL)-1)_","
 S X=ROOT,X1(VAR)="" D ORDER^%ZOSV
 QUIT:'$D(GBL)  ;->
 ;
 ; $Q thru global...
 S LP=GBL
 F  S LP=$Q(@LP) Q:LP'[ROOT  D
 .  S REF=$P(LP,ROOT,2) QUIT:REF'[")"  ;->
 .  S REF=$P($TR(REF,"""",""),")") QUIT:REF']""  ;->
 .  I $L(REF)>10 S REF=$E(REF,1,9)_"~"
 .  D STOREIT(+HLEVIENJ,REF,@LP)
 ;
 Q
 ;
STOREIT(HLEVIENJ,VAR,VAL,EXPL) ; Store VAR in 776...
 N MIEN
 S EXPL=$G(EXPL)
 S MIEN=$O(^HLEV(776,+HLEVIENJ,52,"B",VAR,0))
 I MIEN'>0 S MIEN=$O(^HLEV(776,+HLEVIENJ,52,":"),-1)+1
 S ^HLEV(776,+HLEVIENJ,52,+MIEN,0)=VAR_$S(EXPL]"":U_EXPL,1:"")
 S ^HLEV(776,+HLEVIENJ,52,+MIEN,52)=VAL
 S ^HLEV(776,+HLEVIENJ,52,"B",VAR,MIEN)=""
 S MIEN=$O(^HLEV(776,+HLEVIENJ,52,":"),-1)
 I MIEN'>0 KILL ^HLEV(776,+HLEVIENJ,52) QUIT  ;->
 S ^HLEV(776,+HLEVIENJ,52,0)="^776.003A^"_MIEN_U_MIEN
 Q
 ;
STOREVAR ; Update VARIABLE VALUE multiple in 776...
 ; HLEVIENJ -- req
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 N MIEN,VAL,VAR
 ; Store variable values in 776...
 S VAR=""
 F  S VAR=$O(HLEVAR(VAR)) Q:VAR']""  D
 .  S VAL=$S($D(@VAR):@VAR,1:"---")
 .  S MIEN=$O(^HLEV(776,+HLEVIENJ,52,"B",VAR,0))
 .  I MIEN'>0 S MIEN=$O(^HLEV(776,+HLEVIENJ,52,":"),-1)+1
 .  S ^HLEV(776,+HLEVIENJ,52,+MIEN,0)=VAR_U_HLEVAR(VAR)
 .  S ^HLEV(776,+HLEVIENJ,52,+MIEN,52)=VAL
 .  S ^HLEV(776,+HLEVIENJ,52,"B",VAR,MIEN)=""
 S MIEN=$O(^HLEV(776,+HLEVIENJ,52,":"),-1)
 I MIEN'>0 KILL ^HLEV(776,+HLEVIENJ,52) QUIT  ;->
 S ^HLEV(776,+HLEVIENJ,52,0)="^776.003A^"_MIEN_U_MIEN
 Q
 ;
START(VARIABLE) ; Start the whole monitoring process.
 ; HLEVIENE,HLEVIENJ,HLEVIENM -- req --> HLEVAR()
 ;
 ; - Pass in by reference the VARIABLEs being tracked.
 ;
 ;   >S VAR("VARNAME")="REPORT-VARNAME"
 ;   >D DECLARE("MONITOR-NAME",.VAR)
 ;
 N E,EXPL,I,MIEN,NO,NODE,TXT,VAR
 ;
 D DEBUG^HLEVAPI2("START") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 ; Check STATUS-EVENT...
 QUIT:$P($G(^HLEV(776.999,1,0)),U,6)'="A"  ;->
 ;
 ; Presets...
 S NO=0
 KILL HLEVAR
 ;
 ; If passed in a variable name directly in VARIABLE
 I $G(VARIABLE)]"" F PCE=1:1:$L(VARIABLE,U) D
 .  S X=$P(VARIABLE,U,+PCE) I X]"" S NO=NO+1,HLEVAR(X)=X
 ;
 ; Convert passed in variable to format expected by CHECKIN & CHECKOUT
 S VAR=""
 F  S VAR=$O(VARIABLE(VAR)) Q:VAR']""  D
 .  S EXPL=VARIABLE(VAR) S:EXPL']"" EXPL=VAR
 .  S NO=NO+1,HLEVAR(VAR)=EXPL
 ;
 KILL VARIABLE
 ;
 ; Make initial DIARY entry...
 S TXT="DECLARE called - "_$P($G(^HLEV(776.1,+HLEVIENE,0)),U)
 D WPTXT^HLEVUTIL(776,HLEVIENJ,50,776.001,TXT)
 ;
 Q
 ;
CHECKIN ; Call here to update the EVENT using "your" DECLARE variables...
 N D,D0,DA,DI,DIE,DR,NO
 ;
 D DEBUG^HLEVAPI2("CHECKIN") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 ; Does entry exist?
 QUIT:$G(^HLEV(776,+$G(HLEVIENJ),0))']""  ;->
 ;
 D STOREVAR
 ;
 ; Fill in zero node...
 S DA=+HLEVIENJ,DIE=776
 S DR="4///R;6////"_$$NOW^XLFDT
 D ^DIE
 ;
 Q
 ;
ABORT(STATUS,APPLST) ; Call here if job is to be aborted...
 N DA,DIE,DR,NOW
 ;
 D DEBUG^HLEVAPI2("ABORT") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 ; Does entry exist?
 QUIT:$G(^HLEV(776,+$G(HLEVIENJ),0))']""  ;->
 ;
 D CHECKIN
 ;
 S DA=+HLEVIENJ,DIE=776
 S NOW=$$NOW^XLFDT
 S STATUS=$E($$UP^XLFSTR($G(STATUS)_" "))
 S STATUS=$S("EFQR"[STATUS:STATUS,1:"E")
 S DR="2////"_NOW_";4///"_STATUS_";6////"_NOW
 S:$G(APPLST)]"" DR=DR_";5///"_$TR($E(APPLST,1,10),U,"~")
 D ^DIE
 ;
 D EVCHKD^HLEVAPI2($G(HLEVIENM),$G(HLEVIENE),$G(HLEVIENJ),STATUS)
 ;
 KILL HLEVAR ; Passed-in user variables...
 ;
 Q
 ;
CHECKOUT ; Call here to end EVENT using "your" DECLARE variables...
 N DA,DIE,DR,NOW
 ;
 D DEBUG^HLEVAPI2("CHECKOUT") ; Debug data created conditionally
 ;
 ; Stop all event monitoring to enable on-site debugging...
 QUIT:$G(^TMP("HLEVFLAG",$J))["STOP"  ;->
 ;
 ; Does entry exist?
 QUIT:$G(^HLEV(776,+$G(HLEVIENJ),0))']""  ;->
 ;
 D CHECKIN
 ;
 S DA=+HLEVIENJ,DIE=776
 S NOW=$$NOW^XLFDT
 S DR="2////"_NOW_";4///F;6////"_NOW
 D ^DIE
 ;
 D EVCHKD^HLEVAPI2($G(HLEVIENM),$G(HLEVIENE),$G(HLEVIENJ))
 ;
 KILL HLEVAR ; Passed-in user variables...
 ;
 Q
 ;
MAILIT D MAILIT^HLEVAPI3
 Q
 ;
SENDMAIL(HLEVIENE,HLEVIENJ,XMY) ; Mail info in 776 event monitor's ^(51)...
 ;
 ; PARAMETER NOTES
 ; ---------------------------------------------------------------------
 ; XMY     Pass in XMY by reference.
 ; XMSUB   If XMSUB pre-exists, it will be used.
 ; XMTEXT  The text for the mailman message will come from one of 
 ;         three sources:
 ;           (1) If XMTEXT is pre-set, it will be used.
 ;           (2) If XMTEXT is not passed in, then the MAILMAN MESSAGE
 ;               TEXT global ^HLEV(776,IEN,51,#,0) will be used, if it
 ;               exits.
 ;           (3) Otherwise, a generic "message is completed" message
 ;               will be sent.
 ;
 N MGRP,NO,SITE,TEXT,XMDUZ,X,XMZ
 ;
 ; If no recipients passed in and no mail group exists, quit...
 QUIT:$O(XMY(""))']""  ;->
 ;
 QUIT:$P($G(^HLEV(776.1,+$G(HLEVIENE),0)),U)']""  ;->
 QUIT:$P($G(^HLEV(776,+$G(HLEVIENJ),0)),U)']""  ;->
 ;
 ; Set up sending...
 S XMDUZ=.5
 ;
 ; Subject...
 S X=$$SITE^VASITE,SITE="HL7 Monitor - "_$P(X,U,2)_"["_$P(X,U,3)_"]"
 S XMSUB=$S($G(XMSUB)]"":XMSUB,1:SITE_" - "_$P($G(^HLEV(776.1,+HLEVIENE,0)),U))
 ;
 ; Load generic message text...
 I $G(XMTEXT)']"" D
 .  KILL ^TMP($J,"HLMAILMSG")
 .  D LOADALL^HLEVAPI1(+HLEVIENJ,"HLMAILMSG")
 ;
 ; Declare where message is stored...
 S XMTEXT=$S($G(XMTEXT)]"":XMTEXT,1:"^TMP("_$J_",""HLMAILMSG"",")
 ;
 D ^XMD
 ;
 I '$D(ZTQUEUED) W !!,"Mail message #",$G(XMZ),"..."
 ;
 I $G(XMZ)>0 D UPDFLDE(+HLEVIENJ,7,XMZ)
 ;
 Q
 ;
NEWEVENT(HLEVIENE,QTIME) ; Create a new EVENT and pass back IEN...
 N DIC,DD,DO,X,Y
 ;
 ; Check STATUS-EVENT...
 QUIT:$P($G(^HLEV(776.999,1,0)),U,6)'="A"  ;->
 ;
 S X=$$NOW^XLFDT,DIC="^HLEV(776,",DIC(0)="L"
 S DIC("DR")="3////"_HLEVIENE_";4///Q"
 I $G(HLEVIENM)>0 S DIC("DR")=DIC("DR")_";9////"_HLEVIENM
 I $G(QTIME)]"" S DIC("DR")=DIC("DR")_";10////"_QTIME
 D FILE^DICN
 ;
 Q $S(+Y>0:+Y,1:"")
 ;
UPDFLDE(HLEVIENJ,FLD,VAL) ; Update a specific piece in 776...
 N DA,DIE,DR
 ;
 QUIT:$G(^HLEV(776,+$G(HLEVIENJ),0))']""  ;->
 ;
 ; Field 50, RUN DIARY...
 I FLD=50 D  QUIT  ;->
 .  N DIFF,NO,NOW,TIME
 .  S NO=$O(^HLEV(776,+HLEVIENJ,50,":"),-1)+1
 .  S ^HLEV(776,+HLEVIENJ,50,0)="^776.001^"_NO_U_NO
 .  S ^HLEV(776,+HLEVIENJ,50,+NO,0)=$G(VAL)
 .  ; If FLD=50, update timestamp every 30 seconds...
 .  ; (This is because many 50 nodes might be updated, one after the
 .  ; other in a very disk-intensive way.)
 .  S TIME=$P($G(^HLEV(776,+HLEVIENJ,0)),U,6) ; FM format
 .  S NOW=$$NOW^XLFDT
 .  S DIFF=$$FMDIFF^XLFDT(NOW,TIME,2) S:DIFF<0 DIFF=-DIFF
 .  QUIT:DIFF<30  ;->
 .  S DA=+HLEVIENJ,DIE=776,DR="6////"_NOW
 ;
 ; Fields 401-408...
 I FLD?3N&(FLD>400)&(FLD<409) D  QUIT  ;->
 .  S ^HLEV(776,+HLEVIENJ,FLD)=VAL
 ;
 ; Zero node data...
 QUIT:$G(VAL)']""  ;->
 S DA=+HLEVIENJ,DIE=776,DR=FLD_"///"_VAL_";6////"_$$NOW^XLFDT
 D ^DIE
 ;
 I FLD=2 D EVCHKD^HLEVAPI2($G(HLEVIENM),$G(HLEVIENE),$G(HLEVIENJ))
 ;
 Q
 ;
EOR ;HLEVAPI - Event Monitor APIs ;5/16/03 14:42
