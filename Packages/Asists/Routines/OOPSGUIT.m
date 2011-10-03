OOPSGUIT ;WIOFO/LLH-RPC Rtn for Type of Incident rpt ;11/5/01 
 ;;2.0;ASISTS;**4,7,11,15**;Jun 03, 2002;Build 9
 ;
ENT(RESULTS,TRPT,CSTAT,STDT,ENDDT,LTNTT,STAT,PSTAT) ;
 N DATA,CNT,CS,CS1,EDATE,OOPS,LOST,LP,SDATE,TOT,RPTTY
 N STATION,LOSTTIME,NODE,OOPDA,PER,X,Y
 S RPTTY=$$REPORT(),CS=$S(CSTAT="O":0,CSTAT="C":1,1:"")
 S LOST=$S(LTNTT="L":"Y",1:""),(SDATE,EDATE)=""
 S X=STDT D ^%DT S SDATE=Y,X=ENDDT D ^%DT S EDATE=Y
 S SDATE=(SDATE-1)_".9999",EDATE=EDATE_".9999",LP="",OOPDA=""
 F LP=SDATE:0 S LP=$O(^OOPS(2260,"AD",LP)) Q:(LP'>0)!(LP>EDATE)  D
 .F  S OOPDA=$O(^OOPS(2260,"AD",LP,OOPDA)) Q:OOPDA'>0  D
 ..S OOPS(0)=$G(^OOPS(2260,OOPDA,0))
 ..S CS1=$P(OOPS(0),U,6)
 ..I $G(CS1)>1 Q               ; only open & closed cases
 ..I (CS'=""),(CS'=CS1) Q      ; if 'All cases, case status must match
 ..S PER=$$GET1^DIQ(2260,OOPDA,2,"I")
 ..I (+PSTAT)&(PSTAT'[(PER_"^")) Q
 ..S STATION=$$GET1^DIQ(2260,OOPDA,13,"I")
 ..I STAT'="A",(STATION'=STAT) Q
 ..S LOSTTIME=""
 ..I $O(^OOPS(2260,OOPDA,"OUTC","AC","A","A","")) S LOSTTIME="Y"
 ..I LOST="Y",(LOSTTIME'="Y") Q
 ..I RPTTY=3 D
 ...N INC S INC=$$GET1^DIQ(2260,OOPDA,RPTTY_":.01")
 ...I $G(INC)="" S INC="Unknown"
 ...S:$D(DATA(INC))=0 DATA(INC)=0 S DATA(INC)=DATA(INC)+1
 ..I RPTTY=15 D
 ...N DIC,DR,DA,DIQ,FLD,NAME,OCC,IEN450,X,Y
 ...S NAME=$$GET1^DIQ(2260,OOPDA,1),FLD=16
 ...S DIC="^PRSPC(",DIC(0)="Z",X=NAME D ^DIC
 ...I Y>0 D
 ....K DIQ S DR=FLD,DA=+Y,IEN450=+Y,DIQ="OOPS",DIQ(0)="IE"
 ....D EN^DIQ1 K DIQ
 ...S OCC=$$GET1^DIQ(2260,OOPDA,15,"I")
 ...I $G(IEN450),$G(OCC)'="",(OCC=$E($G(OOPS(450,IEN450,FLD,"I")),1,4)) D
 ....S OCC=OCC_" - "_OOPS(450,IEN450,FLD,"E")
 ...I $G(OCC)="" S OCC="Unknown"
 ...S:$D(DATA(OCC))=0 DATA(OCC)=0 S DATA(OCC)=DATA(OCC)+1
 ..I RPTTY=29 D
 ...N CHAR S CHAR=$$GET1^DIQ(2260,OOPDA,RPTTY_":.01")
 ...I $G(CHAR)="" S CHAR="Unknown"
 ...S:$D(DATA(CHAR))=0 DATA(CHAR)=0 S DATA(CHAR)=DATA(CHAR)+1
 ..I RPTTY=86 D
 ...N SERV S SERV=$$GET1^DIQ(2260,OOPDA,RPTTY_":.01")
 ...I $G(SERV)="" S SERV="Unknown"
 ...S:$D(DATA(SERV))=0 DATA(SERV)=0 S DATA(SERV)=DATA(SERV)+1
 ..I RPTTY=30 D
 ...N BODY S BODY=$$GET1^DIQ(2260,OOPDA,RPTTY_":1")
 ...F I=1:1 Q:$P($T(BODY+I),";",3)="Q"  I $P($T(BODY+I),";",4)[(U_BODY_U) S BODY=$P($T(BODY+I),";",3) Q
 ...I $G(BODY)="" S BODY="Unknown"
 ...S:$D(DATA(BODY))=0 DATA(BODY)=0 S DATA(BODY)=DATA(BODY)+1
 ..I RPTTY=999 D
 ...N DOI,DOW
 ...S DOI=$$GET1^DIQ(2260,OOPDA,4,"I"),DOW=$$DOW^XLFDT(DOI)
 ...S DOW=$S(DOW="Friday":"6Friday",DOW="Monday":"2Monday",DOW="Saturday":"7Saturday",DOW="Sunday":"1Sunday",DOW="Thursday":"5Thursday",DOW="Tuesday":"3Tuesday",DOW="Wednesday":"4Wednesday",1:"Unk")
 ...I $G(DOI)="" S DOI="Unknown"
 ...S:$D(DATA(DOW))=0 DATA(DOW)=0 S DATA(DOW)=DATA(DOW)+1
 ..I RPTTY=9999 D
 ...N LABEL,TDOI,TIME S TDOI=$P($$GET1^DIQ(2260,OOPDA,4),"@",2)
 ...I $G(TDOI)="" S TDOI="Unknown"
 ...I TDOI'="Unknown" D
 ....I +$P(TDOI,":")&($P(TDOI,":")'=24) S TIME=$P(TDOI,":")
 ....E  S TIME=24
 ....S LABEL=TIME_":"_"00 - "_TIME_":59"
 ...I TDOI="Unknown" S LABEL="Unknown"
 ...S:$D(DATA(LABEL))=0 DATA(LABEL)=0 S DATA(LABEL)=DATA(LABEL)+1
 S TOT=1,NODE="",CNT=0
 F  S NODE=$O(DATA(NODE)) Q:NODE=""  S RESULTS(TOT)=NODE_"^"_DATA(NODE),CNT=CNT+$P(RESULTS(TOT),U,2),TOT=TOT+1
 I CNT S RESULTS(0)=CNT
 Q
REPORT() ; Get Fld # to sort on
 I TRPT="Type of Incidents" S RPTTY=3
 I TRPT="Occupation Code" S RPTTY=15
 I TRPT="Characterization of Injury" S RPTTY=29
 I TRPT="Service" S RPTTY=86
 I TRPT="Body Parts" S RPTTY=30
 I TRPT="Day of Week" S RPTTY=999
 I TRPT="Time of Day" S RPTTY=9999
 Q RPTTY
BODY ; group the body parts to min # of columns
 ;;Abdomen;^BA^V5^VI^V4^V3^VL^VM^VS^
 ;;Arm(s) Lower;^AS^AB^A4^A6^A3^A5^
 ;;Arm(s) Upper;^AX^AZ^A2^A1^
 ;;Back (Lumbar Region);^BL^
 ;;Back (Upper);^BU^
 ;;Chest;^BC^RS^
 ;;Ear(s);^H4^C2^H3^C1^
 ;;Elbow;^EB^ES^
 ;;Eye(s);^H2^C4^H1^C3^
 ;;Face;^CK^HC^HF^CJ^HM^CM^HN^CN^CD^CT^
 ;;Foot,Includes Toes;^PB^G2^G3^G4^PS^G1^
 ;;Hand(s),Includes fingers;^F2^F8^MB^F4^F6^TB^FB^FS^F1^F7^MS^F3^F5^TS^
 ;;Knees;^KB^KS^
 ;;Leg(s), lower;^L4^L3^
 ;;Leg(s), upper;^LX^LZ^
 ;;Neck;^HK^CL^CR^
 ;;Not Elsewhere Classified;^XZ^L2^LB^BZ^XX^VN^RP^LS^L1^
 ;;Reproductive Organs;^B2^B4^BP^VR^B1^B3^B5^
 ;;Ribs;^RB^RC^
 ;;Shoulder;^R2^R4^SB^R1^R3^SS^
 ;;Skull/Head;^CB^HX^HZ^CX^CZ^HS^CC^CS^
 ;;Spinal Cord;^VC^RV^
 ;;Thorax;^VH^V2^V1^
 ;;Trunk;^BS^RZ^BX^VX^VZ^RX^BW^
 ;;Q
 Q
ACCID(RESULTS,INPUT,CALL) ; Print Accident Report Status report - get data
 ;  Input: INPUT - START,END DATE, & STATION. Format is STARTDATE^ 
 ;           ENDDATE^STA^CASESTATUS.  STA is A or IEN of station,
 ;           case status = open 'O', closed 'C', or both 'A'.
 ;         CALL - calling menu. Excludes name if called from Union menu
 ; Output:  - RESULTS contains the data to be displayed in the report
 N ARR,CN,IEN,SDATE,SIGN,SIGSTR,STDT,STA,ENDDT,EDATE,X,Y,SUPSTR,EMPSTR
 N CASE,CAT,DOI,EMP,INC,ISEMP,PERSON,SAF,SSN,SSN1,SP,SUP,WCP,PCE
 ; patch 4 llh - select by case status ; patch 11, get super's name
 N CS,STATUS,SUPER,S48,S6,S20,S12
 S S48="                                                "
 S S6="      ",S12="            ",S20="                    "
 K ^TMP($J,"ACCID")
 S CN=1,RESULTS(0)="Processing..."
 S STDT=$P($G(INPUT),U),ENDDT=$P($G(INPUT),U,2)
 S STA=$P($G(INPUT),U,3),STATUS=$P($G(INPUT),U,4)
 I (STDT="")!(ENDDT="")!(STA="")!(STATUS="") D  Q
 .S RESULTS(0)="Input parameters missing, cannot run report." Q
 S STATUS=$S(STATUS="O":0,STATUS="C":1,1:"")
 S (SDATE,EDATE)=""
 S X=STDT D ^%DT S SDATE=Y
 S X=ENDDT D ^%DT S EDATE=Y
 S SDATE=(SDATE-1)_".9999",EDATE=EDATE_".9999"
 S SSN="" I CALL="Employee" S SSN=$$GET1^DIQ(200,DUZ,9)
 S LP="",IEN=""
 F LP=SDATE:0 S LP=$O(^OOPS(2260,"AD",LP)) Q:(LP'>0)!(LP>EDATE)  D
 .F  S IEN=$O(^OOPS(2260,"AD",LP,IEN)) Q:IEN'>0  D
 ..S CS=$$GET1^DIQ(2260,IEN,51,"I")
 ..I $G(CS)>1 Q               ; exclude deleted, amended cases
 ..I (STATUS'=""),(CS'=STATUS) Q  ; if 'All cases, status must match
 ..S STATION=$P(^OOPS(2260,IEN,"2162A"),U,9)
 ..I $G(STA)'="A",STATION'=STA Q
 ..I (CALL="Supervisor"),($$GET1^DIQ(2260,IEN,53,"I")'=DUZ&($$GET1^DIQ(2260,IEN,53.1,"I")'=DUZ)) Q
 ..S (ARR,CASE,PERSON,SSN1,DOI,INC,CAT,WCP,EMP,SUP,SUPER,SAF,SP)=""
 ..S CASE=$$GET1^DIQ(2260,IEN,.01),SUPER=$$GET1^DIQ(2260,IEN,53)
 ..S (PERSON,SSN1)=""
 ..;V2_P15 - changed the SSN display for privacy act concerns
 ..I CALL'="Union" S PERSON=$E($$GET1^DIQ(2260,IEN,1),1,30),SSN1="xxx-xx-"_$E($$GET1^DIQ(2260,IEN,5),8,12)
 ..S INC=$$GET1^DIQ(2260,IEN,52,"I"),DOI=$$GET1^DIQ(2260,IEN,4)
 ..S CAT=$$GET1^DIQ(2260,IEN,2,"I")
 ..; patch 4 llh - get case status title
 ..S CS=$S(CS=0:"Open",CS=1:"Closed",1:"") I SSN1="" S SSN1="           "
 ..S ARR=" ",^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..S ARR="Case Number   Name                                 SSN              Case Status    Date/Time of Incident"
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..S PERSON=PERSON_"                            ",PERSON=$E(PERSON,1,37)
 ..I $L(CASE)=10 S CASE=CASE_" "
 ..;patch 4 llh - pad case status title if needed for alignment
 ..I $L(CS)=4 S CS=CS_"  "
 ..S ARR=CASE_"   "_PERSON_SSN1_"      "_CS_"         "_DOI
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..I CALL="Employee" Q:SSN'=SSN1
 ..S ISEMP=$$ISEMP^OOPSUTL4(IEN)
 ..I 'ISEMP S ISEMP="N/A("_$E($$GET1^DIQ(2260,IEN,2,"E"),1,10)_")"
 ..S SIGN="",SIGSTR="^^^^^^"
 ..S SIGN=$P($$EDSTA^OOPSUTL1(IEN,"E"),U,INC)
 ..S $P(SIGSTR,U,INC)=$S('SIGN:"Un-Signed",SIGN:"Signed",1:"")
 ..I 'ISEMP S $P(SIGSTR,U,INC)=ISEMP
 ..S (SIGN,PCE,SUPSTR)=""
 ..S SIGN=$$EDSTA^OOPSUTL1(IEN,"S"),PCE=INC+2
 ..I ISEMP S $P(SIGSTR,U,PCE)=$S('$P(SIGN,U,INC):"Un-Signed",$P(SIGN,U,INC):"Signed",1:"")
 ..S $P(SIGSTR,U,5)=$S($P(SIGN,U,3):"Signed",1:"Un-Signed")
 ..S SIGN="",SIGN=$$EDSTA^OOPSUTL1(IEN,"O")
 ..S $P(SIGSTR,U,6)=$S($P(SIGN,U):"Signed",1:"Un-Signed")
 ..S SIGN="",SIGN=$$GET1^DIQ(2260,IEN,68)
 ..S $P(SIGSTR,U,7)=$S((($P(SIGN,U)="")&ISEMP):"Un-Signed",($P(SIGN,U)'=""):"Signed",1:"")
 ..F I=1:1:7 I $P(SIGSTR,U,I)="Signed" D
 ...I I=1 S $P(SIGSTR,U,1)=$$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,121,"I")),"2DZ")
 ...I I=2 S $P(SIGSTR,U,2)=$$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,223,"I")),"2DZ")
 ...I I=3 S $P(SIGSTR,U,3)=$$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,171,"I")),"2DZ")_" "
 ...I I=4 S $P(SIGSTR,U,4)=$$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,267,"I")),"2DZ")_" "
 ...I I=5 S $P(SIGSTR,U,5)=$$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,46,"I")),"2DZ")
 ...I I=6 S $P(SIGSTR,U,6)=$$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,50,"I")),"2DZ")
 ...I I=7 S $P(SIGSTR,U,7)=$$FMTE^XLFDT(($$GET1^DIQ(2260,IEN,69,"I")),"2DZ")
 ..S ARR=S48_"          "_"CA1"_S12_"CA2"_S12_"2162"_S12_"WCP"
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..S ARR=S48_"          "_"---"_S12_"---"_S12_"----"_S12_"---"
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..S EMPSTR=S20_S20_"     Employee:    "
 ..I INC=1 S ARR=EMPSTR_$P(SIGSTR,U,1)
 ..I INC=2 S ARR=EMPSTR_S12_"   "_$P(SIGSTR,U,2)
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..; patch 11 - add supervisors name
 ..I $G(SUPER)'="" S SUPSTR=SUPER_", Supervisor:    " F I=1:1:58 Q:$L(SUPSTR)>57  S SUPSTR=" "_SUPSTR
 ..E  S SUPSTR=S20_S20_"   Supervisor:    "
 ..I 'ISEMP S SUPSTR=SUPSTR_"         "
 ..I INC=1 D
 ...I $P(SIGSTR,U,3)="Signed" S ARR=SUPSTR_$P(SIGSTR,U,3)_S6_S12_$P(SIGSTR,U,5)
 ...E  S ARR=SUPSTR_$P(SIGSTR,U,3)_S20_" "_$P(SIGSTR,U,5)
 ..I INC=2 D
 ...I $P(SIGSTR,U,4)="Signed" S ARR=SUPSTR_S12_"   "_$P(SIGSTR,U,4)_"   "_$P(SIGSTR,U,5)
 ...E  S ARR=SUPSTR_S12_"   "_$P(SIGSTR,U,4)_S6_$P(SIGSTR,U,5)
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..S ARR=S20_S12_"       Safety Officer:"_S20_S12_"  "_$P(SIGSTR,U,6)
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 ..S ARR=S20_S12_"        Workers' Comp:"_S48_"  "_$P(SIGSTR,U,7)
 ..S ^TMP($J,"ACCID",CN)=ARR,CN=CN+1,ARR=""
 S RESULTS=$NA(^TMP($J,"ACCID"))
 Q
