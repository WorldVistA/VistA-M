XTLKPRT ;ALB/JLU,SFISC/JC;PRINT ROUTINE ;07/22/93  15:49
 ;;7.3;TOOLKIT;;Apr 25, 1995
KL K DIC,XTLKY,XTLKPF,XTLKUTL,FLDS,BY,DIS,L,JL,JLF,DIR,X,Y,XTLKOPP,JLY,XTLKUT,DHD
 Q
 ;
A ;ENTRY POINT
 S DIR(0)="S^SH:Shortcuts;KE:Keyword;SY:Synonyms",DIR("A")="      Print which file?" D ^DIR K DIR
 S XTLKOPP=$S(Y["SH":"Shortcuts",Y["KE":"Keywords",1:"Synonyms")
 I Y="^"!(Y="") D KL Q
 S JLF=Y
 ;
SB I Y'="SY" S DIR(0)="S^A:Alphabetic;C:Code",DIR("A")="      Sort By?" D ^DIR I Y="^"!(Y="") D KL Q
 S JLY=Y
 ;
 D QU^XTLKEFOP() I '$D(XTLKY) D KL Q
 S JL=$P(^DIC(+XTLKY,0,"GL"),U,2)
 S DHD=$S(JLF="SH":"Shortcuts",JLF="SY":"Synonyms",1:"Keywords")_" of the "_$P(^DIC(+XTLKY,0),U)_" file"_$S(JLY="A":" sorted by Name.",JLY="C":" sorted by Code.",1:".")
 S L=0 D @JLF,KL G A
 ;
SH S DIC="^XT(8984.2,",(FLDS,BY)=$S(JLY="A":"[XTLK SHORT ALPHA]",1:"[XTLK SHORT CODE]"),DIS(0)="I $P(^XT(8984.2,D0,0),U,2)[JL" D EN1^DIP
 Q
 ;
KE S (FR,TO)=+XTLKY,DIC="^XT(8984.1,",(FLDS,BY)=$S(JLY="A":"[XTLK KEYWORD ALPHA]",1:"[XTLK KEYWORD CODES]"),DIS(0)="I $P(^XT(8984.1,D0,0),U,2)[JL" D EN1^DIP
 Q
 ;
SY S DIC="^XT(8984.3,",(FLDS,BY)="[XTLK SYNONYM ALPHA]",DIS(0)="I $P(^XT(8984.3,D0,0),U,2)="_+XTLKY D EN1^DIP
 Q
