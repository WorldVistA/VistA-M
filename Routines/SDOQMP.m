SDOQMP ;ALB/SCK - Appointment Monitoring / Performance Measure report ; [07/17/96]
 ;;5.3;SCHEDULING;**47**;AUG 13,1993
 Q
 ;
EN ;  Entry point for Access PM extract to be sent to data collection server
 ;
 Q:$$CHKTASK^SDOQMP0
 D INIT,LOOP,START^SDOQMP2,BLDPME
 D END^SDOQMP1
 Q
 ;
EN1 ;  Entry point for interactive appointment monitoring report
 ;
 N XT,XT1,CONT,PMSEL
 ;
 S PMSEL=$$SELECT^SDOQMP0
 Q:PMSEL']""
 ;
 I PMSEL="C" G EN1Q:'$$CLINIC^SDOQMP0
 I PMSEL="S" G EN1Q:'$$STOP^SDOQMP0
 I PMSEL="D" G EN1Q:'$$DIV^SDOQMP0
 ;
 F XT=1:1 S XT1=$P($T(MSG+XT),";;",2) Q:XT1="$$END"  W !,XT1
AGN S CONT=0
 S %ZIS="Q" D ^%ZIS  G:POP EN1Q
 ;
 I IOM'=132 D  G:'CONT AGN
 . S:$E(IOST,1,2)="C-" DIR("A",1)="It's not recommended to print this report to screen."
 . S DIR(0)="Y^A",DIR("A")="Do you want to select another device?",DIR("B")="YES"
 . S DIR("A",2)="The selected device does not have 132 columns."
 . D ^DIR K DIR
 . S:$D(DIRUT)!(Y=0) CONT=1
 ;
QUE I $D(IO("Q")) D  G EN1Q
 . S ZTRTN="START^SDOQMP",ZTDESC="Appointment Monitoring Report"
 . S:PMSEL="C" ZTSAVE("CLINIC(")="",ZTSAVE("CLINIC")=""
 . S:PMSEL="S" ZTSAVE("VAUTC(")="",ZTSAVE("VAUTC")=""
 . S:PMSEL="D" ZTSAVE("VAUTD(")="",ZTSAVE("VAUTD")=""
 . D ^%ZTLOAD W:$D(ZTSK) !,"TASK #: ",ZTSK
 . D HOME^%ZIS K IO("Q")
 ;
 D WAIT^DICD
START D INIT,LOOPS^SDOQMP0,START^SDOQMP2,BLDRPT
 ;
EN1Q D:'$D(ZTQUEUED) ^%ZISC
 D END^SDOQMP1
 K CLINIC,^TMP("SDAMMS"),^TMP("SDPM"),VAUTD,VAUTC,^TMP("SDMSG")
 Q
 ;
INIT ;   Initialize date arrays for calculating next available appointments
 ;
 S:'$D(U) U="^"
 K ^TMP("SDAMMS"),^TMP("SDPM"),^TMP("APPT")
 S ^TMP("SDAMMS",$J,"MGN")=80,(CNT,CNT1,CNT2,CNT3,CNT4)=0,IOM=80
 S ^TMP("SDAMMS",$J,"PG")=0,$P(^TMP("SDAMMS",$J,"="),"=",IOM)=""
 S X="T" D ^%DT S DT=Y X ^DD("DD") S ^TMP("SDAMMS",$J,"DT")=Y
 S X="T" D ^%DT S AMMSRDT=Y
 S ^TMP("SDPM",$J,0)=DT
 S AMMSCNT="",AMMSLAST=0,AMMSZDT=DT,AMMSFDT=20,AMMSFSL=33
 D DATES^SDOQMP1
 Q
 ;
LOOP ;   Loop through the clinics in the Hospital location file.  Use only those clinics with
 ;   an associated stop code on the required list for the access performance measure
 ;
 ;   Variables
 ;      AMMSD0 - Clinic IEN
 ;   
 S AMMSD0=0
 F  S AMMSD0=$O(^SC("AC","C",AMMSD0)) Q:'AMMSD0  D
 . Q:'$P($G(^SC(AMMSD0,0)),"^",7)
 . Q:'$$CLNOK^SDOQMP0($P($G(^SC(AMMSD0,0)),"^",7))
 . Q:$G(^TMP("SDAMMS",$J,"Q"))=1
 . F X1=1:1:3 D AMMSCNT^SDOQMP1 Q:AMMSLAST=0
 Q
 ;
LOOPC ;  Loop through the clinics in the hospital location file.  User can select
 ;  one-many-all clinics through this entry point.
 ;
 ;  Variables
 ;    AMMSD0 -  Clinic IEN
 ;    CLINIC -  Clinic array returned from VAUTOMA
 ;
 S AMMSD0=0
 ;   Select all
 I CLINIC=1 D
 . F  S AMMSD0=$O(^SC("AC","C",AMMSD0)) Q:'AMMSD0  D
 .. Q:'$P($G(^SC(AMMSD0,0)),"^",7)
 .. Q:$G(^TMP("SDAMMS",$J,"Q"))=1
 .. F X1=1:1:3 D AMMSCNT^SDOQMP1 Q:AMMSLAST=0
 ;
 ;   Select One-Many
 I CLINIC=0&($D(CLINIC)) D 
 . F  S AMMSD0=$O(CLINIC(AMMSD0)) Q:'AMMSD0  D
 .. Q:'$P($G(^SC(AMMSD0,0)),"^",7)
 .. Q:$G(^TMP("SDAMMS",$J,"Q"))=1
 .. F X1=1:1:3 D AMMSCNT^SDOQMP1 Q:AMMSLAST=0
 Q
 ;
BLDPME ;   Build the data array to be included in the mail message.
 ;   If the number of data lines in the current array goes over 100,
 ;   Send the array and begin building a new one.
 ;
 ;   Data String format:
 ;       Clinic Name^Date Run^Date of Next Appt.^# of Days^Stop code^Division
 ;
 N X,LC,PMNODE,PMDT,PMMSG,PMCLNI,PMCLNE,PMAPT
 ;
 K ^TMP("SDMSG")
 S X=$G(^TMP("SDPM",$J,0)),PMDT=$P(X,U)
 S LC=1,PMCLNI=0
 ;
 F  S PMCLNI=$O(^TMP("SDPM",$J,PMCLNI)) Q:'PMCLNI  D
 . S PMNODE=$G(^TMP("SDPM",$J,PMCLNI,PMDT))
 . S PMCLNE=$P($G(^SC(PMCLNI,0)),U)
 . S PMAPT=$P(PMNODE,U)
 . S X2=PMDT,X1=PMAPT D ^%DTC
 . S ^TMP("SDMSG",$J,LC)=PMCLNE_U_PMDT_U_PMAPT_U_$S(X']"":-1,1:X)_U_$$STOPCDE^SDOQMP0(PMCLNI)_U_$$DIVISION^SDOQMP0(PMCLNI)
 . S LC=LC+1
 ;
 D:LC>350 PRCLRG
 I LC'>350 D PRCSML
DMQ Q
 ;
PRCSML ;  Process clinic lists smaller than 500 entries
 N PMMSG,LC
 S (X,LC)=0
 F  S X=$O(^TMP("SDMSG",$J,X)) Q:'X  D
 . S LC=LC+1
 . S PMMSG(LC)=^TMP("SDMSG",$J,X)
 D MAIL(.PMMSG,LC)
 Q
 ;
PRCLRG ;  Process clinic lists greater than 500 entries
 N SDTMP,XF,XL,XC
 S XF=1,XL=350
 ;
LP1 F XC=XF:1:XL Q:XC'<LC  D
 . S SDTMP(XC)=^TMP("SDMSG",$J,XC)
 ;
 D MAIL(.SDTMP,LC,XC)
 ;
 S XF=XL+1,XL=XL+350
 K SDTMP
 G:XC<LC LP1
 Q
 ;
MAIL(PMDATA,LINCNT,CNT) ;  Send data message to server.
 ;   The data message is sent to the local notification mail group,
 ;   the notification mail group at the server domain, and the
 ;   server at the data collection server domain
 ;
 ;   Server
 ;      A1BO PM NEXT APPT EXTRACT at Albany ISC
 ;
 ;   Variables
 ;     MSG    - Data array to be sent
 ;     LINCNT - Number of lines in the data array
 ;
 ;   Message Format        
 ;     Header - $START^Site Name^Facility Number^Date.Time run^Domain Name^Total lines^Last line sent
 ;     Body   - data array (see BLDPME)
 ;     Tail   - $END
 ;
 N XC,X1,%DT,XMB,PMFAC,XMLOC
 ;
 S XMLOC=0
 S XMDUZ=.5
 S XMY(".5")=""
 S XMY("S.A1BO PM NEXT APPT EXTRACT@DEVFEX.ISC-ALBANY.VA.GOV")=""
 S XMY("G.SD PM NOTIFICATION")=""
 S XMY("G.SD PM EXTRACT@ISC-ALBANY.VA.GOV")=""
 ;
 S PMFAC=$$SITE^VASITE
 D NOW^%DTC
 ;
 S PMDATA(.01)="$START^"_$P($G(PMFAC),"^",2,3)_"^"_%_"^"_$G(^XMB("NETNAME"))_"^"_LINCNT_"^"_$G(CNT)
 S PMDATA(LINCNT+1)="$END"
 ;
 S XMTEXT="PMDATA("
 S XMSUB="Access PM Extract from "_$P($G(PMFAC),U,2),XMN=0
 D ^XMD
 K XMDUZ,XMN,XMSUB,XMTEXT,XMY
SMQ Q
 ;
BLDRPT ;  Call the entry point to print the Appointment Monitoring report
 D START^SDOQMPR
 Q
 ;
MSG ;   Message displayed to user when the EN1 entry point is used.
 ;;
 ;;This report requires 132 columns and could take a long time
 ;;to print depending on the number of clinics selected.
 ;;Please remember to QUEUE it.
 ;;$$END
