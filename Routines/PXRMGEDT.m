PXRMGEDT ; SLC/PJH - PXRM General Edit/Add. ;11/08/2000
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;
 ;Called from protocol PXRM SELECTION ADD
 ;
ADD(TYP) ;
 N DIC,DIDEL,DLAYGO,DTOUT,DUOUT,FILE,HED,PXRMHD,X,Y
 W IORESET
 ;
 ;Ignore finding type parameters
 I "FPAR"=TYP D DUMMY^PXRMRUTL H 1 Q
 ;
 ;Edit dialog
 I "DLGE"=TYP D ADD^PXRMDEDT Q
 ;
 ;Allow auto generate of reminder dialogs
 I TYP["DLG" D ^PXRMDBLD Q
 ;
 ;Finding Item Parameter
 I TYP="FIP" S FILE="801.43",HED="FINDING ITEM PARAMETER"
 ;
 ;Reminder Category
 I TYP="RCAT" S FILE="811.7",HED="REMINDER CATEGORY"
 ;
 ;Resolution Status
 I TYP="RESN" S FILE="801.9",HED="RESOLUTION STATUS"
 ;
 ;Health Factor Resolution
 I TYP="SHFR" S FILE="801.95",HED="HEALTH FACTOR"
 ;
 F  D  Q:(X="")!$D(DUOUT)!$D(DTOUT)
 .S DIC=FILE,DLAYGO=DIC,DIDEL=DIC,DIC(0)="QAELX"
 .S DIC("A")="Select new "_HED_" name: "
 .I TYP="SHFR" S DIC(0)="QAEL"
 .D ^DIC Q:X=""
 .I X=(U_U) S DTOUT=1
 .I Y=-1 S DUOUT=1 W !,"Details not saved",! Q
 .Q:$D(DTOUT)!$D(DUOUT)
 .;Check if exists
 .I ($P(Y,U,3)'=1) W !,"already exists" Q
 .S DA=$P(Y,U)
 .;Edit resolution status
 .I TYP="RESN" D EDIT^PXRMSEDT("^PXRMD(801.9,",DA)
 .;Edit others
 .I TYP'="RESN" D EDIT(TYP,DA,1)
 .S DUOUT=1
 Q
 ;
DIE(HDR,FILE) ;Lock and edit
 I FILE=801.45 W "ED - EDIT "_HDR,!!,PXRMHD,!
 ;Display resolution details if finding type parameter edit
 I FILE=801.45,$G(PXRMINST)'=1 D
 .N RSUB,RNAM
 .S RSUB=$P($G(^PXRMD(801.45,PXRMFIEN,1,PXRMFSUB,0)),U) Q:'RSUB
 .S RNAM=$P($G(^PXRMD(801.9,RSUB,0)),U)
 .S:RNAM="" RNAM=RSUB W "RESOLUTION STATUS : ",RNAM
 D:$$LOCK(FILE) ^DIE,UNLOCK(FILE)
 Q
 ;
 ;Called by protocol PXRM GENERAL EDIT
 ;------------------------------------
EDIT(TYP,DA,ADD) ;
 N DIC,DIDEL,DIE,DR,DTOUT,DUOUT,Y
 W IORESET
 S VALMBCK="R"
 ;
 ;Taxonomy Dialog
 I TYP="DTAX" D
 .I $$TLOCK(811.2,DA) D  D TUNLOCK(811.2,DA)
 ..;Initialize the selectable codes if none exist
 ..I ('$D(^PXD(811.2,DA,"SDX")))&('$D(^PXD(811.2,DA,"SPR"))) D
 ...D BUILD^PXRMTDUP(DA)
 ..;
 ..N DIE,DR
 ..S DIE="^PXD(811.2,"
 ..;
 ..W !,"Dialog Text Fields"
 ..S DR=".03;3107;3108;3111;3112"
 ..D ^DIE
 ..I $D(Y) Q
 ..;
 ..W !!,"Dialog Selectable codes"
 ..S DR="3102;3104"
 ..D ^DIE
 ..I $D(Y) Q
 ..;
 ..W !!,"Dialog Generation Parameters"
 ..S DR="3106;3110"
 ..D ^DIE
 ;
 ;Finding Item Parameter
 I TYP="FIP" D
 .S DIE="^PXRMD(801.43,",DR=".01;.02;.03;.04",DIDEL=801.43
 .D DIE("FINDING ITEM PARAMETER",801.43)
 ;
 ;Finding Type Parameter
 I TYP="FPAR" D
 .;Programmer mode
 .S:$G(PXRMINST)=1 DR=1,DR(2,801.451)="1;3;4;5",DIE="^PXRMD(801.45,"
 .;Site mode
 .I $G(PXRMINST)'=1 D
 ..S DR="1;3;4;5",DIE="^PXRMD(801.45,PXRMFIEN,1,",DA(1)=PXRMFIEN
 ..S DR(2,801.4515)="2;4;5;6;1"
 .D DIE("FINDING TYPE PARAMETER",801.45)
 ;
 ;Reminder Category
 I TYP="RCAT" D
 .S DIE="^PXRMD(811.7,",DR=".01;1;2;10",DIDEL=811.7
 .D DIE("CATEGORY",811.7)
 ;
 ;Resolution Status
 I TYP="RESN" D
 .I $$LOCK(801.9) D EDIT^PXRMSEDT("^PXRMD(801.9,",.DA),UNLOCK(811.9)
 ;
 ;Health Factor Resolution
 I TYP="SHFR" D
 .S DIE="^PXRMD(801.95,",DR=".01;.02",DIDEL=801.95
 .D DIE("HEALTH FACTOR RESOLUTIONS",811.7)
 ;
 ;Skip rebuild if editting taxonomy called from dialog edit
 I PXRMGTYP["DLG" Q
 ;
 ;Deleted ???
 I '$D(DA) S VALMBCK="Q" Q
 ;Redisplay changes
 I 'ADD D BUILD^PXRMGEN
 Q
 ;
 ;
LOCK(FILE) ;Lock the entire file
 L +^PXRMD(FILE):0 I  Q 1
 E  W !!,?5,"Another user is editing this file, try later" H 2
 Q 0
 ;
 ;
UNLOCK(FILE) ;Unlock the file
 L -^PXRMD(FILE)
 Q
 ;Build the list of codes for one taxonomy
 ;----------------------------------------
SEL(TAXIND) ;
 N CODELIST,IC,FINDING,FILE,HIGH,LOW,NCE,TEMP
 ;
 ;Setup file names for indirection, these will hold the taxonomy lists.
 N ICD9IEN,ICPTIEN
 S ICD9IEN="^TMP(""PXRM"",$J,""ICD9IEN"")"
 S ICPTIEN="^TMP(""PXRM"",$J,""ICPTIEN"")"
 ;
 S NCE=0
 F FILE=80,81 D
 .S IC=0
 .F  S IC=$O(^PXD(811.2,TAXIND,FILE,IC)) Q:+IC=0  D
 ..S TEMP=$G(^PXD(811.2,TAXIND,FILE,IC,0))
 ..;Append the taxonomy and finding information to CODELIST.
 ..S NCE=NCE+1
 ..S CODELIST(NCE)=TEMP_U_FILE
 ;CODELIST is LOW_U_HIGH_U_FILE
 ;Go through the standard coded list and get the file IEN for each entry.
 F IC=1:1:NCE D
 .S LOW=$P(CODELIST(IC),U,1)
 .S HIGH=$P(CODELIST(IC),U,2)
 .S FILE=$P(CODELIST(IC),U,3)
 .I FILE=80 D ICD9(LOW,HIGH) Q
 .I FILE=81 D ICPT(LOW,HIGH) Q
 ;
 ;Store the results.
 D STORE(TAXIND)
 K ^TMP("PXRM",$J,"ICD9IEN")
 K ^TMP("PXRM",$J,"ICPTIEN")
 Q
 ;
 ;=======================================================================
DEL(TAXIND) ;Delete existing entry
 K ^PXD(811.2,TAXIND,"SDX")
 K ^PXD(811.2,TAXIND,"SPR")
 Q
 ;
 ;Build the list of internal entries for ICD9 (File 80)
 ;-----------------------------------------------------
ICD9(LOW,HIGH) ;
 N END,IEN,IND
 S IND=LOW_" "
 S END=HIGH_" "
 F  Q:(IND]END)!(+IND>+END)!(IND="")  D
 .S IEN=$O(^ICD9("BA",IND,""))
 .I (+IEN>0),$$CODE^PXRMVAL($TR(IND," "),80) D
 ..S ^TMP("PXRM",$J,"ICD9IEN",IND)=IEN
 .S IND=$O(^ICD9("BA",IND))
 Q
 ;
 ;Build the list of internal entries for ICPT (File 81)
 ;-----------------------------------------------------
ICPT(LOW,HIGH) ;
 N IEN,IND
 S IND=LOW
 F  Q:(IND]HIGH)!(+IND>+HIGH)!(IND="")  D
 .S IEN=$O(^ICPT("B",IND,""))
 .I (+IEN>0),$$CODE^PXRMVAL($TR(IND," "),81) D
 ..S ^TMP("PXRM",$J,"ICPTIEN",IND)=IEN
 .S IND=$O(^ICPT("B",IND))
 Q
 ;
 ;Store selectable codes in taxonomy
 ;----------------------------------
STORE(TAXIND) ;
 K ^TMP("PXRMGEDT",$J)
 N FDA,FDAIEN,FITEM,I2N,IEN,IND,MSG,NAME,SEQ,SUB,TEMP
 ;
 S NAME=$P(^PXD(811.2,TAXIND,0),U)
 ;
 S FDAIEN(1)=TAXIND
 ;
 S SUB="",IND=1,SEQ=0
 F  S SUB=$O(^TMP("PXRM",$J,"ICD9IEN",SUB)) Q:SUB=""  D
 .S IEN=^TMP("PXRM",$J,"ICD9IEN",SUB)
 .S IND=IND+1,SEQ=SEQ+1
 .S I2N="+"_IND_","_FDAIEN(1)_","
 .S ^TMP("PXRMGEDT",$J,811.23102,I2N,.01)=IEN
 ;
 S SEQ=0
 F  S SUB=$O(^TMP("PXRM",$J,"ICPTIEN",SUB)) Q:SUB=""  D
 .S IEN=^TMP("PXRM",$J,"ICPTIEN",SUB)
 .S IND=IND+1,SEQ=SEQ+1
 .S I2N="+"_IND_","_FDAIEN(1)_","
 .S ^TMP("PXRMGEDT",$J,811.23104,I2N,.01)=IEN
 ;
 ;None found
 I IND=1 Q
 ;
 S TEMP="^TMP(""PXRMGEDT"","_$J_")"
 D UPDATE^DIE("",TEMP,"FDAIEN","MSG")
 I $D(MSG) D ERR
 K ^TMP("PXRMGEDT",$J)
 Q
 ;
 ;Error Handler
 ;-------------
ERR N ERROR,IC,REF
 S ERROR(1)="Unable to build selectable codes for taxonomy : "
 S ERROR(2)=NAME
 S ERROR(3)="Error in UPDATE^DIE, needs further investigation"
 ;Move MSG into ERROR
 S REF="MSG"
 F IC=4:1 S REF=$Q(@REF) Q:REF=""  S ERROR(IC)=REF_"="_@REF
 ;Screen message
 D BMES^XPDUTL(.ERROR)
 Q
 ;
TLOCK(FILE,DA) ;Lock the record
 L +^PXD(FILE,DA):0 I  Q 1
 E  W !!,?5,"Another user is editing this file, try later" H 2 Q 0
 ;
 ;
TUNLOCK(FILE,DA) ;Unlock the record
 L -^PXD(FILE,DA)
 Q
