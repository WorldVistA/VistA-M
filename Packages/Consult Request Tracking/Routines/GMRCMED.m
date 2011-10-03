GMRCMED ;SLC/JFR - MEDICINE INTERFACE ROUTINES; 2/20/01 13:32
 ;;3.0;CONSULT/REQUEST TRACKING;**15,47**;DEC 27, 1997
 ;
 ; This routine invokes IA #147,#2757,#3160,#3171
 ;
SET(NUM) ; set selected med result into GMRCMEDR
 I NUM<1!(NUM>VALMCNT) D  Q
 . W !,$C(7),NUM_" is not a valid selection. "
 . W !,"Choose a number between 1 and "_VALMCNT
 I '$D(^TMP("GMRCR",$J,"DT",NUM,1)) D  Q
 . D EXAC^GMRCADC("The displayed item is not selectable")
 I $D(GMRCMEDR) D RESETIT(GMRCMEDR)
 S GMRCMEDR=NUM
 D CNTRL^VALM10(NUM,1,80,IORVON,IORVOFF)
 D WRITE^VALM10(NUM)
 S VALMBCK=""
 Q
RESETIT(NUM) ;return prev. selected number to normal video 
 D CNTRL^VALM10(NUM,1,80,IOINORM,IOINORM)
 D WRITE^VALM10(NUM)
 S VALMBCK="" K GMRCSEL
 Q
RESULTS(ROOT,GMRCDFN) ;get list of results from Medicine
 ; ROOT = "MCAR(691","MCAR(691.5" etc. (global root w/o comma)
 ; return list formatted in ^TMP("GMRCMC",$J
 N S5,CNT,REC
 K ^TMP("GMRCMC",$J)
 S S5=ROOT D EN^MCARPS2(GMRCDFN)
 I '$D(^TMP("OR",$J,"MCAR")) D  Q
 . ;D EXAC^GMRCADC("No results found for"_$P(ROOT,U,2))
 S CNT=1,REC=0
 F  S REC=$O(^TMP("OR",$J,"MCAR","OT",REC)) Q:'REC  D
 . N MCDATA,DATA,ONEDATA
 . S MCDATA=^TMP("OR",$J,"MCAR","OT",REC),DATA=""
 . Q:$D(^GMR(123,"R",$P(MCDATA,U,2)_";"_ROOT_","))
 . Q:$$SCRNDRFT($P(MCDATA,U,2),$P(ROOT,"(",2))
 . S DATA=$$SETSTR^VALM1(CNT,DATA,2,$L(REC))
 . S DATA=$$SETSTR^VALM1($P(MCDATA,U),DATA,6,23)
 . S DATA=$$SETSTR^VALM1($P(MCDATA,U,6),DATA,30,$L($P(MCDATA,U,6)))
 . S DATA=$$SETSTR^VALM1($P(MCDATA,U,7),DATA,50,$L($P(MCDATA,U,7)))
 . S ^TMP("GMRCR",$J,"DT",CNT,0)=DATA
 . ;S ONEDATA=REC_U_$P(MCDATA,U,2)_";"_ROOT_","_U_$P(MCDATA,U,3,5)
 . ;S ONEDATA=ONEDATA_U_$P(MCDATA,U,11)
 . S ONEDATA=$P(MCDATA,U,2)_";"_ROOT_","
 . S ^TMP("GMRCR",$J,"DT",CNT,1)=ONEDATA
 . S CNT=CNT+1
 K ^TMP("OR",$J,"MCAR")
 Q 
PHDR ;set protocols into actions
 S VALMSG=$$CJ^XLFSTR("Select action or item number    ?? for help",80)
 S XQORM("M")=3
 D SHOW^VALM
 S XQORM("#")=$O(^ORD(101,"B","GMRCACT SELECT MED RESULT",0))_"^1:"_VALMCNT
 S XQORM("KEY","EX")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","Q")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","CLOSE")=$O(^ORD(101,"B","GMRCACT QUIT",0))_"^1"
 S XQORM("KEY","NX")=$O(^ORD(101,"B","GMRCACT NEXT SCREEN",0))_"^1"
 S XQORM("KEY","AR")=$O(^ORD(101,"B","GMRCACT ASSOCIATE RESULTS",0))_"^1"
 S XQORM("KEY","DR")=$O(^ORD(101,"B","GMRCACT DISPLAY MED RESULT",0))_"^1"
 Q
 ;
SELECT(CNT) ;grab an item from list
 N DIR,DUOUT,DTOUT,DIRUT,X,Y
 S DIR(0)="NO^1:"_CNT,DIR("A")="Select item"
 D ^DIR I $D(DIRUT) Q 0
 Q +Y
 ;
DISPRES(ITEM) ;
 I '+$G(^TMP("GMRCR",$J,"DT",1,1)) D  Q  ; no result there
 . D EXAC^GMRCADC("There are no results to display")
 N GMRCDFN
 I '$G(ITEM),'$G(GMRCMEDR) D  Q:'ITEM
 . S ITEM=$$SELECT(VALMCNT)
 . D SET(ITEM)
 I $G(GMRCMEDR) S ITEM=GMRCMEDR
 N I,GMRCRES,GMRCDFN,GMRCVTIT
 S GMRCRES=$G(^TMP("GMRCR",$J,"DT",ITEM,1))
 Q:'$L(GMRCRES)
 M ^TMP("GMRCR",$J,"DTSV")=^TMP("GMRCR",$J,"DT")
 K ^TMP("GMRCR",$J,"DT")
 S GMRCDFN=$G(DFN)
 D START^ORWRP(80,"EN^MCAPI(GMRCRES)")
 I '$D(^TMP("ORDATA",$J,1)) D  Q
 . S ^TMP("GMRCR",$J,"DTLIST",1,0)="Unable to locate result"
 S I=0 F  S I=$O(^TMP("ORDATA",$J,1,I)) Q:'I  D
 . S ^TMP("GMRCR",$J,"DTLIST",I,0)=^TMP("ORDATA",$J,1,I)
 K ^TMP("ORDATA",$J) ; clean up from OR WORKSTATION
 S DFN=$S(+GMRCDFN:GMRCDFN,$G(ORVP):+ORVP,1:0)
 S GMRCVTIT="Medicine Result Display"
 S VALMCNT=$O(^TMP("GMRCR",$J,"DTLIST",999999),-1)
 D EN^VALM("GMRC DETAILED DISPLAY")
 M ^TMP("GMRCR",$J,"DT")=^TMP("GMRCR",$J,"DTSV")
 K ^TMP("GMRCR",$J,"DTSV")
 S VALMBCK="R",VALMCNT=$O(^TMP("GMRCR",$J,"DT",999999),-1)
 Q
 ;
AR(ITEM) ;associate specific result and complete consult
 I '+$G(^TMP("GMRCR",$J,"DT",1,1)) D  Q  ; no result there
 . D EXAC^GMRCADC("There are no results to associate")
 N DIR,X,Y,RESTXT,RESULT
 I '$G(ITEM),'$G(GMRCMEDR) D  Q:'ITEM
 . S ITEM=$$SELECT(VALMCNT)
 . D SET(ITEM)
 I $G(GMRCMEDR) S ITEM=GMRCMEDR
 D FULL^VALM1
 S RESTXT=$E(^TMP("GMRCR",$J,"DT",ITEM,0),6,80)
 S RESULT=^TMP("GMRCR",$J,"DT",ITEM,1) Q:'+RESULT
 I $D(^GMR(123,"R",RESULT)) D  Q
 . D EXAC^GMRCADC("This result is already associated with a procedure.")
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)="",DIR("A",2)="   "_RESTXT,DIR("A",3)=""
 S DIR("A")="Are you sure you want to associate this result? "
 D ^DIR I Y<1 Q
 D MEDCOMP(GMRCO,RESULT,$$NOW^XLFDT,DUZ)
 Q
MEDCOMP(GMRCDA,GMRCRSLT,GMRCAD,GMRCORNP,GMRCALRT) ;add medicine result
 ; update status and send alerts
 ;  Input:
 ;   GMRCDA - ien from file 123
 ;   GMRCRSLT - medicine result in var ptr form (e.g. "19;MCAR(691.5,")
 ;   GMRCAD   - FM date/time of action (optional)
 ;   GMRCORNP - DUZ of person taking action
 ;   GMRCALRT - array of users to receive alert  (optional)
 ;
 I '$D(GMRCDA)!'$D(GMRCRSLT) Q
 N GMRCO,GMRCSTS,GMRCA,GMRCDR,GMRCTYP,MSG
 S GMRCO=GMRCDA,GMRCA=10,GMRCSTS=2
 S GMRCDR="8////^S X=GMRCSTS;9////^S X=GMRCA;11////^S X=GMRCRSLT"
 D STATUS^GMRCP
 I $D(GMRCAD) D AUDIT^GMRCP
 I '$D(GMRCAD) D AUDIT0^GMRCP
 D ADDRSLT^GMRCTIUA(GMRCDA,GMRCRSLT)
 S MSG="NEW RESULT ASSOCIATED",GMRCDFN=$P(^GMR(123,GMRCO,0),U,2)
 D MSG^GMRCP(GMRCDFN,MSG,GMRCDA,23,.GMRCALRT,0)
 S GMRCTYP=$P(^GMR(123,+GMRCDA,0),U,17)
 D EN^GMRCHL7(GMRCDFN,GMRCDA,GMRCTYP,"","RE",$G(GMRCORNP),"")
 Q
REFRESH(GMRCIEN) ;update list of available results
 N MCROOT,MCPROC,GMRCPROC
 I $G(GMRCMEDR) D RESETIT(GMRCMEDR)
 K ^TMP("GMRCR",$J,"DT"),GMRCMEDR
 S GMRCPROC=$P(^GMR(123,GMRCIEN,0),"^",8)
 S MCROOT=$$GET1^DIQ(697.2,+$P(^GMR(123.3,+GMRCPROC,0),U,5),1)
 D RESULTS^GMRCMED(MCROOT,$P(^GMR(123,+GMRCIEN,0),U,2))
 I '$O(^TMP("GMRCR",$J,"DT",0)) D
 . S ^TMP("GMRCR",$J,"DT",1,0)="No further results to associate"
 S VALMCNT=$O(^TMP("GMRCR",$J,"DT",""),-1)
 S VALMBCK="R"
 Q
 ;
SCRNDRFT(GMRCMCDA,GMRCMCFL) ;screen out draft or marked for del med results
 ; Input:
 ;   GMRCDA   - ien from a MEDICINE file
 ;   GMRCMCFL - file # from MEDICINE  (e.g. 691, 691.5, 699 etc.)
 ; Output: Boolean 1=screen it out 0=include it
 ;
 N GMRCMCST,GMRCMFD
 I '$D(GMRCMCDA)!('$D(GMRCMCFL)) Q 0
 S GMRCMCST=$$GET1^DIQ(GMRCMCFL,GMRCMCDA,1506,"I") ;get release code
 S GMRCMCST=$S(GMRCMCST="D":0,GMRCMCST="PD":0,1:1) ;no D or PD
 S GMRCMFD=$$GET1^DIQ(GMRCMCFL,GMRCMCDA,1511,"I") ;marked for del?
 I GMRCMFD=1 Q 1 ;marked for del
 I GMRCMCST=0 Q 1 ;screen out draft or prob draft
 Q 0
