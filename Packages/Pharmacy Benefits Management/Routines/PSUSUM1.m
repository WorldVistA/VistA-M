PSUSUM1 ;BIR/DAM - Summary Report for Provider Extract ; 2/23/07 2:18pm
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;**12**;MARCH, 2005;Build 19
 ;
 ; No DBIA's required.
 ;
EN ;EN CALLED FROM ^PSUDEM4
 ;
 D PULL^PSUCP
 D DATE
 D PRSUM^PSUDEM5     ;Mail message
 Q
 ;
DATE ;Convert dates to external format
 ;
 S %H=$E($H,1,5)      ;today's date
 D YX^%DTC
 N PSUD S PSUD=Y
 ;
 S Y=PSUSDT           ;Start date of extract
 D DD^%DT
 N PSUS S PSUS=Y
 ;
 S Y=PSUEDT           ;End date of extract
 D DD^%DT
 N PSUE S PSUE=Y
 ;
 D SUMM
 Q
 ;
SUMM ;Compose summary mail message by placing all text into a 
 ;temporary global, designated ^XTMP("PSU_"_PSUJOB,"PSUSUM",
 ;
 ;
 ;Report header
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUPROV")) D  Q
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUM",1)="No data to report"
 S ^XTMP("PSU_"_PSUJOB,"PSUSUM",1)="Provider Summary Report                                         "_PSUD
 S ^XTMP("PSU_"_PSUJOB,"PSUSUM",2)=""                          ;Blank line
 S ^XTMP("PSU_"_PSUJOB,"PSUSUM",3)="                 "_PSUS_"  through  "_PSUE
 S ^XTMP("PSU_"_PSUJOB,"PSUSUM",4)=""
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUM",5),"-",80)=""              ;Separator Bar
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUM",7),"-",80)=""
 S ^XTMP("PSU_"_PSUJOB,"PSUSUM",8)=""
 S ^XTMP("PSU_"_PSUJOB,"PSUSUM",9)="IEN        Provider Name (SSN)                        Missing Data"
 S $P(^XTMP("PSU_"_PSUJOB,"PSUSUM",10),"-",80)=""
 D PROV
 ;
 Q
 ;
PROV ;Gather missing provider data for summary report
 ;
 N PSUSSN3,PSUMIS,PSUCL,PSUSS,PSUSP,PSUSUB,PSULN,PSUM
 S PSUM=0
 S PSULN=11
 S PSUIP=0
 F  S PSUIP=$O(^XTMP("PSU_"_PSUJOB,"PSUPROV",PSUIP)) Q:PSUIP=""  Q:PSUIP["U"  D
 .I $P($G(^VA(200,PSUIP,"PS")),"^",6)=4 Q  ; Exclude if the provider type is "FEE BASIS" (PSU*4*12)
 .S PSUSSN3=$E($P($G(^XTMP("PSU_"_PSUJOB,"PSUPROV",PSUIP)),U,3),6,9)
 .I PSUSSN3="" S PSUSSN3="????",PSUMIS="SSN" D NAM             ;No SSN
 .S PSUCL=$P($G(^XTMP("PSU_"_PSUJOB,"PSUPROV",PSUIP)),U,5)
 .I PSUCL="" S PSUMIS="PROVIDER CLASS" D NAM   ;No Class
 .S PSUSS=$P($G(^XTMP("PSU_"_PSUJOB,"PSUPROV",PSUIP)),U,6)
 .I PSUSS="" S PSUMIS="SERVICE/SECTION" D NAM  ;No Ser/Sec
 .S PSUSP=$P($G(^XTMP("PSU_"_PSUJOB,"PSUPROV",PSUIP)),U,7)
 .I PSUSP="" S PSUMIS="SPECIALTY" D NAM        ;No Spec
 .Q:PSUSP["Intern"    ;Omit interns from missing subspec. on report
 .Q:PSUSP["Resident"   ;Omit residents from missing subspc. on report
 .S PSUSUB=$P($G(^XTMP("PSU_"_PSUJOB,"PSUPROV",PSUIP)),U,8)
 .I PSUSUB="" S PSUMIS="SUBSPECIALTY" D NAM    ;No Subsp
 Q
 ;
NAM ;Get Provider name and create entry line in summary report
 ;
 N PSUNAM,PSUT1,PSUT2,PSUT3,PSUT4,S1,S2,S3
 N PSUT5,PSUT6,PSUT7,PSUT8,PSUT9,PSUT10
 ;
 S PSUT4=" "
 S PSUT1=11
 S PSUT2=PSUT1-$L(PSUIP)
 F S1=1:1:(PSUT2-1) S PSUT3(S1)=" " D
 .S PSUT4=PSUT4_PSUT3(S1)       ;First tab position
 ;
 S PSUNAM=$P($G(^XTMP("PSU_"_PSUJOB,"PSUPROV",PSUIP)),U,9)
 ;
 S PSUT5=" "
 S PSUT6=54
 S PSUT7=(PSUT6-$L(PSUNAM)-7-$L(PSUT4)-$L(PSUIP))
 F S2=1:1:(PSUT7-1) S PSUT8(S2)=" " D
 .S PSUT5=PSUT5_PSUT8(S2)        ;Second tab position
 ;
 S PSUT10=" "
 F S3=1:1:(PSUT6-1) S PSUT9(S3)=" " D
 .S PSUT10=PSUT10_PSUT9(S3)      ;Third tab position
 ;
 ;
 ;I '$D(^XTMP("PSU_"_PSUJOB,"PSUSUM",PSULN)) D
 S ^XTMP("PSU_"_PSUJOB,"PSUSUM",PSULN)=PSUIP_PSUT4_PSUNAM_" ("_PSUSSN3_")"_PSUT5_PSUMIS
 F I=1:1:5 I $P($G(^XTMP("PSU_"_PSUJOB,"PSUSUM",PSULN-I)),U,1)[PSUNAM D
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUM",PSULN)=PSUT10_PSUMIS
 ;
 I $P($G(^XTMP("PSU_"_PSUJOB,"PSUSUM",PSULN)),U,1)[PSUNAM D
 .S PSUM=PSUM+1       ;Set a counter for number of patients accessed
 .S ^XTMP("PSU_"_PSUJOB,"PSUSUM",6)="Total Number of Incomplete Provider Records Extracted: "_PSUM
 S PSULN=PSULN+1
 ;
 Q
