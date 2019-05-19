PSONVAP2 ;HPS/DSK - Non-VA Provider Updates ;May 16, 2018@16:00
 ;;7.0;OUTPATIENT PHARMACY;**481**;DEC 1997;Build 31
 ;
 ;Note to KERNEL developers:
 ; This routine was written with patch XU*8*659, but not distributed as part of the patch.
 ; It is being given to VistA Maintenance contractors to be renamed as a PSO routine
 ; to run with monthly updates for VACAA data maintenance.
 ;
 ;  Post Installation Routine for Outpatient Pharmacy VACAA non-VA provider updates
 ;  EXTERNAL REFERENCES
 ;    $$PROD^XUPROD                         - IA #4440  (Supported)
 ;    $$AESDECR^XUSHSH                      - IA #6189  (Supported)
 ;    $$B64DECD^XUSHSH                      - IA #6189  (Supported)
 ;    $$VACAA^XUESSO4                       - IA #6230  (Private)
 ;    PARENT^XUAF4                          - IA #2171  (Supported)
 ;    FTG^%ZISH                             - IA #2320  (Supported)
 ;    $$ADDNPI^XUSNPI                       - IA #6937  (Private)
 ;    $$QI^XUSNPI                           - IA #4532  (Controlled Subscription)
 ;    NEW PERSON FILE                       - IA #10060 (Supported)
 ;    NEW PERSON PHARMACY FIELDS            - IA #6889  (Private)
 ;    SERVICE/SECTION FILE                  - IA #2250  (Private)
 ;    %DT                                   - IA #10003 (Supported)
 ;
 Q
 ;
EN ;load non-VA providers into file 200
 N AUTHCODE,PSOVISN,PSOIMPORT,PSOPROD,PSOFILE
 N PSODT,PSOTIM,PSOQUIT,PSOJOB,PSOSERV
 S PSOPROD=$$PROD^XUPROD
 I 'PSOPROD D  Q
 . W !!,"This option may only be invoked in a production environment."
 . W !,"This is a test environment."
 . W !!,"If you are testing, the variable PSOPROD must be manipulated in debug mode."
 ; 
 I PSOPROD,$$PROD^XUPROD=0 D
 . W !!,"*** This is a test environment but the Prod/Test environment indicator "
 . W !,"*** indicates this is a production environment for testing purposes."
 . W !!,"*** Make sure you have the routine ZKESSO4 which is applicable for your site"
 . W !,"*** or test environment.",!!
 . S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 ;
 S PSOQUIT=0
 D CONSIDER
 Q:PSOQUIT
 D INIT
 ;notifying user to only attempt file load for the site's VISN
 W !!,"Your site VISN is: ",PSOVISN,"."
 W !,"Only providers for your VISN may be imported."
 S PSOQUIT=0
 ;
 D IMPORT
 Q:PSOQUIT
 D SERV
 Q:PSOQUIT
 D TASK
 Q
 ;
CONSIDER ;
 N DIR,DUOUT,DTOUT,Y
 W !!,"Considerations before invoking this option:"
 W !!,"TITLE (#3.1) file:"
 W !,?5,"Have the titles ""HN NON-VA PROVIDER"" and ""TW NON-VA PROVIDER"""
 W !,?5,"been defined in the TITLE (#3.1) file in this system?"
 W !,?5,"It is optional to have the titles defined."
 W !,?5,"However, the providers loaded by this patch will have no titles"
 W !,?5,"listed in CPRS if these titles are not pre-defined prior to importing"
 W !,?5,"the non-VA provider information included in this update."
 W !!,"SERVICE/SECTION (#49) file:"
 W !,?5,"Determine whether an entry for the SERVICE/SECTION (#29) field"
 W !,?5,"should be populated during the import."
 W !,?5,"It is optional to populate the SERVICE/SECTION (#29) field."
 W !,?5,"Your site may wish to define a new SERVICE/SECTION (#49) file entry"
 W !,?5,"such as ""NON-VA COMMUNITY CARE"".",!
 K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("?")="Enter ""Y"" if you wish to proceed with non-VA provider filing."
 S DIR("A")="Do you wish to proceed"
 D ^DIR K DIR
 I 'Y!($D(DUOUT))!($D(DTOUT)) S PSOQUIT=1
 Q
 ;
INIT ;initialize
 N PSOUVISN,VIEN,PSOSUB,VIEN,PSOJOBN,PSOA
 ;
 ;This exact setting of AUTHCODE is checked for by VistA routine XUESSO4
 ;The value was determined by a Kernel developer.
 S AUTHCODE="This entry point is for VACAA only. No morons."
 ;
 ;PSODT and PSOTM are used as unique subscripts in ^XTMP.
 ;Not using PSOTM since ^XTMP needs to remain for possible troubleshooting
 ;and a user might invoke this option multiple times under the same job number
 ;when processing files for multiple states within the VISN.
 ;
 S PSOJOB="PSONONVA "_$J
 I $D(^XTMP(PSOJOB)) D
 . S PSOJOBN=$J
 . F PSOA=1:1:500 Q:'$D(^XTMP(PSOJOB))  D
 . . S PSOJOBN=PSOJOBN+1
 . . S PSOJOB="PSONONVA "_PSOJOBN
 ;
 ;not checking to see if the 500th attempt is unused
 ;surely this routine won't be run 500 times using the
 ;same job number within 60 days
 ;
 S PSODT=$$FMTHL7^XLFDT(DT)
 S PSOTM=$P($$NOW^XLFDT,".",2)
 ;PSOTM should never be null, but just making sure
 I PSOTM="" S PSOTM=1
 ;
 ;Initialize trace globals which can be used for future research/troubleshooting if need be.
 ;The trace globals will purge automatically in 60 days by the VistA ^XTMP purging task.
 ;
 ;Purging just in case the ^XTMP entries exist.
 F PSOSUB="RAW DATA","DUPNPI","PRENPI","DUPNAME","PROBLEM","SUCCESS","ZNPI" D
 . K ^XTMP(PSOJOB,PSODT,PSOSUB,PSOTM)
 S ^XTMP(PSOJOB,0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^Non-VA Provider Updates"
 ;
 ;Initialize indexes
 ;
 S ^XTMP(PSOJOB,PSODT,"RAW DATA",PSOTM,1)="Name^Degree^Sex^ST 1^Street 1^Street 2^City^State^ZIP^"
 S ^XTMP(PSOJOB,PSODT,"RAW DATA",PSOTM,1)=^XTMP(PSOJOB,PSODT,"RAW DATA",PSOTM,1)_"NPI^Tax ID^TW/HN^DEA#^DEA Exp. Date^DETOX/Maint ID^"
 S ^XTMP(PSOJOB,PSODT,"RAW DATA",PSOTM,1)=^XTMP(PSOJOB,PSODT,"RAW DATA",PSOTM,1)_"Sched II Narc^Sched II Non-Narc^Sched III Narc^Sched III Non-Narc^Sched IV^Sched V"
 ;
 ;what is site's VISN
 D PARENT^XUAF4("PSOUVISN","`"_DUZ(2),"VISN")
 ;
 ;The check below is needed when testing in MNTVBB.
 ;It will not affect sites and other test environments.
 I DUZ(2)'=16066 S VIEN=$O(PSOUVISN("P",0)) S PSOVISN=$TR($P($G(PSOUVISN("P",VIEN)),U),"VISN ")
 ;
 ;line below is for testing in MNTVBB test environment
 ;keep the line for possible future changes so that the next developer does
 ;not have to research the custom VISN value in MNTVBB
 I DUZ(2)=16066 S PSOVISN=19
 Q
 ;
SERV ;
 N DIC,DTOUT,DUOUT,Y
 W !!,"Press ENTER if the SERVICE/SECTION (#29) field should not be populated.",!
 S DIC("A")="Which SERVICE/SECTION (#29) field entry should be used? "
 S DIC(0)="AEQM"
 S DIC="^DIC(49,"
 D ^DIC
 S PSOSERV=$S(+Y>0:+Y,1:"")
 I $D(DTOUT)!$D(DUOUT) S PSOQUIT=1
 Q
 ;
IMPORT ;
 N PSOTMP1,PSOTMP2,DIR,DUOUT,DTOUT,Y
 S DIR(0)="FA",DIR("A")="Directory name "
 S DIR("B")=""
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 ;
 S PSODIR=Y
 S DIR(0)="FA",DIR("A")="File Name "
 S DIR("B")=""
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 S PSOFILE=Y
 ;
 ;Validate filename to make sure VISN is correct
 I $P(PSOFILE,"_",3)'=PSOVISN D  Q
 . W !!,"This file pertains to VISN ",$P(PSOFILE,"_",3)
 . W !,"Only files for your VISN of ",PSOVISN
 . W !,"may be imported.",!
 . S PSOQUIT=1
 ;
 ;convert CSV into lower case if user specified upper case
 S $P(PSOFILE,".",2)=$TR($P(PSOFILE,".",2),"CSV","csv")
 ;
 S PSOIMPORT=$$FTG^%ZISH(PSODIR,PSOFILE,$NA(^XTMP($TR(PSOFILE,"_",""),PSOTM,1,0)),3)
 I +PSOIMPORT<1 D  Q
 . W !!,"   **** FILE: ",PSOFILE," not found in directory     ****"
 . W !!,"   **** ",PSODIR,".   ****",!
 . S PSOQUIT=1
 ;
 ;Check to make sure the first row is a header row and 
 ;that the headers are correct.
 ;This is another step to make sure the spreadsheets were properly
 ;prepared and that field values will file into the correct fields.
 S PSOTMP1=$P($G(^XTMP($TR(PSOFILE,"_",""),PSOTM,1,0)),",",1,8)
 S PSOTMP2=$P($G(^XTMP($TR(PSOFILE,"_",""),PSOTM,1,0)),",",9,23)
 D CHKHDR
 S ^XTMP(PSOFILE,0)=$$FMADD^XLFDT(DT,60)_"^"_DT_"^Non-VA Provider Updates"
 Q
 ;
TASK ;task processing
 ;
 N ZTSAVE,%ZIS,ZTSK,ZTDTH,ZTRTN,ZTDESC,ZTIO,POP
 S ZTSAVE("PSOJOB")=""
 S ZTSAVE("PSOPROD")=""
 S ZTSAVE("PSODT")=""
 S ZTSAVE("PSOTM")=""
 S ZTSAVE("PSOSERV")=""
 S PSOFILE=$TR(PSOFILE,"_","")
 S ZTSAVE("PSOFILE")=""
 S ZTSAVE("PSOVISN")=""
 S ZTSAVE("AUTHCODE")=""
 S PSOSAVDUZ=$S($O(^VA(200,"B","TASKMAN,PROXY USER",0))]"":$O(^VA(200,"B","TASKMAN,PROXY USER",0)),1:DUZ)
 S ZTSAVE("PSOSAVDUZ")=""
 S ZTRTN="PROC^PSONVAP2"
 S ZTDESC="PSO NON-VA PROVIDER IMPORT"
 S ZTIO=""
 D ^%ZTLOAD
 W:$D(ZTSK) !!,?5,"PSO NON-VA PROVIDER IMPORT TASKED: ",$G(ZTSK)
 Q
 ;
PROC ;
 N PSOTMP1,PSOTMP2,PSOXA,PSOXB,PSOXC,PSOXD,PSOXE,PSOXF
 N PSOSEQ,PSOQUIT
 S DUZ=PSOSAVDUZ
 S PSOXA=1,(PSOXB,PSOXC,PSOXD,PSOXE,PSOXF)=0
 S PSOQUIT=0,PSOSEQ=1
 ;don't check the first row since it is a header row
 F  S PSOSEQ=$O(^XTMP(PSOFILE,PSOTM,PSOSEQ)) Q:PSOSEQ=""  Q:PSOQUIT  D
 . ;
 . ;Throttle the import process in case to avoid possible
 . ;system (journaling, etc.) issues due to thousands of new entries
 . ;being filed
 . I PSOSEQ#1000=0 H 15
 . ;
 . ;Need to break line up into two variables due to possible
 . ;lengthy address lines
 . ;
 . S PSOTMP1=$P($G(^XTMP(PSOFILE,PSOTM,PSOSEQ,0)),",",1,8)
 . S PSOTMP2=$P($G(^XTMP(PSOFILE,PSOTM,PSOSEQ,0)),",",9,23)
 . ;
 . ;San Diego field test site had apparent end of file issues
 . ;in which the last line of ^XTMP was in the format "\000\000\000..."
 . ;In all instances, PSOTMP2 was null.  Inserting the check below
 . ;in case other sites have the same issue.
 . ;
 . I PSOTMP2']"" Q
 . ;
 . D CHECK
 D MAIL^PSONVAP3
 D END
 Q
 ;
CHKHDR ;
 ;
 ;Make sure required column headers are correct so data will be filed into correct
 ;New Person (#200) file fields.  
 ;  A - Provider_Sur_Name
 ;  B - Provider_First_Name
 ;  C - Provider_Suffix
 ;  D - Degree
 ;  E - Sex
 ;  F - Address Line
 ;  G - Address Line 2
 ;  H - City
 ;  I - State
 ;  J - Zip
 ;  K - VISN
 ;  L - Pvdr_NPI
 ;  M - Tax_Id__TIN_
 ;  N - TW_or_HN
 ;  O - DEA_Number
 ;  P - DEA_Expiration_Date
 ;  Q - Detox_Number
 ;  R - Schedule2
 ;  S - Schedule2N
 ;  T - Schedule3
 ;  U - Schedule3N
 ;  V - Schedule4
 ;  W - Schedule5
 ;
 N PSOI,PSOTITLE
 F PSOI=1:1:8 S PSOTITLE=$P(PSOTMP1,",",PSOI) D  Q:PSOQUIT
 . I PSOTITLE'[$P($T(HEADER+PSOI),";",4) D HDRERR
 Q:PSOQUIT
 F PSOI=1:1:15 S PSOTITLE=$P(PSOTMP2,",",PSOI) D  Q:PSOQUIT
 . I PSOTITLE'[$P($T(HEADER+PSOI+8),";",4) D HDRERR
 Q
 ;
HDRERR ;Header row is incorrect
 N DIR
 W !!,"**** Header row is missing or incorrect in file ",PSOFILE,". ****"
 W !!,"     Submit a ticket to Tier 2 to report this issue.",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR K DIR
 S PSOQUIT=1
 Q
 ;
HEADER ;
 ;;1;Provider_Sur_Name
 ;;2;Provider_First_Name
 ;;3;Provider_Suffix
 ;;4;Degree
 ;;5;Sex
 ;;6;Address_Line
 ;;7;Address_Line_2
 ;;8;City
 ;;9;State
 ;;10;Zip
 ;;11;VISN
 ;;12;Pvdr_NPI
 ;;13;Tax_ID__TIN_
 ;;14;TW_or_HN
 ;;15;DEA_Number
 ;;16;DEA_Expiration_Date
 ;;17;Detox_Number
 ;;18;Schedule2
 ;;19;Schedule2N
 ;;20;Schedule3
 ;;21;Schedule3N
 ;;22;Schedule4
 ;;23;Schedule5
 Q
 ;
CHECK ;analyze data and determine whether to file
 ;
 N PSOI,X,PSONPI,PSODUZ
 ;decrypt NPI, Tax ID, and DEA#
 F PSOI=4,5,7 I $P(PSOTMP2,",",PSOI)]"" D
 . S $P(PSOTMP2,",",PSOI)=$$AESDECR^XUSHSH($$B64DECD^XUSHSH($P(PSOTMP2,",",PSOI)),"BaDcefXXijklmnop")
 ;File raw data if future troubleshooting needed
 ;^XTMP is indexed by date in case the site needs to perform research after the
 ;MailMan messages have been deleted
 ;
 S PSOXA=PSOXA+1
 S ^XTMP(PSOJOB,PSODT,"RAW DATA",PSOTM,PSOXA)=PSOTMP1_","_PSOTMP2
 ;
 ;check to see if the provider NPI is already on file
 S PSONPI=$P(PSOTMP2,",",4)
 S PSODUZ=$$FNDUSR(PSONPI)
 ;
 ;was NPI already on file at site before this patch was received?  If so, quit
 I +PSODUZ>0,'$D(^XTMP(PSOJOB,PSOTM,"NPI",PSONPI)) D  Q
 . I $D(^XTMP(PSOJOB,PSODT,"ZNPI",PSONPI)) Q
 . S PSOXB=PSOXB+1
 . S ^XTMP(PSOJOB,PSODT,"PRENPI",PSOTM,PSOXB)=PSOTMP1_","_PSOTMP2
 . S ^XTMP(PSOJOB,PSODT,"ZNPI",PSONPI)=""
 ;
 ;Has NPI been received multiple times in this provider load?
 ;If so, store duplicates in trace global and send in MailMan message
 I +PSODUZ>0,$D(^XTMP(PSOJOB,PSOTM,"NPI",PSONPI)) D  Q
 . S PSOXC=PSOXC+1
 . S ^XTMP(PSOJOB,PSODT,"DUPNPI",PSOTM,PSOXC)=PSOTMP1_","_PSOTMP2
 . S ^XTMP(PSOJOB,PSODT,"ZNPI",PSONPI)=""
 ;
 Q:+PSODUZ>0
 ;
 ;is Provider Name already on file
 I $$CHKNAME() D  Q
 . I $D(^XTMP(PSOJOB,PSODT,"ZNPI",PSONPI)) Q
 . S PSOXD=PSOXD+1
 . S ^XTMP(PSOJOB,PSODT,"DUPNAME",PSOTM,PSOXD)=PSOTMP1_","_PSOTMP2
 . S ^XTMP(PSOJOB,PSODT,"ZNPI",PSONPI)=""
 ;
 D FILE200
 Q
 ;
FILE200 ;
 ;Call Kernel interface to NEW PERSON file (#200) add/edit
 N PSOI,INARRAY,PSONEW,PSOFLG,PSONPI2,PSODUZ2
 S PSOFLG=0
 S INARRAY(0)=PSOVISN
 ;name
 S INARRAY(1)=$P(PSOTMP1,",")_","_$P(PSOTMP1,",",2)_$S($P(PSOTMP1,",",3)]"":" ",1:"")_$P(PSOTMP1,",",3)
 ;degree
 S INARRAY(2)=$P(PSOTMP1,",",4)
 ;sex
 S INARRAY(3)=$P(PSOTMP1,",",5)
 ;address line one
 S INARRAY(4)=$P(PSOTMP1,",",6)
 ;address line two
 S INARRAY(5)=$P(PSOTMP1,",",7)
 ;city
 S INARRAY(7)=$P(PSOTMP1,",",8)
 ;state
 S INARRAY(8)=$P(PSOTMP2,",")
 ;zip
 ;file import / export strips leading 0 off Zip codes
 S INARRAY(9)=$S($L($P(PSOTMP2,",",2))<5:$E("00000",1,5-$L($P(PSOTMP2,",",2)))_$P(PSOTMP2,",",2),1:$P(PSOTMP2,",",2))
 ;skipping $P(PSOTMP2,",",3) because the VISN number is not filed
 ;
 ;NPI
 S INARRAY(10)=$P(PSOTMP2,",",4)
 ;Tax ID
 ;file import/export strips leading 0's off Tax ID
 S INARRAY(11)=$S($L($P(PSOTMP2,",",5))<9:$E("000000000",1,9-$L($P(PSOTMP2,",",5)))_$P(PSOTMP2,",",5),1:$P(PSOTMP2,",",5))
 ;DEA#
 S INARRAY(12)=$P(PSOTMP2,",",7)
 ;Subject Organization text and ID
 S INARRAY(13)="Veteran Care in the Community"
 ;The space is needed after N/A to pass four character requirement
 ;in XUESSO2.
 S INARRAY(14)="N/A "
 ;
 ;The additional check for production ensures that duplicate errors won't
 ;be generated during testing.
 I PSOPROD,$$PROD^XUPROD=1 S PSONEW=$$VACAA^XUESSO4(.INARRAY,AUTHCODE)
 ;
 ;If PSONEW is less than 1, XUESSO4 refused to file, so there is no need
 ;to continue attempting to file additional data for this provider.
 I +PSONEW<1 D PROB Q
 D NPI(+PSONEW,INARRAY(10)),MORE,DEL
 Q
 ;
PROB ;problem detected after FileMan call
 N PSOXERR,PSOTXT,PSOPAD
 S PSOXE=PSOXE+1
 S PSOTXT=$S($P(PSONEW,U,2)]"":$P(PSONEW,U,2),1:"No reason text available.")
 I PSOFLG=1 S PSOTXT="Check ^XTMP(""PSONONVA ""_[job number],[date],""PROBLEM"""
 S PSOPAD=$E("                                                  ",1,55-$L(PSOTXT))
 S ^XTMP(PSOJOB,PSODT,"PROBLEM",PSOTM,PSOXE)=$E(PSOTXT,1,55)_PSOPAD_$E(INARRAY(1),1,20)
 M ^XTMP(PSOJOB,PSODT,"PROBLEM",PSOTM,PSOXE)=INARRAY
 I PSOFLG=1 D
 . M ^XTMP(PSOJOB,PSODT,"PROBLEM",PSOTM,PSOXE)=PSOERR
 Q
 ;
NPI(PSODUZ2,PSONPI2) ;This call needed to file EFFECTIVE DATE/TIME and sub-fields
 N PSOCHK
 S PSOCHK=$$ADDNPI^XUSNPI("Individual_ID",+PSODUZ2,PSONPI2,$$NOW^XLFDT(),1)
 Q
 ;
MORE ;File additional fields 
 ;approved by IA #6889
 N PSOFDR,PSOERR,X,Y
 ;
 ;PSOFLG is used in PROB if there are FileMan errors
 S PSOFLG=1
 ;
 ;Service/Section
 S PSOFDR(200,+PSONEW_",",29)=PSOSERV
 ;
 ;Remarks
 S PSOFDR(200,+PSONEW_",",53.9)=$P(PSOTMP2,",",6)_" NON-VA PROVIDER"
 ;DEA Expiration Date (convert to VistA date format if not null)
 S X=$P(PSOTMP2,",",8)
 I X]"" D
 . D ^%DT
 . S PSOFDR(200,+PSONEW_",",747.44)=Y
 ;Detox/Maintenance ID Number
 S PSOFDR(200,+PSONEW_",",53.11)=$P(PSOTMP2,",",9)
 ;
 ;Convert "Y" or "N" for Schedule fields to "1" or "0"
 ;Schedule II Narcotic
 S PSOFDR(200,+PSONEW_",",55.1)=$S($P(PSOTMP2,",",10)="Y":1,1:0)
 ;Schedule II Non-Narcotic
 S PSOFDR(200,+PSONEW_",",55.2)=$S($P(PSOTMP2,",",11)="Y":1,1:0)
 ;Schedule III Narcotic
 S PSOFDR(200,+PSONEW_",",55.3)=$S($P(PSOTMP2,",",12)="Y":1,1:0)
 ;Schedule III Non-Narcotic
 S PSOFDR(200,+PSONEW_",",55.4)=$S($P(PSOTMP2,",",13)="Y":1,1:0)
 ;Schedule IV
 S PSOFDR(200,+PSONEW_",",55.5)=$S($P(PSOTMP2,",",14)="Y":1,1:0)
 ;Schedule V
 S PSOFDR(200,+PSONEW_",",55.6)=$S($P(PSOTMP2,",",15)="Y":1,1:0)
 D UPDATE^DIE("","PSOFDR","IEN","PSOERR")
 I $D(PSOERR("DIERR")) D PROB
 ;
 ;continue filing additional fields even if there was a problem 
 ;with previous call since the provider has information filed by this time.
 ;
 K PSOFDR,PSOERR
 S PSOFDR(200,+PSONEW_",",8)=$P(PSOTMP2,",",6)_" NON-VA PROVIDER"
 D UPDATE^DIE("E","PSOFDR","IEN","PSOERR")
 I $D(PSOERR("DIERR")) D PROB
 ;
 ;if Title is not defined in the TITLE (#3.1) file, file as text
 K PSOERR
 I $P($G(^VA(200,+PSONEW,0)),"^",9)="" D
 . D UPDATE^DIE("U","PSOFDR","IEN","PSOERR")
 . I $D(PSOERR("DIERR")) D PROB
 S PSOXF=PSOXF+1
 S ^XTMP(PSOJOB,PSOTM,"NPI",INARRAY(10))=""
 S ^XTMP(PSOJOB,PSODT,"SUCCESS",PSOTM,PSOXF)=+PSONEW_$E("               ",1,15-$L(+PSONEW))_$E(INARRAY(1),1,35)
 K INARRAY
 ;
 Q
 ;
DEL ;Delete key XUORES which was filed by XUESSO4
 ;UNCOMMENT if it is decided later to remove the key
 ;N DIC,X,DIK,DA
 ;S DIK="^VA(200,"_+PSONEW_",51,"
 ;S DA(1)=+PSONEW
 ;S DIC="^DIC(19.1,",DIC(0)="MZ",X="XUORES" D ^DIC
 ;S DA=+Y
 ;D ^DIK
 Q
 ;
FNDUSR(PSONPI) ;see if provider already on file
 ;A previous version of this routine checked to see if the
 ;provider is active.  However, if the NPI is already on file,
 ;Kernel routine XUESSO4 will file data into the New Person IEN
 ;on file.  This can create issues because old and new information
 ;is on file within the same IEN.
 N PSOATTRIB
 S PSOATTRIB(8)=PSONPI ; NPI
 S PSODUZ=$$QI^XUSNPI(PSOATTRIB(8))
 Q $S(PSODUZ'=0:1,1:0)
 ;
CHKNAME() ;is provider name already in New Person file
 ;if so, store data in trace global and send MailMan message
 N PSONAME
 ;do not validate suffix to be on safe side
 S PSONAME=$P(PSOTMP1,",",1,2)
 I $D(^VA(200,"B",PSONAME)) Q 1
 Q 0
 ;
END ;clean up
 ;
 K ^XTMP(PSOJOB,PSOTM)
 K ^XTMP(PSOJOB,PSODT,"ZNPI")
 K ^XTMP(PSOFILE,PSOTM)
 K PSODIR,PSOFILE,PSOSAVDUZ,PSOTM
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
