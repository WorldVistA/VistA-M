PSOSPML2 ;BIRM/MFR - View/Process Export Batch Listman Driver ;09/10/12
 ;;7.0;OUTPATIENT PHARMACY;**408**;DEC 1997;Build 100
 ;
 N BATCHIEN,DIR,DIRUT,DTOUT,DUOUT,X,DIC
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
 S VALMHDR(1)="Batch #: "_$$GET1^DIQ(58.42,BATCHIEN,.01),$E(VALMHDR(1),17)="State: "_$$GET1^DIQ(58.42,BATCHIEN,1)
 S $E(VALMHDR(1),47)="Type: "_$$GET1^DIQ(58.42,BATCHIEN,2)
 S $E(VALMHDR(1),68)="Exported? "_$S($$GET1^DIQ(58.42,BATCHIEN,9,"I"):"YES",1:"NO")
 S VALMHDR(2)="Created on: "_$$GET1^DIQ(58.42,BATCHIEN,8)
 S $E(VALMHDR(2),47)="Exported on: "_$$GET1^DIQ(58.42,BATCHIEN,9)
 S VALMHDR(3)="File: "_$$GET1^DIQ(58.42,BATCHIEN,6)
 D SETHDR()
 Q
 ;
SETHDR() ; - Displays the Header Line
 N HDR,ORD,POS
 ;
 S HDR="   #",$E(HDR,6)="Rx#",$E(HDR,21)="FILL",$E(HDR,27)="DRUG",$E(HDR,70)="SCH",$E(HDR,74)="TYPE"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_HDR_IOINORM,1,5)
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
 D  ; Do used to preserve variables PSOTITLE and LINE
 . N PSOTITLE,LINE D EN^PSOSPML4(+RXINFO,$P(RXINFO,"^",2),$P(RXINFO,"^",3))
 S VALMBCK="R",VALM("TITLE")=$G(PSOTITLE)
 D INIT,HDR
 Q
 ;
EXP(MODE) ; Export Batch
 N DIR,Y,DUOUT,PSOSTATE,PSOASVER,PSOTXRTS
 D FULL^VALM1 S VALMBCK="R"
 ;
 S PSOSTATE=$$GET1^DIQ(58.42,BATCHIEN,1,"I")
 S PSOASVER=$$GET1^DIQ(58.41,PSOSTATE,1,"I")
 S PSOTXRTS=+$$GET1^DIQ(58.41,PSOSTATE,12,"I")
 ;
 I MODE="EXPORT",($$GET1^DIQ(58.42,BATCHIEN,2,"I")'="VD"!PSOTXRTS) D  D ^DIR I $G(DTOUT)!$G(DUOUT)!'Y Q
 . W ! S DIR("A",1)="The Batch will be transmitted to the state of "_$$GET1^DIQ(58.42,BATCHIEN,1)_"."
 . S DIR("A",2)="",DIR("A")="Confirm",DIR(0)="Y",DIR("B")="N"
 I (MODE="VIEW")!(($$GET1^DIQ(58.42,BATCHIEN,2,"I")="VD")&'PSOTXRTS) D  D ^%ZIS K %ZIS Q:POP  U IO
 . D EXMSG($S(MODE="VIEW":0,1:1)) W ! K %ZIS,IOP,POP,ZTSK S %ZIS="QM"
 ;
 ; If export batch type is VOID ONLY, and TRANSMIT RTS is OFF, just display for capture
 I (MODE="VIEW")!(($$GET1^DIQ(58.42,BATCHIEN,2,"I")="VD")&'PSOTXRTS) D
 . W ! D EXPORT^PSOSPMUT(BATCHIEN,"VIEW")
 . D ^%ZISC
 E  D
 . D EXPORT^PSOSPMUT(BATCHIEN,"EXPORT")
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
