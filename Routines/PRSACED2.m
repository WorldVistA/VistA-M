PRSACED2 ; HISC/FPT-T&A Edits ;11/24/1999
 ;;4.0;PAID;**45,54,112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; initialize array that stores 8b values.  This array is used
 ; for edit checks that involve more than one type of time.
 ;   nodes 14-17 were initialized and set in PRSACED1.
 F Z=1:1:13 S E(Z)=0
 ;
 F K=29:1:32,34:1:42,46,47 S X=$P(C0,"^",K) I X'="" S LAB=$P(T0," ",K-12) D @LAB
 F K=11:1:14,16:1:24,28,29,58,59 S X=$P(C1,"^",K) I X'="" S LAB=$P(T1," ",K) D @LAB
 I E(1)+E(2)=0 G E1
 I "0123456789GHU"[PAY,E(1)>60!(E(2)>60) S ERR=41 D ERR^PRSACED
E1 I "^R^C^"'[(U_PMP_U),E(3)>20!(E(4)>20) S ERR=55 D ERR^PRSACED
 I E(5)>24!(E(6)>24) S ERR=61 D ERR^PRSACED
 I NOR>80,(E(5)+E(6)) S ERR=168 D ERR^PRSACED
 ;  RA or RE hours may not exceed PT or PH hours minus 53.
 ;  RA is stored in E(3), RE in E(4), PT in E(10) and PH in E(11).
 ;  only check firefighters with premium pay indicator R or C (patch *54)
 I "^R^C^"[(U_PMP_U) D
 . I E(3),(E(3)>(E(10)-53)) S ERR=175 D ERR^PRSACED
 . I E(4),(E(4)>(E(11)-53)) S ERR=176 D ERR^PRSACED
 ;
 ; NT, NH, NO, NP, WD, WP in E(12), E(13), E(14), E(15), E(16), E(17)
 ; NT hrs can't exceed WD + NO.  NH hrs can't exceed WP + NP.
 ;
 I E(12)>(E(14)+E(16)) S ERR=178 D ERR^PRSACED
 I E(13)>(E(15)+E(17)) S ERR=179 D ERR^PRSACED
 ;
 I E(7)+E(8)=0 G E2
 I DUT=1,CWK'="C" S MX=NOR/2 I E(7)>MX!(E(8)>MX) S ERR=80 D ERR^PRSACED
 G:DUT=1 E2 S X1=$P(C0,"^",42)+$P(C0,"^",21),X1=X1\10+(X1#10*.25)
 I E(7)>X1 S ERR=81 D ERR^PRSACED
 S X1=$P(C1,"^",24)+$P(C1,"^",3),X1=X1\10+(X1#10*.25)
 I E(8)>X1 S ERR=81 D ERR^PRSACED
E2 I NOR=112,DUT=1,'$P(C0,"^",42)!('$P(C1,"^",24)) S ERR=67 D ERR^PRSACED
 I E(9),'$P(C1,"^",46),E(9)'=+NOR S ERR=65 D ERR^PRSACED
 ;exclude 9/3 month employee
 I DUT=2,'(NOR="01"&("LMN"[PAY)),'(NOR="80"&(PAY="M")),$P(C0,"^",42)=""!($P(C1,"^",24)="") S ERR=66 D ERR^PRSACED
 G ^PRSACED3
OA ;
OE I "ABCKMN"[PAY,X>600 S ERR=35 D ERR^PRSACED
 I "ABCGKMNU0123456789"'[PAY S ERR=36 D ERR^PRSACED
 S X1=LAB="OE"+1,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
OB ;
OF I "ABCGU0123456789"'[PAY S ERR=37 D ERR^PRSACED
 I "ABC"[PAY,X>60 S ERR=38 D ERR^PRSACED
 S X1=LAB="OF"+1,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
OC ;
OG I "0123456789GU"'[PAY S ERR=39 D ERR^PRSACED
 S X1=LAB="OG"+1,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
OK ;
OS I "ABCKM"'[PAY S ERR=44 D ERR^PRSACED
 I "ABC"[PAY,PMP="" S ERR=45 D ERR^PRSACED
 I FLSA'="E" S ERR=46 D ERR^PRSACED
 Q
OM I X>560 S ERR=48 D ERR^PRSACED
 I ($P(C0,"^",44)'>0),NOR'>80 S ERR=50 D ERR^PRSACED
 I X>$P(C0,"^",44) S ERR=62 D ERR^PRSACED
 Q
OU I X>560 S ERR=49 D ERR^PRSACED
 I ($P(C1,"^",26)'>0),NOR'>80 S ERR=51 D ERR^PRSACED
 I X>$P(C1,"^",26) S ERR=63 D ERR^PRSACED
 Q
RA ;RA is stored in E(3), RE in E(4)
RE I "ABCGKMNU0123456789"'[PAY S ERR=52 D ERR^PRSACED
 S X1=LAB="RE"+3,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
RB ;
RF I "BGU0123456789"'[PAY S ERR=53 D ERR^PRSACED
 S X1=LAB="RF"+3,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
RC ;
RG I "0123456789AGKMNU"'[PAY S ERR=54 D ERR^PRSACED
 I PAY="A",X>200 S ERR=56 D ERR^PRSACED
 S X1=LAB="RG"+3,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
HA ;
HL I "ABCGKMNU0123456789"'[PAY S ERR=57 D ERR^PRSACED
 S X1=LAB="HL"+5,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
HB ;
HM I "BGU0123456789"'[PAY S ERR=58 D ERR^PRSACED
 S X1=LAB="HM"+5,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
HC ;
HN I "0123456789GKMU"'[PAY S ERR=59 D ERR^PRSACED
 S X1=LAB="HN"+5,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
HD ;
HO I X>240 S ERR=60 D ERR^PRSACED
 I PAY'="U" S ERR=76 D ERR^PRSACED
 I PB'="P" S ERR=76 D ERR^PRSACED
 Q
PT ;
PH I 'X,'LVG,'(DUT=2&("BLM"[PAY)) S ERR=64 D ERR^PRSACED
 I DUT=1,NOR'>80 S ERR=67 D ERR^PRSACED
 I DUT=3 S ERR=68 D ERR^PRSACED
 ; total part time hours stored in E(9)
 S E(9)=E(9)+$E(X,1,2)+($E(X,3)*.25)
 ; Save PT in E(10) and PH in E(11)
 S X1=LAB="PH"+10,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
EA S E(7)=E(7)+$E(X,3,4)+($E(X,5)*.25)
EB I LAB="EB" S E(7)=E(7)+$E(X,3,4)+($E(X,5)*.25)
EC I LAB="EC" S E(8)=E(8)+$E(X,3,4)+($E(X,5)*.25)
ED I LAB="ED" S E(8)=E(8)+$E(X,3,4)+($E(X,5)*.25)
 I "GU1234567"'[PAY S ERR=78 D ERR^PRSACED
 I $E(X,1,2)>50 S ERR=79 D ERR^PRSACED
 Q
NT ; Special firefighter codes
NH ; NT is stored in E(12), NH in E(13)
 I NOR'>80 S ERR=177 D ERR^PRSACED
 S X1=LAB="NH"+12,E(X1)=E(X1)+$E(X,1,2)+($E(X,3)*.25)
 Q
