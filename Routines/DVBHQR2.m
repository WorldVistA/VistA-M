DVBHQR2 ;ISC-ALBANY/PKE/JLU-parse Birls response ;1/26/88  19:49
 ;;4.0;HINQ;**53,49**;03/25/92 
 S DFN=+$E(X(1),8,21),XMDUZ=DUZ,DVBLEN=+$E(X(1),22,25),X=$E(X(1),26,999)
 ;
 S DVBCAP="BIRLS Response only - No C&P Record Found",DVBCN=$E(X,1,9)
 I $E(DVBCN,9)=" " S DVBCN=$E(DVBCN,1,8)
 Q:'$L(X)
 S DVBNAME=$E(X,10,72)
 S L=73 D RON
 ;
 S DVBDOB=$E(X,1,8),DVBFL=$E(X,9,11)
FOLDER I +DVBFL S Y=0,Y=$O(^DIC(4,"D",+DVBFL,Y)) I Y S Y=$S($D(^DIC(4,Y,0)):$P(^DIC(4,Y,99),U,1)_" - "_$P(^(0),U),1:""),DVBFL=Y
 I DVBFL="   " K DVBFL
 ;
 S $P(DVBBIR,U,5)=$E(X,12),DVBPOA=$E(X,13,15)
 ;
 D POA
 ;
 S $P(DVBBIR,U,7)=$E(X,16) ;clothing allowance indicator
 S L=17 D RON
 ;
MOR S (DVBDXNO,DVBDXSC)=0
 F I=1:1:9 S Y=$E(X,1,4),DXP(I)=$E(X,5,7),DXP1(I)=$S($E(X,9)="Y":1,1:0)_U_$E(X,8),DX(I)="",L=10 S:$E(X,9)="Y" DVBDXSC=DVBDXSC+1 D RON F L=1:1:4 S Z=$E(Y,L) Q:Z=" "  S:Z'?1N Z=$A(Z)-64 S:Z>9 Z=0 S DX(I)=DX(I)_Z
 ;
 F I=0:0 S I=$O(DX(I)) Q:'I  S Y=DX(I),DX(I)=$S($O(^DIC(31,"C",+DX(I),0)):$O(^(0)),1:"") S DVBDX(I)=Y_"^"_DX(I)_"^"_DXP(I)_"^"_1 S:+Y>0 DVBDXNO=DVBDXNO+1
 ;
 ;DVB*4*49 - sort by SC%
 N DVBCT,DVBDD,DVBE,DVBEE
 F DVBE=0:0 S DVBE=$O(DVBDX(DVBE)) Q:DVBE'>0  S DVBDD(+$P(DVBDX(DVBE),U,3),DVBE)=DVBDX(DVBE)
 S DVBE="",DVBCT=1
 F  S DVBE=$O(DVBDD(DVBE),-1) Q:DVBE']""  D
 . F DVBEE=0:0 S DVBEE=$O(DVBDD(DVBE,DVBEE)) Q:DVBEE'>0  D
 . . S DVBDX(DVBCT)=DVBDD(DVBE,DVBEE) S DVBCT=DVBCT+1
 K DVBDD,DX,DXP
 S $P(DVBBIR,U,8)=$E(X,1),$P(DVBBIR,U,9)=$E(X,2)
 S $P(DVBBIR,U,10)=$E(X,3),DVBDXPCT=$E(X,4,6),$P(DVBBIR,U,11)=$E(X,4,6)
 S L=7 D RON
 D BIRL^DVBHQR13
 Q
 ;
RON S X=$E(X,L,999),LX=$L(X),LY=254-LX I $D(X(2)),(LX+$L(X(2)))<256 S X=X_X(2) K X(2) D RON1 Q
 I $D(X(2)) S X=X_$E(X(2),1,LY),X(2)=$E(X(2),LY+1,999) Q
 Q
 ;
RON1 I $D(X(3)),'$D(X(2)) S X(2)=X(3) K X(3) I $D(X(4)),'$D(X(3)) S X(3)=X(4) K X(4) I $D(X(5)),'$D(X(4)) S X(4)=X(5) K X(5)
 QUIT
 ;
POA ;DVB*4*49 - new Power of Attorney codes
 I DVBPOA'?1.3N D POA3 Q
 I +DVBPOA>99 Q
 I '+DVBPOA K DVBPOA Q
 I $L(DVBPOA)=3 S DVBPOA=+$E(DVBPOA,2,3)
 I DVBPOA>73,DVBPOA<100 S Y=DVBPOA D POA2 S DVBPOA=Y_" - "_DVBPOA Q
 ;
EEE ;
 S Y=0 F I=3,7,12,24,29,32,43,53,55,56,61,62,63,64,65,66,67,68,70,71 S Y=Y+1 IF I=+DVBPOA D POA1 S DVBPOA=Y_" - "_DVBPOA Q
 ;
 S Y=DVBPOA,Y=$S(+Y=2:402,Y=+5:405,Y=36:436,Y=37:437,Y=38:438,Y=42:442,Y=52:452,Y=55:455,Y=60:460,Y>9:3_Y,1:30_Y)
 S Z=0,Z=$O(^DIC(4,"D",Y,Z)) I Z,$D(^DIC(4,Z,0)) S Y=+$P(^(0),U,2) I $D(^DIC(5,Y,0)) S DVBPOA="State of "_$P(^(0),U)_" Department of Veterans - "_DVBPOA Q
 Q
POA1 S Y=$P($T(POA1+Y),";;",2) Q
3 ;;Polish Legion of Amer. Veterans, USA
7 ;;The Retired Enlisted Association
12 ;;Gold Star Wives of America Inc.
24 ;;National Amputation Foundation, Inc.
29 ;;Vietnam Era Veterans Association
32 ;;Virgin Islands Office of Veterans Affairs
43 ;;Swords to Plowshares
53 ;;Northern Mariana Islands Dept VA
55 ;;Puerto Rico Public Advocate for Veterans Affairs
56 ;;Guam Office of Veterans Affairs
61 ;;American Defenders of Bataan & Corregidor, Inc.
62 ;;Noncommissioned Officers Assoc., USA
63 ;;Veteran Assistance Foundation, Inc.
64 ;;Nat. Assn. of County Veterans Affairs Office
65 ;;American Ex-Prisoners of War, Inc.
66 ;;Private Attorney with Exclusive Contact
67 ;;American Samoa Veterans Affirs Office
68 ;;American GI Forum, National Veterans' Outreach Program
70 ;;Vietnam Veterans of America
71 ;;Paralyzed Veterans of America
 ;
POA2 S Y=Y-73,Y=$P($T(POA2+Y),";;",2) Q
74 ;;The American Legion
 ;;American National Red Cross
 ;;American Veterans Committee
 ;;AMVETS
 ;;Army and Air Force Mutual Aid Assoc.
 ;;Army and Navy Union, USA
8 ;;Blinded Veterans Assoc.
 ;;Catholic War Veterans, USA
 ;;National Veterans Legal Services Program
 ;;Disabled American Veterans
 ;;National Association for Black Veterans, Inc.
 ;;Fleet  Reserve Assoc.
 ;;Jewish War Veterans
 ;;Legion of Valor, USA
 ;;Marine Corps League
 ;;Military Order of the Purple Heart
9 ;;Eastern Paralyzed Veterans Association
 ;;African American PTSD Association
 ;;Veterans of the Vietnam War, Inc.
 ;;Navy Mutual Aid Assoc.
 ;;National Veterans Organization of America, Inc.
 ;;Italian American War Veterans
 ;;United Spanish War Veterans
 ;;Veterans of Foreign Wars of the United States
 ;;Veterans of WWI of the USA, Inc
 ;;Agent
 Q
POA3 ;DVB*4*49 - Power of Att. codes with alpha characters
 I $L(DVBPOA)=3 S DVBPOA=$E(DVBPOA,2,3)
 N DVBX,DVBXX
 I $E(DVBPOA)="0" D
 . F DVBX=65:1:82 S DVBXX=$C(DVBX) I DVBXX=$E(DVBPOA,2) S Y=DVBX D POA33 S DVBPOA=Y_" - "_DVBPOA Q
 Q
POA33 S Y=Y-64,Y=$P($T(POA33+Y),";;",2) Q
 ;;Mark R. Caldwell
 ;;Kenneth M. Carpenter
 ;;Stephen L. DeVita
 ;;William G. Smith
 ;;Legal Aid Society of Cincinatti
 ;;Irving M. Solotoff
 ;;Leroy A. St. John
 ;;Rashid L. Malik
 ;;Berry, Kelley & Reiman
 ;;Nancy E Killeen
 ;;Hill & Ponton Professional Assoc.
 ;;Richard A laPointe
 ;;Lisa Ann Lee
 ;;Betty L. G. Jones
 ;;
 ;;Barbara J. Cook
 ;;Law Offices of Theodore Jarvi
 ;;Chisholm, Chisholm & Kilpatrick LLP
 Q
