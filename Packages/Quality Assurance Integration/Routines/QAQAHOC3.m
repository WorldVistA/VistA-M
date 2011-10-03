QAQAHOC3 ;HISC/DAD-AD HOC REPORTS: MACRO MANAGEMENT ;7/12/93  14:35
 ;;1.7;QM Integration Module;**1,2,5**;07/25/1995
 ;
 S QAQSELOP=$E(QAQSELOP,2,999) S:QAQSELOP?1L QAQSELOP=$C($A(QAQSELOP)-32)
 I "^S^L^I^D^O^"'[("^"_QAQSELOP_"^") S QAQSELOP=-1 Q
 W $P($P("^Save^Load^Inquire^Delete^Output^","^"_QAQSELOP,2),"^")," ",$S(QAQSELOP'="O":QAQTYPE(0)_" ",1:""),"macro"
 I $D(^QA(740.1,0))[0 W *7,!!?3,"The Ad Hoc Macro file does not exist !!" S QAQSELOP=0 R QA:QAQDTIME Q
 D SETSAVE:QAQSELOP="S",LOAD:QAQSELOP="L",INQUIRE:QAQSELOP="I",DELETE:QAQSELOP="D",EN1^QAQAHOC4:QAQSELOP="O"
 Q
SETSAVE ; *** Set the save macro flag
 S QAQMSAVE=1 W !!?3,"The macro will be saved when you exit the ",QAQTYPE(0)," menu. ",*7 I QAQSEQ=1 R QA:QAQDTIME Q
SAVEOUT W !!?3,"OK to exit now" S %=1 D YN^DICN I '% W !!?5,QAQYESNO G SAVEOUT
 S:%=1 QAQNEXT=1 S:%=-1 (QAQNEXT,QAQQUIT)=1
 Q
SAVE ; *** Save a sort/print macro
 K DIC,QAQMACRO(QAQTYPE) S DIC(0)="AELMNQZ",DIC("A")="Save" D ASKMAC Q:Y'>0
 I $P(Y,"^",3)'>0 W *7 D  G SAVE:QAQREPLC=2 Q:QAQREPLC=-1
REPLACE . W !!?3,QAQTEMP," already exists, OK to replace"
 . S %=2 D YN^DICN S QAQREPLC=%  I '% W !!?5,QAQYESNO G REPLACE
 . Q:%'=1
 . F QAQD1=0:0 S QAQD1=$O(^QA(740.1,QAQD0,"FLD",QAQD1)) Q:QAQD1'>0  D
 .. S (D0,DA(1))=QAQD0,(D1,DA)=QAQD1,DIK="^QA(740.1,"_QAQD0_",""FLD"","
 .. D ^DIK
 .. Q
 . Q
 S (QAQFLDNO,%)=0
 F QAQORDER=0:0 S QAQORDER=$O(QAQOPTN(QAQTYPE,QAQORDER)) Q:(QAQORDER'>0)!(%=-1)  F QAQFIELD=0:0 S QAQFIELD=$O(QAQOPTN(QAQTYPE,QAQORDER,QAQFIELD)) Q:(QAQFIELD'>0)!(%=-1)  D
SV . I QAQTYPE="S" W !!?3,"Ask user BEGINNING/ENDING values for ",$P(QAQMENU(QAQFIELD),"^",2) S %=2 D YN^DICN Q:%=-1  I '% W !!?5,QAQYESNO G SV
 . S X=QAQPREFX(QAQTYPE,QAQORDER)_QAQFIELD_QAQSUFFX(QAQTYPE,QAQORDER)_"^"_QAQOPTN(QAQTYPE,QAQORDER,QAQFIELD)_"^"_$S(QAQTYPE="S":(%=1),1:"")
 . S ^QA(740.1,QAQD0,"FLD",QAQORDER,0)=X,QAQFLDNO=QAQFLDNO+1
 . I QAQTYPE="S" S ^QA(740.1,QAQD0,"FLD",QAQORDER,"FRTO")=$S(%=2:QAQBEGIN(QAQORDER)_"^"_QAQEND(QAQORDER),1:"^")
 . E  K ^QA(740.1,QAQD0,"FLD",QAQORDER,"FRTO")
 . Q
 I %=-1 S DIK="^QA(740.1,",DA=QAQD0 D ^DIK S QAQMSAVE=0 W !!?3,"Sort macro ",QAQTEMP," not saved !! ",*7 R QA:QAQDTIME Q
 S $P(^QA(740.1,QAQD0,0),"^",2,4)=$TR(QAQTYPE,"SP","sp")_"^"_QAQDIC_"^"_QAQCHKSM
 S ^QA(740.1,QAQD0,"FLD",0)="^"_$P(^DD(740.1,1,0),"^",2)_"^"_QAQFLDNO_"^"_QAQFLDNO,DIK="^QA(740.1,",DA=QAQD0 D IX1^DIK
 S QAQMACRO(QAQTYPE)=QAQTEMP(QAQTYPE)
 Q
LOAD ; *** Load a sort/print macro
 S QAQMLOAD=0 I QAQSEQ>1 W !!?3,QAQTYPE(1)," macros may only be loaded at the first ",QAQTYPE(0)," selection prompt !! ",*7 R QA:QAQDTIME Q
 K DIC,QAQMACRO(QAQTYPE) S DIC(0)="AEMNQZ",DIC("A")="Load" D ASKMAC Q:Y'>0
 S (QAQQUIT,QAQNEXT)=0,QAQMLOAD=1
 F QAQORDER=0:0 S QAQORDER=$O(^QA(740.1,QAQD0,"FLD",QAQORDER)) Q:QAQORDER'>0!QAQQUIT!QAQNEXT  D
 . S X=^QA(740.1,QAQD0,"FLD",QAQORDER,0),X("FRTO")=$G(^("FRTO"))
 . S X(1)=$P($P(X,"^"),";"),QAQFIELD=$TR(X(1),"&!+#-@'")
 . S QA=$G(QAQMENU(+QAQFIELD))
 . I (QA="")!((QAQTYPE="S")&(QA'>0)) D  Q
 .. W !!?3,"Corrupted ",QAQTYPE(0)," macro !! ",*7
 .. R QA:QAQDTIME S QAQQUIT=1
 .. Q
 . S QAQOPTN(QAQTYPE,QAQSEQ,QAQFIELD)=$P(X,"^",2)
 . I QAQTYPE="S" D
 .. I $P(X,"^",3)'>0 S FR(QAQSEQ)=$P(X("FRTO"),"^"),TO(QAQSEQ)=$P(X("FRTO"),"^",2) Q
 .. W !!?3,"Sort by: ",$P(QAQMENU(QAQFIELD),"^",2)
 .. S QAQDIR(0)=$P(QAQMENU(QAQFIELD),"^",4,99) D ^QAQAHOC2
 .. Q
 . S QAQSEQ=QAQSEQ+1
 I QAQQUIT!QAQNEXT D  Q
 . S (QAQQUIT,QAQNEXT,QAQMLOAD)=0,QAQSEQ=1 K QAQCHOSN,QAQOPTN(QAQTYPE)
 . I QAQTYPE="S" K QAQBEGIN,QAQEND
 . Q
 S QAQMACRO(QAQTYPE)=QAQTEMP(QAQTYPE)
 Q
INQUIRE ; *** Inquire a sort/print macro
 K DIC S DIC(0)="AEMNQZ",DIC("A")="Inquire" D ASKMAC Q:Y'>0
INQ2 ;entry point from DISPMAC
 K QAQUNDL S $P(QAQUNDL,"_",81)="",QAQORDER=0
 S X=QAQTYPE(1)_" macro: "_QAQTEMP W !!,X,!,$E(QAQUNDL,1,$L(X))
 F QAQD1=0:0 S QAQD1=$O(^QA(740.1,QAQD0,"FLD",QAQD1)) Q:QAQD1'>0  D
 . S QA=^QA(740.1,QAQD0,"FLD",QAQD1,0),QAQ=$G(^("FRTO"))
 . S QAQORDER=QAQORDER+1,X(1)=$P(QA,"^"),QAQFIELD=$P(X(1),";")
 . S QAQFIELD=$TR(QAQFIELD,"&!+#-@'") S:QAQFIELD'?1.N QAQFIELD=0
 . F QAI=1,2 S X(QAI+1)=$S(QAQTYPE="P":"",$P(QA,"^",3):"Ask User",$P(QAQ,"^",QAI)]"":$P(QAQ,"^",QAI),QAI=1:"Beginning",1:"Ending")
 . D PS1^QAQAHOC4:QAQTYPE="S",PP1^QAQAHOC4:QAQTYPE="P"
 . Q
 R !,QA:(2*QAQDTIME)
 Q
DELETE ; *** Delete a sort/print macro
 K DIC S DIC(0)="AEMNQZ",DIC("A")="Delete" D ASKMAC Q:Y'>0
DEL W !!?3,"Delete ",QAQTEMP,", are you sure" S %=2 D YN^DICN I '% W !!?5,QAQYESNO G DEL
 I %=1 S DIK="^QA(740.1,",DA=QAQD0 D ^DIK
 Q
ASKMAC ; *** Prompt user for the name of a sort/print macro
 S DIC="^QA(740.1,",DIC("A")="   "_DIC("A")_" "_QAQTYPE(0)_" macro name: ",DLAYGO=740.1
 S DIC("S")="I $P(^(0),""^"",2,3)="""_$TR(QAQTYPE,"SP","sp")_"^"_QAQDIC_""""
 W ! D ^DIC
 I Y>0 S QAQD0=+Y,QAQTEMP=Y(0,0),QAQTEMP(QAQTYPE)=Y
 I Y>0 I "^I^D^O^"[QAQSELOP Q
 I Y>0 I $P(^QA(740.1,+Y,0),U,4)=QAQCHKSM Q  ;S QAQD0=+Y,QAQTEMP=Y(0,0),QAQTEMP(QAQTYPE)=Y Q
 I Y>0 I $P(^QA(740.1,+Y,0),U,4)'=QAQCHKSM D
 . ;if the menu for the ad hoc report has been altered, the old checksum
 . ;values in file 740.1 will not be the same as those calculated at
 . ;the beginning of ^QAQAHOC0.
 . I $P(^QA(740.1,+Y,0),U,4)']""!($G(QAQMSAVE)=1) Q  ;S QAQD0=+Y,QAQTEMP=Y(0,0),QAQTEMP(QAQTYPE)=Y Q
 . N DIRUT
 . S DIR(0)="YAO"
 . S DIR("A")="This macro is not current, would you like to review it? "
 . S DIR("B")="YES"
 . S DIR("?")="Enter 'Y' if you want to review this macro now."
 . D ^DIR I Y=0!($D(DIRUT)) S Y=0 Q
 . I Y=1 D DISPMAC
 . Q
 ;I Y'>0 Q
 Q
DISPMAC ;if user wants to review macro, display existing macro,
 ; allow user to say it's okay, then update the checksum value
 ; (set it to QAQCHKSM) or edit or start over
 D INQ2
 W !!
 S DIR(0)="NAO^1:2"
 S DIR("A")="Enter the number of your choice: "
 S DIR("A",1)="Review the menu line"_$S("Pp"[QAQTYPE:" and ",1:", ")_"field name"_$S("Pp"[QAQTYPE:".",1:" and sort range.")
 S DIR("A",2)="   Enter '1' if the macro displayed still reflects the desired report."
 S DIR("A",3)="   Enter '2'if the macro is no longer valid."
 K DIR("B")
 S DIR("?",1)="Check the display of the macro.  If it is still valid enter '1'."
 S DIR("?",2)="If the macro is no longer valid enter '2'."
 D ^DIR K DIR
 I $D(DIRUT) S Y=0 Q
 I Y=1 D UPDMAC
 I Y=2 D EDITMAC^QAQAHOC5
 Q
UPDMAC ;ask user if want to update the macro, if yes, set piece 4 of the
 ;macro's zero node to QAQCHKSM and check piece 2 of the "FLD" zero node
 N QAQEE,QAQFLD
 S DIR(0)="YOA"
 S DIR("A")="Are you ready to update the "_QAQTEMP_" macro? "
 S DIR("B")="YES"
 S DIR=("?")="Enter 'Y' if the macro is valid and ready for updating."
 D ^DIR K DIR
 I $D(DIRUT)!(Y'=1) S Y=0 W !!,"Macro '"_QAQTEMP_"' not updated.",!! R X:5 Q
 S $P(^QA(740.1,QAQD0,0),U,4)=QAQCHKSM ;update the checksum
 ;then update the macro for field, sub-field settings
 S QAQEE=0
 F  S QAQEE=$O(^QA(740.1,QAQD0,"FLD",QAQEE)) Q:QAQEE'>0  D
 . S (QAQOUT,QAQPF,QAQPF1,QAQPF2,QAQPFALL,QAQPFEND,QAQPM,QAQPFQUL,QAQPM1,QAQPM2)=""
 . S QAQFLD=$P($P(^QA(740.1,QAQD0,"FLD",QAQEE,0),U),";")
 . I "'!@#&+-"[$E($G(QAQFLD)) D STRIP^QAQAHOC5
 . ;will set several variables to compare the field setings in QAQMENU
 . ;to the field settings in the macro, disregarding qualifiers
 . ;QAQPF is the piece of the "FLD" node from file 740.1
 . ;QAQPFEND is the format part of the field from 740.1 (2nd ";" piece)
 . ;QAQPM is the is the field's piece from QAQMENU
 . ;QAQPM1 is the 1st "~" piece of the "~" character in the QAQMENU line
 . ;QAQPM2 is the 2nd "~ piece from QAQMENU
 . ;QAQPF1 is the piece of QAQPF up to any qualifiers
 . ;QAQPF2 is the piece of QAQPF after any qualifiers
 . S QAQPF=$P($P(^QA(740.1,QAQD0,"FLD",QAQEE,0),U,2),";")
 . S QAQPFEND=$P($P(^QA(740.1,QAQD0,"FLD",QAQEE,0),U,2),";",2,999)
 . S QAQPM=$P($P(QAQMENU(QAQFLD),U,3),";")
 . I $G(QAQPF)']""!($G(QAQPM)']"") S QAQOUT=1 Q
 . S QAQPM1=$P(QAQPM,"~"),QAQPM2=$P(QAQPM,"~",2)
 . D STRIP2^QAQAHOC5
 I $G(QAQOUT)=1 W !!,"Macro incomplete, cannot update."  Q
 W !!,"Macro '"_QAQTEMP_"' updated.",!!
 Q
