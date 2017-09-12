FHUD112 ;SLC/GDU - UPDATE FILE #112 TO CURRENT USDA NUTRITIONAL DATABASE
 ;;5.5;DIETETICS;**26**;Jan 28, 2005;Build 17
    ;
    ;USDA National Nutrient Database for Standard Reference, Release 23
    ;Data to update the FOOD NUTRIENTS FILE, #112
 ;Routine is not intended to be called by name alone.
 Q
EN ;Entry point of this routine
 N ADDREC,FC,FHFNC,FHFNCN,FHIEN,FHERR,FHLST,FHMSG,FHPGM,FHREC,FLAG,FLDCNT,FLDNUM,FLDVAL
 N LC,LPSRT,LPEND,NEWNV,NVN,NVNL,OLDNV,RL,RL1,RL2,RL3,RL4,RL5,RLP,RTN,TAG,UDREC,X,X0,X1,X2,Y
 S FHMSG(1)="Nutrition and Food Service patch FH*5.5*26"
 S FHMSG(2)="Updating the FOOD NUTRIENTS file (#112) to USDA Standard Release 23"
 S FHMSG(3)=""
 S FHMSG(4)="Back up of file #112 to ^XTMP starting"
 S FHMSG(1,"F")="#",(FHMSG(2,"F"),FHMSG(3,"F"))="!",FHMSG(4,"F")="!!?5"
 D EN^DDIOL(.FHMSG) H 2 K FHMSG
 ;Backup of file #112 to ^XTMP starts here.
 D NOW^%DTC ;Getting the system's current date/time
 ;Creating the Extended temporary globals, setting life span to 180 days after run date
 S ^XTMP("FHNU23",0)=$$FMADD^XLFDT($P(%,"."),180)_U_$P(%,".")_U_"File #112 backup, Update to USDA Standard Release 23, FH*5.5*26"
 S ^XTMP("FHAR23",0)=$$FMADD^XLFDT($P(%,"."),180)_U_$P(%,".")_U_"Records added by update to USDA Standard Release 23, FH*5.5*26"
 S ^XTMP("FHUD23",0)=$$FMADD^XLFDT($P(%,"."),180)_U_$P(%,".")_U_"Records updated by update to USDA Standard Release 23, FH*5.5*26"
 S (^XTMP("FHAR23",1),^XTMP("FHUD23",1))=0
 K %
 M ^XTMP("FHNU23",112)=^FHNU ;file #112 is backed up.
 D EN^DDIOL("Back up of file #112 to ^XTMP is complete","","!?5") H 2
 ;The updating of file #112 starts here.
 D EN^DDIOL("Update of file #112 is running.","","!?5") H 2
 D EN^DDIOL(" ","","!")
 ;Processing the FHNDB* routines
 S LC=0,X0="000",(X1,X2)=""
 F X1=1:1:255 D
 . S RTN="FHNDB"_$E(X0,1,$L(X0)-$L(X1))_X1
 . D EN^DDIOL(".","","?1"),INC
 . I LC>80 D EN^DDIOL("","","!") S LC=1
 . ;Processing the current FHNDB routine
 . F TAG=1:1:30 D
 . . ;Pullinig the embedded data from the current FHNDB routine
 . . S RL0=TAG_U_RTN,RL0=$P($T(@RL0),";",3)
 . . I RL0="" Q
 . . S RL1=TAG_"+1"_U_RTN,RL1=$P($T(@RL1),";",3)
 . . S RL2=TAG_"+2"_U_RTN,RL2=$P($T(@RL2),";",3)
 . . S RL3=TAG_"+3"_U_RTN,RL3=$P($T(@RL3),";",3)
 . . S RL4=TAG_"+4"_U_RTN,RL4=$P($T(@RL4),";",3)
 . . ;Setting the work variables
 . . S FHFNC=$P(RL0,U,2)
 . . S FHFNCN=$P(RL0,U)
 . . S (ADDREC,FHIEN,UDREC)=0
 . . ;Finding the matching Food Nutrient in file #112
 . . K FHERR,FHFDA,FHMSG,FHREC,X
 . . S FHIEN=$O(^FHNU("C",FHFNC,FHIEN))
 . . I FHIEN="" D
 . . . S FHIEN="+1,",FLAG="",X=4,ADDREC=1
 . . . S ^XTMP("FHAR23",1)=^XTMP("FHAR23",1)+1
 . . . S ^XTMP("FHAR23",2,FHFNC)=FHFNCN_U_RTN_U_TAG
 . . E  D
 . . . S FHIEN=FHIEN_",",FLAG="R",X=5,ADDREC=0
 . . . D GETS^DIQ(112,FHIEN,"*","I","FHREC","FHERR")
 . . I ADDREC D ZERONODE
 . . S RL=RL1,NVNL=$P($T(1),";",3),LPSRT=1,LPEND=20,FLDCNT=10 D WORKNODE
 . . S RL=RL2,NVNL=$P($T(2),";",3),LPSRT=1,LPEND=18,FLDCNT=30 D WORKNODE
 . . S RL=RL3,NVNL=$P($T(3),";",3),LPSRT=1,LPEND=18,FLDCNT=50 D WORKNODE
 . . S RL=RL4,NVNL=$P($T(4),";",3),LPSRT=1,LPEND=10,FLDCNT=70 D WORKNODE
 . . I ADDREC D
 . . . S FLDNUM=98,FLDVAL="USDA Std. Reference, Release 23" D BLDFDA
 . . . D UPDATE^DIE("","FHFDA","","FHERR")
 . . I UDREC D
 . . . D FILE^DIE("","FHFDA","FHERR")
 . . . S ^XTMP("FHUD23",1)=^XTMP("FHUD23",1)+1
 . . . S ^XTMP("FHUD23",2,FHFNC)=FHREC(112,FHIEN,.01,"I")
 D EN^DDIOL("Update of file #112 is complete.","","!?5")
 D RPTUPDT
 D RPTADD
 Q
ZERONODE ;If adding a record create zero node FDA nodes
 S RL=RL0,NVNL=$P($T(0),";",3),LPSRT=1,LPEND=7
 F RLP=LPSRT:1:LPEND D
 . I $P(RL,U,RLP)="" Q
 . S FLDNUM=$P($P(NVNL,U,RLP),"|",2)
 . S FLDVAL=$P(RL,U,RLP)
 . D BLDFDA
 Q
WORKNODE ;Process the data nodes for the current nutrient
 F RLP=LPSRT:1:LPEND D
 . I $P(RL,U,RLP)="" Q  ;If no data in the current field, quit to next field
 . S FLDNUM=FLDCNT+RLP ;Compute field number
 . S FLDVAL=$P(RL,U,RLP) ;Pull field data value
 . ;If adding a new record add the field data value to FDA array and quit to next field
 . I ADDREC D BLDFDA Q
 . ;If no old value, quit to next field.
 . ;This is to filter out nutrients that maybe in the release but not used in file #112 
 . I '$D(FHREC(112,FHIEN,FLDNUM,"I")) Q
 . ;If old value and new values match, quit to next field
 . I FHREC(112,FHIEN,FLDNUM,"I")=FLDVAL Q
 . D BLDFDA ;Add new field data value to FDA array
 . ;Update temporary global to report the update
 . S UDREC=1
 . S ^XTMP("FHUD23",2,FHFNC,FLDNUM)=$P(NVNL,U,RLP)_U_FHREC(112,FHIEN,FLDNUM,"I")_U_FLDVAL
 Q
BLDFDA ;Building the FDA arrary
 D FDA^DILF(112,FHIEN,FLDNUM,FLAG,FLDVAL,"FHFDA","FHERR")
 Q
RPTADD ;Report the added records
 N DIFROM,FHMSG,LC,LPEND,NVNL,RL0,RL1,RL2,RL3,RL4,RLP,RTN,TAG,X,X0,XMDUZ,XMSUB,XMY
 D EN^DDIOL(^XTMP("FHAR23",1)_" records were added to file #112 by patch FH*5.5*26","","!?5")
 D EN^DDIOL("Creating report of added records.","","!?5")
 S (X,X0)=""
 K ^TMP($J,"FHMSG")
 S ^TMP($J,"FHMSG",1,0)="Update of FOOD NUTRIENTS file (#112) to USDA Standard Release 23."
 S ^TMP($J,"FHMSG",2,0)="Records added by patch FH*5.5*26"
 S ^TMP($J,"FHMSG",3,0)=$$REPEAT^XLFSTR("-",79)
 S LC=4
 F  S X0=$O(^XTMP("FHAR23",2,X0)) Q:X0=""  D
 . K FHMSG
 . S (RL0,RL1,RL2,RL3,RL4)=""
 . S RTN=$P(^XTMP("FHAR23",2,X0),U,2)
 . S TAG=$P(^XTMP("FHAR23",2,X0),U,3)
 . S RL0=TAG_U_RTN,RL0=$P($T(@RL0),";",3)
 . I RL0="" Q
 . S RL1=TAG_"+1"_U_RTN,RL1=$P($T(@RL1),";",3)
 . S RL2=TAG_"+2"_U_RTN,RL2=$P($T(@RL2),";",3)
 . S RL3=TAG_"+3"_U_RTN,RL3=$P($T(@RL3),";",3)
 . S RL4=TAG_"+4"_U_RTN,RL4=$P($T(@RL4),";",3)
 . S NVNL=$P($T(0),";",3)
 . D INC
 . S ^TMP($J,"FHMSG",LC,0)=$P($P(NVNL,U),"|")_": "_$P(RL0,U)
 . F RLP=3:2:7 D
 . . S FHMSG=$P($P(NVNL,U,RLP-1),"|")_": "_$P(RL0,U,RLP-1)
 . . S X=$$REPEAT^XLFSTR(" ",40-$L(FHMSG))
 . . S FHMSG=FHMSG_X_$P($P(NVNL,U,RLP),"|")_": "_$P(RL0,U,RLP)
 . . D INC
 . . S ^TMP($J,"FHMSG",LC,0)=FHMSG,(FHMSG,X)=""
 . S NVNL=$P($T(1),";",3),RL=RL1,LPEND=20 D RPTADD0
 . S NVNL=$P($T(2),";",3),RL=RL2,LPEND=18 D RPTADD0
 . S NVNL=$P($T(3),";",3),RL=RL3,LPEND=18 D RPTADD0
 . S NVNL=$P($T(4),";",3),RL=RL4,LPEND=10 D RPTADD0
 . D INC
 . S ^TMP($J,"FHMSG",LC,0)=""
 D EN^DDIOL("Sending report by MailMan.","","!?5")
 S XMDUZ=.5
 S XMSUB="RECORDS ADDED BY PATCH FH*5.5*26"
 S XMY(DUZ)=""
 S XMTEXT="^TMP($J,""FHMSG"","
 D ^XMD
 I '$D(XXMG) D EN^DDIOL("Report successfully sent.","","!?5")
 K ^TMP($J,"FHMSG")
 Q
RPTADD0 ;Print the nutrients of the added record
 F RLP=2:2:LPEND D
 . S FHMSG=$P(NVNL,U,RLP-1)_": "_$P(RL1,U,RLP-1)
 . S X=$$REPEAT^XLFSTR(" ",40-$L(FHMSG))
 . S FHMSG=FHMSG_X_$P(NVNL,U,RLP)_": "_$P(RL1,U,RLP)
 . D INC
 . S ^TMP($J,"FHMSG",LC,0)=FHMSG,(FHMSG,X)=""
 Q
RPTUPDT ;Report the updated records
 N DIFROM,FHMSG,LC,X,X0,X1,XMDUZ,XMSUB,XMTEXT,XMY
 D EN^DDIOL(^XTMP("FHUD23",1)_" records in file #112 were updated by patch FH*5.5*26.","","!?5")
 D EN^DDIOL("Creating report of updated records.","","!?5")
 K ^TMP($J,"FHMSG")
 S ^TMP($J,"FHMSG",1,0)="Update of FOOD NUTRIENTS file (#112) to USDA Standard Release 23"
 S ^TMP($J,"FHMSG",2,0)="Records updated by patch FH*5.5*26"
 S ^TMP($J,"FHMSG",3,0)=$$REPEAT^XLFSTR("-",79)
 S LC=4,(X0,X1)=""
 F  S X0=$O(^XTMP("FHUD23",2,X0)) Q:X0=""  D
 . K FHMSG
 . D INC
 . S ^TMP($J,"FHMSG",LC,0)="FOOD: "_X0_" - "_^XTMP("FHUD23",2,X0)
 . S FHMSG="Nutrient"
 . S X=$$REPEAT^XLFSTR(" ",40-$L(FHMSG)),FHMSG=FHMSG_X_"Old value",X=""
 . S X=$$REPEAT^XLFSTR(" ",60-$L(FHMSG)),FHMSG=FHMSG_X_"New value",X=""
 . D INC S ^TMP($J,"FHMSG",LC,0)=FHMSG,FHMSG=""
 . D INC S ^TMP($J,"FHMSG",LC,0)=$$REPEAT^XLFSTR("-",79)
 . F  S X1=$O(^XTMP("FHUD23",2,X0,X1)) Q:X1=""  D
 . . S FHMSG=$P(^XTMP("FHUD23",2,X0,X1),U)
 . . S X=$$REPEAT^XLFSTR(" ",40-$L(FHMSG))
 . . S FHMSG=FHMSG_X_$P(^XTMP("FHUD23",2,X0,X1),U,2)
 . . S X=$$REPEAT^XLFSTR(" ",60-$L(FHMSG))
 . . S FHMSG=FHMSG_X_$P(^XTMP("FHUD23",2,X0,X1),U,3)
 . . D INC S ^TMP($J,"FHMSG",LC,0)=FHMSG,FHMSG=""
 . D INC S ^TMP($J,"FHMSG",LC,0)=""
 D EN^DDIOL("Sending report by MailMan.","","!?5")
 S XMDUZ=.5
 S XMSUB="RECORDS UPDATED BY PATCH FH*5.5*26"
 S XMY(DUZ)=""
 S XMTEXT="^TMP($J,""FHMSG"","
 D ^XMD
 I '$D(XMMG) D EN^DDIOL("Report successfully sent.","","!?5")
 K ^TMP($J,"FHMSG")
 Q
INC ;Increment line counter variable LC
 S LC=LC+1 Q
 ;Field names for the user message display
0 ;;NAME|.01^CODE|1^COMMON UNITS|2^GRAMS/COMMON UNIT|3^% AS PURCHASED|5^EDITABLE?|6^TYPE|7
1  ;;PROTEIN^LIPIDS^CARBOHYDRATE^FOOD ENERGY^WATER^^^CALCIUM^IRON^MAGNESIUM^PHOSPHORUS^POTASSIUM^SODIUM^ZINC^COPPER^MANGANESE^ALPHA TOCOPHEROL^VITAMIN A^ASCORBIC ACID^THIAMIN
2  ;;RIBOFLAVIN^NIACIN^PANTOTHENIC ACID^VITAMIN B6^FOLATE^VITAMIN B12^LINOLEIC ACID^LINOLENIC ACID^CHOLESTEROL^SATURATED FAT^MONOUNSATURATED FAT^POLYUNSATURATED FAT^VITAMIN A^ASH^ALCOHOL^CAFFEINE^TOTAL DIETARY FIBER^TOTAL TOCOPHEROL
3  ;;TRYPTOPHAN^THREONINE^ISOLEUCINE^LEUCINE^LYSINE^METHIONINE^CYSTINE^PHENYLALANINE^TYROSINE^VALINE^ARGININE^HISTIDINE^ALANINE^ASPARTIC ACID^GLUTAMIC ACID^GLYCINE^PROLINE^SERINE^
4  ;;CAPRIC ACID^LAURIC ACID^MYRISTIC ACID^PALMITIC ACID^PALMITOLEIC ACID^STEARIC ACID^OLEIC ACID^ARACHIDONIC ACID^VITAMIN K^SELENIUM
5  ;;SOURCE OF DATA
