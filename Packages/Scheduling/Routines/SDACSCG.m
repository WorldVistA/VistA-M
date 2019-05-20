SDACSCG ;ALB/TET - Print/Edit Computer Generated Appt Types ;3/18/92  14:18
 ;;5.3;Scheduling;**16,22,132,202,721**;Aug 13, 1993;Build 11
 ;
 Q
CK ; -- check the number of computer generated visits
 N SDT,SDOE,CT
 S (SDT,CT)=0
 F  S SDT=$O(^SCE("ACG",SDT)) Q:'SDT  D
 . S SDOE=0
 . F  S SDOE=$O(^SCE("ACG",SDT,SDOE)) Q:'SDOE  S CT=CT+1
 ;
 I CT D
 . W !?5,"There are ",CT," encounter(s) with a 'Computer Generated' appointment type.",*7,!
 E  D
 . W !?5,"There are no 'Computer Generated' appointment type encounters."
 Q
 ;
PRINT ;print those CG types which need to be manually updated
 S DGPGM="QUE^SDACSCG"
 D ZIS^DGUTQ
 Q:POP
 ;
QUE ; -- queue entry point
 N SDOE,SDOE0,SDT,DSAH,SDY,CT,Y,X,VA,VADM,VAERR,CT,%DT
 S DASH="",$P(DASH,"-",79)=""
 S (SDT,CT)=0,%DT="SX"
 D HDR
 F  S SDT=$O(^SCE("ACG",SDT)) Q:'SDT  D  G:$D(DTOUT)!($D(DUOUT)) EXIT
 . S Y=SDT D DD^%DT S SDY=Y
 . S SDOE=0
 . F  S SDOE=$O(^SCE("ACG",SDT,SDOE)) Q:'SDOE  D  Q:$D(DTOUT)!($D(DUOUT))
 . . S SDOE0=$G(^SCE(SDOE,0))
 . . S DFN=+$P(SDOE0,U,2)
 . . D DEM^VADPT
 . . D:$Y+6>IOSL CR,HDR
 . . Q:$D(DTOUT)!($D(DUOUT))
 . . W !,SDY,?25,$S(VAERR=0:VADM(1),1:"UNKNOWN"),?60,$G(VA("PID")) ;SD*5.3*721 - Protect VA("PID") variable
 . . S CT=CT+1
 I CT D:$Y+4>IOSL CR W !!,CT," MATCHES FOUND.",!
 ;
EXIT ; -- exit processing
 K %DT,CT,D,DA,DASH,DE,DFN,DFN0,DGPGM,DIC,DIE,DIRUT,DQ
 K DR,DTOUT,DUOUT,FR,I,J,POP,SDA,SDAPTYP,SDBEG,SDCSNODE
 K SDDIV,SDEND,SDUPDT,SDY,SDZN,SDTYPE,TO,VADM,VAEL,VAERR,VA,X,Y
 Q
 ;
CR ; -- end of page processing
 Q:$E(IOST,1,2)'="C-"
 W !!,"Press RETURN to continue or '^' to exit: "
 R SDXX:DTIME S:'$T DTOUT=1
 Q:$D(DTOUT)!(SDXX="")
 I SDXX="^" S DUOUT=1 Q
 W !?5,"Enter an '^' to exit the listing, or enter RETURN to continue."
 G CR
 ;
HDR ; -- header processing
 W:$D(IOF) @IOF W !,"COMPUTER GENERATED APPOINTMENT TYPES"
 W !,"ENCOUNTER DATE/TIME",?25,"PATIENT",?60,"PT ID",!,DASH,!!
 Q
 ;
EDIT ; -- edit computer generated appt types
 N DIR,SDOUT,%DT
 I '$O(^SCE("ACG",0)) W !!?5,"There are no 'Computer Generated' Appointment Types which need updating." G EDITQ
 ;
 W !
 S DIR("A",1)="You may enter one of the following:"
 S DIR("A",2)="         Encounter Date - edit 'Computer Generated' entries for a specific date"
 S DIR("A",3)="  Patient Name (or SSN) - edit 'Computer Generated' entries for one patient"
 S DIR("A",4)="  The default of 'ALL'  - edit all entries which are 'Computer Generated'"
 S DIR("A")="Select Encounter Date"
 S DIR("B")="ALL"
 S DIR(0)="F^1:30"
 S %DT(0)="-DT"
 S DIR("?")="^D QUE^SDACSCG"
 D ^DIR K DIR
 G:$D(DIRUT) EDITQ
 ;
 S SDOUT=0
 D
 .N SDZ
 .I "ALLall"[Y D  Q
 ..D ALL
 .S (X,SDZ)=Y,%DT="PX"
 .D ^%DT
 .I Y'=-1 D  Q
 ..S Y=SDZ
 ..D DATE
 .S Y=SDZ
 .I Y?9N!(Y?1A4N)!(Y?.AP)!(Y?4N) D  Q
 ..D DPT
 ;
 I 'SDOUT G EDIT
 ;
EDITQ D EXIT
 Q
 ;
DATE ;
 N CT,%DT,Y,SDBEG,SDEND
 S CT=0
 S %DT="EPTXS"
 S %DT(0)=-DT
 D ^%DT S Y=+Y
 IF $D(DTOUT) S SDOUT=1 G DATEQ
 G DATEQ:Y=-1
 ;
 S SDBEG=$S(Y[".":Y-.000001,1:Y)
 S SDEND=$S(Y[".":Y,1:Y_.999999)
 D LOOP(SDBEG,SDEND)
 ;
 G:SDOUT DATEQ
 W:'CT !,"There are no 'Computer Generated' appt types for selection.",*7,!
DATEQ Q
 ;
ALL ; -- loop through and edit all computer generated appt types
 N CT
 S CT=0
 ;
 D LOOP()
 ;
ALLQ Q
 ;
DPT ; -- look up in patient file & loop through acg for selected dfn
 ;
 N DIC,D,CT,Y
 S CT=0
 S DIC="^DPT(",DIC(0)="EQMZ"
 S D=$S(X?9N:"SSN",X?1A.4N:"B5",1:"B")
 D IX^DIC
 G DPTQ:Y'>0
 ;
 D LOOP(,,+Y)
 ;
 G:SDOUT DPTQ
 W:'CT !,"There are no 'Computer Generated' appt types for selected entry.",*7,!
DPTQ Q
 ;
LOOP(SDBEG,SDEND,SDFN) ;
 N SDY,DFN,VA,VAERR,VAADM,SDT,SDOE,SDCLIN,SDSTOP,SDDIV,SDSTA,SDPAT,SDDT,SDCELIG
 ;
 IF '$G(SDBEG) N SDBEG S SDBEG=0
 IF '$G(SDEND) N SDEND S SDEND=9999999
 IF '$G(SDFN) N SDFN S SDFN=0
 ;
 S SDT=SDBEG
 F  S SDT=$O(^SCE("ACG",SDT)) Q:'SDT!(SDT>SDEND)  D  Q:SDOUT
 . S SDOE=0
 . F  S SDOE=$O(^SCE("ACG",SDT,SDOE)) Q:'SDOE  D  Q:SDOUT 
 . . IF SDFN,SDFN'=+$P($G(^SCE(SDOE,0)),"^",2) Q
 . . S SDPAT=+$P($G(^SCE(SDOE,0)),"^",2) Q:'SDPAT  ;SD*721 - Quit if no patient info in encounter
 . . S SDDT=$P(+$P($G(^SCE(SDOE,0)),U),".") Q:'SDDT  ;SD*721 - Quit if not valid date
 . . Q:$G(^DPT(SDPAT,0))=""  ;SD*721 - Quit if not in Patient File, supported by ICR #10035
 . . S SDCELIG=$$GET1^DIQ(409.68,SDOE,.13)  ;SD*721 - Get Current Eligibility
 . . S SDCLIN=$$GET1^DIQ(409.68,SDOE,.04),SDSTOP=$$GET1^DIQ(409.68,SDOE,.03)
 . . ;Reference to SITE^VASITE supported by ICR #10112
 . . S SDDIV=$$GET1^DIQ(409.68,SDOE,.11,"I"),SDSTA=$P($$SITE^VASITE(SDDT,SDDIV),U,3)
 . . D DEM(SDOE),DEMW
 . . D DIE(SDOE)
LOOPQ Q
 ;
DEM(SDOE) ; -- get pt name,ssn and visit date
 N SDOE0,Y,DFN
 S SDOE0=$G(^SCE(SDOE,0))
 S DFN=+$P(SDOE0,"^",2)
 D DEM^VADPT
 S Y=+SDOE0 D DD^%DT S SDY=Y
 Q
 ;
DEMW ; -- write patient demographics
 ;SD*721 - Add header, division, location, stop code, and service connected information
 N SDHASH
 W @IOF,"ENCOUNTER DATE",?25,"PATIENT NAME",?60,"PATIENT SSN" ;Header - SD*721
 W !,?3,"DIVISION",?15,"CLINIC LOCATION",?50,"STOP CODE" ;Header - SD*721
 W ! F SDHASH=1:1:80 W "-" ;Header - SD*721
 W !,SDY,?25,$S(VAERR=0:VADM(1),1:"UNKNOWN"),?60,$G(VA("PID")) ;SD*5.3*721 - Protect VA("PID") variable
 W !,?3,SDSTA,?15,$S(SDCLIN'="":SDCLIN,1:"UNKNOWN LOCATION"),?50,SDSTOP ;SD*721 - division, location, stop code
 D SC(SDPAT) ;SD*721 - Service connected info
 K VAEL,DFN
 Q
 ;
DIE(SDOE) ; -- do edit
 N DR,DIE,DE,DQ
 S DR=".1d;I $P(^(0),U,10)=10 S Y=""@99"";202///@;@99"
 S DIE="^SCE("
 S DA=SDOE
 D ^DIE
 S:$D(DTOUT)!($D(Y)'=0) SDOUT=1
 S CT=CT+1
 Q
 ;
SC(DFN) ;SD*721 - Add Service Connected Information
 ; Input  -- DFN      Patient file IEN
 N SDI,SDCNT,SDDC,SDRD0,SDARR,SDSECN
 ;Reference to ELIG^VADPT supported by ICR #10061
 D ELIG^VADPT
 W !!,"Patient's Service Connection and Rated Disabilities:"
 W !!,$S(+VAEL(3)="1":"        SC Percent: "_$P(VAEL(3),U,2)_"%",1:" Service Connected: No")
 W !,"Rated Disabilities: "
 I 'VAEL(4) W "Not a Veteran",!,"Primary Eligibility Code: ",$S(+VAEL(1):$P(VAEL(1),U,2),1:"N/A") D  W !!,"Current Eligibility for Encounter: ",$S(SDCELIG'="":SDCELIG,1:"N/A") Q
 .S SDSECN=0 F  S SDSECN=$O(VAEL(1,SDSECN)) Q:'SDSECN  W !,"Secondary Eligibility Code: ",$P(VAEL(1,SDSECN),U,2)
 S (SDCNT,SDI)=0
 ;Reference to ^DPT(DFN,.372 supported by ICR #1476
 F  S SDI=$O(^DPT(DFN,.372,SDI)) Q:'SDI  I $P($G(^(SDI,0)),"^",3) S SDRD0=^(0) D
 .S SDCNT=SDCNT+1
 .;Reference to ^DIC(31,+SDRD0 supported by ICR #733
 .S SDDC=$P($G(^DIC(31,+SDRD0,0)),U)
 .W:SDCNT>1 !
 .W ?20,SDDC,"  (",$P(SDRD0,"^",2),"%-",$S($P(SDRD0,"^",3):"SC",1:""),")"
 I 'SDCNT W $S('$O(^DPT(DFN,.372,0)):"None Stated",1:"No Service Connected Disabilities Listed")
 W !,"Primary Eligibility Code: ",$S(+VAEL(1):$P(VAEL(1),U,2),1:"N/A") D
 .S SDSECN=0 F  S SDSECN=$O(VAEL(1,SDSECN)) Q:'SDSECN  W !,"Secondary Eligibility Code: ",$P(VAEL(1,SDSECN),U,2)
 W !!,"Current Eligibility for Encounter: ",$S(SDCELIG'="":SDCELIG,1:"N/A")
 Q
