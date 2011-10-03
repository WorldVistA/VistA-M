VAUQWK ;ALB/MLI - QUICK LOOKUP ON DPT VARIABLES ; 29 MAR 89@1500
 ;;5.3;Registration;;Aug 13, 1993
 F I=1:1:13 S VAQK(I)=""
 Q:'$D(DFN)  Q:'$D(^DPT(+DFN,0))
 F I=0,.1,.101,.321,.36,.52 S VA(I)=$S($D(^DPT(+DFN,I)):^(I),1:"")
 S VAQK(1)=$P(VA(0),"^",1),VAQK(2)=$P(VA(0),"^",9) S:VAQK(2)]"" VAQK(2)=VAQK(2)_"^"_$E(VAQK(2),1,3)_"-"_$E(VAQK(2),4,5)_"-"_$E(VAQK(2),6,9) S (VAQK(3),Y)=$P(VA(0),"^",3) I Y]"" X ^DD("DD") S VAQK(3)=VAQK(3)_"^"_Y
 S VA(1)=$S('$D(^DPT(DFN,.35)):"",'^(.35):"",1:+^(.35)),VA(2)=$S('VA(1):DT,1:VA(1)),VAQK(4)=$E(VA(2),1,3)-$E(VAQK(3),1,3)-($E(VA(2),4,7)<$E(VAQK(3),4,7)),VAQK(5)=$P(VA(0),"^",2)
 I VAQK(5)]"" S VAQK(5)=VAQK(5)_"^"_$S(VAQK(5)="M":"MALE",VAQK(5)="F":"FEMALE",1:"")
 S VAQK(6)=$P(VA(.36),"^",1) I VAQK(6)]"" S VAQK(6)=VAQK(6)_"^"_$S($D(^DIC(8,+VAQK(6),0)):$P(^(0),"^",1),1:"")
 F I=7:1:10 S VA=$S(I<10:$P(VA(.321),"^",I-6),1:$P(VA(.52),"^",5)) S VAQK(I)=$S(VA="Y":1,1:0)
 S VA=$G(^DG(408.32,+$P(VA(0),"^",14),0)) I VA]"" S VAQK(11)=$P(VA,"^",2)_"^"_$P(VA,"^",1)
 F I=12:1:13 S VAQK(I)=$P(VA($S(I=12:.1,1:.101)),"^",1)
 K I,VA,Y Q
