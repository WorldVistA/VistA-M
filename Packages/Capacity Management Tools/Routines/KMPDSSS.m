KMPDSSS ;OAK/RAK - CP Status - SAGG ;5/1/07  15:07
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**3,6**;Mar 22, 2002;Build 3
 ;
 ;
FORMAT(KMPDLN) ;-format text for dislay
 ;-----------------------------------------------------------------------------
 ; KMPDLN.... return number of lines - called by reference
 ;-----------------------------------------------------------------------------
 ;
 Q:$G(KMPDNMSP)=""
 ;
 N LN,X S LN=0 K TMP
 ;
 ; if no kmpsutl routine
 S X="KMPSUTL" X ^%ZOSF("TEST") I '$T D  Q
 .S LN=LN+1
 .D SET^VALM10(LN,"The SAGG Package is not installed!")
 ;
 ; status
 D STATUS
 ;
 ; option data
 D OPT^KMPDSSD("KMPS SAGG REPORT")
 ;
 ; bacground data
 D BKGRND
 ;
 ; file data
 D FILES
 ;
 ; routine version check
 D ROUCHK^KMPDSSD1("S")
 ;
 ; node/cpu data
 D CPU^KMPDSSD1
 ;
 ; mail group member
 D MGRP^KMPDSSD1
 ;
 ; legend
 D LEGEND
 ;
 S KMPDLN=LN
 ;
 Q
 ;
BKGRND ;- background
 ;
 N CURSTAT,LOC,OPT,PLTFRM,PROD,SITENUM,STAT,TEXT,VOL,VOLDA
 ;
 S SITENUM=$P($$SITE^VASITE(),U,3) Q:'SITENUM
 S OPT="KMPS SAGG REPORT",STAT=$$TSKSTAT^KMPSUTL1(OPT),CURSTAT=$$CURSTAT^KMPDUTL1(STAT)
 ;
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"   Temporary collection global.")
 S LN=LN+1
 D SET^VALM10(LN,"   ^XTMP(""KMPS"")............... "_$S('$D(^XTMP("KMPS",SITENUM,0)):"NOT ",1:"")_"Present")
 ;
 S PLTFRM=$$MPLTF^KMPDUTL1,PROD=$P(^%ZOSF("PROD"),",")
 I PLTFRM="DSM" D
 .S LOC=$G(^KMPS(8970.1,1,0))
 .S TEXT="   Global Location............ "
 .S TEXT=TEXT_$S($P(LOC,U,3)="":PROD,1:$P(LOC,U,3))_","_$S($P(LOC,U,2)="":"UNKNOWN",1:$P(LOC,U,2))
 .S LN=LN+1
 .D SET^VALM10(LN,TEXT)
 ;
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"   SAGG Project collection routines will monitor the following:")
 S LN=LN+1
 D SET^VALM10(LN,"")
 S (TEXT,VOL)=""
 F  S VOL=$O(^KMPS(8970.1,1,1,"B",VOL)) Q:VOL=""  D
 .S VOLDA=$O(^KMPS(8970.1,1,1,"B",VOL,0))
 .S LOC=$P(^KMPS(8970.1,1,1,VOLDA,0),U,2)
 .S:LOC="" LOC=PROD
 .S TEXT=$J(" ",10)_VOL,LN=LN+1
 .D SET^VALM10(LN,TEXT)
 ;
 I '+CURSTAT&$D(^XTMP("KMPS","START")) D 
 .S LN=LN+1 D SET^VALM10(LN,"") S LN=LN+1 D SET^VALM10(LN,"")
 .S LN=LN+1
 .D SET^VALM10(LN,"   SAGG Project collection routines are still running on:")
 .S (TEXT,VOL)=""
 .F  S VOL=$O(^XTMP("KMPS","START",VOL)) Q:VOL=""  D
 ..S TEXT=$J(" ",10)_VOL,LN=LN+1
 ..D SET^VALM10(LN,TEXT)
 ;
 ; check for any reported errors
 I $D(^XTMP("KMPS","ERROR")) D 
 .S LN=LN+1 D SET^VALM10(LN,"") S LN=LN+1 D SET^VALM10(LN,"")
 .S LN=LN+1
 .D SET^VALM10(LN,"   SAGG Project collection routines have recorded an error on")
 .S LN=LN+1
 .D SET^VALM10(LN,"   the following Volume Set(s):")
 .S LN=LN+1 D SET^VALM10(LN,"")
 .S (TEXT,VOL)=""
 .F  S VOL=$O(^XTMP("KMPS","ERROR",VOL)) Q:VOL=""  D
 ..S TEXT=$J(" ",10)_VOL,LN=LN+1
 ..D SET^VALM10(LN,TEXT) S TEXT=""
 ;
 ; check to see if SAGG was told to stop or has reported errors
 I (+CURSTAT)>3 D 
 .I +CURSTAT=4 D
 ..S LN=LN+1
 ..D SET^VALM10(LN,"   SAGG has been running over a day. Use ^%S"_$S(PLTFRM="DSM":"Y",1:"S")_" and check to see if")
 ..S LN=LN+1
 ..D SET^VALM10(LN,"   the KMPSGE routine is still running.")
 .S LN=LN+1
 .D SET^VALM10(LN,"   NOTE:  Any incomplete data that has been collected will be")
 .S LN=LN+1
 .D SET^VALM10(LN,"   deleted automatically the next time that SAGG runs.")
 .I $D(^XTMP("KMPS","ERROR")) S LN=LN+1 D SET^VALM10(LN,"            First determine the cause of any volume set errors.")
 .S LN=LN+1
 .D SET^VALM10(LN,"            Reschedule SAGG to collect global data if necessary.")
 ;
 Q
 ;
FILES ;-- file data
 ;
 N TEXT,X
 ;
 S LN=LN+1
 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,$J(" ",35)_" # of") ;     Oldest     Recent")
 S LN=LN+1
 D SET^VALM10(LN,"   File"_$J(" ",28)_"Entries") ;    Date       Date")
 S LN=LN+1
 D SET^VALM10(LN,"   -------------------------       -------") ;   -------   -------")
 ; file name
 S TEXT="   8970.1-"_$P($G(^DIC(8970.1,0)),U)
 ; number of entries
 S TEXT=TEXT_$J(" ",35-$L(TEXT))_$J($FN($P($G(^KMPS(8970.1,0)),U,4),",",0),7)
 S LN=LN+1
 D SET^VALM10(LN,TEXT)
 ;
 Q
 ;
LEGEND ;-- display full package name
 ;
 S LN=LN+1 D SET^VALM10(LN,"")
 S LN=LN+1 D SET^VALM10(LN,"")
 S LN=LN+1
 D SET^VALM10(LN,"   SAGG = Statistical Analysis of Global Growth")
 ;
 Q
 ;
STATUS ;-- current status
 ;
 N CURSTAT,DOW,OPT,SESSNUM,SITNUM,STAT,STRTDT
 ;
 S SITNUM=$P($$SITE^VASITE(),U,3) Q:'SITNUM
 S OPT="KMPS SAGG REPORT",STAT=$$TSKSTAT^KMPSUTL1(OPT),CURSTAT=$$CURSTAT^KMPDUTL1(STAT)
 S LN=LN+1
 D SET^VALM10(LN,"   Current Status.............. "_$P(CURSTAT,U,2))
 I $D(^XTMP("KMPS",SITNUM,0)) D
 .S SESSNUM=^XTMP("KMPS",SITNUM,0),STRTDT=$P(SESSNUM,U,4),SESSNUM=+SESSNUM
 .S LN=LN+1
 .D SET^VALM10(LN,"   Session Number.............. "_SESSNUM)
 .S DOW=$$DOW^XLFDT(STRTDT)
 .S LN=LN+1
 .D SET^VALM10(LN,"   Start Date.................. "_$$FMTE^XLFDT(STRTDT,"P")_" ("_DOW_")")
 ;
 S LN=LN+1
 D SET^VALM10(LN,"")
 ;
 Q
