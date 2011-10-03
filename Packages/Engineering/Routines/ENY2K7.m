ENY2K7 ;(WIRMFO)/DH-Print Y2K Worklist ;9.14.98
 ;;7.0;ENGINEERING;**51,55**;Aug 17, 1993
 ;  Physically prints the Y2K worklist
LN80 ;  10 pitch worklist
 N X
 D DATA
 W !,DA,?11,$E(ENDVTYP,1,30),?42,$E(ENMOD,1,16),?59,$S($L(ENSN)>20:$E(ENSN,1,19)_"*",1:ENSN)
 W !," "_ENLOC I $G(ENWING)]"" S ENWING=$E(ENWING,1,(24-$L(ENLOC))) W " ("_ENWING_")"
 W ?24,$E(ENMFGR,1,40),?65,ENLID
 I ENUSE]"" S ENUSE=$S(ENUSE="IN USE":"IN USE",ENUSE="OUT OF SERVICE":"OOS",ENUSE="LOANED OUT":"ON LOAN",1:"OTHER")
 W !," "_ENUSE,?10,ENPMN,?21,$E(ENMAN,1,30),?52,$E(ENSRVC,1,28)
 W !," Estimated Y2K Compliance Date: "_$$GET1^DIQ(6914,DA,72)_"   Est. Cost: $"_$P($P($G(^ENG(6914,DA,11)),U,3),".") I ENJCAHO="Y" W ?68,"JCAHO=YES"
 S ENX=$P(^ENG(6914,DA,11),U,12) D:ENX]""
 . W ! S ENY=ENY+1
 . W:$L(ENX)<80 " " W ENX
 K ENX D NOTES^ENWOD2(DA),POST
 W !!,ENWOX,?16,"Initials:_______ Date:________ Hrs:______ Materials:_______"
 W !," Y2K Status (circle):   FC   NC   NA   CNL   TI     Vendor Cost:______"
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
 W !," "_ENUSE,?18,ENPMN,?29,$E(ENMAN,1,30),?61,$E(ENSRVC,1,35)
 W !," Estimated Y2K Compliance Date: "_$$GET1^DIQ(6914,DA,72)_"   Estimated Cost: $"_$P($P($G(^ENG(6914,DA,11)),U,3),".") I ENJCAHO="Y" W ?72,"JCAHO=YES"
 S ENX=$P(^ENG(6914,DA,11),U,12) D:ENX]""
 . W ! S ENY=ENY+1
 . W:$L(ENX)<80 " " W ENX
 K ENX D NOTES^ENWOD2(DA),POST
 W !!,ENWOX,?17,"Initials:________ Date___________ Hours:_______ Materials:_______"
 W !," Y2K Status (circle):   FC   NC   NA   CNL  TI        Vendor Cost:__________"
 W !! S ENY=ENY+9
 Q
 ;
DATA ;  Get data from the equipment record (file #6914)
 ;  Expects DA as the IEN for file #6914
 S (ENMAN,ENMANF,ENMOD,ENSN,ENLID,ENLOC,ENDTYP,ENDVTYP,ENLVL,ENSRVC,ENWING,ENUSE,ENCOND,ENJCAHO,ENMFGR)=""
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
 Q
 ;
POST ;  Writes flagging notes (if any)
 ;  Expects that a call has just been made to NOTES^ENWOD2(DA)
 I ENX("T")>0 D
 . N I S I=1
 . I $G(ENX(1))>DT D
 .. S Y=ENX(1) X ^DD("DD")
 .. S X1(I)="Unexpired Warranty ("_Y_")",I=I+1
 . I $G(ENX(6))="O" S X1(I)="HAZARD ALERT("_ENX("HA")_")"
 . I $G(ENX(3))=1 W !," IMPORTANT: Device MUST be isolated & rendered inoperative before servicing." S ENY=ENY+1
 . I $G(X1(1))]"" D
 .. W !," NOTES: "_X1(1) S ENY=ENY+1
 .. S I=1 F  S I=$O(X1(I)) Q:I'>0  W !,?8,X1(I) S ENY=ENY+1
 Q
 ;ENY2K7
