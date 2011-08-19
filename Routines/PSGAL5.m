PSGAL5 ;BIR/CML3-ACTIVITY LOGGER ;22 Jan 99 / 8:00 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3,22,50**;16 DEC 97
 ;
 ;Reference to ^PS(55 is supported by DBIA 2191
 ;Reference to ^DD is supported by DBIA 903
 ;
EN ;
 N PSJ9,PSJ99 F Q=1:1 Q:'$D(DA(Q+1))
 S PSGAL("D0")=DA(Q),PSGAL("D1")=$S(Q=1:DA,1:DA(Q-1))
 I PSGAL("C")'=6000,$D(PSGALO),PSGALO S PSGAL("C")=PSGALO
 I PSGAL("C")=6000,$D(PSGALR),PSGALR]"" S PSGAL("C")=PSGAL("C")+PSGALR
 I $E(PSGAL("C"),1,2)=60 S OLD=X,FLD=$S($D(PSGALFF):PSGALFF,1:0),FN=$S($D(PSGALFN):PSGALFN,1:55.06) D FIELD^DID(FN,FLD,,"SPECIFIER","PSJ9") I OLD]"",$G(PSJ9("SPECIFIER"))["P" S XX=FN,YY=FLD D PNTR
 I $E(PSGAL("C"),1,2)=60,OLD]"" D FIELD^DID(FN,FLD,,"SPECIFIER","PSJ9") I $G(PSJ9("SPECIFIER"))["S" S OLDS=$P($P(";"_$P(^DD(FN,FLD,0),"^",3),";"_OLD_":",2),";") I OLDS]"" S OLD=OLDS
 ;L +^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,0) S QQ=$G(^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,0)) S:QQ="" QQ="^55.09D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 S QQ=$G(^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,0)) S:QQ="" QQ="^55.09D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 ;L -^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,0) D NOW^%DTC S PSGDT=+$E(%,1,12)
 D NOW^%DTC S PSGDT=+$E(%,1,12)
 S Q=%_"^"_$S(PSGAL("C")=6010:"AUTO CANCEL",$D(DUZ)[0:"UNKNOWN",DUZ]"":DUZ,1:"UNKNOWN")_"^"_PSGAL("C")_$S($E(PSGAL("C"),1,2)=60:"^"_$S('$D(^DD(FN,FLD,0)):FLD,$P(^(0),"^")]"":$P(^(0),"^"),1:FLD)_"^"_OLD,1:"")
 S ^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,PSGAL("N"),0)=Q I PSGAL("C")=6000,$D(PSGALEF) S PSGALEF=PSGALEF+1
 ;
DONE ;
 S PSGAL("D")=% K OLDS,FLD,FN,OLD,PSGALFF,PSGALFN,SS,XX,YY Q
 ;
PNTR ; find pointer value
 F  D FIELD^DID(XX,YY,,"POINTER","PSJ99") S SS=PSJ99("POINTER"),XX=+$P(@("^"_SS_"0)"),"^",2),OLD=$P(@("^"_SS_OLD_",0)"),"^") D FIELD^DID(XX,.01,,"SPECIFIER","PSJ99") Q:$G(PSJ99("SPECIFIER"))'["P"  S YY=.01
 Q
 ;
KILL ; if user merely reenters same data (tsk, tsk), kill record just written
 K ^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,PSGAL("N"),0) I PSGAL("C")=6000,$D(PSGALEF),PSGALEF S PSGALEF=PSGALEF-1
 Q
 ;
 ; Create new activity log entry in file #55.
NEWUDAL(PSGALGP,PSGALORD,PSGALC,PSGFLD,PSGOLD)  ;
 ;
 ;Where  PSGALGP  = PSGP (Required)
 ;       PSGALORD = PSGORD (Required)
 ;       PSGALC   = ACTIVITY CODE FROM #53.3 (Required)
 ;       PSGFLD   = FIELD THAT CHANGED (Free text, optional)
 ;       PSGOLD   = THE FIELDS OLD DATA VALUE (Free text, optional)
 ;
 ;N PSGALGP,PSGALORD,PSGALC,PSGFLD,PSGOLD
 ;
 ; Create 0 node activity log for order if not exists, and get next entry number
 S QQ=$G(^PS(55,PSGALGP,5,+PSGALORD,9,0)) S:QQ="" QQ="^55.09D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 ;Set up data to be held in activity log record
 D NOW^%DTC S PSGDT=+$E(%,1,12)
 I $L($G(PSGOLD))>170 S PSGOLD=$E(PSGOLD,1,167)_"..." ; Use of ... indicates old data field was greater than 170 characters
 S Q=%_"^"_$S(PSGALC=6010:"AUTO CANCEL",$D(DUZ)[0:"UNKNOWN",DUZ]"":DUZ,1:"UNKNOWN")_"^"_PSGALC_"^"_$S($D(PSGFLD):PSGFLD,1:"")_"^"_$S($D(PSGOLD):PSGOLD,1:"")
 ; Create activity log entry     
 S ^PS(55,PSGALGP,5,+PSGALORD,9,PSGAL("N"),0)=Q
 Q
 ; Create new activity log entry
NEWNVAL(PSGALORD,PSGALC,PSGFLD,PSGOLD)  ;
 ;
 ;Where  PSGALORD = PSGORD (Required)
 ;       PSGALC   = ACTIVITY CODE FROM #53.3 (Required)
 ;       PSGFLD   = FIELD THAT CHANGED (Free text, optional)
 ;       PSGOLD   = THE FIELDS OLD DATA VALUE (Free text, optional)
 ;
 ;N PSGALORD,PSGALC,PSGFLD,PSGOLD
 ;
 ; Create 0 node activity log for order if not exists, and get next entry number
 S QQ=$G(^PS(53.1,+PSGALORD,"A",0)) S:QQ="" QQ="^53.1119D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 ;Set up data to be held in activity log record
 D NOW^%DTC S PSGDT=+$E(%,1,12)
 I $L($G(PSGOLD))>170 S PSGOLD=$E(PSGOLD,1,167)_"..." ; Use of ... indicates old data field was greater than 170 characters
 S Q=%_"^"_$S(PSGALC=6010:"AUTO CANCEL",$D(DUZ)[0:"UNKNOWN",DUZ]"":DUZ,1:"UNKNOWN")_"^"_PSGALC_"^"_$S($D(PSGFLD):PSGFLD,1:"")_"^"_$S($D(PSGOLD):PSGOLD,1:"")
 ; Create activity log entry     
 S ^PS(53.1,+PSGALORD,"A",PSGAL("N"),0)=Q
 Q
 ;
KILLNV   ; if user merely reenters same data (tsk, tsk), kill record just written
 K ^PS(53.1,PSGAL("D0"),"A",PSGAL("N"),0) I PSGAL("C")=6000,$D(PSGALEF),PSGALEF S PSGALEF=PSGALEF-1
 Q
