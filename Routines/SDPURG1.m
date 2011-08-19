SDPURG1 ;ALB/TMP - Purge-Print Routine ; 12/24/85
 ;;5.3;Scheduling;**132,478**;Aug 13, 1993
START U IO S (SDCT,POP)=0 W @IOF,!,"*** SCHEDULING PURGE IN PROCESS ***",! D NOW^%DTC
 G:'SD44 SD2 W !,"Begin purge of Hospital Location File nodes " S Y=% D DT^DIQ S SDCT=0
 F A=0:0 S A=$O(^SC(A)) D:'A ENDA Q:'A  I $D(^(A,0)),$P(^(0),"^",3)="C" D A F B=0:0 S B=$O(^SC(A,"S",B)) Q:'B!(B'<SDLIM1)  S DA(1)=A,DA=B,DIK="^SC("_DA(1)_",""S"",",X=DIK_B_")" D PRTS,^DIK K DIK W:'(SDCT#100)&('SDPR) "."
 S SDCT=0 G 1010
A F B="C","OST","ST" F C=0:0 S C=$O(^SC(A,B,C)) Q:'C!(C'<SDLIM1)  D MORE,DOT
 Q
1010 F A=0:0 S A=$O(^SC("AAS",A)) W:'A !,SDCT," 10/10 AND UNSCHEDULED XREFS PURGED",!!,"End of Hospital Location purge" Q:'A  F B=0:0 S B=$O(^SC("AAS",A,B)) Q:'B!(B'<SDLIM1)  D MORE3 S X="^SC(""AAS"","_A_","_B_")" K @X D DOT
SD2 G:'SD2 END D NOW^%DTC S SDCT=0 G ^SDPURG2
DOT W:'(SDCT#100)&('SDPR) "." Q
SETA S $P(^SC(A,"S",0),"^",4)="",POP=1 Q
ENDA W !,SDCT," APPTS AND MISCELLANEOUS HOSPITAL LOCATION NODES DELETED" Q
PRTS S:'$D(^SC(A,"S",0)) ^(0)="^44.001DA^^" S:'$D(^SC(A,"S",B,1,0)) ^(0)="^44.003PA^^"
 W:$D(^SC(A,"S",B,0))&(SDPR) !,$P(X,")")_",0) = ",^(0) F C=0:0 S C=$O(^SC(A,"S",B,1,C)) Q:'C  W:SDPR !,$P(X,")")_",1,"_C_",0) = ",^(C,0) S SDCT=SDCT+1
 Q
D ;K ^SC(A,"S",B) Q  ;original line
 S DA(1)=A,DA=B,DIK="^SC("_DA(1)_",""S""," D ^DIK Q
MORE S J=-1
 I B["ST" F I=0:0 S J=$O(^SC(A,B,C,J)) Q:J=""  S:'$D(^SC(A,B,0)) ^(0)="^"_$S(B="ST":"44.005",1:"44.002")_"DA^^" S X="^SC("_A_","""_B_""","_C_","_$S(+J=J:J,1:""""_J_"""")_")",POP=1 D KILL,CT S:B="OST"&('$D(^SC(A,"OST",C,0))) ^(0)=C
 I B'["ST" S X="^SC("_A_","""_B_""","_C_",0)",POP=1 D KILL,CT F I=0:0 S I=$O(^SC(A,B,C,1,I)) Q:'I  S X="^SC("_A_","""_B_""","_C_",1,"_I_",0)",POP=1 D KILL,CT
 S DA(1)=A,DA=C,DIK="^SC("_DA(1)_","""_B_""",",X=DIK_C_")" D ^DIK K DIK Q
MORE3 F I=0:0 S I=$O(^SC("AAS",A,B,I)) Q:'I  S POP=1,X="^SC(""AAS"","_A_","_B_","_I_")" D KILL,CT
 Q
KILL I SDPR W:$S(($D(@X)#2):1,1:0) !,X," = ",@X
 I POP S POP=0 Q
 Q
CT S SDCT=SDCT+1 Q
 D ^DIK Q
END W !!,"*** SCHEDULING PURGE COMPLETED *** " D NOW^%DTC S Y=% D DT^DIQ
 I SD44!(SD2) W ! W:SD44 "Hospital Location " W:SD44&(SD2) "and " W:SD2 "Patient " W "file nodes have been purged through: " S X1=SDLIM1,X2=-1 D C^%DTC S Y=X D DT^DIQ
Q K A,B,C,D,E,F,I,J,SD44,SD2,SDC,SDLIM,SDLIM1,SDCT,SDPR,X,X1,X2,Y,POP,%,%Y D CLOSE^DGUTQ Q
