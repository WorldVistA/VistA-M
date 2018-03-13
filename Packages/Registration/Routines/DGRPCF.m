DGRPCF ;ALB/MRL,BAJ,TDM,DJE - CONSISTENCY OF PATIENT DATA (FILE/EDIT) ;Sep 28, 2017  5:35PM
 ;;5.3;Registration;**250,653,786,754,867,935**;Aug 13, 1993;Build 53
 ;
 ; file new inconsistencies or update file entries for patient
 ;
 ; DGCT = count of inconsistencies found (passed in from checker)
 ; DGCT1= count of inconsistencies which can't be edited because
 ;        user does not hold appropriate key
 ; DGCT2= count of already filed inconsistencies
 ; DGCT3= count of inconsistencies which are uneditable through
 ;        checker options
 ; DGCTZ7= count of inconsistencies found that will prevent Z07
 ;
 ;
 ; 
EN I '$D(DGCT) G KVAR^DGRPCE
 ; DG*5.3*653 BAJ modified to delete only inconsistencies numbered 99 or less
 N DGADD S DGADD=0 ;786 corrects problem with incorrect header
 ;I 'DGCT,$O(^DGIN(38.5,DFN,"I",""),-1)>99 D DELETE G KVAR^DGRPCE
 I 'DGCT D DELETE G KVAR^DGRPCE
 S DGEDCN=+$G(DGEDCN),DGRPOUT=+$G(DGRPOUT),DGCON=1 D:DGEDCN START^DGRPC I 'DGCT D ^DGRPCF1,TIMEQ^DGRPC G KVAR^DGRPCE
 S:'$D(^DGIN(38.5,DFN,0)) ^(0)=DFN_"^"_DT_"^"_$S(('$D(DUZ)#2):"",1:DUZ),DGADD=1 S X=$P(^(0),"^",4),^DGIN(38.5,DFN,0)=$P(^(0),"^",1,3)_"^"_DT_"^"_$S(('$D(DUZ)#2):"",1:DUZ)_"^"_$P(^(0),"^",6) K ^DGIN(38.5,"AC",9999999-X,DFN)
 S ^DGIN(38.5,"B",DFN,DFN)="",^DGIN(38.5,"AC",9999999-DT,DFN)="",^DGIN(38.5,0)=$P(^DGIN(38.5,0),"^",1,2)_"^"_DFN_"^"_($P(^(0),"^",4)+DGADD) ;786 corrected for incorrect header
 I $D(^DGIN(38.5,DFN,"I")) D DELETE
 S DGD2=0 F DGD=1:1 S DGD1=$P(DGER,",",DGD) Q:DGD1=""  I $D(^DGIN(38.6,DGD1,0)) S DGD2=DGD1 S ^DGIN(38.5,DFN,"I",DGD1,0)=DGD1
 S ^DGIN(38.5,DFN,"I",0)="^38.51PA^"_DGD2_"^"_DGCT I DGCT,DGEDCN G DIS
 G KVAR^DGRPCE
 ;
 ;DJE DG*5.3*935 - Add Member ID To Vista Registration Banner - RM#879322 (added SSNNM call)
DIS D TIME^DGRPC S DGRPE=$S($D(DGRPE):DGRPE+1,1:0) D KEY S IOP="HOME" D ^%ZIS K IOP W @IOF,! D DEM^VADPT W $$SSNNM^DGRPU(DFN),?65,$P(VADM(3),"^",2) S X="",$P(X,"=",79)="" W !,X
 S (C,DGCT1,DGCT2,DGCT3,DGCTZ7)=0,DGEDIT="0000000011111110011111113333222223313333332222220030000" F I=1:1 S J=$P(DGER,",",I) Q:J=""  I $D(^DGIN(38.6,J,0)) S X2=$P(^(0),"^",1) D WRIT
 I DGCT1!DGCT3 W ! D NOEDIT
 I DGCTZ7 W !!,"Inconsistencies followed by [+] will prevent a Z07"
 S DGINC55=$S(DGER'[55:0,($G(DGRPVV(9))'["0"):0,1:1)
EDIT G:DGRPOUT BUL I DGCT1+DGCT3'=DGCT W !!,"DO YOU WANT TO UPDATE THESE INCONSISTENCIES NOW" S %=1 D YN^DICN I %=1 D  G ^DGRPC
 . S DGINC55=$S(DGER'[55:0,($G(DGRPVV(9))'["0"):0,1:1)
 . L +^DPT(DFN):3 E  W *7,!!,"Patient is being edited. Try again later."  S DGEDCN=0 Q
 . D ^DGRPCE
 . L -^DPT(DFN)
 . S DGEDCN=1
 I $S(($G(DGRETURN)>10):0,$G(DGINC55):1,1:0) D
 .N DIR
 .S DIR(0)="Y",DIR("A")="Do you wish to return to Screen #9 to enter missing Income Data? ",DIR("B")="YES" D ^DIR
 .S:Y>0 DGRPV=0
 .S:Y>0 DGRETURN=$G(DGRETURN)+1
 I $S($G(Y)'>0:0,(DGRETURN>11):0,1:1) D ^DGRPV G ^DGRP9
 I DGCT1+DGCT3'=DGCT,'% W !!?4,"YES - To correct inconsistencies to unrestricted fields immediately.",!?4,"NO  - To abort this process immediately." G EDIT
 I DGER[313 D
 . N DIR
 . S DIR(0)="Y",DIR("A")="Do you wish to return to Screen #15 to enter Sponsor information? ",DIR("B")="YES" D ^DIR
 . S:Y>0 DGRPV=0
 . S:Y>0 DGRETURN=$G(DGRETURN)+1
 I $G(Y)>0&(DGER[313) D ^DGRPV G ^DGRP15
BUL K DGRETURN,X,Y D ^DGRPCB G KVAR^DGRPCE
 ;
WRIT ;S C=C+1 W:(C#2) ! S X1=$S((C#2):0,1:40) W ?X1,$E(J_"  ",1,3),"- ",X2 I DGKEY(+$E(DGEDIT,J)) W "*" S DGCT1=DGCT1+1
 S C=C+1 W:(C#2) ! S X1=$S((C#2):0,1:40) W ?X1,$E(J_"  ",1,3),"- "
 W X2 I DGKEY(+$E(DGEDIT,J))!(J=407) W "*" S DGCT1=DGCT1+1
 I "^17^55^313^314^"[("^"_+J_"^") W "**" S DGCT3=DGCT3+1
 I +$P(DGRPCOLD,",",2),DGRPCOLD'[(","_J_",") S DGCT2=DGCT2+1
 I $P($G(^DGIN(38.6,J,0)),"^",6) W "+" S DGCTZ7=DGCTZ7+1
 Q
KEY S X=$S(('$D(DUZ)#2):1,'$D(^XUSEC("DG ELIGIBILITY",DUZ)):1,1:0) F I=.3,.32,.361 S DGP(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 F I=0:1:4 S DGKEY(I)=""
 I $P(DGP(.361),"^",1)="V",X S DGKEY(1)=1
 I $P(DGP(.3),"^",6)]"",X S DGKEY(2)=1
 I $P(DGP(.32),"^",2)]"",X S DGKEY(3)=1
 S:'X DGKEY(4)=1 K DGP Q
 ;
DELETE ; Delete all Registration inconsistencies from INCONSISTENT DATA file (#38.5).
 ; 
 ;
 N RULE,DIK,DA
 ;
 S RULE=0,DA=""
 S DIK="^DGIN(38.5,"_DFN_","_"""I"""_","
 ;F  S RULE=$O(^DGIN(38.5,DFN,"I",RULE)) Q:RULE=""  Q:RULE>99  S DA=RULE D ^DIK
 F  S RULE=$O(^DGIN(38.5,DFN,"I",RULE)) Q:RULE=""  D
 . I RULE>99,OVER99'[(","_RULE_",") Q
 . S DA=RULE D ^DIK
 Q
 ;
NOEDIT ; write explanation of non-editable items
 I DGCT1 W !,"You will not be able to edit inconsistencies followed by an asterisk [*]",!,"as you do not hold the appropriate ""DG ELIGIBILITY"" security key."
 I DGCT3 W !,"Inconsistencies followed by two (2) asterisks [**] must be corrected by",!,"using the appropriate MAS menu option(s)."
 I DGCT1+DGCT3'=DGCT W !!,"All items not followed by an asterisk can be edited at this time.  If these",!,"items are not corrected at this time, a bulletin will be sent to the",!,"appropriate hospital personnel."
 ;;QUIT
