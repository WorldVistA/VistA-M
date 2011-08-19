SRCUSS3 ;TAMPA/CFB - SCREEN SERVER ; 9 Jan 1989  7:35 AM;
 ;;3.0; Surgery ;;24 Jun 93
1 S X="IOINHI;IOINLOW;IORVON;IORVOFF;IOEDEOP;IOELEOL" D ENDR^%ZISS
 K Q S Q("TEM")=1,(Q,Q(1,1),Q0(0,1),Q("ED"))=1,Q(1,2)=0,Q(0,1)=$P(Q1,";",2) G BQ^SRCUSS1:'$D(^DIC(Q(0,1),0,"GL")) S Q(8,1)=^DIC(Q(0,1),0,"GL")
 S:'$D(Q3(Q)) @("Q3(Q)=$P("_Q(8,1)_"0),U,1)") S:$P(Q6,U,2)'="" Q3(Q)=$E(Q3(Q)_"  ("_$P(Q6,U,2)_")",1,60) S (DA(1),Q(9,1))=DA,Q(8)=DA,Q(1)=""
 S Q(12,5)=Q7 D PAGE^SRCUSS4
 S Q("HI")=IOINHI,Q("LO")=IOINLOW
 I Q("ED") S Q(7)=IOST(0)
 I $T,+Q(7),IOBS'="",IOXY'="",IORVON'="",IORVOFF'="",IOEDEOP'=""
 I  S Q("BC")=IOBS,Q("XY")=IOXY_" "_^%ZOSF("XY"),Q("REV")=IORVON,Q("NOR")=IORVOFF,Q("EPE")=IOEDEOP
 I $T,IOELEOL'="" S Q("EOL")=IOELEOL
 I $T,'$D(Q3("VIEW")),$S('$D(Q3("FORMAT")):1,'Q3("FORMAT"):0,1:1) S:'$D(Q3("FORMAT")) Q3("FORMAT")=0 S Q("Q")=0 I Q3("FORMAT")
 E  S Q("ED")=0,Q("XY")="Q",(Q("REV"),Q("EPE"),Q("EOL"))="*0" S:'$D(Q("NOR")) Q("NOR")="*0"
 D KILL^%ZISS
 S Q(0)="K:'$D(Q(""SC"")) ^TMP(""SRCUSS"",$J) W @IOF S DY=1,DX=1 X Q(""XY"") F Q(0,""I"")=1:1:Q W Q(""HI""),?(8+(Q(0,""I"")*2)),Q3(Q(0,""I"")),Q(""LO"") W:Q(0,""I"")=1 Q(""HI""),?65,Q(""LO""),""PAGE "",Q0(0,Q) X Q(0,0) W !"
 S Q(0,0)="W:Q(0,""I"")=1&$D(Q(""P"",Q)) "" OF "",Q(""P"",Q)"
 S Q(13)=1 D RT X Q(0) Q
IX X Q("S",Q,"IX") Q
START ;
 S:'$D(Q6) Q6="" I '$D(DA) W @IOF K DIC("V") D ^DIC K DIC("S") Q:Y<1  S DA=+Y I '$D(DIE)#2 S DIE=DIC
 I DIE'?1N.PN,$D(@(DIE_"0)")) S DIE=+$P(^(0),"^",2)
 I '$D(^DD(DIE)) W "  ?" Q
 S Q1=";"_DIE_";"_DR,Q7="DR" Q
STOP S Q6=$S($D(Y)#2:Y,1:"") S:'$D(DIE) DIE=DIC I $E(DR)="[" S Q(1)=$E(DR,2,99),Q(1)=$P(Q(1),"]",1) I $O(^DIE("B",Q(1),0))>0 S Q(0)="^DIE("_($O(^(0)))_","
 E  S Q(0)="DR(",Q1=DIE_";"_DR
 S Q(2)=1,Q(4,1)="",Q(3,Q(2))="Q(4,1)"
2 S Q(4,Q(2))=$O(@(Q(0)_Q(3,Q(2))_")")) G 3:Q(4,Q(2))="" S Q(5)=$D(@(Q(0)_Q(3,Q(2))_")")) Q:Q(4,1)=""
 I Q(5)#2,@(Q(0)_Q(3,Q(2))_")")["S Y=" S Q("DIE")="" Q
 I $O(@(Q(0)_Q(3,Q(2))_","""")"))'="" S Q(2)=Q(2)+1,Q(4,Q(2))="",Q(3,Q(2))=Q(3,Q(2)-1)_",Q(4,"_Q(2)_")"
 G 2
3 S Q(2)=Q(2)-1 Q:Q(2)=0  G 2
 Q
OUTED ;
 S ^TMP("SRCUSS",$J,Q(1,Q)-1,1)="S DY=$S($D(^TMP(""SRCUSS"",$J,"_(Q(1,Q)-1)_",0)):$P(^(0),U,1),1:$Y),DX=1 X Q(""XY"") W !,Q(""HI""),"_(Q(1,Q)-1)_",?6,Q(""LO""),"_$C(34)_$P(Q(3),U,1)_$C(34)_","": "",?30"
 S:'$D(^TMP("SRCUSS",$J,Q(1,Q)-1,2)) ^TMP("SRCUSS",$J,0)=Q(1,Q)-1
 I $D(Q(11)) K:'$D(Q(10)) Q(11)
 S ^TMP("SRCUSS",$J,Q(1,Q)-1,2)="S DX=$P(^(0),U,2),DY=+^(0)+1 X Q(""XY"") W Q(""HI"")"_","_$S($E(Q(7),1)=$C(34):$C(34),1:"")_$C(34)_Q(7)_$S($E(Q(7),$L(Q(7)))=$C(34):$C(34),1:"")_$C(34)_",Q(""LO""),Q(""EOL"")"
 W @$P(^TMP("SRCUSS",$J,Q(1,Q)-1,1)," W ",2) S ^(0)=($Y-1)_U_$X X ^(2) Q
RT ; stop RT logging
 I $D(XRT0) S:'$D(XRTN) XRTN="SRCUSS" D T1^%ZOSV
 Q
