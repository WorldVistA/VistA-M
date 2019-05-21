LRAPUALT ;HPS/DSK - MISSING ANATOMIC PATHOLOGY ALERT SEARCH ;May 1, 2018@16:24
 ;;5.2;LAB SERVICE;**504**;Sep 27, 1994;Build 33
 ;
 Q
 ; 
 ;Reference to ^DPT supported by IA# 10035
 ;Reference to ^OR(100 supported by IA# 4167
 ;Reference to ^XTV(8992.1 supported by IA# 6914
 ;Reference to DD^%DT supported by IA #10003
 ;Reference to NOW^%DTC supported by IA #10000
 ;Reference to ^XLFDT calls supported by IA #10103
 ;Reference to ^XPAR calls supported by IA #2263
 ;Reference to %ZTLOAD supported by IA #10063
 ;Reference to $$SENDMSG^XMXAPI supported by IA #2729
 ;Reference to $$SETUP1^XQALERT supported by IA #10081
 ;
EN ;
 N LRQUIT,LRTASK,LRSDATE,LREDATE,LRSUB,LRDUZ
 ;
 S LRQUIT=0
 D DATE
 Q:LRQUIT
 D QUEUE
 Q
 ;
DATE ;
 I '$G(ZTQUEUED) D  Q
 . W !!,?5,"This option will search for missing Anatomic Pathology alerts"
 . W !,?5,"on verified accessions as well as other issues such as"
 . W !,?5,"incorrect settings in the Orders (#100) file."
 . W !!,?5,"This routine will run in the background and send an alert as well as"
 . W !,?5,"a MailMan message to you as well as the MailMan group ""LMI"" if any"
 . W !,?5,"missing Anatomic Pathology alerts are found."
 . W !!,?5,"The search may take upwards of 20 minutes to run the first time"
 . W !,?5,"or if it is run infrequently.",!
 . W !!,"The dates for the following prompts pertain to the dates that an"
 . W !,"Anatomic Pathology case is verified."
 . W !,"   (The date range cannot be more than a year due to the possibility that"
 . W !,"   the search may take a long time to complete.)",!
 . D ASK
 ;
 ;Search all verified cases from start date to current for TaskMan executions
 S LREDATE=$$NOW^XLFDT()
 ;
 ;Check parameter setting for the last date/time that TaskMan ran the search
 S LRSDATE=$$GET^XPAR("SYS","LR AP ALERT SEARCH END",1,"Q")
 ;
 ;If report hasn't been run before, generate for previous 30 days
 I LRSDATE="" S LRSDATE=$$FMADD^XLFDT(LREDATE,-30)
 ;
 ;Save end date/time in parameter to use next time that TaskMan searches
 D EN^XPAR("SYS","LR AP ALERT SEARCH END",,LREDATE,"")
 Q
 ;
ASK ;
 ;Only used for manual execution of routine "Missing AP Alert Search"
 ;(not used by TaskMan).
 ;
 N DIR
 S DIR(0)="DO",DIR("A")="Date to begin search"
 D ^DIR
 I $G(Y)=""!($D(DTOUT))!($D(DUOUT)) S LRQUIT=1 Q
 S LRSDATE=$P(Y,".")
 D DD^%DT W ?40,$G(Y)
 S DIR(0)="DO",DIR("A")="Date to end search"
 D ^DIR
 I $G(Y)=""!($D(DTOUT))!($D(DUOUT)) S LRQUIT=1 Q
 S LREDATE=$P(Y,".")
  I LRSDATE>LREDATE D  G ASK
 . W !,?5,"The start date cannot be greater than the end date.",!
 D DD^%DT W ?40,$G(Y)
 I $$FMDIFF^XLFDT(LREDATE,LRSDATE)>365 D  G ASK
 . W !!,"A maximum of a year's worth of orders may be searched due to"
 . W !,"potential journaling or other system issues.",!
 S LREDATE=LREDATE_".2359"
 Q
 ;
QUEUE ;
 S LRSUB="LR AP ALERT TRACE "_LREDATE
 L +^XTMP(LRSUB):5
 ;
 ;For the lock to fail, two processes must be starting the same date/time, but
 ;checking anyway.
 I '$T,'$G(ZTQUEUED) D  Q
 . W !!,"Someone else (or TaskMan) is currently executing this option. Please try later."
 ;
 L -^XTMP(LRSUB)
 ;
 ;store DUZ if a user is manually executing the option
 S LRDUZ=$S('$G(ZTQUEUED):DUZ,1:"")
 ;
 S LRTASK=0
 S LRTASK=$$TASK()
 I '$G(ZTQUEUED),LRTASK D  Q
 . W !!,"Task #: ",+LRTASK," has been queued to run on "
 . W $$HTE^XLFDT($P(LRTASK,"^",2))
 I '$G(ZTQUEUED),'LRTASK D
 . W !!,"Task not queued for unknown reason. Please try again."
 Q
 ;
TASK() ;
 N ZTRTN,ZTDESC
 S ZTSAVE("LRDUZ")=""
 S ZTSAVE("LRSDATE")=""
 S ZTSAVE("LREDATE")=""
 S ZTSAVE("LRSUB")=""
 S ZTRTN="START^LRAPUALT"
 S ZTDESC="Missing AP Alert Search"
 S ZTIO=""
 D ^%ZTLOAD
 Q +$G(ZTSK)_"^"_$G(ZTSK("D"))
 ;
START ;
 L +^XTMP(LRSUB):20
 I '$T D LOCKED Q
 ;
 N LRAREA,LRSS,X,%,LRDT,LRDTTM
 D NOW^%DTC
 ;Keep date/time stamp in case running this routine manually multiple times a day
 ;and monitoring for missing alerts since the last time the routine ran
 ;
 S LRDT=X,LRDTTM=%
 ;
 ;Keep data for 90 days for future research, if needed
 S ^XTMP(LRSUB,0)=$$FMADD^XLFDT(LRDT,90)_"^"_LRDT_"^Missing AP Alert research"
 ;
 ;Kill message text if not killed previously for some reason
 K ^XTMP("AP ALERT MESSAGE "_LREDATE)
 ;
 ;LRLINE for Mail Message line count
 S LRLINE=4
 ;
 ;Find all accession areas for CY, EM, and SP LR subscripts
 ;
 S LRSS=0
 F  S LRSS=$O(^LRO(68,LRSS)) Q:'LRSS  D
 . S LRAREA=$P($G(^LRO(68,LRSS,0)),"^",2)
 . I "CYEMSP"[LRAREA D LRSS
 D END
 Q
 ;
LRSS ;
 ;Check to see if a yearly, monthly or daily accession area
 ;even though Anatomic Pathology accession areas are normally yearly
 N LRTYPE,LRAD
 S LRTYPE=$P(^LRO(68,LRSS,0),"^",3)
 ;
 ;No other types should exist, but checking to be sure
 I ",Y,M,D,"'[LRTYPE Q
 ;
 ;A daily accession area might have some cases re-checked due to logic below.
 ;However, Anatomic Pathology accession areas are normally not daily.
 S LRAD=$S(LRTYPE="Y":$E(LRSDATE,1,3)-1_"000",LRTYPE="M":$E(LRSDATE,1,5)-1_"00",1:$P(LRSDATE,".")-1_".2359")
 ;
 ;Yearly area: If LRAD year is greater than end date's year - quit
 ;Monthly area: If LRAD year/month is greater than end date's year/month - quit
 ;Daily area: If LRAD year/month/day is greater than end date - quit
 ;All checks are needed if user manually executed the search.
 ;(Note: The line below is long but is more efficient by not looping through
 ;       all date levels if manually manually executed the search.)
 ;
 F  S LRAD=$O(^LRO(68,LRSS,1,LRAD)) Q:'LRAD  Q:$E(LRAD,1,3)>$E(LREDATE,1,3)  Q:$E(LRAD,1,5)>$E(LREDATE,1,5)  Q:LRAD>$P(LREDATE,".")  D
 . ;only looping through accessions starting with start date's year
 . I $E(LRAD,1,3)'<$E(LRSDATE,1,3) D LRAC
 Q
 ;
LRAC ;Cycle through accessions by verified date/time
 N LRVER,LRAC
 ;
 ;Start of search will be by date/time for TaskMan and by date for a user
 ;TaskMan searches might be defined to run several times daily.
 S LRVER=$S(LRDUZ]"":LRSDATE-1_".2359",1:LRSDATE)
 ;
 F  S LRVER=$O(^LRO(68,LRSS,1,LRAD,1,"AC",LRVER)) Q:LRVER>LREDATE  Q:LRVER=""  D
 . S LRAC=0
 . F  S LRAC=$O(^LRO(68,LRSS,1,LRAD,1,"AC",LRVER,LRAC)) Q:LRAC=""  D
 . . ;
 . . ;Are results verified? 
 . . ;Since multiple tests may be on file in file 68, it's
 . . ;easier to look in file 69 for the completion status
 . . D CHK69
 Q
 ;
CHK69 ;
 N LRLABNM,LRODT,LRSN,LRRL
 S LRLABNM=$G(^LRO(68,LRSS,1,LRAD,1,LRAC,.1))
 I LRLABNM="" S ^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC)="No Lab Number in file 68" Q
 ;
 ;There should only be one file 69 entry, but running a loop
 ;just in case
 ;
 S LRRL="",(LRODT,LRSN)=0
 F  S LRODT=$O(^LRO(69,"C",LRLABNM,LRODT)) Q:LRODT=""  D
 . F  S LRSN=$O(^LRO(69,"C",LRLABNM,LRODT,LRSN)) Q:LRSN=""  D
 . . S LRRL=$P($G(^LRO(69,LRODT,1,LRSN,3)),"^",2)
 . . I LRRL]"" D CHK100
 Q
 ;
CHK100 ;check the orders file
 ;get CPRS order number
 ;multiple order numbers can be present per file 69 specimen number
 ;but Anatomic Pathology should only have one CPRS order number
 N LRCPRS,LRFULL,LRPKG,LRSTATUS,LRRES,LRADFN
 S LRCPRS=$P($G(^LRO(69,LRODT,1,LRSN,0)),"^",11)
 I LRCPRS="" S ^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC)="No CPRS order number" Q
 ;
 ;Need full accession number (ex. "SP 18 34") when checking
 ;for missing alerts and for possible MailMan messages
 S LRFULL=$G(^LRO(68,LRSS,1,LRAD,1,LRAC,.2))
 ;
 ;This should never be null, but checking nevertheless.
 I LRFULL="" S ^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC)="No accession in File 68 at .2 level." Q
 ;
 ;Setting date/time levels in ^XTMP using variable LRDTTM
 ;so will only have to check recent dates/times the search was executed
 ;if reviewing the global and the search runs multiple times daily
 ;
 ;is package reference missing
 S LRPKG=$P($G(^OR(100,LRCPRS,4)),";",4,5)
 I LRPKG="" D
 . D MSGINIT
 . S LRLINE=LRLINE+1
 . S ^XTMP("AP ALERT MESSAGE "_LREDATE,LRLINE)="   - is missing package reference for order "_LRCPRS_"."
 . S ^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC,"NO_PKG_REF")=LRCPRS_"^Missing package reference"
 ;
 ;is status correct
 S LRSTATUS=$P($G(^OR(100,LRCPRS,3)),"^",3)
 I LRSTATUS'=2 D
 . I '$D(^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC)) D MSGINIT
 . S LRLINE=LRLINE+1
 . S ^XTMP("AP ALERT MESSAGE "_LREDATE,LRLINE)="   - has incorrect status of "_LRSTATUS_" for order "_LRCPRS_"."
 . S ^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC,"INCORRECT_STATUS")=LRCPRS_"^Incorrect status of "_LRSTATUS
 ;
 ;Is Results Date/Time set
 S LRRES=$P($G(^OR(100,LRCPRS,7)),"^")
 I LRRES="" D
 . I '$D(^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC)) D MSGINIT
 . S LRLINE=LRLINE+1
 . S ^XTMP("AP ALERT MESSAGE "_LREDATE,LRLINE)="   - has no results date/time for order "_LRCPRS_"."
 . S ^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC,"NO_RESULTS_DATE/TIME")=LRCPRS_"^No results date/time"
 ;
 ;was alert generated?
 ;alerts are only sent for Patient (#2) file
 S LRADFN=$P(^OR(100,LRCPRS,0),"^",2)
 I $P(LRADFN,";",2)["DPT" D
 . S LRADFN=$P(LRADFN,";")
 . D CHKALERT
 Q
 ;
MSGINIT ;
 ;First time issue found for this accession
 S LRLINE=LRLINE+1
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,LRLINE)="  "_LRFULL_":"
 Q
 ;
CHKALERT ;
 N LRALERT,LRHIT,LRPNM
 S LRALERT="",LRHIT=0
 F  S LRALERT=$O(^XTV(8992.1,"C",LRADFN,LRALERT)) Q:LRALERT=""  Q:LRHIT  D
 . I $P($G(^XTV(8992.1,LRALERT,2)),"^",2)=LRFULL S LRHIT=1
 I 'LRHIT D
 . S LRPNM=$P(^DPT(LRADFN,0),"^")
 . I '$D(^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC)) D MSGINIT
 . S LRLINE=LRLINE+1
 . S ^XTMP("AP ALERT MESSAGE "_LREDATE,LRLINE)="   - *** did not generate an alert. ***"
 . ;not sending patient name in MailMan message in case this would violate CRISP
 . ;setting into ^XTMP to aid in research if needed
 . S ^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC,"NO_ALERT")=LRFULL_"^"_LRCPRS_"^"_LRPNM_"^Missing alert"
 . S ^XTMP("AP NO ALERT "_LREDATE)=""
 Q
 ;
END ;Send alerts and MailMan messages
 ;LRDUZ is null if search executed by TaskMan
 ;
 ;Issues were found
 I $D(^XTMP("AP ALERT MESSAGE "_LREDATE)) D
 . D MAIL
 . I $D(^XTMP("AP NO ALERT "_LREDATE)) D ALERT Q
 . ;Issues were found by none are missing alerts
 . D ALERT3
 ;
 ;No issues were found
 ;Do not send alert and MailMan message if executed by TaskMan
 I '$D(^XTMP("AP ALERT MESSAGE "_LREDATE)),LRDUZ]"" D
 . D MAIL2,ALERT2
 ;
 K ^XTMP("AP ALERT MESSAGE "_LREDATE),^XTMP("AP NO ALERT "_LREDATE)
 S ^XTMP(LRSUB,LRDTTM,.1)=$S($D(^XTMP(LRSUB,LRDTTM)):"Issue(s) found",1:"Nothing found")
 S ^XTMP(LRSUB,LRDTTM,.2)="Date Range: "_$$FMTE^XLFDT(LRSDATE)_" to: "_$$FMTE^XLFDT(LREDATE)
 L -^XTMP(LRSUB)
 Q
 ;
MAIL ;
 N LRMRANGE,LRMTEXT,LRMSUB,LRMY,LRMZ,LRMIN
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,1)="Anatomic Pathology Alert Search Issues Found"
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,2)=" "
 S LRMRANGE=$S(LRDUZ]"":"Date ",1:"Date/Time ")_"Range Searched: "_$$FMTE^XLFDT(LRSDATE)
 S LRMRANGE=LRMRANGE_" to: "_$S(LRDUZ]"":$P($$FMTE^XLFDT(LREDATE),"@"),1:$$FMTE^XLFDT(LREDATE))
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,3)=LRMRANGE
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,4)=" "
 S LRMTEXT="^XTMP(""AP ALERT MESSAGE ""_LREDATE)"
 S LRMSUB="Anatomic Pathology Alert Search Issues Found"
 ;
 ;send to user if manually running the routine
 I LRDUZ]"" S LRMY(LRDUZ)=""
 S LRMY("G.LMI")=""
 ;
 S LRMIN("FROM")="Anatomic Pathology Missing Alert Search"
 D SENDMSG^XMXAPI(DUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,.LRMZ,"")
 Q
 ;
ALERT ;
 ;Individual alerts are sent for each accession which is missing an alert
 ;"X" prefixed variables are needed for sending alerts
 N LRTXT,XQAMSG,XQA,XQAID,LRSS,LRAD,LRAC,LRALERT
 S LRTXT="*** ALERT NOT SENT FOR ACCESSION: "
 S (LRSS,LRAD,LRAC)=""
 F  S LRSS=$O(^XTMP(LRSUB,LRDTTM,LRSS)) Q:LRSS=""  D
 . F  S LRAD=$O(^XTMP(LRSUB,LRDTTM,LRSS,LRAD)) Q:LRAD=""  D
 . . F  S LRAC=$O(^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC)) Q:LRAC=""  D
 . . . S LRFULL=$P($G(^XTMP(LRSUB,LRDTTM,LRSS,LRAD,LRAC,"NO_ALERT")),"^")
 . . . Q:LRFULL=""
 . . . ;need to re-set XQAID and XQA because it is killed if sending multiple
 . . . ;alerts
 . . . S XQAID="Missing Alert"
 . . . I LRDUZ]"" S XQA(LRDUZ)=""
 . . . S XQA("G.LMI")=""
 . . . S XQAMSG=LRTXT_LRFULL_" ***"
 . . . S LRALERT=$$SETUP1^XQALERT
 Q
 ;
MAIL2 ;
 ;This section is only called if a user manually invoked the option.
 N LRMRANGE,LRMTEXT,LRMSUB,LRMY,LRMZ,LRMIN
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,1)=" "
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,2)="No missing Anatomic Pathology alert issues found on "
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,2)=^XTMP("AP ALERT MESSAGE "_LREDATE,2)_$$FMTE^XLFDT(LRDTTM,"MZ")_"."
 S LRMRANGE="Date Range Searched: "_$$FMTE^XLFDT(LRSDATE)
 S LRMRANGE=LRMRANGE_" to: "_$S(LRDUZ]"":$P($$FMTE^XLFDT(LREDATE),"@"),1:$$FMTE^XLFDT(LREDATE))
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,3)=LRMRANGE
 S ^XTMP("AP ALERT MESSAGE "_LREDATE,4)=" "
 S LRMTEXT="^XTMP(""AP ALERT MESSAGE ""_LREDATE)"
 S LRMSUB="No Anatomic Pathology Alert Search Issues Found"
 ;
 ;send to person running the routine
 S LRMY(LRDUZ)=""
 S LRMY("G.LMI")=""
 ;
 S LRMIN("FROM")="Anatomic Pathology Missing Alert Search"
 D SENDMSG^XMXAPI(LRDUZ,LRMSUB,LRMTEXT,.LRMY,.LRMIN,.LRMZ,"")
 K ^XTMP("AP ALERT MESSAGE "_LREDATE)
 Q
 ;
ALERT2 ;
 ;This section is only called if a user manually invoked the search option.
 N XQAMSG,XQA,XQAID,LRALERT
 S XQAID="Missing Alert Search"
 S XQA(LRDUZ)=""
 S XQA("G.LMI")=""
 S XQAMSG="No Missing AP Alerts Found on "_$$FMTE^XLFDT(LRDTTM,"MZ")
 S LRALERT=$$SETUP1^XQALERT
 Q
 ;
ALERT3 ;
 N XQAMSG,XQA,XQAID,LRALERT
 S XQAID="Missing Alert Search"
 I LRDUZ]"" S XQA(LRDUZ)=""
 S XQA("G.LMI")=""
 S XQAMSG="Issues(s) found but no missing AP alerts on "_$$FMTE^XLFDT(LRDTTM,"MZ")
 S LRALERT=$$SETUP1^XQALERT
 Q
 ;
LOCKED ;Routine was already being executed by time a user or TaskMan started
 ;This should be a rare occurrence.
 N XQAMSG,XQA,XQAID,LRALERT,%
 D NOW^%DTC
 S XQAID="Missing Alert Search"
 I LRDUZ]"" S XQA(LRDUZ)=""
 S XQA("G.LMI")=""
 S XQAMSG="Missing Alert Search already running - "_$$FMTE^XLFDT(%,"MZ")
 S LRALERT=$$SETUP1^XQALERT
 Q
