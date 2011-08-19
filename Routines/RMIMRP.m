RMIMRP ;WPB/JLTP ; FUNCTIONAL INDEPENDENCE RPCs ; 1/12/04 5:03pm
 ;;1.0;FUNCTIONAL INDEPENDENCE;**3**;Apr 15, 2003
PRM(RMIMR) ; Return Site Parameter Information
 K RMIMR
 N CNT,CNTI,FAC,FNT,FNTI,I,INST,MG,NFNT,NFNT,NT,STANUM,X
 S RMIMR(1)="-1^Site Parameters Not Found"
 S X=$G(^RMIM(783.9,1,0)) Q:X=""  S INST=+X
 S INST=$P($G(^DIC(4,INST,0)),U),STANUM=$P($G(^(99)),U)
 S MG=$P($G(^XMB(3.8,+$P(X,U,3),0)),U)
 S FNTI=+$P(X,U,4),NFNTI=+$P(X,U,5),CNTI=+$P(X,U,6)
 S FNT=$P($G(^TIU(8925.1,FNTI,0)),U)
 S NFNT=$P($G(^TIU(8925.1,NFNTI,0)),U)
 S CNT=$P($G(^TIU(8925.1,CNTI,0)),U)
 S NT=U_FNTI_U_FNT_U_NFNTI_U_NFNT_U_CNTI_U_CNT_U
 S I=0,FAC=1 F  S I=$O(^RMIM(783.9,1,10,I)) Q:'I  S X=^(I,0) D
 .S FAC=FAC+1,RMIMR(FAC)=X
 S RMIMTIME=$S($G(^VA(200,DUZ,200)):$P(^(200),U,10),1:$G(DTIME))
 S RMIMR(1)=INST_U_STANUM_U_MG_NT_(FAC-1)_U_RMIMTIME
 Q
DME(RMIMR,P1) ; DME for a Patient
 K RMIMR
 N DATE,DFN,IFN,ITM,ITM0,ITMI,RMIMAD,RMIMDC,TCST
 I '$G(P1) S RMIMR(0)="-1^Missing Patient Identifier" Q
 S DFN=+P1,RMIMAD=+$P(P1,U,2),RMIMDC=+$P(P1,U,3),RMIMR(0)=0
 I 'RMIMAD!('RMIMDC) D  Q
 .S RMIMR(0)="-2^Missing Required Date Range"
 S IFN=0 F  S IFN=$O(^RMPR(664.1,"D",DFN,IFN)) Q:'IFN  D
 .S DATE=$P(^RMPR(664.1,IFN,0),U) Q:(DATE<RMIMAD)!(DATE>RMIMDC)
 .S ITMI=0 F  S ITMI=$O(^RMPR(664.1,IFN,2,ITMI)) Q:'ITMI  D
 ..S ITM0=$G(^RMPR(664.1,IFN,2,ITMI,0))
 ..S ITM=+ITM0,TCST=$P(ITM0,U,11)
 ..S ITM=+$G(^RMPR(661,ITM,0)),ITM=$P($G(^PRC(441,ITM,0)),U,2) I ITM]"" D
 ...S RMIMR(0)=RMIMR(0)+1
 ...S RMIMR(RMIMR(0))=ITM_U_TCST
 Q
DFN(RMIMR,SSN) ; Convert a Patient's SSN to Internal Entry Number
 K RMIMR N C,DFN,I,X S X=$G(SSN),SSN=""
 F I=1:1:$L(X) S C=$E(X,I) I "0123456789P"[C S SSN=SSN_C
 I SSN'?9N.1"P" S RMIMR(1)="-1^Invalid SSN" Q
 S DFN=$O(^DPT("SSN",SSN,0))
 I 'DFN S RMIMR(1)="-2^SSN Not Found" Q
 S RMIMR(1)=DFN
 Q
FRM(RMIMR,F) ; Set Form Title into Broker Partition
 K RMIMR
 S RMIMFORM=F_"  "_$P(^RMIM(783.9,1,0),U,7),RMIMR(1)="1^OK"
 Q
DTFMT(RMIMR,X) ; Validate and Format External Date/Time
 K RMIMR N %DT,Y
 S %DT="TS" D ^%DT
 I Y<0 S RMIMR(1)="-1^Invalid Date/Time" Q
 S RMIMR(1)=$$FMTE^XLFDT(Y,5)
 Q
XM(RMIMR,X,RMIMTX) ; Send a MailMan Message
 K RMIMR
 N I,RECIP,REPLY,TEXT,XMDUN,XMDUZ,XMER,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S XMSUB=$P(X,U),RECIP=$P(X,U,2)
 S:$G(^XMB(3.9,+$P(X,U,3),0))]"" REPLY=$P(X,U,3) S XMY(RECIP)=""
 I '$O(RMIMTX(0))!(XMSUB="")!(RECIP="") D  Q
 .S RMIMR(1)="-1^Missing Subject, Text, or Recipients for Mail Message"
 S I=0,X="" F  S X=$O(RMIMTX(X)) Q:X=""  S I=I+1,TEXT(I,0)=RMIMTX(X)
 S XMTEXT="TEXT(" I '$G(REPLY) D ^XMD S:$D(XMMG) XMER=XMMG
 I $G(REPLY) S X=$$ENT^XMA2R(REPLY,"",.TEXT) S XMZ=REPLY S:'X XMER=X
 I $G(XMER) S RMIMR(1)="-1^"_XMER Q
 S RMIMR(1)="1^"_XMZ
 Q
DUZ(RMIMR,X) ; Return NEW PERSON Information
 K RMIMR N KEY
 S X=+$G(X) S:'X X=DUZ S RMIMR(1)="-1^User Number Not Defined"
 Q:'X  S X=X_U_$P($G(^VA(200,+X,0)),U)
 S KEY=$S($D(^XUSEC("RMIM COORD",+X)):2,$D(^XUSEC("RMIM FSOD",+X)):1,1:0)
 S X=X_U_KEY,RMIMR(1)=X
 Q
SAV(RMIMR,RMIML) ; Save Information about a Case
 N NXT,OP,X,Y
 S NXT=$O(RMIML("")) I NXT="" S (RMIMR,RMIMR(1))=$$ERR^RMIMU(-4) Q
 S OP=$P(RMIML(NXT),U),X=$P(RMIML(NXT),U,2,200)
 S Y=$S(OP="A":$$A^RMIMU(X),OP="E":$$E^RMIMU(X),OP="D":$$D^RMIMU(X),1:0)
 S:Y=0 Y=$$ERR^RMIMU(-5)
 I OP'="D",Y>0 S Y=$$OF^RMIMU1(+Y,.RMIML)
 S (RMIMR,RMIMR(1))=Y
 Q
LC(RMIMR,X) ; Returns a List of Cases from File #783
 N DATE,DFN,FAC,I,IFN,Y
 S IDX=1,DFN=+X,FAC=$P(X,U,2)
 S IFN=0 F  S IFN=$O(^RMIM(783,"DFN",DFN,IFN)) Q:'IFN  D
 .S X=$G(^RMIM(783,IFN,0)) Q:$P(X,U,6)'=FAC  Q:$P(X,U,14)="D"
 .S IDX=IDX+1,Y(IDX)=$P(X,U,2)_U_DFN_U_FAC
 .F I=10,11 D
 ..S DATE=$P(X,U,I) S:DATE]"" DATE=$$FMTE^XLFDT(DATE,5)
 ..S Y(IDX)=Y(IDX)_U_DATE
 S Y(1)=IDX-1 M RMIMR=Y
 Q
GC(RMIMR,X) ; Returns Information about a Specific Case
 K RMIMR N CASE,I,IFN
 S CASE=+$G(X) I 'CASE S RMIMR(1)=$$ERR^RMIMU(-1) Q
 S (I,IFN)=0 F  S I=$O(^RMIM(783,"CASE",CASE,I)) Q:'I  D
 .I $G(^RMIM(783,I,0))]"",$P(^(0),U,14)'="D" S IFN=I
 I 'IFN S RMIMR(1)=$$ERR^RMIMU(-6) Q
 S RMIMR(1)=IFN_U_CASE D GC^RMIMU(.RMIMR),GF^RMIMU1(.RMIMR)
 Q
PL(RMIMR,X) ; Patient Lookup
 K RMIMR N I,SEN,SL,Y
 D FIND^DIC(2,"","@;.01;.03I;.09","CMP",X,"","","","","Y")
 S I=0 F  S I=$O(Y("DILIST",I)) Q:'I  S LI=Y("DILIST",I,0) D
 .S $P(LI,U,6,7)=$P(LI,U,3,4)
 .D PTSEC^DGSEC4(.SEN,+LI)
 .I SEN(1) S $P(LI,U,3,5)="*SENSITIVE*^*SENSITIVE*^"_+SEN(1)
 .S RMIMR(I)=LI
 Q
RRN(RMIMR,X) ; Send Restricted Record Access Notification
 K RMIMR N Y
 D NOTICE^DGSEC4(.Y,+X,"RMIM FIM^FIM GUI")
 S RMIMR(1)=Y
 Q
AL(RMIMR,X) ; Author Lookup
 K RMIMR N I,Y
 D FIND^DIC(200,"","@;.01","CMP",X,"","","","","Y")
 S I=0 F  S I=$O(Y("DILIST",I)) Q:'I  S RMIMR(I)=Y("DILIST",I,0)
 Q
LL(RMIMR,X) ; Location Lookup
 K RMIMR N I,Y
 D FIND^DIC(44,"","@;.01","CMP",X,"","","","","Y")
 S I=0 F  S I=$O(Y("DILIST",I)) Q:'I  S RMIMR(I)=Y("DILIST",I,0)
 Q
PI(RMIMR,DFN) ; Patient Information
 K RMIMR S RMIMR(1)=$$ERR^RMIMU(-8)
 N I,VA,VADM,VAEL,VAERR,VAPA,X,Y
 D DEM^VADPT Q:VAERR
 D ADD^VADPT Q:VAERR
 D ELIG^VADPT Q:VAERR
 M X=VADM F I=8,10 S X(I)=$P(X(I),U,2)
 I X(8)="" S:$D(VADM(12,1)) X(8)=$P(VADM(12,1),U,2)  ;New Race Information Multiple
 S Y=DFN F I=1,2,8,4,5,10 S Y=Y_U_$P(X(I),U)
 S Y=Y_U_$S($P(VAEL(6),U,2)="ACTIVE DUTY":"A",1:"N")
 K X M X=VAPA F I=5,7 S X(I)=$P(X(I),U,2)
 F I=1,4,5,6,7,8 S Y=Y_U_$P(X(I),U)
 S RMIMR(1)=Y
 Q
PTL(RMIMR,X) ; Lock/Unlock Patient
 S X=$G(X),DFN=+X,L=+$P(X,U,2) I 'DFN S RMIMR(1)="-1^Invalid Patient" Q
 I 'L L -^RMIM("PATIENT",DFN) S RMIMR(1)=1 Q
 S RMIMR(1)=1 L +^RMIM("PATIENT",DFN):2 E  S RMIMR(1)=-1
 Q
