DGPTR0 ;MJK/JS/ADL - PTF TRANSMISSION ; 9/26/05 6:44pm
 ;;5.3;Registration;**114,247,338,342,510,524,565,678,729,664**;Aug 13, 1993;Build 15
 ;;ADL;Update for CSV Project;;Mar 27, 2003
 ; -- setup control data
 ; ssn
 S X=$P(DG10,U,9),Y=$S($E(X,10)="P":"P",1:" ")_$E(X_"         ",1,9)
 ; -- adm d/t
 S X=$P($P(DG0,U,2),"."),Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P($P(DG0,U,2),".",2)_"0000",1,4)
 ; -- facility #
 S L=3,X=DG0,Z=3 D ENTER S Y=Y_$E($P(X,U,5)_"   ",1,3)
 S DGHEAD=Y,Y="    "_Y D HEAD^DGPTR1
 ;
101 ; -- setup 101 transation
 ; control data and name
 ;S Y=$S(T1:"C",1:"N")_"101"_DGHEAD,DGNAM=$P(DG10,U,1) D DGNAM S Y=Y_$E($P(DGNAM,",",1)_"           ",1,12)_$J($E($P(DGNAM,",",2),1),1)_$J($E($P($P(DGNAM,",",2)," ",2),1),1)
 S Y=$S(T1:"C",1:"N")_"101"_DGHEAD S Y=Y_$$PTFNMFT($P(DG10,U))
 ; source of admission
 S Y=Y_$S($D(^DIC(45.1,+DG101,0)):$J($P(^(0),U,1),2),1:"  ")
 ; xfring fac and suffix
 S L=3,X=DG101,Z=5 D ENTER S Y=Y_$E($P(X,U,6)_"   ",1,3)
 ; source of payment
 S Y=Y_$S("A0"[$P(DG0,U,5):" ",1:$J($P(DG101,U,3),1))
 ;POW Location
 S Y=Y_$S($P(DG52,U,5)="N":1,$P(DG52,U,5)'="Y":3,$P(DG52,U,6)>0&($P(DG52,U,6)<7):3+$P(DG52,U,6),$P(DG52,U,6)>6&($P(DG52,U,6)<9):$C($P(DG52,U,6)+58),1:" ")
 ;marital status, sex
 S Y=Y_$S($D(^DIC(11,+$P(DG10,U,5),0)):$E(^(0),1),1:" ")_$J($P(DG10,U,2),1)
 ;  date of birth
 S DGDOB=$P(DG10,U,3)\1,Y=Y_$E(DGDOB,4,5)_$E(DGDOB,6,7)_(1700+$E(DGDOB,1,3))
 ; period of service
 S DGPOS=$S($D(^DIC(21,+$P(DG32,U,3),0)):$P(^(0),U,3),1:"")
 I $D(^DGPM(+$O(^DGPM("APTF",J,0)),"ODS")),+^("ODS") S DGPOS=6
 ;-- if non vet admitting eligibility make POS 9
 S DGPOS=$$CKPOS^DGPTUTL($P($G(^DGPT(PTF,101)),U,8),DGPOS)
 S X=DGPOS,Z=1,L=2 D ENTER
 ; agent orange
 S G=" " S DGAO=$P(DG321,U,2) S:DGPOS=7 G=$S($P(DG321,U)'="Y":1,DGAO="N":2,DGAO="Y":3,1:4) S:(DGAO="Y")&($P(DG321,U,13)="K") G=5
 ; rad exposure
 S E=" " I "^0^2^4^5^7^8^Z^"[(U_DGPOS_U) S DGNT=$P(DG321,U,12),E=$S($P(DG321,U,3)'="Y":1,DGNT="N":2,DGNT="T":3,DGNT="B":4,1:" ")
 S Y=Y_G_E K DGPOS,G,E
 ; state code
 S X=$S($D(^DIC(5,+$P(DG11,U,5),0)):^(0),1:""),L=2,Z=3 D ENTER0
 ; county code
 S X=$S($D(^DIC(5,+$P(DG11,U,5),1,+$P(DG11,U,7),0)):^(0),1:""),L=3,Z=3 D ENTER0
 ; zip code
 S X=DG11,Z=6,L=5 D ENTER
 ; means test
 S Y=Y_$S($P(DG70,U,26)="Y":"AS",1:$E($P(DG0,U,10)_"  ",1,2))
 ; income
 I $L($P(DG101,U,7))>6 S Y=Y_"999999"
 E  S X=DG101,Z=7,L=6 D ENTER0
 ;MST
 S X=$$GETSTAT^DGMSTAPI(+DG0) S Y=Y_$S(X<0:"U",1:$P(X,"^",2))
 ;Combat Vet
 S X=$$CVEDT^DGCV(+DG0,$P(DG0,"^",2)) S Y=Y_$S((+X)>0:1,1:0)
 S X=$P(X,"^",2)_"       " S Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)
 ;Project 112/SHAD
 S X=$$SHAD^SDCO22(+DG0) S Y=Y_$S((+X)>0:1,1:0)
 ;Emergency Response Indicator
 S X=$$EMGRES^DGUTL(+DG0) S Y=Y_$S("^K^"[(U_X_U):X,1:" ")
 ;Country Code
 S X=$$GET1^DIQ(779.004,$P(DG11,U,10)_",",.01),Z=1,L=3 D ENTER
 D FILL^DGPTR2,SAVE
 I T1 S Y=$E(Y,1,52)_" "_$E(Y,54,125)
 ;
P401 ; -- setup 401P transaction
 G 401:'$D(^DGPT(J,"401P"))!(T1) S DG41=^("401P"),Y=$S(T1:"C",1:"N")_"401"_DGHEAD_"P"_"           "
 S DG41=$S($D(^DGPT(J,"401P")):^("401P"),1:"")
 S L=1 F K=1:1:5 S:'$P(DG41,U,K) DG41=$P(DG41,U,1,K-1)_U_$P(DG41,U,K+1,99),K=K-1 S L=L+1 Q:L=5
 F I=1:1:5 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DG41,U,I),$$GETDATE^ICDGTDRG(J)),Y=Y_$S(+DGPTTMP>0:$J($P($P(DGPTTMP,U,2),".",1),2)_$E($P($P(DGPTTMP,U,2),".",2)_"   ",1,3),1:"     ")_"  "
 I $E(Y,40)'=" " D FILL^DGPTR2,SAVE
 ;
401 ; -- setup 401 transactions
 G 501:'$D(^DGPT(J,"S")) K ^UTILITY($J,"S") S I=0
SUR S I=$O(^DGPT(J,"S",I)) G 501:'I S DGSUR=^(I,0),DGAUX=$S($D(^DGPT(J,"S",I,300)):^(300),1:"") G SUR:'DGSUR
 G SUR:DGSUR<T1!(DGSUR>T2) S DGSUD=+^(0)\1,^UTILITY($J,"S",DGSUD)=$S($D(^UTILITY($J,"S",DGSUD)):^(DGSUD),1:0)+1,F=$S(DGSUD<2871000:0,1:1)
 I ^UTILITY($J,"S",DGSUD)>$S(F:3,1:2) D  I Y'=1 S DGERR=1 Q
 .W !,"**There are more than ",$S(F:"three",1:"two")," surgeries on the same date**"
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="OK to continue?" D ^DIR K DIR
 S Y=$S(T1:"C",1:"N")_"40"_^(DGSUD)_DGHEAD_$E(DGSUD,4,5)_$E(DGSUD,6,7)_$E(DGSUD,2,3)_$E($P(+DGSUR,".",2)_"0000",1,4)_$S($D(^DIC(45.3,+$P(DGSUR,U,3),0)):$P(^(0),U,1),1:"  ")
 S L=1,X=DGSUR F Z=4:1:7 D ENTER
 S L=1 F K=8:1:12 S:'$P(DGSUR,U,K) DGSUR=$P(DGSUR,U,1,K-1)_U_$P(DGSUR,U,K+1,99),K=K-1 S L=L+1 Q:L=5
 F K=8:1:12 S DGPTTMP=$$ICDOP^ICDCODE(+$P(DGSUR,U,K),$$GETDATE^ICDGTDRG(J)),Y=Y_$S(+DGPTTMP>0:$J($P($P(DGPTTMP,U,2),".",1),2)_$E($P($P(DGPTTMP,U,2),".",2)_"   ",1,3),1:"     ")_"  "
 ;-- att phy
 S Y=Y_"         "
 ;-- additional ptf question
 ;send null, if disch date>inactive date. DG/729
 I +$P($G(^DIC(45.88,1,0)),U,3) S DGAUX=$S((+$G(^DGPT(J,70))<$P(^DIC(45.88,1,0),U,3)):DGAUX,1:"")
 S Y=Y_$E($P(DGAUX,U)_" ")
 K DGAUX
 D FILL^DGPTR2,SAVE G SUR
501 G 501^DGPTR2
 Q
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("000000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
SAVE D START^DGPTR1 S:'DGERR ^XMB(3.9,DGXMZ,2,DGCNT,0)=Y,DGCNT=DGCNT+1
 I DGERR'>0 S DGACNT=DGACNT+1,^TMP("AEDIT",$J,$E(Y,1,4),DGACNT)=Y
Q Q
DGNAM S X=DGNAM I X?.E.P F I=1:1:$L(X) S Z=$E(X,I) Q:Z=","  S:Z?.P&(Z]"") X=$E(X,1,I-1)_$E(X,I+1,$L(X)),I=I-1 Q:X'?.E.P
 I X?.E.L D UP^DGHELP
 S DGNAM=X
 Q
 ;
PTFNMFT(DG10) ;this function will format the name of the patient for
 ; transmission of the 101 record to Austin. In addition, this
 ; function will be used by OPC so that the format will be consistent
 ; for OPC and PTF.
 ;  INPUT :   DG10 - .01 field from the patient record.
 ;  OUTPUT:   name in the format proper format.
 ;        A = <12 - characters of last name padded with blanks>
 ;        B = <1  - first initial of fist name>
 ;        C = <1  - first initial of middle name>
 ;      returns :ABC <14 - characters>
 N X,I
 S DGNAM=DG10 D DGNAM
 Q $E($P(DGNAM,",",1)_"           ",1,12)_$J($E($P(DGNAM,",",2),1),1)_$J($E($P($P(DGNAM,",",2)," ",2),1),1)
 ;
