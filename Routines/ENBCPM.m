ENBCPM ;(WASH ISC)/DH-Driver for Bar Coded PMI Module ;1/9/2001
 ;;7.0;ENGINEERING;**21,32,68**;Aug 17, 1993
 Q
DNLOAD S ENSTA=""""_$P($G(^DIC(6910,1,0)),U,2)_""""
 I ENSTA="""""" W !,"STATION NUMBER not found in Eng Init Parm File.  Can't proceed.",*7 G EXIT
 S ENCTID="ENPM" F I=1,2,3,4,5,6,7,8 S ENSTA(I)=""""_" "_""""
 I $G(^DIC(6910,1,3,0))]"" D
 . S (I,ENX)=0 F  S ENX=$O(^DIC(6910,1,3,ENX)) Q:'ENX!(I>8)  D
 .. S I=I+1,ENSTA(I)=""""_$P(^DIC(6910,1,3,ENX,0),U)_""""
 . I I>8 W !!,"NOTE: Only the first eight (8) ALTERNATE STATION NUMBERS will be downloaded.",*7
 D:$D(ENSTA) DNLD^ENBCPM1
 K ENCTEON,ENCTEOFF,ENCTTYPE,ENCTOPEN,ENCTCLOS,ENEMP
EXIT K DIC,ENX,ENSTA,I,J,K,O,S,X,Y
 Q
 ;
 ;ENBCPM
