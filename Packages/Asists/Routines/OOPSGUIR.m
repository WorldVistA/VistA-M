OOPSGUIR ;WIOFO/LLH-RPC routine for misc reports ; 6/11/09 10:32am
 ;;2.0;ASISTS;**8,7,11,14,20**;Jun 03, 2002;Build 2
 ;
ENT(RESULTS,INPUT,CALL) ; get the data for the report
 ;   Input:  INPUT - contains 3 values, the START AND END DATE, 
 ;                   STATION. The Date of Occ (fld #4) is used to 
 ;                   in/exclude claims from the report. If Station='ALL'
 ;                   then all claims are included, if not 'All', then
 ;                   only 1 station is included.
 ;            CALL - contains the report call which will invoke
 ;                   the appropriate M call 
 ; Output: RESULTS - the results array passes data back to the client.
 N CAX,FI,LP,MENU,SDATE,STDT,STA,STATION,ENDDT,EDATE,TAG,X,Y,%DT
 S RESULTS(0)="Processing..."
 S STDT=$P($G(INPUT),U),ENDDT=$P($G(INPUT),U,2)
 S STA=$P($G(INPUT),U,3),TAG=CALL
 I (STDT="")!(ENDDT="")!(STA="")!(TAG="") D  Q
 . S RESULTS(0)="Input parameters missing, cannot run report." Q
 K ^TMP($J,TAG)
 S (SDATE,EDATE,MENU)=""
 S X=STDT D ^%DT S SDATE=Y
 S X=ENDDT D ^%DT S EDATE=Y
 ; SDATE made last time in day prior so start date correct
 I TAG="LOG300U" S TAG="LOG300",MENU="U"
 S SDATE=(SDATE-1)+.9999,EDATE=EDATE_".9999"
 D @TAG
 Q
SERVICE ; Service/Detail Location report - patch 11
DSPUTE ; Reason for Dispute report. Patch 11
FLD174 ; Report compiles filing instruction result counts
FLD332 ; Use this tag for Reason for Controvert report. Patch 11
 N ARR,CODE,CN,LP,IEN,I,GOON,P2,TX
 S LP="",IEN="",CN=0
 I TAG="FLD174" D
 .S CODE=$P($G(^DD(2260,174,0)),U,3)
 .F I=1:1 S LP=$P(CODE,";",I) Q:$G(LP)=""  I $P(LP,":",2)'="" S ARR(LP)=0
 .S ARR(I_":No Data Entered")=0
 I TAG="FLD332" D
 .F I=1:1 Q:'$D(^OOPS(2262.4,I))  S ARR(I_":"_$P(^OOPS(2262.4,I,0),U))=0
 .S ARR(98_":Blk 36 also has text entered")=0
 .S ARR(99_":Controvert question checked Yes, but no Controvert Code entered")=0
 F LP=SDATE:0 S LP=$O(^OOPS(2260,"AD",LP)) Q:(LP'>0)!(LP>EDATE)  D
 .F  S IEN=$O(^OOPS(2260,"AD",LP,IEN)) Q:IEN'>0  D
 ..I $$GET1^DIQ(2260,IEN,51,"I")>1 Q      ;only allow open/closed cases
 ..S CAX=$$GET1^DIQ(2260,IEN,52,"I")
 ..I TAG'="SERVICE"&(CAX=2) Q                       ;only allow CA1's
 ..S STATION=$P(^OOPS(2260,IEN,"2162A"),U,9)
 ..I ($G(STA)'="A"),(STATION'=STA) Q        ;get correct station
 ..;patch 11 - sent to OOPSGUIF due to size this routine
 ..I TAG="DSPUTE" D DSPUTE^OOPSGUIF
 ..I TAG="SERVICE" D SERVICE^OOPSGUIU
 ..; Filing instructions report
 ..I TAG="FLD174" D
 ...S FI=$$GET1^DIQ(2260,IEN,174,"I")_":"_$$GET1^DIQ(2260,IEN,174)
 ...I $$GET1^DIQ(2260,IEN,174)="" S FI=I_":No Data Entered"
 ...S ARR(FI)=ARR(FI)+1
 ...;patch 11 - Reason for controvert report
 ..I TAG="FLD332" D
 ...;first Agency Controvert must = "Y" to be counted
 ...S GOON=$$GET1^DIQ(2260,IEN,165.1,"I") I $G(GOON)'="Y" D  Q
 ....S:'$D(ARR("999:Case not controverted, no controvert code expected")) ARR("999:Case not controverted, no controvert code expected")=0
 ....S ARR("999:Case not controverted, no controvert code expected")=ARR("999:Case not controverted, no controvert code expected")+1
 ...S FI=$$GET1^DIQ(2260,IEN,332,"I")_":"_$$GET1^DIQ(2260,IEN,332)
 ...I $$GET1^DIQ(2260,IEN,332)="" S FI=99_":Controvert question checked Yes, but no Controvert Code entered"
 ...S ARR(FI)=ARR(FI)+1
 ...I $G(^OOPS(2260,IEN,"CA1K",1,0))'="" D
 ....;if case is diputed, don't count in Controvert rpt - quit
 ....S GOON=$$GET1^DIQ(2260,IEN,165.2,"I") I $G(GOON)="Y" Q
 ....S ARR(98_":Blk 36 also has text entered")=ARR(98_":Blk 36 also has text entered")+1
 I TAG'="DSPUTE",(TAG'="SERVICE") D
 .S CN=0,FI="",P2=""
 .F  S FI=$O(ARR(FI)) Q:FI=""  D
 ..S CN=$P(FI,":"),P2=$P(FI,":",2),CODE=0
 ..I TAG="FLD332" S TX=$O(^OOPS(2262.4,"B",P2,"")) I $G(TX) S CODE=$P(^OOPS(2262.4,TX,0),U,2)
 ..S ^TMP($J,TAG,CN)=P2_U_CODE_U_ARR(FI)
 ..; rearrange 'bogus' Controvert Codes for report formating
 ..I TAG="FLD332",(CN>97) S ^TMP($J,TAG,CN)=U_P2_U_ARR(FI)
 I TAG="SERVICE" D CMPLSRV^OOPSGUIU
 I TAG="DSPUTE" D DSPUTE^OOPSGUIU
 S RESULTS=$NA(^TMP($J,TAG))
 Q
SUM300A ; Summary of Work-related injuries and illness report
 N CN,EMP,FAC,HRS,STATE,STR
 N COLG,COLH,COLI,COLJ,COLK,COLL,COLM
 S (COLG,COLH,COLI,COLJ,COLK,COLL)=0
 S (COLM(1),COLM(2),COLM(3),COLM(4),COLM(5),COLM(6))=0
 S ^TMP($J,TAG,0)="No worksheet data for this station."
 S FAC=$$GET1^DIQ(4,STA,.01,"E")
 K ARR D STATINFO^OOPSGUI3(.ARR,STA) I $D(ARR) D
 .S STATE=$P($G(ARR(0)),U,3)
 .I $G(STATE)'="" D
 ..S STATE=$O(^DIC(5,"B",STATE,""))
 ..S $P(ARR(0),U,3)=$P(^DIC(5,STATE,0),U,2)
 .S ^TMP($J,TAG,0)=FAC_U_ARR(0)
 K ARR D SITEPGET^OOPSGUI6(.ARR,"OSHA300") I $D(ARR) D 
 .S CN=0 F  S CN=$O(ARR(CN)) Q:CN=""  D
 ..I $P(ARR(CN),U,11)'=STA Q
 ..S STR=$P($P(ARR(CN),U,1)," = ",2)
 ..S STR=$P(ARR(CN),U,3)_U_$P(ARR(CN),U,4)_U_$P(ARR(CN),U,6)_U
 ..S STR=STR_$P(ARR(CN),U,7)_U_$P(ARR(CN),U,8)
 ..S ^TMP($J,TAG,0)=^TMP($J,TAG,0)_U_STR
 K ARR,DATA S DATA=""
 D EMPHRS,DETAIL
 Q
IRWSHT ; Incidence Rates Worksheet Report
 N COLHI,EMP,HRS
 S ^TMP($J,TAG,1)="No Worksheet Data for this Station"
 S COLHI=0
 K ARR,DATA S DATA=""
 D EMPHRS,DETAIL
 Q
DETAIL ; now get employee information
LOG300 ; entry point for the OSHA 300 LOG
 N CN,CASES,COLF,DOI,FLD,IEN,INC,STATION,TYPE
 S DOI=SDATE,CASES=0,CN=1
 F  S DOI=$O(^OOPS(2260,"AF",DOI)) Q:(DOI>EDATE)!(DOI="")  S IEN=0 D
 .F  S IEN=$O(^OOPS(2260,"AF",DOI,"Y",IEN)) Q:IEN=""  D
 ..S STATION=$P(^OOPS(2260,IEN,"2162A"),U,9) I $G(STATION)'=STA Q
 ..I $P(^OOPS(2260,IEN,0),U,6)>1 Q
 ..S CASES=CASES+1
 ..I TAG="IRWSHT" D
 ...I $D(^OOPS(2260,IEN,"OUTC","AC","A","J"))!$D(^OOPS(2260,IEN,"OUTC","AC","A","A")) S COLHI=COLHI+1
 ..I TAG="SUM300A" D FLD95
 ..I TAG="LOG300" D FLD95 D
 ...S ARR(1)=$$GET1^DIQ(2260,IEN,.01),ARR(2)=$$GET1^DIQ(2260,IEN,1)
 ...I $$GET1^DIQ(2260,IEN,337,"I")="Y" S ARR(2)="Privacy Case"
 ...S TYPE=$$GET1^DIQ(2260,IEN,3,"I")
 ...I TYPE>10&(TYPE<15) S ARR(2)="Privacy Case"
 ...I MENU="U" S ARR(2)=""
 ...S INC=$$GET1^DIQ(2260,IEN,52,"I"),FLD=$S(INC=1:111,INC=2:208,1:"")
 ...S ARR(3)=$$GET1^DIQ(2260,IEN,FLD)
 ...S ARR(4)=$P($$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,4,"I")),2),"@")
 ...S ARR(5)=$$GET1^DIQ(2260,IEN,27,"E")
 ...;v2_P20 changed field to populate ARR(6) - Coluum F OSHA 300 log
 ...S COLF=$$GET1^DIQ(2260,IEN,384),ARR(6)=COLF
 ...I (SDATE<3081231.9999&(EDATE>3081231.9999)) S ARR(6)=COLF
 ...I EDATE<3090101&(COLF="") S ARR(6)=$$GET1^DIQ(2260,IEN,3)_";"_$$GET1^DIQ(2260,IEN,30)
 ...S DATA=ARR(1)_U_ARR(2)_U_ARR(3)_U_ARR(4)_U_ARR(5)_U_ARR(6)_U_ARR(7)_U
 ...S DATA=DATA_ARR(8)_U_ARR(9)_U_ARR(10)
 ...S ^TMP($J,TAG,CN)=DATA,CN=CN+1
 I TAG="IRWSHT" S ^TMP($J,TAG,1)=CASES_U_COLHI_U_HRS
 I TAG="SUM300A" D
 .S DATA=CASES_U_EMP_U_HRS_U_COLG_U_COLH_U_COLI_U_COLJ_U_COLK_U_COLL_U
 .S DATA=DATA_COLM(1)_U_COLM(2)_U_COLM(3)_U_COLM(4)_U_COLM(5)_U_COLM(6)
 .S ^TMP($J,TAG,1)=DATA
 S RESULTS=$NA(^TMP($J,TAG))
 K ARR,DATA
 Q
FLD95 ; use OUTC subrecord to retrieve data
 N AVAIL,ED,SD,S0,INC,ILL,DAYA,DAYJ,DAYS,IEN95,OC,OUTC,S95,TDAY
 S S0=$G(^OOPS(2260,IEN,0)),INC=$P(S0,U,7)
 S ILL=$P($G(^OOPS(2260,IEN,"2162B")),U,15)
 S TDAY=$$HTFM^XLFDT(+$H)
 ; add days away & job transfer up only to 180 for log, 4 300A get all
 S (DAYA,DAYJ,TAWAY)=0,IEN95=0
 F  S IEN95=$O(^OOPS(2260,IEN,"OUTC",IEN95)) Q:IEN95'>0  D
 .S S95=$G(^OOPS(2260,IEN,"OUTC",IEN95,0))
 .S SD=$P(S95,U,1),ED=$P(S95,U,2),OC=$P(S95,U,3),DAYS=0
 .I $P(S95,U,11)="D" Q      ; entry is deleted
 .;patch 11 - added logic that if TAG=LOG300 include all incident days
 .;           up to 180, else 300A, only include date range incidents
 .I (TAG="SUM300A"),(EDATE<SD) Q
 .I $G(OC)'="" S OUTC(OC)=""
 .I TAG="SUM300A" D
 ..I $G(ED)=""!($G(ED)>EDATE) S DAYS=$$FMDIFF^XLFDT(EDATE,SD,1)+1
 .I TAG="LOG300",($G(ED)="") S DAYS=$$FMDIFF^XLFDT(TDAY,SD,1)+1
 .I '$G(DAYS) S DAYS=$S(OC="A":$P(S95,U,4),OC="J":$P(S95,U,5),1:0)
 .I DAYA+DAYJ>179 Q
 .S AVAIL=0
 .I DAYS>179 S AVAIL=(180-(DAYA+DAYJ))
 .I (DAYS<180) D
 ..I (DAYS+DAYA+DAYJ)<180 S AVAIL=DAYS
 ..I (DAYS+DAYA+DAYJ)>180 S AVAIL=(180-(DAYA+DAYJ))
 .I $G(OC)="A" S DAYA=DAYA+AVAIL
 .I $G(OC)="J" S DAYJ=DAYJ+AVAIL
 I TAG="SUM300A" D
 .S:$G(INC)=1 COLM(1)=COLM(1)+1
 .I INC=2 D
 ..I $G(ILL) S COLM(ILL)=COLM(ILL)+1
 ..I '$G(ILL) S COLM(6)=COLM(6)+1
 .S COLK=COLK+DAYA,COLL=COLL+DAYJ
 .I $D(OUTC("D")) S COLG=COLG+1 Q
 .I $D(OUTC("A")) S COLH=COLH+1 Q
 .I $D(OUTC("J")) S COLI=COLI+1 Q
 .I $D(OUTC("O")) S COLJ=COLJ+1 Q
 I TAG="LOG300" D
 .S ARR(7)="",ARR(10)="",(ARR(8),ARR(9))=0
 .I INC=1 S ARR(10)=1
 .I INC=2 S:$G(ILL) ARR(10)=ILL S:'$G(ILL) ARR(10)=6
 .S ARR(8)=DAYA,ARR(9)=DAYJ
 .I $D(OUTC("D")) S ARR(7)="D" S (ARR(8),ARR(9))=0 Q
 .I $D(OUTC("A")) S ARR(7)="A" Q
 .I $D(OUTC("J")) S ARR(7)="J" Q
 .I $D(OUTC("O")) S ARR(7)="O" Q
 Q
EMPHRS ; get Total Num Employees and Hours worked
 N CASES,ED,LV1,LV2,MON,OK,PAR,SD,SIEN,STR,WS,X,X1,X2
 S (EMP,HRS,WS)=0
 S PAR="^OOPS(2262,0)",PAR=$Q(@PAR),PAR=$Q(@PAR)
 S LV1=$P(PAR,",",2),LV2=$P(PAR,",",3)
 S SIEN=$O(^OOPS(2262,LV1,LV2,"B",STA,-1)) Q:SIEN=""
 ; get month range to make sure all emp numbers and hours are entered
 S SDATE=SDATE\1
 S SD=$E(SDATE,1,5)_"00"_$E(SDATE,8,$L(SDATE))
 S ED=$E(EDATE,1,5)_"00"_$E(EDATE,8,$L(EDATE))
 S X1=$E(ED,1,3),X2=$E(SD,1,3)
 I X1>X2 D
 .S OK=0,X=(X1-X2) S:X>1 OK=(X-1)*12
 .S OK=OK+((12-$E(SD,4,5))+1)+$E(ED,4,5)
 I X1=X2 S OK=($E(ED,4,5)-$E(SD,4,5))+1
 S MON=OK
 F  S WS=$O(^OOPS(2262,LV1,LV2,SIEN,2,WS)) Q:(WS'>0)  D
 .S STR=^OOPS(2262,LV1,LV2,SIEN,2,WS,0)
 .I ($P(STR,U)'<SD)&($P(STR,U)'>ED) D
 ..I ($P(STR,U,2)="")!($P(STR,U,3)="") Q
 ..S EMP=EMP+$P(STR,U,2),HRS=HRS+$P(STR,U,3),OK=OK-1
 I '$G(OK) S EMP=EMP/MON
 I $G(OK) S (EMP,HRS)="INCOMPLETE DATA"
 Q
