SPNLSCRN ;HIRMFO/WAA - Display Patient data ;5/17/96  10:14
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
 ;;
V1(IEN) ;
 S VIEW=0
 W !,"IEN"=IEN,!
 W !,"^SPNL(154.2,"_IEN_",0)=",^SPNL(154.2,IEN,0)
 I $P(^SPNL(154.2,IEN,0),U,2)="1" S VIEW=1
 Q VIEW
