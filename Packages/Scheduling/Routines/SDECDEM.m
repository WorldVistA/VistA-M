SDECDEM ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
ZIPLINK(RET,ZIP) ;GET linked cities/state/etc for given zip code
 ;INPUT:
 ;  1. ZIP  - 5 or 9 digit numeric Zip code
 ;RETURN:
 ;  1. CITYNAME   - City name
 ;  2. CITY_ABB   - City Abbreviation
 ;  3. CITY_KEY   - City Key
 ;  4. COUNTYNAME - County name
 ;  5. COUNTYIEN  - County Pointer
 ;  6. FIPS       - FIPS code
 ;  7. ZIP        - ZIP CODE
 ;  8. P_CITY_KEY - Preferred City Key
 ;  9. STATENAME  - State name
 ; 10. STATE_IEN  - State ien
 ; 11. UID        - Unique Key
 ;
 N SDATA,SDECI,SDI,SDTMP,X
 S SDECI=0
 S RET="^TMP(""SDECDEM"","_$J_",""ZIPLINK"")"
 K @RET
 ; data header
 S SDTMP="T00030CITYNAME^T00030CITY_ABB^T00030CITY_KEY^T00030COUNTYNAME^T00030COUNTY_IEN^T00030FIPS^T00030ZIP"
 S SDTMP=SDTMP_"^T00030P_CITY_KEY^T00030STATENAME^T00030STATE_IEN^T00030UID"
 S @RET@(0)=SDTMP_$C(30)
 ;validate ZIP
 S ZIP=$G(ZIP)
 I ZIP'="" D
 .I ($A(ZIP)=45),$L(ZIP)>20!($L(ZIP)<5) S @RET@(1)="-1^Zip code must be 5 or 9 numeric digits "_ZIP_"."_$C(30,31) Q
 .S X=ZIP D ZIPIN^VAFADDR S X=$G(X) S:X'="" ZIP=X I X="" S @RET@(1)="-1^Invalid zip code "_ZIP_"."_$C(30,31) Q
 ;
 I ZIP'="" D
 .D POSTALB^XIPUTIL(ZIP,.SDATA)
 .S SDI="" F  S SDI=$O(SDATA(SDI)) Q:SDI=""  D
 ..S SDTMP=$G(SDATA(SDI,"CITY"))
 ..S $P(SDTMP,U,2)=$G(SDATA(SDI,"CITY ABBREVIATION"))
 ..S $P(SDTMP,U,3)=$G(SDATA(SDI,"CITY KEY"))
 ..S $P(SDTMP,U,4)=$G(SDATA(SDI,"COUNTY"))
 ..S $P(SDTMP,U,5)=$G(SDATA(SDI,"COUNTY POINTER"))
 ..S $P(SDTMP,U,6)=$G(SDATA(SDI,"FIPS CODE"))
 ..S $P(SDTMP,U,7)=$G(SDATA(SDI,"POSTAL CODE"))
 ..S $P(SDTMP,U,8)=$G(SDATA(SDI,"PREFERRED CITY KEY"))
 ..S $P(SDTMP,U,9)=$G(SDATA(SDI,"STATE"))
 ..S $P(SDTMP,U,10)=$G(SDATA(SDI,"STATE POINTER"))
 ..S $P(SDTMP,U,11)=$G(SDATA(SDI,"UNIQUE KEY"))
 ..S SDECI=SDECI+1 S @RET@(SDECI)=SDTMP_$C(30)
 S @RET@(SDECI)=@RET@(SDECI)_$C(31)
 Q
 ;
MARITAL(RET)  ;GET Marital status entries from the MARITAL STATUS file (#11)
 ;INPUT:
 ;  none
 ;RETURN:
 ;  1. MIEN   - Marital Status ID pointer to the MARITAL STATUS file (#11)
 ;  2. MNAME  - Marital Status name
 ;  3. MABB   - Marital Status Abbreviation
 ;  4. MCODE  - Marital Status Code - valid values are:
 ;              D:DIVORCED
 ;              M:MARRIED
 ;              N:NEVER MARRIED
 ;              S:SEPARATED
 ;              W:WIDOWED
 ;              U:UNKNOWN
 N MIEN,MNAME,MNOD,SDECI
 S SDECI=0
 S RET="^TMP(""SDECDEM"","_$J_",""MARITAL"")"
 K @RET
 ; data header
 S @RET@(0)="T00030MIEN^T00030MNAME^T00030MABB^T00030MCODE"_$C(30)
 ;
 S MNAME="" F  S MNAME=$O(^DIC(11,"B",MNAME)) Q:MNAME=""  D
 .S MIEN=0 F  S MIEN=$O(^DIC(11,"B",MNAME,MIEN)) Q:MIEN=""  D
 ..S MNOD=$G(^DIC(11,MIEN,0))
 ..Q:MNOD=""
 ..S SDECI=SDECI+1 S @RET@(SDECI)=MIEN_U_MNAME_U_$P(MNOD,U,2)_U_$P(MNOD,U,3)_$C(30)
 S @RET@(SDECI)=@RET@(SDECI)_$C(31)
 Q
 ;
RELIGION(RET)  ;GET Religious preference entries from the RELITION file (#13)
 ;INPUT:
 ;  none
 ;RETURN:
 ;  1. RIEN    - Religion ID pointer to the RELIGION file (#13)
 ;  2. RNAME   - Religion name
 ;  3. RABB    - Religion Abbreviation
 ;  4. RCLASS  - Religion Classification code
 ;               1=CATHOLIC
 ;               2=PROTESTANT
 ;               3=JEWISH
 ;               4=ORTHODOX
 ;               5=OTHER
 ;  5. RCLASSN - Relition Classification name
 ;  6. RCODE   - Religion Code - Numeric 1-99
 N RIEN,RNAME,RNOD,SDECI
 S SDECI=0
 S RET="^TMP(""SDECDEM"","_$J_",""RELIGION"")"
 K @RET
 ; data header
 S @RET@(0)="T00030RIEN^T00030RNAME^T00030RABB^T00030RCLASS^T00030RCLASSN^T00030RCODE"_$C(30)
 ;
 S RNAME="" F  S RNAME=$O(^DIC(13,"B",RNAME)) Q:RNAME=""  D
 .S RIEN=0 F  S RIEN=$O(^DIC(13,"B",RNAME,RIEN)) Q:RIEN=""  D
 ..S RNOD=$G(^DIC(13,RIEN,0))
 ..Q:RNOD=""
 ..S SDECI=SDECI+1 S @RET@(SDECI)=RIEN_U_RNAME_U_$P(RNOD,U,2)_U_$P(RNOD,U,3)_U_$$GET1^DIQ(13,RIEN_",",2)_U_$P(RNOD,U,4)_$C(30)
 S @RET@(SDECI)=@RET@(SDECI)_$C(31)
 Q
 ;
CITYAB(ZIP,CITY) ;GET city abbreviation for given city and zip
 N CITY1,CITYAB,SDATA,SDI
 S (CITY1,CITYAB)=""
 S ZIP=$G(ZIP) Q:ZIP="" ""
 S CITY=$G(CITY)
 D POSTALB^XIPUTIL(ZIP,.SDATA)
 S SDI="" F  S SDI=$O(SDATA(SDI)) Q:SDI=""  D  Q:CITY1=CITY
 .S CITY1=$G(SDATA(SDI,"CITY"))
 .S CITY1=$S($E(CITY1,$L(CITY1))="*":$E(CITY1,1,$L(CITY1)-1),1:CITY1)
 .S CITYAB=$G(SDATA(SDI,"CITY ABBREVIATION"))
 Q CITYAB
