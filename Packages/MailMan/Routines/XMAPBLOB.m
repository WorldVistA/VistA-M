XMAPBLOB ;(WASH ISC)/CAP-DISPLAY BLOBs ;04/18/2002  07:22
 ;;8.0;MailMan;;Jun 28, 2002
 ;BLOB display
BLOB Q:'$O(^XMB(3.9,XMZ,2005,0))
 N %,I,XMA0,XMB0,MAGFILE2,MAGFILE
 S XMA0=0,XMB0=0 I '$D(XMAPBLOB) S XMAPBLOB=1
B S XMA0=$O(^XMB(3.9,XMZ,2005,XMA0)) G BQ:'XMA0 S %=+^(XMA0,0)
 S XMB0=XMB0+1,XMA0(XMB0)=%,MAGXX=%
 I $L($T(IMPORT^MAGBAPI)) S %=$$IMPORT^MAGBAPI("MAIL^"_MAGXX)
 D ^MAGFILE
 S XMA0(XMB0)=XMA0(XMB0)_U_MAGFILE1(.01)_"^^^^^^^"_MAGFILE
 G B
BQ S X=$O(XMA0(0)) I X,'$O(XMA0(X)) Q:$G(XMAPBLOB("DISPDONE"))
 S XMAPBLOB("DISPDONE")=1
 I XMB0=1 G CLRQ:$$ASK()="",PRTQ:$G(XMAPBLOB)>99 S (X,XMA0)=+XMA0(1) I 1
 E  I $S($G(IOT)="IMPC":1,1:0) S X=$$BLIST() G CLRQ:X="" S XMA0=X
 D ^MAGOBJ(X,"DISPLAY","")
 I $S(XMB0=1:1,$O(XMA0(XMA0))=""&$O(XMA0(0))="":1,1:0) Q
 G BQ
CLRQ I $G(XMAPBLOB)>99 Q
 G ERASE^MAGAPI
 ;
BLIST() ;List BLOBS in the message
 I $G(IOT)="IMPC",$G(XMAPBLOB)>99 Q ""
 N X,Y,DIR,DIRUT,DUOUT
 I '$G(XMAPBLOB("D")),$Y>(IOSL-4) K DIR S DIR(0)="E" D ^DIR:$G(XMAPBLOB)<100 K DIR,DIRUT
 I '$G(XMAPBLOB("D")) W !,"============================================================="
 I  W !!,"There are non-textual parts (BLOBs) included on this message"
 S XMAPBLOB("D")=1 W !!,"Object Name",?70,"Filename"
 F I=0:0 S I=$O(XMA0(I)) Q:'I  W !,I_". "_$E($P(XMA0(I),U,2),1,68),?70,$E($P(XMA0(I),U,9),1,9)
A I $G(XMAPBLOB)>99 Q ""
 W !!,"Pick a BLOB you wish to display from the above list (1-"_XMB0_"): NONE// " R X:DTIME
 S X=$TR(X,"none","NONE") I $E("NONE",1,$L(X))=X!("^"[X) Q ""
 I +X'=X W !!,"Choose the index number of the BLOB you wish to display or accept the default.",! G A
 I '$D(XMA0(X)) W !!,"Please choose a listed item by typing in its index number." G A
 Q +XMA0(X)
 ;Ask if user wants to display single BLOB
ASK() I $G(XMAPBLOB)>99 Q 2
 N DIR,DIRUT,DUOUT
 S DIR(0)="Y",DIR("A")="Execute Other Message Part ("_$P(XMA0(1),U,2)_") Attached ",DIR("B")="NO"
 D ^DIR K DIRUT I 'Y!$D(DIRUT) Q ""
 Q 1
NODISP ;If not proper terminal
 Q:$G(XMAPBLOB("D"))  S XMAPBLOB("D")=1 Q:'$D(^XMB(3.9,XMZ,2005))
 W !!,"================================================================="
 W !,"There are non-textual body parts (BLOBs) attached to this"
 W !,"message.  You may not execute them (display...) because you"
 W !,"are not using the proper terminal."
 W !!,"Query the message to see the list of BLOBs attached."
 W !,"================================================================="
 Q
PRT ;Print BLOB list
 N MAGOBJ,MAGFILE,MAGFILE1,MAGROU,X,XMAPBLOB S XMAPBLOB=100
 D BLOB Q
PRTQ S X=$$BLIST() Q
