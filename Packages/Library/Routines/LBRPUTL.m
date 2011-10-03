LBRPUTL ;SFISC/JSR- LBR UTIL2;04/08/99  15:12 [ 05/12/2000  4:31 PM ]
 ;;2.5;Library;**8**;Mar 11, 2000
 Q
NEWCP(XPD,XPDC,XPDP) ;create new check point, returns 0=error or ien
 ;XPD=name, XPDC=call back, XPDP=parameters
 Q:$G(XPD)="" 0
 N %,XPDI,XPDJ,XPDF,XPDY
 ;XPDCP="INI"=Pre-init, "INIT"=Post-init
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713)
 S %=$$FIND1^DIC(XPDI,","_XPDA_",","X",XPD) Q:% %
 S XPDF="+1,"_XPDA_",",XPDJ(XPDI,XPDF,.01)=XPD
 S:$D(XPDC) XPDJ(XPDI,XPDF,2)=XPDC
 S:$D(XPDP) XPDJ(XPDI,XPDF,3)=XPDP
 D UPDATE^DIE("","XPDJ","XPDY")
 Q $G(XPDY(1))
 ;
UPCP(XPD,XPDP) ;update check point, returns 0=error or ien
 ;XPD=name, XPDP=parameters
 N XPDI,XPDJ,XPDF,XPDY
 ;XPDCP="INI"=Pre-init, "INIT"=Post-init
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713),XPDY=$$DICCP($G(XPD))
 Q:'XPDY 0
 S XPDF=XPDY_","_XPDA_","
 S:$D(XPDP) XPDJ(XPDI,XPDF,3)=XPDP
 D FILE^DIE("","XPDJ")
 Q XPDY
 ;
COMCP(XPD) ;complete check point, returns 0=error or date/time
 ;XPD=name
 N XPDD,XPDI,XPDJ,XPDY
 S XPDD=$$NOW^XLFDT()
 S $P(^XTMP("LBRY",LBRVSTA,XPD),"^",2)=XPDD
 Q XPDD
 ;
VERCP(XPD) ;verify check point, returns 1=completed, 0=not
 ;-1=doesn't exist
 ;XPD=name
 N XPDI,XPDY
 S XPDI=$S(XPDCP="INIT":9.716,1:9.713),XPDY=$$DICCP($G(XPD))
 Q:'XPDY -1
 Q ''$$GET1^DIQ(XPDI,XPDY_","_XPDA_",",1,"I")
 ;
PARCP(XPD,XPDF) ;returns parameters of check point
 ;
 ;  Quit with the data value to set into the variable
 Q $P($G(^XTMP("LBRY",LBRVSTA,XPDF)),"^",1)
 ;
CURCP(XPDF) ;returns current check point
 ;XPDF flag - 0=externel, 1=internal
 Q $S($G(XPDF):XPDCHECK,1:XPDCHECK(0))
 ;
DICCP(X) ;lookup check point, returns ien or 0
 Q:$G(X)="" 0
 ;if they pass ien, fail if can't find
 I X=+X S Y=X Q:'$D(^JSR(9.7,XPDA,XPDCP,Y,0)) 0
 E  S Y=$$FIND1^DIC(XPDI,","_XPDA_",","X",X)
 Q Y
MES(X)  ;record message, X=message or an array passed by reference
        N %
        I $D(X)#2 S %=X K X S X(1)=%
        ;write message
        F %=1:1 Q:'$D(X(%))  W !,X(%)
        Q:'$G(XPDA)  D WP^DIE(9.7,XPDA_",",20,"A","X")
        Q
BMES(X) ;add blank line before message
        N %
        I $D(X)#2 S %=X K X S X(1)=" ",X(2)=%
        D MES(.X)
        Q
 ;
