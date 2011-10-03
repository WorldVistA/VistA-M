GMTSLRME ; SLC/JER,KER - Microbiology Extract Routine ; 08/27/2002
 ;;2.7;Health Summary;**25,28,37,56**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA    67  ^LAB(60
 ;   DBIA   525  ^LR(
 ;   DBIA   531  ^LRO(68
 ;   DBIA 10006  ^DIC
 ;   DBIA 10007  MIX^DIC1
 ;   DBIA  2056  $$GET1^DIQ
 ;   DBIA 10015  EN^DIQ1
 ;                    
XTRCT ; Extract
 N ACC,CDT,SS,CS,X,DIC,DIQ,DA,DR,MICRO,LOC,RDT,MICCOM K ^TMP("LRM",$J)
 S X=$P(^LR(LRDFN,"MI",IX,0),U),RDT=$P(^(0),U,3),ACC=$P(^(0),U,6),LOC=$P(^(0),U,8) D REGDTM4^GMTSU S CDT=X K X
 D LABTEST($P(^LR(LRDFN,"MI",IX,0),U),ACC)
 ;   Get External format of site/specimen
 ;   collection sample, and comment
 S DIC=63,DIQ="MICRO",DIQ(0)="E",DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)=".05;.055;.99"
 D EN^DIQ1
 S SS=MICRO(63.05,IX,.05,"E")
 S CS=MICRO(63.05,IX,.055,"E"),MICCOM=MICRO(63.05,IX,.99,"E")
 S ^TMP("LRM",$J,0)=CDT_U_ACC_U_SS I $D(EXPAND) S ^TMP("LRM",$J,0)=^TMP("LRM",$J,0)_U_RDT_U_LOC
 S $P(^TMP("LRM",$J,0),U,6)=CS_U_MICCOM
 D ABXLEV,BACT,GRAM,STER,PARA^GMTSLRMX,MYCO^GMTSLRMX,TB^GMTSLRMX,VIRO^GMTSLRMX
 Q
BACT ; Get Bacteriology Work-up
 N DA,DIC,DIQ,DR,STATUS,ISO,ORG,RMK,COM,SMEAR
 ;   Work up
 I $D(^LR(LRDFN,"MI",IX,1)) D
 . S DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)="11.5;11.51;11.57;11.58",DIQ="STATUS"
 . S DIQ(0)="E" D EN^DIQ1
 . ;     Include Status, sputum screen, and urine screen
 . S ^TMP("LRM",$J,"BACT",0)=$E($P(STATUS(63.05,IX,11.5,"E")," ",1),1,6)_U_STATUS(63.05,IX,11.58,"E")_U_STATUS(63.05,IX,11.57,"E")
 . ;     Include sterility control
 . S ^TMP("LRM",$J,"BSTER",0)=STATUS(63.05,IX,11.51,"E")
 S ISO=0 F  S ISO=$O(^LR(LRDFN,"MI",IX,3,ISO)) Q:+ISO'>0  D
 . D ORGNSM S ^TMP("LRM",$J,"BACT",ISO)=$S($D(EXPAND):ISO_";"_ORG,1:ORG)
 . I $O(^LR(LRDFN,"MI",IX,3,ISO,1)) D ANTIBX
 . ;     Get Comment
 . S COM=0
 . F  S COM=$O(^LR(LRDFN,"MI",IX,3,ISO,1,COM)) Q:COM'>0  S ^TMP("LRM",$J,"BACT",ISO,"COM",COM)=^(COM,0)
 ;   Bacteriology smear/prep
 S SMEAR=0
 F  S SMEAR=$O(^LR(LRDFN,"MI",IX,25,SMEAR)) Q:SMEAR'>0  S ^TMP("LRM",$J,"BACT","SMEAR",SMEAR)=^(SMEAR,0)
 ;     Get Remark
 S RMK=0
 F  S RMK=$O(^LR(LRDFN,"MI",IX,4,RMK)) Q:RMK=""  S ^TMP("LRM",$J,"BACT","R",RMK)=^(RMK,0)
 Q
ORGNSM ; Get Organism
 N QTY
 S ORG=+^LR(LRDFN,"MI",IX,3,ISO,0),QTY=$P(^(0),U,2)
 S ORG=$$GET1^DIQ(61.2,ORG,.01,"I")
 S ORG=ORG_U_QTY
 Q
ANTIBX ; Get Antibitiotic susceptibility results on demand
 N ABX S ABX=1
 F  S ABX=$O(^LR(LRDFN,"MI",IX,3,ISO,ABX)) Q:ABX=""!(ABX'<3)  D ABXSET
 Q
ABXSET ; Antibiotic Susceptability Data
 ;   Separate out by Susceptable, Intermediate, and Resistant
 N FOUND,GMTSR,GMABX,ABXI,ABXNM,ABXN
 S ABXI=$$ABXI(ABX),ABXNM=$$ABXNM(ABXI),ABXN=ABX_";"_ABXNM
 I $P(ABXN,";",2)']"" S $P(ABXN,";",2)="UNKNOWN"
 I ("A"[$P(^LR(LRDFN,"MI",IX,3,ISO,ABX),U,3)) D
 . S GMABX=$G(^LR(LRDFN,"MI",IX,3,ISO,ABX))
 . ;     Check for interpreted result (S, I, or R) first
 . S FOUND=0
 . S GMTSR=$P(GMABX,U,2) D SAVE Q:FOUND
 . ;     If not found then check reported result (S,I, or R)
 . S GMTSR=$P(GMABX,U) D SAVE Q:FOUND
 . ;     Neither interpreted nor reported result equaled
 . ;     S, I, or R so we'll store it in the "other" list
 . ;     provided that reported and interpreted are both
 . ;     not null
 . S:$P(GMABX,U)'=""&($P(GMABX,U,2)'="") ^TMP("LRM",$J,"BACT",ISO,"SUSC","O",$P($P(ABXN,U),";",2))=ABXN_U_GMABX
 Q
ABXI(X) ; Antibiotic Susceptability IEN
 S X=$G(X) Q:'$L(X) 0 N DIC,DTOUT,DUOUT,Y S DIC="^LAB(62.06,",D="AD",DIC(0)="" D MIX^DIC1 S X=+($G(Y)) S:X'>0 X=0 Q X
ABXNM(X) ; Antibiotic Susceptability Name
 S X=$G(X) Q:+X'>0 "" S X=$$GET1^DIQ(62.06,+X,.01) Q X
ABXLEV ; Get Serum antibiotic level
 Q:'$D(^LR(LRDFN,"MI",IX,14))  N GMI S GMI=0
 F  S GMI=$O(^LR(LRDFN,"MI",IX,14,GMI)) Q:GMI'>0  S ^TMP("LRM",$J,"CABXL",GMI)=$G(^(GMI,0))
 Q
STER ; Get sterility results if they exist
 N RESULT,STER S STER=0
 F  S STER=$O(^LR(LRDFN,"MI",IX,31,STER)) Q:STER'>0  D
 . S DIQ(0)="E",DIC=63,DA=LRDFN,DA(63.05)=IX,DR=5,DR(63.05)=11.52
 . S DR(63.292)=.01,DIQ="RESULT"
 . S DA(63.292)=STER
 . D EN^DIQ1
 . S ^TMP("LRM",$J,"BSTER",STER)=RESULT(63.292,STER,.01,"E")
 Q
GRAM ; Get Gram Stain Results
 N ISO Q:'$D(^LR(LRDFN,"MI",IX,2))  S ISO=0
 F  S ISO=$O(^LR(LRDFN,"MI",IX,2,ISO)) Q:ISO=""  S ^TMP("LRM",$J,"GRAM",ISO)=^(ISO,0)
 Q
LABTEST(SDT,LRACC) ; Get lab test names and results
 N X,Y,LRAA,LRAN,LRAD,LRBRR,LRTSTS,LRTS
 S LRAD=+$E(SDT)_$P(LRACC," ",2)_"0000",X=$P(LRACC," "),DIC=68,DIC(0)="M"
 Q:'$L(X)  D ^DIC S LRAA=+Y,LRAN=+$P(LRACC," ",3)
 S LRBRR=0
 F  S LRBRR=+$O(^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRBRR)) Q:LRBRR'>0  D
 . S LRTS=+^LRO(68,LRAA,1,LRAD,1,LRAN,4,LRBRR,0),LRTS(1)=$P(^(0),U,5)
 . Q:"BO"'[$P($G(^LAB(60,LRTS,0)),U,3)
 . S LRTSTS=$S($D(^LAB(60,LRTS,0)):$P(^(0),U),1:"deleted test")
 . ;   Lab test name and results in print order
 . S ^TMP("LRM",$J,0,"TEST",$S($D(^LAB(60,LRTS,.1)):$P(^(.1),U,6),1:"")_","_U_LRBRR)=LRTSTS_U_LRTS(1)
 Q
SAVE ; If result = S, I, or R then save
 I $S(GMTSR="I":1,GMTSR="R":1,GMTSR="S":1,1:0) S ^TMP("LRM",$J,"BACT",ISO,"SUSC",GMTSR,$P($P(ABXN,U),";",2))=ABXN_U_GMABX S FOUND=1
 Q
