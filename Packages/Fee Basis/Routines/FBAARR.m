FBAARR ;AISC/GRR - REINITIATE REJECTED LINE ITEMS ; 4/6/2012
 ;;3.5;FEE BASIS;**61,114,132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 N FBILM
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
 S Q="",$P(Q,"=",80)="=",UL="",$P(UL,"-",80)="-",(FBAAOUT,CNT,FBINTOT)=0
 D DT^DICRW
BT K QQ W !!
 S DIC="^FBAA(161.7,",DIC(0)="AEQMN",DIC("A")="Select Batch with Rejects: ",DIC("S")="I $G(^(""ST""))=""V""&($P(^(0),U,17)]"""")" D ^DIC K DIC("S"),DIC("A") G Q:X="^"!(X=""),BT:Y<0
 L +^FBAA(161.7,+Y):$G(DILOCKTM,3)
 I '$T W !,"Another user is editing this batch.  Try again later." G BT
 S FBN=+Y,B=FBN,FZ=^FBAA(161.7,FBN,0),FBTYPE=$P(FZ,"^",3)
 S FBOB=$P(FZ,"^",2),FBEXMPT=$S($P(FZ,"^",18)]"":$P(FZ,"^",18),1:"N")
 I '$S(FBTYPE="B3":$D(^FBAAC("AH",B)),FBTYPE="B2":$D(^FBAAC("AG",B)),FBTYPE="B5":$D(^FBAA(162.1,"AF",B)),FBTYPE="B9":$D(^FBAAI("AH",B)),1:0) W !!,*7,"No items rejected in this batch!" D  D UNLK G BT
 .S $P(^FBAA(161.7,B,0),U,17)=""
 ;
 I "^P^E^"[(U_$$GET1^DIQ(161.7,FBN_",",22,"I")_U) D  D UNLK G BT
 . W !,"This batch cannot be re-initiated yet.  The Voucher Batch"
 . W !,"Message must first be successfully acknowledged by Central Fee."
 ;
 I FBTYPE="B9",$P(FZ,"^",15)="Y" D NEWBT^FBAARR0 G ASKLL
BTN W !! S DIC("A")="Select New Batch number: ",DIC("S")="I $P(^(0),U,3)=FBTYPE&($P(^(0),U,5)=DUZ)&($G(^(""ST""))=""O"")" D ^DIC K DIC("A"),DIC("S") G Q:X=""!(X="^"),HELP^FBAARR0:X["?",BTN:Y<0 S FBNB=+Y
 D BATCNT^FBAARR1 I '$D(FBNB) D UNLK G BT
 S FBNUM=$P(^FBAA(161.7,B,0),"^",1),FBVD=$P(^(0),"^",12),FBVDUZ=$P(^(0),"^",16),FBNOB=$P(^FBAA(161.7,FBNB,0),"^",2) G:FBNOB'=FBOB CHKOB^FBAARR0
ASKLL S B=FBN,FBNNP=1 S DIR(0)="Y",DIR("A")="Want line items listed",DIR("B")="NO" D ^DIR K DIR W:Y @IOF D:Y MORE^FBAARJP:FBTYPE="B3",PMORE^FBAARJP:FBTYPE="B5",TMORE^FBAARJP:FBTYPE="B2",CMORE^FBAARJP:FBTYPE="B9" K FBNNP
RD0 S DIR(0)="Y",DIR("A")="Want to re-initiate all rejected items in the Batch",DIR("B")="NO",DIR("?")="'Yes' will re-initiate all rejected payment items for this batch, 'No' will prompt for re-initiation of specific line items"
 D ^DIR K DIR G:Y ^FBAARR1
RD1 S DIR(0)="Y",DIR("A")="Want to re-initiate any line items",DIR("B")="NO" D ^DIR K DIR Q:$D(DIRUT)!'Y  D DELT^FBAARR2:FBTYPE="B2",DELM:FBTYPE="B3",DELP^FBAARR2:FBTYPE="B5",DELC^FBAARR0:FBTYPE="B9"
RDD ;
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 D UNLK
 G BT
Q ; clean up
 D UNLK
 D KILL^FBAARR1
 Q
UNLK ; unlock batch
 I $G(FBN) L -^FBAA(161.7,FBN)
 Q
DELM ; specify line items to re-initiate for batch type B3
 ; select patient
 S J=$$ASKVET^FBAAUTL1("I $D(^FBAAC(""AH"",B,+Y))")
 Q:'J
 K QQ
 S QQ=0 W @IOF D HED^FBAACCB
 F K=0:0 S K=$O(^FBAAC("AH",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AH",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AH",B,J,K,L,M)) Q:M'>0  D WRITM
RL S ERR=0 S DIR(0)="N^1:"_QQ,DIR("A")="Re-initiate which line item" D ^DIR K DIR G:$D(DIRUT) END S HX=X
 I '$D(QQ(HX)) W !,*7,"You already did that one!!" G RL
ASKSU S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate line item number "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RL
 S J=$P(QQ(HX),"^",1),K=$P(QQ(HX),"^",2),L=$P(QQ(HX),"^",3),M=$P(QQ(HX),"^",4)
 K FBERR
 D REJM^FBAARR1
ASKRI S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Item Re-initiated.  ")_"Want to re-initiate another",DIR("B")="YES" D ^DIR K DIR G ASKRI:$D(DIRUT),DELM:Y,END
WRITM S QQ=QQ+1,QQ(QQ)=J_"^"_K_"^"_L_"^"_M D SET^FBAACCB Q
END ;
 ; Assign new invoice number to moved lines if invoice was split
 I $$CKSPLIT(B,.FBILM) S DIR(0)="E" D ^DIR K DIR
 Q
CKSPLIT(B,FBILM) ; Check for/Update split invoice
 ; Input
 ;   B      - ien of original batch before item moved
 ;   FBILM( - array of invoice lines that were moved to a new batch
 ;     passed by reference
 ;     format FBILM(invoice number,iens)=""
 ;     where
 ;       invoice number = invoice number
 ;       iens           = iens of subfile 162.03 (a line item)
 ; Result (0 or 1)
 ;   =0 if no lines were assigned a new invoice number
 ;   =1 if some lines assigned a new invoice number
 ;   May change invoice number of line items in subfile 162.03
 ;   and inform user
 N FBAAIN,FBFDA,FBIENS,FBIN,FBINL,FBJ,FBK,FBL,FBM,FBRET,FBSPLT
 S FBRET=0
 ; loop thru invoice numbers in input array
 S FBIN="" F  S FBIN=$O(FBILM(FBIN)) Q:FBIN=""  D
 . S FBSPLT=0 ; initialize split flag to false
 . ; check if any unrejected invoice lines still in original batch
 . I $D(^FBAAC("AJ",B,FBIN)) S FBSPLT=1
 . ; check if any rejected invoice lines still in original batch
 . I 'FBSPLT S FBJ=0 F  S FBJ=$O(^FBAAC("AH",B,FBJ)) Q:'FBJ  D  Q:FBSPLT
 . . S FBK=0
 . . F  S FBK=$O(^FBAAC("AH",B,FBJ,FBK)) Q:'FBK  D  Q:FBSPLT
 . . . S FBL=0
 . . . F  S FBL=$O(^FBAAC("AH",B,FBJ,FBK,FBL)) Q:'FBL  D  Q:FBSPLT
 . . . . S FBM=0
 . . . . F  S FBM=$O(^FBAAC("AH",B,FBJ,FBK,FBL,FBM)) Q:'FBM  D  Q:FBSPLT
 . . . . . S FBINL=$P($G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,0)),U,16)
 . . . . . I FBINL=FBIN S FBSPLT=1
 . Q:FBSPLT=0  ; invoice was not split
 . S FBRET=1
 . ; assign new invoice number to lines moved to the new batch
 . ; get a new invoice number (FBAAIN)
 . D GETNXI^FBAAUTL
 . ; loop thru the moved line items and assign the new invoice number
 . K FBFDA
 . S FBIENS="" F  S FBIENS=$O(FBILM(FBIN,FBIENS)) Q:FBIENS=""  D
 . . S FBFDA(162.03,FBIENS,14)=FBAAIN
 . W !!,"FYI: Invoice ",FBIN," was split since entire invoice did not move to the new batch."
 . W !,"Re-initiated lines are being assigned a new invoice number of ",FBAAIN,"."
 . ; update the file
 . I $D(FBFDA) D FILE^DIE("","FBFDA"),MSG^DIALOG()
 Q FBRET
 ;
 ;FBAARR
