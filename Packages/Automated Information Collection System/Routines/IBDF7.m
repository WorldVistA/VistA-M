IBDF7 ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(ADDING TOOLKIT BLKS) ;01/08/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**63**;APR 24, 1997;Build 80
 ;
 ;
ADD ;create a new block by copying a toolkit block
 N BLKLIST,OLDBLOCK,NEWBLOCK,TOP,BOT,IBBG,IBLFT,IBDLST,IBDCS,IBDX,IBDY
 S VALMBCK="R",IBBG=+$G(VALMBG),OLDBLOCK="",IBLFT=+$G(VALMLFT)
 D EN^VALM("IBDF TOOL KIT BLOCK LIST") ;list processor displays list of tool kit blocks
 I '$G(IBFASTXT) D
 .S VALMBG=IBBG S:VALMBG<1 VALMBG=1
 .Q:OLDBLOCK=""  ;selected tool kit block stored in OLDBLOCK
 .S NEWBLOCK=$$COPYBLK^IBDFU2(OLDBLOCK,IBFORM,357.1,357.1,IBBG-1,IBLFT-5,0,"",1)
 .D RE^VALM4,POS^IBDFU4(NEWBLOCK)
 .S VALMBCK="R"
 .D TOPNBOT^IBDFU5(NEWBLOCK,.TOP,.BOT)
 .D IDXFORM^IBDF5A(TOP,BOT)
 .;Now check if new block contains any selection lists that specify ICD-9 or ICD-10
 .;if so, update history field at #357 .19 or .2 plus field .21
 .S IBDLST=0 F  S IBDLST=$O(^IBE(357.2,"C",NEWBLOCK,IBDLST)) Q:IBDLST=""  S IBDX=$P(^IBE(357.2,IBDLST,0),U,11) D:IBDX?1.N
 ..S IBDCS=$P(^IBE(357.6,IBDX,0),U,22) D:IBDCS=1!(IBDCS=30)  ;Coding System 1=ICD-9 30=ICD-10
 ...I '$O(^IBE(357.3,"C",IBDLST,"")) Q  ;Only log history fields if ICD-9 or ICD-10 codes are contained in block.
 ...S IBDY=$$CSUPD357^IBDUTICD(IBFORM,IBDCS,"",$$NOW^XLFDT(),DUZ)
 Q
 ;
INIT ;entry code to list
 S BLKLIST="^TMP(""IBDF"",$J,""TOOL KIT BLOCK LIST"")"
 D IDXBLKS
 Q
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !
 Q
 ;
EXIT ; -- exit code
 K @BLKLIST
 Q
 ;
IDXBLKS ; sets up list of toolkit blocks for list processor
 N BLOCK,TK
 K @BLKLIST
 S VALMCNT=0
 S TK=0,BLOCK="" F  S TK=$O(^IBE(357.1,"D",TK)) Q:'TK  F  S BLOCK=$O(^IBE(357.1,"D",TK,BLOCK)) Q:'BLOCK  D
 .Q:'$P($G(^IBE(357.1,BLOCK,0)),"^",14)
 .S VALMCNT=VALMCNT+1
 .S @BLKLIST@(VALMCNT,0)=$$DISPLAY(BLOCK,VALMCNT,TK),@BLKLIST@("IDX",VALMCNT,VALMCNT)=BLOCK
 .D FLDCTRL^VALM10(VALMCNT,"ID") ;set video for ID column
 Q
 ;
DISPLAY(BLOCK,ID,TKORDER) ;adds one toolkit block to the list array
 N NODE,NAME,DESCR,RET
 ;** note: IBTKBLK=1 only if editing the tool kit blocks - display the tool kit order in that case
 S RET=$J(ID,3)_$$PADRIGHT^IBDFU("",2)
 S NODE=$G(^IBE(357.1,BLOCK,0))
 S NAME=$P(NODE,"^",1),DESCR=$P(NODE,"^",13)
 S RET=RET_$$PADRIGHT^IBDFU(NAME,30)_" "
 I $G(IBTKBLK) S RET=RET_$E($J(TKORDER,4),1,4)_"  "
 S RET=RET_$E(DESCR,1,80)
 Q RET
SELECT ;
 N CHOICE
 D EN^VALM2($G(XQORNOD(0)),"S")
 S CHOICE=$O(VALMY("")) Q:'CHOICE  S OLDBLOCK=$G(@VALMAR@("IDX",CHOICE,CHOICE))
 Q
