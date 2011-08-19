GMRYUT8 ;HIRMFO/YH - IV/LOCK/PORT ENTER/EDIT ;2/12/91
 ;;4.0;Intake/Output;**6**;Apr 25, 1997
IV ;EDIT OR DELETE IV RECORD
 S GX(1)=+GX,GX(2)="",GDCREAS=$P(^GMR(126,DA(2),"IV",DA(1),0),"^",11)
REASK S GREC(1)=0 I GMRDEL="@" S %=1 W !!,"Are you sure you want to delete" D YN^DICN S:%<0 GMROUT=1 W:%=0 !!,"Enter N(o) if you do not want to delete this record or '^' to quit.",! G:%=0 REASK D:%=1 KILLRC K % Q
REDIT S Y=+GX X ^DD("DD")
 W:GMRVTYP'="L" !!,"Enter "_$S(GLABEL'="":GLABEL_" intake dated ",1:"solution left in the container on ")_$P(Y,":",1,2),!,?5,"Enter * for AMOUNT LEFT if amount of solution absorbed is unknown.",!,?10,"Unit mls is not required.",!
 S DIE="^GMR(126,"_DA(2)_",""IV"","_DA(1)_",""IN"","
 S DR="S GMRZZZ="""" S:GMRVTYP=""P""!(GMRVTYP=""L""!(GDCREAS[""INFUSED"")) GMRZZZ=0;"_$S(GMRVTYP="L":"1///",1:"1//")_"^S X=GMRZZZ;3///^S X=""`""_DUZ;4///^S X=""`""_GHLOC;" D WAIT^GMRYUT0 I GMROUT K DIE,DR Q
 ;; GMRY*4*6 - RJS  ADDED THE DA SETS
 D ^DIE L -^GMR(126,DFN) K DIE,DR S GMRDA=$P(^GMR(126,DA(2),"IV",DA(1),"IN",DA,0),"^",2),GREC(1)=DA I GMRDA="" D KILLRC S GMROUT=1,DA=DA(1),DA(1)=DA(2) K GIN Q
 K GIN S DA=DA(1),DA(1)=DA(2) Q:GMRVTYP="L"
 I $D(^GMR(126,DA(1),"IV",DA,0)) D IVINTK W !!,"Intake for this period: "_$S($P(^GMR(126,DFN,"IV",DA,"IN",GREC(1),0),"^",2)="*":"unknown",1:$P(GIN(+GX),"^",2)_" mls   ")
 I $D(GIN(+GX)),$P(GIN(+GX),"^",2)<0 W !!,"ERROR ENTRY!!!" S $P(^GMR(126,DFN,"IV",DA,"IN",GREC(1),0),"^",2)="",DA(2)=DA(1),DA(1)=DA,DA=GREC(1) G REDIT
 ;; GMRY*4*6 - RJS  ADDED THE DA SETS
 S %=1 D YN^DICN I %<0 S DA(2)=DA(1),DA(1)=DA,DA=GREC(1) D KILLRC S GMROUT=1,DA=DA(1),DA(1)=DA(2) K DA(2) Q
 I %'=1 S $P(^GMR(126,DFN,"IV",DA,"IN",GREC(1),0),"^",2)="",DA(2)=DA(1),DA(1)=DA,DA=GREC(1) G REDIT
 Q
KILLRC S DIK="^GMR(126,"_DA(2)_",""IV"","_DA(1)_",""IN""," D ^DIK K DIK S Y=GX(1) X ^DD("DD") W !!,GLABEL_" Entered on "_$P(Y,":",1,2)_" has been deleted!!!",! S GREC(1)=0,$P(^GMR(126,DFN,"IV",DA(1),0),"^",9)="" Q
IVINTK ;CALCULATE IV INTAKE FOR EACH IV INTAKE RECORD
 S:'$D(^GMR(126,DA(1),"IV",DA,0)) GMROUT=1 Q:GMROUT  K GIN S (GTOTAL(1),GTOTAL)=+$P(^GMR(126,DA(1),"IV",DA,0),"^",5),GSOL=$P(^(0),"^",3)
 S GDT=0,GSTAR="" F  S GDT=$O(^GMR(126,DA(1),"IV",DA,"IN","B",GDT)) Q:GDT'>0  S GDA=$O(^GMR(126,DA(1),"IV",DA,"IN","B",GDT,0)) Q:GDA'>0  D SETGIN
 K GINTAKE,GDT,GDA Q
 Q
SETGIN S GLEFT=$P(^GMR(126,DA(1),"IV",DA,"IN",GDA,0),"^",2),GXX=^(0)
 S GINTAKE=$S($E(GLEFT)=".":GTOTAL-GLEFT,$A($E(GLEFT))<48!($A($E(GLEFT))>57):0,1:GTOTAL-GLEFT),GTOTAL=GTOTAL-GINTAKE,(GIN(GDT),GIN(GDA))=GLEFT_"^"_GINTAKE_"^"_$P(GXX,"^",4)_"^"_GSOL S:GLEFT["*" GSTAR="unknown" K GXX Q
LOCK ;CONVERT TO LOCK/PORT
 S GHLOC=GMRHLOC K DD S X=+GX,DLAYGO=126.03,DA(1)=DFN,DIC="^GMR(126,"_DA(1)_",""IV"",",DIC(0)="ML" D WAIT^GMRYUT0 Q:GMROUT  D FILE^DICN L -^GMR(126,DFN) K DIC,DLAYGO,DD S DA=+Y Q:Y'>0!GMROUT
 S DIE="^GMR(126,"_DA(1)_",""IV"",",DR="2///^S X=GMRZ;3///^S X=GMRZ(1);4///^S X=GMRZ(2);11///^S X=GMRZ(3);6///^S X=""`""_DUZ;7///^S X=""`""_GHLOC;1///^S X=GSITE;17///^S X=GCATH(1)"
 D WAIT^GMRYUT0 D:'GMROUT ^DIE K DIE,DR L:'GMROUT -^GMR(126,DFN) Q
MOREDRN ;ENTER MORE THAN ONE DRAINAGE DATA
 K DD S DLAYGO=126.02,X=+GX,DA(1)=DFN,DIC="^GMR(126,"_DA(1)_","""_GNANS_""",",DIC(0)="ML" D WAIT^GMRYUT0 Q:GMROUT  D FILE^DICN L -^GMR(126,DFN) K DIC,DLAYGO,DD S DA=+Y S:Y'>0 GMROUT=1 Q
DC ;DC IV FROM IV INTAKE
 S GDATA=^GMR(126,DFN,"IV",DA,0),GDT=$P(GDATA,"^"),GTYPE=$P(GDATA,"^",4) W !!,"Discontinue ",?5,$P(GDATA,"^",3)_"  "_$S(GTYPE'["L":$P(GDATA,"^",5)_" mls ("_GTYPE_") ",1:"")_$P(GDATA,"^",2)
 S Y=GDT X ^DD("DD") W "   started on "_$P(Y,":",1,2),!
 S GDCDT=+GX,DIE="^GMR(126,"_DA(1)_",""IV"",",DR="8///^S X=+GX;9///^S X=""`""_DUZ;10///^D DCREASON^GMRYUT11" D WAIT^GMRYUT0 I 'GMROUT D ^DIE L -^GMR(126,DFN)
 K DIE,DR Q
