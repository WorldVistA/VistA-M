PSARDCUT ;BIRM/MFR - Return Drug - Utilities ;07/01/08
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**69,72**;10/24/97;Build 2
 ;References to DRUG file (#50) supported by IA #2095
 ;References to ^PSSNDCUT supported by IA #4707
 ;
PHLOC() ;Select Pharmacy location
 N PSALOC,PSACNT,PSAOSIT,PSAOSITN,PSACOMB,PSAISIT,PSAISITN,PSALOCA
 N PSALOCN,PSAMENU,DIR,X,Y
 S PSALOC=+$O(^PSD(58.8,"ADISP","P",0)) I 'PSALOC D  Q ""
 .W !!?5,"No Drug Accountability location has been created yet."
 ;
 ;If more than one pharmacy location, collect them in alpha order.
 S (PSACNT,PSALOC)=0
 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) Q:'PSALOC  D
 .Q:'$D(^PSD(58.8,PSALOC,0))!($P($G(^PSD(58.8,PSALOC,0)),"^")="")
 .I +$G(^PSD(58.8,PSALOC,"I")),+^PSD(58.8,PSALOC,"I")'>DT Q
 .Q:'$O(^PSD(58.8,PSALOC,1,0))
 .S (PSAOSIT,PSAOSITN)=""
 .D SITES^PSAUTL1
 .S PSALOCA($P(^PSD(58.8,PSALOC,0),"^")_PSACOMB,PSALOC)=PSALOC_"^"_$P(^PSD(58.8,PSALOC,0),"^")_PSACOMB_"^"_$P(^(0),"^",3)_"^"_$P(^(0),"^",10)_"^"_$P($G(^PSD(58.8,PSALOC,"I")),"^")
 I $O(PSALOCA(""))="" Q ""
 S PSALOCN="" F  S PSALOCN=$O(PSALOCA(PSALOCN)) Q:PSALOCN=""  D
 .S PSALOC=0 F  S PSALOC=$O(PSALOCA(PSALOCN,PSALOC)) Q:'PSALOC  D
 ..S PSACNT=PSACNT+1,DIR("A",PSACNT)=PSACNT_".  "_PSALOCN
 ..S PSAMENU(PSACNT,PSALOCN,PSALOC)=""
 S DIR("A",PSACNT+1)=""
 W !,"Choose one pharmacy location:",!
 S DIR(0)="NO^1:"_PSACNT,DIR("A")="Select PHARMACY LOCATION"
 S DIR("?")="Enter the number representing the Pharmacy Location"
 D ^DIR
 S PSALOCN=$O(PSAMENU(+Y,"")),PSALOC=$S(PSALOCN'="":+$O(PSAMENU(+Y,PSALOCN,0)),1:0)
 Q $S(+PSALOC>0:PSALOCA(PSALOCN,PSALOC),1:"")
 ;
DTTM(DATE,SEC) ; Converts FM to MM/DD/YY@HHMM(SS) (w/ or /out seconds)
 ;
 Q $P($$FMTE^XLFDT(DATE,"2Z"),":",1,$S($G(SEC):3,1:2))
 ;
LOGACT(PHLOC,BATCH,ITEM,TYPE,COMM) ; - Log an EDIT activity for the return item
 N DIC,DR,DA,X,Y,DINUM,DLAYGO,DD,DO
 I '$D(^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITEM)) Q
 S DIC="^PSD(58.35,"_PHLOC_",""BAT"","_BATCH_",""ITM"","_ITEM_",""LOG"","
 S X=$$NOW^XLFDT(),DIC(0)="",DA(3)=PHLOC,DA(2)=BATCH,DA(1)=ITEM
 S DIC("DR")="1////^S X=DUZ;2///^S X=TYPE;3///^S X=COMM"
 K DD,DO D FILE^DICN K DD,DO
 ;
 Q
 ;
DTRNG(BGN,END) ; Date Range Selection
 ;Input: (o) BGN - Default Begin Date 
 ;       (o) END - Default End Date 
 ;
 N %DT,DTOUT,DUOUT,DTRNG,X,Y
 S DTRNG=""
 S %DT="AES",%DT("A")="BEGIN DATE: ",%DT("B")=$G(BGN) K:$G(BGN)="" %DT("B") D ^%DT
 I $G(DUOUT)!$G(DTOUT)!($G(Y)=-1) Q "^"
 S $P(DTRNG,U)=Y
 ;
 W ! K %DT
 S %DT="AES",%DT("A")="END DATE: ",%DT("B")=$G(END),%DT(0)=Y K:$G(END)="" %DT("B") D ^%DT
 I $G(DUOUT)!$G(DTOUT)!($G(Y)=-1) Q "^"
 ;
 ;Define Entry
 S $P(DTRNG,U,2)=Y
 ;
 Q DTRNG
 ;
STASEL() ; Status Selection
 N PSARY,STR,I,DIR,X,Y
 S STR="AP:AWAITING PICKUP;PU:PICKED UP;CO:COMPLETED;CA:CANCELLED;ALL:ALL"
 W !,"Select one or multiple (separated by comma) of the following:"
 F I=1:1:$L(STR,";") D
 .S PSARY($P($P(STR,";",I),":"))=$P($P(STR,";",I),":",2)
 .S DIR("A",I)=$J($P($P(STR,";",I),":"),10)_" -  "_$P($P(STR,";",I),":",2)
 S DIR("A",I+1)="Ex.: 'PU,CO' for PICKED UP and COMPLETED batches."
 S DIR("A",I+2)=""
 S DIR(0)="FO^^K:'$$STAVAL^PSARDCUT(Y,.PSARY) X",DIR("A")="STATUS(ES)"
 S DIR("?")="Enter one or multiple (separated by comma) from below:"
 S DIR("B")="ALL"
 D ^DIR I $D(DIRUT) Q ""
 S Y=$$UP^XLFSTR(Y)
 I $F(Y,"ALL") S Y="ALL"
 Q Y
 ;
STAVAL(X,PSARY) ;Checks for valid combinations of statuses
 ; Input  - X user input to be validated
 ;        - PSARY array contains the valid statues
 ; Output - Return 1 valid or 0 invalid flag
 N II,FLG
 I $G(X)="" Q 0
 S X=$$UP^XLFSTR(X)
 S FLG=1
 F II=1:1:$L(X,",") D  I 'FLG Q
 .I $P(X,",",II)="" S FLG=0 Q
 .I '$D(PSARY($P(X,",",II))) S FLG=0
 Q FLG
 ;
UPDINV(PHLOC,BATCH,ITEM,DRUG,QTY,DISPLAY) ; - Update Drug Inventory
 N TYPE,BALANCE,TIMEOUT,COMM,TRANUM,DIC,DA,X,Y,DLAYGO,MONTH,BEGBAL,PREVMON,Z,DD,DO,D0
 N DINUM,DIE,DR,ENDBAL,TOTADJ,DRGMFR,EXPDT
 ;
 W !,"Updating Inventory "_$S($G(DISPLAY):"("_$$GET1^DIQ(50,DRUG,.01)_")",1:"")_"..."
 ;
 I '$D(^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITEM)) W "Failed." H 1 Q
 ;
 S TYPE=$O(^PSD(58.84,"B","RETURNED TO MANUFACTURER",0))
 I 'TYPE D  Q
 . W "Failed." H 1
 . D LOGACT(PHLOC,BATCH,ITEM,"X","Drug Accountability Inventory not updated: 'RETURNED TO MANUFACTURER' missing from the CS WORKSHEET file (#58.84).")
 ;
 I '$D(^PSD(58.8,PHLOC,1,DRUG,0)) D  Q
 . W "Failed." H 1
 . D LOGACT(PHLOC,BATCH,ITEM,"X","Drug Accountability Inventory not updated: No current inventory information for Drug/Pharmacy Location.")
 ;
 ; - Updating current inventory
 F  L +^PSD(58.8,PHLOC,1,DRUG):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 S BALANCE=+$P($G(^PSD(58.8,PHLOC,1,DRUG,0)),"^",4)
 ;
 F TIMEOUT=20:-1:0 L:TIMEOUT +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 I 'TIMEOUT L -^PSD(58.8,PHLOC,1,DRUG) D  Q
 . W "Failed." H 1
 . D LOGACT(PHLOC,BATCH,ITEM,"X","Drug Accountability Inventory not updated: DRUG ACCOUNTABILITY TRANSACTION file (#58.81) locked.")
 ;
 S DRGMFR=$$GET1^DIQ(58.3511,ITEM_","_BATCH_","_PHLOC,2)
 S EXPDT=$$GET1^DIQ(58.3511,ITEM_","_BATCH_","_PHLOC,9)
 S COMM=$S(QTY<0:"RETURNED",1:"CANCELLED RETURN")_" FOR CREDIT: "_$$GET1^DIQ(58.3511,ITEM_","_BATCH_","_PHLOC,15)
 S TRANUM=$O(^PSD(58.81,999999999999),-1)+1
 S DIC="^PSD(58.81,",DIC(0)="",(DINUM,X)=TRANUM
 S DA=TRANUM
 S DIC("DR")="1////^S X=TYPE;2////^S X=PHLOC;3////^S X=$$NOW^XLFDT();4////^S X=DRUG"
 S DIC("DR")=DIC("DR")_";5////^S X=QTY;6////^S X=DUZ;9////^S X=(BALANCE+QTY)"
 S DIC("DR")=DIC("DR")_";12////^S X=DRGMFR;14////^S X=EXPDT;15////^S X=COMM"
 K DD,DO D FILE^DICN K DD,DO
 L -^PSD(58.81,0)
 ;
 S $P(^PSD(58.8,PHLOC,1,DRUG,0),"^",4)=(BALANCE+QTY)
 ;
 L -^PSD(58.8,PHLOC,1,DRUG)
 ;
 W "OK" H 1
 Q
 ;
MONTH ; Monthly Activity update (Unsure if this should be done. So, not being called right now)
 I '$D(^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITEM)) Q
 S DIC="^PSD(58.35,"_PHLOC_",""BAT"","_BATCH_",""ITM"","_ITEM_",""LOG"","
 S X=$$NOW^XLFDT(),DIC(0)="",DA(3)=PHLOC,DA(2)=BATCH,DA(1)=ITEM
 S DIC("DR")="1////^S X=DUZ;2///^S X=TYPE;3///^S X=COMM"
 K DD,DO D FILE^DICN K DD,DO
 ;
 S MONTH=DT\100*100
 S BEGBAL=0,PREVMON=$O(^PSD(58.8,PHLOC,1,DRUG,5,MONTH),-1)
 I PREVMON D
 . S BEGBAL=$P(^PSD(58.8,PHLOC,1,DRUG,5,PREVMON,0),"^",4)  ; Ending balance from previous month
 I '$D(^PSD(58.8,PHLOC,1,DRUG,5,MONTH,0)) D
 . S DIC="^PSD(58.8,"_PHLOC_",1,"_DRUG_",5,",DIC(0)=""
 . S DIC("DR")="1////^S X=BEGBAL",(X,DINUM)=MONTH
 . S DA(2)=PHLOC,DA(1)=DRUG
 . K DD,DO D FILE^DICN K DD,DO
 S Z=$G(^PSD(58.8,PHLOC,1,DRUG,5,MONTH,0))
 S ENDBAL=$P(Z,"^",4),TOTADJ=$P(Z,"^",5)
 S DIE="^PSD(58.8,"_PHLOC_",1,"_DRUG_",5,",DA(2)=PHLOC,DA(1)=DRUG,DA=MONTH
 S DR="3////^S X="_(ENDBAL+QTY)_";7////^S X="_(TOTADJ+QTY)
 D ^DIE
 Q
 ;
DEFCTMF() ; - Returns the default Contractor/Manufacturer (if there is only 1 active)
 N CTMF,CNT,DEFAULT,Z
 S (CTMF,CNT)=0 F  S CTMF=$O(^PSD(58.36,CTMF)) Q:'CTMF  D  I CNT>1 Q
 . S Z=^PSD(58.36,CTMF,0) I DT<$P(Z,"^",2) Q
 . S CNT=CNT+1,DEFAULT=$P(Z,"^",1)
 Q $S(CNT=1:$G(DEFAULT),1:"")
 ;
TOTCRE(PHLOC,BATCH) ; - Return Batch Total Estimated^Actual Credit
 N ITM,ESTOT,ACTOT,Z
 S (ITM,ESTOT,ACTOT)=0
 F  S ITM=$O(^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITM)) Q:'ITM  D
 . S Z=^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITM,0)
 . S ESTOT=ESTOT+$P(Z,"^",12),ACTOT=ACTOT+$P(Z,"^",13)
 Q $J(ESTOT,0,2)_"^"_$J(ACTOT,0,2)
 ;
LIST(PHLOC,BATCH) ; - Items List
 N ITM,DSPLN,LIST,XX,DIR,Y,X,DIRUT,Z,DRNAM,CNT
 S ITM=0
 F  S ITM=$O(^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITM)) Q:'ITM  D
 . S Z=^PSD(58.35,PHLOC,"BAT",BATCH,"ITM",ITM,0)
 . S DSPLN=$E($E($$GET1^DIQ(50,+Z,.01),1,20)_" ("_$P(Z,"^",4)_")",1,36)
 . S $E(DSPLN,37)=$J($P(Z,"^",18),8),$E(DSPLN,46)=$P(Z,"^",9)
 . S LIST($$GET1^DIQ(50,+Z,.01),ITM)=DSPLN
 ;
 I $D(LIST) D
 . S $P(XX,"-",59)="" W !?10,XX,!?10," #",?13,"RETURN DRUG (NDC)",?49,"DISP QTY",?58,"UNIT",!?10,XX,!
 . S CNT=0,DRNAM="" F  S DRNAM=$O(LIST(DRNAM)) Q:DRNAM=""  D  I $G(DIRUT) Q
 . . S ITM=0 F  S ITM=$O(LIST(DRNAM,ITM)) Q:'ITM  D  I $G(DIRUT) Q
 . . . S CNT=CNT+1 W ?10,$J(CNT,2),?13,LIST(DRNAM,ITM) I '(CNT#15) S DIR(0)="E" D ^DIR W $C(13) Q
 . . . W !
 Q
 ;
LMHDR(PHLOC,BATCH,LOCNAM) ; - Header for Batch/Item screens
 N LINE,PSALOC,PSACOMB
 S PSALOC=PHLOC D SITES^PSAUTL1
 S LINE(1)="Pharm Location: "_$E($$GET1^DIQ(58.8,PHLOC,.01)_$G(PSACOMB),1,32)
 S $E(LINE(1),51)="Date Created: "_$$DTTM^PSARDCUT($$GET1^DIQ(58.351,BATCH_","_PHLOC,3,"I"))
 S LINE(2)="Batch Number  : "_$$GET1^DIQ(58.351,BATCH_","_PHLOC,.01)
 S $E(LINE(2),57)="Status: "_$$GET1^DIQ(58.351,BATCH_","_PHLOC,1)
 S LINE(3)="Rtn Contractor: "_$E($$GET1^DIQ(58.351,BATCH_","_PHLOC,4),1,31)
 S $E(LINE(3),49)="Date Picked Up: "_$$DTTM^PSARDCUT($$GET1^DIQ(58.351,BATCH_","_PHLOC,2,"I"))
 S LINE(4)="Reference #   : "_$$GET1^DIQ(58.351,BATCH_","_PHLOC,5)
 S $E(LINE(4),45)="Total Batch Credit: $"_$P($$TOTCRE^PSARDCUT(PHLOC,BATCH),"^",2)
 K VALMHDR S VALMHDR(1)=LINE(1),VALMHDR(2)=LINE(2),VALMHDR(3)=LINE(3),VALMHDR(4)=LINE(4)
 Q
 ;
EXCEL() ; - Returns whether to capture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D EXCHLP^PSARDCUT"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 K DIROUT,DTOUT,DUOUT,DIRUT
 S EXCEL=0 I Y S EXCEL=1
 ;
 ;Display Excel display message
 I EXCEL=1 D EXCMSG
 ;
 Q EXCEL
 ;
EXCHLP ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
EXCMSG ;Display the message about capturing to an Excel file format
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data. On some terminals, this can  be  done  by"
 W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 W !?5,"while to run."
 W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 W !?5,"      file, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 Q
 ;
CHKEY() ; Check for keys to use Return Drug options
 I $D(^XUSEC("PSARET",DUZ))!$D(^XUSEC("PSAMGR",DUZ))!$D(^XUSEC("PSORPH",DUZ)) Q 1
 W !!,"Please contact your Pharmacy Coordinator for access to this option."
 W !,"The PSARET security key is required!",$C(7),!
 Q 0
