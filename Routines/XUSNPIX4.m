XUSNPIX4 ;OAK_BP/CMW/SLT - NPI EXTRACT REPORT ;7/7/08  17:39
 ;;8.0;KERNEL;**438,452,453,481,528,548**; Jul 10, 1995;Build 24
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
 ; Individual records
TYPE1(DTTM3,SITE,XUSPROD,XUSHDR,XUSP2P) ;
 N IBA0,NVIEN,XUSNPI,MAXSIZE,XUSEOL,XUSCNT
 N XUSI,XUSNM,XUSNV,XLFNC,XUSIZE,XUSDT,XUSNEW
 N TOTREC1
 ;
 ; Set Maximum Message Size
 S MAXSIZE=300000
 ;
 ; Set end of line character
 S XUSEOL="~~"
 ;
 S XUSCNT=1,(TOTREC1,MSGCNT,XUSIZE)=0
 S XUSNPI=""
 F  S XUSNPI=$O(^TMP("XUSNPI",$J,1,XUSNPI)) Q:'XUSNPI  D
 . S XUSDATA=XUSNPI
 . S NVIEN=$G(^TMP("XUSNPI",$J,1,XUSNPI))
 . ;
 . F XUSI=1:1:33 S XUSNV(XUSI)=""
 . S IBA0=$G(^IBA(355.93,NVIEN,0))
 . S XUSNM=$P(IBA0,U)
 . ; Break Name into components
 . I XUSNM'="" D
 . . S XLFNC=XUSNM D FORMAT^XLFNAME7(.XLFNC,,,,0)
 . . S XUSNV(2)=XLFNC("GIVEN"),XUSNV(3)=XLFNC("MIDDLE"),XUSNV(4)=XLFNC("FAMILY")
 . . I XLFNC("SUFFIX")'="" S XUSNV(4)=XUSNV(4)_" "_XLFNC("SUFFIX")
 . . K XLFNC
 . S XUSDATA=XUSDATA_U_XUSNV(2)_U_XUSNV(3)_U_XUSNV(4)
 . S XUSNV(5)=1 ;TYPE
 . ;                                    
 . ; DOB (place holder)
 . S XUSNV(6)=""
 . S XUSDATA=XUSDATA_U_XUSNV(5)_U_XUSNV(6)
 . ;
 . ; Pay to Provider Address (7-12)
 . S XUSDATA=XUSDATA_U_XUSP2P
 . ;
 . ; Servicing Provider Address
 . S XUSNV(13)=$P(IBA0,U,5)
 . S XUSNV(14)=$P(IBA0,U,10)
 . S XUSNV(15)=$P(IBA0,U,6)
 . S XUSNV(16)=$P(IBA0,U,7)
 . I XUSNV(16) S XUSNV(16)=$P($G(^DIC(5,XUSNV(16),0)),U,2)
 . S XUSNV(17)=$P(IBA0,U,8)
 . S XUSDATA=XUSDATA_U_XUSNV(13)_U_XUSNV(14)_U_XUSNV(15)_U_XUSNV(16)_U_XUSNV(17)
 . ;
 . ; Office Phone number (place holder)
 . S XUSNV(18)=""
 . ;
 . ; Degree Description / Degree Code (place holder)
 . S XUSNV(19)=""
 . S XUSNV(20)=""
 . ;
 . ; Get Taxonomy and specialty codes
 . N NVTX,NVSPC,NVTAX
 . S NVTX=0
 . F  S NVTX=$O(^IBA(355.93,NVIEN,"TAXONOMY","B",NVTX)) Q:'NVTX  D
 . . S NVSPC=$P($G(^USC(8932.1,NVTX,0)),U,9)
 . . ;S NVTAX=$P($G(^USC(8932.1,NVTX,0)),U,7)
 . . I NVSPC'="" D
 . . . I XUSNV(21)="" S XUSNV(21)=NVSPC Q
 . . . S XUSNV(21)=XUSNV(21)_";"_NVSPC
 . . . Q
 . . Q
 . ;use "B" cross ref to find primary vs non-primary code 0 (no)!1 (yes), and only "A"'s
 . S NVTX=0
 . F  S NVTX=$O(^IBA(355.93,NVIEN,"TAXONOMY",NVTX)) Q:NVTX'?1N.N  D
 . . S IBA=$G(^IBA(355.93,NVIEN,"TAXONOMY",NVTX,0))
 . . I $P(IBA,U,3)="A" D
 . . . I $P(IBA,U,2)=1 S XUSNV(22)=$P($G(^USC(8932.1,$P(IBA,U,1),0)),U,7)
 . . . I $P(IBA,U,2)=0 D
 . . . . I XUSNV(23)="" S XUSNV(23)=$P($G(^USC(8932.1,$P(IBA,U,1),0)),U,7) Q
 . . . . ;
 . . . . ; *** Start XU*8.0*548 - RBN ***
 . . . . ;
 . . . . I (XUSNV(23)'[$P($G(^USC(8932.1,$P(IBA,U,1),0)),U,7))&($P($G(^USC(8932.1,$P(IBA,U,1),0)),U,7)'=XUSNV(22)) D
 . . . . . S XUSNV(23)=XUSNV(23)_";"_$P($G(^USC(8932.1,$P(IBA,U,1),0)),U,7)
 . . . . . ;
 . . . . . ; *** End XU*8.0*548 - RBN ***
 . . . . . ;
 . . . . Q
 . . . Q
 . . Q
 . K IBA
 . ;
 . ; Fed tax ID
 . S XUSNV(24)=$P($G(IBA0),U,9)
 . ;
 . S XUSDATA=XUSDATA_U_XUSNV(18)_U_XUSNV(19)_U_XUSNV(20)_U_XUSNV(21)_U_XUSNV(22)
 . S XUSDATA=XUSDATA_U_XUSNV(23)_U_XUSNV(24)
 . ;
 . ; Medicare Part A/B
 . S XUSNV(25)=670899
 . S XUSNV(26)="VA"_$E(SITE+10000,2,5)
 . ;
 . ; State Lic and DEA (place holder)
 . S XUSNV(27)=""
 . S XUSNV(28)=""
 . ;
 . ; Status and Creation/Termination Date (place holder)
 . S XUSNV(29)=""
 . S XUSNV(30)=""
 . ; VISN Station
 . S XUSNV(31)=SITE
 . ;
 . S XUSDATA=XUSDATA_U_XUSNV(25)_U_XUSNV(26)_U_XUSNV(27)
 . S XUSDATA=XUSDATA_U_XUSNV(28)_U_XUSNV(29)_U_XUSNV(30)_U_XUSNV(31)
 . ;
 . ;BCBS info
 . K XUSBXID
 . D NNVAID^XUSNPIXU(NVIEN,.XUSBXID)
 . ;
 . ;Update counter and save Entry
 . N XUSB,XUSB1
 . S XUSCNT=XUSCNT+1,TOTREC1=TOTREC1+1
 . S ^TMP(XUSRTN,$J,XUSCNT)=XUSDATA_U_XUSEOL
 . S XUSIZE=XUSIZE+$L(^TMP(XUSRTN,$J,XUSCNT))
 . I $D(XUSBXID) D
 . . S XUSB=""
 . . F  S XUSB=$O(XUSBXID(XUSB)) Q:XUSB=""  D
 . . . S XUSB1=$G(XUSBXID(XUSB)) I XUSB1'="" S XUSB1="^"_XUSB1 ;add p 528
 . . . S XUSCNT=XUSCNT+1,TOTREC1=TOTREC1+1
 . . . S ^TMP(XUSRTN,$J,XUSCNT)=XUSDATA_U_$$TRIM^XLFSTR(XUSB)_XUSB1_U_XUSEOL ;add _XUSB1 p 528
 . . . S XUSIZE=XUSIZE+$L(^TMP(XUSRTN,$J,XUSCNT))
 . I XUSIZE>MAXSIZE D
 . . D EOF1(XUSRTN)
 . . D EMAIL^XUSNPIX3(XUSRTN) ;sending the extracted data via MailMan
 . . K ^TMP(XUSRTN,$J)
 . . S ^TMP("XUSNPIXS",$J,3,MSGCNT)="1 (Non-VA)^"_(XUSCNT-2)
 . . S ^TMP(XUSRTN,$J,1)=XUSHDR
 . . S XUSCNT=1,XUSIZE=0
 . K XUSNV,XUSDATA,XUSBXID
 ;
 D EOF1(XUSRTN)
 ;
 ; Send last message (if it has records)
 I $G(XUSCNT)>1 D
 . D EMAIL^XUSNPIX3(XUSRTN) ;sending the extracted data via MailMan
 . K ^TMP(XUSRTN,$J)
 . S ^TMP("XUSNPIXS",$J,3,MSGCNT)="1 (Non-VA)^"_($G(XUSCNT)-2)
 ;
 ; Update Summary
 S ^XTMP("XUSNPIXT","1NV")=MSGCNT_U_TOTREC1_U_DTTM3
 Q
 ;
EOF1(XUSRTN) ;
 Q:$G(XUSCNT)=1
 S MSGCNT=MSGCNT+1
 S ^TMP(XUSRTN,$J,1)=XUSHDR_U_"Message Number: "_MSGCNT_U_"Line Count: "_XUSCNT_U_DTTM3_U_$G(XUSPROD)_U_XUSEOL
 S XUSCNT=XUSCNT+1
 S ^TMP(XUSRTN,$J,XUSCNT)="END OF FILE"_U_XUSEOL
 Q
 ;
TYPE2(DTTM3,SITE,XUSPROD,XUSHDR,XUSP2P) ;Facility/Group
 N IBA0,NVIEN,XUSNPI,MAXSIZE,XUSEOL,XUSCNT
 N XUSNV,XUSI,XUSNM,XLFNC,MSGCNT,XUSIZE,XUSDT,XUSNEW,TOTREC2
 ;
 ; Set Maximum Message Size
 S MAXSIZE=300000
 ;
 ; Set end of line character
 S XUSEOL="~~"
 ;
 S XUSNPI=""
 S XUSCNT=1,(TOTREC2,MSGCNT,XUSIZE)=0
 F  S XUSNPI=$O(^TMP("XUSNPI",$J,2,XUSNPI)) Q:'XUSNPI  D
 . S XUSDATA=XUSNPI
 . S NVIEN=$G(^TMP("XUSNPI",$J,2,XUSNPI))
 . ;
 . F XUSI=1:1:24 S XUSNV(XUSI)=""
 . S IBA0=$G(^IBA(355.93,NVIEN,0))
 . ;Get Organization name  
 . S XUSNV(2)=$P(IBA0,U)
 . ;Type
 . S XUSNV(3)=2
 . ;
 . S XUSDATA=XUSDATA_U_XUSNV(2)_U_XUSNV(3)
 . ;
 . ; Pay to Provider Address (4-9)
 . S XUSDATA=XUSDATA_U_XUSP2P
 . ;
 . ; Servicing Provider Address
 . S XUSNV(10)=$P(IBA0,U,5)
 . S XUSNV(11)=$P(IBA0,U,10)
 . S XUSNV(12)=$P(IBA0,U,6)
 . S XUSNV(13)=$P(IBA0,U,7)
 . I XUSNV(13) S XUSNV(13)=$P($G(^DIC(5,XUSNV(13),0)),U,2) ;SLT 9/23/10
 . S XUSNV(14)=$P(IBA0,U,8)
 . S XUSDATA=XUSDATA_U_XUSNV(10)_U_XUSNV(11)_U_XUSNV(12)_U_XUSNV(13)_U_XUSNV(14)
 . ;
 . ;Office Phone number (place holder)
 . S XUSNV(15)=""
 . ; 
 . ; get Taxonomy and Specialty
 . N NVTX,NVSPC,NVTAX
 . S NVTX=0
 . F  S NVTX=$O(^IBA(355.93,NVIEN,"TAXONOMY","B",NVTX)) Q:'NVTX  D
 . . S NVSPC=$P($G(^USC(8932.1,NVTX,0)),U,9)
 . . S NVTAX=$P($G(^USC(8932.1,NVTX,0)),U,7)
 . . I NVSPC'="" D
 . . . I XUSNV(16)="" S XUSNV(16)=NVSPC Q
 . . . S XUSNV(16)=XUSNV(16)_";"_NVSPC
 . . I NVTAX'="" D
 . . . I XUSNV(17)="" S XUSNV(17)=NVTAX Q
 . . . ;
 . . . ; *** Start XU*8.0*548 - RBN ***
 . . . ;
 . . . ;S XUSNV(17)=XUSNV(17)_";"_NVTAX
 . . . S:(XUSNV(17)'[NVTAX) XUSNV(17)=XUSNV(17)_";"_NVTAX
 . . . ;
 . . . ; *** End XU*8.0*548 - RBN ***
 . ;
 . ; Fed Tax ID
 . S XUSNV(18)=$P($G(IBA0),U,9)
 . ;
 . ;Medicare A/B
 . S XUSNV(19)=670899
 . S XUSNV(20)="VA"_$E(SITE+10000,2,5)
 . ;
 . S XUSDATA=XUSDATA_U_XUSNV(15)_U_XUSNV(16)_U_XUSNV(17)_U_XUSNV(18)_U_XUSNV(19)_U_XUSNV(20)
 . ;
 . ;State License Number
 . ;S XUSNV(20)=$P($G(IBA0),U,12)
 . ;
 . ;DEA Number (place holder)
 . S XUSNV(21)=""
 . ;
 . ;NCPDP #
 . S XUSNV(22)=""
 . ;
 . ;VISN STATION ID
 . S XUSNV(23)=SITE
 . ;
 . S XUSDATA=XUSDATA_U_XUSNV(21)_U_XUSNV(22)_U_XUSNV(23)
 . ;
 . ;BCBS info
 . K XUSBXID
 . D NNVAID^XUSNPIXU(NVIEN,.XUSBXID)
 . ;
 . ;Update counter and save Entry
 . N XUSB,XUSB1
 . S XUSCNT=XUSCNT+1,TOTREC2=TOTREC2+1
 . S ^TMP(XUSRTN,$J,XUSCNT)=XUSDATA_U_XUSEOL
 . S XUSIZE=XUSIZE+$L(^TMP(XUSRTN,$J,XUSCNT))
 . I $D(XUSBXID) D
 . . S XUSB=""
 . . F  S XUSB=$O(XUSBXID(XUSB)) Q:XUSB=""  D
 . . . S XUSB1=$G(XUSBXID(XUSB)) I XUSB1'="" S XUSB1="^"_XUSB1 ;add p 528
 . . . S XUSCNT=XUSCNT+1,TOTREC2=TOTREC2+1
 . . . S ^TMP(XUSRTN,$J,XUSCNT)=XUSDATA_U_$$TRIM^XLFSTR(XUSB)_XUSB1_U_XUSEOL ;add _XUSB1 p 528
 . . . S XUSIZE=XUSIZE+$L(^TMP(XUSRTN,$J,XUSCNT))
 . I XUSIZE>MAXSIZE D
 . . D EOF2(XUSRTN)
 . . D EMAIL^XUSNPIX3(XUSRTN) ;sending the extracted data via MailMan
 . . K ^TMP(XUSRTN,$J)
 . . S ^TMP("XUSNPIXS",$J,4,MSGCNT)="2 (Non-VA)^"_(XUSCNT-2)
 . . S ^TMP(XUSRTN,$J,1)=XUSHDR
 . . S XUSCNT=1,XUSIZE=0
 . K XUSNV,XUSDATA,XUSB,XUSBXID
 ;
 D EOF2(XUSRTN)
 ;
 ; Send last message (if it has records)
 I $G(XUSCNT)>1 D
 . D EMAIL^XUSNPIX3(XUSRTN) ;sending the extracted data via MailMan
 . K ^TMP(XUSRTN,$J)
 . S ^TMP("XUSNPIXS",$J,4,MSGCNT)="2 (Non-VA)^"_($G(XUSCNT)-2)
 ;
 ; Update Summary
 S ^XTMP("XUSNPIXT","2NV")=MSGCNT_U_TOTREC2_U_DTTM3
 Q
 ;
EOF2(XUSRTN) ;
 Q:$G(XUSCNT)=1
 S MSGCNT=MSGCNT+1
 S ^TMP(XUSRTN,$J,1)=XUSHDR_U_"Message Number: "_MSGCNT_U_"Line Count: "_XUSCNT_U_DTTM3_U_$G(XUSPROD)_U_XUSEOL
 S XUSCNT=XUSCNT+1
 S ^TMP(XUSRTN,$J,XUSCNT)="END OF FILE"_U_XUSEOL
 Q
