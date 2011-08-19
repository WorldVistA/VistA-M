XTLKDICL ; IHS/ACC,ALB/JLU,SFISC/JC ;10/11/94  14:42
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;Bypass special lookup if XTLKUT exists or DIC(0)["I"
 I $D(XTLKUT) S:DIC(0)'["I" DIC(0)=DIC(0)_"I" G:$G(DIPGM(0))=2 RTN^DIC D ^DIC Q
 S:'$D(X) X=""
 I X?1"?".E S X="~"_X
 G:DIPGM(0)=2 EN2
EN1 ; FIRST ENTRY FROM DIC
 K HITLIMIT
 G:DIC(0)["A" ASK^DIC
EN2 ; SECOND ENTRY FROM DIC OR FALL-THROUGH IF NO 'ASK' INDICATED
 I X="?BAD"!(X["^") S Y=-1 Q
 ;Precede entry with "`" to 'force' lookup by IEN
 I X?1"`"1N.N!(U[X)!(X?1N.N)!(X?.N1".".N) D:'$D(D0(2)) DO^DIC1 G RTN^DIC
 ;Precede entry with "~" to 'force' lookup by ALL X-REF'S
 I X?1"~".E S X=$E(X,2,99) D:'$D(D0(2)) DO^DIC1 G RTN^DIC
 ;Setting up var, from old xtlkkwld routine
TS D DO^DIC1 I $D(DO(2)),'$D(^XT(8984.4,+DO(2),0)) W $C(7),!!,"'",$P(DO,U),"' is not in the 'Local Lookup Files' file. Unable to use lookup." S Y=-1 Q
 S XTLKX=X K XTLKKSCH S XTLKKSCH("GBL")=DIC,XTLKKSCH("INDEX")=$P(^XT(8984.4,+DO(2),0),U,3)
 S XTLKKSCH("DSPLY")=$S('$D(^XT(8984.4,+DO(2),1)):"DGEN^XTLKKWLD",$L(^(1))=0:"DGEN^XTLKKWLD",1:^(1))
 I $D(DIC(0)),DIC(0)["A" W !
 S X=XTLKX,XTLKX="" F XTLKPC=1:1 S XTLKC=$E(X,XTLKPC) Q:XTLKC=""  S:XTLKC?1L XTLKC=$C($A(XTLKC)-32) S XTLKX=XTLKX_XTLKC
 K XTLKC
 D ^XTLKKWL
 Q:$D(DIROUT)!($D(DTOUT))
 I +Y=-1 S X="~"_X W !,"Attempting FILEMAN lookup..." G EN2
 Q
