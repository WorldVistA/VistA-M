SRCUSS2 ;TAMPA/CFB - SCREEN SERVER ; 9 Dec 1988  11:07 AM
 ;;3.0; Surgery ;;24 Jun 93
 K Q("DRR") F Q8=1:1 S Q6=$P(DR,";",Q8) Q:Q6=""  S Q("DRR",Q6)=""
 K Q("DR") F Q8=2:1 S Q6=$P(Q0(Q,Q0(0,Q)),";",Q8) Q:Q6=""  I $D(Q("DRR",Q6)) S Q("DR",Q8-1)=Q6
 K Q("DRR")
 F Q("X")=0:0 S Q("X")=$O(Q("DR",Q("X"))) Q:Q("X")=""  S DR=Q("DR",Q("X")) D ED3
 K Q("SC"),Q("X"),Q("DR") Q
ED S DR=DR_"///"_Q8 D ^DIE,SET
ED0 S Q(1,Q)=Q("X"),DY=$P(^TMP("SRCUSS",$J,Q("X"),0),U,1)-1,DX=1 X Q("XY") W ! D A^SRCUSS Q
ED1 I $O(Q("DR",Q("X")))'="" W @IOF X Q(0) F Q6=0:0 S Q6=$O(^TMP("SRCUSS",$J,Q6)) Q:Q6=""!(Q6'=+Q6)  S:Q6>Q("X") ^TMP("SRCUSS",$J,Q6,0)=$P(^(Q6,0),U,1)+Q8 X ^TMP("SRCUSS",$J,Q6,1),^(2) ;S DY=+^(0)+1,DX=$P(^(0),U,2) X Q("XY"),^(2)
ED2 S DR=Q("DR",Q("X")),DY=22,DX=1 X Q("XY") W Q("EPE") D ^DIE W $C(13),Q("EOL") S Q("SC")="?" W @IOF,Q("EPE") X Q(0)
 W ! F Q8=1:1:^TMP("SRCUSS",$J,0) I $D(^TMP("SRCUSS",$J,Q8,1)) X ^(1) S DY=+^(0)+1,DX=$P(^(0),U,2) X Q("XY"),^(2)
 G ED0
ED3 I $D(^TMP("SRCUSS",$J,Q("X"),1)) X ^(1)
 E  Q
 I ^TMP("SRCUSS",$J,Q("X"),2)["(WORD PROCESSING)" D ED2 Q
 S @("DX(3)="_Q("BC")),DX(3)=$A(DX(3)),DX(1)=$X,DY(1)=$Y,DX=1,DY=22 X Q("XY")
 W Q("EPE"),Q("HI"),"""."" WILL ENTER THE CHARACTER UNDERNEATH, SPACE BAR ENTERS THE NEXT WORD",!," ENTER A ""E"" TO ENTER NEW TEXT AT CURSOR, RETURN TO EXIT",Q("LO") S DX=DX(1),DY=DY(1) X Q("XY")
 S (DX(0),DX(1))=$P(^TMP("SRCUSS",$J,Q("X"),0),U,2),(DY(0),DY(1))=+^(0)+1,Q6=$P($P(^(2),$C(34)_",Q(""LO""),",1),"Q(""HI""),"_$C(34),2),Q("T")=0 W Q("REV"),Q("HI")
 S Q8="" W ! D RDP,RD Q:'$T  S DX=DX(0)-1,DY=DY(0) X Q("XY") W Q("EOL"),Q("NOR"),Q("HI") K Q("SC") D:"?@"[$E(Q8,1)&(Q8'="") ED2 I '$D(Q("SC")) D ED
 Q
RD R Q7:DTIME Q:'$T  S Q7=$A(Q7) Q:((Q7=13)&('Q("T")))
 I Q8="",((Q7=63)!(Q7=64)) S Q8=$C(Q7) Q
 I Q7=DX(3),$L(Q8)>0 S Q8=$E(Q8,1,$L(Q8)-1),DX(1)=$X D RDO G RD
 I Q7=DX(3) S DX=$X+1,DY=$Y S:DX=81 DX=1,DY=DY+1 X Q("XY") G RD
 I 'Q("T"),Q7=69 S Q("T")=1,DX(2)=$E(Q6,$L(Q8)+1,999),DY(2)=$L(Q8) S DX(1)=$X-1 D RDO G RD
 I 'Q("T"),'((Q7=46)!(Q7=127)!(Q7=32)) S DX(1)=$X-1 D RDO G RD
 I Q("T")=1,Q7=13 S Q("T")=0,DX(2)="" S DX(1)=$X D RDO G RD
 I Q7=127,'Q("T") S Q6=$E(Q6,1,$L(Q8))_$E(Q6,$L(Q8)+2,999),DX=$X-1 D RDO G RD
 I Q7=127 G:$L(Q8)=DY(2) RD S Q6=$E(Q6,1,$L(Q8)-1)_$E(Q6,$L(Q8)+1,999),Q8=$E(Q8,1,$L(Q8)-1),DX(1)=$X-1 D RDO G RD
 I 'Q("T"),(Q7=46) Q:$E(Q6,$L(Q8)+1)=""  S Q8=Q8_$E(Q6,$L(Q8)+1),DX(1)=$X,DY(1)=$Y D RDP G RD
 I 'Q("T"),Q7=32 S DX(1)=$X,DY(1)=$Y,DY(3)=$F(Q6," ",$L(Q8)+2) S:DY(3)=0 DY(3)=$L(Q6)+1 S DX(1)=DX(0)+DY(3)-1,Q8=Q8_$E(Q6,$L(Q8)+1,DY(3)-1) S:DX(1)>80 DY(1)=DY(1)+DX(1)\80,DX(1)=DX(1)#80 D RDO G RD
 S Q8=Q8_$C(Q7),Q6=Q8_DX(2) S DX(1)=$X,DY(1)=$Y D RDP G RD
RDO S DY(1)=$Y S:DX(1)=0 DX(1)=80,DY(1)=DY(1)-1
RDP S:'$D(Q7) Q7=0 S DX=DX(0),DY=DY(0) X Q("XY") W Q6_$S(Q7=127:" ",1:"") S DX=DX(1),DY=DY(1) X Q("XY") Q
SET F Q8=1:1:Q S DA(Q8)=Q(9,Q)
 Q
