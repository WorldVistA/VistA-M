SCCVCST3 ;ALB/TMP - Scheduling Conversion Template Utilities - CST; APR 20, 1998
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
ONE ; -- Select/Convert one pt's encounter episode - no CST needed
 D FULL^VALM1
 ; -- is conversion enabled
 IF '$$OK^SCCVU(1) G ONEQ
 ;
 F  W !! Q:$$SEL1()
 ;
ONEQ S VALMBCK="R"
 Q
 ;
SEL1() ; Select an entry, convert
 N DIR,X,Y,SCFILE,SCFILE1,SCCVDFN,SCCVTYP,SCCVDA,SCCVCOD,SCQUIT,DA,DIC,DIQ,SCSTOP,SCCVEVT,SCPREF,Z,SCCVACRP,SCCV900,SCCVDIS
 S SCCVACRP=$$ENDDATE^SCCVU()
 S SCCV900=+$O(^DIC(40.7,"C",900,0))
 S SCSTOP=0
 S DIR(0)="SAMB^C:Convert;R:Reconvert",DIR("A")="(C)onvert/(R)econvert: ",DIR("B")="Convert"
 D ^DIR K DIR
 I Y["^" S SCSTOP=1 G SEL1Q
 S SCCVEVT=$S(Y="C":1,1:2),SCPREF=$S(SCCVEVT=1:"",1:"re")
 ;
 S DIR(0)="SABM^E:Encounter;D:Disposition;A:Appointment;S:Standalone Add/Edit",SCCVCOD=$P(DIR(0),U,2)
 S DIR("A")="TYPE OF ENTRY TO "_$S(SCCVEVT=1:"",1:"RE")_"CONVERT: ",DIR("?")="Select the type of entry you want to "_SCPREF_"convert from the list"
 D ^DIR K DIR
 I "EDAS"'[Y S SCSTOP=1 G SEL1Q
 S SCCVTYP=Y,SCCVTYPN=$P($P(SCCVCOD,SCCVTYP_":",2),";")
 ;
 S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC ;Select patient
 G:Y'>0 SEL1Q
 S SCCVDFN=+Y
 ;
 S SCFILE=$$SETFL($S(SCCVTYP="E":0,SCCVTYP="D":3,SCCVTYP="A":1,1:2),SCCVDFN)
 S SCFILE1=$S(SCFILE["SCE"!(SCFILE["SDV"):SCFILE_"("_$S(SCFILE["SCE":"""ADFN"","_SCCVDFN_",",1:""),1:$P(SCFILE,")")_",") ;Indirection format
 ;
 ; Select a specific entry
 S SCQUIT=0
 W !
 S DIR(0)=$S(SCFILE["SCE":"NAO^^I $P($G(^SCE(X,0)),U,2)'=SCCVDFN K X",SCFILE["SDV":"FAO^^D DTCNVT^SCCVCST3(.X)",1:"DAO^:"_SCCVACRP_":RXP")
 S DIR("A")="ENTER THE "_$S(SCFILE["SDV":"SCHEDULING VISIT ENTRY #",SCFILE["SCE":"ENCOUNTER ENTRY #",SCFILE["""DIS""":"DISPOSITION DATE/TIME",1:"APPOINTMENT DATE/TIME")_", IF KNOWN: "
 S DIR("?",1)="Enter the "_$S(SCFILE["SCE":"internal entry number",1:"date/time")_" of the "_SCCVTYPN_" to "_SCPREF_"convert, if you know it"
 S Z=2
 I SCFILE["SDV" S DIR("?",2)="Date may be entered in internal or external format",Z=Z+1
 S DIR("?",Z)="Must be a valid "_SCCVTYPN_$S(SCFILE'["SCE":" date/time",1:"")_" for the patient"_$S(SCFILE'["SCE":", on or before "_$$FMTE^XLFDT(SCCVACRP,"1D"),1:"")
 S DIR("?")="If not known, Press RETURN to review the "_SCCVTYPN_"s on a specific date"
 D ^DIR K DIR
 W !!
 ;
 S SCCVDA=$S(Y'>0:0,SCFILE'["""DIS""":+Y,1:9999999-Y)
 I SCCVDA D CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,$S(SCFILE'["SCE":+Y,1:+$G(^SCE(SCCVDA,0))),SCCVDA,0,.SCQUIT,.SCONE) ;Specific entry selected
 ;
 G:SCQUIT SEL1Q
 ;
 ; Select entry by date or date/time
 S DIR(0)="DAO^:"_SCCVACRP_":PTSX"
 S DIR("A")="DATE: "
 S DIR("?",1)="Enter a valid date or date and time of the patient's "_SCCVTYPN_" to "_SCPREF_"convert."
 S DIR("?",2)=" The date must be on or before "_$$FMTE^XLFDT(SCCVACRP,1)_".",DIR("?",3)=" "
 S DIR("?",4)="If you enter only a date, all the patient's "_SCCVTYPN_"s on that date will be",DIR("?",5)=" presented one at a time.  If the entry displayed is the correct one,"
 S DIR("?")=" you may request it be "_SCPREF_"converted or if not the correct one, reject it."
 D ^DIR K DIR
 G:'Y SEL1Q
 S SCDTM=+Y,SCQUIT=0
 ;
 I SCDTM'["." D  G:SCQUIT SEL1Q ; Date only entered
 . ; SCQUIT is set to 1 when an entry is selected for conversion
 . ; SCONE is set to 1 if at least one valid entry is found
 . ;
 . N SCONE,SC,SCV,SCF,SCD
 . S SCF=$S(SCFILE["SCE":"^SCE(""ADFN"","_SCCVDFN_")",SCFILE["SDV":"^SDV(""ADT"","_SCCVDFN_")",1:SCFILE)
 . S SCONE=$S(SCF["SCE":$O(@SCF@(SCDTM)),SCF["""S""":$O(@SCF@(SCDTM)),SCF["""DIS""":9999999-$O(@SCF@(9999999-SCDTM),-1),1:$O(@SCF@(SCDTM-1)))
 . S SCONE=(SCONE\1=SCDTM)
 . I '$G(SCONE) D NOENT^SCCVCST4(SCCVTYPN,SCCVDFN,SCDTM) S SCQUIT=1 Q  ;No valid entry found
 . I SCCVEVT=2 S SCONE=0
 . ;
 . I SCFILE["SCE"!(SCFILE["""S""") D  ; Encounters and Appts
 .. S SC=SCDTM,SCONE=0
 .. F  S SC=$O(@SCF@(SC)) Q:'SC!((SC\1)'=SCDTM)  D  Q:SCQUIT
 ... I SCF["SCE" D  ; Encounters
 .... S SCD=0 F  S SCD=$O(@SCF@(SC,SCD)) Q:'SCD  W "." I '$P($G(^SCE(SCD,0)),U,6) D CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,+$G(^SCE(SCD,0)),SCD,1,.SCQUIT,.SCONE) Q:SCQUIT
 ... ;
 ... I SCF["""S""" D  ; Appts
 .... D CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,SC,SC,1,.SCQUIT,.SCONE)
 . ;
 . I SCFILE["""DIS""" D  ; Dispositions
 .. S SCDTM=9999999-SCDTM-1,SC=SCDTM+1,SCONE=0
 .. F  S SC=$O(@SCF@(SC),-1) Q:'SC!((SC\1)'=SCDTM)  W "." D  Q:SCQUIT
 ... D CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,9999999-SC,SC,1,.SCQUIT,.SCONE)
 . I SCFILE["SDV" D  ; Add/edits
 .. S SCONE=0,SC=$G(@SCF@(SCDTM))
 .. Q:SC=""
 .. D CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,SC,SC,1,.SCQUIT,.SCONE)
 . ;
 . I 'SCONE S SCQUIT=1 D NOENT^SCCVCST4(SCCVTYPN,SCCVDFN,SCDTM) Q
 . ;
 . I 'SCQUIT,SCONE S DIR(0)="EA",DIR("A",1)="NO ENTRY SELECTED",DIR("A")="PRESS RETURN " D ^DIR K DIR
 ;
 I SCDTM["." D  ; Date and time entered
 . I SCFILE["SCE" D  ; Encounter
 .. S SCCVDA=0 F  S SCCVDA=$O(^SCE("ADFN",SCCVDFN,SCDTM,SCCVDA)) W "." Q:'SCCVDA  D
 ... D CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,SCDTM,SCCVDA,1,.SCQUIT,.SCONE)
 . ;
 . I SCFILE'["SCE" D  ; Non-encounter
 .. S SCCVDA=$S(SCFILE'["""DIS""":SCDTM,1:9999999-SCDTM)
 .. D CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,SCDTM,SCCVDA,0,.SCQUIT,.SCONE)
SEL1Q Q SCSTOP
 ;
SETFL(SCCVTYP,SCCVDFN) ;Set the lookup format of the file
 ; INPUT: SCCVTYP, SCCVDFN
 ; FUNCTION OUTPUT: Lookup format of filename for type/patient
 ;
 Q $S(SCCVTYP=0:"^SCE",SCCVTYP=3:"^DPT("_SCCVDFN_",""DIS"")",SCCVTYP=1:"^DPT("_SCCVDFN_",""S"")",SCCVTYP=2:"^SDV",1:"")
 ;
CHK(SCCVEVT,SCCVTYPN,SCFILE,SCFILE1,SCDTM,SC,SCMULT,SCQUIT,SCONE) ;
 ; Check for validity for convert, display entry, convert if confirmed
 N SCV,DIR,Y
 I $$VAL1^SCCVCST5(SCCVEVT,SCFILE,SC,SCMULT) D
 .S SCONE=1
 .W ! S SCV=$$DISP1^SCCVCST4(SCCVTYPN,SCFILE1,SC)
 .I 'SCV S:SCV="^" SCQUIT=1 Q
 .S SCQUIT=1 D CONV1^SCCVCST4(SCCVEVT,SCFILE,SCCVDFN,SCDTM,SC)
 Q
 ;
DTCNVT(X) ; Convert date/time for disposition
 N SCZ,SCX,Y,Z,%DT
 S %DT="RXPT"
 I X["@"!(X'[".") D
 . S SCX=$P(X,"@",2)
 . S SCZ=$TR(SCX,"APMapm"),Z=$L(SCZ) ;strip AM/PM from time
 . I Z>4 S %DT=%DT_"S" S:Z=5 X=$P(X,"@")_"@"_SCZ_"0"
 D ^%DT S X=Y
 K:Y<0 X
 Q
 ;
