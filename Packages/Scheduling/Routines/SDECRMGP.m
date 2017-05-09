SDECRMGP ;ALB/JSM - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**658**;Aug 13, 1993;Build 23
 ;
 ;
 Q
 ;
PUTRMGUP(RET,SDECUSER,INP...) ; Save Request Manager Grid preferences for user.
 ;PUT1(RET,SDECUSER,INP)  ;text input
 ;INPUT:
 ; SDECUSER   - USER id pointer to NEW PERSON file (#200)
 ; INP(1-x) - Array of filter string text in which each array entry contains no more than 80 characters.
 ;RETURN:
 ; Successful Return:
 ;   Single Value return in the format "0^"
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N ERR,SDI,SDC,END,FIL,FIL1,FILTERIN,FLTR
 ;S RET="^TMP(""SDECRMGP"","_$J_",""USRPREF"")"
 S END=78
 ;K @RET
 ; data header
 ;S RET="T00030RETURNCODE^T00050TEXT"_$C(30)
 S SDECUSER=$G(SDECUSER)
 ;D:SDECUSER=113 ^%ZTER
 I SDECUSER'="",'$D(^VA(200,SDECUSER,0)) S RET="-1^Invalid user ID "_SDECUSER Q
 I SDECUSER="" S SDECUSER=DUZ
 S SDC=0
 S SDI=-1 F  S SDI=$O(INP(SDI)) Q:SDI=""  D
 .S FILTERIN=$G(INP(SDI))
 .Q:FILTERIN=""
 .S FIL=FILTERIN
 .F  Q:FIL=""  D
 ..S:$E(FIL,END)=" " $E(FIL,END)="~"
 ..S FIL1=$E(FIL,1,END)
 ..S FIL=$S($L(FIL)>END:$E(FIL,END+1,$L(FIL)),1:"")
 ..S SDC=SDC+1 S FLTR(SDC,0)=FIL1
 S:SDC>0 FLTR="SET USER PREFERENCES"
 I FLTR'="" D EN^XPAR(SDECUSER_";VA(200,","SDEC REQ MGR GRID FILTER",1,.FLTR,.ERR)
 I ERR S RET="-1^FILTER ERR: "_$P(ERR,U,1)_";"_$P(ERR,U,2) Q
 S RET="0^SUCCESS"
 ;
 Q
 ;
GETRMGUP(RET,SDECUSER)  ; Get Request Manager Grid preferences for user.
 ;
 ;  RETURN: The Filter delimited by "|" as it was provided by GUI to store
 ;          OR -1:ERR
 ;
 N ERR,SDI,SDC,FIL,FLTR
 S RET=""  ;"T00500FILTER"_$C(30)
 S SDECUSER=$G(SDECUSER)
 I SDECUSER="" S SDECUSER=DUZ
 ; setup array for word processing
 D GETWP^XPAR(.FLTR,SDECUSER_";VA(200,","SDEC REQ MGR GRID FILTER",1,.ERR)
 ;I ERR S RET=RET_"-1: "_ERR_$C(30,31) Q
 I ERR S RET="-1: "_ERR Q
 S SDC=0 F  S SDC=$O(FLTR(SDC)) Q:SDC=""  D
 .S FIL=FLTR(SDC,0)
 .I $E(FIL,1,2)="~~" S RET=RET_$E(FIL,3,$L(FIL))
 .E  S RET=RET_FLTR(SDC,0)
 S:RET="" RET="-1: NO USER PREFERENCE SET"
 ;.E  S RET=RET_$S(SDC>1:"|",1:"")_FLTR(SDC,0)
 ;S:$O(FLTR(0)) RET=RET_$C(30)
 ;S RET=RET_$C(31)
 ;
 Q
GET2(RET,SDECUSER)  ; Get Request Manager Grid preferences for user.
 ;
 ;  RETURN: The Filter delimited by "|" as it was provided by GUI to store
 ;          OR -1:ERR
 ;
 N ERR,SDI,SDC,END,FIL,FLTR
 S END=78
 S RET="T00500FILTER"_$C(30)
 S SDECUSER=$G(SDECUSER)
 I SDECUSER="" S SDECUSER=DUZ
 ; setup array for word processing
 D GETWP^XPAR(.FLTR,SDECUSER_";VA(200,","SDEC REQ MGR GRID FILTER",1,.ERR)
 I ERR S RET=RET_"-1: "_ERR_$C(30,31) Q
 S SDC=0 F  S SDC=$O(FLTR(SDC)) Q:SDC=""  D
 .S FIL=FLTR(SDC,0)
 .S:$E(FIL,$L(FIL))="~" $E(FIL,$L(FIL))=" "
 .S RET=RET_FIL
 S:$O(FLTR(0)) RET=RET_$C(30)
 S RET=RET_$C(31)
 ;
 Q
