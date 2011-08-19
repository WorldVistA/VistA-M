IVMUM5 ;ALB/SEK - ADD NEW INCOME RELATION FILE ENTRIES ; 19 MAY 94
 ;;2.0;INCOME VERIFICATION MATCH;**1,17**;21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; this routine will add entries to INCOME RELATION file (408.22) 
 ; will also inactivate VAMC dependents (spouse & children) who are not
 ; IVM dependents, by adding an inactivate entry into the EFFECTIVE DATE
 ; sub-file (multiple-408.1275) of the PATIENT RELATION file (#408.12)
 ;
 ; DFN    Patient file IEN
 ; DGINI  Individual Annual Income IEN
 ; DGIRI  Income Relation IEN
 ; IVMSEG ZIR record for veteran or spouse or dependent
 ; IVM0   408.22 0 node pieces 5-7
 ; IVM01         0 node pieces 9-12
 ; IVM02         0 node piece  6
 ;
 N IVM0,IVM01,IVM02
 S DGIRI=$$ADDIR^DGMTU2(DFN,DGINI)
 ;
 ; if can't create stub notify site & IVM Center
 I DGIRI'>0 D  Q
 .S (IVMTEXT(6),HLERR)="Can't create stub for file 408.22"
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 .S IVMFERR=""
 ;
 ; set "mt" node to annual means test ien
 D MT^DGMTSCU3(DGIRI,DGMTI)
 Q:IVMSPCHV="S"
 ;
 ; set number of dependent children (#.13) and dependent children(#.08)
 ; in income relation file (#408.22) based on active child dependents
 ; in patient relation file (#408.12).
 ; make IVM means test primary income test for year
 I IVMSPCHV="V" D  Q:$D(IVMFERR)
 .S DA=IVMMTIEN,DIE="^DGMT(408.31,",DR="2////0" D ^DIE ; vamc mt
 .S DA=DGMTI,DIE="^DGMT(408.31,",DR="2////1" D ^DIE ; ivm mt
 .;
 .; inactivate VAMC dependents who are not IVM dependents
 .K DGREL("V")
 .I $D(DGREL) D INACTIVE Q:$D(IVMFERR)
 .;
 .D RESET^DGMTU11(DFN,DGLY,DGMTI)
 .I $P($G(^DGMT(408.22,DGIRI,0)),"^",8)="" D
 ..S DA=DGIRI,DR=".08////0;.13////@",DIE="^DGMT(408.22," D ^DIE
 ..K DA,DR,DIE
 .S IVM0=$P(IVMSEG,"^",2,4)
 I IVMSPCHV="C" S IVM01=$P(IVMSEG,"^",6,9),IVM02=$P(IVMSEG,"^",3)
 S DIK="^DGMT(408.22,"
 L +^DGMT(408.22,DGIRI) S:IVMSPCHV="V" $P(^DGMT(408.22,DGIRI,0),"^",5,7)=IVM0 S:IVMSPCHV="C" $P(^DGMT(408.22,DGIRI,0),"^",9,12)=IVM01,$P(^(0),"^",6)=IVM02 S DA=DGIRI D IX1^DIK L -^DGMT(408.22,DGIRI)
 K DA,DIK
 Q
 ;
INACTIVE ; inactivate dependents not in IVM means test and kill
 ; corresponding dgrel
 I $D(DGREL("S")) S DA(1)=+DGREL("S") D  K DGREL("S")
 .D CHKINACT
 .Q:IVMFLG6!($D(IVMFERR))
 .; if spouse was active before income year, add record with date
 .; of 12/31 of year before income year with active code 0
 .S X=$E(DGLY,1,3)-1_1231
 .D INACT1
 Q:'$D(DGREL)!($D(IVMFERR))
 S IVMACTR=0
 F  S IVMACTR=$O(DGREL("C",IVMACTR)) Q:'IVMACTR  S DA(1)=+DGREL("C",IVMACTR) D  K DGREL("C",IVMACTR)
 .D CHKINACT
 .Q:IVMFLG6!($D(IVMFERR))
 .; if child was active before income year, add record with date
 .; of 12/31 of year before income year with active code 0
 .S X=$E(DGLY,1,3)-1_1231
 .D INACT1
 ;
 K IVMACTR,IVMDGLY,IVMFLG6,IVMYEAR
 Q
 ;
CHKINACT ; if dependent was made active during income year
 ; add record for same date (add .08 time) with active code 0
 ;
 S IVMFLG6=0
 S IVMDGLY="" F  S IVMDGLY=$O(^DGPR(408.12,DA(1),"E","B",IVMDGLY)) Q:IVMDGLY']""  D  Q:IVMFLG6!($D(IVMFERR))
 .Q:$E(IVMDGLY,1,3)'=$E(DGLY,1,3)
 .S IVMYEAR=0 F  S IVMYEAR=$O(^(IVMDGLY,IVMYEAR)) Q:IVMYEAR']""  D  Q:IVMFLG6!($D(IVMFERR))
 ..I $P($G(^DGPR(408.12,DA(1),"E",IVMYEAR,0)),"^",2) D
 ...S X=IVMDGLY_.08 D INACT1 S IVMFLG6=1
 ...Q
 Q
 ;
INACT1 ; add inactivate entry to 408.1275
 ;
 K DINUM
 S (DIK,DIC)="^DGPR(408.12,DA(1),""E"",",DIC(0)="L",DLAYGO=408.1275 K DD,DO D FILE^DICN S DA=+Y K DLAYGO
 ;
 ; if can't create stub notify site & IVM Center
 I DA'>0 D  Q
 .S (IVMTEXT(6),HLERR)="Can't create stub for file 408.1275"
 .D ERRBULL^IVMPREC7,MAIL^IVMUFNC()
 .S IVMFERR=""
 L +^DGPR(408.12,+DGPRI) S $P(^DGPR(408.12,DA(1),"E",DA,0),"^",2,4)=0_"^"_1_"^"_DGMTI D IX1^DIK L -^DGPR(408.12,+DGPRI)
 K DA,DIC,DIK
 Q
