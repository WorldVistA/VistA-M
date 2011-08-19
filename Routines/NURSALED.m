NURSALED ;HIRMFO/RM,FT-LOCATION FILE EDIT ROUTINE ;6/11/89
 ;;4.0;NURSING SERVICE;**17**;Apr 25, 1997
EN1 ; ENTRY TO EDIT LOCATION FILE ENTRY FROM NURSAFUD ROUTINE
 S NURSWARD=+Y,NURSWARD(0)=$P(Y(0),"^"),NURSWARD(0,0)=Y(0,0),NURSNEW=+$P(Y,"^",3)
NAME ;
 W !,"NAME: "_NURSWARD(0,0)_"// " R X:DTIME S X=$S('$T:"^",X="":NURSWARD(0,0),1:X) G Q1:"^"[X I X="@" W $C(7) S XQH="NURS-LOCATION-DELETE" D EN^XQH K XQH G NAME
 I X?1"?".E W $C(7),!?5,"Answer with Nursing Unit name.  Answer must be 2-30 characters",!?5,"in length.  You may put the letters 'NUR ' in front of the unit",!?5,"name, but if you do not the software will take care of it." G NAME
 I X?1P.E!(X'?.ANP)!(X["""") W $C(7)," ??" G NAME
 S X=$S(X'?1"NUR ".E:"NUR "_X,1:X) I $L(X)<2!($L(X)>30) W $C(7),!?5,"Answer must be between 2 and 30 characters in length." G NAME
 S NURFACIL=$$EN8^NURSAFU0() S:$$SITE^VASITE()'>0 NURFACIL="Y"
 I X'=("NUR "_NURSWARD(0,0)) S NURLOC=X,DIE="^SC(",DR=".01///^S X=NURLOC;S:NURFACIL=""Y"" Y=""@1"";3///^S X=$P($$SITE^VASITE(),U,2);S Y=0;@1;3",DA=NURSWARD(0) D ^DIE K NURFACIL G:$D(Y) Q1
 S DA=$P($G(^NURSF(211.4,+NURSWARD,0)),U,1) I DA>0 S DIE="^SC(",DR="3R~HOSPITAL LOCATION INSTITUTION" D ^DIE
 G:$D(Y) Q1 ;quit if user up-arrows out
 S DIE="^NURSF(211.4,",DR="S:$$EN7^NURSAFU0()'=""Y"" Y=""@1"";.03R;S Y=""@2"";@1;.03///^S X=""NURSING"";@2;1T~;1.5T~",DA=NURSWARD D ^DIE
 G:$D(Y) Q1 ;quit if user up-arrows out
 I $D(X),X="I",'$D(^NURSF(211.4,DA,3,0))#2 G Q1
MAS ;
 S NURSOMAS=+$O(^NURSF(211.4,NURSWARD,3,0)) G:'NURSOMAS ASKM
OMAS ;
 K OMAS S Z=1 F X=0:0 S X=$O(^NURSF(211.4,NURSWARD,3,X)) Q:X'>0  S Y=$S($D(^NURSF(211.4,NURSWARD,3,X,0)):$P(^(0),"^"),1:"") S:Y'="" OMAS(Z)=X_"^"_Y,Z=Z+1
 S OMAS=Z-1 W !!,"Below is a listing of associated MAS wards"
 S Z=0 F X=0:0 S X=$O(OMAS(X)) Q:X'>0  W !?2,$J(X,2),". ",$S($D(^DIC(42,+$P(OMAS(X),"^",2),0)):$P(^(0),"^"),1:"") S Z=Z+1 D LINCK Q:Y="^"
ASKM ;
 D ASKM0 G Q1:"^"[NURSX I NURSX="A"!(NURSX="B")!(NURSX="D"&NURSOMAS) W "  ",$P($T(@NURSX),";;",2),! D ADDM^NURSALE0:NURSX="A",DELM^NURSALE0:NURSX="D" G Q1:NURSX="^",ABED:NURSX="B",MAS
ABED ;
 S NURSOBED=+$O(^NURSF(211.4,NURSWARD,4,0)) G:'NURSOBED ASKB
OBED ;
 K OBED S Z=1 F X=0:0 S X=$O(^NURSF(211.4,NURSWARD,4,X)) Q:X'>0  S Y=$S($D(^NURSF(211.4,NURSWARD,4,X,0)):$P(^(0),"^"),1:"") S:Y'="" OBED(Z)=X_"^"_Y,Z=Z+1
 S OBED=Z-1 W !!?7,"AMIS Bed section",?43,"Associated MAS ward"
 S Z=0 F X=0:0 S X=$O(OBED(X)) Q:X'>0  W !,$J(X,2),". ",$S($D(^NURSF(213.3,+$P(OBED(X),"^",2),0)):$P(^(0),"^"),1:"") S Z=Z+1 D LINCK Q:Y="^"  D PMAS Q:Y="^"
ASKB ;
 D ASKB^NURSALE0 G Q1:"^"[NURSX I NURSX="A"!(NURSX="B")!((NURSX="D"!(NURSX="E"))&NURSOBED) W "  ",$P($T(@NURSX),";;",2),! D ADDB^NURSALE0:NURSX="A",DELB^NURSALE0:NURSX="D",EDM^NURSALE0:NURSX="E" G Q1:NURSX="^",BYPB:NURSX="B",ABED
BYPB ;
 G Q1:NURSREV W ! S DR="[NURS-I-PRIORITY 1A]",DIE="^NURSF(211.4,",DA=NURSWARD D ^DIE
 D ^NURSBPO
Q1 ;
 D ^NURSKILL
 Q
PMAS ;
 S Y="",B=$O(^NURSF(211.4,"ABS",+$P(OBED(X),"^",2),NURSWARD,3,0)) Q:B'>0
 F A=B:0 W:A'=B ! S:A'=B Z=Z+1 D:A'=B LINCK Q:Y="^"  S C=$S($D(^NURSF(211.4,NURSWARD,3,A,0)):$P(^(0),"^"),1:"") W ?41,$S($D(^DIC(42,+C,0)):$P(^(0),"^"),1:"") S A=$O(^NURSF(211.4,"ABS",+$P(OBED(X),"^",2),NURSWARD,3,A)) Q:A'>0
 Q
LINCK ;
 I Z>(IOSL-3) W !,"Press return to continue or ""^"" to exit: " R Y:DTIME S:'$T Y="^" Q:Y="^"  S Z=0
 Q
ASKM0 ;
 W:'NURSOMAS !!,"There are no MAS wards associated with this Nursing unit."
 W !,"Would you like to (A)dd new MAS wards" W:NURSOMAS ", (D)elete existing units from the",!,"above listing" W " or (B)ypass " W:'NURSOMAS ! W "this prompt (A"_$S(NURSOMAS:"/D",1:"")_"/B): "_$S(NURSOMAS:"B",NURSNEW:"A",1:"B")_"// "
 R X:DTIME S NURSX=$S('$T:"^",X'="":$S(X'?1L:X,1:$C($A(X)-32)),NURSOMAS:"B",NURSNEW:"A",1:"B") Q:"^"[NURSX!(NURSX="B")!(NURSX="A")!(NURSX="D"&NURSOMAS)
 I NURSX?1"?".E W !?4,$C(7),"ANSWER WITH A IF YOU WOULD LIKE TO ADD MORE MAS WARDS FOR THIS UNIT" W:NURSOMAS ",",!?16,"D IF YOU WOULD LIKE TO DELETE MAS WARDS FROM THE ABOVE LISTING,"
 I  W !?13,"OR B IF YOU WOULD LIKE TO DO NOTHING AND BYPASS THIS PROMPT." G ASKM0
 W !?4,$C(7),"INVALID ENTRY, TYPE ? TO GET MORE HELP" G ASKM0
 ;
A ;;ADD NEW ENTRIES
B ;;BYPASS PROMPT
D ;;DELETE EXISTING ENTRIES
E ;;EDIT RELATIONSHIP
