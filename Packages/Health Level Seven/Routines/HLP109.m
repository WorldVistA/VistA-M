HLP109 ;ALB/CJM - Post-Install for patch 109 ;06/03/99
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
SETAC ;Used to undo the changes to the "AC" xref, used only if the patch
 ;HL*1.6*109 needs to be backed out.
 S ^DD(773,7,1,1,1)="S %=$P(^HLMA(DA,0),U,3) S:%]"""" ^HLMA(""AC"",%,X,DA)="""" I %=""O"",'$D(HLTCPO) D LLCNT^HLCSTCP(X,3)"
 S ^DD(773,7,1,1,2)="S %=$P(^HLMA(DA,0),U,3) K:%]"""" ^HLMA(""AC"",%,X,DA)"
 ;S ^DD(773,100,1,1,1)="S ^HLMA(""AD"",X,DA)="""" N %,%1 S %=$G(^HLMA(DA,0)),%1=$P(%,U,3),%=$P(%,U,7) K:%1]""""&% ^HLMA(""AC"",%1,%,DA)"
 Q
 ;
PRE ; Called by KIDS pre-init...
 S ^HLCS(869.3,1,772)=($O(^HL(772,":"),-1)\1)
 S ^HLCS(869.3,1,773)=($O(^HLMA(":"),-1)\1)
 D UNQUEUE^HLEVUTIL
 D LOADMON
 D ETHL7 ; Make sure every official HL7 entry has PACKAGE NAME...
 Q
 ;
LOADMON ; Create a list of monitors in ^XTMP(XTMP,"O")...
 N NOW,XTMP
 S NOW=$$NOW^XLFDT
 S XTMP="HLEV INSTALL "_NOW
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(NOW,2)_U_NOW_U_"HLEV INSTALLATION MONITOR LIST"
 S IEN=0
 F  S IEN=$O(^HLEV(776.1,IEN)) Q:'IEN  D
 .  S ^XTMP(XTMP,"O",IEN)=$P($G(^HLEV(776.1,IEN,0)),U)_U_$$IENSUM(IEN)
 Q
 ;
 ;
 ;
 ;
POST ; Called by KIDS post-init...
 N NO,TEXT,XMDUZ,XMSUB,XMTEXT,XMZ
 N %KMPRJT,%XX,%ZH0,%ZHFN,C,D0,DA,DG,DICR,DIFRFRV1,DIFROM,DIU,I,IEN
 N J,X,XG255,XGATRSET,XGCURATR,XGEMPATR,XGPAD,XGRT,XGSCRN
 N XQCH,ZQJMP,XQSV,XWT,XQUSER,XQZ,Y
 N XPD,XPD0,XPDA,XPDBLD,XPDCHECK,XPDCP,XPDD,XPDGREF,XPDIDCNT
 N XPDIDMOD,XPDIDTOT,XPDIDVT,XPDIT,XPDNM,XPDPKG,XPDRTN,XPDSET
 N XPDSET1,XPDST,XPDT
 ;
 ; Load 776.999 file entry if needed...
 D LOADPAR
 ;
 ; Update list of monitors...
 D COMPMON
 ;
 ; Send email message to DUZ...
 KILL ^TMP($J,"HLMAIL")
 D ADD("The installation of the Event Monitoring software held in patch")
 D ADD("HL*1.6*109 is complete. ")
 S XTMP=$O(^XTMP("HLEV INSTALL 9999999.99999"),-1)
 I XTMP]"",$D(^XTMP(XTMP)) D MAILMON
 ;
 ; Send Mailman message.
 S XMDUZ=.5,XMSUB="HL*1.6*109 Installation - Site# "_$P($$SITE^VASITE,U,3)
 S XMTEXT="^TMP("_$J_",""HLMAIL"","
 S XMY("HL7SystemMonitoring@med.va.gov")=""
 ;
 D ^XMD
 ;
 I '$D(ZTQUEUED) W !!,"Setup instructions message #",$G(XMZ)," sent..."
 KILL ^TMP($J,"HLMAIL")
 ;
 D DELMON ; Delete monitor(2)...
 D DELMGRP ; Delete mail group(s) from monitor(s)...
 ;
 ; Start a new master job...
 D STARTJOB^HLEVMST
 ;
 Q
 ;
DELMON ; Delete renamed, or now unwanted official monitors...
 N DA,DIE,DR
 D DELONE("STUB 870 SEARCH")
 D DELONE("XREF CHECK - FILE 772 & 773")
 Q
 ;
DELONE(NAME) ; Delete a monitor...
 N DA
 QUIT:$G(NAME)']""  ;->
 F  S DA=+$O(^HLEV(776.1,"B",NAME,0)) Q:'DA  D
 .  N DIK,DR
 .  S DIK="^HLEV(776.1,"
 .  D ^DIK
 Q
 ;
LOADPAR ; Load 776.999 file...
 QUIT:$G(^HLEV(776.999,1,0))]""  ;->
 S $P(^HLEV(776.999,0),U,3)=1,$P(^HLEV(776.999,0),U,4)=1
 S ^HLEV(776.999,1,0)="SYSTEM^A^120^96^^A"
 S ^HLEV(776.999,"B","SYSTEM",1)=""
 Q
 ;
COMPMON ; Create list of monitors that have been changed...
 N DATA,IEN,NM,XTMP
 ;
 S XTMP=$O(^XTMP("HLEV INSTALL 9999999.999999999"),-1)
 QUIT:XTMP'["HLEV INSTALL"  ;->
 ;
 S IEN=0
 F  S IEN=$O(^HLEV(776.1,IEN)) Q:IEN'>0  D
 .  S $P(^XTMP(XTMP,"O",IEN),U,3)=$P($G(^HLEV(776.1,+IEN,0)),U)
 .  S $P(^XTMP(XTMP,"O",IEN),U,4)=$$IENSUM(IEN)
 .  S DATA=^XTMP(XTMP,"O",IEN)
 .  QUIT:$P(DATA,U)'=$P(DATA,U,3)  ;-> Names don't match
 .  QUIT:$P(DATA,U,2)'=$P(DATA,U,4)  ;-> Checksums don't match
 .  KILL ^XTMP(XTMP,"O",IEN)
 ;
 ; Rearrange into new and "used" (pre-existing) monitors...
 KILL ^XTMP(XTMP,"NEW"),^XTMP(XTMP,"OLD")
 S IEN=0
 F  S IEN=$O(^XTMP(XTMP,"O",IEN)) Q:'IEN  D
 .  S DATA=^XTMP(XTMP,"O",IEN) QUIT:DATA']""  ;->
 .  S NM=$P(DATA,U,3)
 .  S:$P(DATA,U)']"" ^XTMP(XTMP,"NEW",NM,IEN)=DATA
 .  S:$P(DATA,U)]"" ^XTMP(XTMP,"OLD",NM,IEN)=DATA
 ;
 KILL ^XTMP(XTMP,"O")
 ;
 Q
 ;
ETHL7 ; Check/reset PACKAGE NAME in HL7 Monitor Event Type file (#776.3)...
 N DA,DIE,DR,IEN,IENS,PCE
 ;
 S IENS="1^2^3^4^5^6^7^8^9^10^11^12^13^14^15^16^17^18^100^101^102^103^104^105^106^107^108^109^200^201^202^203^204^205^206^207^208^209^210^211^213^214^215^216"
 ;
 F PCE=1:1:$L(IENS,U) D
 .  S IEN=$P(IENS,U,+PCE) QUIT:$G(^HLEV(776.3,IEN,0))']""  ;->
 .  S DA=IEN,DIE=776.3,DR=".08///HEALTH LEVEL SEVEN"
 .  D ^DIE
 ;
 Q
 ;
MAILMON ; Add to new or changed monitors to mail text...
 N HDR,NM,TXT,TYP
 ;
 D ADD(" - New and changed monitors.")
 ;
 S TYPE=""
 F  S TYPE=$O(^XTMP(XTMP,TYPE)) Q:TYPE']""  D
 .  D ADD("")
 .  S HDR=$S(TYPE="OLD":"Monitors changed during installation",TYPE="NEW":"New monitors",1:"") QUIT:HDR']""  ;->
 .  D ADD(HDR),ADD($$REPEAT^XLFSTR("-",$L(HDR)))
 .  S NM="",TXT=""
 .  F  S NM=$O(^XTMP(XTMP,TYPE,NM)) Q:NM']""  D
 .  .  S TXT(1)=$E(NM_$$REPEAT^XLFSTR(" ",40),1,35)
 .  .  S TXT=TXT_TXT(1)
 .  .  I $L(TXT)>35 D ADD(TXT) S TXT=""
 .  I $L(TXT)>0 D ADD(TXT)
 ;
 Q
 ;
ADD(TXT) ; Add text to ^TMP($J,"HLMAIL")
 N NO
 S NO=$O(^TMP($J,"HLMAIL",":"),-1)+1
 S ^TMP($J,"HLMAIL",+NO)=TXT
 Q
 ;
IENSUM(IEN) ; Checksum of entry...
 N ASC,CHAR,LP,POS,ST,SUM,TXT,VAL
 S SUM=0
 S LP="^HLEV(776.1,"_IEN,ST=LP_",",LP=LP_")"
 F  S LP=$Q(@LP) Q:LP'[ST  D
 .  S TXT=LP_"="_@LP
 .  F POS=1:1:$L(TXT) D
 .  .  S CHAR=$E(TXT,POS),ASC=$A(CHAR)
 .  .  S SUM=SUM+(ASC*POS)
 Q SUM
 ;
DELMGRP ; Delete mailgroup in monitor...
 N IEN,MIEN
 ;
 ; CHECK 773 AC XREF --- @ --- HL7DevelopmentTeam@med.va.gov
 S IEN=$O(^HLEV(776.1,"B","CHECK 773 AC XREF",0))
 S MIEN=$O(^HLEV(776.1,+IEN,62,"B","HL7DevelopmentTeam@med.va.gov",0))
 D DELGRP1(IEN,MIEN)
 ;
 ; LINK (870) CHECKS
 S IEN=$O(^HLEV(776.1,"B","LINK (870) CHECKS",0))
 S MIEN=$O(^HLEV(776.1,+IEN,62,"B","HL7DevelopmentTeam@med.va.gov",0))
 D DELGRP1(IEN,MIEN)
 ;
 Q
 ;
 ;
DELGRP1(IEN,MIEN) ; Delete one remote mail group...
 N DIE,DIE,DR
 QUIT:'$D(^HLEV(776.1,+IEN,62,+MIEN,0))  ;->
 S DIE="^HLEV(776.1,"_IEN_",62,",DA(1)=IEN,DA=MIEN
 S DR=".01///@"
 D ^DIE
 Q
 ;
EOR ;HLEVINIT - Event Monitor PRE&POST-INITS ;5/16/03 14:42
