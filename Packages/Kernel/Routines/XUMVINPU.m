XUMVINPU ;MVI/DRI - Master Veteran Index New Person Utilities ;7/31/20  15:04
 ;;8.0;KERNEL;**691,711,710,732,733**;Jul 10, 1995;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;**711, Story  977780 (jfw)
 ;**732, Story 1204309 (mko)
 ;**733, Story 1291666 (dri)
 ;
GET(XURET,XUDUZ,SECID,NPI,SSN) ;rpc to retrieve new person file data
 ; called from rpc: XUS MVI NEW PERSON GET
 ; Input (ONE of the following):
 ;  XUDUZ = NEW PERSON IEN    SECID=SECURITY ID   NPI=NATIONAL PROVIDER IDENTIFIER    SSN=SOCIAL SECURITY NUMBER
 ; Output:
 ;  Success: XURET = ^TMP("XUMVINPU",$J)
 ;    @XURET@(#) = FILE #;FIELD #<;SUBFIELD #><;FILE POINTER>^FIELD NAME^<COUNTER #>^INTERNAL VALUE^EXTERNAL VALUE
 ;      <> Denotes optional values. If Counter populated, denotes multiple value <1-n>.
 ;    @XURET@(#)="200;IEN^DUZ^^^"
 ;    @XURET@(#)="200;.01^NAME^^^"
 ;    @XURET@(#)="200;4^SEX^^^"
 ;    @XURET@(#)="200;5^DOB^^^" ;**732,1204309 (mko): Return DOB
 ;    @XURET@(#)="200;8^TITLE^^^"
 ;    @XURET@(#)="200;7^DISUSER^^^"
 ;    @XURET@(#)="200;9.2^TERMINATION DATE^^^"
 ;    @XURET@(#)="200;9.4^Termination Reason^^^"
 ;    @XURET@(#)="200;15^PROHIBITED TIMES FOR SIGN-ON^^^"
 ;    @XURET@(#)="200;11.2^DATE VERIFY CODE LAST CHANGED^^^"
 ;    @XURET@(#)="200;.111^STREET ADDRESS 1^^^"
 ;    @XURET@(#)="200;.112^STREET ADDRESS 2^^^"
 ;    @XURET@(#)="200;.113^STREET ADDRESS 3^^^"
 ;    @XURET@(#)="200;.114^CITY^^^"
 ;    @XURET@(#)="200;.115^STATE^^^"
 ;    @XURET@(#)="200;.116^ZIP CODE^^^"
 ;    @XURET@(#)="200;.132^OFFICE PHONE^^^"
 ;    @XURET@(#)="200;.136^FAX NUMBER^^^"
 ;    @XURET@(#)="200;.151^EMAIL ADDRESS^^^"
 ;    @XURET@(#)="200;30^DATE ENTERED^^^"
 ;    @XURET@(#)="200;31^CREATOR^^^"
 ;    @XURET@(#)="200;41.98^NPI ENTRY STATUS^^"
 ;    @XURET@(#)="200;41.99^NPI^^^"
 ;    @XURET@(#)="200;9^SSN^^^"
 ;    @XURET@(#)="200;42;.01^EFFECTIVE DATE/TIME^<#>^^"
 ;    @XURET@(#)="200;42;.02^STATUS^<#>^^"
 ;    @XURET@(#)="200;42;.03^NPI^<#>^^"
 ;    @XURET@(#)="200;101.13;.01^CPRS TAB^<#>^^"
 ;    @XURET@(#)="200;101.13;.02^EFFECTIVE DATE^<#>^^"
 ;    @XURET@(#)="200;101.13;.03^EXPIRATION DATE^<#>^^"
 ;    @XURET@(#)="200;202^LAST SIGN-ON DATE/TIME^^^"
 ;    @XURET@(#)="200;202.02^XUS Logon Attempt Count^^^"
 ;    @XURET@(#)="200;202.03^XUS Active User^^^"
 ;    @XURET@(#)="200;202.04^Entry Last Edit Date^^^"
 ;    @XURET@(#)="200;202.05^LOCKOUT USER UNTIL^^^"
 ;    @XURET@(#)="200;16;.01^DIVISION^<1-n>^^"
 ;    @XURET@(#)="200;10.1^NAME COMPONENTS^^^"
 ;    @XURET@(#)="20;1^FAMILY (LAST) NAME^^^"
 ;    @XURET@(#)="20;2^GIVEN (FIRST) NAME^^^"
 ;    @XURET@(#)="20;3^MIDDLE NAME^^^"
 ;    @XURET@(#)="20;4^PREFIX^^^"
 ;    @XURET@(#)="20;5^SUFFIX^^^"
 ;    @XURET@(#)="20;6^DEGREE^^^"
 ;    @XURET@(#)="200;29^SERVICE/SECTION^^^"
 ;    @XURET@(#)="200;201^PRIMARY MENU OPTION^^^"
 ;    @XURET@(#)="200;203;.01^SECONDARY MENU OPTIONS^<1-n>^^"
 ;    @XURET@(#)="200;51;.01^KEYS^<1-n>^^"
 ;    @XURET@(#)="200;205.1^SECID^^^"
 ;    @XURET@(#)="200;205.2^SUBJECT ORGANIZATION^^^"
 ;    @XURET@(#)="200;205.3^SUBJECT ORGANIZATION ID^^^"
 ;    @XURET@(#)="200;205.4^UNIQUE USER ID^^^"
 ;    @XURET@(#)="200;205.5^ADUPN^^^"
 ;    @XURET@(#)="200;501.1^NETWORK USERNAME^^^"
 ;    @XURET@(#)="200;8932.1;.01^PERSON CLASS^<1-n>^^"
 ;    @XURET@(#)="200;8932.1;2^EFFECTIVE DATE^<#>^^"
 ;    @XURET@(#)="200;8932.1;3^EXPIRATION DATE^<#>^^"
 ;    @XURET@(#)="200;53.1^AUTHORIZED TO WRITE MED ORDERS^^^"
 ;    @XURET@(#)="200;53.11^DETOX/MAINTENANCE ID NUMBER^^^"
 ;    @XURET@(#)="200;53.2^DEA#^^^"
 ;    @XURET@(#)="200;747.44^DEA EXPIRATION DATE^^^"
 ;    @XURET@(#)="200;53.4^INACTIVE DATE^^^"
 ;    @XURET@(#)="200;53.5^PROVIDER CLASS^^^"
 ;    @XURET@(#)="200;53.6^PROVIDER TYPE^^^"
 ;    @XURET@(#)="200;53.9^REMARKS^^^"
 ;    @XURET@(#)="200;53.91^NON-VA PRESCRIBER^^^"
 ;    @XURET@(#)="200;53.92^TAX ID^^^"
 ;    @XURET@(#)="200;55.1^SCHEDULE II NARCOTIC^^^"
 ;    @XURET@(#)="200;55.2^SCHEDULE II NON-NARCOTIC^^^"
 ;    @XURET@(#)="200;55.3^SCHEDULE III NARCOTIC^^^"
 ;    @XURET@(#)="200;55.4^SCHEDULE III NON-NARCOTIC^^^"
 ;    @XURET@(#)="200;55.5^SCHEDULE IV^^^"
 ;    @XURET@(#)="200;55.6^SCHEDULE V^^^"
 ;
 ;    **The following are ONLY returned if patch
 ;    **XU*8.0*688 has been installed.
 ;    **Subscript Counter (#) will denote the DEA Data that belongs to the DEA NUMBER subscript
 ;    ** New DEA Data will always follow the DEA NUMBER entry!
 ;    @XURET@(#)="200;9001^DETOX CALCULATED^^^"
 ;    @XURET@(#)="200;53.21;.01;8991.9^DEA NUMBER^<1-n>^^"
 ;    @XURET@(#)="200;53.21;.02^INDIVIDUAL DEA SUFFIX^<#>^^"
 ;    **Only returned if there is a DEA NUMBER (200.5321) value!!**
 ;    @XURET@(#)="8991.9;.02^BUSINESS ACTIVITY CODE^<#>^^"
 ;    @XURET@(#)="8991.9;.03^DETOX NUMBER^<#>^^"
 ;    @XURET@(#)="8991.9;.04^EXPIRATION DATE^<#>^^"
 ;    @XURET@(#)="8991.9;.06^USE FOR INPATIENT ORDERS?^<#>^^"
 ;    @XURET@(#)="8991.9;.07^TYPE^<#>^^"
 ;    @XURET@(#)="8991.9;1.1^NAME (PROVIDER OR INSTITUTION)^<#>^^"
 ;    @XURET@(#)="8991.9;1.2^STREET ADDRESS 1^<#>^^"
 ;    @XURET@(#)="8991.9;1.3^STREET ADDRESS 2^<#>^^"
 ;    @XURET@(#)="8991.9;1.4^STREET ADDRESS 3^<#>^^"
 ;    @XURET@(#)="8991.9;1.5^CITY^<#>^^"
 ;    @XURET@(#)="8991.9;1.6^STATE^<#>^^"
 ;    @XURET@(#)="8991.9;1.7^ZIP CODE^<#>^^"
 ;    @XURET@(#)="8991.9;2.1^SCHEDULE II NARCOTIC?^<#>^^"
 ;    @XURET@(#)="8991.9;2.2^SCHEDULE II NON-NARCOTIC?^<#>^^"
 ;    @XURET@(#)="8991.9;2.3^SCHEDULE III NARCOTIC?^<#>^^"
 ;    @XURET@(#)="8991.9;2.4^SCHEDULE III NON-NARCOTIC?^<#>^^"
 ;    @XURET@(#)="8991.9;2.5^SCHEDULE IV?^<#>^^"
 ;    @XURET@(#)="8991.9;2.6^SCHEDULE V?^<#>^^"
 ;    @XURET@(#)="8991.9;10.1^LAST UPDATED BY^<#>^^"
 ;    @XURET@(#)="8991.9;10.2^LAST UPDATED DATE/TIME^<#>^^"
 ;    @XURET@(#)="8991.9;10.3^LAST DOJ UPDATE DATE/TIME^<#>^^"
 ;
 ;  Fail:
 ;   XURET = ^TMP("XUMVINPU",$J)
 ;   @XURET@(1)="-1^Invalid User"
 ;            or
 ;   @XURET@(1)="-1^No Data for User: ######"
 ;
 ; Example calling rpc from VistA:
 ;  >D GET^XUMVINPU(.XURET,12596)
 ;  >ZW XURET
 ;  >XURET="^TMP(""XUMVINPU"",17226)"
 ;
 ;  D ^%G would return:
 ;    ^TMP("XUMVINPU",17226,1)="200;IEN^DUZ^12596^12596"
 ;                          2)="200;.01^NAME^LAST,FIRST^LAST,FIRST"
 ;                          3)="200;7^DISUSER^^"
 ;                          #)=continuation of returned data
 ;
 ; Example calling rpc from MVI:
 ;  D DIRECT^XWB2HL7(.XURET,SITE,"XUS MVI NEW PERSON GET","",$G(XUDUZ),$G(SECID),$G(NPI),$G(SSN))
 ;
 N I,CNT,FILE,FLD,FLDS,FLDCNT,FLDNM,XUARR,XUGBL S XUGBL="^TMP("_"""XUMVINPU"""_","_$J_")",CNT=1,FILE=200 K @XUGBL,XURET
 I $G(SECID)'="" S XUDUZ=$O(^VA(FILE,"ASECID",SECID,0))
 I $G(NPI)'="" S XUDUZ=$O(^VA(FILE,"ANPI",NPI,0))
 I $G(SSN)'="" S XUDUZ=$O(^VA(FILE,"SSN",SSN,0))
 I $G(XUDUZ)="" S @XUGBL@(CNT)="-1^Invalid User" S XURET=$NA(@XUGBL) Q
 I '$D(^VA(FILE,XUDUZ)) S @XUGBL@(CNT)="-1^No Data for User: "_XUDUZ S XURET=$NA(@XUGBL) Q
 S @XUGBL@(CNT)=FILE_";IEN^DUZ^^"_XUDUZ_"^"_XUDUZ S CNT=CNT+1
 S FLDS=".01;4;5;8;7;9.2;9.4;15;11.2;.111;.112;.113;.114;.115;.116;.132;.136;.151;30;31;41.98;41.99;9;42*;101.13*;202;202.02;202.03;"
 S FLDS=FLDS_"202.04;202.05;16*;10.1;29;201;203*;51*;205.1;205.2;205.3;205.4;205.5;501.1;8932.1*;53.1;53.11;53.2;"
 S FLDS=FLDS_"747.44;53.4;53.5;53.6;53.9;53.91;53.92;55.1;55.2;55.3;55.4;55.5;55.6"
 S:($$PATCH^XPDUTL("XU*8.0*688")) FLDS=FLDS_";9001;53.21*"  ;NEW DETOX CALCULATED and DEA #'S multiple | DBIA #10141 (Supported)
 S FLDCNT=$L(FLDS,";") D GETS^DIQ(FILE,+XUDUZ_",",FLDS,"EI","XUARR") ;retrieve data
 F I=1:1:FLDCNT D
 .S FLD=$P($P(FLDS,";",I),"*") D FIELD^DID(FILE,FLD,"","LABEL","FLDNM")
 .I FLD=16 D  Q  ;division multiple
 ..N IENS,MCNT,SUBFILE,SUBFLD S MCNT=1,SUBFILE=200.02,SUBFLD=.01 D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ..I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^" S CNT=CNT+1 Q
 ..S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")) S MCNT=MCNT+1,CNT=CNT+1
 .I FLD=10.1 D  Q  ;name components
 ..S @XUGBL@(CNT)=FILE_";"_FLD_"^"_(FLDNM("LABEL"))_"^^"_$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_"^"_$G(XUARR(FILE,XUDUZ_",",FLD,"E")) S CNT=CNT+1
 ..N NCFILE,NCFLD S NCFILE=20 D GETS^DIQ(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",","1;2;3;4;5;6","EI","XUARR") ;retrieve name component data
 ..F NCFLD=1,2,3,4,5,6 D
 ...D FIELD^DID(NCFILE,NCFLD,"","LABEL","FLDNM")
 ...S @XUGBL@(CNT)=NCFILE_";"_NCFLD_"^"_(FLDNM("LABEL"))_"^^"_$G(XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"I"))_"^"_$G(XUARR(NCFILE,+$G(XUARR(FILE,XUDUZ_",",FLD,"I"))_",",NCFLD,"E")) S CNT=CNT+1
 .I FLD=42 D  Q  ;**732,Story 1204309 (mko): EFFECTIVE DATE/TIME (#42) (Multiple-200.042)
 ..N IENS,MCNT,SUBFILE,SUBFLD S MCNT=1,SUBFILE=200.042
 ..I '$D(XUARR(SUBFILE)) D  Q  ;No EFFECTIVE DATE/TIME
 ...F SUBFLD=.01,.02,.03 D
 ....D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM") S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_FLDNM("LABEL")_"^"_MCNT_"^^",CNT=CNT+1
 ..S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  D
 ...F SUBFLD=.01,.02,.03 D
 ....D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ....S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_FLDNM("LABEL")_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")),CNT=CNT+1
 ...S MCNT=MCNT+1
 .I FLD=51 D  Q  ;KEYS multiple
 ..N IENS,MCNT,SUBFILE,SUBFLD S MCNT=1,SUBFILE=200.051,SUBFLD=.01 D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ..I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^",CNT=CNT+1 Q
 ..S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")),MCNT=MCNT+1,CNT=CNT+1
 .I FLD=53.21 D  Q  ;NEW DEA #'s multiple
 ..N I,IEN,IENS,MCNT,SUBFILE,SUBFLD,DEAARR,DEAFILE,DEAFLD,DEAFLDS,DEAFLDCNT S MCNT=1,SUBFILE=200.5321,SUBFLD=.01,DEAFILE=8991.9
 ..D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ..I '$D(XUARR(SUBFILE)) D  Q
 ...S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_";8991.9^"_(FLDNM("LABEL"))_"^"_MCNT_"^^",CNT=CNT+1 D FIELD^DID(SUBFILE,.02,"","LABEL","FLDNM")
 ...S @XUGBL@(CNT)=FILE_";"_FLD_";"_.02_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^",CNT=CNT+1
 ..S DEAFLDS=".02;.03;.04;.06;.07;1.1;1.2;1.3;1.4;1.5;1.6;1.7;2.1;2.2;2.3;2.4;2.5;2.6;10.1;10.2;10.3",DEAFLDCNT=$L(DEAFLDS,";")
 ..S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  D
 ...S IEN=$G(XUARR(SUBFILE,IENS,.03,"I")) D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ...S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_";8991.9^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_IEN_"^"_$G(XUARR(SUBFILE,IENS,.03,"E")),CNT=CNT+1
 ...D FIELD^DID(SUBFILE,.02,"","LABEL","FLDNM")
 ...S @XUGBL@(CNT)=FILE_";"_FLD_";.02^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,.02,"I"))_"^"_$G(XUARR(SUBFILE,IENS,.02,"E")),CNT=CNT+1
 ...D GETS^DIQ(DEAFILE,IEN_",",DEAFLDS,"EI","DEAARR")  ;retrieve DEA data
 ...F I=1:1:DEAFLDCNT D
 ....S DEAFLD=$P(DEAFLDS,";",I) D FIELD^DID(DEAFILE,DEAFLD,"","LABEL","FLDNM")
 ....S @XUGBL@(CNT)=DEAFILE_";"_DEAFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(DEAARR(DEAFILE,IEN_",",DEAFLD,"I"))_"^"_$G(DEAARR(DEAFILE,IEN_",",DEAFLD,"E")),CNT=CNT+1
 ...S MCNT=MCNT+1
 .I FLD=101.13 D  Q  ;CPRS TAB multiple ;**733 - STORY 1291666 (dri) add field 101.13
 ..N IENS,MCNT,SUBFILE,SUBFLD S MCNT=1,SUBFILE=200.010113 I '$D(XUARR(SUBFILE)) D  Q  ;No CPRS TAB
 ...F SUBFLD=.01,.03,.03  D
 ....D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM") S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^",CNT=CNT+1
 ..S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  D
 ...F SUBFLD=.01,.02,.03  D
 ....D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ....S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")),CNT=CNT+1
 ...S MCNT=MCNT+1
 .I FLD=203 D  Q  ;secondary menu options multiple
 ..N IENS,MCNT,SUBFILE,SUBFLD S MCNT=1,SUBFILE=200.03,SUBFLD=.01 D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ..I '$D(XUARR(SUBFILE)) S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^" S CNT=CNT+1 Q
 ..S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")) S MCNT=MCNT+1,CNT=CNT+1
 .I FLD=8932.1 D  Q  ;PERSON CLASS multiple
 ..N IENS,MCNT,SUBFILE,SUBFLD S MCNT=1,SUBFILE=200.05 I '$D(XUARR(SUBFILE)) D  Q  ;No Person Class(es)
 ...F SUBFLD=.01,2,3  D
 ....D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM") S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^^",CNT=CNT+1
 ..S IENS="" F  S IENS=$O(XUARR(SUBFILE,IENS)) Q:IENS=""  D
 ...F SUBFLD=.01,2,3  D
 ....D FIELD^DID(SUBFILE,SUBFLD,"","LABEL","FLDNM")
 ....S @XUGBL@(CNT)=FILE_";"_FLD_";"_SUBFLD_"^"_(FLDNM("LABEL"))_"^"_MCNT_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"I"))_"^"_$G(XUARR(SUBFILE,IENS,SUBFLD,"E")),CNT=CNT+1
 ...S MCNT=MCNT+1
 .S @XUGBL@(CNT)=FILE_";"_FLD_"^"_(FLDNM("LABEL"))_"^^"_XUARR(FILE,XUDUZ_",",FLD,"I")_"^"_XUARR(FILE,XUDUZ_",",FLD,"E") S CNT=CNT+1 ;all other fields
 S XURET=$NA(@XUGBL)
 Q
 ;
UPDATE(XURET,XUARR) ;rpc to update new person file data
 ; called from rpc: XUS MVI NEW PERSON UPDATE
 ; Input:
 ;   XUARR(#) = FILE #;FIELD #<;SUBFIELD #><;FILE POINTER>^FIELD NAME^<COUNTER #>^INTERNAL VALUE^EXTERNAL VALUE
 ;      <> Denotes optional values. If Counter populated, denotes multiple value <1-n>.
 ;   XUARR(0)="200;IEN^DUZ^^^"
 ;   XUARR(#)="200;.01^NAME^^^"
 ;   XUARR(#)="200;205.1^SECID^^"
 ;   XUARR(#)="200;205.2^SUBJECT ORGANIZATION^^^"
 ;   XUARR(#)="200;205.3^SUBJECT ORGANIZATION ID^^^"
 ;   XUARR(#)="200;205.4^UNIQUE USER ID^^^"
 ;   XUARR(#)="200;205.5^ADUPN^^^"
 ;   **711, Story 977821 (jfw) - Allow additional fields to be updated.
 ;   XUARR(#)="200;.151^EMAIL ADDRESS^^^"
 ;   XUARR(#)="200;501.1^NETWORK USERNAME^^^"
 ;   **710, Story 1100018 (jfw) - Add NPI field to be updated.
 ;   XUARR(#)="200;41.99^NPI^^^"
 ;   **732,Story 1204309 (mko): Add NPI ENTRY STATUS (#41.98)
 ;   XUARR(#)=200;41.98^NPI ENTRY STATUS^^<value>
 ;   **732, story 1278983 (cmc) add EFFECTIVE DATE (#42) MULTIPLE
 ;   XUARR(#)="200;42;.01^EFFECTIVE DATE/TIME^<#>^^"
 ;   XUARR(#)="200;42;.02^STATUS^<#>^^"
 ;   XUARR(#)="200;42;.03^NPI^<#>^^"
 ;  Success:
 ;   XURET(0) = 1
 ;  Fail:
 ;   XURET(0) = "-1^No data passed"
 ;   XURET(0) = "-1^Invalid User DUZ (null)"
 ;   XURET(0) = "-1^User '"_XUDUZ_"' does not exist"
 ;   XURET(0) = "-1^Invalid Name Component IEN"
 ;   XURET(0) = "-1^No Data for Name Component IEN: "_NCIEN
 ;   XURET(0) = "-1^No data to file for record '"_XUDUZ_"' in file 200"
 ;   XURET(0) = "-1^Unable to lock record '"_XUDUZ_"' in file 200"
 ;   XURET(0) = "-1^"_$G(XUERR("DIERR",1,"TEXT",1))
 ;
 ; Example calling rpc from VistA:
 ;  >D UPDATE^XUMVINPU(.XURET,.XUARR)
 ;  >ZW XURET
 ;  >XURET(0)=1
 ; Example calling rpc from MVI:
 ;  D DIRECT^XWB2HL7(.XURET,SITE,"XUS MVI NEW PERSON UPDATE","",.XUARR)
 K XURET N ARR,FILENUM,FLDNAM,FLDNUM,IDATA,NCIEN,NPIIN,NPIERR,NPINEW,XUDUZ,XUERR,XUFDA S ARR="XUARR"
 I '$D(XUARR) S XURET(0)="-1^No data passed" Q
 F  S ARR=$Q(@ARR) Q:ARR=""  S FILENUM=+$P($P(@ARR,"^",1),";",1),FLDNUM=+$P($P(@ARR,"^",1),";",2),FLDNAM=$P(@ARR,"^",2),IDATA=$P(@ARR,"^",4) D  I $G(XURET(0))<0 Q
 . I FLDNAM="DUZ" D  Q  ;first parameter passed
 . . S XUDUZ=IDATA ;duz ien
 . . I $G(XUDUZ)="" S XURET(0)="-1^Invalid User DUZ (null)" Q
 . . I '$D(^VA(FILENUM,XUDUZ,0)) S XURET(0)="-1^User '"_XUDUZ_"' does not exist"  Q
 . I FLDNAM="NAME COMPONENTS" D  Q
 . . S NCIEN=IDATA ;name component ien
 . . I $G(NCIEN)="" S XURET(0)="-1^Invalid Name Component IEN"
 . . I '$D(^VA(20,NCIEN,0)) S XURET(0)="-1^No Data for Name Components IEN: "_NCIEN
 . ;**732,Story 1204309 (mko): If NPI is passed, not null, and doesn't yet exist
 . ;  in the EFFECTIVE DATE/TIME multiple, add it, and let the "AC" xref update
 . ;  the single-valued fields AUTHORIZE RELEASE OF NPI (#41.97), NPI ENTRY STATUS (#41.98), and NPI (#41.99) at the top file level.
 . ; IF NPI IS NOT BEING DELETED BUT ADDING A VALUE
 . I FLDNAM="NPI",IDATA'="@" D  Q
 . . N IENS,ERR,XUFDA,DIERR,DIHELP,DIMSG S NPIIN=IDATA
 . . Q:IDATA=""  Q:$O(^VA(200,XUDUZ,"NPISTATUS","C",IDATA,""))
 . . S NPINEW=1,IENS="+1,"_XUDUZ_",",XUFDA(200.042,IENS,.01)="NOW",XUFDA(200.042,IENS,.02)=1,XUFDA(200.042,IENS,.03)=IDATA
 . . D UPDATE^DIE("E","XUFDA","","ERR") S:$G(DIERR) NPIERR=$$BLDERR("ERR")
 . I FLDNAM="NPI",IDATA="@" D  Q
 . . S XUFDA(200,XUDUZ_",",41.99)=IDATA,XUFDA(200,XUDUZ_",",41.98)=IDATA
 . . ;GET NPI TO BE DELETED FROM ARR(X+1)
 . . S ARR=$Q(@ARR) S NPI=$P(@ARR,"^",3),IENS=$O(^VA(200,XUDUZ,"NPISTATUS","C",NPI,""))_","_XUDUZ_",",XUFDA(200.042,IENS,.01)="@"
 . S XUFDA(FILENUM,$S(FILENUM=200:+$G(XUDUZ),1:+$G(NCIEN))_",",FLDNUM)=IDATA
 Q:$G(XURET(0))<0
 I '$G(NPINEW),'$D(XUFDA) S XURET(0)="-1^No data to file for record '"_XUDUZ_"' in file 200" Q
 ;**732,Story 1204309 (mko): If NPI (#41.99) is not the NPI coming in, don't update NPI ENTRY STATUS (#41.98)
 I $G(NPIIN)]"",$P($G(^VA(200,XUDUZ,"NPI")),U)'=NPIIN K XUFDA(200,XUDUZ_",",41.98)
 ;**732,Story 1204309 (mko): File the Name first (Within a FILE^DIE call,
 ;  triggers on the .01 that in turn call FILE^DIE may cause the Filer flag to change from "E", to "". FDA must be also be namespaced)
 I $D(XUFDA(200,XUDUZ_",",.01))#2 D  Q:$G(XURET(0))["Unable to lock record"
 . N NAMEFDA S NAMEFDA(200,XUDUZ_",",.01)=XUFDA(200,XUDUZ_",",.01) D FILER(XUDUZ,.NAMEFDA,.XURET) K XUFDA(200,XUDUZ_",",.01)
 ;**732,Story 1204309 (mko): Move code to call Filer to subroutine
 D FILER(XUDUZ,.XUFDA,.XURET) Q:$G(XURET(0))["Unable to lock record"
 ;**732,Story 1204309 (mko): Add NPIERR to XURET(0)
 S:$G(NPIERR)]"" XURET(0)=$$ADDERR(XURET(0),NPIERR)
 ;Return 1 in first piece to indicate Filer/Updater calls were made. If errors, also return -1^errMsg in 2nd and 3rd pieces.
 S XURET(0)=1_$S($G(XURET(0))<0:U_XURET(0),1:"")
 Q
 ;
FILER(XUDUZ,XUMVIFDA,XURET) ;Call the Filer
 ;**732,Story 1204309 (mko): Move the code to call the Filer into a separate subroutine, since it is called multiple times.
 N DIERR,DIHELP,DIMSG,XUERR
 Q:'$G(XUDUZ)  Q:'$D(XUMVIFDA)
 L +^VA(200,XUDUZ):10 I '$T S XURET(0)="-1^Unable to lock record '"_XUDUZ_"' in file 200" Q
 ;**710, Story 1100018 (jfw) - Process fields as External Values now so Input Transform checks fire
 ;**732,Story 1204309 (mko): Unlock the record before checking for DIERR
 D FILE^DIE("E","XUMVIFDA","XUERR") L -^VA(200,XUDUZ)
 ;**732,Story 1204309 (mko): Put all error messages into XURET(0)
 S:$G(DIERR) XURET(0)=$$ADDERR($G(XURET(0)),$$BLDERR("XUERR"))
 Q
 ;
ADDERR(RET,MSG) ;Return RET with MSG appended to it, and 1st piece equal to -1
 Q:$G(MSG)="" $G(RET)
 Q $S($G(RET)]"":RET_" ",1:"-1^")_MSG
 ;
BLDERR(INROOT) ;Build a string containing error messages returned by FileMan
 N ERRSTR,I,XUERMSGS D MSG^DIALOG("AE",.XUERMSGS,"","",$G(INROOT))
 S ERRSTR="",I=0 F  S I=$O(XUERMSGS(I)) Q:'I  S:XUERMSGS(I)]"" ERRSTR=ERRSTR_$E(" ",ERRSTR]"")_XUERMSGS(I)
 Q ERRSTR
