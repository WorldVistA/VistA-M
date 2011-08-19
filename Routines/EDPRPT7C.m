EDPRPT7C ;SLC/MKB - Exposure Report (CSV format)
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
EXP(IEN) ; Get Exposure Report for IEN at EDPSITE
 S IEN=+$G(IEN)  Q:IEN<1  Q:'$D(^EDP(230,IEN,0))
 N BEG,END,LIST,LOG,IN,OUT,X,X0,Y,RLIST,TREAT,OTHER,MD,RN,RES,I,J,RIN,ROUT,TAB
 N SHIFT D SETUP^EDPRPT5 ;build SHIFT(#)
 I 'SHIFT D ERR^EDPRPT(2300013) Q
 S X0=^EDP(230,IEN,0),BEG=$P(X0,U,8),END=$P(X0,U,9),TAB=$C(9)
 S:'BEG BEG=$P(X0,U) S:'END END=$$NOW^EDPRPT
 D ROOMS(IEN,END)
 ; put IEN info into CSV
 S X="ED"_TAB_"Room"_TAB_"Shift - Time In"_TAB_"Shift - Time Out"_TAB_"Diagnosis"_TAB_"Dispo"_TAB_"Arr Mode"_TAB_"Notes"
 D ADD^EDPCSV(X),BLANK^EDPCSV ;headers
 S X=TAB_TAB_"Contagious Patient Information"
 D ADD^EDPCSV(X),BLANK^EDPCSV
 D ADD(IEN),STAFF(IEN)
 D BLANK^EDPCSV
E1 ; look for patients also in ED between BEG and END
 D FIND(BEG,END) ;create LIST(#) list of ien's to check
 S LOG=0 F  S LOG=+$O(LIST(LOG)) Q:'LOG  I LOG'=IEN D
 . S X0=$G(^EDP(230,LOG,0)),IN=$P(X0,U,8),OUT=$P(X0,U,9)
 . D ROOMS(LOG,OUT)
 . ; compare treatment rooms
 . S I=0 F  S I=$O(RLIST(IEN,I)) Q:I<1  D
 .. S RIN=$P(RLIST(IEN,I),U,2),ROUT=$P(RLIST(IEN,I),U,3)
 .. S J=0 F  S J=$O(RLIST(LOG,J)) Q:J<1  I +RLIST(IEN,I)=+RLIST(LOG,J) D
 ... S X=$P(RLIST(LOG,J),U,2) Q:X>ROUT     ;in to room after IEN left
 ... ;I (RIN<=X)&(X<=ROUT) S TREAT(LOG)="" Q
 ... S X=$P(RLIST(LOG,J),U,3) Q:X&(X<RIN)  ;out of room before IEN came
 ... ;I (RIN<=X)&(X<=ROUT) S TREAT(LOG)="" Q
 ... S TREAT(LOG)=""
 . I '$D(TREAT(LOG)) S OTHER(LOG)=""
E2 ; return treatment room patients
 D ADD^EDPCSV(TAB_TAB_"Exposed in Treatment Room"),BLANK^EDPCSV
 I '$O(TREAT(0)) D ADD^EDPCSV(TAB_TAB_"  None")
 E  S LOG=0 F  S LOG=$O(TREAT(LOG)) Q:LOG<1  D ADD(LOG),STAFF(LOG)
 D BLANK^EDPCSV
 ; return other ED patients
 D ADD^EDPCSV(TAB_TAB_"Other ED Patients"),BLANK^EDPCSV
 I '$O(OTHER(0)) D ADD^EDPCSV(TAB_TAB_"  None")
 E  S LOG=0 F  S LOG=$O(OTHER(LOG)) Q:LOG<1  D ADD(LOG),STAFF(LOG)
 D BLANK^EDPCSV
E3 ; return staff on duty
 N MAX,MORE D ADD^EDPCSV(TAB_TAB_"On Duty Staff")
 D ADD^EDPCSV(TAB_"Doctors"_TAB_"Nurses"_TAB_"Residents")
 S MAX=+$G(RN) S:$G(MD)>MAX MAX=+MD S:$G(RES)>MAX MAX=+RES
 S MORE=1,(MD,RN,RES)=0 F  D  Q:'MORE
 . S:MD'="" MD=$O(MD(MD)) S:RN'="" RN=$O(RN(RN))
 . S:RES'="" RES=$O(RES(RES)) ;get next
 . I MD="",RN="",RES="" S MORE=0 Q  ;done
 . S X=TAB_$S(MD:MD(MD),1:"")_TAB_$S(RN:RN(RN),1:"")_TAB_$S(RES:RES(RES),1:"")
 . D ADD^EDPCSV(X)
 Q
 ;
FIND(IN,OUT) ; create LIST(#) of visits at same time
 N TIME,I,X K LIST
 S TIME=+$P(IN,".") ;ck today's arrivals
 F  S TIME=$O(^EDP(230,"ATI",EDPSITE,TIME)) Q:TIME<1!(TIME>OUT)  D
 . S I=0 F  S I=$O(^EDP(230,"ATI",EDPSITE,TIME,I)) Q:I<1  D
 .. S X=$P($G(^EDP(230,I,0)),U,9) I X,X<IN Q  ;left before IEN arrived
 .. S LIST(I)=""
 Q
 ;
ROOMS(LOG,OUT) ; Return RLIST(LOG,n)= room ^ time in ^ time out
 N N,D,I,X,LAST S N=0,LAST=""
 S D=0 F  S D=$O(^EDP(230.1,"ADF",LOG,D)) Q:D<1  S I=+$O(^(D,0)) D
 . S X=+$P($G(^EDP(230.1,I,3)),U,4) Q:'X  Q:X=LAST  ;no location change
 . S:N $P(RLIST(LOG,N),U,3)=D ;time in of next room = time out of prev
 . S N=N+1,RLIST(LOG,N)=X_U_D,LAST=X ;new room
 I N,'$P(RLIST(LOG,N),U,3) S $P(RLIST(LOG,N),U,3)=OUT
 Q
 ;
ADD(LOG) ; Add row to CSV for each room used during visit
 N EDPI,EDPX,ROW,LABS,XRAY,X,X0
 S EDPI=0 F  S EDPI=$O(RLIST(LOG,EDPI)) Q:EDPI<1  S EDPX=RLIST(LOG,EDPI) D
 . S ROW=$S(EDPI=1:LOG,1:"")_TAB_$P($G(^EDPB(231.8,+EDPX,0)),U)
 . S X=$P(EDPX,U,2) ;shiftTimeIn
 . S ROW=ROW_TAB_$$SHIFT^EDPRPT5(X)_" - "_$$EDATE^EDPRPT(X)
 . S X=$P(EDPX,U,3) ;shiftTimeOut
 . S ROW=ROW_TAB_$$SHIFT^EDPRPT5(X)_" - "_$$EDATE^EDPRPT(X)
 . S X0=$G(^EDP(230,LOG,0)),X=$$DXPRI^EDPQPCE(+$P(X0,U,3),LOG)
 . S ROW=ROW_TAB_$P(X,U,2) ;Dx
 . S X=$P($G(^EDP(230,LOG,1)),U,2),ROW=ROW_TAB_$$ECODE^EDPRPT(X) ;dis
 . S X=$P(X0,U,10),ROW=ROW_TAB_$$ENAME^EDPRPT(X) ;arrival
 . S LABS=$D(^EDP(230,LOG,8,"AC","L")),XRAY=$D(^("R")),X=""
 . I LABS!XRAY D  S X=X_" ordered"
 .. I LABS&XRAY S X="Labs and Imaging" Q
 .. S:LABS X="Labs" S:XRAY X="Imaging"
 . S ROW=ROW_TAB_X ;notes
 . D ADD^EDPCSV(ROW)
 Q
 ;
STAFF(LOG) ; save staff involved in patient care
 N D,I,X,ACT S LOG=+$G(LOG)
 S D=0 F  S D=$O(^EDP(230.1,"ADF",LOG,D)) Q:D<1  S I=+$O(^(D,0)) D
 . S ACT=$G(^EDP(230.1,I,3))
 . S X=+$P(ACT,U,5) S:X MD(X)=$$EPERS^EDPRPT(X)
 . S X=+$P(ACT,U,6) S:X RN(X)=$$EPERS^EDPRPT(X)
 . S X=+$P(ACT,U,7) S:X RES(X)=$$EPERS^EDPRPT(X)
 Q
