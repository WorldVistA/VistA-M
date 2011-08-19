IVMADDRP ;ALB/PHH,EG,ERC,BAJ,CKN - IVM ADDRESS UPLOAD LOG REPORT ; 7/11/06 4:36pm
 ;;2.0;INCOME VERIFICATION MATCH;**108,106,115**; 21-OCT-94;Build 28
 ;
 ; This routine list veterans who have had more than one address
 ; change in the past 90 days.
 ;
 N SDATE,EDATE,HDR,MSG,%ZIS,ZTRTN,ZTDESC,ZTSAVE,PAGE,ZTSK,ZTREQ,POP,X
 N BDT,U,DFN,SO
 S U="^",DFN="",SO=""
 S DOS=$$DOS
 I DOS="^" Q
 S X=$$ENDDATE
 I X="" Q
 S BDT=$P(X,"^",1)
 I DOS="D" D  I DFN="" Q
 . S DFN=$$GETPAT
 . Q
 I DOS="S" S SO=$$SORTORD I SO="^" Q
 S (SDATE,EDATE,HDR)=""
 S EDATE=$$FMADD^XLFDT(BDT) I EDATE="" Q
 S SDATE=$$FMADD^XLFDT(EDATE,-90)
 ;
 ; Get report device. Queue report if requested
 S MSG(1)=""
 S MSG(2)="This report may take a long time to generate.  It is recommended that the report"
 S MSG(3)="be queued to print."
 S MSG(4)=""
 D BMES^XPDUTL(.MSG)
 K IOP,%ZIS
 S %ZIS="MQ"
 D ^%ZIS I POP W !!,"Report Cancelled!" Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="START^IVMADDRP"
 . S ZTDESC="IVM Address Change Log Report"
 . S (ZTSAVE("PAGE"),ZTSAVE("SDATE"),ZTSAVE("EDATE"))=""
 . S (ZTSAVE("DOS"),ZTSAVE("DFN"),ZTSAVE("SO"))=""
 . D ^%ZTLOAD
 . W !!,"Report "_$S($D(ZTSK):"Queued!",1:"Cancelled!")
 . D HOME^%ZIS
 . Q
 D START,^%ZISC
 Q
DOS() ;detail or summary
 N DIR,Y,X
 S DIR(0)="SA^D:Detail;S:Summary"
 S DIR("A")="Select Type of Report to Run: "
 D ^DIR
 Q Y
 ;
GETPAT() ;get a patient
 N DIC,Y,X,U
 S DIC="^DPT(",DIC(0)="AEQZM" D ^DIC
 Q $S($P(Y,U,1)>0:$P(Y,U,1),1:"")
 ;
ENDDATE() ;get an end date, default to TODAY
 N DIR,Y,X
 S DIR(0)="D^::EX",DIR("?")="^D HELP^%DTC",DIR("B")=$$FMTE^XLFDT(DT)
 S DIR("A")="Enter End Date of 90 Day Window: "
 D ^DIR
 Q $S('Y:"",1:Y)
 ;
SORTORD() ;get sort order for summary
 N DIR,Y,X
 S DIR(0)="SA^S:Social Security Number;N:Name then SSN"
 S DIR("A")="What Order Do You Want to See Output: "
 D ^DIR
 Q Y
 ;
START ; Generate Report
 N CRT,X
 K ^XTMP("IVMADDRP",$J)
 S CRT=$S($E(IOST,1,2)="C-":1,1:0)
 S X=$$BUILD(SDATE,EDATE,DOS,DFN,SO)
 U IO W ! D REPORT W ! U 0
 K ^XTMP("IVMADDRP",$J)
 I $G(ZTSK) S ZTREQ="@"
 Q
BUILD(SDATE,EDATE,DOS,DFN,SO) ; Build the Report
 ;use C index if you are only looking for one DFN
 I $L(DFN) D C Q 1
 N CHDTTM
 S CHDTTM=SDATE
 F  S CHDTTM=$O(^IVM(301.7,"B",CHDTTM)) Q:CHDTTM=""!(CHDTTM>(EDATE+1))  D ADDIEN
 Q 1
ADDIEN ;
 N ADDIEN
 S ADDIEN=0
 F  S ADDIEN=$O(^IVM(301.7,"B",CHDTTM,ADDIEN)) Q:ADDIEN=""  D GETINF
 Q
C N ADDIEN,CHDTTM
 S ADDIEN=""
 F  S ADDIEN=$O(^IVM(301.7,"C",DFN,ADDIEN)) Q:ADDIEN=""  D
 . S CHDTTM=$P($G(^IVM(301.7,ADDIEN,0)),"^",1)
 . I (CHDTTM>SDATE),(CHDTTM<(EDATE+1)) D GETINF
 . Q
 Q
GETINF ; 
 N NODE0,NODE1,DFN,SSN,NAME,ADDR1,ADDR2,CITY,STATE,ZIP,SORT1,SORT2,U
 N SOURCE,SIEN,SITE,PROV,PCODE,COUNTRY,DGBAI,BAI,ADDR3,NODE2
 S U="^",SITE=""
 S NODE0=$G(^IVM(301.7,ADDIEN,0))
 S NODE1=$G(^IVM(301.7,ADDIEN,1))
 S NODE2=$G(^IVM(301.7,ADDIEN,2))
 S DFN=$P(NODE0,"^",2)
 Q:DFN=""
 Q:'$D(^DPT(DFN))
 S SSN=$P($G(^DPT(DFN,0)),"^",9)
 Q:SSN=""
 S NAME=$P($G(^DPT(DFN,0)),"^",1)
 S SOURCE=$P(NODE1,"^",4),SIEN=$P(NODE1,"^",3)
 I SIEN S SITE=$P($G(^DIC(4,SIEN,0)),"^",1)
 S ADDR1=$P(NODE1,"^",6)
 S ADDR2=$P(NODE1,"^",7)
 S ADDR3=$P(NODE2,"^",1)
 S CITY=$P(NODE1,"^",8)
 S STATE=$P(NODE1,"^",10)
 I STATE'="",$D(^DIC(5,STATE,0)) S STATE=$P(^DIC(5,STATE,0),"^",2)
 S ZIP=$P(NODE1,"^",11)
 S PROV=$P(NODE1,"^",12)
 S PCODE=$P(NODE1,"^",13)
 S COUNTRY=$P(NODE1,"^",14)
 I COUNTRY'="",$D(^HL(779.004,"B",COUNTRY,0)) S COUNTRY=$$CNTRYI^DGADDUTL(COUNTRY)
 I COUNTRY=-1 S COUNTRY="UNKNOWN COUNTRY"
 S DGBAI=$P(NODE1,"^",15)
 S BAI=$S(DGBAI=1:"UNDELIVERABLE",DGBAI=2:"HOMELESS",DGBAI=3:"OTHER",DGBAI=4:"ADDRESS NOT FOUND",1:"")
 I DOS="D" D  Q
 . S ^XTMP("IVMADDRP",$J,SSN,CHDTTM)=ADDIEN_"^"_DFN_"^"_NAME_"^"_ADDR1_"^"_ADDR2_"^"_CITY_"^"_STATE_"^"_ZIP_"^"_SOURCE_"^"_SITE_"^"_PROV_"^"_PCODE_"^"_COUNTRY_"^"_BAI_"^"_ADDR3
 . S ^XTMP("IVMADDRP",$J,SSN)=$G(^XTMP("IVMADDRP",$J,SSN))+1
 . Q
 I DOS="S" D
 . S SORT1=$S(SO="S":SSN,1:NAME) I NAME="" S SORT1="UNKNOWN"
 . S SORT2=$S(SO="S":0,1:SSN)
 . S ^XTMP("IVMADDRP",$J,SORT1,SORT2,"INF")=NAME_U_SSN
 . S ^XTMP("IVMADDRP",$J,SORT1,SORT2,"DATE",CHDTTM)=""
 . S ^XTMP("IVMADDRP",$J,SORT1,SORT2)=$G(^XTMP("IVMADDRP",$J,SORT1,SORT2))+1
 . Q
 Q
REPORT ; Display the Report
 D HEADER
 I '$D(^XTMP("IVMADDRP",$J)) D  Q
 . N X S X="****** NOTHING TO REPORT ******" W !?80-$L(X)\2,X,!
 . Q
 I DOS="S" D SUMMARY Q
 N SSN
 ;
 S SSN=""
 F  S SSN=$O(^XTMP("IVMADDRP",$J,SSN)) Q:SSN=""  D DETAIL
 Q
DETAIL N NAME,CHDTTM,ADDR,ADDR2,CITY,STATE,ZIP,CSZ
 N ADDR1,ADDR2,X,U,QUIT,CNT,SITE,SOURCE,DGCNTRY,DGFOR,ADDR3,BAI
 S CHDTTM="",U="^",QUIT=0,CNT=0
 I $G(^XTMP("IVMADDRP",$J,SSN))'>1 Q
 F  S CHDTTM=$O(^XTMP("IVMADDRP",$J,SSN,CHDTTM)) Q:CHDTTM=""!(QUIT)  D
 . S X=$G(^XTMP("IVMADDRP",$J,SSN,CHDTTM))
 . S NAME=$P(X,U,3)
 . S ADDR1=$P(X,U,4)
 . S ADDR2=$P(X,U,5)
 . S ADDR3=$P(X,U,15)
 . S CITY=$P(X,U,6)
 . S STATE=$P(X,U,7)
 . S ZIP=$P(X,U,8)
 . S SOURCE=$P(X,U,9)
 . S SITE=$P(X,U,10)
 . S PROV=$P(X,U,11)
 . S PCODE=$P(X,U,12)
 . S COUNTRY=$P(X,U,13)
 . S BAI=$P(X,U,14)
 . S DGCNTRY=$$CNTRYI^DGADDUTL(COUNTRY)
 . S DGFOR=$$FORIEN^DGADDUTL(COUNTRY)
 . I DGFOR=-1 S DGCNTRY="UNKNOWN COUNTRY" S DGFOR=1
 . I ($Y+6)>IOSL D HEADER I QUIT Q
 . W !,$$FSSN(SSN),?12,$E(NAME,1,20)
 . W ?35,$$FMTE^XLFDT($P(CHDTTM,".",1))
 . I DGFOR=0 S CSZ=$$CSZ(CITY,STATE,ZIP)
 . I DGFOR=1 S CSZ=$$PCP(PCODE,CITY,PROV)
 . W ?49,$E(ADDR1,1,30),!
 . I $L(ADDR2) W ?49,$E(ADDR2,1,30),!
 . I $L(ADDR3) W ?49,$E(ADDR3,1,30),!
 . I $L(CSZ) W ?49,$E(CSZ,1,30),!
 . I $L(DGCNTRY) W ?49,$E(DGCNTRY,1,30),!
 . I $L(SOURCE) W ?49,"SOURCE: ",SOURCE,!
 . I $L(SITE) W ?49,"SITE: ",SITE
 . I $L(BAI) W !?49,"BAI: ",BAI
 . S CNT=CNT+1
 . Q
 I 'QUIT D TOTAL(CNT)
 Q
SUMMARY N SORT1,QUIT,CNT
 S SORT1="",QUIT=0,CNT=0
 F  S SORT1=$O(^XTMP("IVMADDRP",$J,SORT1)) Q:SORT1=""!(QUIT)  D SORT2
 I 'QUIT D TOTAL(CNT)
 Q
SORT2 N NAME,SSN
 S SORT2=""
 F  S SORT2=$O(^XTMP("IVMADDRP",$J,SORT1,SORT2)) Q:SORT2=""!(QUIT)  D
 . I $G(^XTMP("IVMADDRP",$J,SORT1,SORT2))'>1 Q
 . D SUMPR S CNT=CNT+1
 . Q
 Q
SUMPR N X,U
 S U="^"
 S X=$G(^XTMP("IVMADDRP",$J,SORT1,SORT2,"INF"))
 S NAME=$P(X,U,1),SSN=$P(X,U,2)
 I ($Y+2)>IOSL D HEADER I QUIT Q
 W !,$$FSSN(SSN),?12,$E(NAME,1,20)
 W ?35,$$FMTE^XLFDT($O(^XTMP("IVMADDRP",$J,SORT1,SORT2,"DATE",""),-1))
 S X=$G(^XTMP("IVMADDRP",$J,SORT1,SORT2))
 W ?73,$J($FN(X,","),5)
 Q
TOTAL(CNT) ;
 I ($Y+2)>IOSL D HEADER
 W !!,"Total records found meeting criteria: ",CNT,!
 Q
CSZ(CITY,STATE,ZIP) ;format city, state and zip into one line
 N X
 S X=""
 I $L(CITY) S X=CITY
 I $L(STATE) D
 . I $L(X) S X=X_", "_STATE Q
 . S X=STATE
 . Q
 I $L(ZIP) D
 . I $L(X) S X=X_"  "_ZIP Q
 . S X=ZIP
 . Q
 Q X
PCP(PCODE,CITY,PROV) ;format postal code, city, province for foreign address
 N X
 S X=""
 I $L(PCODE) S X=PCODE
 I $L(CITY) D
 . I $L(X) S X=X_" "_CITY Q
 . S X=CITY
 .Q
 I $L(PROV) D
 . I $L(X) S X=X_" "_PROV Q
 . S X=PROV
 . Q
 Q X
FSSN(SSN) ; Format the SSN
 N FMTSSN
 I SSN="NO SSN" Q SSN
 I $L(SSN)=9 S FMTSSN=SSN
 I $L(SSN)>9 S FMTSSN=$E(SSN,1,10)  ; Account for pseudo-SSN
 I $L(SSN)<9 D
 . S FMTSSN=""
 . F FMTSSN=$L(SSN):1:9 S FMTSSN=FMTSSN_"0"
 . S FMTSSN=FMTSSN_SSN
 . Q
 Q FMTSSN
HEADER ; Print the header
 N IDX,PGHDR
 S QUIT=0
 I $G(CRT),($G(PAGE)>0) I $$PAUSE(0) S QUIT=1 Q
 S PAGE=$G(PAGE,0),PAGE=PAGE+1,PGHDR="Page: "_$J(PAGE,3)
 W #
 I $G(CRT) W $C(27,91,72,27,91,74)  ; Additional $C to clear screen in Cache'
 S IDX="",IDX=$O(HDR(IDX))
 W "IVM ADDRESS CHANGE LOG REPORT",?71,PGHDR
 W !,$$FMTE^XLFDT(SDATE)_" THRU "_$$FMTE^XLFDT(EDATE)
 I DOS="D" D
 . W !!,"SSN",?12,"NAME",?35,"CHANGE DATE",?49,"PRIOR ADDRESS"
 . W !,"---",?12,"----",?35,"-----------",?49,"--------------"
 . Q
 I DOS="S" D
 . W !!,"SSN",?12,"NAME",?35,"LAST UPDATED",?69,"# ENTRIES"
 . W !,"---",?12,"----",?35,"------------",?69,"---------"
 . Q
 Q
PAUSE(RESP) ; Prompt user for next page or quit
 N DIR,DIRUT,DUOUT,DTOUT,U,X,Y
 W !
 S DIR(0)="E"
 D ^DIR
 I 'Y S RESP=1
 Q RESP
