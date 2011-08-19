SROAC1 ;B'HAM ISC/MAM - NON-CARDIAC COMPLICATIONS ; 4 MAR 1992 8:10 am
 ;;3.0; Surgery ;;24 Jun 93
RESP ; respiratory complications
 F I=10:1:13 S $P(^SRF(SRTN,205),"^",I)=$S(X="":"",X="NS":"NS",1:"N")
 S $P(^SRF(SRTN,205),"^",14)=""
 Q
URINE ; urine complications
 F I=16,17,18 S $P(^SRF(SRTN,205),"^",I)=$S(X="":"",X="NS":"NS",1:"N")
 S $P(^SRF(SRTN,205),"^",19)=""
 Q
CNS ; CNS complications
 F I=21,22,23 S $P(^SRF(SRTN,205),"^",I)=$S(X="":"",X="NS":"NS",1:"N")
 S $P(^SRF(SRTN,205),"^",24)=""
 Q
CARD ; cardiac complications
 F I=26,27,28 S $P(^SRF(SRTN,205),"^",I)=$S(X="":"",X="NS":"NS",1:"N")
 S $P(^SRF(SRTN,205),"^",29)=""
 Q
OTHER ; other complications
 F I=31:1:35 S $P(^SRF(SRTN,205),"^",I)=$S(X="":"",X="NS":"NS",1:"N")
 S $P(^SRF(SRTN,205),"^",36)=""
 Q
