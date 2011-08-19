MAGGTRP1 ;WOIFO/GEK - Display Associated Report ; [ 11/08/2001 17:18 ]
 ;;3.0;IMAGING;**8**;Sep 15, 2004
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
RAD(MAGRPTY,RARPT) ;RPC [MAGGRADREPORT] Call to retrun a Radiology report
 ; MAGRPTY is the return array
 ; RARPT is the Radiology Report IEN i.e. ^RARPT(RARPT
 N ERRRES,RPTRES
 S ERRRES=""
 D OPENDEV Q:POP
 D BUILD(RARPT)
 S RPTRES=$G(@MAGRPTY@(0))
 I 'RPTRES S ERRRES=RPTRES
 I +RPTRES=-2 S ERRRES=RPTRES
 D:IO'=IO(0) ^%ZISC
 I $L(ERRRES) K @MAGRPTY S @MAGRPTY@(0)=ERRRES
 ; Mod Patch5 block Questionable reports 
 ; stop incorrectly report success on a failed report attempt.  this line is 
 ; moved inside BUILD tag
 ;S @MAGRPTY@(0)="1^OK"
 Q
BUILD(RARPT) ;Call to generate the Radiology Report
 ; This call is called be various Imaging routines to get the Rad Report
 ; This call assumes the device is already open.
 ; New the variables that'll be defined in the call to RASET^RAUTL2
 N RACN,RACNI,RADATE,RADFN,RADTE,RADTI
 ; We'll use these
 ; RADTI = Inverse date/time for rad order
 ; RACNI = rad case number
 ; RADFN = Patient DFN
 N I,Y,X,MAGPRC,XINF
 IF $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTRP1"
 E  S X="ERRA^MAGGTPR1",@^%ZOSF("TRAP")
 I RARPT["PMRAD" S @MAGRPTY@(0)="-2^Patient Mismatch. Radiology Files" Q
 I '$G(RARPT) S @MAGRPTY@(0)="0^NO Radiology Report number." Q
 ; 
 I '$$FIND1^DIC(74,"","A",+RARPT) S @MAGRPTY@(0)="0^Radiology report entry "_RARPT_" is not on file.  Contact IRM." Q
 ;
 S Y=RARPT
 ; This call will define the needed variables RADTI,RACNI and RADFN
 D RASET^RAUTL2
 ;D RPT2DPT(RARPT,.XINF)
 ;S ^TMP("MAGQIRP1",$J,"XINF")=XINF
 ;I +XINF'=RADFN S @MAGRPTY@(0)="0^Patient Mismatch. Radiology Files"  Q
 S ^TMP("MAGQIRP1",$J)="RADFN "_RADFN_" RADTI "_RADTI_" RACNI "_RACNI
 S ^TMP("MAGQIRP1",$J,1)="RARPT "_RARPT_" ,0)="_$G(^RARPT(RARPT,0))
 D EN3^RAO7PC3(RADFN_"^"_RADTI_"^"_RACNI)
 I '$D(^TMP($J,"RAE3")) D  Q
 . S @MAGRPTY@(0)="0^Radiology report not on file.  Contact IRM." Q
 S MAGPRC=$O(^TMP($J,"RAE3",RADFN,RACNI,""))
 S I=0 F  S I=$O(^TMP($J,"RAE3",RADFN,RACNI,MAGPRC,I)) Q:'I  D
 . W !,$G(^TMP($J,"RAE3",RADFN,RACNI,MAGPRC,I))
 ; 2.5P5  This line was moved from above.  So this BUILD function
 ;        should now correctly return success or failure.
 S @MAGRPTY@(0)="1^OK"
 Q
OPENDEV ;
 S MAGRPTY=$NA(^TMP($J,"WSDAT"))
 K @MAGRPTY ; clean it up first.
 S IOP="IMAGING WORKSTATION",%ZIS=0 D ^%ZIS
 I POP S @MAGRPTY@(0)="0^Can't open device IMAGING WORKSTATION" Q
 U IO
 Q
ERRA ;
 S @MAGRPTY@(0)="0^ERROR "_$$EC^%ZOSV
 D @^%ZOSF("ERRTN")
 Q
GRPDESC(MAGIEN) ; PRINT LONG DESC OF IMAGE GROUP and ALL children in Group
 ;DEVICE HAS ALREADY BEEN OPENED
 N MAGCIEN,MAGJ,MAGDASH
 S $P(MAGDASH,"_",79)="_"
 K ^UTILITY($J,"W")
 D GETDESC(MAGIEN)
 S MAGCIEN=0
 F  S MAGCIEN=$O(^MAG(2005,MAGIEN,1,MAGCIEN)) Q:'MAGCIEN  D
 . S MAGJ=^MAG(2005,MAGIEN,1,MAGCIEN,0)
 . I '$D(^MAG(2005,+MAGJ,3)) Q
 . D GETDESC(MAGJ)
 W MAGDASH
 Q
GETDESC(MAGIEN) ;
 ;
 N X,MAGI,DIWR,DIWL,DIWF,MAGHD
 I $O(^MAG(2005,MAGIEN,1,0)) S MAGHD="Group"
 E  S MAGHD="Image"
 W MAGHD_" ID# "_MAGIEN,!
 I $O(^MAG(2005,MAGIEN,3,0)) D
 . S DIWR=80,DIWL=1,DIWF="N"
 . W MAGHD_" : "_$P(^MAG(2005,MAGIEN,2),U,4),!
 . W MAGHD_" Long Description:  ",!
 . S MAGI=0
 . F  S MAGI=$O(^MAG(2005,MAGIEN,3,MAGI)) Q:+MAGI<1  D
 . . S X=^MAG(2005,MAGIEN,3,MAGI,0) D ^DIWP
 . D ^DIWW
 . W !
 Q
RPT2DPT(RARPT,RET) ; For input RARPT, return string RET containing case
 ;                 subscript values for accessing ^RADPT
 ; Stole this code from john, don't tell him.
 ; * This subroutine may be called by other routines of the Radiology
 ;   Imaging Workstation programs
 ;
 N DFN,DTI,CNI S (DFN,DTI,CNI)=""
 I RARPT?1N.N,$D(^RARPT(RARPT)) S X=$G(^(RARPT,0)) I X]"" D
 . S X=$P(X,U)
 . S X=$O(^RADPT("ADC",X,0)) I X S DFN=X,DTI=$O(^(X,0)),CNI=$O(^(DTI,0))
 . S RET=DFN_U_DTI_U_CNI
 E  S RET=""
 Q
