PXRMSTA2 ; SLC/AGP - Routines for building status list. ;03/27/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ;
DATA(FILE,DA,TYPE,RXTYPE,STATUS) ;
 ; this sub routine get the list of statuses from the apporiate global
 ;
 N ARRAY,ARRAY1,CNT,CODE,DEF,OUTPUT,SARRAY,STAT
LOOP ;
 ;get build status list into a local array from each pharmacy type of
 ;finding item
 I TYPE="DRUG" D
 .I $D(RXTYPE("I"))>0 D
 . . D STATUS^PSS55MIS(55.06,28,"SARRAY")
 . . ;D FIELD^DID(55.06,28,"","POINTER","SARRAY")
 . . D ARRAYFOR(.SARRAY,.ARRAY,"I") K CODE
 . . D STATUS^PSS55MIS(55.01,100,"SARRAY")
 . . ;D FIELD^DID(55.01,100,"","POINTER","SARRAY")
 . . D ARRAYFOR(.SARRAY,.ARRAY1,"I") K CODE
 . . D COMPARE(.ARRAY,.ARRAY1,"I",.OUTPUT)
 . I $D(RXTYPE("O"))>0 D
 . . K ARRAY,ARRAY1,CODE
 . . D STATUS^PSODI(52,100,"SARRAY")
 . . ;D FIELD^DID(52,100,"","POINTER","SARRAY")
 . . D ARRAYFOR(.SARRAY,.ARRAY,"O") K CODE
 . . I $D(OUTPUT)>0 K ARRAY1 M ARRAY1=OUTPUT K OUTPUT D COMPARE(.ARRAY,.ARRAY1,"",.OUTPUT)
 . . E  M OUTPUT=ARRAY
 . I $D(RXTYPE("N"))>0 D
 . . K ARRAY,ARRAY1,CODE
 . . D STATUS^PSS55MIS(55.05,5,"SARRAY")
 . . ;D FIELD^DID(55.05,5,"","POINTER","SARRAY")
 . . S SARRAY("POINTER")=SARRAY("POINTER")_"0:ACTIVE;"
 . . D ARRAYFOR(.SARRAY,.ARRAY,"N") K CODE
 . . I $D(OUTPUT)>0 K ARRAY1 M ARRAY1=OUTPUT K OUTPUT D COMPARE(.ARRAY,.ARRAY1,"",.OUTPUT)
 . . E  M OUTPUT=ARRAY
 ;
 I TYPE="PROB" S OUTPUT("ACTIVE")="ACTIVE",OUTPUT("INACTIVE")="INACTIVE"
 I TYPE="ORD(101.43," D
 . S CNT=0,STAT="" F  S STAT=$O(^ORD(100.01,"B",STAT)) Q:STAT=""  D
 . . S CNT=CNT+1 S OUTPUT(STAT)=STAT
 I TYPE="RAMIS(71,"!(TYPE="TAX") D
 . S TYPE="RAMIS(71,"
 . S CNT=0,STAT="" F  S STAT=$O(^RA(72,"B",STAT)) Q:STAT=""  D
 . . S CNT=CNT+1 S OUTPUT(STAT)=STAT
 .;I TYPE'="TAX" Q
 .;I '$D(OUTPUT("ACTIVE")) S OUTPUT("ACTIVE")="ACTIVE"
 .;I '$D(OUTPUT("INACTIVE")) S OUTPUT("INACTIVE")="INACTIVE"
 D SELECT(.OUTPUT,FILE,TYPE,.STATUS,.DA)
 ;
 Q
 ;
COMPARE(ARRAY,ARRAY1,TYPE,OUTPUT) ;
 ; this sub routine is use to combine the InPatient and 
 ; Both Pharmacy type into one array
 N ARY,CNT,COMP,NODE
 K OUTPUT
 S COMP=""
 ;
 ;inpatient pharmacy list is built from two seperated fields in file #55
 ;this is used to combined the two fields into one array
 I $G(TYPE)="I" D
 . F  S COMP=$O(ARRAY(COMP)) Q:COMP=""  D
 . . S OUTPUT(COMP)=ARRAY(COMP)
 . S (COMP)="" F  S COMP=$O(ARRAY1(COMP)) Q:COMP=""  D
 . . I '$D(OUTPUT(COMP)) S OUTPUT(COMP)=ARRAY1(COMP)
 ;
 ;this section is uses to combine the different RX Types into one array
 I $G(TYPE)'="I" D
 . F  S COMP=$O(ARRAY(COMP)) Q:COMP=""  D
 . . S NODE=$G(ARRAY(COMP))
 . . S OUTPUT(COMP)=NODE
 . S COMP="" F  S COMP=$O(ARRAY1(COMP)) Q:COMP=""  D
 . . S NODE=$G(ARRAY1(COMP))
 . . I '$D(OUTPUT(COMP)) S OUTPUT(COMP)=NODE Q
 . . I $D(OUTPUT(COMP)) S $P(OUTPUT(COMP),U,2)=$P(OUTPUT(COMP),U,2)_$P(NODE,U,2)
 Q
 ;
ARRAYFOR(ARRAY,OUTPUT,DEF) ;
 ;this sub routine is use to format the array data into a standard 
 ;format
 ;
 N CNT,COMP,PIECE,STR,TYPE
 S PIECE=0
 ;
 ;determine the number of pieces minus one in the string
 F CNT=1:1:$L(ARRAY("POINTER")) I $E(ARRAY("POINTER"),CNT)=";" S PIECE=PIECE+1 I PIECE>0 D
 . S STR=$P($P($G(ARRAY("POINTER")),";",PIECE),":",2)
 . S OUTPUT($P($P($G(ARRAY("POINTER")),";",PIECE),":",2))=STR_U_$G(DEF)
 ;
 ;add last piece in the string to the array
 I PIECE>0 S PIECE=PIECE+1 D
 . I $P($G(ARRAY("POINTER")),";",PIECE)'="" D
 . . S OUTPUT($P($P($G(ARRAY("POINTER")),";",PIECE),":",2))=$P($P($G(ARRAY("POINTER")),";",PIECE),":",2)_U_$G(DEF)
 Q
 ;
SELECT(ARRAY,FILE,TYPE,STATUS,DA) ;
 ; this sub routine is use to sort through the formated array and 
 ; set up the DIR call
 ;
 N CHECK,CNT,CNT1,DIR,DUOUT,DTOUT,EMPTY,EXTR
 N HELP,LENGTH,NODE,STAT,STR,TEXT,TMP,X,Y
 N TMPARR,NUM
DISPLAY ;
 I TYPE="DRUG" S TEXT="Select a Medication Status or enter '^' to Quit",HELP="Select a status from the Medication Status list or '^' to Quit"
 I TYPE="ORD(101.43," S TEXT="Select a Order Status from or enter '^' to Quit",HELP="Select a Order Status from the status list or '^' to Quit"
 I TYPE="RAMIS(71," S TEXT="Select a Radiology Procedure Status or enter '^' to Quit",HELP="Select a Radiology Procedure Status from the status list or '^' to Quit"
 ;I TYPE="TAX" S TEXT="Select a Taxonomy Status or enter '^' to Quit",HELP="Select a Taxonomy Status from the status list or '^' to Quit"
 ;I TYPE="PROB" S TEXT="Select a Problem Status or enter '^' to Quit",HELP="Select a Taxonomy Status from the status list or '^' to Quit"
 ;
 S CNT=0,CNT1=0,STAT=""
 ;if text is not entered into the prompt or no match is found display
 ;entire list of statuses for this finding item
 ;
 ;Add wildcard character
 S CNT=CNT+1,CNT1=CNT1+1,TMP(CNT)=CNT_" - * (WildCard)",TMPARR(CNT)="*"
 ;Add status from file to the selectable list
 F  S STAT=$O(ARRAY(STAT)) Q:STAT=""  D
 . S NODE=$G(ARRAY(STAT))
 . S STR=$P(NODE,U)
 . S CNT=CNT+1,CNT1=CNT1+1
 . I TYPE="DRUG" S TMP(CNT)=CNT_" - "_STR_"("_$P(NODE,U,2)_")",TMPARR(CNT)=STR
 . E  S TMP(CNT)=CNT_" - "_STR,TMPARR(CNT)=STR
 ;
 S DIR(0)="LO^1:"_CNT_""
 M DIR("A")=TMP
 S DIR("A")=TEXT
 S DIR("?")=HELP
 D ^DIR
 I $D(DTOUT)!($D(DUOUT))!($G(Y)="") K STATUS Q
 S CNT=0 F X=1:1:$L(Y(0)) D
 .I $E(Y(0),X)="," S CNT=CNT+1,NUM=$P(Y(0),",",CNT),STATUS(TMPARR(NUM))=""
 ;S STATUS=Y(0)
 ;I STATUS="WildCard" S STATUS="*"
 Q
 ;
