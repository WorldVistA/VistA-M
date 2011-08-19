XUFILE ;SF/XAK-ASSIGN, DEL FILE ACCESS; ;7/21/95  08:38
 ;;8.0;KERNEL;**1**;Jul 05, 1995
 D KIL
EN I DUZ(0)'="@",'$D(^VA(200,DUZ,"FOF")) G OUT
 D GETU G:X[U!'$D(XUSR) KIL S XUA=2 S:'$D(XUW) XUW="Add "
RD K DIR S DIR(0)="LCOA^2::5",DIR("??")="^D H1^XUFILE"
 S DIR("?",2)=$P($T(H0),";;",2),DIR("?")=" ",DIR("?",1)=$P($T(H),";;",2)
 S %=$P("^DICTIONARY^DELETE^LAYGO^READ^WRITE^AUDIT",U,XUA)
 S DIR("A")=$E("      ",1,(10-$L(%)))_XUW_%_" ACCESS to files: "
 D ^DIR I $D(DTOUT)!$D(DUOUT) G KIL
X S XUA(XUA)=Y,XUA=XUA+1 G RD:XUA<8 D QUE G KIL:%<2,GO
QUE S %=1 W !,"Would you like to Queue this Job " D YN^DICN Q:%<0  G QHP:'%
 I %=1 S ZTRTN="GO^XUFILE",ZTSAVE("XUW")="",ZTSAVE("XUA(")="",ZTSAVE("XUSR(")="",ZTDESC=XUW_"Access to Files",ZTIO="" D ^%ZTLOAD S %=1
 Q
GO ;
 K ^TMP($J) G DQ:XUW["Copy" S XUW=$S(XUW["Del":"",1:1)
 F I=2:1:7 S XUA=XUA(I) F %=1:1 S J=$P(XUA,",",%) Q:J=""  S K=$P(J,"-",2),J=$S(J<.19:.2,1:J) S:K="" K=J D L:DUZ(0)'="@",LAT:DUZ(0)="@"
 F I=0:0 S I=$O(XUSR(I)) Q:I'>0  S:'$D(^VA(200,I,"FOF",0)) ^(0)="^200.032P^^" D S S DA(1)=I,DIK="^VA(200,"_I_",""FOF""," D IXALL^DIK
 I $D(ZTSK) S ZTREQ="@"
KIL K P,X,Y,XUA,DIC,DA,DIK,XUSR,XUW,^TMP($J),DIR,DIRUT,DTOUT,DUOUT
 K %,%T,%X,%Y,I,J,K,%DT,B,DCC,DIPT,DISYS,F,FLDS,L,W,X1,ZISI
 K %H,DIJ,DP,ZTSK,%ZISI Q
L F J=J-.000001:0 S J=$O(^VA(200,DUZ,"FOF",J)) Q:J'>0!(J>K)  I $D(^(J,0))#2,$P(^(0),U,I),$D(^DIC(J,0)) S ^TMP($J,J,1)=J,^(I)=XUW
 Q
LAT F J=J-.000001:0 S J=$O(^DIC(J)) Q:J'>0!(J>K)  I $D(^DIC(J,0)) S ^TMP($J,J,1)=J,^(I)=XUW
 Q
S F J=0:0 S J=$O(^TMP($J,J)) Q:J'>0  S X=$S($D(^VA(200,I,"FOF",J,0)):^(0),1:J) F K=1:0 S K=$O(^TMP($J,J,K)) S:K>0 $P(X,U,K)=^(K) I K'>0 D SD Q
 Q
SD I $P(X,U,2,7)'?1.6"^" S ^VA(200,I,"FOF",J,0)=X Q
 S DA(1)=I,DA=J,DIK="^VA(200,"_I_",""FOF""," D ^DIK
 Q
GETU ;
 S DIC="^VA(200,",DIC(0)="AEMQ",DIC("S")="I $S($P(^(0),U,11):$P(^(0),U,11)>DT,1:1),$P(^(0),U,3)]"""""
 F I=0:0 D ^DIC Q:Y'>0  S XUSR(+Y)="",DIC("A")="Select ANOTHER USER: "
 K DIC Q
 ;
OUT W !?5,"You do not have the correct access to run this option."
 W !?5,"Please contact your site manager for help." Q
 ;
H ;;Answer with a File Number, a List, or a Range of Files.
H0 ;;For example:  2 or 50-59 or 33,42-61,88,220-240.
 ;
H1 I DUZ(0)'="@" S DIC="^VA(200,DUZ,""FOF"",",DIC(0)="NEQ",DIC("S")="I $P(^(0),U,XUA)"
 E  S DIC="^DIC(",DIC(0)="EQ",DIC("S")="I Y>.19"_$S(XUA=6:",Y-1,Y-1.1",XUA=5:"",1:",Y>1.1")
 S D="B",DZ=X D DQ^DICQ K DIC,DO,DIX,DIY,DZ
 Q
QHP W !!?5,"This could take some time to run depending on the number of"
 W !?5,"files and users selected.  It is definitely best to QUEUE the job." G QUE
 ;
XUDEL D KIL S XUW="Delete " G EN
COPY ;
 S DIC("A")="Select USER whose Access you want to copy: "
 S DIC("S")="I $O(^VA(200,Y,""FOF"",0))>0"
 S DIC=200,DIC(0)="QEAM" D ^DIC G KIL:Y<0 S XUSR(0)=+Y K DIC
 S DIC("A")="Select USER to receive Access: "
 D GETU G KIL:$O(XUSR(0))'>0!(X[U) S XUW="Copy " D QUE G KIL:%<2
DQ S %X="^VA(200,"_XUSR(0)_",""FOF"","
 F I=0:0 S I=$O(XUSR(I)) Q:I'>0  S %Y="^VA(200,"_I_",""FOF""," D %XY^%RCR S DA(1)=I,DIK=%Y D IXALL^DIK
 G KIL
