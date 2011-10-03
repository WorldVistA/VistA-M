GMRAUTL3 ;SLC/DAN - New style index utilities continued ;1/7/08  09:36
 ;;4.0;Adverse Reaction Tracking;**41**;Mar 29, 1996;Build 8
 ;DBIA Section
 ;PSN50P41 - 4531
 ;PSN50P65 - 4543
 ;XLFDT    - 10103
 ;
ADDCOM ;Add comment to updated allergy indicating changes
 Q  ;Not currently in use
 N TYPE,ROOT,SUB2,DICR,DIEL,DL,DP,DM,DK,DIK,DC,DE,GLOB,DH,D,DQ,DR,DIC,DIE,DIA,DI,DG,DDH,DDER,DA,D0,D1
 K ^TMP($J,"GMRAINFO") ;41 Clear out storage space
 F GLOB="ING(""A"")","ING(""D"")","CLASS(""A"")","CLASS(""D"")" I $D(@GLOB) D
 .S TYPE=$S(GLOB="ING(""A"")":1,GLOB="ING(""D"")":2,GLOB="CLASS(""A"")":3,1:4) ;Determines if we're adding or deleting ingredients or classes
 .S COM="The following "_$S(TYPE=1!(TYPE=2):"ingredients",1:"drug classes")_" were "_$S(TYPE=2!(TYPE=4):"deleted",1:"added")_": "
 .S ROOT=$S(TYPE=1:"ING(""A"")",TYPE=2:"ING(""D"")",TYPE=3:"CLASS(""A"")",1:"CLASS(""D"")")
 .S SUB2=0 F  S SUB2=$O(@ROOT@(SUB2)) Q:'+SUB2  I @ROOT@(SUB2) S COM=COM D  ;41 Split code, added dot structure
 ..I TYPE=1!(TYPE=2) D ZERO^PSN50P41(SUB2,,$$DT^XLFDT,"GMRAINFO") ;41 ingredient call
 ..I TYPE=3!(TYPE=4) D C^PSN50P65(SUB2,,"GMRAINFO") ;41 drug class call
 ..S COM=COM_$G(^TMP($J,"GMRAINFO",SUB2,.01)) ;41 adds data
 .I $P(COM,": ",2)'="" L +^GMR(120.8,SUB) D ADCOM^GMRAFX(SUB,"O",COM) L -^GMR(120.8,SUB)
 Q
