HLEVX000 ;O-OIFO/LJA - VistA HL7 Event Monitor Code ;02/04/2004 15:25
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
 ; Event Types - 870-DINUM, 870-SKIP, 870-STUB
 ;
CHK870 ; Search for various file 870 problems...
 ;
 ; {01/16/04 - See call to REPDINUM below.}
 ;
 N CT870,CTERR,CTNO,CTSTUB,DATA,DATABEF,IEN870,LINKNM,MIEN870
 N NOW,STATUS,TXT,VAR,WAY,XTMPBEF,XTMPNOW
 ;
 ; Call event monitor...
 KILL VAR
 ; Variables can be defined prior to passing into START by reference...
 F VAR="CT870","CTDINUM","CTERR" S VAR(VAR)="" ; #1-Indiv array elements
 S VAR="CTNO^CTSKIP^CTSTUB" ;                    #2-Parsed from string
 D START^HLEVAPI(.VAR)
 ; Even D START^HLEVAPI(VAR) would work...
 ;
 KILL ^TMP($J,"HLREP"),^TMP($J,"HLEV REP"),^TMP($J,"HLMAIL")
 ;
 ; Set current XTMP subscript and create zero node...
 S NOW=$$NOW^XLFDT,XTMPNOW="HLEV STUB "_NOW
 S ^XTMP(XTMPNOW,0)=$$FMADD^XLFDT(NOW,2)_U_NOW_U_"HLEV Stub Record Search"
 ;
 ; Has there been a prior run?  If so, set XTMPBEF.  If not, set to null
 S XTMPBEF=$O(^XTMP(XTMPNOW),-1),XTMPBEF=$S(XTMPBEF["HLEV STUB ":XTMPBEF,1:"")
 ;
 ; Find current stub entries...
 S (CT870,CTDINUM,CTERR,CTNO,CTSKIP,CTSTUB)=0,IEN870=0,CTNO=0
 F  S IEN870=$O(^HLCS(870,IEN870)) Q:IEN870'>0  D
 .  D CHECKIN^HLEVAPI
 .  S CT870=CT870+1
 .  S LINKNM=$P($G(^HLCS(870,+IEN870,0)),U)
 .  S LINKNM=$S(LINKNM]"":LINKNM_"["_IEN870_"]",1:"IEN ["_IEN870_"]")
 .  ; 1=IN QUEUE     2=OUT QUEUE
 .  F WAY=1,2 D
 .  .  S WAY(1)=$S(WAY=1:"I",1:"O")
 .  .  D CHECKIN^HLEVAPI
 .  .  S MIEN870=$O(^HLCS(870,+IEN870,WAY,0)) ; First entry...
 .  .  S MIEN870(1)=$O(^HLCS(870,+IEN870,WAY,":"),-1) ; Last entry...
 .  .  Q:MIEN870'>0!(MIEN870(1)'>0)  ;->
 .  .  F MIEN870=MIEN870:1:MIEN870(1) D
 .  .  .  S CTNO=CTNO+1
 .  .  .  I '(CTNO#500) D CHECKIN^HLEVAPI
 .  .  .  D CHECKS(IEN870,WAY,MIEN870)
 ;
 D CHECKIN^HLEVAPI ; To store final values of variables
 D CHECKOUT^HLEVAPI ; To finalize fields...
 ;
 S ^XTMP(XTMPNOW,0,0)=CT870_U_CTNO_"~"_CTERR_"~"_CTDINUM_U_CTSKIP_U_CTSTUB
 ;
 ; Create report and put in text...
 QUIT:'$D(^TMP($J,"HLEV REP"))  ;->
 ;
 ; Create report text...
 D GENREP^HLEVUTI0($NA(^TMP($J,"HLEV REP")),$NA(^TMP($J,"HLEVREP")),4,1)
 ;
 ; Load report text in 776 message text...
 D MSGTEXT^HLEVAPI1($NA(^TMP($J,"HLEVREP")))
 ;
 ; Mail report...
 S HLEVTXT(1)="MESSAGETEXT"
 D MAILIT^HLEVAPI
 ;
 ; Report DINUM problems, using report text...
 D REPDINUM^HLEVX003 ; {01/16/04}
 ;
 ; Clean out ^TMP data...
 KILL ^TMP($J,"HLREP"),^TMP($J,"HLEV REP"),^TMP($J,"HLMAIL")
 ;
 Q
 ;
SITE S SITE=$$SITE^VASITE,SITE=$P(SITE,U,2)_" ["_$P(SITE,U,3)_"]"
 D ADD("Run site:  "_SITE)
 D ADD("")
 ;
EXPL D ADD("Some stub entries exist in the HL Logical Link file (#870) that")
 D ADD("appear to be ""stuck"".  Someone at the site needs to check out")
 D ADD("and possibly change their status to DONE.")
 ;
HDR D ADD("")
 D ADD("Link          In/Out     IENs")
 D ADD($$REPEAT^XLFSTR("-",74))
 ;
 ; Send report...
REP S LINKNM=""
 F  S LINKNM=$O(^TMP($J,"HLEV REP",LINKNM)) Q:LINKNM']""  D
 .  S TXT=$E(LINKNM_"               ",1,15)
 .  S WAY="",CTNO=0
 .  F  S WAY=$O(^TMP($J,"HLEV REP",LINKNM,WAY)) Q:WAY']""  D
 .  .  S TXT=$E(TXT_" "_$S(WAY="I":"IN",1:"OUT")_$$REPEAT^XLFSTR(" ",80),1,25)
 .  .  S MIEN870=0
 .  .  F  S MIEN870=$O(^TMP($J,"HLEV REP",LINKNM,WAY,MIEN870)) Q:MIEN870'>0  D
 .  .  .  S CTNO=CTNO+1
 .  .  .  I ($L(TXT)+$L(MIEN870)+2)>74 D  QUIT  ;->
 .  .  .  .  D ADD(TXT)
 .  .  .  .  S TXT=$$REPEAT^XLFSTR(" ",25)
 .  .  .  S TXT=TXT_$S($L(TXT)>25:",",1:"")_MIEN870
 .  .  I $TR(TXT," ","")]"" D ADD(TXT)
 .  .  S TXT=$$REPEAT^XLFSTR(" ",15)
 .  I TXT]"" D ADD(TXT) S TXT=""
 I TXT]"" D ADD(TXT) S TXT=""
 ;
 D MSGTEXT^HLEVAPI1($NA(^TMP($J,"HLMAIL")))
 ;
 KILL ^TMP($J,"HLEV REP"),^TMP($J,"HLMAIL")
 ;
 S HLEVTXT(1)="MESSAGE TEXT"
 D MAILIT^HLEVAPI
 ;
 Q
 ;
ADD(TXT) ; Add to global for moving into report
 N NO
 S NO=$O(^TMP($J,"HLMAIL",":"),-1)+1
 S ^TMP($J,"HLMAIL",+NO)=TXT
 Q
 ;
MSG(TXT) ; Generic text displayer...
 W !!,TXT
 W ! ; Always put at least one blank row in place
 F  Q:($Y+3)>IOSL  W !
 S X=$$BTE^HLCSMON("Press RETURN to exit... ")
 Q
 ;
CHECKS(IEN870,WAY,MIEN870) ; Perform various checks on queue entry...
 ; CTDINUM,CTSKIP,CTSTUB -- req
 QUIT:'$$DATA870(IEN870,WAY,MIEN870)  ;->
 D CHKSTUB(IEN870,WAY,MIEN870)
 D CHKDINUM(IEN870,WAY,MIEN870)
 Q
 ;
DATA870(IEN870,WAY,MIEN870) ; Does record exist?
 ; CTSKIP,LINKNM -- req
 ;
 ; Check for existence of data here...
 QUIT:$G(^HLCS(870,+IEN870,WAY,+MIEN870,0))]"" 1 ;->
 ;
 S WAY(1)=$S(WAY=1:"INCOMING",1:"OUTGOING")
 ;
 ; Has this problem already been logged?
 QUIT:'$$LOG^HLEVAPI2("870-SKIP","IEN870^WAY^MIEN870") "" ;->
 ;
 D RECORD("SKIP",LINKNM,WAY(1),MIEN870)
 S CTSKIP=CTSKIP+1,CTERR=CTERR+1
 ;
 Q ""
 ;
CHKSTUB(IEN870,WAY,MIEN870) ; Check if a stub record that "hangs around"
 ; CTSTUB,LINKNM -- req
 N DATABEF,STATUS
 S STATUS=$P($G(^HLCS(870,+IEN870,+WAY,+MIEN870,0)),U,2)
 QUIT:STATUS'="S"  ;-> Stub record
 S WAY(1)=$S(WAY=1:"INCOMING",1:"OUTGOING")
 S DATABEF=$S(XTMPBEF']"":"",1:$S($D(^XTMP(XTMPBEF,+IEN870,WAY(1),+MIEN870)):1,1:""))
 S ^XTMP(XTMPNOW,+IEN870,WAY(1),+MIEN870)=DATABEF
 QUIT:'DATABEF  ;-> Stub entry didn't exist before...
 ;
 ; Has this problem already been logged?
 QUIT:'$$LOG^HLEVAPI2("870-STUB","IEN870^WAY^MIEN870")  ;->
 ;
 D RECORD("STUB",LINKNM,WAY(1),MIEN870)
 S CTSTUB=CTSTUB+1,CTERR=CTERR+1
 ;
 Q
 ;
CHKDINUM(IEN870,WAY,MIEN870) ; Check for records not DINUMd for log link
 ; CTDINUM,LINKNM -- req
 ;
 ; {01/16/04 - Call to $$LOG^HLEVAPI2 removed.  See REPDINUM call.}
 ;
 N IEN
 ;
 ; DINUM check here...
 S IEN=+$G(^HLCS(870,+IEN870,WAY,+MIEN870,0)) QUIT:IEN=MIEN870  ;->
 ;
 S WAY(1)=$S(WAY=1:"INCOMING",1:"OUTGOING")
 ;
 ; New occurence, so record error...
 D RECORD("DINUM",LINKNM,WAY(1),MIEN870)
 S CTDINUM=CTDINUM+1,CTERR=CTERR+1
 ;
 Q
 ;
RECORD(PROBL,LINKNM,WAY,MIEN870) ; Record for later inclusion in report
 ;
 ; Required:  At least two levels passed...
 S PROBL=$G(PROBL) QUIT:PROBL']""  ;->
 S LINKNM=$G(LINKNM) QUIT:LINKNM']""  ;->
 S LEVEL=2
 S WAY=$G(WAY) I WAY]"" S LEVEL=3
 S MIEN870=$G(MIEN870) I MIEN870]"" S LEVEL=4
 ;
 ; Data level set...
 I LEVEL=4 S ^TMP($J,"HLEV REP",PROBL,LINKNM,WAY,MIEN870)=""
 I LEVEL=3 S ^TMP($J,"HLEV REP",PROBL,LINKNM,WAY)=""
 I LEVEL=2 S ^TMP($J,"HLEV REP",PROBL,LINKNM)=""
 ;
 ; Total level sets...
 I LEVEL=4 S ^TMP($J,"HLEV REP",PROBL,LINKNM,WAY)=$G(^TMP($J,"HLEV REP",PROBL,LINKNM,WAY))+1
 I LEVEL=3 S ^TMP($J,"HLEV REP",PROBL,LINKNM)=$G(^TMP($J,"HLEV REP",PROBL,LINKNM))+1
 S ^TMP($J,"HLEV REP",PROBL)=$G(^TMP($J,"HLEV REP",PROBL))+1
 S ^TMP($J,"HLEV REP")=$G(^TMP($J,"HLEV REP"))+1
 ;
 Q
 ;
 ; ====================================================================
 ;
CORRECT ; Correct a stub entry in HLCS(870)...
 N IEN870,MIEN870,WAY
 D HD,EX
 S WAY=$$WAY I WAY']"" D  QUIT  ;->
 .  D MSG("Exiting... ")
 W !
 S IEN870=$$LINK I IEN870']"" D  QUIT  ;->
 .  D MSG("No link selected.  Start again... ")
CONT W !
 S MIEN870=$$MIEN870(IEN870,WAY) I MIEN870'>0 D  QUIT  ;->
 .  D MSG("No stub entry exists for link.")
 W !!,"Stub record# ",MIEN870," found.  It's status is about to be changed to DONE..."
 W !
 QUIT:'$$YN^HLCSRPT4("OK to correct","Yes")  ;->
 D FIX(IEN870,WAY,MIEN870,"D")
 W "  fixed... "
 W !
 QUIT:$$BTE^HLCSMON("Press RETURN to continue searching... ")  ;->
 G CONT ;->
 ;
FIX(IEN870,WAY,MIEN870,STAT) ; Fix stub record...
 N DA,DIE,DR,SUBDD
 S DIE="^HLCS(870,"_IEN870_","_WAY_","
 S DA(1)=IEN870,DA=+MIEN870
 S DR=$S($G(STAT)]"":"1///"_STAT,1:1)
 D ^DIE
 Q
 ;
WAY() ; In or Out?
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SO^1:Search the IN QUEUE;2:Search the OUT QUEUE"
 S DIR("A")="Select the QUEUE to search"
 D ^DIR
 QUIT:$D(DIRUT)!($D(DTOUT))!($D(DUOUT)) "" ;->
 Q $S(+Y:+Y,1:"")
 ;
LINK() ; Which 870 entry?
 N DIC,X,Y
 S DIC=870,DIC(0)="AEMQ",DIC("A")="Select LOGICAL LINK: "
 D ^DIC
 Q $S(+Y:+Y,1:"")
 ;
MIEN870(IEN870,WAY) ; Search for stub record...
 N CT,IEN,IOINHI,IOINORM,MIEN870,STATUS,X
 ;
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 ;
 W !,IOINHI,"Searching for stub records...",IOINORM
 S CT=0,IEN=0,MIEN870=0
 F  S IEN=$O(^HLCS(870,+IEN870,WAY,IEN)) Q:IEN'>0!(MIEN870)  D
 .  S CT=CT+1 W:'(CT#500) "."
 .  S DATA=$G(^HLCS(870,+IEN870,WAY,IEN,0)) QUIT:$P(DATA,U,2)'="S"  ;->
 .  H 15 ; If not hung, and is a proper stub entry, it will disappear
 .  S DATA=$G(^HLCS(870,+IEN870,WAY,IEN,0)) QUIT:$P(DATA,U,2)'="S"  ;->
 .  S MIEN870=IEN
 ;
 Q MIEN870
 ;
HD W @IOF,$$CJ^XLFSTR("Stub Record Correction",IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EX N I,T F I=1:1 S T=$T(EX+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;Occasionally, entry's in the IN QUEUE and the OUT QUEUE of the HL Logical
 ;;Link file (#870) get stuck in the STUB status.  (Stub records have the STATUS
 ;;field set to STUB.)  When this occurs, no further processing of the queue
 ;;occurs.
 ;;
 ;;This utility loops through the IN QUEUE or the OUT QUEUE of a logical link
 ;;looking for stub records.  (Stub records have the STATUS field set to STUB.)
 ;;When it finds a stub record it requests permission to set the STATUS field to
 ;;DONE.
 QUIT
 ;
EOR ;HLEVX000 - VistA HL7 Event Monitor Code ;5/30/03 15:25
