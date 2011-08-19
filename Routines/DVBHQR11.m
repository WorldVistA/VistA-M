DVBHQR11 ;ISC-ALBANY/PKE - parse HINQ response;6/10/09 7:39pm
 ;;4.0;HINQ;**32,35,49,63,65**;03/25/92;Build 19
 ;
 ;
STAT ;Parse Statistics Segment for the records that have it.
 I ($P(DVBBAS(1),U,6)="A"!($P(DVBBAS(1),U,6)="E")),$P(DVBBAS(1),U,4)="00" D ASTAT
 I $P(DVBBAS(1),U,6)="B"!($P(DVBBAS(1),U,6)="F") D BSTAT
 I $P(DVBBAS(1),U,6)="E",$P(DVBBAS(1),U,4)'="00" D BSTAT
 I $P(DVBBAS(1),U,6)="C",$P(DVBBAS(1),U,4)=10 D CSTAT
 I $P(DVBBAS(1),U,6)="C",$P(DVBBAS(1),U,4)'=10 S DVBVET="C^^^^"
 ;
 G CHILD ;changing the order of the response message - diag will
 ;come at the very end to accommodate variable length records
 ;
DIAG ;Diagnostics Segment.
 K DXP,DX,DVBDX,DVBEFF
 N DVBCUR,DVBEXT,DVBORIG
 ;with the HINQ replacement, interim solution (DVB*4*49) there are 
 ;several changes to the diagnostic segment.  Total # codes, Add'l
 ;codes, length of segment are not longer being sent.  # SC Codes is
 ;being stored in DVBDXNO.  The for loop at DIAG+15 will terminate
 ;after DVBDXNO, the 6 code limit from VBA has been increased to 150.
 ;Total # of SC Diagnostic Codes.
 S DVBV1=$E(X,1,3)
 I DVBV1["{" S DVBV2=2 D SIGN^DVBHUTIL Q:$G(DVBERCS)  ;????
 S DVBDXNO=+DVBV1
 ;Combined Degree of Disability, Effective Date of Combined SC% Eval
 S DVBDXPCT=$E(X,4,6)
 S DVBDXPCT=$TR(DVBDXPCT," ")
 S DVBEFF=$E(X,7,14)
 S DVBEFF=$TR(DVBEFF," ")
 S L=15 D RON S L=1
 ;Y=Diagnostic Codes; DXP(I)=Percent of Disability:
 F I=1:1:DVBDXNO D
 . D RON S L=1
 . I $E(X,L,L+3)["    "!($E(X,L,L+3)']"") S L=L+25 Q
 . S Y=$E(X,L,L+3),DXP(I)=$E(X,L+4,L+6)
 . S DVBEXT(I)=$E(X,L+7,L+8)
 . S DVBEXT(I)=$TR(DVBEXT(I)," ")
 . S DVBORIG(I)=$E(X,L+9,L+16)
 . S DVBORIG(I)=$TR(DVBORIG(I)," ")
 . S DVBCUR(I)=$E(X,L+17,L+24)
 . S DVBCUR(I)=$TR(DVBCUR(I)," ")
 . S L=L+25 I DXP(I)'="   " S DX(I)="" F J=1:1:4 S Z=$E(Y,J) S:Z'?1N Z=$A(Z)-64 S:Z>9 Z=0 S DX(I)=DX(I)_Z
 F I=0:0 S I=$O(DX(I)) Q:'I  S Y=DX(I),DX(I)=$S($O(^DIC(31,"C",+DX(I),0)):$O(^(0)),1:"") S DVBDX(I)=Y_"^"_DX(I)_"^"_DXP(I)_"^"_$G(DVBEXT(I))_"^"_$G(DVBORIG(I))_"^"_$G(DVBCUR(I))
 ;
 ;sorting by SC% so that they will be saved and displayed that way
 N DVBCT,DVBDD,DVBE,DVBEE
 F DVBE=0:0 S DVBE=$O(DVBDX(DVBE)) Q:DVBE'>0  S DVBDD(+$P(DVBDX(DVBE),U,3),DVBE)=DVBDX(DVBE)
 S DVBE="",DVBCT=1
 F  S DVBE=$O(DVBDD(DVBE),-1) Q:DVBE']""  D
 . F DVBEE=0:0 S DVBEE=$O(DVBDD(DVBE,DVBEE)) Q:DVBEE'>0  D
 . . S DVBDX(DVBCT)=DVBDD(DVBE,DVBEE) S DVBCT=DVBCT+1
 K DVBDD,DX,DXP
 Q
 S L=L+1 D RON
 ;
CHILD ;Child-Birth-Data.
 S $P(DVBCHI,U,1)=$E(X,1,2)
 S DVBV1=$E(X,3,4)
 I DVBV1?1N1A!(DVBV1["{") S DVBV2=2 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S DVBCHNO=DVBV1,L=5,J1=0 D RON
 I 'DVBCHNO S DVBCHNO=0 F DVBV=1:1:20 S L=20 D RON
 E  F DVBV=1:1:20 S DVBV1=$E(X,1,19),L=20 D RON I DVBV'>DVBCHNO S DVBCHDOB=$E(DVBV1,1,8) S:DVBCHDOB?8N J1=J1+1,DVBCHILD(J1)=$E(DVBV1,9)_U_$E(DVBV1,10,19)_U_DVBCHDOB
 K DVBCHDOB,J1,DVBV1,DVBV
 ;
WITH ;WITHHOLDING-APPORTIONED-SEGMENT.
 S $P(DVBWIT,U,1)=$E(X,1),DVBV1=$E(X,2,7)
 I DVBV1?5N1A!(DVBV1["{") S DVBV2=6 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBWIT,U,2)=+$E(DVBV1,1,4)_"."_$E(DVBV1,5,6)
 S DVBV1=$E(X,8,13)
 I DVBV1?5N1A!(DVBV1["{") S DVBV2=6 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBWIT,U,3)=+$E(DVBV1,1,4)_"."_$E(DVBV1,5,6)
 S DVBV1=$E(X,14,19)
 I DVBV1?5N1A!(DVBV1["{") S DVBV2=6 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBWIT,U,4)=+$E(DVBV1,1,4)_"."_$E(DVBV1,5,6),$P(DVBWIT,U,5)=$E(X,20)
 S L=21 D RON
 ;
NMADR ;ADDRESS-SEGMENT.
 S M("+")=7 F I=65:1:70 S M($C(I))=71-I
 S M("-")=15 F I=74:1:80 S M($C(I))=88-I
 F I=84:1:88 S M($C(I))=104-I
 S M("&")=7
 ;Blank & Length of Segment:
 S $P(DVBADD,U,1)=$E(X,1),DVBV1=$E(X,2,4)
 I DVBV1?2N1A!(DVBV1["{") S DVBV2=3 D SIGN^DVBHUTIL Q:$G(DVBERCS)
 S $P(DVBADD,U,2)=DVBV1
 ;Sequence Control:
 S $P(DVBADD,U,3)=$E(X,5)
 ;Name Line Indicator:
 S $P(DVBADD,U,4)=$E(X,6)
 ;Zip Code:
 S DVBZIP=$E(X,7,15)
 S DVBZIP=$E(DVBZIP,1,5) ;use only 1st 5 digits - DVB*4*49
 S L=16,L1=15
 F I=1:1:DVBADRLN Q:$E(X,L)=" "!($E(X,L)="")  Q:'$G(M($E(X,L)))  S M=M($E(X,L)),DVBADR(I)=$E(X,L+1,L+M),L=L+M+1,L1=L1+M+1 D RON S L=1
 S $P(DVBADD,U,18)=145-L1
 S L=$P(DVBADD,U,18)+1 D RON
 K M,L1
 ;instead of calling DEDBL^DVBHQR12 call REF^DVBHQR12, since the DED/BAL
 ;segments will no longer be included in the VBA resp message, DVB*4*49
 G REF^DVBHQR12
 ;
RON S X=$E(X,L,999),LX=$L(X),LY=254-LX I $D(X(2)),(LX+$L(X(2)))<256 S X=X_X(2) K X(2) D RON1 Q
 I $D(X(2)) S X=X_$E(X(2),1,LY),X(2)=$E(X(2),LY+1,999) Q
 Q
 ;
RON1 F Z1=3:1:99 I $D(X(Z1)),'$D(X(Z1-1)) S X(Z1-1)=X(Z1) K X(Z1) Q:'$O(X(Z1))
 QUIT
 ;
ASTAT ;Statistics Segment of Type A Record.
 S $P(DVBVET,U,1)="A",$P(DVBVET,U,2)=$E(X,1)
 S $P(DVBVET,U,3)=$E(X,2)
 S DVBBOS(1)=$E(X,3),DVBEOD(1)=$E(X,4,11),DVBRAD(1)=$E(X,12,19),DVBASVC=$E(X,20),DVBDOB=$E(X,21,28)
 S $P(DVBVET,U,9)=$E(X,29,30),$P(DVBVET,U,10)=$E(X,31)
 S $P(DVBP(2),U,2)=$E(X,32)
 S DVBEI=$E(X,33),DVBCI=$E(X,34)
 S $P(DVBVET,U,14)=$E(X,35)
 S DVBCPS=$E(X,36)
 S DVBPTI=$E(X,37)
 S $P(DVBP(2),U,6)=$E(X,38,39),$P(DVBP(2),U,3)=$E(X,40,41),$P(DVBP(2),U,1)=$E(X,42,43),$P(DVBP(2),U,4)=$E(X,44),$P(DVBP(2),U,5)=$E(X,45)
 S L=46 D RON
 S DVBSPDOB=$E(X,1,8)
 ;leave spouse DOB in format MMDDYYYY
 S DVBSPNAM=$E(X,9,18) ;;;DVBPTI=$E(X,40)
 ;Hospitalized SMC code:
 S $P(DVBVET,U,24)=$E(X,19,20)
 ;DOB of Father:
 S $P(DVBVET,U,25)=$E(X,21,28)
 ;DOB of Mother:
 S $P(DVBVET,U,26)=$E(X,29,36)
 ;Blanks:
 S $P(DVBVET,U,27)=$E(X,37,40)
 ;P&T disability and dental
 S DVBPTIDT=$E(X,41,48) ;DVB*4*65
 S DVBDENTI=$E(X,49) ;DVB*4*65
 S L=50 D RON
 ;
 Q
 ;
BSTAT ;Statistics Segment of Type B Record.
 S $P(DVBVET,U,1)="B",$P(DVBVET,U,2)=$E(X,1)
 S $P(DVBVET,U,3)=$E(X,2)
 S DVBBOS(1)=$E(X,3),DVBEOD(1)=$E(X,4,11),DVBRAD(1)=$E(X,12,19),DVBASVC=$E(X,20),DVBDOB=$E(X,21,28)
 S DVBDOB=$E(DVBDOB,5,8)_$E(DVBDOB,1,4)
 S $P(DVBVET,U,9)=$E(X,29,30),$P(DVBVET,U,10)=$E(X,31,37)
 ;Age at Death & Death Date:
 S $P(DVBVET,U,11)=$E(X,38,39),$P(DVBVET,U,12)=$E(X,40,47)
 ;Blank & Pay Grade
 S $P(DVBVET,U,13)=$E(X,48),$P(DVBVET,U,14)=$E(X,49,50)
 ;DOB of Payee & DOB of 3rd Party:
 S $P(DVBVET,U,15)=$E(X,51,58),$P(DVBVET,U,16)=$E(X,59,66)
 ;Name of 3rd Party & Filler
 S $P(DVBVET,U,17)=$E(X,67,73),$P(DVBVET,U,18)=$E(74,85)
 S L=86 D RON
 Q
 ;
CSTAT ;Statistics Segment of Type C Record.
 S $P(DVBVET,U,1)="C",$P(DVBVET,U,2)=$E(X,1)
 ;CP-APPORT-SPOUSE NAME & DOB
 S $P(DVBVET,U,3)=$E(X,2,11),$P(DVBVET,U,4)=$E(X,12,19)
 S $P(DVBVET,U,5)=$E(X,20,25)
 S L=86 D RON
 Q
 ;
PENSION ;DVB*4*65
 S $P(DVBP(1),U,10)=$E(X,1,8),$P(DVBP(1),U,11)=$E(X,9,20),$P(DVBP(1),U,12)=$E(X,21,28),$P(DVBP(1),U,13)=$E(X,29,40),$P(DVBP(1),U,14)=$E(X,41,52),$P(DVBP(1),U,15)=$E(X,53,64),$P(DVBP(1),U,16)=$E(X,65,76)
 S L=77 D RON
 ;
 Q
 ;
