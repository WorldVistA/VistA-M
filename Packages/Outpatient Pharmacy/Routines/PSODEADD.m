PSODEADD ;DAL/JCH-Add/update DEA NUMBERS file (8991.9) ;19 Jul 2021 06:00
 ;;7.0;OUTPATIENT PHARMACY;**545**;DEC 1997;Build 270
 ; Reference to ^XOBWLIB supported by DBIA 5421
 ;
EN ; Entry Point
 N PSOCONN,DEAEDQ,ASTERS,MSGPADC,MSGPADT,PSOABORT,PSOSTOP,PSODONE,PSOWSUP
 S PSOCONN="",DEAEDQ=0,MSGPADC=0,MSGPADT="",PSOSTOP=0,PSODONE=0
 D WSDMSG(.DEAEDQ) Q:$G(DEAEDQ)
 F  Q:'$$ADDEDIT()
 K DIE,DA,DR,DTOUT,DUOUT,DIROUT,DLAYGO,X,Y
 Q
 ;
ADDEDIT() ;  Add/Edit a DEA number
 N PSOLOOP,PSODEAI,PSOBACE,PSODTYPE,PSOBAC,PSOBACI,MANBAC,PSOMISS,PSODNEW,PSODEAE
 S PSOSTOP=0,PSODEAI=0,PSOABORT=0
 ;
 ; Select or Enter New entry in 8991.9
 D ADD(.PSOSTOP,.PSODEAI,.PSODNEW,.PSODEAE)
 ;
 ; No DEA number selected/entered, quit and exit
 Q:'$G(PSODEAI)>0 0
 ;
 ; Get existing BAC as default, prompt for new BAC
 S PSOBACE=$$GET1^DIQ(8991.9,$G(PSODEAI),.02)
 F  S PSOBACI=$$BAC(.PSOBACE,.PSOABORT,PSODNEW,PSODEAI) Q:$G(PSOBACI)!$G(PSOABORT)
 ;
 ; If no BAC, quit. If DEA is new/manual and is missing required fields, delete it
 I 'PSOBACI!$G(PSOABORT) D  Q 1
 .Q:'$G(PSODNEW)                                   ; Don't delete DOJ DEA's
 .D REQD(PSODEAI,.PSOMISS)                         ; Check for required fields
 .I $D(PSOMISS)>1 D ABORT(PSODNEW,PSODEAI,"DEA")   ; Delete new incomplete entry
 ;
 ; Edit/Enter the DEA data in 8991.9
 F  S PSODONE=$$ED89919(+PSODEAI,PSODNEW,.PSOSTOP) Q:$G(PSOSTOP)!PSODONE
 K DIE,DA,DR W !
 Q PSODONE
 ;
ADD(PSOSTOP,PSODEAI,PSODNEW,PSODEAE) ; Add new DEA number
 N DIC,DIE,PSODEAE
 W !!
 S DIC="8991.9",DIC(0)="AELMQ",DLAYGO=8991.9,DIC("A")="Enter DEA number: ",DIC("DR")=""
 D ^DIC I (Y'>0)!$G(DIRUT)!$G(DUOUT) S PSOSTOP=1 Q
 ; Considered 'New' if never updated by DOJ - no date/time in 8991.9:10.3 LAST UPDATED BY DOJ
 S PSODNEW=$S($P(Y,U,3):1,'$$GET1^DIQ(8991.9,+Y,10.3,"I"):2,1:0)
 S PSODEAE=$P(Y,U,2)
 S PSODEAI=+Y
 Q
 ;
BAC(PSOBACE,PSOABORT,PSODNEW,PSODEAI) ; Prompt for Business Activity Code, File New if Necessary
 N DIC,DIE,DA,DR,FDA,ERR,RETURN,PSOBNEW
 N PSOBACI
 I $G(PSOBACE)'="" S DIC("B")=PSOBACE
 S DIC="8991.8",DIC(0)="AELQZ",DLAYGO=8991.8,DIC("A")="Enter Business Activity Code: "
 S DIC("DR")="" D ^DIC
 S PSOBNEW=$P(Y,U,3)  ; PSOBNEW=1 - New entry into file 8991.8
 I (Y'>0)!$D(DTOUT)!$G(DIRUT)!$G(DUOUT) D  Q RETURN
 .S RETURN=0
 .I $G(DUOUT)!$D(DTOUT) S PSOABORT=1 Q
 .S RETURN=$$GET1^DIQ(8991.9,PSODEAI,.02,"I") Q
 .S PSOABORT=$$SURE(PSODNEW) D  Q
 ..I PSOABORT D ABORT(PSODNEW,PSODEAI,"DEA")
 .I Y=-1 W *7,"  Required" S PSOABORT="" Q
 S PSOBACI=+Y,PSOBACE=$P(Y,U,2)
 I PSOBACI>0,$$FIND1^DIC(8991.8,,"QA",+PSOBACI) D FILEBAC(+PSODEAI,+PSOBACI)
 I $$GET1^DIQ(8991.8,+Y,2,"I")!$G(PSOBNEW) D  ; Allow manually entered BAC's to be edited
 .W *7,!!?2," * Now editing Business Activity Code file entry *"
 .K FDA,ERR
 .S FDA(8991.8,+Y_",",.02)=$E(PSOBACE)
 .S FDA(8991.8,+Y_",",.03)=$E(PSOBACE,2,3)
 .S FDA(8991.8,+Y_",",2)=$$NOW^XLFDT()
 .D FILE^DIE("","FDA","ERR")
 .S DIE=8991.8,DA=+Y
 .S DR="1R" D ^DIE
 .I $G(PSOBNEW),($$GET1^DIQ(8991.8,PSOBACI,1)="") D ABORT(PSODNEW,PSOBACI,"BAC") S PSOABORT=1
 .I $G(PSODNEW) D
 ..N PSOBACI S PSOBACI=$$GET1^DIQ(8991.9,PSODEAI,.02,"I") I 'PSOBACI D ABORT(PSODNEW,PSODEAI,"DEA") S PSOABORT=1 Q
 ..I $$GET1^DIQ(8991.8,PSOBACI,1)="" D ABORT(PSODNEW,PSODEAI,"DEA") S PSOABORT=1
 .W *7,!?2," * Finished editing Business Activity Code file entry *",!
 Q PSOBACI
 ;
ED89919(PSODEAI,PSODNEW,PSOSTOP) ; Enter remaining fields in 8991.9
 N ABORT S ABORT=0
 S DIE=8991.9,DA=+PSODEAI
 S PSOBACE=$$GET1^DIQ(8991.9,+PSODEAI,.02,"E")
 S PSODTYPE=$$PROVTYPE^PSODEAUT(PSOBACE)
 S DR=".07///"_+PSODTYPE D ^DIE
 W !,"DEA TYPE: ",$P(PSODTYPE,U,2)
 K DR I +PSODTYPE=2 S DR=".03;"
 S DR=$G(DR)_".04;1.1R;2.1R;2.2R;2.3R;2.4R;2.5R;2.6R;1.2;1.3;1.4;1.5;1.6;1.7" D ^DIE
 ;
 K FDA,ERR
 S FDA(8991.9,+PSODEAI_",",10.1)=$G(DUZ)
 S FDA(8991.9,+PSODEAI_",",10.2)=$$NOW^XLFDT()
 S FDA(8991.9,+PSODEAI_",",10.3)=""
 D FILE^DIE("","FDA","ERR")
 ;
 ; Check for required fields, if new DEA and missing required fields, delete it
 I '$$REQD(+PSODEAI,.PSOMISS) D  Q ABORT
 .Q:'$G(PSODNEW)
 .S ABORT=$S($$SURE(PSODNEW,.PSOMISS):1,1:0)
 .I ABORT D ABORT(PSODNEW,PSODEAI,"DEA")
 K DIE,DA,DR W !
 ; Finished editing, record complete
 Q 1
 ;
WSCHK() ; Check PSO DOJ/DEA WEB SERVICE
 N PSOCONN,DEAEDQ,ASTERS
 S PSOCONN="",DEAEDQ=0
 D FULL^VALM1
 S $P(ASTERS,"*",75)="*"
 W !!,"Checking PSO DOJ/DEA WEB SERVICE connectivity..."
 S PSOCONN=$S($$CONNECT^PSODEADD:"1^Connection established, web service is operational!",1:"0^Unable to establish connection.")
 Q PSOCONN
 ;
CONNECT()  ; -- Send a test to the Web Service and compare the Result
 N SERVER,SERVICE,RESOURCE,REQUEST,SC,RESPONSE,RESPJSON,DATA,PSOERR,PSOECODE
 S SERVER="PSO DOJ/DEA WEB SERVER"
 S SERVICE="PSO DOJ/DEA WEB SERVICE"
 S RESOURCE=""
 S PSOECODE=""
 ;
 ; Get an instance of the REST request object.
 S REQUEST=$$GETREST^XOBWLIB(SERVICE,SERVER)
 ; 
 ; Execute the HTTP Get method
 S SC=$$GETXOBW^PSODEAU0(REQUEST,RESOURCE,.PSOERR,.PSOECODE)
 ;
 ; Execute the HTTP Get method.
 ;S SC=$$GET^XOBWLIB(REQUEST,RESOURCE,.PSOERR,0)
 I 'SC I PSOECODE=404 Q 1   ; Server running, null dea not found=ok
 I 'SC Q "0^General Service Error"
 I 'SC I PSOECODE=6059 Q 0
 Q 1
 ;
ABORT(PSODNEW,PSODIEN,TYPE) ; Quit and undo incomplete new entry
 Q:'PSODNEW         ; Undo incomplete entry
 N PSODMSG,DEAE,BACE
 S:TYPE="DEA" DEAE=$$GET1^DIQ(8991.9,+$G(PSODIEN),.01)
 S:TYPE="BAC" BACE=$$GET1^DIQ(8991.8,$G(PSODIEN),.01)
 D UNDO(+PSODIEN,TYPE)
 S PSODMSG="DELETING INCOMPLETE "_$S($G(TYPE)="DEA":"DEA NUMBER "_$G(DEAE),$G(TYPE)="BAC":"BUSINESS ACTIVITY CODE "_$G(BACE),1:"")
 W !?3,PSODMSG
 Q
 ;
UNDO(IEN,TYPE) ; Remove just-added record if user exits before required data is entered
 N DA,DIK,FILNO
 S DA=IEN
 Q:'$G(DA)
 S FILNO=$S(TYPE="DEA":8991.9,TYPE="BAC":8991.8,1:"")
 Q:FILNO=""
 S DIK="^XTV("_FILNO_","
 Q:'$$FIND1^DIC(FILNO,,"QA",IEN)
 D ^DIK
 Q
 ;
REQD(PSODEAI,PSOMISS)  ; Check required data has been entered
 N FLDS,DEAVALS,FLD,FLDLABEL
 K PSOMISS
 S FLDS=".02;.04;.07;1.1;2.1;2.2;2.3;2.4;2.5;2.6"
 D GETS^DIQ(8991.9,PSODEAI,FLDS,"I","DEAVALS")
 S FLD=0 F  S FLD=$O(DEAVALS(8991.9,PSODEAI_",",FLD)) Q:FLD=""  D
 .Q:$G(DEAVALS(8991.9,PSODEAI_",",FLD,"I"))'=""
 .K DEARTRN
 .D FIELD^DID(8991.9,FLD,,"LABEL","FLDLABEL")
 .S PSOMISS(FLD)=FLDLABEL("LABEL")
 Q $S($D(PSOMISS):0,1:1)
 ;
SURE(PSODNEW,PSOMISS) ; Are they sure they want to quit? Incomplete entry will be deleted
 N DIR,MISSFLD
 Q:'$G(PSODNEW) 1
 Q:'$D(PSOMISS)
 W !!?2," REQUIRED FIELDS ARE MISSING "
 S MISSFLD=0 F  S MISSFLD=$O(PSOMISS(MISSFLD)) Q:MISSFLD=""  D
 .W !?5,$G(PSOMISS(MISSFLD))
 W !!?5,"Exiting now will abort the process"
 W !?5,"and remove the incomplete entry."
 S DIR(0)="S"
 S DIR("A")="Quit or Continue Editing?"
 S DIR(0)="S^C:Continue Editing;Q:Quit and Remove Incomplete Entry"
 D ^DIR
 Q $S(Y="C":0,1:1)
 ;
FILEBAC(PSODEAI,PSOBACI) ; Save Business Activity Code to file 8991.8
 K FDA,ERR
 N FDA S FDA(8991.9,+PSODEAI_",",.02)=+PSOBACI
 D FILE^DIE("","FDA","ERR")
 Q
 ;
WSDMSG(DEAEDQ) ; Should be using the web service if possible
 N DIR
 D FULL^VALM1
 S $P(ASTERS,"*",75)="*"
 S PSOWSUP=$$WSCHK()
 S MSGPADC=55-$L($P(PSOWSUP,U,2)),$P(MSGPADT," ",MSGPADC)=" "
 S DIR("A",1)="    "_$E(ASTERS,1,26)_" WARNING "_$E(ASTERS,1,28)
 S DIR("A",2)="    **   "_$P(PSOWSUP,U,2)_MSGPADT_" **"
 S DIR("A",3)="    **   This option should only be used if a connection to the  **"
 S DIR("A",4)="    **   PSO DOJ/DEA WEB SERVICE cannot be established. DEA data **"
 S DIR("A",5)="    **   entered using this option may not match Department of   **"
 S DIR("A",6)="    **   Justice (DOJ) source data.                              **"
 S DIR("A",7)="    "_$E(ASTERS,1,63)
 S DIR("A")="Do you want to continue"
 S DIR(0)="Y",DIR("B")="N" D ^DIR I 'Y!$G(DIRUT) S DEAEDQ=1 Q
 Q
