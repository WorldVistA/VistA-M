XUSNPIX3 ;OAK_BP/CMW - NPI EXTRACT REPORT ;01-OCT-06
 ;;8.0;KERNEL;**438,452,453,481,548**; Jul 10, 1995;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Direct access to ^IBE(350.9, fields .02, 1.05, 19;.02, 19;1.01, 19;1.02, 19;1.03, 19;,1.04, 19;1.05 authorized by
 ; Integration Agreement #4964.
 ;
 ; NPI Extract Report
 ;
 ; Input parameter: N/A
 ;
 ; Other relevant variables:
 ;   XUSRTN="XUSNPIX1NV" (current routine name, used for ^XTMP and ^TMP
 ;   XUSRTN="XUSNPIX2NV"  storage subscript)
 ; Storage Global:
 ;   ^XTMP("XUSNPIX1VA",0) = Piece 1^Piece 2^Piece 3^Piece 4^Piece 5^Piece 6
 ;   ^XTMP("XUSNPIX2VA",0)
 ;      where:
 ;      Piece 1 => Purge Date - 1 year in future
 ;      Piece 2 => Create Date - Today
 ;      Piece 3 => Description
 ;      Piece 4 => Last Date Compiled
 ;      Piece 5 => $H last run start time
 ;      Piece 6 => $H last run completion time
 ;      
 ;      Entry Point - ENT called from XUSNPIX1
 ;
 Q
 ;
ENT(XUSPROD,XUSVER) ; ENTRY POINT
 ; init variables
 N XUSRTN,XUSEOL,DTTM3,XUSP2P,INST,SITE
 N XUSNPI,XUSDATA,XUSTYP,XUST
 N NVIEN,IBA0,PROTYPE,NPIDT,NPINEW,XUSHDR,NVTYPE
 K ^TMP("XUSNPI",$J)
 ;
 ; Set end of line character
 S XUSEOL="~~"
 ;
 S DTTM3=$$HTE^XLFDT($H,"2")
 ;
 S XUST=""
 ; Loop through IB NON/OTHER VA BILLING PROVIDER records NPI xref
 S XUSNPI=0
 F  S XUSNPI=$O(^IBA(355.93,"NPI",XUSNPI)) Q:'XUSNPI  D
 . S NVIEN=$O(^IBA(355.93,"NPI",XUSNPI,""))
 . S IBA0=$G(^IBA(355.93,NVIEN,0))
 . ; Get Provider Type
 . S PROTYPE=$P(IBA0,U,2)
 . S XUSTYP=$S(PROTYPE=1:2,1:1)
 . ; setup NPI array
 . S ^TMP("XUSNPI",$J,XUSTYP,XUSNPI)=NVIEN
 ;
 I $D(^TMP("XUSNPI",$J)) D INITA     ; set up global variables and P2P data
 ;
 ; If Provider Type is Individual
 S XUSRTN="XUSNPIX1NV",NVHEADR=" NPI EXTRACT TYPE 1 (NON VA)",NVTYPE="TYPE 1 (NVA)"
 I $D(^TMP("XUSNPI",$J,1)) D  I XUST G EXIT
 . ; Check to see if report is in use
 . L +^XTMP(XUSRTN):5 I '$T S XUST=1 Q
 . D INITB(XUSRTN)
 . D HDR(XUSRTN)
 . D TYPE1^XUSNPIX4(DTTM3,SITE,XUSPROD,XUSHDR,XUSP2P)
 . ;
 . ; Log Run Completion Time
 . S $P(^XTMP(XUSRTN,0),U,6)=$H
 . L -^XTMP(XUSRTN)
 ;
 I '$D(^TMP("XUSNPI",$J,1)) D
 . D INITB(XUSRTN)
 . D HDR(XUSRTN)
 . S ^TMP(XUSRTN,$J,1)=XUSHDR_U_"Message Number: "_1_U_"Line Count: "_1_U_DTTM3_U_$G(XUSPROD)_XUSEOL
 . S ^XTMP("XUSNPIXT","1NV")=1_U_0_U_DTTM3
 . S ^TMP(XUSRTN,$J,2)="END OF FILE"_U_XUSEOL
 . D EMAIL(XUSRTN)
 . S ^TMP("XUSNPIXS",$J,3,1)="1 (Non-VA)^0"
 ;
 ; If Provider Type is Facility/Group
 S XUSRTN="XUSNPIX2NV",NVHEADR=" NPI EXTRACT TYPE 2 (NON VA)",NVTYPE="TYPE 2 (NVA)"
 I $D(^TMP("XUSNPI",$J,2)) D  I XUST G EXIT
 . ; Check to see if report is in use
 . L +^XTMP(XUSRTN):5 I '$T S XUST=1 Q
 . D INITB(XUSRTN)
 . D HDR(XUSRTN)
 . D TYPE2^XUSNPIX4(DTTM3,SITE,XUSPROD,XUSHDR,XUSP2P)
 . ;
 . ; Log Run Completion Time
 . S $P(^XTMP(XUSRTN,0),U,6)=$H
 . L -^XTMP(XUSRTN)
 . ;
 I '$D(^TMP("XUSNPI",$J,2)) D
 . D INITB(XUSRTN)
 . D HDR(XUSRTN)
 . S ^TMP(XUSRTN,$J,1)=XUSHDR_U_"Message Number: "_1_U_"Line Count: "_1_U_DTTM3_U_$G(XUSPROD)_XUSEOL
 . S ^XTMP("XUSNPIXT","2NV")=1_U_0_U_DTTM3
 . S ^TMP(XUSRTN,$J,2)="END OF FILE"_U_XUSEOL
 . D EMAIL(XUSRTN)
 . S ^TMP("XUSNPIXS",$J,4,1)="2 (Non-VA)^0"
 ;
EXIT ;Standard EXIT point
 K ^TMP("XUSNPI",$J)
 K XUSNV,P,LDTCMP,SITE,NVHEADR,XUSEOL,DTTM3
 ;
 Q
 ;=============================================
INITA ; set up global variables (site and inst info)
 N SINFO,XUSTMP,XUSP2PA,I
 K XUSTMP
 ;
 ; Pull site info
 S SINFO=$$SITE^VASITE
 ; Station Number        
 S SITE=$P(SINFO,U,3)
 ; Institution   
 S INST=$P(SINFO,U)
 ;
 ; Get Pay-to-Provider for all Non-VA records (type 1 & 2)
 ;
 F I=1:1:6 S $P(XUSP2P,U,I)=""   ; initialize
 D P2PBASE^XUSNPIXU(.XUSTMP)
 I $D(XUSTMP("P2P",INST)) S XUSP2P=$$P2PEXP^XUSNPIXU((XUSTMP("P2P",INST)),.XUSP2PA)
 Q
 ;
INITB(XUSRTN) ; check/init variables
 N XUSDESC
 ;
 ;Reset Temporary Scratch Global
 K ^TMP(XUSRTN)
 S XUSDESC="NPI EXTRACT NON VA - Do Not Delete"
 S ^XTMP(XUSRTN,0)=(DT+10000)_U_DT_U_XUSDESC_U_DT_U_$H
 ;
 I '$D(^TMP("XUSNPIXU",$J)) D BCBSID^XUSNPIXU
 Q
 ;
HDR(XUSRTN) ;Get header
 N DIC4,XUSCITY,XUSSTATE,XUSZIP
 S (DIC4,XUSCITY,XUSSTATE,XUSZIP)=""
 ;
 ; *** Start XU*8.0*548 - RBN ***
 ; Get header for extracted data NOT email
 I INST D
 . S DIC4=$G(^DIC(4,INST,4))
 . S XUSCITY=$P(DIC4,U,3)
 . S XUSSTATE=$P(DIC4,U,4)
 . I XUSSTATE S XUSSTATE=$P($G(^DIC(5,XUSSTATE,0)),U,2)
 . S XUSZIP=$P(DIC4,U,5)
 S XUSHDR="Station: "_SITE_U_XUSCITY_U_XUSSTATE_U_XUSZIP_U_NVTYPE_U_XUSVER
 Q
 ;
EMAIL(XUSRTN) ; EMAIL THE MESSAGE
 N XMY
 ; Send email to designated recipient for live release (send the extracted data via MailMan)
 D MAILTO^XUSNPIX1(.XMY) ;p548
 D ESEND
 Q
 ;
ESEND N XMTEXT,XMSUB,XMDUN,XMDUZ,XMZ,XMMG,DIFROM
 S XMTEXT="^TMP("""_XUSRTN_""","_$J_","
 S XMSUB=$TR($P($G(^TMP(XUSRTN,$J,1)),U),":")_"("_$G(XUSPROD)_") "_NVHEADR
 D ^XMD
 Q
