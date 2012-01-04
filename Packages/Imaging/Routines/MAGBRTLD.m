MAGBRTLD ;WOIFO/EdM - List of destinations ; 03/09/2005  13:56
 ;;3.0;IMAGING;**9,11,30,51**;26-August-2005
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
LISTALL(TO,LIST) N DEST,N,X
 S TO=$$UPNOPU(TO),N=0 K LIST
 ;
 S DEST="" F  S DEST=$O(^MAG(2005,"ROUTE",DEST)) Q:DEST=""  D
 . S:DEST["MAG(2005.2," DEST(+DEST)=""
 . Q
 ;
 S DEST="" F  S DEST=$O(DEST(DEST)) Q:DEST=""  D
 . N PW
 . S PW=$P($G(^MAG(2005.2,DEST,2)),"^",1,2)
 . S $P(PW,"^",2)=$$DECRYP^MAGDRPC2($P(PW,"^",2))
 . S X=$G(^MAG(2005.2,DEST,0))
 . Q:$$UPNOPU($P(X,"^",1))'[TO
 . S N=N+1,LIST(N)=$P(X,"^",2)_"^"_$P($G(^MAG(2005.2,DEST,4)),"^",2)_"^"_$P(X,"^",8)_"^"_PW_"^"_$P($G(^MAG(2005.2,DEST,3)),"^",5)_"^"_DEST
 . Q
 S LIST=N
 Q
 ;
LIST(TO,LIST) N DEST,N,ORI,PRI,X
 S TO=$$UPNOPU(TO),N=0 K LIST
 ;
 S ORI="" F  S ORI=$O(^MAGQUEUE(2006.035,"STS",ORI)) Q:ORI=""  D
 . S PRI="" F  S PRI=$O(^MAGQUEUE(2006.035,"STS",ORI,"SENT",PRI)) Q:PRI=""  D
 . . S DEST="" F  S DEST=$O(^MAGQUEUE(2006.035,"STS",ORI,"SENT",PRI,DEST)) Q:DEST=""  D
 . . . S:DEST["MAG(2005.2," DEST(+DEST)=""
 . . . Q
 . . Q
 . Q
 ;
 S DEST="" F  S DEST=$O(DEST(DEST)) Q:DEST=""  D
 . N PW
 . S PW=$P($G(^MAG(2005.2,DEST,2)),"^",1,2)
 . S $P(PW,"^",2)=$$DECRYP^XUSRB1($P(PW,"^",2))
 . S X=$G(^MAG(2005.2,DEST,0))
 . Q:$$UPNOPU($P(X,"^",1))'[TO
 . S N=N+1,LIST(N)=$P(X,"^",2)_"^"_$P($G(^MAG(2005.2,DEST,4)),"^",2)_"^"_$P(X,"^",8)_"^"_PW_"^"_$P($G(^MAG(2005.2,DEST,3)),"^",5)_"^"_DEST
 . Q
 S LIST=N
 Q
 ;
AVERAGE() N A,D0,D1,N,P,X
 S (A,N)=0
 S D0=0 F  S D0=$O(^MAGQUEUE(2006.036,D0)) Q:'D0  D
 . S N=N+1
 . S D1=0 F  S D1=$O(^MAGQUEUE(2006.036,D0,1,D1)) Q:'D1  D
 . . S X=$G(^MAGQUEUE(2006.036,D0,1,D1,0)) Q:$P(X,"^",6)'["Duration"
 . . F P=1:1:4 S A=A+$P(X,"^",P)
 . . Q
 . Q
 Q A/$S(N:N,1:1)
 ;
UPNOPU(X) Q $TR(X,"abcdefghijklmnopqrstuvwxyz !""#$%&'()*+,-./:;<=>?@[\]^_`{|}~","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
PURGSTAT N COUNT,DATE,FIRST,IMAGE,LAST,LOC
 W !!,"Overview of images to be purged.",!
 S LOC="" F  S LOC=$O(^MAG(2005,"ROUTE",LOC)) Q:LOC=""  D
 . Q:LOC'["MAG(2005.2,"
 . S FIRST=$O(^MAG(2005,"ROUTE",LOC,""))\1
 . S LAST=$O(^MAG(2005,"ROUTE",LOC,""),-1)\1
 . S COUNT=0
 . S DATE="" F  S DATE=$O(^MAG(2005,"ROUTE",LOC,DATE)) Q:DATE=""  D
 . . S IMAGE="" F  S IMAGE=$O(^MAG(2005,"ROUTE",LOC,DATE,IMAGE)) Q:IMAGE=""  S COUNT=COUNT+1
 . . Q
 . W !,COUNT," image" W:COUNT'=1 "s"
 . W " to be purged on ",$P(^MAG(2005.2,+LOC,0),"^",2)
 . W !?5,"(transmitted "
 . I FIRST=LAST W " on ",$$FMD(FIRST)
 . E  W " between ",$$FMD(FIRST)," and ",$$FMD(LAST)
 . W ")"
 . Q
 Q
 ;
FMD(X) Q (X#100)_" "_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",X\100#100)_" "_(X\10000+1700)
 ;
