IBDY338 ;ALB/DHH - POST INSTALL FOR PATCH IBD*3*38 ; OCT 1, 1999
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38**;APR 24, 1997
 ;
 D ASK,ASK1
 ;
 ;-- Add CPT Modifier Tool Kit Blocks to Tool Kit
 D AUTOINS
 Q
 ;
ASK ;-- Set ASK CPT MODIFIERS to yes for DG SELECT CPT PROCEDURE CODES
 ;   in the package interface file
 ;
 D MES^XPDUTL(">>> Updating DG SELECT CPT PROCEDURE CODES Package Interface.")
 N I,J,X
 S I=0
 F  S I=$O(^IBE(357.6,"B",$E("DG SELECT CPT PROCEDURE CODES",1,30),I)) Q:'I  D
 .I $P($G(^IBE(357.6,I,0)),"^")="DG SELECT CPT PROCEDURE CODES" S $P(^IBE(357.6,I,0),"^",21)=1
 Q
 ;
ASK1 ;-- Set ASK CPT MODIFIERS to yes for DG SELECT VISIT TYPE PROCEDURES
 ;   in the package interface file
 ;
 D MES^XPDUTL(">>> Updating DG SELECT VISIT TYPE CPT PROCEDURES Package Interface.")
 N I,J,X
 S I=0
 F  S I=$O(^IBE(357.6,"B",$E("DG SELECT VISIT TYPE CPT PROCEDURES",1,30),I)) Q:'I  D
 .I $P($G(^IBE(357.6,I,0)),"^")="DG SELECT VISIT TYPE CPT PROCEDURES" S $P(^IBE(357.6,I,0),"^",21)=1
 Q
 ;
AUTOINS ;-- Auto install CPT Modifier tool kit blocks into AICS Tool Kit
 N FORM,NEWFORM,FORMNM,CNT,CNT1,ARY,NAME,X,Y,NEWBLOCK,A,EXCLUDE,BLK,CNTF,CNTB
 D MES^XPDUTL(">>> Adding CPT Modifier Tool Kit Blocks to AICS Tool Kit.")
 S (CNTB,CNTF)=0
 ;
 ;-- Add all tool kit blocks
 S FORMNM="TOOL KIT"
 I '$O(^IBE(357,"B",FORMNM,0)) Q
 S ORD="" F  S ORD=$O(^IBE(358.1,"D",ORD)) Q:ORD=""  S BLK=0 F  S BLK=$O(^IBE(358.1,"D",ORD,BLK)) Q:'BLK  D
 .S NAME=$P($G(^IBE(358.1,+BLK,0)),"^")
 .Q:$P($G(^IBE(358.1,BLK,0)),"^",14)'=1  ;not toolkit
 .I $O(^IBE(357.1,"B",NAME,0)) D MES^XPDUTL("     Block "_NAME_" already exists") Q
 .D MES^XPDUTL("    Moving block '"_$P($G(^IBE(358.1,+BLK,0)),"^")_"' from Import/Export files to Tool Kit")
 .N IBTKBLK S IBTKBLK=1
 .S NEWBLOCK=$$COPYBLK^IBDFU2(BLK,$$TKFORM^IBDFU2C,358.1,357.1,"","",$$TKORDER^IBDF13),CNTB=CNTB+1
 .D:$G(NEWBLOCK) DLTBLK^IBDFU3(BLK,"",358.1)
 ;
 ;-- Clear workspace
 D DLTALL^IBDE2
 Q
PREINIT ; Pre-Init for Patch 38
 ; clearing workspace - imp/exp
 D MES^XPDUTL(">>> Clearing Import/Export Workspace Now...")
 D DLTALL^IBDE2
 Q
