LRMIPSZ5 ;DALOI/STAFF - MICRO PATIENT REPORT - BACTERIA, ANTIBIOTICS ;05/24/11  14:37
 ;;5.2;LAB SERVICE;**350**;Sep 27, 1994;Build 230
 ;
 Q
 ;
BACT ;
 ; from LRMIPSZ2
 N A,I,J,K,L,LRABCNT,LRCOMMAX,LRCOMTAB,LRBUG,LRDCOM,LRFMT,LR1PASS,LRBN,LRI,LRINT,LRMAX,LRORG,LRRES,LRSECT,LRTAB,LRWIDTH,LRX,LRY,X,Y
 Q:+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,0))<1
 S LRFMT=$P(^LAB(69.9,1,0),U,11),LRFMT=$S(LRFMT="":"I",1:LRFMT)
 ;
 ; Check each organism identified on the specimen.
 ;         A = number of organisms on report that have susceptibilities
 S (A,LRBUG)=0
 F  S LRBUG=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  D
 . I +$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,2))'["2." Q
 . S A=A+1 D CHECK
 ;
 S (LRBN,LRABCNT)=0
 F  S LRBN=+$O(LRRES(LRBN)) Q:LRBN<1  S LRABCNT=LRABCNT+1
 Q:'LRABCNT!($G(LREND))
 ;
 ; Scan result to find longest value, set mininium field width = 4
 S (LRI,LRMAX(1))=0
 F  S LRI=$O(LRRES(LRI)) Q:'LRI  D
 . F I=1:1:A D
 . . S X=$L($P(LRRES(LRI),"^",I))
 . . I X<4 S X=4
 . . I X>$G(LRWIDTH(I,1)) S LRWIDTH(I,1)=X
 . . I X>LRMAX(1) S LRMAX(1)=X
 ;
 ; Scan interpretations to find longest value
 S (LRI,LRMAX(2))=0
 F  S LRI=$O(LRINT(LRI)) Q:'LRI  D
 . F I=1:1:A D
 . . S X=$L($P(LRINT(LRI),"^",I))
 . . I X<4 S X=4
 . . I X>$G(LRWIDTH(I,2)) S LRWIDTH(I,2)=X
 . . I X>LRMAX(2) S LRMAX(2)=X
 ;
 ; Find longest antibiotic display comment to display on report
 S (LRCOMMAX,LRI)=0
 F  S LRI=$O(^LAB(62.06,LRI)) Q:'LRI  D
 . S LRX=$G(^LAB(62.06,LRI,0)) Q:$P(LRX,"^",3)=""
 . I '$P(LRX,"^",2) Q
 . S LRY=0
 . F  S LRY=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRY)) Q:'LRY  D
 . . I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRY,$P(LRX,"^",2))) S X=$L($P(LRX,"^",3)) S:X>LRCOMMAX LRCOMMAX=X
 ;
 ; Check display width so that at least one organsism's values will display when display width is limited
 ; 31 character for antibiotic name, possibly 40 character display comments does not leave much space for actual results.
 I LRCOMMAX>10,IOM'>80 D
 . I LRFMT="B" S X=LRMAX(1)+LRMAX(2)+4
 . I LRFMT="R" S X=LRMAX(1)+2
 . I LRFMT="I" S X=LRMAX(2)+2
 . S X=X+31
 . I (X+LRCOMMAX)>IOM S LRCOMMAX=IOM-X
 ;
 ; Determine tab position (column) of each organism and associated results
 ;  LRSECT will indicate if multiple sections needed when number of organisms, results and display comments exceed right margin.
 S (LRI,LRWIDTH(0,1),LRWIDTH(0,2))=0,LRSECT=1,LRTAB(LRSECT,0)=29
 F  S LRI=$O(LRWIDTH(LRI)) Q:'LRI  D
 . S LRX=LRTAB(LRSECT,LRI-1)
 . I LRFMT="B" D  Q
 . . S LRY=LRX+LRWIDTH(LRI-1,1)+LRWIDTH(LRI-1,2)+4
 . . I (LRY+LRCOMMAX+LRWIDTH(LRI,1)+LRWIDTH(LRI,2))>IOM S LRCOMTAB(LRSECT)=LRY,LRY=LRTAB(1,0)+4,LRSECT=LRSECT+1
 . . S LRTAB(LRSECT,LRI)=LRY
 . . S LRTAB(LRSECT,LRI,1)=LRTAB(LRSECT,LRI)
 . . S LRTAB(LRSECT,LRI,2)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,1)+2
 . . S LRSECT(LRSECT)=$G(LRSECT(LRSECT))_LRI_"^"
 . . S LRCOMTAB(LRSECT)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,1)+LRWIDTH(LRI,2)+4
 . I LRFMT="I" D  Q
 . . S LRY=LRX+LRWIDTH(LRI-1,2)+4
 . . I (LRY+LRCOMMAX+LRWIDTH(LRI,2))>IOM S LRCOMTAB(LRSECT)=LRY,LRY=LRTAB(1,0)+4,LRSECT=LRSECT+1
 . . S LRTAB(LRSECT,LRI)=LRY
 . . S LRTAB(LRSECT,LRI,1)=LRTAB(LRSECT,LRI)
 . . S LRTAB(LRSECT,LRI,2)=LRTAB(LRSECT,LRI)
 . . S LRSECT(LRSECT)=$G(LRSECT(LRSECT))_LRI_"^"
 . . S LRCOMTAB(LRSECT)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,2)+2
 . I LRFMT="R" D  Q
 . . S LRY=LRX+LRWIDTH(LRI-1,1)+4
 . . I (LRY+LRCOMMAX+LRWIDTH(LRI,1))>IOM S LRCOMTAB(LRSECT)=LRY,LRY=LRTAB(1,0)+4,LRSECT=LRSECT+1
 . . S LRTAB(LRSECT,LRI)=LRY
 . . S LRTAB(LRSECT,LRI,1)=LRTAB(LRSECT,LRI)
 . . S LRTAB(LRSECT,LRI,2)=LRTAB(LRSECT,LRI)
 . . S LRSECT(LRSECT)=$G(LRSECT(LRSECT))_LRI_"^"
 . . S LRCOMTAB(LRSECT)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,1)+2
 ;
 D NP Q:LRABORT
 W ! D NP Q:LRABORT
 ;
 W !,"ANTIBIOTIC SUSCEPTIBILITY TEST RESULTS:"
 I $D(^XUSEC("LRLAB",DUZ))&'$D(LRWRDVEW) W "  ('*' indicates display is suppressed)"
 ;
 D NP Q:LRABORT
 ;
 ; If hard copy (LRHC=1)
 I LRHC W ! D NP Q:LRABORT
 ;
 S LRSECT=0
 F  S LRSECT=$O(LRTAB(LRSECT)) Q:'LRSECT  D SECT
 ;
 Q
 ;
 ;
SECT ; Print antibiotic susceptibility for each section
 ;
 N LRAO
 ;
 D BUGHDR Q:LRABORT
 ;
 ; Display antibiotics by print order
 S LRAO=0
 F  S LRAO=$O(^LAB(62.06,"AO",LRAO)) Q:LRAO<.001!($G(LREND))  D  Q:LRABORT
 . S B=$O(^LAB(62.06,"AO",LRAO,0))
 . I B>0,$D(^LAB(62.06,B,0)) D AB
 ;
 D NP Q:LRABORT
 W !
 D NP
 ;
 Q
 ;
 ;
CHECK ;
 ;
 N B,B1,B2,B3,LRBN,LRFLAG,LR1PASS
 ;
 S LRFLAG=0,LRBN=2
 F  S LRBN=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,LRBN)) Q:LRBN'["2."!($G(LREND))  D
 . S B=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,LRBN),B1=$P(B,U),B2=$P(B,U,2)
 . I B1'="" D FIRST
 ;
 S LRBN=2
 F  S LRBN=+$O(LR1PASS(LRBN)) Q:LRBN<1!($G(LREND))  D
 . S B=LR1PASS(LRBN),B1=$P(B,U),B2=$P(B,U,2),B3=$P(B,U,3)
 . D LAB
 ;
 S LRBUG(A)=LRBUG
 ;
 Q
 ;
 ;
FIRST ;
 ;
 ; If format is 'interpretation only' and no interpretation for this sensitivity then display sensitivity result in it's place.
 I B2="" S B2=$S(LRFMT="I":B1,1:" ")
 ;
 S B3=$P(B,U,3)
 I B2'=" ",$E(B2)'="R","A"[B3 S LRFLAG=1
 S LR1PASS(LRBN)=B1_U_B2_U_B3
 S $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,LRBN),U,1,3)=LR1PASS(LRBN)
 Q
 ;
 ;
LAB ;
 I $D(^XUSEC("LRLAB",DUZ)),'$D(LRWRDVEW) D  Q
 . S $P(LRRES(LRBN),U,A)=$S(B3="N"!(B3="R"&LRFLAG):B1_"*",1:B1)
 . S $P(LRINT(LRBN),U,A)=$S(B3="N"!(B3="R"&LRFLAG):B2_"*",1:B2)
 ;
 I B3=""!(B3="A")!(B3="R"&'LRFLAG) S $P(LRRES(LRBN),U,A)=B1,$P(LRINT(LRBN),U,A)=B2
 Q
 ;
 ;
AB ;
 N PGNUM,LRX
 Q:$G(LREND)
 S LRX=$G(^LAB(62.06,B,0)),J=$P(LRX,"^",2)
 I J<1 Q
 D NP Q:LRABORT
 I '$D(LRINT(J)) Q
 I LRINT(J)'="",LRINT(J)?."^" Q
 D NP Q:LRABORT
 ;
 ; Write name of antibiotic
 W !,$$LJ^XLFSTR($P(LRX,U),30,".")
 ;
 ; Antibiotic display comment from file #62.06
 K LRDCOM(0)
 S LRDCOM=$P(LRX,U,3)
 ; If longer than comment window (IOM-LRCOMTAB) then format to fit within window.
 I $L(LRDCOM)>(IOM-LRCOMTAB(LRSECT)) D
 . N J,K,L
 . S J=$L(LRDCOM),K=0,L=IOM-LRCOMTAB(LRSECT)-1
 . F  Q:LRDCOM=""  S K=K+1,LRDCOM(0,K)=$E(LRDCOM,1,L),LRDCOM=$E(LRDCOM,L+1,J)
 ;
 D SIR
 ;
 S PGNUM=LRPG
 D NP Q:LRABORT
 I LRPG>PGNUM D BUGHDR D NP
 Q
 ;
 ;
BUGHDR ;
 ;
 N A,J
 F J=1:1 S LRBUG=$P(LRSECT(LRSECT),"^",J) Q:LRBUG=""!($G(LREND))  D
 . S LRORG=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG(LRBUG),0),U),LRORG=$P(^LAB(61.2,LRORG,0),U)
 . I +$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG(LRBUG),2))'["2." Q
 . D ORG
 ;
 I LRFMT="B" D
 . W !
 . F J=1:1 S A=$P(LRSECT(LRSECT),"^",J) Q:A=""  W ?LRTAB(LRSECT,A),":"
 ;
 D NP Q:LRABORT
 W !
 D NP Q:LRABORT
 ;
 F J=1:1 S A=$P(LRSECT(LRSECT),"^",J) Q:A=""  D
 . I LRFMT'="B" W ?LRTAB(LRSECT,A),":"
 . I LRFMT="B" W ?LRTAB(LRSECT,A,1),"SUSC",?LRTAB(LRSECT,A,2),"INTP"
 ;
 D NP
 Q
 ;
 ;
ORG ;
 ;
 ; LR2ORMOR flag indicating 2 or more organsims on report - set in LRMIPSZ2.
 ;
 N J
 W !
 D NP Q:LRABORT
 ;
 I LRBUG>$P(LRSECT(LRSECT),"^") F J=1:1 Q:$P(LRSECT(LRSECT),"^",J)=LRBUG  W ?LRTAB(LRSECT,$P(LRSECT(LRSECT),"^",J)),":"
 ;
 W ?LRTAB(LRSECT,LRBUG),$S(LR2ORMOR:LRBUG(LRBUG)_". ",1:""),LRORG
 D NP
 Q
 ;
 ;
SIR ; Display the susceptibility results/interpretations
 ;
 N II,K
 ;
 F K=1:1 S II=$P(LRSECT(LRSECT),"^",K) Q:II=""  D
 . I LRFMT="B" D  Q
 . . W ?LRTAB(LRSECT,II,1),$P($G(LRRES(J)),U,II)
 . . W ?LRTAB(LRSECT,II,2),$P(LRINT(J),U,II),"  "
 . I LRFMT="I" W ?LRTAB(LRSECT,II,2),$P(LRINT(J),U,II)," " Q
 . I LRFMT="R" W ?LRTAB(LRSECT,II,1),$P(LRRES(J),U,II)," " Q
 ;
 D DCOM
 Q
 ;
 ;
DCOM ;
 N A,K
 ;
 I LRDCOM'="" D
 . I LRCOMTAB(LRSECT)<$X,$L(LRDCOM)>(IOM-$X) W !
 . W ?LRCOMTAB(LRSECT),LRDCOM
 ;
 I $D(LRDCOM(0)) D
 . N J
 . S J=0
 . F  S J=$O(LRDCOM(0,J)) Q:'J  W:J'=1 ! W ?LRCOMTAB(LRSECT),LRDCOM(0,J)
 ;
 I $D(LRDCOM(J)) D
 . S K=0,A=0
 . F  S A=+$O(LRDCOM(J,A)) Q:A<1  D
 . . I '('K&(LRDCOM="")) W !
 . . W ?LRCOMTAB(LRSECT),LRDCOM(J,A) S K=1
 Q
 ;
 ;
NHDR ;
 F X=1:1 W ! Q:$Y>(IOSL-LRFLIP)
 Q:$G(LREND)  I 'LRHC D FH^LRMIPSU Q
 W ! F X=1:1:IOM W "-"
 W !,"PATIENT'S IDENTIFICATION",?60,"MICROBIOLOGY REPORT"
 W !!,PNM,?$X+3,SSN,?$X+3,SEX,?$X+3,"DOB: ",DOB,"  WARD: ",LRWRD,!,"ADM: ",LRADM,"   ADM DX: ",LRADX
 S LRPG=LRPG+1
 W @IOF,!,?18,"MICROBIOLOGY LAB ",$$INS^LRU
 W ?$X+10,$$HTE^XLFDT($H,"D"),!
 F X=1:1:IOM W "-"
 W !,"ACCESSION: ",LRACC,?25,"TAKEN:",LRTK,?52,"RECEIVED:",LRRC
 Q
 ;
 ;
NP ;
 ; Convenience method
 D NP^LRMIPSZ1
 Q
