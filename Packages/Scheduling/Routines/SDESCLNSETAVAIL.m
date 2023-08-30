SDESCLNSETAVAIL ;ALB/TAW,KML,MGD,LAB - SET CLINIC AVAILABILITY ;Mar 16,2023
 ;;5.3;Scheduling;**800,803,805,809,818,820,833,842,843**;Aug 13, 1993;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
SETCLINAVAIL(RETURN,SDCLINIC,DATES,TIMES,SLOTS,SDEAS) ;INICSET2(.POP,SDIEN,.FDA,.SDCLINIC,.PROVIDER,.DIAGNOSIS,.SPECIALINSTRUCT,.PRIVLIAGEDUSER)
 ; Input:
 ; SDCLIN - [REQ] Name or IEN from file 44
 ; DATES - [opt] String of dates in ISO8601 or FM format separated by a ;
 ; TIMES - [opt] String of time frames in military format separated by a ;
 ;   ex: 0700-1030;1030-1400
 ; SLOTS - [REQ] String of integers separated by a ;
 ;  The number of TIMES and SLOTS must match
 ; SDEAS - [Optional] - Enterprise Appointment Scheduling (EAS) Tracking Number
 ;
 ;if times and slots are empty, logic will remove availability
 ;
 N POP,SDAVAIL,I,SDDOWNUM,DOWNUM,EOF,SDTOTALSLOTS,SDDISPPERHR,SDCLINSTARTHR,SDSOH,SLT,IEN,SDCLINDATA,SDSLOTS,SDTIME,SDDATE,TMPINDX
 N SDRETURN,APPTCNT,ERRARRAY
 S (POP,SDTOTALSLOTS,APPTCNT)=0
 D VALIDATE
 I 'POP D CREATE(SDCLINIC,SDCLINSTARTHR,SLT,SDDOWNUM)
 I 'POP S SDRETURN("ClinicAvailability","Create")="Pattern Filed"
 D BUILDER
 K ERRARRAY
 Q
 ;
VALIDATE ;
 S SDCLINIC=$G(SDCLINIC)
 I SDCLINIC'="",SDCLINIC'?1.N S SDCLINIC=$O(^SC("B",SDCLINIC,""))
 I SDCLINIC,'$D(^SC(SDCLINIC,0)) D ERRLOG(19) Q
 I SDCLINIC="" D ERRLOG(18) Q
 ;
 S IEN=SDCLINIC_","
 D GETS^DIQ(44,IEN,"1912;1914;1917;1918.5","IE","SDCLINDATA","SDMSG")
 S SLT=$G(SDCLINDATA(44,IEN,1912,"I"))
 I SLT=""  D ERRLOG(115)
 I (SLT<10)!(SLT>240)!(SLT?.E1"."1N.N)!($S('(SLT#10):0,'(SLT#15):0,1:1)) D ERRLOG(116)
 S SDDISPPERHR=$G(SDCLINDATA(44,IEN,1917,"I"))
 S SDCLINSTARTHR=$G(SDCLINDATA(44,IEN,1914,"I"),"")
 I SDCLINSTARTHR="" S SDCLINSTARTHR=8
 ;
 N STARTTIME,ENDTIME,TMPTIMES
 S TIMES=$G(TIMES)
 S SLOTS=$G(SLOTS)
 I ((TIMES="")&(SLOTS'=""))!((TIMES'="")&(SLOTS="")) D ERRLOG(52,"Times and slots mismatch")
 I 'POP,$L(TIMES,";")'=$L(SLOTS,";") D ERRLOG(52,"Times and slots mismatch")
 ;
 I $P(DATES,"9999999",1)="" D ERRLOG(52,"Date Missing.  Must have a date indicated.") Q
 I $P(DATES,"9999999",2)'="" D ERRLOG(52,"Indefinite date indicator must be last") Q
 ;
 I TIMES'="" D
 .F I=1:1:$L(TIMES,";") Q:POP  D
 ..S SDTIME=$P(TIMES,";",I)
 ..I SDTIME'?4N1"-"4N D ERRLOG(52,"Invalid time format") Q
 ..I $P(SDTIME,"-",2)>2400 D ERRLOG(52,"Invalid time format") Q
 ..S STARTTIME=$P(SDTIME,"-",1)
 ..S ENDTIME=$P(SDTIME,"-",2)
 ..I +STARTTIME'<+ENDTIME D ERRLOG(52,"Invalid time format") Q
 ..;Do not allow overlapping time frames
 ..I $D(TIMES(STARTTIME)) D ERRLOG(52,"Existing entry with same start time") Q
 ..; STARTTIME can not fall within the previous segment
 ..S TMPINDX=$O(TIMES(STARTTIME),-1)
 ..I TMPINDX D  Q:POP
 ...S TMPTIMES=TIMES(TMPINDX)
 ...I +$P(TMPTIMES,"-",2)>+STARTTIME D ERRLOG(52,"Start time overlaps existing segment") Q
 ..; ENDTIME can not fall within a prior segment
 ..S TMPINDX=$O(TIMES(ENDTIME),-1)
 ..I TMPINDX D
 ...S TMPTIMES=TIMES(TMPINDX)
 ...;Current start time is = or > than previous end time
 ...I STARTTIME'<+$P(TMPTIMES,"-",2) Q
 ...; ENDTIME falls within and existing segment
 ...I +$P(TMPTIMES,"-",1)<+ENDTIME D ERRLOG(52,"End time overlaps existing segment") Q
 ...; An existing segment falls within STARTTIME and ENDTIME
 ...I +$P(TMPTIMES,"-",2)<+ENDTIME D ERRLOG(52,"End time overlaps existing segment") Q
 ..; Is this time segment consistent with slot duration
 ..I '$$CHECKDURATION(STARTTIME,ENDTIME,SLT) D ERRLOG(52,"Time span not consistent with appointment length")
 ..;
 ..S SDSLOTS=+$P(SLOTS,";",I)
 ..I SDSLOTS<1!(SDSLOTS>26) D ERRLOG(125) Q
 ..S TIMES(STARTTIME)=SDTIME_"^"_SDSLOTS
 ..S SDTOTALSLOTS=SDTOTALSLOTS+SDSLOTS
 .I 'POP,$D(TIMES)'>1 D ERRLOG(52,"No valid time segments passed in")
 .;Can't start prior to clinic opening
 .I 'POP,+$O(TIMES(""))<(SDCLINSTARTHR*100) D ERRLOG(52,"Appointments can not start prior to clinic opening")
 ;
 S DATES=$G(DATES)
 S SDDATE=$P(DATES,";",1)
 I SDDATE="" D ERRLOG(45)
 I SDDATE'="" D
 .I SDDATE'?7N S SDDATE=$$ISOTFM^SDAMUTDT(SDDATE)  ;vse-2396
 .I SDDATE'?7N D ERRLOG(46) Q
 .I SDDATE<DT D ERRLOG(71) Q
 .S SDDOWNUM=$$DOW^XLFDT(SDDATE,1),DATES(SDDATE)=""
 .D GETAPPT
 .I $G(ERRARRAY(SDDATE))=1 D ERRLOG(52,"Pending appointments must be cancelled")
 ;
 I 'POP,$D(DATES)'>1 D ERRLOG(52,"No valid dates passed in") Q
 ;
 S EOF=0
 F I=2:1:$L(DATES,";") D  Q:EOF
 .S SDDATE=$P(DATES,";",I)
 .Q:'SDDATE
 .I SDDATE=9999999 S DATES(SDDATE)="",EOF=1 Q  ;Indefinitely
 .I SDDATE'?7N S SDDATE=$$ISOTFM^SDAMUTDT(SDDATE)  ;vse-2396
 .I SDDATE'?7N D ERRLOG(46) Q
 .I SDDATE<DT D ERRLOG(71)
 .I SDDOWNUM'=$$DOW^XLFDT(SDDATE,1) D ERRLOG(52,"Schedule days do not match") S EOF=1
 .S DATES(SDDATE)=""
 .D GETAPPT
 .I $G(ERRARRAY(SDDATE))=1 D ERRLOG(52,"Pending appointments must be cancelled")
 .;I $D(SDRETURN("ClinicAvailability","Appt")) D ERRLOG(52,"Pending appointments must be cancelled")
 ;
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I SDEAS=-1 D ERRLOG(142)
 Q
GETAPPT ;Check if there are any open appts for this date
 N JSON,SDESERR,A,X
 S X=""
 D APPTBYCLINIC^SDESAPPT(.JSON,SDCLINIC,SDDATE_"@0001",SDDATE_"@2359")
 ;D DECODE^XLFJSON("JSON","A","SDESERR") ;removed the decode
 ;Remove any canceled appt
 F  S X=$O(JSON("Appt",X)) Q:'X  D
 .I $P(JSON("Appt",X,"Status"),"CANCELLED",2)'="" Q
 .S APPTCNT=APPTCNT+1
 .M SDRETURN("ClinicAvailability","Appt",APPTCNT)=JSON("Appt",X)
 .S ERRARRAY(SDDATE)=1
 Q
CHECKDURATION(T1,T2,SLT) ;Ensure the appointment lengths align with the time segment
 N H1,H2,M1,M2,SDL,SD1
 S H1=$E(T1,1,2),H2=$E(T2,1,2),M1=$E(T1,3,4),M2=$E(T2,3,4)
 S:M1=0 M1=60,H1=H1-1
 S:M2=0 M2=60,H2=H2-1
 S SD1=M2-M1+((H2-H1)*60),SDL=SD1\SLT
 I SDL*SLT'=+SD1 Q 0
 Q 1
 ;
CREATE(DA,STARTDAY,SLT,DOW) ;
 ;DA = Clinic IEN  (SDCLINIC)
 ;SLT - Appointment length
 N D0,X,CNT,STARTTIME,T1,T2,NSL,CTR,DR,HY,MAX,SC,SD,SDREB,SDSTRTDT,SDZQ,ST,STR,Y1,INDEFINITELY,STIME
 N LT,H1,H2,M1,M2,SDTOP,SDREACT,X,SI,ZDX,DH,DO,D,Y,SDEL,HSI,SDJJ,HHY,SDIN,SDRE,SDRE1,I,OK,X1,X2,A,SDA1
 S STARTTIME=STARTDAY*100
 S (HSI,SI)=$G(SDDISPPERHR,4)
 S:SI=1 SI=4,HSI=1
 S:SI=2 SI=4,HSI=2
 ;
 ;S DIC(0)="MAQEZL",(DIC,DIE)="^SC("_DA_",""T"",",DIC("W")=$P($T(DOW),";",3)
 S:'$D(^SC(DA,"T",0)) ^SC(DA,"T",0)="^44.002D"
 ;
 S D0=""
 F  S (SD,D0)=$O(DATES(D0)) Q:D0=""  D  Q:POP
 .Q:D0?7"9"
 .S (CNT,INDEFINITELY)=0
 .I $O(DATES(D0))?7"9" S INDEFINITELY=1
 .S STARTTIME=""
 .F  S STARTTIME=$O(TIMES(STARTTIME)) Q:STARTTIME=""  D  Q:POP
 ..S X=TIMES(STARTTIME)
 ..S T2=$P($P(X,"^",1),"-",2)
 ..S NSL=$P(X,"^",2)
 ..S T1=STARTTIME
 ..D G3  ;Set up time slots in the T node
 .;
 .D:'POP G5  ;Set up pattern for the date
 Q
 ;
G3 ;
 ;
 ;SDTOP ??
 ;SDREACT ??
 ;SDSOH - Schedule on holidays
 ;SDIN - Inactivation date
 ;SDRE - Reactivation date
 ;
 S SDTOP=1 ;????
 S SDZQ=1
 ;
 S LT=T2,H1=$E(T1,1,2),H2=$E(T2,1,2),M1=$E(T1,3,4),M2=$E(T2,3,4)
 S M2=M2-SLT
G3A I M2<0 S M2=M2+60,H2=H2-1 G G3A
 S:M2?1N M2="0"_M2 S:H2?1N H2="0"_H2
G4 S CNT=CNT+1,^SC(DA,"T",D0,2,CNT,0)=H1_M1_"^"_NSL
 S M1=M1+SLT
G4A I M1>59 S M1=M1-60,H1=H1+1 G G4A
 S:M1?1N M1="0"_M1 S:H1?1N H1="0"_H1
 I (H1_M1)>(H2_M2) Q
 G G4
 Q
 ;
G5 ;
 S SDEL=0
 G:'CNT DEL1:'$D(SDREACT),DEL1:'$D(SDTOP)&$D(SDREACT)&'CNT,C^SDB
 S ^SC(DA,"T",D0,0)=D0,^SC(DA,"T",D0,2,0)="^44.004A^"_CNT_"^"_CNT
 S X=^SC(DA,"T",0),^SC(DA,"T",0)="^44.002D^"_D0_"^"_($P(X,"^",4)+1)
 S DH=SLT*SI\60
 F ZDX=CNT:0 S ZDX=$O(^SC(DA,"T",D0,2,ZDX)) Q:ZDX=""  K ^SC(DA,"T",D0,2,ZDX)
 F X=0:0 S X=$O(^SC(DA,"T",D0,2,X)) Q:X=""  D
 .S Y=^SC(DA,"T",D0,2,X,0)
 .F D=1:1:DH S Y(Y#100*SI\60+(Y\100*SI)-(STARTDAY*SI)+D)=$S($P(Y,U,2):$E("123456789jklmnopqrstuvwxyz",$P(Y,U,2)),1:0)
 S (DH,DO,X)=""
 I $D(Y)=1 S SDEL=1 G D
 I $D(HSI) I HSI=1!(HSI=2) D CKSI1
 F Y=1:1 S DH=$D(Y(Y)),X=X_$S('DH&DO:"]",'DO&DH:"[",Y#SI=1:"|",1:" ")_$S(DH:Y(Y),1:" "),DO=DH I 'DH,$O(Y(Y))="" Q
 ; CHECK WITH DARRYL & ANGELA RELATED TO NEXT LINE
 K Y
 I SI+SI+$L(X)>80 K ^SC(DA,"T",D0) S CNT=0,LT=$G(STIME),SDEL=0 D ERRLOG(52,"Availability string exceeds 80 characters") Q
 G D
CKSI1 F SDJJ=$O(Y(-1)):$S(HSI=1:4,1:2) Q:SDJJ>41  S:$D(Y(SDJJ)) HY(SDJJ)="" I '$D(Y(SDJJ)) Q:$O(Y(SDJJ))=""  S SDJJ=$O(Y(SDJJ-1))-$S(HSI=1:4,1:2)
 F HHY=0:0 S HHY=$O(Y(HHY)) Q:HHY=""  I '$D(HY(HHY)) K Y(HHY)
 Q
 ;
DEL1 S (DH,DO,X)="",SDEL=1
D I $D(SDIN),SDIN>D0 S SDRE1=$S(SDRE:SDRE,1:9999999)
 S DH=X,OK=0,CTR=0
 S SDSOH=$S('$D(^SC(DA,"SL")):0,$P(^SC(DA,"SL"),"^",8)']"":0,1:1)
 F X=D0:0 S X=+$O(^SC(DA,"T",X)) Q:X'>0  D DOW^SDM0 I Y=DOW S Y=X,DO=Y G R
 I X'>0,$D(SDIN),SDIN>D0 D
 .S SDRE1=$S(SDRE=0:9999999,1:SDRE)
 .S X=SDIN
 .F I=0:1:6 D DOW^SDM0 S:Y=DOW OK=1 Q:OK  S X1=X,X2=1 D C^%DTC Q:X>SDRE1
 I OK S Y=X,DO=D0 G R
 S DO=9999999
R K OK
 ; CHECK ON AVAILABILITY DATE W D&A THEN REVIEW G1^SDB
EN1 ;
 S D=D0
 I 'INDEFINITELY G 1
 S Y=""
 I '$D(^SC(DA,"T"_DOW,D0,1)) D
 .S Y=+$O(^SC(DA,"T"_DOW,D0))
 .I Y>D0 S X=^SC(DA,"T"_DOW,Y,1),POP=0 D CHK1 K:'POP ^SC(DA,"T"_DOW,Y) S ^SC(DA,"T"_DOW,D0,1)=X,^SC(DA,"T"_DOW,D0,0)=D0 D TX
 I Y<0,'$D(^SC(DA,"T"_DOW,D0)) S ^SC(DA,"T"_DOW,D0,1)="",^SC(DA,"T"_DOW,D0,0)=D0 D TX
 S ^SC(DA,"T"_DOW,DO,1)=DH,^SC(DA,"T"_DOW,DO,0)=DO D TX
 S X=D0 D B1^SDB1 S MAX=30,SC=DA,SDSTRTDT=SD
 Q:'CNT
 D OVR^SDAUT1 Q:'SDZQ
 Q
 ;
1 I SDEL S POP=0 D APPCK I POP D DELERR G OVR
11 G:$D(^HOLIDAY(D,0))&('SDSOH) OVR
 S POP=0
 D:$D(SDIN) CHK2
 G:POP OVR
 S (POP,SDREB)=0
 S %=1
 D APPCK
 I POP D APPERR G:(%-1) OVR S SDREB=1
 S X=D,DO=X+1,^SC(DA,"ST",X,9)=D,SDREACT=1
 S:'$D(^SC(DA,"ST",0)) ^SC(DA,"ST",0)="^44.005DA^^" D B1^SDB1  ;SD*567 change set of 9 node to selected date
OVR ;
 I D#100<22 S D=D+7 S POP=0 D:$D(SDIN) CHK2 Q
 S X1=D,X2=7 D C^%DTC S D=X S POP=0 D:$D(SDIN) CHK2 Q
 ;
APPCK ;Are there appointments for this time?
 Q
 ;Temporary change appointment has already been checked above, quick fix, logic to be removed during rewrite
 F A=D:0 S A=+$O(^SC(DA,"S",A)) Q:A'>0!(A\1-D)  F SDA1=0:0 S SDA1=+$O(^SC(DA,"S",A,1,SDA1)) Q:SDA1'>0  I $P(^SC(DA,"S",A,1,SDA1,0),"^",9)'["C" S POP=1 Q
 Q
APPERR ;
 N %
 W *7,!,"THERE ARE ALREADY APPOINTMENTS PENDING ON THIS DATE",!,"ARE YOU SURE YOU WANT TO CHANGE THE EXISTING AVAILABILITY" S %=2 D YN^DICN
 I '% W !,"IF YOU SAY YES, THE EXISTING APPOINTMENTS MAY BECOME OVERBOOKS WHEN THE NEW AVAILABILITY IS APPLIED",!,"ANSWER YES OR NO" G APPERR
 Q
DELERR ;
 S Y=D
 W !,"... " D DT^DIQ W " HAS PENDING APPTS - DELETE AVAILABILITY NOT ALLOWED" Q
CHK1 Q:'$D(SDIN)
 I Y=SDIN S POP=1
 Q
 ;
CHK2 ;
 I SDIN<D,SDRE,SDRE'>D K SDIN Q
 I SDIN<D,SDRE=0 S POP=1 Q
 I SDIN<D,SDRE>D S POP=2,D=SDRE,X=D F I=0:1:6 D DOW^SDM0 Q:Y=DOW  S X1=D,X2=1 D C^%DTC S D=X
 S Y=SDIN D DTS^SDUTL S Y1=Y,Y=SDRE1 D DTS^SDUTL W:POP=2&('CTR) !!,"    Clinic is inactive from ",Y1," to ",Y,! S:POP=2 CTR=1
 Q
OB ;
 S SDSLOT=$E(STR,$F(STR,ST)-2)
 I SDSLOT?1P,SDSLOT'?1" " S ^SC(DA,"S",DR,1,Y,"OB")="O" K SDSLOT Q
 K ^SC(DA,"S",DR,1,Y,"OB"),SDSLOT
 Q
TX ;
 S:'$D(^SC(DA,"T"_DOW,0)) ^SC(DA,"T"_DOW,0)="^44.0"_$S(DOW<4:DOW+6,DOW<6:"0"_DOW+4,1:"001")_"A^^" Q
 ;
ERRLOG(ERNUM,OPTIONALTXT) ;
 S POP=1
 D ERRLOG^SDESJSON(.SDRETURN,$G(ERNUM),$G(OPTIONALTXT))
 Q
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDRETURN,.RETURN,.JSONERR)
 Q
