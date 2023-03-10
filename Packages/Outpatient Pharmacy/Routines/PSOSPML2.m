PSOSPML2 ;BIRM/MFR - View/Process Export Batch Listman Driver ;10/7/20  16:12
 ;;7.0;OUTPATIENT PHARMACY;**408,451,625**;DEC 1997;Build 42
 ;
 N BATCHIEN,DIR,DIRUT,DTOUT,DUOUT,X,DIC,VALM,VALMCNT,VALMHDR,VALMBCK,VALMSG,PSOLSTLN
 ;
BAT ; Single Batch Selection
 W ! K DIC S DIC("A")="Export Batch #: ",DIC="^PS(58.42,",DIC(0)="QEAM"
 K BATCHIEN D ^DIC I X="^"!$D(DUOUT)!$D(DTOUT)!(Y<0) G EXIT
 S BATCHIEN=+Y
 ;
 D EN(BATCHIEN)
 ;
 G BAT
 ;
EN(BATCHIEN) ; Entry point
 D EN^VALM("PSO SPMP VIEW/EXPORT BATCH")
 D FULL^VALM1
 Q
 ;
HDR ; - Builds the Header section
 K VALMHDR
 S VALMHDR(1)="Batch #: "_$$GET1^DIQ(58.42,BATCHIEN,.01),$E(VALMHDR(1),17)="State: "_$$GET1^DIQ(58.42,BATCHIEN,1)
 S $E(VALMHDR(1),47)="Type: "_$$GET1^DIQ(58.42,BATCHIEN,2)
 S $E(VALMHDR(1),68)="Exported? "_$S($$GET1^DIQ(58.42,BATCHIEN,9,"I"):"YES",1:"NO")
 S VALMHDR(2)="Created on: "_$$GET1^DIQ(58.42,BATCHIEN,8)
 S $E(VALMHDR(2),47)="Exported on: "_$$GET1^DIQ(58.42,BATCHIEN,9)
 S VALMHDR(3)="File: "_$$GET1^DIQ(58.42,BATCHIEN,6)
 N LASTDR,LASTST
 S LASTDR=$O(^PS(58.42,BATCHIEN,"DR",99999),-1) I LASTDR D
 . S LASTST=$P($G(^PS(58.42,BATCHIEN,"DR",LASTDR,0)),"^")
 . I $D(LASTST),LASTST'="<blank>" S $E(VALMHDR(3),43)="Debug Reason: "_$E($P($G(^PS(58.42,BATCHIEN,"DR",LASTDR,0)),"^"),1,30)
 S VALMHDR(4)="Created by: "_$$GET1^DIQ(58.42,BATCHIEN,10,"E") ; PSO*7*625:PSU-14
 D SETHDR()
 Q
 ;
SETHDR() ; - Displays the Header Line
 N HDR,ORD,POS
 ;
 S HDR="   #",$E(HDR,6)="Rx#",$E(HDR,21)="FILL",$E(HDR,27)="DRUG",$E(HDR,70)="SCH",$E(HDR,74)="TYPE"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,6) ; PSO*7*625:PSU-14 Add line to Y coordinate for VOID Created By
 Q
 ;
INIT ; Builds the Body section
 N RXIEN,RXNUM,I,LINE,TYPE,NODE0,RX,COUNT,DRUGIEN,DRUGNAM,DRUGDEA,DSPLINE,FILL,RXNFLL,BATRXIEN
 ;
 K ^TMP("PSOSPSRT",$J)
 S BATRXIEN=0
 F  S BATRXIEN=$O(^PS(58.42,BATCHIEN,"RX",BATRXIEN)) Q:'BATRXIEN  D
 . S NODE0=$G(^PS(58.42,BATCHIEN,"RX",BATRXIEN,0))
 . S RXIEN=+NODE0,FILL=$P(NODE0,"^",2)
 . S ^TMP("PSOSPSRT",$J,$$GET1^DIQ(52,RXIEN,.01)_"^"_FILL)=BATRXIEN
 ;
 K ^TMP("PSOSPML2",$J) S VALMCNT=0,LINE=0
 S RXNFLL="",COUNT=0
 F  S RXNFLL=$O(^TMP("PSOSPSRT",$J,RXNFLL)) Q:RXNFLL=""  D
 . S BATRXIEN=+$G(^TMP("PSOSPSRT",$J,RXNFLL))
 . S NODE0=$G(^PS(58.42,BATCHIEN,"RX",BATRXIEN,0))
 . S RXIEN=+NODE0,FILL=$P(NODE0,"^",2),TYPE=$P(NODE0,"^",3)
 . S RXNUM=$$GET1^DIQ(52,RXIEN,.01)
 . S DRUGIEN=$$GET1^DIQ(52,RXIEN,6,"I")
 . S DRUGNAM=$E($$GET1^DIQ(50,DRUGIEN,.01),1,45)
 . S DRUGDEA=+$$GET1^DIQ(50,DRUGIEN,3)
 . S COUNT=COUNT+1
 . S DSPLINE=$J(COUNT,4)_" "_RXNUM,$E(DSPLINE,22)=$J(FILL,3)_"  "_DRUGNAM
 . S $E(DSPLINE,70)=$J(DRUGDEA,3)
 . S $E(DSPLINE,74)=$S(TYPE="N":"NEW",TYPE="R":"REVISE",TYPE="V":"VOID",1:"")
 . D SETLN^PSOSPMU1("PSOSPML2",DSPLINE,0,0,0)
 . S ^TMP("PSOSPML2",$J,LINE,"RX")=RXIEN_"^"_FILL_"^"_TYPE
 S VALMCNT=LINE
 Q
 ;
SEL ;Process selection of one entry
 N PSOSEL,XQORM,ORD,PSOTITLE,RXINFO,LINE
 S PSOSEL=+$P(XQORNOD(0),"=",2) I 'PSOSEL S VALMSG="Invalid selection!",VALMBCK="R" Q
 S RXINFO=$G(^TMP("PSOSPML2",$J,PSOSEL,"RX"))
 I 'RXINFO S VALMSG="Invalid selection!",VALMBCK="R" Q
 S PSOTITLE=VALM("TITLE")
 D  ; DO command used to preserve variables PSOTITLE and LINE
 . N PSOTITLE,LINE D EN^PSOSPML4(+RXINFO,$P(RXINFO,"^",2),$P(RXINFO,"^",3))
 S VALMBCK="R",VALM("TITLE")=$G(PSOTITLE)
 D INIT,HDR
 Q
 ;
EXP(MODE) ; Export Batch
 N DIR,Y,DUOUT,DIRUT,STATEIEN,PSOASVER,PSOTXRTS,QUIT,RUNMODE,LASTDR,LASTST,NEWR,FLUSH
 D FULL^VALM1 S VALMBCK="R"
 ;
 S STATEIEN=$$GET1^DIQ(58.42,BATCHIEN,1,"I")
 S PSOASVER=$$GET1^DIQ(58.41,STATEIEN,1,"I")
 S PSOTXRTS=+$$GET1^DIQ(58.41,STATEIEN,12,"I")
 ;
 S QUIT=0,RUNMODE="F"
 I MODE="EXPORT",($$GET1^DIQ(58.42,BATCHIEN,2,"I")'="VD"!PSOTXRTS) D  I QUIT Q
 . W ! K DIRUT,DUOUT,DIR
 . S DIR(0)="SA^B:Background;F:Foreground;D:Debug Mode (Foreground)"
 . S DIR("A",1)="Indicate whether the transmission should be queued to run on the Background"
 . S DIR("A",2)="via TaskMan, on the Foreground (Terminal Screen) or in Debug Mode (Foreground)"
 . S DIR("A",3)="which shows the sFTP (secure File Transfer) connection steps."
 . S DIR("A",3)=""
 . S DIR("A",4)="      Select one of the following:"
 . S DIR("A",5)=""
 . S DIR("A",6)="          B         Background"
 . S DIR("A",7)="          F         Foreground"
 . S DIR("A",8)="          D         Debug Mode (Foreground)"
 . S DIR("A",9)=""
 . S DIR("A")="Running Mode: ",DIR("B")="F",DIR("??")="^D RMHELP^PSOSPML2"
 . D ^DIR I $D(DTOUT)!$D(DIRUT) S QUIT=1 Q
 . S RUNMODE=Y
 . W ! K DIRUT,DUOUT,DIR
 . S DIR("A",1)="The Batch will be transmitted to the state of "_$$GET1^DIQ(58.42,BATCHIEN,1)_"."
 . S DIR("A",2)="",DIR("A")="Confirm",DIR(0)="Y",DIR("B")="N"
 . D ^DIR I $G(DTOUT)!$G(DUOUT)!'Y S QUIT=1 Q
 . I RUNMODE'="B" W ?40,"Please wait..."
 . I RUNMODE="D",($$GET1^DIQ(58.42,BATCHIEN,2,"I")'="RX") D DBUG(BATCHIEN) I QUIT=1 Q
 ;
 I (MODE="VIEW")!(($$GET1^DIQ(58.42,BATCHIEN,2,"I")="VD")&'PSOTXRTS) D  D ^%ZIS K %ZIS Q:POP  U IO
 . D EXMSG($S(MODE="VIEW":0,1:1)) W ! K %ZIS,IOP,POP,ZTSK S %ZIS="QM"
 ;
 ; If export batch type is VOID ONLY, and TRANSMIT RTS is OFF, just display for capture
 I (MODE="VIEW")!(($$GET1^DIQ(58.42,BATCHIEN,2,"I")="VD")&'PSOTXRTS) D
 . W ! D EXPORT^PSOSPMUT(BATCHIEN,"VIEW")
 . D ^%ZISC
 E  D
 . I RUNMODE="B" D  Q
 . . N ZTRTN,ZTIO,ZTDESC,ZTDTH,ZTSK
 . . S ZTRTN="EXPORT^PSOSPMUT("_BATCHIEN_",""EXPORT"",1,1)",ZTIO=""
 . . S ZTDESC="State Prescription Monitoring Program (SPMP) Transmission"
 . . S ZTDTH=$$NOW^XLFDT()
 . . D ^%ZTLOAD W:$D(ZTSK) !!,"Export Background Job Queued to Run.",$C(7),! K ZTSK
 . D EXPORT^PSOSPMUT(BATCHIEN,"EXPORT",0,$S(RUNMODE="D":1,1:0),$G(FLUSH))
 ;
 ; If exporting manually (web upload), update export fields (assumes user will upload file)
 I MODE="EXPORT",$$GET1^DIQ(58.42,BATCHIEN,2,"I")="VD",'PSOTXRTS D
 . D ^%ZISC N DIE,DA,DR S DIE="^PS(58.42,",DA=BATCHIEN
 . S DR="6///<Manual Web Upload>;7////"_DUZ_";9///"_$$NOW^XLFDT()
 . D ^DIE
 ;
 K DIR S DIR("A")="Press Return to continue",DIR(0)="E" D ^DIR
 D HDR
 Q
 ;
EXIT ;
 K ^TMP("PSOSPML2",$J)
 Q
 ;
HELP ; Listman HELP entry-point
 Q
 ;
EXMSG(RTSONLY) ;
 W !!?5,"Before continuing, set up your terminal to capture the ASAP"
 W !?5,"formatted data. On some terminals, this can be done by clicking"
 W !?5,"on the 'File' menu above, then click on 'Logging...' and check"
 W !?5,"'Logging on' and 'Disk'."
 W !!?5,"Note: To avoid undesired wrapping of the data saved to the"
 W !?5,"      file, please enter '0;256;9999' at the 'DEVICE:' prompt."
 I '$G(RTSONLY) Q
 W !!?5,"*********************** IMPORTANT ******************************"
 W !?5,"When you upload this file to the state website, make sure to"
 W !?5,"select the correct import option, usually called ""Back Records"
 W !?5,"Out of the System"", to avoid reporting duplicate records for the"
 W !?5,"patients."
 W !?5,"*****************************************************************"
 Q
 ;
RMHELP ; Running Mode Help Text
 W !!?5,"Choose one of the following transmission modes:"
 W !!?5,"Background: Transmission runs in the background via Taskman. This option"
 W !?5,"            will help you simulate the same transmission mode used by the"
 W !?5,"            Scheduled Nightly Transmissions."
 W !!?5,"Foreground: Transmission runs and displays the steps to your terminal"
 W !?5,"            screen."
 W !!?5,"Debug Mode: This is similar to the Foreground mode. The difference is"
 W !?5,"            that the sFTP command used to transfer the file will be run"
 W !?5,"            in 'debug mode'. This option is useful when troubleshooting"
 W !?5,"            transmission problems."
 Q
 ;
DBUG(BATCH) ; flush and debug reason prompt
 I '$D(^XUSEC("PSO SPMP ADMIN",DUZ)) S FLUSH=0 Q
 S FLUSH=0
 K DIRUT,DUOUT,DIR
 W ! S DIR("A")="Do you want to flush the known hosts key",DIR(0)="Y",DIR("B")="N"
 D ^DIR I $G(DTOUT)!$G(DUOUT) S QUIT=1 Q
 S FLUSH=$S(Y:1,1:0) I 'FLUSH S NEWR="<blank>" D F102 Q
 W ! K DIRUT,DUOUT,DIR
 N DIR,DIC,DA,X,Y,DLAYGO,DO,DD
RD S DIR("A")="Reason for Debug",DIR(0)="58.42102,.01" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S QUIT=1 Q
 I Y="" W !,$C(7),"This is a required response. Enter '^' to exit" G RD
 S NEWR=Y
 W !
F102 ; add new entry in the DEBUG REASON field #102
 S DLAYGO=58.42102,DIC(0)="L",X=NEWR,DA(1)=BATCHIEN,DIC="^PS(58.42,"_BATCHIEN_",""DR"",",DIC("DR")="1////"_DUZ_";3///"_$$NOW^XLFDT()
 D FILE^DICN K DIC,DLAYGO
 W !
 Q
