SCRPW71 ;BP-CIOFO/KEITH - Clinic appointment availability extract (cont.) ; 14 May 99  9:19 PM
 ;;5.3;Scheduling;**192**;AUG 13, 1993
 ;
CLINIC(SC,SDFMT,SDSTRTDT,MAXDT,MAX,SDPAST) ;Evaluate a clinic
 ;Input: SC=clinic ifn
 ;Input: SDFMT='S' for totals only, 'D' for detail and totals
 ;Input: SDSTRTDT=begin date for data extraction
 ;Input: MAXDT=end date for data extraction
 ;Input: MAX=number of days in date range
 ;Input: SDPAST='0' for future dates, '1' for past dates
 ;Output: # of slots found^maximum capacity^error condition (1=success,-1=failure)^comment (if failure) or sort value (if success)
 N SC0,SDCP,X1,X2,X,%H,SDIV
 S SC0=$G(^SC(SC,0)) Q:$P(SC0,U,3)'="C" "0^0^-1^Not a clinic location type"
 Q:$P(SC0,U,17)="Y" "0^0^-1^Clinic defined as non-count"
 Q:'$$CPAIR(SC0,.SDCP) "0^0^-1^Not a valid primary clinic Stop Code"
 S X2=$P($G(^SC(SC,"SDP")),U,2) I X2 S X1=DT D C^%DTC S:X<MAXDT MAXDT=X
 Q:'$$ACTC(SC,SDSTRTDT,MAXDT) "0^0^-1^Clinic is inactivated during these dates"
 S SDIV=$$DIV(SC0) Q:'$L(SDIV) "0^0^-1^Invalid division number"
 D SPAT(SC,SDSTRTDT,MAXDT)
 Q $$CCNT(SC,MAX,SDCP,SDFMT,SDSTRTDT,SDIV,SDPAST)_"^1^"_SDCP_U_SC
 ;
DIV(SC0) ;Get facility division name and number
 ;Input: SC0=hospital location zeroeth node
 N SDIV S SDIV=$P(SC0,U,15)
 Q:SDIV>0 $P($$SITE^VASITE(,SDIV),U,2,3)
 Q $P($$SITE^VASITE(),U,2,3)
 ;
CPAIR(SC0,SDCP) ;Validate primary stop code, get credit pair
 ;Input: SC0=zeroeth node of HOSPITAL LOCATION record
 ;Input: SDCP=variable to return clinic credit pair (pass by reference)
 ;Output: 1=success, 0=invalid primary stop code
 N SDSSC
 S SDCP=$P($G(^DIC(40.7,+$P(SC0,U,7),0)),U,2),SDCP=$S(SDCP<100:0,SDCP>999:0,1:SDCP)
 Q:SDCP'>0 0
 S SDSSC=$P($G(^DIC(40.7,+$P(SC0,U,18),0)),U,2),SDCP=SDCP_$S(SDSSC<100:"000",SDSSC>999:"000",1:SDSSC)
 Q 1
 ;
ACTC(SC,SDSTRTDT,MAXDT) ;Determine if clinic is active during date range
 ;Input: SC=clinic ifn
 ;Input: SDSTRTDT=begin date for evaluation (TODAY+1)
 ;Input: MAXDT=maximum date in the future to evaluate (end date)
 ;Output: 1=active, 0=inactive during entire date range
 N SDIN,SDRE,X1,X2,X,%H
 S SDIN=$G(^SC(SC,"I")),SDRE=$P(SDIN,U,2),SDIN=$P(SDIN,U)
 Q:SDIN<1 1  Q:SDIN>SDSTRTDT 1
 I SDRE,SDRE'>MAXDT Q 1
 Q 0
 ;
SPAT(SC,SDSTRTDT,ENDATE,SDS) ;Set patterns into ^TMP (modified clone of OVR^SDAUT1)
 ;Input: SC=clinic ifn
 ;Input: SDSTRTDT=start date for gathering patterns
 ;Input: ENDATE=date in future to evaluate to
 ;Input: SDS=array namespace subscript value (optional)
 ;Output: array of clinic current availability patterns in
 ;        ^TMP(SDS,$J,clinic_ifn,"ST",date,1)
 ;
 S SDS=$G(SDS) S:'$L(SDS) SDS="SDTMP" K ^TMP(SDS,$J)
 N SI,SDIN,SDRE,SDSOH,X,X1,X2,SM,I,D,J,Y,SS,DAY
 S SDIN=$G(^SC(SC,"I")),SDRE=$P(SDIN,U,2),SDIN=$P(SDIN,U)
 S DAY="SU^MO^TU^WE^TH^FR^SA"
 S SI=$P($G(^SC(SC,"SL")),U,6),SI=$S(SI<3:4,1:SI)
 S SDSOH=$S('$D(^SC(SC,"SL")):0,$P(^SC(SC,"SL"),"^",8)']"":0,1:1)
 S SDIN=$G(SDIN),X=SDSTRTDT
EN1 S:$O(^SC(SC,"T",0))>X X=$O(^SC(SC,"T",0))
 S Y=$$DOW^XLFDT(X,1),I=Y+32,SM=X,D=Y D WM
 K J F Y=0:1:6 I $D(^SC(+SC,"T"_Y)) S J(Y)=""
 I '$D(J) D  Q
 .S D=SDSTRTDT-1 F  S D=$O(^SC(SC,"ST",D)) Q:'D!(D>ENDATE)  D
 ..S X=$G(^SC(SC,"ST",D,1)) S:$L(X) ^TMP(SDS,$J,SC,"ST",D,1)=X Q
 .Q
X1 Q:X>ENDATE  S X1=X\100_28
 I '$$ACTIVE(X,SDIN,SDRE) S X1=X,X2=1 D C^%DTC G X1
W S X=X\1
 I $D(^SC(+SC,"ST",X,1)) S ^TMP(SDS,$J,SC,"ST",X,1)=^SC(+SC,"ST",X,1) G W1
 I '$D(^SC(SC,"ST",X,1)) S Y=D#7 G L:'$D(J(Y)),H:$D(^HOLIDAY(X))&('SDSOH) S SS=$O(^SC(SC,"T"_Y,X)) G L:SS<1,L:^SC(SC,"T"_Y,SS,1)="" D
 .S ^TMP(SDS,$J,SC,"ST",X\1,1)=$P(DAY,U,Y+1)_" "_$E(X,6,7)_$J("",SI+SI-6)_^SC(SC,"T"_Y,SS,1) Q
W1 D WM:X>SM
L Q:X>ENDATE  S X=X+1,D=D+1 G W:X'>X1 S X2=X-X1 D C^%DTC G X1
 ;
H S ^TMP(SDS,$J,SC,"ST",X,1)="   "_$E(X,6,7)_"    "_$P(^(X,0),U,2) G W1
 ;
WM S SM=$S($E(X,4,5)[12:$E(X,1,3)+1_"01",1:$E(X,1,3)_$E(X,4,5)+1)_"00" Q
 ;
ACTIVE(X,SDIN,SDRE) ;Determine if the clinic is active on a given date
 ;Input: X=date to be examined
 ;Input: SDIN=clinic inactive date
 ;Input: SDRE=clinic reactivate date
 ;Output: '1'=active, '0'=inactive
 Q:'SDIN 1  Q:X<SDIN 1  Q:'SDRE 0  Q:X<SDRE 0  Q 1
 ;
INIT ;Initialize array for counting patterns
 K SD N SDI
 S SD="123456789jklmnopqrstuvwxyz"
 F I=1:1:26 S SD($E(SD,I))=I
 Q
 ;
CCNT(SC,MAX,SDCP,SDFMT,SDSTRTDT,SDIV,SDPAST) ;Count clinic availability and capacity
 ;Input: SC=clinic ifn
 ;Input: MAX=maximum days to evaluate availability
 ;Input: SDCP=credit pair
 ;Input: SDFMT=report format
 ;Input: SDSTRTDT=begin date of report
 ;Input: SDIV=clinic division number
 ;Input: SDPAST='0' for future dates, '1' for past dates
 ;Output: total # of open slots found^maximum capacity
 ;Output: Creates an array of:
 ;        ^TMP("SD",$J,SDIV,SDCP)=open slots^maximum capacity^encounters
 ;        ^TMP("SD",$J,SDIV,SDCP,SC)=open slots^maximum capacity^encounters
 ;        ^TMP("SD",$J,SDIV,SDCP,SC,sub)=slots~capacity~encounters^slots~capacity~encounters ... etc. (up to 12 slots~capacity~encounters values)
 ;                               where 'sub' is a number 0 to nnn, 'sub' * 12 + "^" $PIECE where the data
 ;                               is stored equals the day which that data represents.
 ;
 N SDTOE
 S SDTOE=U_$P($G(^TMP("SD",$J,SDIV,SDCP,SC)),U,3) S:$L(SDTOE)=1 SDTOE=""
 Q:'$D(^TMP("SDTMP",$J)) "0^0"_SDTOE
 D:'$D(^TMP("SD",$J,SDIV,SDCP,SC)) ARRINI(SDCP,SC,MAX,SDPAST)
 N SDDAY,SDI,SDPATT,SDTSL,SDSL,SDTCAP,SDCAP,SDY
 S X1=SDSTRTDT,X2=-1 D C^%DTC S SDY=X
 S (SDTSL,SDTCAP)=0 F SDI=1:1:MAX D
 .S (SDSL,SDCAP)=0,X1=SDY,X2=SDI D C^%DTC S SDDAY=X
 .;Count open slots
 .S SDPATT=$E($G(^TMP("SDTMP",$J,SC,"ST",SDDAY,1)),6,999)
 .I SDPATT["[" D
 ..S SDSL=$$PCT(SDPATT),SDTSL=SDTSL+SDSL
 ..;Count maximum slots
 ..N X,%H,%T,%Y,SDDW,SDMPDT
 ..S SDCAP=0
 ..S SDPATT=$E($G(^SC(SC,"OST",SDDAY,1)),6,999) I $L(SDPATT) S SDCAP=$$PCT(SDPATT),SDTCAP=SDTCAP+SDCAP Q:SDCAP
 ..S X=SDDAY D H^%DTC S SDDW="T"_%Y,SDMPDT=$O(^SC(SC,SDDW,SDDAY))
 ..S SDPATT=$G(^SC(SC,SDDW,+SDMPDT,1)),SDCAP=$$PCT(SDPATT),SDTCAP=SDTCAP+SDCAP
 ..Q
 .D:SDFMT="D" ARRSET(SDCP,SC,SDI,SDSL,SDCAP) Q
 S $P(^TMP("SD",$J,SDIV,SDCP),U)=$P(^TMP("SD",$J,SDIV,SDCP),U)+SDTSL
 S $P(^TMP("SD",$J,SDIV,SDCP),U,2)=$P(^TMP("SD",$J,SDIV,SDCP),U,2)+SDTCAP
 S $P(^TMP("SD",$J,SDIV,SDCP,SC),U)=$P(^TMP("SD",$J,SDIV,SDCP,SC),U)+SDTSL
 S $P(^TMP("SD",$J,SDIV,SDCP,SC),U,2)=$P(^TMP("SD",$J,SDIV,SDCP,SC),U,2)+SDTCAP
 I SDPAST D
 .S $P(^TMP("SD",$J,SDIV,SDCP),U,3)=$P(^TMP("SD",$J,SDIV,SDCP),U,3)+0
 .S $P(^TMP("SD",$J,SDIV,SDCP,SC),U,3)=$P(^TMP("SD",$J,SDIV,SDCP,SC),U,3)+0 Q
 Q SDTSL_U_SDTCAP_SDTOE
 ;
PCT(SDPATT) ;Pattern count
 ;Input: SDPATT=pattern to evaluate
 Q:SDPATT'["[" 0
 N X,I S X=0
 S SDPATT=$TR(SDPATT," |[]","")
 F I=1:1:$L(SDPATT) S X=X+$G(SD($E(SDPATT,I)))
 Q X
 ;
ARRINI(SDCP,SC,MAX,SDPAST) ;Initialize array for counts
 ;Input: SDCP=credit pair
 ;Input: SC=clinic ifn
 ;Input: MAX=maximum days to report
 ;Input: SDPAST='0' for future dates, '1' for past dates
 N SDI,SDX,SDY,SDS,SDP
 S SDY="0~0" S:SDPAST SDY=SDY_"~0"
 S SDX="" F SDI=1:1:(2+SDPAST) S $P(SDX,U,SDI)=0
 S:'$D(^TMP("SD",$J,SDIV,SDCP)) ^TMP("SD",$J,SDIV,SDCP)=SDX
 S ^TMP("SD",$J,SDIV,SDCP,SC)=SDX Q:SDFMT'="D"
 F SDI=0:1:(MAX-1\12) S ^TMP("SD",$J,SDIV,SDCP,SC,SDI)=""
 F SDI=1:1:MAX D
 .S SDS=SDI-1\12,SDP=SDI#12 S:SDP=0 SDP=12
 .S $P(^TMP("SD",$J,SDIV,SDCP,SC,SDS),U,SDP)=SDY
 .Q
 Q
 ;
ARRSET(SDCP,SC,SDI,SDSL,SDCAP) ;Set daily counts into array
 ;Input: SDCP=credit pair
 ;Input: SC=clinic ifn
 ;Input: SDI=number of days from report date
 ;Input: SDSL=number of open slots for day SDI
 ;Input: SDCAP=maximum slots for day SDI
 N SDS,SDP,SDX
 S SDS=SDI-1\12,SDP=SDI#12 S:SDP=0 SDP=12
 S SDX=$P(^TMP("SD",$J,SDIV,SDCP,SC,SDS),U,SDP)
 S $P(SDX,"~")=$P(SDX,"~")+SDSL
 S $P(SDX,"~",2)=$P(SDX,"~",2)+SDCAP
 I $G(SDPAST),$P(SDX,"~",3)="" S $P(SDX,"~",3)=0
 S $P(^TMP("SD",$J,SDIV,SDCP,SC,SDS),U,SDP)=SDX
 Q
 ;
PCNT(X) ;Count open slots in a pattern
 ;Input: X=^SC(SC,"ST",SDT,1) node
 ;Output: number of open slots in a single date pattern
 N I,CT
 S CT=0 Q:X'["[" CT
 S X=$E(X,6,999),X=$TR(X,"|[] ","")
 F I=1:1:$L(X) S CT=CT+$G(SD($E(X,I)))
 Q CT
