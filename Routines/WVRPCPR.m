WVRPCPR ;HIOFO/FT-WV PROCEDURE file (790.1) RPCs (cont.) ;9/29/03  15:15
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #10103 - ^XLFDT calls           (supported)
 ;
 ; This routine supports the following IAs:
 ; LATEST - 4105
 ;
TYPEIEN(WVNAME) ; This function returns the IEN of an entry in the
 ; WV PROCEDURE TYPE file (#790.2)
 ;  Input: WVNAME is the procedure name (i.e., .01 value)
 ; Output: IEN of the procedure type. Returns -1 if not found.
 N WVIEN
 I WVNAME="" Q -1  ;can't be null
 S WVIEN=$O(^WV(790.2,"B",WVNAME,0))
 S:WVIEN'>0 WVIEN=-1
 Q WVIEN
 ;
TYPENAME(WVIEN) ; This function returns the NAME of an entry in the
 ; WV PROCEDURE TYPE file (#790.2)
 ;  Input: IEN (FILE 790.2)
 ; Output: Name of the procedure type. Returns -1 if not found.
 N WVNAME
 I WVIEN="" Q -1  ;can't be null
 S WVNAME=$P($G(^WV(790.2,+WVIEN,0)),U,1)
 Q WVNAME
 ;
BUIEN() ; This function returns the IEN for a BREAST ULTRASOUND procedure
 ; type from FILE 790.2
 Q $$TYPEIEN("BREAST ULTRASOUND")
 ;
PAPIEN() ; This function returns the IEN for a screening PAP SMEAR
 ; procedure type from FILE 790.2
 Q $$TYPEIEN("PAP SMEAR")
 ;
MAMIENS() ; This function returns the IENs for diagnostic MAMMOGRAM
 ; procedure types from FILE 790.2
 ; returns a string delimited by caret with the IENS (e.g., "25^26"
 N WVARRAY,WVCNT,WVDIAG,WVIEN,WVNAME
 S (WVDIAG,WVNAME)="",WVCNT=0
 S WVARRAY("MAMMOGRAM DX UNILAT")=""
 S WVARRAY("MAMMOGRAM DX BILAT")=""
 S WVARRAY("MAMMOGRAM SCREENING")=""
 F  S WVNAME=$O(WVARRAY(WVNAME)) Q:WVNAME=""  D
 .S WVIEN=$$TYPEIEN(WVNAME)
 .I WVIEN>0 S WVCNT=WVCNT+1,$P(WVDIAG,U,WVCNT)=WVIEN
 .Q
 Q WVDIAG
 ;
LATEST(RESULT,WVDFN,WVPTYPE,WVDATES,WVMAX,WVDX) ; Returns the Pap Smear or
 ; Mammogram entries in reverse chronological order.
 ; Input:   RESULT - Array name for return values [required]
 ;           WVDFN - patient DFN [required]
 ;         WVPTYPE - "P" for Pap Smear or "M" for Mammogram or
 ;                   "U" for Breast Ultrasound [required]
 ;         WVDATES - date range in FileMan internal format
 ;                   (e.g., 3020101^3021231) [optional]
 ;           WVMAX - max number of entries to return (e.g., 20)
 ;                   (optional - default is 10) [optional]
 ;            WVDX - "N", "A", "P" or "*" to return records with a
 ;                   dx/result of normal, abnormal, pending or any
 ;                   [optional]
 ;
 ; Output: RESULT(0)=# of matches^
 ;                   or=-1^error message
 ;         RESULT(n)=IEN^DFN^DATE^TYPE^DX CATEGORY^DX Result^Rad/Lab
 ;                   Link^FILE 790.1 STATUS
 ;   where IEN = FILE 790.1 internal entry number
 ;         DFN = FILE 2 internal entry number
 ;        DATE = Procedure date in FileMan format
 ;        TYPE = Procedure name (from FILE 790.2)
 ; DX Category = Normal, Abnormal or Pending
 ;   DX Result = FILE 790.31, Field .01
 ;RAD/LAB LINK = 0=no link to rad/lab entry, 1=link to rad/lab entry
 ;      Status = File 790.1 procedure status ('OPEN' or 'CLOSED')
 ;
 I '$G(WVDFN) D  Q
 .S RESULT(0)="-1^Patient DFN is not numeric or undefined."
 .Q 
 I $G(WVPTYPE)="" D  Q
 .S RESULT(0)="-1^Procedure type not identified."
 .Q
 I '$D(^WV(790.1,"C",WVDFN)) D  Q
 .S RESULT(0)="-1^No procedures found for this patient"
 .Q
 N WVCOUNT,WVEND,WVIEN,WVLOOP,WVMANUAL,WVNODE,WVNODE1,WVNORM,WVOUT,WVRD
 N WVRESULT,WVSTART,WVSTATUS,WVTYPE,WVYES
 S (WVCOUNT,WVLOOP,WVOUT)=0
 S:'$D(WVDATES) WVDATES="^"
 S WVSTART=$P(WVDATES,U,1) ;search start date
 S:WVSTART="" WVSTART=$$FMADD^XLFDT(DT,-1095)
 S WVEND=$P(WVDATES,U,2) ;search end date
 S:WVEND="" WVEND=DT
 S:+$G(WVMAX)'>0 WVMAX=10
 S:$G(WVDX)="" WVDX="*"
 S WVLOOP=WVEND+.000001
 F  S WVLOOP=$O(^WV(790.1,"AC",WVDFN,WVLOOP),-1) Q:'WVLOOP!(WVSTART>WVLOOP)!(WVOUT=1)  D
 .S WVIEN=0
 .F  S WVIEN=$O(^WV(790.1,"AC",WVDFN,WVLOOP,WVIEN)) Q:'WVIEN!(WVOUT=1)  D
 ..S WVNODE=$G(^WV(790.1,+WVIEN,0))
 ..Q:WVNODE=""
 ..I $P(WVNODE,U,5)=$$ERROR^WVRPCPR1() Q  ;error/disregard diagnosis 
 ..;check procedure types
 ..S WVYES=0
 ..I WVPTYPE="P",$E($P(WVNODE,U,1),1,2)="PS" S WVYES=1
 ..I WVPTYPE="M",$E($P(WVNODE,U,1),1,2)="MB" S WVYES=1
 ..I WVPTYPE="M",$E($P(WVNODE,U,1),1,2)="MU" S WVYES=1
 ..I WVPTYPE="M",$E($P(WVNODE,U,1),1,2)="MS" S WVYES=1
 ..I WVPTYPE="U",$E($P(WVNODE,U,1),1,2)="BU" S WVYES=1
 ..Q:'WVYES
 ..;check result/dx value
 ..S WVYES=0
 ..S WVNORM=$$NORMAL^WVRPCPR1($P(WVNODE,U,5)) ;is dx normal/abnormal?
 ..I WVDX="N",WVNORM=0 S WVYES=1
 ..I WVDX="A",WVNORM=1 S WVYES=1
 ..I WVDX="P",WVNORM=2 S WVYES=1
 ..I WVDX="P",$P(WVNODE,U,5)="" S WVYES=1 ;treat 'NO RESULT' & null alike
 ..I WVDX="*" S WVYES=1
 ..Q:'WVYES
 ..I WVCOUNT=WVMAX S WVOUT=1 Q  ;max # reached, stop looking
 ..S WVCOUNT=WVCOUNT+1
 ..S WVSTATUS=$P(WVNODE,U,14)
 ..S WVSTATUS=$S(WVSTATUS="o":"OPEN",WVSTATUS="c":"CLOSED",1:"OPEN")
 ..S WVTYPE=$$TYPENAME(+$P(WVNODE,U,4))
 ..S WVRESULT=$$DXNAME^WVRPCPR1($P(WVNODE,U,5))
 ..S WVNORM=$S(WVNORM=0:"Normal",WVNORM=1:"Abnormal",WVNORM=2:"Unsatisfactory",1:"Pending")
 ..S WVMANUAL=0 ;0=no link to rad/lab entry, 1=link to rad/lab entry
 ..I $P($G(^WV(790.1,WVIEN,2)),U,17)]""!($P(WVNODE,U,15)]"") S WVMANUAL=1
 ..;WVNODE1=IEN^DFN^DATE^TYPE^Dx Category^DX Result^Manual
 ..S WVNODE1=WVIEN_U_$P(WVNODE,U,2)_U_$P(WVNODE,U,12)_U_WVTYPE_U_WVNORM_U_WVRESULT_U_WVMANUAL_U_WVSTATUS
 ..S RESULT(WVCOUNT)=WVNODE1
 ..Q
 .Q
 I WVCOUNT=0 S RESULT(0)="-1^No records matched."
 I WVCOUNT>0 S RESULT(0)=WVCOUNT_U
 Q
SETRESLT(WVIEN,WVRESULT) ; Update the RESULTS/DIAGNOSIS field (.05)
 ; for the WV PROCEDURE file (#790.1) record identified by WVIEN. 
 ; Input:    WVIEN - FILE 790.1 IEN
 ;        WVRESULT - FILE 790.31 IEN
 ;
 ; Output: <none>
 ;
 N WVERR,WVDXFLAG,WVFAC,WVFDA
 I $G(WVIEN)'>0 Q
 D UPDATE^WVALERTS(WVIEN) ;mark procedure as processed by CR
 I $G(WVRESULT)'>0 Q
 ; Check 'update results/dx?' parameter
 S WVFAC=+$P($G(^WV(790.1,+WVIEN,0)),U,10)
 S WVDXFLAG=$P($G(^WV(790.02,+WVFAC,0)),U,11)
 Q:'WVDXFLAG
 S WVFDA(790.1,WVIEN_",",.05)=WVRESULT
 S WVFDA(790.1,WVIEN_",",.14)="c"
 D FILE^DIE("","WVFDA","WVERR")
 Q
