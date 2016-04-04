DDBRU2 ;SFISC/DCL-BROWSE LOCAL OR GLOBAL ARRAY DDBROOT DESCENDANTS ;2AUG2004
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**139**
 ;
 Q
EN N DDBNCC G CNTNU
ROOT(DDBNCC,DDBRTOP,DDBRBOT) ; Browse Array Root Descendants ; DDBNCC node count check (default=1000)
CNTNU K ^TMP("DDBARD",$J),^TMP("DDBARDL",$J)
 ;W !!,"Enter Root> " R DDBROOT W !!
 ;I DDBROOT="^"!(DDBROOT="") Q
 D ARSEL
 I $O(^TMP("DDBARDL",$J,""))']"" Q
 N DDBARDX,N,X
 S DDBARDX="",DDBNCC=$G(DDBNCC,1000)
 F  S DDBARDX=$O(^TMP("DDBARDL",$J,DDBARDX)) Q:DDBARDX=""  S X=^(DDBARDX) D
 .S N=$O(^TMP("DDBARD",$J,""),-1)+1
 .S ^TMP("DDBARDL",$J,DDBARDX)=$NA(^TMP("DDBARD",$J,N))
 .W !,"...loading ",DDBARDX
 .D BLD(DDBNCC,X,N)
 .Q
 W !,"...building ""Current List"" tables"
 D DOCLIST^DDBR("^TMP(""DDBARDL"",$J)","",$G(DDBRTOP),$G(DDBRBOT))
END K ^TMP("DDBARD",$J),^TMP("DDBARDL",$J)
 Q
 ;
BLD(DDBNCC,DDBROOT,DDBN) ;build structures
 N DDBMAXL,DDBR1X
 S DDBMAXL=$G(DDBMAXL,255)
 S DDBNCC=$G(DDBNCC,1000)
 S DDBR1X=$$OREF^DIQGU(DDBROOT)
 N DDBR1,DDBR1A,DDBR1B,DDBR1I,DDBR1Q,DDBI,DDBII,DDBX,DDBX1,DDBX1L,DDBX2,DDBX2L,DDBX3,DDBX3L,DDBXT
 S DDBR1A=$$OREF^DIQGU($NA(@$$CREF^DIQGU(DDBR1X))),DDBR1Q=""""""
 I $L(DDBR1A,",")>1,$P(DDBR1A,",",$L(DDBR1A,","))]"" S DDBR1Q=$P(DDBR1A,",",$L(DDBR1A,",")),$P(DDBR1A,",",$L(DDBR1A,","))=""
 S DDBR1=DDBR1A_DDBR1Q_")",DDBR1B=$L(DDBR1A)+1,DDBX2=" = ",DDBX2L=$L(DDBX2),DDBII=0
 F DDBI=1:1 S DDBR1=$Q(@DDBR1) Q:$P(DDBR1,DDBR1A)]""!(DDBR1="")  D  Q:DDBII
 .I '(DDBI#DDBNCC) D
 ..W $C(7),!,DDBROOT,!,"Node count: ",DDBI,!!,"Do you wish to continue //Yes  "
 ..R DDBX:$G(DTIME,300) W !!
 ..I DDBX=""!($TR($E(DDBX),"y","Y")="Y") Q
 ..S DDBII=1
 ..Q
 .S DDBX1=DDBR1
 .S DDBX3=@DDBR1
 .S DDBX1L=$L(DDBX1),DDBX3L=$L(DDBX3)
 .S DDBXT=DDBX1L+DDBX2L+DDBX3L
 .I DDBXT'>DDBMAXL S ^TMP("DDBARD",$J,DDBN,DDBI)=DDBX1_DDBX2_DDBX3 Q
 .I DDBX1L+DDBX2L'>DDBMAXL D  Q
 ..S ^TMP("DDBARD",$J,DDBN,DDBI)=DDBX1_DDBX2_$E(DDBX3,1,DDBMAXL-(DDBX1L+DDBX2L))
 ..S DDBI=DDBI+1
 ..S ^TMP("DDBARD",$J,DDBN,DDBI)=$E(DDBX3,(DDBMAXL-(DDBX1L+DDBX2L)+1),DDBMAXL)
 ..Q
 .Q
 Q
 ;
ARSEL ; Array Root Select
 N DDBERR,DDBRLVD,X,Y
 W !!
SEL R !,"Select Root> ",X:$G(DTIME,300)
 I X="" Q
 I X="^" K ^TMP("DDBARDL",$J) Q
 I $E(X)="?" D HLP G SEL
 I X="^TMP"!(X="^TMP(")!($E(X,1,14)="^TMP(""DDBARDL""") D HLP G SEL
 S Y=$$OREF^DIQGU(X),DDBERR=0,Y=$$R(Y) I DDBERR W $C(7),"  ...INVALID",!!,"'",X,"' CAN NOT BE RESOLVED",! G SEL
 S DDBRLVD=$$CREF^DIQGU(Y)
 S Y=$$CREF^DIQGU(X)
 I $D(@Y)'>9 S Y=$X W $C(7),"  ...INVALID",!!,"'",X,"' HAS NO DESCENDANTS",! G SEL
 I DDBRLVD'=Y S X=X_" ["_DDBRLVD_"]"
 S ^TMP("DDBARDL",$J,X_" | DESCENDANTS |")=Y
 G SEL
 ;
HLP ;
 W !!,"Enter a valid local or global array root"
 W !,"Can not be ^TMP, ^TMP( or ^TMP(""DDBARDL""",!
 Q
 ;
R(%R) ;
 N %C,%F,%G,%I,%R1,%R2
 S %R1=$P(%R,"(")_"("
 I $E(%R1)="^" S %R2=$E($P(%R1,"("),2,99) D  Q:$G(DDBERR) %R
 .I $L(%R2)'>0 S DDBERR=1 Q
 .I %R2="%" Q
 .I $E(%R2)="%" D  Q
 ..I $E(%R2,2,99)?.E1P.E S DDBERR=1 Q
 ..Q
 .I %R2?1N.E S DDBERR=1 Q
 .I %R2?.E1P.E S DDBERR=1 Q
 .Q
 .;I %R2'="%"&(%R2'?.A) S DDBERR=1 Q %R
 I $E(%R1)'="^" S %R2=$P(%R1,"(") D  Q:$G(DDBERR) %R
 .I $L(%R2)'>0 S DDBERR=1 Q
 .I %R2="%" Q
 .I $E(%R2)="%" D  Q
 ..I $E(%R2,2,99)?.E1P.E S DDBERR=1 Q
 ..Q
 .I %R2?1N.E S DDBERR=1 Q
 .I %R2?.E1P.E S DDBERR=1 Q
 .Q
 .;,$E(%R1)'="%",$E(%R1)'?.A S DDBERR=1 Q %R
 I $E(%R1)="^" S %R2=$P($Q(@(%R1_""""")")),"(")_"(" S:$P(%R2,"(")]"" %R1=%R2
 S %R2=$P($E(%R,1,($L(%R)-($E(%R,$L(%R))=")"))),"(",2,99)
 S %C=$L(%R2,","),%F=1 F %I=1:1 Q:%I'<%C  S %G=$P(%R2,",",%F,%I) Q:%G=""  I ($L(%G,"(")=$L(%G,")")&($L(%G,"""")#2))!(($L(%G,"""")#2)&($E(%G)="""")&($E(%G,$L(%G))="""")) D
 .S %G=$$S(%G),$P(%R2,",",%F,%I)=%G,%F=%F+$L(%G,","),%I=%F-1,%C=%C+($L(%G,",")-1)
 .Q
 S:'DDBERR DDBERR=%F'=%C
 Q %R1_%R2
S(%Z) ;
 I $G(%Z)']"" Q ""
 I $E(%Z)'="""",$L(%Z,"E")=2,+$P(%Z,"E")=$P(%Z,"E"),+$P(%Z,"E",2)=$P(%Z,"E",2) Q +%Z
 I +%Z=%Z Q %Z
 I $E(%Z)?1N,+%Z'=%Z S DDBERR=1 Q %Z
 I %Z="""""" Q ""
 I $E(%Z)="""" Q %Z
 I $E(%Z)'?1A,"%$+@"'[$E(%Z) S DDBERR=1 Q %Z
 I "+$"[$E(%Z) X "S %Z="_%Z Q $$Q(%Z)
 I $D(@%Z) Q $$Q(@%Z)
 S DDBERR=1  ;Unable to resolve a variable within a reference
 Q %Z
Q(%Z) ;
 S %Z(%Z)="",%Z=$Q(%Z("")) Q $E(%Z,4,$L(%Z)-1)
