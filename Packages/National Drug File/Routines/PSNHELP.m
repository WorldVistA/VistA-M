PSNHELP ;BIR/CCH&WRT-Help text routine ;08/21/98 14:25
 ;;4.0; NATIONAL DRUG FILE;**60,84,93**; 30 Oct 98
 ;IA 2352 - ^PSDRUG(
 ;IA 2613 - ^PS(59.7
 ;IA 3621 - DRG^PSSHUIDG(DA)
 ;IA 4394 - DRG^PSSDGUPD(DA)  V.2.4 dispensing machines
 ;IA 1976 - ^PS(59
TRD1 ; TRADE NAME 
 W !!,"Enter number of one of the trade names displayed"
 W !,"Or press return to view more" D UPAR Q
TR2 ; TRADE NAME 
 W !!,"Enter number of one of the trade names displayed",!,"If none of them match, press return to proceed"
 W !,"to next step in matching process" D UPAR K ANS Q
UPAR W !,"or enter ""^"" to exit",! Q
NDC1 ; NDC CODE 
 W !!,"Enter NDC Code for drug from your drug file",!,"Format should be MANUFACTURER'S CODE""-""PRODUCT CODE""-""PACKAGE CODE",!,"(i.e. 9999-999-99)" D UPAR K ANS Q
NDC2 ; NDC CODE 
 W !!,"Enter number of one of the drugs displayed or press",!,"return to view more.",!,"You may enter ""^NDC"" to skip this step and go directly to the",!,"""enter NDC Code <WITH DASHES>:"" prompt" D UPAR K ANS Q
NDC3 ; NDC CODE 
 W !!,"Enter number of one of the drugs displayed",!,"If none of them match, press return to proceed"
 W !,"to next step in matching process" D UPAR Q
HIT1 ;  FOR MATCH PROMPT
 W !!,"The drugs displayed are ""matches"" found in the National",!,"Drug File" D NDC2 Q
RES1 ;  FOR RESP PROMPT
 W !!,"If the drug from the National Drug File matches the drug ",!," from your drug file enter ""Y""",!,"If an incorrect response was entered, respond ""N"""
 W !," or press return to proceed to next step in matching process" D UPAR Q
TYP1 ;  FOR PKG TYPE
 W !!,"Enter Package Type which matches the Package Type of the drug",!,"in your drug file" D UPAR Q
SZ1 ;  FOR PKG SIZE
 W !!,"Enter Package Size matches the Package Size",!,"of the drug in your drug file",!,"If none of them match, enter ""NONE""" D UPAR Q
MRG1 ;  FOR MERGE OPTION
 ; W !!,"This routine will merge the following data from the National Drug File",!,"into your local drug file:  ",!,"(1) PTR TO NDF",!,"(2) VA PRODUCT NAME FROM NDF",!,"(3) PTR TO NDF VA PRODUCT NAME"
 ; W !,"(4) PTR TO PACKAGE SIZE IN NDF",!,"(5) PTR TO PACKAGE TYPE IN NDF AND",!,"(6) NEW VA DRUG CLASSIFICATION." K ANS G RESP^PSNMRG Q
ASK1 ;  FOR MATCH PROMPT
 W !!,"If drugs match, enter ""Y"" for YES",!,"If you would like to rematch drug, enter ""N"" for NO",!,"If no match is possible, press return and the drug will remain unmatched"
 W:'$D(Z9) !,"and next drug in your drug file will be displayed" D UPAR Q
REMTCH ; REMATCH PROMPT
 W:$P(^PSDRUG(+Y,"ND"),"^",2)]"" !!,"This drug has already been matched and classified with the",!,"National Drug File."
 I $D(^PSDRUG(+Y,3)) W:$P(^PSDRUG(+Y,3),"^",1)=1 !,"This drug has also been marked to transmit to CMOP.",!,"If you choose to rematch it, the drug will be marked NOT TO TRANSMIT to CMOP.",!
 W:$P(^PSDRUG(+Y,"ND"),"^",2)']"" !!,"This drug has been manually classed but not matched (merged with NDF)."
 R !,"Do you wish to match/rematch it? N// ",ANS:DTIME S:'$T ANS="^" S:ANS']"" ANS="N" I ANS="^" S PSNFL=1 Q
 I ANS?.E1C.E G REMTCH
 I "?"[$E(ANS) W !!,"Answer ""Yy"" to rematch this drug.",!,"Answer ""Nn"" or ""^"" or press <RET> to quit." K ANS G REMTCH
 I "NnYy"'[$E(ANS)!(ANS="") W !,"ANSWER MUST BE YES OR NO" K ANS G REMTCH
 I "Yy"'[$E(ANS) K ANS G START^PSNDRUG
 K ANS S:$D(^PSDRUG(+Y,"ND")) PSNID=$P(^PSDRUG(+Y,"ND"),"^",10) D SETNULL^PSNHELP1  S:$D(^PSDRUG(+Y,3)) $P(^PSDRUG(+Y,3),"^",1)=0 K:$D(^PSDRUG("AQ",+Y)) ^PSDRUG("AQ",+Y) K:PSNID]"" ^PSDRUG("AQ1",PSNID,+Y) S DA=+Y K PSNID
 I $$PATCH^XPDUTL("PSS*1.0*57") D DRG^PSSHUIDG(DA)
 N XX,DNSNAM,DNSPORT,DVER,DMFU S XX=""
 F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D
 .S DVER=$$GET1^DIQ(59,XX_",",105,"I"),DMFU=$$GET1^DIQ(59,XX_",",105.2)
 .I DVER="2.4" S DNSNAM=$$GET1^DIQ(59,XX_",",2006),DNSPORT=$$GET1^DIQ(59,XX_",",2007) I DNSNAM'=""&(DMFU="YES") D DRG^PSSDGUPD(DA,"",DNSNAM,DNSPORT)
 S X="PSXREF" X ^%ZOSF("TEST") D:$T ^PSXREF K DA G MATCH^PSNDRUG Q
BLD1 ; WHERE TO BEGIN MATCHING
 W !!,"If you wish to begin matching process from beginning of your local drug file,",!,"enter ""B"". This will allow you to match drugs which may have been re-activated."
 W !,"Press return to continue with next drug following the one last matched" D UPAR K ANS Q
ING ; INGREDIENTS
 R !!,"Display ingredients for this NDF drug? N//",ANS:DTIME S:'$T ANS="^" I ANS["^" S PSNFL=1 Q
 I ANS?.E1C.E G ING
 I ANS["?" D ING1 G ING
 I ANS']""!"nN"[ANS S ANS="N" Q
 ; S D0=PSNNDF,Y=$P(^PSNDF(D0,5,PSNFNM,1),"^",1)
 D INGRED^PSNOUT
 ; I $D(^PSNDF(D0,5,PSNFNM,3)) S Y=$P(^PSNDF(D0,5,PSNFNM,3),"^",1) D INGRED^PSNOUT
 ; I $D(^PSNDF(D0,5,PSNFNM,4)) S Y=$P(^PSNDF(D0,5,PSNFNM,4),"^",1) D INGRED^PSNOUT
 Q
ING1 W !!,"Displays ingredients (including strengths and units)" D UPAR K ANS Q
RES2 ; MATCH PROMPT
 W !!,"If the drug from the National Drug File matches the drug",!," from your local file, respond ""Y""",!,"If it is not a match, respond ""N"""
 W:'$D(Z9) !,"If you want to pass to next drug and leave this drug unverified, press return" D UPAR K ANS Q
CR ; FORCES CONVERSION REMATCH OPTION
 I $P(^PS(59.7,1,10),"^",3)=0 W !!,"You must use the Conversion Rematch option first before using this option.",! Q
