FHWOR3 ; HISC/NCA - HL7 Early/Late Tray ;10/10/00  14:56
 ;;5.5;DIETETICS;;Jan 28, 2005
 S DATA=X
 N BAG,CODE,DATE,DAY,DTE,DP,EL,K,L1,LP,LSTWD,MEAL,PER,PIECE,SERV,SP,W1,WKD,WKDAYS,Y
 S:ITVL="" ITVL="ONCE"
 I 'SDT S TXT="No Start Date." D ERR^FHWOR Q
 S DATE=SDT D CVT^FHWOR S SDT=DATE\1
 I EDT S DATE=EDT D CVT^FHWOR S EDT=DATE\1
 I 'EDT S:ITVL="ONCE" EDT=SDT I 'EDT S TXT="No Stop Date." D ERR^FHWOR Q
 S SERV=$P(DATA,"|",2)
 I $P("EARLY",SERV,1)'="",$P("LATE",SERV,1)'="" S TXT="Wrong Type of Tray." D ERR^FHWOR Q
 S PER=$P(DATA,"|",3),PER=$E(PER,4,$L(PER)),MEAL=$E(PER,1) I "BNE"'[MEAL S TXT="Wrong Service Period." D ERR^FHWOR Q
 I $E(PER,2)'=$E(SERV,1) S TXT="Wrong Service Period." D ERR^FHWOR Q
 S PIECE=$E(PER,3) I 'PIECE S TXT="No Time Specified." D ERR^FHWOR Q
 S K=$S(MEAL="B":0,MEAL="N":6,1:12)+($E(PER,2)="L"*3)
 S W1=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8),DP=$P($G(^FH(119.6,+W1,0)),"^",8)
 K TM F L1=1:1:3 S TM(L1)=$P($G(^FH(119.73,+DP,1)),"^",K+L1)
 S TIM=TM(PIECE) I TIM="" F L1=1:1:3  S:TM(L1)'="" TIM=TM(L1)
 I TIM="" S TXT="No Early/Late Time on file." D ERR^FHWOR Q
 S BAG="N" I $P(X,"|",4)="bagged" S BAG="Y"
 S X=SDT_"@"_TIM,%DT="XT" D ^%DT S (SDT,FHDTIM)=Y,EDT=EDT+(SDT#1)
 S (FHV1,FHV2)="" D CUR^FHWOR31(FHDFN,ADM,FHDTIM,.FHV1,.FHV2)
 S (WKDAYS,WKD)=""
 I SDT=EDT D  G:SP ERR G PROC
 .S SP="" F K=SDT\1:0 S K=$O(^FHPT(FHDFN,"A",ADM,"EL",K)) Q:K<1!(K\1'=(SDT\1))  I $P(^(K,0),"^",2)=MEAL S SP=K Q
 .I SP S TXT="Early/Late Meal Already Ordered for this Date." Q
 .Q
 F LP=1:1 S CODE=$P(ITVL,"~",LP) Q:CODE=""  D  Q:TXT'=""
 .I CODE="ONCE" S TXT="ONCE is for one Day Only." Q
 .I $E(CODE,1)'="Q" S TXT="Wrong Interval specification.  Use Only ONCE, QJ#, or Q1J#." Q
 .I +$E(CODE,2)>1 S TXT="Wrong interval specification.  Use Only ONCE, QJ#, or Q1J#." Q
 .S LSTWD=$E(CODE,$L(CODE))
 .I LSTWD="J" S DAY=1 S WKD=WKD_$E("MTWRFSX",DAY) Q
 .I LSTWD?1N,$E(CODE,$L(CODE)-1)="J" D  Q
 ..S DAY=LSTWD I DAY<1!(DAY>7) S TXT="Wrong Day Specification." Q
 ..S WKD=WKD_$E("MTWRFSX",DAY),WKDAYS=WKDAYS_DAY Q
 .S TXT="Wrong interval specification.  Use Only ONCE, QJ#, or Q1J#."
 .Q
 I TXT'="" D ERR^FHWOR Q
PROC ; Process Add E/L Trays
 D PROC^FHWOR31
EXIT ; Exit Process Kill.
 K %,%H,%I,%DT,BAG,CODE,DATE,DAY,DTE,DP,EL,FHDAY,FHDTIM,FHV1,FHV2,K,L1,LP,LSTWD,MEAL,PER,PIECE,SERV,SP,W1,WKD,WKDAYS,X,Y Q
ERR ; Send Error Message
 D ERR^FHWOR Q
CAN ; Process Cancel/Discontinue from OE/RR
 D NOW^%DTC S NOW=%,CT=0
 D GADM^FHWORR
 F EL=%:0 S EL=$O(^FHPT(FHDFN,"A",+ADM,"EL",EL)) Q:EL<1!(EL>$P(FILL,";",5))  S X=$G(^(EL,0)) I $P(X,"^",7)=+FHORN K ^FHPT(FHDFN,"A",ADM,"EL",EL),^FHPT("ADLT",EL,FHDFN) S CT=CT+1
 S %=$S($D(^FHPT(FHDFN,"A",ADM,"EL",0)):$P(^(0),"^",4),1:0)-CT S:%'<0 $P(^(0),"^",4)=%
 K %,%H,%I,CT,EL D CSEND^FHWOR Q
EL ; Code Early Late Tray
 K MSG S WKDAYS=""
 I SDT=EDT S ITVL="ONCE" G EL1
 S ITVL="" F K=1:1 S Z=$E(WKD,K) Q:Z=""  S DAY=$F("MTWRFSX",Z),DAY=DAY-1 S:ITVL'="" ITVL=ITVL_"~" S ITVL=ITVL_"QJ"_DAY,WKDAYS=WKDAYS_DAY
EL1 S FILL="E"_";"_ADM_";;"_SDT_";"_EDT_";"_WKD_";"_MEAL_";"_TIM_";"_BAG
 D SET
 ; Code MSH, PID, and PV1
 D MSH^FHWOR
 ; code ORC
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^"_ITVL_"^^"_SDT_"^"_EDT_"|||"_DUZ_"||"_DUZ_"|||"_NOW
 ; code ODT
 S MSG(5)="ODT|"_$S(SERV="E":"EARLY",1:"LATE")_"|^^^"_MEAL_SERV_NUM_"^^99FHS|"_$S(BAG="Y":"bagged",1:"")
 K FHWARD,FILL,HOSP,ITVL,FHORN,RM,SITE,WARD,WKDAYS,Z Q
CODE ; Code Cancel/Discontinue Early Late Tray
 K MSG S ACT="OC",WKD="",CTR=0 D SITE^FH
 S EDT="" F SK=0:0 S SK=$O(NN(FHORN,SK)) Q:SK<1  S CTR=CTR+1 S:CTR=1 SDT=SK S EDT=SK D WKD
 S STR=$G(^FHPT(FHDFN,"A",ADM,"EL",EDT,0))
 S FILL="E"_";"_ADM_";;"_SDT_";"_EDT_";"_WKD_";"_$P(STR,"^",2)_";"_$P(STR,"^",3)_";"_$P(STR,"^",4)
 ; code MSH
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORM"
 ; code PID
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 ; code ORC
 S DATE=$$FMTHL7^XLFDT(NOW)
 S MSG(3)="ORC|"_ACT_"|"_FHORN_"^OR|"_FILL_"^FH|||||||||"_FHPV_"|||"_DATE_"|Dietetics Canceled Early/Late Tray order."
 K %,%Y,ACT,DATE,EDT,FILL,FHORN,SDT,SK,SITE,STR,WKD Q
WKD ; Get week days
 D WKD^FHWOR31
 Q
SET ; Set Date/Time in HL7 format
 D SET^FHWOR31
 Q
NA ; OE/RR Number Assign
 S SDT=$P(FILL,";",4),EDT=$P(FILL,";",5),WKD=$P(FILL,";",6),MEAL=$P(FILL,";",7),TIM=$P(FILL,";",8),DTE=SDT
 G:'+FHORN KIL
 G:'$D(^FHPT(FHDFN,"A",ADM,"EL",SDT,0)) KIL
 I WKD="" S $P(^FHPT(FHDFN,"A",ADM,"EL",SDT,0),"^",7)=+FHORN G KIL
 F EL=SDT\1:0 S EL=$O(^FHPT(FHDFN,"A",ADM,"EL",EL)) Q:EL<1!(EL>EDT)  D
 .Q:$P(^FHPT(FHDFN,"A",ADM,"EL",EL,0),"^",7)
 .Q:$P(^FHPT(FHDFN,"A",ADM,"EL",EL,0),"^",2)'=MEAL
 .Q:$P(^FHPT(FHDFN,"A",ADM,"EL",EL,0),"^",3)'=TIM
 .S X=EL D H^%DTC S:%Y=0 %Y=7 Q:%Y<0
 .S WKDAYS=$E("MTWRFSX",%Y) Q:WKDAYS=""
 .S:"MTWRFSX"[WKDAYS $P(^FHPT(FHDFN,"A",ADM,"EL",EL,0),"^",7)=+FHORN
 .Q
KIL K %Y,DTE,EDT,EL,NUM,MEAL,MSG,FHORN,SDT,TIM,WKDAYS,WKD Q
