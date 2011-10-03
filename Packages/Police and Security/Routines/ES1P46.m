ES1P46 ;PHOENIX/KLD - Patch ES*1*46 Post-init - remove W,D,L file access to Police files; 5/15/09  4:04 PM
 ;;1.0;POLICE & SECURITY;**46**;May 8.2009;Build 12
 ;;Integration agreement #5439
ST Q:'$D(^VA(200,"AFOF"))  ;No Kernel File Access Security
 N DA,DIE,DR,ESI,ESII S DR="2///@;3///@;5///@"
 F ESI=0:0 S ESI=$O(^VA(200,ESI)) Q:'ESI  D
 .F ESII=909.9:0 S ESII=$O(^VA(200,ESI,"FOF",ESII)) Q:'ESII!(ESII>916)  D
 ..L +^VA(200,ESI,"FOF"):5
 ..I $T S DIE="^VA(200,"_ESI_",""FOF"",",DA(1)=ESI,DA=ESII D ^DIE L -^VA(200,ESI,"FOF")
 Q
