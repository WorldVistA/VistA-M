MAGQBUT1 ;WOIFO/RP - Utilities for Background ; 18 Jan 2011 5:13 PM
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
UBPW(WS,ASSIGN) ;  screen for duplicate assignments
 N IEN,PLACE,PIECE,WSIEN,VALUE,DUP
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S VALUE(1)=PLACE,VALUE(2)=WS
 S WSIEN=$$FIND1^DIC(2006.8,"","QX",.VALUE,"D","","")
 S PIECE=$P(ASSIGN,";",2)
 S (DUP,IEN)=0
 ;IF NOT ASSIGNED THEN QUIT
 I '$P($G(^MAG(2006.8,WSIEN,0)),U,PIECE) K VALUE Q DUP
 F  S IEN=$O(^MAG(2006.8,IEN)) Q:'IEN  D  Q:DUP
 . S ZNODE=^MAG(2006.8,IEN,0)
 . Q:'$P(ZNODE,U,12)  ; not a BP
 . Q:$P(ZNODE,U,2)'=PLACE
 . Q:$P(ZNODE,U)=WS
 . S:+$P(ZNODE,U,PIECE) DUP=1
 . Q
 Q DUP
BPPS(INPUT,WS,PROCESS) ;INPUT TRANSFORM FOR FILE 2006.8
 N IEN,FND,WSNAME,WSNAME2,ZNODE,PIECE,MAGX,MAGY,PLACE
 S U="^"
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 Q:'(+$P($G(^MAG(2006.8,WS,0)),U,12)) 0  ;NOT A BACKGROUND PROCESSOR
 Q:'INPUT 1  ; Always allow unassigned
 S WSNAME=$P($G(^MAG(2006.8,WS,0)),U) ;Workstation Name
 Q:$L(WSNAME)<3 0 ;BP WS NOT PROPERLY INSTALLED
 Q:$O(^MAG(2006.8,"C",PLACE,WSNAME,""))'?1N.N 1
 S PIECE=$P($$GET1^DID(2006.8,PROCESS,"","GLOBAL SUBSCRIPT LOCATION"),";",2)
 S IEN=0,WSNAME2="",FND=0
 F  S WSNAME2=$O(^MAG(2006.8,"C",PLACE,WSNAME2)) Q:WSNAME2=""  D  Q:FND
 . Q:WSNAME2=WSNAME
 . S IEN=$O(^MAG(2006.8,"C",PLACE,WSNAME2,"")) Q:IEN'?1N.N
 . S ZNODE=$G(^MAG(2006.8,IEN,0))
 . Q:$P(ZNODE,"^",12)'="1"
 . S FND=$P(ZNODE,"^",PIECE)="1"
 . Q
 Q $S(FND="1":0,1:1)
RSQUE(RESULT,IEN,QUEUE) ;[MAGQB RSQUE]
 N PTR,PLACE
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S PTR=$O(^MAGQUEUE(2006.031,"C",PLACE,QUEUE,""))
 I $P(^MAGQUEUE(2006.031,PTR,0),"^")=QUEUE D
 . S $P(^MAGQUEUE(2006.031,PTR,0),"^",2)=IEN
 . Q
 Q
ICCL(SRVRCNT,NMESS,PLACE) ;UPDATE IMAGING DISTRIBUTION
 N Y,LOC,INDEX,CNT,IEN,ARRAY,SUB1,SUB2,NAME
 S Y=$$FMTE^XLFDT($$NOW^XLFDT)
 S LOC=$$KSP^XUPARAM("WHERE")
 S CNT=1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="SITE: "_LOC
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="DATE: "_Y_" "_$G(^XMB("TIMEZONE"))
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="SENDER: "_$$PLNM^MAGQBUT5(PLACE)_" Imaging Background Processor"
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="Total Cache Free: "_$P(SRVRCNT,U,2)_" megabytes"
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="Total Cache Available: "_$P(SRVRCNT,U,3)_" megabytes"
 I $P(SRVRCNT,U,4) S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="An Automatic Purge process has been Activated. "
 E  S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="The Automatic Purge process is NOT configured. "
 I $P(SRVRCNT,U,5)]"" S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="The Automatic Purge process is assigned to: "_$P(SRVRCNT,U,5)
 E  S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="The Automatic Purge process is NOT assigned to a BP server. "
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="The "_$P(SRVRCNT,U)_" Imaging cache servers will"
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="require operator intervention to ensure continued"
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="availability.  The following MAG SERVER members"
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="are being notified: "
 S INDEX=0,IEN=$$FIND1^DIC(3.8,"","MX","MAG SERVER","","","ERR")
 Q:IEN'?1N.N
 D GETS^DIQ(3.8,IEN_",","2*;11*;12*","","ARRAY")
 S (SUB1,SUB2)=""
 F  S SUB1=$O(ARRAY(SUB1)) Q:SUB1=""  D
 . F  S SUB2=$O(ARRAY(SUB1,SUB2)) Q:SUB2=""  D
 . . S NAME=$G(ARRAY(SUB1,SUB2,".01")) D:NAME'=""
 . . . S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",8+CNT)=NAME
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)="The next notifications will occur in: "
 S CNT=CNT+1,^TMP($J,"MAGQ",PLACE,"BP",CNT)=NMESS
 D MAILSHR(PLACE,"BP","Image Cache Critically Low at "_LOC)
 S $P(^MAG(2006.1,$$PLACE^MAGBAPI($G(DUZ(2))),3),"^",11)=$$NOW^XLFDT
 D UDMI^MAGQBUT5("Image Cache Critically Low at ",PLACE)
 K ARRAY
 Q
MAILSHR(PLACE,APP,XMSUB) ;Shared Mail server code
 N XMY,XMTEXT,XMID,XMZ
 S XMTEXT="^TMP($J,""MAGQ"",PLACE,APP)"
 S:$G(DUZ) XMY(DUZ)=""
 D:$$PROD^XUPROD("1") ADDMG^MAGQBUT5(XMSUB,.XMY,PLACE)
 S:$G(MAGDUZ) XMY(MAGDUZ)=""
 S XMID=$G(DUZ) S:'XMID XMID=.5
 S XMY(XMID)=""
 D SENDMSG^XMXAPI(XMID,XMSUB,XMTEXT,.XMY,,.XMZ,)
 K ^TMP($J,"MAGQ",PLACE,APP)
 I $G(XMERR) M XMERR=^TMP("XMERR",$J) K XMERR
 Q
ALLSERV(RESULT,GRP) ; BP Queue Processor
 ; RPC[MAGQ ALL SERVER] used for ServerSize update/display function - reports network resources
 ; Returns OnLine, network addressed, non-router, place related Magnetic shares
 ; it returns the share designated as the current Write location in the (0) indice
 ; it does not screen on READ-ONLY, and the list is group specific
 ; the function could be replaced by a fileman call from the GUI 
 ; PHYSICAL REFERENCE^CWL or ien^FREE SPACE^TOTAL SPACE^NAME^GROUP^TYPE
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 N INDX,DATA,CNT,SHARE,CWL,VALUE,TMP,PLACE,CWG ;CWL=CURRENT WRITE LOCATION CWG=CURRENT WRITE GROUP
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S CWG=$S($G(GRP)["ALL":"",1:$$CWG^MAGBAPI(PLACE))
 D:CWG CWGIC(CWG)  ;Remove all members that do not reference this group
 S CWL=$$CWL^MAGBAPI(PLACE)
 ; I CWL D  ;First report Current Write Location data 
 ; . S DATA=$G(^MAG(2005.2,CWL,0))
 ; . S SHARE=$P(DATA,U,2)
 ; . S RESULT(0)=SHARE_U_CWL_U_+$P(DATA,U,5)_U_+$P(DATA,U,3)_U_$P(DATA,U)
 ; . S RESULT(0)=RESULT(0)_U_$S($L($$GET1^DIQ(2005.2,CWL,31,"E","","")):$$GET1^DIQ(2005.2,CWL,31,"E","",""),1:"")
 ; . S RESULT(0)=RESULT(0)_U_$$GET1^DIQ(2005.2,CWL,6,"I","","")
 ; . Q
 ; E  S RESULT(0)="-1^The Current Write Location (CWL) is not currently set."
 S INDX=0,U="^",CNT=1
 K ^TMP("MAGQAS")
 F  S INDX=$O(^MAG(2005.2,INDX)) Q:INDX'?1N.N  D
 . S DATA=$G(^MAG(2005.2,INDX,0))
 . Q:$P(DATA,U,6,7)'["1^MAG"
 . Q:$P(DATA,U,2)[":"
 . Q:($P(DATA,U,10)'=PLACE)
 . Q:$P(DATA,U,9)="1"  ;ROUTING SHARE
 . S SHARE=$P(DATA,U,2)
 . Q:$E(SHARE,1,2)'="\\"
 . I $E(SHARE,$L(SHARE))="\" S SHARE=$E(SHARE,1,$L(SHARE)-1)
 . S TMP(SHARE)=""
 . I CWG,'$$GMEM(CWG,INDX) Q  ;screen on Current Write Group also validate group member reference
 . S VALUE=SHARE_U_INDX_U_+$P(DATA,U,5)_U_+$P(DATA,U,3)_U_$P(DATA,U)
 . S VALUE=VALUE_U_$S($L($$GET1^DIQ(2005.2,INDX,31,"E","","")):$$GET1^DIQ(2005.2,INDX,31,"E","",""),1:"")
 . S VALUE=VALUE_U_$$GET1^DIQ(2005.2,INDX,6,"I","","")
 . I INDX=CWL D  Q  ;ELSE CONTINUE 
 . . S RESULT(0)=VALUE_U_$G(^TMP("MAGQ","WSUD"))
 . . S ^TMP("MAGQAS",0)=VALUE ;1ST SHARE=CWL
 . . Q
 . S RESULT(CNT)=VALUE,CNT=CNT+1
 . S ^TMP("MAGQAS",CNT-1)=VALUE
 . Q
 Q
ALLSHR(RESULT,TYPE) ; RPC[MAGQBP ALL SHARES] - Used by BP Purge
 ; screens off-line,read-only,routing share,non-mag,non-place,next group,current group,specific group(s)
 N TMP,INDX,DATA,CNT,SHARE,CWL,VALUE,PLACE,NG,GRP ;CWL=CURRENT WRITE LOCATION
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S (CNT,INDX)=0,U="^" S:'$D(TYPE) TYPE="ALL" ;calling routine will define TYPE, or set as ALL by default (no screen).
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S CWL=$$CWL^MAGBAPI(PLACE)
 S GRP=$$GRP^MAGQBUT(PLACE)
 S NG=$$NXTGP^MAGQBUT(PLACE,GRP,"1") ; Next Purge capable group
 F  S INDX=$O(^MAG(2005.2,INDX)) Q:INDX'?1N.N  D
 . S DATA=$G(^MAG(2005.2,INDX,0))
 . Q:$P(DATA,U,6,7)'["1^MAG"
 . Q:$P(DATA,U,9)="1"  ;ROUTING SHARE
 . Q:$P(DATA,U,2)[":"
 . Q:($P(DATA,U,10)'=PLACE)
 . Q:($P($G(^MAG(2005.2,INDX,1)),U,6)="1")  ;Read Only
 . Q:(("^AUTO^NRG^"[("^"_TYPE_"^"))&($P($G(^MAG(2005.2,INDX,1)),U,8)'=NG))  ;NOT a member of the Next RAID Group
 . Q:(("^CRG^"[("^"_TYPE_"^"))&($P($G(^MAG(2005.2,INDX,1)),U,8)'=GRP))  ;NOT a member of the Current RAID Group
 . Q:((TYPE?1N.N)&($P($G(^MAG(2005.2,INDX,1)),U,8)'=TYPE))  ;NOT a member of the Specified RAID Group
 . S SHARE=$$UPPER^MAGQE4($P(DATA,U,2))
 . Q:$E(SHARE,1,2)'="\\"
 . I $E(SHARE,$L(SHARE))="\" S SHARE=$E(SHARE,1,$L(SHARE)-1)
 . Q:$D(TMP(SHARE))
 . S TMP(SHARE)=""
 . Q
 S INDX=""
 F  S INDX=$O(TMP(INDX)) Q:INDX=""  D
 . S RESULT(CNT)=INDX,CNT=CNT+1
 . Q
 K TMP
 Q
FSUPDT(RESULT,IEN,SPACE,SIZE) ; File Server Update
 ; RPC[MAGQ FS UPDATE]
 ; Space is field #2 (Total Space)and is actually share size
 ; Size is field #4 (Free Space)
 N NODE,X,Y,INDEX,SHNAME,PLACE
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 K ^TMP("MAGQ","WSUD")
 S ^TMP("MAGQ","WSUD",IEN)=$$FMTE^XLFDT($$NOW^XLFDT)_U_IEN_U_SPACE_U_SIZE
 I $G(^MAG(2005.2,IEN,0))="" S RESULT="-1^No Network Location Entry" Q
 S SHNAME=$P($G(^MAG(2005.2,IEN,0)),U,2)
 D FSW(IEN,SPACE,SIZE) ;The next is to update redundant shares and should not be necessary
 S INDEX=0 F  S INDEX=$O(^MAG(2005.2,"AC",SHNAME,INDEX)) Q:'INDEX  D
 . Q:INDEX=IEN
 . D FSW(INDEX,SPACE,SIZE)
 . Q
 S RESULT="1^Update Complete"
 Q
FSW(IX,SP,SZ) ;
 S $P(^MAG(2005.2,IX,0),U,3)=+SP,$P(^MAG(2005.2,IX,0),U,5)=+SZ
 Q
QUEUER(QUE,FROM,TO) ;
 N TYPE,INC,CNT,AR,TMP,PLACE,INST,MAGFILE
 I $$GET1^DIQ(200,+$G(DUZ),.01)="" D  Q
 . W !,"You must have a valid User ID (DUZ) to use this function!"
 . Q
 I "^JBTOHD^PREFET^ABSTRACT^JUKEBOX^GCC^DELETE^EVAL^"'[QUE D  Q
 . W !,"Only JBTOHD, PREFET, ABSTRACT, JUKEBOX, DELETE, EVAL & GCC queues are valid!"
 . W !,"Input values: ""Queue type"",""From Image IEN"",""To Image IEN"""
 S CNT=0,PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2))),INST=$$GET1^DIQ(2006.1,PLACE,.01,"I")
 F INC=FROM:1:TO D
 . I ('$D(^MAG(2005,INC,0))&('$D(^MAG(2005.1,INC,0)))) Q
 . I $D(^MAG(2005,INC,0)),$$PLACE^MAGBAPI(+$P($G(^MAG(2005,INC,100)),U,3))'=PLACE Q
 . I $D(^MAG(2005.1,INC,0)),$$PLACE^MAGBAPI(+$P($G(^MAG(2005.1,INC,100)),U,3))'=PLACE Q
 . I ($P($G(^MAG(2005,INC,0)),"^",2)="")&($P($G(^MAG(2005.1,INC,0)),"^",2)="") Q  ;No full filename attribute
 . I (+$P($G(^MAG(2005,INC,1,0)),"^",4)>0)!(+$P($G(^MAG(2005.1,INC,1,0)),"^",4)>0) Q  ;GROUP PARENT
 . I "^DELETE^"[QUE D  Q
 . . N MAGXX S MAGXX=INC D VSTNOCP^MAGFILEB I $E(MAGFILE,1,2)="-1" W !,"Image # "_INC Q 
 . . S MAGXX=INC D ABSNOCP^MAGFILEB I $E(MAGFILE,1,2)="-1" W !,"Image # "_INC Q
 . . S MAGXX=INC D BIGNOCP^MAGFILEB I $E(MAGFILE,1,2)="-1" W !,"Image # "_INC Q
 . . D IMAGEDEL^MAGGTID(.MAGFILE,INC,"","TESTING")
 . . Q
 . I "^ABSTRACT^"[QUE D  Q
 . . I $$ABSOK^MAGQBUT1(INC) D MAPI(QUE,INC,.CNT)
 . . Q
 . I "^JBTOHD^PREFET^"[QUE F TYPE="ABSTRACT","FULL","BIG" D
 . . Q:(TYPE="BIG")&('$D(^MAG(2005,INC,"FBIG"))&'$D(^MAG(2005.1,INC,"FBIG")))
 . . D MAPI(QUE,INC_"^"_TYPE,.CNT)
 . . Q
 . E  D MAPI(QUE,INC,.CNT) ; JUKEBOX,EVAL,GCC
 . Q
 Q
MAPI(TYP,PARAM,CNT) ;
 N PLACE
 S CNT=CNT+1,PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 W !,CNT," TYPE: ",TYP,": ",PARAM_" QUEUE #: ",@("$$"_TYP_"^MAGBAPI(PARAM,PLACE)")
 Q
ABSOK(IEN) ; Verify that the Full Image Type is a supported by our ABSTRACT method
 N TYPE,FILE,IFT ; Image file type
 S FILE=$S($D(^MAG(2005,IEN)):$P($G(^MAG(2005,IEN,0)),U,2),$D(^MAG(2005.1,IEN)):$P($G(^MAG(2005.1,IEN,0)),U,2),1:"")
 S TYPE=$P(FILE,".",2)
 S IFT=$S($D(^MAG(2005.021,"B",TYPE)):$O(^MAG(2005.021,"B",TYPE,"")),1:"")
 I (IFT']"")!($P($G(^MAG(2005.021,IFT,0)),U,5)'="1") D  Q 0
 . W !,"Abstract not supported IEN/TYPE: "_IEN_"/"_TYPE
 Q $P($G(^MAG(2005.021,IFT,0)),U,5)
BPQSL(RESULT,TYPE) ; Called from MAGQUEMAN.PAS and MagSiteParameters.PAS
 ; RPC[MAGQB QSL]
 N STATUS,CNT,IEN,CP,PLACE
 S PLACE=$$PLACE^MAGBAPI(+$G(DUZ(2)))
 S STATUS="",CNT=0
 F  S STATUS=$O(^MAGQUEUE(2006.03,"D",PLACE,TYPE,STATUS)) Q:STATUS=""  D
 . Q:+STATUS>0
 . S IEN=$O(^MAGQUEUE(2006.03,"D",PLACE,TYPE,STATUS,""))
 . S CP=$P(^MAGQUEUE(2006.031,$O(^MAGQUEUE(2006.031,"C",PLACE,TYPE,"")),0),"^",2)
 . Q:IEN>(CP)
 . S CNT=CNT+1,RESULT(CNT)=STATUS
 . Q
 Q
CWGIC(CWG) ;  Current RAID Group integrity check
 N VALUE,IEN,MAGFDA,MSG
 S VALUE=""
 F  S VALUE=$O(^MAG(2005.2,CWG,7,"B",VALUE)) Q:'VALUE  D:($P($G(^MAG(2005.2,VALUE,1)),U,8)'=CWG)
 . S IEN=$O(^MAG(2005.2,CWG,7,"B",VALUE,""))
 . S MAGFDA(2005.22,IEN_","_CWG_",",.01)="@"
 . D FILE^DIE("","MAGFDA","")
 . K MAGFDA
 . Q
 Q
GMEM(CWG,IEN) ; Update Current RAID Group
 N GVAL
 S GVAL=$P($G(^MAG(2005.2,IEN,1)),U,8)
 I GVAL,'$D(^MAG(2005.2,GVAL,7,"B",IEN)) D
 . N MAGFDA
 . S MAGFDA(2005.22,"+1,"_GVAL_",",.01)=IEN
 . D UPDATE^DIE("","MAGFDA","","")
 . K MAGFDA
 . Q
 Q $S(GVAL'=CWG:0,1:1)
