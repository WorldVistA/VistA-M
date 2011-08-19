MAGGTSY ;WOIFO/GEK - Imaging  Utilities ; [ 06/20/2001 08:57 ]
 ;;3.0;IMAGING;;Mar 01, 2002
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
WRKS(MAGRY,ZY) ;RPC Call for MAGSYS utility. List of Workstation Information.
 S ^TMP("MAGGTSY","ZY")=ZY
 ;
 N DTFR,DTTO,PACI,ACI,CT,X,Y,Z,MAGX,MAGIEN,MAGTIEN
 ; $P(ZY,U,1) is the Computer Name running MAGSYS.  we need to know this
 ; in case the same computer is also logged onto Imaging.
 ;
 I $L($P(ZY,"^",1)) S MAGTIEN=$O(^MAG(2006.81,"B",$P(ZY,"^",1),""))
 S DTFR=+$P(ZY,U,2),DTTO=+$P(ZY,U,3)
 I DTFR>DTTO S X=DTFR,DTFR=DTTO,DTTO=X
 I DTTO=0 S DTTO=9999999
 S DTTO=DTTO_".9999"
 D CHECKCON
 S MAGRY=$NA(^TMP($J,"MAGWRKS"))
 K ^TMP($J,"MAGWRKS")
 K ^TMP($J,"MAGWSES")
 S I=0,CT=1
 S ACI="L"_DTTO
 I ($P(ZY,U,4)="last")!($P(ZY,U,4)="") D
 . F  S ACI=$O(^MAG(2006.81,"AC",ACI),-1) S PACI=$E(ACI,2,99) Q:PACI<DTFR  D
 . . S I="" F  S I=$O(^MAG(2006.81,"AC",ACI,I)) Q:'I  D INFO(I,.Y) S CT=CT+1,@MAGRY@(CT)=Y
 I $P(ZY,U,4)="any" D
 . F  S ACI=$O(^MAG(2006.82,"AC",ACI),-1) S PACI=$E(ACI,2,99) Q:PACI<DTFR  D
 . . S I=$O(^MAG(2006.82,"AC",ACI,"")) S J=$P(^MAG(2006.82,I,0),U,5)
 . . I $D(^MAG(2006.81,J)) S ^TMP($J,"MAGWSES",J)=""
 ;
 I $D(^TMP($J,"MAGWSES")) D
 . S I="" F  S I=$O(^TMP($J,"MAGWSES",I)) Q:'I  D INFO(I,.Y) S CT=CT+1,@MAGRY@(CT)=Y
 I CT=1 S @MAGRY@(0)="0^No workstation logons for reqested dates." Q
 S @MAGRY@(0)=(CT-1)_"^Workstations logged on during requested data range."
 S @MAGRY@(1)="Computer Name^Last Logon^Last User^Active^Service/Section^IMGVWP10.EXE^Logoff^Display Ver^Capture Ver^MAGSETUP.EXE^TELE19N.EXE^Err^Sess #"
 ;
 Q
INFO(I,Y) ;Returns info for a Workstation in the IMAGING WINDOWS
 ;        WORKSTATION file ^MAG(2006.81
 ;  Y is passed by reference, we create an '^' delimited string 
 ;  of workstation info.
 ;
 N M,Z,MDUZ
 S M=^MAG(2006.81,I,0)
 S Y=$P(M,U,1) ; Computer Name
 S MDUZ=$P(M,U,2)_","
 S Y=Y_U_$$OUTDT($P(M,U,3)) ;Date of Last Logon, by a user.
 ;
 D GETS^DIQ(200,MDUZ,".01;29","IE","Z","")
 ;
 S Y=Y_U_Z(200,MDUZ,".01","E")                 ;Last User
 S Y=Y_U_$S($P(M,U,8):"Active",1:"-")          ;Active or Not
 S Y=Y_U_Z(200,MDUZ,"29","E")                  ;Service/Section
 ;S Y=Y_U_$P(^VA(200,$P(M,U,2),0),U,1) ; Last User Name
 S Y=Y_U_$$OUTDT($P(M,U,6)) ;Date of Display exe last used.
 S Y=Y_U_$$OUTDT($P(M,U,4)) ;Date/Time of Last Logoff.
 S Y=Y_U_$P(M,U,9) ; Display Version IMGVWP10.EXE
 S Y=Y_U_$P(M,U,13) ; Capture Version info TELE19N.EXE
 S Y=Y_U_$$OUTDT($P(M,U,7)) ;Date of MAGSETUP.EXE last run on this wrks.
 S Y=Y_U_$$OUTDT($P(M,U,5)) ;Date of Capture exe last used.
 ;S Y=Y_U_$P(M,U,11) ; current session error count.
 ; COUNT ERRORS FROM IMAGING WINDOWS SESSION FILE MULTIPLE
 S X=$O(^MAG(2006.82,"C",I,""),-1)
 S Y=Y_U_$P($G(^MAG(2006.82,X,"ERR",0)),U,3)
 S Y=Y_U_$E("     ",1,(6-$L($P(M,U,12))))_$P(M,U,12) ;Sess Ct for Wrks
 S Y=Y_U_I ; WRKS IEN  ^MAG(2006,81,I"
 Q
OUTDT(Z) ;
 I 'Z Q Z
 S X=$$FMTE^XLFDT(Z,4)
 S MAGTM=$P(X,"@",2)
 ;
 ;Q $E(Z,1,3)+1700_" "_$E(Z,4,5)_"/"_$E(Z,6,7)
 Q $E(Z,2,3)_"/"_$E(Z,4,5)_"/"_$E(Z,6,7)_" "_MAGTM
 ; Let's use Kernel date/time functions
 ;;;Q $$FMTE^XLFDT(Z,"2P")
 Q
CHECKCON ;
 S I=0
 F  S I=$O(^MAG(2006.81,I)) Q:'I  D
 . I $G(MAGTIEN)=I Q
 . L +^MAG(2006.81,"LOCK",I):0 I $T D
 . . L -^MAG(2006.81,"LOCK",I) S $P(^MAG(2006.81,I,0),U,8)=0
 Q
CLEAR ; UTIL TO CLEAR THE WORKSTATION FILE OUT, 
 W !,"This will clear all workstations not currently connected from the Imaging Windows Workstation file ",!,"  OK To proced  ?  Y/N  Y//"
 R X:$G(DTIME,300) I '("Yy"[X) W !!,"CANCELED  !.  BYE" Q
 S I=0,CT=1
 F  S I=$O(^MAG(2006.81,I)) Q:'I  D
 . W !,I
 . I $P(^MAG(2006.81,I,0),U,8)=1 W "   In use." Q
 . W "     Deleting..."
 . S DIK="^MAG(2006.81,",DA=I D ^DIK
 Q
