XUINCON ;SF/XAK - BUILDS ACCESSIBLE FILE MULTIPLE ;2/9/95  09:44
 ;;8.0;KERNEL;;Jul 10, 1995
 G A:'$D(^VA(200,"AFOF")) W !,"You currently have the 'AFOF' X-ref that shows you are",!,"using the accessible file."
 W !,"If you need to re-run the conversion please kill the '^VA(200,""AFOF"")' X-ref first." Q
A W !!,"Version 7 of the Kernel defined a new multiple-valued field"
 W !,"in the New Person File called Accessible File.  This conversion"
 W !,"will store file access in this multiple in the following manner:"
 W !!,"Those Users who have a FileMan Access Code (DUZ(0)) which"
 W !,"is not null, i.e., contains some character string,"
 W !,"will have their access string matched to the protection"
 W !,"currently on your files.  For each match between the file"
 W !,"and the user, the file will be listed in the user's"
 W !,"Accessible File multiple as will the type of access"
 W !,"(dictionary, delete, laygo, read, write, audit)."
 W !!,"NOTE: Files with no protection will NOT be assigned to any user.",!
AGN S %=2,U="^" W !!,"Would you like to run the conversion now " D YN^DICN
 G GO:%=1 I %=2!(%<0) W !!,"To run this conversion, D ^XUINCON." G KIL
 W !!,"If you are uncertain about your current file protection, it would"
 W !,"be wiser to examine them before running this."
 W !,"If you are not on the CPU which holds the user file, it would"
 W !,"be better to run this conversion on that CPU."
 W !,"If you are short for time, it would be wiser to run this later."
 G AGN
GO W !,$H,!,"Build table." I '$D(DT) S DT=$$HTFM^XLFDT($H)\1
 K ^TMP($J) S X="DD^DEL^LAYGO^RD^WR^$$$" K XU
 F I=1.99:0 S I=$O(^DIC(I)) Q:I'>0  F J=1:1:6 I $D(^DIC(I,0,$P(X,U,J))),"@"'[^($P(X,U,J)) S %=^($P(X,U,J)) F K=1:1:$L(%) S ^TMP($J,$E(%,K),I,J+1)=""
 W !,"Convert Users."
 F I=0:0 S I=$O(^VA(200,I)) Q:I'>0  S X=$G(^(I,0)),%=$P(X,U,11) I $S(%:%'<DT,1:1),$P(X,U,3)]"",$P(X,U,4)]"" S %=$P(X,U,4) D CHECK:%'="@"
 D DISV,XREF W !,"Done",$H
KIL K ^TMP($J),I,J,K Q
 ;
CHECK ;
 F J=1:1:$L(%) F K=0:0 S K=$O(^TMP($J,$E(%,J),K)) Q:K'>0  F L=0:0 S L=$O(^TMP($J,$E(%,J),K,L)) Q:L'>0  S $P(^VA(200,I,"FOF",K,0),U,L)=1,$P(^(0),U)=K
 Q
DISV ;
 W !,"Give access from DISV file."
 F I=.5:0 S I=$O(^DISV(I)) Q:+I'=I  I $D(^VA(200,I,0)),'$P(^(0),U,11),$P(^(0),U,3)]"",$P(^(0),U,4)'="@" S X="" D D1
 Q
D1 ;
 F J=0:0 S X=$O(^DISV(I,X)) Q:X=""  I $E(X)=U,"(,"[$E(X,$L(X)),$L(X,",")<3,X'?1"^DD".E,X'="^DIC(",X'?1"^DOPT".E,$D(@(X_"0)")) S J=+$P(^(0),U,2) I J'<2,'$D(^VA(200,I,"FOF",J,0)) S ^(0)=J_"^^^^1^"_0 ;(J'=3)
 Q
XREF W !,"X-ref."
 F I=0:0 S I=$O(^VA(200,I)) Q:I'>0  S K=0,%=0 D
 . F J=0:0 S J=$O(^VA(200,I,"FOF",J)) Q:J'>0  S %=J,K=K+1,^VA(200,I,"FOF","B",J,J)="",^VA(200,"AFOF",J,I,J)=""
 . S ^VA(200,I,"FOF",0)="^200.032PA^"_%_U_K
 . Q
 Q
 Q
