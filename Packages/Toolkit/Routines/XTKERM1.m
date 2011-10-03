XTKERM1 ;SF/RWF - Kermit Send a file. ;8/30/94  10:52
 ;;7.3;TOOLKIT;;Apr 25, 1995
S D BSPAR^XTKERM4,STO S XTKS("PT")="S",F1=0
 I '$D(ZTQUEUED) U IO(0) D
 . I IO=IO(0) W !,"Now start a KERMIT receive on your system.",!,"Starting [REMOTE] KERMIT send.",! H 5
 . E  W !,"Starting a [LOCAL] KERMIT send.",!
 . Q
 U IO S XTKET=$H
 F XTKERR=0:0 D @("S"_XTKS("PT")) Q:XTKERR!(XTKS("PT")="")
 S %=$H,XTKET=%-XTKET*86400+$P(%,",",2)-$P(XTKET,",",2)
 I '$D(ZTQUEUED) U IO(0) D
 . W !,"Done with ",$S(IO=IO(0):"[REMOTE]",1:"[LOCAL]")," send, File transfer ",$S('XTKERR:"was successful.",1:"failed. ("_XTKERR_")")
 . W:'XTKERR !,?10,"Bytes: ",XTKS("CCNT")," Sec: ",XTKET," cps: ",$J(XTKS("CCNT")/XTKET,3,1)
 Q
SS S XTKS("PN")=0 D SEND,RTO S XTKSDAT=XTKRDAT D SPAR^XTKERM4 S XTKS("PT")="F" Q
SF S XTKSDAT=XTKFILE D SEND,RACK:(XTKR("PN")'=XTKS("PN")) S XTKS("PT")="D" Q
SD D GDATA I 'F1 D SZ Q
 D SDATA Q
SZ S XTKSDAT="",XTKS("PT")="Z" D SEND S XTKS("PT")="B" Q:XTKERR
 Q  ;MARK FILE AS SENT.
SB S XTKSDAT="",XTKS("PT")="B" D SEND S XTKS("PT")="" Q
SEND D:XTKS("PT")'="S" BUMP D SPACK ;Fall into RACK
RACK S XTKS("TRY")=XTKS("TRY")+1 I XTKS("TRY")>XTKS("MAXTRY") G ABORT
 D RPACK^XTKERM3 I "EY"'[XTKR("PT")!XTKERR D SPACK G RACK
 I XTKR("PN")'=XTKS("PN") D SPACK G RACK
 S:"E"=XTKR("PT") XTKERR="8 Error packet" Q
 Q
SEQ S X=(XTKS("PN")'=XTKS("PN")) Q:'X  D NAK S X=1 Q
 Q
ABORT S:'XTKERR XTKERR="7 Aborting send operation" Q
BUMP S XTKS("TRY")=0,XTKS("PN")=XTKS("PN")+1#64 Q
PREV S XTKS("PN")=$S(XTKS("PN"):XTKS("PN")-1,1:63) Q
NAK S XTKS("PT")="N",XTKSDAT="" D SPACK Q
ACK S XTKS("PT")="Y",XTKSDAT="" D SPACK S XTKS("TRY")=0 Q
SPACK G SPACK^XTKERM3
RPACK G RPACK^XTKERM3
SDATA ;Send the data from the file.
 S XTKSDAT="",XTKS("SA")=X G IDATA:'XTKMODE
 I X'[XTKS("QA")&(X?1.ANP) S XTKSDAT=$E(X,1,XTKS("SIZ")),I=XTKS("SIZ")+1 G SD2
 F I=1:1:$L(XTKS("SA")) S %1=$E(XTKS("SA"),I),%2=(%1[XTKS("QA")!(%1?1C)) Q:$L(XTKSDAT)+1+%2>XTKS("SIZ")  D
 . S XTKSDAT=XTKSDAT_$S('%2:%1,%1[XTKS("QA"):%1_%1,1:XTKS("QA")_$C($A(%1)+64)),%2=0
 . Q
 S:'%2&(I=$L(XTKS("SA"))) I=I+1
SD2 S XTKS("SA")=$E(XTKS("SA"),I,999) D SEND Q:XTKERR  S X=XTKS("SA") G SDATA:X]""
 Q
IDATA F F3=0:0 S X=$E(XTKS("SA"),1,XTKS("SIZ")),XTKS("SA")=$E(XTKS("SA"),XTKS("SIZ")+1,999) D SEND Q:XTKS("SA")=""
 Q
 Q
GDATA ;Get data from global
 S @("F1=$O("_XTKDIC_"F1))") Q:F1'>0  S X=@(XTKDIC_"F1,0)"),XTKS("CCNT")=XTKS("CCNT")+$L(X) S:XTKMODE=2 X=X_$C(13) S:XTKMODE=3 X=X_$C(13,10) Q
 Q
STO ;Save timeout data for startup
 S XTKR("TOS")=XTKR("TO"),XTKR("TO")=5,XTKS("MAXTRY")=30
 Q
RTO ;Restore saved timeout
 S XTKR("TO")=XTKR("TOS"),XTKS("MAXTRY")=10 K XTKR("TOS")
 Q
