ENEQNX ;(WASH ISC)/DH-Equipment Inventory Driver ;1/9/2001
 ;;7.0;ENGINEERING;**21,68**;Aug 17, 1993
INIT S:'$D(DTIME) DTIME=600 S ENERR=0,IOP="HOME",U="^" D ^%ZIS K IOP Q
DNLD S ENSTA=""""_$P($G(^DIC(6910,1,0)),U,2)_""""
 I ENSTA="""""" W !,"STATION NUMBER not found in Eng Init Param File.  Can't proceed.",*7 G EXIT
 S ENCTID="ENNX" F I=1,2,3,4,5,6,7,8 S ENSTA(I)=""""_" "_""""
 I $G(^DIC(6910,1,3,0))]"" D
 . S (I,ENX)=0 F  S ENX=$O(^DIC(6910,1,3,ENX)) Q:'ENX!(I>8)  D
 .. S I=I+1,ENSTA(I)=""""_$P(^DIC(6910,1,3,ENX,0),U)_""""
 . I I>8 W !!,"NOTE: Only the first eight (8) ALTERNATE STATION NUMBERS will be downloaded.",*7
 D:$D(ENSTA) ^ENCTBAR
EXIT K DIC,ENERR,ENSTA,ENX,I,J,K,O,S,X,Y
 Q
 ;ENEQNX
