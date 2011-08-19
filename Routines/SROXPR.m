SROXPR ;B'HAM ISC/MAM - RESTRICTED PERSON FIELDS ; 26 DEC 1991  9:15 AM
 ;;3.0; Surgery ;;24 Jun 93
KEY ; determine whether field is restricted
 K SROK I +Y<1 Q
 I $O(^SRP("AX",RESTRICT,0))="" S SROK=1 Q
 S KEY=0 F  S KEY=$O(^SRP("AX",RESTRICT,KEY)) Q:KEY=""!($D(SROK))  I $D(^XUSEC(KEY,Y)) S SROK=1
END K RESTRICT,ENTRY,KEY
 Q
XREF ; set logic for 'AX' cross reference in file 131
 S SRENTRY=$P(^SRP(DA(1),0),"^"),^SRP("AX",SRENTRY,X,DA(1))="" K ENTRY
 Q
KXREF ; kill logic for 'AX' cross reference in file 131
 S SRENTRY=$P(^SRP(DA(1),0),"^") K ^SRP("AX",SRENTRY,X,DA(1)),SRENTRY
 Q
