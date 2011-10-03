PXRMSTA1 ; SLC/AGP - Routines for building status list. ;09/06/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
 ;This routine and PXRMSTA2 will allow users to select the
 ;approriate status for Orders, Medication, Taxonomy, Problem List,
 ;and Radiology Procedure findings items.
 ;
CLEAR(GBL,FILE,DA) ;
 N IEN,NODE,DIK,TEMP
 I FILE="D" S DIK="^PXD(811.9,"_DA(2)_",20,"_DA(1)_",5,"
 I FILE="T" S DIK="^PXRMD(811.5,"_DA(2)_",20,"_DA(1)_",5,"
 S DA=0 F  S DA=$O(@GBL@(DA(2),20,DA(1),5,DA)) Q:DA'>0  S TEMP(DA)=""
 S DA=0 F  S DA=$O(TEMP(DA)) Q:DA'>0  D ^DIK
 Q
 ;
STATUS(DA,FILE) ;
 N ANS,DELSTS,DELALL,GBL,NODE,PXRMRX,STATUS,STS,TAXIEN,TERMIEN,TAXTYPE,TTYPE,TYPE
 N RXTYPE,TAXNODE,TERMTYPE,Y
 N CSTATUS,UPDATE,HTEXT,OSTAUS,WILD
 S DA(2)=DA(1),DA(1)=DA,DA="",UPDATE=0,DELALL=0
 I FILE="D" S GBL="^PXD(811.9)"
 I FILE="T" S GBL="^PXRMD(811.5)"
 S NODE=$G(@GBL@(DA(2),20,DA(1),0))
 S TYPE=$P($G(@GBL@(DA(2),20,DA(1),0)),U)
 S WILD=0
 ;check for current defined statuses if none set the default values
 I FILE="D",$P($G(@GBL@(DA(2),20,DA(1),5,0)),U,4)'>0 D DEFAULT(GBL,TYPE,NODE,FILE,0,.DA)
 ;I FILE="T",$P($G(@GBL@(DA(2),20,DA(1),5,0)),U,4)>0 D
 ;.S STS="" F  S STS=$O(@GBL@(DA(2),20,DA(1),5,"B",STS)) Q:STS=""  S DELSTS(STS)=""
 ;display the current status 
 D DISPLAY(GBL,UPDATE,.WILD,DELALL)
 ;do inital prompt
 D ADDDEL($G(ANS),GBL,FILE,TYPE,NODE,WILD,.DA,.UPDATE,.DELALL)
 Q
 ;
ADDDEL(ANS,GBL,FILE,TYPE,NODE,WILD,DA,UPDATE,DELALL) ;
 I $G(ANS)="" S ANS=$$PROMPT("S^A:ADD STATUS;D:DELETE A STATUS;S:SAVE AND QUIT;Q:QUIT WITHOUT SAVING CHANGES")
 I "ADDASQ"'[ANS Q
 I ANS="A",WILD=1 D
 .W !,"Wildcard is already on the status list all possible statuses will be evaluated."
 .W !,"To add a specific status please remove the wildcard first."
 .S UPDATE=0 H 1
 I ANS="A",WILD=0 D ADD(GBL,FILE,.CSTATUS,TYPE,.WILD,.DA,.UPDATE)
 I ANS="D" D DELETE(GBL,FILE,.CSTATUS,NODE,.WILD,.DA,.UPDATE,.DELALL)
 I ANS="S" S UPDATE="S"
 I ANS="Q" S UPDATE="Q"
 I UPDATE'="S",UPDATE'="Q" S DELALL=0 D ADDDEL("",GBL,FILE,TYPE,NODE,.WILD,.DA,.UPDATE,.DELALL)
 ; only update the new record if the action is Save
 I UPDATE="S" D UPDATE(FILE,.UPDATE,.CSTATUS,.DA,.DELALL)
 Q
 ;
ADD(GBL,FILE,CSTATUS,TYPE,WILD,DA,UPDATE) ;
 N ANS,STATUS,TERMIEN
 ;Find what types of finding is in the term
 I TYPE["PXRMD(811.5," D
 .S TERMIEN=$P($G(TYPE),";")
 .S TYPE=$$TERMSTAT(TERMIEN) I TYPE=0 Q
 .I TYPE["PXD" S TAXTYPE=$$TAXTYPE(TERMIEN,"")
 I TYPE=0 Q
 ;find out what is in the taxonomy
 I TYPE["PXD(811.2,",$G(TAXTYPE)="" S TAXTYPE=$$TAXNODE($P(TYPE,";"),"")
 I TYPE[";" S TYPE=$P($G(TYPE),";",2)
 I TYPE="PXD(811.2," D  G ADDEX
 .I $G(TAXTYPE)="R"!($G(TAXTYPE)="B") D DATA^PXRMSTA2(FILE,.DA,"RAMIS(71,","",.STATUS)
 .;I $G(TAXTYPE)="P" D DATA^PXRMSTA2(FILE,.DA,"PROB","",.STATUS)
 .;I $G(TAXTYPE)="B" D DATA^PXRMSTA2(FILE,.DA,"TAX","",.STATUS)
 ; handle drug finding items
 I TYPE["PSDRUG("!(TYPE["PS(50.605")!(TYPE["PSNDF") D  G ADDEX
 .D SRXTYL^PXRMRXTY(NODE,.RXTYPE)
 .D DATA^PXRMSTA2(FILE,.DA,"DRUG",.RXTYPE,.STATUS)
 ;radiology and orderable item finding item
 D DATA^PXRMSTA2(FILE,.DA,TYPE,"",.STATUS)
ADDEX ;
 I '$D(STATUS) S UPDATE=0 Q
 S STAT="" F  S STAT=$O(STATUS(STAT)) Q:STAT=""!(WILD)=1  D
 .I STAT["*" S WILD=1 Q
 .S CSTATUS(STAT)=""
 I WILD=1 K CSTATUS S CSTATUS("*")=""
 S UPDATE=1 D DISPLAY(GBL,UPDATE,.WILD,0)
 Q
 ;
DEFAULT(GBL,TYPE,NODE,RFILE,DELETE,DA) ;
 N ANS,FDA,FILE,IND,MSG,STATUS,TERMIEN
 S FILE=""
 I TYPE["PXRMD(811.5," D
 .S TERMIEN=$P($G(TYPE),";")
 .S TYPE=$$TERMSTAT(TERMIEN) I TYPE=0 S STATUS="" Q
 .I TYPE["PXD" S TAXTYPE=$$TAXTYPE(TERMIEN,"")
 I TYPE=0 Q
 I TYPE["PXD(811.2,",$G(TAXTYPE)="" S TAXTYPE=$$TAXNODE($P(TYPE,";"),"")
 I TYPE[";" S TYPE=$P($G(TYPE),";",2)
 I TYPE="PXD(811.2," D
 .I $G(TAXTYPE)="R"!($G(TAXTYPE)="B") S FILE=70
 .;I $G(TAXTYPE)="P" S FILE=9000011
 I FILE="",TYPE="ORD(101.43," S FILE=100
 I FILE="",TYPE="RAMIS(71," S FILE=70
 I FILE="",TYPE["PSDRUG("!(TYPE["PS(50.605")!(TYPE["PSNDF") D
 .N DSTATUS,NAME,STATUSI,STATUSN,STATUSO,RXTYPE
 .D SRXTYL^PXRMRXTY(NODE,.RXTYPE)
 .I $D(RXTYPE("O")) D DEFAULT^PXRMSTAT(52,.STATUSO) D
 ..F IND=1:1:STATUSO(0) S DSTATUS(STATUSO(IND))=""
 .I $D(RXTYPE("I")) D DEFAULT^PXRMSTAT(55,.STATUSI) D
 ..F IND=1:1:STATUSI(0) S DSTATUS(STATUSI(IND))=""
 .I $D(RXTYPE("N")) D DEFAULT^PXRMSTAT("55NVA",.STATUSN) D
 ..F IND=1:1:STATUSN(0) S DSTATUS(STATUSN(IND))=""
 .S NAME="",IND=0 F  S NAME=$O(DSTATUS(NAME)) Q:NAME=""  D
 ..S IND=IND+1 S STATUS(IND)=NAME
 .S STATUS(0)=IND
 I '$D(STATUS) D DEFAULT^PXRMSTAT(FILE,.STATUS)
 F IND=1:1:STATUS(0) Q:$D(MSG)>0  D
 .I DELETE=1 S CSTATUS(STATUS(IND))="" Q
 .I $D(@GBL@(DA(2),20,DA(1),5,"B",STATUS(IND))) Q
 .I RFILE="D" S FDA(811.90221,"+3,"_DA(1)_","_DA(2)_",",.01)=STATUS(IND)
 .I RFILE="T" S FDA(811.54,"+3,"_DA(1)_","_DA(2)_",",.01)=STATUS(IND)
 .D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
 Q
 ;
DELETE(GBL,FILE,CSTATUS,NODE,WILD,DA,UPDATE,DELALL) ;
 N ANS,CNT,DIK,NUM,NAME,DIR,TMP,TMPARR,Y
 S CNT=0,NAME="" F  S NAME=$O(CSTATUS(NAME)) Q:NAME=""  D
 .S CNT=CNT+1 S TMPARR(CNT)=CNT_" - "_NAME,TMP(CNT)=NAME
 S DIR(0)="LO^1:"_CNT_""
 M DIR("A")=TMPARR
 S DIR("A")="Select which status to be deleted"
 ;S DIR("?")=HELP
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($G(Y)="") Q
 S CNT=0 F X=1:1:$L(Y(0)) D
 .I $E(Y(0),X)="," S CNT=CNT+1,NUM=$P(Y(0),",",CNT) S NAME=TMP(NUM) K CSTATUS(NAME) I NAME["*" S WILD=0
 S UPDATE=1
 I FILE="T",$D(CSTATUS)'>0 S DELALL=1
 ;.S DIK="^PXRMD(811.5,"_DA(2)_",20,"_DA(1)_",5," 
 ;D CLEAR(GBL,FILE,.DA)
 ;I $D(CSTATUS)'>0 S DA=0 F  S DA=$O(^PXRMD(811.5,DA(2),20,DA(1),5,DA)) Q:DA'>0  D ^DIK
 ;I '$D(CSTATUS) D CLEAR(GBL,FILE,.DA) D DEFAULT(GBL,TYPE,NODE,FILE,1,.DA)
 ;I '$D(CSTATUS),FILE="D" D DEFAULT(GBL,TYPE,NODE,FILE,1,.DA)
 D DISPLAY(GBL,UPDATE,.WILD,DELALL)
 Q
 ;
DISPLAY(GBL,UPDATE,WILD,DELALL) ;
 ;display statuses defined in the 5 node or display statuses if CStatus
 ;array has been loaded
 N NAME
 S NAME=""
 I ((UPDATE=1)&(DELALL=1))!(($D(CSTATUS)'>0)&(UPDATE=0)&(GBL["811.5")&('$D(@GBL@(DA(2),20,DA(1),5)))) W !!,"No statuses defined for this finding item" W ! Q 
 W !!,"Statuses already defined for this finding item:"
 ;I $D(CSTATUS)'>0,UPDATE=1 D 
 ;.F  S NAME=$O(@GBL@(DA(2),20,DA(1),5,"B",NAME)) Q:NAME=""  D
 ;..S CSTATUS(NAME)=$O(^PXD(811.9,DA(2),20,DA(1),5,"B","NAME",""))
 I $D(CSTATUS)'>0,UPDATE=0 D 
 .F  S NAME=$O(@GBL@(DA(2),20,DA(1),5,"B",NAME)) Q:NAME=""  D
 ..I NAME["*" S WILD=1
 ..W !,NAME S CSTATUS(NAME)=$O(^PXD(811.9,DA(2),20,DA(1),5,"B","NAME",""))
 I UPDATE=1 F  S NAME=$O(CSTATUS(NAME)) Q:NAME=""  W !,NAME I NAME["*" S WILD=1
 W !
 Q
 ;
 ;
UPDATE(FILE,UPDATE,CSTATUS,DA,DELALL) ;
 N FDA,MSG,NAME
 I UPDATE="S" S UPDATE=1
 I UPDATE=0,$D(CSTATUS) G EXIT
 D CLEAR(GBL,FILE,.DA)
 I $D(CSTATUS)'>0 S UPDATE=0,DELALL=0 G EXIT
 I $D(CSTATUS)'>0 S UPDATE=1,DELALL=1 G EXIT
 S NAME="" F  S NAME=$O(CSTATUS(NAME)) Q:NAME=""!($D(MSG)>0)  D
 .I FILE="D" S FDA(811.90221,"+3,"_DA(1)_","_DA(2)_",",.01)=NAME
 .I FILE="T" S FDA(811.54,"+3,"_DA(1)_","_DA(2)_",",.01)=NAME
 .D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG)>0 D AWRITE^PXRMUTIL("MSG") H 2
EXIT ;
 Q
 ;
PROMPT(STR) ;
 N DIR,HTEXT
 S HTEXT(1)="Select 'A' to add a status to the current status list.\\Select 'D' to"
 S HTEXT(2)="delete a status from the list.\\Select 'S' to save your changes and quit. "
 S HTEXT(3)="\\Select 'Q' to quit without saving your changes."
 S DIR(0)=STR
 S DIR("B")="S"
 S DIR("?")="Select one of the above option or '^' to quit. Enter ?? for detail help."
 S DIR("??")=U_"D HELP^PXRMEUT(.HTEXT)"
 D ^DIR
 I $G(Y)="" S Y=U
 Q Y
 ;
ASK(STR,HTEXT) ;
 N DIR,HTEXT
 I '$D(HTEXT) D
 .S HTEXT(1)="Enter 'Y' to continue editing the Status List or '^' to Quit"
 S DIR(0)="YA0"
 S DIR("A")=STR
 S DIR("B")="N"
 S DIR("?")="Select either 'Y' or 'N' or '^' to quit. Enter ?? for detail help."
 S DIR("??")=U_"D HELP^PXRMEUT(.HTEXT)"
 D ^DIR
 Q Y
 ;
TAXTYPE(TERMIEN,HELP) ;
 ;use to determine the Rx type of the term and the type of taxonomy
 N ARRAY,BOTH,CNT,IEN,TAXNODE,RAD,PL,RESULT,TYPE
 S (BOTH,PL,RAD,RESULT)=0
 S IEN=0 F  S IEN=$O(^PXRMD(811.5,TERMIEN,20,IEN)) Q:+IEN'>0  D
 .S TAXNODE=$G(^PXRMD(811.5,TERMIEN,20,IEN,0))
 .S ARRAY($P($P($G(TAXNODE),U),";"))=""
 I $D(ARRAY)>0 S IEN=0 F  S IEN=$O(ARRAY(IEN)) Q:IEN'>0  D
 .S TYPE=$$TAXNODE(IEN,$G(HELP))
 .I TYPE="R" S RAD=1
 .I TYPE="P" S PL=1
 .I TYPE="B" S BOTH=1
 I RAD=1,PL=1 S RESULT="B" Q
 I RAD=1,PL=0,BOTH=0 S RESULT="R"
 I RAD=0,PL=1,BOTH=0 S RESULT="P"
 Q RESULT
 ;
TAXNODE(TAXIEN,HELP) ;
 ;use to determine the type of taxonomy
 N TAXNODE,ICD,CPT,ARRAY,RAD,PL,BOTH,RADM,PLM,RESULT
 S (BOTH,PL,PLM,RAD,RADM,RESULT)=0
 D CHECK^PXRMBXTL(TAXIEN,"")
 I $D(^PXD(811.3,TAXIEN,71,"RCPTP"))>0 S RAD=1
 I $D(^PXD(811.3,TAXIEN,"PDS",9000011))>0 S PL=1
 I RAD=1,PL=1 S RESULT="B"
 I RAD=1,PL=0 S RESULT="R"
 I RAD=0,PL=1 S RESULT="P"
 Q RESULT
 ;
 ;
TERMSTAT(TIEN) ;
 N CNT,FIEN,NODE
 S (CNT,FIEN)=0
 S TYPE=0 F  S FIEN=$O(^PXRMD(811.5,TIEN,20,FIEN)) Q:+FIEN=0!(CNT=1)  D
 . S NODE=$G(^PXRMD(811.5,TIEN,20,FIEN,0)),TYPE=$P(NODE,U),CNT=CNT+1
 Q TYPE
 ;
WARN ;
 ;If the whole entry is being deleted don't give the warning.
 I $G(PXRMDEFD) Q
 I $G(PXRMTMD) Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N TEXT
 S TEXT(1)=""
 S TEXT(2)="Since you changed the value of Rx Type, you should review the status list"
 S TEXT(3)="for the finding to make sure it is still appropriate."
 S TEXT(4)=""
 D EN^DDIOL(.TEXT)
 Q
 ;
 ;
