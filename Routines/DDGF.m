DDGF ;SFISC/MKO-FORM BUILDING TOOL ;08:38 AM  12 Aug 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Program-wide variables
 ; DDGFILE  = File number^File name
 ; DDGFFM   = Form number^Form name
 ; DDGFPG   = Page number
 ; DDGFWID  = Window id for given page
 ; DDGFWIDB = Window id for block displayer for a given page
 ; DDGFREF  = Global reference where data is stored
 ; DDGFLIM  = Boundaries within which cursor can be moved
 ;            $Y1^$X1^$Y2^$X2
 ; DDGFBV   = If defined, we're in the block view page
 ; DDGFMSG  = Indicates there's a message on the message line.
 ;
 N %,%W,%X,%Y,C,D,D0,DI,DIC,DIEQ,DIW,DIZ,DQ,I,X,Y,DIOVRD
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 D ^DDGF0 G:$G(DIERR) END^DDGF0
 D SEL^DDGFFM G:$D(DDGFFM)[0 END^DDGF0
 D ALL^DDGFASUB,^DDGF1,END^DDGF0
 Q
 ;
REFRESH ;Repaint all windows, status line
 D REPALL^DDGLIBW(),STATUS
 Q
 ;
STATUS ;Paint status line
 N DX,DY,N,S
 K DDGFMSG
 S DY=IOSL-7,DX=0 X IOXY
 W $P(DDGLCLR,DDGLDEL,3)_$TR($J("",IOM-1)," ","_")
 ;
 S DY=IOSL-6 X IOXY
 W "File: "_$P(DDGFFILE,U,2)_" (#"_$P(DDGFFILE,U)_")"
 I $D(DDGFBV)#2 S DX=46 X IOXY W "BLOCK VIEWER"
 W !,"Form: "_$P(DDGFFM,U,2)
 S N=$G(@DDGFREF@("F",+$G(DDGFPG)))
 W !,"Page: "_$S(N]"":$P(N,U,6)_" ("_$P(N,U,5)_")",1:""),!!!
 I $D(DDGFBV)#2 W $P(DDGLVID,DDGLDEL)_"<PF1>V=Main Screen  <PF1>H=Help"_$P(DDGLVID,DDGLDEL,10)
 E  W $P(DDGLVID,DDGLDEL)_"<PF1>Q=Quit  <PF1>E=Exit  <PF1>S=Save  <PF1>V=Block Viewer  <PF1>H=Help"_$P(DDGLVID,DDGLDEL,10)
 Q
 ;
MSG(M) ;Print message
 N DDGFDY,DDGFDX
 S DDGFDY=DY,DDGFDX=DX S:$D(M)[0 M=""
 S DY=IOSL-2,DX=0 X IOXY
 ;
 W $E(M,1,79)_$P(DDGLCLR,DDGLDEL)
 S:M]"" DDGFMSG=1 K:M="" DDGFMSG
 S DY=DDGFDY,DX=DDGFDX X IOXY
 Q
 ;
RESET ;Reset terminal and cleanup
 S DDGFREF="^TMP(""DDGF"",$J)",DDGLREF="^TMP(""DDGL"",$J)"
 K DDSFILE,DDSPAGE,DDSPARM,DR
 G KILL^DDGF0
