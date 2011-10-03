PSAUP ;BIR/JMB-Upload and Process Prime Vendor Invoice Data ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**12**; 10/24/97
 ;This routine uploads the prime vendor data into ^TMP("PSAPV",$J).
 ;The  X12 data is checked for proper format. If the X12 data is correct,
 ;it is loaded into ^XTMP("PSAX12").
 ;
 I '$D(^XUSEC("PSA ORDERS",DUZ)) W !,"You do not hold the key to enter the option." Q
 W @IOF,!,"****************************** I M P O R T A N T ******************************"
 W !!,"This option uploads the invoice data received from your prime vendor.",!,"In order to upload the data, you must be running ProComm Plus software",!,"on Pharmacy's prime vendor PC.",!!
 S PSASTLN="",$P(PSASTLN,"*",80)="" W PSASTLN,! K PSASTLN
 S DIR("A")="Are you ready to upload the prime vendor invoice data",DIR(0)="Y",DIR("B")="Yes",DIR("??")="^D YNUPLOAD^PSAUP1" D ^DIR K DIR
 I 'Y S PSAOUT=1 G KILL
 I $D(^DIZ(8980,"AOK",DUZ)) S XTKDIC="^TMP(""PSAX12"",$J,",DWLC=0,XTKMODE=2
 I '$D(^DIZ(8980,"AOK",DUZ)) D RFILE^XTKERM4
 S PSAOUT=0 K ^TMP("PSAX12",$J)
 W !!,"Press <ALT> 1 if your Prime Vendor script is installed as a Meta Key,",!,"otherwise press <ALT> F5 and enter ""PV""",!
 X ^%ZOSF("EOFF") R X:DTIME X ^%ZOSF("EON") D HASH^XUSHSHP I X'="$4_\y o\Xp>RN}ab*_%," S PSAOUT=1
 I '$G(PSAOUT) S XTKDIC="^TMP(""PSAX12"",$J,",DWLC=0,XTKMODE=2 D RECEIVE^XTKERMIT
 I $G(PSAOUT) S XTKERR="The invoice file cannot be uploaded. Contact your IRM staff for assistance." K ^TMP("PSAPV",$J) H 1
 I $G(XTKERR)'=0 W !!,"ERROR - "_XTKERR S PSAOUT=1 Q
 I DWLC=0 W !,"ERROR - NO LINES RECEIVED." S PSAOUT=1 Q
 W @IOF,!,"Done",!,"The data uploaded to a temporary file. "_DWLC," lines received.",!! H 2
 G:'$O(^TMP("PSAX12",$J,0)) KILL
 ;
UNWRAP ;Changes the data element and segment delimiters to ^ & ~, places each
 ;segment on a node to itself, then removes leading spaces from each
 ;data element
 W !,"Unwrapping the invoice."
 ;
 ;Get delimiters
 S (PSABBC,PSAISA,PSALINE,PSASEGD,PSALND)=0
 F  S PSALINE=$O(^TMP("PSAX12",$J,PSALINE)) Q:'PSALINE  D  Q:PSABBC&(PSAISA)
 .I $E($G(^TMP("PSAX12",$J,PSALINE,0)),1,3)="ISA" S DAVE=^TMP("PSAX12",$J,PSALINE,0) S PSASEGD=$E(^(0),4,4),PSALND=$E(^(0),106,106),PSAISA=1 W "." Q
 .I $P($G(^TMP("PSAX12",$J,PSALINE,0)),PSASEGD,2)="DS",$P($G(^(0)),PSASEGD,3)="BBC" S PSABBC=1
 ;If drug company is Bergen (BBC), changes data element to ^ and adds
 ;segment delimiters to ~.
 I PSABBC S (PSACNT,PSALINE)=0 F  S PSALINE=$O(^TMP("PSAX12",$J,PSALINE)) Q:'PSALINE  D
 .S PSADATA=^TMP("PSAX12",$J,PSALINE,0)_"~"
 .I PSASEGD'="^" S PSADATA=$TR(PSADATA,PSASEGD,"^")
 .I $E($G(^TMP("PSAX12",$J,PSALINE,0)),1,3)="ISA" W "."
 .S ^TMP("PSAX12",$J,PSALINE,0)=PSADATA
 G:PSABBC LINE
 ;
 I PSASEGD=""!(PSALND="") D  G KILL
 .S PSASTAR="",$P(PSASTAR,"*",80)=""
 .W !,PSASTAR,!,"There is a major error in the invoice file.",!,"Contact your IRM Staff for assistance."
 .W !!,"Press the Esc key then enter YES at the 'EXIT SCRIPT (Y/N)' prompt.",!,"Press RETURN to exit the option.",!,PSASTAR D END^PSAPROC
 G:PSASEGD="~"&(PSALND="^") LINE
 ;
 ;Changes the data element and segment delimiters to ^ and ~.
 S (PSACNT,PSALINE)=0 F  S PSALINE=$O(^TMP("PSAX12",$J,PSALINE)) Q:'PSALINE  D  Q:PSAOUT
 .S PSADATA=^TMP("PSAX12",$J,PSALINE,0)
 .I PSALND'="~" S PSADATA=$TR(PSADATA,PSALND,"~")
 .I PSASEGD'="^" S PSADATA=$TR(PSADATA,PSASEGD,"^")
 .S ^TMP("PSAX12",$J,PSALINE,0)=PSADATA
 .I $P(^TMP("PSAX12",$J,PSALINE,0),"^")="ISA" W "."
 ;
LINE ;Places each segment on a node to itself.
 K ^TMP("PSAPV",$J)
 S PSAHOLD="",(PSACNT,PSALINE)=0
 F  S PSALINE=$O(^TMP("PSAX12",$J,PSALINE)) Q:'PSALINE  D
 .S PSADATA=^TMP("PSAX12",$J,PSALINE,0),PSADATA=PSAHOLD_PSADATA
 .I PSADATA'["~" S PSAHOLD=PSADATA Q
 .S PSASTOP=0 F  S PSASEG=$P(PSADATA,"~") Q:PSASEG=""  D  Q:PSASTOP
 ..S PSACNT=PSACNT+1,^TMP("PSAPV",$J,PSACNT,0)=PSASEG
 ..I $P(PSASEG,"^")="ISA" W "."
 ..S PSADATA=$P(PSADATA,"~",2,99) I PSADATA'["~" S PSASTOP=1,PSAHOLD=PSADATA Q
 ..S PSAHOLD=""
 ;
SPACES ;remove all leading spaces in all data elements
 K ^TMP("PSAX12",$J)
 S (PSACNT,PSALINE)=0 F  S PSALINE=$O(^TMP("PSAPV",$J,PSALINE)) Q:'PSALINE  D
 .S PSASEG=^TMP("PSAPV",$J,PSALINE,0)
 .I $E(PSASEG,1,3)="ISA" S ^TMP("PSAPVS",$J,PSALINE)=^TMP("PSAPV",$J,PSALINE,0) W "." Q
 .S PSACNT=0,PSASEGL=$L(PSASEG)
 .F PSAEX=1:1:PSASEGL S PSAX=$E(PSASEG,PSAEX,PSAEX) S:PSAX="^" PSACNT=PSACNT+1
 .F PSAPC=1:1:(PSACNT+1) S PSADE=$P(PSASEG,"^",PSAPC) D
 ..F  Q:$E(PSADE,1,1)'=" "  S PSADE=$E(PSADE,2,999)
 ..S $P(PSASEG,"^",PSAPC)=PSADE
 .S ^TMP("PSAPVS",$J,PSALINE)=PSASEG
 K ^TMP("PSAPV",$J)
 W !,"Finished unwrapping the invoice." H 2
 ;
CHECK ;Looks for X12 errors. If no errors, loads data into ^TMP("PSAPV SET",$J)
 W !!,"Checking the invoice data."
 D ^PSAUP2
 K ^TMP("PSAPVS",$J)
 I PSAOUT K ^TMP("PSAPV SET",$J) G KILL
 W !,"Finished checking the invoice data." H 2
 ;
LOADXTMP ;Loads data into ^XTMP("PSAPV").
 W !!,"Loading data into VISTA."
 D XTMP^PSAUP1
 K ^TMP("PSAPV SET",$J) G:PSAOUT KILL
 W !,"Finished loading data into VISTA."
 W !!,"** The upload was successful. **" H 4
 D END^PSAPROC
 ;
STORE ;Get the line item data and store in ^XTMP("PSAPV")
 W @IOF S PSANEXT=$O(^XTMP("PSAPV",0))
 I PSANEXT="" W !,"There are no valid invoices to process." H 1 G KILL
 W !,"Searching for and storing the drug data for each line item."
 D ^PSAUP5
 W !,"Finished storing the drug data." H 1
 ;
PRINT ;Ask if user wants to print invoices.
 S PSASTA="U"
 W ! S DIR(0)="Y",DIR("A")="Print all uploaded invoices",DIR("B")="Y",DIR("?",1)="Enter YES to print the invoices that were uploaded.",DIR("?")="Enter NO to bypass printing the invoices and continue.",DIR("??")="^D YNPRINT^PSAUP1"
 D ^DIR K DIR G:$G(DIRUT) KILL D:Y ^PSAUP4
 ;
PROC ;Ask if user wants to process the invoice data now.
 W ! S DIR(0)="Y",DIR("A")="Do you want to process the invoices now",DIR("B")="Y",DIR("?",1)="Enter YES to process the invoices that were uploaded.",DIR("?")="Enter NO to exit the option.",DIR("??")="^D YNPROCES^PSAUP1"
 D ^DIR K DIR G:'Y!($G(DIRUT)) KILL
 D KILL
 ;
PHARM ;Assign a pharmacy location or master vault to each Order.
 ;Then process the invoice data.
 S PSAOUT=0
 D ^PSAPROC G:$G(PSAOUT) EXIT^PSAPROC
 ;
PRINT2 W !! S DIR(0)="Y",DIR("A")="Print all unprocessed and just processed invoices",DIR("B")="N"
 S DIR("?",1)="Enter YES to print all of the uploaded invoices that are",DIR("?")="unprocessed or just processed. Enter NO to exit the option."
 S DIR("??")="^D PRT2^PSAUP1"
 D ^DIR K DIR D:+Y ^PSAUP4 S PSAENTRY=0
 G EXIT^PSAPROC
 ;
KILL ;Kills uploading variables
 K ^TMP("PSAPV",$J),^TMP("PSAPVS",$J),^TMP("PSAPV SET",$J),^TMP("PSAX12",$J)
 K %,DIR,DIRUT,DWLC,PSABBC,PSACNT,PSACTN1,PSACOMB,PSACS,PSACTRL,PSACTRL2,PSADATA,PSADE,PSADT,PSADUP,PSAENTRY,PSAERR,PSAEX,PSAEXPEC,PSAFND1,PSAGS,PSAHOLD,PSAIEN,PSAIN,PSAINV,PSAINVDT,PSAINVN,PSAISA,PSAISIT,PSAISITN,PSAITCNT,PSAITEM
 K PSALAST,PSALINE,PSALLCS,PSALLOK,PSALND,PSALOC,PSANDC,PSANEW,PSANEXT,PSANTYPE,PSAOK,PSAORD,PSAORDDT,PSAORDN,PSAOSIT,PSAOSITN,PSAOUT,PSAPC
 K PSAS,PSASEG,PSASEGL,PSASEGD,PSASS,PSAST,PSASTA,PSASTAR,PSASTCNT,PSASUB,PSASYN,PSAUOM,PSAUOM1,PSAUOMH,PSAUOMH1,PSAVSN,PSAX,X,X1,X2,XTKDIC,XTKERR,XTKMODE,Y
 Q
