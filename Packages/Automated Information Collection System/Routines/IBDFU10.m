IBDFU10 ;ALB/CJM - ENCOUNTER FORM (uncompile forms,blocks);DEC 14,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
UNCMPILE ;
 N BLK,FORM
 ;
 W !,"Beginning to Uncompile Forms and Blocks"
 ;
 ;set COMPILED? field for forms to 0
 S FORM=0 F  S FORM=$O(^IBE(357,FORM)) Q:'FORM  S $P(^IBE(357,FORM,0),"^",5)=0
 ;
 ;delete cross-references for compiled blocks
 S BLK=0 F  S BLK=$O(^IBE(357.1,BLK)) Q:'BLK  D UNCMPBLK^IBDF19(BLK)
 ;
 W !,"Forms and Blocks have been Uncompiled!"
 Q
