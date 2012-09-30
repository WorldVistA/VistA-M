LEX2081A ;ISL/KER - LEX*2.0*81 Pre/Post Install (cont) ;08/17/2011
 ;;2.0;LEXICON UTILITY;**81**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757,
 ;    ^LEX(757.001
 ;    ^LEX(757.01
 ;    ^LEX(757.02
 ;    ^LEX(757.1
 ;               
 ; External References
 ;    ^%ZTLOAD            ICR  10063
 ;    ^DIK                ICR  10013
 ;    ENALL^DIK           ICR  10013
 ;    IX1^DIK             ICR  10013
 ;    IX2^DIK             ICR  10013
 ;    MES^XPDUTL          ICR  10141
 ;               
 Q
POST ; Post-Install (Continue)
 D AVA,AWRD,CHG
 Q
CHG ; Changes
 D CHG1,CHG2
 Q
AVA ; AVA Cross-Reference
 N Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="AVAT^LEX2081A",ZTIO="",ZTDTH=$H
 S ZTDESC="Lexicon Rebuild AVA Cross-Reference" D ^%ZTLOAD
 D MES^XPDUTL(" Checking cross-references")
 Q
AVAT ; AVA Cross-Reference (task)
 N DIK S DIK="^LEX(757.02,",DIK(1)="2^AVA" D ENALL^DIK
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
AWRD ; AWRD Cross-Reference
 N Y,ZTQUEUED,ZTREQ,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTRTN="AWRDT^LEX2081A",ZTIO="",ZTDTH=$H
 S ZTDESC="Lexicon Rebuild AWRD Cross-Reference" D ^%ZTLOAD
 D:+($G(ZTSK))>0 MES^XPDUTL((" A task has been created to rebuild the AWRD cross-reference (#"_+($G(ZTSK))_")"))
 D:+($G(ZTSK))'>0 MES^XPDUTL(" Rebuilding the AWRD cross-reference")
 Q
AWRDT ; AWRD Cross-Reference (task)
 N DIK S DIK="^LEX(757.01,",DIK(1)="2^AWRD" D ENALL^DIK
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CHG1 ; Change 1 - Sleep Deprivation/Lack of Adequate Sleep
 N CODE,DA,DIK,EFF,EX,FQ,MC,OM,SAB,SO
 ; Key Words for #331586, "Lack of Adequate Sleep"
 S EX=331586
 S ^LEX(757.01,EX,5,0)="^757.18^2^2"
 S ^LEX(757.01,EX,5,1,0)="SLEEP"
 S ^LEX(757.01,EX,5,2,0)="DEPRIVATION"
 S DA=EX,DIK="^LEX(757.01," D IX1^DIK
 ; Key Words for #111265, "Sleep Deprivation"
 S EX=111265
 S ^LEX(757.01,EX,5,0)="^757.18^4^4"
 S ^LEX(757.01,EX,5,1,0)="LACK"
 S ^LEX(757.01,EX,5,2,0)="OF"
 S ^LEX(757.01,EX,5,3,0)="SLEEP"
 S ^LEX(757.01,EX,5,4,0)="ADEQUATE"
 S DA=EX,DIK="^LEX(757.01," D IX1^DIK
 ; ICD Code for #111265, "Sleep Deprivation"
 S MC=22890,FQ=22890,EX=111265,SO=117782,CODE="V69.4",EFF=3041001,SAB=1
 S ^LEX(757.02,SO,0)=EX_"^"_CODE_"^"_SAB_"^"_MC_"^0^^1"
 S ^LEX(757.02,SO,4,0)="^757.28D^1^1"
 S ^LEX(757.02,SO,4,1,0)=EFF_"^1",DA=SO,DIK="^LEX(757.02," D IX1^DIK
 ; Move Expression to New Major Concept as a Synonym
 S MC=22890,OM=7112472
 S DA=7224943,DIK="^LEX(757.01," D IX2^DIK
 S ^LEX(757.01,7224943,0)="Sleep Deprivation"
 S ^LEX(757.01,7224943,1)=MC_"^2^D^1"
 S DA=7224943,DIK="^LEX(757.01," D IX1^DIK
 S DA=7224944,DIK="^LEX(757.01," D IX2^DIK
 S ^LEX(757.01,7224944,0)="Sleep Deprivation (finding)"
 S ^LEX(757.01,7224944,1)=MC_"^8^D^15"
 S DA=7224944,DIK="^LEX(757.01," D IX1^DIK
 ; Move Semantic Map to new Major Concept
 S DA=7112472,DIK="^LEX(757.1," D IX2^DIK
 S ^LEX(757.1,7112472,0)=MC_"^10^71"
 S DA=7112472,DIK="^LEX(757.1," D IX1^DIK
 ; Move Code to new Major Concept
 S DA=7112472,DIK="^LEX(757.02," D IX2^DIK
 s ^LEX(757.02,7112472,0)="7224943^130989002^56^"_MC_"^1^^1"
 S DA=7112472,DIK="^LEX(757.02," D IX1^DIK
 ; Delete old Frequency
 I $D(^LEX(757.001,OM,0)) D
 . S DA=OM,DIK="^LEX(757.001," D ^DIK
 ; Delete old Major Concept Map
 I $D(^LEX(757,OM,0)) D
 . S DA=OM,DIK="^LEX(757," D ^DIK
 Q
CHG2 ; Change 2 - Loss of Consciousness
 S MC=7367393,EX=7941742,SO=270124,CODE="780.09",EFF=2781001,SAB=1
 ; Frequency
 S DA=7367393,DIK="^LEX(757.001," D IX2^DIK
 S ^LEX(757.001,7367393,0)="7367393^6^6"
 S DA=7367393,DIK="^LEX(757.001," D IX1^DIK
 ; Expression
 S DA=EX,DIK="^LEX(757.01," D IX2^DIK
 S ^LEX(757.01,7941742,0)="Loss of Consciousness"
 S DA=EX,DIK="^LEX(757.01," D IX1^DIK
 ; Code
 S ^LEX(757.02,SO,0)=EX_"^"_CODE_"^"_SAB_"^"_MC_"^0^^1"
 S ^LEX(757.02,SO,4,0)="^757.28D^1^1"
 S ^LEX(757.02,SO,4,1,0)=EFF_"^1"
 S DA=SO,DIK="^LEX(757.02," D IX1^DIK
 Q
