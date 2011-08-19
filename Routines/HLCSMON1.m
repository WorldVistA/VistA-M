HLCSMON1 ;SF-Utilities for Driver Program  ;06/26/2008  15:30
 ;;1.6;HEALTH LEVEL SEVEN;**15,40,49,65,109,122,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;This routine contains several entry points called from HLCSMON
 ;no input parameters are required. All variables used which are
 ;not newed here are newed in HLCSMON
 ;
DISPLAY ;display link info
 ;turn of line wrap
 S HLXX=0,X=0 X ^%ZOSF("RM")
 F  S HLXX=$O(HLARYD(HLXX)) Q:(HLXX'>0)  D WLINE(HLXX)
 ;DISPLAY INCOMING FILER STATUS
 ; patch HL*1.6*142 start
 ; call STAT^%ZTLOAD for each display in CNTFLR^HLCSUTL2.
 ; patch HL*1.6*122
 ; S HLXX=$P(HLRUNCNT,"^",1)
 ; I (+HLXX)=-1 S HLXX=$$CNTFLR^HLCSUTL2("IN")
 S HLXX=$$CNTFLR^HLCSUTL2("IN")
 ; patch HL*1.6*142 end
 ;
 ;ONLY UPDATE SCREEN IF COUNT HAS CHANGED
 I (HLXX'=+HLRUNCNT) D
 .D WDATA(5,17,"","",$J(" ",31)),WDATA^HLCSMON1(5,17,"","","Incoming filers running => ",35)
 .I (HLXX) D WDATA(32,17,"","",HLXX)
 .I ('HLXX) D WDATA(32,17,IOINHI,IOINORM,"Zero")
 .S $P(HLRUNCNT,"^",1)=HLXX
 ;DISPLAY OUTGOING FILER STATUS
 ; patch HL*1.6*142 start
 ; call STAT^%ZTLOAD for each display in CNTFLR^HLCSUTL2.
 ; patch HL*1.6*122
 ; S HLXX=$P(HLRUNCNT,"^",2)
 ; I (+HLXX)=-1 S HLXX=$$CNTFLR^HLCSUTL2("OUT")
 S HLXX=$$CNTFLR^HLCSUTL2("OUT")
 ; patch HL*1.6*142 end
 ;
 ;ONLY UPDATE SCREEN IF COUNT HAS CHANGED
 I (HLXX'=+$P(HLRUNCNT,"^",2)) D
 .D WDATA(5,18,"","",$J(" ",31)),WDATA^HLCSMON1(5,18,"","","Outgoing filers running => ",35)
 .I (HLXX) D WDATA(32,18,"","",HLXX)
 .I ('HLXX) D WDATA(32,18,IOINHI,IOINORM,"Zero")
 .S $P(HLRUNCNT,"^",2)=HLXX
 S X=$$TM^%ZTLOAD
 I X'=$G(HLTMSTAT) D
 .S HLTMSTAT=X
 .S HLXX=$S('HLTMSTAT:"***TASKMAN NOT RUNNING!!!***",1:"")
 .I 'HLTMSTAT D WDATA^HLCSMON1(45,17,IOELEOL_IOBON_IORVON,IOBOFF_IORVOFF,HLXX) I 1
 .E  D WDATA(45,17,IOELEOL,"",$J("TaskMan running ",16)) ;D WDATA(5,19,IOELALL,"","")
 S X=$$STAT^HLCSLM
 I X'=$G(HLLMSTAT) D
 .S HLLMSTAT=X Q:HLLMSTAT=3
 .S HLXX=$S('HLLMSTAT:"***LINK MANAGER NOT RUNNING!!!***",1:"")
 .I 'HLLMSTAT D WDATA^HLCSMON1(45,18,IOELEOL_IOBON_IORVON,IOBOFF_IORVOFF,HLXX) I 1
 .E  D WDATA^HLCSMON1(45,18,IOELEOL,"",$J("Link Manager running",18))
 ;Turn terminal line wrap back on
 D WDATA(45,19,IOELEOL,"",$$SLM^HLEVUTIL) ; HL*1.6*109
 S X=IOM X ^%ZOSF("RM")
 Q
 ;
WLINE(HLXX) ;write line from HLARYD=current values, HLARYO=old values
 ;if values haven't changed, don't do anything
 I HLARYD(HLXX)]"",HLARYD(HLXX)=$G(HLARYO(HLXX)) Q
 S HLARYO(HLXX)=HLARYD(HLXX),HLERR=$P(HLARYD(HLXX),U,8),DX=1
 ; patch HL*1.6*122
 ; F X=1:1:7 S @$P("HLNODE^HLREC^HLPROC^HLSEND^HLSENT^HLDEV^HLSTAT",U,X)=$E($P(HLARYD(HLXX),U,X)_"        ",1,8)
 F X=1,7 S @$P("HLNODE^HLREC^HLPROC^HLSEND^HLSENT^HLDEV^HLSTAT",U,X)=$E($P(HLARYD(HLXX),U,X)_"        ",1,10)
 F X=2:1:5 S @$P("HLNODE^HLREC^HLPROC^HLSEND^HLSENT^HLDEV^HLSTAT",U,X)=$E($P(HLARYD(HLXX),U,X)_"        ",1,8)
 ; patch HL*1.6*142
 ; if the link in-queue is set to 1 (stop), display it from HLDEV
 ; S X=6,@$P("HLNODE^HLREC^HLPROC^HLSEND^HLSENT^HLDEV^HLSTAT",U,X)=$E($P(HLARYD(HLXX),U,X)_"        ",1,7)
 I $P(HLARYD(HLXX),U,6)["/I-off" D
 . S X=6,@$P("HLNODE^HLREC^HLPROC^HLSEND^HLSENT^HLDEV^HLSTAT",U,X)=$E($P(HLARYD(HLXX),U,X)_"        ",1,8)
 E  S X=6,@$P("HLNODE^HLREC^HLPROC^HLSEND^HLSENT^HLDEV^HLSTAT",U,X)=$E($P(HLARYD(HLXX),U,X)_"        ",1,7)
 ;
 ;if link is in error, write node in rev. video
 I HLERR]"" D WDATA(5,HLXX,IOBON_IORVON,IOBOFF_IORVOFF,HLNODE,8) S DX=14
 ;Turn off terminal line wrap & inform O/S where cursor is located
 S DY=HLXX X IOXY,^%ZOSF("XY")
 ; patch HL*1.6*122
 W:HLERR="" ?4,HLNODE
 ; patch HL*1.6*142
 ; if the link in-queue is set to 1 (stop), display it
 ; W ?16,HLREC,?26,HLPROC,?37,HLSEND,?47,HLSENT,?58,HLDEV,?63,HLSTAT
 I HLDEV["/I-off" D
 . W ?16,HLREC,?26,HLPROC,?37,HLSEND,?47,HLSENT,?56,HLDEV,?65,HLSTAT
 E  W ?16,HLREC,?26,HLPROC,?37,HLSEND,?47,HLSENT,?58,HLDEV,?63,HLSTAT
 ;
 Q
 ;
WDATA(DX,DY,IO1,IO2,HLDATA,HLENGTH) ;
 ;
 ;First erase the data block then write to it. Attributes are 
 ;contained in IO1 & IO2
 ;
 N X S X=0 X ^%ZOSF("RM") X ^%ZOSF("XY")
 ;Turn off terminal line wrap & inform O/S where cursor is located
 I '$D(HLENGTH) S HLENGTH=$L(HLDATA)
 X IOXY W IOSC,$E($J(" ",79),1,HLENGTH),IORC W IO1,$E(HLDATA,1,HLENGTH),IO2
 S X=IOM X ^%ZOSF("RM")
 ;Turn terminal line wrap back on
 Q
