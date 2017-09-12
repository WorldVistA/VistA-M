IBDY2117 ;ALB/JLS - KIDS post-install for patch IBD*2.1*17
 ;;Version 2.1 ; AUTOMATED INFO COLLECTION SYS ;**17**; 3-APR-96
 ;
 D PXACT,ICD9
 Q
 ;
PXACT ; -- if PCE is installed, activate Selection Interfaces in file 357.6.
 N I,J,X,Y
 I $D(^AUTTEDT(0)) D  ; education topics installed
 .F I=1:1 S X=$P($T(INTRFCE+I),";;",2) Q:X=""  D
 ..S IBDIEN=$O(^IBE(357.6,"B",X,0))
 ..Q:'IBDIEN
 ..Q:$G(^IBE(357.6,IBDIEN,0))=""
 ..Q:$P($G(^IBE(357.6,IBDIEN,0)),"^",9)=1  ; already available
 ..S $P(^IBE(357.6,IBDIEN,0),"^",9)=1 ; makes it available
 ..D MES^XPDUTL(">>> Updating Package Interface Entry for "_X)
 ..Q
 .Q
 K IBDIEN
 Q
 ;
INTRFCE ;
 ;;PX SELECT EDUCATION TOPICS
 ;;PX SELECT EXAMS
 ;;PX SELECT HEALTH FACTORS
 ;;PX SELECT IMMUNIZATIONS
 ;;PX SELECT SKIN TESTS
 ;;PX SELECT TREATMENTS
 ;;
 ;
ICD9 N IBDA,IBDX
 S IBDA=0 F  S IBDA=$O(^IBE(357.6,"B","INPUT DIAGNOSIS CODE (ICD9)",IBDA)) Q:'IBDA  D
 .S IBDX=$G(^IBE(357.6,IBDA,0))
 .Q:IBDX=""!($P(IBDX,"^")'="INPUT DIAGNOSIS CODE (ICD9)")
 .Q:$P($G(^IBE(357.6,IBDA,12)),"^")="DIAGNOSIS/PROBLEM"
 .S ^IBE(357.6,IBDA,12)="DIAGNOSIS/PROBLEM^1^13^14^2^^^"
 .D MES^XPDUTL(">>> Updating Package Interface Entry for INPUT DIAGNOSIS CODE (ICD9)")
 .Q
 Q
