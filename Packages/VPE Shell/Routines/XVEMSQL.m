XVEMSQL ;DJB/VSHL**QWIKs - List QWIKs ;2017-08-16  10:35 AM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ; Error trap removed test trap at IMPORT (c) 2016 Sam Habiel
 ;
LISTQ(BOX,TYPE) ;List QWIKs. BOX=Display Box
 ;TYPE=1-User Desc,2-User Code,3-Sys Desc,4-Sys Code
 NEW CNT,FLAGQ,TEMP,X
 NEW DX,DY,XVVT NEW:'$D(XVVS) XVVS
 S BOX=$G(BOX),FLAGQ=0 S:$G(TYPE)="" TYPE=1
 D IMPORT,@$S("34"[TYPE:"LISTS",1:"LISTU")
 D IMPORTF^XVEMKT KILL ^TMP("XVV",$J,"K")
 Q
LISTU ;List User QWIKs
 S CNT=1,X="@"
 F  S X=$O(^XVEMS("QU",XVV("ID"),X)) Q:X=""  D LISTU1 Q:FLAGQ
 I CNT=1 D
 . I BOX S XVVT="No User QWIKs assigned to this box." D ^XVEMKT Q
 . S XVVT="No User QWIKs on record. Is your DUZ correct?" D ^XVEMKT
 Q
LISTU1 ;
 Q:$G(^XVEMS("QU",XVV("ID"),X))']""
 I BOX,$P($G(^(X,"DSC")),"^",3)'=BOX Q
 S XVVT=$J(CNT,3)_") "_X,XVVT=XVVT_$J("",15-$L(XVVT))
 I 'BOX S XVVT=XVVT_$J($P($G(^XVEMS("QU",XVV("ID"),X,"DSC")),"^",3),4)_"  "
 I TYPE=1 D
 . S XVVT=XVVT_$P($G(^XVEMS("QU",XVV("ID"),X,"DSC")),"^")
 . D ^XVEMKT Q:FLAGQ
 . Q:$P($G(^XVEMS("QU",XVV("ID"),X,"DSC")),"^",2)']""
 . S TEMP=$S('BOX:21,1:15)
 . S XVVT=$J("",TEMP)_"-> "_$P(^("DSC"),"^",2) D ^XVEMKT Q
 I TYPE=2 D
 . S TEMP=$S($D(^XVEMS("QU",XVV("ID"),X,XVV("OS"))):^(XVV("OS")),1:^XVEMS("QU",XVV("ID"),X)) D CD
 S CNT=CNT+1
 Q
LISTS ;List System QWIKs
 S CNT=1,X="@"
 F  S X=$O(^XVEMS("QS",X)) Q:X=""  D LISTS1 Q:FLAGQ
 I CNT=1 D
 . I 'BOX S XVVT="No System QWIKs on record." D ^XVEMKT Q
 . S XVVT="No System QWIKs assigned to this box." D ^XVEMKT
 Q
LISTS1 ;
 Q:$G(^XVEMS("QS",X))']""
 I BOX,$P($G(^(X,"DSC")),"^",3)'=BOX Q
 S XVVT=$J(CNT,3)_") "_X,XVVT=XVVT_$J("",15-$L(XVVT))
 I 'BOX S XVVT=XVVT_$J($P($G(^XVEMS("QS",X,"DSC")),"^",3),4)_"  "
 I TYPE=3 D
 . S XVVT=XVVT_$P($G(^XVEMS("QS",X,"DSC")),"^")
 . D ^XVEMKT Q:FLAGQ
 . Q:$P($G(^XVEMS("QS",X,"DSC")),"^",2)']""
 . S TEMP=$S('BOX:21,1:15)
 . S XVVT=$J("",TEMP)_"-> "_$P(^("DSC"),"^",2) D ^XVEMKT Q
 I TYPE=4 D
 . S TEMP=$S($D(^XVEMS("QS",X,XVV("OS"))):^(XVV("OS")),1:^XVEMS("QS",X)) D CD
 S CNT=CNT+1
 Q
CD ;Print Code without wrapping
 I BOX D CDBX Q
 S XVVT=XVVT_$E(TEMP,1,57) D ^XVEMKT Q:FLAGQ  S TEMP=$E(TEMP,58,999)
CD1 Q:TEMP']""  S XVVT=$J("",20)_$E(TEMP,1,57) D ^XVEMKT Q:FLAGQ
 S TEMP=$E(TEMP,58,999)
 G CD1
CDBX ;Print Code without wrapping when Boxes aren't displayed
 S XVVT=XVVT_$E(TEMP,1,63) D ^XVEMKT Q:FLAGQ  S TEMP=$E(TEMP,64,999)
CDBX1 Q:TEMP']""  S XVVT=$J("",15)_$E(TEMP,1,63) D ^XVEMKT Q:FLAGQ
 S TEMP=$E(TEMP,64,999)
 G CDBX1
IMPORT ;Use Scroller
 NEW HD1,HD2,HD3,LINE,MAR
 S MAR=$G(XVV("IOM")) S:MAR'>0 MAR=80
 S $P(LINE,"=",MAR)=""
 S HD1="U S E R   Q W I K S   (.QWIK)    ID: "_XVV("ID")
 S HD2="S Y S T E M   Q W I K S   (..QWIK)    ID: "_XVV("ID")
 S HD3="BOX: "_BOX
 S XVVT("HD")=2
 I "1,2"[TYPE S XVVT("HD",1)=HD1_$J(HD3,MAR-1-$L(HD1)-$L(HD3))
 I "3,4"[TYPE S XVVT("HD",1)=HD2_$J(HD3,MAR-1-$L(HD2)-$L(HD3))
 S XVVT("HD",2)=LINE
 S XVVT("S1")=3 D IMPORTS^XVEMKT("K")
 I $G(XVSIMERR) S $EC=",U-SIM-ERROR,"
 Q
ERROR ;
 D ENDSCR^XVEMKT2 KILL ^TMP("XVV",$J,"K")
 D ERRMSG^XVEMKU1("'Scroll QWIKs'"),PAUSE^XVEMKU(2)
 Q
