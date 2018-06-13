GMRCCA ;SFVAMC/DAD - Consult Closure Tool: Report Prompting ;01/20/17 15:19
 ;;3.0;CONSULT/REQUEST TRACKING;**89**;DEC 27, 1997;Build 62
 ;Consult Closure Tool
 ; IA#    Usage      Component
 ; ---------------------------
 ;  4836  Private    ^DIC(40.7
 ;   510  Controlled ^DISV(
 ;  1519  Supported  EN^XUTMDEVQ
 ;  2056  Supported  $$GET1^DIQ
 ;  2608  Supported  $$TEST^DDBRT
 ; 10024  Supported  WAIT^DICD
 ; 10026  Supported  ^DIR
 ; 10063  Supported  ^%ZTLOAD
 ; 10103  Supported  $$DT^XLFDT
 ; 10104  Supported  $$TRIM^XLFSTR
 ; 10150  Supported  HLP^DDSUTL
 ; 
EN ;
 ; *** Interactive entry point
 N GM0CFG,GMAPPT,GMDLIM,GMHEAD,GMAUTO,GMNOTE,GMOKAY
 N GMOPUT,GMTBEG,GMTEAM,GMTEXT,GMTEND,GMXLAT
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N X,Y,ZTCPU,ZTDESC,ZTDTH,ZTIO,ZTKIL
 N ZTPRI,ZTRTN,ZTSAVE,ZTSK,ZTSYNC,ZTUCI
 S GMAUTO=0 ; 0-disable/1-enable consult auto update (***DO NOT ENABLE***)
 ;
 ;
 K DIR
 S DIR(0)="POAr^123.033:AEMNQZ"
 S DIR("A")="Select CONSULT CONFIGURATION: "
 S GM0CFG=$G(^DISV(DUZ,$$GLOBROOT^GMRCCD(123.033)))
 I $$CHKCFG(+GM0CFG,1)>0 D
 . S DIR("B")=$$GET1^DIQ(123.033,+GM0CFG,.01)
 . Q
 S DIR("S")="I $$CHKCFG^GMRCCA(+Y,1)>0"
 W ! D ^DIR S GM0CFG=+$G(Y)
 I $$DIREXIT>0 G EXIT
 ;
 S GMHEAD="Select a consult date range"
 D LASTMNTH^GMRCCY($$DT^XLFDT,.GMTBEG,.GMTEND)
 W ! I $$EN^GMRCCY(.GMTBEG,.GMTEND,GMHEAD,"U")'>0 G EXIT
 ;
 K DIR
 S DIR(0)="SOA^1:Seen in clinic;0:Not seen in clinic;"
 S DIR("A",1)="Select an appointment status for the report"
 S DIR("A",2)=" "
 S DIR("A",3)="  1 - Seen in clinic"
 S DIR("A",4)="  0 - Not seen in clinic"
 S DIR("A",5)=" "
 S DIR("A")="Select APPOINTMENT STATUS: "
 S DIR("B")=1
 W ! D ^DIR S GMAPPT=+$G(Y)
 I $$DIREXIT>0 G EXIT
 ;
 K DIR
 S DIR(0)="SOA^1:Has a note;0:Does not have a note;"
 S DIR("A",1)="Select a note status for the report"
 S DIR("A",2)=" "
 S DIR("A",3)="  1 - Has a note"
 S DIR("A",4)="  0 - Does not have a note"
 S DIR("A",5)=" "
 S DIR("A")="Select NOTE STATUS: "
 S DIR("B")=1
 W ! D ^DIR S GMNOTE=+$G(Y)
 I $$DIREXIT>0 G EXIT
 ;
 S GMOPUT=0,GMXLAT=""
 I GMNOTE>0 D  G:$$DIREXIT>0 EXIT
 . K DIR
 . S DIR(0)="YAO"
 . S DIR("A")="Interactive consult update: "
 . S DIR("B")="Yes"
 . W ! D ^DIR S GMOPUT=+$G(Y)
 . S GMXLAT="1^I"
 . I GMOPUT>0 I $$TEST^DDBRT'>0 D
 .. K GMTEXT
 .. S GMTEXT(1)="*** The VA FileMan browser is not supported by your terminal type  ***"
 .. S GMTEXT(2)="*** You cannot use the interactive consult update on this terminal ***"
 .. S GMTEXT="*** You may print the consult report and/or update the CPRS team   ***"
 .. D HANGMSG^GMRCCD(.GMTEXT,3,1)
 .. S GMOPUT=0,GMXLAT=""
 .. Q
 . Q
 ;
 I GMOPUT'>0 D  G:$$DIREXIT>0 EXIT
 . S GMTEAM=$$ISTM^GMRCCD(GM0CFG)
 . K DIR
 . S DIR(0)="LOA^1:1:0"
 . S DIR("A")="Select OUTPUT TYPE: "
 . S DIR("A",1)="Select the output type for the report"
 . S DIR("A",2)=" "
 . S DIR("A",3)="  1 - Print report"
 . S DIR("B")="1"
 . S GMXLAT="1^P"
 . I GMTEAM>0 D
 .. S DIR(0)="LOA^1:2:0"
 .. S DIR("A",4)="  2 - Team update"
 .. S DIR("B")="1,2"
 .. S GMXLAT="12^PT"
 .. Q
 . I (GMAUTO>0)&(GMNOTE>0) D
 .. S DIR(0)="LOA^1:2:0"
 .. S DIR("A",4)="  2 - Consult update"
 .. S DIR("B")="1,2"
 .. S GMXLAT="12^PC"
 .. Q
 . I (GMAUTO>0)&(GMTEAM>0)&(GMNOTE>0) D
 .. S DIR(0)="LOA^1:3:0"
 .. S DIR("A",4)="  2 - Team update"
 .. S DIR("A",5)="  3 - Consult update"
 .. S DIR("B")="1-3"
 .. S GMXLAT="123^PTC"
 .. Q
 . S DIR("A",1+$O(DIR("A",1E25),-1))=" "
 . W ! D ^DIR S GMOPUT=$G(Y)
 . Q
 S GMOPUT=$$TRIM^XLFSTR(GMOPUT,"LR",",")
 S GMOPUT=$TR(GMOPUT,$P(GMXLAT,U,1),$P(GMXLAT,U,2))
 ;
 I GMOPUT["P" D  G:$$DIREXIT>0 EXIT
 . K DIR
 . S DIR(0)="YOA"
 . S DIR("A")="Delimited output: "
 . S DIR("B")="No"
 . W ! D ^DIR S GMDLIM=+$G(Y)
 . Q
 E  D
 . S GMDLIM=0
 . Q
 ;
 W !
 S ZTRTN="TASK^GMRCCA("_GMTBEG_","_GMTEND_","
 S ZTRTN=ZTRTN_GM0CFG_","_GMAPPT_","_GMNOTE_","""
 S ZTRTN=ZTRTN_GMOPUT_""","_GMDLIM_")"
 S ZTDESC="Consult Closure Tool"
 I GMOPUT["P" D
 . W !,"This report requires a 132 column output device"
 . D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"MQ",1)
 . Q
 E  D
 . I GMOPUT["I" D
 .. W !,"Searching for patient consults / appointments / notes",!
 .. D WAIT^DICD
 .. D @ZTRTN
 .. Q
 . E  D
 .. S ZTIO=""
 .. D ^%ZTLOAD
 .. Q
 . Q
 I $G(ZTSK)>0 W !,"Task #",ZTSK
 ;
EXIT ;
 ; *** Common exit point
 Q
 ;
TASK(GMTBEG,GMTEND,GM0CFG,GMAPPT,GMNOTE,GMOPUT,GMDLIM) ;
 ; *** TaskMan entry point
 N GMROOT
 S GMROOT=$NA(^TMP($T(+0),$J))
 K @GMROOT
 D GETDATA^GMRCCB(GMROOT,GMTBEG,GMTEND,GM0CFG,GMAPPT,GMNOTE,GMOPUT,GMDLIM)
 I GMOPUT["C" D
 . D CONSUPDT^GMRCCC(GMROOT)
 . Q
 I GMOPUT["T" D
 . D MAKETEAM^GMRCCC(GMROOT,GM0CFG)
 . Q
 I GMOPUT["P" D
 . D PRNTDATA^GMRCCC(GMROOT,GMTBEG,GMTEND,GM0CFG,GMAPPT,GMNOTE,GMDLIM)
 . Q
 I GMOPUT["I" D
 . D INTERACT^GMRCCD(GMROOT)
 . Q
 K @GMROOT
 Q
 ;
CHKCFG(GM0CFG,GMINAC) ;
 ; *** Screen for valid consult configuration
 ; GMDATA("XXX")=1 says XXX field is not populated
 N GMDATA,GMOKAY
 S GMOKAY=1
 I (GMINAC>0)&($$GET1^DIQ(123.033,GM0CFG,.02,"I")>0) S GMOKAY=0
 I $$GET1^DIQ(123.033,GM0CFG,.04)'>0 S GMOKAY=0
 I $$GET1^DIQ(123.033,GM0CFG,.05)'>0 S GMOKAY=0
 S GMDATA("STOP")=($$GET1^DIQ(123.033,GM0CFG,.06,"I")'>0)
 F GMDATA="CLIN","CLPR","CONP","CONS","NOTE","PROT" D
 . S GMDATA(GMDATA)=($O(^GMR(123.033,GM0CFG,GMDATA,0))'>0)
 . Q
 I (GMDATA("CLPR"))&(GMDATA("CONP"))&(GMDATA("CONS"))&(GMDATA("PROT")) S GMOKAY=0
 I (GMDATA("CLIN"))&(GMDATA("STOP")) S GMOKAY=0
 I GMDATA("NOTE") S GMOKAY=0
 Q GMOKAY
 ;
DIREXIT() ;
 ; *** DIR exit status
 Q $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT)
 ;
POSTSAVE(GM0CFG) ;
 ; *** Post-save code for config editor
 N GMTEXT
 I $$CHKCFG(+GM0CFG,0)'>0 D
 . S GMTEXT(1)="* * * The consult configuration is incomplete, required data is missing. * * *"
 . S GMTEXT(2)="* * * You must enter a Config Name, Days Cons->Appt, Days Appt->Note,    * * *"
 . S GMTEXT(3)="* * * at least one type of Consult (Service, Procedure, etc.), at least  * * *"
 . S GMTEXT(4)="* * * one Clinic and/or a Stop Code, and at least one Note Title.        * * *"
 . S GMTEXT(5)="$$EOP"
 . D HLP^DDSUTL(.GMTEXT)
 . Q
 Q
