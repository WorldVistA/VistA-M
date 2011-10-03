PXRMCSD ;SLC/JVS - Code Set Version-dialog file ;11/02/2009
 ;;2.0;CLINICAL REMINDERS;**9,17**;Feb 04, 2005;Build 102
 ;Variable List
 ;TMP        =Mail message array
 ;DLGNAME    =Dialogue Name .01 field
 ;EFFDATE    =Effective Date
 ;FILE       =Name of the Glpbal (ie ICPT or ICD9)
 ;VAR,VAR3   =Variable Pointer
 ;VARIEN     =Ien from Variable Pointer
 ;VRSTATUS   =Status of Code in form 1 or 0
 ;VARDESC    =Code Text Description
 ;STATUS     =External form of Code Status
 ;NUM        =Line Number
 ;
 Q
TASKALL ;TASK for all codes
 S ZTRTN="DLG^PXRMCSD(""ALL"")"
 S ZTDESC="Finding Inactive Codes in Dialog file"
 S ZTIO=""
 S ZTDTH=$H
 D ^%ZTLOAD
 Q
TASKCPT ;TASK for Icpt codes Diagnosis
 S ZTRTN="DLG^PXRMCSD(""ICPT"")"
 S ZTDESC="Finding Inactive Codes in Dialog file"
 S ZTIO=""
 S ZTDTH=$H
 D ^%ZTLOAD
 Q
TASKICD ;TASK for ICD codes
 S ZTRTN="DLG^PXRMCSD(""ICD9"")"
 S ZTDESC="Finding Inactive Codes in Dialog file"
 S ZTIO=""
 S ZTDTH=$H
 D ^%ZTLOAD
 Q
OPTION ;Option entry point for dir call
 N X,Y,%,%H,X
 K DIR,Y,%I
 S DIR(0)="SX^1:ICPT Codes;2:ICD9 Codes;3:ALL Codes"
 S DIR("A")="Select Codes or All of the codes or ""^"" to exit"
 S DIR("?",1)="This option is use to evaluate the various codes"
 S DIR("?",2)="used in the reminder dialogs as Finding Items and"
 S DIR("?",3)="Additonal Finding Items. It will report by mail message"
 S DIR("?",4)="which codes are now inactive or are set to become"
 S DIR("?",5)="in the future."
 S DIR("B")="3"
 S DIR("?")="Select a code set to be evaluated"
 D ^DIR
 I Y=1 W !,"Check Mail for results....." S ZTRTN="DLG^PXRMCSD(""ICPT"",1)"
 I Y=2 W !,"Check Mail for results....." S ZTRTN="DLG^PXRMCSD(""ICD9"",1)"
 I Y=3 W !,"Check Mail for results....." S ZTRTN="DLG^PXRMCSD(""ALL"",1)"
 S ZTDESC="Finding Inactive Codes in Dialog file"
 S ZTIO=""
 D NOW^%DTC S ZTDTH=%H
 D ^%ZTLOAD
 K DIR,Y,%I,X
 Q
 ;
DLG(GLOBAL,OPTION) ;ENTRY POINT
 ;Test entry point to $O through dialogues
 ;GLOBAL = Which code set to check out.
 ;GLOBAL ="ICPT" OR "ICD9" OR "ALL"
 ;OPTION = From and option 1=yes null=no
 ;^PXRMD(801.41,IEN,1) 5TH PIECE
 Q:'$D(GLOBAL)
 N IEN,VAR,STATUS,NUM,ITEM,FILE,VARDIS,LINE,VARTYP
 N VARIEN,VRSTATUS,VARDESC,DLGNAME,VARIENX,ARRY,VARDIS
 N TMP,TYPE,XMDUN,XMSUB,XMUSB
 ;=====Set variables====================================
 S TMP="^TMP(""PXRMXMZ"",$J,NUM,0)"
 S NUM=0
 S LINE="S NUM=NUM+1"
 D TEXT
 S IEN=0 F  S IEN=$O(^PXRMD(801.41,IEN)) Q:IEN'>0  D
 .S VAR=$P($G(^PXRMD(801.41,IEN,1)),"^",5) ;varable pointer
 .S DLGNAME=$P($G(^PXRMD(801.41,IEN,0)),"^",1)
 .S TYPE=$P($G(^PXRMD(801.41,IEN,0)),"^",4)
 .I +VAR'=0 S ITEM=" FI" D
 ..;============ICPT(=================================
 ..N VARIEN,CPTDATA,IADATE,VARCODE,VARDESC,VARPAST,VARTYP,VARDIS,VART
 ..I $P(VAR,";",2)="ICPT(",((GLOBAL="ICPT")!(GLOBAL="ALL")) D
 ...S FILE=" CPT"
 ...S VARIEN=$P(VAR,";",1) ;Ien from variable pointer
 ...S CPTDATA=$$CPTA^PXRMCSU(VARIEN) ;ALL Cpt data
 ...I ($P(CPTDATA,"^",7)=0) D
 ....S IADATE=$$CONV^PXRMCSU($P(CPTDATA,"^",8)) ;Convert Inactive date
 ....S VARCODE=$$CPT^PXRMCSU(VARIEN) ;Code value
 ....S VARDESC=$$CPTD^PXRMCSU(VARIEN) ;Description
 ....S VARPAST=$P(CPTDATA,"^",11)
 ....D GETS^DIQ(801.41,IEN,"3;4","E","VART") S VARIENX=IEN_"," D
 .....S VARTYP=$G(VART(801.41,VARIENX,4,"E")) ;element type
 .....S VARDIS=$G(VART(801.41,VARIENX,3,"E")) ;element disabled
 ....D TMP
 ..;============ICD9(=================================
 ..N VARIEN,ICD9DATA,IADATE,VARCODE,VARDESC,VARPAST,VARTYP,VARDIS,VART
 ..I $P(VAR,";",2)="ICD9(",((GLOBAL="ICD9")!(GLOBAL="ALL")) D
 ...S FILE="ICD9"
 ...S VARIEN=$P(VAR,";",1) ;Ien from variable pointer
 ...S ICD9DATA=$$ICD9A^PXRMCSU(VARIEN) ;All ICD9 data
 ...I ($P(ICD9DATA,"^",10)=0) D
 ....S IADATE=$$CONV^PXRMCSU($P(ICD9DATA,"^",12)) ;Conver Inact date
 ....S VARCODE=$$ICD9^PXRMCSU(VARIEN) ;Code
 ....S VARDESC=$$ICD9D^PXRMCSU(VARIEN) ;Description
 ....S VARPAST=$P(ICD9DATA,"^",19)
 ....D GETS^DIQ(801.41,IEN,"3;4","E","VART") S VARIENX=IEN_"," D
 .....S VARTYP=$G(VART(801.41,VARIENX,4,"E")) ;element type
 .....S VARDIS=$G(VART(801.41,VARIENX,3,"E")) ;element description
 ....D TMP
 .D DLG3
 S XMSUB="Reminder Dialog "_$S(GLOBAL="ALL":"ICD9 AND CPT",GLOBAL="ICPT":"CPT",1:GLOBAL)_" Code changes"
 I '$D(^TMP("PXRMXMZ",$J)) D
 . S ^TMP("PXRMXMZ",$J,1,0)="No dialog elements using inactive codes were found."
 . S ^TMP("PXRMXMZ",$J,2,0)="No action is necessary."
 D SEND^PXRMMSG("PXRMXMZ",XMSUB)
 K ^TMP("PXRMXMZ",$J)
 S ZTREQ="@"
 Q
DLG3 ;^PXRMD(801.41,IEN,3,IEN3,0) 1ST PIECE
 N IEN3,VAR3
 S IEN3=0 F  S IEN3=$O(^PXRMD(801.41,IEN,3,IEN3)) Q:IEN3'>0  D
 .S VAR3=$P($G(^PXRMD(801.41,IEN,3,IEN3,0)),"^",1)
 .I +VAR3'=0 S ITEM="AFI" D
 ..;================ICPT================================= 
 ..N VARIEN,CPTDATA,IADATE,VARCODE,VARDESC,VARPAST,VARTYP,VARDIS,VART
 ..I $P(VAR3,";",2)="ICPT(",((GLOBAL="ICPT")!(GLOBAL="ALL")) D
 ...S FILE=" CPT"
 ...S VARIEN=$P(VAR3,";",1) ;Ien from variable pointer
 ...S CPTDATA=$$CPTA^PXRMCSU(VARIEN) ;All CPT data
 ...I ($P(CPTDATA,"^",7)=0) D
 ....S IADATE=$$CONV^PXRMCSU($P(CPTDATA,"^",8)) ;Convert Inac Date
 ....S VARCODE=$$CPT^PXRMCSU(VARIEN) ;Code
 ....S VARDESC=$$CPTD^PXRMCSU(VARIEN) ;Description
 ....S VARPAST=$P(CPTDATA,"^",11)
 ....D GETS^DIQ(801.41,IEN,"3;4","E","VART") S VARIENX=IEN_"," D
 .....S VARTYP=$G(VART(801.41,VARIENX,4,"E")) ;element type
 .....S VARDIS=$G(VART(801.41,VARIENX,3,"E")) ;element description
 ....D TMP
 ..;================ICD9=================================
 ..N VARIEN,ICD9DATA,IADATE,VARCODE,VARDESC,VARPAST,VARTYP,VARDIS,VART
 ..I $P(VAR3,";",2)="ICD9(",((GLOBAL="ICD9")!(GLOBAL="ALL")) D
 ...S FILE="ICD9"
 ...S VARIEN=$P(VAR3,";",1) ;Ien from variable pointer
 ...S ICD9DATA=$$ICD9A^PXRMCSU(VARIEN) ;All ICD9 data
 ...I ($P(ICD9DATA,"^",10)=0) D
 ....S IADATE=$$CONV^PXRMCSU($P(ICD9DATA,"^",12)) ;Conver Inac date
 ....S VARCODE=$$ICD9^PXRMCSU(VARIEN) ;Code
 ....S VARDESC=$$ICD9D^PXRMCSU(VARIEN) ;Description
 ....S VARPAST=$P(ICD9DATA,"^",19)
 ....D GETS^DIQ(801.41,IEN,"3;4","E","VART") S VARIENX=IEN_"," D
 .....S VARTYP=$G(VART(801.41,VARIENX,4,"E")) ;element type
 .....S VARDIS=$G(VART(801.41,VARIENX,3,"E")) ;element desc
 ....D TMP
 Q
SUB ;==============Sub Routines=============================
 ;SET MAIL MESSAGE LINE
TMP ;Set tmp global lines
 X LINE S @TMP="    "_FILE_" "_ITEM_": "_VARCODE_" (Inactive "_$G(IADATE)_")"
 S VARDIS=$S($G(VARDIS)'="":"(Disabled)",1:"(Enabled)")
 S VARTYP=$G(VARTYP)
 X LINE S @TMP="    Found in: "_DLGNAME_" ["_VARTYP_"]"_" "_VARDIS
 D PARENT(IEN)
 Q
MESS ;Mail Message Static Text
 Q
MESS1 ;
 N GLOBALX
 S GLOBALX=$S(GLOBAL="ICPT":"CPT",GLOBAL="ICD9":"ICD9",GLOBAL="ALL":"CPT and/or ICD9",1:"")
 I $G(OPTION)=1 S MESS1="Review of inactive codes as of "_$$CONV^PXRMCSU(DT)
 I $G(OPTION)="" S MESS1="There was a "_GLOBALX_" code set update on "_$$CONV^PXRMCSU(DT)
 Q
MESS2 ;
 ;;
 ;;Please review the FINDING ITEM and ADDITIONAL FINDING items
 ;;currently used by REMINDER DIALOGS that may need changes.
 ;;
 ;;Consider adding another ADDITIONAL FINDING item to the reminder dialog
 ;;entry which will be active. This will allow the dialog to have old
 ;;and new codes associated with a dialog element, which will use
 ;;the item that is active for the encounter date.
 ;;Eventually, the inactive FINDING ITEM or ADDITIONAL FINDING items
 ;;should be removed from the dialog element.
 ;;
 ;;Note: FI=FINDING ITEM field    AFI=ADDITIONAL FINDING ITEMS field
 ;;Note: [finding type]  (status)
 ;;_______________________________________________________________________________
 Q
MESS3 ;
 ;;Report of Inactive ICD9 and CPT Codes referenced in the Reminder
 ;;Dialog file.
 ;;
 ;;Note: FI=FINDING ITEM field    AFI=ADDITIONAL FINDING ITEMS field
 ;;Note: [finding type]  (status)
 ;;_______________________________________________________________________________
 Q
TEXT ;display text
 N MESS1,PXRMI
 I GLOBAL="ALL" D
 .F PXRMI=1:1:6 X LINE S @TMP=$P($T(MESS3+PXRMI),";",3)
 I GLOBAL'="ALL" D
 .D MESS1 X LINE S @TMP=MESS1
 .F PXRMI=1:1:14 D
 ..X LINE S @TMP=$P($T(MESS2+PXRMI),";",3)
 Q
PARENT(PARXY) ;Get the Parent Dialog Element of the Dialog Element
 N PARY,PARXYVAR,PARX,PXRMTYPE
 S PARX=0 F  S PARX=$O(^PXRMD(801.41,PARX)) Q:PARX<1  D
 .S PARY=0 F  S PARY=$O(^PXRMD(801.41,PARX,10,"D",PARY)) Q:PARY<1  D 
 ..I PARXY=PARY D GETS^DIQ(801.41,PARX,"3;4","E","PXRMTYPE") D
 ...S PARXYVAR=PARX_",",VARDIS=$G(PXRMTYPE(801.41,PARXYVAR,3,"E")),VARDIS=$S($G(VARDIS)'="":"(Disabled)",1:"(Enabled)")
 ...X LINE S @TMP="     Used by: "_$P($G(^PXRMD(801.41,PARX,0)),"^",1)_" ["_$G(PXRMTYPE(801.41,PARXYVAR,4,"E"))_"]"_" "_VARDIS
 X LINE S @TMP="___________________________________________________________________________"
 Q
