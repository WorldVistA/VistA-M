SYNDHPIC ;AFHIL DHP/fjf - HealthConcourse - get ICNs list ; 06 Jun 2019  5:27 PM
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 Q
 ;
ICNS(RETSTA,DHPCNT,DHPJSON,DHPRND) ; list some or all ICNs in a namespace
 ;
 ; Input:
 ;   DHPCNT  - Number of ICN's to return
 ;               nn - Integer
 ;               A  - all (default)
 ;   DHPJSON - Return format
 ;               J for JSON (default)
 ;               T for plain text
 ;   DHPRND -  Random selection of ICN's from target system
 ;               R for random selection of ICN's
 ;               O for first n (DHPCNT) ICN's in index (default)
 ;
 ; Output:
 ;   ICN's in JSON format, or
 ;   ICN's in semicolon delimited text string
 ;
 ;
 N ICNAR,JSICNS,ICN,N,I,ICNSTR
 S DHPCNT=$G(DHPCNT)
 S DHPCNT=$S(+DHPCNT>0:DHPCNT,1:"A")
 S DHPJSON=$G(DHPJSON,"J")
 S DHPRND=$G(DHPRND,"O")
 ; next line because random not consistent with all
 I DHPCNT="A",DHPRND="R" S DHPRND="O"
 S ICN=""
 I DHPRND'="R" F I=1:1 S ICN=$O(^DPT("AFICN",ICN)) Q:ICN=""  Q:DHPCNT'="A"&(I>DHPCNT)  D
 .S ICNAR(ICN)=""
 I DHPRND="R" D RNDICN(DHPCNT)
 ;
 I DHPJSON="J" D
 .; put ICN array into json format
 .D ENCODE^XLFJSON("ICNAR","JSICNS")
 .; merge array elements into one string
 .S (ICNSTR,N)="" F  S N=$O(JSICNS(N)) Q:N=""  S ICNSTR=ICNSTR_JSICNS(N)
 I DHPJSON'="J" D
 .S (ICNSTR,N)="" F  S N=$O(ICNAR(N)) Q:N=""  S ICNSTR=ICNSTR_N_";"
 S RETSTA=ICNSTR
 Q
 ;
RNDICN(CNT) ; pick a random assortment of CNT ICN's
 N ICN,I,TOT,SUB,LIST
 S ICN=""
 F I=1:1 S ICN=$O(^DPT("AFICN",ICN)) Q:ICN=""  D
 .S ICN(I)=ICN
 S TOT=I-1
 I CNT>TOT S CNT=TOT
 K LIST
 F I=1:1:CNT D
 .S SUB=$R(TOT)+1
 .I $D(LIST(SUB)) S I=I-1 Q
 .S LIST(SUB)=ICN(SUB)
 .K ICN(SUB)
 ;
 S SUB=""
 F  S SUB=$O(LIST(SUB)) Q:SUB=""  D
 .S ICNAR(LIST(SUB))=""
 Q
 ;
 ;
TEST ; tests
T1 ; count
 F FT="T","J","" D
 .S CT=3
 .F RN="O","R","" D
 ..D ICNS(.ZXC,CT,FT,RN)
 ..W !!!,$$ZW^SYNDHPUTL("ZXC")
 Q
T2 ; all
 F FT="T","J","" D
 .S CT="A"
 .D ICNS(.ZXC,"T")
 .W !!!,$$ZW^SYNDHPUTL("ZXC")
 Q
