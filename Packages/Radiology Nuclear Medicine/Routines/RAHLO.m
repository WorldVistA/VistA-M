RAHLO ;HIRMFO/GJC-Process data set from the bridge program ; Dec 13, 2019@11:14:22
 ;;5.0;Radiology/Nuclear Medicine;**4,8,27,55,66,84,94,106,144,162**;Mar 16, 1998;Build 2
 ; 09/07/2005 Remedy call 108405 - KAM Allow Radiology to accept dx codes from Talk Technology
 ;
 ;Integration Agreements
 ;----------------------
 ;DT^DILF(2054); LOCK^DILF(2054); DEM^VADPT(10061); $$DT^XLFDT(10103)
 ;
EN1 ; Check the validity of the following data globals:
 ; Example: '^TMP("RARPT-REC",$J,RASUB,' where RASUB is a
 ; record in file 772.
 ;**************** Validates (if data present): ************************
 ; ^TMP("RARPT-REC",$J,RASUB,"RACNI")=Case IEN
 ; ^TMP("RARPT-REC",$J,RASUB,"RADATE")=Date reported/entered/verified
 ; ^TMP("RARPT-REC",$J,RASUB,"RADFN")=Patient IEN
 ; ^TMP("RARPT-REC",$J,RASUB,"RADTI")=Inverted Exam Date/Time
 ; ^TMP("RARPT-REC",$J,RASUB,"RADX",#)=Dx codes (could be more than 1)
 ; ^TMP("RARPT-REC",$J,RASUB,"RAESIG")=Verifier's E-Sig (if present)
 ; ^TMP("RARPT-REC",$J,RASUB,"RAHIST")=Additional Clinical History
 ; ^TMP("RARPT-REC",$J,RASUB,"RAIMP",#)=Impression Text
 ; ^TMP("RARPT-REC",$J,RASUB,"RALONGCN")=Long Case Number
 ; ^TMP("RARPT-REC",$J,RASUB,"RASSN")=Patient SSN
 ; ^TMP("RARPT-REC",$J,RASUB,"RASTAT")=A, C, F or R
 ;    Note: we use 'F' for final and 'P' for preliminary as RESULT
 ;          STATUS values for both the v2.3 & v2.4 HL7 interfaces.
 ;          BUT: we use 'C' ('corrected') for the v2.4 interface &
 ;                      'A' ('amended') for the v2.3 interface.
 ; 
 ;    Note: VAQ - added w/P106 study released back to VAMC
 ;                for interpretation
 ;
 ; ^TMP("RARPT-REC",$J,RASUB,"RATXT",#)=Report Text
 ; ^TMP("RARPT-REC",$J,RASUB,"VENDOR")=vendor
 ; ^TMP("RARPT-REC",$J,RASUB,"RAVERF")=Verifier ien
 ; ^TMP("RARPT-REC",$J,RASUB,"RATRANSCRIPT")=transcriptionist (optional)
 ; ^TMP("RARPT-REC",$J,RASUB,"RASTAFF")=Primary staff
 ; ^TMP("RARPT-REC",$J,RASUB,"RARESIDENT")=Primary resident
 ; ^TMP("RARPT-REC",$J,RASUB,"RAWHOCHANGE")=Who changed status to Verify
 ;**********************************************************************
 K RAERR S RAQUIET=1
 ; Check if the minimum data set exists.
 I '$D(^TMP("RARPT-REC",$J,RASUB,"RACNI")) S RAERR="Missing Case Number" Q
 I '$D(^TMP("RARPT-REC",$J,RASUB,"RADFN")) S RAERR="Internal Patient ID Missing" Q
 I '$D(^TMP("RARPT-REC",$J,RASUB,"RADTI")) S RAERR="Missing Exam Date" Q
 I '$D(^TMP("RARPT-REC",$J,RASUB,"RALONGCN")) S RAERR="Missing Exam Date and/or Case Number" Q
 I '$D(^TMP("RARPT-REC",$J,RASUB,"RASSN")) S RAERR="Missing Patient ID" Q
 D CHECK ; check the validity of our data.
XIT ; Kill and quit
 K A,B,DFN,K,RACNI,RADX,RADENDUM,RADFN,RADTI,RADUZ,RAIMGTY,RALONGCN,RAMDIV,RAMDV,RAMLC
 K RAQUIET,RARPT,RARPTSTS,RASSN,RAVLDT,X,Y,Z,RATRANSC,RAERRCHK,RAOR,RAPURGE,RARPTI,RASIUID
 K RASN,RASSNVAL,RAST32,RASTAT,RASTI,RAZDAYCS,RAZDTE,RAZORD,RAZORD1,RAZPROC,RAZRXAM,RAZXAM
 Q
CHECK ; Check if our data is valid.
 S RACNI=$G(^TMP("RARPT-REC",$J,RASUB,"RACNI"))
 S RADATE=$G(^TMP("RARPT-REC",$J,RASUB,"RADATE"))
 S RADFN=$G(^TMP("RARPT-REC",$J,RASUB,"RADFN"))
 S RADTI=$G(^TMP("RARPT-REC",$J,RASUB,"RADTI"))
 S RALONGCN=$G(^TMP("RARPT-REC",$J,RASUB,"RALONGCN"))
 S RASSN=$G(^TMP("RARPT-REC",$J,RASUB,"RASSN"))
 S (RAVERF,RADUZ)=$G(^TMP("RARPT-REC",$J,RASUB,"RAVERF"))
 S RATRANSC=$G(^TMP("RARPT-REC",$J,RASUB,"RATRANSCRIPT"))
 S RASTAT=$G(^TMP("RARPT-REC",$J,RASUB,"RASTAT")) I RASTAT="A"!(RASTAT="C") S RADENDUM=""
 I $D(^TMP("RARPT-REC",$J,RASUB,"RAESIG")) S RAESIG=$G(^("RAESIG"))
 I $D(^TMP("RARPT-REC",$J,RASUB,"RAIMP")) D IMPTXT^RAHLO2
 I RADATE']"" S RAERR="Missing report date" Q
 I RADFN']"" S RAERR="Missing Internal Patient ID" Q
 I RACNI']"" S RAERR="Missing Case Number" Q
 I RADTI']"" S RAERR="Missing Exam Date" Q
 D DT^DILF("ET",RADATE,.RAVLDT)
 S:RAVLDT=-1 RAERR="Invalid report date" Q:$D(RAERR)
 K VA,VADM,VAERR S DFN=RADFN D DEM^VADPT
 I VADM(1)']"" S RAERR="Unknown Internal patient identifier" K VA,VADM,VAERR Q
 I RASSN'=$P(VADM(2),"^") S RAERR="Internal patient identifier and SSN don't match" K VA,VADM,VAERR Q
 I '$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))!(RALONGCN']"") D  Q
 . S RAERR="Invalid Exam Date and/or Case Number"
 . Q
 D EDTCHK^RAHLQ ; is user allowed to edit report for a cancelled case?
 I RARPT=1 S RAERR="Report for CANCELLED case not permitted." Q
 I RARPT=2 S RAERR="Please use VISTA to edit CANCELLED printset cases." Q
 S RARPT=+$P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),"^",17)
 I '$D(^RARPT(RARPT,0)),($D(RADENDUM)#2) S RAERR="Can't add addendum, no report" Q
 I $D(^RARPT(RARPT,0)),($P(^(0),"^",5)'="V"),($D(RADENDUM)#2)  D  Q
 .S RAERR="Can't add addendum to a report that is not verified." Q  ;P94
 ;
 I $D(^RARPT(RARPT,0)),(($P(^(0),"^",5)="V")!($P(^(0),"^",5)="EF")),('$D(RADENDUM)#2) D  Q
 .S RAERR="Report already on file" Q  ;P94
 ;
 I ($D(RADENDUM)#2),'$O(^TMP("RARPT-REC",$J,RASUB,"RAIMP",0)),'$O(^TMP("RARPT-REC",$J,RASUB,"RATXT",0)) S RAERR="Missing addendum report/impression text" Q
 I $D(^RADPT(RADFN,"DT",RADTI,0)) S RAMDIV=^(0),RAMLC=+$P(RAMDIV,"^",4),RAMDIV=+$P(RAMDIV,"^",3),RAMDV=$S($D(^RA(79,RAMDIV,.1)):^(.1),1:""),RAMDV=$S(RAMDV="":RAMDV,1:$TR(RAMDV,"YyNn",1100))
 I '($D(RADENDUM)#2) I $P(RAMDV,"^",16),('$D(^TMP("RARPT-REC",$J,RASUB,"RAIMP"))) S RAERR="Missing Impression Text" Q  ; impression req'd for this division
 I ($D(RADENDUM)#2),($D(^RARPT(RARPT,0))#2),($P(RAMDV,"^",16)),('$O(^RARPT(RARPT,"I",0))),('$D(^TMP("RARPT-REC",$J,RASUB,"RAIMP"))) S RAERR="Impression Text missing for current record." Q  ; impression req'd for this division
 I $D(RADENDUM)#2 D CKDUPA^RAHLO4 I RADUPA S RAERR="Duplicate Addendum" Q
 ; check resident and staff
 N X1,X2,X3 S X2=0,X3=""
 I '$G(RATELE),+$G(^TMP("RARPT-REC",$J,RASUB,"RARESIDENT"))!(+$G(^("RASTAFF"))) D  Q:$G(RAERR)]""
 . S X1=+$G(^TMP("RARPT-REC",$J,RASUB,"RARESIDENT"))
 . I X1 D
 .. I '$D(^VA(200,"ARC","R",X1)),'$D(^VA(200,"ARC","S",X1)) S X2=1
 .. I $P($G(^VA(200,X1,"RA")),"^",3),$P(^("RA"),"^",3)'>$$DT^XLFDT S X2=X2+2
 .. I X2=1 S X3=$E($P($G(^VA(200,X1,0)),"^"),1,20)_" is not class'd as Resident or Staff"
 .. I X2=2 S X3=$P($G(^VA(200,X1,0)),"^")_"'s INACTIVE DATE is past"
 .. I X2=3 S X3=$P($G(^VA(200,X1,0)),"^")_" is not class'd as resident and past INACTIVE DATE"
 .. I X3]"" S RAERR=X3
 . S X2=0,X3="" S X1=+$G(^TMP("RARPT-REC",$J,RASUB,"RASTAFF"))
 . I X1 D
 .. I '$D(^VA(200,"ARC","S",X1)) S X2=1
 .. I $P($G(^VA(200,X1,"RA")),"^",3),$P(^("RA"),"^",3)'>$$DT^XLFDT S X2=X2+2
 .. I X2=1 S X3=$E($P($G(^VA(200,X1,0)),"^"),1,20)_" is not class'd as staff"
 .. I X2=2 S X3=$P($G(^VA(200,X1,0)),"^")_"'s INACTIVE DATE is past"
 .. I X2=3 S X3=$P($G(^VA(200,X1,0)),"^")_" is not class'd as staff and past INACTIVE DATE"
 .. I X3]"" S RAERR=$S($G(RAERR)]"":RAERR_", ",1:"")_X3
 . Q
 ; raesig is in alphanumeric format, so shouldn't use $g of it here
 I ($G(RAESIG)]"")!($G(RAVERF)) D:'$G(RATELE) VERCHK^RAHLO3 ; check if provider can verify report
 ; if verifier fails checks,
 ;   quit only if vendor is non-kurzweil,
 ;   if vendor is kurzweil, continue on by deleting raerr, raverf
 I $D(RAERR) Q:$G(^TMP("RARPT-REC",$J,RASUB,"VENDOR"))'="KURZWEIL"  K RAERR,RAVERF
 S RAIMGTY=$$IMGTY^RAUTL12("l",RAMLC) I '$L(RAIMGTY) S RAERR="No Imaging Type for Location where exam was performed" Q
 K RASECDX ;clear secondary dx array because RAHLO2 may not be called
 ; 09/07/2005 108405 KAM- Removed ('$D(RADENDUM)#2) from next line
 I $G(RATELE),'$D(RADENDUM),'$D(^TMP("RARPT-REC",$J,RASUB,"RADX")) D  ;Patch 84
 .I RASTAT="R" S:$D(RATELEDR) ^TMP("RARPT-REC",$J,RASUB,"RADX",1)=RATELEDR Q
 .S:$D(RATELEDF) ^TMP("RARPT-REC",$J,RASUB,"RADX",1)=RATELEDF
 D:$D(^TMP("RARPT-REC",$J,RASUB,"RADX")) DIAG^RAHLO2 Q:$D(RAERR)  ; DX code check took out - &('$D(RADENDUM)#2)
 ; edit sec Dx codes if they exist for non-addendums
 ; 09/07/2005 108405 KAM - Removed ('$D(RADENDUM)#2)from next line
 I $D(RASECDX) D SECDX^RAHLO2 Q:$D(RAERR)
 S B=0 F A="I","R" D  Q:$D(RAERR)
 . Q:A="R"&('$D(^TMP("RARPT-REC",$J,RASUB,"RATXT")))  ; no rpt text
 . Q:A="I"&('$D(^TMP("RARPT-REC",$J,RASUB,"RAIMP")))  ; no imp text
 . S B=$$TEXT^RAHLO3(A)
 . S:'B RAERR=$$ERR^RAHLO2(A)
 . Q
 ;
 I $G(RATELE),$L($G(RATELEPI)),RATELEPI'?10N S RAERR="Incorrect Teleradiologist's NPI: "_RATELEPI Q
 D RPTSTAT^RAHLO3 ; determine the status of the report
 Q:$D(RAERR)#2  ;P162 added error chk
 ;
 ;new w/P106
 I RARPT,($T(EN^RARPTUT)'=""),(RASTAT="VAQ") D EN^RARPTUT QUIT  ;p162 removed $D(RAERR)#2
 ;
 ;new w/P162
 I $G(RARPT)>0 D  Q:$D(RAERR)#2
 .L +^RARPT(RARPT):60
 .I '$T S RAERR="Lock of report record: "_RARPT_" failed."
 .Q
 L +^RADPT(RADFN,"DT",RADTI):60
 I '$T S RAERR="Lock of study accession: "_$S(RALONGCN'="":RALONGCN,1:"N/A")_" failed." Q
 D FILE^RAHLO1
 ;unlock the report & study unconditionally
 L -^RARPT(RARPT) L -^RADPT(RADFN,"DT",RADTI)
 Q
 ;
