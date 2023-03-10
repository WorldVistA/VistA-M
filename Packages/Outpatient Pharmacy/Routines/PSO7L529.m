PSO7L529 ;WILM/BDB - MIGRATION REPORT ;04/30/2021
 ;;7.0;OUTPATIENT PHARMACY;**529,684**;DEC 1997;Build 57
 ;External reference to sub-file NEW DEA #S (#200.5321) is supported by DBIA 7000
 ;External reference to DEA NUMBERS file (#8991.9) is supported by DBIA 7002
 Q 
 ;
START ;
 N DEA,NPIEN,PSI,RET,PSOSTOP,REMIG,PSOPRINT,HANDPSO
 K RET
 S PSOPRINT=2,HANDPSO="PSO70684-INSTALL"
 W !!,"  This option will allow you to re-run the DEA migration and "
 W !,"  print a migration report from the last completed migration, "
 W !,"   including ""exception"" records that did not migrate.",!
 ;
 S REMIG=$$ASKREMIG(.PSOPRINT) Q:REMIG<0!'$G(PSOPRINT)
 I $G(REMIG) D REMIG^PSO7L684 S PSOPRINT=$$ASKSCH2^PSO7L684(HANDPSO) Q:'PSOPRINT
 D RPTDTHD^PSO7L684(PSOPRINT,HANDPSO)
 D SELDEV Q:PSOSTOP
 S X=512 X ^%ZOSF("RM")
 D LOGON Q:PSOSTOP
 D SETRXDT()
 D PROCESS
 D LOGOFF
 Q
 ;
PROCESS ; Get data, build and print one line of output at a time
 U IO
 S DEA="A"
 D
 .S RET="LOCAL DEA NUMBER|DOJ DEA NUMBER|STATUS|SOURCE|DEA SUFFIX|BUSINESS CODE|NAME|ADDITIONAL COMPANY INFO|ADDRESS 1|ADDRESS 2|CITY|STATE|ZIP|DETOX NUMBER"
 .S RET=RET_"|EXPIR DATE|II N|II N-N|III N"
 .S RET=RET_"|III N-N|IV|V|INPAT|PROVIDER IEN|LAST SIGN-ON|LAST RX W/IN 3 YRS|EXCEPTION 1|EXCEPTION 2"
 .W !,RET
 F  S DEA=$O(^VA(200,"PS1",DEA)) Q:DEA=""  D
 . S NPIEN=0 F  S NPIEN=$O(^VA(200,"PS1",DEA,NPIEN)) Q:'NPIEN  D
 .. D DEALIST(.RET,NPIEN)
 .. I $D(RET) S PSI=0 F  S PSI=$O(RET(PSI)) Q:'PSI  D
 ... I PSI=1 S:$D(RET(2)) $P(RET(PSI),"|",3)="M",$P(RET(PSI),"|",4)="VISTA" W !,RET(PSI) Q
 ... I PSI>1 S $P(RET(PSI),"|",3)="M",$P(RET(PSI),"|",4)="DOJ" W !,RET(PSI) Q
 D EXIT
 Q
 ;
DEALIST(RET,NPIEN)  ; -- return a List of DEA numbers and information for a single provider.
 ; INPUT:  NPIEN - NEW PERSON FILE #200 INTERNAL ENTRY NUMBER
 ;
 ; OUTPUT: RET - A STRING OF DEA INFORMATION DELIMITED BY THE "^"
 ;
 Q:'$G(NPIEN)
 N CNT,DNDEADAT,DNDEAIEN,NPDEADAT,NPDEAIEN,I,PSAR,IENS,SUB,LASTSON,LASTRX
 N PHANDLE
 K RET S CNT=1
 S PHANDLE="PSODEAWB-"_$$FMADD^XLFDT($$DT^XLFDT,1)
 S PHANDLE=$O(^XTMP(PHANDLE),-1) S:PHANDLE'["PSODEAWB" PHANDLE="PSODEAWB"
 D GETS^DIQ(200,NPIEN,".01;.111;.112;.113;.114;.115;53.2;53.11;55.1;55.2;55.3;55.4;55.5;55.6;.116","E","PSAR")
 D GETS^DIQ(200,NPIEN,"747.44","I","PSAR")
 S SUB=NPIEN_","
 ;
 S RET(CNT)=""
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,53.2,"E")_"|"        ; NEW PERSON DEA NUMBER
 S RET(CNT)=RET(CNT)_"|"            ; DEA POINTER NO EQUIVALENT
 S RET(CNT)=RET(CNT)_"E|"           ; MIGRATION STATUS
 S RET(CNT)=RET(CNT)_"VISTA|"       ; SOURCE
 S RET(CNT)=RET(CNT)_"|"            ; INDIVIDUAL DEA SUFFIX
 S RET(CNT)=RET(CNT)_"|"            ; BUSINDESS CODE 
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.01,"E")_"|"   ; NAME
 S RET(CNT)=RET(CNT)_"|"                         ; ADDITIONAL COMPANY INFO
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.111,"E")_"|"  ; ADDR 1
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.112,"E")_"|"  ; ADDR 2 
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.114,"E")_"|"  ; CITY
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.115,"E")_"|"  ; STATE
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,.116,"E")_"|"  ; ZIP 
 S RET(CNT)=RET(CNT)_PSAR(200,SUB,53.11,"E")_"|" ; DETOX NUMBER
 S RET(CNT)=RET(CNT)_$$FMTE^XLFDT(PSAR(200,SUB,747.44,"I"))_"|"  ; EXPIRATION DATE
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.1,"E"))_"|"  ; SCHEDULE II NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.2,"E"))_"|"  ; SCHEDULE II NON-NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.3,"E"))_"|"  ; SCHEDULE III NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.4,"E"))_"|"  ; SCHEDULE III NON-NARCOTIC
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.5,"E"))_"|"  ; SCHEDULE IV
 S RET(CNT)=RET(CNT)_$G(PSAR(200,SUB,55.6,"E"))_"|"  ; SCHEDULE V
 S RET(CNT)=RET(CNT)_""_"|"                          ; USE FOR INPATIENT ORDERS?
 S RET(CNT)=RET(CNT)_NPIEN_"|"                       ; FILE #200 IEN
 S LASTSON=$$FMTE^XLFDT($P($$GET1^DIQ(200,NPIEN,202,"I"),"."),5) S:(LASTSON'?1.2N1"/"1.2N1"/"4N) LASTSON=""
 S RET(CNT)=RET(CNT)_LASTSON_"|"   ; LAST SIGN-ON DATE/TIME
 S LASTRX=$$FMTE^XLFDT($G(^TMP("PSODEAMX",$J,"PROVIDER",NPIEN,"LAST RX DATE")),5) S:(LASTRX'?1.2N1"/"1.2N1"/"4N) LASTRX=""
 S RET(CNT)=RET(CNT)_LASTRX_"|"                      ; LAST RX DATE ISSUED
 S RET(CNT)=RET(CNT)_$G(^XTMP(PHANDLE,"PROVIDER",NPIEN,"DEA",DEA,1))_"|"
 S RET(CNT)=RET(CNT)_$G(^XTMP(PHANDLE,"PROVIDER",NPIEN,"DEA",DEA,2))
 S RET(CNT)=$$UPPER(RET(CNT))
 ;
 S NPDEAIEN=0 F CNT=2:1 S NPDEAIEN=$O(^VA(200,NPIEN,"PS4",NPDEAIEN)) Q:'+NPDEAIEN  D
 . S IENS=NPDEAIEN_","_NPIEN_","
 . K NPDEADAT D GETS^DIQ(200.5321,IENS,"**","","NPDEADAT") Q:'$D(NPDEADAT)
 . S DNDEAIEN=$$GET1^DIQ(200.5321,IENS,.03,"I") Q:'DNDEAIEN
 . K DNDEADAT D GETS^DIQ(8991.9,DNDEAIEN,"**","","DNDEADAT") Q:'$D(DNDEADAT)
 . ;
 . S RET(CNT)=""
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.01)_"|"        ; NEW PERSON DEA NUMBER
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.03)_"|"        ; NEW PERSON DEA NUMBER
 . S RET(CNT)=RET(CNT)_"M|"                                   ; MIGRATION STATUS
 . S RET(CNT)=RET(CNT)_"DOJ|"                                 ; SOURCE
 . S RET(CNT)=RET(CNT)_NPDEADAT(200.5321,IENS,.02)_"|"        ; INDIVIDUAL DEA SUFFIX
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.02)_"|"  ; BUSINESS CODE
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.1)_"|"  ; NAME 8991.9
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.2)_"|"  ; ADDL COMPANY INFO
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.3)_"|"  ; ADDR 1
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.4)_"|"  ; ADDR 2
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.5)_"|"  ; CITY
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.6)_"|"  ; STATE
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",1.7)_"|"  ; ZIP
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.03)_"|"  ; DETOX NUMBER
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.04)_"|"  ; EXPIRATION DATE
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.1)_"|"  ; SCHEDULE II NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.2)_"|"  ; SCHEDULE II NON-NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.3)_"|"  ; SCHEDULE III NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.4)_"|"  ; SCHEDULE III NON-NARCOTIC
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.5)_"|"  ; SCHEDULE IV
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",2.6)_"|"  ; SCHEDULE V
 . S RET(CNT)=RET(CNT)_DNDEADAT(8991.9,DNDEAIEN_",",.06)_"|"  ; USE FOR INPATIENT ORDERS?
 . S RET(CNT)=RET(CNT)_""_"|"                                 ; IEN
 . S RET(CNT)=RET(CNT)_""_"|"                                 ; LAST SIGN-ON DATE/TIME
 . S RET(CNT)=RET(CNT)_""_"|"                                 ; LAST RX DATE ISSUED
 . S RET(CNT)=$$UPPER(RET(CNT))
 Q
 ;
UPPER(PSOUCS) ;
 Q $TR(PSOUCS,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
SELDEV ; Select Device
 ;
 N DIR,X,Y
 S PSOSTOP=0
 S DIR("A",1)=""
 S DIR("A",2)="   *******************************************************"
 S DIR("A",3)="   **  To avoid undesired wrapping of this report, you  **"
 S DIR("A",4)="   **  may need to set your terminal session display    **"
 S DIR("A",5)="   **  to a wider margin (e.g., 512 columns).           **"
 S DIR("A",6)="   *******************************************************"
 ;
 S DIR("A")=" Press return to continue or '^' to quit"
 S DIR(0)="EA" D ^DIR K DIR W !
 I 'Y S PSOSTOP=1 Q
 ;
 K X,Y
 S DIR("T")=0
 S DIR("A",1)=""
 S DIR("A",2)="   ************************************************************"
 S DIR("A",3)="   **  This report is designed for a 512 column format.      **"
 S DIR("A",4)="   **  Please enter '0;512;9999' at the 'DEVICE:' prompt.    **"
 S DIR("A",5)="   **  You may queue this report to print at a later time.   **"
 S DIR("A",5)="   ************************************************************"
 S DIR("A")=""
 S DIR(0)="EA" D ^DIR K DIR W !
 ;
 K %ZIS,IOP,POP,ZTSK N I S PSOION=$I,%ZIS="QM"
 D ^%ZIS K %ZIS
 I POP S IOP=PSOION D ^%ZIS K IOP,PSOION D  Q
 .K X,Y
 .S DIR("A",1)=""
 .S DIR("A",2)="  ** No Device Selected **"
 .S DIR("A")="  Press return to continue or '^' to quit"
 .S DIR(0)="EA" D ^DIR K DIR W !
 .S PSOSTOP=1
 ;
 I $D(IO("Q")) D
 . N ZTRTN,ZTDESC,ZTIO,ZTSAVE,ZTDTH,ZTSK,ZTREQ,ZTQUEUED
 . S:$G(ZPR) ZTIO="`"_ZPR,ZTDTH=$H S ZTRTN="PROCESS^PSO7L529",ZTDESC=XQY0
 . D ^%ZTLOAD W:$D(ZTSK) !,"Report is Queued to print !!"
 . S PSOSTOP=1
 Q
 ;
LOGON ; Turn on Logging Message
 N DIR
 S PSOSTOP=0
 S DIR("A",1)="     *****************************************************"
 S DIR("A",2)="     **  This is a Delimited report. Please verify you  **"
 S DIR("A",3)="     **  have identified a log file, and have turned    **"
 S DIR("A",4)="     **  logging on to capture the output.              **"
 S DIR("A",5)="     *****************************************************"
 S DIR("A",6)="",DIR("A",6)=""
 S DIR("A")=" Press return to continue or '^' to quit"
 S DIR(0)="EA" D ^DIR W !
 S:'Y PSOSTOP=1
 Q
 ;
LOGOFF ; Turn off Logging Message
 N DIR
 S DIR("A",1)="     *******************************************************"
 S DIR("A",2)="     **  The report is complete. Please verify you have   **"
 S DIR("A",3)="     **  turned logging off to save the captured output.  **"
 S DIR("A",4)="     *******************************************************"
 S DIR("A",5)="",DIR("A",6)=""
 S DIR("A")=" Press return to continue "
 S DIR(0)="EA" D ^DIR W !
 Q
SETRXDT(PSDSD) ; Find recent provider order activity
 ; Input: PSDSD (optional) - Only look back as far as this date; default to 365 days, ignore dates more than 10 years in the past.
 ; Output: ^TMP("PSODEAMX",$J,"PROVIDER",DUZ,"LAST RX DATE",RX ISSUE DATE)=RXIEN
 ;
 N PSOCURDT S PSOCURDT=$$DT^XLFDT
 I ($G(PSDSD)'?7N)&($G(PSDSD)'?8N1".".N) S PSDSD=""
 K ^TMP("PSODEAMX",$J)
 I '$G(PSDSD)!($G(PSDSD)<$$FMADD^XLFDT($$DT^XLFDT,-3650)) S PSDSD=$$FMADD^XLFDT($$DT^XLFDT,-365)
 ;
 D PROCRX(PSDSD)
 Q
 ;
PROCRX(PSDSD) ; Search Rx's
 N PRVIEN,RXISSUE,RXISSUE,RXIEN,ORD,RX0
 S RXISSUE=$$FMADD^XLFDT($$DT^XLFDT,365)
 F  S RXISSUE=$O(^PSRX("AC",RXISSUE),-1) Q:'RXISSUE!(RXISSUE<PSDSD)  D
 . S RXIEN=0 F  S RXIEN=$O(^PSRX("AC",RXISSUE,RXIEN)) Q:'RXIEN  D
 .. Q:'$D(^PSRX(RXIEN,0))  S RX0=^(0),ORD=$P($G(^("OR1")),"^",2)
 .. Q:'$P(RX0,"^",2)                    ; Order must contain a patient
 .. S PRVIEN=$P(RX0,"^",4) Q:'PRVIEN    ; Order must contain a provider
 .. Q:'$L($P($G(^VA(200,PRVIEN,"PS")),"^",2))
 .. I '$D(^TMP("PSODEAMX",$J,"PROVIDER",PRVIEN,"LAST RX DATE")) S ^TMP("PSODEAMX",$J,"PROVIDER",PRVIEN,"LAST RX DATE")=RXISSUE_"^"_RXIEN
 Q
 ;
ASKREMIG(PSOPRINT) ; Ask if DEA Migration should be run
 N DIR,LASTMSG,XTMP0,STATUS,XTMP0,P684CHK,LASTRUN,MIGSTAT,PSOAST,DUOUT,DTOUT,MIRESET,FG,WSTAT,P684CHK
 S MIRESET=0,PSOPRINT=1
 S $P(PSOAST,"*",75)="*"
 S LASTMSG="The DEA Migration",LASTRUN=""
 S STATUS=$G(^XTMP(HANDPSO,"STATUS"))
 S LASTRUN=$P($G(^XTMP(HANDPSO,0)),"^",2)
 I $G(LASTRUN) S P684CHK=$$FMDIFF^XLFDT($$DT^XLFDT(),LASTRUN)
 I (STATUS="Install Completed"),LASTRUN S LASTMSG=LASTMSG_" was last run on "_$$FMTE^XLFDT(LASTRUN)
 I STATUS'="Install Completed" S LASTMSG=LASTMSG_" did not run to completion."
 I '$G(LASTRUN) S LASTMSG=LASTMSG_" was last run more than 7 days ago."
 ;
 S MIGSTAT=$G(^XTMP(HANDPSO,"STATUS"))
 ;
 L +^XTMP(HANDPSO):0 I '$T D  Q $S(($D(DTOUT)!$D(DUOUT)):-1,1:0)
 . N DIR
 . S DIR("A",1)=PSOAST
 . S DIR("A",2)="               The DEA Migration is currently running. "
 . S DIR("A",3)="The migration must run to completion before printing the migration report."
 . S DIR("A",4)="                    Please try again later."
 . S DIR("A",5)=PSOAST
 . S DIR(0)="E",(DIR("?"),DIR("A"))="Press Return to continue"
 . D ^DIR S PSOPRINT=0
 ;
 I $G(MIGSTAT)["Start of Install" S PSOPRINT=$$ASKRPTSCH^PSO7L684(.MIRESET) I '$G(MIRESET) Q $S(($D(DTOUT)!$D(DUOUT)):-1,1:0)
 ;
 S WSTAT=$$WSGET^PSODEAU0(.FG,0) I $P(WSTAT,"^",3)=6059 D  Q 0
 . D BMES^XPDUTL("Unable to Establish a Connection to the PSO DOJ/DEA Web Service.")
 . D MES^XPDUTL("The DEA Migration cannot be refreshed until a connection")
 . D MES^XPDUTL("to the web service is restored.")
 . L -^XTMP(HANDPSO)
 ;
 I $$PROD^XUPROD,$$P545CHK7^PSO7E684() L -^XTMP(HANDPSO) Q 0  ; Don't run migration in production if PSO*7*545 has been installed more than 7 days ago
 ;
 K DIR S DIR(0)="Y"
 S DIR("?",1)="Answer YES if you wish to queue a re-run of the data migration."
 S DIR("?",2)="This may take several hours. An email will be generated"
 S DIR("?",3)="to holders of the PSDMGR key when the re-run is complete."
 S DIR("?",4)="",DIR("?")="Answer NO to display the report of the existing migrated records."
 S DIR("??")="^D MSHLP^PSO7E684"
 S DIR("A",1)="",DIR("A",2)=LASTMSG
 S DIR("A")="Do you want to re-run the DEA Migration",DIR("B")="N" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) L -^XTMP(HANDPSO) Q -1
 ;
 I $G(Y)>0 D  I $G(Y)>0 Q 1
 . K DIR,Y,DUOUT,DTOUT S DIR(0)="Y"
 . S DIR("A",1)=""
 . S DIR("A",2)=" ******************** WARNING *************************"
 . S DIR("A",3)="   This will DELETE all previously migrated DEA data "
 . S DIR("A",4)="    and repopulate by running a new DEA migration."
 . S DIR("A",5)="*******************************************************"
 . S DIR("A")="Are you sure you want to re-run the DEA Migration",DIR("B")="N" D ^DIR
 . D BMES^XPDUTL("")
 ;
 L -^XTMP(HANDPSO)
 I $D(DTOUT)!($D(DUOUT)) Q -1
 Q 0
 ;
EXIT ; Close Device
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
