PRCNMESG ;SSI/ALA-Build Mail Messages ;[ 03/28/96  11:24 AM ]
 ;;1.0;Equipment/Turn-In Request;;Sep 13, 1996
CON ;  Get the selected concurring officials to send message to
 S CFL=0 Q:'$D(^PRCN(413,DA,5))
 S N=0 F  S N=$O(^PRCN(413,DA,5,N)) Q:'N  D
 . S CFL=1,NUM=^PRCN(413,DA,5,N,0)
 . S XMY(+^PRCN(413.3,+NUM,0))=""
 Q
FND ;  Find holders
 S PDZ="" F  S PDZ=$O(^XUSEC(KEY,PDZ)) Q:PDZ=""  S XMY(PDZ)=""
 K KEY,PDZ
 Q
MES ;  Send mail message to requestor and CMR Official
 S PRCNCMR=$P(^PRCN(413,IN,0),U,6),PRCNRQS=$P(^(0),U,2)
 S XMB(1)=$P(^PRCN(413,IN,0),U) S:$G(MSGN)=53 XMB(2)=$P(^PRCN(413,IN,0),U,18)
 S XMDUZ=DUZ,XMY(PRCNCMR)="",XMY(PRCNRQS)=""
 S XMB=$S(MSGN=39:"PRCNEQC1",MSGN=40:"PRCNEQC2",MSGN=43:"PRCNEQC3",MSGN=44:"PRCNEQC4",MSGN=53:"PRCNEQFN",1:$G(XMB))
 I $G(NOD)="" G MS
 ;  Append the explanation text to end of this mail message
 S NL=$P($G(^PRCN(413,IN,NOD,0)),U,3)
 I NL'="" F II=1:1:NL S MSG(II)=$G(^PRCN(413,IN,NOD,II,0))
MS S XMTEXT="MSG(" D ^XMB
 K NL,MSGN,II,MSG,NOD,XMY,XMDUZ,PRCNCMR,PRCNRQS,XMB
 Q
