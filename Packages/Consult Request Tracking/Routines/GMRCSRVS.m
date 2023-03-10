GMRCSRVS ;SLC/DCM,JFR - Add/Edit services in File 123.5. ;6/14/00 12:00
 ;;3.0;CONSULT/REQUEST TRACKING;**1,16,40,53,63,186,191**;DEC 27, 1997;Build 17
 ;
 ;Jan 5, 2022, Phil Burkhalter - patch GMRC*3.0*186, added code to edit the Community Care Clinic filed if the consult service is for a community care consult
 ;
EN ;set up services entry point
 ;GMRCOLDU=Service Usage field. If changed, GMRCOLDU shows the change (See ^DD(123.5,2,0) for field description).
 N GMRCSAFE,GMRCOLDU,GMRCOLDS,GMRCOSNM,GMRCSRVC,GMRCACT,GMRCSSNM
 N DIC,DLAYGO,DUOUT,DTOUT
 S DIC="^GMR(123.5,",DLAYGO=123.5,DIC(0)="AELMQZ",DIC("A")="Select Service/Specialty:"
 D ^DIC I $S(Y<0:1,$D(DTOUT):1,$D(DUOUT):1,1:0) D END K GMRCMSG,DTOUT,DUOUT Q
 D
 .S GMRCSAFE=+$G(^GMR(123.5,+Y,"INT"))
 .S (DA,GMRCSRVC)=+Y,GMRCOSNM=$P(Y,"^",2),(GMRCOLDU,GMRCOLDS)=""
 .S GMRCACT=$S('$O(^GMR(123.5,+Y,0)):"MAD",1:"MUP"),GMRCOLDU=$P(^(0),"^",2),GMRCOLDN=$P(^(0),"^",1) S ND=0,GMRCOLDS="" F  S ND=$O(^GMR(123.5,+Y,2,ND)) Q:ND?1A.E!(ND="")  S GMRCOLDS=GMRCOLDS_^GMR(123.5,+Y,2,ND,0)_"^"
 .S DIE=DIC,DR="[GMRC SETUP REQUEST SERVICE]",DIE("NO^")="OUTOK"
 .D ^DIE
 .Q
 I $D(DA) S GMRCACT=$S($P(^GMR(123.5,GMRCSRVC,0),"^",2)=9:"MDC",$P(^(0),"^",2)=1:"MDC",1:GMRCACT) D
 .S GMRCSSNM=$P(^GMR(123.5,GMRCSRVC,0),"^",1)
 .I GMRCACT'="MAD",GMRCSSNM'=GMRCOSNM S GMRCACT="MUP"
 .I $S(GMRCACT'="MAD":1,GMRCACT'="MUP":1,1:0),$L(GMRCOLDU),GMRCOLDU=$P(^GMR(123.5,GMRCSRVC,0),"^",2) S GMRCACT="NOACT"
 .I $S(GMRCACT="MUP":1,GMRCACT="NOACT":1,1:0),GMRCOLDN'=$P(^GMR(123.5,GMRCSRVC,0),"^",1) S GMRCACT="MUP"
 .S ND=0 F  S ND=$O(^GMR(123.5,GMRCSRVC,2,ND)) Q:ND?1A.E!(ND="")  I GMRCOLDS'=""&(^GMR(123.5,GMRCSRVC,2,ND,0)'=""),GMRCOLDS'[^GMR(123.5,GMRCSRVC,2,ND,0) S GMRCACT="MUP" Q
 .I $S(GMRCACT="MAD":1,GMRCACT="MUP":1,GMRCACT="MDC":1,1:0) D SVC^GMRC101H(GMRCSRVC,GMRCSSNM,GMRCACT),MSG^XQOR("GMRC ORDERABLE ITEM UPDATE",.GMRCMSG)
 .D PTRCLN^GMRCU
 .Q
 ;Phil Burkhalter - Jan 10, 2022 patch GMRC*3.0*186 - Change to edit the Related Hospital Location to add a community care clinic
 I $P(^GMR(123.5,GMRCSRVC,0),"^")["COMMUNITY CARE" D
 .N XY,CLIN,CLINNAME,LAST S (LAST,XY)=0 F  S XY=$O(^GMR(123.5,GMRCSRVC,123.4,XY)) Q:XY'>0  S LAST=XY
 .I $G(LAST)'>0 D
 ..N DIC,Y,X,DLAYGO,DUOUT,DTOUT,CCCLINIC S DIC="^SC(",DIC(0)="QEAB",DIC("S")="I $P(^SC(Y,0),U)[""COM CARE"""
 ..D ^DIC I $S(Y<0:1,$D(DTOUT):1,$D(DUOUT):1,1:0) K DTOUT,DUOUT,X,Y Q  ;G ASK
 ..S CCCLINIC=+Y
 ..;add a new entry so it will be the last entry.
 ..;routine SDECCRSEN loops thru this multiple and get the last clinic in the list.
 ..;the SDCCRSEN routine, when pulling the clinic, checks the clinic name to make sure it is a com care clinic
 ..;if it is not a com care clinic don't use it for scheduling, default to the existing match rules in SDCCRSEN
 ..N SUBREC,REC S (REC,SUBREC)=0 F  S SUBREC=$O(^GMR(123.5,GMRCSRVC,123.4,SUBREC)) Q:$G(SUBREC)'>0  S REC=SUBREC
 ..N FDA,FDAIEN S FDAIEN="+1,"_GMRCSRVC_",",FDA(1,123.56,FDAIEN,.01)=CCCLINIC D UPDATE^DIE("","FDA(1)")
 .I $G(LAST)>0 D
 ..S CLIN=$P(^GMR(123.5,GMRCSRVC,123.4,LAST,0),"^"),CLINNAME=$P(^SC(CLIN,0),"^")
 ..N DIE,DR,DA,X,Y S DA=LAST,DA(1)=GMRCSRVC,DIE="^GMR(123.5,"_DA(1)_",123.4,",DR=".01//"_CLINNAME D ^DIE
 ;end patch GMRC*3.0*186 changes
ASK ; 
 K GMRCMSG,GMRCSSNM,GMRCSRVS,GMRCOLDN,GMRCOLDS,GMRCOLDU,ND
 ;Ask to continue...
 ;
 N GMRC0,GMRCA,GMRCB,GMRCH,GMRCL
 S GMRC0="YA",GMRCA="Add/Edit Another Service? ",GMRCB="NO"
 S GMRCH="Enter 'YES' to add/edit another service, or 'NO' to exit."
 S GMRCL=2
 I '+$$READ(GMRC0,GMRCA,GMRCB,GMRCH,GMRCL) D END Q
 G EN
 ;
END K DIC,DIE,DTOUT,DUOUT,DA,DR,FL,GMRCACT,GMRCANS,GMRCMSG,GMRCREA,GMRCSRVC,GMRCSSNM,REVCODE,RLEVCODE,Y
 Q
 ;
READ(GMRC0,GMRCA,GMRCB,GMRCH,GMRCL,GMRCS) ;
 ;
 ;  GMRC0 -> DIR(0) --- Type of read
 ;  GMRCA -> DIR("A") - Prompt
 ;  GMRCB -> DIR("B") - Default Answer
 ;  GMRCH -> DIR("?") - Help text or ^Execute code
 ;  GMRCS -> DIR("S") - Screen
 ;  GMRCL -> Number of blank lines to put before Prompt
 ;
 ;  Returns "^" or answer
 ;
 N GMRCLINE,DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 Q:'$L($G(GMRC0)) U
 S DIR(0)=GMRC0
 S:$L($G(GMRCA)) DIR("A")=GMRCA
 I $D(GMRCA("A")) M DIR("A")=GMRCA("A")
 S:$L($G(GMRCB)) DIR("B")=GMRCB
 I $D(GMRCH("?")) M DIR("?")=GMRCH("?")
 S:$L($G(GMRCH)) DIR("?")=GMRCH
 S:$L($G(GMRCS)) DIR("S")=GMRCS
 F GMRCLINE=1:1:($G(GMRCL)-1) W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) Q U
 Q Y
 ;
NOED(SERV) ;
 I '$D(^GMR(123.5,+SERV,0)) Q 0
 N NAME
 S NAME=$P(^GMR(123.5,+SERV,0),U)
 I NAME="PROSTHETICS REQUEST" Q 1
 I NAME="EYEGLASS REQUEST" Q 1
 I NAME="CONTACT LENS REQUEST" Q 1
 I NAME="HOME OXYGEN REQUEST" Q 1
 Q 0
 ;
CLONPSAS ; clone a PROSTHETICS service
 ; choose service and text to append
 N GMRCSIEN,GMRCROOT,GMRCNWNM
 N GMRCCPY,GMRCNEW,FDA,GMRCERR,GMRC
 S GMRC(0)="PAO^GMR(123.5,:AEMQ"
 S GMRC("A")="Select the Prosthetics Service to clone: "
 S GMRC("S")="I $$NOED^GMRCSRVS(+Y)"
 S GMRCCPY=+$$READ(GMRC(0),GMRC("A"),,,2,GMRC("S"))
 I 'GMRCCPY Q
 K GMRC
 S GMRCNWNM=$$GETAPP(GMRCCPY)
 I '$L(GMRCNWNM) Q
 S FDA(1,123.5,"+1,",.01)=GMRCNWNM
 S FDA(1,123.5,"+1,",2)="DISABLED"
 S FDA(1,123.5,"+1,",1.01)="REQUIRE"
 S FDA(1,123.5,"+1,",1.02)="LEXICON"
 S FDA(1,123.5,"+1,",123.01)="CONSULTS"
 S FDA(1,123.5,"+1,",123.03)="GMRCACTM SERVICE ACTION MENU"
 S FDA(1,123.5,"+1,",131)="YES"
 D UPDATE^DIE("E","FDA(1)","GMRCNEW","GMRCERR")
 I '$D(GMRCNEW) W !,"Failed to create new entry. Please try again" Q
 W !!,GMRCNWNM," created",!
 S GMRCSIEN=GMRCNEW(1)_","
 S GMRCROOT="^GMR(123.5,"_GMRCCPY_",124)"
 D WP^DIE(123.5,GMRCSIEN,124,,GMRCROOT,"GMRCERR")
 W !!,"The new Service is currently DISABLED. To activate this service for use in"
 W !,"the Prosthetics interface, you MUST use the Setup Consult Services option"
 W !,"and delete the DISABLED flag from the SERVICE USAGE field.",!
 Q
GETAPP(GMRIEN) ;get text to append
 N GMRCNWNM,QTFLG,I,GMRC,GMRCHL,OK
 S GMRCNWNM=""
 F I=0:0 D  Q:$G(QTFLG)
 . W !!
 . S GMRC(0)="FA^3:40"
 . S GMRC("A")="Enter text to append to national service name: "
 . S GMRCHL("?",1)="The text entered will be appended to the name of the exported service"
 . S GMRCHL("?")="(e.g. If HINES was entered it may appear as PROSTHETICS REQUEST - HINES"
 . S GMRCNWNM=$$READ(GMRC(0),GMRC("A"),,.GMRCHL,2)
 . I '$L(GMRCNWNM)!(GMRCNWNM["^") S GMRCNWNM="",QTFLG=1 Q
 . K GMRC,GMRCHL
 . S GMRCNWNM=$P(^GMR(123.5,GMRIEN,0),U)_" - "_GMRCNWNM
 . I $$FIND1^DIC(123.5,,"X",GMRCNWNM) D  Q
 .. W !!,$C(7),"This service already exists, you'll have to try again!",!
 .. S GMRCNWNM=""
 . W !,"The new service name will be:"
 . W !,?5,GMRCNWNM,!
 . S OK=+$$READ("Y","Is this OK",,,1)
 . I OK=U S QTFLG=1 Q
 . I 'OK S GMRCNWNM="" Q
 . S QTFLG=1
 Q GMRCNWNM
INPUT(X,GMRCDA) ; INPUT TRANSFORM FOR THE SUB-SERVICE/SPECIALTY (#.01) FIELD
 ; OF THE SUB-SERVICE (#123.51) FILE WHICH IS A SUB-FILE OF THE
 ; SUB-SERVICE (#10) FIELD OF THE REQUEST SERVICES (#123.5) FILE.
 ;
 ; X = INTERNAL VALUE OF USER SELECTED SUB-SERVICE (IEN OF SERVICE
 ;     IN FILE 123.5)
 ; GMRCDA = IEN OF INITIAL PARENT SERVICE IN FILE 123.5
 ;
 I +$G(X)=0 K X Q
 I GMRCDA<1 D  Q:'$D(X)
 . S GMRCDA=+$G(D0)
 . I GMRCDA<1 K X
 N GMRPARNT,GMRCHILD,GMRQ,GMRCNT
 K ^TMP("GMRC INPUT",$J) ;MAKE SURE INPUT PARENT LOG GLOBAL IS BLANK
 I X=GMRCDA S GMRQ=1 G INPUTQ ;NOT ALLOW SERVICE AS A SUB-SERVICE TO ITSELF
 S ^TMP("GMRC INPUT",$J,"B",GMRCDA)="" ;USED TO PREVENT DUPLICATE CHECKING OF PARENTS
 S ^TMP("GMRC INPUT",$J,0)=1 ;USED TO FIND NEXT NUMBER FOR TMP GLOBAL ENTRY
 S ^TMP("GMRC INPUT",$J,1)=GMRCDA ;PARENT IEN STORED TO BE USED AS CHILD
 S (GMRCNT,GMRQ)=0
 F  S GMRCNT=$O(^TMP("GMRC INPUT",$J,GMRCNT)) Q:'GMRCNT  D  Q:GMRQ=1
 . S GMRCHILD=$G(^TMP("GMRC INPUT",$J,GMRCNT))
 . S GMRPARNT=0
 . F  S GMRPARNT=$O(^GMR(123.5,"APC",GMRCHILD,GMRPARNT)) Q:GMRPARNT=""  D  Q:GMRQ=1
 .. I GMRPARNT=X S GMRQ=1 Q  ;NOT ALLOW SERVICE AS A SUB-SERVICE WITHIN IT'S SUB-SERVICE HIERARCHY
 .. I '$D(^TMP("GMRC INPUT",$J,"B",GMRPARNT)) D  ;IF NOT IN LIST ADD
 ... S ^TMP("GMRC INPUT",$J,"B",GMRPARNT)="" ;ADD TO "B" CROSS-REFERENCE
 ... S ^TMP("GMRC INPUT",$J,0)=$G(^TMP("GMRC INPUT",$J,0))+1 ;INCREASE LAST NUMBER BY 1
 ... S ^TMP("GMRC INPUT",$J,$G(^TMP("GMRC INPUT",$J,0)))=GMRPARNT ;ADD NEW PARENT SERVICE TO GLOBAL SO IT CAN BE CHECKED AS A CHILD ENTRY TO FIND IT'S PARENTS
 K ^TMP("GMRC INPUT",$J)
INPUTQ I GMRQ=1 D EN^DDIOL("A SERVICE CAN NOT BE A SUB-SERVICE OF ITSELF","","!!?12") K X Q
 ;
DUPCHK ;CHECK FOR CONSULT SERVICES APPEARING AS PART OF THE CONSULT SERVICE
 ;HIERARCHY IN MORE THAN ONE PLACE
 N ARRAY,COUNT,GMRCON,PARENT
 S PARENT=0
 ;Check if they are a sub-service to more than one service.
 F COUNT=0:1 S PARENT=$O(^GMR(123.5,"APC",X,PARENT)) Q:'+PARENT
 ;Print message about which services this service is a sub-service of.
 I COUNT'>0 Q
 S COUNT=1
 S ARRAY(COUNT)=" ",COUNT=COUNT+1
 S ARRAY(COUNT)=" ",COUNT=COUNT+1
 S ARRAY="Service "_$P(^GMR(123.5,X,0),"^",1)_" is already a sub-service of:"
 D PARSE(.ARRAY)
 S PARENT=0
 F  S PARENT=$O(^GMR(123.5,"APC",X,PARENT)) Q:'+PARENT  S ARRAY="   "_$P(^GMR(123.5,PARENT,0),"^",1) D PARSE(.ARRAY)
 S ARRAY(COUNT)=" ",COUNT=COUNT+1
 S ARRAY(COUNT)="A consult service appearing as part of the Consult service",COUNT=COUNT+1
 S ARRAY(COUNT)="hierarchy in more than one place (i.e. a sub-service of more",COUNT=COUNT+1
 S ARRAY(COUNT)="than one parent) has the potential to skew the results of the",COUNT=COUNT+1
 S ARRAY(COUNT)="Consult Performance Monitor Report [GMRC RPT PERF MONITOR].",COUNT=COUNT+1
 S ARRAY(COUNT)=" ",COUNT=COUNT+1
 D EN^DDIOL(.ARRAY)
 I '$G(DIQUIET) D
 . S GMRCON=0
 . D YESNO(X,Y)
 . I 'GMRCON K X
 . D EN^DDIOL(" ")
 Q
PARSE(ARRAY) ;TAKE ARRAY VALUE AND PARSE INTO PIECES SHORTER THAN 70 CHARACTERS
 N ARRAYSP,GMRCNT
PARSE1 I $L(ARRAY)'>70 S ARRAY(COUNT)=ARRAY,COUNT=COUNT+1 Q
 F GMRCNT=70:-1 S ARRAYSP=$E(ARRAY,GMRCNT) I ARRAYSP=" " Q
 S ARRAY(COUNT)=$E(ARRAY,1,GMRCNT-1),COUNT=COUNT+1
 S ARRAY=$E(ARRAY,GMRCNT+1,9999)
 G:ARRAY'="" PARSE1
 Q
YESNO(X,Y) ;YES/NO QUESTION/RESPONSE
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Do you wish to continue adding "_$P(^GMR(123.5,X,0),"^",1)_" as a new sub-service? "
 S DIR("B")="NO"
 S DIR("T")=300
 S DIR("?",1)="Enter ""YES"" to add service as a sub-service."
 S DIR("?")="Enter ""NO"" to NOT add the service as a sub-service."
 D ^DIR Q:($G(DTOUT))!($G(DUOUT))!($G(DIROUT))
 I Y=1 S GMRCON=1
 Q
