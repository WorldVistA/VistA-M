IBDE4 ;ALB/AAS - PUT FORMS AND BLOCKS INTO IMPORT/EXPORT UTILTIY ;AUG 12,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
ADD ; -- add forms to the import exort utility
 N FORM,NEWFORM,FORMNM,CNT,CNT1,ARY,NAME,X,Y,NEWBLOCK,A,EXCLUDE,BLK
 F CNT=1:1 S FORMNM=$P($T(FORMS+CNT),";;",2,99) Q:FORMNM=""  D
 .S FORM=$O(^IBE(357,"B",$E(FORMNM,1,30),0))
 .Q:$O(^IBE(358,"B",$E(FORMNM,1,30),0))
 .W !,"Moving Form '"_FORMNM_"' to import export utility"
 .S NEWFORM=$$COPYFORM^IBDFU2C(FORM,357,358,"",1)
 ;
 ; -- add all blocks for a form
 F CNT=1:1 S FORMNM=$P($T(BLOCKS+CNT),";;",2,99) Q:FORMNM=""  D
 .S FORM=$O(^IBE(357,"B",$E(FORMNM,1,30),0))
 .Q:$O(^IBE(358,"B",$E(FORMNM,1,30),0))
 .S ARY="A",EXCLUDE="" K A
 .S CNT1=$$FINDALL^IBDFU8
 .S NAME="" F  S NAME=$O(A("NAME",NAME)) Q:NAME=""  S BLK=0 F  S BLK=$O(A("NAME",NAME,BLK)) Q:'BLK  D
 ..W !,"Moving Block '"_NAME_"' from form '"_FORMNM_"' to utility"
 ..;Q:$O(^IBE(357.1,"B",NAME,0))  ;quit if same block from same form
 ..S NEWBLOCK=$$COPYBLK^IBDFU2(BLK,"",357.1,358.1,"","",1)
 Q
 ;
AUTOINS ; -- auto install tool kit into production
 N FORM,NEWFORM,FORMNM,CNT,CNT1,ARY,NAME,X,Y,NEWBLOCK,A,EXCLUDE,BLK,CNTF,CNTB
 W !!,">>> Now Attempting to automatically update Tool Kit forms and Tool Kit Blocks."
 S (CNTB,CNTF)=0
 ;
 ; -- add all tool kit blocks
 S FORMNM="TOOL KIT"
 I '$O(^IBE(357,"B",FORMNM,0)) G FRM
 S ORD="" F  S ORD=$O(^IBE(358.1,"D",ORD)) Q:ORD=""  S BLK=0 F  S BLK=$O(^IBE(358.1,"D",ORD,BLK)) Q:'BLK  D
 .S NAME=$P($G(^IBE(358.1,+BLK,0)),"^")
 .Q:$P($G(^IBE(358.1,BLK,0)),"^",14)'=1  ;not toolkit
 .Q:$O(^IBE(357.1,"B",NAME,0))  ;already installed
 .W !,"    Moving Block '"_$P($G(^IBE(358.1,+BLK,0)),"^")_"' from import/export to Tool Kit"
 .N IBTKBLK S IBTKBLK=1
 .S NEWBLOCK=$$COPYBLK^IBDFU2(BLK,$$TKFORM^IBDFU2C,358.1,357.1,"","",$$TKORDER^IBDF13),CNTB=CNTB+1
 .D:$G(NEWBLOCK) DLTBLK^IBDFU3(BLK,"",358.1)
 ;
FRM ; -- Add tool kit forms
 F CNT=1:1 S FORMNM=$P($T(FORMS+CNT),";;",2,99) Q:FORMNM=""  D
 .S FORM=$O(^IBE(358,"B",$E(FORMNM,1,30),0))
 .Q:$O(^IBE(357,"B",$E(FORMNM,1,30),0))
 .W !,"    Moving Form '"_FORMNM_"' from import export utility to AICS"
 .S NEWFORM=$$COPYFORM^IBDFU2C(FORM,358,357,"",1),CNTF=CNTF+1
 ;
 I CNTF=0,CNTB=0 W !!,">>> Tool Kit Forms and Blocks are already installed." Q
 W !!,">>>   Tool Kit Forms sent (4): ",$J(CNTF,3)_" installed"
 W !,">>> Tool Kit Blocks sent (28): ",$J(CNTB,3)_" installed"
 Q
 ;
FORMS ;;
 ;;DEFAULTS
 ;;
 ;;
 ;;AMBULATORY SURGERY SAMPLE V2.1
 ;;EMERGENCY SERVICES SAMPLE V2.1
 ;;PRIMARY CARE SAMPLE V2.1
 ;;
BLOCKS ;;
 ;;TOOL KIT
 ;;
