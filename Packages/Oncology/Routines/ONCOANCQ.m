ONCOANCQ ;Hines OIFO/GWB - [ER Report of accessions requiring additional input] ;06/14/00
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 ;
 S AASTYPNC="A"
LINE N AASAY
 N READY
 F  D  Q:READY
 .S READY=0
 .I '$$SITEPAR^ONCOU("ERRMSG") S READY=-1
 .E  I '$$GETDATA S READY=-1
 .E  S READY=$$DEFOK
 .I 'READY W !!!?10,"OK, restarting from the beginning...",!!!
 I READY>0 D ^ONCOANC0
 Q
 ;
GETDATA() ;Get data
 N ALLOK
 S AASAY=0,ALLOK=$$GETYEAR(.AASAY)
 I ALLOK D STATE S:'$D(BYR("B")) BYR("B")=(200+EYR)_"0000" S:'$D(BYR("E")) BYR("E")=(201+EYR)_"0000"
 I ALLOK S AASDXH=0,ALLOK=$$GETDXH(.AASDXH)
 Q ALLOK
 ;
SHOINST() ;Display instructions
 N OKSHO,OKHERE S OKHERE=1
 S OKSHO=$$ASKY^ONCOU("    DISPLAY/PRINT on-line instructions for Help")
 I $D(DIRUT)!$D(DIROUT) S OKHERE=0
 E  I OKSHO,'($D(ONCOREP)!$D(ONCOREQ)) S OKHERE=$$SHOWEM
    E  I OKSHO,($D(ONCOREP)!$D(ONCOREQ)) D TEMPHLP
 Q OKHERE
 ;
TEMPHLP N X,DIWL,DIWR,DIWF
 S DIWL=10,DIWR=70,DIWF="W"
 W !!
 I $D(ONCOREQ) D
 .S X="This report displays incomplete records for data to be transmitted to the ACOS, for a time period specified.  The report does not specify exactly where in the database to fix problems.  It is intended only as an aid."
 E  D
 .S X="This report will display what will be transmitted on the ACOS disk.  It is intended as an aid in correcting and validating the ACOS data.  There is no extensive help for this report at this time."
 D ^DIWP,^DIWW W !
 Q
 ;
SHOWEM() ;Instruction display
 N OKHERE
 W !! S DIC="^ONCO(160.2,",L=0,DHD="@"
 I AASTYPNC="A" S BY="[ONCO ACOS DOCUMENTATION]",DA=4
 I AASTYPNC="I" S FLDS="1",FR="PRIMARY ACOS INFO (850)",TO="STATE REPORTING ACOS INFOA",BY="@.01"
 D EN1^DIP
 S OKHERE=($D(DTOUT)+$D(DUOUT)=0)
 I 'OKHERE S OKHERE=$$ASKY^ONCOU("Continue")
 Q OKHERE
 ;
GETYEAR(YR) ;Get year
 N OKHERE
 S BYR=1980,EYR=(1700+$E(DT,1,3))-1
 S:AASTYPNC'="A" YR=$$ASKNUM^ONCOU("    Select YEAR for ACOS Call for Data",BYR_":"_(BYR+20),EYR)
 I AASTYPNC="A" S YR=$$ASKNUM^ONCOU("    Select Accession Year",BYR_":"_(EYR),EYR)
 S OKHERE=($D(DTOUT)+$D(DUOUT)=0)
 Q OKHERE
 ;
GETDXH(DXH) ;Get INSTITUTION ID NUMBER (160.1,27)
 N OKHERE
 S DIE=160.1
 S DA=$O(^ONCO(160.1,"C",DUZ(2),0))
 I DA="" S DA=$O(^ONCO(160.1,0))
 S DR=27_$J("",20)_"ACOS Number"
 S ONCOL=0
 L +^ONCO(160.1,DA):0 I $T D ^DIE L -^ONCO(160.1,DA) S ONCOL=1
 I 'ONCOL W !,"The site paramaters record is being edited by another user."
 K ONCOL
 K DIE S DXH=X
 S OKHERE=($D(Y)=0) ;Y is defined if user answered all prompts
 Q OKHERE
 ;
DEFOK() ;Confirm definitions
 N OKHERE
 S OSP=$O(^ONCO(160.1,"C",DUZ(2),0))
 I OSP="" S OSP=$O(^ONCO(160.1,0))
 S AC=$P(^ONCO(160.1,OSP,1),U,4)
 S AC=$$GET1^DIQ(160.19,AC,.01,"I")
 K OSP
 W !!!?20,"ACOS Number is ",$S(AC'="":AC,1:"NOT defined in Site Parameters File") S:AC'="" AASDXH=AC
 W:AASTYPNC="I" !?20,"Year for ACOS data is ",AASAY
 I AASTYPNC="A" W !?20,"Accession Year ",AASAY,!?20,"Abstract Completed Date, Start is ",BYR("BY"),!?20,"Abstract Completed Date, End is ",BYR("BE")
 W ! S OKHERE=$$ASKY^ONCOU("     Definitions OK")
 Q OKHERE
REPORT ;Set variable for report to run instead of tape
 N ONCOREP
 S ONCOREP=1,AASTYPNC="I" D LINE^ONCOANCQ,CLEANUP^ONCOANC9 Q
 ;
REQREP ;Set variable for required field report to run
 N ONCOREQ
 S ONCOREQ=1 D ^ONCOANCQ,CLEANUP^ONCOANC9 Q 
 ;
STATE ;Identifies desired date range for state data collection disk
 Q:AASTYPNC'="A"  I AASAY'>1 S ALLOK=0 Q
 S DIR(0)="D",DIR("A")="      Abstract Completed Date, Start"
 S DIR("B")="Jan 1, "_AASAY D ^DIR K DIR("B") I $D(DIRUT) S ALLOK=0 Q
 S BYR("B")=Y X ^DD("DD") W "   ",Y S BYR("BY")=Y
 S DIR("A")="      Abstract Completed Date, End",DIR("B")="Dec 31, "_AASAY
 D ^DIR I $D(DIRUT) S ALLOK=0 Q
 S BYR("E")=Y X ^DD("DD") W "   ",Y S BYR("BE")=Y
 K DIR
 Q
