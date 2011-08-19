MAGQBUT2 ;WOIFO/SRR/RMP - IMAGE SITE PARAMETERS COMPANION ; 31 Jan 2011 3:06 PM
 ;;3.0;IMAGING;**7,8,20,81,39**;Mar 19, 2002;Build 2010;Mar 08, 2011
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
MAGSYS(LIST) ;
 ; RPC[MAGQ SYSTEM]
 N VAIEN,NODE,MGIEN,UNAME,TDATE
 S MGIEN=$$FIND1^DIC(3.8,"","MX","MAG SERVER","","","ERR")
 S VAIEN=0
 F  S VAIEN=$O(^XUSEC("MAG SYSTEM",VAIEN)) Q:VAIEN'?1N.N  D
 . S UNAME=$$GET1^DIQ(200,VAIEN,.01)
 . Q:UNAME=""
 . ;CHECK FOR TERMINATION DATE
 . S TDATE=$$GET1^DIQ(200,VAIEN,9.2)
 . Q:((TDATE'="")&(TDATE<$$NOW^XLFDT))
 . ;the next line screens existing 'MAG SERVER' members
 . I MGIEN?1N.N,$$FIND1^DIC(3.81,","_MGIEN_",","QA",VAIEN,"","","ERR") Q
 . S LIST(VAIEN)=VAIEN_"^"_UNAME
 Q
IMPAR(RESULT,QIEN) ; Import Array
 N INDX,CNT
 S (INDX,CNT)=0
 F  S INDX=$O(^MAG(2006.034,QIEN,1,INDX)) Q:INDX'?1N.N  D
 . S CNT=CNT+1
 . S RESULT(CNT)=$G(^MAG(2006.034,QIEN,1,INDX,0))
 I CNT<1 S RESULT(0)="0^Corrupted Import Array"
 E  S RESULT(0)="1"
 Q
CHKIMG(IEN) ;
 ; Given an Image IEN, return:
 ;   1: Case # or accession #
 ;   2: Parent application~IEN
 ;   3: Application DFN
 ;   4: Image DFN
 ;   5: Flag: true = all DFNs in images in same parent group are identical
 ;   6: Image object Class
 ;
 ; PF: Parent Data file number
 ; PT(): Parent file data dictionary
 ; PD0: Parent (Global root) IEN (D0)
 ; PD1:  Lab Parent Global Root (D1)
 ; PD2:  Parent Data File Image Pointer
 ; T():  Error types
 ; IDFN: Image file entry DFN
 ; PDFN: Parent file DFN
 ; GRG:  virtual Parent File Image Multiple
 ; IOR: Image Object Referenced (by parent)
 N GF,GP,G0,GR,GRD,GRG,GR0,IDFN,IENV,P0,PD0,PD1,PD2,PF,PT,X,X0,X2,N0,N1,R,T,GPDFN,PACS,IOR,APR,I,PDFN
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S R="^^^^^"
 S T(1)="No Image ptr in AP"
 S T(2)="GP has no Images"
 S T(3)="Conflicting AP & Image DFNs"
 S T(4)="Invalid Image Ptr to AP"
 S T(5)="Conflicting GP and GO DFN"
 S T(6)="GP & GO AP Mismatch"
 S T(7)="GP Missing GO ptr"
 S T(8)="No AP Ptr"
 S T(9)="No AP Entry ptr"
 S T(10)="No AP Mult ptr"
 S T(11)="GO DFN mismatches"
 S T(12)="Null Image Ptr"
 S T(13)="Invalid Image Ptr"
 S T(14)="Invalid Image Ptr to AP"
 S T(15)="Image Entry is structurally abnormal"
 S T(16)="Missing Group Objects"
 S T(21)="DFN Mismatches in AP Image Mult"
 I IEN="" S $P(R,"^",5)=T(12)_"~1" Q R
 S X0=$G(^MAG(2005,IEN,0))
 I X0="" S $P(R,"^",5)=T(13)_"~1" Q R
 S IDFN=$P(X0,"^",7),$P(R,"^",4)=IDFN
 S PT(3.9)="^XMB(3.9,PD0,|Mail message||2|^XMB(3.9,PD0,2005,|MAIL"
 ; The following 5 Lab subsections must be in-synch with FILE+42^MAGGTLB1
 ; IA #1962
 S PT(63)="^LR(PD0,GF,PD1,|Autopsy (microscopic)|AY|1|^LR(PD0,GF,PD1,2005.1,|AUM"
 S PT(63.02)="^LR(PD0,GF,PD1,|Electron microscopy|EM|1|^LR(PD0,GF,PD1,2005,|EM"
 S PT(63.08)="^LR(PD0,GF,PD1,|Surgical pathology|SP|1|^LR(PD0,GF,PD1,2005,|SP"
 S PT(63.09)="^LR(PD0,GF,PD1,|Cytology|CY|1|^LR(PD0,GF,PD1,2005,|CY|"
 S PT(63.2)="^LR(PD0,GF,PD1,|Autopsy (gross)|AY|1|^LR(PD0,GF,PD1,2005,|AUG"
 S PT(70)="^RADPT(PDFN,|Radiology Patient||1|"
 S PT(74)="^RARPT(PD0,|Radiology||2|^RARPT(PD0,2005,|RAD"
 S PT(130)="^SRF(PD0,|Surgery||1|^SRF(PD0,2005,|SUR"
 S PT(691)="^MCAR(691,PD0,|Echocardiogram||2|^MCAR(691,PD0,2005,|ECHO"
 S PT(691.1)="^MCAR(691.1,PD0,|Cardiac catheterization||2|^MCAR(691.1,PD0,2005,|CATH"
 S PT(691.5)="^MCAR(691.5,PD0,|Electrocardiography||2|^MCAR(691.5,PD0,2005,|ECG"
 S PT(694)="^MCAR(694,PD0,|Hematology||2|^MCAR(694,PD0,2005,|HEM"
 S PT(699)="^MCAR(699,PD0,|Endoscopy||2|^MCAR(699,PD0,2005,|ENDO"
 S PT(699.5)="^MCAR(699.5,PD0,|Medicine||2|^MCAR(699.5,PD0,2005,|GEN"
 S PT(8925)="^TIU(8925,PD0,|TIU||2|^TIU(8925.91,""ADI"",PD0,|TIU"
 S IC=$$IC(IEN,.N0,.N2,.GPDFN),$P(R,U,6)=IC
 I IC="ER" S $P(R,U,5)=T(15)_"~1" Q R
 I IC["GP",'$O(^MAG(2005,IEN,1,0)) S $P(R,U,5)=T(2)_"~1" Q R
 D PF(IEN,IC,N0,.PF,.PD0,.PD1,.PD2,.PACS,.IOR,.APR)
 I "GP^GO"[IC D  Q:$P(R,U,5)'="" R
 . S I=0
 . F  S I=$O(^MAG(2005,IOR,1,I)) Q:I'?1N.N  D
 . . I '$D(^MAG(2005,$P($G(^MAG(2005,IOR,1,I,0)),U),0)) S $P(R,U,5)=T(16)_$S(IC="GO":"~2",1:"~1")
 . . Q
 I IC["GO" S $P(R,U,6)=$P(R,U,6)_"~"_IOR
 I PD2'?1N.N,(('PACS)&(PD0?1N.N)) S $P(R,U,5)=T(10)_$S(IC["GO":"~2",1:"~1") Q R
 I IC["GO" D  Q:$P(R,U,5)'="" R
 . N I,J
 . S (I,J)=0
 . F  S I=$O(^MAG(2005,IOR,1,I)) Q:I'?1N.N  S:IEN=$P($G(^MAG(2005,IOR,1,I,0)),U,1) J=1
 . S:J=0 $P(R,U,5)=T(7)_"~2"
 . Q
 I IC["GO",IDFN'=GPDFN S $P(R,U,5)=T(5)_"~1",$P(R,U,3)=GPDFN Q R
 I IC["GO" D  Q:$P(R,U,5)'="" R
 . N I,J
 . S I=0
 . F  S I=$O(^MAG(2005,IOR,1,I)) Q:I'?1N.N  D  Q:$P(R,U,5)'=""
 . . S J=$P($G(^MAG(2005,IOR,1,I,0)),U)
 . . I $P($G(^MAG(2005,J,0)),U,7)'=IDFN S $P(R,U,5)=T(11)_"~2",$P(R,U,3)=$P($G(^MAG(2005,J,0)),U,7)
 . . Q
 I IC["GO",PACS,(($P(N2,U,6,7)'="")&($P(N2,U,6,7)'="^")),$P(N2,U,6,7)'=$P($G(^MAG(2005,$P(N0,U,10),2)),U,6,7) D  Q R
 . S $P(R,U,5)=T(6)_"~1",$P(R,U,3)=$P(^MAG(2005,IOR,0),U,7) Q
 I (PF\1=63),PD1'?1N.N,PD1'?1N.N1"."1N.N Q R
 I PF?1N.E,$D(PT(+PF)),PD0?1N.N D
 . S $P(R,"^",2)=$P(PT(PF),"|",6)_"~"_PD0
 . S GR=$P(PT(PF),"|",1),GR0=GR_"0)"
 . S GF=$P(PT(PF),"|",3),GP=$P(PT(PF),"|",4)
 . S T=$P(PT(PF),"|",5),GRD=T_"G0,0)",GRG=T_"G0)"
 E  D  Q R
 . S:((IC["GP")&($P(R,U,5)="")) $P(R,U,5)="1"
 S P0=$G(@GR0)
 I P0="" S $P(R,"^",5)=T(4)_$S((('PACS)&(IC["GO")):"~2",1:"~1") Q R
 S PDFN=$S(PF\1=63:$P(^LR(PD0,0),U,3),$P(P0,"^",GP)'="":$P(P0,"^",GP),1:PDFN)
 I 'PDFN,$P($G(^VA(200,IDFN,0)),"^",1)=PDFN S PDFN=IDFN
 S $P(R,"^",3)=PDFN
 I PDFN'=IDFN S $P(R,U,5)=T(3)_$S((('PACS)&(IC["GO")):"~2",1:"~1") Q R
 I PF=74 D
 . S GR=$P(PT(70),"|",1),GR0=GR_"0)"
 . S GF=$P(PT(70),"|",3),GP=$P(PT(70),"|",4)
 . S P0=$G(@GR0),$P(R,"^",3)=$P(R,"^",3)_"~"_$P(P0,"^",GP)
 S T=1,G0=0,IENV=0
 F  S G0=$O(@GRG) Q:'G0  Q:$P(R,U,5)'=""  D  I 'T K PT Q
 . I PF=8925 D  Q
 . . I '$D(^MAG(2005,+G0,0)) S $P(R,U,5)=T(14)_$S((('PACS)&(IC["GO")):"~2",1:"~1")
 . . S:G0=IOR IENV=1
 . . I $P($G(^MAG(2005,+G0,0)),"^",7)'=IDFN S $P(R,U,5)=T(21)_"~2",$P(R,U,3)=$P($G(^MAG(2005,+G0,0)),"^",7)
 . . Q
 . I '$D(^MAG(2005,+$P($G(@GRD),"^",1),0)) S $P(R,U,5)=T(14)_$S((('PACS)&(IC["GO")):"~2",1:"~1")
 . I $P($G(^MAG(2005,+$P($G(@GRD),"^",1),0)),"^",7)'=IDFN D  Q
 . . S $P(R,U,5)=T(21)_"~2",$P(R,U,3)=$P($G(^MAG(2005,+$P($G(@GRD),"^",1),0)),"^",7) Q
 . I PF=63 S:+$P($G(^LR(PD0,GF,PD1,2005.1,G0,0)),U)=IOR IENV=1
 . I PF=63.2 S:+$P($G(^LR(PD0,GF,PD1,2005,G0,0)),U)=IOR IENV=1
 . S:+$P($G(@GRD),"^",1)=IOR IENV=1
 . Q
 Q:$P(R,U,5)'="" R
 I IC["GP" S $P(R,U,5)="1"
 I IENV=0 S $P(R,U,5)=T(1)_"~1"
 I PF=74 S $P(R,"^",1)=$P(P0,"^",1)
 K PT
 Q R
IC(IEN,N0,N2,GPDFN) ;
 S N0=$G(^MAG(2005,IEN,0))
 S N1=$G(^MAG(2005,IEN,1,0))
 S N2=$G(^MAG(2005,IEN,2))
 I ($P(N0,U,2)="")&($P(N0,U,10)="")&($P(N1,U,4)>0) Q "GP"
 I (($P(N0,U,2)'="")&($P(N0,U,10)?1N.N)&(N1="")) D  Q "GO"
 . S GPDFN=$P($G(^MAG(2005,$P(N0,U,10),0)),U,7) Q
 I ($P(N0,U,2)'="")&($P(N0,U,10)'?1N.N)&(N1="") Q "NG"
 Q "ER"
PF(IEN,IC,N0,PF,PD0,PD1,PD2,PACS,IOR,APR) ;
 N N2
 S PACS=$S($D(^MAG(2005,IEN,"PACS")):1,1:0)
 S IOR=$S(IC="GO":$P($G(N0),U,10),1:IEN)
 I ((IC="GP")!(IC="NG")!((PACS)&(IC="GO"))) S N2=$G(^MAG(2005,IEN,2))
 I ((IC="GO")&('PACS)) S N2=$G(^MAG(2005,IOR,2))
 S PF=$P(N2,"^",6),PD0=$P(N2,"^",7),PD1=$P(N2,"^",10),PD2=$P(N2,"^",8)
 I PACS S APR=$S(PD0?1N.N:1,1:0)
 E  S APR=$S(((PF'="")&(PD0?1N.N)):1,$P($G(^MAG(2005,IOR,100)),U)?1N.N:1,$P($G(^MAG(2005,IOR,0)),U,6)="18":1,1:0)
 Q
DBQ(QIEN,PLACE,ZNODE) ;
 N INDX
 F INDX="DELETE","ABSTRACT","JUKEBOX","JBTOHD","PREFET","IMPORT","EVAL" D
 . K ^MAGQUEUE(2006.03,"C",PLACE,INDX,QIEN)
 . K:$P(ZNODE,U,5)]"" ^MAGQUEUE(2006.03,"D",PLACE,INDX,$E($P(ZNODE,U,5),1,30),QIEN)
 . I INDX="JUKEBOX" D
 . . K:$P(ZNODE,U,7) ^MAGQUEUE(2006.03,"E",PLACE,$P(ZNODE,U,7),QIEN) Q
 . I "^JBTOHD^PREFET^"[("^"_INDX_"^") D
 . . K:((+$P(ZNODE,U,7))&($P(ZNODE,U,8)]"")) ^MAGQUEUE(2006.03,"F",PLACE,$P(ZNODE,U,7),$P(ZNODE,U,8),QIEN) Q
 K ^MAGQUEUE(2006.03,QIEN,0)
 Q
DQUE(QIEN,QONLY) ;
 N ZNODE,TYPE,MAGIEN,PLACE,QP,TMP,DA,IMPORTIEN
 S ZNODE=$G(^MAGQUEUE(2006.03,QIEN,0))
 S PLACE=$P(ZNODE,U,12)
 S TYPE=$P(ZNODE,U)
 I TYPE="" D DBQ^MAGQBUT2(QIEN,PLACE,ZNODE) Q
 I "^IMPORT^"[("^"_TYPE_"^") S IMPORTIEN=$S($P(ZNODE,U,11)?1N.N:$P(ZNODE,U,11),1:QIEN)
 S MAGIEN=$P(ZNODE,U,7)
 S QP=$O(^MAGQUEUE(2006.031,"C",PLACE,TYPE,""))
 L +^MAGQUEUE(2006.031,QP,0):1E9
 S TMP=$G(^MAGQUEUE(2006.031,QP,0))
 S $P(TMP,U,5)=$P(TMP,U,5)-1
 S ^MAGQUEUE(2006.031,QP,0)=TMP
 L -^MAGQUEUE(2006.031,QP,0)
 K ^MAGQUEUE(2006.03,"C",PLACE,$P(ZNODE,U),QIEN)
 K ^MAGQUEUE(2006.03,QIEN,0)
 I $P(ZNODE,U,5)]"" D
 . K ^MAGQUEUE(2006.03,"D",PLACE,TYPE,$E($P(ZNODE,U,5),1,30),QIEN)
 L +^MAGQUEUE(2006.03,0):1E9
 S $P(^MAGQUEUE(2006.03,0),"^",4)=$P(^MAGQUEUE(2006.03,0),"^",4)-1
 L -^MAGQUEUE(2006.03,0)
 I "^IMPORT^"[("^"_TYPE_"^"),'$D(QONLY) D  Q
 . I $D(^MAG(2006.041,"B",IMPORTIEN)) D
 . . N TRACKID,ASIEN,SIEN
 . . S ASIEN=$O(^MAG(2006.041,"B",IMPORTIEN)) Q:ASIEN=""
 . . S TRACKID=$P($G(^MAG(2006.041,ASIEN)),U,2) Q:TRACKID=""
 . . S ASIEN="A",ASIEN=$O(^MAG(2006.041,"C",TRACKID,ASIEN),-1)
 . . F  S SIEN=$O(^MAG(2006.041,"C",TRACKID,SIEN),-1) Q:'SIEN  D
 . . . S DIK="^MAG(2006.041,",DA=SIEN
 . . . D ^DIK K DIK,DA
 . . . Q
 . . Q
 . S DIK="^MAG(2006.034,",DA=IMPORTIEN D ^DIK
 . K DIK,DA
 . K:MAGIEN ^MAGQUEUE(2006.03,"E",PLACE,MAGIEN,IMPORTIEN)
 . Q 
 Q:("^JBTOHD^PREFET^JUKEBOX^")'[("^"_TYPE_"^")
 S MAGIEN=$P(ZNODE,U,7)
 Q:'MAGIEN
 I TYPE="JUKEBOX" D  Q
 . K ^MAGQUEUE(2006.03,"E",PLACE,MAGIEN,QIEN)
 I "^JBTOHD^PREFET^"[("^"_TYPE_"^") D  Q
 . Q:$P(ZNODE,U,8)']""
 . K ^MAGQUEUE(2006.03,"F",PLACE,MAGIEN,$P(ZNODE,U,8),QIEN)
 . Q
 Q
DQUE1(RESULT,QIEN) ;[MAGQB QUEDEL]
 N X,TYPE
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 S RESULT=0
 S TYPE=$P($G(^MAGQUEUE(2006.03,QIEN,0)),U)
 D QRNGE^MAGQBUT5(.RESULT,TYPE,"DEL",QIEN,QIEN)
 S RESULT=1
 Q
JBQUE(RESULT,QIEN) ; RPC[MAGQ JBQUE]
 S X="ERR^MAGQBTM",@^%ZOSF("TRAP")
 I '+QIEN S RESULT=0 Q
 S RESULT=$$JUKEBOX^MAGBAPI(QIEN,$$PLACE^MAGBAPI(+$G(DUZ(2))))
 Q
