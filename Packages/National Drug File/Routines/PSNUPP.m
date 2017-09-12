PSNUPP ;BIR/DMA-post install to load entries in NDF ; 16 Oct 97 / 9:27 AM [ 06/11/98  3:18 PM ]
 ;;3.18; NATIONAL DRUG FILE;**3**;12 Jan 98
 ;
 N ROOT,I,J,X,LINE,TOT,CT,PCT,XPDITOT
 S ROOT=$NA(@XPDGREF@("DATA")),TOT=@XPDGREF@("TOT"),XPDITOT=TOT,CT=0,PCT=.05
 D BMES^XPDUTL("Now updating entries in the National Drug File.")
 F J=1:1 Q:'$D(@ROOT@(J))  S LINE=^(J) F I=1:1:$L(LINE,"|")-1 S X=$P(LINE,"|",I),$P(^PSNDF($P(X,"^"),5,$P(X,"^",2),0),"^",7,8)=$P(X,"^",3,4),CT=CT+1 I CT/TOT'<PCT D UPDATE^XPDID(CT) S PCT=PCT+.05
 ;
 Q
