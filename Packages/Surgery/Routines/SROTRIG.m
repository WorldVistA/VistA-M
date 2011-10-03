SROTRIG ;B'HAM ISC/MAM - TRIGGERS FOR CONCURRENT CASES ; 21 AUG 1990
 ;;3.0; Surgery ;;24 Jun 93
 I '$D(^SRF(DA,"CON")) Q
 S SRCON=$P(^SRF(DA,"CON"),"^") I 'SRCON Q
 K DIV S (DIV,Y(0))=X,(D0,DIV(0))=DA
 S Y(1)=^SRF(D0,0),X=$P(Y(1),"^",3),DIU=X K Y
 S Y(1)=";"_$P(^DD(130,.011,0),"^",3),X=$P($P(Y(1),";"_DIV_":",2),";")
 S DIH=130,DIG=.03
