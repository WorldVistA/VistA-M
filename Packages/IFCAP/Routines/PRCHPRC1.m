PRCHPRC1 ;WISC/DJM-FILE 442 CONVERSION ROUTINE, CONTINUED ;1/15/95  1:40 PM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
BBFY(A,B,C) ;A=station #, B=fcp#, C=1 if display available year
 ;EF value ~1=0-node of file 420.14, ~2=fcp bbfy, ~3=length of fund, ~4=default year
 N D,E,F,G,H,I,J
 S D=$G(^PRC(420,+A,1,+B,5)) I D="" QUIT ""
 S E=+$$DATE^PRC0C($P(D,"^",8),"I")
 S F=$$FUND^PRC0C($P(D,"^",1),E) I F="" QUIT ""
 S $P(F,"~",2)=E,G=$P(F,"^",5)-$P(F,"^",4)+1,$P(F,"~",3)=G
 S J=+$$DATE^PRC0C($H,"H"),$P(F,"~",4)=J
 I C D
 . F I=J-G+1:1:J+G+1 Q:I-E#G=0
 . S E=I,I="" F H=-3*G+E:G:3*G+E S I=I_H_"    " S:H'>J $P(F,"~",4)=H
 . QUIT
 QUIT F
