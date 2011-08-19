PRCUTL ;WISC/RWS/DL-IFCAP UTILITY ROUTINE ; 1/28/98  1430
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;CREATE DOCUMENT LOCATOR NUMBER FOR CERTIFIED INVOICE
 ;REQUIRES PRCFX("X")=DATE,PRC("SITE")=STATION NUMBER
 ;IF PRCFX("X") IS UNDEFINED, OR NOT ?7N PROGRAM WILL ASSUME CURRENT DATE
 I $S($D(PRC("SITE"))["0":1,+PRC("SITE")=0:1,1:0) S X="  Station Number is undefined, Processing is terminated.*" D MSG^PRCFQ S %=0 Q
 I $S($D(PRCFX("X"))[0:1,PRCFX("X")?7N:1,1:0) D NOW^PRCFQ S PRCFX("X")=X S:$D(DT)[0 DT=X K %,%X,X,Y
 S X=PRCFX("X") D JDN S PRCFDLN=Y,X=PRC("SITE")_"-DLN-"_X D DLN
 S PRCFDLN=PRCFDLN_"7"_PRC("SITE")_Y K Y,%Y,DA Q
JDN ;CREATE 7 DIGIT JULIAN DATE FROM FM INTERNAL DATE
 ;REQUIRES X=FM INTERNAL DATE. RETURN Y AS JULIAN DAY NUMBER
 N DAY,DAYS,MO,YR,I,Z
 S Y=-1,DAYS="31^28^31^30^31^30^31^31^30^31^30^31"
 S YR=$E(X,1,3)+1700,MO=+$E(X,4,5),DAY=+$E(X,6,7)
 S $P(DAYS,"^",2)=$S(YR#400=0:29,(YR#4=0&(YR#100'=0)):29,1:28)
 S Z=0 F I=1:1:MO-1 Q:MO=I  S Z=Z+$P(DAYS,"^",I)
 S Y=Z+DAY,Y="000"_Y,Y=$E(Y,$L(Y)-2,$L(Y)),Y=YR_Y Q
DLN ;GET NEXT SEQUENCE NUMBER FOR JULIAN DATE
 ;REQUIRES X=PRC("SITE")_"-"_JULIAN DATE. JD must be in fromat dddy where ddd is Julian day and y is last character of year.
 ;returns next julian date for the number in Y where Y=+Y
 D NEXT Q:Y<0
 S Y="000"_Y,Y=$E(Y,$L(Y)-2,$L(Y)),%=1 Q
NEXT N PRCFX,K S K=0,Y=$O(^PRCF(421.7,"B",X,0))
 I Y="" S DIC=421.7,DIC(0)="XL",DLAYGO=DIC D ^DIC S %=0 K DIC,DLAYGO Q:Y<0
 L +^PRCF(421.7) S Y(0)=^PRCF(421.7,+Y,0),Y1=$P(Y(0),"^",2)+1,$P(^(0),"^",2,3)=Y1_"^"_DT,Y=Y1 L -^PRCF(421.7) K Y(0),Y1,X Q
MSG S PRCFX=$S($D(X)'[0:X,1:""),X="Please hold on while I find the next available number.*" D MSG^PRCFQ S X=PRCFX Q
 Q
X S %DT="AET" D ^%DT S X=Y D JDN G X
DIS N I F I=1:1:8 W !,$P($T(DIS+I),";",3,99)
 I $D(PRC("SITE")) S %A="Do you want me to get you the NEXT DLN",%B="A 'Yes' will display the next number, a 'No' or '^' will not."
 Q
DIWP(DA) ;call DIWP^PRCUTL($G(DA)) to save DA value
 D ^DIWP
 QUIT
