PSGAL5 ;BIR/CML3-ACTIVITY LOGGER ;22 Jan 99 / 8:00 AM
 ;;5.0;INPATIENT MEDICATIONS;**3,22,50,267**;16 DEC 97;Build 158
 ;
 ;Reference to ^PS(55 is supported by DBIA 2191
 ;Reference to ^DD is supported by DBIA 903
 ;
EN ;
 N PSJ9,PSJ99 F Q=1:1 Q:'$D(DA(Q+1))
 S PSGAL("D0")=DA(Q),PSGAL("D1")=$S(Q=1:DA,1:DA(Q-1)) Q:PSGAL("D0")["U"
 I PSGAL("C")'=6000,$D(PSGALO),PSGALO S PSGAL("C")=PSGALO
 I PSGAL("C")=6000,$D(PSGALR),PSGALR]"" S PSGAL("C")=PSGAL("C")+PSGALR
 I $E(PSGAL("C"),1,2)=60 S OLD=X,FLD=$S($D(PSGALFF):PSGALFF,1:0),FN=$S($D(PSGALFN):PSGALFN,1:55.06) D FIELD^DID(FN,FLD,,"SPECIFIER","PSJ9") I OLD]"",$G(PSJ9("SPECIFIER"))["P" S XX=FN,YY=FLD D PNTR
 I $E(PSGAL("C"),1,2)=60,OLD]"" D FIELD^DID(FN,FLD,,"SPECIFIER","PSJ9") I $G(PSJ9("SPECIFIER"))["S" S OLDS=$P($P(";"_$P(^DD(FN,FLD,0),"^",3),";"_OLD_":",2),";") I OLDS]"" S OLD=OLDS
 S QQ=$G(^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,0)) S:QQ="" QQ="^55.09D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 D NOW^%DTC S PSGDT=+$E(%,1,12)
 S Q=%_"^"_$S(PSGAL("C")=6010:"AUTO CANCEL",$D(DUZ)[0:"UNKNOWN",DUZ]"":DUZ,1:"UNKNOWN")_"^"_PSGAL("C")_$S($E(PSGAL("C"),1,2)=60:"^"_$S('$D(^DD(FN,FLD,0)):FLD,$P(^(0),"^")]"":$P(^(0),"^"),1:FLD)_"^"_OLD,1:"")
 I Q'["SPECIAL INSTRUCTIONS" S ^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,PSGAL("N"),0)=Q I PSGAL("C")=6000,$D(PSGALEF) S PSGALEF=PSGALEF+1
 I Q["SPECIAL INSTRUCTIONS",$$DIFFSI^PSJBCMA5(PSGAL("D0"),PSGAL("D1")) D
 .Q:'$G(PSJSYSP)  Q:($G(^PS(53.45,PSJSYSP,5))="AL")
 .S ^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,PSGAL("N"),0)=Q
 .S ^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,PSGAL("N"),1,0)=$G(^PS(55,PSGAL("D0"),5,PSGAL("D1"),15,0))
 .N LN S LN=0 F  S LN=$O(^PS(55,PSGAL("D0"),5,PSGAL("D1"),15,LN)) Q:'LN  D
 ..S ^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,PSGAL("N"),1,LN,0)=^PS(55,PSGAL("D0"),5,PSGAL("D1"),15,LN,0)
 ;
DONE ;
 S PSGAL("D")=% K OLDS,FLD,FN,OLD,PSGALFF,PSGALFN,SS,XX,YY Q
 ;
PNTR ; find pointer value
 F  D FIELD^DID(XX,YY,,"POINTER","PSJ99") S SS=PSJ99("POINTER"),XX=+$P(@("^"_SS_"0)"),"^",2),OLD=$P(@("^"_SS_OLD_",0)"),"^") D FIELD^DID(XX,.01,,"SPECIFIER","PSJ99") Q:$G(PSJ99("SPECIFIER"))'["P"  S YY=.01
 Q
 ;
KILL ; if user merely reenters same data (tsk, tsk), kill record just written
 I Q["SPECIAL INSTRUCTIONS" Q:$$COMPSI()
 K ^PS(55,PSGAL("D0"),5,PSGAL("D1"),9,PSGAL("N"),0) I PSGAL("C")=6000,$D(PSGALEF),PSGALEF S PSGALEF=PSGALEF-1
 Q
 ;
COMPSI() ; Compare old Special Instructions (long) to new Special Instructions (long)
 N Q2,DIFF Q:'$G(DUZ) 0
 S DIFF=0,Q2=0 F  S Q2=$O(^PS(55,PSGAL("D0"),5,PSGAL("D1"),15,Q2)) Q:'Q2!$G(DIFF)  D
 .I $G(^PS(53.45,DUZ,5,Q2,0))'=^PS(55,PSGAL("D0"),5,PSGAL("D1"),15,Q2,0) S DIFF=1
 Q $S(DIFF:1,1:0)
 ;
 ; Create new activity log entry in file #55.
NEWUDAL(PSGALGP,PSGALORD,PSGALC,PSGFLD,PSGOLD,PSGOLDAR)  ;
 ;
 ;Where  PSGALGP  = PSGP (Required)
 ;       PSGALORD = PSGORD (Required)
 ;       PSGALC   = ACTIVITY CODE FROM #53.3 (Required)
 ;       PSGFLD   = FIELD THAT CHANGED (Free text, optional)
 ;       PSGOLD   = THE FIELDS OLD DATA VALUE (Free text, optional)
 ;
 ; Create 0 node activity log for order if not exists, and get next entry number
 Q:PSGALGP["U"
 S QQ=$G(^PS(55,PSGALGP,5,+PSGALORD,9,0)) S:QQ="" QQ="^55.09D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 ;Set up data to be held in activity log record
 D NOW^%DTC S PSGDT=+$E(%,1,12)
 I $L($G(PSGOLD))>170 S PSGOLD=$E(PSGOLD,1,167)_"..." ; Use of ... indicates old data field was greater than 170 characters
 S Q=%_"^"_$S(PSGALC=6010:"AUTO CANCEL",$D(DUZ)[0:"UNKNOWN",DUZ]"":DUZ,1:"UNKNOWN")_"^"_PSGALC_"^"_$S($D(PSGFLD):PSGFLD,1:"")_"^"_$S($D(PSGOLD):PSGOLD,1:"")
 ; Create activity log entry     
 I $D(PSGOLDAR),$$DIFFSI^PSJBCMA5(PSGALGP,PSGALORD) D
 .S ^PS(55,PSGALGP,5,+PSGALORD,9,PSGAL("N"),0)=Q,^PS(55,PSGALGP,5,+PSGALORD,9,PSGAL("N"),1,0)=PSGOLDAR(0)
 .N LN S LN=0 F  S LN=$O(PSGOLDAR(LN)) Q:'LN  D
 ..S ^PS(55,PSGALGP,5,+PSGALORD,9,PSGAL("N"),1,LN,0)=PSGOLDAR(LN,0)
 .N LN S LN=0 F  S LN=$O(^PS(53.45,+$G(PSJSYSP),5,LN)) Q:'LN  D
 ..S ^PS(55,PSGALGP,5,+PSGALORD,9,PSGAL("N"),2,LN,0)=^PS(53.45,+$G(PSJSYSP),5,LN,0)
 .S ^PS(53.45,+$G(PSJSYSP),5)="AL"
 Q
 ; Create new activity log entry
NEWNVAL(PSGALORD,PSGALC,PSGFLD,PSGOLD,PSGOLDAR)  ;
 ;
 ;Where  PSGALORD = PSGORD (Required)
 ;       PSGALC   = ACTIVITY CODE FROM #53.3 (Required)
 ;       PSGFLD   = FIELD THAT CHANGED (Free text, optional)
 ;       PSGOLD   = THE FIELDS OLD DATA VALUE (Free text, optional)
 ;       PSGOLDAR = THE FIELDS OLD DATA VALUE, IF WP FIELD (array, optional)
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
 I $D(PSGOLDAR)&(Q["SPECIAL INSTRUCTIONS"!(Q["OTHER PRINT INFO")) D
 .I Q["SPECIAL INSTRUCTIONS" Q:'$$DIFFSI^PSJBCMA5(+$G(DFN),PSGALORD)
 .I Q["OTHER PRINT INFO" Q:'$$DIFFOPI^PSJBCMA5(+$G(DFN),PSGALORD)
 .N LNCNT S LNCNT=$O(PSGOLDAR(""),-1) S ^PS(53.1,+PSGALORD,"A",PSGAL("N"),1,0)="^53.11195^"_+LNCNT_"^"_+LNCNT,^(1,0)=" "
 .N LN S LN=0 F  S LN=$O(PSGOLDAR(LN)) Q:'LN  S ^PS(53.1,+PSGALORD,"A",PSGAL("N"),1,LN,0)=PSGOLDAR(LN,0)
 Q
 ;
KILLNV   ; if user merely reenters same data (tsk, tsk), kill record just written
 K ^PS(53.1,PSGAL("D0"),"A",PSGAL("N"),0) I PSGAL("C")=6000,$D(PSGALEF),PSGALEF S PSGALEF=PSGALEF-1
 Q
