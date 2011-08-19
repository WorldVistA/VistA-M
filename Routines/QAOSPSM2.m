QAOSPSM2 ;HISC/DAD-SUMMARY OF OCCURRENCE SCREENING - PART II ;2/9/93  09:08
 ;;3.0;Occurrence Screen;;09/14/1993
 K UNDL,DASH S $P(UNDL,"_",81)="",$P(DASH,"-",81)="",QAOSQUIT=0
 D FF
 W !!,"PART II.  Information on Program Operation"
 W !!,"2.  Improvement Actions"
 W !!,"Indicate the types of improvement actions resulting from data collected"
 W !,"through the Occurrence Screening Program during the reporting period."
 W !!,"     Type of Action                                       Number of times taken"
 W !,"    ----------------                                     -----------------------"
 S X=$S(QAOSLIST["^N^":"National ",1:"         ")_$S(QAOSLIST["^L^":"Local ",1:"      ")_$S(QAOSLIST["^1^":"Inactive",1:"") S:QAOSLIST="^N^" X=""
 W !?57,X W:X]""&QAOBLANK !
 W !,"Discussion of case at service staff meeting",?57,$$ACT(8)
 W !!,"Discussion of case at M&M conference",?57,$$ACT(9)
 W !!,"Service education program",?57,$$ACT(10)
 W !!,"Facility education program",?57,$$ACT(11)
 W !!,"Discussion of case with practitioner by supervisor",?57,$$ACT(12)
 W !!,"Formal counseling of practitioner by supervisor",?57,$$ACT(13)
 D PAUSE G:QAOSQUIT EXIT
 W !!,"Investigation or focused study of case",?57,$$ACT(14)
 W !!,"Investigation to review privileges",?57,$$ACT(15)
 W !!,"Other disciplinary action",?57,$$ACT(16)
 W !!,"Changes in policy or procedures",?57,$$ACT(17)
 W !!,"Repair of malfunctioning equipment",?57,$$ACT(18)
 W !!,"Change in ordering of medical supplies or equipment",?57,$$ACT(19)
 W !!,"Development of improved communication procedures",?57,$$ACT(20)
 W !!,"Further study of issues raised by occurrence screening",?57,$$ACT(21)
 W !!,"Other",?57,$$ACT(22)
 D PAUSE G:QAOSQUIT EXIT
 G ^QAOSPSM3
ACT(Y) N X I QAOSLIST="^N^" Q "       "_$S(QAOBLANK:"________",1:$J(+$G(QAOSACTN("N",Y)),5,0))
 S X=$S(QAOBLANK:"________",QAOSLIST["^N^":$J(+$G(QAOSACTN("N",Y)),5,0)_"   ",1:"        ")_" "
 S X=X_$S(QAOBLANK:"_____",QAOSLIST["^L^":$J(+$G(QAOSACTN("L",Y)),5,0),1:"     ")_" "
 S X=X_$S(QAOBLANK:"________",QAOSLIST["^1^":"   "_$J(+$G(QAOSACTN("1",Y)),5,0),1:"        ")
 Q X
EXIT K DASH,UNDL
 Q
PAUSE Q:$E(IOST)'="C"
 K DIR S DIR(0)="E" D ^DIR K DIR S QAOSQUIT=$S(Y'>0:1,1:0)
 Q
FF W @IOF
 Q
