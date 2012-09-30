XUSAP1 ;OAK/KC - Connector Proxy Reports ;2/1/2012
 ;;8.0;KERNEL;**574**;Jul 10, 1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; Option File entry points:
 ;    EN1^XUSAP1: prompt user to select 1 connector proxy to display
 ;  ENALL^XUSAP1: prompt user to display all connector proxies (can be scheduled)
 ;
EN1 ;option entry point w/dialog to select 1 CP entry; calls task entry point
 N XUSCPSAV,XUSCPDUZ,DIC,X,Y,XUSCPSCANLOG,XUSCPSCANFLD
 I '$$GETCPIEN W !!,"ABORTING! 'CONNECTOR PROXY' USER CLASS UNDEFINED." Q
 ;select CP entry to print
 S DIC="^VA(200,",DIC(0)="AEMQZ",DIC("S")="I $$ISUSERCP^XUSAP1(Y)" D ^DIC Q:Y'>0
 S XUSCPDUZ=+Y,XUSCPSAV("XUSCPDUZ")=""
 K Y D ASKFLD Q:Y[U!(Y="")  S XUSCPSCANFLD=+Y,XUSCPSAV("XUSCPSCANFLD")=""
 K Y D ASKLOG Q:Y[U!(Y="")  S XUSCPSCANLOG=+Y,XUSCPSAV("XUSCPSCANLOG")=""
 D EN^XUTMDEVQ("Q1^XUSAP1","Connector Proxy Display",.XUSCPSAV)
 Q
 ;
ENALL ;schedulable option entry point w/dialog to print all CPs; calls task entry point
 N XUSCPSAV,XUSCPSCANLOG,XUSCPSCANFLD
 I '$$GETCPIEN W !!,"Connector Proxy Report ABORTING! 'CONNECTOR PROXY' USER CLASS UNDEFINED." Q
 I $D(ZTQUEUED) S (XUSCPSCANLOG,XUSCPSCANFLD)=1 G QALL ; can run as scheduled option
 K Y D ASKFLD Q:Y[U!(Y="")  S XUSCPSCANFLD=+Y,XUSCPSAV("XUSCPSCANFLD")=""
 K Y D ASKLOG Q:Y[U!(Y="")  S XUSCPSCANLOG=+Y,XUSCPSAV("XUSCPSCANLOG")=""
 D EN^XUTMDEVQ("QALL^XUSAP1","Connector Proxy Report",.XUSCPSAV)
 Q
 ;
ASKLOG ;ask if want to scan sign-on log too
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YO",DIR("B")="No"
 S DIR("A")="Scan sign-on log for connector proxy activity"
 S DIR("?")="Scanning the sign-on log will consume additional time before report completion."
 D ^DIR Q
 ;
ASKFLD ;ask if want to analyze options
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YO",DIR("B")="Yes"
 S DIR("A")="Check/display connector proxy fields"
 S DIR("?")="More output will be contained in the report if connector proxy fields are checked/displayed."
 D ^DIR Q
 ;
Q1 ;EN^XUTMDEVQ entry point, print 1
 ;input values: 
 ; XUSCPDUZ (conn proxy DUZ)
 ; XUSCPSCANFLD (whether to scan NP flds in CP entries)
 ; XUSCPSCANLOG (whether to scan sign-on log)
 N XUSCPRNT,XUSCPDT,XUSCPSAEXP,XUSCPACTIVE,XUSCPQ,XUSCPLST,XUSCPOKFLDS,XUSCPWARNFLDS,XUSCPINACFLDS
 S XUSCPACTIVE=$$ACTIVE^XUSER(XUSCPDUZ)
 D VARSETUP
 I +$G(XUSCPSCANLOG) S XUSCPLST($P(XUSCPACTIVE,U),XUSCPDUZ)=$P(XUSCPACTIVE,U,2) D SCANLOG
 W:$E(IOST,1,2)="C-" @IOF D HDR,BLURB
 D P(XUSCPACTIVE,XUSCPDUZ)
 K ^TMP($J,"XUSCP"),^TMP($J,"XUSCPLOG") Q
 ;
QALL ;EN^XUTMDEVQ entry point, print all
 ;input values (EN^XUTMDEVQ):
 ; XUSCPSCANFLD (whether to scan NP flds in CP entries)
 ; XUSCPSCANLOG (whether to scan sign-on log)
 N XUSCPRNT,XUSCPDT,XUSCPSAEXP,XUSCPACTIVE,XUSCPQ,XUSCPLST,XUSCPOKFLDS,XUSCPWARNFLDS,XUSCPINACFLDS
 D VARSETUP
 ;gather DUZ list of CPs in XUSCPLST
 D DUZLIST Q:+$G(ZTSTOP)
 D:+$G(XUSCPSCANLOG) SCANLOG Q:+$G(ZTSTOP)
 W:$E(IOST,1,2)="C-" @IOF D HDR,BLURB ;header for page 1
 ;loop through/sort by active, then inactive, CP DUZ list users, print detail if requested
 F XUSCPACTIVE=1,0  Q:+$G(XUSCPQ)  D
 .S XUSCPDUZ=0 F  S XUSCPDUZ=$O(XUSCPLST(XUSCPACTIVE,XUSCPDUZ))  Q:('XUSCPDUZ)!+$G(XUSCPQ)  D P(XUSCPACTIVE,XUSCPDUZ)
 K ^TMP($J,"XUSCP"),^TMP($J,"XUSCPLOG") Q
 ;
VARSETUP ;set up date,print,field list vars
 S XUSCPDT=$$HTFM^XLFDT($H),XUSCPSAEXP=1095 ;current date, + service acct expiry in days
 S XUSCPRNT("DT EXT")=$$FMTE^XLFDT(XUSCPDT,"1PM")
 S $P(XUSCPRNT("UL"),"-",IOM)="",$P(XUSCPRNT("EQ"),"=",IOM)="",XUSCPRNT("PG")=1
 D ADDFLDS("WARNFLDS",.XUSCPWARNFLDS) ;get fields processed in warning sections
 D ADDFLDS("OKFLDS",.XUSCPOKFLDS) ;get "ok to be populated" field list
 D ADDFLDS("INACFLDS",.XUSCPINACFLDS) ;get "ok for inactive user field list
 Q
 ;
P(XUSCPACTIVE,XUSCPDUZ) ;print/display a CP entry
 ;input values: XUSCPDUZ, + VARSET values
 N XUSCPERR,I,J,XUSCPSTR
 I $$S^%ZTLOAD() S (XUSCPQ,ZTSTOP)=1 Q
 K ^TMP($J,"XUSCP")
 I $$HDRCHK(4) S XUSCPQ=1 Q
 D GETS^DIQ(200,XUSCPDUZ,"**","EINR","^TMP($J,""XUSCP"")","XUSCPERR") ;get populated fields int/ext
 I $D(XUSCPERR) D  Q
 .W !," >>>>Error(s) processing Connector Proxy DUZ "_XUSCPDUZ_": "
 .S I=0 F  S I=$O(XUSCPERR("DIERR",I)) Q:'I!(+$G(XUSCPQ))  D
 ..S J=0 F  S J=$O(XUSCPERR("DIERR",I,"TEXT",J)) Q:'J!(+$G(XUSCPQ))  D
 ...W !," >>>>"_$G(XUSCPERR("DIERR",I))_" "_$G(XUSCPERR("DIERR",I,"TEXT",J)),!
 ...I $$HDRCHK(4) S XUSCPQ=1 Q
 ;
 S XUSCPSTR="Name: '"_$$NAME^XUSER(XUSCPDUZ)_"'"
 W !,XUSCPRNT("EQ"),!,XUSCPSTR,$$RJ^XLFSTR(" Active: "_$S(+XUSCPACTIVE:"YES",1:"NO"),IOM-$L(XUSCPSTR)-1," ")
 I '+XUSCPACTIVE,$L($G(XUSCPLST(XUSCPACTIVE,XUSCPDUZ))) W !,$$RJ^XLFSTR("("_XUSCPLST(XUSCPACTIVE,XUSCPDUZ)_")",IOM-1," ")
 W !,XUSCPRNT("EQ")
 I $$HDRCHK(4) S XUSCPQ=1 Q
 ;
 D PCREDCHK S:$$HDRCHK(4) XUSCPQ=1 Q:+$G(XUSCPQ)
 I +$G(XUSCPSCANFLD) D  Q:+$G(XUSCPQ)
 .D PWARN S:$$HDRCHK(4) XUSCPQ=1 Q:+$G(XUSCPQ)
 .D POKFLDS S:$$HDRCHK(4) XUSCPQ=1 Q:+$G(XUSCPQ)
 .D PBADFLDS S:$$HDRCHK(4) XUSCPQ=1 Q:+$G(XUSCPQ)
 .D PBADMULT S:$$HDRCHK(4) XUSCPQ=1  Q:+$G(XUSCPQ)
 D:+$G(XUSCPSCANLOG) PSCANLOG S:$$HDRCHK(4) XUSCPQ=1  Q:+$G(XUSCPQ)
 W !
 Q
 ;
PCREDCHK ;display credential date checks
 ;input values: ^TMP($J,"XUSCP"), XUSCPDUZ, XUSCPDT
 N XUSCPDIFFDE,XUSCPDIFFVC,XUSCPOLDTIME,XUSCPDC
 S XUSCPOLDTIME="2950710.000101"
 ;check time since v/c last changed, WARN > 3 yrs
 ;if DATE VERIFY CODE LAST CHANGED="60000,1" then no date on record.
 S XUSCPDC=$G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","DATE VERIFY CODE LAST CHANGED","I")) S:$L(XUSCPDC) XUSCPDC=$$HTFM^XLFDT(XUSCPDC,1) ; convert $H to FM
 S XUSCPDIFFDE=$$FMDIFF^XLFDT(XUSCPDT,$G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","DATE ENTERED","I"),XUSCPOLDTIME))
 S XUSCPDIFFVC=$$FMDIFF^XLFDT(XUSCPDT,$G(XUSCPDC,XUSCPOLDTIME))
 I $$HDRCHK(4) S XUSCPQ=1 Q
 W !,"   Compliant w/3-year Service Account Mandate? " D
 .I (XUSCPDIFFDE<XUSCPSAEXP)!(XUSCPDIFFVC<XUSCPSAEXP) W "YES" Q  ;one or both dates within exp
 .;both dates exp, verify code date is real OR if fake, there are no VOLD nodes
 .I ('($G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","DATE VERIFY CODE LAST CHANGED","I"))="60000,1"))!('$D(^VA(200,XUSCPDUZ,"VOLD"))) W $S(XUSCPACTIVE:"*** NO <---- MUST FIX ***",1:"No, but user not active.") Q
 .W $S(XUSCPACTIVE:"UNABLE TO DETERMINE",1:"unable to det. but not active.") Q  ;fake verify code date AND VOLD nodes, so can't tell
 W !,"   Date User Created: "_$G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","DATE ENTERED","E"))
 I $$HDRCHK(4) S XUSCPQ=1 Q
 W !,"   Date Verify Code Last Changed: "
 W $S('$L($G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","DATE VERIFY CODE LAST CHANGED","I"))):"never",$G(^("I"))'="60000,1":$G(^("E")),$D(^VA(200,XUSCPDUZ,"VOLD")):"(changed but date not recorded)",1:"never")
 ; if XUS Logon Attempt Count > 0, strongly indicates verify code-related login problem(s) from 1 or more adapters
 I +$G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","XUS Logon Attempt Count","E")) W !,"   >>>Failed Logon Attempts: "_^("E")
 Q
 ;
PWARN ;display warning for primary menus, other user classes defined, FM access code
 N XUSCPWRN,XUSCPMUL
 S:$L($G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","PRIMARY MENU OPTION","E"))) XUSCPWRN("PRIMARY")=^("E")
 S:$L($G(^TMP($J,"XUSCP",200,XUSCPDUZ_",","SSN","E"))) XUSCPWRN("SSN")="<masked>"
 I $D(^TMP($J,"XUSCP",200,XUSCPDUZ_",","FILE MANAGER ACCESS CODE")) S XUSCPWRN("FILE MANAGER ACCESS CODE")=""
 S XUSCPMUL="" F  S XUSCPMUL=$O(^TMP($J,"XUSCP",200.07,XUSCPMUL)) Q:XUSCPMUL']""  D
 .I ^TMP($J,"XUSCP",200.07,XUSCPMUL,"User Class","I")'=$$GETCPIEN S XUSCPWRN("USC")=""
 I $D(XUSCPWRN) W !!," Warning(s):",!," -----------" D  Q:+$G(XUSCPQ)!+$G(XUSCPQ)
 .I $D(XUSCPWRN("PRIMARY")) W !,"   Primary Menu defined (SHOULDN'T BE!): ",XUSCPWRN("PRIMARY")
 .I $D(XUSCPWRN("SSN")) W !,"   SSN defined (SHOULDN'T BE!): ",XUSCPWRN("SSN")
 .I $$HDRCHK(4) S XUSCPQ=1 Q
 .I $D(XUSCPWRN("USC")) W !,"   Non-CP User Classes defined (SHOULDN'T BE!): " D  Q:+$G(XUSCPQ)
 ..S XUSCPMUL="" F  S XUSCPMUL=$O(^TMP($J,"XUSCP",200.07,XUSCPMUL)) Q:XUSCPMUL']""!+$G(XUSCPQ)  D
 ...Q:^TMP($J,"XUSCP",200.07,XUSCPMUL,"User Class","I")=$$GETCPIEN
 ...W !,"   - "_^TMP($J,"XUSCP",200.07,XUSCPMUL,"User Class","E")
 ...I $$HDRCHK(4) S XUSCPQ=1 Q
 .I $D(XUSCPWRN("FILE MANAGER ACCESS CODE")) W !,"   File Manager Access Code is defined (SHOULDN'T BE!): "_^TMP($J,"XUSCP",200,XUSCPDUZ_",","FILE MANAGER ACCESS CODE","E")
 Q
 ;
POKFLDS ;display values of allowed fields
 N XUSCPFLD
 W !!," Values for other fields allowed/expected to be Populated:"
 W !," ----------------------------------------------------------"
 I $$HDRCHK(4) S XUSCPQ=1 Q
 S XUSCPFLD="" F  S XUSCPFLD=$O(XUSCPOKFLDS(XUSCPFLD)) Q:'$L(XUSCPFLD)!(+$G(XUSCPQ))  D PFLD
 I 'XUSCPACTIVE S XUSCPFLD="" F  S XUSCPFLD=$O(XUSCPINACFLDS(XUSCPFLD)) Q:'$L(XUSCPFLD)!(+$G(XUSCPQ))  D PFLD
 Q
 ;
PFLD ; output a field
 ;input XUSCPFLD,XUSCPDUZ,^TMP values
 Q:'$D(^TMP($J,"XUSCP",200,XUSCPDUZ_",",XUSCPFLD,"I"))  ; skip empty fields
 W !,"  "_$$RJ^XLFSTR(XUSCPFLD,29)_": "
 W $S(XUSCPFLD="NAME COMPONENTS":"entry# "_$G(^TMP($J,"XUSCP",200,XUSCPDUZ_",",XUSCPFLD,"I")),1:$G(^TMP($J,"XUSCP",200,XUSCPDUZ_",",XUSCPFLD,"E")))
 I $$HDRCHK(4) S XUSCPQ=1 Q
 Q
 ;
PBADFLDS ;display any unexpected (not part of CP template) top-level fields populated
 N XUSCPFLD,XUSCPCNT
 S XUSCPFLD="",XUSCPCNT=0 F  S XUSCPFLD=$O(^TMP($J,"XUSCP",200,XUSCPDUZ_",",XUSCPFLD)) Q:XUSCPFLD']""!(+$G(XUSCPQ))  D
 .Q:$D(XUSCPOKFLDS(XUSCPFLD))!$D(XUSCPWARNFLDS(XUSCPFLD))
 .Q:$D(XUSCPINACFLDS(XUSCPFLD))&'XUSCPACTIVE
 .S XUSCPCNT=XUSCPCNT+1 I XUSCPCNT=1 D  Q:+$G(XUSCPQ)
 ..W !!," Other Fields Populated:"
 ..W !," -----------------------"
 ..I $$HDRCHK(4) S XUSCPQ=1 Q
 .Q:+$G(XUSCPQ)
 .D PFLD
 Q
 ;
PBADMULT ;display any unexpected multiples; skip those already processed:
 ;- 200.07 user class
 N XUSCPMUL,XUSCPFLD,XUSCPFILE,XUSCPCNT
 S (XUSCPFILE,XUSCPCNT)=0 F  S XUSCPFILE=$O(^TMP($J,"XUSCP",XUSCPFILE)) Q:'XUSCPFILE!+$G(XUSCPQ)  D
 .Q:XUSCPFILE=200!(XUSCPFILE="200.07")
 .S XUSCPCNT=XUSCPCNT+1 D:XUSCPCNT=1
 ..W !!," Other Multiples Populated:"
 ..W !," ---------------------------"
 .W !," ",XUSCPFILE,": ",$P($G(^DD(XUSCPFILE,0)),U)
 .S XUSCPMUL="" F  S XUSCPMUL=$O(^TMP($J,"XUSCP",XUSCPFILE,XUSCPMUL)) Q:XUSCPMUL']""!+$G(XUSCPQ)  D
 ..S XUSCPFLD="" F  S XUSCPFLD=$O(^TMP($J,"XUSCP",XUSCPFILE,XUSCPMUL,XUSCPFLD)) Q:XUSCPFLD']""!(+$G(XUSCPQ))  D
 ...W !,"  "_$$RJ^XLFSTR(XUSCPFLD,29)_": "_$G(^TMP($J,"XUSCP",XUSCPFILE,XUSCPMUL,XUSCPFLD,"E"))
 ...I $$HDRCHK(4) S XUSCPQ=1 Q
 Q
 ;
PSCANLOG ; output signon activity for this CP user found in SCANLOG pass
 N XUSCPIP,XUSCPSIGNON,XUSCPTOT
 ;input: ^TMP($J,"XUSCPLOG",XUSCPDUZ),XUSCPDUZ
 W !!," Connector Proxy Activity (Sign-On Log):"
 W !," --------------------------------------"
 I $$HDRCHK(4) S XUSCPQ=1 Q
 I '$D(^TMP($J,"XUSCPLOG",XUSCPDUZ)) W !," no signon activity found" Q
 S XUSCPIP="" F  S XUSCPIP=$O(^TMP($J,"XUSCPLOG",XUSCPDUZ,XUSCPIP)) Q:'+XUSCPIP!+$G(XUSCPQ)  D
 .W !,"  IP address "_XUSCPIP_": "
 .W !,"     - Total active connections (current): ",+$G(^TMP($J,"XUSCPLOG",XUSCPDUZ,XUSCPIP,"CUR"))
 .I $$HDRCHK(4) S XUSCPQ=1 Q
 .S (XUSCPSIGNON,XUSCPTOT)=0 F  S XUSCPSIGNON=$O(^TMP($J,"XUSCPLOG",XUSCPDUZ,XUSCPIP,XUSCPSIGNON)) Q:'+XUSCPSIGNON!+$G(XUSCPQ)  D
 ..S XUSCPTOT=XUSCPTOT+$G(^TMP($J,"XUSCPLOG",XUSCPDUZ,XUSCPIP,XUSCPSIGNON))
 .W !,"     - Total logons recorded in sign-on log: "_XUSCPTOT
 .W !,"     - Total logons by date: "
 .I $$HDRCHK(4) S XUSCPQ=1 Q
 .S XUSCPSIGNON=0 F  S XUSCPSIGNON=$O(^TMP($J,"XUSCPLOG",XUSCPDUZ,XUSCPIP,XUSCPSIGNON)) Q:'+XUSCPSIGNON!+$G(XUSCPQ)  D
 ..W !,"        > "_$$FMTE^XLFDT(XUSCPSIGNON)_": "_^TMP($J,"XUSCPLOG",XUSCPDUZ,XUSCPIP,XUSCPSIGNON)
 ..I $$HDRCHK(4) S XUSCPQ=1 Q
 Q
 ;
DUZLIST ;loop thru file 200, return list of CP user class DUZs in XUSCPLST in format:
 ;XUSCPLST(0 or 1,DUZ)=reason/description active/inactive
 ;0=inactive user, 1=active
 N XUSCPIEN,XUSCPACTIVE,XUSCPLOOPC,XUSCPQC
 ;get CP user class IEN
 S XUSCPIEN=$$GETCPIEN I 'XUSCPIEN W !!,"ABORTING! 'CONNECTOR PROXY' USER CLASS UNDEFINED." Q
 ;loop thru 200 for connector proxy users (USC3 xref)
 S XUSCPQC=100
 S (XUSCPDUZ,XUSCPLOOPC)=0 F  S XUSCPDUZ=$O(^VA(200,XUSCPDUZ)) Q:'XUSCPDUZ!+$G(XUSCPQ)  D
 .S XUSCPLOOPC=XUSCPLOOPC+1 I '+(XUSCPLOOPC#XUSCPQC) I $$S^%ZTLOAD() S (XUSCPQ,ZTSTOP)=1 Q
 .I $D(^VA(200,XUSCPDUZ,"USC3")) D
 ..Q:'$$ISUSERCP(XUSCPDUZ)
 ..S XUSCPACTIVE=$$ACTIVE^XUSER(XUSCPDUZ)
 ..S XUSCPLST($P(XUSCPACTIVE,U),XUSCPDUZ)=$P(XUSCPACTIVE,U,2)
 Q
 ;
ISUSERCP(XUSCPDUZ) ;return 1 if any of DUZ's user classes are CP, 0 if not
 N XUSCP200P07IEN,XUSCP201IEN,XUSCPRET,XUSCPIEN
 S XUSCPRET=0
 I $D(^VA(200,XUSCPDUZ,"USC3")) D
 .;loop thru DUZ's user class multiple/look for CP
 .S XUSCP200P07IEN=0,XUSCPIEN=$$GETCPIEN
 .F  S XUSCP200P07IEN=$O(^VA(200,XUSCPDUZ,"USC3",XUSCP200P07IEN)) Q:'XUSCP200P07IEN!$D(XUSCPLST(XUSCPDUZ))  D
 ..;get IEN of user class, check if CONNECTOR PROXY
 ..S XUSCP201IEN=$P(^VA(200,XUSCPDUZ,"USC3",XUSCP200P07IEN,0),U)
 ..S:(XUSCP201IEN=XUSCPIEN) XUSCPRET=1 ;user has CP user class
 Q XUSCPRET
 ;
GETCPIEN() ;return CP IEN from User Class file
 Q +$O(^VA(201,"B","CONNECTOR PROXY",""))
 ;
HDR ;
 W "CONNECTOR PROXY REPORT: ",XUSCPRNT("DT EXT"),?70,$$RJ^XLFSTR("PAGE "_XUSCPRNT("PG"),9),!,XUSCPRNT("UL"),!
 Q
 ;
BLURB ;
 W !,">>>Always contact the National Help Desk or Customer Support, to determine"
 W !,"the best fix (and be alerted to known issues) for ANY problem listed below.",!
 W !?10,"Coordinate all account changes with affected remote"
 W !?15,"application to prevent service disruptions.",!
 Q
 ;
HDRCHK(Y) ;Y=excess lines, return 1 to exit
 ;return 0 to continue
 Q:+$G(XUSCPQ) 1
 Q:$Y<(IOSL-Y) 0
 I $E(IOST,1,2)="C-" D  Q:'Y 1
 .N DIR,I,J,K,X
 .S DIR(0)="E" D ^DIR
 S XUSCPRNT("PG")=XUSCPRNT("PG")+1
 W @IOF D HDR
 Q 0
 ;
SCANLOG ;loop thru sign-on log for connector proxy activity, save results in ^TMP($J,"XUSCPLOG")
 N XUSCPSEC0,XUSCPSIGNON,XUSCPSECDUZ,XUSCPIP,XUSCPCUR,XUSCPLOOPC,XUSCPQ,XUSCPQC
 ;input: XUSCPLST(ACTIVE,DUZ) list of CPs
 ;search each ^XUSEC(0, date/time) 0-node
 SET (XUSCPSIGNON,XUSCPLOOPC)=0,XUSCPQC=100
 F  SET XUSCPSIGNON=$O(^XUSEC(0,XUSCPSIGNON)) Q:'+XUSCPSIGNON!+$G(XUSCPQ)  D
 .S XUSCPLOOPC=XUSCPLOOPC+1 I '+(XUSCPLOOPC#XUSCPQC) I $$S^%ZTLOAD() S (XUSCPQ,ZTSTOP)=1 Q
 .S XUSCPSEC0=^XUSEC(0,XUSCPSIGNON,0),XUSCPSECDUZ=$P(XUSCPSEC0,U) ; get XUSEC 0 node, DUZ
 .I +XUSCPSECDUZ,($D(XUSCPLST(0,XUSCPSECDUZ))!$D(XUSCPLST(1,XUSCPSECDUZ))) D  ; check if DUZ in CP list
 ..S XUSCPIP=$P(XUSCPSEC0,U,11) S:XUSCPIP']"" XUSCPIP="unknown" ; get IP from XUSEC
 ..S XUSCPCUR=$D(^XUSEC(0,"CUR",XUSCPSECDUZ,XUSCPDT)) ; check if job currently logged on
 ..;increment logon count per IP per day
 ..S ^TMP($J,"XUSCPLOG",XUSCPSECDUZ,XUSCPIP,$P(XUSCPSIGNON,"."))=+$G(^TMP($J,"XUSCPLOG",XUSCPSECDUZ,XUSCPIP,$P(XUSCPSIGNON,".")))+1
 ..I $D(^XUSEC(0,"CUR",XUSCPSECDUZ,XUSCPSIGNON)) D  ;increment currently signed on count
 ...S ^TMP($J,"XUSCPLOG",XUSCPSECDUZ,XUSCPIP,"CUR")=+$G(^TMP($J,"XUSCPLOG",XUSCPSECDUZ,XUSCPIP,"CUR"))+1
 Q
 ;
ADDFLDS(XUSCPTAG,XUSCPARR) ;return list of fields in .XUSCPARR(fieldname)
 ; XUSCPTAG: tag to read field names from
 ; .XUSCPARR: array to populate (pass as .param)
 N I,XUSCPFLD
 F I=1:1  S XUSCPFLD=$P($T(@XUSCPTAG+I),";;",2) Q:'$L(XUSCPFLD)  D
 .S XUSCPARR(XUSCPFLD)=""
 Q
 ;
OKFLDS ;top-level fields OK/expected to be populated
 ;;ACCESS CODE
 ;;CREATOR
 ;;DISUSER
 ;;Entry Last Edit Date
 ;;LAST SIGN-ON DATE/TIME
 ;;MULTIPLE SIGN-ON
 ;;NAME
 ;;NAME COMPONENTS
 ;;PROVIDER KEY
 ;;SERVICE/SECTION
 ;;SIGNATURE BLOCK PRINTED NAME
 ;;TIMESTAMP
 ;;VERIFY CODE
 ;;VERIFY CODE never expires
 ;;XUS Active User
 ;
INACFLDS ;fields OK to populate for an INACTIVE user
 ;;TERMINATION DATE
 ;
WARNFLDS ;field checked in WARNING section
 ;;DATE ACCESS CODE LAST CHANGED
 ;;DATE VERIFY CODE LAST CHANGED
 ;;DATE ENTERED
 ;;FILE MANAGER ACCESS CODE
 ;;SSN
 ;;XUS Logon Attempt Count
