DGREGTE2 ;ALB/BAJ,TDM,BDB,JAM - Temporary & Confidential Address Support Routine; 02/27/2006 ; 22 Mar 2017  1:10 PM
 ;;5.3;Registration;**688,754,851,1040,1143**;Aug 13, 1993;Build 36
 ;
 Q
 ;
GETACT(DFN,DGTYPE,DGINPUT,DGACTIVE) ; DG*5.3*1143 - populate DGINPUT array with initial fields - Active?, Start/End Dates, Confidential Categories
 ; Input: 
 ;   DFN - Patient IEN
 ;   DGTYPE - "TEMP" or "CONF"
 ; Output:
 ; DGINPUT - (pass by reference) - array that will hold the values entered
 ; DGACTIVE - (pass by reference) - holds the value of the Active? field (Y or N)
 ; Returns: 1 if an update has occurred
 ;
 N DIR,DA,X,Y,DGN,DGNACT,DGDEFACT
 ; Prompt for Address Active?
 ; Get the field number for Active? field
 S DGNACT=$S(DGTYPE="TEMP":.12105,DGTYPE="CONF":.14105,1:"")
 ; Set the default value from the current value of the Active? field stored in the patient file
 S DGDEFACT=$$GET1^DIQ(2,DFN,DGNACT,"I")
 ; If RTA local array has a value for the Active? field, make that the default instead
 I DGTYPE="TEMP" I $D(DGADDGRP3(DGNACT)) S DGDEFACT=DGADDGRP3(DGNACT)
 I DGTYPE="CONF" I $D(DGADDGRP4(DGNACT)) S DGDEFACT=DGADDGRP4(DGNACT)
RETRY ;
 S DA=DFN
 S DGACTIVE=""
 I DGTYPE="TEMP" S DIR("A")="TEMP MAILING ADDRESS ACTIVE?"
 ; Set default value for ^DIR from the local DGINPUT array or the current default value or "N" if none of these are defined
 S DGDEFACT=$S($D(DGINPUT(DGNACT)):DGINPUT(DGNACT),$G(DGDEFACT)'="":DGDEFACT,1:"N")
 S DIR(0)=2_","_DGNACT,DIR("B")=$S($E(DGDEFACT)="Y":"YES",1:"NO")
 D ^DIR
 I $D(DIRUT) Q 0
 ; Set value into return variables
 S (DGACTIVE,DGINPUT(DGNACT))=Y
 ; If Active is NO, and is also the default value, no change occurring, quit 0
 I Y="N" I DGDEFACT="N" Q 0
 ; If Active is changed to NO, call code to determine if address is being deleted and store the N in the local array
 ;  Return 1 to indicate an update occurred
 I Y="N" D  Q 1
 . N DGDATA,DGERROR
 . I DGTYPE="TEMP" D TADD^DGLOCK I $G(DGRTAON)=1 S DGADDGRP3(DGNACT)="N"
 . I DGTYPE="CONF" D CADD^DGLOCK3 I $G(DGRTAON)=1 S DGADDGRP4(DGNACT)="N"
 ;
 ; Active set to YES, continue prompting for dates
 ; Get Start and End Dates
 K DIR
 N DGOK,ANS
 S DGOK=1
 ; Temp Start/End Dates, store internal format to DGINPUT
 I DGTYPE="TEMP" F DGN=.1217,.1218 S DGOK=$$READ(DGTYPE,DGN,.ANS) Q:'DGOK  S DGINPUT(DGN)=ANS
 ; Get Confidential Start/End Dates, store internal format to DGINPUT
 I DGTYPE="CONF" F DGN=.1417,.1418  S DGOK=$$READ(DGTYPE,DGN,.ANS) Q:'DGOK  S DGINPUT(DGN)=ANS
 ; Done with Temp address or if 'DGOK
 I DGTYPE="TEMP"!('DGOK) Q DGOK
 ;
 ; Process CONFIDENTIAL ADDRESS CATEGORIES
 N DGORIGINAL,DGUPDATED,DGERROR,DGFDA,DIK,DGIEN,DGNEWIEN,DGSAVE
 ; Capture current categories in the patient file
 D GETS^DIQ(2,DFN,".141*,","IE","DGORIGINAL","DGERROR")
 ; If we have the RTA group array defined, load the categories from the local array into the patient file
 I $D(DGADDGRP4("CCATS",2.141)) D
 . ; Clean out existing categories
 . S DA(1)=DFN
 . S DIK="^DPT("_DFN_",.14,"
 . S DA=0 F  S DA=$O(^DPT(DFN,.14,DA)) Q:'DA  D ^DIK
 . ; Restore the categories from Group 4
 . K DGFDA
 . S DGIEN=0 F  S DGIEN=$O(DGADDGRP4("CCATS",2.141,DGIEN)) Q:'DGIEN  D
 . . S DGNEWIEN=DFN_","
 . . S DGNEWIEN="+1,"_DGNEWIEN
 . . S DGFDA(2.141,DGNEWIEN,.01)=DGADDGRP4("CCATS",2.141,DGIEN,.01,"I")
 . . S DGFDA(2.141,DGNEWIEN,1)=DGADDGRP4("CCATS",2.141,DGIEN,1,"I")
 . . D UPDATE^DIE("","DGFDA","","DGERR")
 . . K DGFDA
 . K DGFDA
 ; Process input from user for confidential categories
 N DIE,DR
 S DA=DFN
 S DIE("NO^")=1
 S DR(2,2.141)=".01;1//YES;"
 S DIE="^DPT("
 S DR=.141
 D ^DIE
 ; If there is a timeout, X will equal "^" - restore the original data and quit
 I X="^" S DGTMOT=1,DGOK=0 G RESTORE
 I '$P($$CAACT^DGRPCADD(DFN),U,2) W !?4,"But I need at least one active category." D  G RETRY
 . ; Clean up current changes and start over
 . D RESTORE
 . K DGORIGINAL
 ; Capture updated categories into the local array
 D GETS^DIQ(2,DFN,".141*,","IE","DGUPDATED","DGERROR")
 ; Place user-selections into DGINPUT
 M DGINPUT("CCATS")=DGUPDATED
 ; For Real-time updating: compare the categories in DGORIGINAL with DGINPUT and add/mark those categories in DGINPUT as deleted
 I DGRTAON=1 S DGIEN=0 F  S DGIEN=$O(DGORIGINAL(2.141,DGIEN)) Q:'DGIEN  D
 . N DGFOUND,DGCATID
 . S DGCATID=DGORIGINAL(2.141,DGIEN,.01,"I")
 . ; loop over the categories in DGINPUT and if the category is there, set FOUND=1
 . S DGFOUND=0,DGNEWIEN=0 F  S DGNEWIEN=$O(DGINPUT("CCATS",2.141,DGNEWIEN)) Q:'DGNEWIEN  D  Q:DGFOUND
 . . I DGINPUT("CCATS",2.141,DGNEWIEN,.01,"I")=DGCATID S DGFOUND=1
 . ; If the category was not found, set it into DGINPUT as DELETED
 . I 'DGFOUND S DGINPUT("CCATS","DELETE",DGCATID)=DGORIGINAL(2.141,DGIEN,.01,"E")
 ; 
 ; Restore the original categories
RESTORE ; Restore original set of Confidential Categories
 ; Clean out existing categories
 S DA(1)=DFN
 S DIK="^DPT("_DFN_",.14,"
 S DA=0 F  S DA=$O(^DPT(DFN,.14,DA)) Q:'DA  D ^DIK
 ;
 ; Restore the original categories
 K DGFDA
 S DGIEN=0 F  S DGIEN=$O(DGORIGINAL(2.141,DGIEN)) Q:'DGIEN  D
 . S DGNEWIEN=DFN_","
 . S DGNEWIEN="+1,"_DGNEWIEN
 . S DGFDA(2.141,DGNEWIEN,.01)=DGORIGINAL(2.141,DGIEN,.01,"I")
 . S DGFDA(2.141,DGNEWIEN,1)=DGORIGINAL(2.141,DGIEN,1,"I")
 . D UPDATE^DIE("","DGFDA","","DGERR")
 . K DGFDA
 Q DGOK
 ;
READ(DGTYPE,DGN,ANS) ; DG*5.3*1143 - User entry for start/end dates
 ; Input:  DGN - Field number to prompt for
 ; Output: ANS - (pass by reference) the internal format of the user entry
 ; Returns: 1= ok response  0 = no response (timeout or user exit)
 N DIR,X,Y,DGCURRENT,DGDEF
 ; Get current field value in the patient file
 S DGCURRENT=$$GET1^DIQ(2,DFN,DGN,"I")
 ; Get default value for the field from local input array or RTA array (if defined) or current patient record value
 I DGTYPE="CONF" S DGDEF=$S($D(DGINPUT(DGN)):DGINPUT(DGN),$D(DGADDGRP4(DGN)):DGADDGRP4(DGN),1:DGCURRENT)
 I DGTYPE="TEMP" S DGDEF=$S($D(DGINPUT(DGN)):DGINPUT(DGN),$D(DGADDGRP3(DGN)):DGADDGRP3(DGN),1:DGCURRENT)
 ; Set default value only if it is different from what's in the DB - transform it to external format
 I DGDEF'=DGCURRENT S Y=DGDEF,Y=$$FMTE^DILIBF(Y,"5U") S DIR("B")=Y
 ; For temp address, set Prompt text
 I DGN=.1217 S DIR("A")="TEMP MAILING ADDRESS START DATE"
 I DGN=.1218 S DIR("A")="TEMP MAILING ADDRESS END DATE"
 S DA=DFN
 S DIR(0)=2_","_DGN
PROMPT ; Tag for entering in the date
 D ^DIR
 I $D(DTOUT) S DGTMOT=1 Q 0
 I $D(DUOUT) Q 0
 ; If an end date entered, check the value against the start date (previously stored in local input array)
 I Y'="" I DGN=.1218,(Y<DGINPUT(.1217)) W !,"End Date must not be before Start Date." G PROMPT
 I Y'="" I DGN=.1418,(Y<DGINPUT(.1417)) W !,"End Date must not be before Start Date." G PROMPT
 S ANS=Y
 Q 1
 ;
GETOLD(DGCMP,DFN,TYPE) ;populate array with existing address info
 N CCIEN,DGCURR,CFORGN,CFSTR,L,T,DGCIEN,DGST,DGCNTY,FDESC,FNODE,FPECE,CCNTRY,COUNTRY
 S CFORGN=0,FDESC=$S(TYPE="TEMP":"TEMPORARY ADDRESS COUNTRY",1:"CONFIDENTIAL ADDR COUNTRY")
 ; get current country
 S FNODE=$S(TYPE="TEMP":.122,TYPE="CONF":.141,1:.11)
 S FPECE=$S(TYPE="TEMP":3,TYPE="CONF":16,1:10)
 S CCIEN=$P($G(^DPT(DFN,FNODE)),U,FPECE)
 I CCIEN="" S CCNTRY=$O(^HL(779.004,"D","UNITED STATES",""))
 S CFORGN=$$FORIEN^DGADDUTL(CCIEN)
 ;get current address fields and xlate to ^DIQ format
 S CFSTR=$$INPT1(DFN,CFORGN),CFSTR=$TR(CFSTR,",",";")
 ; Domestic data needs some extra fields
 ; add country field before lookup
 D GETS^DIQ(2,DFN_",",CFSTR,"EI","DGCURR")
 F L=1:1:$L(CFSTR,";") S T=$P(CFSTR,";",L),DGCMP("OLD",T)=$G(DGCURR(2,DFN_",",T,"E"))
 S COUNTRY=$$CNTRYI^DGADDUTL(CCIEN) I COUNTRY=-1 S COUNTRY="UNKNOWN COUNTRY"
 S DGCMP("OLD",FCNTRY)=COUNTRY
 I 'CFORGN D
 . S DGCIEN=$G(DGCURR(2,DFN_",",FCOUNTY,"I"))
 . S DGST=$G(DGCURR(2,DFN_",",FSTATE,"I"))
 . S DGCNTY=$$CNTY^DGREGAZL(DGST,DGCIEN)
 . I DGCNTY=-1 S DGCNTY=""
 . S DGCMP("OLD",FCOUNTY)="" I DGCNTY]"" S DGCMP("OLD",FCOUNTY)=$P(DGCNTY,U)_" "_$P(DGCNTY,U,3)
 Q
INPT1(DFN,FORGN,PSTR) ; address input prompts
 N FSTR
 ; PSTR contains the full list of address fields to be modified
 ; FSTR contains the field list based on country
 S PSTR=FSLINE1_","_FSLINE2_","_FSLINE3_","_FCITY_","_FSTATE_","_FCOUNTY_","_FZIP_","_FPROV_","_FPSTAL_","_FCNTRY_","_FPHONE
 ;S FSTR=FSLINE1_","_FSLINE2_","_FSLINE3_","_FCITY_","_FSTATE_","_FCOUNTY_","_FZIP_","_FPHONE
 S FSTR=FSLINE1_","_FSLINE2_","_FSLINE3_","_FZIP_","_FPHONE ;DG*5.3*851
 I FORGN S FSTR=FSLINE1_","_FSLINE2_","_FSLINE3_","_FCITY_","_FPROV_","_FPSTAL_","_FPHONE
 Q FSTR
 ;
 ; DG*5.3*1143 - Tags DISPUS and DISPFGN moved from DGREGTED due to size limitations.
 ; DG*5.3*1014;jam;  Added these tags to display the address prior to calling the Validation service
DISPUS(DGCMP,DGM) ;tag to display US data
 N DGCNTRY
 ;    "AddressLine1,AddressLine2,AddressLine3,City,State,County,Zip,Province,PostalCode^Country"
 ;        ".1411,.1412,.1413,.1414,.1415,.14111,.1416,.14114,.14115,.14116"  ; Confidential address fields
 W !,?2,"[",DGM," CONFIDENTIAL ADDRESS]"
 W !?16,$G(DGCMP(DGM,.1411))
 I $G(DGCMP(DGM,.1412))'="" W !,?16,$G(DGCMP(DGM,.1412))
 I $G(DGCMP(DGM,.1413))'="" W !,?16,$G(DGCMP(DGM,.1413))
 W !,?16,$G(DGCMP(DGM,.1414))
 W:($G(DGCMP(DGM,.1414))'="")!($P($G(DGCMP(DGM,.1415)),U,2)'="") ","
 W $P($G(DGCMP(DGM,.1415)),U,2)
 W " ",$G(DGCMP(DGM,.1416))
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.14116)),U))
 I DGCNTRY]"",(DGCNTRY'=-1) W !?16,DGCNTRY
 I $P($G(DGCMP(DGM,.14111)),U)'="" W !,?6,"  County: ",$P($G(DGCMP(DGM,.14111)),U,2)
 W !
 Q
 ;
DISPFGN(DGCMP,DGM) ;tag to display Foreign data
 N DGCNTRY
 W !,?2,"[",DGM," CONFIDENTIAL ADDRESS]"
 W !?16,$G(DGCMP(DGM,.1411))
 I $G(DGCMP(DGM,.1412))'="" W !,?16,$G(DGCMP(DGM,.1412))
 I $G(DGCMP(DGM,.1413))'="" W !,?16,$G(DGCMP(DGM,.1413))
 W !,?16,$G(DGCMP(DGM,.1414))_" "_$G(DGCMP(DGM,.14114))_" "_$G(DGCMP(DGM,.14115))
 S DGCNTRY=$$CNTRYI^DGADDUTL($P($G(DGCMP(DGM,.14116)),U))
 S DGCNTRY=$S(DGCNTRY="":"UNSPECIFIED COUNTRY",DGCNTRY=-1:"UNKNOWN COUNTRY",1:DGCNTRY)
 I DGCNTRY]"" W !?16,DGCNTRY
 W !
 Q
 ;
LOADTEMP ; DG*5.3*1143 - Called from TADD^DGLOCK when the address active? flag is set from YES to NO
 ; Load DGADDGRP3 Temp Address array from the DB
 N DGRP
 S DGRP(.121)=$G(^DPT(DFN,.121))
 S DGRP(.122)=$G(^DPT(DFN,.122))
 K DGADDGRP3
 ; Set Address Active? field to NO in the local array 
 S DGADDGRP3(.12105)="N"
 ; Line 1
 S DGADDGRP3(.1211)=$P(DGRP(.121),"^",1)
 ; Line 2
 S DGADDGRP3(.1212)=$P(DGRP(.121),"^",2)
 ; Line 3
 S DGADDGRP3(.1213)=$P(DGRP(.121),"^",3)
 ; City
 S DGADDGRP3(.1214)=$P(DGRP(.121),"^",4)
 ; State
 S DGADDGRP3(.1215)=$P(DGRP(.121),"^",5)
 ; Zip 
 S DGADDGRP3(.1216)=$P(DGRP(.121),"^",6)
 ; Start Date
 S DGADDGRP3(.1217)=$P(DGRP(.121),"^",7)
 ; End Date
 S DGADDGRP3(.1218)=$P(DGRP(.121),"^",8)
 ; Temp Phone
 S DGADDGRP3(.1219)=$P(DGRP(.121),"^",10)
 ; County
 S DGADDGRP3(.12111)=$P(DGRP(.121),"^",11)
 ; Zip+4
 S DGADDGRP3(.12112)=$P(DGRP(.121),"^",12)
 ; Province
 S DGADDGRP3(.1221)=$P(DGRP(.122),"^",1)
 ; Postal Code
 S DGADDGRP3(.1222)=$P(DGRP(.122),"^",2)
 ; Country
 S DGADDGRP3(.1223)=$P(DGRP(.122),"^",3)
 Q
 ;
LOADCONF ; DG*5.3*1143 - Called from CADD^DGLOCK3 when the address active? flag is set from YES to NO
 ; Load DGADDGRP4 Address array from the DB - these fields will be sent to ES with delete flag set.  Then deleted from the DB.
 K DGADDGRP4
 N DGRP
 S DGRP(.141)=$G(^DPT(DFN,.141))
 S DGRP(.13)=$G(^DPT(DFN,.13))
 ; Set Address Active? field to NO in the local array
 S DGADDGRP4(.14105)="N"
 ; Line 1
 S DGADDGRP4(.1411)=$P(DGRP(.141),"^",1)
 ; Line 2
 S DGADDGRP4(.1412)=$P(DGRP(.141),"^",2)
 ; Line 3
 S DGADDGRP4(.1413)=$P(DGRP(.141),"^",3)
 ; City
 S DGADDGRP4(.1414)=$P(DGRP(.141),"^",4)
 ; State
 S DGADDGRP4(.1415)=$P(DGRP(.141),"^",5)
 ; Zip 
 S DGADDGRP4(.1416)=$P(DGRP(.141),"^",6)
 ; Start Date
 S DGADDGRP4(.1417)=$P(DGRP(.141),"^",7)
 ; End Date
 S DGADDGRP4(.1418)=$P(DGRP(.141),"^",8)
 ; County
 S DGADDGRP4(.14111)=$P(DGRP(.141),"^",11)
 ; Province
 S DGADDGRP4(.14114)=$P(DGRP(.141),"^",14)
 ; Postal Code
 S DGADDGRP4(.14115)=$P(DGRP(.141),"^",15)
 ; Country
 S DGADDGRP4(.14116)=$P(DGRP(.141),"^",16)
 ; CASS Indicator
 S DGADDGRP4(.14117)=$P(DGRP(.141),"^",17)
 ; Conf Phone
 S DGADDGRP4(.1315)=$P(DGRP(.13),"^",15)
 ; Confidential override
 S DGADDGRP4(.141201)=$P(DGRP(.141),"^",17)
 ; Load the Address Categories
 N DGADDCATS
 ; Capture current categories in the patient file and load them into the array
 D GETS^DIQ(2,DFN,".141*,","IE","DGADDCATS","DGERROR")
 M DGADDGRP4("CCATS")=DGADDCATS
 Q
 ;
SURE() ; Are you sure prompt
 N DIR,X,Y,DUOUT,DTOUT,DIRUT
 S DIR(0)="Y"
 S DIR("B")="NO"
 S DIR("A")="   SURE YOU WANT TO DELETE"
 D ^DIR
 Q Y
SKIP(DGN,DGINPUT) ; determine whether or not to skip the prompt
 N SKIP,NULL
 S SKIP=0
 S NULL=($G(DGINPUT(FSLINE1))="")!(($G(DGINPUT(FSLINE1))="@"))
 I NULL,(DGN=FSLINE2) S SKIP=1
 S NULL=($G(DGINPUT(FSLINE2))="")!(($G(DGINPUT(FSLINE2))="@"))
 I NULL,(DGN=FSLINE3) S SKIP=1
 Q SKIP
 ;
INIT ; initialize variables
 ; This tag reads the table at FLDDAT (below) to set relationship between
 ; variables and Field numbers.
 ; 
 ; Set up array of fields needed
 N I,T,FTYPE,VNAME,FNUM,RFLD
 F I=1:1 S T=$P($T(FLDDAT+I^DGREGTE2),";;",3) Q:T="QUIT"  D
 . S FTYPE=$P(T,";",1),VNAME=$P(T,";",2),FNUM=$P(T,";",3)
 . I FTYPE=TYPE S @VNAME=FNUM
 ; Set up array of field and prompting rules
 K T,I
 F I=1:1 S T=$P($T(FLDPRMPT+I^DGREGTE2),";;",2) Q:T="QUIT"  D
 . S RFLD=$P(T,";",1) I RFLD'="ALL" S RFLD=@RFLD
 . S RPROC(RFLD,$P(T,";",2),$P(T,";",3))=$P(T,";",4)
 Q
 ; DG*5.3*1143 - Add Address Active?, Start and End Date fields
FLDDAT ; Table of field values STRUCTURE --> Description;;Type;Variable Name;Field Number
 ;;Active;;TEMP;FSACTIVE;.12105
 ;;Start Date;;TEMP;FSSTART;.1217
 ;;End Date;;TEMP;FSEND;.1218
 ;;Street Line 1;;TEMP;FSLINE1;.1211
 ;;Street Line 2;;TEMP;FSLINE2;.1212
 ;;Street Line 3;;TEMP;FSLINE3;.1213
 ;;City;;TEMP;FCITY;.1214
 ;;State;;TEMP;FSTATE;.1215
 ;;County;;TEMP;FCOUNTY;.12111
 ;;Zip;;TEMP;FZIP;.12112
 ;;Phone;;TEMP;FPHONE;.1219
 ;;Province;;TEMP;FPROV;.1221
 ;;Postal Code;;TEMP;FPSTAL;.1222
 ;;Country;;TEMP;FCNTRY;.1223
 ;;Address Node 1;;TEMP;FNODE1;.121
 ;;Address Node 2;;TEMP;FNODE2;.122
 ;;Country data piece;;TEMP;CPEICE;3
 ;;Active;;CONF;FSACTIVE;.14105
 ;;Start Date;;CONF;FSSTART;.1417
 ;;End Date;;CONF;FSEND;.1418
 ;;Street Line 1;;CONF;FSLINE1;.1411
 ;;Street Line 2;;CONF;FSLINE2;.1412
 ;;Street Line 3;;CONF;FSLINE3;.1413
 ;;City;;CONF;FCITY;.1414
 ;;State;;CONF;FSTATE;.1415
 ;;County;;CONF;FCOUNTY;.14111
 ;;Zip;;CONF;FZIP;.1416
 ;;Phone;;CONF;FPHONE;.1315
 ;;Province;;CONF;FPROV;.14114
 ;;Postal Code;;CONF;FPSTAL;.14115
 ;;Country;;CONF;FCNTRY;.14116
 ;;Address Node 1;;CONF;FNODE1;.141
 ;;Address Node 2;;CONF;FNODE2;.141
 ;;Country data piece;;CONF;CPEICE;16
 ;;QUIT;;QUIT
 ;;
 ; DG*5.3*1040; Change NULL FSLINE1 to REPEAT response code instead of REVERSE
FLDPRMPT ;Table of prompts and responses STRUCTURE --> Description;;Field;Old Value;New Value;Response Code
 ;;ALL;NULL;UPCAR;REPEAT
 ;;ALL;NULL;DELETE;QUES
 ;;ALL;NULL;VALUE;OK
 ;;ALL;VALUE;UPCAR;REPEAT
 ;;ALL;VALUE;NULL;OK
 ;;ALL;VALUE;VALUE;OK
 ;;FSLINE1;NULL;NULL;REPEAT
 ;;FSLINE2;NULL;NULL;OK
 ;;FSLINE3;NULL;NULL;OK
 ;;FCITY;NULL;NULL;REVERSE
 ;;FSTATE;NULL;NULL;REVERSE
 ;;FZIP;NULL;NULL;REVERSE
 ;;FCOUNTY;NULL;NULL;REVERSE
 ;;FPROV;NULL;NULL;OK
 ;;FPSTAL;NULL;NULL;OK
 ;;FCNTRY;NULL;NULL;REVERSE
 ;;FSLINE1;VALUE;DELETE;INSTRUCT
 ;;FSLINE2;VALUE;DELETE;CONFIRM
 ;;FSLINE3;VALUE;DELETE;CONFIRM
 ;;FCITY;VALUE;DELETE;INSTRUCT
 ;;FSTATE;VALUE;DELETE;INSTRUCT
 ;;FZIP;VALUE;DELETE;INSTRUCT
 ;;FCOUNTY;VALUE;DELETE;INSTRUCT
 ;;FPROV;VALUE;DELETE;CONFIRM
 ;;FPSTAL;VALUE;DELETE;CONFIRM
 ;;FCNTRY;VALUE;DELETE;REVERSE
 ;;QUIT
 ;;
