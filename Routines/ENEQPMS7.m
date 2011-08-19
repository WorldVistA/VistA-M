ENEQPMS7 ;(WIRMFO)/DH-Print PM Worklist ;4.3.98
 ;;7.0;ENGINEERING;**15,21,35,51**;Aug 17, 1993
 ;  Physically prints the worklist
LN80 ;  10 pitch worklist
 N X1
 D DATA
 W !,DA,?11,$E(ENDVTYP,1,30),?42,$E(ENMOD,1,16),?59,$S($L(ENSN)>20:$E(ENSN,1,19)_"*",1:ENSN)
 W !," "_ENLOC I $G(ENWING)]"" S ENWING=$E(ENWING,1,(24-$L(ENLOC))) W " ("_ENWING_")"
 W ?24,$E(ENMFGR,1,40),?65,ENLID
 I ENUSE]"" S ENUSE=$S(ENUSE="IN USE":"IN USE",ENUSE="OUT OF SERVICE":"OOS",ENUSE="LOANED OUT":"ON LOAN",1:"OTHER")
 W !," "_ENUSE,?10,ENPMN,?21,$E(ENMAN,1,30),?52,$E(ENSRVC,1,28)
 W !," Proc: " I ENPROC(2)]"" W $E(ENPROC(2),1,24)
 E  W $E(ENPROC(1),1,24)
 W ?37,"Crit: ",ENCRIT,?47,"Freq: ",ENHZ,?56,"Level: ",ENLVL
 I ENJCAHO="Y" W ?69,"JCAHO: YES"
 K ENX D NOTES^ENWOD2(DA),POST
 W !!,ENWOX,?17,"Initials:_____ Date:_______ Hours:_____" W:ENHRS]"" "("_ENHRS_") " W "Cost:______" W:ENMAT]"" "("_ENMAT_")"
 W !," PM Status (circle): P C D0 D1 D2 D3  Condition" W:$G(ENX(2))]"" " ("_ENX(2)_")" W ": LN G P  Y2K: "_$P($G(^ENG(6914,DA,11)),U)
 W !! S ENY=ENY+9
 Q
 ;
LN96 ;  12 pitch worklist
 N X1
 D DATA
 W !,DA,?12,$E(ENDVTYP,1,31),?44,$E(ENMOD,1,20),?65,ENSN
 W !," "_ENLOC I $G(ENWING)]"" S ENWING=$E(ENWING,1,(24-$L(ENLOC))) W " ("_ENWING_")"
 W ?24,$E(ENMFGR,1,55),?80,ENLID
 I ENUSE]"" S ENUSE=$S(ENUSE="IN USE":"IN USE",ENUSE="OUT OF SERVICE":"OUT OF SERVICE",ENUSE="LOANED OUT":"ON LOAN",1:"OTHER")
 W !," "_ENUSE,?18,ENPMN,?29,$E(ENMAN,1,36),?65,$E(ENSRVC,1,30)
 W !," Proc: " I ENPROC(2)]"" W $E(ENPROC(2),1,30)
 E  W $E(ENPROC(1),1,30)
 W ?44,"Crit: ",ENCRIT,?53,"Freq: ",ENHZ,?62,"Level: ",ENLVL
 I ENJCAHO="Y" W ?76,"JCAHO: YES"
 K ENX D NOTES^ENWOD2(DA),POST
 W !!,ENWOX,?18,"Initials:_______ Date:___________ Hours:______" W:ENHRS]"" "("_ENHRS_") " W "Cost:________" W:ENMAT]"" "("_ENMAT_")"
 W !," PM Status (circle):  P  C  D0  D1  D2  D3    Condition" W:$G(ENX(2))]"" " ("_ENX(2)_")" W ":  LN  G  P   Y2K: "_$P($G(^ENG(6914,DA,11)),U)
 W !! S ENY=ENY+9
 Q
 ;
DATA ;  Get data from the equipment record (file #6914)
 ;  Expects DA as the IEN for file #6914
 S (ENPMN,ENMAN,ENMANF,ENMOD,ENSN,ENLID,ENLOC,ENCRIT,ENPRC,ENPROC(1),ENPROC(2),ENDTYP,ENDVTYP,ENLVL,ENSRVC,ENWING,ENHRS,ENMAT,ENUSE,ENCOND,ENJCAHO,ENMFGR)=""
 S ENMFGR=$P(^ENG(6914,DA,0),U,2)
 I $D(^ENG(6914,DA,3)) S EN=^(3),ENLOC=$P(EN,U,5),ENPMN=$P(EN,U,6),ENLID=$P(EN,U,7),ENJCAHO=$P(EN,U,9),ENUSE=$$GET1^DIQ(6914,DA,20),ENCOND=$$GET1^DIQ(6914,DA,53)
 I ENLOC]"" D
 . I ENLOC=+ENLOC,$D(^ENG("SP",ENLOC,0)) D  Q
 .. S ENLOC=$P(^ENG("SP",ENLOC,0),U),ENWING=$P(^(0),U,3)
 .. K:ENWING="" ENWING
 . S X=$O(^ENG("SP","B",ENLOC,0))
 . I X>0,$D(^ENG("SP",X,0)) S ENWING=$P(^(0),U,3) K:ENWING="" ENWING
 S ENSRVC=$$GET1^DIQ(6914,DA,21)
 I $D(^ENG(6914,DA,1)) S EN=^(1),ENMAN=$$GET1^DIQ(6914,DA,1),ENMOD=$P(EN,U,2),ENSN=$P(EN,U,3),ENDVTYP=$$GET1^DIQ(6914,DA,6)
 S ENCRIT=$P(^ENG(6914,DA,4,SE,0),U,4)
 S ENLVL=$P(^ENG(6914,DA,4,SE,2,MULT,0),U,4),ENPRC=$P(^(0),U,5),ENHRS=$P(^(0),U,2),ENMAT=$P(^(0),U,3) S:ENLVL="" ENLVL="N/A" I ENPRC]"",$D(^ENG(6914.2,ENPRC,0)) S ENPROC(1)=$P(^(0),U),ENPROC(2)=$P(^(0),U,2)
 E  I ENPRC]"" S ENPROC(2)=ENPRC
 Q
 ;
POST ;  Writes flagging notes (if any)
 ;  Expects that a call has just been made to NOTES^ENWOD2(DA)
 I ENX("T")>0 D
 . N I S I=1
 . I $G(ENX(1))>DT D
 .. S Y=ENX(1) X ^DD("DD")
 .. S X1(I)="Unexpired Warranty ("_Y_")",I=I+1
 . I $G(ENX(4))]"" S X1(I)="Missed Last PMI" D  S I=I+1
 .. I ENX(4)'="D0" S X1(I)=X1(I)_" ("_$S(ENX(4)="D1":"could not locate",ENX(4)="D2":"in use",ENX(4)="D3":"out of service",1:"")_")"
 . I $G(ENX(6))="O" S X1(I)="HAZARD ALERT("_ENX("HA")_")"
 . I $G(ENX(3))=1 W !," IMPORTANT: Device MUST be isolated & rendered inoperative before servicing." S ENY=ENY+1
 . I $G(X1(1))]"" D
 .. W !," NOTES: "_X1(1) S ENY=ENY+1
 .. S I=1 F  S I=$O(X1(I)) Q:I'>0  W !,?8,X1(I) S ENY=ENY+1
 Q
 ;ENEQPMS7
