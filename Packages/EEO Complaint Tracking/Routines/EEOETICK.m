EEOETICK ;HISC/JWR - TASKED BULLETIN TO ALERT EEO SPECIALISTS OF APPROACHING AND PAST DUE DATES OF ACTION ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;**1,4,6**;Apr 27, 1995
 K BLANK,LINE1,LINE2,LINE3
 S $P(BLANK," ",30)="",$P(LINE,"=",20)="",$P(LINE,"=")=BLANK,$P(LINE1," ",10)="",$P(LINE2,"*",52)="",LINE2=LINE1_LINE2
 S:'$D(EFLG) EFLG="P" K EEOT S D0=0
 F  S D0=$O(^EEO(785,D0)) Q:'D0  D
 .I $P($G(^EEO(785,D0,12)),"^",2)="D" Q  ; ignore deleted cases!
 .F CN1=1:1:7 S EDO=$E($T(LINE+CN1),4,240),EDO(1)=+EDO,EDO(2)=$P(EDO,U,2),EDO(3)=$P(EDO,U,3),EDO(4)=$P(EDO,U,4,99) X EDO(4) D
 ..I EDO(1)=14.1 S EDO(3)=EDO(3)+$P($G(^EEO(785,D0,6)),"^",6) ; add extension days before checking counselor days
 ..S X=$G(X) I X'["*" K EDO Q
 ..I X>$S(EFLG="P":EDO(3)-4,1:EDO(3)) Q:EFLG="P"&(X>EDO(3))  D STRING Q
 I $D(EEOT) D XMT
EXIT ;KILL VARIABLES AND QUIT
 K CASE,LINE,EDO,EEOT,BLANK,LINE1,LINE2,LINE3,AZ,F1,^TMP($J),EC1,EFLG Q
STRING ;
 S EEOT($J,D0,EDO(1))="^^"_X_"^"_EDO(1)_"^"_EDO(3) Q
XMT ;Builds ^TMP($J, global for transmission 
 S D0="",F1=12 F  S D0=$O(EEOT($J,D0)) Q:D0'>0  D CASE S EC1="" F  S EC1=$O(EEOT($J,D0,EC1)) Q:EC1'>0  D
 .F AZ=1:1:6 S @("A"_AZ)=$P($G(EEOT($J,D0,EC1)),U,AZ)
 .S ^TMP($J,F1)=$P(^DD(785,EC1,0),U)_" ("_A5_" DAYS PERMITTED)   "_A3_" DAYS HAVE PAST",F1=F1+1 Q
 Q:'$D(^TMP($J))
 S Y=DT D DD^%DT
 S (^TMP($J,1),^TMP($J,3))=LINE2
 S ^TMP($J,2)=LINE1_"**  EQUAL EMPLOYMENT OPPORTUNITY PACKAGE UPDATE  **"
 I EFLG'="P" S ^TMP($J,5)="  Subject: PAST DUE PROCESSING DATES",^TMP($J,8)="     The following cases have processing times which have exceeded",^TMP($J,9)="     the allowable time constraints for the listed processing phases:"
 I EFLG="P" S ^TMP($J,5)="  Subject: NEARING EEO REPORTING DEADLINES",^TMP($J,8)="     The following cases have processing times which are within 4",^TMP($J,9)="     days of the maximum time allowed for the listed processing phases:"
 F EO=4,10,11 S ^TMP($J,EO)=" "
 S ^TMP($J,6)="  Date:    "_Y D TRANS
 Q
CASE ;Grabs case number
 S CASE=$P($G(^EEO(785,D0,5)),U,6)
 S ^TMP($J,F1)=LINE,^TMP($J,F1+1)=" ",^TMP($J,F1+2)="   For case# "_CASE
 S F1=F1+3 Q
TRANS ;Transmits timeliness warning message to members of UPLINK_DATA_SERVER mailgroup
 S ^TMP($J,F1)=LINE
 D DT^DICRW S XMSUB="EEO LIST OF TIMELINESS CONCERNS",XMDUZ=.5
 S XMY("G.UPLINK_DATA_SERVER")=""
 S XMTEXT="^TMP($J,"
 S XMSUB=XMSUB_$S(EFLG="P":" (Nearing Deadlines)",1:" (Deadlines Missed)")
 D ^XMD Q
LINE ;COMPUTED FIELDS CALCULATION (FLD#^TITLE^# OF DAYS MAX^CODE)
 ;;14.1^TOTAL COUNSELOR DAYS^30^S EN1=$S($P($G(^EEO(785,D0,6)),U,3)>0:"6;3",1:"1;2"),EN2="1;12" D INPUT^EEOEOSE
 ;;25^TOTAL DAYS ACCEPTANCE^45^D ACCEPT^EEOUTIL1
 ;;42^TOTAL DAYS ASSIGN INV.^30^S EN1="3;3",EN2="2;5" D INPUT^EEOEOSE
 ;;53^TOTAL DAYS FOR ADVISE/RIGHTS^15^S EN1="2;6",EN2="3;6" D INPUT^EEOEOSE
 ;;55^TOTAL DAYS TO MAKE ELECTION^30^S EN1=$S($P($G(^EEO(785,D0,5)),U,10)>0:"5;10",$P($G(^EEO(785,D0,2)),U,9):"2;9",1:"2;13"),EN2="5;11" D INPUT^EEOEOSE
 ;;57^180 DAYS^180^S EN1="5;11",EN2="1;3" D INPUT^EEOEOSE
 ;;51^TOTAL COUNSELOR REPORT DAYS^5^S EN2="5;7",EN1=$S($P($G(^EEO(785,D0,5)),U,8)>0:"5;8",1:"5;9") D INPUT^EEOEOSE
