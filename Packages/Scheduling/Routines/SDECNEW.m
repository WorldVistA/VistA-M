SDECNEW ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ;
 ;  PROGRAMMERS:  DO NOT USE THE FIRST LINE FOR ENTRY.
 ;                USE LABEL EN^XBNEW() FOR ENTRY.
 ;
 ; EN^XBNEW("TAG^ROUTINE","variable list")
 ;
 ; Variable list has the form "AGDFN;AGINS;AGP*".
 ; Wild card * allowed.
 ;
 ; XBRET has the form "TAG^ROUTINE:VAR;NSVAR*"
 ;
 ; This allows for the nesting of die calls by
 ;
 ; 1. Building and executing an exclusive new from preselected
 ;    kernel variables and any local variables &/or name
 ;    spaces identified by the calling parameter.
 ;
 ; 2. After executing the new (....) XBNEW performs a DO call
 ;    to the program entry point identified by the calling
 ;    parameter.  The entry point passed should build the
 ;    variables and execute the DIE call to be nested.
 ;
 ; 3. As XBNEW quits to return to the calling program it pops
 ;    the variable stack.
 ;
 ;
 NEW XB,XBNS,XBN,XB,XBY,XBL,XBKVAR
 G S
 ;
EN(XBRT,XBNS) ;PEP XBRT=TAG^ROUTINE  XBNS=variable list ";" with * allowed
 NEW XB,XBN,XB,XBY,XBL,XBKVAR,XBRET
 S XBRET=XBRT_":"_XBNS
S ;
 N XBI
 I XBRET'[":" S XBRET=XBRET_":"
 S XBN="XBRET",XBKVAR=$P($T(XBKVAR),";;",2),XBNS=$P(XBRET,":",2)
 I XBNS="" G RETURN
 F XBI=1:1 S (XB,XBY)=$P(XBNS,";",XBI) Q:XB=""  D
 . I XB'["*" S XBN=XBN_","_XB Q
 . S (XB,XBY)=$P(XB,"*"),XBN=XBN_","_XB,XBL=$L(XB)
 . F  S XBY=$O(@XBY) Q:((XBY="")!(XB'=$E(XBY,1,XBL)))  S XBN=XBN_","_XBY
 .Q
RETURN ;
 S XBN="("_XBN_","_XBKVAR_")",$P(XBRET,":",2)=XBN
NEW ;
 NEW @($P(XBRET,":",2))
 D @($P(XBRET,":",1))
 Q
 ;
END ;--------------------------------------------------------------
 ; the following taken from the variable list in KILL^XUSCLEAN from  KERNEL
XBKVAR ;;DUZ,DTIME,DT,DISYS,IO,IOBS,IOF,IOM,ION,IOSL,IOST,IOT,IOS,IOXY,U,XRTL,%ZH0,XQVOL,XQY,XQY0,XQDIC,XQPSM,XQPT,XQAUDIT,XQXFLG,ZTSTOP,ZTQUEUED,ZTREQ,XQORS;; IHS/SET/GTH XB*3*9 10/29/2002
 ;;DUZ,DTIME,DT,DISYS,IO,IOF,IOBS,IOM,ION,IOSL,IOST,IOT,IOS,IOXY,U,XRTL,ZTSTOP,ZTQUEUED,ZTREQ
 ;--------------------------------------------------------------
 Q
 ;
