PSJCOM ;BIR/CML3-FINISH COMPLEX UNIT DOSE ORDERS ENTERED THROUGH OE/RR ;02 Feb 2001  12:20 PM
 ;;5.0; INPATIENT MEDICATIONS ;**110,186**;16 DEC 97
 ;
 ; Reference to ^VALM1 is supported by DBIA 10116.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^%DTC is supported by DBIA 10000.
 ; Reference to ^%RCR is supported by DBIA 10022.
 ; Reference to ^DIR is supported by DBIA 10026.
 ; Reference to ^TIUEDIT is supported by DBIA 2410.
 ;
UPD ;
 Q:'PSJCOM
 M ^TMP("PSJCOM",$J,+PSGORD)=^PS(53.1,+PSGORD)
 I PSGST="",(PSGSCH="NOW"!(PSGSCH="ONCE")) S PSGST="O"
 S $P(^TMP("PSJCOM",$J,+PSGORD,0),"^",9)="N",$P(^(0),"^",4)="U",$P(^(0),"^",7)=PSGST,$P(^TMP("PSJCOM",$J,+PSGORD,2),"^",2)=PSGSD,$P(^(2),"^",4)=PSGFD
 I $D(PSGSI),$P($G(^PS(53.1,+PSGORD,0)),U,24)'="R" S ^TMP("PSJCOM",$J,+PSGORD,6)=PSGSI
 I $D(PSGSI),$P($G(^PS(53.1,+PSGORD,0)),U,24)="R" S $P(^TMP("PSJCOM",$J,+PSGORD,6),U)=$P(PSGSI,U) I $P(PSGSI,U)="" S $P(^TMP("PSJCOM",$J,+PSGORD,6),U,2)=""
 S:$D(PSGSCH) $P(^TMP("PSJCOM",$J,+PSGORD,2),"^")=PSGSCH
 I PSGSM,PSGOHSM'=PSGHSM S $P(^TMP("PSJCOM",$J,+PSGORD,0),"^",5)=PSGSM,$P(^TMP("PSJCOM",$J,+PSGORD,0),"^",6)=PSGHSM
 W "."
 S PSGOEEWF="^TMP(""PSJCOM"",$J,+PSGORD,"
 F Q=1,3 K @(PSGOEEWF_Q_")") S %X="^PS(53.45,"_PSJSYSP_","_$S(Q=1:2,1:1)_",",%Y=PSGOEEWF_Q_"," K @(PSGOEEWF_Q_")") D %XY^%RCR W "."  ;MOU-0100-30945
 S PSGND=$G(^TMP("PSJCOM",$J,+PSGORD,0)),X=$P(PSGND,U,24)
 S PSJOWALL=+$G(^PS(55,PSGP,5.1))
 I $S(X="R":1,+$G(^PS(55,PSGP,5.1))>PSGDT:0,1:X'="E") S X=$G(^TMP("PSJCOM",$J,+PSGORD,2)) D ENWALL^PSGNE3(+$P(X,U,2),+$P(X,U,4),PSGP)
 S $P(^TMP("PSJCOM",$J,+PSGORD,.2),U,2)=PSGDO,$P(^TMP("PSJCOM",$J,+PSGORD,2),U,5)=PSGAT S:$G(PSGS0XT) $P(^(2),U,6)=PSGS0XT
 I 'PSGOEAV D NEWNVAL(PSGORD,$S(+PSJSYSU=3:22005,1:22000))
 I PSGOEAV,+PSJSYSU=3 D VFY Q
 I PSGOEAV,$G(PSJRNF) D VFY
 Q
VFY ; change status, move to 55, and change label record
 Q:'PSJCOM
 I '$D(^TMP("PSJCOM",$J,+PSGORD)) M ^TMP("PSJCOM",$J,+PSGORD)=^PS(53.1,+PSGORD)
 NEW PSJDOSE,PSJDSFLG
 D DOSECHK^PSJDOSE
 I +$G(PSJDSFLG) D SETVAR^PSJDOSE W !!,PSJDOSE("WARN"),!,PSJDOSE("WARN1") I '$$CONT() W !,"...order was not verified..." D PAUSE^VALM1 D  Q:'$G(PSJACEPT)
 . S PSGOEEF(109)=1
 . S PSJACEPT=0
 D DDCHK G:CHK DONE
 W !,"...a few moments, please..."
 I PSGORD["P" D
 . S PSGORDP=PSGORD ;Used in ACTLOG to update activity log in ^TMP
 . I '$D(^TMP("PSJCOM2",$J,+PSGORD)) D  Q
 .. NEW PSGX S PSGX=$G(^TMP("PSJCOM",$J,+PSGORD,2.5)),PSGRSD=$P(PSGX,U),PSGRFD=$P(PSGX,U,3)
 .. S $P(^TMP("PSJCOM",$J,+PSGORD,0),"^",9)="A" W "." ;D ^PSGOT
 .  NEW PSGX S PSGX=$G(^TMP("PSJCOM2",$J,+PSGORD,2.5)),PSGRSD=$P(PSGX,U),PSGRFD=$P(PSGX,U,3)
 .  S $P(^TMP("PSJCOM2",$J,+PSGORD,0),"^",9)="A" W "." ;D ^PSGOT
 D NEWNVAL(+PSGORD,(PSJSYSU*10+22000)) W "."
 S VND4=$S('$D(^TMP("PSJCOM2",$J,+PSGORD)):$G(^TMP("PSJCOM",$J,+PSGORD,4)),1:$G(^TMP("PSJCOM2",$J,+PSGORD,4)))
 I $G(PSGRSD) D
 . S PSGRSD=$$ENDTC^PSGMI(PSGRSD) D NEWNVAL(PSGORD,6090,"Requested Start Date",PSGRSD)
 . S PSGRFD=$$ENDTC^PSGMI(PSGRFD) D NEWNVAL(PSGORD,6090,"Requested Stop Date",PSGRFD)
 N DUR,DURORD S DURON=$S($G(ON)&($G(PSGORD)["U"):ON,$G(PSGORD):PSGORD,1:"") Q:'DURON  D
 . S DUR=$S($P($G(PSGRDTX),U,2)]"":$P($G(PSGRDTX),U,2),1:$$GETDUR^PSJLIVMD(PSGP,+DURON,$S($G(DURON)["P":"P",$G(DURON)["V":"IV",1:5),1),1:"")
 I DUR]"" S $P(^TMP("PSJCOM2",$J,+PSGORD,2.5),"^",2)=DUR
 ;D:$D(PSGORDP) ACTLOG(PSGORDP,PSGP,PSGORD)
 K PSGRSD,PSGRFD,PSGALFN
 NEW X S X=0 I $G(PSGONF),(+$G(PSGODDD(1))'<+$G(PSGONF)) S X=1
 I +PSJSYSU=3,PSGORD'["O",$S(X:0,'$P(VND4,"^",16):1,1:$P(VND4,"^",15)) ;D EN^PSGPEN(+PSGORD)
 S:'$P(VND4,U,+PSJSYSU=3+9) $P(VND4,U,+PSJSYSU=3+9)=+$P(VND4,U,+PSJSYSU=3+9)
 ;S $P(VND4,"^",+PSJSYSU=1+9)=1,$P(VND4,U,+PSJSYSU=3+9)=0
 S:$P(VND4,"^",15)&'$P(VND4,"^",16) $P(VND4,"^",15)="" S:$P(VND4,"^",18)&'$P(VND4,"^",19) $P(VND4,"^",18)="" S:$P(VND4,"^",22)&'$P(VND4,"^",23) $P(VND4,"^",22)=""
 S $P(VND4,"^",PSJSYSU,PSJSYSU+1)=DUZ_"^"_PSGDT
 S:'$D(^TMP("PSJCOM2",$J,+PSGORD)) ^TMP("PSJCOM",$J,+PSGORD,4)=VND4 S:$D(^TMP("PSJCOM2",$J,+PSGORD)) ^TMP("PSJCOM2",$J,+PSGORD,4)=VND4
 W:'$D(PSJSPEED) ! W !,"ORDER VERIFIED.",!
 I '$D(PSJSPEED) K DIR S DIR(0)="E" D ^DIR K DIR
 S VALMBCK="Q"
 S ^TMP("PSJCOM",$J)="A" S:$D(^TMP("PSJCOM2",$J,+PSGORD)) ^TMP("PSJCOM2",$J)="A"
 ;
DONE ;
 W:CHK !!,"...order NOT verified..."
 I '$D(PSJSPEED),'CHK,+PSJSYSU=3,$G(PSJPRI)="D" D
 .N DIR W ! S DIR(0)="S^Y:Yes;N:No",DIR("A")="Do you want to enter a Progress Note",DIR("B")="No" D ^DIR
 .Q:Y="N"
 .D MAIN^TIUEDIT(3,.TIUDA,PSGP,"","","","",1)
 S VALMBCK="Q" K CHK,DA,DIE,F,DP,DR,ND,PSGAL,PSGODA,PSJDOSE,PSJVAR,VND4,X Q
 ;
DDCHK ; dispense drug check
 S DRGF=$S('$D(^TMP("PSJCOM2",$J,+PSGORD)):"^TMP(""PSJCOM"","_$J_","_+PSGORD_",",1:"^TMP(""PSJCOM2"","_$J_","_+PSGORD_","),CHK=$S('$O(@(DRGF_"1,0)")):7,1:0)
 S PSGPD=$G(@(DRGF_".2)"))
 S CHK=$S('$$DDOK^PSGOE2(DRGF_"1,",PSGPD):7,1:0)
 Q:CHK=0
 W $C(7),!!,"This order must have at least one valid, active dispense drug to be verified."
 ;
CONT() ;
 NEW DIR,DIRUT,Y
 W ! K DIR,DIRUT
 S DIR(0)="Y",DIR("A")="Would you like to continue verifying the order",DIR("B")="Yes"
 D ^DIR
 Q Y
 ;
NEWNVAL(PSGALORD,PSGALC,PSGFLD,PSGOLD)  ;
 ;
 ;Where  PSGALORD = PSGORD (Required)
 ;       PSGALC   = ACTIVITY CODE FROM #53.3 (Required)
 ;       PSGFLD   = FIELD THAT CHANGED (Free text, optional)
 ;       PSGOLD   = THE FIELDS OLD DATA VALUE (Free text, optional)
 ;
 ;N PSGALORD,PSGALC,PSGFLD,PSGOLD
 ;
 ; Create 0 node activity log for order if none exists, and get next entry number
 I '$D(^TMP("PSJCOM2",$J,+PSGALORD)) D  Q
 . S QQ=$G(^TMP("PSJCOM",$J,+PSGALORD,"A",0)) S:QQ="" QQ="^53.1119D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 . ;Set up data to be held in activity log record
 . D NOW^%DTC S PSGDT=+$E(%,1,12)
 . I $L($G(PSGOLD))>170 S PSGOLD=$E(PSGOLD,1,167)_"..." ; Use of ... indicates old data field was greater than 170 characters
 . S Q=%_"^"_$S(PSGALC=6010:"AUTO CANCEL",$D(DUZ)[0:"UNKNOWN",DUZ]"":DUZ,1:"UNKNOWN")_"^"_PSGALC_"^"_$S($D(PSGFLD):PSGFLD,1:"")_"^"_$S($D(PSGOLD):PSGOLD,1:"")
 . ; Create activity log entry
 . S ^TMP("PSJCOM",$J,+PSGALORD,"A",PSGAL("N"),0)=Q
 S QQ=$G(^TMP("PSJCOM2",$J,+PSGALORD,"A",0)) S:QQ="" QQ="^53.1119D" F Q=$P(QQ,"^",3)+1:1 I '$D(^(Q)) S $P(QQ,"^",3,4)=Q_"^"_Q,^(0)=QQ,PSGAL("N")=Q Q
 ;Set up data to be held in activity log record
 D NOW^%DTC S PSGDT=+$E(%,1,12)
 I $L($G(PSGOLD))>170 S PSGOLD=$E(PSGOLD,1,167)_"..." ; Use of ... indicates old data field was greater than 170 characters
 S Q=%_"^"_$S(PSGALC=6010:"AUTO CANCEL",$D(DUZ)[0:"UNKNOWN",DUZ]"":DUZ,1:"UNKNOWN")_"^"_PSGALC_"^"_$S($D(PSGFLD):PSGFLD,1:"")_"^"_$S($D(PSGOLD):PSGOLD,1:"")
 ; Create activity log entry
 S ^TMP("PSJCOM2",$J,+PSGALORD,"A",PSGAL("N"),0)=Q
 Q
