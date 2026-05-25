PSOUTOR ;HPS/DSK - MEDICATION ORDER STATUS CHECK; Oct 22, 2024@10:20
 ;;7.0;OUTPATIENT PHARMACY;**546,775**;DEC 1997;Build 1
 ;
 ;Reference to:                     Supported by:
 ;-------------                     -------------
 ;^OR(100                           IA #3582
 ;DISPLAY GROUP (#100.98) file      IA #873
 ;ORDER STATUS (#100.01) file       IA #875
 ;ORDERABLE ITEMS (#101.43) file    IA #5430
 ;DRUG (#50) file                   IA #221
 ;PHARMACY PATIENT (#55) file       IA #6987
 ;^XLFDT                            IA #10103
 ;DD^%DT                            IA #10003
 ;NOW^%DTC                          IA #10000
 ;^%ZTLOAD                          IA #10063
 ;STATUS^ORCSAVE2                   IA #5903
 ;$$SETUP1^XQALERT                  IA #10081
 ;NOTE: SACC guidelines allow lowercase subscripts in ^TMP and ^XTMP.
 ;
 ;PSO*7.0*775: Deleted requirement that start date precede login date
 ;             of first IEN in the ORDERS (#100) file. The lowest IEN
 ;             may not necessarily correspond to the install of CPRS.
 ;
 ;Search Logic
 ;============
 ;
 ;This routine searches for discontinued medication orders with discontinued 
 ;or expired statuses which are still active in the ORDERS (#100) file.
 ;
 ;^XTMP Subscript Logic
 ;=====================
 ;
 ;Subscripts in ^XTMP are set with verbiage that will aid anyone who reviews the search
 ;results as to the issues which were found.  Data is kept in ^XTMP for 60 days.
 ;
 ;MailMan Message / Alert Logic
 ;=============================
 ;
 ;MailMan messages and an alert are generated to the user who invoked the search option. 
 ;
 Q
 ;
EN ;Status Mismatch Search
 N DIR,DTOUT,DUOUT,Y,PSOQUIT,PSOSDT,PSOEDT,PSOTYP,PSOCORR,PSOVER,PSODUZ,PSOAR
 S PSOQUIT=0,PSODUZ=""
 ;
 ;PSOAR used for user display and MailMan messaging
 S PSOAR("I")="Inpatient",PSOAR("O")="Outpatient",PSOAR("N")="Non-VA"
 S PSOAR("IO")="Inpatient and Outpatient",PSOAR("IN")="Inpatient and Non-VA"
 S PSOAR("ON")="Outpatient and Non-VA",PSOAR("ION")="All"
 D ASK
 I PSOQUIT D QUIT Q
 D VER
 I PSOQUIT D QUIT Q
 ;Check for PSODUZ because at this point PSOQUIT might be 0
 ;if user kept re-answering prompts and cycling through without
 ;verifying all answers were correct
 I PSODUZ]"" D TASK
 Q
 ;
ASK ;
 W !!,"NOTE: Because of the potential for journaling or other system"
 W !,"issues, you may not want to search large date ranges at one time."
 W !,"This search routine limits the search to a year's worth of orders,"
 W !,"but that might still be too large of a date range depending on"
 W !,"your order volume.",!
 S DIR(0)="DO",DIR("A")="Date to begin search"
 D ^DIR
 I $G(Y)=""!($D(DTOUT))!($D(DUOUT)) S PSOQUIT=1 Q
 S PSOSDT=$P(Y,".")
 D DD^%DT W ?40,$G(Y)
 S DIR(0)="DO",DIR("A")="Date to end search  "
 D ^DIR
 I $G(Y)=""!($D(DTOUT))!($D(DUOUT)) S PSOQUIT=1 Q
 S PSOEDT=$P(Y,".")
 I PSOSDT>PSOEDT D  G ASK
 . W !,?5,"The start date cannot be greater than the end date.",!
 D DD^%DT W ?40,$G(Y)
 I $$FMDIFF^XLFDT(PSOEDT,PSOSDT)>365 D  G ASK
 . W !!,"A maximum of a year's worth of orders may be searched due to"
 . W !,"potential journaling or other system issues."
 W !!,"Search Inpatient, Outpatient, Non-VA, or a combination of order types?"
 W !,"(IV Medications are included in an Inpatient search.)"
 W !,"(""Inpatient"" and ""Outpatient"" refer to the order dialog used,"
 W !," not the patient's status.)"
 K DIR S DIR(0)="SO^I:"_PSOAR("I")_";O:"_PSOAR("O")_";N:"_PSOAR("N")_";IN:"_PSOAR("IN")
 S DIR(0)=DIR(0)_";ON:"_PSOAR("ON")_";A:All"
 D ^DIR
 I $G(Y)=""!($D(DTOUT))!($D(DUOUT)) S PSOQUIT=1 Q
 S PSOTYP=$S(Y="A":"ION",1:Y)
 ;
 W !!,"INSTRUCTIONS FOR NEXT PROMPT"
 W !,"============================"
 W !!," * If a medication is expired or discontinued in the associated"
 W !,"   medication file (PRESCRIPTION (#52) file or PHARMACY PATIENT (#55) file)"
 W !,"   this routine could correct the ORDERS (#100) file status to expired"
 W !,"   or discontinued if the ORDERS (#100) file status is active."
 W !!," * Initially answer the prompt ""Should the status in the ORDERS (#100) file"
 W !,"   be corrected automatically?"" with ""NO"" to let the routine search to see"
 W !,"   how many affected orders exist per date range. Then check a few in CPRS"
 W !,"   and FileMan."
 W !!," * After running the search option again and answering the following prompt"
 W !,"   with ""Y"", verify that those orders have been corrected."
 W !!,"Should the status in the ORDERS (#100) file"
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="be corrected automatically"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S PSOQUIT=1 Q
 S PSOCORR=+Y
 Q
 ;
VER ;
 W !!,"PLEASE VERIFY:",!
 W !,?5,"Date to begin search: "
 S Y=PSOSDT D DD^%DT W ?34,Y
 W !,?5,"Date to end search:   "
 S Y=PSOEDT D DD^%DT W ?34,Y
 W !!,?5,"Type(s) of orders to search: ",PSOAR(PSOTYP)
 W !!,?5,"ORDERS (#100) file status ",$S(PSOCORR:"*** WILL ***",1:"*** WILL NOT ***")," be corrected automatically.",!
 S DIR(0)="Y",DIR("B")="NO"
 W ! S DIR("A")="Are these selections correct"
 D ^DIR K DIR
 I $G(Y)=0 W !! G EN
 I $D(DTOUT)!($D(DUOUT)) S PSOQUIT=1 Q
 S PSODUZ=DUZ
 Q
 ;
QUIT ;
 Q:$D(^TMP("PSOQUIT",$J))
 ;
 ;setting ^XTMP("PSOQMSG",$J) since otherwise this message might display twice
 ;depending on how often user reviewed prompt choices before deciding to quit
 ;Need to use ^XTMP instead of variable check because user might review multiple times
 ;^TMP("PSOQUIT",$J) is killed as an "EXIT ACTION" after exiting the option.
 ;
 S ^TMP("PSOQUIT",$J)=""
 W !!,"Exiting... Re-enter option if you wish to perform the search."
 W !!,"There will be no MailMan message and alert generated"
 W !,"due to early termination of this option.",!!
 Q
 ;
TASK ;
 S ZTSAVE("PSOSDT")=""
 S ZTSAVE("PSOEDT")=""
 S ZTSAVE("PSOTYP")=""
 S ZTSAVE("PSOCORR")=""
 S ZTSAVE("PSODUZ")=""
 S ZTSAVE("PSOAR(")=""
 S ZTRTN="INIT^PSOUTOR"
 S ZTDESC="Medication File(s) Status Search"
 S ZTIO=""
 D ^%ZTLOAD
 W:$D(ZTSK) !!,?5,"Medication File(s) Status Search - TASK NUMBER: ",$G(ZTSK)
 W !!,"You will receive an alert and a MailMan message when the search completes.",!
 Q
 ;
INIT ;
 N PSOOREXP,PSOORDIS,PSOORDISED,PSOACTIVE,PSORD,PSOSUB,PSODIAL
 N PSOOUTP,PSOINPAT,PSIV,PSONONVA,PSOMSTAT
 S PSOOREXP=$O(^ORD(100.01,"B","EXPIRED",""))
 S PSOORDIS=$O(^ORD(100.01,"B","DISCONTINUED",""))
 S PSOORDISED=$O(^ORD(100.01,"B","DISCONTINUED/EDIT",""))
 S PSOACTIVE=$O(^ORD(100.01,"B","ACTIVE",""))
 I PSOTYP["O" D
 . S PSOSUB=$O(^ORD(100.98,"B","OUTPATIENT MEDICATIONS","")) Q:PSOSUB=""
 . S PSOOUTP=PSOSUB
 . S PSODIAL(PSOSUB)=""
 I PSOTYP["I" D
 . ;Unknown when "INPATIENT MEDICATIONS" is set vs IV or UD, but setting in array anyway
 . F PSORD="INPATIENT MEDICATIONS","IV MEDICATIONS","UNIT DOSE MEDICATIONS" D
 . . S PSOSUB=$O(^ORD(100.98,"B",PSORD,"")) Q:PSOSUB=""
 . . S PSODIAL(PSOSUB)=""
 . . I PSORD="IV MEDICATIONS" S PSIV=PSOSUB Q
 . . S PSOINPAT(PSOSUB)=""
 I PSOTYP["N" D
 . S PSONONVA=$O(^ORD(100.98,"B","NON-VA MEDICATIONS",""))
 . I PSONONVA]"" S PSODIAL(PSONONVA)=""
 ;Set array of Med (#52 or #55) statuses
 ;(Except for non-VA)
 S PSOMSTAT(0)="Active"
 S PSOMSTAT(1)="Non-Verified"
 S PSOMSTAT(2)="Refill"
 S PSOMSTAT(3)="Hold"
 S PSOMSTAT(4)="Drug Interactions"
 S PSOMSTAT(5)="Suspended"
 S PSOMSTAT(10)="Done"
 S PSOMSTAT(11)="Expired"
 S PSOMSTAT(12)="Discontinued"
 S PSOMSTAT(13)="Deleted"
 S PSOMSTAT(14)="DC/Provider"
 S PSOMSTAT(15)="DC/Edit"
 S PSOMSTAT(16)="Provider Hold"
 S PSOMSTAT("A")="Active"
 S PSOMSTAT("D")="Discontinued"
 S PSOMSTAT("DE")="DC/Edit"
 S PSOMSTAT("DR")="DC/Renewal"
 S PSOMSTAT("H")="Hold"
 S PSOMSTAT("E")="Expired"
 S PSOMSTAT("R")="Renewed"
 S PSOMSTAT("RE")="Reinstated"
 S PSOMSTAT("P")="Purge"
 S PSOMSTAT("O")="On Call"
 S PSOMSTAT("N")="Non Verified"
 D SEARCH
 Q
 ;
SEARCH ;
 N PSOTMP,X,PSOJOB,PSNUM,PSOORD,PSOORSTAT,PSOPAUSED,PSMSTAT,PSOPAT,PSOA
 N PSOSTART,PSOORTYPE,PSOORD,PSOSUBN,PSOSTR,PSOWHICH,PSOMESNUM
 N PSOOI,PSOIV,PSOPKG,PSODRUG,PSODATEA,PSODATEB,PSOTX
 S PSOTMP="PSOUTOR "_$J
 I $D(^XTMP(PSOTMP)) D
 . S PSOJOB=$J
 . F PSOA=1:1:500 Q:'$D(^XTMP(PSOTMP))  D
 . . S PSOJOB=PSOJOB+1
 . . S PSOTMP="PSOUTOR "_PSOJOB
 ;
 ;not checking to see if the 500th attempt is unused
 ;surely this routine won't be run 500 times using the
 ;same job number within 60 days
 ;
 S ^XTMP(PSOTMP,0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^MEDICATION FILE SEARCH"
 ;Note: The "A" subscript is necessary because follow-up patch PSO*7.0*599 will
 ;      set another subscript for an additional type of search.
 S ^XTMP(PSOTMP,"A")="ORDERS (#100) file status = active / Medication file status not active"
 ;
 ;Setting "1" subscript to "No issues found" initially.
 S ^XTMP(PSOTMP,"A",1)="No issues found."
 ;
 S PSOA=0,(PSOPAUSED,PSOSTART)=PSOSDT,PSOEDT=PSOEDT+1
 S PSOORD=""
 F  S PSOSDT=$O(^OR(100,"AF",PSOSDT)) Q:PSOSDT>PSOEDT  Q:PSOSDT=""  D
 . ;pause between every 30 days of data
 . I PSOPAUSED'=$P(PSOSDT,"."),$E($P(PSOSDT,"."),6,7)#30=0 D
 . . H 5 S PSOPAUSED=$P(PSOSDT,".")
 . . ;setting "PAUSE" level in case a developer is monitoring the search
 . . ;and would like to know how far along the search is
 . . S ^XTMP(PSOTMP,"PAUSE")=PSOPAUSED
 . F  S PSOORD=$O(^OR(100,"AF",PSOSDT,PSOORD)) Q:PSOORD=""  D
 . . ;
 . . ;Quit if this order number has been evaluated in this session
 . . ;There can be multiple entries for each order in the "AF" subscript.
 . . Q:$D(^XTMP(PSOTMP,"DONE",PSOORD))
 . . S ^XTMP(PSOTMP,"DONE",PSOORD)=""
 . . ;
 . . S PSOORTYPE=$P($G(^OR(100,PSOORD,0)),"^",11) Q:PSOORTYPE=""
 . . Q:'$D(PSODIAL(PSOORTYPE))
 . . S PSOORSTAT=$P($G(^OR(100,PSOORD,3)),"^",3)
 . . ;
 . . S PSOPAT=$P($P(^OR(100,PSOORD,0),"^",2),";") Q:'PSOPAT
 . . ;
 . . ;Non-VA Medications (both Inpatient and Outpatient non-VA meds are stored in file 55)
 . . I PSOORTYPE=$G(PSONONVA) D NONVA Q
 . . ;Outpatient
 . . I PSOORTYPE=$G(PSOOUTP) D OP Q
 . . ;IV
 . . I PSOORTYPE=$G(PSIV) D IV Q
 . . ;Unit Dose
 . . I $D(PSOINPAT(PSOORTYPE)) D UD
 ;
 S PSOMESNUM=$$MAIL^PSOUTOR1()
 D ALERT,KILL
 S ^XTMP(PSOTMP,"FINISHED")=""
 Q
 ;
NONVA ;Non-VA medication order evaluation
 S PSNUM=$P($G(^OR(100,PSOORD,4)),"^") Q:PSNUM=""
 ;
 ;Package reference for non-VA - numeric plus "N"
 S PSOSUBN=$E(PSNUM,1,$L(PSNUM)-1) Q:PSOSUBN=""
 S PSOSTR=$G(^PS(55,PSOPAT,"NVA",PSOSUBN,0))
 ;
 ;Entry will not yet be in file 55 if pending
 ;(but also PSNUM will be null -- this is a double check)
 Q:PSOSTR=""
 ;
 ;Should be only one orderable item per non-VA order
 S PSOOI=$G(^OR(100,PSOORD,.1,1,0))
 S PSOOI=$P($G(^ORD(101.43,+PSOOI,0)),"^")
 S PSOPKG=$G(^OR(100,PSOORD,4))
 S PSODATEA=$P(PSOSTR,"^",10)
 S PSODRUG=$P(PSOSTR,"^",2)
 S PSODRUG=$P($G(^PSDRUG(+PSODRUG,0)),"^")
 S PSODATEB=$P(PSOSTR,"^",7)
 ;PSMSTAT will be null if active
 ;1=discontinued; 2=date of death entered
 S PSMSTAT=$P(PSOSTR,"^",6)
 S PSMSTAT=$S(PSMSTAT=2:"DC/Death",PSMSTAT=1:"Discontinued",1:"Active")
 ;
 ;Validate active file 100 status against file 55 status
 I PSOORSTAT=PSOACTIVE,$E(PSMSTAT)'="A" D
 . S PSOA=PSOA+1
 . I PSOCORR D FOUND
 . D XTMP("A","Non-VA")
 Q
 ;
OP ;Outpatient medication order evaluation
 S PSNUM=$P($G(^OR(100,PSOORD,4)),"^") Q:PSNUM=""
 ;
 ;Entry will not yet be in file 52 if order is pending
 Q:'$D(^PSRX(PSNUM))
 ;
 ;should only have one orderable item per outpatient med
 S PSOOI=$G(^OR(100,PSOORD,.1,1,0))
 S PSOOI=$P($G(^ORD(101.43,+PSOOI,0)),"^")
 S PSOPKG=$G(^OR(100,PSOORD,4))
 S PSODATEA=$P(^PSRX(PSNUM,0),"^",13)
 S PSODRUG=$P(^PSRX(PSNUM,0),"^",6)
 S PSODRUG=$P($G(^PSDRUG(+PSODRUG,0)),"^")
 S PSODATEB=$P($G(^PSRX(PSNUM,2)),"^",6)
 ;PRESCRIPTION (#52) File Status codes:
 ;  11 = Expired
 ;  12 = Discontinued
 ;  13 = Deleted
 ;  14 = Discontinued By Provider
 ;  15 = Discontinued (Edit)
 S PSMSTAT=$G(^PSRX(PSNUM,"STA"))
 I PSMSTAT]"" S PSMSTAT=$G(PSOMSTAT(PSMSTAT))
 ;
 ;Validate active file 100 status against file 55 status
 I PSOORSTAT=PSOACTIVE,($E(PSMSTAT)="E"!($E(PSMSTAT,1,2)="Di")!($E(PSMSTAT,1,2)="De")!($E(PSMSTAT,1,2)="DC")) D
 . S PSOA=PSOA+1
 . I PSOCORR,($E(PSMSTAT,1,2)="Di"!($E(PSMSTAT)="E")!($E(PSMSTAT,1,2)="De")!($E(PSMSTAT,1,2)="DC")) D FOUND
 . D XTMP("A","Outpatient")
 Q
 ;
IV ;IV order search
 S PSNUM=$P($G(^OR(100,PSOORD,4)),"^") Q:PSNUM=""
 ;
 S PSOSUBN=$E(PSNUM,1,$L(PSNUM)-1) Q:PSOSUBN=""
 S PSOSTR=$G(^PS(55,PSOPAT,"IV",PSOSUBN,0))
 ;
 ;PSOSTR will be null if order is pending
 Q:PSOSTR=""
 ;
 N PSOX
 ;partial text on IV components since there can be
 ;several - enough information is provided enabling
 ;sites to research
 S PSOX=0,(PSOOI,PSOIV)=""
 F  S PSOX=$O(^OR(100,PSOORD,.1,PSOX)) Q:'PSOX  D
 . S PSOOI=PSOOI_$S(PSOOI]"":";",1:"")
 . S PSOIV=$G(^OR(100,PSOORD,.1,PSOX,0))
 . S PSOOI=PSOOI_$P($G(^ORD(101.43,+PSOIV,0)),"^")
 S PSOOI=$E(PSOOI,1,14)
 S PSOPKG=$G(^OR(100,PSOORD,4))
 S PSODATEA=$P(PSOSTR,"^",2)
 S PSODRUG=$P($G(^PS(55,PSOPAT,"IV",PSOSUBN,"AD",1,0)),"^")
 S PSODRUG=$P($G(^PS(52.6,+PSODRUG,0)),"^")
 S PSODATEB=$P(PSOSTR,"^",3)
 S PSMSTAT=$P(PSOSTR,"^",17)
 I PSMSTAT]"" S PSMSTAT=$G(PSOMSTAT(PSMSTAT))
 ;
 ;Validate active file 100 status against file 55 status
 I PSOORSTAT=PSOACTIVE,$E(PSMSTAT)'="A" D
 . S PSOA=PSOA+1
 . I PSOCORR,($E(PSMSTAT)="D"!($E(PSMSTAT)="E")) D FOUND
 . D XTMP("A","IV")
 Q
 ;
UD ;Inpatient (unit dose) order search
 S PSNUM=$P($G(^OR(100,PSOORD,4)),"^") Q:PSNUM=""
 ;
 ;Years ago, IV orders were filed under the Unit Dose display group
 ;If an IV order, display under the IV section of the MailMan message.
 I $E(PSNUM,$L(PSNUM))="V" D IV
 Q:$E(PSNUM,$L(PSNUM))="V"
 S PSOSUBN=$E(PSNUM,1,$L(PSNUM)-1) Q:PSOSUBN=""
 S PSOSTR=$G(^PS(55,PSOPAT,5,PSOSUBN,0))
 ;
 ;PSOSTR will be null if order is pending
 Q:PSOSTR=""
 ;
 ;There might be multiple OI's, but just get the first one.
 ;User then has enough information to research the order.
 S PSOOI=$G(^OR(100,PSOORD,.1,1,0))
 S PSOOI=$P($G(^ORD(101.43,+PSOOI,0)),"^")
 S PSOPKG=$G(^OR(100,PSOORD,4))
 S PSODATEA=$P($G(^PS(55,PSOPAT,5,PSOSUBN,2)),"^",2)
 ;Retrieve the last dispense drug.
 S PSODRUG=$P($G(^PS(55,PSOPAT,5,PSOSUBN,1,0)),"^",3)
 S PSODRUG=$P($G(^PS(55,PSOPAT,5,PSOSUBN,1,+PSODRUG,0)),"^")
 S PSODRUG=$P($G(^PSDRUG(+PSODRUG,0)),"^")
 S PSODATEB=$P($G(^PS(55,PSOPAT,5,PSOSUBN,2)),"^",4)
 S PSMSTAT=$P(PSOSTR,"^",9)
 I PSMSTAT]"" S PSMSTAT=$G(PSOMSTAT(PSMSTAT))
 ;
 ;Validate active file 100 status against file 55 status
 I PSOORSTAT=PSOACTIVE,$E(PSMSTAT)'="A" D
 . S PSOA=PSOA+1
 . I PSOCORR,($E(PSMSTAT)="D"!($E(PSMSTAT)="E")) D FOUND
 . D XTMP("A","Unit Dose")
 Q
 ;
FOUND ;
 ;This section is only called if the Order (#100) status is active,
 ;the associated med (#52 or #55) status is expired or discontinued
 ;and the user specified that the order status should be updated.
 ;PSMSTAT = status of Med (#52 or #55) file
 ;PSOSTAT = which corresponding status should the Order (#100) entry
 ;          be set to
 N PSOSTAT
 S PSOSTAT=$S($E(PSMSTAT)="E":PSOOREXP,1:PSOORDIS)
 D STATUS^ORCSAVE2(PSOORD,PSOSTAT)
 Q
 ;
XTMP(PSOTX,PSOWHICH) ;
 ;PSOORDTM = WHEN ENTERED (#4) field from the Order (#100) file
 N PSOORDTM,PSOSTATX
 S PSOORDTM=$P(^OR(100,+PSOORD,0),"^",7)
 S PSOSTATX=$P($G(^ORD(100.01,+PSOORSTAT,0)),"^")
 S ^XTMP(PSOTMP,PSOTX,PSOWHICH,PSOORD)=$S(PSOTX'="A":"",PSOCORR:"fixed",1:"")_"^"_$$FMTE^XLFDT(PSOORDTM)_"^"_PSOOI_"^"
 S ^XTMP(PSOTMP,PSOTX,PSOWHICH,PSOORD)=^XTMP(PSOTMP,PSOTX,PSOWHICH,PSOORD)_PSOSTATX_"^"_PSOPKG_"^"_$$FMTE^XLFDT(PSODATEA)_"^"
 S ^XTMP(PSOTMP,PSOTX,PSOWHICH,PSOORD)=^XTMP(PSOTMP,PSOTX,PSOWHICH,PSOORD)_PSODRUG_"^"_PSMSTAT_"^"_$$FMTE^XLFDT(PSODATEB)
 Q
 ;
ALERT ;
 ;variables must be prefixed with "X"
 N XQAID,XALERT
 S (XQAID,XQAMSG)="Medication file search: "_$S(PSOA:"A",1:"No a")
 S XQAMSG=XQAMSG_"ffected order(s)"_" found. Message #:"_PSOMESNUM
 S XQA(PSODUZ)=""
 S XALERT=$$SETUP1^XQALERT
 Q
 ;
KILL ;
 K ^XTMP(PSOTMP,"PAUSE")
 ;gradually kill in case this file is huge
 N PSOCOUNT,PSOORD
 S PSOCOUNT=0,PSOORD=""
 F  S PSOORD=$O(^XTMP(PSOTMP,"DONE",PSOORD)) Q:PSOORD=""  D
 . S PSOCOUNT=PSOCOUNT+1
 . H:PSOCOUNT#10000=0 20
 . K ^XTMP(PSOTMP,"DONE",PSOORD)
 Q
 ;
