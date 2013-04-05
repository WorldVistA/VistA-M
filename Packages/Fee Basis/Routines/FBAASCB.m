FBAASCB ;AISC/GRR - SUPERVISOR RELEASE ;4/4/2012
 ;;3.5;FEE BASIS;**38,61,116,117,132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S FBERR=0 D DT^DICRW
 I '$D(^FBAA(161.7,"AC","C"))&('$D(^FBAA(161.7,"AC","A"))) W !!,*7,"There are no batches Pending Release!" Q
BT W !! S DIC="^FBAA(161.7,",DIC(0)="AEQ",DIC("S")="I ($G(^(""ST""))=""C""!($G(^(""ST""))=""A""))&('$G(^XTMP(""FBAASCB"",+Y)))" D ^DIC K DIC("S") G Q:X="^"!(X=""),BT:Y<0 S FBN=+Y,^XTMP("FBAASCB",FBN)=1
 D LOCK^FBUCUTL("^FBAA(161.7,",FBN) I 'FBLOCK W !!,*7,"Try releasing batch at another time." D Q G FBAASCB
 S FZ=^FBAA(161.7,FBN,0),FBTYPE=$P(FZ,"^",3),FBAAON=$P(FZ,"^",2),FBAAB=$P(FZ,"^")
 I $G(FBTYPE)="B9",$P(FZ,"^",15)="Y",$P(^FBAA(161.7,FBN,"ST"),"^")="C",$P(FZ,"^",18)'="Y" W !!,*7,"Batch needs to be released to Pricer first.",! G Q
 I $G(FBTYPE)="B9",$P(FZ,"^",15)="" S FBCNH=1
 S FBSTAT=^FBAA(161.7,FBN,"ST"),FBSTAT=$S(FBSTAT="C":"S",FBSTAT="A":"R",1:FBSTAT)
 S FBAAOB=$P(FZ,"^",8)_"-"_FBAAON,FBAAMT=$P(FZ,"^",9),FBCOMM="Release of batch "_FBAAB
 I '$D(^XUSEC("FBAASUPERVISOR",DUZ)) W !!,*7,"Sorry, only Supervisor can Release batch!" D Q G FBAASCB
 ; enforce segregation of duties (FB*3.5*117)
 D UOKCERT^PRCEMOA(.FBUOK,FBAAOB,DUZ) ; IA #5573
 I 'FBUOK D  D Q G FBAASCB
 . W $C(7),!,$P(FBUOK,U,2) ; display text returned by IFCAP API
 . I $P(FBUOK,U)="0" W !,"Due to segregation of duties, you cannot also certify an invoice for payment."
 . I $P(FBUOK,U)="E" W !,"This 1358 error must be resolved before the batch can be released."
 ;
 S DA=FBN,DR="0:1;ST" W !! D EN^DIQ
RD S B=FBN S DIR(0)="Y",DIR("A")="Want line items listed",DIR("B")="NO" D ^DIR K DIR G Q:$D(DIRUT) W:Y @IOF D:Y LIST^FBAACCB:FBTYPE="B3",LISTP^FBAACCB:FBTYPE="B5",LISTT^FBAACCB0:FBTYPE="B2",LISTC^FBAACCB1:FBTYPE="B9"
RDD S DIR(0)="Y",DIR("A")="Do you want to Release Batch as Correct",DIR("B")="NO" D ^DIR K DIR G Q:$D(DIRUT) I 'Y W !!,"Batch has NOT been Released!",*7 D Q G FBAASCB
 D WAIT^DICD
 S FBAARA=0
 I FBTYPE="B9" D ^FBAASCB0 G SHORT:$D(FBERR)
 I FBTYPE="B9",FBAARA>0 S FBAAMT=FBAARA D POST G SHORT:$D(FBERR)
 I FBTYPE'="B9" D POST I $D(FBERR) G SHORT
FIN ;
 ; use FileMan to update fields 5 and 6, store date & time (FB*3.5*117)
 S DA=FBN,DIE="^FBAA(161.7,"
 S DR="11////^S X=FBSTAT;6////^S X=DUZ;5////^S X=$$NOW^XLFDT" D ^DIE
 K DA,DIE,DIC,DR
 D UCAUTOP
 S DA=FBN,DR="0:1;ST",DIC="^FBAA(161.7," W !! D EN^DIQ W !!," Batch has been Released!"
 D Q G FBAASCB
Q I $G(FBN) K ^XTMP("FBAASCB",FBN) L -^FBAA(161.7,FBN)
 K B,J,K,L,M,X,Y,Z,DIC,FBN,A,A1,A2,BE,CPTDESC,D0,DA,DL,DR,DRX,DX,FBAACB,FBAACPT,FBAAON,FBAAOUT,FBVP,FBIN,DK,N,XY,FBINOLD,FBINTOT,FBTYPE,FZ,P3,P4,Q,S,T,V,VID,ZS,FBAAB,FBAAMT,FBAAOB,FBCOMM,FBAUT,FBSITE,I,X,Y,Z,FBERR,DIRUT,FBSTAT,FBLOCK
 K FBAC,FBAP,FBCNH,FBFD,FBI,FBLISTC,FBPDT,FBSC,FBTD,PRCSCPAN,DFN,FBINV
 K FBUOK,FBAARA
 Q
SHORT ;
 I '$D(FBINV) W !!,*7,"This batch CANNOT be released. Check your 1358.",!
 L -^FBAA(161.7,FBN) D Q G FBAASCB
POST ;FBAAOB=FULL OBLIGATION NUMBER(STA-CXXXXX)
 ;FBCOMM=COMMENT FOR 1358
 ;FBAAMT=TOTAL AMOUNT OF BATCH
 ;FBAAB=BATCH NUMBER
 ;IF CALL FAILS FBERR RETURNED=1
 ;FBN added as 7th peice of 'X'. It is the interface ID
 K FBERR
 S PRCS("X")=FBAAOB,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 W !!,*7,?5,"1358 not available for posting!",! S FBERR=1 Q
 D NOW^%DTC S X=FBAAOB_"^"_%_"^^"_FBAAMT_"^"_$S($L(FBAAB)<3:$$PADZ^FBAAV01(FBAAB,4),1:FBAAB)_"^"_FBCOMM_"^"_FBN_"^"_1,PRCS("TYPE")="FB" D EN2^PRCS58 I +Y=0 W !!,*7,Y,! S FBERR=1 Q
 K PRCS("SITE"),PRCSI Q
UCAUTOP ; Unauthorized Claims Autoprint
 ; If unauthorized claims autoprint feature is enabled then check items
 ; in batch and print an unauthorized claim disposition letter if all
 ; payments for a claim have been released
 ; input FBN    - batch ien
 ;       FBTYPE - batch type
 ;       FBCNH  - (opt) equals 1 if batch is for community nursing home
 N DA,FBDA,FBORDER,FBUC,FBUCA,FBX
 Q:"^B3^B5^B9^"'[(U_FBTYPE_U)  ; not an applicable batch type
 Q:$G(FBCNH)=1  ; CNH batch won't have associated unauth claims
 S FBUC=$$FBUC^FBUCUTL2(1)
 Q:'$$PARAM^FBUCLET(FBUC)  ; autoprint feature not enabled
 ;
 ; loop thru items in batch to build list of unauthorized claims
 K ^TMP("FBUC",$J)
 I FBTYPE="B3" D  ; if outpatient/ancillary batch
 . S DA(3)=0 F  S DA(3)=$O(^FBAAC("AC",FBN,DA(3))) Q:'DA(3)  D
 . . S DA(2)=0 F  S DA(2)=$O(^FBAAC("AC",FBN,DA(3),DA(2))) Q:'DA(2)  D
 . . . S DA(1)=0
 . . . F  S DA(1)=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1))) Q:'DA(1)  D
 . . . . S DA=0
 . . . . F  S DA=$O(^FBAAC("AC",FBN,DA(3),DA(2),DA(1),DA)) Q:'DA  D
 . . . . . S FBX=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0)),U,13)
 . . . . . I FBX["FB583" S ^TMP("FBUC",$J,+FBX)=""
 I FBTYPE="B5" D  ; if pharmacy batch
 . S DA(1)=0 F  S DA(1)=$O(^FBAA(162.1,"AE",FBN,DA(1))) Q:'DA(1)  D
 . . S DA=0 F  S DA=$O(^FBAA(162.1,"AE",FBN,DA(1),DA)) Q:'DA  D
 . . . S FBX=$P($G(^FBAA(162.1,DA(1),"RX",DA,2)),U,6)
 . . . I FBX["FB583" S ^TMP("FBUC",$J,+FBX)=""
 I FBTYPE="B9" D  ; if inpatient batch
 . S DA=0 F  S DA=$O(^FBAAI("AC",FBN,DA)) Q:'DA  D
 . . S FBX=$P($G(^FBAAI(DA,0)),U,5)
 . . I FBX["FB583" S ^TMP("FBUC",$J,+FBX)=""
 ;
 ; loop thru unauthorized claim list and print letter when appropriate
 S FBDA=0 F  S FBDA=$O(^TMP("FBUC",$J,FBDA)) Q:'FBDA  D
 . Q:'$$PAYST^FBUCUTL(FBDA)  ; not all payments for claim released yet
 . S FBUCA=$G(^FB583(FBDA,0))
 . Q:$P(FBUCA,U,16)'=1  ; claim not flagged for printing
 . S FBORDER=$$ORDER^FBUCUTL($P(FBUCA,U,24))
 . D AUTO^FBUCLET(FBDA,FBORDER,FBUCA,FBUC) ; autoprint letter
 ;
 K ^TMP("FBUC",$J)
 Q
 ;
