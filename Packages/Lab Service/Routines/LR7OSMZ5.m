LR7OSMZ5 ;DALOI/STAFF - Silent Micro rpt - BACTERIA, ANTIBIOTICS ;05/24/11  14:47
 ;;5.2;LAB SERVICE;**121,187,244,350**;Sep 27, 1994;Build 230
 ;
BACT ;from LR7OSMZ2
 ;
 N A,I,J,K,L,LRABCNT,LRCOMMAX,LRCOMTAB,LRBUG,LRDCOM,LRFMT,LR1PASS,LRBN,LRI,LRINT,LRMAX,LRORG,LRRES,LRSECT,LRTAB,LRWIDTH,LRX,LRY,X,Y
 ;
 Q:+$O(^LR(LRDFN,"MI",LRIDT,3,0))<1
 ;
 S LRFMT=$P(^LAB(69.9,1,0),U,11),LRFMT=$S(LRFMT="":"I",1:LRFMT)
 ;
 ; Check each organism identified on the specimen.
 ;         A = number of organisms on report that have susceptibilities
 S (A,LRBUG)=0
 F  S LRBUG=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  D
 . I +$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,2))'["2." Q
 . S A=A+1 D CHECK
 ;
 S (LRBN,LRABCNT)=0
 F  S LRBN=+$O(LRRES(LRBN)) Q:LRBN<1  S LRABCNT=LRABCNT+1
 Q:'LRABCNT
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
 . F  S LRY=$O(^LR(LRDFN,"MI",LRIDT,3,LRY)) Q:'LRY  D
 . . I $D(^LR(LRDFN,"MI",LRIDT,3,LRY,$P(LRX,"^",2))) S X=$L($P(LRX,"^",3)) S:X>LRCOMMAX LRCOMMAX=X
 ;
 ; Check display width so that at least one organsism's values will display when display width is limited
 ; 31 character for antibiotic name, possibly 40 character display comments does not leave much space for actual results.
 I LRCOMMAX>10,GIOM'>80 D
 . I LRFMT="B" S X=LRMAX(1)+LRMAX(2)+4
 . I LRFMT="R" S X=LRMAX(1)+2
 . I LRFMT="I" S X=LRMAX(2)+2
 . S X=X+31
 . I (X+LRCOMMAX)>GIOM S LRCOMMAX=GIOM-X
 ;
 ; Determine tab position (column) of each organism and associated results
 ;  LRSECT will indicate if multiple sections needed when number of organisms, results and display comments exceed right margin.
 S (LRI,LRWIDTH(0,1),LRWIDTH(0,2))=0,LRSECT=1,LRTAB(LRSECT,0)=29
 F  S LRI=$O(LRWIDTH(LRI)) Q:'LRI  D
 . S LRX=LRTAB(LRSECT,LRI-1)
 . I LRFMT="B" D  Q
 . . S LRY=LRX+LRWIDTH(LRI-1,1)+LRWIDTH(LRI-1,2)+4
 . . I (LRY+LRCOMMAX+LRWIDTH(LRI,1)+LRWIDTH(LRI,2))>GIOM S LRCOMTAB(LRSECT)=LRY,LRY=LRTAB(1,0)+4,LRSECT=LRSECT+1
 . . S LRTAB(LRSECT,LRI)=LRY
 . . S LRTAB(LRSECT,LRI,1)=LRTAB(LRSECT,LRI)
 . . S LRTAB(LRSECT,LRI,2)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,1)+2
 . . S LRSECT(LRSECT)=$G(LRSECT(LRSECT))_LRI_"^"
 . . S LRCOMTAB(LRSECT)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,1)+LRWIDTH(LRI,2)+4
 . I LRFMT="I" D  Q
 . . S LRY=LRX+LRWIDTH(LRI-1,2)+4
 . . I (LRY+LRCOMMAX+LRWIDTH(LRI,2))>GIOM S LRCOMTAB(LRSECT)=LRY,LRY=LRTAB(1,0)+4,LRSECT=LRSECT+1
 . . S LRTAB(LRSECT,LRI)=LRY
 . . S LRTAB(LRSECT,LRI,1)=LRTAB(LRSECT,LRI)
 . . S LRTAB(LRSECT,LRI,2)=LRTAB(LRSECT,LRI)
 . . S LRSECT(LRSECT)=$G(LRSECT(LRSECT))_LRI_"^"
 . . S LRCOMTAB(LRSECT)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,2)+2
 . I LRFMT="R" D  Q
 . . S LRY=LRX+LRWIDTH(LRI-1,1)+4
 . . I (LRY+LRCOMMAX+LRWIDTH(LRI,1))>GIOM S LRCOMTAB(LRSECT)=LRY,LRY=LRTAB(1,0)+4,LRSECT=LRSECT+1
 . . S LRTAB(LRSECT,LRI)=LRY
 . . S LRTAB(LRSECT,LRI,1)=LRTAB(LRSECT,LRI)
 . . S LRTAB(LRSECT,LRI,2)=LRTAB(LRSECT,LRI)
 . . S LRSECT(LRSECT)=$G(LRSECT(LRSECT))_LRI_"^"
 . . S LRCOMTAB(LRSECT)=LRTAB(LRSECT,LRI)+LRWIDTH(LRI,1)+2
 ;
 D LINE^LR7OSUM4,LINE^LR7OSUM4
 S X="ANTIBIOTIC SUSCEPTIBILITY TEST RESULTS:"
 I $D(^XUSEC("LRLAB",DUZ))&'$D(LRWRDVEW) S X=X_"  ('*' indicates display is suppressed)"
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,X)
 D LINE^LR7OSUM4
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
 D BUGHDR
 ;
 ; Display antibiotics by print order
 S LRAO=0
 F  S LRAO=$O(^LAB(62.06,"AO",LRAO)) Q:LRAO<.001  D
 . S B=$O(^LAB(62.06,"AO",LRAO,0))
 . I B>0,$D(^LAB(62.06,B,0)) D AB
 ;
 D LINE^LR7OSUM4
 ;
 Q
 ;
 ;
CHECK ;
 ;
 N B,B1,B2,B3,LRBN,LRFLAG,LR1PASS
 ;
 S LRFLAG=0,LRBN=2
 F  S LRBN=+$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG,LRBN)) Q:LRBN'["2."  D
 . S B=^LR(LRDFN,"MI",LRIDT,3,LRBUG,LRBN),B1=$P(B,U),B2=$P(B,U,2)
 . I B1'="" D FIRST
 ;
 S LRBN=2
 F  S LRBN=+$O(LR1PASS(LRBN)) Q:LRBN<1  D
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
 ;
 N LRX
 ;
 S LRX=$G(^LAB(62.06,B,0)),J=$P(LRX,"^",2)
 I J<1 Q
 ;
 I '$D(LRINT(J)) Q
 I LRINT(J)'="",LRINT(J)?."^" Q
 ;
 D LINE^LR7OSUM4
 ;
 ; Write name of antibiotic
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,$$LJ^XLFSTR($P(LRX,U),30,"."))
 ;
 ; Antibiotic display comment from file #62.06
 K LRDCOM(0)
 S LRDCOM=$P(LRX,U,3)
 ; If longer than comment window (GIOM-LRCOMTAB) then format to fit within window.
 I $L(LRDCOM)>(GIOM-LRCOMTAB(LRSECT)) D
 . N J,K,L
 . S J=$L(LRDCOM),K=0,L=GIOM-LRCOMTAB(LRSECT)-1
 . F  Q:LRDCOM=""  S K=K+1,LRDCOM(0,K)=$E(LRDCOM,1,L),LRDCOM=$E(LRDCOM,L+1,J)
 ;
 D SIR
 Q
 ;
 ;
BUGHDR ;
 ;
 N A,J
 F J=1:1 S LRBUG=$P(LRSECT(LRSECT),"^",J) Q:LRBUG=""  D
 . S LRORG=$P(^LR(LRDFN,"MI",LRIDT,3,LRBUG(LRBUG),0),U),LRORG=$P(^LAB(61.2,LRORG,0),U)
 . I +$O(^LR(LRDFN,"MI",LRIDT,3,LRBUG(LRBUG),2))'["2." Q
 . D ORG
 ;
 I LRFMT="B" D
 . D LN^LR7OSMZ1
 . S ^TMP("LRC",$J,GCNT,0)=""
 . F J=1:1 S A=$P(LRSECT(LRSECT),"^",J) Q:A=""  S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,A),CCNT,":")
 ;
 D LN^LR7OSMZ1
 S ^TMP("LRC",$J,GCNT,0)=""
 ;
 F J=1:1 S A=$P(LRSECT(LRSECT),"^",J) Q:A=""  D
 . I LRFMT'="B" S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,A),CCNT,":")
 . I LRFMT="B" D
 . . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,A,1),CCNT,"SUSC")
 . . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,A,2),CCNT,"INTP")
 ;
 Q
 ;
 ;
ORG ;
 ;
 ; LR2ORMOR flag indicating 2 or more organsims on report - set in LRMIPSZ2.
 ;
 N J
 ;
 D LINE^LR7OSUM4
 ;
 S ^TMP("LRC",$J,GCNT,0)=""
 ;
 I LRBUG>$P(LRSECT(LRSECT),"^") F J=1:1 Q:$P(LRSECT(LRSECT),"^",J)=LRBUG  S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,$P(LRSECT(LRSECT),"^",J)),CCNT,":")
 ;
 S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,LRBUG),CCNT,$S(LR2ORMOR:LRBUG(LRBUG)_". ",1:"")_LRORG)
 ;
 Q
 ;
 ;
SIR ; Display the susceptibility results/interpretations
 ;
 N II,K
 ;
 F K=1:1 S II=$P(LRSECT(LRSECT),"^",K) Q:II=""  D
 . I LRFMT="B" D  Q
 . . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,II,1),CCNT,$P(LRRES(J),U,II))
 . . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,II,2),CCNT,$P(LRINT(J),U,II))
 . I LRFMT="I" S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,II,2),CCNT,$P(LRINT(J),U,II)) Q
 . I LRFMT="R" S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRTAB(LRSECT,II,1),CCNT,$P(LRRES(J),U,II)) Q
 ;
 D DCOM
 Q
 ;
 ;
DCOM ; Show antibiotic's display comments
 ;
 I LRDCOM'="" D
 . I LRCOMTAB(LRSECT)<$X,$L(LRDCOM)>(GIOM-$X) D LINE^LR7OSUM4 S ^TMP("LRC",$J,GCNT,0)=""
 . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRCOMTAB(LRSECT),CCNT,LRDCOM)
 ;
 I $D(LRDCOM(0)) D
 . N J
 . S J=0
 . F  S J=$O(LRDCOM(0,J)) Q:'J  D
 . . I J>1 D LINE^LR7OSUM4 S ^TMP("LRC",$J,GCNT,0)=""
 . . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRCOMTAB(LRSECT),CCNT,LRDCOM(0,J))
 ;
 I $D(LRDCOM(J)) D
 . S K=0,A=0
 . F  S A=+$O(LRDCOM(J,A)) Q:A<1  D
 . . D:'('K&(LRDCOM="")) LINE^LR7OSUM4
 . . S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(LRCOMTAB(LRSECT),CCNT,LRDCOM(J,A)),K=1
 Q
