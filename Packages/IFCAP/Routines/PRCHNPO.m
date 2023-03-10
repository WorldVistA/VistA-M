PRCHNPO ;WISC/SC,ID/RSD/RHD/DGL/BGJ-ENTER NEW PURCHASE ORDER/REQUISITION ; Jun 30, 2021@12:03
V ;;5.1;IFCAP;**7,11,79,108,123,184,192,208,224**;Oct 20, 2000;Build 5
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*184 Added check for Purchase Card orders to insure there
 ;            are sufficient requsition sequence entries (>5) for
 ;            requistion created in file 410 for realted FCP used
 ;            and control for Running Balance Report.
 ;
 ;PRC*5.1*208 Changed order limit in opening message to $10000 at tag MSG
 ;
 ;PRC*5.1*224 changes the IENs to match the line numbers, and removed any associated discounts when a line item is deleted.
 ;
 S NOTCOMPL=0 ;Initialize for Incomplete Template.
 D SWITCH^PRCHUTL K ERRFLG ; SET LOG/ISMS SWITCH
 K PRCSIP ; Initialize Inventory point variable
 I $S('$G(PRCHPO):1,'$D(PRC("SITE")):1,1:0) G Q
 S DIE="^PRC(442,",DR="["_$S($D(PRCHNRQ):"PRCHNREQ",1:"PRCH2138")_"]",DIC("DR")="[PRCHVENDOR]"
 I $G(PRCPROST)=1 S DR="[PRCH PROSTHETIC]" D ^DIE QUIT
 I $G(PRCHPC)=1 S DR="[PRCHSIMP]"
 I $G(PRCHPC)=2 S DR="[PRCH DETAILED PURCHASE CARD]"
 I $G(PRCHPC)=3 S DR="[PRCH PC DIRECT DELIVERY]"
 I $G(PRCHDELV)=1,'$G(PRCHPHAM) S DR="[PRCH DELIVERY ORDER]"
 I $G(PRCHPHAM)=1 S DR="[PRCH DIRECT DELIVERY ORDER]"
 D ^DIE
 ;PRC*5.1*224- if Line Item removed, remove discount
 N PRCDA,PRCDISC,PRCDA1,PRCDSC,PRCFLG
 S PRCDA=0 F  S PRCDA=$O(^PRC(442,PRCHPO,3,PRCDA)) Q:'PRCDA  S PRCDISC=$P(^PRC(442,PRCHPO,3,PRCDA,0),U) D
 .S PRCDA1=0,PRCFLG=0 F  S PRCDA1=$O(^PRC(442,PRCHPO,2,PRCDA1)) Q:'PRCDA1  I PRCDISC=$P(^PRC(442,PRCHPO,2,PRCDA1,0),U) S PRCFLG=1 Q
 .I 'PRCFLG N DIE,DA,DR S DIE="^PRC(442,"_PRCHPO_",3,",DR=".01///@",DA=PRCDA,DA(1)=PRCHPO D ^DIE D
 ..W !!,"***Discount associated with deleted Line Item # ",PRCDISC," has been deleted.***",!
 ;end PRC*5.1*224
 ;
 ; Check ERRFLG to see if the user entered an up-arrow to get out or
 ; did not select a credit card name. The flag ERRFLG is set at the
 ; input templates above.
 I $G(ERRFLG)=99 G ERR      ;PRC*5.1*184 Check for error flag coming from Input Template for Purchase Cards
 I $G(ERRFLG)=42 G ERR
 I $G(ERRFLG)=38 G ERR
 I $G(ERRFLG)=1 G ERR
 I $G(ERRFLG)=2 G ERR
 I $G(ERRFLG)=3 G ERR
 ;Look for incomplete Input-Template when PRCHPC is defined.
 I $D(PRCHPC)  D
 . I $D(Y)'=0 S NOTCOMPL=1
 I NOTCOMPL G INCMSG
 I $G(PRCHPC)=1 Q:$D(Y)  D  Q:$D(Y)
 . S:'$D(^PRC(442,PRCHPO,2,0)) $P(^PRC(442,PRCHPO,2,0),U,2)=$P(^DD(442,40,0),U,2)
 . S DA(1)=PRCHPO,DIE="^PRC(442,"_DA(1)_",2,",DA=1
 . S DR=".01///^S X=1;1;I '$D(^PRC(442,DA(1),2,DA,1)) W !,""Description is Required!!"" S Y=1;2///^S X=1;3///^S X=""EA"";5////^S X=PRCHTOT;3.1///^S X=1;9.7///^S X=1;9///^S X="""";8///^S X=9999;K PRCHBOCC;"
 . S DR(1,442.01,1)="I PRCHN(""SFC"")=2 S PRCHBOCC=2696;I '$G(PRCHBOCC) S Y=""@87"";"
 . S DR(1,442.01,2)="S PRCHBOCC=$P($G(^PRCD(420.2,PRCHBOCC,0)),U);3.5////^S X=PRCHBOCC;S Y=""@89"";@87;3.5//^S X=PRCHBOC1;@89;K PRCHBOCC"
 . D ^DIE Q:$D(Y)
 . S DIE="^PRC(442,",DA=PRCHPO,DR=20 D ^DIE
PROS I $P($G(^PRC(442,PRCHPO,23)),U,11)]"" Q:$D(Y)  D  Q:$D(Y)  Q:'$G(CDA)
 . S PODIE=DIE,PODA=DA
 . S CDA=$P($G(^PRC(442,PRCHPO,23)),U,23),PRC("CP")=$P($G(^PRC(442,PRCHPO,0)),U,3)
 . I +$G(PRC("CP"))'=0 S DA=PRCHPO D START^PRCH410 I $G(PRCRMPR)=1,$G(X)="#" Q
 . I '$G(PRCHPHAM),'$G(PRCPROST),+$G(PRC("CP"))'=0 S DIE="^PRCS(410,",DA=$P($G(^PRC(442,PRCHPO,23)),U,23),DR=16 D ^DIE
 . S DIE=PODIE,DA=PODA
 I $G(PRCRMPR)=1,X="#" Q
 S VEN=+$G(^PRC(442,PRCHPO,1))
 I '$P($G(^PRC(442,PRCHPO,23)),U,11),$P($G(PRCHNVF),U,3)!($G(^PRC(440.3,+$G(VEN),0))]"") D
 . I $P($G(^PRC(411,PRC("SITE"),9)),U,3)="Y" D  Q
 . . S PRCHXXDA=DA
 . . S PRCHXDIE=DIE
 . . S DA=VEN
 . . Q:$$NEW^PRCOVTST(VEN,PRC("SITE"),1)
 . . I $P($G(PRCHNVF),U,3) D
 . . . S %X="^PRC(440,DA,"
 . . . S %Y="^PRC(440.3,DA,"
 . . . D %XY^%RCR
 . . . Q
 . . S DIE="^PRC(440.3,",DR="47///^S X=1;48///^S X=VEN;49///^S X=PRC(""SITE"")"
 . . D ^DIE
 . . S DA=PRCHXXDA
 . . S DIE=PRCHXDIE
 . . K PRCHXXDA
 . . K PRCHXDIE
 . D NEW^PRCOVRQ(VEN,PRC("SITE"))
 K VEN
 L +^PRC(442,PRCHPO):0 G ERR:'$T S PRCHSTAT=$P($G(^PRC(442,PRCHPO,7)),U,2) S:$D(Y)&('$D(PRCHNRQ))&(PRCHSTAT'=22) PRCHER="" S (PRCH,PRCHEC,PRCHX)=0
 S PRCHSC="" I $D(^PRC(442,PRCHPO,1)),$D(^PRCD(420.8,+$P(^(1),U,7),0)) S PRCHSC=$P(^(0),U,1) S $P(^PRC(442,PRCHPO,1),U,14)=$S(PRCHSC="B":"*",1:"")
 ;K PRCHER F  S PRCH=$O(^PRC(442,PRCHPO,2,PRCH)) Q:PRCH=""!(PRCH'>0)  D  G ERR:$D(PRCHER)
 K PRCHER F  S PRCH=$O(^PRC(442,PRCHPO,2,PRCH)) Q:PRCH=""!(PRCH'>0)  D
 .S $P(^PRC(442,PRCHPO,2,PRCH,2),U,6)=""
 .S PRCHLN=$G(^PRC(442,PRCHPO,2,PRCH,0)) ;I PRCHLN="" D ERR2 Q
 .S SUBACC=$P(PRCHLN,U,4) ;I SUBACC="" D ERR2 Q
 .D ERR2
 .Q
 K ^PRC(442,PRCHPO,2,"B"),^("C"),^("AC"),^("AE"),^("AH")
 N PRCHCNYS,PRCHCNNO S (PRCHCNYS,PRCHCNNO)=0 ;FLGS FOR CONTRACT # ON ITEM
 S PRCH=0 F I=1:1 S PRCH=$O(^PRC(442,PRCHPO,2,PRCH)) Q:PRCH=""!(PRCH'>0)  D CHG I $D(^PRC(442,PRCHPO,2,PRCH,0)) D
 .S PRCHAM=+$P(^PRC(442,PRCHPO,2,PRCH,2),U,1),PRCHCN=$P(^(2),U,2) D CN:PRCHCN]"",OM:PRCHCN=""
 .I PRCHCN]"" S PRCHCNYS=1
 .E  S PRCHCNNO=1
 .S $P(^PRC(442,PRCHPO,2,PRCH,2),U,5)=""
 .Q
 S PRCHLCNT=I-1,$P(^PRC(442,PRCHPO,0),U,14)=PRCHLCNT S:$D(^PRC(442,PRCHPO,2,0)) $P(^(0),U,3,4)="1^"_PRCHLCNT I 'PRCHLCNT S PRCHER="" W !,"There are no line items listed in the Purchase Order."
 G ERRCHKS:'$D(^PRC(442,PRCHPO,1))!('$D(^(2)))
 I $P(^PRC(442,PRCHPO,0),U,3)=""!($P(^(0),U,4))="" W !!?5,"Fund Control Point is undefined  !",$C(7)
 S PRCHV=$P(^PRC(442,PRCHPO,1),U,1) I PRCHV="" W !!?5,"Vendor is undefined !",$C(7) ;G ERR
ERRCHKS S ERRFL=0 D ERRCHKS^PRCHNPO9 ;I ERRFL=0 K ERRFL G CONT
 ;K ERRFL G ERR
CONT ;
 S ERROR1="" D ^PRCHNPO9
 I ERROR1=1!(ERRFL>0)!($D(PRCHER)) G ERR
 D BBFY^PRCHNPO8(PRCHPO) I PRC("BBFY")'>0 W !!?5,"BBFY can not be checked/updated.",$C(7) G ERR
 S PRCH=0 F I=0:1 S PRCH=$O(PRCH("AM",PRCH)) Q:PRCH=""  S PRCH("COUNT",+PRCH("AM",PRCH),PRCH)=""
 I PRCHCNNO,PRCHCNYS D ASTR ; <<< only call on ASTR
 G:I=1 ^PRCHNRQ:$D(PRCHNRQ),^PRCHNPO1 S J=1 F PRCHJ=0:0 S PRCH=$O(PRCH("COUNT",PRCH)) Q:PRCH=""  D MISS
 G ^PRCHNRQ:$D(PRCHNRQ),^PRCHNPO1
 ;
LI S PRCHL0=$P(PRCH("AM",PRCHL3),U,3) Q:PRCHL0=""  F J=1:1 S PRCHL1=$E(PRCHL0,$L(PRCHL0)-J) Q:PRCHL1'=+PRCHL1
 S PRCHL2=$E(PRCHL0,$L(PRCHL0)-J+1,$L(PRCHL0)-1),PRCHL2=PRCHL2+1 I PRCHL2'=PRCHLI S PRCHLI=PRCHL0_PRCHLI Q
 I PRCHL1=":" S PRCHLI=$E(PRCHL0,1,$L(PRCHL0)-J)_PRCHLI Q
 S PRCHLI=$E(PRCHL0,1,$L(PRCHL0)-1)_":1:"_PRCHLI
 Q
 ;
CHG I '$P(^PRC(442,PRCHPO,2,PRCH,0),"^",5),'$O(^(1,0)) S $P(^PRC(442,PRCHPO,2,PRCH,2),U,4,6)="^^" W !,"Line item ",+^PRC(442,PRCHPO,2,PRCH,0)," is missing its description!" S PRCHER=""
 S PRCOIEN=$P(^PRC(442,PRCHPO,2,PRCH,0),U,1),$P(^PRC(442,PRCHPO,2,PRCH,0),U,1)=I,X=$P(^(0),U,5),X1=$P(^(0),U,4) ;PRC*5.1*224 - Update IEN to match line items
 S ^PRC(442,PRCHPO,2,"B",I,PRCH)="",^PRC(442,PRCHPO,2,"C",I,PRCH)="",^PRC(442,PRCHPO,2,"AH",+X1,I,PRCH)="",PRCHLI=I,PRCHX=PRCH S:X]"" ^PRC(442,PRCHPO,2,"AE",X,PRCH)=""
 S PRCDA=0 F  S PRCDA=$O(^PRC(442,PRCHPO,3,PRCDA)) Q:'PRCDA  S PRCDLN=$P(^PRC(442,PRCHPO,3,PRCDA,0),U) I PRCDLN=PRCOIEN D  ;PRC*5.1*224 - update discount when line item is deleted
 .S $P(^PRC(442,PRCHPO,3,PRCH,0),U,1)=I  ;PRC*5.1*224 - update discount when line item is updated
 Q
 ;
ERR2 I $S('$D(^PRC(442,PRCHPO,2,PRCH,2)):1,$P(^(2),U,1)="":1,1:0) S $P(^(2),U,1)="",$P(^(2),U,4,7)="" W !,"Line item ",+^(0)," is incomplete !",$C(7) S PRCHER=""
 I '$G(PRCHPC),$D(PRCHNRQ),PRCHSC'=9,$P(^PRC(442,PRCHPO,2,PRCH,0),U,13)="" W !,"Line item ",+^(0)," is missing NSN !",$C(7) S PRCHER=""
 I $P(^PRC(442,PRCHPO,2,PRCH,0),U,4)="" W !,"Line item ",+^(0)," is missing BOC !",!,$C(7) S PRCHER=""
 Q
 ;
CN S:'$D(PRCH("AM",PRCHCN)) PRCH("AM",PRCHCN)="",PRCHEC=PRCHEC+1 S PRCHL3=PRCHCN
 D LI S PRCH("AM",PRCHCN)=($P(PRCH("AM",PRCHCN),U,1)+1)_U_($P(PRCH("AM",PRCHCN),U,2)+PRCHAM)_U_PRCHLI_",",^PRC(442,PRCHPO,2,"AC",$E(PRCHCN,1,30),PRCH)=""
 Q
 ;
OM S:'$D(PRCH("AM",".OM")) PRCH("AM",".OM")="",PRCHEC=PRCHEC+1 S PRCHL3=".OM" D LI S PRCH("AM",".OM")=($P(PRCH("AM",".OM"),U,1)+1)_U_($P(PRCH("AM",".OM"),U,2)+PRCHAM)_U_PRCHLI_","
 Q
 ;
MISS S PRCHN=0 F K=1:1 S PRCHN=$O(PRCH("COUNT",PRCH,PRCHN)) Q:PRCHN=""!(J>(I-1))  S J=J+1,L=0,Y=$P(PRCH("AM",PRCHN),U,3),Y="F PRCHLI="_$E(Y,1,$L(Y)-1)_" S L=L+1 G ERR2:PRCHX<0" X Y
 Q
 ;
ASTR ;IF SOME ITEMS HAVE CN, SOME DO NOT, PLACE '*' ON DISPLAY OF PO
 N CN,ITM,DESC,ROOT
 S ROOT="^PRC(442,PRCHPO)"
 S CN=0 F M=1:1 S CN=$O(@ROOT@(2,"AC",CN)) Q:CN=""  S:$D(^(CN)) ITM=$O(^(CN,0)) S ^PRC(442,PRCHPO,2,"AC",CN,ITM)="*"
 S:PRCHSC="B" $P(^PRC(442,PRCHPO,1),U,14)="*"
 S DESC=0 F I=1:1 S DESC=$O(@ROOT@(2,DESC)) Q:DESC=""!(DESC'>0)  I $P(@ROOT@(2,DESC,2),U,2)']"" S $P(^PRC(442,PRCHPO,2,DESC,2),U,5)="*"
 ;S PRCHX=$O(^PRC(442,PRCHPO,2,"B",PRCHLI,0)) Q:PRCHX=""!('$D(^PRC(442,PRCHPO,2,PRCHX,2)))  S $P(^(2),U,5)=PRCHN("*") S:PRCHN'=".OM" ^PRC(442,PRCHPO,2,"AC",PRCHN,PRCHLI)=PRCHN("*")
 ;I PRCHSC="B",PRCHN=".OM",$D(^PRC(442,PRCHPO,1)),L=1 S ^(1)=$P(^(1),U,1,13)_U_PRCHN("*")_U_$P(^(1),U,15,99)
 Q
 ;
ERR ;
 W !!?5,$S($D(PRCHNRQ):"Requisition",1:"Purchase Order")_" is incomplete and must be re-edited !",$C(7)
INCMSG ;
 I '$D(NOTCOMPL)  D
 . S NOTCOMPL=0
 I NOTCOMPL  D
 . W !!,?5,"Incomplete transaction. It must be re-edited !",$C(7)
Q K ERRDEL,ERRPC,ERRPO,DR,NOTCOMPL,DRTY,IMF,IMFD,LI,MUL,MULMSG,PRCHDRTY,PRCHFSCD,PRCHLCNT,PRCHMUL,PRCHM10,PRCHMS10,PRCHMS11,PRCHUCF,PRTY,SUPUSR,UCF,UCFMSG,UFL,VND
 G Q^PRCHNPO4
 ;
MSG ;Call by the "ENTRY ACTION" for Simplified PC (PRC*5.1*79)
 NEW MSG
 S MSG(1)="*********************************************"
 S MSG(1,"F")="!!?15"
 S MSG(2)="*  IF THE ORDER IS MORE THAN $10000.00      *"     ;PRC*5.1*208
 S MSG(2,"F")="!?15"
 S MSG(3)="*  OR IS ON A CONTRACT, YOU CANNOT USE      *"
 S MSG(3,"F")="!?15"
 S MSG(4)="*        SIMPLIFIED PURCHASE CARD.          *"
 S MSG(4,"F")="!?15"
 S MSG(5)="*  YOU MUST USE DETAILED PURCHASE CARD!!    *"
 S MSG(5,"F")="!?15"
 S MSG(6)="*********************************************"
 S MSG(6,"F")="!?15"
 S MSG(7,"F")="!"
 ;
 D EN^DDIOL(.MSG)
 QUIT
