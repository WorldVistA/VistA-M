VAFHPIV2 ;ALB/CM PIVOT FILE UTILITY FUNCTIONS ;5/5/95
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
SETTRAN(PIVOT) ;
 ;sets TRANSMITTED field in pivot file
 I '$D(PIVOT) Q "-1^Missing Parameter for SETTRAN function"
 N ERR,ENT,DIE,DR,DA,X,Y,CROSS
 S ENT=$O(^VAT(391.71,"D",PIVOT,""))
 I +ENT<1 S ERR="-1^NO D CROSS REFERENCE"
 I +ENT>0 D
 .S $P(^VAT(391.71,ENT,0),"^",6)=1,CROSS=0,DA=ENT
 .F  S CROSS=$O(^DD(391.71,.06,1,CROSS)) Q:'CROSS  D
 ..S X=0 X ^DD(391.71,.06,1,CROSS,2) ;kill cross reference
 ..S X=1 X ^DD(391.71,.06,1,CROSS,1) ;set cross reference
 I $D(ERR) Q ERR
 Q 0
 ;
CLNTRAN(PIVOT) ;
 ;resets TRANSMITTED field in pivot file
 I '$D(PIVOT) Q "-1^Missing Parameter for CLNTRAN function"
 N ERR,ENTRY,DA,CROSS
 S ENTRY=$O(^VAT(391.71,"D",PIVOT,"")),DA=ENTRY
 I +ENTRY<0 S ERR="-1^NO D CROSS REFERENCE"
 I +ENTRY>0 D
 .S $P(^VAT(391.71,ENTRY,0),"^",6)="",CROSS=0
 .F  S CROSS=$O(^DD(391.71,.06,1,CROSS)) Q:'CROSS  D
 ..S X=1 X ^DD(391.71,.06,1,CROSS,2) ;kill cross reference
 ..S X=0 X ^DD(391.71,.06,1,CROSS,1) ;set cross reference
 I $D(ERR) Q ERR
 Q 0
 ;
GETPIV() ;
 ;gets next available pivot number.  Get entry from MAS PARAMETER file
 ;quit returning new pivot number
 N ERR,VAR1,NEXT,FOUND
 S VAR1=$O(^DG(43,0)) I 'VAR1 Q "-1^Unable to Find Parameter One"
 F  Q:$D(FOUND)!($D(ERR))  D
 .L +^DG(43,VAR1,"HL7"):5 I '$T S ERR="-1^Unable to get next pivot number" Q
 .S NEXT=$G(^DG(43,VAR1,"HL7"))+1
 .I '$D(^VAT(391.71,NEXT)) S FOUND=""
 I $D(ERR) Q ERR
 S $P(^DG(43,VAR1,"HL7"),"^")=NEXT
 L -^DG(43,VAR1,"HL7")
 Q NEXT
