TIUSROI ; SLC/JER - TIU/Surgery Interface Routine ; 04/19/2004
 ;;1.0;TEXT INTEGRATION UTILITIES;**112,187,173**;Jun 20, 1997
 Q
GETOP(TIUY,TIUDA,SROTYP) ; Get Op-Top
 N SROVP
 S SROVP=$P($G(^TIU(8925,TIUDA,14)),U,5),SROTYP=$G(SROTYP,"OP")
 S TIUY=$S(SROTYP="OP":$NA(^TMP("SROP",$J,+SROVP)),1:$NA(^TMP("SRNOR",$J,+SROVP)))
 I $P(SROVP,";",2)'="SRF(" Q
 D @$S(SROTYP="OP":"OPTOP^SROSRPT(+SROVP)",1:"OPTOP^SRONP(+SROVP)")
 I +$G(@TIUY@(0))=0 K @TIUY Q
 I '$D(XWBOS),'$D(ZTQUEUED),($E($G(IOST))="C"),(@TIUY@(0)=2) D
 . N SEEOP S SEEOP=0
 . I $S(+$D(XQADATA):1,$G(TIUEVNT)["SIGN":1,1:0) D  Q:+SEEOP
 . . W ! S SEEOP=+$$READ^TIUU("YA","Do you want to see the Op Top? ","YES")
 . K @TIUY
 I $D(XWBOS),($G(@TIUY@(0))'=1) K @TIUY
 Q
GETCASE(DFN,DA) ; Match Operation Report to an open Surgical Case
 ; Call with:     [DFN] - patient file entry number
 ;   Returns:     TIUY  - Variable pointer to Surgical Case
AGN ; Loop for handling repeated attempts
 N TIUI,TIUII,TIUER,TIUOK,TIUOUT,TIUX,TIUY,TIUMTSTR,TIUMLST,TIUCNT,X,TIULIST
 I +DFN'>0 S TIUOUT=1 Q 0
 I +$G(DA) D  G:+TIUX>0 GETX
 . I +$P($G(^TIU(8925,+DA,14)),U,5) S TIUX=+$P($G(^(14)),U,5) Q
 . I +$$ISADDNDM^TIULC1(+DA) S TIUX=+$$DADSC(DA)
 D ISSURG^TIUSROI(.TIUY,+$G(^TIU(8925,+TIUDA,0))) I +TIUY W !,"This action is no longer permitted for SURGICAL REPORTS" H 3 Q 0
 D LIST^SROESTV(.TIULIST,DFN,"","","",0) ; Call Surgery to get list of cases
 ; If no Surgeries for patient, then quit
 I '$D(@TIULIST) D  Q -1
 . W !!,$C(7),"No SURGICAL CASES to Result for ",$$PTNAME^TIULC1(DFN),".",!
 S (TIUCNT,TIUI)=0 F  S TIUI=+$O(@TIULIST@(TIUI)) Q:+TIUI'>0  D
 . S TIUCNT=+$G(TIUCNT)+1
 W !,"You must link your Result to a SURGICAL CASE...",!
 D INDEX(TIULIST)
 D  I +TIUER Q:+$G(TIUOUT) 0  G AGN
 . W !,"The following SURGICAL CASE",$S(+TIUCNT>1:"(S) are",1:" is")," available:"
 . S (TIUER,TIUOK,TIUI)=0
 . F  S TIUI=$O(@TIULIST@(TIUI)) Q:+TIUI'>0!+TIUER!+TIUOK  D
 . . S TIUII=TIUI,TIUX=$G(@TIULIST@(TIUI))
 . . D WRITE I '(TIUI#5) D BREAK
 . Q:$D(TIUOUT)
 . I +TIUER S TIUOUT=1 Q
 . I TIUII#5 D BREAK Q:$D(TIUOUT)
 . I +TIUER S TIUOUT=1 Q
 . S TIUX=+@TIULIST@(TIUOK),^DISV(DUZ,"^SRF(",DFN)=+TIUX
 . W "  ",+TIUX
GETX S TIUY=+TIUX_";SRF(" K @TIULIST
 Q $G(TIUY)
BREAK ; Handle prompting
 W !,"CHOOSE 1-",TIUII W:$D(@TIULIST@(TIUII+1)) !,"<RETURN> TO CONTINUE",!,"OR '^' TO QUIT" W ": " R X:DTIME
 I $S('$T!(X["^"):1,X=""&'$D(@TIULIST@(TIUII+1)):1,1:0) S TIUER=1 Q
 I X="" Q
 I X=" ",$D(^DISV(DUZ,"^SRF(",DFN)) S TIUX=^(DFN) S TIUOK=+$O(@TIULIST@("C",+TIUX,0)) Q
 I X'=+X!'$D(@TIULIST@(+X)) W !!,$C(7),"INVALID RESPONSE",! G BREAK
 S TIUOK=X
 Q
DADSC(DA) ; Get the Surgical Case associated with the parent record
 N TIUDADA,TIUY S TIUDADA=$P($G(^TIU(8925,+DA,0)),U,6)
 S TIUY=$P($G(^TIU(8925,TIUDADA,14)),U,5)
 Q TIUY
WRITE ; Writes each case
 W !,$J(TIUI,4),">  ",$$DATE^TIULS($P(TIUX,U,3),"AMTH DD, CCYY")
 W " Case #",$P(TIUX,U),?34,$E($P(TIUX,U,2),1,25),?60,$E($P($P(TIUX,U,4),";",2),1,20)
 Q
INDEX(TIULIST) ; Build index of list
 N TIUI S TIUI=0
 F  S TIUI=$O(@TIULIST@(TIUI)) Q:+TIUI'>0  D
 . S @TIULIST@("C",+@TIULIST@(TIUI),TIUI)=""
 Q
ISSURG(TIUY,TITLE) ; Boolean RPC to evaluate whether TITLE is a SURGERY REPORT
 N TIUCLASS,TIUI S TIUY=0
 F TIUI="SURGICAL REPORTS","PROCEDURE REPORTS (NON-O.R.)" D  Q:TIUY>0
 . S TIUCLASS=+$$CLASS(TIUI)
 . I +TIUCLASS'>0 Q
 . S TIUY=+$$ISA^TIULX(TITLE,TIUCLASS)
 Q
RBOR(TIUDA) ; Roll back OPERATION REPORT when TIU changes require it
 N SRODA S SRODA=+$P($G(^TIU(8925,TIUDA,14)),U,5) Q:+SRODA'>0
 D OS^SROTIUD(SRODA)
 Q
RBPR(TIUDA) ; Roll back NON-O.R. PROC REPORT when TIU changes require it
 N SRODA S SRODA=+$P($G(^TIU(8925,TIUDA,14)),U,5)
 Q:+SRODA'>0
 D NON^SROTIUD(SRODA)
 Q
CLASS(CLNAME) ; What is the TIU Class (or Document Class) for SURGERY REPORTS
 N TIUY S TIUY=+$O(^TIU(8925.1,"B",CLNAME,0))
 I +TIUY>0,$S($P($G(^TIU(8925.1,+TIUY,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S TIUY=0
 Q TIUY
ES(TIUDA,TIUDUZ) ; Apply user's e-Sig to Document
 N TIUES S TIUDUZ=$G(TIUDUZ,DUZ)
 I '+$G(^TIU(8925,TIUDA,0)) Q
 S TIUES="1^"_$$SIGNAME^TIULS(TIUDUZ)_U_$$SIGTITL^TIULS(TIUDUZ)
 D ES^TIURS(TIUDA,TIUES)
 Q
ENTEROP(DFN,TIUTYP) ; Re-direct entry of Op and Proc Reports
 N TIUDA,TIUD0,TIUX,TIUPRM0,TIUPRM1,SUCCESS,TIUBUF,TIUTNM
 S TIUTNM=$$PNAME^TIULC1(TIUTYP)
 ; -- Exclude NIR and AR from Entry
 I $S(TIUTNM["ANESTH":1,TIUTNM["NURS":1,1:0) D  Q
 . W !!,TIUTNM,"s may only be entered through the Surgery Options.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . W !
 ; -- first, determine the correct TIU DOCUMENT record --
 F  D  Q:$D(DUOUT)!$D(DIROUT)!+$G(TIUOUT)
 . N D,D0,DK,DL,DIC,X,Y,DA,DX,A,S,TIUFPRIV
 . S X=+$G(DFN)
 . I X'>0 D  Q
 . . W !!,"No Patient Specified...",!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . S TIUOUT=1 W !
 . S DIC=8925,DIC(0)="UXEV",D="C"
 . W ! S DIC("W")="D DICW^TIUPUTS(+Y)",DIC("S")="I +$G(^TIU(8925,+Y,0))=TIUTYP"
 . D IX^DIC
 . I +Y'>0 D  Q
 . . W !!,$S(+$O(^TIU(8925,"C",+X,0))'>0:"No "_TIUTNM_"s Available.",1:"No "_TIUTNM_" Selected..."),!
 . . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . . S TIUOUT=1 W !
 . D BROWS1^TIURA2("TIU BROWSE FOR TRANSCRIPTION",+Y)
 . S TIUOUT=1 W !
 Q
REASSOP(DFN,TIUODA) ; Re-direct REASSIGNMENT of Op and Proc Reports
 N TIUDA,TIUD0,TIUD12,TIUTYP,TIUTNM,TIUSCRN
 S TIUD0(0)=$G(^TIU(8925,+TIUODA,0)),TIUD12(0)=$G(^(12))
 I DFN=$P(TIUD0(0),U,2) D CHANGE^TIUSROI1(TIUODA) Q
 S TIUTYP=+TIUD0(0)
 S TIUTNM=$$PNAME^TIULC1(TIUTYP)
 I +$$ISADDNDM^TIULC1(TIUODA),$S($$GET1^DIQ(8925,TIUODA,.06)["ANESTH":1,$$GET1^DIQ(8925,TIUODA,.06)["NURS":1,1:0) D  G REASSOPX
 . W !!,"ADDENDUMs to ",$$GET1^DIQ(8925,TIUODA,.06),"s may not be reassigned.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...")
 . S TIUOUT=1 W !
 S TIUDA=0
 I $S(TIUTNM["ANESTH":1,TIUTNM["NURS":1,1:0) D  G REASSOPX
 . W !!,TIUTNM,"s may only be created through the Surgery Options..."
 . W !,"Reassignment is not allowed.",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . S TIUOUT=1 W !
 W ! S SROVP=$$GETCASE^TIUSROI(DFN)
 I +SROVP'>0 D  Q
 . W !!,$C(7),"Okay, no harm done...",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 ; if target case is same as current, quit
 I +SROVP=+$P(^TIU(8925,TIUODA,14),U,5) D  Q
 . W !!,$C(7),"You've selected the original case. No changes made.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 ; Get the document for the target surgical case
 S TIUDA=$$TARGET^TIUSROI1(SROVP)
 ; if target document is of a different type than source, quit
 I $$TYPE^TIUSROI1(TIUDA)'=$$TYPE^TIUSROI1(TIUODA) D  Q
 . W !!,$C(7),"Incompatible document type. No changes made.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 I +TIUDA'>0 D  G REASSOPX
 . W !!,"No Destination Document Selected: Aborting Transaction,",!,"   No Harm Done...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 ; -- If original and target are the same --
 I +TIUDA=+TIUODA D  G REASSOPX
 . W !!,$C(7),"You've selected the original case. No changes made.",!
 . W:$$READ^TIUU("EA","Press RETURN to continue...") ""
 ; -- Confirm selection --
 I '$$FROMTO^TIUSROI1(TIUODA,TIUDA,TIUTNM) D  G REASSOPX
 . W !!,"Aborting Transaction, No Harm Done...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 ; -- Conditionally Retract Original --
 I (+$P(TIUD0(0),U,5)>5) D
 . N TIUMSG,TIURTCT S TIUMSG=$S(DFN=+$P(TIUD0(0),U,2):"Reassigning document...",DFN'=+$P(TIUD0(0),U,2):"Moving signed document to another Patient...")
 . W !!,TIUMSG,!,"A RETRACTED copy will be retained.",!
 . S TIURTCT=$$RETRACT^TIURD2(TIUODA,"",15)
 ; -- Copy AUTHOR from original to target/Update target status --
 D AUTHSTAT(TIUDA,TIUODA,.TIUD12)
 ; -- Copy contents of original into target --
 D COPYTEXT^TIURC1(TIUODA,TIUDA) K ^TIU(8925,TIUDA,15)
 I $D(^TIU(8925,TIUDA,"TEMP")) D
 . N TIU
 . D GETTIU^TIULD(.TIU,TIUDA)
 . D MERGTEXT^TIUEDI1(TIUDA,.TIU)
 . K ^TIU(8925,TIUDA,"TEMP")
 ; -- Conditionally roll back original --
 I +$P(TIUD0(0),U,5)>5 D
 . N TIUDA,TIUDELX
 . S TIUDA=TIUODA
 . S TIUDELX=$$DELETE^TIULC1(+$G(TIUD0(0)))
 . I TIUDELX]"" X TIUDELX
 I +$P(TIUD0(0),U,5)'>5 D
 . N TIUX,SUCCESS
 . K ^TIU(8925,TIUODA,"TEXT")
 . S TIUX(.05)=1
 . D FILE^TIUSRVP(.SUCCESS,TIUODA,.TIUX,1)
 ; -- Send Signature Alerts for target --
 D SEND^TIUALRT(TIUDA)
 ; -- Delete Signature Alerts for Original --
 D ALERTDEL^TIUALRT(TIUODA)
 ; -- Audit Reassignment of target --
 S TIUD0(1)=$G(^TIU(8925,+TIUDA,0)),TIUD12(1)=$G(^(12))
 D AUDREASS^TIURB1(TIUDA,.TIUD0,.TIUD12)
 ; -- Register audit trail for original
 I +$G(TIUODA) D AUDREASS^TIURB1(TIUODA,.TIUD0,.TIUD12)
 S TIUCHNG=1
REASSOPX Q
AUTHSTAT(TIUDA,TIUODA,TIUD12) ; Copy Author, update status
 N TIUX,SUCCESS
 S TIUX(.05)=5
 S TIUX(1406)=TIUODA
 I +$P(TIUD12(0),U,2) S TIUX(1202)=$P(TIUD12(0),U,2)
 D FILE^TIUSRVP(.SUCCESS,TIUDA,.TIUX,1)
 Q
SELOP(DFN,TIUTYP,TIUSCRN) ; Select an Op or Proc Report
 N DUOUT,DTOUT,D,D0,DK,DL,DIC,X,Y,DA,DX,A,S,TIUFPRIV,TIUY,TIUTNM
 S TIUY=0
 S TIUTNM=$$PNAME^TIULC1(TIUTYP)
 S TIUSCRN=$G(TIUSCRN,"I +$G(^TIU(8925,+Y,0))=TIUTYP")
 S X=+$G(DFN)
 I X'>0 D  G SELOPX
 . W !!,"No Patient Specified...",!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . W !
 S DIC=8925,DIC(0)="UXEV",D="C"
 W !
 S DIC("W")="D DICW^TIUPUTS(+Y)"
 S DIC("S")=TIUSCRN
 D IX^DIC
 I +Y'>0 D
 . W !!,"No "_TIUTNM
 . W $S(+$O(^TIU(8925,"APT",DFN,TIUTYP,0))'>0:"s On File.",+$O(^(0))>2:"s Available.",1:" Selected..."),!
 . I $$READ^TIUU("EA","Press RETURN to continue...") ; pause
 . W !
 S TIUY=+Y
SELOPX Q TIUY
