PXRMG2M1 ;SLC/JVS -GEC #2 MAIL MESSAGES ;7/14/05  08:12
 ;;2.0;CLINICAL REMINDERS;**2,4**;Feb 04, 2005;Build 21
 Q
 ;=================================================
TASK ;Start queued option PXRM GEC QUARTERLY ROLLUP
 Q:'$D(DT)
 D CALCMON
 D EN^PXRMG2E2
 D MAIL
 Q
START ;Start queued option PXRM GEC QUARTERLY ROLLUP
 Q:'$D(DT)
 D CALC
 D EN^PXRMG2E2
 D MAIL
 Q
MAIL ;MAIL OUT the STAT array
 N SITE,XMZ,XMY,XMSUB,XMDUZ,SITE2
 S XMSUB="GEC FISCAL QUARTER "_FQUARTER_" "_YEAR_" Rollup Data"
 I DT<3050401 S XMSUB="TEST DATA-- "_XMSUB
 S SITE=$P($$SITE^VASITE,"^",2)_" #"_$P($$SITE^VASITE,"^",3)
 S SITE2=$P($$SITE^VASITE,"^",3)_" "_$P($$SITE^VASITE,"^",2)
 S XMDUZ=SITE2_" GEC Rollup Data"
RETRY D XMZ^XMA2
 I XMZ<1 G RETRY
 ;
 N PROG,MON,L,LINE,MGIEN,MGROUP
 S L=0
 S PROG="AD" F  S PROG=$O(STAT(PROG)) Q:PROG=""  D
 .S MON=0 F  S MON=$O(STAT(PROG,MON)) Q:MON=""  D
 ..S L=L+1
 ..S ^XMB(3.9,XMZ,2,L,0)=$G(STAT(PROG,MON))
 ;
 I L>10 D
 .F I=(L+1):1:14 S ^XMB(3.9,XMZ,2,I,0)=$P($T(TEXT+(I-12)),";",3)
 .S ^XMB(3.9,XMZ,2,15,0)="data from "_SITE_" for Fiscal Quarter # "_FQUARTER_" of "_YEAR_". (Calendar Quarter "_QUARTER_")"
 .S L=15 F I=(L+1):1:55 S ^XMB(3.9,XMZ,2,I,0)=$P($T(TEXT+(I-12)),";",3)
 .;
 .S ^XMB(3.9,XMZ,2,0)="^3.92^"_I_"^"_I_"^"_DT
 .S XMDUZ="GEC Project"
 .I $$PROD^XUPROD(1) S XMY("G.GEC2 NATIONAL ROLLUP")=""
 .S MGIEN=$G(^PXRM(800,1,"MGFE"))
 .I MGIEN'="" D
 ..S MGROUP="G."_$$GET1^DIQ(3.8,MGIEN,.01)
 ..S XMY(MGROUP)=""
 .D ENT1^XMD
 .D EXIT
 Q
TEXT ;Text added to the bottom of the mail message
 ;13;
 ;14;   The above information is Geriatric Extended Care "Home" Referral
 ;15;
 ;16;-------------------------------------------------
 ;17;   Each section of data is separated by a comma. The table below
 ;18;defines the sections. Numbers represent Patients. Patient only counted once.
 ;19;
 ;20;  1 Number for the site.
 ;21;  2 Number that stands for the Month (1=January)...
 ;22;  3 Acronym for the Program (ADHC,HHHA,VAIHR,CC)
 ;23;  4 Total number of patients referred to the program that month
 ;24;  5 Number that DID NOT MEET ANY of the criteria
 ;25;  6 Number that only met criteria 1
 ;26;  7 Number that only met criteria 2
 ;27;  8 Number that only met criteria 3
 ;28;  9 Number that only met criteria 4
 ;29; 10 Number that only met both criteria's 1 and 2
 ;30; 11 Number that only met both criteria's 1 and 3
 ;31; 12 Number that only met both criteria's 1 and 4
 ;32; 13 Number that only met both criteria's 2 and 3
 ;34; 14 Number that only met both criteria's 2 and 4
 ;35; 15 Number that only met both criteria's 3 and 4
 ;36; 16 Number that only met the criteria's 1 and 2 and 3
 ;37; 17 Number that only met the criteria's 1 and 2 and 4
 ;38; 18 Number that only met the criteria's 1 and 3 and 4
 ;39; 19 Number that only met the criteria's 2 and 3 and 4
 ;40; 20 Number that met all criteria's 1 and 2 and 3 and 4
 ;41;
 ;42;--------------------------------------------------
 ;43;The Basic Criteria for Eligibility is shown below.
 ;44;
 ;45; 1: Problems with 3 or more ADL's.
 ;46; 2: 1 or more patient behavior or cognitive problem.
 ;47; 3: Expected life limit of less than 6 months.
 ;48; 4: Combination of the following:
 ;49;      2 or more ADL dependencies.
 ;50;      <AND> 2 or more of the following:
 ;51;            problems with 3 or more IADL's.
 ;52;      <OR> age of patients is 75 or more.
 ;53;      <OR> living alone in the community.
 ;54;      <OR> utilizes the clinics 12 or more times in the
 ;55;           preceding 12 months.
 ;============================================
EXIT ;Exit and Clean up Variables
 K ^TMP("PXRMGEC",$J)
 Q
CALC ;Calculate the quarter number
 N MON,YER,CQTR,BCQTR,BQTR,BYER,FQTR
 S MON=+$E(DT,4,5),YER=1700+$E(DT,1,3)
 ;
 I MON=1!(MON=2)!(MON=3) S CQTR=1
 I MON=4!(MON=5)!(MON=6) S CQTR=2
 I MON=7!(MON=8)!(MON=9) S CQTR=3
 I MON=10!(MON=11)!(MON=12) S CQTR=4
 ;
 I CQTR=1 S BYER=YER-1
 E  S BYER=YER
 I CQTR=1 S BQTR=4
 E  S BQTR=CQTR-1
 ;
 I BQTR=1 S FQTR=2
 I BQTR=2 S FQTR=3
 I BQTR=3 S FQTR=4
 I BQTR=4 S FQTR=1
 S QUARTER=BQTR,FQUARTER=FQTR,YEAR=BYER,DFNONLY=0
 ;After april 1 2005 no test patients
 S TPAT=0
 Q
 ;
CALCMON ;Calculate the quarter number for current quarter
 N MON,YER,CQTR,BQTR,BCQTR,BYER,FQTR
 S MON=+$E(DT,4,5),YER=1700+$E(DT,1,3)
 ;
 I MON=1!(MON=2)!(MON=3) S CQTR=1
 I MON=4!(MON=5)!(MON=6) S CQTR=2
 I MON=7!(MON=8)!(MON=9) S CQTR=3
 I MON=10!(MON=11)!(MON=12) S CQTR=4
 ;
 S BYER=YER
 S BQTR=CQTR
 ;
 I BQTR=1 S FQTR=2
 I BQTR=2 S FQTR=3
 I BQTR=3 S FQTR=4
 I BQTR=4 S FQTR=1
 ;
 S QUARTER=BQTR,FQUARTER=FQTR,YEAR=BYER,DFNONLY=0
 ;After april 1 2005 no test patients
 S TPAT=0
 S ZTREQ="@"
 ;
 Q
 ;
POST ;Post installation routine
 ;add remote members to mail group
 D ADDMBRS^XMXAPIG(DUZ,"GEC2 NATIONAL ROLLUP","VAUGHN.SMITH@MED.VA.GOV")
 D ADDMBRS^XMXAPIG(DUZ,"GEC2 NATIONAL ROLLUP","patrick.brady@e2k.hq.med.va.gov")
 D ADDMBRS^XMXAPIG(DUZ,"GEC2 NATIONAL ROLLUP","daniel.schoeps@e2k.hq.med.va.gov")
 ;
TASKRPT ;This will task a monthy report for 4 month.
 ;May 8th 2005,June 8th 2005,AUG 8th 2005,Sept 8th 2005
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,MON,ZTREQ,ZTSK
 S MON=0
 Q:$D(^TMP("PXRMG2TSK"))
 F ZTDTH="3050508.0200","3050608.0200","3050808.0200","3050908.0200" D
 .S MON=MON+1
 .I MON=1 S MONTH="MAY"
 .I MON=2 S MONTH="JUNE"
 .I MON=3 S MONTH="AUGUST"
 .I MON=4 S MONTH="SEPT"
 .S ZTRTN="TASK^PXRMG2M1"
 .S ZTDESC=MONTH_" 2005 GEC National Report"
 .S ZTIO=""
 .D ^%ZTLOAD
 .D BMES^XPDUTL(MONTH_" 8th's GEC Tasked Job number "_ZTSK)
 S ^TMP("PXRMG2TSK",$J)="DT"
CLEAN ;Clean up after previous builds
 K ^PXRMD(801.5,"ATASK")
 Q
