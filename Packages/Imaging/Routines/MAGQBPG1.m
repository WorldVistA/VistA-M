MAGQBPG1 ;WOIFO/RMP - REMOTE Task SERVER Program ; 18 Jan 2011 5:00 PM
 ;;3.0;IMAGING;**7,8,20,81,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
ENTRY(RESULT,WSTAT,PROCESS) ;RPC[MAGQ JBS]
 N X,SYSIEN,SYSNAME,ZNODE,NODE,INDX,CNT,PROC,%,QPTR,QCNT,SHARE,PLACE,SCANDATE
 S SCANDATE=$$FMTE^XLFDT($$NOW^XLFDT)
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S (SYSIEN,CNT)=0,SYSNAME="",U="^",PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S SYSIEN=$O(^MAG(2006.8,"C",PLACE,WSTAT,"")) ;TRUE WORKSTATION NAME
 I 'SYSIEN S SYSIEN=$O(^MAG(2006.8,"C",PLACE,$$UPPER^MAGQE4(WSTAT),""))
 I 'SYSIEN D  ;ATTEMPT TO FIND A MATCH FROM LOCAL NAME
 . N TRY
 . F TRY=1:1:$L(WSTAT,".") D  Q:SYSIEN?1N.N
 . . S SYSIEN=$O(^MAG(2006.8,"C",PLACE,$P(WSTAT,".",TRY),""))
 . . I 'SYSIEN S SYSIEN=$O(^MAG(2006.8,"C",PLACE,$$UPPER^MAGQE4($P(WSTAT,".",TRY)),""))
 I SYSIEN="" D  Q
 . S RESULT(0)="-1^This workstation is not currently setup as a Background Processor."
 . Q
 S NODE=^MAG(2006.8,SYSIEN,0)
 S SYSNAME=$P(NODE,U)
 I SYSNAME="" D  Q
 . S RESULT(0)="-1^This workstation is not currently setup as a Background Processor."
 . Q
 S RESULT(0)="0^BP List^PID: "_$$BASE^XLFUTL($J,10,16)_U_SYSNAME_U_WSTAT_U_$P(^MAG(2006.1,PLACE,0),U,2)
 S (X,CNT)=0
 F  S X=$O(^MAG(2005.2,X)) Q:X'?1N.N  S ZNODE=$G(^(X,0)) D
 . Q:'$P(ZNODE,U,6)  ;1=online
 . Q:$E($P(ZNODE,U,2),1,2)'="\\"
 . Q:$P(ZNODE,U,10)'=PLACE
 . Q:(($P(ZNODE,U,7)'["WORM")&($P(ZNODE,U,7)'="RW"))
 . S CNT=CNT+1,SHARE=$P(ZNODE,U,2)
 . I $E(SHARE,$L(SHARE))="\" S SHARE=$E(SHARE,1,$L(SHARE)-1)
 . S RESULT(CNT)=X_U_SHARE_U_$P(ZNODE,U,8)
 Q
SHR(RESULT) ; RPC[MAGQ SHARES]
 N TMP,INDX,DATA,CNT,SHARE,CWL,VALUE,PLACE
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S (CNT,INDX)=0,U="^",PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S CWL=$$CWL^MAGBAPI(PLACE)
 F  S INDX=$O(^MAG(2005.2,INDX)) Q:INDX'?1N.N  D
 . S DATA=$G(^MAG(2005.2,INDX,0))
 . Q:$P(DATA,U,6,7)'["1^MAG"
 . Q:$P(DATA,U,9)="1"  ;ROUTING SHARE
 . Q:$P(DATA,U,2)[":"
 . Q:$P(DATA,U,10)'=PLACE
 . S SHARE=$P(DATA,U,2)
 . Q:$E(SHARE,1,2)'="\\"
 . I $E(SHARE,$L(SHARE))="\" S SHARE=$E(SHARE,1,$L(SHARE)-1)
 . S SHARE=SHARE_U_$P(DATA,U,8)
 . Q:$D(TMP(SHARE))
 . S TMP(SHARE)=INDX
 S INDX=""
 F  S INDX=$O(TMP(INDX)) Q:INDX=""  D
 . S RESULT(CNT)=TMP(INDX)_U_INDX,CNT=CNT+1
 . S ^TMP("MAGQBP",$J,"SHRLST",CNT-1)=TMP(INDX)_U_INDX
 K TMP
 Q
CNP2(RESULT,IEN,START,STOP,AUTO) ;[MAGQ JBSCN]
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 N FNAME,PIECE,ZNODE,NODE2,BNODE,BNAME,PTR,HASH,TEMP,ORDER,RDATE,PLACE,OFFLINE,PLACEOK,GL,END,ACQSITE
 S (RESULT,GL)="",PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2))),(OFFLINE,PLACEOK)=0
 I AUTO D
 . S IEN=+IEN
 . S ORDER="R"
 . I START="" S START=$S(IEN>0:IEN,1:$O(^MAG(2005,"A"),-1))
 . S STOP=$O(^MAG(2005,0))
 . Q
 S:START="" START=$O(^MAG(2005,0)) S:STOP="" STOP=$O(^MAG(2005,"A"),-1)
 S ORDER=$S(START>STOP:"R",1:"F")
 I (IEN'?1N.N)!IEN=0 D  I IEN="" S RESULT=0 Q
 . I START=0 S IEN=START Q
 . I ORDER="R" D
 . . S I1=+$O(^MAG(2005," "),-1),I2=+$O(^MAG(2005.1," "),-1),END=$S(I1>I2:I1,1:I2)
 . . S IEN=$S(START>END:START,1:START+1) Q
 . E  S IEN=START-1
 . Q
 S IEN=+IEN
 F  D SCAN^MAGQBPG1(.IEN,ORDER,.GL) D  Q:((('OFFLINE)&PLACEOK)!('IEN)!($P(RESULT,U,21)="DUPE")!'$G(ACQSITE))
 . Q:'IEN
 . S ZNODE=$G(@(GL_IEN_",0)")),ACQSITE=$P($G(@(GL_IEN_",100)")),U,3)
 . I AUTO,$P(ZNODE,U,11)'="" D  Q
 . . S $P(RESULT,U,1)=0
 . . S IEN=0
 . . Q
 . S PLACEOK=$S($$PLACE^MAGBAPI(+ACQSITE)=$$PLACE^MAGBAPI($G(DUZ(2))):1,1:"")
 . I $P(ZNODE,U,2)'="" S OFFLINE=$$IMOFFLN^MAGFILEB($P(ZNODE,U,2))  ; Only check the offline status of image files
 . I ($D(^MAG(2005.1,IEN,0))&$D(^MAG(2005,IEN,0))) D  Q  ; Image is duplicated in the Archive file
 . . I $P(^MAG(2005,IEN,0),U,1,8)="^^^^^^^",+$P(^MAG(2005,IEN,0),U,9) K ^MAG(2005,IEN,0) Q
 . . S FDA(2005,IEN_",",13.5)="1" ; Set Dupe field in the Image File 
 . . S FDA(2005,IEN_",",13)="1" ; Set IQ field in the Image File  
 . . D FILE^DIE("I","FDA","MSG") K FDA,MSG
 . . S FDA(2005.1,IEN_",",13.5)="1" ; Set the Dupe field in the archive file
 . . S FDA(2005.1,IEN_",",13)="1" ; and set the IQ field in the archive file
 . . D FILE^DIE("I","FDA","MSG") K FDA,MSG
 . . S $P(RESULT,U,21)="DUPE"
 . . S $P(RESULT,U)=IEN
 . . I $P(ZNODE,U,2)=$P($G(^MAG(2005.1,IEN,0)),U,2) S $P(RESULT,U,2)=$P(ZNODE,U,2) D
 . . . I $P(RESULT,U,2)="" S $P(RESULT,U,2)="No File Name" Q
 . . E  S $P(RESULT,U,2)=$P(ZNODE,U,2)_"/"_$P($G(^MAG(2005.1,IEN,0)),U,2) D
 . . . I $P($P(RESULT,U,2),"/")="" S $P(RESULT,U,2)="No File Name"_$P(RESULT,U,2)
 . . . I $P($P(RESULT,U,2),"/",2)="" S $P(RESULT,U,2)=$P(RESULT,U,2)_"No File Name"
 . . . Q
 . . Q
 . E  I $P(ZNODE,U,2)'="" S $P(@(GL_IEN_",0)"),U,12)="0"
 . Q
 ;  The next statement will stop the BP Verifier cycle because the ien is out of range
 I $S('IEN:1,((ORDER="F")&(IEN>STOP)):1,((ORDER="R")&(IEN<STOP)):1,1:0) D  Q
 . S $P(RESULT,U,1)=0
 . Q
 S FNAME=$P(ZNODE,U,2)
 S $P(RESULT,U)=IEN
 Q:($P(RESULT,U,21)="DUPE")
 S $P(RESULT,U,19)=$P($P($G(@(GL_IEN_",2)")),U),".")
 I $P(ZNODE,U,2)'="" D  ;NON-GROUP PARENT
 . S BNODE=$G(@(GL_IEN_",""FBIG"")"))
 . I $P(ZNODE,U,5)?1N.N S $P(RESULT,U,3)=$P(ZNODE,U,5)
 . S:$P(BNODE,U,2)?1N.N $P(RESULT,U,4)=$S($P(BNODE,U,3)'="":"["_$P(BNODE,U,3)_"]",1:"")_$P(BNODE,U,2)
 . S:$P(ZNODE,U,3)?1N.N $P(RESULT,U,5)=$P(ZNODE,U,3)
 . S:$P(ZNODE,U,4)?1N.N $P(RESULT,U,6)=$P(ZNODE,U,4)
 . S:$P(BNODE,U)?1N.N $P(RESULT,U,7)=$S($P(BNODE,U,3)'="":"["_$P(BNODE,U,3)_"]",1:"")_$P(BNODE,U)
 . S $P(RESULT,U,8)=$$CWL^MAGBAPI(PLACE)
 . S $P(RESULT,U,2)=FNAME
 . I $D(@(GL_IEN_",""FBIG"")")),'$P(BNODE,U),'$P(BNODE,U,2) S $P(RESULT,U,22)="EMPTY_FBIG"
 . Q
 I '$P($G(@(GL_IEN_",100)")),U,3) S $P(RESULT,U,23)=-1 ;"NO ACQ SITE VALUE"
 I GL[("^MAG(2005.1,") S $P(RESULT,U,21)="ARCH"
 E  S $P(RESULT,U,12,17)=$$CHKIMG^MAGQBUT2(IEN)
 Q
JPUD(RESULT,JPTR,EXT,IEN) ; RPC[MAGQ JPUD]
 N TYPE,PIECE,NODE,GL
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP"),RESULT="0"
 S TYPE=$$FTYPE^MAGQBPRG(EXT,IEN)
 S PIECE=$S(TYPE="BIG":2,1:5)
 S NODE=$S(TYPE="BIG":"FBIG",1:0)
 I JPTR="0" D  Q:(RESULT<0)
 . S JPTR=""
 . S GL=$S($D(^MAG(2005,IEN)):"^MAG(2005,",$D(^MAG(2005.1,IEN)):"^MAG(2005.1,",1:0)
 . I GL=0 S RESULT="-1" Q
 . I $D(^MAGQUEUE(2006.033,"B",$P($G(@(GL_IEN_",0)")),U,2))) D  Q
 . . S RESULT=-2 Q  ;Don't clear the JB pointer if image is on an Offline Platter
 . . Q
 . Q
 S:$D(^MAG(2005,IEN,NODE)) $P(^MAG(2005,IEN,NODE),U,PIECE)=JPTR
 S:$D(^MAG(2005.1,IEN,NODE)) $P(^MAG(2005.1,IEN,NODE),U,PIECE)=JPTR
 S RESULT="1"
 Q
VCUD(RESULT,VCPTR,EXT,IEN) ; RPC[MAGQ VCUD]
 N TYPE,PIECE,NODE
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP"),RESULT="0"
 S TYPE=$$FTYPE^MAGQBPRG(EXT,IEN)
 S PIECE=$S(TYPE="BIG":1,TYPE="ABS":4,1:3)
 S NODE=$S(TYPE="BIG":"FBIG",1:0)
 S:VCPTR="0" VCPTR=""
 S:$D(^MAG(2005,IEN,NODE)) $P(^MAG(2005,IEN,NODE),U,PIECE)=VCPTR
 S:$D(^MAG(2005.1,IEN,NODE)) $P(^MAG(2005.1,IEN,NODE),U,PIECE)=VCPTR
 S RESULT="1"
 Q
DFNIQ(RESULT,INPUT,SEND,PLACE,APP) ;
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 N LOC,CNT,Y,XMSUB
 S U="^",RESULT="1"
 S CNT=+$O(^TMP($J,"MAGQDFN",PLACE,APP,""),-1)
 I CNT<2 D
 . S LOC=$$KSP^XUPARAM("WHERE")
 . S ^TMP($J,"MAGQDFN",PLACE,APP,1)="            SITE: "_LOC
 . S ^TMP($J,"MAGQDFN",PLACE,APP,2)="            DATE: "_$$FMTE^XLFDT($$NOW^XLFDT)_" "_$G(^XMB("TIMEZONE"))
 . S CNT=2 Q
 I SEND="1" D
 . S RESULT=$$SUBCHK^XMGAPI0(INPUT,0)
 . Q:$P(RESULT,U)
 . S XMSUB=INPUT
 . N XMTEXT,INTERVAL,XMDUZ,XMZ
 . S INTERVAL=$$GETMI^MAGQBUT5(XMSUB,PLACE)
 . I $$FMADD^XLFDT(+$P(INTERVAL,"^",2),"",+$P(INTERVAL,U,1),"","")>$$NOW^XLFDT D  Q
 . . K ^TMP($J,"MAGQDFN",PLACE,APP) Q
 . S XMTEXT="^TMP($J,""MAGQDFN"",PLACE,APP)"
 . D:$$PROD^XUPROD("1") ADDMG^MAGQBUT5(INPUT,.XMY,PLACE)
 . S XMY(DUZ)="",XMDUZ=DUZ,XMY(XMDUZ)=""
 . S XMID=$G(DUZ) S:'XMID XMID=.5
 . S XMINSTR("FLAGS")="I",XMINSTR("FROM")="VistA Imaging "_APP
 . D SENDMSG^XMXAPI(XMID,XMSUB,XMTEXT,.XMY,.XMINSTR,.XMZ,)
 . K ^TMP($J,"MAGQDFN",PLACE,APP)
 . I $G(XMERR) M XMERR=^TMP("XMERR",$J) K XMERR
 . K ^TMP($J,"MAGQDFN",PLACE,APP)
 . D UDMI^MAGQBUT5(INPUT,PLACE) Q
 E  S CNT=CNT+1,^TMP($J,"MAGQDFN",PLACE,APP,CNT)=INPUT
 S $P(RESULT,U)=$S($P(RESULT,U):"1",1:0)
 K XMY,XMINSTR,XMID
 Q
SCAN(IEN,ORDER,GB) ; Find the next image spanning the Image and the Image Archive file
 I IEN,GB="^MAG(2005,",$D(^MAG(2005.1,IEN)) D  Q
 . S IEN=IEN,GB="^MAG(2005.1," Q
 N I1,I2
 I $G(ORDER)="F" D 
 . S I1=$O(^MAG(2005,IEN)),I1=$S(I1:I1,1:"")
 . S I2=$O(^MAG(2005.1,IEN)),I2=$S(I2:I2,1:"")
 . I I1,'I2 S IEN=I1,GB="^MAG(2005," Q
 . I I2,'I1 S IEN=I2,GB="^MAG(2005.1," Q
 . S GB=$S(I1>I2:"^MAG(2005.1,",1:"^MAG(2005,")
 . S IEN=$S(I1>I2:I2,1:I1)
 . Q
 E  D  ;Reverse
 . S I1=$O(^MAG(2005,IEN),-1),I1=$S(I1:I1,1:"")
 . S I2=$O(^MAG(2005.1,IEN),-1),I2=$S(I2:I2,1:"")
 . I I1,'I2 S IEN=I1,GB="^MAG(2005," Q
 . I I2,'I1 S IEN=I2,GB="^MAG(2005.1," Q
 . S GB=$S(I1<I2:"^MAG(2005.1,",1:"^MAG(2005,")
 . S IEN=$S(I1<I2:I2,1:I1)
 . Q
 S IEN=$S('IEN:"",1:IEN)
 Q
