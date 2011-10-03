IVMYZ1 ;ALB/SEK - PURGE INCORRECT IVM PATIENT & TRANSMISSION RECORDS ; 8-NOV-94
 ;;Version 2.0 ; INCOME VERIFICATION MATCH ;**1**; 21-OCT-94
 ;
EN ; this routine will delete ivm patient (301.5) and ivm
 ; transmission log (301.6) records for incorrect income years of
 ; -10000 & -910000.
 ; this routine will also send notification to the IVM Center once
 ; the facility has installed IVM*2*1 patch. 
 ;
TYPE ; Ask user if this installation is for a test account or live account.
 S DIR(0)="SM^1:PRODUCTION;0:TEST"
 S DIR("A")="Enter type of account you are installing in"
 S DIR("?")="Enter P for production account or T for test account"
 F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  S DIR("?",I)=X
 D ^DIR
 I Y=""!(Y["^") W:Y="" !!,*7,"User Timed Out..."
 S IVMPROD=Y
 K DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 I IVMPROD=""!(IVMPROD["^") K IVMPROD Q
 ;
 ; - do the purge
 S IVMCTR=0
 F IVMYR=-10000,-910000 S DFN="" D
 .S DFN=$O(^IVM(301.5,"AYR",IVMYR,DFN)) Q:'DFN  D
 ..S IVMDA=0 F  S IVMDA=$O(^IVM(301.5,"AYR",IVMYR,DFN,IVMDA)) Q:'IVMDA  D  S DIK="^IVM(301.5,",DA=IVMDA D ^DIK S IVMCTR=IVMCTR+1
 ...S IVMTR=0 F  S IVMTR=$O(^IVM(301.6,"B",IVMDA,IVMTR)) Q:'IVMTR  D
 ....S DIK="^IVM(301.6,",DA=IVMTR D ^DIK
 ;
 W !!,"  Total number of 301.5 records deleted: "_IVMCTR
 K DA,DFN,DIK,IVMYR,IVMDA,IVMTR,IVMCTR
 ;
 ;
 ; Send notification to the IVM Center once the facility has installed
 ; IVM*2*1 patch in production account.
 ;
 I 'IVMPROD K IVMPROD Q
 N DIFROM
 W !!,"Sending a 'completed installation' notice to the IVM Center... "
 S XMSUB="IVM*2*1 PATCH INSTALLATION"
 S XMDUZ="IVM PACKAGE"
 S XMY("WEATHERLY@IVM.VA.GOV")="",XMY(DUZ)="",XMY(.5)=""
 S XMTEXT="IVMTEXT("
 S IVMX=$$SITE^VASITE
 S IVMTEXT(1)="  Facility:                   "_$P(IVMX,"^",2)
 S IVMTEXT(2)="  Station Number:             "_$P(IVMX,"^",3)
 ;
 D NOW^%DTC S Y=% D DD^%DT
 S IVMTEXT(3)="  Installed IVM*2*1 patch on: "_Y
 D ^XMD W "done."
 K IVMPROD,IVMTEXT,IVMX,XMDUZ,XMSUB,XMTEXT,XMY,%
 Q
 ;
TEXT ; Text for help for production/test question
 ;;If you are currently installing this IVM package in a production
 ;;account, you must answer P.  If you are installing in a test account
 ;;you must answer T.
 ;;
 ;;The answer to this question is extremely important as it determines
 ;;where income data for patients gets transmitted.  Test data must not
 ;;be transmitted to the IVM Center's production account.  Production
 ;;data, likewise, will not be evaluated properly if it is not sent to
 ;;the IVM Center's production account.
 ;;
 ;;Enter '^' to abort this installation.
 ;;
 ;;QUIT
