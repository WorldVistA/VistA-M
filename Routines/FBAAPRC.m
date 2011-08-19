FBAAPRC ;AISC/DMK-PRINT REPORT OF CONTACT ;08/02/88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D DT^DICRW,SITEP^FBAAUTL
RD S DIC="^FBAAA(",DIC(0)="AEQM" D ^DIC Q:X=""!(X="^")  G:Y<0 RD S DFN=+Y G:$O(^FBAAA(DFN,2,0))'>0 NONE S DIC="^FBAAA("_DFN_",2," D ^DIC Q:Y<0  S ROC=+Y,SITE=$P(FBSITE(0),"^",1)
 S VAR="DFN^ROC^SITE",VAL=DFN_"^"_ROC_"^"_SITE,PGM="START^FBAAPRC" D ZIS^FBAAUTL G:FBPOP Q
START U IO S I=ROC,(USR,VEN,J)="",FBX=$G(^FBAAA(DFN,2,I,0)),USR=$P($G(^FBAAA(DFN,2,I,100)),"^"),VEN=$P(FBX,"^",2),Y=+FBX,VENTEL=$P(FBX,"^",3) F J=1:1:6 S J(J)="" D DATE
 Q:'$D(^DPT(DFN))  S NAM=$P(^(DFN,0),"^")
 I $D(^DPT(DFN,.11)) F J=1:1:6 S J(J)=$P(^(.11),"^",J)
 S TEL=$S($D(^DPT(DFN,.13)):$P(^DPT(DFN,.13),"^"),1:"None on File"),STAT=$S(J(5)']"":" ",$D(^DIC(5,J(5),0)):$P(^(0),"^",2),1:" ")
 S FBCON=$P($G(^FBAAA(DFN,2,ROC,0)),"^",6),FBCON=$S(FBCON="T":"Telephone",FBCON="P":"Personal",1:"Unknown")
 S L="|",(PI,QQ,Q)="",$P(Q,"-",80)="-",$P(QQ,"=",80)="=" W !!!,QQ,!,?40,L,"VA Office",?58,L,"SSN #",!
 W ?40,L,?58,L,!,?8,">>  REPORT  OF  CONTACT  <<",?40,L,$E(SITE,1,18),?58,L,?60,$P(^DPT(DFN,0),"^",9),!,?40,L,$E(SITE,19,30),?58,L,!,Q,!,?3," Name of Veteran",?34,L,"Telephone No. of Vet.",?58,L,"Date of Contact",!
 W ?34,L,?58,L,!,?3,$E(NAM,1,30),?34,L,TEL,?58,L,?61,DAT,!,Q,!,?3," Address of Veteran",?58,L,"Type of Contact",!,?3,J(1),?58,L,!,?3,J(4) I J(5)]"" W ",",STAT," ",J(6)
 W ?58,L,?63,FBCON,!,Q,!,?3," Person Contacted",?58,L,"Telephone Number of",!,?58,L,"  Person Contacted",!,?3,VEN,?58,L,?61,VENTEL,!,Q,!,?3,"Brief statement of information requested and given",!
ALRT1 W !!! Q:'$D(^FBAAA(DFN,2,I,1,0))  K ^UTILITY($J,"W") S DIWL=10,DIWR=70,DIWF="W" S FBI=I
 F FBRR=0:0 S FBRR=$O(^FBAAA(DFN,2,FBI,1,FBRR)) Q:FBRR'>0  S FBXX=^(FBRR,0),X=FBXX D ^DIWP
 D ^DIWW:$D(FBXX) K FBXX S I=FBI
BOT W ! S BOT=IOSL-($Y+8) F BT=1:1:BOT W !
 W Q,!,?6,"Division or Section",?40,L,"   Executed by(signature and title)",!,?10,"FEE BASIS",?40,L,"   ",$$SIGBLK^FBAAPRC(USR),!,QQ,!,"VA form 119"
Q D CLOSE^FBAAUTL K DFN,DIC,Y,X,I,J,L,NAM,TEL,ROC,S,PI,FBI,FBSITE,PGM,VAL,VAR,Z,FBCON,FBRR,USR,Q,QQ,VEN,BOT,BT,SITE,STAT,VENTEL,D0,D1,DAT,DIW,DIWF,DIWL,DIWR,DIWT,DIYS,DWLW,FBX Q 
DATE S DAT=$P(FBX,"^"),DAT=$$DATX^FBAAUTL(DAT) Q
NONE W !!,"There are no Reports of Contact on line for this patient.",!! G Q
 ;
SIGBLK(X) ;returns the signature block printed name if in 200
 ;if not will return the .01 field.
 ;if entry does not exist will return null
 ;X equal to duz
 ;
 I $S('$G(X):1,'$D(^VA(200,X,0)):1,1:0) Q ""
 Q $S($P($G(^VA(200,X,20)),U,2)]"":$P(^(20),U,2),1:$P(^VA(200,X,0),U))
