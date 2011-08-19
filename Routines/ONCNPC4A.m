ONCNPC4A ;HIRMFO/GWB - PCE Study of Non-Hodgkin's Lymphoma - Table IV;4/18/97
 ;;2.11;ONCOLOGY;**15,16**;Mar 07, 1995
SC W !!,"SYSTEMIC CHEMOTHERAPY"
 W !,"---------------------"
 S DR="864  SYSTEMIC CHEMOTHERAPY..........." D ^DIE G:$D(Y) JUMP
 I X=0 D  G IC
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,20)="0000000"
 .W !,"  SYSTEMIC CHEMOTHERAPY DATE......: 00/00/0000"
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,21)=88
 .W !,"  NUMBER OF PLANNED CYCLES........: NA"
 .W !!,"  AGENT ADMINISTERED DURING SYSTEMIC CHEMOTHERAPY:",!
 .W !,"    SINGLE-AGENT CHEMOTHERAPY:",!
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,22)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,23)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,24)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,25)=8
 .W !,"      CHLORAMBUCIL.....: NA   DOXORUBICIN......: NA"
 .W !,"      CYCLOPHOSPHAMIDE.: NA   FLUDARABINE......: NA"
 .W !!,"    COMBINATION CHEMOTHERAPY:",!
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,26)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,27)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,28)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,29)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,30)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,31)=8
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,32)=8
 .W !,"      CHOP.............: NA   M-BACOD..........: NA"
 .W !,"      CVP..............: NA   PRO-MACE-Cyta BOM: NA"
 .W !,"      COMLA............: NA   OTHER............: NA"
 .W !,"      MACOP-B..........: NA"
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,33)=0
 .W !!,"    HIGH DOSE W STEM CELL RESCUE..: No"
 .W ! K DIR S DIR(0)="E" D ^DIR Q:(Y=0)!(Y="")  D HEAD^ONCNPC0
 I X=9 D  G IC
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,20)="0000000"
 .W !,"  SYSTEMIC CHEMOTHERAPY DATE......: 00/00/0000"
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,21)=99
 .W !,"  NUMBER OF PLANNED CYCLES........: Unknown if chemotherapy given"
 .W !!,"  AGENT ADMINISTERED DURING SYSTEMIC CHEMOTHERAPY:",!
 .W !,"    SINGLE-AGENT CHEMOTHERAPY:",!
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,22)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,23)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,24)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,25)=9
 .W !,"      CHLORAMBUCIL.....: Unknown if given   DOXORUBICIN......: Unknown if given"
 .W !,"      CYCLOPHOSPHAMIDE.: Unknown if given   FLUDARABINE......: Unknown if given"
 .W !!,"    COMBINATION CHEMOTHERAPY:",!
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,26)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,27)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,28)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,29)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,30)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,31)=9
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,32)=9
 .W !,"      CHOP.............: Unknown if given   M-BACOD..........: Unknown if given"
 .W !,"      CVP..............: Unknown if given   PRO-MACE-Cyta BOM: Unknown if given"
 .W !,"      COMLA............: Unknown if given   OTHER............: Unknown if given"
 .W !,"      MACOP-B..........: Unknown if given"
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,33)=9
 .W !!,"    HIGH DOSE W STEM CELL RESCUE..: Unknown if given"
 .W ! K DIR S DIR(0)="E" D ^DIR Q:(Y=0)!(Y="")  D HEAD^ONCNPC0
 S DR="865  SYSTEMIC CHEMOTHERAPY DATE......" D ^DIE G:$D(Y) JUMP
 S DR="866  NUMBER OF PLANNED CYCLES........" D ^DIE G:$D(Y) JUMP
 W !!,"  AGENT ADMINISTERED DURING SYSTEMIC CHEMOTHERAPY:",!
 W !,"    SINGLE-AGENT CHEMOTHERAPY:",!
 S DR="867      CHLORAMBUCIL................" D ^DIE G:$D(Y) JUMP
 S DR="868      CYCLOPHOSPHAMIDE............" D ^DIE G:$D(Y) JUMP
 S DR="869      DOXORUBICIN................." D ^DIE G:$D(Y) JUMP
 S DR="870      FLUDARABINE................." D ^DIE G:$D(Y) JUMP
 W !!,"    COMBINATION CHEMOTHERAPY:",!
 S DR="871      CHOP........................" D ^DIE G:$D(Y) JUMP
 S DR="872      CVP........................." D ^DIE G:$D(Y) JUMP
 S DR="873      COMLA......................." D ^DIE G:$D(Y) JUMP
 S DR="874      MACOP-B....................." D ^DIE G:$D(Y) JUMP
 S DR="875      M-BACOD....................." D ^DIE G:$D(Y) JUMP
 S DR="876      PRO-MACE-Cyta BOM..........." D ^DIE G:$D(Y) JUMP
 S DR="877      OTHER......................." D ^DIE G:$D(Y) JUMP
 W !
 S DR="878  HIGH DOSE W STEM CELL RESCUE...." D ^DIE G:$D(Y) JUMP
IC W !!,"INTRATHECAL CHEMOTHERAPY"
 W !,"------------------------"
 S DR="879  INTRATHECAL CHEMOTHERAPY........" D ^DIE G:$D(Y) JUMP
 I X=0 D  G I
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,35)=7
 .W !,"  PURPOSE.........................: NA, not administered"
 I X=9 D  G I
 .S $P(^ONCO(165.5,ONCONUM,"NHL2"),U,35)=9
 .W !,"  PURPOSE.........................: Unknown if administered"
 S DR="880  PURPOSE........................." D ^DIE G:$D(Y) JUMP
I W !!,"IMMUNOTHERAPY"
 W !,"-------------"
 S DR="881  INTERLEUKIN-2 (IL-2)............" D ^DIE G:$D(Y) JUMP
 S DR="882  INTERFERON......................" D ^DIE G:$D(Y) JUMP
 S DR="883  MONOCLONAL ANTIBODIES..........." D ^DIE G:$D(Y) JUMP
 S DR="884  VACCINE THERAPY................." D ^DIE G:$D(Y) JUMP
 W ! K DIR S DIR(0)="E" D ^DIR
 Q
JUMP ;Jump to prompts
 S XX="" R !!,"GO TO: ",X:DTIME I (X="")!(X[U) S OUT="Y" G EXIT^ONCNPC4
 I X["?" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 I '$D(TABLE(X)) S XX=X,X=$O(TABLE(X)) I ($P(X,XX,1)'="")!(X="") W *7,"??" D  G JUMP
 .W !,"CHOOSE FROM:" F I=1:1:CHOICES W !,?5,HTABLE(I)
 S X=TABLE(X)
 G @X
