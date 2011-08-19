PRCST23 ; ;10/27/00
 S X=DE(21),DIC=DIE
 X "S E=0,E(1)="""" S:'$D(^PRCS(410,DA(1),4)) ^(4)="""" F E(0)=1:1 S E=$O(^PRCS(410,DA(1),""IT"",E)) S:E?1N.N&(E'=DA) E(1)=E(1)+($P(^(E,0),U,2)*$P(^(0),U,7)) I E'?1N.N X ^DD(410.02,2,1,1,1.4) K E Q"
