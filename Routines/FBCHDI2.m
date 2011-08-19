FBCHDI2 ;AISC/DMK-DISPLAY INVOICE ;08FEB89
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASKIN K FBAANQ W !! S DIC="^FBAAI(",DIC(0)="AEQM" D ^DIC G END:X="^"!(X=""),ASKIN:Y<0 S FBI=+Y
 S VAR="FBI",VAL=FBI,PGM="START^FBCHDI2" D ZIS^FBAAUTL G:FBPOP END S:IO=IO(0) FBAANQ=1
START S Q="",$P(Q,"=",80)="=",FBAAOUT=0,FBPG=$S($E(IOST,1,2)="C-":0,1:1)
 U IO D HEDC^FBCHVH
EN D GETINV^FBCHVH Q:FBAAOUT
 F J=5,16,17 S FBIN(J)=$P(FBIN,"^",J)
 S Y=FBIN(16) D PDF^FBAAUTL S FBIN(16)=Y S:$P(FBIN(5),";",2)="FB583(" FBIN(5)="" I FBIN(5)]"" S FBIN(5)=$S($D(^FB7078(+FBIN(5),0)):$P(^(0),"^",1),1:"")
 I FBIN(17)]"" S FBIN(17)=$S($D(^FBAA(161.7,FBIN(17),0)):$P(^(0),"^",1),1:"")
 I FBIN(5)]"" W !,?4,"Associated 7078: ",FBIN(5)
 W !,?4,"Batch #: ",FBIN(17),?40,"Date Finalized: ",FBIN(16),!
 I $D(^FBAAI(FBI,"FBREJ")),$P(^("FBREJ"),"^",1)]"" W ?4,"Rejects Pending!",?25,"Reject reason: ",$P(^("FBREJ"),"^",2),!,?4,"Old Batch #: ",$S($P(^("FBREJ"),"^",3):$S($D(^FBAA(161.7,$P(^("FBREJ"),"^",3),0)):$P(^(0),"^"),1:""),1:"")
 Q:$D(FBLISTC)
 G:$D(FBAANQ) ASKIN
END K VA D END^FBCHVH Q
