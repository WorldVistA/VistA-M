GMTSLRMX ;SLC/JER,KER - Extended Microbiology Extract; Aug 02, 2022@08:31:08
 ;;2.7;Health Summary;**49,138**;Oct 20, 1995;Build 4
 ;                    
 ; External References
 ; Reference to %XY^%RCR in ICR #10022
 ; Reference to ^LAB(61.2 in ICR #526
 ; Reference to ^LR( in ICR #63
 ; Reference to $$GET1^DID in ICR #2056
 ; Reference to EN^DIQ1 in ICR #10015
 ;                    
PARA ; Get Parasitology Work-up
 ;Do not display if results not verified (GMTS*2.7*138)
 I $P($G(^LR(LRDFN,"MI",IX,5)),U)="" D  Q
 . ;Were results previously verified and are now in the process
 . ;of being amended?
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,IX,5))
 . S ^TMP("LRM",$J,"PARA",0)="Results currently being edited by tech code "_$G(^XTMP("LRMICRO EDIT",LRDFN,IX,5))
 N DA,DIC,DIQ,DR,STATUS,PN,SN,RMK,SMEAR,COM
 I $D(^LR(LRDFN,"MI",IX,5)) D
 . S DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)=15,DIQ="STATUS"
 . S DIQ(0)="E" D EN^DIQ1
 . S ^TMP("LRM",$J,"PARA",0)=$E($P(STATUS(63.05,IX,15,"E")," ",1),1,6)
 S PN=0
 F  S PN=$O(^LR(LRDFN,"MI",IX,6,PN)) Q:+PN'>0  D
 . S SN=0
 . D IDPARA
 . F  S SN=$O(^LR(LRDFN,"MI",IX,6,PN,1,SN)) Q:+SN'>0  D IDPARA
 ;   Parasitology smear/prep
 S SMEAR=0
 F  S SMEAR=$O(^LR(LRDFN,"MI",IX,24,SMEAR)) Q:SMEAR'>0  S ^TMP("LRM",$J,"PARA","SMEAR",SMEAR)=^(SMEAR,0)
 ;   Remark
 S RMK=0
 F  S RMK=$O(^LR(LRDFN,"MI",IX,7,RMK)) Q:+RMK'>0  S ^TMP("LRM",$J,"PARA","R",RMK)=^(RMK,0)
 Q
IDPARA ; Get parasite stage, quantity, and comment
 N DA,DIC,DIQ,DR,PARA,STAGE
 I 'SN S PARA=+^LR(LRDFN,"MI",IX,6,PN,0),PARA=$S($D(EXPAND):PN_";"_$P(^LAB(61.2,PARA,0),U),1:$P(^LAB(61.2,PARA,0),U)),^TMP("LRM",$J,"PARA",PN)=PARA Q
 S DA=LRDFN,DA(63.05)=IX,DA(63.34)=PN,DA(63.35)=SN,DIC=63,DIQ="STAGE",DIQ(0)="E",DR=5,DR(63.05)=16,DR(63.34)=1,DR(63.35)=".01;1" D EN^DIQ1
 S ^TMP("LRM",$J,"PARA",PN,SN)=STAGE(63.35,SN,.01,"E")_U_STAGE(63.35,SN,1,"E")
 ;   Comment
 S COM=0
 F  S COM=$O(^LR(LRDFN,"MI",IX,6,PN,1,SN,1,COM)) Q:COM'>0  S ^TMP("LRM",$J,"PARA",PN,SN,"COM",COM)=^(COM,0)
 Q
MYCO ; Get Mycology Work-up
 ;Do not display if results not verified (GMTS*2.7*138)
 I $P($G(^LR(LRDFN,"MI",IX,8)),U)="" D  Q
  . ;Were results previously verified and are now in the process
 . ;of being amended?
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,IX,8))
 . S ^TMP("LRM",$J,"MYCO",0)="Results currently being edited by tech code "_$G(^XTMP("LRMICRO EDIT",LRDFN,IX,8))
 N DA,DIC,DIQ,DR,DA,STATUS,GMW,ISO,FUN,RMK,COM,SMEAR
 ;   Work-up
 I $D(^LR(LRDFN,"MI",IX,8)) D
 . S DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)=19,DIQ="STATUS"
 . S DIQ(0)="E" D EN^DIQ1
 . S ^TMP("LRM",$J,"MYCO",0)=$E($P(STATUS(63.05,IX,19,"E")," ",1),1,6)
 S ISO=0
 F  S ISO=$O(^LR(LRDFN,"MI",IX,9,ISO)) Q:+ISO'>0  D
 . D FNGS S ^TMP("LRM",$J,"MYCO",ISO)=$S($D(EXPAND):ISO_";"_FUN,1:FUN)
 . ;   Comment
 . S COM=0
 . F  S COM=$O(^LR(LRDFN,"MI",IX,9,ISO,1,COM)) Q:COM'>0  S ^TMP("LRM",$J,"MYCO",ISO,"COM",COM)=^(COM,0)
 ;   Mycology smear/prep
 S SMEAR=0
 F  S SMEAR=$O(^LR(LRDFN,"MI",IX,15,SMEAR)) Q:SMEAR'>0  S ^TMP("LRM",$J,"MYCO","SMEAR",SMEAR)=^(SMEAR,0)
 ;   Remark
 S RMK=0
 F  S RMK=$O(^LR(LRDFN,"MI",IX,10,RMK)) Q:+RMK'>0  S ^TMP("LRM",$J,"MYCO","R",RMK)=^(RMK,0)
 Q
FNGS ; Fungus/Yeast
 N QTY S FUN=+^LR(LRDFN,"MI",IX,9,ISO,0),QTY=$P(^(0),U,2)
 S FUN=$P(^LAB(61.2,FUN,0),U),FUN=FUN_U_QTY
 Q
TB ; Gets Mycobacteriology Work-up
 ;Do not display if results not verified (GMTS*2.7*138)
 I $P($G(^LR(LRDFN,"MI",IX,11)),U)="" D  Q
 . ;Were results previously verified and are now in the process
 . ;of being amended?
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,IX,11))
 . S ^TMP("LRM",$J,"TB",0)="Results currently being edited by tech code "_$G(^XTMP("LRMICRO EDIT",LRDFN,IX,11))
 N DA,DIC,DIQ,DR,STATUS,GMW,ISO,MB,RMK,X,%X,Y,%Y,COM,MY,GMTB,GMTBA,GMTBF,GMTBL
 I $D(^LR(LRDFN,"MI",IX,11)) D
 . S DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)="23;24;25",DIQ="STATUS"
 . S DIQ(0)="E" D EN^DIQ1
 . ;   Status, Acid Fast Stain, Quantity
 . S ^TMP("LRM",$J,"TB",0)=$E($P(STATUS(63.05,IX,23,"E")," ",1),1,6)_U_STATUS(63.05,IX,24,"E")_U_STATUS(63.05,IX,25,"E")
 S ISO=0
 F  S ISO=$O(^LR(LRDFN,"MI",IX,12,ISO)) Q:+ISO'>0  D
 . D MYCB S ^TMP("LRM",$J,"TB",ISO)=$S($D(EXPAND):ISO_";"_MB,1:MB)
 . ;   Comment
 . S COM=0
 . F  S COM=$O(^LR(LRDFN,"MI",IX,12,ISO,1,COM)) Q:COM'>0  S ^TMP("LRM",$J,"TB",ISO,"COM",COM)=^(COM,0)
 . ;   Susceptiblities
 . S GMTB=2
 . F  S GMTB=$O(^LR(LRDFN,"MI",IX,12,ISO,GMTB)) Q:GMTB'["2."!(GMTB="")  D
 . . K GMTBL S %X="^DD(63.39,""GL"","_+($G(GMTB))_",1",%Y="GMTBL(" D %XY^%RCR
 . . S GMTBF=+($O(GMTBL(1,0))),GMTBA=$$GET1^DID(63.39,GMTBF,"","LABEL")
 . . S ^TMP("LRM",$J,"TB",ISO,"SUSC",GMTB)=GMTBA_U_$P(^LR(LRDFN,"MI",IX,12,ISO,GMTB),U)
 ;   Remark
 S RMK=0
 F  S RMK=$O(^LR(LRDFN,"MI",IX,13,RMK)) Q:RMK=""  S ^TMP("LRM",$J,"TB","R",RMK)=^(RMK,0)
 Q
MYCB ; Mycobacterium
 N QTY S MB=+^LR(LRDFN,"MI",IX,12,ISO,0),QTY=$P(^(0),U,2)
 S MB=$P(^LAB(61.2,MB,0),U),MB=MB_U_QTY
 Q
VIRO ; Gets Virology Work-up
 ;Do not display if results not verified (GMTS*2.7*138)
 I $P($G(^LR(LRDFN,"MI",IX,16)),U)="" D  Q
  . ;Were results previously verified and are now in the process
 . ;of being amended?
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,IX,16))
 . S ^TMP("LRM",$J,"VIRO",0)="Results currently being edited by tech code "_$G(^XTMP("LRMICRO EDIT",LRDFN,IX,16))
 N BUG,DA,DIC,DIQ,DR,GMW,ISO,RMK,STATUS
 I $D(^LR(LRDFN,"MI",IX,16)) D
 . S DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)=34,DIQ="STATUS"
 . S DIQ(0)="E" D EN^DIQ1
 . S ^TMP("LRM",$J,"VIRO",0)=$E($P(STATUS(63.05,IX,34,"E")," ",1),1,6)
 S ISO=0
 F  S ISO=$O(^LR(LRDFN,"MI",IX,17,ISO)) Q:+ISO'>0  D
 . D PHAGE S ^TMP("LRM",$J,"VIRO",ISO)=$S($D(EXPAND):ISO_";"_BUG,1:BUG)
 S RMK=0
 F  S RMK=$O(^LR(LRDFN,"MI",IX,18,RMK)) Q:RMK=""  S ^TMP("LRM",$J,"VIRO","R",RMK)=^(RMK,0)
 Q
PHAGE ; Virus
 S BUG=+^LR(LRDFN,"MI",IX,17,ISO,0),BUG=$P(^LAB(61.2,BUG,0),U)
 Q
