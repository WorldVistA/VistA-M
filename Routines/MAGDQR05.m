MAGDQR05 ;WOIFO/EdM - Imaging RPCs for Query/Retrieve ; 26 Mar 2009 11:33 PM
 ;;3.0;IMAGING;**54**;03-July-2009;;Build 1424
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
 ;
TIM ; Overflow from MAGDQR02
 N D0,D1,D2,PAT,SDT,V,X
 ; The references below to ^RADPT are permitted according to the
 ; existing Integration Agreement # 1172
 S V="" F  S V=$O(^RADPT("ADC",V)) Q:V=""  D
 . S D0="" F  S D0=$O(^RADPT("ADC",V,D0)) Q:D0=""  D
 . . S D1="" F  S D1=$O(^RADPT("ADC",V,D0,D1)) Q:D1=""  D
 . . . S SDT=9999999.9999-D1 Q:SDT<FD  Q:SDT>LD
 . . . S D2="" F  S D2=$O(^RADPT("ADC",V,D0,D1,D2)) Q:D2=""  D
 . . . . Q:'$P($G(^RADPT(D0,"DT",D1,"P",D2,0)),"^",17)
 . . . . S ^TMP("MAG",$J,"QR",10,"R^"_D0_"^"_D1_"^"_D2)="",TIM=2
 . . . . S ANY=1,SID=1
 . . . . Q
 . . . Q
 . . Q
 . Q
 S PAT="" F  S PAT=$O(^MAG(2005,"APDTPX",PAT)) Q:PAT=""  D
 . S D1="" F  S D1=$O(^MAG(2005,"APDTPX",PAT,D1)) Q:D1=""  D
 . . S SDT=9999999.9999-D1 Q:SDT<FD  Q:SDT>LD
 . . S D0="" F  S D0=$O(^MAG(2005,"APDTPX",PAT,D1,"CON/PROC",D0)) Q:D0=""  D
 . . . S X=$G(^MAG(2005,D0,2)),V=""
 . . . D:$P(X,"^",6)=2006.5839
 . . . . S V="123^"_$P(X,"^",7)_"^"_D0_"^"_$P(X,"^",7)
 . . . . Q
 . . . D:$P(X,"^",6)=8925
 . . . . N T
 . . . . S T=$P($G(^TIU(8925,+$P(X,"^",7),14)),"^",5) ; IA# 3268
 . . . . S T=$S(T[";GMR(123,":"GMRC-"_(+T),1:"") ; Should use FileMan
 . . . . S V="8925^"_$P(X,"^",7)_"^"_D0_"^"_T
 . . . . Q
 . . . S ^TMP("MAG",$J,"QR",10,"C^"_PAT_"^"_V)="",TIM=2
 . . . S ANY=1,SID=1
 . . . Q
 . . Q
 . Q
 I TIM=1 D  Q
 . D ERR^MAGDQR01("No matches for tag 0008,0020 / 0008,0030")
 . D ERRSAV^MAGDQR01
 . Q
 ;
 Q
 ;
AETITLE(OUT,TITLE,SERVICE,MODE,LOCATION) ; RPC = MAG DICOM CHECK AE TITLE
 N D0,D1,LO,N,OK,SERV,T,UP,X,L
 I $G(TITLE)="" S OUT(1)="-1,No AE Title specified" Q
 S LO="abcdefghijklmnopqrstuvwxyz"
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S TITLE=$TR(TITLE,UP,LO),N=1
 S D0=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D
 . S X=$G(^MAG(2006.587,D0,0)) S T=$TR($P(X,"^",2),UP,LO) Q:T'=TITLE
 . S L=$P(X,"^",7)  Q:L'=LOCATION
 . S SERV=$P(X,"^",1) S:SERV="" SERV="?" Q:$G(SERV(SERV))
 . I $G(SERVICE)'="",$G(MODE)'="" D  Q:'OK
 . . S OK=0,D1=0 F  S D1=$O(^MAG(2006.587,D0,1,D1)) Q:'D1  D  Q:OK
 . . . S T=$G(^MAG(2006.587,D0,1,D1,0)) Q:T=""
 . . . Q:$TR($P(T,"^",1),UP,LO)'=$TR(SERVICE,UP,LO)
 . . . I $TR(MODE,UP,LO)="scu",'$P(T,"^",2) Q
 . . . I $TR(MODE,UP,LO)="scp",'$P(T,"^",3) Q
 . . . S OK=1
 . . . Q
 . . Q
 . S SERV(SERV)=1
 . S N=N+1,OUT(N)=SERV_"^"_$P(X,"^",3)_"^"_$P(X,"^",4)
 . Q
 I N=1 S OUT(1)="-2,No entry for AE Title """_TITLE_""" at location """_LOCATION_"""." Q
 S OUT(1)=N-1_",OK"
 Q
 ;
VATITLE(OUT,SERVICE,MODE,LOCATION) ; RPC = MAG DICOM VISTA AE TITLE
 N AE,D0,D1,LO,OK,UP,X0,X1,L
 S LO="abcdefghijklmnopqrstuvwxyz"
 S UP="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S SERVICE=$TR($G(SERVICE),LO,UP)
 S MODE=$TR($G(MODE),LO,UP)
 S AE("C-MOVE","SCU")="VistA_QR_SCU"
 S AE("C-STORE","SCU")="VistA_Send_Image"
 S AE("C-FIND","SCU")="VISTA_QR_SCU"
 S AE("C-MOVE","SCP")="VistA_QR_SCP"
 S AE("C-STORE","SCP")="VistA_Storage"
 S AE("C-FIND","SCP")="VISTA_QR_SCP"
 S OUT="" I SERVICE'="",MODE'="" D
 . S OUT=$G(AE(SERVICE,MODE)) S:OUT'="" OUT="1,"_OUT
 . S (D0,OK)=0 F  S D0=$O(^MAG(2006.587,D0)) Q:'D0  D  Q:OK
 . . S X0=$G(^MAG(2006.587,D0,0))
 . . S L=$P(X0,"^",7)  Q:L'=LOCATION
 . . S D1=0 F  S D1=$O(^MAG(2006.587,D0,1,D1)) Q:'D1  D  Q:OK
 . . . S X1=$G(^MAG(2006.587,D0,1,D1,0))
 . . . Q:$P(X1,"^",1)'=SERVICE
 . . . I MODE="SCU",$P(X1,"^",2) S OK=1
 . . . I MODE="SCP",$P(X1,"^",3) S OK=1
 . . . S:OK OUT="1,"_$P(X0,"^",2)
 . . . Q
 . . Q
 . Q
 S:OUT="" OUT="-1,No title for """_SERVICE_""", """_MODE_""" at location """_LOCATION_"""."
 Q
 ;
GWINFO(OUT,HOSTNAME,LOCATION,FILES,VER) ; RPC = MAG DICOM STORE GATEWAY INFO
 N D0,X
 I $G(HOSTNAME)="" S OUT="-1,No HostName provided." Q
 I '$G(LOCATION) S OUT="-3,No location provided." Q
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S D0=$O(^MAG(2006.87,"B",HOSTNAME,"")) D:'D0
 . L +^MAG(2006.87,0):1E9 ; Background process MUST wait
 . S X=$G(^MAG(2006.87,0))
 . S $P(X,"^",1,2)="DICOM GATEWAY INFORMATION^2006.87"
 . S D0=$O(^MAG(2006.87," "),-1)+1
 . S $P(X,"^",3)=D0
 . S $P(X,"^",4)=$P(X,"^",4)+1
 . S ^MAG(2006.87,0)=X
 . S ^MAG(2006.87,D0,0)=HOSTNAME
 . S ^MAG(2006.87,"B",HOSTNAME,D0)=""
 . L -^MAG(2006.87,0)
 . Q
 S ^MAG(2006.87,D0,0)=HOSTNAME_"^"_"^"_(+LOCATION)
 D GWLOG(.FILES,"INSTRUMENT",D0,1)
 D GWLOG(.FILES,"MODALITY",D0,2)
 D GWLOG(.FILES,"PORTLIST",D0,3)
 D GWLOG(.FILES,"SCU_LIST",D0,4)
 D GWLOG(.FILES,"WORKLIST",D0,5)
 D GWLOG(.FILES,"CT_PARAM",D0,6)
 D GWLOG(.VER,"GW",D0,100)
 D GWLOG(.VER,"MAG_DCMVIEW",D0,101)
 D GWLOG(.VER,"MAG_MAKEABS",D0,102)
 D GWLOG(.VER,"MAG_CSTORE",D0,103)
 D GWLOG(.VER,"MAG_RECON",D0,104)
 D GWLOG(.VER,"MAG_DCMTOTGA",D0,105)
 S OUT=0
 Q
 ;
GWLOG(ARRAY,NAME,D0,F) ;
 S:$D(ARRAY(NAME)) ^MAG(2006.87,D0,F)=ARRAY(NAME)
 Q
 ;
GETINFO(OUT,HOSTNAME) ; RPC = MAG DICOM GET GATEWAY INFO
 N D0,N,X
 I $G(HOSTNAME)="" S OUT="-1,No HostName provided." Q
 S HOSTNAME=$TR(HOSTNAME,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 S D0=$O(^MAG(2006.87,"B",HOSTNAME,""))
 I 'D0 S OUT(1)="-2,Cannot find info for """_HOSTNAME_"""." Q
 S N=1
 S X=$G(^MAG(2006.87,D0,0))
 S:$P(X,"^",3) N=N+1,OUT(N)="Loc="_$P(X,"^",3)
 D GWGET($G(^MAG(2006.87,D0,1)),"In")
 D GWGET($G(^MAG(2006.87,D0,2)),"Mo")
 D GWGET($G(^MAG(2006.87,D0,3)),"PL")
 D GWGET($G(^MAG(2006.87,D0,4)),"SL")
 D GWGET($G(^MAG(2006.87,D0,5)),"WL")
 D GWGET($G(^MAG(2006.87,D0,6)),"CP")
 S X=$G(^MAG(2006.87,D0,100)) S:X'="" N=N+1,OUT(N)="Ver="_X
 D GWGET($G(^MAG(2006.87,D0,101)),"Vw")
 D GWGET($G(^MAG(2006.87,D0,102)),"Ab")
 D GWGET($G(^MAG(2006.87,D0,103)),"CS")
 D GWGET($G(^MAG(2006.87,D0,104)),"Rc")
 D GWGET($G(^MAG(2006.87,D0,105)),"DT")
 S OUT(1)=N
 Q
 ;
GWGET(X,K) N T
 Q:X=""
 S:$P(X,"^",2)'="" N=N+1,OUT(N)=K_"_p="_$P(X,"^",2)
 S T=$P(X,"^",1) Q:'T
 S N=N+1,OUT(N)=K_"_s="_$$STAMP(T)
 Q
 ;
STAMP(T) N O,V
 S V=(T\1#100)_"-"_$P("JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC"," ",T\100#100)_"-"_(T\10000+1700)
 S O=$E($P(T,".",2)_"000000",1,6),V=V_" "_$E(O,1,2)_":"_$E(O,3,4)_":"_$E(O,5,6)
 Q V
 ;
