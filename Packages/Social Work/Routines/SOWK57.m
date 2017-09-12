SOWK57 ;B'HAM ISC/MAM - DELETE FILE 658 ; 3 May 1998 7:16 am
 ;;3.0; Social Work ;**57**;27 Apr 93
 ;
 ; call EN^DIU2, delete ^DD and Data Global
 ;
 I '$D(^DIC(658)) G MSG
 S DIU=658,DIU(0)="DT" D EN^DIU2
MSG W !!,"The NURSING HOME PROFILE file (#658) has been deleted.",!
 K DIU
 Q
