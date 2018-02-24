PSNVCR1 ;BIR/RTR-VISTA COMPARISON REPORT CONTINUED ; 10 January 2017
 ;;4.0;NATIONAL DRUG FILE;**513**; 30 Oct 98;Build 53
 ;
 ;
FILE ;File Selection
 ;Sets selected file in PSNVRFIL array as PSNVRFIL(#)=File Name
 K DIR,Y S DIR(0)="SA^A:ALL;S:SPECIFIC"
 S DIR("?",1)="Enter 'A' to see changes made in all of the audited National Drug File files,"
 S DIR("?")="enter 'S' to select specific National Drug File files to see changes."
 S DIR("A")="Select (A)ll or (S)pecific Files: "
 D ^DIR I $D(DIRUT) S PSNVROUT=1 Q
 S PSNVRANS=Y D SELFILE(PSNVRANS) I PSNVROUT Q
 I PSNVRANS="A" W !!,"Since all files were selected, all audited fields will be shown on the report." S PSNVRSEE="A"
 Q
 ;
 ;
SELFILE(PSNVRSET) ; Set File array
 N PSNVRLP,PSNVRLPC,PSNVRLAR,PSNVRLST,PSNVRLTH,PSNVRNUM
 S PSNVRLAR(1)="50.416^DRUG INGREDIENTS"
 S PSNVRLAR(2)="50.6^VA GENERIC"
 S PSNVRLAR(3)="50.605^VA DRUG CLASS"
 S PSNVRLAR(4)="50.606^DOSAGE FORM"
 S PSNVRLAR(5)="50.607^DRUG UNITS"
 S PSNVRLAR(6)="50.608^PACKAGE TYPE"
 S PSNVRLAR(7)="50.609^PACKAGE SIZE"
 S PSNVRLAR(8)="50.64^VA DISPENSE UNIT"
 S PSNVRLAR(9)="50.67^NDC/UPN"
 S PSNVRLAR(10)="50.68^VA PRODUCT"
 S PSNVRLAR(11)="55.95^DRUG MANUFACTURER"
 S PSNVRLAR(12)="56^DRUG INTERACTION"
 I PSNVRSET="A" D  Q
 .S PSNVRLP="" F  S PSNVRLP=$O(PSNVRLAR(PSNVRLP)) Q:'PSNVRLP  S PSNVRFIL($P(PSNVRLAR(PSNVRLP),"^"))=($P(PSNVRLAR(PSNVRLP),"^",2))
AGAIN ;Re-prompt file selection
 W !!?4,"1)  "_$P(PSNVRLAR(1),"^")_"   "_$P(PSNVRLAR(1),"^",2)
 W !?4,"2)  "_$P(PSNVRLAR(2),"^")_"     "_$P(PSNVRLAR(2),"^",2)
 W !?4,"3)  "_$P(PSNVRLAR(3),"^")_"   "_$P(PSNVRLAR(3),"^",2)
 W !?4,"4)  "_$P(PSNVRLAR(4),"^")_"   "_$P(PSNVRLAR(4),"^",2)
 W !?4,"5)  "_$P(PSNVRLAR(5),"^")_"   "_$P(PSNVRLAR(5),"^",2)
 W !?4,"6)  "_$P(PSNVRLAR(6),"^")_"   "_$P(PSNVRLAR(6),"^",2)
 W !?4,"7)  "_$P(PSNVRLAR(7),"^")_"   "_$P(PSNVRLAR(7),"^",2)
 W !?4,"8)  "_$P(PSNVRLAR(8),"^")_"    "_$P(PSNVRLAR(8),"^",2)
 W !?4,"9)  "_$P(PSNVRLAR(9),"^")_"    "_$P(PSNVRLAR(9),"^",2)
 W !?3,"10)  "_$P(PSNVRLAR(10),"^")_"    "_$P(PSNVRLAR(10),"^",2)
 W !?3,"11)  "_$P(PSNVRLAR(11),"^")_"    "_$P(PSNVRLAR(11),"^",2)
 W !?3,"12)  "_$P(PSNVRLAR(12),"^")_"       "_$P(PSNVRLAR(12),"^",2),!
 K DIR,Y S DIR(0)="LA^1:12"
 S DIR("A")="Select from the above list of files: "
 S DIR("?",1)="Select from entries 1 through 12. Multiple entries can be selected by using"
 S DIR("?")="commas and dashes, such as 1,2,5-7 to select entries 1, 2, 5, 6, and 7."
 D ^DIR I $D(DIRUT) S PSNVROUT=1 Q
 S PSNVRLST=Y
 S PSNVRLPC=0 F PSNVRLP=1:1:$L(PSNVRLST) I $E(PSNVRLST,PSNVRLP)="," S PSNVRLPC=PSNVRLPC+1
 W !!,"You have selected the following files:",!
 F PSNVRLP=1:1:PSNVRLPC D
 .S PSNVRNUM=$P(PSNVRLST,",",PSNVRLP)
 .S PSNVRFIL($P(PSNVRLAR(PSNVRNUM),"^"))=$P(PSNVRLAR(PSNVRNUM),"^",2),PSNVRLTH=$L($P(PSNVRLAR(PSNVRNUM),"^"))
 .W !?3,$P(PSNVRLAR(PSNVRNUM),"^")_$S(PSNVRLTH=6:"  ",PSNVRLTH=5:"   ",PSNVRLTH=4:"    ",1:"      ")_$P(PSNVRLAR(PSNVRNUM),"^",2)
 W ! K DIR,Y S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S PSNVROUT=1 Q
 I Y'=1 K PSNVRFIL G AGAIN
 Q
 ;
 ;
DATE ;Date selection
 N %DT,X,X1,X2,%H,PSNVR90
 S X1=DT,X2=-90 D C^%DTC S PSNVR90=X
 W ! S %DT="AEPTX",%DT("A")="Enter Start Date: ",%DT(0)=PSNVR90 D ^%DT I $D(DTOUT)!(Y<0) S PSNVROUT=1 Q
 S PSNVRBEG=Y S X1=PSNVRBEG,X2=-1 D C^%DTC S PSNVRBEG=X_.9999
 K %DT,X S (PSNVRBEG,%DT(0))=Y
 S %DT="AEPTX",%DT("A")="Enter End Date: " D ^%DT I $D(DTOUT)!(Y<0) S PSNVROUT=1 Q
 S PSNVREND=Y I '$P(PSNVREND,".",2) S PSNVREND=PSNVREND_.9999
 Q
 ;
 ;
SUMM ;Prompt for full listing or summary
 W ! K DIR,Y S DIR(0)="SA^F:Full Listing;S:Summary totals"
 S DIR("?",1)="Enter 'F' to see old and new values of all of the audited fields,"
 S DIR("?")="enter 'S' to only see total numbers of records changed."
 S DIR("A")="Select (F)ull Listing or (S)ummary totals: "
 D ^DIR I $D(DIRUT) S PSNVROUT=1 Q
 S PSNVRSUM=Y
 Q
 ;
 ;
PMI ;Prompt for PMI and Warning Lablels if summary was selected in prior prompt
 W ! K DIR,Y S DIR(0)="Y",DIR("A")="Include counts for PMI and Warning Labels",DIR("B")="Y"
 S DIR("?",1)="Enter 'Y' to include PMI and Warning Label counts,"
 S DIR("?")="enter 'N' to not include these counts."
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S PSNVROUT=1 Q
 I Y=1 S PSNVRPMI=1
 Q
 ;
 ;
TYPE ;Prompt for report format or delimited list
 W ! K DIR,Y S DIR(0)="SA^P:Print List;D:Delimited File"
 S DIR("?",1)="Enter 'P' to see the output in a report format,"
 S DIR("?")="enter 'D' for a delimited list that can be exported to excel."
 S DIR("A")="Select (P)rint List or (D)elimited File: "
 D ^DIR I $D(DIRUT) S PSNVROUT=1 Q
 S PSNVRTYP=Y
 Q
 ;
 ;
SELECT(PSNVRNM) ;Select fields from each file selected
 N PSNVRSHO,PSNVRHPC,PSNVRHPL,PSNVRHNM,PSNVRAB1,PSNVRAB2,PSNVRAB3,PSNVRABN
 S PSNVRAGN=0 W ! K DIR,Y S DIR(0)="LA^1:"_PSNVRNM
 S DIR("A")="Select from the above list of fields: "
 S DIR("?",1)="Select from entries 1 through "_PSNVRNM_". Multiple entries can be selected by using"
 S DIR("?")="commas and dashes."
 D ^DIR I $D(DIRUT) S PSNVROUT=1 Q
 S PSNVRSHO=Y
 S PSNVRHPC=0 F PSNVRHPL=1:1:$L(PSNVRSHO) I $E(PSNVRSHO,PSNVRHPL)="," S PSNVRHPC=PSNVRHPC+1
 W !!,"You have selected the following fields:",!
 F PSNVRHPL=1:1:PSNVRHPC Q:PSNVROUT  D
 .I ($Y+5)>IOSL D YN^PSNVCR Q:PSNVROUT  W @IOF
 .S PSNVRHNM=$P(PSNVRSHO,",",PSNVRHPL)
 .W !?3,$P(PSNVRDAT(PSNVRHNM),"^",3)
 Q:PSNVROUT
 W ! K DIR,Y S DIR(0)="Y",DIR("A")="Is this correct",DIR("B")="Y" D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S PSNVROUT=1 K PSNVRAR Q
 I Y'=1 S PSNVRAGN=1 Q
 F PSNVRHPL=1:1:PSNVRHPC D
 .S PSNVRHNM=$P(PSNVRSHO,",",PSNVRHPL)
 .S PSNVRABN=$P(PSNVRDAT(PSNVRHNM),"^",4)
 .S PSNVRAB1=$P(PSNVRABN,";;"),PSNVRAB2=$P(PSNVRABN,";;",2),PSNVRAB3=$P(PSNVRABN,";;",3)
 .I 'PSNVRAB3 S PSNVRAR(PSNVRAB1,PSNVRAB2)=$P(PSNVRDAT(PSNVRHNM),"^") Q
 .S PSNVRAR(PSNVRAB1,PSNVRAB2,PSNVRAB3)=$P(PSNVRDAT(PSNVRHNM),"^")
 Q
 ;
 ;
DRM ;Set Fields for Drug Manufacturer (#55.95) File
 I PSNVRSL="A" D  Q
 .S PSNVRSL1=55.95 D
 ..F PSNVRSL2=0:0 S PSNVRSL2=$O(^DD(PSNVRSL1,"AUDIT",PSNVRSL2)) Q:'PSNVRSL2  D
 ...S PSNVRAR(55.95,PSNVRSL2)=PSNVRSL1
 K PSNVRDAT S PSNVRCN=0,PSNVRSL1=55.95
 F PSNVRSL2=0:0 S PSNVRSL2=$O(^DD(PSNVRSL1,"AUDIT",PSNVRSL2)) Q:'PSNVRSL2  D
 .S PSNVRCN=PSNVRCN+1,PSNVRDAT(PSNVRCN)=PSNVRSL1_"^"_PSNVRSL2
 .S PSNVRSUB=PSNVRDAT(PSNVRCN),$P(PSNVRDAT(PSNVRCN),"^",3)=$$GET1^DID($P(PSNVRSUB,"^"),$P(PSNVRSUB,"^",2),,"LABEL")
 .S $P(PSNVRDAT(PSNVRCN),"^",4)=55.95_";;"_PSNVRSL2
DRMN ;Redisplay for selection
 W @IOF
 W !?5,"Audited fields from the Drug Manufacturer (#55.95) File:",! S PSNVRFL=0
 D AUDF
 Q:PSNVROUT
 I 'PSNVRFL D MESS,YN Q
 D SELECT(PSNVRCN) I PSNVRAGN G DRMN
 Q
 ;
 ;
DRI ;Set Fields for Drug Interaction (#56) File
 I PSNVRSL="A" D  Q
 .S PSNVRSL1=56 D
 ..F PSNVRSL2=0:0 S PSNVRSL2=$O(^DD(PSNVRSL1,"AUDIT",PSNVRSL2)) Q:'PSNVRSL2  D
 ...S PSNVRAR(56,PSNVRSL2)=PSNVRSL1
 K PSNVRDAT S PSNVRCN=0,PSNVRSL1=56
 F PSNVRSL2=0:0 S PSNVRSL2=$O(^DD(PSNVRSL1,"AUDIT",PSNVRSL2)) Q:'PSNVRSL2  D
 .S PSNVRCN=PSNVRCN+1,PSNVRDAT(PSNVRCN)=PSNVRSL1_"^"_PSNVRSL2
 .S PSNVRSUB=PSNVRDAT(PSNVRCN),$P(PSNVRDAT(PSNVRCN),"^",3)=$$GET1^DID($P(PSNVRSUB,"^"),$P(PSNVRSUB,"^",2),,"LABEL")
 .S $P(PSNVRDAT(PSNVRCN),"^",4)=56_";;"_PSNVRSL2
DRIN ;Redisplay for selection
 W @IOF
 W !?5,"Audited fields from the Drug Interaction (#56) File:",! S PSNVRFL=0
 D AUDF
 Q:PSNVROUT
 I 'PSNVRFL D MESS,YN Q
 D SELECT(PSNVRCN) I PSNVRAGN G DRIN
 Q
 ;
 ;
AUDF ;Show audited fields
 F PSNVRSL1=1:1 Q:'$D(PSNVRDAT(PSNVRSL1))!(PSNVROUT)  D
 .I ($Y+5)>IOSL D YN Q:PSNVROUT  W @IOF
 .S PSNVRSUB=PSNVRDAT(PSNVRSL1)
 .W !?2,PSNVRSL1_")  "_$P(PSNVRDAT(PSNVRSL1),"^",3) S PSNVRFL=1
 Q
 ;
 ;
MESS ;Write Message
 W !,"***No Audited fields for this file.***"
 Q
 ;
 ;
YN ;yes or no prompt if no audited fields found for a file
 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue" D ^DIR
 I $D(DTOUT)!($D(DUOUT))!('Y) S PSNVROUT=1
 Q
 ;
 ;
DL ;Delimited File message
 ;
 W !!,"You have selected the delimited file output." D YN Q:PSNVROUT
 W @IOF
 W !,"The report output will be displayed on the screen in a delimited format, so"
 W !,"it can be captured and exported. If you are using Reflections, you can turn"
 W !,"logging on by selecting 'File' on the top left corner of the screen, then"
 W !,"select 'Logging' and capture to your desired location."
 W !!,"The format of the output is as follows, using '^' as the delimiter:"
 I PSNVRSUM="S" D  D YN Q
 .W !!,"File Name^Number of Records^Records Changed^Fields/Sub-fields Changed" Q:'PSNVRPMI
 .W !!,"**note** - the output for the PMI and Warning label Files"
 .W !,"           will only contain File Name and Number of Records.",!
 W !!,"File Name^Records - #####"
 W !,"File Name^Entry Name^Field Name^Field Number^Old Value^New Value"
 W !!,"**notes** - the Old Value and New Value will repeat as often as necessary."
 W !,"            duplicate Entry Names will have (duplicate #) appended."
 W !,"            duplicate Field Names will have the subfile number appended."
 W !,"            File Name^***No Changes** will print if there were no changes."
 D YN
 Q
 ;
 ;
PMIP ;Print PMI and Warning label totals
 ;
 I PSNFON,($Y+5)>IOSL D HD^PSNVCR2 Q:PSNCROUT
 I PSNFON W !
 I PSNFON,($Y+5)>IOSL D HD^PSNVCR2 Q:PSNCROUT
 I PSNFON W !,"PMI and Warning Label counts",!
 I PSNFON,($Y+5)>IOSL D HD^PSNVCR2 Q:PSNCROUT
 S PSNCRAT=0 F PSNCRA2=0:0 S PSNCRA2=$O(^PS(50.621,PSNCRA2)) Q:'PSNCRA2  I $G(^PS(50.621,PSNCRA2,0))'="" S PSNCRAT=PSNCRAT+1 I PSNCRDEV="C",PSNFON,PSNCRAT#500=0 W "."
 I PSNFON W !?5,"PMI-ENGLISH FILE (#50.621) - "_PSNCRAT_" records"
 I 'PSNFON W !,"PMI-ENGLISH FILE^"_PSNCRAT_"^0^0"
 ;
 I PSNFON,($Y+5)>IOSL D HD^PSNVCR2 Q:PSNCROUT
 S PSNCRAT=0 F PSNCRA2=0:0 S PSNCRA2=$O(^PS(50.622,PSNCRA2)) Q:'PSNCRA2  I $G(^PS(50.622,PSNCRA2,0))'="" S PSNCRAT=PSNCRAT+1 I PSNCRDEV="C",PSNFON,PSNCRAT#500=0 W "."
 I PSNFON W !!?5,"PMI-SPANISH FILE (#50.622) - "_PSNCRAT_" records"
 I 'PSNFON W !,"PMI-SPANISH FILE^"_PSNCRAT_"^0^0"
 ;
 I PSNFON,($Y+5)>IOSL D HD^PSNVCR2 Q:PSNCROUT
 S PSNCRAT=0 F PSNCRA2=0:0 S PSNCRA2=$O(^PS(50.623,PSNCRA2)) Q:'PSNCRA2  I $G(^PS(50.623,PSNCRA2,0))'="" S PSNCRAT=PSNCRAT+1 I PSNCRDEV="C",PSNFON,PSNCRAT#500=0 W "."
 I PSNFON W !!?5,"PMI MAP-ENGLISH FILE (#50.623) - "_PSNCRAT_" records"
 I 'PSNFON W !,"PMI MAP-ENGLISH FILE^"_PSNCRAT_"^0^0"
 ;
 I PSNFON,($Y+5)>IOSL D HD^PSNVCR2 Q:PSNCROUT
 S PSNCRAT=0 F PSNCRA2=0:0 S PSNCRA2=$O(^PS(50.624,PSNCRA2)) Q:'PSNCRA2  I $G(^PS(50.624,PSNCRA2,0))'="" S PSNCRAT=PSNCRAT+1 I PSNCRDEV="C",PSNFON,PSNCRAT#500=0 W "."
 I PSNFON W !!?5,"PMI MAP-SPANISH FILE (#50.624) - "_PSNCRAT_" records"
 I 'PSNFON W !,"PMI MAP-SPANISH FILE^"_PSNCRAT_"^0^0"
 I PSNFON,($Y+5)>IOSL D HD^PSNVCR2
 ;
 Q
