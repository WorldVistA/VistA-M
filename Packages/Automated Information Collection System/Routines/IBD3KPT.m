IBD3KPT ;ALB/MAF - Post Init routine for AICS v 3.0 - 11 NOV 96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 D ADDNAR,GARBAGE,SCDATA,AUTOINS,LEX,FORMSPEC,RECOMP,ICD9,SELEX,DELFLD,RESOURC,ACTIVAT,OPTRF
 Q
 ;
ADDNAR ;  -- Sets fields .17 ASK FOR  ADDITIONAL NARRATIVE and
 ;     .18 ASK FOR CLINICAL LEXICON to 1 'YES'.
 N IBDIFN,IBI
 S IBDIFN=$O(^IBE(357.6,"B","DG SELECT ICD-9 DIAGNOSIS CODE",0)) I $G(^IBE(357.6,IBDIFN,0))]"" D
 .S DIE="^IBE(357.6,",DA=IBDIFN F IBI=.17,.18 S DR=IBI_"////^S X=1" D ^DIE
 .K DIE,DA,DR
 Q
 ;
GARBAGE ;  -- Changing the name of the GARBAGE form to WORKCOPY
 N IBDIFN
 I $D(^IBE(357,"B","GARBAGE")) D
 .S IBDIFN=$O(^IBE(357,"B","GARBAGE",0)) I $G(^IBE(357,IBDIFN,0))]"" D
 ..S DIE="^IBE(357,",DA=IBDIFN S DR=".01///WORKCOPY" D ^DIE
 ..K DIE,DA,DR
 ..Q
 Q
SELEX ; -- Correct selector for PX INPUT EXAMS
 N IBDIFN
 S IBDIFN=$O(^IBE(357.6,"B","PX INPUT EXAMS",0))
 Q:$G(^IBE(357.6,IBDIFN,0))=""
 I $G(^IBE(357.6,IBDIFN,17))'="D SLCTEX^IBDFN12(.X)" S ^IBE(357.6,IBDIFN,17)="D SLCTEX^IBDFN12(.X)"
 Q
 ;
SCDATA ; -- changes PI for SC data fields (did not work as originally defined)
 N IBDIFN,VAR,IBDIFN1
 S IBDIFN=$O(^IBE(357.6,"B","PX INPUT VISIT CLASSIFICATION",0)) I $G(^IBE(357.6,IBDIFN,0))]"" D
 .S VAR="S X=$$VARVAL^IBDFN9(Y)"
 .S DIE="^IBE(357.6,",DA=IBDIFN,DR="20////1;21////^S X=VAR"
 .D ^DIE K DIE,DA,DR
 .S IBDIFN1=0 F  S IBDIFN1=$O(^IBE(357.6,IBDIFN,13,IBDIFN1)) Q:'IBDIFN1  D
 ..S DIE="^IBE(357.6,IBDIFN,13,",DA(1)=IBDIFN,DA=IBDIFN1,DR=".03////0;.08////@"
 ..D ^DIE K DIE,DA,DR
 ; -- loop through 357.93 and add ID for each classification
 N IBDIFN1,IBDIFN2,VAL,NODE
 S IBDIFN1=0 F  S IBDIFN1=$O(^IBE(357.93,IBDIFN1)) Q:'IBDIFN1  I $P($G(^IBE(357.93,IBDIFN1,0)),"^",6)=IBDIFN D
 .S IBDIFN2=0 F  S IBDIFN2=$O(^IBE(357.93,IBDIFN1,1,IBDIFN2)) Q:'IBDIFN2  D
 ..S NODE=$G(^IBE(357.93,IBDIFN1,1,IBDIFN2,0)) Q:NODE']""
 ..Q:$P(NODE,"^",8)'=""
 ..S VAL=$P(NODE,"^",5)
 ..S DIE="^IBE(357.93,IBDIFN1,1,",DA(1)=IBDIFN1,DA=IBDIFN2,DR=".08////^S X=VAL"
 ..D ^DIE K DIE,DA,DR
 ..Q
 Q
 ;
AUTOINS ; -- auto install tool kit into production
 N FORM,NEWFORM,FORMNM,CNT,CNT1,ARY,NAME,X,Y,NEWBLOCK,A,EXCLUDE,BLK,CNTF,CNTB
 D MES^XPDUTL(">>> Now Attempting to automatically update Tool Kit forms and Tool Kit Blocks.")
 S (CNTB,CNTF)=0
 ;
 ; -- add all tool kit blocks
 S FORMNM="TOOL KIT"
 I '$O(^IBE(357,"B",FORMNM,0)) G FRM
 S ORD="" F  S ORD=$O(^IBE(358.1,"D",ORD)) Q:ORD=""  S BLK=0 F  S BLK=$O(^IBE(358.1,"D",ORD,BLK)) Q:'BLK  D
 .S NAME=$P($G(^IBE(358.1,+BLK,0)),"^")
 .Q:$P($G(^IBE(358.1,BLK,0)),"^",14)'=1  ;not toolkit
 .Q:$O(^IBE(357.1,"B",NAME,0))  ;already installed
 .D MES^XPDUTL("    Moving Block '"_$P($G(^IBE(358.1,+BLK,0)),"^")_"' from import/export to Tool Kit")
 .N IBTKBLK S IBTKBLK=1
 .S NEWBLOCK=$$COPYBLK^IBDFU2(BLK,$$TKFORM^IBDFU2C,358.1,357.1,"","",$$TKORDER^IBDF13),CNTB=CNTB+1
 .D:$G(NEWBLOCK) DLTBLK^IBDFU3(BLK,"",358.1)
 ;
FRM ; -- Add tool kit forms
 F CNT=1:1 S FORMNM=$P($T(FORMS+CNT),";;",2,99) Q:FORMNM=""  D
 .S FORM=$O(^IBE(358,"B",$E(FORMNM,1,30),0))
 .Q:$O(^IBE(357,"B",$E(FORMNM,1,30),0))
 .D MES^XPDUTL("    Moving Form '"_FORMNM_"' from import export utility to AICS")
 .S NEWFORM=$$COPYFORM^IBDFU2C(FORM,358,357,"",1),CNTF=CNTF+1
 ;
 I CNTF=0,CNTB=0 D MES^XPDUTL(">>> Tool Kit Forms and Blocks are already installed.") Q
 ;D MES^XPDUTL(">>>   Tool Kit Forms sent (4): ") D MES^XPDUTL($J(CNTF,3)) D MES^XPDUTL(" installed")
 D MES^XPDUTL(">>>   Tool Kit Forms sent (4): "_$J(CNTF,3)_" installed")
 D MES^XPDUTL(">>> Tool Kit Blocks sent (28): "_$J(CNTB,3)_" installed")
 ;D MES^XPDUTL(">>> Tool Kit Blocks sent (28): ") D MES^XPDUTL($J(CNTB,3)) D MES^XPDUTL(" installed")
 Q
 ;
 ;
LEX ; -- if clinic lex version two installed, update dd nodes
 I $D(^LEX) D  ; -- maybe add $$ver^xpdutl(lex2_0??)
 .S ^DD(357.3,2.02,0)="CLINICAL LEXICON ENTRY^P757.01'^LEX(757.01,^2;2^Q"
 .S ^DD(358.3,2.02,0)="CLINICAL LEXICON ENTRY^P757.01'^LEX(757.01,^2;2^Q"
 .S ^DD(357.951,2.02,0)="CLINICAL LEXICON^P757.01'^LEX(757.01,^2;2^Q"
 .D MES^XPDUTL(">>> AICS Data Dictionaries updated to use Lexicon Utility version 2.0")
 E  D MES^XPDUTL(">>> AICS Data Dictionaries updated to use Clinical Lexicon Utility version 1.0")
 Q
 ;
FORMSPEC ;Form Specs deleted from the file 359.2  FORM SPEC file.
 D MES^XPDUTL(">>> Form Specs being deleted and recreated for scanning.")
 N IBDIFN
 S IBDIFN=0
 F  S IBDIFN=$O(^IBD(359.2,IBDIFN)) Q:IBDIFN']""  I $D(^IBD(357.95,IBDIFN,0)) D SCAN^IBDFBKS(IBDIFN)
 Q
 ;
RECOMP ; -- recompile all forms
 S IBFORM=0
 F  S IBFORM=$O(^IBE(357,IBFORM)) Q:'IBFORM  D UNCMPALL^IBDF19(IBFORM)
 Q
 ;
ICD9 ; -- make sure ICD9 input interface uses diagnosis/problem node
 N IBDA,IBDX
 S IBDA=0 F  S IBDA=$O(^IBE(357.6,"B","INPUT DIAGNOSIS CODE (ICD9)",IBDA)) Q:'IBDA  D
 .S IBDX=$G(^IBE(357.6,IBDA,0))
 .Q:IBDX=""!($P(IBDX,"^")'="INPUT DIAGNOSIS CODE (ICD9)")
 .Q:$P($G(^IBE(357.6,IBDA,12)),"^")="DIAGNOSIS/PROBLEM"
 .S ^IBE(357.6,IBDA,12)="DIAGNOSIS/PROBLEM^1^13^14^2^^^"
 .D MES^XPDUTL(">>> Updating Package Interface Entry for INPUT DIAGNOSIS CODE (ICD9)")
 ;
SCRN S IBDA=$O(^IBE(357.6,"B","INPUT PROVIDER",0)) Q:'IBDA  D
 .S IBDX=$G(^IBE(357.6,IBDA,0))
 .Q:IBDX=""!($P(IBDX,"^")'="INPUT PROVIDER")
 S ^IBE(357.6,IBDA,18)="S IBDF(""OTHER"")=""200^I $$SCREEN^IBDFDE10(+Y)"" D LIST^IBDFDE2(.IBDSEL,.IBDF,""Provider"")"
 Q
 ;
ACTIVAT ; -- activate two entries in 357.69 that were erroniously inactivated
 I $P($G(^IBE(357.69,99220,0)),"^",4) S $P(^IBE(357.69,99220,0),"^",4)=""
 I $P($G(^IBE(357.69,99232,0)),"^",4) S $P(^IBE(357.69,99232,0),"^",4)=""
 Q
 ;
OPTRF ; -- remove erroneous output transform for PX INPUT PATIENT PROBLEMS
 N IBDFA
 S IBDFA=$O(^IBE(357.6,"B","PX INPUT PATIENT ACTIVE PROBLE",0)) Q:'IBDFA
 I $G(^IBE(357.6,IBDFA,14))="S Y=$$DSPLYICD^IBDFN9(Y)" K ^IBE(357.6,IBDFA,14)
 Q
DELFLD ; -- delete fields *'d for deletion
 Q:'$D(^DD(357.6,2.14))  ;already removed
 S DIK="^DD(357.6,",DA(1)=357.6
 F DA=8.01,8.02,8.03,8.04,8.05,8.06,8.07,2.03,2.04,2.05,2.06,2.07,2.08,2.09,2.1,2.11,2.12,2.13,2.14 D ^DIK
 K DIK,DA
 D MES^XPDUTL(">>> Deleting Fields *'d for Deletion in Package Interface file (357.6)")
 Q
 ;
RESOURC ; -- add scanning resource device
 I $D(^%ZIS(1,"B","IBD RESOURCE")) Q
 D MES^XPDUTL(">>> Adding Resouce Device 'IBD RESOURCE' for scanning.")
 S DIC="^%ZIS(1,",DIC(0)="L",DLAYGO=3.5,X="IBD RESOURCE" D FILE^DICN
 S DA=+Y Q:DA<1
 S DR="1////IBD RESOURCE;.02////NA;2///RESOURCE"
 S DIE=DIC D ^DIE K DIC,DIE,DR,DA
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
 Q
