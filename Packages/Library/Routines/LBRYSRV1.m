LBRYSRV1 ;SSI/ALA-LIBRARY SERVER PROGRAM ;[ 04/19/2000  10:46 AM ]
 ;;2.5;LIBRARY;**8**;Mar 11, 1996
 ;
IN ;  Put index sources information into transaction file
 X XMREC I $P(XMRG,U)="$" Q
 Q:$P(XMRG,U)'="IS"
 D TRN^LBRYUTL
 S NL=$P(XMRG,U,2),^LBRY(682.1,LBRYDA,6,NL,0)=$P(XMRG,U,4,6)
 S TAF=$P(XMRG,U,3),$P(^LBRY(682.1,LBRYDA,1),U,2)=TAF,TIT=$P(XMRG,U,4)
 G IN
 ;
PU ;  Put publisher records into transaction file
 X XMREC I $P(XMRG,U)="$" Q
 Q:$P(XMRG,U)'="PU"
 D TRN^LBRYUTL
 S TAF=$P(XMRG,U,3),TIT=$P(XMRG,U,4),IDA=$P(XMRG,U,5)
 S $P(^LBRY(682.1,LBRYDA,1),U,2)=TAF,$P(^(1),U,3)=IDA,$P(^LBRY(682.1,LBRYDA,4),U)=TIT
 G PU
 ;
FR ;  Put frequencies into transaction file
 X XMREC I $P(XMRG,U)="$" Q
 Q:$P(XMRG,U)'="FR"
 D TRN^LBRYUTL
 S TAF=$P(XMRG,U,3),IDA=$P(XMRG,U,6)
 S $P(^LBRY(682.1,LBRYDA,1),U,2)=TAF,$P(^(1),U,3)=IDA
 S $P(^LBRY(682.1,LBRYDA,2),U)=$P(XMRG,U,4)
 S $P(^LBRY(682.1,LBRYDA,4),U,4)=$P(XMRG,U,5),TIT=$P(XMRG,U,5)
 G FR
 ;
PR ;  Put prediction patterns into transaction file
 S LEV=""
PR1 X XMREC I $P(XMRG,U)="$" Q
 S SEQ=$P(XMRG,U,2)
 I LEV'=SEQ D TRN^LBRYUTL S LEV=SEQ
 I $P(XMRG,U)="PP" D
 . S TAF=$P(XMRG,U,3),$P(^LBRY(682.1,LBRYDA,1),U,2)=TAF
 . S ^LBRY(682.1,LBRYDA,5)=$P(XMRG,U,5,11)
 . S TIT=$P(XMRG,U,4),$P(^LBRY(682.1,LBRYDA,4),U,5)=TIT
 I $P(XMRG,U)="PP2" D
 . S $P(^LBRY(682.1,LBRYDA,5),U,8)=$P(XMRG,U,3)
 . S $P(^LBRY(682.1,LBRYDA,4),U,6)=$P(XMRG,U,4)
 . S TIT=$P(XMRG,U,4)_"  "_TIT,$P(^LBRY(682.1,LBRYDA,1),U,3)=$P(XMRG,U,5)
 I $P(XMRG,U)="PP3" D
 . S NL=$P(XMRG,U,3),TEX=$P(XMRG,U,4),^LBRY(682.1,LBRYDA,8,NL,0)=TEX
 G PR1
