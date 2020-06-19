DGPPSYCH ;LIB/MKN - PRESUMPTIVE PSYCHOSIS SCREEN 7 ;08/01/2019
 ;;5.3;Registration;**977**August 01, 2019;;Build 177
 ;
 ;IA's
 ; 10003 Sup ^%DT
 ; 10004 Sup ^DIQ: $$GET1, GETS
 ; 10018 Sup ^DIE
 ; 10026 Sup ^DIR
 ;
YN(DFN) ;
 ;This API gets called from input template DG LOAD EDIT SCREEN 7 at tag @705 (toward the end)
 ;Some of the variables NEWd here are because FileMan was crashing due to them getting killed in DIE
 N DA,DGARR,DIC,DIE,DIK,DIR,DIROUT,DIRUT,DL,DP,DR,DTOUT,DUOUT,DGPPC,IEN331,IEN3312,Y
YN1 ;
 K DGARR D GETS^DIQ(2,DFN_",",".5601;1901","IE","DGARR")
 Q:$G(DGARR(2,DFN_",",1901,"I"))'="Y"  ;Not VETERAN="YES"
 S DGPPC=$G(DGARR(2,DFN_",",.5601,"I"))
 K DIR S DIR(0)="Y",DIR("A")="PRESUMPTIVE PSYCHOSIS",DIR("B")=$S(DGPPC]"":"Y",1:"N") D ^DIR
 Q:$D(DIRUT)
 I 'Y D  Q
 .S IEN331=$O(^DGPP(33.1,"B",DFN,"")) I IEN331 D
 ..S DIK="^DGPP(33.1,",DA=IEN331 D ^DIK
 ..S DIE="^DPT(",DA=DFN,DR=".5601///@" D ^DIE
 ..Q
 .Q
 ;
 K DIR S DIR(0)="2,.5601AO",DIR("B")=DGPPC
 D ^DIR G:$D(DIRUT) YN1
 S DIE="^DPT(",DA=DFN,DR=".5601///"_Y_";" D ^DIE
 Q
 ;
CH(DFN) ;
 ;This API is called by cross-reference "AX" on #2,#.5601 to make an entry in file #33.1
 ;
 N DGCAT,DGERR,DGFDA,DGIEN331,DGIEN3312,DGIENS,DGX,IEN331,IEN331S,IEN3312,IEN3312S,IEN33121,IEN33121S
 ;
 S DGCAT=$$GET1^DIQ(2,DFN_",",.5601,"I")
 ;Find existing entry, if any, for this patient
 S IEN331=$O(^DGPP(33.1,"B",DFN,"")),IEN331S=$S(IEN331:IEN331_",",1:"+1,")
 K DGERR,DGFDA I 'IEN331 S DGFDA(33.1,IEN331S,.01)=DFN D UPDATE^DIE(,"DGFDA","DGIENS","DGERR") S IEN331=$G(DGIENS(1)),IEN331S=IEN331_","
 I DGCAT="",'$$EXISTS(IEN331,"") D SET(IEN331,"") Q
 ;At this point we have found an existing patient entry or created one
 ;Check if the last entry in the DATE OF CHANGE multiple (#33.121) for this patient was same
 ; Presumptive Psychosis Category. If so, quit, do not add same category for later date.
 Q:$$EXISTS(IEN331,DGCAT)
 K DGERR,DGFDA
 ;Create new entry in DATE OF CHANGE multiple (#33.12) for NOW and DGCAT
 ; with new Presumptive Psychosis Category
 D SET(IEN331,DGCAT)
 Q
 ;
SET(IEN331,DGCAT) ;
 K DGERR,DGFDA
 ;Create new entry in CHANGES multiple (#33.12) for 'today' showing deleted
 ; with new Presumptive Psychosis Category
 S DGFDA(33.12,"+1,"_IEN331_",",.01)=DT
 S DGFDA(33.12,"+1,"_IEN331_",",.02)=DGCAT
 S DGFDA(33.12,"+1,"_IEN331_",",.03)=DUZ
 D UPDATE^DIE(,"DGFDA",,"DGERR")
 Q
 ;
EXISTS(IEN331,DGCAT) ;
 ;Check if the last entry in the CHANGES multiple (#33.12)
 ; is the same Presumptive Psychosis Category
 N DGCATE,DGN
 S DGN=$O(^DGPP(33.1,IEN331,"CH","B","@"),-1) Q:'DGN 0 S DGN=$O(^DGPP(33.1,IEN331,"CH","B",DGN,""),-1) Q:'DGN 0
 S DGCATE=$P(^DGPP(33.1,IEN331,"CH",DGN,0),U,2)
 Q $S(DGCATE=DGCAT:1,1:0)
 ;
