%ZOSVKSS ;OAK/KAK - Automatic INTEGRIT Routine (cont.) (Cache) ;5/9/07  10:44
 ;;8.0;KERNEL;**90,94,197,268,456**;Jul 26, 2004
 ;
 ; Version for Cache
 ;
RESTART ;-- called by routine C+6^%ZOSVKSE
 ; 
 ;-- code from routine CHECKPNT
 ;
 K SUB,C
 N B,D,E,FLAG,LE,LL,LN,LNP,TL1
 ;
 S (ERR,FLAG,NP,NB,LSNP,LNB)=0
 ;
 S X="",@^%ZOSF("TRAP")
 ;
 V BLK
 S A=$V(2,-5)
 V A
 S A=",,"_($V(2043,0,1)*16777216+A)_","
 ;
 S X="ERR^%ZOSVKSS",@^%ZOSF("TRAP")
 ;
CHK Q:+$G(^XTMP("KMPS","STOP"))
 ;
 V BLK
 S LINK=$V(2040,0,"3O")
 S A=$V($P(A,",",3),-7,$P(A,",",4),400)
 S TL=$P(A,",",3)\16777216
 S NP=NP+A,NB=NB+$P(A,",",2)
 ;
 ; big global data blocks (type 12)
 I FLAG=0,(TL=8)!(TL=12) S FLAG=1 V BLK S B=$V(2,-5) D
 .F  Q:'B  V B S B=$V(2040,0,"3O") F N=1:1 Q:$V(N-1*2+1,-6)=""  S X=$V(N-1*2+2,-6) S:$A(X)=3 LNB=LNB+($A(X,2)*2048)+$ZWA(X,3),LSNP=LSNP+$A(X,2)+1
 ;
CHKB I LINK S BLK=LINK G CHK
 ;
 ; ragged edge
 I $P(A,",",3)#16777216,$P(A,",",3)\16777216-16 G ER6
 ;
END S X="",@^%ZOSF("TRAP")
 ;
 ; W "# ptrs = "_NP
 S LNBLK=+$G(LNBLK)
 ; na% => cannot calculate the percent efficiency of first pointer block
 I CUR=1 S ^XTMP("KMPS",KMPSSITE,NUM,$P(GLO,"^"),KMPSZU,KMPSDT,CUR)="1^na%^Pointer"
 I (NBLK+LNBLK) D
 .; W ", # blks = "_(NBLK+LNBLK)_", # ptrs/blk = "_(NP\(NBLK+LNBLK))
 .; W ", eff = "_(((NBYTE+LNBYTE)*100)\((2036*NBLK)+(2048*LNBLK)))_"%"
 .S ^XTMP("KMPS",KMPSSITE,NUM,$P(GLO,"^"),KMPSZU,KMPSDT,CUR)=(NBLK+LNBLK)_"^"_(((NBYTE+LNBYTE)*100)\((2036*NBLK)+(2048*LNBLK)))_"%^"_$S(CUR=(LEV-1):"Bottom p",1:"P")_"ointer"
 S TL=$P(A,",",3)\16777216
 ;
 ; m-code blocks (type 16) - do not store into ^XTMP("KMPS")
 ; I TL=16 W "Routine level:  # rtns = "_NP
 ;
 ; global data blocks (type 8) and big global data blocks (type 12)
 I TL=8!(TL=12) D
 .; I NP W "Data level:  # blks = "_NP_", eff = " W:NP (NB*100\(2036*NP))_"%"
 .I NP S ^XTMP("KMPS",KMPSSITE,NUM,$P(GLO,"^"),KMPSZU,KMPSDT,"D")=NP_"^"_$S(NP:NB*100\(2036*NP),1:"")_"%^Data"
 .; I LSNP W "Long String level: # blks = "_LSNP_",eff = " W:LSNP (LNB*100\(2048*LSNP))_"%"
 .I LSNP S ^XTMP("KMPS",KMPSSITE,NUM,$P(GLO,"^"),KMPSZU,KMPSDT,"L")=LSNP_"^"_$S(LSNP:LNB*100\(2048*LSNP),1:"")_"%^LongString"
 S NBLK=NP,LNBLK=LSNP,NBYTE=NB,LNBYTE=LNB
 Q
 ;-- end code from routine CHECKPNT
 ;
ERR ;-- code from routine CHECK0
 ;
 S (LE,LL,ERR)=0
 ;
 ; global is too large for INTEGRIT - use ^DIAG to check this global
 I $ZE?1"<MAXARRAY>".E S ERR=1 Q
 ;
 S D=BLK,LN=$P(A,",",4),TL=$P(A,",",3)\16777216
 ;
 S X="ERROR^%ZOSVKSS",@^%ZOSF("TRAP")
 ;
 V BLK
 D CHECK1
 Q:ERR
 ;
 K B
 F I=1:2:C-2 S B=C(I)-1#400,B(C(I)-B,B)=""
 D CM(1)
 Q:ERR
 ;
 K B
 F I=1:2:C-2 I C(I,1) D MB
 D CM(249)
 Q:ERR
 ;
 K B
 S NP=C\2+NP,NB=NB+LE,A=",,"_(TL*16777216+LL)_","_LN
 K C
 ;
 S X="ERR^%ZOSVKSS",@^%ZOSF("TRAP")
 ;
 G CHKB
 ;
ERROR I $ZE?1"<DISK".E!($ZE?1"<DATA".E) G ERDK
 G MISC
 ;
CM(X) S D=""
 F I=1:1 S D=$O(B(D)) Q:D=""  V D D ER15:$V(2038,0,"4O")-1431699455!($V(2042,0,"4O")=0) Q:ERR  S B="" F J=1:1 S B=$O(B(D,B)) Q:B=""  I $V(B,0)'=X,$V(B,0)'=255 D ER5
 Q
 ;
MB N A,X,L,BL,J,K,R
 ;
 V C(I)
 F J=1:2 Q:$V(J,-6)=""  S X=$V(J+1,-6) I $E(X)=3 D
 .S N=$A(X,2),A=4,L=A+((N+1)*3) I L'=$L(X) D ER18 Q
 .S R=$A(X,4)*256+$A(X,3) I (R<1)!(R>2048) D ER19
 .F K=0:1:N S BL=(((($A(X,A+3)*256)+$A(X,A+2))*256)+$A(X,A+1)),A=A+3 S B=BL-1#400 I $D(B(BL-B,B)) D ER20 S B(BL-B,B)=C(I)_","_J_","_K
 Q
 ;-- end code from routine CHECK0
 ;
CHECK1 ;-- code from routine CHECK1
 ;
 F C=1:2 Q:$V(C,-5)=""  S SUB(C)=$V(C,-5)
 F I=1:2:C-2 D
 .S C(I)=$V(I+1,-6),C(I,1)=C(I)\8388608#2,C(I)=C(I)#8388608
 .I C(I)=BLK G ER10
 I $P(A,",",3)#16777216-C(1),$P(A,",",3)\16777216-16 G ER3
 F E=1:2:C-2 S D=C(E) V D D CH Q:ERR
 I TL=16,LINK S D=LINK V D S LL=$V(2,-5)
 Q
 ;
CH I $V(0,0)#256 G ER7
 S TL1=$V(2043,0,1)
 I (TL=8)!(TL=12) D
 .I 'C(E,1),TL1'=8 G ER16
 .I C(E,1),TL1'=12 G ER17
 I (TL-8),(TL-12),$V(2043,0,1)-TL G ER12
 S LE=LE+$V(2046,0,2)
 I $V(1,-5)'=SUB(E) G ER8
 Q:TL=16
 S LL=$V(2040,0,"3O") I E+2<C,LL-C(E+2) G ER9
 I $V(1,-6)']LN G ER1
 S LN=$V(-1,-6),LNP=$V(-1,-5)
 Q
 ;-- end code from routine CHECK1
 ;
 ;-- code from routine CHECKERR
 ;
ER1 ; error: the first node in block D is $V(1,-5) and it should collate after the previous block's last node, which was LNP        
 S KMPSERR4="ER1",ERR=1
 Q
ER3 ; error: pointer block BLK has a first pointer of C(1) [ The node is SUB(1) ] but the link from the previous lower level block is $P(A,",",3)#16777216  
 S KMPSERR4="ER3",ERR=1
 Q
ER5 ; block B+D, which is pointed to by block BLK appears to be available in map block D - checking of this global will continue
 S KMPSERR4="ER5"
 I '$V(B,0) Q
 ; block B+D, which is pointed to by block BLK has code $V(B,0) in the map block D whereas code X was expected - checking of this global will continue
 Q
ER6 ; error: pointer block BLK should have had a right link
 ; V BLK F I=1:2 Q:$V(I,-6)=""
 ; according to the lower level block $V(I-1,-5), which had a link to block $P(A,",",3)#16777216
 S KMPSERR4="ER6",ERR=1
 Q
ER7 ; error: the 1st byte of block D should have been zero - the pointer block was BLK
 S KMPSERR4="ER7",ERR=1
 Q
ER8 ; error: the lower block's first node didn't match the pointer node - node E+1\2 in pointer block BLK was: SUB(E) - the 1st node in the lower level block D was: $V(1,-5)
 S KMPSERR4="ER8",ERR=1
 Q
ER9 ; error: the link in block D is LL although the pointer block BLK specifies that C(E+2) should be the next block
 S KMPSERR4="ER9",ERR=1
 Q
ER10 ; error: node I+1\2 in block BLK points to itself - the node is: SUB(I)
 S KMPSERR4="ER10",ERR=1
 Q
ER12 ; error: block D, which is pointed to by pointer block BLK has a block type of $V(2043,0,1) whereas a block type of TL was expected
 S KMPSERR4="ER12",ERR=1
 Q
ER15 ; error: map block D does not have a correct map label - the pointer block was BLK
 S KMPSERR4="ER15",ERR=1
 Q
 ;
ER16 ; block D, which is pointed to by pointer block BLK has a block type of $V(2043,0,1) whereas a block type of 8 was expected since the pointer block say big data nodes are not present
 ; checking of this global will continue if $V(2043,0,1)=12
 I $V(2043,0,1)=12 Q
 ; else error
 S KMPSERR="ER16",ERR=1
 Q
 ;
ER17 ; block D, which is pointed to by pointer block BLK has a block type of $V(2043,0,1),whereas a block type of 12 was expected since the pointer block says big data nodes are present
 ; checking of this global will continue if $V(2043,0,1)=8
 I $V(2043,0,1)=8 Q
 ; else error
 S KMPSERR="ER17",ERR=1
 Q
 ;
ER18 ; node J+1\2 in big data block C(I), which is pointed to by block BLK says number of data blocks is  N, but length of node is $L(X) rather than L
 ; this big string node will not be checked - checking of this global will continue
 Q
 ;
ER19 ; node J+1\2 in big data block C(I), which is pointed to by block BLK says it has R bytes in last block, which is illegal - checking of this global will continue        
 Q
 ;
ER20 ; node J+1\2 in big data block C(I), which is pointed to by block BLK has data block BL which is also used as data block $P(B(BL-B,B),",",3) in node $P(B(BL-B,B),",",2)+1\2 of block $P(B(BL-B,B),",",1)
 ; checking of this global will continue
 Q
 ;
ERDK ; if D-BL error in lower block D - pointer block is BLK
 ; else error in pointer block D - last node in prev pntr block was LNP
 S KMPSERR="ERDK",ERR=1
 Q
 ;
MISC ; misc error
 S KMPSERR="MISC",ERR=1
 Q
