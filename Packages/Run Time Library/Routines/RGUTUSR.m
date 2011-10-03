RGUTUSR ;CAIRO/DKM - Parse recipient list;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Takes a list of recipients (which may be DUZ #'s, names,
 ; mail groups, or special tokens) as input and produces an
 ; array of DUZ's as output.  If a list element is found in
 ; in the token list RGLST, the value of the token entry will
 ; be substituted.
 ; Inputs:
 ;     RGUSR = Semicolon-delimited list of recipients
 ;     RGLST = Special token list
 ; Outputs:
 ;     RGOUT = Local array to receive DUZ list
 ;=================================================================
ENTRY(RGUSR,RGOUT,RGLST) ;
 N RGZ,RGZ1,RGZ2
 K RGOUT
 F RGZ=1:1:$L(RGUSR,";") S RGZ1=$P(RGUSR,";",RGZ) D:RGZ1'=""  S:RGZ1 RGOUT(+RGZ1)=""
 .S:$D(RGLST(RGZ1)) RGZ1=RGLST(RGZ1)
 .Q:RGZ1?.N
 .I RGZ1?1"-"1.N D MGRP(-RGZ1) S RGZ1=0 Q
 .S RGZ2=$E(RGZ1,1,2)
 .I RGZ2="G." D MGRP($E(RGZ1,3,999)) Q
 .I RGZ2="L." D LIST($E(RGZ1,3,999)) Q
 .S RGZ1=$$LKP(RGZ1)
 Q
LKP(RGNAME) ;
 N RGZ,RGZ1
 I $D(^VA(200,"B",RGNAME)) S RGZ=RGNAME G L1
 S RGZ=$O(^(RGNAME)),RGZ1=$O(^(RGZ))
 Q:(RGZ="")!(RGNAME'=$E(RGZ,1,$L(RGNAME))) 0
 Q:(RGZ1'="")&(RGNAME=$E(RGZ1,1,$L(RGNAME))) 0
L1 S RGZ1=$O(^(RGZ,0)),RGZ=$O(^(RGZ1))
 Q:'RGZ1!RGZ 0
 Q RGZ1
LIST(RGLIST) ;
 Q:RGLIST=""
 S:RGLIST'=+RGLIST RGLIST=+$O(^RGCDSS(993.6,"B",RGLIST,0))
 S @$$TRAP^RGZOSF("LERR^RGUTUSR")
 X:$D(^RGCDSS(993.6,RGLIST,1)) ^(1)
LERR Q
MGRP(RGMGRP) ;
 N RGX
 S RGX(0)=""
 D MGRP2(RGMGRP)
 Q
MGRP2(RGMGRP) ;
 N RGZ,RGZ1
 Q:RGMGRP=""
 S:RGMGRP'=+RGMGRP RGMGRP=+$O(^XMB(3.8,"B",RGMGRP,0))
 Q:$D(RGX(RGMGRP))
 S RGX(RGMGRP)=""
 F RGZ=0:0 S RGZ=+$O(^XMB(3.8,RGMGRP,1,RGZ)) Q:'RGZ  S RGOUT(+^(RGZ,0))=""
 F RGZ=0:0 S RGZ=+$O(^XMB(3.8,RGMGRP,5,RGZ)) Q:'RGZ  D MGRP2(^(RGZ,0))
 Q
