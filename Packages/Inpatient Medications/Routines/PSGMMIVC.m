PSGMMIVC ;BIR/MV-PRT MULT DAYS MAR C ORDERS(IV) ;16 Mar 99 / 2:10 PM
 ;;5.0; INPATIENT MEDICATIONS ;**20,21,28,31,35,67,58,110**;16 DEC 97
 ;
 ; Reference to ^PS(52.7 supported by DBIA #2173.
 ; Reference to ^PS(55 supported by DBIA #2191.
 ;
PRT ;*** Print IV orders.
 K P,DRG,PSGLRN,PSGMARTS,PSGMARGD,PSGLFFD,TS N ON55,PSJLABEL S TS=1,PSGMARGD="",PSJLABEL=1
 S ON=$P(DAO,U,2),DFN=$P(PN,U,2) D:$P(DAO,U,2)["V" GT55^PSIVORFB D:$P(DAO,U,2)["P" GT531^PSIVORFA(DFN,ON)  D:P(9)]"" OS S PSGLSSD=P(2),PSGLFFD=P(3)
 I $G(P("DTYP"))'=1 K P(11)
 F X="LOG",2,3 S:P(X) P(X)=$$ENDTC1^PSGMI(P(X))
 D INITOPI
 S PSGST=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I PSGST'="O" S PSGST=$S(P(9)["PRN":"P",1:"C")
 I PSGST="O",(P(2)="") S PSGST=""
 NEW NAMENEED,NEED,X S NAMENEED=0
 D LNNEED^PSGMIV,PRTIV
 Q
 ;
OS ; order record set
 S FD=P(3),PSGOES="",X=P(9),SD=P(2) D EN^PSGS0 S T=PSGS0XT
 S QQ="" I PST["C" D DTS^PSGMMAR0(P(9)) S SD=$P(SD,"."),QQ="" F X=0:0 S X=$O(PSGD(X)) Q:'X  S QQ=QQ_$S(X<SD:"",X>FD:"",'S:$P(PSGD(X),U),$D(S(X)):$P(PSGD(X),U),1:"")
 I T="D",P(11)="" S P(11)=$E($P(P(2),".",2)_"0000",1,4)
 S PSGMARTS=P(11),PSGMARGD=QQ
 K TS D TS^PSGMAR3(P(11))
 Q
 ;
PRTIV ;*** Print IV order on MAR
 I PSGMAROC,(PSGMAROC+LN)>6 D BOT^PSGMMAR2,HEADER^PSGMMAR2
 S PSGMAROC=PSGMAROC+1 W !?6,"|",?19,"|",?48,"|",$G(TS(1)) D CELL(1,0)
 W !,$E(P("LOG"),1,5)," |"
 W:ON["V" $E(P(2),1,5)_$E(P(2),9,14)," |",P(3)
 W:ON["P" "P E N D I N G"
 W ?39,"("_$E(PSGP(0))_$E(PSSN,8,12)_")"
 W ?48,"|",$G(TS(2)) D CELL(2,0) S L=3
 NEW NAME
 F X=0:0 S X=$O(DRG("AD",X)) Q:'X  D NAME^PSIVUTL(DRG("AD",X),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  W !,NAME(Y) W:L=3 ?47,PSGST W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)) D L(1)
 I '$G(DRG("AD",0)) D
 .W !
 .W:L=3 ?47,PSGST W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)) D L(1)
 W:$G(DRG("SOL",0)) !,"in "
 NEW PSJPRT2
 F X=0:0 S X=$O(DRG("SOL",X)) Q:'X  D NAME^PSIVUTL(DRG("SOL",X),47,.NAME,1) F Y=0:0 S Y=$O(NAME(Y)) Q:'Y  D
 . W:(Y>1!(X>1)) ! W ?4,NAME(Y) W:L=3 ?47,PSGST W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)) D L(1)
 . S PSJPRT2=$P(^PS(52.7,+DRG("SOL",X),0),U,4) I PSJPRT2]"" W !?7,PSJPRT2 W:L=3 ?47,PSGST W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)) D L(1)
 W !,$P(P("MR"),U,2)," ",P(9)," ",P(8) W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)) I L>5 S PSJTMPL=L\6,PSJDIV=PSJTMPL+4 I L>PSJDIV,(L#PSJDIV>1) W ! ;I L>5,(L#5>1) W !
 I '$G(DRG("SOL",0)) S L=L+1 W !,?48,"|",$G(TS(L)) D CELL(L,'(L#6))
 ;I P(4)="C",'(L#5),P("OPI")="" D L(1) W !,"*CAUTION-CHEMOTHERAPY*",?48,"|",$G(TS(L)) D CELL(L,'(L#6)) W ! ;S L=L+1 
 I P(4)="C",'(L#5),P("OPI")="" D
 . D L(1)
 . W !,"*CAUTION-CHEMOTHERAPY*",?48,"|",$G(TS(L))
 . D CELL(L,'(L#6)) W ! ;S L=L+1
 ;E  I P(4)="C" D L(1) W "*CAUTION-CHEMOTHERAPY*",?48,"|",$G(TS(L)) D CELL(L,'(L#6)) I (L+1)#6'=0 W !
 E  I P(4)="C" D
 . D L(1)
 . W:L#7=0 !
 . W "*CAUTION-CHEMOTHERAPY*",?48,"|",$G(TS(L))
 . D CELL(L,'(L#6))
 . I (L+1)#6'=0 W !
 I (L#5)=0,($L($P(P("OPI"),"^"))<29),(TS<7) S L=L+1
 E  D L(1)
 W:P("OPI")=""&(TS>6) !
 I P("OPI")'="" D
 . I L#7=0 W !
 . I L#5=1 W !
 . N PSJTMPX S PSJTMPX=0
 . F Y=1:1:$L($P(P("OPI"),"^")," ") S Y1=$P($P(P("OPI"),"^")," ",Y) D
 .. I $L(Y1)>47 W $E(Y1,1,47)
 .. I (PSJTMPX+$L(Y1))>47 W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)),L(1) S PSJTMPX=0 W !
 .. I $L(Y1)>47 W $E(Y1,48,$L(Y1)) S PSJTMPX=$L($E(Y1,48,$L(Y1)))
 .. E  W Y1," " S PSJTMPX=PSJTMPX+$L(Y1)+1
 N PSGIVFL I '$O(DRG("AD",0))!'$O(DRG("SOL",0)) S PSGIVFL=1
 I L>TS,(L#6) W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)) S L=L+1
 I (TS-1)>L W ?48,"|",$G(TS(L)) D CELL(L,'(L#6)) D
 . F L=L+1:1:TS-1 D L(0) W !?48,"|",$G(TS(L)) D CELL(L,'(L#6))
 . S L=L+1
 F  Q:'(L#6)  W !?48,"|",$G(TS(L)) D CELL(L,'(L#6)) S L=L+1
 I '(L#6),(P("OPI")="") W !
 I P("OPI")]"",(L>6) W !
 W ?29,"RPH: ",PSGLRPH,?38,"RN: ",PSGLRN,?48,"|",$G(TS(L)) D CELL(L,'(L#6)) W:PSGMAROC<6 !?7,LN2
 Q
 ;
L(X) ;***Check to see if a new block if needed.
 S L=L+X
 I L#6=0,PSGMAROC<6 D
 . W !,"See next label for continuation",?48,"|",$G(TS(L)) D CELL(L,'(L#6))
 . W:PSGMAROC<6 !?7,LN2,$C(13) S $X=0 S PSGMAROC=PSGMAROC+1,L=L+1 D
 . . I LN>6,(PSGMAROC>5) S MSG1="*** CONTINUE ON NEXT PAGE ***" D BOT^PSGMMAR2,HEADER^PSGMMAR2 S PSGMAROC=1
 Q
LN(L) ;*** Print lines within block.
 N X S X=$S(L#6:LN4,1:LN7)
 Q X
CELL(X,X1)         ;
 I ON["P",(X=6) NEW PSGLFFD,PSGMARGD S P(9)="",PSGLFFD="9999999",PSGMARGD="" W ?55 D ASTERS^PSGMMAR2 Q
 I TS=1,'$G(P(11)),(X=6) W ?55 D ASTERS^PSGMMAR2 Q
 I TS=1,'$G(P(11)) W ?55,$$LN(X) Q
 D CELL^PSGMMAR2(X,X1)
 Q
INITOPI ;* Set nurse's initial and the other print info.
 D RPHINIT^PSGMIV(.PSGLRPH)
 S PSGLRN="_____"
 I ON["V" N ND4 S ND4=$G(^PS(55,DFN,"IV",+ON,4))
 I $G(ND4) D
 .I $G(DFN),$G(ON) N PSGLREN S PSGLREN=+$$LASTREN^PSJLMPRI(DFN,ON) D
 ..N PSGLRNDT S PSGLRNDT=$P(ND4,"^",2),ND4=+ND4 I PSGLRNDT,$G(PSGLREN) I $G(PSGLREN)>PSGLRNDT S ND4=0
 .I ND4 D NAME(+ND4,"",.PSGLRN)
 I ON["P" D
 . I P("OPI")="",$O(^PS(53.1,ON,12,0)) S X=0 F  S X=$O(^PS(53.1,ON,12,X)) Q:'X  S Z=$G(^(X,0)),Y=$L(P("OPI")) S:Y+$L(Z)'>179 P("OPI")=P("OPI")_Z_" " I Y+$L(Z)>179 S P("OPI")="SEE PROVIDER COMMENTS"
 . S PSGST=""
 . D NAME(+$G(^PS(53.1,+ON,4)),"",.PSGLRN)
 Q
NAME(X,NAME,INIT)  ;Lookup in ^VA(200.
 ;X = IEN in ^VA(200
 ;NAME = Return the name in 200
 ;INIT = Return the initial
 NEW DIC,Y
 S DIC="^VA(200,",DIC(0)="NZ" D ^DIC
 S NAME=$G(Y(0,0))
 S INIT=$P($G(Y(0)),U,2)
 Q
