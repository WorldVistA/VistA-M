XMPG ;(WASH ISC)/THM/CAP-PackMan Global List/Load ;10/07/2003  12:16
 ;;8.0;MailMan;**23**;Jun 28, 2002
 ; Entry point (DBIA 10071):
 ; ENT  Load and send a packman message with globals
 ;
 ; Entry points used by MailMan options (not covered by DBIA):
 ; LOAD  XMPGLO - Load global
 ;
 ; If you D ^XMPG, you are asked for a global, and it is printed
 ; to whichever device you choose.
 S %1="W !,D,""="",@D",%2="W !,%G_I_"")="",%T"
 D ^%ZIS G K:POP
 D R
 I IO(0)'=IO U IO D ^%ZISC
 D HOME^%ZIS
 Q
R D N G R:K G K:%G="" U IO D EN G R
EN K I,R G K:%G="" S %0=0,Q=$C(34),R=1 D GP
 S D=$P(%G,"(",1) I @("$D("_D_")#2"),$L(@D) X %1
 D S Q
S S I=Q_Q
DISK S @("I=$O("_%G_I_"))") Q:I=""  S D=$D(^(I)),%0=%0+1 S:D#2 %T=^(I)
 F J=1:1:$L(I) S J=$F(I,Q,J) Q:J=0  S I=$E(I,1,J-1)_Q_$E(I,J,999)
 I I'?1.N&(I'?.N1"."1.N)!(I?1"0".1"."1.N)!(I?.N1".".N1."0") S I=""""_I_""""
 X:D#2 %2 I D>9 D PUSH S %G=%G_I_"," D S,POP
 G DISK
PUSH S R=R+1,I(R)=I,R(R)=%G Q
POP S I=I(R),%G=R(R),R=R-1 Q
K K %,%0,%1,%2,%D,%G,%GQ,%T,D,I,K,POP,Q,R
 Q
 ;
LOAD ;LOAD GLOBAL INTO MESSAGE DEFINED IN <DIE>
 S (DIE,DIF)="^XMB(3.9,XMZ,2," S:'$D(XCNP) XCNP=0 D %
L1 D N G L1:K I %G="" S @(DIE_"0)")="^^"_XCNP_U_XCNP G K
 W "   Loading..." D MOVE G L1
SET S XCNP=XCNP+1,@(DIE_XCNP_",0)")=%D Q
GP S R=1,%G=$E("^",$E(%G)'="^")_%G
 I ",("'[$E(%G,$L(%G)) S %G=%G_$E("(,",%G["("+1)
 Q
N ;GET NAME OF GLOBAL
 U IO(0) S K=0 R !,"Global: ",%G:DTIME S I=$E(%G) Q:I=""
 I I="^",I=%G S %G="" Q
 I I'?1A,I'="%" G N1
 I I'?1A,I'="%" S %G="",K=1 W !,"MUST BEGIN WITH % OR LETTER" Q
 I I="^" S %G=$E(%G,2,99)
 I $P(%G,"(")'?0.1"%".AN D N1 Q
 I $E(%G,$L(%G))=")" S %G="",K=1 W !,"DO NOT END GLOBAL REFERENCE WITH ')'" Q
 S I=$P(%G,"(",2,99) F J=1:1 Q:$P(I,",",J,99)=""  I $P(I,",",J)="" S K=1 W $C(7),!,"EACH SUBSCRIPT MUST HAVE A VALUE" Q
 F J=1:1 S I=$P($P(%G,"(",2),",",J) Q:I=""  I +I'=I S I=$S($E(I)'=$C(34):1,$E(I,$L(I))'=$C(34):2,$L(I,$C(34))-1#2:3,1:0) I I S K=1 W $C(7),!,"Invalid entry !  Please enter the EXACT values of the subscripts." Q
 Q
N1 S %G="",K=1 W !,"GLOBAL NAME MUST BEGIN WITH '%' OR LETTER" Q
 ;
ENT ;LOAD UP GLOBAL ENTRY POINT FROM OUTSIDE ROUTINES
 ; Input:
 ; DUZ    Sender's DUZ
 ; XMSUB  Message subject
 ; XMY    Recipient array
 ; XMTEXT String of open global roots separated by semicolon
 ; Output:
 ; XMZ    Message number
 ; XMMG   Error message, if error
 ; Kills:
 ; XMY
 N XMV,XMDF,XMINSTR,XMPIECE
 K XMERR,^TMP("XMERR",$J),XMMG
 S XMDF=1
 S XMINSTR("ADDR FLAGS")="R"
 D INIT^XMVVITAE
 I $D(XMV("ERROR")) D  Q
 . S XMMG=@$Q(XMV("ERROR"))
 D CRE8XMZ^XMXSEND(XMSUB,.XMZ)
 I $D(XMERR) D  Q
 . S XMMG=^TMP("XMERR",$J,1,"TEXT",1)
 . K XMERR,^TMP("XMERR",$J)
 D NEW^XMP
 D %
 S (DIE,DIF)="^XMB(3.9,XMZ,2,"
 F XMPIECE=1:1:$L(XMTEXT,";") D
 . S %G=$P(XMTEXT,";",XMPIECE)
 . Q:%G=""
 . D MOVE
 K XCNP
 D K
 Q:'$O(^XMB(3.9,XMZ,2,1))
 D ADDRNSND^XMXSEND(XMDUZ,XMZ,.XMY,.XMINSTR)
 K:$D(XMERR) XMERR,^TMP("XMERR",$J)
 K XMY
 Q
MOVE ;MOVE GLOBAL INTO MESSAGE
 S %D="$GLO "_%G D SET
 D EN S %D="$END GLO "_%G D SET
 S $P(@(DIE_"0)"),U,3,4)=XCNP_U_XCNP
 Q
% ;SET UP EXECUTABLE STRINGS
 S %1="S %D=D D SET S %D=@D D SET"
 S %2="S %D=%G_I_"")"" D SET S %D=%T D SET W:'(%0#25)&'$D(ZTQUEUED) ""."""
 Q
