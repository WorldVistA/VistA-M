YSPP2 ;ALB/ASF-PATIENT INQUIRY-PART MILITARY ; 2/15/89  09:30 ;
 ;;5.01;MENTAL HEALTH;**37**;Dec 30, 1994
 ;
 S YSFHDR="Military Data <<section 4>>" D ENHD^YSFORM
ENCE ; Called indirectly from YSCEN31
 ;
 I $P(A(.15),U,2)?7N W !?20,"PATIENT LISTED AS INELIGIBLE",$C(7,7)
 S L=+A(1010.15) W !!," PREV CARE: " W:L?7N $$FMTE^XLFDT(L,"5ZD") W ?30 W:+$P(A(1010.15),U,2)>0 $P(^DIC(4,+$P(A(1010.15),U,2),0),U)
 G SERV:+$P(A(1010.15),U,3)'>0 S L=+$P(A(1010.15),U,3) W !?15,$$FMTE^XLFDT(L,"5ZD"),?30 W:+$P(A(1010.15),U,4)>0 $P(^DIC(4,+$P(A(1010.15),U,4),0),U)
SERV ;
 W !!,"SERV RECORD: BRANCH",?29,"SERVICE # ENTER DATE SEPAR DATE DISCHARGE TYPE",!?8,"1",?16 S L=$P(A(.32),U,5),L1=$P(A(.32),U,8),L2=$P(A(.32),U,6),L3=$P(A(.32),U,7),L4=$P(A(.32),U,4) D SER
 G NON:+$P(A(.32),U,11)'>0 W !?8,"2",?16 S L=$P(A(.32),U,10),L1=$P(A(.32),U,13),L2=$P(A(.32),U,11),L3=$P(A(.32),U,12),L4=$P(A(.32),U,9) D SER G NON:+$P(A(.32),U,16)'>0
 W !?8,3,?16 S L=$P(A(.32),U,15),L1=$P(A(.32),U,18),L2=$P(A(.32),U,16),L3=$P(A(.32),U,17),L4=$P(A(.32),U,14) D SER
 ;
NON ;
 W !!,"NON-VET CLASS: " S L=+$P(A(.3),U,8),L=$E($P($G(^DIC(24,L,0)),U),1,20) W L
 W ?40,"AGENCY/ALL COUNTRY: " S L=+$P(A(.3),U,9),L=$E($P($G(^DIC(35,L,0)),U),1,20) W L
 ;
COMB ;
 S C=$P(A(.52),U,11) W !!,"",?7,"COMBAT: ",$S(C="Y":"YES",C="N":"NO",1:"UNK"),?24,"FROM: " S L=$P(A(.52),U,13),L1=$P(A(.52),U,14) W:L?7N $$FMTE^XLFDT(L,"5ZD")
 W ?45,"TO: " W:L1?7N $$FMTE^XLFDT(L1,"5ZD") W ?59,"WHERE: " S L=+$P(A(.52),U,12) W:L>0 $E($P($G(^DIC(22,L,0)),U),1,14)
POW ;
 W !,"",?9," POW: " S C=$P(A(.52),U,5),L=$S(C="Y":"YES",C="N":"NO",1:"UNK") W L S L=$P(A(.52),U,7),L1=$P(A(.52),U,8) W ?24,"FROM: " W:L?7N $$FMTE^XLFDT(L,"5ZD")
 W ?45,"TO: " W:L1?7N $$FMTE^XLFDT(L1,"5ZD") W ?61,"WAR: " I +$P(A(.52),U,6)>0,$D(^DIC(22,+$P(A(.52),U,6),0)) W $P(^(0),U)
ION ;
 W !,"ION RADIAT: " S C=$P(A(.321),U,3),L=$S(C="Y":"YES",C="N":"NO",1:"UNK") W L S L=$P(A(.321),U,11) W ?20," ION REG: " W:+L>0 $$FMTE^XLFDT(L,"5ZD")
 S L=";"_$P(^DD(2,.3212,0),U,3),L1=";"_$P(A(.321),U,12)_":" W ?41,"METHOD: ",$P($P(L,L1,2),";")
 G ^YSPP3
SER ;
 W:$D(^DIC(23,+L,0)) $P(^(0),U) W ?30,L1,?40 W:+L2>0 $$FMTE^XLFDT(L2,"5ZD") W:+L3>0 ?50,$$FMTE^XLFDT(L3,"5ZD") W:$D(^DIC(25,+L4,0)) ?60,$P(^(0),U) Q
