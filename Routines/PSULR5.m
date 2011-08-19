PSULR5 ;BIR/PDW - LAB extract summary message generator ;10 JUL 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;DBIA(s)
 ; Reference to file 40.8 supported by DBIA 2438
 ;
EN ;EP generate Total & Cost summary
EN1 N PSUITT,PSUREC
 S:'$D(PSULRJOB) PSULRJOB=PSUJOB
 S:'$D(PSULRSUB) PSULRSUB="PSULR_"_PSULRJOB
 ;
 ;S PSUSDT=2970101
 ;S PSUEDT=2980501
 I '$D(^XTMP(PSULRSUB,"RECORDS")) G NODATA
DIV ;EP Loop by Division
 S PSUDIV="" F  S PSUDIV=$O(^XTMP(PSULRSUB,"SUMMARY",PSUDIV)) Q:PSUDIV=""  D MESSAGE
 Q
 ;
MESSAGE ;EP Generate Summary Messages for a Division
 ;
 ;S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 ;S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
MSG1 ;  Generate 1st summary message
 ;
 S PSUT=0,PSUP=0 ; test & patient counters
 ;   loop to get totals from records stored
 S DFN=0
 F  S DFN=$O(^XTMP(PSULRSUB,"SUMMARY",PSUDIV,DFN)) Q:DFN'>0  S PSUP=PSUP+1 D
 . S PSUDC="" F  S PSUDC=$O(^XTMP(PSULRSUB,"SUMMARY",PSUDIV,DFN,PSUDC)) Q:PSUDC=""  D
 .. S PSUND=0
 .. F  S PSUND=$O(^XTMP(PSULRSUB,"SUMMARY",PSUDIV,DFN,PSUDC,PSUND)) Q:PSUND'>0  S PSUT=PSUT+1
 ;
 S XMDUZ=DUZ
 M XMY=PSUXMYS1
 ;
 S Y=PSUSDT X ^DD("DD") S PSUDTS=Y ;    start date
 S Y=PSUEDT X ^DD("DD") S PSUDTE=Y ;    end date
 N PSUMSG
 S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 ;
 I $D(^XTMP("PSU_"_PSUJOB,"DIV",PSUDIV)) D
 .;VMP OIFO BAY PINES;ELR;PSU*3.0*31
 .I '$L($P($G(^XTMP("PSU_"_PSUJOB,"DIV",PSUDIV)),U,1)) Q
 .S PSUDIVNM=$P(^XTMP("PSU_"_PSUJOB,"DIV",PSUDIV),U,1)
 ;
 S PSUMSG(1)="               Laboratory Statistical Summary"
 S PSUMSG(2)="               "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 S PSUMSG(3)="      "
 S PSUMSG(4)="Total Patients          "_PSUP
 S PSUMSG(5)="Total Laboratory Tests  "_PSUT
 S PSUMSG(6)="   "
 S XMSUB="V. 4.0 PBMLR "_$G(PSUMON)_"  "_PSUDIV_" "_PSUDIVNM
 S XMTEXT="PSUMSG("
 S XMCHAN=1
 D ^XMD
 M ^XTMP(PSULRSUB,"REPORT1",PSUDIV)=PSUMSG
 K PSUMSG
 ;
MSG2 ; SUMMARY BY PATIENT
 ;
 ;
 S PSUG="^XTMP(PSULRSUB,""REPORT2"",PSUDIV)"
 K @PSUG
 S @PSUG@(1)="               Laboratory Data Summary"
 S @PSUG@(2)="               "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 S @PSUG@(3)=" "
 S X="Patient SSN"
 S X=$$SETSTR^VALM1("VA CODE",X,15,7)
 S X=$$SETSTR^VALM1("Laboratory",X,24,10)
 S X=$$SETSTR^VALM1("Results",X,42,7)
 S X=$$SETSTR^VALM1("Flag",X,57,4)
 S X=$$SETSTR^VALM1("Date/Time Taken",X,63,15)
 S @PSUG@(4)=X
 S X="",$P(X,"-",79)=""
 S @PSUG@(5)=X
 S PSULC=5
 ;  loop records stored
 S DFN=0,DFN1="",PSUCD1=""
 F  S DFN=$O(^XTMP(PSULRSUB,"SUMMARY",PSUDIV,DFN)) Q:DFN'>0  D  S DFN1=DFN
 . ;  loop drug codes
 . S PSUCD=""
 . F  S PSUCD=$O(^XTMP(PSULRSUB,"SUMMARY",PSUDIV,DFN,PSUCD)) Q:PSUCD=""  D  S PSUCD1=PSUCD
 .. ; loop tests  
 .. S PSUND=0
 .. F  S PSUND=$O(^XTMP(PSULRSUB,"SUMMARY",PSUDIV,DFN,PSUCD,PSUND)) Q:PSUND'>0  D SET
 ;
 S @PSUG@(PSULC+1)="   "
 S XMSUB="V. 4.0 PBMLR "_$G(PSUMON)_"  "_PSUDIV_" "_PSUDIVNM
 S XMTEXT="^XTMP(PSULRSUB,""REPORT2"",PSUDIV,"
 S XMCHAN=1
 M XMY=PSUXMYS2
 I '$G(PSUSMRY) D ^XMD
 Q
 ;
SET ;EP  Set data into message
 ;
 S X=^XTMP(PSULRSUB,"SUMMARY",PSUDIV,DFN,PSUCD,PSUND)
 S PSULRT=$P(X,U),PSULRR=$P(X,U,2)
 S PSULD=$P(X,U,3),PSULRF=$P(X,U,4)
 S PSULD0=$E(PSULD,4,5)_"/"_$E(PSULD,6,7)_"/"_$E(PSULD,2,3)
 S X=$P(PSULD,".",2),X=$E(X,1,4) F  Q:$L(X)=4  S X=X_0 ; fill time
 S PSULD=PSULD0_" "_X
 S X=""
 I DFN=DFN1
 E  D PID^VADPT S X=$TR(VA("PID"),"-",""),DFN1=DFN,PSUCD1="" K VA
 I PSUCD1=PSUCD
 E  S X=$$SETSTR^VALM1(PSUCD,X,15,5) S PSUCD1=PSUCD
 S X=$$SETSTR^VALM1(PSULRT,X,24,$L(PSULRT))
 S X=$$SETSTR^VALM1(PSULRR,X,42,$L(PSULRR))
 S X=$$SETSTR^VALM1(PSULRF,X,57,$L(PSULRF))
 S X=$$SETSTR^VALM1(PSULD,X,63,$L(PSULD))
 S PSULC=PSULC+1
 S @PSUG@(PSULC)=X
 ;
 Q
NODATA ;EP SEND NO DATA MESSAGE
 S XMDUZ=DUZ
 M XMY=PSUXMYS1
 ;
 S Y=PSUSDT X ^DD("DD") S PSUDTS=Y ;    start date
 S Y=PSUEDT X ^DD("DD") S PSUDTE=Y ;    end date
 S PSUDIV=PSUSNDR
 S X=PSUDIV,DIC=40.8,DIC(0)="X",D="C" D IX^DIC ;**1
 S X=+Y S PSUDIVNM=$$VAL^PSUTL(40.8,X,.01)
 S XMSUB="V. 4.0 PBMLR "_$G(PSUMON)_"  "_PSUDIV_" "_PSUDIVNM
 S XMTEXT="^XTMP(PSULRSUB,""REPORT2"",PSUDIV,"
 S XMCHAN=1
 K X
 S X(1)="               Laboratory Statistical Summary"
 S X(2)="               "_PSUDTS_" through "_PSUDTE_" for "_PSUDIVNM
 S X(3)="    "
 S X(4)="No data to report"
 S X(5)="     "
 S XMTEXT="X("
 S:$G(PSUDUZ) XMY(PSUDUZ)=""
 D ^XMD
 M ^XTMP(PSULRSUB,"REPORT1",PSUDIV)=X
 S XMSUB="V. 4.0 PBMPR "_$G(PSUMON)_"  "_PSUDIV_" "_PSUDIVNM
 S X(1)="               Laboratory Data Summary"
 M ^XTMP(PSULRSUB,"REPORT2",PSUDIV)=X ;store for print cycle
 Q
