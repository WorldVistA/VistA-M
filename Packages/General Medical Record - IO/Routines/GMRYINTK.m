GMRYINTK ;HIRMFO/YH-PATIENT INTAKE ;11/6/96
 ;;4.0;Intake/Output;;Apr 25, 1997
INTAKE ;EDIT OR DELETE INPUT RECORD
 S GX(1)=+GX I GMRDEL="@" S %=1 W !!,"Are you sure you want to delete this record" D YN^DICN S:%<0 GMROUT=1 W:%=0 !!,"Enter N(o) if you do not want to delete this record or '^' to quit.",! G:%=0 INTAKE D:%=1 KILLRC K % Q
 S Y=+GX X ^DD("DD") W ! D:GNI>GMRYITM ITEM W !,"Enter "_GLABEL_" dated "_Y W !,?5,"Unit ml is not required.",!
 I GNI>GMRYITM S DR="1///^S X=GLABEL;3;7///^S X=""`""_GHLOC;6///^S X=""`""_DUZ;",DR(2,126.13)=".01;I $P(^GMRD(126.8,+X,0),""^"")'[""OTHER"" S Y=""@1"";2;@1;1"
 E  S DR="1///^S X=GLABEL;7///^S X=""`""_GHLOC;6///^S X=""`""_DUZ;4;8;"
 S GEDIT=1,GMRYTYP=GTP,DIE="^GMR(126,"_DA(1)_",""IN""," D WAIT^GMRYUT0 I GMROUT K DIE,DR Q
 D ^DIE L -^GMR(126,DFN) K DIE,DR S:'$D(^GMR(126,DA(1),GNANS,DA,0)) GMROUT=1 I GMROUT Q
 S DA(2)=DA(1),DA(1)=DA I $D(^GMR(126,DA(2),"IN",DA(1),1)) D EN3^GMRYUT2
 S DA=DA(1),DA(1)=DA(2)
 I $P(^GMR(126,DA(1),GNANS,DA,0),"^",5)="" D KILLRC Q
 W !!,?5,"Total "_GLABEL_" intake for this time: ",$P(^GMR(126,DA(1),GNANS,DA,0),"^",5)_" mls" Q
 ;
KILLRC S DIK="^GMR(126,"_DA(1)_","""_GNANS_"""," D ^DIK K DIK S Y=+GX X ^DD("DD") W !!,GLABEL_" Entered on "_$P(Y,":",1,2),"  has been deleted!!!",! Q
 ;
ITEM W !,"You may select the following items:",! S (GTM,GTM(1))=0 F  S GTM=$O(^GMRD(126.8,"C",GTP,GTM)) Q:GTM'>0!GMROUT  W:$D(^GMRD(126.8,+GTM,0)) ?5,$P(^(0),"^"),?20,$P(^(0),"^",2),?25,"mls",! S GTM(1)=GTM(1)+1 I (GTM(1)#18)=0 D  W !
 .W "Return to continue " S GTM(2)="" R GTM(2):DTIME S:'$T!(GTM(2)["^") GMROUT=1
 K GTM S GMROUT=0 Q
