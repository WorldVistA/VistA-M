PSUDEM7 ;BIR/DAM - Inpatient PTF Record Extract ;20 DEC 2001
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA's
 ; Reference to file 2    supported by DBIA 10035
 ; Reference to file 4.3  supported by DBIA 2496
 ; Reference to file 45   supported by DBIA 3511
 ;
EN ;EN
 D DAT
 D EN^PSUDEM8    ;Gather ICD9 codes
 I '$D(^XTMP("PSU_"_PSUJOB,"PSUIPV")) D NODATA
 D XMD
 K ^XTMP("PSU_"_PSUJOB,"PSUIPV")
 K ^XTMP("PSU_"_PSUJOB,"PSUXMD")
 Q
 ;
DAT ;Find discharge dates that fall within the extract date range
 ;as well as discharge dates within the 30 days prior to day 1 of
 ;of the extract date range.
 ;
 S PSUDD=0
 F  S PSUDD=$O(^DGPT("ADS",PSUDD)) Q:'PSUDD  D
 .S PSUDDT=$E(PSUDD,1,7)
 .S X1=PSUSDT
 .S X2=(-30)
 .D C^%DTC
 .S PSUSDT1=X              ;Date 30 days prior to start date
 .I (PSUDDT>PSUSDT1)!(PSUDDT=PSUSDT1)&(PSUDDT<PSUEDT)!(PSUDDT=PSUEDT) D
 ..S ^XTMP("PSU_"_PSUJOB,"PSUDM",PSUDDT)=""
 ..S PSUIEN=0
 ..F  S PSUIEN=$O(^DGPT("ADS",PSUDD,PSUIEN)) Q:'PSUIEN  D
 ...S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUIEN),U,5)=PSUDDT        ;Discharge Date
 ...N PSUDT
 ...S PSUDT=$P($G(^DGPT(PSUIEN,0)),U,2)
 ...S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUIEN),U,4)=$E(PSUDT,1,7)  ;Admit date
 ...D INST^PSUDEM1
 ...S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUIEN),U,2)=PSUSIT         ;SITE
 ...S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUIEN),U,3)=PSUSIT_PSUIEN  ;Unique PTF ID
 ...D SSNICN
 Q
 ;
SSNICN ;Find patient Admission date, SSN and ICN for inpatient record
 ;VMP - OIFO BAY PINES;ELR;PSU*3.0*24
 ;
 N PSUPT,PSUICN,PSUICN1
 S PSUPT=$P($G(^DGPT(PSUIEN,0)),U)     ;Pointer to patient file
 ;
 N PSUREC
 I PSUPT D
 .S PSUREC=$P($G(^DPT(PSUPT,0)),U,9) D REC D
 ..S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUIEN),U,6)=PSUREC     ;Pt SSN
 .S PSUICN=$$GETICN^MPIF001(PSUPT) D
 ..I PSUICN'[-1 D
 ...S $P(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUIEN),U,7)=PSUICN   ;ICN
 Q
 ;
REC ;If "^" is contained in any record, replace it with (')
 ;
 I PSUREC["^" S PSUREC=$TR(PSUREC,"^","'")
 Q
 ;
NODATA ;Generate a 'No Data' message if there is no data in the extract
 ;
 S NONE=1
 M PSUXMYH=PSUXMYS1
 S PSUM=1
 S ^XTMP("PSU_"_PSUJOB,"PSUXMD",PSUM,1)="No data to report"
 Q
 ;
XMD ;Format mailman message and send.
 ;
 S PSUAB=0,PSUPL=1
 F  S PSUAB=$O(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUAB)) Q:PSUAB=""  D
 .M ^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUPL)=^XTMP("PSU_"_PSUJOB,"PSUIPV",PSUAB)  ;Global numerical order
 .S PSUPL=PSUPL+1
 ;
 NEW PSUMAX,PSULC,PSUTMC,PSUTLC,PSUMC
 S PSUMAX=$$VAL^PSUTL(4.3,1,8.3)
 S PSUMAX=$S(PSUMAX="":10000,PSUMAX>10000:10000,1:PSUMAX)
 S PSUMC=1,PSUMLC=0
 F PSULC=1:1 S X=$G(^XTMP("PSU_"_PSUJOB,"PSUIPV",PSULC)) Q:X=""  D
 .S PSUMLC=PSUMLC+1
 .I PSUMLC>PSUMAX S PSUMC=PSUMC+1,PSUMLC=0,PSULC=PSULC-1 Q  ; +  message
 .I $L(X)<235 S ^XTMP("PSU_"_PSUJOB,"PSUXMD",PSUMC,PSUMLC)=X Q
 .F I=235:-1:1 S Z=$E(X,I) Q:Z="^"
 .S ^XTMP("PSU_"_PSUJOB,"PSUXMD",PSUMC,PSUMLC)=$E(X,1,I)
 .S PSUMLC=PSUMLC+1
 .S ^XTMP("PSU_"_PSUJOB,"PSUXMD",PSUMC,PSUMLC)="*"_$E(X,I+1,999)
 ;
 ;   Count Lines sent
 S PSUTLC=0
 F PSUM=1:1:PSUMC S X=$O(^XTMP("PSU_"_PSUJOB,"PSUXMD",PSUM,""),-1),PSUTLC=PSUTLC+X
 ;
 F PSUM=1:1:PSUMC D PTF^PSUDEM5
 D CONF
 Q
CONF ;Construct globals for confirmation message
 ;
 ;D INST^PSUDEM1
 I $G(NONE) S PSUTLC=0
 N PSUDIVIS
 ;S PSUDIVIS=$P(^XTMP("PSU_"_PSUJOB,"PSUSITE"),U,1)
 S PSUDIVIS=PSUSNDR
 S PSUSUB="PSU_"_PSUJOB
 S ^XTMP(PSUSUB,"CONFIRM",PSUDIVIS,9,"M")=PSUMC
 S ^XTMP(PSUSUB,"CONFIRM",PSUDIVIS,9,"L")=PSUTLC
 Q
