HLEVSRV3 ;O-OIFO/LJA - Event Monitor SERVER ;02/04/2004 14:42
 ;;1.6;HEALTH LEVEL SEVEN;**109**;Oct 13, 1995
 ;
OPENMAIL ; Grant license to remote requesters...
 N ANS,CODE,CODEXP,EXPNOW,IOINHI,IOINORM,NOW,X,XTMP
 ;
 S XTMP="HLEV REMOTE LICENSE"
 S X="IOINHI;IOINORM" D ENDR^%ZISS
 S NOW=$$NOW^XLFDT
 ;
 D HDM
 D EXM
 F  Q:($Y+3)>IOSL  W !
 QUIT:$$BTE^HLCSMON("Press RETURN to continue, or '^' to exit... ")
 ;
 D HDM
 ;
 S (CODE,CODEXP,EXPNOW)="" ; Default to no current license...
 ;
 ; Current license?  Show details of current (maybe expired) license.
 S CODE=$G(^XTMP(XTMP,"CODE")) I CODE]"" D
 .  S CODEXP=$P(CODE,U),CODE=$P(CODE,U,2)
 .  S EXPNOW=$S(CODEXP<NOW:1,1:0) ; Is license expired?
 .  D SHOWLIC
 ;
 I CODE']"" W !!,"No current license exists..."
 ;
 ; OK.  License and expiration date exist...
 S EXPNOW=$S(CODEXP<NOW:1,1:0) ; Is license expired?
 ;
 F  D  QUIT:ACTION="EXIT"
 .  N STR
 .  S STR=$S($D(^XTMP(XTMP)):1,1:0)
 .  I STR S STR(1)="LICEXT^Change cutoff date/time~LICUSER^Add requesters~LICNEW^Create new license"_$S(CODE]"":" (and cancel old license)",1:"")_"~LICAN^Cancel current license~EXIT^Exit"
 .  I 'STR S STR(1)="LICNEW^Create new license~EXIT^Exit"
 .  S ACTION=$$ASKDIR(STR(1),$$DEFAULT)
 .  S:ACTION']"" ACTION="EXIT"
 .  QUIT:ACTION="EXIT"  ;->
 .  S ACTION=ACTION_"^HLEVSRV4"
 .  D @ACTION
 .  D SHOWLIC
 ;
 I '$D(^XTMP(XTMP)) QUIT  ;->
 ;
 I $O(^XTMP(XTMP,"USER",""))']"" D
 .  W !!,"No requesters have been created under this license.  So, even thought a"
 .  W !,"license exists, no one can make use of the license.  To enter requesters, you"
 .  W !,"must reinvoke this option and enter one or more requesters."
 ;
 I EXPNOW W !!,"The current license is expired!"
 ;
 I $O(^XTMP(XTMP,"USER",""))']""!(EXPNOW) D
 .  W !
 .  S X=$$BTE^HLCSMON("Press RETURN to exit...")
 ;
 Q
 ;
DEFAULT() ; What would most users do under circumstances?
 ; CODE,CODEXP,EXPNOW,XTMP -- req
 I CODE']""!('$D(^XTMP(XTMP))) QUIT "Create new license" ;->
 I EXPNOW QUIT "Change cutoff date/time" ;->
 I $O(^XTMP(XTMP,"USER",""))']"" QUIT "Add requesters" ;->
 Q "Exit"
 ;
SHOWLIC ; Show license and expiration date...
 ; CODE,CODEXP,EXPNOW,IOINHI,IOINORM,XTMP -- req
 N HOLD,NO,USER
 ;
 I '$D(^XTMP(XTMP)) D  QUIT  ;->
 .  W !!,$$CJ^XLFSTR("---------------- No License Exists ----------------",IOM)
 ;
 W !!,$$CJ^XLFSTR("---------------- Current License - "_CODE_" ["_$S(EXPNOW:IOINHI,1:"")_$$SDT^HLEVX001(CODEXP)_IOINORM_"] ----------------",IOM)
 ;
 S NO=0,USER=""
 F  S USER=$O(^XTMP(XTMP,"USER",USER)) Q:USER']""  D
 .  S NO=NO+1,HOLD(USER)=""
 ;
 I NO'>0 W !,$$CJ^XLFSTR("No current users exist!",IOM) QUIT  ;->
 ;
 W !,$$CJ^XLFSTR("----- Licensed Requesters ------",IOM)
 S USER=""
 F  S USER=$O(HOLD(USER)) Q:USER']""  D
 .  W !,$$CJ^XLFSTR(USER,IOM)
 ;
 Q
 ;
SETLIC(CODE) ; Set license...
 ; XTMP -- req
 N CUT
 S CUT=+CODE
 ;
 KILL ^XTMP(XTMP) ; Remove all old data...
 ;
 ; Set vaporization date to 7 days after cutoff time...
 S ^XTMP(XTMP,0)=$$FMADD^XLFDT(CUT,7)_U_$$NOW^XLFDT_U_"VistA HL7 Remote Request License"
 ;
 S ^XTMP(XTMP,"CODE")=CODE ; Cutoff date/time ^ Code
 S ^XTMP(XTMP,"USER")=$$NOW^XLFDT_U_DUZ
 ;
 Q
 ;
HDM ; Header for option...
 ; IOINHI,IOINORM,XTMP -- req
 N CODE,NOW
 W @IOF,$$CJ^XLFSTR("Grant License to Remote Requesters",IOM)
 S CODE=$G(^XTMP(XTMP,"CODE")) I CODE]"" D
 .  S CUT=+CODE,CODE=$P(CODE,U,2,999)
 .  I CUT<$$NOW^XLFDT D  QUIT  ;->
 .  .  W !,$$CJ^XLFSTR("License: "_CODE_"   Cutoff: "_IOINHI_$$FMTE^XLFDT(CUT)_IOINORM,IOM+$L(IOINHI)+$L(IOINORM))
 .  W !,$$CJ^XLFSTR("License: "_CODE_"   Cutoff: "_$$FMTE^XLFDT(CUT),IOM)
 W !,$$REPEAT^XLFSTR("=",IOM)
 QUIT
 ;
EXM N I,T F I=1:1 S T=$T(EXM+I) QUIT:T'[";;"  W !,$P(T,";;",2,99)
 ;;Mailman server requests can be sent to your site requesting HL7 data be 
 ;;returned to the VistA HL7 team.  These requests are normally only sent to
 ;;the VistA HL7 team.  However, from time to time, support personnel will have
 ;;legitimate need to retrieve critical VistA HL7 data.  In order to receive
 ;;return data, anyone not on the VistA HL7 team needs a license.  This option
 ;;will generate a license that must be communicated to those (not on the VistA
 ;;HL7 team) requesting remote query rights.
 ;;
 ;;Note:  Notification of every remote server request is automatically sent to
 ;;       the VistA HL7 team.  And, this includes the messages sent remotely
 ;;       to non-VistA HL7 recipients (using the license you are about to grant.)
 QUIT
 ;
GRANT() ; Get date and license...
 N CODE,CONT,CUT,FUTURE,LICENSE
 ;
 S CODE=$G(^XTMP(XTMP,"CODE")) I CODE]"" D  QUIT:'CONT "" ;->
 .  S CONT=1
 .  W !!,"License# ",IOINHI,$P(CODE,U,2),IOINORM," exists and has a cutoff time of ",$$FMTE^XLFDT($P(CODE,U)),"."
 .  W !
 .  I $$YN^HLCSRPT4("Terminate license now","No") D  QUIT:'CONT  ;->
 .  .  KILL ^XTMP(XTMP)
 .  .  W "  done..."
 .  .  S CONT=""
 .  W !
 .  QUIT:'$$YN^HLCSRPT4("Keep license and extend time","Yes")  ;->
 .  W !!,"Defaulting 'NOW + 7 days' below..."
 .  W !
 .  S CUT=$$ASKDATE^HLEVAPI2("Enter CUTOFF DATE","EXT",$P($$FMTE^XLFDT(+$$FMADD^XLFDT($$NOW^XLFDT,7)),":",1,2)) QUIT:'CUT  ;->
 .  S $P(^XTMP(XTMP,"CODE"),U)=CUT
 .  S ^XTMP(XTMP,0)=CUT_U_$$NOW^XLFDT_U_"VistA HL7 Remote Request License"
 .  S ^XTMP(XTMP,"USER")=$$NOW^XLFDT_U_DUZ
 .  W "  updated..."
 .  S CONT=0
 ;
 S FUTURE=$$FMADD^XLFDT($$NOW^XLFDT,0,1)
 W !!,"Enter a future  cutoff date/time now after which no remote requests by"
 W !,"non-VistA HL7 team message recipients will be honored."
 W !!,"Defaulting 'NOW + 7 days' below..."
 W !
G1 S CUT=$$ASKDATE^HLEVAPI2("Enter CUTOFF DATE","EXT",$P($$FMTE^XLFDT(+$$FMADD^XLFDT($$NOW^XLFDT,7)),":",1,2)) QUIT:'CUT "NO" ;->
 I CUT<FUTURE D  G G1 ;->
 .  W "  enter time one hour or more in future..."
 S LICENSE=$$CODE
 W !!,"License# ",IOINHI,LICENSE,IOINORM," generated..."
 Q "SET^"_CUT_U_LICENSE
 ;
CODE() ; Return license code...
 N CODE,EX,NOP,TYPE
 F EX=39,44,95,96 S EX(EX)=""
 S CODE="",NOP=0
 F EX=1:1:6 D
 .  S TYPE=$P("A^P",U,$R(2)+1)
 .  I EX=6,NOP=0 S TYPE="P" ; Must be at least one punctuation
 .  I TYPE="P" S NOP=NOP+1
 .  S:NOP>1 TYPE="A"
 .  S CODE=CODE_$$RNO(TYPE)
 .  I EX=3 S CODE=CODE_"-"
 Q CODE
 ;
RNO(TYPE) ; Return random number between 33 and 122 (w/exceptions)
 ; NOP -- req
 N NO,OK
 F  S NO=$R(89)+33 D  Q:OK
 .  S OK=0
 .  I $D(EX(NO)) QUIT  ;-> Is it in exclusion list?
 .  I TYPE="A" D  QUIT  ;-> Is it an alpha character
 .  .  I $$ALPHA(NO) S OK=1
 .  I '$$ALPHA(NO) S OK=1 ; Need punctuation...
 Q $C(NO)
 ;
ALPHA(NO) ; Is it ALPHA character?
 N X
 S X=$A($$UP^XLFSTR($C(NO))) QUIT:X>64&(X<91) 1 ;->
 Q ""
 ;
ASKDIR(CHOICES,DEFAULT) ; Ask user what to do...
 ; CODE,CODEXP,EXPNOW -- req
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,HOLD,PCE,TXT,X,Y
 S DIR(0)="S^",DIR("A")="Select ACTION"
 F PCE=1:1:$L(CHOICES,"~") D
 .  S TXT=$P(CHOICES,"~",+PCE) QUIT:TXT']""  ;->
 .  S TAG=$P(TXT,U),PMT=$P(TXT,U,2)
 .  S DIR(0)=DIR(0)_$S(DIR(0)'="S^":";",1:"")_PCE_":"_PMT
 .  S HOLD(PCE)=TAG
 QUIT:DIR(0)="S^" "" ;->
 I $G(DEFAULT)]"" S DIR("B")=DEFAULT
 D ^DIR
 S X=$G(HOLD(+Y)) QUIT:X]"" X ;->
 Q ""
 ;
EOR ;HLEVSRV3 - Event Monitor SERVER ;5/16/03 14:42
