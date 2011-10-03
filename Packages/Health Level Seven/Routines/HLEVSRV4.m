HLEVSRV4 ;O-OIFO/LJA - Event Monitor SERVER ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
LICEXT ; Change license date...  (Resets CODEXP,EXPNOW)
 N CUT
 W !
 S CUT=$$ASKDATE^HLEVAPI2("Enter NEW CUTOFF DATE/TIME","EXT")
 I CUT'?7N1"."1.N W "  no action taken..." QUIT  ;->
 S $P(^XTMP(XTMP,"CODE"),U)=CUT
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(CUT,7)_U_$$NOW^XLFDT_U_"VistA HL7 Remote Request License"
 S ^XTMP(XTMP,"USER")=$$NOW^XLFDT_U_DUZ
 W !!,"The current license has been changed to "
 W $$FMTE^XLFDT(CUT),"..."
 S CODEXP=CUT,EXPNOW=$S(CUT>NOW:0,1:1)
 D SETLIC^HLEVSRV3(CODEXP_U_CODE)
 Q
 ;
LICUSER ; Enter new users now...
 ; IOINHI,IOINORM -- req
 N POSX,USER
 ;
 W !!,"Enter the email address of the recipient(s).  (Enter the address of an"
 W !,"existing user and they will be removed.)"
 W !!,IOINHI,"Hint:",IOINORM,"   "
 S POSX=8
 W "You may enter ""something"" that is less exact than the complete"
 W !,?POSX,"email address and not compromise security.  For example, if"
 W !,?POSX,"the remote requester is named 'John Doe' and will be sending"
 W !,?POSX,"requests from the Buffalo VAMC, you still might not know"
 W !,?POSX,"the exact email address to enter.  (E.g., Should you enter"
 W !,?POSX,"'JOHN.DOE@MED.VA.GOV' or 'DOE.JOHN@BUFFALO.VA.GOV'?)  And, this"
 W !,?POSX,"is why it is often advantageous to enter something like"
 W !,?POSX,"'DOE@BUFFALO' and also 'DOE@MED.VA.GOV'.  When a remote "
 W !,?POSX,"request is received, as long as 'DOE' is in the sender's"
 W !,?POSX,"name, and either 'BUFFALO' or 'MED.VA.GOV' is in the"
 W !,?POSX,"address, it will be honored."
 W !
 ;
 F  D  QUIT:USER']""
 .  S USER=$$FT^HLEVSRV2("Enter REMOTE ADDRESS","","O")
 .  I USER']""!(USER[U) S USER="" QUIT  ;->
 .  I USER'?1.E1"@"1.E D  QUIT  ;->
 .  .  W !!,?5,"No action taken! (Use 'NAME@ADDRESS' format.)"
 .  .  W !
 .  S USER=$$UP^XLFSTR(USER)
 .  I $D(^XTMP(XTMP,"USER",USER)) D  QUIT  ;->
 .  .  KILL ^XTMP(XTMP,"USER",USER)
 .  .  W "  removed..."
 .  S ^XTMP(XTMP,"USER",USER)=$$NOW^XLFDT_U_$G(DUZ)
 .  W "  added..."
 Q
 ;
LICNEW ; Create new license...  (Creates CODE,CODEXP,EXPNOW)
 ;
 I $G(^XTMP(XTMP,"CODE"))]"" D  I '$$YN^HLCSRPT4("Continue","No") W "  no action taken..." QUIT  ;->
 .  W !!,IOINHI,"Warning!!",IOINORM
 .  W "  The current license, along with all licensed requesters, will"
 .  W "                   be deleted if you continue."
 .  W !
 ;
 S (CODEXP,EXPNOW)="",CODE=$$CODE^HLEVSRV3
 W !!,"License '",IOINHI,CODE,IOINORM,"' will be used after you enter cutoff date..."
 W !!,"Defaulting 'NOW + 7 days' below..."
 W !
 S CODEXP=$$ASKDATE^HLEVAPI2("Enter CUTOFF DATE","EXT",$P($$FMTE^XLFDT(+$$FMADD^XLFDT($$NOW^XLFDT,7)),":",1,2))
 I CODEXP'?7N1"."1.N S (CODE,CODEXP,EXPNOW)="" QUIT  ;->
 ; Accept any date.  For user will have opportunity to change later.
 S EXPNOW=$S(CODEXP<NOW:1,1:0) ; Is license expired?
 D SETLIC^HLEVSRV3(CODEXP_U_CODE)
 ;
 Q
 ;
LICAN ; Cancel current license...
 ; XTMP -- req
 ;
 ; If no license exists...
 I '$D(^XTMP(XTMP)) D  QUIT  ;->
 .  W !,"No license exists..."
 ;
 W !!,"If you cancel license, the code and all requesters will be removed!"
 W !
 I '$$YN^HLCSRPT4("OK to cancel license","No") D  QUIT  ;->
 .  W "  no action taken..."
 ;
 KILL ^XTMP(XTMP)
 W "  license canceled..."
 S (CODE,CODEXP,EXPNOW)=""
 ;
 Q
 ;
CHKLIC(CODEXM,FROM) ; Called by server action to see if passed in license
 ; matches current license.  If so, data will be returned to
 ; requester.  If not, a refusal email will be returned to XMFROM.
 N OXMZ,OXTMP
 ;
 S OXMZ=$G(XMZ),OXTMP=$G(XTMP)
 ;
 N CODE,CUT,NOW,XTMP
 ;
 S XTMP="HLEV REMOTE LICENSE",NOW=$$NOW^XLFDT
 S CODE=$G(^XTMP(XTMP,"CODE")),CUT=+CODE,CODE=$P(CODE,U,2,999)
 ;
 ; If no requester known...
 I $G(XMFROM)']"" D  QUIT  ;->
 .  D REFUSE("requester unknown.")
 ;
 ; If no code exists...
 I CODE']"" D   QUIT  ;->
 .  D REFUSE("no license exists.")
 ;
 ; License has expired...
 I CUT<NOW D REFUSE("the current license has expired.") QUIT  ;->
 ;
 ; Incorrect code sent by remote requester...
 I CODEXM'=CODE D REFUSE("incorrect code received.") QUIT  ;->
 ;
 ; Is remote requester licensed?
 I '$$LICENSED($G(XMFROM)) D  QUIT  ;->
 .  D REFUSE("Requester is not licensed.")
 ;
 ; Set XMY so report returned to remote requester...
 I $G(XMFROM)]"" S XMY(XMFROM)=""
 ;
 D RECXTMP("Request# "_XMZ_" from "_$G(XMFROM)_" honored. ["_OXTMP_"]")
 ;
 Q
 ;
LICENSED(FROM) ; Is requester licensed?
 N OK,USER
 S FROM=$$UP^XLFSTR(FROM)
 S ADDR=$P(FROM,"@",2) QUIT:ADDR']"" "" ;->
 S FROM=$P(FROM,"@") QUIT:FROM']"" "" ;->
 S OK=0,USER=""
 F  S USER=$O(^XTMP(XTMP,"USER",USER)) Q:USER']""!(OK)  D
 .  S FROM(1)=$P(USER,"@"),ADDR(1)=$P(USER,"@",2)
 .  QUIT:FROM'[FROM(1)  ;-> License NAME not in XMFROM
 .  QUIT:ADDR'[ADDR(1)  ;-> License ADDR not in XMFROM
 .  S OK=1
 Q $S(OK:1,1:"")
 ;
REFUSE(REA) ; Send refusal email back to remote requester...
 ; XMFROM,XTMP -- req
 N HOLD,NO,TEXT,XMDUZ,XMSUB,XMTEXT
 ;
 D RECXTMP("Refused ("_REA_")  Request# "_$G(XMZ)_"  from "_$G(XMFROM))
 ;
 N XMZ
 S XMDUZ=.5,XMSUB="HL7 Remote Request Refusal: "_$G(XMFROM)
 S XMTEXT="HOLD("
 ;
 D MAILADD("The following remote request for VistA HL7 data has been refused.")
 D MAILADD("Details are included below."),MAILADD("")
 D MAILADD("              Requester: "_$G(XMFROM))
 D MAILADD("               Message#: "_$G(OXMZ))
 D MAILADD("                 Reason: "_REA)
 ;
 S XMY("HL7SystemMonitoring@med.va.gov")=""
 I $G(XMFROM)]"" S XMY(XMFROM)=""
 ;
 D ^XMD
 ;
 QUIT
 ;
MAILADD(T) S NO=$O(HOLD(":"),-1)+1,HOLD(NO)=T
 Q
 ;
RECXTMP(TXT) ; Record in ^XTMP for remote requests...
 ; XTMP -- req
 S NO=$O(^XTMP(XTMP,"REQ",":"),-1)+1
 S ^XTMP(XTMP,"REQ",+NO)=TXT
 Q
 ;
EOR ;HLEVSRV4 - Event Monitor SERVER ;5/16/03 14:42
