DIRCR ;SFISC/GFT-DELETE THIS LINE AND SAVE AS '%RCR'*** ;12:18 PM  20 Apr 1993
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
%RCR ;GFT/SF
 ;
STORLIST ;
 D INIT
O S %D=$O(%RCR(%D)) G CALL:%D=""
 I $D(@%D)#2 S @(%E_")="_%D) G O:$D(@%D)=1
 S %X=%D_"(" D %XY G O
 ;
CALL S %E=%RCR K %RCR,%X,%Y D @%E
 S %E="^UTILITY(""%RCR"",$J,"_^UTILITY("%RCR",$J)_",%D",^($J)=^($J)-1,%D=0,%X=%E_","
G S %D=$O(@(%E_")")) I %D="" K %D,%E,%X,%Y,^($J,^UTILITY("%RCR",$J)+1) Q
 I $D(^(%D))#2 S @%D=^(%D) G G:$D(^(%D))=1
 S %Y=%D_"(" D %XY G G
 ;
 ;
XY(%X,%Y) ;
%XY ;
 N %A,%B,%Q,%Z
 S %A=$$R(%X),%Q=""""""
 I $P(%A,"(",2)]"",$E(%A,$L(%A))'="," S:$L($P(%A,"(",2),",")>1 %Q=$P(%A,",",$L(%A,",")),$P(%A,",",$L(%A,","))="" S:%Q="""""" %Q=$P(%A,"(",2),$P(%A,"(",2)=""
 S %Z=%A_%Q_")",%B=$L(%A)+1
 F  S %Z=$Q(@%Z) Q:$P(%Z,%A)]""!(%Z="")  S @(%Y_$E(%Z,%B,255))=@%Z
 Q
R(%R) ;
 N %C,%F,%G,%I,%R1,%R2
 S %R1=$P(%R,"(")_"(" I $E(%R1)="^" S %R2=$P($Q(@(%R1_""""")")),"(")_"(" S:$P(%R2,"(")]"" %R1=%R2
 S %R2=$P($E(%R,1,($L(%R)-($E(%R,$L(%R))=")"))),"(",2,99)
 S %C=$L(%R2,","),%F=1 F %I=1:1:%C S %G=$P(%R2,",",%F,%I) Q:%G=""  I ($L(%G,"(")=$L(%G,")")&($L(%G,"""")#2))!(($L(%G,"""")#2)&($E(%G)="""")&($E(%G,$L(%G))="""")) S %G=$$S(%G),$P(%R2,",",%F,%I)=%G,%F=%F+$L(%G,","),%I=%F-1
 Q %R1_%R2
S(%Z) ;
 I $G(%Z)']"" Q ""
 I $E(%Z)'="""",$L(%Z,"E")=2,+$P(%Z,"E")=$P(%Z,"E"),+$P(%Z,"E",2)=$P(%Z,"E",2) Q +%Z
 I +%Z=%Z Q %Z
 I %Z="""""" Q ""
 I $E(%Z)'?1A,"%$+@"'[$E(%Z) Q %Z
 I "+$"[$E(%Z) X "S %Z="_%Z Q $$Q(%Z)
 I $D(@%Z) Q $$Q(@%Z)
 Q %Z
Q(%Z) ;
 S %Z(%Z)="",%Z=$Q(%Z("")) Q $E(%Z,4,$L(%Z)-1)
 ;
INIT I $D(^UTILITY("%RCR",$J))[0 S ^UTILITY("%RCR",$J)=0
 S ^($J)=^($J)+1,%D="%Z",%E="^UTILITY(""%RCR"",$J,"_^($J)_",%D",%Y=%E_","
 K ^($J,^($J))
 Q
OS ;
 S $P(^%ZOSF("OS"),"^",2)=DITZS
 K DITZS S ZTREQ="@"
 Q
