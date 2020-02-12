SDECAR2 ;ALB/SAT/JSM - VISTA SCHEDULING RPCS ;10:57 AM  3 Jul 2017
 ;;5.3;Scheduling;**627,642,658,671,686**;Aug 13, 1993;Build 53
 ;
 Q
 ;
ARSET(RET,INP) ;Appointment Request Set
 ;ARSET(RET,INP...)  external parameter tag in SDEC
 ;  INP(1)  = (integer)  Wait List IEN point to
 ;                       SDEC APPT REQUEST file 409.85.
 ;                       If null, a new entry will be added
 ;  INP(2)  = (text)     DFN Pointer to the PATIENT file 2
 ;  INP(3)  = (date)     Originating Date/time in external date form
 ;  INP(4)  = (text)     Institution name NAME field from the INSTITUTION file
 ;  INP(5)  = (text)     Request Type
 ;  INP(6)  = (text)     REQ Specific Clinic name - NAME field in file 44
 ;  INP(7)  = (text)     Originating User name  - NAME field in NEW PERSON file 200
 ;  INP(8)  = (text)     Priority - 'ASAP' or 'FUTURE'
 ;  INP(9)  = (text)     Request By - 'PROVIDER' or 'PATIENT'
 ;  INP(10) = (text)     Provider name  - NAME field in NEW PERSON file200
 ;  INP(11) = (date)     Desired Date of appointment in external format.
 ;  INP(12) = (text)     comment must be 1-60 characters
 ;  INP(13) = (text)     ENROLLMENT PRIORITY - Valid Values are:
 ;                                             GROUP 1
 ;                                             GROUP 2
 ;                                             GROUP 3
 ;                                             GROUP 4
 ;                                             GROUP 5
 ;                                             GROUP 6
 ;                                             GROUP 7
 ;                                             GROUP 8
 ;  INP(14) = (text)     MULTIPLE APPOINTMENT RTC      NO; YES
 ;  INP(15) = (integer)  MULT APPT RTC INTERVAL integer between 1-365
 ;  INP(16) = (integer)  MULT APPT NUMBER integer between 1-100
 ;  INP(17) = Patient Contacts separated by ::
 ;            Each :: piece has the following ~~ pieces:
 ;            1) = (date)    DATE ENTERED external date/time
 ;            2) = (text)    PC ENTERED BY USER ID or NAME - Pointer toNEW PERSON file or NAME
 ;            4) = (optional) ACTION - valid values are:
 ;                             CALLED
 ;                             MESSAGE LEFT
 ;                             LETTER
 ;            5) = (optional) PATIENT PHONE Free-Text 4-20 characters
 ;            6) = NOT USED (optional) Comment 1-160 characters
 ;  INP(18) = (optional) SERVICE CONNECTED PRIORITY valid values are NO YES
 ;  INP(19) = (optional) SERVICE CONNECTED PERCENTAGE = numeric 0-100
 ;  INP(20) = (optional) MRTC calculated preferred dates separated by pipe |:
 ;                       Each date can be in external format with no time.
 ;  INP(21) = (optional) CLINIC STOP pointer to CLINIC STOP file 40.7
 ;                       used to populate the REQ SERVICE/SPECIALTY field in 409.85
 ;  INP(22) = (optional) Appointment Type ID pointer to APPOINTMENT TYPE file 409.1
 ;  INP(23) = (optional) Patient Status
 ;                          N = NEW
 ;                          E = ESTABLISHED
 ;  INP(24) = (optional) MULT APPTS MADE
 ;                    list of child pointers to SDEC APPOINTMENT and/orSDEC APPT REQUEST files separated by pipe
 ;                    each pipe piece contains the following ~ pieces:
 ;                1. Appointment Id pointer to SDEC APPOINTMENT file 409.84
 ;                2. Request Id pointer to SDEC APPT REQUEST file 409.85
 ;  INP(25) = (optional) PARENT REQUEST pointer to SDEC APPT REQUEST file 409.85
 ;  INP(26) = (optional) NLT (No later than) [CPRS RTC REQUIREMENT]
 ;  INP(27) = (optional) PREREQ (Prerequisites) [CPRS RTC REQUIREMENT]
 ;  INP(28) = (optional) ORDER IEN [CPRS RTC REQUIREMENT]
 ;  INP(29) = (optional) VAOS GUID  <== wtc patch 686 3/21/18 added for VAOS requests
 N X,Y,%DT
 N DFN,MI,ARAPTYP,ARIEN,ARORIGDT,ARORIGDTI,ARINST,ARINSTI,ARTYPE,ARTEAM,ARPOS,ARSRVSP,ARCLIN
 N ARUSER,ARPRIO,ARREQBY,ARPROV,ARDAPTDT,ARCOMM,AREESTAT,AREDT,ARQUIT
 N FNUM,FDA,ARNEW,ARRET,ARMSG,ARDATA,ARERR,ARHOSN,AUDF,SDREC
 N ARMAI,ARMAN,ARMAR,ARPARENT,ARPATTEL,ARENPRI,ARSTOP,ARSVCCON,ARSVCCOP
 N VAOSGUID ; wtc patch 686 3/21/18 added for VAOS requests
 S (ARQUIT,AUDF)=0
 S FNUM=$$FNUM^SDECAR
 S RET="I00020ERRORID^T00030ERRORTEXT"_$C(30)
 ; Use MERGE instead of SET so we can know if values were actually specified or not.
 ; This way, if a value is null, we will delete any previous value,
 ; but if it is missing, then we will just ignore it.
 M ARIEN=INP(1)
 S DFN=$G(INP(2))
 I '+DFN S RET=RET_"-1^Invalid Patient ID."_$C(30,31) Q
 I '$D(^DPT(DFN,0)) S RET=RET_"-1^Invalid Patient ID"_$C(30,31) Q
 S AREDT=$P($G(INP(3)),":",1,2)
 S %DT="TX" S X=AREDT D ^%DT S AREDT=Y
 I Y=-1 S RET=RET_"-1^Invalid Origination date."_$C(30,31) Q
 S ARORIGDT=$P(AREDT,".",1)
 S ARINST=$G(INP(4)) I ARINST'="" D
 .I '+ARINST S ARINST=$O(^DIC(4,"B",ARINST,0))
 M ARTYPE=INP(5)
 S ARCLIN=$G(INP(6))
 I ARCLIN'="" D
 .I +ARCLIN=ARCLIN D
 ..I '$D(^SC(+ARCLIN,0)) S RET=RET_"-1^"_ARCLIN_" is an invalid Clinic ID."_$C(30,31) S ARQUIT=1 Q
 ..;S ARCLIN=$$GET1^DIQ(44,ARCLIN_",",.01)
 .I '(+ARCLIN=ARCLIN) D
 ..S ARCLIN=$O(^SC("B",ARCLIN,0))
 ..I ARCLIN="" S RET=RET_"-1^"_ARCLIN_" is an invalid Clinic Name."_$C(30,31) S ARQUIT=1 Q
 Q:ARQUIT=1
 S ARUSER=$G(INP(7))
 I ARUSER'="" I '+ARUSER S ARUSER=$O(^VA(200,"B",ARUSER,0))
 I ARUSER="" S ARUSER=DUZ
 S ARREQBY=$G(INP(9)) I ARREQBY'="" D
 .S ARREQBY=$S(ARREQBY="PATIENT":2,ARREQBY="PROVIDER":1,1:"")
 S ARPROV=$G(INP(10)) I ARPROV'="" I '+ARPROV S ARPROV=$O(^VA(200,"B",ARPROV,0))
 S ARDAPTDT=INP(11)
 S %DT="" S X=$P($G(ARDAPTDT),"@",1) D ^%DT S ARPRIO=$S(Y=$P($$NOW^XLFDT,".",1):"A",1:"F")
 S ARDAPTDT=Y
 I Y=-1 S ARDAPTDT=""   ;S RET=RET_"-1^Invalid Desired Date."_$C(30,31)Q
 S (INP(12),ARCOMM)=$TR($G(INP(12)),"^"," ")   ;alb/sat 658
 S ARENPRI=$G(INP(13)) D
 .S:ARENPRI'="" ARENPRI=$S(ARENPRI="GROUP 1":1,ARENPRI="GROUP 2":2,ARENPRI="GROUP3":3,ARENPRI="GROUP4":4,ARENPRI="GROUP 5":5,ARENPRI="GROUP 6":6,ARENPRI="GROUP 7":7,ARENPRI="GROUP 8":8,1:ARENPRI)
 S ARMAR=$G(INP(14)) I ARMAR'="" S ARMAR=$S(ARMAR="YES":1,1:0)
 M ARMAI=INP(15)
 M ARMAN=INP(16)
 S ARSVCCON=$G(INP(18)) S:ARSVCCON'="" ARSVCCON=$S(ARSVCCON="YES":1,1:0)
 M ARSVCCOP=INP(19) I $G(ARSVCCOP)'="" S ARSVCCOP=+$G(ARSVCCOP) S:(+ARSVCCOP<0)!(+ARSVCCOP>100) ARSVCCOP=""
 S ARSTOP=$G(INP(21))
 I ARSTOP'="",ARCLIN'="" S RET=RET_"-1^Cannot include both Clinic and Service."_$C(30,31) Q
 S ARAPTYP=+$G(INP(22)) I +ARAPTYP,'$D(^SD(409.1,ARAPTYP,0)) S ARAPTYP=""
 S ARPARENT=+$G(INP(25)) I +ARPARENT,'$D(^SDEC(409.85,+ARPARENT,0)) S ARPARENT=""
 S ARNLT=+$G(INP(26))
 S ARPRER=$G(INP(27))
 S ARORDN=+$G(INP(28))
 ;CHECK FOR MISSING NLT,PREREQ,ORDER IEN ON MULTIPLE APPT REQUESTS
 I +ARPARENT>0&(+$G(INP(26))=0) D
 .S ARNLT=$P($G(^SDEC(409.85,+ARPARENT,7)),U,2)
 I +ARPARENT>0&($G(INP(27))="") D
 .N PRIEN,PR
 .S PRIEN=0 F  S PRIEN=$O(^SDEC(409.85,+ARPARENT,8,PRIEN)) Q:PRIEN'>0  D
 ..S PR=$P($G(^SDEC(409.85,+ARPARENT,8,PRIEN,0)),"^") Q:PR=""
 ..S ARPRER=$S(ARPRER'="":ARPRER_";"_PR,1:PR)
 I +ARPARENT>0&(+$G(INP(28))=0) D
 .S ARORDN=$P($G(^SDEC(409.85,+ARPARENT,7)),U,1)
 ;
 S VAOSGUID=$G(INP(29)) ;   <== wtc patch 686 3/21/18 added for VAOS requests
 S ARIEN=$G(ARIEN)
 S ARNEW=ARIEN=""
 I ARNEW D
 . S AUDF=1
 . S FDA=$NA(FDA(FNUM,"+1,"))
 . S @FDA@(.01)=+DFN   ;$S(+DFN:$P($G(^DPT(DFN,0)),U),1:DFN)
 . ;This handles the date/time coming in as "8/27/2014 12:00:00 AM"
 . S:$G(ARORIGDT)'="" @FDA@(1)=ARORIGDT
 . S:$G(ARINST)'="" @FDA@(2)=+ARINST
 . S:$G(ARTYPE)'="" @FDA@(4)=$S(ARTYPE="APPOINTMENT":"APPT",ARTYPE="MOBILE":"MOBILE",1:ARTYPE)
 . S:$G(VAOSGUID)'="" @FDA@(5)=VAOSGUID ;   <== wtc patch 686 3/21/18 added for VAOS requests
 . S:$G(ARCLIN)'="" @FDA@(8)=+ARCLIN
 . S:$G(ARSTOP)'="" @FDA@(8.5)=+ARSTOP
 . S:+ARAPTYP @FDA@(8.7)=+ARAPTYP
 . S:$G(ARUSER)'="" @FDA@(9)=+ARUSER
 . S:$G(AREDT)'="" @FDA@(9.5)=AREDT
 . S:$G(ARPRIO)'="" @FDA@(10)=ARPRIO
 . S:$G(ARENPRI)'="" @FDA@(10.5)=ARENPRI
 . S:$G(ARREQBY)'="" @FDA@(11)=ARREQBY
 . S:$G(ARPROV)'="" @FDA@(12)=+ARPROV
 . S:$G(ARSVCCOP)'="" @FDA@(14)=ARSVCCOP
 . S:$G(ARSVCCON)'="" @FDA@(15)=+ARSVCCON
 . S:$G(ARDAPTDT)'="" @FDA@(22)=ARDAPTDT
 . S:$G(ARNLT)'="" @FDA@(47)=ARNLT
 . D FDAPRER(.FDA,ARPRER,"+1")
 . S:$G(ARORDN)'="" @FDA@(46)=ARORDN
 . S @FDA@(23)="O"
 . S:$G(ARCOMM)'="" @FDA@(25)=ARCOMM
 . S:$G(ARMAR)'="" @FDA@(41)=ARMAR
 . I +ARMAR,$G(ARMAI)'="" S @FDA@(42)=ARMAI
 . I +ARMAR,$G(ARMAN)'="" S @FDA@(43)=ARMAN
 . S:$G(INP(23))'="" @FDA@(.02)=$S(INP(23)="N":"N",INP(23)="NEW":"N",INP(23)="E":"E",INP(23)="ESTABLISHED":"E",1:"")
 . S:+ARPARENT @FDA@(43.8)=+ARPARENT
 E  D
 . S ARIEN=ARIEN_"," ; Append the comma for both
 . K ARDATA,ARERR
 . D GETS^DIQ(FNUM,ARIEN,"*","IE","ARDATA","ARERR")
 . I $D(ARERR) M ARMSG=ARERR K FDA Q
 . S FDA=$NA(FDA(FNUM,ARIEN))
 . I $D(ARORIGDT) D
 . . S ARORIGDT=$P(ARORIGDT,"@",1) S %DT="" S X=ARORIGDT D ^%DT S ARORIGDTI=Y
 . . I ARORIGDTI'=ARDATA(FNUM,ARIEN,1,"I") S @FDA@(1)=$S(ARORIGDT="":"@",1:ARORIGDT)
 . I $D(ARINST),ARINST'=ARDATA(FNUM,ARIEN,2,"I") S @FDA@(2)=+ARINST
 . I $D(ARTYPE),ARTYPE'=ARDATA(FNUM,ARIEN,4,"E") S @FDA@(4)=$S(ARTYPE="APPOINTMENT":"APPT",ARTYPE="MOBILE":"MOBILE",1:ARTYPE)
 . I $G(VAOSGUID)'="",VAOSGUID'=ARDATA(FNUM,ARIEN,5,"I") S @FDA@(5)=VAOSGUID ;   <== wtc patch 686 3/21/18 added for VAOS requests
 . I ARCLIN'="",ARCLIN'=ARDATA(FNUM,ARIEN,8,"I") S @FDA@(8)=+ARCLIN,AUDF=1 S:ARDATA(FNUM,ARIEN,8.5,"I")'="" @FDA@(8.5)="@"
 . I ARSTOP'="",ARSTOP'=ARDATA(FNUM,ARIEN,8.5,"I") S @FDA@(8.5)=+ARSTOP,AUDF=1 S:ARDATA(FNUM,ARIEN,8,"I")'="" @FDA@(8)="@"
 . S:+ARAPTYP @FDA@(8.7)=+ARAPTYP
 . I $D(ARUSER),ARUSER'=ARDATA(FNUM,ARIEN,9,"I") S @FDA@(9)=+ARUSER
 . I $D(AREDT),AREDT'=$G(ARDATA(FNUM,ARIEN,9.5,"I")) S @FDA@(9.5)=AREDT
 . I $D(ARPRIO),ARPRIO'=ARDATA(FNUM,ARIEN,10,"I") S @FDA@(10)=$S(ARPRIO="":"@",1:ARPRIO)
 . I $D(ARENPRI),ARENPRI'=ARDATA(FNUM,ARIEN,10.5,"E") S @FDA@(10.5)=ARENPRI
 . I $D(ARREQBY),ARREQBY'=ARDATA(FNUM,ARIEN,11,"I") S @FDA@(11)=$S(ARREQBY="":"@",1:ARREQBY)
 . I $D(ARPROV),ARPROV'=ARDATA(FNUM,ARIEN,12,"I") S @FDA@(12)=+ARPROV
 . I $D(ARSVCCOP),ARSVCCOP'=$G(ARDATA(FNUM,ARIEN,14,"I")) S @FDA@(14)=ARSVCCOP
 . I $D(ARSVCCON),ARSVCCON'=ARDATA(FNUM,ARIEN,15,"E") S @FDA@(15)=+ARSVCCON
 . I $D(ARDAPTDT),ARDAPTDT'=ARDATA(FNUM,ARIEN,22,"I") S @FDA@(22)=$S(ARDAPTDT="":"@",1:ARDAPTDT)
 . I $D(ARCOMM),ARCOMM'=ARDATA(FNUM,ARIEN,25,"I") S @FDA@(25)=$S(ARCOMM="":"@",1:ARCOMM)
 . S:$G(ARMAR)'="" @FDA@(41)=ARMAR
 . S:$G(ARMAI)'="" @FDA@(42)=ARMAI
 . S:$G(ARMAN)'="" @FDA@(43)=ARMAN
 . S:$G(ARNLT)'="" @FDA@(47)=ARNLT
 . D DELPRER(+ARIEN)
 . D FDAPRER(.FDA,ARPRER,+ARIEN)
 . S:$G(ARORDN)'="" @FDA@(46)=ARORDN
 . S:$G(INP(23))'="" @FDA@(.02)=$S(INP(23)="N":"N",INP(23)="NEW":"N",INP(23)="E":"E",INP(23)="ESTABLISHED":"E",1:"")
 . S:+ARPARENT @FDA@(43.8)=+ARPARENT
 ; Only call UPDATE^DIE if there are any array entries in FDA
 D:$D(FDA)>9 UPDATE^DIE("","FDA","ARRET","ARMSG")
 I $D(ARMSG) D
 . F MI=1:1:$G(ARMSG("DIERR")) S RET=RET_"-1^"_$G(ARMSG("DIERR",MI,"TEXT",1))_$C(30)
 . S RET=RET_$C(31)
 Q:$D(ARMSG)
 S ARINSTI=$P($G(^SDEC(409.85,$S(+ARIEN:ARIEN,1:ARRET(1)),0)),U,3)
 I $G(INP(17))'="" D AR23(INP(17),$S(+ARIEN:ARIEN,1:ARRET(1)))   ;patient contacts
 I +ARMAR,$G(INP(20))'="" D AR435(INP(20),$S(+ARIEN:ARIEN,1:ARRET(1)))   ;MRTC CALC PREF DATES
 I +AUDF D ARAUD($S(+ARIEN:+ARIEN,1:ARRET(1)),ARCLIN,ARSTOP)   ;VS AUDIT
 I $G(INP(24))'="" N SDI F SDI=1:1:$L(INP(24),"|") S SDREC=$P(INP(24),"|",SDI) D AR433($S(+ARIEN:+ARIEN,1:ARRET(1)),SDREC)
 I +ARPARENT D AR433(+ARPARENT,"~"_$S(+ARIEN:+ARIEN,1:ARRET(1)))
 I +$G(ARRET(1)) S RET=RET_ARRET(1)_U_$C(30,31)
 E  S RET=RET_+ARIEN_U_$C(30,31)
 Q
 ;
FDAPRER(FDA,ARPRER,ARIEN) ;Setup the FDA array for the PREREQUISITE multiple (#48)
 N ASEQ,DELIM,PC,PR
 Q:$G(ARPRER)=""
 S DELIM=";",ASEQ=80
 F PC=1:1:$L(ARPRER,DELIM) D
 .S PR=$P(ARPRER,DELIM,PC) Q:PR=""
 .S ASEQ=ASEQ+1,FDA(409.8548,"+"_ASEQ_","_ARIEN_",",.01)=PR
 Q
 ;
DELPRER(ARIEN) ;Delete all entries in the PREREQUISITE multiple (#48)
 N DIK,DA
 Q:$G(ARIEN)'=+$G(ARIEN)  Q:ARIEN'>0
 S DIK="^SDEC(409.85,"_ARIEN_",8,",DA(1)=ARIEN
 S DA=0 F  S DA=$O(^SDEC(409.85,ARIEN,8,DA)) Q:DA'>0  D ^DIK
 Q
 ;
GETPRER(RET,ARIEN) ;Return the values in the PREREQUISITE multiple (#48)
 N CC,PR
 I $G(^SDEC(409.85,+$G(ARIEN),0))="" S RET="-1^Invalid SDEC APPT REQUEST id "_$G(ARIEN) Q
 S RET=""
 S CC=0 F  S CC=$O(^SDEC(409.85,ARIEN,8,CC)) Q:CC'>0  D
 .S PR=$P($G(^SDEC(409.85,ARIEN,8,CC,0)),U,1) Q:PR=""
 .S RET=$S(RET'="":RET_U_PR,1:PR)
 Q
 ;
ARAUD(ARIEN,ARCLIN,ARSTOP,DATE,USER) ;populate VS AUDIT multiple field 45
 ; ARIEN   - (required) pointer to SDEC APPT REQUEST file 409.85
 ; ARCLIN  - (optional) pointer to HOSPITAL LOCATION file 44
 ; ARSTOP  - (optional) pointer to CLINIC STOP file
 ; DATE    - (optional) date/time in fileman format
 N SDFDA,SDP,SDPN
 S ARIEN=$G(ARIEN) Q:ARIEN=""
 S ARCLIN=$G(ARCLIN)
 S ARSTOP=$G(ARSTOP)
 S SDP=$O(^SDEC(409.85,ARIEN,6,9999999),-1)
 I +SDP S SDPN=^SDEC(409.85,ARIEN,6,SDP,0) I $P(SDPN,U,3)=ARCLIN,$P(SDPN,U,4)=ARSTOP Q
 S DATE=$G(DATE) S:DATE="" DATE=$E($$NOW^XLFDT,1,12)
 S USER=$G(USER) S:USER="" USER=DUZ
 S SDFDA(409.8545,"+1,"_ARIEN_",",.01)=DATE
 S SDFDA(409.8545,"+1,"_ARIEN_",",1)=USER
 S:ARCLIN'="" SDFDA(409.8545,"+1,"_ARIEN_",",2)=ARCLIN
 S:ARSTOP'="" SDFDA(409.8545,"+1,"_ARIEN_",",3)=ARSTOP
 D UPDATE^DIE("","SDFDA")
 Q
 ;
AR433(ARIEN,SDEC) ;set MULT APPTS MADE
 ;INPUT:
 ;  ARIEN  = (required) pointer to SDEC APPT REQUEST file 409.85
 ;  SDEC   = (required) child pointers to SDEC APPOINTMENT and SDEC APPTREQUEST file separated by pipe
 ;                    each pipe piece contains the following ~ pieces:
 ;                1. Appointment Id pointer to SDEC APPOINTMENT file 409.84
 ;                2. Request Id pointer to SDEC APPT REQUEST file 409.85
 N SDAPP,SDFDA,SDI,SDIEN
 S ARIEN=$G(ARIEN)
 Q:'$D(^SDEC(409.85,ARIEN,0))
 S SDEC=$G(SDEC)
 F SDI=1:1:$L(SDEC,"|") D
 .K SDFDA
 .S SDAPP=$P(SDEC,"|",SDI)
 .I $P(SDAPP,"~",2)="",$P(SDAPP,"~",1)'="" S $P(SDAPP,"~",2)=$P($$GET1^DIQ(409.84,+SDAPP_",",.22,"I"),";",1)
 .Q:$P(SDAPP,"~",2)=""
 .S SDIEN=$O(^SDEC(409.85,ARIEN,2,"B",$P(SDAPP,"~",2),0))
 .S SDIEN=$S(SDIEN'="":SDIEN,1:"+1")
 .I $D(^SDEC(409.85,+$P(SDAPP,"~",2),0)) S SDFDA(409.852,SDIEN_","_ARIEN_",",.01)=+$P(SDAPP,"~",2)
 .I $D(^SDEC(409.84,+$P(SDAPP,"~",1),0)) S SDFDA(409.852,SDIEN_","_ARIEN_",",.02)=+$P(SDAPP,"~",1)
 .D:$D(SDFDA) UPDATE^DIE("","SDFDA")
 Q
AR433D(SDEC) ;delete MULT APPTS MADE
 ;INPUT:
 ;  SDEC   = (required) pointers to SDEC APPOINTMENT file 409.84 separated by pipe
 N ARIEN,DFN,DIEN,SDAPP,SDFDA,SDI,SDJ,SDTYP
 S SDEC=$G(SDEC)
 F SDI=1:1:$L(SDEC,"|") D
 .S SDAPP=$P(SDEC,"|",SDI)
 .Q:'$D(^SDEC(409.84,SDAPP,0))
 .S DFN=$$GET1^DIQ(409.84,SDAPP_",",.05,"I")
 .S SDTYP=$$GET1^DIQ(409.84,SDAPP_",",.22,"I"),DIEN=$P(SDTYP,";",1)
 .I $P(SDTYP,";",2)="SDEC(409.85," S ARIEN="" F  S ARIEN=$O(^SDEC(409.85,"B",DFN,ARIEN)) Q:ARIEN=""  D  ; alb/jsm 658
 ..S SDJ="" F  S SDJ=$O(^SDEC(409.85,ARIEN,2,"B",DIEN,SDJ)) Q:SDJ=""  D
 ...S SDFDA(409.852,SDJ_","_ARIEN_",",.01)="@"
 ...D UPDATE^DIE("","SDFDA")
 Q
AR438(ARIEN,SDPARENT,SDEC) ;set PARENT REQUEST field 43.8; set as child in MULTAPPTS MADE in parent request
 N SDFDA
 I $G(SDPARENT)'="" S SDFDA(409.85,ARIEN_",",43.8)=SDPARENT D UPDATE^DIE("","SDFDA")
 Q
 ;
AR435(SDDT,ARIEN) ;set dates into MRTC CALC PREF DATES multiple field 43.5
 ;INPUT:
 ; ARIEN - Requested date ID pointer to SDEC REQUESTED APPT file 409.85
 ; SDDT  - MRTC calculated preferred dates separated by pipe |:
 ;         Each date can be in external format with no time.
 N SDI,SDJ,SDFDA,X,Y,%DT
 F SDI=1:1:$L(SDDT,"|") D
 .S %DT="" S X=$P($P(SDDT,"|",SDI),"@",1) D ^%DT S SDJ=Y
 .Q:SDJ=-1
 .Q:$O(^SDEC(409.85,ARIEN,5,"B",SDJ,0))   ;don't add duplicates
 .S SDFDA(409.851,"+1,"_ARIEN_",",.01)=SDJ
 .D UPDATE^DIE("","SDFDA")
 Q
 ;
WLACT(NAME) ;
 N ACTIVE,H
 S ACTIVE=""
 S H="" F  S H=$O(^DIC(40.7,"B",NAME,H)) Q:H=""  D  Q:ACTIVE'=""
 .I $P(^DIC(40.7,H,0),U,3)'="",$P(^DIC(40.7,H,0),U,3)<$$NOW^XLFDT() Q
 .S ACTIVE=H
 Q ACTIVE
 ;
AR23(INP17,ARI) ;Patient Contacts
 N STR17,ARASD,ARASDH,ARDATA1,ARERR1,ARI1,ARIENS,ARIENS1,ARRET1,FDA
 N ARDT,ARUSR,X,Y,%DT
 S ARIENS=ARI_","
 F ARI1=1:1:$L(INP17,"::") D
 .S STR17=$P(INP17,"::",ARI1)
 .K FDA
 .S %DT="T" S X=$P($P(STR17,"~~",1),":",1,2) D ^%DT S ARASD=Y
 .I (ARASD=-1)!(ARASD="") Q
 .S ARDT=$P($P(STR17,"~~",1),":",1,2)
 .S ARASDH=""   ;$O(^SDEC(409.85,ARI,4,"B",ARASD,0))
 .S ARIENS1=$S(ARASDH'="":ARASDH,1:"+1")_","_ARIENS
 .S FDA=$NA(FDA(409.8544,ARIENS1))
 .I ARASDH'="" D
 ..D GETS^DIQ(409.8544,ARIENS1,"*","IE","ARDATA1","ARERR1")
 ..I $P(STR17,"~~",1)'="" S @FDA@(.01)=ARDT ;DATE ENTERED external date/time
 ..I $P(STR17,"~~",2)'="" S ARUSR=$P(STR17,"~~",2) S @FDA@(2)=$S(ARUSR="":"@",+ARUSR:$P($G(^VA(200,ARUSR,0)),U,1),1:ARUSER)  ;PC ENTERED BY USER
 ..I $P(STR17,"~~",4)'="" S @FDA@(3)=$P(STR17,"~~",4)     ;ACTION  C=Called; M=Message Left; L=LETTER
 ..I $P(STR17,"~~",5)'="" S @FDA@(4)=$P(STR17,"~~",5)     ;PATIENT PHONE
 ..;I $P(STR17,"~~",6)'="" S @FDA@(5)=$E($P(STR17,"~~",6),1,160)     ;COMMENT
 .I ARASDH="" D
 ..I $P(STR17,"~~",1)'="" S @FDA@(.01)=ARDT ;DATE ENTERED external date/time
 ..I $P(STR17,"~~",2)'="" S ARUSR=$P(STR17,"~~",2) S @FDA@(2)=$S(ARUSR="":"@",+ARUSR:$P($G(^VA(200,ARUSR,0)),U,1),1:ARUSR)     ;PC ENTERED BY USER
 ..I $P(STR17,"~~",4)'="" S @FDA@(3)=$P(STR17,"~~",4)     ;ACTION  C=Called; M=Message Left; L=LETTER
 ..I $P(STR17,"~~",5)'="" S @FDA@(4)=$P(STR17,"~~",5)     ;PATIENT PHONE
 ..;I $P(STR17,"~~",6)'="" S @FDA@(5)=$E($P(STR17,"~~",6),1,160)     ;COMMENT
 .D:$D(@FDA) UPDATE^DIE("E","FDA","ARRET1","ARMSG1")
 Q
UPDATE(ARIEN,APPDT,SDCL,SVCP,SVCPR,NOTE,SDAPPTYP) ;update REQ APPT REQUEST at apointment add
 ;INPUT:
 ;  ARIEN = Appt Request pointer to SD WAIT LIST file 409.85
 ;  APPDT = Appointment date/time (Scheduled Date of appt) in fm format
 ;  SDCL  = Clinic ID pointer to HOSPITAL LOCATION file 44
 ;  SVCP  = Service Connected Percentage numeric 0-100
 ;  SVCPR = Service Connected Priority  0:NO  1:YES
 ;  NOTE  = Comment only 1st 60 characters are used
 ;  SDAPPTYP = (optional) Appointment type ID pointer to APPOINTMENT TYPE file 409.1
 ;
 ;all input must be verified by calling routine
 N SDDIV,SDFDA,SDSN,SDMSG
 S:+$G(SDAPPTYP) SDFDA(409.85,ARIEN_",",8.7)=SDAPPTYP
 S SDFDA(409.85,ARIEN_",",13)=APPDT                     ;SCHEDULED DATEOF APPT       = APPDT  (SDECSTART)
 S SDFDA(409.85,ARIEN_",",13.1)=$P($$NOW^XLFDT,".",1)   ;DATE APPT. MADE= TODAY
 S SDFDA(409.85,ARIEN_",",13.2)=SDCL                    ;APPT CLINIC= SDCL   (SDECSCD)
 S SDFDA(409.85,ARIEN_",",13.3)=$P($G(^SC(SDCL,0)),U,4) ;APPT INSTITUTION             = Get from 44 using SDCL
 S SDFDA(409.85,ARIEN_",",13.4)=$P($G(^SC(SDCL,0)),U,7) ;APPT STOP CODE= Get from 44 using SDCL
 S SDDIV=$P($G(^SC(SDCL,0)),U,15)
 S SDSN=$S(SDDIV'="":$P($G(^DG(40.8,SDDIV,0)),U,2),1:"")
 S SDFDA(409.85,ARIEN_",",13.6)=SDSN                    ;APPT STATION NUMBER
 S SDFDA(409.85,ARIEN_",",13.7)=DUZ                     ;APPT CLERK= Current User
 S SDFDA(409.85,ARIEN_",",13.8)="R"                     ;APPT STATUS= R:Scheduled/Kept
 S:SVCP'="" SDFDA(409.85,ARIEN_",",14)=SVCP                      ;SERVICE CONNECTED PERCENTAGE = SVCP   (SDSVCP)
 S:SVCPR'="" SDFDA(409.85,ARIEN_",",15)=SVCPR                     ;SERVICE CONNECTED PRIORITY   = SVCPR  (SDSVCPR)
 S:$G(NOTE)'="" SDFDA(409.85,ARIEN_",",25)=NOTE
 D UPDATE^DIE("","SDFDA","","SDMSG")
 Q
