FBAAPAY ;AISC/DMK-COMPILE CPT CODE SCHEDULE ;6/14/1999
 ;;3.5;FEE BASIS;**4,69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASKDT S FBFL=0,FBFY="" W !!,?20,"*** DATE RANGE SELECTION ***",!!,?12,"Enter fiscal year or date range within fiscal year.",!!
 S %DT="AE",%DT("A")="  Beginning Date : " D ^%DT Q:Y<0  G FYCK:'$E(Y,4,7) S BEGDATE=Y-.1,%DT(0)=Y W ! S %DT("A")="  Ending Date : " D ^%DT K %DT Q:Y<0  W ! D DATECK G:FBFL ASKDT S ENDDATE=Y+.9
QUE S VAR="BEGDATE^ENDDATE^FBFY",VAL=BEGDATE_"^"_ENDDATE_"^"_FBFY,PGM="START^FBAAPAY" D ZIS^FBAAUTL G END:FBPOP
 ;
START K ^TMP($J) S (CNT,PAY)="",%DT="X",X="TODAY" D ^%DT S FBRUN=Y_"^"_BEGDATE_"^"_ENDDATE,FBFY=FBFY+1700
 ;
RD F I=0:0 S I=$O(^FBAAC(I)) Q:I'>0  F J=0:0 S J=$O(^FBAAC(I,1,J)) Q:J'>0  I $D(^(J,0)) F K=0:0 S K=$O(^FBAAC(I,1,J,1,K)) Q:K'>0  I $D(^(K,0)) D RD1
 S I=0 F  S I=$O(^TMP($J,I)) Q:I=""  I +^(I)>7 S VARR=+^(I) D SET,80
 S ^FBAA(163.99,"AC",FBFY,FBFY)="" D START^FBAASOUT
 ;
END K AC,AP,%DT("A"),FBCPT,FBAAFY,FBEDT,FBRUN,PGM,Q,QQ,VAL,FBFL,FBFY,VARR,CNT,NUM,NUM1,PAY,I,II,J,K,L,NOD,VAR,X,Y,ZZ,BEGDATE,ENDDATE ;,^TMP($J),FBDESC,FBI
 K FBMODLE
 D CLOSE^FBAAUTL Q
 ;
SET S FBI=$O(^FBAA(163.99,"B",I,0)) D:'FBI
 .S X=I,DIC(0)="L",DIC="^FBAA(163.99,"
 .K DD,DO D FILE^DICN Q:Y<0  S FBI=+Y K DIC,DD,DO
 Q:'$G(FBI)
 S:'$D(^FBAA(163.99,FBI,"FY",0)) ^FBAA(163.99,FBI,"FY",0)="^163.991A^^"
 S Y(2)=^FBAA(163.99,FBI,"FY",0),$P(Y(2),"^",3)=FBFY,$P(Y(2),"^",4)=$P(Y(2),"^",4)+1,^FBAA(163.99,FBI,"FY",0)=Y(2)
 S ^FBAA(163.99,FBI,"FY",FBFY,0)=FBFY_"^"_VARR
 Q
RD1 I +^FBAAC(I,1,J,1,K,0)>BEGDATE&(+^FBAAC(I,1,J,1,K,0)<ENDDATE) F L=0:0 S L=$O(^FBAAC(I,1,J,1,K,1,L)) Q:L'>0  I $D(^(L,0)) D LOOK
 Q
LOOK N FBUNITS
 S Y(1)=^FBAAC(I,1,J,1,K,1,L,0)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC(I,1,J,1,K,1,L,""M"")","E")
 ; file 163.99 supports upto 18 modifiers
 I $L(FBMODLE,",")>18 S FBMODLE=$P(FBMODLE,",",1,18) ; truncate mods
 S II=$$CPT^FBAAUTL4($P(Y(1),U))_$S($G(FBMODLE)]"":"-"_FBMODLE,1:"")
 Q:II=""
 S AC=$P(Y(1),"^",2),AP=$P(Y(1),"^",3) S:'$D(^TMP($J,II)) ^TMP($J,II)=0
 I AP>0 D
 . ; skip if beginning date not after October 2003
 . I BEGDATE>3030930 D
 . . S FBUNITS=$P($G(^FBAAC(I,1,J,1,K,1,L,2)),U,14)
 . . ; skip if units paid not more than one
 . . Q:$G(FBUNITS)'>1
 . . ; divide amount claimed by units and round it to cents
 . . S AC=$J(AC/FBUNITS,"",2)
 . . ; divide amount paid by units and round it to cents
 . . S AP=$J(AP/FBUNITS,"",2)
 . S Y=^TMP($J,II),$P(^(II),"^",1)=$P(Y,"^",1)+1,$P(^(II),"^",2)=$P(Y,"^",2)+AC,$P(^(II),"^",3)=$P(Y,"^",3)+AP,CNT=CNT+1,^TMP($J,II,+AC,+AP,CNT)=""
 Q
FILE F J=0:0 S J=$O(^TMP($J,I,J)) Q:J'>0  F K=0:0 S K=$O(^TMP($J,I,J,K)) Q:K'>0  F L=0:0 S L=$O(^TMP($J,I,J,K,L)) Q:L'>0  S CNT=CNT+1 S:CNT=VAR $P(^FBAA(163.99,FBI,"FY",FBFY,0),"^",NOD)=J,$P(^(0),"^",6,8)=FBRUN
 K FBI Q
 ;
80 Q:'$G(FBI)
 S VAR=VARR*.75,VAR=$S($P(VAR,".",2)>5:$P(VAR,".",1)+1,1:$P(VAR,".",1)) S (CNT,NUM,NUM1,PAY)=0,NOD=5 D FILE Q
 ;
FYCK S FBFY=$E(Y,1,3),BEGDATE=(FBFY-1_"1000"),ENDDATE=(FBFY_"0930") G QUE
 ;
DATECK S FBFY=$S($E(BEGDATE,4,5)>9:($E(BEGDATE,1,3)+1),1:$E(BEGDATE,1,3)) I Y>(FBFY_"1001") W !,*7," Dates must be within a fiscal year. " S FBFL=1 Q
 Q
