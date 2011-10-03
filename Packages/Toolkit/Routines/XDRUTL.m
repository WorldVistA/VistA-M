XDRUTL ;SF-IRMFO/RSD - XDR utilities ;11/3/95  16:32
 ;;7.3;TOOLKIT;**23**;Apr 25, 1995
 ;;
 Q
 ;
NEWCP(XDR,XDRP) ;create new check point, returns 0=error or ien
 ;XDR=name, XDRP=parameters
 Q:$G(XDR)="" 0
 N %,XDRI,XDRJ,XDRF,XDRY
 S %=$$FIND1^DIC(15.013,","_XDRMPDA_",","X",XDR) Q:% %
 S XDRF="+1,"_XDRMPDA_",",XDRJ(15.013,XDRF,.01)=XDR
 S:$D(XDRP) XDRJ(15.013,XDRF,1)=XDRP
 D UPDATE^DIE("","XDRJ","XDRY")
 Q $G(XDRY(1))
 ;
UPCP(XDR,XDRP) ;update check point, returns 0=error or ien
 ;XDR=name, XDRP=parameters
 N XDRI,XDRJ,XDRF,XDRY
 S XDRY=$$DICCP($G(XDR))
 Q:'XDRY 0
 S XDRF=XDRY_","_XDRMPDA_","
 S:$D(XDRP) XDRJ(15.013,XDRF,1)=XDRP
 D FILE^DIE("","XDRJ")
 Q XDRY
 ;
COMCP(XDR) ;complete check point, returns 0=error or date/time
 ;XDR=name
 N XDRD,XDRI,XDRJ,XDRY
 S XDRY=$$DICCP($G(XDR))
 Q:'XDRY 0
 S XDRD=$$NOW^XLFDT,XDRJ(15.013,XDRY_","_XDRMPDA_",",1)=XDRD
 D FILE^DIE("","XDRJ")
 Q XDRD
 ;
VERCP(XDR) ;verify check point exists, returns 1=exist, 0=doesn't
 ;XDR=name
 N XDRI,XDRY
 S XDRY=$$DICCP($G(XDR))
 Q $S('XDRY:0,1:1)
 ;
PARCP(XDR,XDRF) ;returns parameters of check point
 ;XDR=name, XDRF="PRE"
 N XDRI,XDRY
 I $G(XDRF)="PRE" N XDRCP S XDRCP="INI"
 S XDRY=$$DICCP($G(XDR))
 Q:'XDRY 0
 Q $$GET1^DIQ(15.013,XDRY_","_XDRMPDA_",",1,"I")
 ;
DICCP(X) ;lookup check point, returns ien or 0
 Q:$G(X)="" 0
 I X=+X S Y=X Q:'$D(^VA(15,XDRMPDA,"CP",Y,0)) 0
 E  S Y=$$FIND1^DIC(15.013,","_XDRMPDA_",","X",X)
 Q Y
