LRMLED ;BPFO/DTG - NTRT MESSAGE PROCESS AND EDITS UPDATE ;02/10/2016
 ;;5.2;LAB SERVICE;**468**;FEB 10 2016;Build 64
 ;
 ; ESTART is called from a 'NEW' format cross reference on the 60 file AMLTFNTRT
 ; and will send NTRT message if appropiate.
EN(LRS,LR60IEN) ; entry point from cross reference
 ; only have one
 L +^TMP(LR60IEN,LRS):1 I '$T Q
 N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC
 S ZTDTH=$$NOW^XLFDT,ZTDESC="LAB Create NTRT message from file 60 Cross Reference #491"
 S ZTRTN="ESTART^LRMLED("_LR60IEN_","_LRS_")",ZTSAVE("LR60IEN")="",ZTSAVE("LRS")="",ZTIO="",ZTSAVE("LRDUZ")=DUZ
 D ^%ZTLOAD
 L -^TMP(LR60IEN,LRS)
 Q
 ;
ESTART(LR60IEN,LRS) ; pick up key data for NTRT
 Q:$D(LRMLTFREC)
 L +^TMP(LR60IEN,LRS):30 I '$T Q
 N LXA,LXB,LXC,LXG,LXD,LXE,LXF,A,B,C,D,LSITE,LRNT,LRNTI,AR,LRNLT,LRSEC,I,LRNOS1,LRNOS2
 N LRSITE,LRSITEN,LRGMAIL,LRSMAIL,LRNAMIL,LACT,MAILPERSON,LR64,LRCOM,LRCTY,LRSUBSCRIPT
 N LRSCHPA,LRSCHNM,ALI,LRTEXT,LR64N,LRDTNM,G
 S:$G(LRDUZ)="" LRDUZ=$G(DUZ)
 I $G(DT)="" S DT=$$DT^XLFDT
 D GET664
 ; check if allow to send to NTRT
 ; I $G(LRNTI(.1,"I"))'=1 G EOUT
 ;
 ;site number and name
 S LRSITE=$G(LRNTI(.01,"I")),LRSITEN=$G(LRNTI(.01,"E"))
 ;ntrt mail group
 S LRNMAIL=$G(LRNTI(1,"I"))
 ;lab send mail group
 S LRGMAIL=$G(LRNTI(2,"I"))
 ;lab server side mail group
 S LRSMAIL=$G(LRNTI(3,"I"))
 ;how to send mail
 S LACT=$G(LRNTI(.02,"E"))
 ; get type of test to send
 S LRSUBSCRIPT=$G(LRNTI(.07,"I")) I LRSUBSCRIPT="" S LRSUBSCRIPT=1 ; default to CH only
 ; send blood bank?
 ;
 S DA=+LR60IEN
 ;get test
EA ; .01 test name, 4 subscript (CH), 5 data name, 13 field (DD of 5), 64.1 result nlt code
 S DIQ="LXB",DIQ(0)="IE",DIC=60,DR=".01;4;64.1;5;13;132;133" K ^UTILITY("DIQ1",$J) D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LXA M LXA=LXB(60,DA) K LXB
 D TDT
 ; check test subscript is valid for NTRT
 S A=$G(LXA(4,"I"))
 I A="WK" G EOUT ; don't send if workload
 I A="AU" G EOUT
 I A="EM" G EOUT
 I A="BB" G EOUT
 I A="CH"&((LRSUBSCRIPT=1)!(LRSUBSCRIPT=7)!(LRSUBSCRIPT=8)) G EGOOD
 I A="MI"&((LRSUBSCRIPT=2)!(LRSUBSCRIPT=7)!(LRSUBSCRIPT=8)) G EGOOD
 ; I A="EM"&((LRSUBSCRIPT=3)!(LRSUBSCRIPT=8)) G EGOOD  ; do not do AU per Leeanne 6/2016
 I A="SP"&((LRSUBSCRIPT=4)!(LRSUBSCRIPT=8)) G EGOOD
 I A="CY"&((LRSUBSCRIPT=5)!(LRSUBSCRIPT=8)) G EGOOD
 ; I A="AU"&((LRSUBSCRIPT=6)!(LRSUBSCRIPT=8)) G EGOOD ; do not do AU per Leeanne 6/2016
 G EOUT ; doesn't match up
 ;
EGOOD ; if the subscript is valid
 ; check if inactive
 S A=$G(LXA(132,"I")),B=$G(LXA(133,"I")) I A'=""!(B'="") G EOUT
 ;get synonyms
 K B S LXG="",A=0 F I=0:1 S A=$O(^LAB(60,DA,5,A)) Q:'A  S B(I)=$P(^LAB(60,DA,5,A,0),U,1)
 I I>0 S B=I-1 F I=0:1:B S:LXG="" LXG=B(I) S:LXG'="" LXG=LXG_U_B(I) I $L(LXG)>210 Q
 ;get nlt number
 S LR64=$G(LXA(64.1,"I")),(LRNLT,LRSEC)="",LR64N=$G(LXA(64.1,"E"))
 I LR64'="" S LRNLT=$G(^LAM(LR64,0)),A=$P(LRNLT,U,15),LRNLT=$P(LRNLT,U,2)
 I A'="" S LRSEC=$P($G(^LAB(64.21,A,0)),U,2)
 ;get comment / data type from comment
 S (LRCOM,LRCTY,LRDTNM)="",A=$G(LXA(13,"I")),LRDTNM=$P($G(LXA(5,"I")),";",2)
 I A'="" S B=$$ETSTTYP(A),LRCOM=$P(B,"|",1),LRCTY=$P(B,"|",2) S:$P(B,"|",3)'="" LRDTNM=LRDTNM_" - "_$P(B,"|",3)
 ; loop through site/specimen multiple
 ; S LRS=0
ES ; S LRS=$O(^LAB(60,DA,1,LRS)) I 'LRS G EOUT
 S DIQ="LXB",DIQ(0)="IE",DIC=60,DR=100,DA=+LR60IEN K LXB,^UTILITY("DIQ1",$J)
 S DR(60.01)=".01;6;1;2;9.2;9.3;13;30;32;33;34;35",DA(60.01)=LRS
 D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LXC M LXC=LXB("60.01",LRS) K LXB
 ; get the specimen INTERPRETATION
 D GETS^DIQ(60.01,LRS_","_DA,"5.5","","LXB")
 K LXE M LXE=LXB(60.01,LRS_","_DA_",",5.5) K LXB
 ; don't do if VUID already associated
 I $G(LXC(30,"I"))'="" G EOUT
 ; don't do if inactive or already sent
 S A=$G(LXC(32,"I")),B=$G(LXC(33,"I")),C=$G(LXC(34,"I")) I $E(A,1)="Y"!(B'="")!($E(C,1)="Y") G EOUT
 ;if no send method oor not allowed to send to NTRT
 S LRNOS1=0 I LACT=""!(LACT="N")!($G(LRNTI(3,"I"))="N")!($G(LRNTI(.1,"I"))'=1) S LRNOS1=1
 S A=$TR(LRGMAIL,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S LRNOS2=0 I '$$PROD^XUPROD()!(LRGMAIL'["DOMAIN.EXT") S LRNOS2=1
 I LACT=""!($E(LACT,1)="N") D MAILMAN G EOUT
 D @LACT
 ;put exception flag in 60 file
 ; since making exception flag uneditable must do physical set
 I (LRNOS1'=1&(LRNOS2'=1)) D  ;<
 . N A,B,LRO,LRN,I S A=$G(^LAB(60,LR60IEN,1,LRS,5)),B=A,$P(B,U,3)="Y",^LAB(60,LR60IEN,1,LRS,5)=B
 . ; need to build array for saving in audit section
 . F I=1,2,4 S LRO(I)="",LRN(I)=""
 . S LRO(3)=$P(A,U,3),LRN(3)=$P(B,U,3)
 . N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC
 . S ZTDTH=$$NOW^XLFDT,ZTDESC="LAB Edit Save of Deployed Flag"
 . S ZTRTN="SEDA^LRMLED("_LRS_","_LR60IEN_")",ZTSAVE("LR60IEN")="",ZTSAVE("LRS")=""
 . S ZTSAVE("LRN(")="",ZTSAVE("LRO(")=""
 . S ZTIO=""
 . D ^%ZTLOAD
 G EOUT
 ;
MAILMAN ;mailman
 N XMSUB,XMY,XMTEXT,LRTEXT,XMDUZ,DA,DR,DIE
 ;
 I LRNMAIL="" Q  ; missing NTRT recipient
 ;
 S XMSUB="NEW NTRT REQUEST FOR LABORATORY"
 S XMY(DUZ)=""
 ; send to NTRT if ntrt mail group and send method and production/va site
 I LRNMAIL'="" S XMY(LRNMAIL)="" I LRNOS1=1!(LRNOS2=1) K XMY(LRNMAIL)
 ;
 I LRGMAIL'="" S XMDUZ("New Test/Specimen NTRT Request From: "_$E(LRSITEN,1,30))="",XMY($P(LRGMAIL,"@",1))=""
 S ALI=0
 I LRNOS1=1!(LRNOS2=1) D  ;<
 . S ALI=$$LRTP(ALI),LRTEXT(ALI)="***  THIS TEST/SPECIMEN WAS NOT SENT TO NTRT ***"
 . S A="" S:LRNOS1=1 A="Missing Send Method" S A=A_$S((LRNOS2=1&(A'="")):" and ",1:""),A=A_$S(LRNOS2=1:"Facility is Either Not Production or Not a VA Site",1:"")
 . S ALI=$$LRTP(ALI),LRTEXT(ALI)=A
 . S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="A new Laboratory Test has been entered at: "_LRSITEN
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Facility Name/Number: "_LRSITEN_" / "_LRSITE
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="For questions or notifications respond to: "_LRGMAIL
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 ; S LRTEXT(6)="For NTRT results respond to :"_LRSMAIL
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 I $G(LRRESEND)=1 S ALI=$$LRTP(ALI),LRTEXT(ALI)=" **** THIS TEST/SPECIMEN IS BEING RESENT ****"
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="New Laboratory Test Name: "_$G(LXA(.01,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="New Laboratory Test LOCAL IEN: "_(+LR60IEN)
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Laboratory Test Site/Specimen Number (IEN): "_$G(LXC(.01,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Laboratory Test Site/Specimen Name: "_$G(LXC(.01,"E"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S B="",A=$G(LXC(.01,"I")) I A S A=$G(^LAB(61,A,0)),B=$P(A,U,10) I +B>0 S B=$P($G(^LAB(64.061,B,0)),U,1)
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Spec: "_$P(A,U,1)
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Time Aspect: "_B
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Units: "_$G(LXC(6,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="NLT: "_LRNLT
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Lab Section: "_LRSEC
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Subscript: "_$G(LXA(4,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Data Name: "_LRDTNM
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Data Comment: "_LRCOM
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Data Type: "_LRCTY
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Reference Low: "_$G(LXC(1,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Reference High: "_$G(LXC(2,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Therapeutic Low: "_$G(LXC(9.2,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Therapeutic High: "_$G(LXC(9.3,"I"))
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 ; S A=$G(LXC(13,"I")),B=$S(A=1:"YES",1:"NO")
 ; S ALI=$$LRTP(ALI),LRTEXT(ALI)="Use Ref Lab: "_B
 ; S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S ALI=$$LRTP(ALI),LRTEXT(ALI)="Test Synonyms: "_LXG
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 ; F I=10:2:44 S LRTEXT(I)=""
 S E=0 F I=1:1 S E=$O(LXE(E)) Q:'E  S G=LXE(E),ALI=$$LRTP(ALI),LRTEXT(ALI)=$S(I=1:"Specimen Interpretation: ",1:"                         ")_G
 S ALI=$$LRTP(ALI),LRTEXT(ALI)=""
 S XMTEXT="LRTEXT(" D ^XMD
 ;
 Q
 ;
CTCHK(LR60IEN) ; check if the test is valid for create date and it hasn't been set previously
 ; is the test valid for update
 N A,B,C,LSITE,LRNT
 S A=$$GET1^DIQ(60,LR60IEN_",",131)
 I A'="" Q 0
 S LSITE=$$SITE^VASITE,LSITE=$P(LSITE,U,1)
 S LRNT=$O(^LAB(66.4,"B",LSITE,0))
 I +LRNT<1 Q 0
 S A=$$GET1^DIQ(66.4,LRNT_",",.06)
 I A&(A>(LR60IEN-1)) Q 0
 Q 1
 ;
NSP(LR6001IEN,LR60IEN) ; entry to set specimen date if new specimen
 N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC,LRN,LRO
 ; X1-old array  X2-new array
 M LRO=X1,LRN=X2
 S ZTDTH=$$NOW^XLFDT,ZTDESC="LAB Edit Save from file 60 Cross Reference #490"
 S ZTRTN="NSPA^LRMLED("_LR6001IEN_","_LR60IEN_")",ZTSAVE("LR60IEN")="",ZTSAVE("LR6001IEN")=""
 S ZTSAVE("LRN(")="",ZTSAVE("LRO(")=""
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
NSPA(LRDA,LRDA1) ; save specimen create date if new specimen for test
 ; (1)-.01 SITE/SPECIMEN
 ; LRDA - specimen IEN
 ; LRDA1 - test IEN
 ; LRO-old array  LRN-new array
 Q:$D(LRMLTFREC)
 N A,B,C,D,E,F,DA
 N DR,DIE,DIC,X
 I $G(LRO(1))'=""!($G(LRN(1))="") G NSPQ
 S DA=LRDA,DA(1)=LRDA1
 S A=$$GET1^DIQ(60.01,DA_","_DA(1),35,"I")
 I A'="" G NSPQ
 I $G(DT)="" S DT=$$DT^XLFDT
 S DIE="^LAB(60,"_DA(1)_",1,",DR="35///"_DT
 D ^DIE
 G NSPQ
 ;
NSPQ ; quit
 K A,B,C,D,E,F,DA,DR,DIE,DIC,X
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
TDT ;place creation date in test
 I $G(LXA(131,"I"))'="" Q  ; date already on file
 S A=$G(LRNTI(".06","I")) I A&(A>(LR60IEN-1)) Q  ; only set if test added after patch 468 load
 N DA,DR,DIE
 L +^LAB(60,LR60IEN):30 I '$T Q
 S DA=+LR60IEN,DR="131///"_DT,DIE="^LAB(60," D ^DIE
 L -^LAB(60,LR60IEN)
 Q
 ;
SDT ; place specimen creation dt
 I $G(LXC(35,"I"))'="" Q  ; date on file
 N DA,DR,DIE
 L +^LAB(60,LR60IEN,1,LRS):30 I '$T Q
 S DA(1)=+LR60IEN,DA=LRS,DR="35///"_DT,DIE="^LAB(60,"_DA(1)_",1," D ^DIE
 L -^LAB(60,LR60IEN,1,LRS)
 Q
 ;
LRTEXT(AL) ; update counter for message xml
 S AL=AL+1
 Q AL
 ;
HL7 ;send hl7 to NTRT
 ; currently not implemented
 Q
 ;
LRTP(AA) ;update text counter
 S AA=AA+1
 Q AA
 ;
XML ;send xml to NTRT
 ; moved to LRMLEDA for size
 D XML^LRMLEDA
 Q
 ;
 ;
ETSTTYP(LRX) ; get test data type
 N LRSTUB,LRTYPE,LRY,K,KK
 I LRX="" Q ""
 S K="^"_LRX_"0)",KK=$G(@K),$P(LRSTUB,"|",3)=$P(KK,U,1)
 S LRX=$P(LRX,"(",2)
 ;
 ; Data type
 S LRTYPE=$$GET1^DID($P(LRX,","),$P(LRX,",",2,99),"","TYPE")
 S $P(LRSTUB,"|",2)=LRTYPE
 ;
 ; Input transform
 S LRY=$$GET1^DID($P(LRX,","),$P(LRX,",",2,99),"",$S(LRTYPE="SET":"POINTER",1:"INPUT TRANSFORM"))
 I LRTYPE="NUMERIC",LRY["LRNUM" D
 . S LRX=$P(LRY,"""",2)
 . I LRX?.1"-".N1","1.N1","1N S LRY="Number from "_$P(LRX,",")_" to "_$P(LRX,",",2)_" with "_$P(LRX,",",3)_" decimal"
 . S $P(LRSTUB,"|",1)=LRY
 ; Help prompt
 I LRTYPE="FREE TEXT" D
 . S LRY=$$GET1^DID($P(LRX,","),$P(LRX,",",2,99),"","HELP-PROMPT")
 . S $P(LRSTUB,"|",1)=LRY
 Q LRSTUB
 ;
EOUT ; quit
 L -^TMP(LR60IEN,LRS)
 K LXA,LXB,LXC,LXD,LXE,LXF,LXG,A,LR60IEN,DA,DIC,DIQ,B,C,D,LRS,LSITE,LRNT,LRNTI,AR,I,LRMLTFREC
 K LRSITE,LRSITEN,LRGMAIL,LRSMAIL,LRNMAIL,LACT,MAILPERSON,LR64,LRNLT,LRSEC,LRCOM,LRCTY,LRNEWTEST,LRSUBSCRIPT
 K LRNOS1,LRNOS2,LRSCHPA,LRSCHNM,ALI,LRTEXT,LR64N,LRDTNM,G
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
 ; This section is called by the NEW Record cross references in file 60
 ; CR 489 for BED (base level edit) and SITE/SPECIMEN sub Level 490 for SED
 ;
BED(LR60IEN) ;ENTRY POINT FOR MAIN EDITS
 ;
 N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC,LRN,LRO
 M LRO=X1,LRN=X2
 S ZTDTH=$$NOW^XLFDT,ZTDESC="LAB Edit Save from file 60 Cross Reference #489"
 S ZTRTN="BEDA^LRMLED("_LR60IEN_")",ZTSAVE("LR60IEN")=""
 S ZTSAVE("LRN(")="",ZTSAVE("LRO(")=""
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
BEDA(LRDA) ; edits from main level
 Q:$D(LRMLTFREC)
 ; (1)-3 TYPE (2)-131 CREATION DATE (3)-133 TEST INACTIVE DATE
 ; X1-old array  X2-new array
 N A,B,C,D,E,F,G,I,DA,LO,LN,LE,LLI,LTYP
 M A=DR S D=0
 N DR,DIE,DIC,X
 F I=1:1:3 S F=$G(LRO(I)),G=$G(LRN(I)) I F'=G S D=1
 I 'D G BEDO
 F LLI=1:1:3 S LO=$G(LRO(LLI)),LN=$G(LRN(LLI)) I LO'=LN S LTYP=$S(LLI=1:"Y",LLI=2:"C",1:"T") D  D SAV
 . ; I LTYP="C"!(LTYP="T") S:+LO>0 LO=$$FMTE^XLFDT(LO,9) S:+LN>0 LN=$$FMTE^XLFDT(LN,9)
 G BEDO
 ;
BEDO K A,B,C,D,E,I,X,DA,LRN,LRO,LO,LN,LE,LLI,DR,DIE,DIC,LRMLTFREC,LTYP
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
SAV ; file edit in 60.28
 N DR,DIE,DIC,X,DA,Y,LRMLTFREC,LE
 S DA(1)=LRDA,DA=0,LRMLTFREC=1
 S LE="^LAB(60,"_DA(1)_",15,",DIC=LE,DIC(0)="QEAL"
 S X=$$NOW^XLFDT
 L +^LAB(60,DA(1),15):30 I '$T Q
 D FILE^DICN
 L -^LAB(60,DA(1),15)
 I Y="-1" Q
 S DIE=LE,DA=+Y
 S DR=".02///"_+$G(DUZ)_";.03///"_LTYP_";.04///"_LO_";.05///"_LN
 D ^DIE
 K DR,DIE,DIC,X,DA,Y,LRMLTFREC,LE
 Q
 ;
SED(LR6001IEN,LR60IEN) ;ENTRY POINT FOR MAIN SITE/SPECIMEN EDITS
 ;
 N ZTDTH,ZTRTN,ZTSAVE,ZTIO,ZTSK,ZTDESC,LRN,LRO
 M LRO=X1,LRN=X2
 S ZTDTH=$$NOW^XLFDT,ZTDESC="LAB Edit Save from file 60 Cross Reference #490"
 S ZTRTN="SEDA^LRMLED("_LR6001IEN_","_LR60IEN_")",ZTSAVE("LR60IEN")="",ZTSAVE("LR6001IEN")=""
 S ZTSAVE("LRN(")="",ZTSAVE("LRO(")=""
 S ZTIO=""
 D ^%ZTLOAD
 Q
 ;
SEDA(LRDA,LRDA1) ; edits from site/specimen level
 ; (1)-30 MLTF VUID (2)-RESULT/SPECIMEN INACTIVE DATE (3)-EXCEPTION FLAG (4)-SPECIMEN CREATE DATE
 ; X1-old array  X2-new array
 Q:$D(LRMLTFREC)
 N A,B,C,D,E,F,DA,LLI,LTYP
 M A=DR
 N DR,DIE,DIC,X
 S D="" F I=1:1:4 S E=$G(LRO(I)),F=$G(LRN(I)) I E'=F S D=1
 I 'D G BEDO
 F LLI=1:1:4 S LO=$G(LRO(LLI)),LN=$G(LRN(LLI)) I LO'=LN S LTYP=$S(LLI=1:"M",LLI=2:"R",LLI=3:"E",1:"S") D  D SSAV
 . ; I LTYP="R"!(LTYP="S") S:+LO>0 LO=$$FMTE^XLFDT(LO,9) S:+LN>0 LN=$$FMTE^XLFDT(LN,9)
 G BEDO
 Q
 ;
SSAV ; file edit in 60.28
 N DR,DIE,DIC,X,DA,Y,LRMLTFREC,LE
 S DA(1)=LRDA1,DA=0,LRMLTFREC=1
 S LE="^LAB(60,"_DA(1)_",15,",DIC=LE,DIC(0)="QEAL"
 S X=$$NOW^XLFDT
 L +^LAB(60,DA(1),15):30 I '$T Q
 D FILE^DICN
 L -^LAB(60,DA(1),15)
 I Y="-1" Q
 S DIE=LE,DA=+Y
 S DR=".02///"_+$G(DUZ)_";.03///"_LTYP_";.04///"_LO_";.05///"_LN_";.06///"_LRDA
 D ^DIE
 K DR,DIE,DIC,X,DA,Y,LRMLTFREC,LE
 Q
 ;
GET664 ; get file 66.4 info
 S LSITE=$$SITE^VASITE,LSITE=$P(LSITE,U,1)
 S LRNT=$O(^LAB(66.4,"B",LSITE,0))
 D GETS^DIQ(66.4,LRNT_",","**","IE","AR")
 M LRNTI=AR("66.4",LRNT_",") K AR
 Q
 ;
GET60T ; get top of file 60 test info
 S DIQ="LXB",DIQ(0)="IE",DIC=60,DR=".01;131" K ^UTILITY("DIQ1",$J) D EN^DIQ1 K ^UTILITY("DIQ1",$J)
 K LXA M LXA=LXB(60,DA) K LXB
 Q
 ;
