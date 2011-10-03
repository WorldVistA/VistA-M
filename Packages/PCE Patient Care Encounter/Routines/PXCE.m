PXCE ;ISL/dee - Main routine for PCE's user interface ; 3/27/01 12:17pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**25,47,52,64,75,78,147,151,161**;Aug 12, 1996
 ;
 ;PXCEKEYS is a set of letters that enable the user
 ;  to enter certain fields
 ;  "P" is included if the user holds the AK.PROVIDER key.
 ;  "C" should be included by the option if the user should be
 ;    asked for the Provider Narrative Categories on V CPT, V POV,
 ;    and V TREATMENT files.  As well as for  other fields that are
 ;    not ask of the normal user.
 ;  "S" is for the superviser.  If they have "S" then they will be 
 ;    given "C" and "D" by the program.
 ;  "V" is for view only
 ; And if it:
 ;  includes "D" to delete any V-File
 ;  includes "d" to only delete V-File entries this user created
 ;
 I '$D(PXCEKEYS)#2 N PXCEKEYS S PXCEKEYS=""
 S:PXCEKEYS'["D" PXCEKEYS=PXCEKEYS_"D"
 G START
 ; -- main entry point for PCE's user interface
EN1(PXCEKEYS) ;Does not checks for provider
 G START1
EN(PXCEKEYS) ;Checks for provider
 ;
START ;
 ;Key for provider (P)
 I PXCEKEYS'["P",$O(^VA(200,"AK.PROVIDER",$P(^VA(200,DUZ,0),"^"),""))=DUZ S PXCEKEYS=PXCEKEYS_"P"
START1 ;
 ;If they have the Key for superviser (S) make sure that they also
 ;  have C and D.
 I PXCEKEYS["S" S:PXCEKEYS'["C" PXCEKEYS=PXCEKEYS_"C" S:PXCEKEYS'["D" PXCEKEYS=PXCEKEYS_"D"
 ;
 K I,X,SDB,XQORNOD,SDFN,SDCLN,DA,DR,DIE,DNM,DQ,%B
 N PXCEVIEW,SDAMTYP
 N PXCEPAT,PXCEHLOC
 N PXCEDBEG,PXCEDEND,PXCE9BEG,PXCE9END,SDBEG,SDEND
 N PXCEDBP,PXCEDBHL,PXCEDEP,PXCEDEHL
 N PXCECONT
 N PXCESOR,PXCEPKG
 I $G(DFN)'>0 N DFN
 ;
 S PXCEVIEW="^"_$S("~V~A~"["~"_$P(^PX(815,1,"LM"),"^",2)_"~":$P(^PX(815,1,"LM"),"^",2),1:"V")_"^"
 S PXCESOR=$$SOURCE^PXAPIUTL("PXCE DATA ENTRY")
 S PXCEPKG=$$PKG2IEN^VSIT("PX")
 ;
 K DIRUT
 D SETUP Q:$D(DIRUT)
 ;
 F  D  Q:$D(PXCEVIEW)'=1!'$D(PXCECONT)
 . K PXCECONT
 . I PXCEKEYS["V" D
 .. I PXCEVIEW["A" D
 ... D EN^VALM("PXCE SDAM VIEW ONLY")
 .. E  D EN^VALM("PXCE VIEW ONLY")
 . E  I PXCEVIEW["A" D
 .. D EN^VALM("PXCE SDAM MENU")
 . E  D EN^VALM("PXCE MAIN MENU")
 D FULL^VALM1
 D EXITALL
 Q
 ;
SETUP ;
 N DIR,DA,X,Y,PXRES
 N PXCEUSEL,X1,X2
 I $G(DFN)>0 S PXCEUSEL=DFN_"^DPT("
 E  S DIR(0)="815,201",DIR("A")="Select Patient or Clinic name" D ^DIR K DIR,DA Q:$D(DIRUT)  S PXCEUSEL=Y
 S X1=DT,X2=$S($P(^PX(815,1,"LM"),"^",3)]"":$P(^PX(815,1,"LM"),"^",3),1:-30) D C^%DTC
 S PXCEDBP=X
 S X1=DT,X2=$S($P(^PX(815,1,"LM"),"^",4)]"":$P(^PX(815,1,"LM"),"^",4),1:0) D C^%DTC
 S PXCEDEP=X
 S X1=DT,X2=$S($P(^PX(815,1,"LM"),"^",5)]"":$P(^PX(815,1,"LM"),"^",5),1:-7) D C^%DTC
 S PXCEDBHL=X
 S X1=DT,X2=$S($P(^PX(815,1,"LM"),"^",6)]"":$P(^PX(815,1,"LM"),"^",6),1:0) D C^%DTC
 S PXCEDEHL=X
 I PXCEUSEL["DPT(" S $P(PXCEVIEW,"^",1)="P" S SDAMTYP="P"
 I PXCEUSEL["SC(" S $P(PXCEVIEW,"^",1)="H" S SDAMTYP="C" D  I 'PXRES G SETUP
 .S PXRES=$$CLNCK^SDUTL2(+PXCEUSEL,1)
 .I 'PXRES W !,?5,"Clinic MUST be corrected before continuing."
 D SETDATES
 I PXCEUSEL["DPT(" S PXCEPAT=+PXCEUSEL,FSEL=1 D NEWPAT1^PXCEPAT K FSEL G:$D(DIRUT) SETUP
 I PXCEUSEL["SC(" S PXCEHLOC=+PXCEUSEL D NEWHOSL1^PXCENEW
 Q
 ;
SETDATES ;
 I PXCEVIEW["H" D
 . S PXCEDBEG=PXCEDBHL
 . S PXCEDEND=PXCEDEHL
 E  D
 . S PXCEDBEG=PXCEDBP
 . S PXCEDEND=PXCEDEP
 D DATE9S^PXCEDATE
 Q
 ;
HDR ; -- header code
 K VALMHDR,PXLNX,PXPCP
 S PXLNX=1,PXPCP=""
 ;
 ;PATIENT
 I PXCEVIEW["P" D
 . S PXPCP=$$PCLINE^SDPPTEM(PXCEPAT,DT)
 . S VALMHDR(PXLNX)=$E(PXCEPAT("NAME"),1,26)
 . S VALMHDR(PXLNX)=$E(VALMHDR(PXLNX)_$E("    ",1,(27-$L(VALMHDR(PXLNX))))_PXCEPAT("SSN")_"                                           ",1,40)
 E  S VALMHDR(PXLNX)="                                        "
 ;LOCATION
 S VALMHDR(PXLNX)=VALMHDR(PXLNX)_"Clinic:  "_$S($G(PXCEHLOC)&(PXCEVIEW'["P^A"):$P(^SC(PXCEHLOC,0),"^"),1:"All")
 S PXLNX=PXLNX+1
 I $L(PXPCP) S VALMHDR(PXLNX)=PXPCP,PXLNX=PXLNX+1
 ;
 ;DATE
 S VALMHDR(PXLNX)=$E("Date range:  "_$$FMTE^XLFDT(PXCEDBEG,5)_" to "_$$FMTE^XLFDT(PXCEDEND,5)_$J("",40),1,40)
 ;
 ;Credit Stop
 S:PXCEVIEW["A" VALMHDR(PXLNX)=VALMHDR(PXLNX)_$P($G(SDAMLIST),"^",2)
 S PXLNX=PXLNX+1
 ;
 ;CHECK IF GAF NEEDED
 I PXCEVIEW'["P",$$MHCLIN^SDUTL2(PXCEHLOC) S VALMHDR(PXLNX)=$$SETSTR^VALM1("* - New GAF Score Required","",25,80)
 I PXCEVIEW["P" D
 .S VALMHDR(PXLNX)=$$SETSTR^VALM1("* - New GAF Score Required","",25,80)
 .N PXCEHLC,PXCESTA
 .K PXCEHIT
 .S PXCESTA=$$ELSTAT^SDUTL2(PXCEPAT)
 .S PXCEZZ=0
 .F  S PXCEZZ=$O(^TMP("PXCEIDX",$J,PXCEZZ)) Q:PXCEZZ'>0  D  Q:$D(PXCEHIT)
 ..S PXCEHLC=+$P($G(^AUPNVSIT(^TMP("PXCEIDX",$J,PXCEZZ),0)),"^",22)
 ..I $$MHCLIN^SDUTL2(PXCEHLC),'$$COLLAT^SDUTL2(PXCESTA) D
 ...S PXCEGAF=$$NEWGAF^SDUTL2($S($D(SDFN):SDFN,$D(PXCEPAT):PXCEPAT,1:""))
 ...S PXCEGST=$P(PXCEGAF,"^")
 ...I PXCEGST D
 ....S PXCEGDT=$$FMTE^XLFDT($P(PXCEGAF,"^",3),"5M"),PXCEGSC=$P(PXCEGAF,"^",2),PXCEGPR=$P(PXCEGAF,"^",4)
 ....S VALMHDR(PXLNX)="GAF Date: "_PXCEGDT_"  GAF Score:"_PXCEGSC_"   NEW REQ",PXCEHIT=1
 ;
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
INIT ; -- init variables and list array
 D MAKELIST^PXCENEW
 Q
 ;
EXIT ; -- exit code
 D FULL^VALM1
 D CLEAN^VALM10
 K ^TMP("PXCE",$J)
 K ^TMP("PXCEIDX",$J)
 D FNL^PXCESDAM
 Q
 ;
EXITALL ; Exit of whole program
 D PATKILL^PXCEPAT
 D KVA^VADPT
 Q
 ;
DONE ; -- exit action for protocol
 S:'$D(VALMBCK) VALMBCK="R"
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
EXPND ; -- expand code
 D EN^PXCEEXP
 Q
 ;
SEL1(HELP,PXCEADD) ; Select 1 visit
 ; If the $GET(PXCEADD) is non zero then will 
 ;   add to the prompt "add a new encounter"
 N X,Y,MAX
 S MAX=+$G(^TMP("PXCEIDX",$J,0)) I MAX'>0 Q "^"
 S Y=$P($P(XQORNOD(0),"^",4),"=",2)
 I Y]"" D
 . I (+Y'=Y)!(+Y>MAX)!(+Y<1)!(Y#1'=0) D
 .. W !,$C(7),"Selection '",Y,"' is not a valid choice."
 .. D PAUSE^PXCEHELP
 .. S Y="^"
 E  I '$G(PXCEADD) D
 . N DIR,DA
 . S DIR(0)="NAO^1:"_MAX_":0",DIR("A")="Select Encounter"
 . S:MAX>1 DIR("A")=DIR("A")_" (1-"_MAX_"): "
 . S:MAX'>1 DIR("A")=DIR("A")_": ",DIR("B")=1
 . S DIR("?")="Enter the number of the Encounter you wish to "
 . S DIR("?")=DIR("?")_$S($L(HELP):HELP,1:"act on")
 . D ^DIR I $D(DTOUT)!(X="") S Y="^"
 E  D
 . N DIR,DA
ASKLOOP . S DIR(0)="FAO^1:"_$L(MAX)
 . S DIR("A")="Enter 1-"_MAX_" to Edit, or 'A' to Add: "
 . S DIR("?")="Enter the number of the Encounter you wish "
 . S DIR("?")=DIR("?")_$S($L(HELP):HELP,1:"act on")_" or A to "
 . S DIR("?")=DIR("?")_$S($L(HELP):HELP,1:"act on")_" add a new Encounter"
 . D ^DIR
 . K DIR,DA
 . I $D(DIRUT)!(X="") S Y="^" Q
 . I "Aa"[Y S Y="A" Q
 . G:Y<1!(Y>MAX) ASKLOOP
 Q Y
 ;
GAF ;;
 N PXCEVIEN,PXDFN,PXDSS,PXELIG,PXDATA
 I $G(PXCEHLOC),'$$MHCLIN^SDUTL2(PXCEHLOC) D  G SKIP
 . S DIR(0)="FOA"
 . S DIR("A",1)=" This is not a Mental Health Clinic, a GAF Score may not be entered."
 . S DIR("A")=" Press any key to continue: "
 . D ^DIR K DIR
 ;
 I $D(^TMP("PXCEIDX",$J)) D GETVIEN^PXCEAE
 I $D(^TMP("SDAMIDX",$J)) S PXCEVIEN=$$SELAPPM^PXCESDAM
 I '($G(PXCEVIEN)]"")!($G(PXCEVIEN)=-1) D  S VALMBCK="R" Q
 . S DIR(0)="FAO"
 . I '($G(PXCEVIEN)]"") S DIR("A",1)="Nothing to select."
 . I $G(PXCEVIEN)=-1 S DIR("A",1)="No selections made."
 . S DIR("A")="Press any key to continue."
 . D ^DIR K DIR
 S PXDFN=$P($G(^AUPNVSIT(PXCEVIEN,0)),"^",5)
 S PXDSS=$P($G(^AUPNVSIT(PXCEVIEN,0)),"^",8)
 S PXDATA=$G(^DPT(PXDFN,"S",$P(^AUPNVSIT(PXCEVIEN,0),U),0))
 S PXELIG=$$ELSTAT^SDUTL2(PXDFN)
 I $$MHCLIN^SDUTL2("",PXDSS),'($$COLLAT^SDUTL2(PXELIG)!$P(PXDATA,U,11)) D
 . S PXGAF=$$NEWGAF^SDUTL2(PXDFN)
 . D FULL^VALM1
 . W !
 . I +$P(PXGAF,U,5)>0 W !,"Warning: Patient is deceased."
 . W !,"Current GAF: "_+$P(PXGAF,U,2)
 . W $S($P(PXGAF,U,3)>0:", from "_$$FMTE^XLFDT($P(PXGAF,U,3),"D"),1:", Date Unavailable")
 . D EN^SDGAF(PXDFN)
 E  D
 . S DIR(0)="FOA"
 . S DIR("A",1)="A GAF Score is not required for this appointment!"
 . S DIR("A")="Press any key to continue: "
 . D ^DIR K DIR
 ;
SKIP S VALMBCK="R"
GAFQ Q
 ;
