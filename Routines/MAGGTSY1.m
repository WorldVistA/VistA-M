MAGGTSY1 ;WOIFO/GEK - Imaging Session Utilities ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;**7**;Jul 12, 2002
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
SESSION(MAGRY,DATA) ;RPC Call for MAGSYS utility.
 ; List of Sessions for a Workstation.
 ; DATA is '^' delimited string
 ; IEN Workstatin File ^  From Date ^ To Date
 ;
 N I,J,I1,CT,X,Y,Z,MAGX,MAGWIEN,MAGTIEN
 N DTFR,DTTO
 S ^TMP("MAGGTSY1","DATA")=DATA
 S MAGWIEN=$P(DATA,U,1)
 S MAGRY=$NA(^TMP($J,"MAGWSESS"))
 K ^TMP($J,"MAGWSESS")
 S CT=1
 S DTFR=$P(DATA,U,2),DTTO=$P(DATA,U,3)
 I DTFR>DTTO S X=DTFR,DTFR=DTTO,DTTO=X
 I DTTO=0 S DTTO=9999999
 S DTTO=DTTO_".9999"
 S ACI="L"_DTTO
 F  S ACI=$O(^MAG(2006.82,"ACWRK",MAGWIEN,ACI),-1) S I1=$E(ACI,2,99) Q:I1<DTFR  D
 . S I="" F  S I=$O(^MAG(2006.82,"ACWRK",MAGWIEN,ACI,I),-1) Q:'I  D
 . . ;S I=$O(^MAG(2006.82,"ACWRK",MAGWIEN,ACI,""))
 . . D INFO(I,.Y) S CT=CT+1,@MAGRY@(CT)=Y
 I CT=1 S @MAGRY@(0)="0^No Sessions in Date Range." Q
 S @MAGRY@(0)=(CT-1)_"^"_$P(^MAG(2006.81,MAGWIEN,0),U,1)_"  Workstation sessions "
 S @MAGRY@(1)="User^Service/Section^Last Logon^Logoff^Pat ct^Image ct^Cap ct^Actions^Error^TrkID"
 ;S @MAGRY@(1)="User^Workstation^Service/Section^Last Logon^Logoff^Pat ct^Image ct^Cap ct^Actions^Error"
 Q
INFO(I,Y) ;
 N N1,N0,MDUZ,Z
 S N0=^MAG(2006.82,I,0) ; Imaging Windows Session file
 ; THIS WON'T BE NEEDED,I '$P(M,U,8) D SERV(I)
 S Y=$P(N0,U,1) ; User Name
 ;S Y=Y_$P(^MAG(2006.81,$P(M,U,5),0),U,1) ; Workstation Name
 S X=""
 I $P(N0,U,8) D
 . D GETS^DIQ(49,$P(N0,U,8)_",",".01","E","Z","")
 . S X=Z(49,$P(N0,U,8)_",",".01","E")
 S Y=Y_U_X
 S Y=Y_U_$$OUTDT^MAGGTSY($P(N0,U,3)) ;Date of Last Logon, by a user.
 S Y=Y_U_$$OUTDT^MAGGTSY($P(N0,U,4)) ;Date/Time of Last Logoff.
 ;
 S N1=$G(^MAG(2006.82,I,1))
 ;
 S Y=Y_U_$P(N1,U,1) ; patients viewed this session
 S Y=Y_U_$P(N1,U,2) ; images viewed this session.
 S Y=Y_U_$P(N1,U,3) ; Images captured this session
 S Y=Y_U_$P($G(^MAG(2006.82,I,"ACT",0)),U,3) ; action count
 S Y=Y_U_$P($G(^MAG(2006.82,I,"ERR",0)),U,3) ; error count
 S Y=Y_U_$P(N0,U,9)
 S Y=Y_U_I ; session ien
 Q
DISPLAY(MAGRY,MAGSIEN) ; RPC Call for MAGSYS utility. 
 ; Returns a display of this sessions info.
 ;
 N CT,I,ECT,ACT
 S MAGRY=$NA(^TMP($J,"MAGSDISP"))
 K ^TMP($J,"MAGSDISP")
 S CT=0,I=0,ACT=0
 F  S I=$O(^MAG(2006.82,MAGSIEN,"ACT",I)) Q:'I  D
 . S CT=CT+1,ACT=ACT+1
 . S @MAGRY@(CT)=^MAG(2006.82,MAGSIEN,"ACT",I,0)
 S I=0,ECT=0
 I $D(^MAG(2006.82,MAGSIEN,"ERR")) D
 . S CT=CT+1
 . S @MAGRY@(CT)="[ERRORS]"
 . F  S I=$O(^MAG(2006.82,MAGSIEN,"ERR",I)) Q:'I  D
 . . S CT=CT+1,ECT=ECT+1
 . . S @MAGRY@(CT)=^MAG(2006.82,MAGSIEN,"ERR",I,0)
 S @MAGRY@(0)=(CT)_"^"_ACT_" Actions.  "_ECT_" Errors."
 Q
SERV(I) ;
 ; FILE THE SERVICE/SECTION INTO THE SESSION FILE
 N N,MAGGFDA,MDUZ
 S N=^MAG(2006.82,I,0)
 S MDUZ=$P(N,U,2)_","
 D GETS^DIQ(200,MDUZ,"29","I","Z","") ; service/section
 S MAGGFDA(2006.82,I_",",7)=Z(200,MDUZ,29,"I")
 D UPDATE^DIE("","MAGGFDA","","")
 Q
