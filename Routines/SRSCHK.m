SRSCHK ;B'HAM ISC/MAM - CHECK FOR REQUIRED FIELDS ; 27 DEC 1991  12:30 PM
 ;;3.0; Surgery ;;24 Jun 93
 K NOWAY I '$O(^SRO(133,SRSITE,4,0)) Q
 S (SRFIELD,CNT)=0 F  S SRFIELD=$O(^SRO(133,SRSITE,4,SRFIELD)) Q:'SRFIELD  S FIELD=$P(^SRO(133,SRSITE,4,SRFIELD,0),"^") D CHECK
 I $D(NOWAY) W !!,"This case cannot be scheduled until the missing information has been entered.",!!,"Press RETURN to continue  " R X:DTIME
 Q
CHECK ; check each field for data
 S FNAME=$P(^DD(130,FIELD,0),"^"),GLOBAL=$P(^DD(130,FIELD,0),"^",4),Y=$P(GLOBAL,";",2) I Y=0 D MULT Q
 S SUB=$P(GLOBAL,";"),PIECE=$P(GLOBAL,";",2) I $P($G(^SRF(SRTN,SUB)),"^",PIECE)="" S CNT=CNT+1 W:CNT=1 ! W !,"The field '"_FNAME_"' has not been entered." S NOWAY=1
 Q
MULT ; check multiple
 S SUB=$P(GLOBAL,";") I '$O(^SRF(SRTN,SUB,0)) S CNT=CNT+1 W:CNT=1 ! W !,"The field '"_FNAME_"' has not been entered." S NOWAY=1
 Q
