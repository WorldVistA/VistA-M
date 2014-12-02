PXRMSTA2 ; SLC/AGP - Routines for building status list. ;12/19/2012
 ;;2.0;CLINICAL REMINDERS;**4,6,26**;Feb 04, 2005;Build 404
 ;
ARRAYFOR(ARRAY,OUTPUT,DEF) ;
 ;Format the data array into a standard format
 N CNT,COMP,PIECE,STR,TYPE
 S PIECE=0
 ;Determine the number of pieces minus one in the string
 F CNT=1:1:$L(ARRAY("POINTER")) I $E(ARRAY("POINTER"),CNT)=";" S PIECE=PIECE+1 I PIECE>0 D
 . S STR=$P($P($G(ARRAY("POINTER")),";",PIECE),":",2)
 . S OUTPUT($P($P($G(ARRAY("POINTER")),";",PIECE),":",2))=STR_U_$G(DEF)
 ;
 ;Add last piece in the string to the array
 I PIECE>0 S PIECE=PIECE+1 D
 . I $P($G(ARRAY("POINTER")),";",PIECE)'="" D
 .. S OUTPUT($P($P($G(ARRAY("POINTER")),";",PIECE),":",2))=$P($P($G(ARRAY("POINTER")),";",PIECE),":",2)_U_$G(DEF)
 Q
 ;
COMPARE(ARRAY,ARRAY1,TYPE,OUTPUT) ;
 ;This sub routine is used to combine both Pharmacy types into one array
 N ARY,CNT,COMP,NODE
 K OUTPUT
 S COMP=""
 ;
 ;Inpatient pharmacy list is built from two separated fields in file #55
 ;this is used to combine the two fields into one array
 I $G(TYPE)="I" D
 . F  S COMP=$O(ARRAY(COMP)) Q:COMP=""  S OUTPUT(COMP)=ARRAY(COMP)
 . S (COMP)="" F  S COMP=$O(ARRAY1(COMP)) Q:COMP=""  I '$D(OUTPUT(COMP)) S OUTPUT(COMP)=ARRAY1(COMP)
 ;
 ;This section combines the different RX Types into one array
 I $G(TYPE)'="I" D
 . F  S COMP=$O(ARRAY(COMP)) Q:COMP=""  D
 .. S NODE=$G(ARRAY(COMP))
 .. S OUTPUT(COMP)=NODE
 . S COMP="" F  S COMP=$O(ARRAY1(COMP)) Q:COMP=""  D
 .. S NODE=$G(ARRAY1(COMP))
 .. I '$D(OUTPUT(COMP)) S OUTPUT(COMP)=NODE Q
 .. I $D(OUTPUT(COMP)) S $P(OUTPUT(COMP),U,2)=$P(OUTPUT(COMP),U,2)_$P(NODE,U,2)
 Q
 ;
DATA(FILE,DA,TYPE,RXTYPE,STATUS) ;
 ;Get the list of statuses from the appopriate global
 N ARRAY,ARRAY1,CNT,CODE,DEF,OUTPUT,SARRAY,STAT
LOOP ;
 ;Get build status list into a local array from each pharmacy type of
 ;finding item
 I TYPE="DRUG" D
 . I $D(RXTYPE("I"))>0 D
 ..;DBIA #4928
 .. D STATUS^PSS55MIS(55.06,28,"SARRAY")
 .. D ARRAYFOR(.SARRAY,.ARRAY,"I") K CODE
 .. D STATUS^PSS55MIS(55.01,100,"SARRAY")
 .. D ARRAYFOR(.SARRAY,.ARRAY1,"I") K CODE
 .. D COMPARE(.ARRAY,.ARRAY1,"I",.OUTPUT)
 . I $D(RXTYPE("O"))>0 D
 .. K ARRAY,ARRAY1,CODE
 ..;DBIA #4848
 .. D STATUS^PSODI(52,100,"SARRAY")
 .. D ARRAYFOR(.SARRAY,.ARRAY,"O") K CODE
 .. I $D(OUTPUT)>0 K ARRAY1 M ARRAY1=OUTPUT K OUTPUT D COMPARE(.ARRAY,.ARRAY1,"",.OUTPUT)
 .. E  M OUTPUT=ARRAY
 . I $D(RXTYPE("N"))>0 D
 .. K ARRAY,ARRAY1,CODE
 .. D STATUS^PSS55MIS(55.05,5,"SARRAY")
 .. S SARRAY("POINTER")=SARRAY("POINTER")_"0:ACTIVE;"
 .. D ARRAYFOR(.SARRAY,.ARRAY,"N") K CODE
 .. I $D(OUTPUT)>0 K ARRAY1 M ARRAY1=OUTPUT K OUTPUT D COMPARE(.ARRAY,.ARRAY1,"",.OUTPUT)
 .. E  M OUTPUT=ARRAY
 ;
 I TYPE="PROB" S OUTPUT("ACTIVE")="ACTIVE",OUTPUT("INACTIVE")="INACTIVE"
 I TYPE="ORD(101.43," D
 .;DBIA #??
 . S CNT=0,STAT="" F  S STAT=$O(^ORD(100.01,"B",STAT)) Q:STAT=""  D
 .. S CNT=CNT+1 S OUTPUT(STAT)=STAT
 I TYPE="RAMIS(71,"!(TYPE="TAX") D
 . S TYPE="RAMIS(71,"
 .;DBIA #996
 . S CNT=0,STAT="" F  S STAT=$O(^RA(72,"B",STAT)) Q:STAT=""  D
 .. S CNT=CNT+1 S OUTPUT(STAT)=STAT
 D SELECT(.OUTPUT,FILE,TYPE,.STATUS,.DA)
 Q
 ;
SELECT(ARRAY,FILE,TYPE,STATUS,DA) ;
 ;Sort through the formated array and set up the DIR call
 N CHECK,CNT,CNT1,DIR,DUOUT,DTOUT,EMPTY,EXTR
 N HELP,LENGTH,NODE,STAT,STR,TEXT,TMP,X,Y
 N TMPARR,NUM
DISPLAY ;
 I TYPE="DRUG" S TEXT="Select a Medication Status or enter '^' to Quit",HELP="Select a status from the Medication Status list or '^' to Quit"
 I TYPE="ORD(101.43," S TEXT="Select a Order Status from or enter '^' to Quit",HELP="Select a Order Status from the status list or '^' to Quit"
 I TYPE="RAMIS(71," S TEXT="Select a Radiology Procedure Status or enter '^' to Quit",HELP="Select a Radiology Procedure Status from the status list or '^' to Quit"
 ;
 S CNT=0,CNT1=0,STAT=""
 ;If text is not entered into the prompt or no match is found display
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
 Q
 ;
