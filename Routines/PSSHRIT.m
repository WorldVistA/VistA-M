PSSHRIT ;WOIFO/SG,PO - Transmits a "ping" to determine if FDB server is down and record the down time ;7/30/2008
 ;;1.0;PHARMACY DATA MANAGEMENT;**136**;9/30/97;Build 89
 ;
 ;External reference to IN^PSSHRQ2 supported by DBIA 5369
 ;
 Q
PINGCHK ; do ping test, if not passed record it and send a message.
 ; Called from PSS INTERFACE SCHEDULER option
 N STATUS
 F  L +^PS(59.74,"PINGCHK^PSSHRIT"):1 Q:$T
 S STATUS=$$PINGTST()
 S STATUS=$$PINGFILE(STATUS)
 I STATUS=-1 D SMSGDWN   ; if failed for the first time (a new entry created) send a message that interface is down.
 L -^PS(59.74,"PINGCHK^PSSHRIT")
 Q
 ;
PINGTST() ; test the ping by sending a ping request.
 ;return 0 - ping successful,  -1^reason  ping failed
 N BASE,STATUS
 S BASE="PINGTST^"_$T(+0)
 K ^TMP($J,BASE)
 S ^TMP($J,BASE,"IN","PING")=""
 D IN^PSSHRQ2(BASE)
 S STATUS=$G(^TMP($J,BASE,"OUT",0))
 K ^TMP($J,BASE)
 Q STATUS
 ;
PINGFILE(STATUS) ;  file the ping results
 ; Input
 ;   Status - Ping results
 ; Return 
 ;     -1 - if creates an entry - means the first it noticed PEPS is unavailable
 ;      0 - if does not create/update a record, 
 ;      1 - if updates the last entry
 N LIEN,LASTAVL
 S STATUS=+$G(STATUS)
 S LIEN=+$O(^PS(59.74,":"),-1)           ; get last entry
 S LASTAVL=$P($G(^PS(59.74,LIEN,0)),U,2) ; get last available date/time
 I STATUS=0,'LIEN Q 0                          ; do nothing
 I STATUS=0,LIEN,LASTAVL Q 0                   ; do nothing
 I STATUS=0,LIEN,'LASTAVL D UPDATENT(LIEN) Q 1 ; update file
 I STATUS=-1,LIEN,LASTAVL D NEWENT Q -1        ; create new entry
 I STATUS=-1,'LIEN D NEWENT Q -1               ; create new entry
 Q 0
NEWENT ; create a new entry in FDB INTERFACE DATA (#59.74) file.
 N DIC,DO
 S X=$$NOW^XLFDT(),DIC="^PS(59.74,",DIC(0)="Z" D FILE^DICN
 K X,Y
 Q
 ;
UPDATENT(LAST) ; update the last entry in FDB INTERFACE DATA (#59.74) file.
 ;edit flag once it is created.
 N DIE,NEWVAL,DWNTIME,DA,DR,DIFF
 S DA=LAST
 S NEWVAL=$$NOW^XLFDT()   ;$$NOW()
 S DWNTIME=+$G(^PS(59.74,DA,0))
 Q:'DWNTIME
 S DIFF=$$FMDIFF^XLFDT(NEWVAL,DWNTIME,2)
 S DIFF=DIFF\60  ;IN MINUTES
 S DIE="^PS(59.74,",DR="1///^S X=NEWVAL;2///^S X=DIFF"
 D ^DIE
 D SMSGRST  ; send a message that interface connection is restored
 Q
 ;
SMSGDWN ; send a bulletin that Interface connection is down.
 N XMB,XMTEXT,XMY,PSFDB,XMV,XMDUN,XMDUZ
 S XMDUZ="PSS INTERFACE SCHEDULER"
 S XMB="PSS FDB INTERFACE"
 S XMTEXT="PSFDB"
 ; check to if dosing check is on.
 I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI() D
 .S PSFDB(1)="Connection to Vendor Database is down!  No Drug-Drug Interaction, Duplicate"
 .S PSFDB(2)="Therapy or Dosing Order Checks will be performed until the connection is"
 .S PSFDB(3)="reestablished!!!"
 E  D
 .S PSFDB(1)="Connection to Vendor Database is down!  No Drug-Drug Interaction or Duplicate"
 .S PSFDB(2)="Therapy Order Checks will be performed until the connection is reestablished!!!"
 S XMY("G.PSS ORDER CHECKS")=""
 D ^XMB
 Q
 ;
SMSGRST ; send a bulletin that Interface connection is restored
 N XMB,XMTEXT,XMY,PSFDB,XMV,XMDUN,XMDUZ
 S XMDUZ="PSS INTERFACE SCHEDULER"
 S XMB="PSS FDB INTERFACE RESTORED"
 S XMTEXT="PSFDB"
 ; check to if dosing check is on.
 I $T(DS^PSSDSAPI)]"",$$DS^PSSDSAPI() D
 .S PSFDB(1)="Connection to Vendor Database has been restored! Drug-Drug Interactions,"
 .S PSFDB(2)="Duplicate Therapy and Dosing Order Checks can now be performed."
 E  D
 .S PSFDB(1)="Connection to Vendor Database has been restored! Drug-Drug Interactions or"
 .S PSFDB(2)="Duplicate Therapy Order Checks can now be performed."
 S XMY("G.PSS ORDER CHECKS")=""
 D ^XMB
 Q
 ;
TASKIT(FREQ,START) ; create/update scheduling option start time and frequency
 ; Input:
 ;   FREQ  - Optional - rescheduling frequency in minutes (default 15 minutes)
 ;  START  - Optional - start time (default is current time + 4 minutes)
 ; Note: if START is less than 4 minutes in future,  it will be defaulted to 
 ;       current time + 4 minutes.
 ;
 K PSERROR
 S FREQ=$G(FREQ,15)
 S FREQ=FREQ*60_"S"
 S START=$G(START,$$NOW^XLFDT())
 ;
 ; if start date/time is less than 4 minutes in future make it 4 minutes from now
 S:$$FMDIFF^XLFDT(START,$$NOW^XLFDT(),2)<240 START=$$FMADD^XLFDT($$NOW^XLFDT(),0,0,4)
 ;
 ; create the option schedule if it does not exist. return PSERROR=-1 if fails.
 ; in some situation when it fails, does not create the PSERROR variable
 D RESCH^XUTMOPT("PSS INTERFACE SCHEDULER",START,"",FREQ,"L",.PSERROR)
 Q
 ;
SCHDOPT ; edit option scheduling
 ; Called from "PSS SCHEDULE PEPS INTERFACE CK" option to create and/or edit the scheduling
 ; parameters for "PSS INTERFACE SCHEDULER" option in OPTION SCHEDULING file. 
 ; The "PSS SCHEDULE PEPS INTERFACE CK" option is installed by PAS*1.0*117 package.
 N PSSROOT
 ; check to see if the option is defined in option scheduler file and it is tasked.
 ; if not create and task the option.
 D OPTSTAT^XUTMOPT("PSS INTERFACE SCHEDULER",.PSSROOT)
 I '+$G(PSSROOT(1)) D TASKIT(15)
 ;
 D EDIT^XUTMOPT("PSS INTERFACE SCHEDULER")
 Q
 ;
SLASTRUN(LASTRUN) ; set last run time
 N SUB,PURGE,NOW,DESC
 S DESC="This stores the latest data on FDB interface"
 S NOW=$$NOW^XLFDT()\1
 S PURGE=$$FMADD^XLFDT(NOW,30)
 S ^XTMP("PSSRUN",0)=PURGE_U_NOW_U_DESC
 S ^XTMP("PSSRUN","LASTRUN")=LASTRUN
 Q
 ;
GLASTRUN() ; get last run time
 Q $G(^XTMP("PSSRUN","LASTRUN"))
 ;
RUNTEST ; run interaction test to PEPS server
 ; called from PSS CHECK PEPS SERVICES SETUP option
 D KILL^XUSCLEAN
 N STATUS,X
 S STATUS=$$CONCHK()
 D PRSRTN Q:(STATUS=0)!(X="^") 
 ;
 S STATUS=$$INTERACT()
 D PRSRTN Q:X="^" 
 ;
 S STATUS=$$DUPTHRPY()
 D PRSRTN Q:X="^" 
 ;
 S STATUS=$$DOSECHK() ;
 D PRSRTN Q:X="^" 
 ;
 S STATUS=$$CUSTOM()
 D PRSRTN Q:X="^" 
 Q
 ;
CONCHK() ; check connection
 ; Return 1 if OK, 0 if not OK.
 ; 
 N MESSAGE,Y,STATUS,RESULT
 W !,"Checking Vendor Database Connection"
 S RESULT=$$PINGTST()
 I RESULT=0 D
 .W "...OK"
 E  D
 .W "...",!!,"    Connection could not be made to Vendor database."
 .S Y=$$GLASTRUN()
 .I Y D
 ..D DD^%DT                      ; convert last reached time in Y to external format
 ..W !,"       Last reached @"_$E(Y,1,18)
 W !
 Q $S(RESULT=0:1,1:0)
 ; 
INTERACT() ; check drug-drug interaction.
 ; Return 1 if OK, 0 if not OK.
 ;
 N PSORDER,PSDRUG1,PSDRUG2,BASE,INFO,INTRO,PSSPEC
 N PSSLEFT S PSSLEFT=4     ; left margin for results
 S BASE=$T(+0)_" INTERACT"
 K ^TMP($J,BASE)
 S ^TMP($J,BASE,"IN","DRUGDRUG")=""
 S PSORDER="I;1464P;PROSPECTIVE;2",PSDRUG1="WARFARIN 10MG TAB",PSDRUG2="ASPIRIN 325MG TAB"
 SET ^TMP($JOB,BASE,"IN","PROSPECTIVE","I;1464P;PROSPECTIVE;2")="6559^4005201^^WARFARIN 10MG TAB"
 SET ^TMP($JOB,BASE,"IN","PROSPECTIVE","I;91464P;PROSPECTIVE;2")="4376^4005735^^ASPIRIN 325MG TAB"
 D IN^PSSHRQ2(BASE)
 ;
 S INTRO="Performing Drug-Drug Interaction Order Check for "_PSDRUG2_" and "_PSDRUG1
 S INFO=$G(^TMP($J,BASE,"OUT","DRUGDRUG","S",PSDRUG1,PSORDER,1,"PMON",9,0))
 S INTRO=INTRO_$S($L(INFO):"...OK",1:"...Not OK")
 W !
 I '$L(INFO) D
 .D OUTPUT(INTRO)
 .W ! D OUTPUT("Drug-Drug Interaction Order Check could not be performed.",PSSLEFT)
 E  D
 . D OUTPUT(INTRO)
 . W !
 . S PSSPEC("CLINICAL EFFECTS:  ")=""
 . S INFO=$$REPLACE^XLFSTR(INFO,.PSSPEC)
 . S INFO="Significant Drug Interaction: "_INFO
 . D OUTPUT(INFO,PSSLEFT)
 ;
 K ^TMP($J,BASE)
 Q $S($L(INFO)=0:0,1:1)
 ;
DUPTHRPY() ; check duplicate therapy
 ; Return 1 if OK, 0 if not OK.
 ; 
 N PSORDER,PSDRUG1,PSDRUG2,BASE,CLAS1,CLAS2,LINE1,LINE2,INTRO
 N PSSLEFT S PSSLEFT=4     ; left margin for results
 S BASE=$T(+0)_" DUPTHRPY"
 K ^TMP($J,BASE)
 S ^TMP($J,BASE,"IN","THERAPY")=""
 S PSORDER="O;403931;PROFILE;3"
 S PSDRUG1="CIMETIDINE 300MG TAB"
 S PSDRUG2="RANITIDINE 150MG TAB"
 S ^TMP($J,BASE,"IN","PROFILE","O;403931;PROFILE;3")="11666^4006826^^CIMETIDINE 300MG TAB^O"
 S ^TMP($J,BASE,"IN","PROSPECTIVE","Z;1;PROSPECTIVE;1")="11673^4007038^^RANITIDINE 150MG TAB"
 D IN^PSSHRQ2(BASE)
 ; 
 S CLAS1=$G(^TMP($J,BASE,"OUT","THERAPY",1,1,"CLASS"))
 S CLAS2=$G(^TMP($J,BASE,"OUT","THERAPY",1,2,"CLASS"))
 S INTRO="Performing Duplicate Therapy Order Check for "_PSDRUG1_" and "_PSDRUG2
 S INTRO=INTRO_$S($L(CLAS1):"...OK",1:"...Not OK")
 W !
 D OUTPUT(INTRO)
 I '$L(CLAS1) D
 .W !
 .D OUTPUT("Duplicate Therapy Order Check could not be performed.",PSSLEFT)
 E  D
 .S LINE1="Therapeutic Duplication with "_PSDRUG1_" and "_PSDRUG2
 .S LINE2="Duplicate Therapy Class(es): "_CLAS1_","_CLAS2
 .W !
 .D OUTPUT(LINE1,PSSLEFT)
 .D OUTPUT(LINE2,PSSLEFT)
 ;
 Q $S($L(CLAS1)=0:0,1:1)
 ;
DOSECHK() ; check dosing
 ; Return 1 if OK, 0 if not OK.
 N TOTAL,SINGLE,INTRO,ORDER,PSDRUG1,PSDRUG2,BASE
 N PSSLEFT S PSSLEFT=4     ; left margin for results
 S BASE=$T(+0)_" DOSECHK"
 S ORDER="O;1464P;PROSPECTIVE;2"
 S PSDRUG1="ACETAMINOPHEN 500MG TAB"
 K ^TMP($J,BASE)
 S ^TMP($J,BASE,"IN","DOSE")=""
 SET ^TMP($J,BASE,"IN","DOSE","AGE")=5000
 SET ^TMP($J,BASE,"IN","DOSE","WT")=83.01
 SET ^TMP($J,BASE,"IN","DOSE","BSA")=1.532
 ;VALUES: GCN^VUID^IEN^NAME^DOSE AMOUNT^DOSE UNIT^DOSE RATE^FREQ^DURATION^DURATION RATE^ROUTE^DOSE TYPE^SPECIFIC
 S ^TMP($J,BASE,"IN","DOSE","O;1464P;PROSPECTIVE;2")="4490^4007154^^ACETAMINOPHEN 500MG TAB^3000^MILLIGRAMS^DAY^Q4H^10^DAY^ORAL^MAINTENANCE^1"
 S ^TMP($J,BASE,"IN","PROSPECTIVE","O;1464P;PROSPECTIVE;2")="4490^4007154^^ACETAMINOPHEN 500MG TAB^O"
 D IN^PSSHRQ2(BASE)
 ;
 S TOTAL=$G(^TMP($J,BASE,"OUT","DOSE",ORDER,PSDRUG1,"RANGE","MESSAGE",0))
 S SINGLE=$G(^TMP($J,BASE,"OUT","DOSE",ORDER,PSDRUG1,"SINGLE","MESSAGE",0))
 S INTRO="Performing Dosing Order Check for "_PSDRUG1_" - 3000MG Q4H"_$S($L(TOTAL):"...OK",1:"...Not OK")
 I '$L(TOTAL) D
 .D OUTPUT(INTRO)
 .W !
 .D OUTPUT("Dosing Order Check could not be performed.",PSSLEFT)
 E  D
 .W !
 .D OUTPUT(INTRO)
 .W !
 .D OUTPUT(SINGLE,PSSLEFT)
 .W !
 .D OUTPUT(TOTAL,PSSLEFT)
 Q $S($L(TOTAL)=0:0,1:1)
 ;
CUSTOM() ; check custom drug-drug interaction
 ; Return 1 if OK, 0 if not OK.
 ;
 N INFO,INTRO,ORDER,DRUG1,DRUG2,BASE,STATUS,PSSPEC
 N PSSLEFT S PSSLEFT=4     ; left margin for results
 S BASE=$T(+0)_" CUSTOM"
 S ORDER="Z;1;PROSPECTIVE;1"
 S DRUG1="CLARITHROMYCIN 250MG TAB",DRUG2="DIAZEPAM 5MG TAB"
 K ^TMP($J,BASE)
 S ^TMP($J,BASE,"IN","DRUGDRUG")=""
 S ^TMP($J,BASE,"IN","PROSPECTIVE","Z;1;PROSPECTIVE;1")="16373^4010075F^^CLARITHROMYCIN 250MG TAB"
 S ^TMP($J,BASE,"IN","PROFILE","I;10U;PROFILE;10")="3768^40002216^^DIAZEPAM 5MG TAB"
 D IN^PSSHRQ2(BASE)
 ;
 S STATUS=$G(^TMP($J,BASE,"OUT",0))
 S INTRO="Performing Custom Drug-Drug Interaction Order Check for "_DRUG1_" and "_DRUG2
 D SCUST
 S INTRO=INTRO_$S($L(INFO):"...OK",STATUS=0:"...OK",1:"...Not OK")
 I '$L(INFO) D
 .D OUTPUT(INTRO)
 .I STATUS'=0 W ! D OUTPUT("Custom Drug-Drug Interaction Order Check could not be performed.",PSSLEFT)
 E   D
 . W !
 . D OUTPUT(INTRO)
 . W !
 . S PSSPEC("CLINICAL EFFECTS:  ")=""
 . S INFO=$$REPLACE^XLFSTR(INFO,.PSSPEC)
 .S INFO="Significant Drug Interaction: "_INFO
 .D OUTPUT(INFO,PSSLEFT)
 W !
 Q $S(STATUS=0:1,$L(INFO)=0:0,1:1)
 ;
 ;
INTACT ; check vendor data base link
 ; Called from CHECK VENDOR DATABASE LINK  option
 N STATUS,PSFIN,BASE,STATUS,Y
 S BASE="PSPRE"
 K ^TMP($J,BASE)
 S ^TMP($J,BASE,"IN","PING")=""
 D IN^PSSHRQ2(BASE)
 S STATUS=+$G(^TMP($J,BASE,"OUT",0))
 I STATUS=0 D
 .W !
 .W !,"  Database Version: ",$G(^TMP($J,BASE,"OUT","difBuildVersion"))
 .W !,"     Build Version: ",$G(^TMP($J,BASE,"OUT","difDbVersion"))
 .S Y=$G(^TMP($J,BASE,"OUT","difIssueDate"))
 .S:Y?8N Y=$E(Y,5,6)_"/"_$E(Y,7,8)_"/"_$E(Y,1,4)
 .W !,"        Issue Date: ",Y,!
 .;
 .W !,"  Custom Database Version: ",$G(^TMP($J,BASE,"OUT","customBuildVersion"))
 .W !,"     Custom Build Version: ",$G(^TMP($J,BASE,"OUT","customDbVersion"))
 .S Y=$G(^TMP($J,BASE,"OUT","customIssueDate"))
 .S:Y?8N Y=$E(Y,5,6)_"/"_$E(Y,7,8)_"/"_$E(Y,1,4)
 .W !,"        Custom Issue Date: ",Y,!
 .;
 .S Y=$$NOW^XLFDT()
 .D DD^%DT                       ; convert current time in Y to external format.
 .W !,"Connected to Vendor database successfully @",$E(Y,1,18)
 E  D
 .W !,"Connection could not be made to Vendor database."
 .S Y=$$GLASTRUN()
 .IF Y D
 ..D DD^%DT                      ; convert last reached time in Y to external format.
 ..W !,"  Last reached @"_$E(Y,1,18)
 ;
 D PRSRTN
 Q
 ;
 ;----------------------------------------------------
 ;
PRSRTN ;
 ;calls std routine to ask user to hit return 
 N DIR S DIR(0)="E" D ^DIR
 Q
 ;
PING(BASE) ;
 K ^TMP($J,BASE)
 S ^TMP($J,BASE,"IN","PING")=""
 D IN^PSSHRQ2(BASE)
 Q
 ;
HRSMIN(MIN) ;
 ; Called from output transform of VENDOR INTERFACE DATA FILE (#59.54) field TOTAL TIME NOT AVAILABLE (field# 2)
 ;INPUTS: MIN-TIME IN MINUTES
 ;RETURNS HRS AND MINUTES
 N HRS,MINHR,HRSMIN
 S HRSMIN=""
 S MINHR=60     ;TOTAL # OF MIN IN AN HR
 S HRS=MIN\MINHR,MIN=MIN#MINHR
 I HRS S HRSMIN=HRS_" HR"_$S(HRS>1:"S",1:"")
 I MIN S HRSMIN=HRSMIN_$S(HRSMIN:", ",1:"")_MIN_" MINUTE"_$S(MIN>1:"S",1:"")
 Q HRSMIN
 ;
OUTPUT(INFO,DIWL) ;
 K ^UTILITY($J,"W")
 N DIWR,DIWF,DIW,DIWT,X
 S DIWL=$G(DIWL,1)
 S X=INFO,DIWR=$S($G(IOM):IOM,1:60),DIWF="W" D ^DIWP
 D ^DIWW
 Q
 ;
 ;
SCUST ;Set Custom info
 I $D(^TMP($J,BASE,"OUT","DRUGDRUG","S",DRUG1,ORDER,1)) S INFO=$G(^TMP($J,BASE,"OUT","DRUGDRUG","S",DRUG1,ORDER,1,"PMON",9,0)) Q
 I $D(^TMP($J,BASE,"OUT","DRUGDRUG","S",DRUG2,"I;10U;PROFILE;10",1)) S INFO=$G(^TMP($J,BASE,"OUT","DRUGDRUG","S",DRUG2,"I;10U;PROFILE;10",1,"PMON",9,0)) Q
 S INFO=""
 Q
