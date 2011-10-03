TIUPNAPI ; SLC/JER - API to Replace GMRPAPI ; 8/8/05
 ;;1.0;TEXT INTEGRATION UTILITIES;**57,140,175,180,184**;Jun 20, 1997
 ;
 ; ^DPT( IA #3101
NEW(TIUIFN,DFN,TIUAUTH,TIURDT,TIUTITLE,TIULOC,TIUES,TIUPRT,TIUESBY,TIUASKVS,TIUADEL) ;
 ; -- Create new note
 ;****************
 ; Return variable (must pass by reference):
 ;      TIUIFN (pass by ref) = New note IFN in file 8925, -1 if error,
 ;                           = IFN^-1 if note filed, w/o signature when
 ;                              TIUES=1 (It has been IFN^-1 as far back
 ;                              as patch 140. Noted on 8/4/05)
 ;                           = -1 if user fails to enter valid cosig
 ;                           = IFN^-1 if TIUESBY>0 & signature fails,
 ;                             if TIUADEL not present
 ;                           =  -1^-1 if TIUESBY>0 & signature fails,
 ;                             if TIUADEL is present
 ;                           = -1^-1 if TIUES=1 and user deletes note
 ; Required Input parameters:
 ;      DFN                  = Patient IFN in file #2
 ;      TIUAUTH              = Author IFN in file #200
 ;      TIURDT               = Date/time of note in FM format
 ;      TIUTITLE             = Title IFN in file 8925.1
 ; Required global variable:
 ;      ^TMP("TIUP",$J)      = Array root for text in format compatible
 ;                             w/FM Word-processing fields. e.g.,
 ;                             ^TMP("TIUP",$J,0)=^^1^1^2961216^
 ;                             ^TMP("TIUP",$J,1,0)=Testing the TIUPNAPI.
 ; 
 ;                             NOTE: you no longer need to use the
 ;                             additional subscript to designate where
 ;                             the text should go (e.g., 10 for Admission
 ;                             Note).
 ; Optional Input variables:
 ;      TIULOC              = Patient Location IFN in file #44
 ;      TIUES               = 1 if TIU should prompt/process E-SIG
 ;      TIUPRT              = 1 if TIU should prompt user to print note
 ;      TIUESBY             = Signer IFN in file #200:  Calling App is
 ;                            resonsible for Electronic Signature
 ;      TIUASKVS            = BOOLEAN flag indicating whether to ask for visit
 ;      NOTE: If TIUESBY is passed, the document will be marked as
 ;            signed at the time the encrypted signature block name
 ;            and title are filed
 ;      TIUADEL             = BOOLEAN flag for automatic delete if TIUESBY>0 and
 ;                            signature fails instead of leaving UNSIGNED doc.
 ;****************
 ;
 N TIUX,TIUCHNG,TIUHIT,TIUPRM0,TIUPRM1,TIUTYP,TIUOUT,TIUDPRM,TIUVSTR
 N COSPROB,AUTHSIGN
 S TIUIFN=-1,COSPROB=0
 I $D(^TMP("TIUP",$J))'>9 Q  ; If no text, quit
 I '$D(^DPT(+$G(DFN),0)) G EXIT ; if not valid patient, clean-up & quit
 I $L($$GET1^DIQ(200,+$G(TIUAUTH),.01))'>0 G EXIT ; if not valid author, clean-up & quit
 I '$D(^TIU(8925.1,+$G(TIUTITLE),0)) G EXIT ; if not valid title, clean-up & quit
 I $S(+$G(TIURDT)'>0:1,+$G(TIURDT)>+$$NOW^XLFDT:1,+$$FMTH^XLFDT(TIURDT)'>0:1,1:0) G EXIT
 I $S('($D(DUZ)#2):1,$L($$GET1^DIQ(200,DUZ,.01))'>0:1,1:0) G EXIT
 S TIUASKVS=+$G(TIUASKVS)
 ; -- Okay, create new note
 S TIUX(1202)=TIUAUTH,TIUX(1301)=TIURDT
 ; get doc parameters
 D DOCPRM^TIULC1(TIUTITLE,.TIUDPRM)
 I +TIUASKVS D  G:+$G(TIUOUT) EXIT
 . N TIUBY,TIU,TIUY
 . D ENPN^TIUVSIT(.TIU,DFN,1)
 . I '$D(TIU) S TIUOUT=1,TIUIFN=-1 Q
 . S TIUY=$$CHEKPN^TIULD(.TIU,.TIUBY)
 . I '+TIUY S TIUOUT=1,TIUIFN=-1 Q
 . I '$L($G(TIU("VSTR"))) S TIUOUT=1,TIUIFN=-1 Q
 . S TIUVSTR=$G(TIU("VSTR")),TIULOC=+$G(TIU("LOC"))
 . I +$G(TIU("STOP")),(+$P(TIUDPRM(0),U,14)'=1) S TIUX(.11)=1
 M TIUX("TEXT")=^TMP("TIUP",$J)
 D MAKE^TIUSRVP(.TIUIFN,DFN,TIUTITLE,TIURDT,$G(TIULOC),"",.TIUX,$G(TIUVSTR))
 I +TIUIFN'>0 S TIUIFN=-1 G EXIT
 ; -- If author requires cosig, then 
 ;      If we're not interactive we can't get Exp Cos so we have
 ;      a cosig problem:
 S AUTHSIGN=$S($G(TIUESBY):TIUESBY,1:TIUAUTH)
 I +$$REQCOSIG^TIULP(TIUTITLE,"",AUTHSIGN) D  G:+$G(TIUOUT) EXIT
 . I $D(ZTQUEUED) S COSPROB=1 Q  ; called from a task
 . I $D(XWBOS) S COSPROB=1 Q  ; called from RPCBroker app
 . ; -- If we are interactive, get Exp Cos. Get it after note
 . ;      is created since screen needs IFN:
 . N DIE,DA,DR,X,Y,COSNEED,EXPCOS
 . S COSNEED=1
 . S EXPCOS=$$GETCOSNR(+TIUIFN)
 . I EXPCOS'>0 D DELETE^TIUSRVP("",+TIUIFN,"",1) S TIUIFN=-1,TIUOUT=1 Q
 . S DIE=8925,DR="1208////^S X=EXPCOS;1506////^S X=COSNEED",DA=+TIUIFN D ^DIE
 I '+$G(TIUESBY),(+$G(TIUES)>0) D  I +$G(TIUOUT) G EXIT
 . N VALMBCK
 . ; -- Present Browse Screen so user can sign:
 . D EXSTNOTE^TIUBR1(DFN,TIUIFN) I '$D(^TIU(8925,+TIUIFN,0)) S TIUIFN="-1^-1",TIUOUT=1 Q
 . I +$P(^TIU(8925,+TIUIFN,0),U,5)<6 S TIUIFN=TIUIFN_"^-1"
 ; -- If esig done by calling app:
 ;      but there IS a cosig problem and caller doesn't want unsigned
 ;        docmts left around, delete docmt:
 I +$G(TIUESBY),COSPROB,$G(TIUADEL) D DELETE^TIUSRVP("",+TIUIFN,"",1) S TIUIFN="-1^-1" G EXIT
 ;             but if unsigned is OK, leave it unsigned:
 I +$G(TIUESBY),COSPROB S TIUIFN=TIUIFN_"^-1"
 ; -- If esig done by calling app and no cosig problem,
 ;    mark it signed. If sig fails and caller doesn't
 ;      want unsigned docmts left around, delete docmt:
 I +$G(TIUESBY),'COSPROB D MARKSIGN(.TIUIFN,+$G(TIUESBY)) I +$G(TIUADEL),+$P(^TIU(8925,+TIUIFN,0),U,5)<6 D DELETE^TIUSRVP("",+TIUIFN,"",1) S TIUIFN="-1^-1" G EXIT
 D SEND^TIUALRT(+TIUIFN)
EXIT K ^TMP("TIUP",$J)
 Q
WHATITLE(X) ; -- Given a freetext title, return pointer to file 8925.1
 Q $$WHATITLE^TIUPUTU(X)
 ;
GETCOSNR(TIUIEN) ; Function Asks Expected Cosigner
 N TIUY,HELP
 S HELP="You may not select self, author, or others who require cosignature."
 S TIUY=$$READ^TIUU("P^200:AEMQ","EXPECTED COSIGNER","",HELP,"I $$SCRCSNR^TIULA3(TIUIEN,+Y)")
 Q +$G(TIUY)
 ;
MARKSIGN(TIUDA,TIUESBY) ; Mark note as electronically signed
 N ESNAME,ESTITLE,ESBLOCK
 I $S(+$G(TIUESBY)'>0:1,$L($$GET1^DIQ(200,+$G(TIUESBY),.01))'>0:1,+$$CANDO^TIULP(TIUDA,"SIGNATURE",$G(TIUESBY))'>0:1,1:0) S TIUDA=TIUDA_U_-1 Q
 S ESNAME=$$GET1^DIQ(200,+TIUESBY,20.2),ESTITLE=$$GET1^DIQ(200,+TIUESBY,20.3)
 S ESBLOCK="1^"_ESNAME_U_ESTITLE
 D ES^TIURS(TIUDA,ESBLOCK)
 I +$P(^TIU(8925,+TIUIFN,0),U,5)<6 S TIUDA=TIUDA_"^-1"
 Q
TEST ; Interactive Test
 N DUOUT,DFN,TITLE,TIUTYP,TIURDT,TIUDA,DIC K ^TMP("TIUP",$J)
 W !,"First, collect the data to pass to the API...",!
 S DFN=+$$PATIENT^TIULA Q:+DFN'>0
 D DOCSPICK^TIULA2(.TIUTYP,3,"1A","","","+$$CANPICK^TIULP(+Y),+$$CANENTR^TIULP(+Y)")
 S TITLE=$P($G(TIUTYP(1)),U,2) Q:+TITLE'>0
 S TIURDT=+$$NOW^XLFDT
 S DIC="^TMP(""TIUP"",$J," D EN^DIWE
 W !,"NOW, call the API!",!
 D NEW(.TIUDA,DFN,DUZ,TIURDT,TITLE,"",1,1,"",1)
 Q
