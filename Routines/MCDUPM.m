MCDUPM ;WASH/DCB-DUPLICATION FINDER ;4/30/96  08:39
 ;;2.3;Medicine;;09/13/1996
START ;
 K ^TMP($J,"DUP")
 N FILE,FIL,ID,VAL,FLOC,IEN,YES
 W @IOF,"Compiling Data: please wait",!!!!
 F OFFSET=1:1 S IEN=+$P($T(FILE+OFFSET),";",3) Q:IEN'>0  D
 . I IEN'=700.1 D MAIN2(IEN)
 . Q
 D MAIN2(697.5)
 D ^MCDUPR
 Q
MAIN2(IEN) ;The 2nd half of main
 W !,IEN,?20,$$GET1^DID(IEN,"","","NAME")
 S FILE=$$GET1^DID(IEN,"","","GLOBAL NAME") K YES
 S ID=$$ID(FILE)
 D DUP(FILE,ID) K:'$D(YES) ^TMP($J,"DUP","I",IEN)
 S ^TMP($J,"DUP","F",IEN)=$S($D(YES):1,1:0)
 W ?60,$S($D(YES):"DUP",1:"NO DUP")
 D:$D(YES) COMPILE^MCDUP1(FILE)
 Q
DUP(FILE,ID) ;Main Routine
 N POINT,XDUP,COUNT
 D INIT(FILE,ID),FINDDUPS(FILE,ID)
 D:$D(YES) TABLE(FILE,ID)
 Q
ID(FILE) ;loads the Identifiers from the ID node
 N MFILE,FIELD,TEMP S MFILE=+$P(FILE,"(",2),FIELD="",ID=".01"
 F  S FIELD=+$O(^DD(MFILE,0,"ID",FIELD)) Q:FIELD=0  S ID=ID_";"_FIELD
 Q ID
POINTER(FILE,POINT) ;load the pointers from th PT node
 N TEMP,COUNT,MFILE S TEMP="",MFILE=+$P(FILE,"(",2)
 F COUNT=1:1 S TEMP=$O(^DD(MFILE,0,"PT",TEMP)) Q:TEMP=""  D
 .I $D(^DD(TEMP,0)) S POINT(COUNT,"FILE")=TEMP,POINT(COUNT,"FIELD")=$O(^DD(MFILE,0,"PT",TEMP,""))
 Q
INIT(FILE,ID) ; Builds a global with all of the indefitiers
 N TEMP,FILEN,ORD
 S FILEN=+$P(FILE,"(",2)
 S TEMP="",(COUNT,RECC,MREC)=0,ORD=FILE_"""B"",TEMP)"
 F  S TEMP=$O(@ORD) Q:TEMP=""  D LOAD(FILE,TEMP,ID)
 Q
LOAD(FILE,NAME,ID) ;Loads the array.
 N TEMP,REC,FILEN,COUNT
 S (TEMP,REC)=""
 S FILEN=+$P(FILE,"(",2)
 F  S REC=$O(@(FILE_"""B"""_",NAME,REC)")) Q:REC=""  D 
 .I '$D(@(FILE_REC_",0)")) K ^MCAR(FILEN,"B",NAME,REC) Q
 .D MOVE(FILE,FILEN,REC)
 Q
MOVE(FILE,FILEN,REC,COUNT) ;Get the Identifiers from the file
 ;Builds a global of
 ;^TMP($J,"DUP-I",file number,.01 field,internal rec number,"N") =
 ;         the identifiers of the record
 N ID3,DA,DR,DIC,TMP,LOOP,TEMP,TMP1,HOLD
 S HOLD=U,DIC=FILE,DIQ="ID3(",DA=REC,DR=ID,DIQ(0)="I" D EN^DIQ1
 S TMP1=ID3(FILEN,REC,.01,"I") ; get the .01 field
 F LOOP=2:1 Q:'$P(ID,";",LOOP)  S TMP=$G(ID3(FILEN,REC,$P(ID,";",LOOP),"I")),HOLD=HOLD_TMP_U
 S ^TMP($J,"DUP","I",FILEN,TMP1,REC,0)=HOLD
 Q
FINDDUPS(FILE,ID) ; Finds Duplications and store them in a temp global
 N TEMP,FILEN S TEMP="",FILEN=+$P(FILE,"(",2)
 F  S TEMP=$O(^TMP($J,"DUP","I",FILEN,TEMP)) Q:TEMP=""  D BUILD(TEMP,FILEN)
 Q
BUILD(TEMP,FILEN) ; Move the duplication in a single global
 N LOOP,REC,ARR S (REC,LOOP)=""
 F  S REC=$O(^TMP($J,"DUP","I",FILEN,TEMP,REC)) Q:REC=""  D
 .S ARR(^TMP($J,"DUP","I",FILEN,TEMP,REC,0))=$G(ARR(^TMP($J,"DUP","I",FILEN,TEMP,REC,0)))_REC_"^"
 F  S LOOP=$O(ARR(LOOP)) Q:LOOP=""  D
 .S ^TMP($J,"DUP","I",FILEN,TEMP,$P(ARR(LOOP),U),1)=ARR(LOOP)_"*"
 .S:$P(^TMP($J,"DUP","I",FILEN,TEMP,$P(ARR(LOOP),U),1),U,2)'="*" YES=""
 Q
TABLE(FILE,ID) ; Takes the temp array and builds a table for repointing
 N LOOP,REC,OLD,TEMP,FILEN S TEMP="",FILEN=+$P(FILE,"(",2)
 F  S TEMP=$O(^TMP($J,"DUP","I",FILEN,TEMP)) Q:TEMP=""  D
 .S REC="" F  S REC=+$O(^TMP($J,"DUP","I",FILEN,TEMP,REC)) Q:REC=0  D
 ..I $D(^TMP($J,"DUP","I",FILEN,TEMP,REC,1)) D
 ...F LOOP=1:1 S OLD=$P(^TMP($J,"DUP","I",FILEN,TEMP,REC,1),U,LOOP) Q:OLD="*"  S ^TMP($J,"DUP","RT",FILEN,OLD)=REC
 Q
FILE ;;File#
 ;;697
 ;;696.4
 ;;695.3
 ;;693.5
 ;;696.9
 ;;699.82
 ;;699.6
 ;;699.84
 ;;693.3
 ;;699.85
 ;;699.55
 ;;695.6
 ;;693.2
 ;;694.1
 ;;696.5
 ;;696.2
 ;;699.83
 ;;693
 ;;696.7
 ;;699.57
 ;;696.3
 ;;699.88
 ;;698.9
 ;;695.9
 ;;698.4
 ;;698.6
 ;;695.4
 ;;696.1
 ;;695.8
 ;;695.1
 ;;699.81
 ;;696
 ;;699.86
 ;;695.5
 ;;700.1
 ;;690.2
 ;;690.5
 ;;694.8
