XUSC1S1 ;ISCSF/RWF - Read data ;04/01/2002  17:13
 ;;8.0;KERNEL;**283**;Jul 10, 1995
 Q
DATA(ROOT,STAT) ;get Data
 N I,M
 D DCODE(XUSCDAT),TRACE^XUSC1S("DECODE "_XUSCDAT)
 ;Check if data type is OK
 ;I ...
 F I=1:1 S M=$$DREAD() Q:XUSCER!M  S @ROOT@(I)=XUSCDAT
 ;If we got it all
 D SEND^XUSC1S($S(XUSCER:"500 Data error",1:"220 OK"))
 Q
 ;
SDATA(ROOT,TYPE) ;Send data from a source
 N X,Y,L,D
 S ROOT=$NA(@ROOT),X=ROOT,Y=$E(ROOT,1,$L(ROOT)-1),XUSCER=0
 D SEND^XUSC1S("DATA PARAM="_TYPE)
 S X=ROOT
 F  S X=$Q(@X) Q:$E(X,1,$L(Y))'=Y  D DSEND(@X)
 D ESEND ;Tell other end we'r done
 Q
DCODE(D) ;Decode a DATA string
 S D=$$UP^XLFSTR(D),D=$P(D,"PARAM=",2,99)
 F I=1:1 S STAT("P"_I)=$P(D,",",I) Q:$P(D,",",I+1)=""
 Q
DREAD() ;Data read
 N L,D,R S (D,XUSCDAT)="",XUSCER=0
 S L=$$LREAD(3) Q:XUSCER 1
 I L<0 S XUSCDAT="" Q 1
 I L'?3N S XUSCER="1 Out of sync: "_L Q 1
 I L>0 S XUSCDAT=$$LREAD(L)
 Q 0
DSEND(D) ;Data send
 N L
 S L=$L(D),L=$E(1000+L,2,4)
 W L,D,! ;Flush buffer
 Q
ESEND ;Send end of data message
 W "-10",!
 Q
LREAD(N) ;Read N char
 N D,C,P S D="",C=N,XUSCER=0
 F  D  Q:'C!XUSCER
 . R P#C:XUSCTIME E  S XUSCER=1 Q
 . D TRACE^XUSC1S("LREAD "_$A(P)) ;*rwf
 . S D=D_P,C=N-$L(D)
 . Q
 Q D
