PSODEAME ;ALB/BI - DEA MANUAL ENTRY ;05/15/2018
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 ;External reference to sub-file NEW DEA #S (#200.5321) is supported by DBIA 7000
 Q
 ;
EN(DEATXT,PSOWSDWN) ; -- main entry point for PSO DEA NUMBER MANAGEMENT
 N CN,FG,RESPONSE,SC,FG,GETS,DNDEAIEN,POP,VALMBCK,VALMCNT,VALMSG,DTRESULT
 N ASTRSK S $P(ASTRSK,"*",75)="*"
 D CONVNAME^PSODEAUT(.CN)
 S DNDEAIEN=$O(^XTV(8991.9,"B",DEATXT,0))
 S RESPONSE=0
 I '$G(PSOWSDWN) S SC=$$WSGET^PSODEAUT(.FG,DEATXT)
 I $P($G(SC),U,3)=6059 S PSOWSDWN=1
 I $G(PSOWSDWN) S RESPONSE=0 D  Q RESPONSE
 .S SC="0^Unable to Connect to Server^6059"
 .S RESPONSE=SC
 .S DNDEAIEN=$O(^XTV(8991.9,"B",DEATXT,0))
 .N DIR S DIR("A",1)="  "_$E(ASTRSK,1,60)
 .S DIR("A",2)="     Unable to Connect to PSO DOJ/DEA Web Service"
 .S DIR("A",3)="  "_$E(ASTRSK,1,60),DIR("A",4)=" "
 .S DIR("A",5)="   If you continue, the DEA information entered "
 .S DIR("A",6)="   will not be checked against DOJ DEA source data."
 .S DIR(0)="Y",DIR("A")="Continue without Web Service",DIR("B")="NO" D ^DIR
 .Q:'Y
 .W !,"DEA NUMBER: "_$G(DEATXT)
 .D MANLOAD(DUZ,DEATXT,.GETS,.FG)
 .D ACTIONE,ACTIONA
 .S DNDEAIEN=$O(^XTV(8991.9,"B",DEATXT,0)) S:DNDEAIEN RESPONSE=DNDEAIEN
 I 'SC S RESPONSE=SC W !!,"  ***"_$P(RESPONSE,U,2)_"***" G ENX
 I $G(FG("type"))="INSTITUTIONAL" D
 .; PREFINST = flag to indicate an automatic update of INSTITUTIONAL DEA in File 8991.9
 .S DNDEAIEN=$O(^XTV(8991.9,"B",DEATXT,0)) Q:'DNDEAIEN  ; Only auto-update previously filed institutional DEA's
 .N PREFINST S PREFINST=1
 .D DEACOPY(.FG)
 .D ACTIONA
 .D LSCHED(.GETS) ; Get Local Schedules if Institutional DEA
 D EN^VALM("PSO DEA NUMBER MANAGEMENT")
ENX  ; -- Cleanup and Exit
 S DNDEAIEN=$O(^XTV(8991.9,"B",DEATXT,0)) S:DNDEAIEN RESPONSE=DNDEAIEN
 Q RESPONSE
 ;
HDR ; -- header code
 ;S VALMHDR(1)="Asterisks ""**"" next to fields in the DOJ column indicate the local value"
 ;S VALMHDR(2)="value has been changed and no longer matches the value in the DOJ file"
 S VALMHDR(1)="The asterisks ""**"" next to fields in the DOJ column indicate that the local"
 S VALMHDR(2)="value has been changed and does not match the value stored in the DOJ file."
 S VALMHDR(3)=""
 Q
 ;
INIT ; -- Build the List Array
 D INIT^PSODEAED
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 W !,"Asterisks ""**"" indicate the DOJ value does not match the local VistA value",!
 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 Q
 ;
EXPND ; -- expand code
 Q
 ;
ACTIONA  ; -- Perform Action A: ACCEPT AND SAVE CHANGES
 N FDA      ; FileMan Data Array used to insert data into file #8991.9
 N DNDEAIEN ; The IEN for the entry in the DEA NUMBERS FILE #8991.9
 N IENROOT  ; Variable for the IEN being returned from the ^DIE call.
 N IENS     ; ENTRY IEN VALUE
 N MSGROOT  ; Message Root for the error messages from the ^DIE call.
 I '$D(GETS) S VALMSG="NOTHING TO SAVE",VALMBCK="R" Q
 I '$$FIND1^DIC(8991.8,,,GETS(.02)) D
 .Q:$D(^XTV(8991.8,"B",GETS(.02)))  ; Don't file duplicate BAC
 .N FDA,BACERR S FDA(8991.8,"+1,",.01)=GETS(.02)
 .S FDA(8991.8,"+1,",.02)=$E(GETS(.02))
 .S FDA(8991.8,"+1,",.03)=$E(GETS(.02),2,4)
 .D UPDATE^DIE("E","FDA",,"BACERR")
 S:$G(GETS(.01))'="" DNDEAIEN=$O(^XTV(8991.9,"B",GETS(.01),0))
 S IENS=$S($G(DNDEAIEN):$G(DNDEAIEN)_",",1:"+1,")
 ; Pre-file INSTITUTIONAL DEA without ListMan
 ; File INDIVIDUAL DEA when service is down without ListMan 
 I '$G(PREFINST)&'$G(PSOWSDWN) D FULL^VALM1,CLEAN^VALM10
 S FDA(1,8991.9,IENS,1.1)=GETS(1.1)   ; NAME
 S FDA(1,8991.9,IENS,1.2)=GETS(1.2)   ; ADDRESS 1
 S FDA(1,8991.9,IENS,1.3)=GETS(1.3)   ; ADDRESS 2
 S FDA(1,8991.9,IENS,1.4)=GETS(1.4)   ; ADDRESS 3
 S FDA(1,8991.9,IENS,1.5)=GETS(1.5)   ; CITY
 S FDA(1,8991.9,IENS,1.6)=GETS(1.6)   ; STATE
 S FDA(1,8991.9,IENS,1.7)=GETS(1.7)   ; ZIP CODE
 S FDA(1,8991.9,IENS,.02)=GETS(.02)   ; BUSINESS ACTIVITY CODE AND SUBCODE
 S FDA(1,8991.9,IENS,.07)=GETS(.07)   ; TYPE
 S FDA(1,8991.9,IENS,.01)=GETS(.01)   ; DEA NUMBER
 I GETS(.03)'="" D CLEARDTX(NPIEN)    ; REMOVE DETOX NUMBERS FROM OTHER DEA NUMBERS
 S FDA(1,8991.9,IENS,.03)=GETS(.03)   ; DETOX NUMBER
 S FDA(1,8991.9,IENS,.04)=GETS(.04)   ; EXPIRATION DATE
 S FDA(1,8991.9,IENS,2.1)=GETS(2.1)   ; SCHEDULE II NARCOTIC
 S FDA(1,8991.9,IENS,2.2)=GETS(2.2)   ; SCHEDULE II NON-NARCOTIC
 S FDA(1,8991.9,IENS,2.3)=GETS(2.3)   ; SCHEDULE III NARCOTIC
 S FDA(1,8991.9,IENS,2.4)=GETS(2.4)   ; SCHEDULE III NON-NARCOTIC
 S FDA(1,8991.9,IENS,2.5)=GETS(2.5)   ; SCHEDULE IV
 S FDA(1,8991.9,IENS,2.6)=GETS(2.6)   ; SCHEDULE V
 S FDA(1,8991.9,IENS,10.2)="N"        ; LAST UPDATED DATE/TIME
 S FDA(1,8991.9,IENS,10.3)=GETS(10.3) ; LAST DOJ UPDATE
 D UPDATE^DIE("E","FDA(1)","IENROOT","MSGROOT")
 I $D(MSGROOT) D ACTIONAM G ACTIONAX
 S DNDEAIEN=$S($D(IENROOT(1)):IENROOT(1),1:IENS)
 S FDA(2,8991.9,DNDEAIEN,10.1)=DUZ D FILE^DIE("","FDA(2)","MSGROOT")
 I $G(GETS(.07))="INSTITUTIONAL" D
 .Q:'$D(GETS(55.1))
 .Q:$G(PREFINST)
 .K FDA
 .S FDA(1,200,NPIEN_",",55.1)=GETS(55.1)
 .S FDA(1,200,NPIEN_",",55.2)=GETS(55.2)
 .S FDA(1,200,NPIEN_",",55.3)=GETS(55.3)
 .S FDA(1,200,NPIEN_",",55.4)=GETS(55.4)
 .S FDA(1,200,NPIEN_",",55.5)=GETS(55.5)
 .S FDA(1,200,NPIEN_",",55.6)=GETS(55.6)
 .D UPDATE^DIE("E","FDA(1)","NPIEN","MSGROOT")
 ;
 K FDA S FDA(8991.9,IENS,10.3)=$S($G(PSOWSDWN):"",1:$$DT^XLFDT)
 N IENROOT,MSGROOT
 D UPDATE^DIE("","FDA","IENROOT","MSGROOT")
 ;
ACTIONAX  ; -- Return here to end cleanly.
 S VALMBCK="Q"
 Q
 ;
ACTIONAM  ; -- Provide filing error messge and pause.
 N DIR
 W !!,"*** The information could not be filed ***",!
 W:$D(MSGROOT("DIERR",1,"TEXT",1)) MSGROOT("DIERR",1,"TEXT",1),!
 S DIR(0)="E" D ^DIR  W !
 Q
 ;
ACTIONC  ; -- Perform Action C: COPY DOJ/DEA VALUES TO VISTA
 N SC
 D DEACOPY(.FG)
 D CLEAN^VALM10
 D INIT
 S VALMBCK="R"
 Q
 ;
ACTIONE  ; -- Perform Action E: EDIT VISTA VALUES
 N DIRUT,DIR,X,Y,PSPROCDT
 I '$D(GETS) S VALMSG="NOTHING TO EDIT",VALMBCK="R" Q
 I '$G(PSOWSDWN) D FULL^VALM1,CLEAN^VALM10
 ;
 I $D(FG("processedDate")) D DT^DILF("E",FG("processedDate"),.DTRESULT)
 I '$D(FG("processedDate")) D DT^DILF("E",DT,.DTRESULT)
 S GETS(10.3)=$G(DTRESULT(0))   ; Automatically update DOJ processed date (is now)
 ;
 ; DETOX
 N CDETOX,NDETOX,GETS03,DTXDEAX
 S DTXDEAX=""
 D:GETS(.07)="INDIVIDUAL"
 . S GETS03=GETS(.03)
 . S CDETOX=$$GETDNDTX^PSODEAUT(NPIEN,.DTXDEAX)
 . K DTOUT,DUOUT,DIR S DIR(0)="FO^9:9^K:'$$DEANUM^PSODEAUT(X)!$$DTXDUPIT^PSODEAU0(GETS(.01),$G(X),NPIEN) X",DIR("A")="DETOX",DIR("B")=GETS(.03)
 . S DIR("?")="^D DTXHLP^PSODEAME"
 . ; S DIR("?")="Response must contain 2 letters and 7 numbers. The numeric portion must satisfy the DEA number checksum rules."
 . D ^DIR
 . Q:$D(DTOUT)!($D(DUOUT))
 . S NDETOX=Y
 . I X="@" S GETS(.03)=$$UP^XLFSTR(NDETOX) Q
 . I CDETOX="" S GETS(.03)=$$UP^XLFSTR(NDETOX) Q
 . I CDETOX'=""&(NDETOX'="")&(CDETOX'=NDETOX) D
 .. K DTOUT,DUOUT,DIR S DIR(0)="Y"
 .. S DIR("A",1)="DETOX NUMBER: "_CDETOX_" already exists on DEA NUMBER: "_$G(DTXDEAX)
 .. S DIR("A",2)="for this provider. Only one DEA number can contain a DETOX number."
 .. S DIR("A",3)="Do you want to replace the existing DETOX number?"
 .. S DIR("A")="Enter Yes or No:"
 .. D ^DIR I '($D(DTOUT)!($D(DUOUT))) D
 ... I 'Y S GETS(.03)=$$UP^XLFSTR(GETS03)
 ... I Y S GETS(.03)=$$UP^XLFSTR(NDETOX)
 G:$D(DTOUT)!($D(DUOUT)) ACTIONEX
 K DTOUT,DUOUT
 ;
 ; Don't allow editing of DEA Expiration Date or Schedules if any of the following are true:
 ;   PROVIDER TYPE         NOT=  'FEE BASIS' or 'C&A'
 ;           -OR-
 ; NON-VA PRESCRIBER       NOT=  'YES'
 ;           -OR-
 ; PHARMACY OPERATING MODE NOT=  'VAMC'
 ;
 ; Don't allow editing of DEA Expiration Date for Institutional DEA #'S
 ;
 N PSOEDCHK S PSOEDCHK=$$EDITCHK^PSOPRVW(+$G(NPIEN))
 I 'PSOEDCHK S DEAEDQ=1 D  Q
 . N ASTER S $P(ASTER,"*",70)="*"
 . W !!?6,$E(ASTER,1,45)
 . W !?6,"*    This provider's DEA Expiration Date    *"
 . W !?6,"*    and DEA Schedules are not editable     *"
 . W !?6,$E(ASTER,1,45)
 . W !! K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR W !
 ;
 ; Set NDROOT to "2" (file 8991.9 schedule fields root) if INDIVIDUAL DEA
 ; Set NDROOT to "55" (file 200 schedule fields root) if INSTITUTIONAL DEA
 ;
 N NDROOT S NDROOT=$S($G(GETS(.07))="INSTITUTIONAL":55,1:2)
 I '$D(GETS(55.1)),$G(GETS(.07))="INSTITUTIONAL" D LSCHED(.GETS) ; Get Local Schedules if Institutional DEA
 ;
 ; EXPIRATION DATE
 I GETS(.07)="INDIVIDUAL" D  G:$D(DTOUT)!($D(DUOUT)) ACTIONEX
 . K DTOUT,DUOUT,DIR N DTRESULT
 . S DIR(0)="DO",DIR("A")="EXPIRATION DATE" S DIR("B")=GETS(.04) D ^DIR
 . Q:($D(DTOUT)!$D(DUOUT))  D DT^DILF("E",$G(Y),.DTRESULT)
 . S GETS(.04)=$G(DTRESULT(0))
 . W "   ",GETS(.04)
 ;
 ; SCHEDULE II NARCOTIC
 K DTOUT,DUOUT,DIR S DIR(0)="Y",DIR("A")="SCHEDULE II NARCOTIC",DIR("B")=$S(GETS(NDROOT_".1")="YES":"YES",1:"NO") D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) ACTIONEX S GETS(NDROOT_".1")=$S(Y=1:"YES",1:"NO")
 ;
 ; SCHEDULE II NON-NARCOTIC
 K DTOUT,DUOUT,DIR S DIR(0)="Y",DIR("A")="SCHEDULE II NON-NARCOTIC",DIR("B")=$S(GETS(NDROOT_".2")="YES":"YES",1:"NO") D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) ACTIONEX S GETS(NDROOT_".2")=$S(Y=1:"YES",1:"NO")
 ;
 ; SCHEDULE III NARCOTIC
 K DTOUT,DUOUT,DIR S DIR(0)="Y",DIR("A")="SCHEDULE III NARCOTIC",DIR("B")=$S(GETS(NDROOT_".3")="YES":"YES",1:"NO") D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) ACTIONEX S GETS(NDROOT_".3")=$S(Y=1:"YES",1:"NO")
 ;
 ; SCHEDULE III NON-NARCOTIC
 K DTOUT,DUOUT,DIR S DIR(0)="Y",DIR("A")="SCHEDULE III NON-NARCOTIC",DIR("B")=$S(GETS(NDROOT_".4")="YES":"YES",1:"NO") D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) ACTIONEX S GETS(NDROOT_".4")=$S(Y=1:"YES",1:"NO")
 ;
 ; SCHEDULE IV
 K DTOUT,DUOUT,DIR S DIR(0)="Y",DIR("A")="SCHEDULE IV",DIR("B")=$S(GETS(NDROOT_".5")="YES":"YES",1:"NO") D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) ACTIONEX S GETS(NDROOT_".5")=$S(Y=1:"YES",1:"NO")
 ;
 ; SCHEDULE V
 K DTOUT,DUOUT,DIR S DIR(0)="Y",DIR("A")="SCHEDULE V",DIR("B")=$S(GETS(NDROOT_".6")="YES":"YES",1:"NO") D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) ACTIONEX S GETS(NDROOT_".6")=$S(Y=1:"YES",1:"NO")
 ;
ACTIONEX  ; -- ACTIONE Clean Exit Point
 K DIRUT,DIR
 Q:$G(PSOWSDWN)
 D INIT
 S VALMBCK="R"
 Q
 ;
ACTIONX  ; -- Perform Action X: QUIT AND REJECT CHANGES
 D FULL^VALM1
 D CLEAN^VALM10
 S VALMBCK="Q"
 Q
 ;
DEACOPY(FG) ; -- Private Subroutine to Copy import data in the GETS Array
 ; POSTAL^XIPUTL used in agreement with Integration Agreement: 3618
 ;
 ; INPUT:  FG       ;Web Service Response Global
 ;
 ; VARIABLES:
 N DS       ;Single drug schedule field as sent from the VA DOJ Web Service.
 N XIP      ;Used to calculate the state from a zip code.
 N XSTATE   ;Used to calculate the state from a zip code.
 N BAC      ;Business Activity Code
 N I
 ;
 S DS=$G(FG("drugSchedule"))
 S GETS(.01)=$G(FG("deaNumber"))
 S BAC=$G(FG("businessActivityCode"))_$G(FG("businessActivitySubcode"))
 S GETS(.02)=BAC ; Pointer to file #8991.8
 S GETS(.03)=$S($$GETDNDTX^PSODEAUT(NPIEN)'="":"",$$DETOXCHK^PSODEAUT(BAC):"X"_$E($G(FG("deaNumber")),2,9),1:"")  ; DETOX NUMBER
 D DT^DILF("E",$G(FG("expirationDate")),.DTRESULT)
 S GETS(.04)=$G(DTRESULT(0))
 S GETS(.07)=$G(FG("type"))
 S GETS(1.1)=$G(FG("name"))
 S GETS(1.2)=$G(FG("additionalCompanyInfo"))
 S GETS(1.3)=$G(FG("address1"))
 S GETS(1.4)=$G(FG("address2"))
 S GETS(1.5)=$G(FG("city"))
 ;
 ; Special State Processing
 S GETS(1.6)=$G(FG("state"))
 D POSTAL^XIPUTIL($G(FG("zipCode")),.XIP)
 S XSTATE=$G(XIP("STATE"))
 I XSTATE'="" S GETS(1.6)=XSTATE ; Pointer to the State File #5.
 ;
 S GETS(1.7)=$G(FG("zipCode"))
 ;
 S GETS(2.1)=$S(DS["22N":"YES",(DS["2"&(DS'["2N")):"YES",1:"NO") ; SCHEDULE II NARCOTIC
 S GETS(2.2)=$S(DS["2N":"YES",1:"NO") ; SCHEDULE II NON-NARCOTIC
 S GETS(2.3)=$S(DS["33N":"YES",(DS["3"&(DS'["3N")):"YES",1:"NO") ; SCHEDULE III NARCOTIC
 S GETS(2.4)=$S(DS["3N":"YES",1:"NO") ; SCHEDULE III NON-NARCOTIC
 S GETS(2.5)=$S(DS["4":"YES",1:"NO") ; SCHEDULE IV
 S GETS(2.6)=$S(DS["5":"YES",1:"NO") ; SCHEDULE V
 ;
 I $G(GETS(.07))="INSTITUTIONAL" F I=2.1:.1:2.6 S GETS(55_"."_$P(I,".",2))=GETS(I)
 ;
 D DT^DILF("E",$G(DT),.DTRESULT)
 S GETS(10.2)=$G(DTRESULT(0))  ; LAST UPDATED DATE/TIME
 ;D DT^DILF("E",$G(FG("processedDate")),.DTRESULT)
 S GETS(10.3)=$G(DTRESULT(0))  ; LAST DOJ UPDATE DATE/TIME
 S GETS(10.1)=DUZ
 Q
 ;
CLEARDTX(NPIEN)  ; REMOVE DETOX NUMBERS FROM ALL OF A PROVIDERS DEA NUMBERS
 N DNDEAIEN,FDA,NPDEAIEN
 S NPDEAIEN=0 F  S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'NPDEAIEN  D
 . S DNDEAIEN=$$GET1^DIQ(200.5321,NPDEAIEN_","_NPIEN_",",.03,"I")
 . K FDA S FDA(1,8991.9,DNDEAIEN_",",.03)="@" D UPDATE^DIE("","FDA(1)") K FDA
 Q
 ;
DTXHLP ; Detox Number Help Text
 N CDETOX,DTXDEAX
 I $G(NPIEN) S CDETOX=$$GETDNDTX^PSODEAUT(NPIEN,.DTXDEAX)
 I $G(Y)'="",($G(CDETOX)'="") I Y=CDETOX D  Q
 .I $G(DEATXT)'=$G(DTXDEAX) D  Q
 .. W !,"The entered DETOX NUMBER already exists on DEA NUMBER: "_DTXDEAX
 .. W !,"for this provider."
 W !,"Response must contain 2 letters and 7 numbers. The numeric portion must satisfy the DEA number checksum rules."
 Q
 ;
LSCHED(GETS) ; Get local provider schedules from NEW PERSON and add to GETS(55.1-55.6)
 Q:$G(GETS(.07))'="INSTITUTIONAL"
 Q:'$G(NPIEN)
 N LOCSCH,LOCSCH2,I
 D GETS^DIQ(200,NPIEN,"55.1;55.2;55.3;55.4;55.5;55.6","I","LOCSCH")
 M LOCSCH2=LOCSCH(200,NPIEN_",")
 F I=55.1,55.2,55.3,55.4,55.5,55.6 S GETS(I)=$S($G(LOCSCH2(I,"I")):"YES",1:"NO")
 Q
 ;
MANLOAD(DUZ,DEA,GETS,FG) ; Manually load default values when web service is down
 ; Load GETS()
 N DNDEAIEN
 S DNDEAIEN=$O(^XTV(8991.9,"B",DEA,0))
 I $G(DNDEAIEN) D GETS^PSODEAUT(DNDEAIEN,.GETS) D  Q
 .I $G(NPIEN),($G(GETS(.07))="INSTITUTIONAL") D LSCHED^PSODEAME(.GETS) ; Get Local Schedules if Institutional DEA
 ;
 ; New DEA entered without PSO DOJ/DEA WEB SERVICE connection. Default BAC? and TYPE. 
 S GETS(.01)=DEA
 S GETS(.02)="C0"
 S GETS(.03)=""
 S GETS(.04)=""
 S GETS(.07)="INDIVIDUAL"
 S GETS(1.1)=$$GET1^DIQ(200,NPIEN,.01,"E")
 S GETS(1.2)=""
 S GETS(1.3)=""
 S GETS(1.4)=""
 S GETS(1.5)=""
 S GETS(1.6)=""
 S GETS(1.7)=""
 S GETS(2.1)=""
 S GETS(2.2)=""
 S GETS(2.3)=""
 S GETS(2.4)=""
 S GETS(2.5)=""
 S GETS(2.6)=""
 S GETS(10.1)=DUZ
 S GETS(10.2)=""
 S GETS(10.3)=""
 ;
 ; Load FG()
 S FG("drugSchedule")=""
 S FG("deaNumber")=DEA
 S FG("businessActivityCode")="C"
 S FG("businessActivitySubcode")=0
 S FG("expirationDate")=""
 S FG("type")="INDIVIDUAL"
 S FG("name")=GETS(1.1)
 S FG("address1")=""
 S FG("address2")=""
 S FG("address3")=""
 S FG("city")=""
 S FG("state")=""
 S FG("zipCode")=""
 S FG("processedDate")=""
 Q
