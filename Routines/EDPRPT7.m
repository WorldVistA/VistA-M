EDPRPT7 ;SLC/MKB - Exposure Report
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
EXP(IEN) ; Get Exposure Report for IEN at EDPSITE
 S IEN=+$G(IEN)  Q:IEN<1  Q:'$D(^EDP(230,IEN,0))
 I $G(CSV) D EXP^EDPRPT7C(IEN) Q  ;CSV format instead
 N BEG,END,LIST,LOG,IN,OUT,X,X0,Y,RLIST,TREAT,OTHER,MD,RN,RES,I,J,RIN,ROUT
 N SHIFT D SETUP^EDPRPT5 ;build SHIFT(#)
 I 'SHIFT D ERR^EDPRPT(2300013) Q
 S X0=^EDP(230,IEN,0),BEG=$P(X0,U,8),END=$P(X0,U,9)
 S:'BEG BEG=$P(X0,U) S:'END END=$$NOW^EDPRPT
 D ROOMS(IEN,END)
 ; put IEN info into XML
 D XML^EDPX("<patient>")
 D ADD(IEN),STAFF(IEN)
 D XML^EDPX("</patient>")
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
 I $O(TREAT(0)) D
 . D XML^EDPX("<treatmentRoom>")
 . S LOG=0 F  S LOG=$O(TREAT(LOG)) Q:LOG<1  D ADD(LOG),STAFF(LOG)
 . D XML^EDPX("</treatmentRoom>")
 ; return other ED patients
 I $O(OTHER(0)) D
 . D XML^EDPX("<otherPatients>")
 . S LOG=0 F  S LOG=$O(OTHER(LOG)) Q:LOG<1  D ADD(LOG),STAFF(LOG)
 . D XML^EDPX("</otherPatients>")
E3 ; return staff on duty
 D XML^EDPX("<onDutyStaff>")
 I $O(MD(0)) D
 . D XML^EDPX("<doctors>")
 . S I=0 F  S I=$O(MD(I)) Q:I<1  D
 .. S X="<md name='"_$$ESC^EDPX(MD(I))_"' />"
 .. D XML^EDPX(X)
 . D XML^EDPX("</doctors>")
 I $O(RN(0)) D
 . D XML^EDPX("<nurses>")
 . S I=0 F  S I=$O(RN(I)) Q:I<1  D
 .. S X="<rn name='"_$$ESC^EDPX(RN(I))_"' />"
 .. D XML^EDPX(X)
 . D XML^EDPX("</nurses>")
 I $O(RES(0)) D
 . D XML^EDPX("<residents>")
 . S I=0 F  S I=$O(RES(I)) Q:I<1  D
 .. S X="<md name='"_$$ESC^EDPX(RES(I))_"' />"
 .. D XML^EDPX(X)
 . D XML^EDPX("</residents>")
 D XML^EDPX("</onDutyStaff>")
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
ROOMS(LOG,OUT) ; Return RLIST(LOG,n) = room ^ time in ^ time out
 N N,D,I,X,LAST S N=0,LAST=""
 S D=0 F  S D=$O(^EDP(230.1,"ADF",LOG,D)) Q:D<1  S I=+$O(^(D,0)) D
 . S X=+$P($G(^EDP(230.1,I,3)),U,4) Q:'X  Q:X=LAST  ;no location change
 . S:N $P(RLIST(LOG,N),U,3)=D ;time in of next room = time out of prev
 . S N=N+1,RLIST(LOG,N)=X_U_D,LAST=X ;new room
 I N,'$P(RLIST(LOG,N),U,3) S $P(RLIST(LOG,N),U,3)=OUT
 Q
 ;
ADD(LOG) ; Add row to XML for each room used during visit
 N EDPI,EDPX,ROW,LABS,XRAY,X,X0
 S EDPI=0 F  S EDPI=$O(RLIST(LOG,EDPI)) Q:EDPI<1  S EDPX=RLIST(LOG,EDPI) D
 . K ROW S ROW("id")=LOG ;only return for EDPI=1 ??
 . S ROW("roomName")=$P($G(^EDPB(231.8,+EDPX,0)),U)
 . S X=$P(EDPX,U,2)
 . S ROW("shiftIn")=$$SHIFT^EDPRPT5(X),ROW("inTS")=X
 . S X=$P(EDPX,U,3)
 . S ROW("shiftOut")=$$SHIFT^EDPRPT5(X),ROW("outTS")=X
 . S X=$P($G(^EDP(230,LOG,1)),U,2),ROW("disposition")=$$ECODE^EDPRPT(X)
 . S X0=$G(^EDP(230,LOG,0)),X=$P(X0,U,10),ROW("arrival")=$$ENAME^EDPRPT(X)
 . S X=$$DXPRI^EDPQPCE(+$P(X0,U,3),LOG),ROW("dx")=$P(X,U,2)
 . S LABS=$D(^EDP(230,LOG,8,"AC","L")),XRAY=$D(^("R")),X=""
 . I LABS!XRAY D  S X=X_" ordered"
 .. I LABS&XRAY S X="Labs and Imaging" Q
 .. S:LABS X="Labs" S:XRAY X="Imaging"
 . S ROW("notes")=X
 . S X=$$XMLA^EDPX("row",.ROW) D XML^EDPX(X)
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
