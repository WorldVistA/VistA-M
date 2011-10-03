GMRCAD31 ;SLC/JFR - admin corrections on cons. activities; 2/19/03 14:09
 ;;3.0;CONSULT/REQUEST TRACKING;**32**;DEC 27, 1997
EN ;Start prompting and prepare to build a list
 N GMRCIEN
 S GMRCIEN=$$GETCSLT
 I 'GMRCIEN W !,"No Consult selected." Q
 I '$$CKACTS(GMRCIEN) D  G EN
 . W !,"The request has no activities meeting editing criteria"
 . H 2
 D BLDLST(GMRCIEN)
 D EN^VALM("GMRC ADM31")
 Q
 ;
GETCSLT() ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 D EN^DDIOL("You may only select IFC requests ordered at your facility")
 D EN^DDIOL(" ")
 S DIR(0)="PAO^123"
 S DIR("?")="Select an inter-facility request being performed elsewhere"
 S DIR("A")="Select Consult #: "
 S DIR("S")="I $P($G(^GMR(123,+Y,12)),U,5)=""P"""
 D ^DIR
 I '$G(Y) Q ""
 Q +Y
 Q
 ;
NEWCSLT ; select a new consult to work on
 D FULL^VALM1
 N GMRCIEN
 S GMRCIEN=$$GETCSLT
 I 'GMRCIEN D  D INIT Q
 . N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 . S DIR(0)="E" D ^DIR
 . Q
 I '$$CKACTS(GMRCIEN) D  D INIT Q
 . W !,"The request has no activities meeting editing criteria"
 D EXIT,BLDLST(GMRCIEN),INIT
 Q
 ;
SELACT ; choose which action to edit
 D FULL^VALM1
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y,GMRCO
 D EN^DDIOL("You may only select one of the listed activities.")
 D EN^DDIOL(" ")
 S DIR(0)="NAO^2:50"
 S DIR("A")="Select an activity from the list by number: "
 D ^DIR
 I $D(DIRUT) S VALMBCK="R" Q
 I '$D(^TMP("GMRCADM",$J,"B",+Y)) D  G SELACT
 . D EN^DDIOL("That is not a listed activity",,"!!?5")
 S GMRCO=$G(^TMP("GMRCADM",$J,"CSLT"))
 D FIX(GMRCO,+Y)
 D EXIT,BLDLST(GMRCO),INIT
 S VALMBCK="R"
 Q
 ;
BLDLST(GMRCDA) ;build the list for LM
 ; Input: 
 ;  GMRCDA = ien from file 123
 ;
 K ^TMP("GMRCADM",$J)
 N PTNM,PTSSN,REMSIT,REMNUM,GMRCCT,TAB
 S ^TMP("GMRCADM",$J,"CSLT")=GMRCDA
 S GMRCCT=1,TAB=$$REPEAT^XLFSTR(" ",29)
 S PTNM="Patient name: "_$$GET1^DIQ(123,GMRCDA,.02,"E")
 S PTSSN="SSN: "_$$GET1^DIQ(2,$P(^GMR(123,GMRCDA,0),U,2),.09)
 S REMSIT="Receiving Site: "
 S REMSIT=REMSIT_$$GET1^DIQ(4,$P(^GMR(123,GMRCDA,0),U,23),.01)
 S REMNUM="Remote Consult #: "_$P(^GMR(123,GMRCDA,0),U,22)
 S ^TMP("GMRCADM",$J,GMRCCT,0)="Consult #: "_GMRCDA
 S GMRCCT=GMRCCT+1
 S ^TMP("GMRCADM",$J,GMRCCT,0)=PTNM_"      "_PTSSN
 S GMRCCT=GMRCCT+1
 S ^TMP("GMRCADM",$J,GMRCCT,0)=REMSIT_"   "_REMNUM
 S GMRCCT=GMRCCT+1
 S ^TMP("GMRCADM",$J,GMRCCT,0)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCADM",$J,GMRCCT,0)="Facility",GMRCCT=GMRCCT+1
 S ^TMP("GMRCADM",$J,GMRCCT,0)=" Activity"_$E(TAB,1,16)_"Date/Time/Zone"_$E(TAB,1,6)_"Responsible Person"_$E(TAB,1,2)_"Entered By",GMRCCT=GMRCCT+1
 S ^TMP("GMRCADM",$J,GMRCCT,0)=$$REPEAT^XLFSTR("-",79)
 S GMRCCT=GMRCCT+1
 N ACTV
 S ACTV=0
 F  S ACTV=$O(^GMR(123,GMRCDA,40,ACTV)) Q:'ACTV  D
 . N ACTYPE
 . S ACTYPE=$P(^GMR(123,GMRCDA,40,ACTV,0),U,2)
 . Q:ACTYPE'=17&(ACTYPE'=4)  ;only FWD and SF are affected
 . Q:'$D(^GMR(123,GMRCDA,40,ACTV,2))  ;only remote activities
 . Q:'$O(^GMR(123,GMRCDA,40,ACTV,1,1))
 . S ^TMP("GMRCADM",$J,"B",ACTV)=GMRCCT
 . S ^TMP("GMRCADM",$J,GMRCCT,0)="    Act. #: "_ACTV,GMRCCT=GMRCCT+1
 . D BLDALN^GMRCSLM4(GMRCDA,ACTV)
 . M ^TMP("GMRCADM",$J)=^TMP("GMRCR",$J,"DT")
 . K ^TMP("GMRCR",$J,"DT")
 . S ^TMP("GMRCADM",$J,GMRCCT,0)="",GMRCCT=GMRCCT+1
 . Q
 Q
 ;
INIT ;
 S VALMCNT=$O(^TMP("GMRCADM",$J," "),-1)
 S VALMBG=1
 S VALMBCK="R"
 Q
 ;
EXIT ;
 K ^TMP("GMRCADM",$J)
 S VALMBCK="Q"
 Q
 ;
HDR ;
 S VALMHDR(1)=$$CJ^XLFSTR(("Consult #:"_^TMP("GMRCADM",$J,"CSLT")),80)
 Q
CKACTS(CSLT) ;assure that there is at least one activity meeting criteria
 ; Input:
 ;   CSLT = ien from file 123
 ;
 N ACTV,OK
 S ACTV=0,OK=0
 F  S ACTV=$O(^GMR(123,CSLT,40,ACTV)) Q:'ACTV!(OK=1)  D
 . N ACTYPE
 . S ACTYPE=$P(^GMR(123,CSLT,40,ACTV,0),U,2)
 . I ACTYPE=17 S OK=1 ; FWD action
 . I ACTYPE=4 S OK=1 ; SF action
 . I OK,'$D(^GMR(123,CSLT,40,ACTV,2)) S OK=0 ;only remote activities
 . I OK,'$O(^GMR(123,CSLT,40,ACTV,1,1)) S OK=0 ;only those with comments
 Q OK
 ;
FIX(GMRCDA,GMRCACT) ;do the admin correction on bad IFC comments
 ; GMRCDA  = ien from file 123
 ; GMRCACT = ien within 40 multiple for activity
 ;
 I '$D(^GMR(123,GMRCDA,40,1)) D  Q
 . W !,"No comment there to correct"
 K ^TMP("GMRCOCMT",$J)
 M ^TMP("GMRCOCMT",$J)=^GMR(123,GMRCDA,40,GMRCACT,1)
 W !!
 N DIE,DR,DA,CHGD
 S CHGD=0
 S DA=GMRCACT,DA(1)=GMRCDA,DR=5,DIE="^GMR(123,"_DA(1)_",40,"
 D ^DIE
 I $O(^GMR(123,GMRCDA,40,GMRCACT,1," "),-1)'=$O(^TMP("GMRCOCMT",$J," "),-1) S CHGD=1
 I 'CHGD D
 . N I S I=0
 . F  S I=$O(^GMR(123,GMRCDA,40,GMRCACT,1,I)) Q:'I!(CHGD)  D
 .. I ^GMR(123,GMRCDA,40,GMRCACT,1,I,0)'=^TMP("GMRCOCMT",$J,I,0) S CHGD=1
 .. Q
 I 'CHGD W !,"No comment modification made!",!
 I CHGD D AUDIT(GMRCDA,GMRCACT,$NA(^TMP("GMRCOCMT",$J)))
 K ^TMP("GMRCOCMT",$J)
 Q
 ;
AUDIT(GMRCO,GMRCAC,ARRAY) ;make new audit trail activity w/old and new
 ;Input: 
 ;  GMRCO  = ien from file 123
 ;  GMRCAC = IEN WITHIN 40 MULTIPLE
 ;  ARRAY  = array containing the old comment
 N GMRCA,GMRCAD,GMRCMT,GMRCDA,DA,NUM,I
 N ACTYPE,ACTWHO,ACTRESP,ACTWHEN
 I '$G(GMRCO) Q
 ; load up particulars about edited activity, then load old comment
 ; then load up new comment in GMRCMT local array
 S ACTYPE=$$GET1^DIQ(123.1,$P(^GMR(123,GMRCO,40,GMRCAC,0),U,2),.01)
 S ACTWHO=$P(^GMR(123,GMRCO,40,GMRCAC,2),U)
 S ACTRESP=$P(^GMR(123,GMRCO,40,GMRCAC,2),U,2)
 D  ;GET VALUE OF ACTWHEN
 . N X
 . S X=$P(^GMR(123,GMRCO,40,GMRCAC,2),U,5) D REGDTM^GMRCU
 . S ACTWHEN=X_" "_$P(^GMR(123,GMRCO,40,GMRCAC,2),U,3)
 S NUM=1
 S GMRCMT(NUM)=" ",NUM=NUM+1
 S GMRCMT(NUM)="The "_ACTYPE_" action, added "_ACTWHEN_" by",NUM=NUM+1
 S GMRCMT(NUM)=ACTWHO_" "_$S($L(ACTRESP):("for "_ACTRESP),1:"")_","
 S GMRCMT(NUM)=GMRCMT(NUM)_" has been administratively corrected."
 S NUM=NUM+1,GMRCMT(NUM)=" ",NUM=NUM+1
 S GMRCMT(NUM)="The comment was corrected from:",NUM=NUM+1
 S GMRCMT(NUM)=" ",NUM=NUM+1
 S I=0 ;load up old comment
 F  S I=$O(^TMP("GMRCOCMT",$J,I)) Q:'I  D
 . S GMRCMT(NUM)=^TMP("GMRCOCMT",$J,I,0),NUM=NUM+1
 S GMRCMT(NUM)=" ",NUM=NUM+1
 S GMRCMT(NUM)="The comment was corrected to: ",NUM=NUM+1
 S GMRCMT(NUM)=" ",NUM=NUM+1
 S I=0 ;load up current comment
 F  S I=$O(^GMR(123,GMRCO,40,GMRCAC,1,I)) Q:'I  D
 . S GMRCMT(NUM)=^GMR(123,GMRCO,40,GMRCAC,1,I,0)
 . S NUM=NUM+1
 ;
 ; file admin correct comment
 S GMRCDA=$$SETDA^GMRCGUIB ; get new activity ien
 S GMRCA=26,GMRCAD=$$NOW^XLFDT,DA=GMRCDA
 D SETCOM^GMRCGUIB(.GMRCMT,DUZ)
 Q
