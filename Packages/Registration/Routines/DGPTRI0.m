DGPTRI0 ;MJK/JS/ADL/TJ,ISF/GJW,HIOFO/FT - PTF TRANSMISSION ;4/9/15 2:57pm
 ;;5.3;Registration;**850,884**;Aug 13, 1993;Build 31
 ;;ADL;Update for CSV Project;;Mar 27, 2003
 ;
 ; ICDXCODE APIs - 5699
 ; SDCO22 APIs - 1579
 ; XLFSTR APIs - 10104
 ;
 ; -- setup control data
 ; ssn
 S X=$P(DG10,U,9),Y=$S($E(X,10)="P":"P",1:" ")_$E(X_"         ",1,9)
 ; -- adm d/t
 S X=$P($P(DG0,U,2),"."),Y=Y_$E(X,4,5)_$E(X,6,7)_$E(X,2,3)_$E($P($P(DG0,U,2),".",2)_"0000",1,4)
 ; -- facility #
 S L=3,X=DG0,Z=3 D ENTER S Y=Y_$E($P(X,U,5)_"   ",1,3)
 S DGHEAD=Y,Y="    "_Y D HEAD^DGPTRI1
 ;
101 ; -- setup 101 transmission
 ; control data and name
 S $E(Y,1,30)=$S(T1:"C",1:"N")_"101"_DGHEAD
 S $E(Y,31,44)=$$PTFNMFT($P(DG10,U))
 ; source of admission - $E(Y,45,46)
 S $E(Y,45,46)=$S($D(^DIC(45.1,+DG101,0)):$J($P(^(0),U,1),2),1:"  ")
 ; xfring fac and suffix - $E(Y,47,49) & $E(Y,50,52)
 S L=3,X=DG101,Z=5 D FORMAT S $E(Y,47,49)=DGVALUE S $E(Y,50,52)=$E($P(X,U,6)_"   ",1,3)
 ; source of payment - $E(Y,53)
 S $E(Y,53)=$S("A0"[$P(DG0,U,5):" ",1:$J($P(DG101,U,3),1))
 ;POW Location $E(Y,54)
 S $E(Y,54)=$S($P(DG52,U,5)="N":1,$P(DG52,U,5)'="Y":3,$P(DG52,U,6)>0&($P(DG52,U,6)<7):3+$P(DG52,U,6),$P(DG52,U,6)>6&($P(DG52,U,6)<9):$C($P(DG52,U,6)+58),1:" ")
 ;marital status, sex - $E(Y,55) & $E(Y,56)
 S $E(Y,55,56)=$S($D(^DIC(11,+$P(DG10,U,5),0)):$E(^(0),1),1:" ")_$J($P(DG10,U,2),1)
 ;  date of birth - $E(Y,57,64)
 S DGDOB=$P(DG10,U,3)\1,$E(Y,57,64)=$E(DGDOB,4,5)_$E(DGDOB,6,7)_(1700+$E(DGDOB,1,3))
 S $E(Y,65)=" " ;blank, not used
 ; period of service - $E(Y,66)
 S DGPOS=$S($D(^DIC(21,+$P(DG32,U,3),0)):$P(^(0),U,3),1:"")
 I $D(^DGPM(+$O(^DGPM("APTF",J,0)),"ODS")),+^("ODS") S DGPOS=6
 ;-- if non vet admitting eligibility make POS 9
 S DGPOS=$$CKPOS^DGPTUTL($P($G(^DGPT(PTF,101)),U,8),DGPOS)
 S X=DGPOS,Z=1,L=1 D FORMAT S $E(Y,66)=DGVALUE
 ; agent orange - $E(Y,67)
 S G=" " S DGAO=$P(DG321,U,2) S:DGPOS=7 G=$S($P(DG321,U)'="Y":1,DGAO="N":2,DGAO="Y":3,1:4) S:(DGAO="Y")&($P(DG321,U,13)="K") G=5
 ; rad exposure - $E(Y,68)
 ;patch 884 - use the correct numeric codes (from the DD)
 S E=" " I "^0^2^4^5^7^8^Z^"[(U_DGPOS_U) S (E,DGNT)=$P(DG321,U,12)
 S $E(Y,67,68)=G_E K DGPOS,G,E
 ; state code - $E(Y,69,70)
 S X=$S($D(^DIC(5,+$P(DG11,U,5),0)):^(0),1:""),L=2,Z=3 D FORMAT0 S $E(Y,69,70)=DGVALUE0
 ; county code - $E(Y,71,73)
 S X=$S($D(^DIC(5,+$P(DG11,U,5),1,+$P(DG11,U,7),0)):^(0),1:""),L=3,Z=3 D FORMAT0 S $E(Y,71,73)=DGVALUE0
 ; zip code - $E(Y,74,78)
 S X=DG11,Z=6,L=5 D FORMAT S $E(Y,74,78)=DGVALUE
 ; means test - $E(Y,79,80)
 S $E(Y,79,80)=$S($P(DG70,U,26)="Y":"AS",1:$E($P(DG0,U,10)_"  ",1,2))
 ; income - $E(Y,81,86)
 I $L($P(DG101,U,7))>6 S $E(Y,81,86)="999999"
 E  S X=DG101,Z=7,L=6 D FORMAT0 S $E(Y,81,86)=DGVALUE0
 ;MST - $E(Y,87)
 S X=$$GETSTAT^DGMSTAPI(+DG0) S $E(Y,87)=$S(X<0:"U",1:$P(X,"^",2))
 ;Combat Vet $E(Y,88) & $E(Y,89,94)
 S X=$$CVEDT^DGCV(+DG0,$P(DG0,"^",2)) S $E(Y,88)=$S((+X)>0:1,1:0)
 S X=$P(X,"^",2)_"       " S $E(Y,89,94)=$E(X,4,5)_$E(X,6,7)_$E(X,2,3)
 ;Project 112/SHAD - $E(Y,95)
 S X=$$SHAD^SDCO22(+DG0) S $E(Y,95)=$S((+X)>0:1,1:0)
 ;Emergency Response Indicator - $E(Y,96)
 S X=$$EMGRES^DGUTL(+DG0) S $E(Y,96)=$S("^K^"[(U_X_U):X,1:" ")
 ;Country Code - $E(Y,97,99)
 S X=$$GET1^DIQ(779.004,$P(DG11,U,10)_",",.01),Z=1,L=3 D FORMAT S $E(Y,97,99)=DGVALUE
 ;[RESERVED] - $E(Y,100,112)
 ;[NOT ALLOCATED] - $E(Y,113,384)
 K DGVALUE,DGVALUE0
 D SAVE
 I T1 S Y=$E(Y,53)=" " ;resets SOURCE OF PAYMENT to space
 ;
401 ; -- setup 401 transactions (402 and 403 are no longer used. All surgeries are 401 segments.)
 G 501:'$D(^DGPT(J,"S")) K ^UTILITY($J,"S") S I=0
SUR ;
 S I=$O(^DGPT(J,"S",I)) G 501:'I
 S DGSUR=^DGPT(J,"S",I,0)
 G SUR:'DGSUR
 G SUR:DGSUR<T1!(DGSUR>T2) S DGSUD=+^(0)\1,^UTILITY($J,"S",DGSUD)=$S($D(^UTILITY($J,"S",DGSUD)):^(DGSUD),1:0)+1,F=$S(DGSUD<2871000:0,1:1) ;^(0) references global 2 lines above
 ;
 I ^UTILITY($J,"S",DGSUD)>$S(F:3,1:2) D  I Y'=1 S DGERR=1 Q
 .W !,"**There are more than ",$S(F:"three",1:"two")," surgeries on the same date**"
 .S DIR(0)="Y",DIR("B")="YES",DIR("A")="OK to continue?" D ^DIR K DIR
 ;
 ;header, date of surgery followed by SPECIALTY - $E(Y,41,42)
 S Y=$S(T1:"C",1:"N")_"401"_DGHEAD_$E(DGSUD,4,5)_$E(DGSUD,6,7)_$E(DGSUD,2,3)_$E($P(+DGSUR,".",2)_"0000",1,4)_$S($D(^DIC(45.3,+$P(DGSUR,U,3),0)):$P(^(0),U,1),1:"  ")
 ;4 is CATEGORY OF CHIEF SURGEON - $E(Y,43)
 ;5 is CATEGORY OF FIRST ASSISTANT - $E(Y,44)
 ;6 is ANESTHESIA TECHNIQUE (PRINCIPAL) - $E(Y,45)
 ;7 is SOURCE OF PAYMENT - $E(Y,46)
 S L=1,X=DGSUR F Z=4:1:7 D ENTER
 N EFFDATE,IMPDATE,DGPTDAT D EFFDATE^DGPTIC10(J)
 ;operation codes 1 - 25 - $E(Y,47,246)
 N DG401CODES,DGLOOP,DGOCODE,DGSTRING,DGPTTMP
 D PTFICD^DGPTFUT(401,J,I,.DG401CODES) ;get procedure values
 S DGLOOP=0,DGSTRING=""
 F  S DGLOOP=$O(DG401CODES(DGLOOP)) Q:DGLOOP=""  D
 .S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",$P(DG401CODES(DGLOOP),U,1),EFFDATE,"I") ;check data
 .Q:+DGPTTMP'>0  ;don't use if bad
 .S DGOCODE=$P(DG401CODES(DGLOOP),U,3) ;external value
 .S DGSTRING=DGSTRING_DGOCODE_" " ;append space to pad to 8 characters
 S $E(Y,47,246)=DGSTRING_$$REPEAT^XLFSTR(" ",200-$L(DGSTRING))
 ;-- att phy [NOT ACTIVATED - $E(Y,247,256)]
 S $E(Y,247,256)="         "
 ;[RESERVED - $E(Y,256,290)]
 ;[NOT ALLOCATED - $E(Y,291,384)] 
 D SAVE G SUR
501 G 501^DGPTRI2
 Q
FORMAT ;format value
 S DGVALUE=$J($P(X,U,Z),L)
 Q
FORMAT0 ;format value with zeros
 S DGVALUE0=$S($P(X,U,Z)]"":$E("000000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
 ;
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("000000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
SAVE ;
 D SAVE^DGPTRI2
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
