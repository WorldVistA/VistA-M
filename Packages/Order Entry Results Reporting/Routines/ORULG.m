ORULG ; SLC/KER/JVS - COLUMNAR GLOBAL LISTING BY PIECE ;; 08-19-92
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**18**;Dec 17, 1997
 ;
 ; Variables passed
 ;  ROOT  Global file root, i.e., "^XXX(SUB1,SUB2,SUBX,"
 ;  PIE   Pieces to display, i.e, "1" or "1^2^4" (Default 1)
 ;  HDR   Display title (Default first piece of 0 node)
 ;  COL   Number of columns to display (Default 1)
 ;
EN(ROOT,PIE,HDR,COL) ; Entry Point - device selection not allowed
 N X,PRTR S PRTR=0
 G INIT
ENP(ROOT,PIE,HDR,COL) ; Entry Point - device selection allowed
 N X,PRTR S PRTR=1
 ;
INIT ;
 D HOME^%ZIS N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 NEW CC,CF,CL,CP,CONT,ELE,END,FMTPG,FPG,FREF,IDX,ITEM,LNS,MDY,M2,M3,M4
 NEW N0,NLC,NR,NT,PAGES,PGNO,PREF,PNM,POP,PPG,RECNR,RPC,RT,SN,SNODE,TWD,UW
 S MDY=$$MDY() W @IOF
VAL ;
 S:$E(ROOT,1)'="^" ROOT="^"_ROOT
 S ROOT=$S($E(ROOT,$L(ROOT))=",":$E(ROOT,1,($L(ROOT)-1))_")",($E(ROOT,$L(ROOT))'=","&($E(ROOT,$L(ROOT))'=")")):ROOT_")",1:ROOT) I '$D(@ROOT) W !!,"Global ",ROOT," not found",!! G END
 I $E(ROOT,$L(ROOT))=")" S ROOT=$P(ROOT,")",1),RT=ROOT_","
 S IDX=0,SNODE=ROOT_",0)"  S:$O(@SNODE)'?1N.N IDX=1
 I IDX S N0=$P(SNODE,",",1,($L(SNODE,",")-2))_",0)"
 I 'IDX&(($D(@SNODE)=11)!($D(@SNODE)=1)) S N0=SNODE
 I 'IDX&(($D(@SNODE)=10)!($D(@SNODE)=0)) W !,"Not a valid Fileman Global" G END
 S:HDR=""&($D(@N0)=1!($D(@N0)=11)) HDR=$P(@N0,"^",1) S:HDR=""&($D(@N0)'=1&($D(@N0)'=11)) HDR="GENERIC LISTING" S HDR=$$UPPER(HDR)
 I 'PRTR G START
OPEN ;
 K IOP,%ZIS S %ZIS="NQM",%IS("B")="" D ^%ZIS K %ZIS
 I POP W !,$C(7),"Terminated.  No device specified." G END
 S IOP=ION_";"_IOST_$S($D(IO("DOC")):";"_IO("DOC"),1:";"_IOM_";"_IOSL)
 I IO=IO(0),"C"[$E(IOST),$D(IO("Q"))#2 G START
 I IO'=IO(0),'$D(IO("Q")) W !!,"Queueing report" S IO("Q")=1,ZTDTH=$H
 I '$D(IO("Q")) D ^%ZIS G START
 S ZTRTN="START^ORULG",ZTIO=IOP,ZTDESC="GLOBAL LISTING (ORULG)"
 S (ZTSAVE("ROOT"),ZTSAVE("HDR"),ZTSAVE("RT"),ZTSAVE("N0"),ZTSAVE("PIE"),ZTSAVE("COL"),ZTSAVE("MDY"),ZTSAVE("IDX"))=""
 K IO("Q") D ^%ZTLOAD D HOME^%ZIS G END
NY S %="N" D RD Q:"^YyNn"[X
 W !,"Enter 'N' or return for NO, 'Y' for YES" G NY
RD R X:DTIME S:X["^" X="^" S X=$E(X_%) Q
START ;
 I IOST["C-" W @IOF
 S:'$D(COL) COL=1 S:COL=""!(+COL>4)!(+COL=0) COL=1 S NT=((COL*6)+(4*(COL-1))),UW=IOM-NT
 F CC=UW:-1 Q:((CC#4=0)&(CC#3=0))
 S TWD=(CC/COL)+1,M2=TWD+5,M3=M2+9+TWD,M4=M3+9+TWD
 S NR=$P(@N0,"^",$L(@N0,"^")),LNS=IOSL-8,FPG=NR\(COL*LNS),PPG=$S(NR#(COL*LNS)=0:(NR/(COL*LNS))-FPG,1:((NR\(COL*LNS))+1)-FPG)
 S RPC=(NR#(COL*LNS))\COL,NLC=(NR#(COL*LNS))#COL,PNM=$S(PIE'["^"&(PIE'=""):1,PIE="":1,1:$L(PIE,"^"))
 F CP=1:1:PNM S PREF="PIE"_CP NEW @PREF S @PREF=$S(PNM=1:PIE,1:$P(PIE,"^",CP))
STORE ;
 S (PGNO,ITEM,RECNR)=0 F CF=1:1:FPG S PGNO=PGNO+1 D
 . F CC=1:1:COL D
 . . F CL=1:1:LNS S SN=ROOT_","_RECNR_")" Q:(('IDX)&(+($O(@SN))=0))!((IDX)&($O(@SN)=""))  D
 . . . S ELE="",RECNR=$O(@SN) D ELE S:+RECNR=0!((+RECNR)'=RECNR) RECNR=$C(34)_RECNR_$C(34)
 I PPG S PGNO=PGNO+1 D
 . F CC=1:1:COL D
 . . F CL=1:1:LNS S SN=ROOT_","_RECNR_")" Q:(('IDX)&(+($O(@SN))=0))!((IDX)&($O(@SN)=""))  D
 . . . S ELE="",RECNR=$O(@SN) D ELE S:+RECNR=0!((+RECNR)'=RECNR) RECNR=$C(34)_RECNR_$C(34)
CNTRL ;
 S (PGNO,ITEM,RECNR)=0,CONT="",END=$S(PPG:FPG+2,1:FPG+1)
 F PGNO=1:1:END Q:CONT="^"  S:CONT="-" CONT="",PGNO=$S(PGNO<3:1,1:PGNO-2) Q:PGNO=END  D CENTER(HDR) S FMTPG=$$PGFMT(PGNO) W !,MDY,?(IOM-($L("PAGE:  "_FMTPG))),"PAGE:  ",FMTPG,! D  D DISP,CONT
 . F CC=1:1:IOM W "-" W:CC=IOM !
END ;
 I IOST["C-" W @IOF
 K ZTSK,IOP,%IS Q
DISP ;
 F CL=1:1:LNS D
 . W:$D(PAGES(PGNO,1,CL)) !,PAGES(PGNO,1,CL) W:'$D(PAGES(PGNO,1,CL)) ! W:$D(PAGES(PGNO,2,CL)) ?M2,PAGES(PGNO,2,CL)
 . W:$D(PAGES(PGNO,3,CL)) ?M3,PAGES(PGNO,3,CL) W:$D(PAGES(PGNO,4,CL)) ?M4,PAGES(PGNO,4,CL)
 Q
ELE ;
 I IDX S ELE=RECNR
 I 'IDX S FREF=$P(SN,",",1,($L(SN,",")-1))_","_RECNR_",0)" F CP=1:1:PNM S PREF="PIE"_CP,ELE=$S($L(ELE)=0:ELE_$P(@FREF,"^",@PREF),1:ELE_" "_$P(@FREF,"^",@PREF))
 S ELE=$E(ELE,1,TWD),ITEM=ITEM+1
 S PAGES(PGNO,CC,CL)=$S(CC=1:$J(ITEM,4)_" "_ELE,1:"    "_$J(ITEM,4)_" "_ELE)
 Q
CONT ;
 I IOST["P-" W @IOF S CONT="" Q
 I PGNO>1 W !!,"Press RETURN to continue                   ""^"" to Quit, ""-"" for previous page "
 E  W !!,"Press RETURN to continue                                          ""^"" to Quit "
 R CONT:DTIME I '$T!(CONT="^") S CONT="^" Q
 W @IOF Q
UPPER(STRING) ;
 Q $TR(STRING,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
CENTER(STRING) ;
 W:STRING="" ! Q:STRING=""  W:IOST["P-" ! W ?($S($L(STRING)#2=0:(IOM\2)-($L(STRING)\2),1:((IOM\2)-1)-($L(STRING)\2))),STRING,! Q
PGFMT(PGNO) ;
 S PGNO=$S(((+PGNO<10)&(+PGNO>0)):"00"_+PGNO,((+PGNO<100)&(+PGNO>9)):"0"_+PGNO,(+PGNO>99):+PGNO,1:"---") Q PGNO
MDY() ;
 N %,%I,X,MDY D NOW^%DTC S MDY=$$FMTE^XLFDT(X,"5D") Q MDY
 ;changed for Y2K compliance
