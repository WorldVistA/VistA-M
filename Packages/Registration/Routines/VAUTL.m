VAUTL ;ALB/MRL - UTILITY FUNCTIONS; 13 APR 89
 ;;5.3;Registration;;Aug 13, 1993
 ;
FA ;Format Address
 ;REQUIRED VARIABLES = VADN-Address node; VAD(1)=Start with Piece;
 ;VAD(2)=Build array starting where
 ;RETURNS 'VADD' Array containing formated address information
 ;OPTIONAL = VAEXT-Numeric number of characters to extract
 ;
 F I=VAD(1):1:VAD(1)+2 I $P(VADN,"^",I)]"" S VADD(VAD(2))=$P(VADN,"^",I),VAD(2)=VAD(2)+2
 I VAD(2)=1 S VADD(1)="NO STREET",VAD(2)=VAD(2)+2
 S J=$S($D(^DIC(5,+$P(VADN,"^",VAD(1)+4),0)):$P(^(0),"^",2),1:"NO STATE"),J(1)=$P(VADN,"^",VAD(1)+3) S:J(1)']"" J(1)="NO CITY" S J(2)=$P(VADN,"^",VAD(1)+5) S:J(2)']"" J(2)="NO ZIP"
 S VADD(VAD(2))=J(1)_","_J_" "_J(2) K I,J,VAD,VADN I $S('$D(VAEXT):1,'VAEXT:1,1:0) Q
 ;
 S I=0 F I1=0:0 S I=$O(VADD(I)) Q:I'>0  S VADD(I)=$E(VADD(I),1,VAEXT)
 K I,I1,VAEXT Q
 ;
PA ;Print Address
 S I=0 F I1=0:0 S I=$O(VADD(I)) Q:I'>0  W:(I#2) ! S I2=$S((I#2):0,1:40) W ?I2,VADD(I)
 K I,I1,I2,VADD Q
