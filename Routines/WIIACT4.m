WIIACT4 ;VISN20/WDE/WHN/WII Admission & Discharges or OIE-OEF PTS TO VISN CONTACT
 ;;1.0;Wounded Injured and Ill Warriors;**1**;06/12/2008;Build 28
 ;-------------------------------------------------------------------------------------------------
 ;
 ;This routine goes through admissions and discharges based on a date range and collects 
 ;Patients that have particular eligibilites.  
 ;When entries are found they are stored in file 987.5 for review at the local site
 ;Before this routine finishes a message is sent to the WII ADT REVIEWER mail group alerting the site that data needs to be reviewed.
 ;A second message is sent to the national collection site that provides the site number needing to conduct the review, the date the
 ;report was run and the date range of the report.
 ;Line labels DATE, DATE2 and RESET Can't be called from any option.
 ;They will be used if the GWOT or national support needs to seed a site or reset the site entries.
 ;DBI used in this routine:
 ;        419     NAME: DBIA419   (405/ .06 Direct Global Read & w/Fileman)
 ;                                 Particular ^DGPM('AMV1',and ^DGPM('AMV3'
 ;       4938                     (2/"MPI" to get ICN with a direct read)
 ;        417           DBIA417    (40.8 / 1 Direct Global Read & w/Fileman)
 ;       2440           DBIA2440   (42 /15 Direct Global Read & w/Fileman)
 ;API's used in this routine:
 ;      use of VADPT API documented in PIMS ver 5.3 technical manual
 ;      # can also use DBIA # 10061 -  VADPT
 ;      ELIG^VADPT
 ;      SVC^VADPT
 ;      DEM^VADPT
 ;to send mail out we use the xmb API listed below
 ;http://www.va.gov/vdl/documents/Infrastructure/Mailman/xm_8_0_developerguide.pdf
 ;-------------------------------------------------------------------------------------------------
EN ; set a default past 7 days time frame
 D NOW^%DTC S WIIENDT=X_".2359" S X1=X,X2=-7 D C^%DTC S WIISTRT=X K X1,X2,X
 D NOW^%DTC S DT=X K X,Y,%
 ;clean up symbol table
JUMP ;
 D KVAR^VADPT
 ; Patient Movement File X-Ref as described in the file attributes
 ; TT=Transaction type where selections are
 ;   1=admission          
 ;   3=discharge
 ; wiistrt = start date /  dfn = patients dfn  /  wiient = ien of the movement  /  wiimodt = movement date  / wiienddt = end date
 ;  USE OF DBIA419 CUSTODIAL PACKAGE: REGISTRATION TO GO THROUGH "AMV1" AND "AMV3"
 F WIIACT="AMV1","AMV3" S WIIMODT=WIISTRT F  S WIIMODT=$O(^DGPM(WIIACT,WIIMODT)) Q:(WIIMODT="")!(WIIMODT>WIIENDT)  D  ;
 . S DFN="" F  S DFN=$O(^DGPM(WIIACT,WIIMODT,DFN)) Q:DFN=""  S WIIENT="" S WIIENT=$O(^DGPM(WIIACT,WIIMODT,DFN,WIIENT)) Q:WIIMODT=""  D  ;
 . . S WIIVALD=0 D VERPAT1(DFN)
 D XMD
 K WIIACT,WIIMODT,WIIENT,WIIENDT,WIISTRT,WIIENDT,WIITST,WIIVALD
 K XMDUZ,XMSUB,XMTEXT,XMY,Y,WIICNT
 K VADM,VAEL
 K WIITMP
 K WIIACT,WIIMODT,DFN,WIIENT,WIIACT
 D KVAR^VADPT
 D CLEAN
 Q
VERPAT1(DFN) ;
 ;VADPT API documented in PIMS ver 5.3 technical manual
 Q:$$TESTPAT^VADPT(DFN)  ; screen out test patient records
 S WIITST=0
ELIG ;
 ;VADPT API documented in PIMS ver 5.3 technical manual
 D KVAR^VADPT
 D ELIG^VADPT
 K WII1,WIISORC,WIITRAN
 S WII1=$P($G(VAEL(1)),U,2) D
 .I WII1="SHARING AGREEMENT" S WIITST=1,WIIELG=WII1 Q  ;PRIMARY ELIG
 .I WII1="TRICARE" S WIITST=1,WIIELG=WII1 Q
 .I WII1="OTHER FEDERAL AGENCY" S WIITST=1,WIIELG=WII1 Q
 ;now go through other eligibility
 I WIITST=0 S WII1=0 F  S WII1=$O(VAEL(1,WII1)) Q:(WII1="")!('+WII1)  D
 .I $P($G(VAEL(1,WII1)),U,2)="TRICARE" S WIITST=1,WIIELG=$P($G(VAEL(1,WII1)),U,2) Q
 .I $P($G(VAEL(1,WII1)),U,2)="SHARING AGREEMENT" S WIITST=1,WIIELG=$P($G(VAEL(1,WII1)),U,2) Q  ;SHARING AGREEMENT
 .I $P($G(VAEL(1,WII1)),U,2)="OTHER FEDERAL AGENCY" S WIITST=1,WIIELG=$P($G(VAEL(1,WII1)),U,2) Q
 I WIITST=0 D CLEAN Q  ;failed the eligibility no need to go futher
 D KVAR^VADPT
FORCE2 ;this tag can be called with the wiient
 ;in the case this is a discharge we want the admission number
 ;in the case of a admission we are good.
 S WIIADM=$$GET1^DIQ(405,WIIENT,.14,"I")  ;admission ien
 ;in the case that this movement is a discharge and the record in 987.5 has not been sent off    
 ;then we don't need to collect it as the admission has the data in it. 
 I WIIACT="AMV3" I $P($G(^WII(987.5,WIIADM,0)),U,9)=1 D REMOVE  ;
 ;GET WARD LOCATION TO GET DIVISION TO COVER INTEGRATED FACILITIES
 ;dbia'S     419   (405/ .06)   DBIA2440 (42/.015)      DBIA417 (40.8/1)
 S WIIDIV=$$GET1^DIQ(405,WIIADM,.06,"I")
 S WIIDIV=$$GET1^DIQ(42,WIIDIV,.015,"I")  ;THIS POINTS TO 40.8
 S WIIDIV=$$GET1^DIQ(40.8,WIIDIV,.07,"I")  ;THIS POINTS TO THE INSTU FILE AT LAST
 S WIIDIV=$$GET1^DIQ(4,WIIDIV,99,"E")  ;THE NAME
 S WII1A=$$GET1^DIQ(405,WIIADM,.01,"I"),WII1A=$$FMTE^XLFDT(WII1A,"5MZ")
 S WII3=$$GET1^DIQ(405,WIIADM,.17,"I") D
 .I WII3="" S WII3A="" Q
 .S WII3A=$$GET1^DIQ(405,WII3,.01,"I") S WII3A=$$FMTE^XLFDT(WII3A,"5MZ")
 D DEM^VADPT
 S WIINAM=$G(VADM(1)),WIISSN=$P($G(VADM(2)),U,2),WIIADAT=$$GET1^DIQ(405,WIIENT,.14)
 S WIIDOB=$P($G(VADM(3)),U,2)  ;Date of birth
 S WIISEX=$P($G(VADM(5)),U,2)  ;SEX
 S VAPA("P")="" D ADD^VADPT S WIIZIP=$G(VAPA(6))  ;The P forces the permanent address be returned
 ;DBIA 4938 for the ICN read below
 S WWICN=$P($G(^DPT(DFN,"MPI")),U,1)
 S WWISSN=$P($G(VADM(2)),U,1)
ADD ; ADD ENTRY INTO FILE ;
 S DIC="^WII(987.5,"
 S DIC(0)=""
 S X=WIIENT,DINUM=WIIENT
 D FILE^DICN
 I Y>0 D
 .S DIE=DIC
 .S DR="1///"_$G(VADM(1))_";2///"_$P($G(VADM(2)),U,1)_";3///"_WIIMODT_";4///"_WIIDIV_";5///"_WII1A_";6///"_WII3A_";7///"_WWICN_";8///1;9///"_DT_";10///"_DUZ
 .S DR=DR_";13///"_WIIZIP_";14///"_WIIDOB_";15///"_WIISEX_";16///"_WIIELG_";18///"_DFN
 .D ^DIE
CLEAN ;
 K WIITRAN,WIISTS,WIISORC,WIIMVT,WIIDIV,WIIAZ,DIC,DIE,DA,DR,WWISSN,WWICN,WIIADAT
 K WII3A,WIIDIV,WII1A,WII3A,WWICN,WIIANS,A,DINUM,DIRUT
 K WII3,WIINAM,WIIREV,WIISSN,WIIADM,WIICNT
 K WIIELG,WIIDOB,WIISEX,WIIZIP,WIICOMP
 K VAPA
 D KVAR^VADPT
 Q
REMOVE ;---------------------------------------------------------------------------------------------------
 ;If the movement is a discharge AND the admission movement is marked with a status of 1 pending approval 
 ;then we want to remove the admission from the file.  If this is not done the data file will contain two entries one for the 
 ;admission and one for the discharge.
 I $P($G(^WII(987.5,WIIADM,0)),U,9)=1 D
 .S DIK="^WII(987.5,",DA=WIIADM
 .D ^DIK
 .K DA,DIK
 Q
FORCE(DFN,WIIENT)  ;WIIENT SHOULD BE THE IEN IN THE PATIENT MOVEMENT FILE
 S WIIACT=$$GET1^DIQ(405,WIIENT,.02,"I") S WIIACT=$S(WIIACT=1:"AMV1",WIIACT=3:"AMV3",1:"")
 S WIIMODT=$$GET1^DIQ(405,WIIENT,.01,"I")
 D ELIG^VADPT
 S WIIELG=$P($G(VAEL(1)),U,2)
 D FORCE2
 D CLEAN
 Q
XMD ; send out message using XMD API
 ; XMY..........RECIPIENTS OF MSG
 ; XMDUZ........MESSAGE SENDER
 ; XMSUB........MESSAGE SUBJECT
 ; XMTEXT.......MESSAGE TEXT
 ; The XMB API listed below is used to send mail out
 S (WIIENT,WIICNT)=0 F  S WIIENT=$O(^WII(987.5,"C",1,WIIENT)) Q:(WIIENT="")!('+WIIENT)  S WIICNT=WIICNT+1
 S WIITMP("GWOT",1,0)="Active duty admission report ran from "_$$FMTE^XLFDT(WIISTRT,"2")_" to "_$$FMTE^XLFDT(WIIENDT,"2")
 I WIICNT=0 S WIITMP("GWOT",2,0)="There are No Active Duty Admissions / Discharges that need to be reviewed."
 I WIICNT>0 S WIITMP("GWOT",3,0)="There are ["_WIICNT_"]"_" Active Duty Admissions/Discharge entries that need reviewing." D
 . S WIITMP("GWOT",2,0)="You can review these entries with the WII REVIEW ADT EVENTS option."
 S WIITMP("GWOT",4,0)="-------------------------------------------------------------------------------"
 S WIITMP("GWOT",5,0)="Station ID :"_$G(^DD("SITE"))  ;"GET FACILITY OR INST DBIA OR API FOR THIS DATA"
 S WIITMP("GWOT",6,0)="Count Pending review: ["_WIICNT_"]"
 S WIITMP("GWOT",7,0)="Date ran :"_$$FMTE^XLFDT(DT,"2")
 S WIITMP("GWOT",8,0)="Reporting Period :"_$$FMTE^XLFDT(WIISTRT,"2")_" to "_$$FMTE^XLFDT(WIIENDT,"2")
 S WIIREV=$$GET1^DIQ(987.6,1,.01,"E")  ;LOCAL REVIEWER MAIL GROUP
 S WIIREV="G."_WIIREV  ;LOCAL REVIEWER GROUP
 S XMY(WIIREV)=""
 S XMDUZ=.5,XMSUB=^DD("SITE")_" - Admissions/Discharges",XMTEXT="WIITMP(""GWOT""," D ^XMD,KILL^XM
 ;send status message to repository site to track that the option and that the job is running
 K WIITMP
 ;SITE  ^  COUNT  ^  DATE RAN  ^  Start of reporting period  ^ End of REPORTING PERIOD
 S WIITMP("GWOT",1,0)="987.8 DATA^"_$G(^DD("SITE",1))_"^"_WIICNT_"^"_DT_"^"_WIISTRT_"^"_WIIENDT
 S WIIREV=$$GET1^DIQ(987.6,1,1,"I")  ;MAIL SERVER
 S XMY(WIIREV)=""
 S XMDUZ=.5,XMSUB=^DD("SITE",1)_" - Admissions/Discharges",XMTEXT="WIITMP(""GWOT""," D ^XMD,KILL^XM
 D CLEAN
 Q
 ;  All of the code below can ONLY be called from the programmer prompt.
 ;  The date tag can be used to generate data for a missing period.
 ;  For example the weekly tasked job failed to get restarted after a system shutdown.
 ;  The reset tag can be used in the case that all collected entries in 987.5 need to reset for review.
DATE ;
 K DIR S DIR(0)="DO^::EX",DIR("A")="From date" D ^DIR K DIR Q:$D(DIRUT)
 S WIISTRT=+Y
 ;end date
DATE2 ;
 K DIR S DIR(0)="DO^::EX",DIR("A")="  To date" D ^DIR K DIR Q:$D(DIRUT)
 I +Y<WIISTRT W !!,"To Date must follow From Date",!! D DATE2
 S WIIENDT=+Y_.2359
 Q:$D(DIRUT)
 W ! D JUMP
 Q
RESET ; 
 ;  Enter 1 for PENDING 2 for READY TO SEND and 3 DO NOT SEND
 R !,"SET ALL ENTRIES TO :",WIIANS:60
 S WIIENT=0 F  S WIIENT=$O(^WII(987.5,WIIENT)) Q:(WIIENT="")!('+WIIENT)  D
 .S DIE="^WII(987.5,",DA=WIIENT
 .S DR="8///"_WIIANS
 .D ^DIE
 .K DIE,DA,DR
