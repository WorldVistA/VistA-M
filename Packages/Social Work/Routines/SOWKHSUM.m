SOWKHSUM ; B'ham ISC/DMA - health summary ; [ 06/17/96  10:00 AM ]
 ;;3.0; Social Work ;**44**;27 Apr 93
 ;;
 ;Called with DFN - assumed to be valid
 ;returns parts V. VII. and VIII. of the assessment
 ;in ^TMP("SOWK",$J,line number)
 ;
 N LINE,SP15,MS,SP,SOWKJ,J,C,Y,X,SO,SP10,SZ,D,DIWL,DIWF
 K ^TMP("SOWK",$J) Q:'$D(^SOWK(655.2,DFN,0))  S LINE=6,$P(SP15," ",15)="",SP10=$E(SP15,1,10)
 S MS=$P($G(^DIC(11,+$P(^DPT(DFN,0),"^",5),0)),"^")
 S ^TMP("SOWK",$J,1)="Source of Referral: "_$P(^SOWK(655.2,DFN,0),"^",21)
 S ^TMP("SOWK",$J,2)="Source of Information: "_$S($D(^SOWK(655.2,DFN,18)):$P(^(18),"^"),1:"UNSPECIFIED")
 S ^TMP("SOWK",$J,3)="Social/Family Relationship:",^(4)="     1.  Marital status: "_MS,^(5)="     2.  Spouse:"
 S SP=$G(^SOWK(655.2,DFN,6))
 F J=1:1:4 I $P(SP,"^",J)]"" S ^TMP("SOWK",$J,LINE)=SP15_$P(SP,"^",J),LINE=LINE+1
 I $P(SP,"^",5)]"" S SZ=$P(^DIC(5,+$P(SP,"^",5),0),"^")_"     "_$P(SP,"^",6),^(LINE-1)=^TMP("SOWK",$J,LINE-1)_",    "_SZ
 S ^TMP("SOWK",$J,LINE)="     3.  Children:",LINE=LINE+1
 F SOWKJ=0:0 S SOWKJ=$O(^SOWK(655.2,DFN,7,SOWKJ)) Q:'SOWKJ  S X=^(SOWKJ,0),D=$P(X,"^",2),^TMP("SOWK",$J,LINE)=$$LJ^XLFSTR(SP15_$P(X,"^"),50," ")_"Age: "_($E(DT,1,3)-$E(D,1,3)-($E(D,4,7)>$E(DT,4,7))),LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="     4.  Describe Social Support System:",LINE=LINE+1
 K ^UTILITY($J,"W") S DIWL=0,DIWF="C60" F SOWKJ=0:0 S SOWKJ=$O(^SOWK(655.2,DFN,13,SOWKJ)) Q:'SOWKJ  S X=^(SOWKJ,0) D ^DIWP
 F J=0:0 S J=$O(^UTILITY($J,"W",0,J)) Q:'J  S X=^(J,0),^TMP("SOWK",$J,LINE)=SP10_X,LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="     5.  Present Use of Community Resources:",LINE=LINE+1
 K ^UTILITY($J,"W") F SOWKJ=0:0 S SOWKJ=$O(^SOWK(655.2,DFN,14,SOWKJ)) Q:'SOWKJ  S X=^(SOWKJ,0) D ^DIWP
 F J=0:0 S J=$O(^UTILITY($J,"W",0,J)) Q:'J  S X=^(J,0),^TMP("SOWK",$J,LINE)=SP10_X,LINE=LINE+1
 S Y=$P(^SOWK(655.2,DFN,0),"^",15),C=$P(^DD(655.2,15,0),"^",2) D Y^DIQ S:Y="" Y="UNSPECIFIED"
 S ^TMP("SOWK",$J,LINE)="     6.  Current Living Arrangements:    "_Y,LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="     7.  Social/Family Assessment:",LINE=LINE+1
 K ^UTILITY($J,"W") F SOWKJ=0:0 S SOWKJ=$O(^SOWK(655.2,DFN,16,SOWKJ)) Q:'SOWKJ  S X=^(SOWKJ,0) D ^DIWP
 F J=0:0 S J=$O(^UTILITY($J,"W",0,J)) Q:'J  S X=^(J,0),^TMP("SOWK",$J,LINE)=SP10_X,LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="",LINE=LINE+1
 S SO=$P(^SOWK(655.2,DFN,0),"^",25),SO=$S(SO=1:"YES",SO=2:"NO",1:"UNKNOWN"),^TMP("SOWK",$J,LINE)="Current Substance Problems: "_SO,LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="",LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="      Comments on Substance Abuse :",LINE=LINE+1
 K ^UTILITY($J,"W") F SOWKJ=0:0 S SOWKJ=$O(^SOWK(655.2,DFN,8,SOWKJ)) Q:'SOWKJ  S X=^(SOWKJ,0) D ^DIWP
 F J=0:0 S J=$O(^UTILITY($J,"W",0,J)) Q:'J  S X=^(J,0),^TMP("SOWK",$J,LINE)=SP10_X,LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="",LINE=LINE+1
 S ^TMP("SOWK",$J,LINE)="Psycho-Social Assessment:",LINE=LINE+1
 K ^UTILITY($J,"W") F SOWKJ=0:0 S SOWKJ=$O(^SOWK(655.2,DFN,19,SOWKJ)) Q:'SOWKJ  S X=^(SOWKJ,0) D ^DIWP
 F J=0:0 S J=$O(^UTILITY($J,"W",0,J)) Q:'J  S X=^(J,0),^TMP("SOWK",$J,LINE)=SP10_X,LINE=LINE+1
 K ^UTILITY($J,"W")
