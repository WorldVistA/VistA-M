XTKERM2 ;SF/RWF - Kermit Receive a file. ;11/8/93  11:50 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
R I '$D(ZTQUEUED) U IO(0) D
 . I IO=IO(0) W !,"Now start a KERMIT send from your system.",!,"Starting [REMOTE] KERMIT receive.",!
 . E  W !,"Starting a [LOCAL] KERMIT receive.",!
 . Q
 U IO S XTKET=$H
 F XTKERR=0:0 D GET,@("R"_XTKR("PT")):'XTKERR Q:XTKERR!(XTKR("PT")="B")
 D:XTKERR RB
 S %=$H,XTKET=$H-XTKET*86400+$P(%,",",2)-$P(XTKET,",",2)
 I '$D(ZTQUEUED) U IO(0) D
 . W !,"Done with ",$S(IO=IO(0):"[REMOTE]",1:"[LOCAL]")," receive, File transfer ",$S('XTKERR:"was successful.  ("_XTKR("CCNT")_" bytes)",1:"failed. ("_XTKERR_")")
 W:'XTKERR !,?10,"Bytes: ",XTKR("CCNT")," Sec: ",XTKET," cps: ",$J(XTKR("CCNT")/XTKET,3,1)
 Q
RS S XTKS("PN")=XTKR("PN") D RPAR^XTKERM4,BSPAR^XTKERM4 S XTKS("PT")="Y" D SPACK,BUMP Q
RF D SEQ Q:X  S X=XTKRDAT D FILE,ACK,BUMP Q
RD D SEQ Q:X  D STORE,ACK,BUMP Q
RZ D SEQ G:X ABORT S XTKRDAT="" D STORE:XTKR("SA")]"",ACK,BUMP,CLOSE Q
RB D SEQ Q:X  D ACK Q
RY ;
RN ;
RE G ABORT
SEQ S X=(XTKR("PN")'=XTKS("PN")) Q:'X  D NAK S X=1 Q
 Q
GET S XTKR("TRY")=XTKR("TRY")+1 I XTKR("TRY")>XTKR("MAXTRY") G ABORT
 D RPACK^XTKERM3
 I XTKERR D NAK G GET
 I "SFEDNZYB"'[XTKR("PT") S XTKERR="6 Unknown packet type" Q
 Q
ABORT S:'XTKERR XTKERR="5 Aborting receive operation" Q
BUMP S XTKR("TRY")=0,XTKS("PN")=XTKS("PN")+1#64 Q
PREV S XTKS("PN")=$S(XTKS("PN"):XTKS("PN")-1,1:63) Q
NAK S XTKS("PT")="N",XTKSDAT="" D SPACK Q
ACK S XTKS("PT")="Y",XTKSDAT="" D SPACK S XTKR("TRY")=0 Q
SPACK G SPACK^XTKERM3
RPACK G RPACK^XTKERM3
FILE ;See if need to change file name.
 I XTKDIC["DIZ(8980,",XTKR("RFN")="y" S XTKFILE(0)=XTKFILE,XTKFILE=X
 ;Other wise toss file name we don't need it.
 ;I XTKDIC'["^DIZ(8980," S X="KERMIT File Name: "_X D PDATA ;Old, just store the file name.
 Q
STORE ;Store the data (XTKRDAT) in file.
 I 'XTKMODE S X=XTKRDAT D PDATA Q
 F I=0:0 S I=$F(XTKRDAT,XTKR("QA"),I) Q:I<1  S X=$E(XTKRDAT,1,I-2),Y=$E(XTKRDAT,I) D TEXT:XTKMODE=2,REPLACE:XTKMODE=1
 S X="" S:$L(XTKRDAT)+$L(XTKR("SA"))'>245 XTKR("SA")=XTKR("SA")_XTKRDAT,XTKRDAT="" S:$L(XTKRDAT)+$L(XTKR("SA"))>245 X=XTKR("SA"),XTKR("SA")=XTKRDAT,XTKRDAT="" S:XTKR("PT")="Z" X=XTKR("SA")
 D:X]"" PDATA Q
 ;Y=M end of line, L form feed, J line feed, other make into control
TEXT I "L"[Y D TX2 S X="|TOP|" D PDATA Q
 I "M"'[Y S XTKRDAT=X_$S(Y=XTKR("QA"):Y,"J"[Y:"",1:$C($A(Y)-64))_$E(XTKRDAT,I+1,999),I=I-(Y'=XTKR("QA")) Q
TX2 I $L(XTKR("SA")) S X1=XTKR("SA"),X2=X,Z=245-$L(X1),X=X1_$E(X2,1,Z),XTKR("SA")=$E(X2,Z+1,999)
 D PDATA S X="" G TX2:$L(XTKR("SA")) S XTKRDAT=$E(XTKRDAT,I+1,999),I=0 Q
PDATA ;Put data in global
 S DWLC=DWLC+1,@(XTKDIC_"DWLC,0)")=X,XTKR("CCNT")=XTKR("CCNT")+$L(X) Q
 Q
REPLACE S XTKRDAT=X_$S(Y=XTKR("QA"):Y,1:$C($A(Y)-64))_$E(XTKRDAT,I+1,999),I=$L(X)+(Y=XTKR("QA")) Q
 Q
CLOSE ;Close and update the filename if file 8980
 I XTKDIC["DIZ(8980,",XTKR("RFN")="y" S $P(^DIZ(8980,XTKDA,0),"^",1)=XTKFILE,^DIZ(8980,"B",$E(XTKFILE,1,30),XTKDA)="" K ^DIZ(8980,"B",XTKFILE(0),XTKDA)
 S @("X=$S($D("_XTKDIC_"0)):^(0),1:"""")"),^(0)=$P(X_"^^",U,1,2)_U_DWLC_U_DWLC
 Q
