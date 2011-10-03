TIULA ; SLC/JER - Interactive Library functions ;04/23/10  09:00
 ;;1.0;TEXT INTEGRATION UTILITIES;**79,113,250**;Jun 20, 1997;Build 14
 ;
 ; ICR #10142    - EN^DDIOL Routine
 ;     #10006    - DIC Routine & DIC, X, & Y local vars
 ;     #10026    - DIR Routine & DIR, X, & Y local vars
 ;     #10112    - $$PRIM^VASITE, $$SITE^VASITE Routines
 ;     #664      - DIVISION^VAUTOMA Routine & VAUTD local var
 ;     #10140    - XQORM, EN^XQORM Routine & XQORM local var
 ;
PATIENT(TIUSSN) ; Select a patient
 N X,DIC,Y S:$G(TIUSSN)]"" X=TIUSSN
 S DIC=2,DIC(0)=$S($G(TIUSSN)']"":"AEMQ",1:"MX") D ^DIC
 Q Y
SELDIV ; Get document division(s)
 ;
 ; Output - SELDIV  -1= user ^ at prompt if multidivisional
 ;                   0= institution file pointer missing for
 ;                      division entry
 ;                   1= successful division selection
 ;          BADDIV    = comma-delimited list of bad divisions (if any)
 ;          TIUDI(  undefined= user <cr> for all divisions or ^ at prompt
 ;                             if multidivisional
 ;                  defined= user selected one or more divisions if
 ;                           multidivisional, or pre-selection of
 ;                           division file entry if not multidivisional;
 ;                           i.e.: TIUDI(file #40.8 ien)= Institution
 ;                           file pointer for file #40.8 entry
 N TIUI,VAUTD,Y
 K SELDIV,TIUDI,BADDIV
 ; -- Determine if facility is multidivisional
 I $P($G(^DG(43,1,"GL")),U,2) D
 . D DIVISION^VAUTOMA
 . I Y<0 S SELDIV=-1 Q
 . I VAUTD=1 S SELDIV=1 Q
 . S TIUI=0 F  S TIUI=$O(VAUTD(TIUI)) Q:'TIUI  D ONE(TIUI,.VAUTD)
 E  D
 . S TIUI=$$PRIM^VASITE D ONE(TIUI,.VAUTD)
 Q
ONE(TIUI,VAUTD) ; Input - TIUI  Medical Center Division file (#40.8) IEN
 N TIUIFP
 S TIUIFP=$P($$SITE^VASITE(,TIUI),U) I TIUIFP>0 D
 . S TIUDI(TIUI)=TIUIFP,SELDIV=1
 E  D
 . S SELDIV=0,BADDIV=$G(BADDIV)_$S($L($G(BADDIV)):", ",1:"")_$G(VAUTD(TIUI))
 Q
 ;
SELSVC(TIUSVCS) ;Select Services
 ; Input  -- None
 ; Output -- 1=Successful and 0=Failure
 ;           TIUSVCS  Service Selection Array
 N TIUCNT,TIUSVCI,Y
 S TIUCNT=0
 F  Q:'$$ASKSVC(.TIUSVCS,TIUCNT,.TIUSVCI)  D
 . S TIUSVCS(+TIUSVCI)=""
 . S TIUCNT=TIUCNT+1
 . S TIUSVCI=""
 I $G(TIUSVCI)=-1 S Y=0 G SELSVCQ
 I $G(TIUSVCI)="ALL" S TIUSVCS="ALL"
 S Y=1
SELSVCQ Q +$G(Y)
 ;
ASKSVC(TIUSVCS,TIUCNT,TIUSVCI) ;Ask Service
 ; Input  -- TIUSVCS  Service Selection Array
 ;           TIUCNT   Number of Services Selected
 ; Output -- 1=Successful and 0=Failure
 ;           TIUSVCI  Service/Section file (#49) IEN
 N DIR,DTOUT,DUOUT,X,Y
 S DIR(0)="PAO^49:AEMQ^K:'$$CHKSVC^TIULA(.TIUSVCS,+Y) X"
 S DIR("PRE")="I X="""",'$G(TIUCNT),'$D(DTOUT) S TIUSVCI=""ALL"""
 S DIR("A")="Select "_$S($G(TIUCNT):"another ",1:"")_"service: "_$S('$G(TIUCNT):"ALL// ",1:"")
 I '$G(TIUCNT) S DIR("?")="   OR enter Return for ALL services." W !
 D ^DIR
 I Y>0 S TIUSVCI=+Y
 I $D(DTOUT)!($D(DUOUT)) S TIUSVCI=-1
 Q $S($G(TIUSVCI)>0:1,1:0)
 ;
CHKSVC(TIUSVCS,TIUSVCI) ;Check Selected Service
 ; Input  -- TIUSVCS  Service Selection Array
 ;           TIUSVCI  Service file (#49) IEN
 ; Output -- 1=Successful and 0=Failure
 N Y
 S Y=1
 ;Check if Service has already been selected
 I $D(TIUSVCS(TIUSVCI)) D EN^DDIOL("This Service has already been selected.","","!?5") S Y=0
 Q +$G(Y)
 ;
SELSTAT(Y,PARM,DEF) ; Select Signature status
 N I,XQORM,X,TIUY
 S XQORM=+$O(^ORD(101,"B","TIU STATUS MENU",0))_";ORD(101,"
 I +XQORM'>0 W !,"Status selection unavailable." S TIUY=-1 G STATX
 S XQORM(0)=$G(PARM),XQORM("A")="Select Status: "
 I $S(PARM="F":1,PARM="R":1,1:0) S X=DEF
 S XQORM("B")=DEF D ^XQORM
 S TIUY=$G(Y)
 I +$G(Y)=1,(+$G(Y(1))=7) S Y=2,Y(2)="8^4843^amended^8"
STATX Q TIUY
SELSCRN(DEF) ; Select Review Screen
 N DIC,XQORM,X,Y
 S DIC=101,DIC(0)="X",X="TIU REVIEW SCREEN MENU" D ^DIC
 I +Y>0 D
 . S XQORM=+Y_";ORD(101,",XQORM(0)="1A",XQORM("A")="Select Category: "
 . S XQORM("S")="I 1 X:$D(^ORD(101,+$P(^ORD(101,DA(1),10,DA,0),U),24)) ^(24)"
 . S XQORM("B")=DEF D ^XQORM
 . I +Y,($D(Y)>9) D
 . . S Y=$S(Y(1)["Author":"AAU",Y(1)["Patient":"APT",Y(1)["Spec":"ATS",Y(1)["Transcrip":"ATC",Y(1)["All":"ALL",Y(1)["Subject":"ASUB",Y(1)["Service":"ASVC",Y(1)["Location":"ALOC",1:"")
 . . I +$G(Y(1))'>0,(X'="^^"),(X'="^") D  Q
 . . . W !,"^^-jumps not allowed from this prompt." S Y=-1
 . . S:Y'="ALL" Y=Y_U_$$SELPAR(Y)
 . . S:Y="ALL" Y=Y_U_"ANY"
 Q Y
SELPAR(DEF) ; Select an author or patient or...
 N DIC,X,Y
 I DEF="ASUB" S Y=$$ASKSUBJ^TIULA1 G SELPARX
 S DIC=$S(DEF="APT":2,DEF="ATS":45.7,DEF="ASVC":123.5,1:200)
 S DIC(0)="AEMQ"
 S DIC("A")="Select "_$S(DEF="APT":"PATIENT",DEF="AAU":"AUTHOR",DEF="ATS":"TREATING SPECIALTY",DEF="ATC":"TRANSCRIPTIONIST",DEF="ASVC":"SERVICE",1:"ATTENDING PHYSICIAN")_": "
 I DEF="ARP" S DIC("S")="I $$ISA^USRLA(+$G(Y),""PROVIDER"")"
 D ^DIC K DIC("S") I +Y>0 D
 . I $S(DEF="APT"&'$D(^TIU(8925,"C",+Y)):1,DEF="AAU"&'$D(^TIU(8925,"CA",+Y)):1,DEF="ARP"&'$D(^TIU(8925,"CR",+Y)):1,1:0) W !,"No entries for ",$P(Y,U,2) S Y=0
SELPARX Q Y
EDATE(PRMPT,STATUS,DFLT) ; Get early date
 N X,Y,TIUPRMT,TIUDFLT
 I $G(STATUS)=4 S Y=1 Q Y
 S TIUPRMT=" Start "_$S($L($G(PRMPT)):PRMPT_" ",1:"")_"Date [Time]: "
 S TIUDFLT=$S($L($G(DFLT)):DFLT,1:"T-30")
 S Y=$$READ^TIUU("DOA^::AET",TIUPRMT,TIUDFLT)
 Q Y
LDATE(PRMPT,STATUS,DFLT) ; Get late date
 N X,Y,TIUPRMT,TIUDFLT
 I $G(STATUS)=4 S Y=9999999 Q Y
 S TIUPRMT="Ending "_$S($L($G(PRMPT)):PRMPT_" ",1:"")_"Date [Time]: "
 S TIUDFLT=$S($L($G(DFLT)):DFLT,1:"NOW")
 S Y=$$READ^TIUU("DOA^::AET",TIUPRMT,TIUDFLT)
 Q Y
CATEGORY() ; Select Service Category
 N DIR,X,Y
 S DIR(0)="9000010,.07",DIR("A")="Select SERVICE CATEGORY"
 D ^DIR
 Q Y_U_Y(0)
SELTYP(DA,RETURN,PARM,DFLT,TYPE,MODE,DCLASS,PICK) ; Select Document Types
 N I,J,X,XQORM,CURTYP,Y
 I '$D(RETURN) S RETURN=$NA(^TMP("TIUTYP",$J)) K @RETURN
 ; TIUK is STATIC
 ;I +MODE D DOCLIST^TIULA1(DA,.RETURN,PARM,DFLT) Q:+RETURN'<0
 ; *** ADD CALL TO PERSONAL DOCUMENT LISTER HERE
 N:'$D(TIUK) TIUK S TIUK=+$G(TIUK)
 I $G(DFLT)="LAST" D
 . S DFLT=$O(^DISV(DUZ,"XQORM",DA_";TIU(8925.1,",0))
 . S DFLT=$S(+DFLT:$G(^DISV(DUZ,"XQORM",DA_";TIU(8925.1,",DFLT)),1:"")
 I $G(TYPE)']"" S TYPE="DOC"
 I $G(MODE)']"" S MODE=1 ; Default is ASK
 S XQORM=DA_";TIU(8925.1,",XQORM(0)=$S(+$P($G(^TIU(8925.1,+DA,10,0)),U,3)=1:"F",1:$G(PARM,"AD"))
 I XQORM(0)["D" S XQORM("H")="W !!,$$CENTER^TIULS(""--- ""_$P(^TIU(8925.1,+DA,0),U,3)_"" ---""),!"
 I $S(XQORM(0)="F":1,XQORM(0)="R":1,1:0) S X=$S(DFLT]"":DFLT,1:"ALL")
 S:$G(DFLT)]"" XQORM("B")=DFLT
 S XQORM("A")="Select "_$S(XQORM(0)["D":"Document",1:$P(^TIU(8925.1,+DA,0),U,3))_$S($P(^TIU(8925.1,+DA,0),U,4)="DOC":" Component",1:" Type")_$S(+XQORM(0)'=1:"(s)",1:"")_": "
 ; If screening inactive titles proves to be correct, remove comment
 ; from the line below:
 ; S XQORM("S")="I +$$CANPICK^TIULP(+$G(^TIU(8925.1,+DA(1),10,+DA,0)))>0"
 D EN^XQORM
 I +Y'>0,($D(@RETURN)'>9) S @RETURN=Y Q
 I (PARM["A"),(+$G(@RETURN)'>0) M PICK=Y
 S I=0 F  S I=$O(Y(I)) Q:+I'>0  D
 . N TYPMATCH
 . S J=+$P(Y(I),U,2),CURTYP=$P($G(^TIU(8925.1,+J,0)),U,4)
 . I CURTYP="DC" S DCLASS=+$G(DCLASS)+1,DCLASS(DCLASS)=J
 . I  I TYPE="DOC",(PARM["A"),(+$O(^TIU(8925.1,+J,10,0))'>0) W !!,"The Document Class ",$P(^TIU(8925.1,+J,0),U)," has no active titles at present..."
 . S TYPMATCH=$$TYPMATCH^TIULA1(TYPE,CURTYP)
 . I +TYPMATCH>0 D
 . . S TIUK=+$G(TIUK)+1,@RETURN@(TIUK)=Y(I),@RETURN=TIUK
 . I $S('+$G(TYPMATCH):1,CURTYP="CL":1,1:0),+$O(^TIU(8925.1,+J,10,0))>0 D SELTYP(+J,.RETURN,$S(MODE=1:$G(PARM),1:"F"),$S(MODE=1:"LAST",1:"ALL"),TYPE,MODE,.DCLASS,.PICK)
 Q
