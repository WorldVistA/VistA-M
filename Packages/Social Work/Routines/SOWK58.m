SOWK58 ;B'HAM ISC/MAM - DELETE FILE 657 ; 24 July 1998 7:16 am
 ;;3.0; Social Work ;**58**;27 Apr 93
 ;
 ; call EN^DIU2, delete ^DD and Data Global
 ;
 I '$D(^DIC(657)) G MSG
 S DIU=657,DIU(0)="DT" D EN^DIU2
MSG W !!,"The CNHC COST CONTROL file (#657) has been deleted.",!
 K DIU
 Q
