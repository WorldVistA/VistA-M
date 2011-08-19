GMRCDIS ;SLC/JFR - LM ROUTINE TO DISASSOCIATE MED RESULTS; 11/5/01 11:20
 ;;3.0;CONSULT/REQUEST TRACKING;**15,22**;DEC 27, 1997
 ;
 ; This routine invokes IA #2324,#3042,#3120
 ;
EN ;invoke list template
 D EN^VALM("GMRC DISASSOC RESULTS")
 Q
HDR ;format list template header
 N GMRCVTIT
 S GMRCVTIT="Procedure/Medicine Resulting"
 D HDR^GMRCSLDT
 S VALMHDR(2)="Consult No.: "_GMRCO
 S VALMHDR(2)=$$SETSTR^VALM1("Associated Medicine Results",VALMHDR(2),30,28)
 Q
PHDR    ;set protocols into actions
 S VALMSG=$$CJ^XLFSTR("Select action or item number    ?? for help",80)
 S XQORM("M")=3
 D SHOW^VALM
 S XQORM("#")=$O(^ORD(101,"B","GMRCACT SELECT MED RESULT",0))_"^1:"_VALMCNT
 S XQORM("KEY","EX")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","Q")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","CLOSE")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","NX")=$O(^ORD(101,"B","GMRCACT NEXT SCREEN",0))_"^1"
 S XQORM("KEY","DM")=$O(^ORD(101,"B","GMRCACT DISASSOC MED RSLT",0))_"^1"
 S XQORM("KEY","DR")=$O(^ORD(101,"B","GMRCACT DISPLAY MED RESULT",0))_"^1"
 Q
INIT ; set up array into ^TMP("GMRCR",$J,"DT"...
 ; should already have it
 S VALMCNT=$O(^TMP("GMRCR",$J,"DT",999999),-1),VALMBG=1
 Q
GETRES(GMRCO) ; get associated MEDICINE results and format
 N RES,GMRCMCR,CNT,DATA
 S RES=0,CNT=1
 F  S RES=$O(^GMR(123,GMRCO,50,RES)) Q:'RES  D
 . I $G(^GMR(123,GMRCO,50,RES,0))'["MCAR" Q
 . S GMRCMCR=$$SINGLE^MCAPI(^GMR(123,GMRCO,50,RES,0))
 . S DATA=""
 . S DATA=$$SETSTR^VALM1(CNT,DATA,2,$L(CNT))
 . S DATA=$$SETSTR^VALM1($P(GMRCMCR,U),DATA,6,23)
 . S DATA=$$SETSTR^VALM1($P(GMRCMCR,U,6),DATA,30,$L($P(GMRCMCR,U,6)))
 . S DATA=$$SETSTR^VALM1($P(GMRCMCR,U,7),DATA,50,$L($P(GMRCMCR,U,7)))
 . S ^TMP("GMRCR",$J,"DT",CNT,0)=DATA
 . S ^TMP("GMRCR",$J,"DT",CNT,1)=^GMR(123,GMRCO,50,RES,0)
 . S CNT=CNT+1
 Q
DIS(GMRCO) ;select consult and start disassoc process
 N GMRCQUT,GMRCQIT,GMRCSS,GMRCMSG
 I '+$G(GMRCO) D SELECT^GMRCA2(.GMRCO) I $D(GMRCQUT) Q
 I '+$G(GMRCO) Q
 I '$$LOCK^GMRCA1(GMRCO) Q
 S GMRCMSG=$$REMUSR(GMRCO,DUZ) I '+GMRCMSG D  Q
 . N MSG
 . I '$L($P(GMRCMSG,U,2)) D
 .. S MSG="You are not authorized to disassociate results."
 . D EXAC^GMRCADC($S($D(MSG):MSG,1:$P(GMRCMSG,U,2)))
 D GETRES(GMRCO)
 D EN
 D UNLOCK^GMRCA1(GMRCO)
 Q
EXIT ;
 K ^TMP("GMRCR",$J,"DT")
 Q
EN1(GMRCRSLT) ; select result and verify remove action
 I '+$G(^TMP("GMRCR",$J,"DT",1,1)) D  Q  ;no result there
 . D EXAC^GMRCADC("There are no results to remove")
 N RESTXT,RESULT,DIR,X,Y,DUOUT,DTOUT,DIROUT
 I '$G(ITEM),'$G(GMRCMEDR) D  Q:'ITEM
 . S ITEM=$$SELECT^GMRCMED(VALMCNT)
 . D SET^GMRCMED(ITEM)
 I $G(GMRCMEDR) S ITEM=GMRCMEDR
 D FULL^VALM1
 S RESTXT=$E(^TMP("GMRCR",$J,"DT",ITEM,0),6,80)
 S RESULT=^TMP("GMRCR",$J,"DT",ITEM,1) Q:'+RESULT
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)="",DIR("A",2)="   "_RESTXT,DIR("A",3)=""
 S DIR("A")="Are you sure you want to disassociate this result? "
 D ^DIR I Y<1 Q
 D REMOVE(GMRCO,RESULT)
 Q
REMOVE(GMRCO,RSLT,GMRCAD,GMRCORNP) ;disassociate result
 ; remove rslt, log actv, update sts, send alerts
 ; Input:
 ;  GMRCO    - ien from file 123
 ;  RSLT     - medicine result in var ptr form (e.g. "19;MCAR(691.5,")
 ;  GMRCAD   - FM date/time of action (optional)
 ;  GMRCORNP - DUZ of person performing action  (optional) 
 ;
 N GMRCRES,DIK,DA,GMRCQUT,GMRCQIT
 S GMRCRES=$O(^GMR(123,+GMRCO,50,"B",RSLT,0)) I 'GMRCRES D  Q
 . D EXAC^GMRCADC("This result is no longer associated with the request")
 ; delete result entry
 S DA(1)=+GMRCO,DA=GMRCRES,DIK="^GMR(123,"_DA(1)_",50," D ^DIK
 I $P(^GMR(123,+GMRCO,0),U,15)=RSLT D
 . N DA,DIE,DR
 . S DIE="^GMR(123,",DA=+GMRCO,DR="11///@" D ^DIE
 ; update activity tracking
 N GMRCA,GMRCRSLT
 S GMRCA=12,GMRCRSLT=RSLT
 D AUDIT^GMRCP
 ; Update status back to active if not completed before
 N GMRCDFN,GMRCTYP
 S GMRCDFN=$P(^GMR(123,+GMRCO,0),U,2)
 I $$STSCHG(GMRCO) D
 . N GMRCSTS
 . S GMRCSTS=6 D STATUS^GMRCP
 . ; update CPRS
 . S GMRCTYP=$P(^GMR(123,+GMRCO,0),U,17)
 . D EN^GMRCHL7(GMRCDFN,+GMRCO,GMRCTYP,"","SC",$G(GMRCORNP),"")
 ; send notification?
 I '$G(GMRCORNP) S GMRCORNP=DUZ
 I GMRCORNP'=$P(^GMR(123,+GMRCO,0),U,14) D
 . Q:'$P(^GMR(123,+GMRCO,0),U,14)
 . N GMRCADUZ,GMRCORTX
 . S GMRCADUZ($P(^GMR(123,+GMRCO,0),U,14))=""
 . S GMRCORTX="Result removed from "_$$ORTX^GMRCAU(+GMRCO)
 . D MSG^GMRCP(GMRCDFN,GMRCORTX,GMRCO,27,.GMRCADUZ,0)
 Q
 ;
STSCHG(GMRCIEN) ;completed before or go back
 I $O(^GMR(123,GMRCIEN,50,0)) Q 0 ;still at least one result
 I $O(^GMR(123,GMRCIEN,51,0)) Q 0 ;still at least one remote result
 N CHG,ACT,I S ACT=0,CHG=1,I=0
 F  S I=$O(^GMR(123,GMRCIEN,40,I)) Q:'I  D
 . S ACT(0)=^GMR(123,GMRCIEN,40,I,0),ACT(2)=$G(^(2))
 . I $P(ACT(0),U,2)=10,('$L($P(ACT(0),U,9))&('$L($P(ACT(2),U,4)))) D
 .. S CHG=0 ; admin completed before if no results
 . Q
 Q CHG
 ;
REFRESH(GMRCIEN) ;re-build list of associated results
 I $G(GMRCMEDR) D RESETIT^GMRCMED(GMRCMEDR)
 K ^TMP("GMRCR",$J,"DT"),GMRCMEDR
 D GETRES(GMRCIEN)
 I '$O(^TMP("GMRCR",$J,"DT",0)) D
 . S ^TMP("GMRCR",$J,"DT",1,0)="No further results to disassociate"
 S VALMCNT=$O(^TMP("GMRCR",$J,"DT",""),-1)
 S VALMBCK="R"
 Q
REMUSR(GMRCIEN,USER) ; check to see if user is authorized to remove results
 N GMRCSS,GMRCCLS,RES
 I '+$P($G(^GMR(123,GMRCIEN,0)),U,8) Q 0
 S GMRCSS=$P(^GMR(123,GMRCIEN,0),U,5) I 'GMRCSS Q 0  ;no service
 S GMRCCLS=$P($G(^GMR(123.5,GMRCSS,1)),U,6) I 'GMRCCLS Q 0  ;no class
 I '$O(^GMR(123,GMRCIEN,50,0)) Q "0^There are no results associated with this request." ;no results to remove
 S RES=""
 F  S RES=$O(^GMR(123,GMRCIEN,50,"B",RES)) Q:RES=""  Q:RES["MCAR"
 I RES="" Q "0^There are no Medicine results associated with this request." ;no med results
 I '$G(USER) S USER=DUZ
 I $$ISA^USRLM(USER,GMRCCLS) Q 1  ;part of USR CLASS in fld 1.06
 Q 0
