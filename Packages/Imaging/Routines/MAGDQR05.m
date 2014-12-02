MAGDQR05 ;WOIFO/EdM,MLH,DAC - Imaging RPCs for Query/Retrieve ; 07 Feb 2013 5:18 PM
 ;;3.0;IMAGING;**54,118,138**;Mar 19, 2002;Build 5380;Sep 03, 2013
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
TIM(REQ,FD,LD,TIM,ANY,SID) ; Overflow from MAGDQR02
 N D0,D1,D2,I,PAT,SDT,V,X,STDATE,STTIME,STUDYIX,STUTYP,STUDTA,DAT0,DATF,TIM0,TIMF,T,P
 N PROCIX,PATREFIX,PATREFDTA,SERIX,SOPIX
 D:$D(REQ("0008,0020"))>9
 . ; search old structure for studies by date and time
 . ; The references below to ^RADPT are permitted according to the
 . ; existing Integration Agreement # 1172
 . S V="" F  S V=$O(^RADPT("ADC",V)) Q:V=""  D
 . . S D0="" F  S D0=$O(^RADPT("ADC",V,D0)) Q:D0=""  D
 . . . S D1="" F  S D1=$O(^RADPT("ADC",V,D0,D1)) Q:D1=""  D
 . . . . S SDT=9999999.9999-D1 Q:SDT<FD  Q:SDT>LD
 . . . . S D2="" F  S D2=$O(^RADPT("ADC",V,D0,D1,D2)) Q:D2=""  D
 . . . . . Q:'$P($G(^RADPT(D0,"DT",D1,"P",D2,0)),"^",17)
 . . . . . S ^TMP("MAG",$J,"QR",10,"R^"_D0_"^"_D1_"^"_D2)="",TIM=2
 . . . . . S ANY=1,SID=1
 . . . . . Q
 . . . . Q
 . . . Q
 . . Q
 . S PAT="" F  S PAT=$O(^MAG(2005,"APDTPX",PAT)) Q:PAT=""  D
 . . S D1="" F  S D1=$O(^MAG(2005,"APDTPX",PAT,D1)) Q:D1=""  D
 . . . S SDT=9999999.9999-D1 Q:SDT<FD  Q:SDT>LD
 . . . S D0="" F  S D0=$O(^MAG(2005,"APDTPX",PAT,D1,"CON/PROC",D0)) Q:D0=""  D
 . . . . S X=$G(^MAG(2005,D0,2)),V=""
 . . . . D:$P(X,"^",6)=2006.5839
 . . . . . S V="123^"_$P(X,"^",7)_"^"_D0_"^"_$P(X,"^",7)
 . . . . . Q
 . . . . D:$P(X,"^",6)=8925
 . . . . . N T
 . . . . . S T=$P($G(^TIU(8925,+$P(X,"^",7),14)),"^",5) ; IA# 3268
 . . . . . S T=$S(T[";GMR(123,":$$GMRCACN^MAGDFCNV(+T),1:"") ; Should use FileMan
 . . . . . S V="8925^"_$P(X,"^",7)_"^"_D0_"^"_T
 . . . . . Q
 . . . . S ^TMP("MAG",$J,"QR",10,"C^"_PAT_"^"_V)="",TIM=2
 . . . . S ANY=1,SID=1
 . . . . Q
 . . . Q
 . . Q
 . Q
 ; search new structure for studies by date and time
 S T="0008,0020" ; search by date and time
 D:$D(REQ(T))>9
 . S P=$O(REQ(T,"")) Q:P=""  S (DAT0,DATF)=$G(REQ(T,P)) Q:DAT0=""
 . S:DAT0["-" DATF=$P(DAT0,"-",2),DAT0=$P(DAT0,"-",1)
 . S DAT0=DAT0-17000000,DATF=DATF-17000000
 . S T="0008,0030" D:$D(REQ(T))>9
 . . S P=$O(REQ(T,"")),(TIM0,TIMF)=$G(REQ(T,P)) Q:TIM0=""
 . . S:TIM0["-" TIMF=$P(TIM0,"-",2),TIM0=$P(TIM0,"-",1)
 . . S TIM0=$E(TIM0_"000000",1,6),TIMF=$E(TIMF_"000000",1,6)
 . . Q
 . S STDATE=$O(^MAGV(2005.62,"J",DAT0),-1)
 . F  S STDATE=$O(^MAGV(2005.62,"J",STDATE)) Q:STDATE>DATF  Q:'STDATE  D
 . . S STUDYIX=""
 . . F  S STUDYIX=$O(^MAGV(2005.62,"J",STDATE,STUDYIX)) Q:STUDYIX=""  D
 . . . Q:$P($G(^MAGV(2005.62,STUDYIX,5)),"^",2)="I"  ; study marked inaccessible
 . . . N HIT
 . . . S HIT=1
 . . . D:$D(TIM0)
 . . . . S HIT=0
 . . . . S STTIME=$P($P($G(^MAGV(2005.62,STUDYIX,2)),"^",1),".",2) Q:STTIME=""
 . . . . S STTIME=$E((STTIME\1)_"000000",1,6)
 . . . . I STTIME'<TIM0,STTIME'>TIMF S HIT=1
 . . . . Q
 . . . S:HIT ^TMP("MAG",$J,"QR",30,STUDYIX)=""
 . . . Q
 . . Q
 . Q
 S T="0008,0030" ; search by time alone
 D:$D(REQ(T))>9
 . Q:$D(REQ("0008,0020"))>9  ; already did date & time search
 . S P=$O(REQ(T,"")) Q:P=""  S (TIM0,TIMF)=$G(REQ(T,P)) Q:TIM0=""
 . S:TIM0["-" TIMF=$P(TIM0,"-",2),TIM0=$P(TIM0,"-",1)
 . S TIM0=$E(TIM0_"000000",1,6),TIMF=$E(TIMF_"000000",1,6)
 . S STTIME=$O(^MAGV(2005.62,"K",TIM0),-1)
 . F  S STTIME=$O(^MAGV(2005.62,"K",STTIME)) Q:STTIME>TIMF  Q:'STTIME  D
 . . S STUDYIX=""
 . . F  S STUDYIX=$O(^MAGV(2005.62,"K",STTIME,STUDYIX)) Q:STUDYIX=""  D
 . . . Q:$P($G(^MAGV(2005.62,STUDYIX,5)),"^",2)="I"  ; study marked inaccessible
 . . . S ^TMP("MAG",$J,"QR",30,STUDYIX)=""
 . . . Q
 . . Q
 . Q
 D:$D(^TMP("MAG",$J,"QR",30))
 . S TIM=2,STUDYIX=""
 . F  S STUDYIX=$O(^TMP("MAG",$J,"QR",30,STUDYIX)) Q:'STUDYIX  D
 . . S PROCIX=$P($G(^MAGV(2005.62,STUDYIX,6)),"^",1) Q:'PROCIX
 . . S PATREFIX=$P($G(^MAGV(2005.61,PROCIX,6)),"^",1) Q:'PATREFIX
 . . S PATREFDTA=$G(^MAGV(2005.6,PATREFIX,0)) Q:$P(PATREFDTA,"^",3)'="D"
 . . S PAT=$P(PATREFDTA,"^",1) Q:PAT=""
 . . S ^TMP("MAG",$J,"QR",10,"N^"_PAT_"^"_STUDYIX)=""
 . . S ANY=1,SID=1
 . . Q
 . K ^TMP("MAG",$J,"QR",30)
 . Q
 I TIM=1 D  Q
 . D ERR^MAGDQRUE("No matches for tag 0008,0020 / 0008,0030")
 . D ERRSAV^MAGDQRUE
 . Q
 ;
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
 S:$P(X,"^",3) N=N+1,OUT(N)="Loc="_$$STA^XUAF4($P(X,"^",3))
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
