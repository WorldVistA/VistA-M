LRAPBR1 ;DALOI/STAFF - AP Browser Print Cont. ;12/04/09  18:27
 ;;5.2;LAB SERVICE;**259,317,363,350**;Sep 27, 1994;Build 230
 ;
 ;
ENTER ; from LRAPBR
 N LRCNT,LRTMP,LRA1,LRADESC,LRLENG1,LRLENG2,LRFILE,LRAPMD
 N LRFLD,LRV,LRV1,LRV2,LRX,LRB1,LRTEXT,LRSPCE,LRIENS,LRAPMR
 Q:'$D(^LR(LRDFN,LRSS,LRI,0))
 S:'LRTIU GROOT="^TMP(""LRAPBR"",$J,"
 S:LRTIU GROOT="^TMP(""TIUP"",$J,"
 ;
 D GETPCP^LRAPUTL(.LRPRAC,LRDFN,LRSS,LRI)
 ;
 ; If reporting lab available then use instead of VistA site name.
 S LRX=+$G(^LR(LRDFN,LRSS,LRI,"RF"))
 I LRX S LRQ(1)=$$NAME^XUAF4(LRX)
 ;
 S LRQ=0 D ^LRUA,HEADER
 S LR("F")=1
 D DASH
 D:LRTIU GLENTRY("$TEXT",,1)
 D GLENTRY("Submitted by: "_LRW(5),"",1)
 D GLENTRY("Date obtained: "_LRTK,44)
 D:LRA DASH
 ;
 S LRIENS=LRI_","_LRDFN_","
 ;
 ;
MAIN ;
 D SPEC
 D MODCHK
 D SUPBNNR
 D COMMENT
 D DIAG
 D DOC
 D WPFLD
 D SUPRPT
 D SSJR
 D PPL
 Q
 ;
 ;
SPEC ; List specimens
 ;
 ;ZEXCEPT: LRDFN,LRI,LRIENS,LRSF,LRSS
 ;
 N LRB,LRFILE,LRX
 ;
 D GLENTRY("Specimen (Received "_LRTK(1)_"):","",1)
 ;
 S LRFILE=+$$GET1^DID(LRSF,.012,"","SPECIFIER")
 S LRB=0
 F  S LRB=$O(^LR(LRDFN,LRSS,LRI,.1,LRB)) Q:LRB<1  D
 . S LRX=$$GET1^DIQ(LRFILE,LRB_","_LRIENS,.01)
 . D GLENTRY(LRX,"",1)
 ;
 Q
 ;
 ;
MODCHK ; Display modified banner if required
 S LRAPMR=$$GET1^DIQ(LRSF,LRIENS,.17,"I")
 Q:'LRAPMR
 S LRAPMD=$$GET1^DIQ(LRSF,LRIENS,.172,"I")
 D GLENTRY("","",1)
 S LRTEXT=""
 F LRCNT=1:1:$S(LRAPMD:14,1:15) D
 . S LRTEXT=LRTEXT_"*+"
 S LRTEXT=LRTEXT_" MODIFIED "
 S LRTEXT=LRTEXT_$S(LRAPMD:"DIAGNOSIS ",1:"REPORT ")
 F LRCNT=1:1:$S(LRAPMD:14,1:15) D
 . S LRTEXT=LRTEXT_"*+"
 D GLENTRY(LRTEXT,"",1)
 D GLENTRY("","",1)
 Q
 ;
 ;
SUPBNNR ; Display supplementary report header if one or more has been added
 I $P($G(^LR(LRDFN,LRSS,LRI,1.2,0)),U,4) D
 . S LRTEXT="*+* SUPPLEMENTARY REPORT HAS BEEN ADDED *+*"
 . D GLENTRY($$CJ^XLFSTR(LRTEXT,IOM),"",1)
 . S LRTEXT="*+* REFER TO BOTTOM OF REPORT *+*"
 . D GLENTRY($$CJ^XLFSTR(LRTEXT,IOM),"",1)
 . D GLENTRY("","",1)
 Q
 ;
 ;
DIAG ; Display the Brief Clinical History, Preoperative Diagnosis, Operative Findings, and Postoperative Diagnosis
 S LRFILE=LRSF,LRCNT=0,LRIENS=LRI_","_LRDFN_","
 F LRFLD=.013:.001:.016 D
 . D:LRA DASH
 . S LRCNT=LRCNT+1
 . D GLENTRY($P($T(TEXT1+LRCNT),";",3),"",1)
 . D WP
 Q
 ;
 ;
DOC ; Pathologist information
 ;
 N LRIENS,LRX
 D GLENTRY("","",1)
 ;
 ; Retrieve surgeon/attending
 D ATTEND(.LRMD)
 D GLENTRY("Surgeon/physician: "_LRMD,27,1)
 I LRMD("SR-SURGEON")'="" D GLENTRY(LRMD("SR-SURGEON"),28,1)
 I LRMD("SR-ATTEND")'="" D GLENTRY(LRMD("SR-ATTEND"),26,1)
 ;I +$G(LRMD("ERR"))=601 D GLENTRY($P(LRMD("ERR"),"^",2),26,1)
 ;
 D:LRA GLENTRY(LR("%1"),"",1)
 D DASH
 D HEADER2
 D:LRA DASH
 I LRRC="" D
 . D GLENTRY("+*+* REPORT INCOMPLETE *+*+",20,1)
 . D GLENTRY("","",1)
 D GLENTRY("","",1)
 I LRRMD'="" D
 . S LRCNT=0 F LRA1="SP","CY","EM" D
 . . S LRCNT=LRCNT+1
 . . S LRTMP(LRA1)=$P($T(TEXT2+LRCNT),";",4)
 . S LRTMP=LRTMP(LRSS)
 . D GLENTRY(LRTMP_" "_LRRMD,31)
 Q
 ;
 ;
WPFLD ; Display Frozen Section, Gross Description, Microscopic Description and Surgical Path Diagnosis
 F LRCNT=1:1:4 D
 . S X=$T(FIELDS+LRCNT)
 . S LRV=$P(X,";",3),LRV1=$P(X,";",4),LRV2=$P(X,";",5)
 . D TEXTCHK
 . I $P($G(^LR(LRDFN,LRSS,LRI,LRV,0)),U,4) D
 . . D GLENTRY("","",1),GLENTRY(LR(69.2,LRV1),"",1)
 . . S LRFILE=LRSF,LRIENS=LRI_","_LRDFN_",",LRFLD=LRV
 . . I $P($G(^LR(LRDFN,LRSS,LRI,LRV2,0)),U,4) D
 . . . S LRFILE1=+$$GET1^DID(LRSF,LRV2,"","SPECIFIER")
 . . . D GLENTRY("*+* MODIFIED REPORT *+*",28,1)
 . . . D GLENTRY("(Last modified: ","",1)
 . . . S (LRA1,LRB1)=0
 . . . F  S LRA1=$O(^LR(LRDFN,LRSS,LRI,LRV2,LRA1)) Q:'LRA1  S LRB1=LRA1
 . . . Q:'$D(^LR(LRDFN,LRSS,LRI,LRV2,LRB1,0))
 . . . S LRSR1=$$GET1^DIQ(LRFILE1,LRB1_","_LRIENS,.01)
 . . . S LRSR2=$$GET1^DIQ(LRFILE1,LRB1_","_LRIENS,.02)
 . . . S LRTEXT=LRSR1_" typed by "_LRSR2_")"
 . . . D GLENTRY(LRTEXT,BTAB)
 . . D WP
 Q
 ;
 ;
SUPRPT ; Supplementary Report
 N LRA2
 I $P($G(^LR(LRDFN,LRSS,LRI,1.2,0)),U,4) D
 . S LRFILE=+$$GET1^DID(LRSF,1.2,"","SPECIFIER")
 . S LRIENS1=LRI_","_LRDFN_","
 . D GLENTRY("","",1),GLENTRY("SUPPLEMENTARY REPORT(S):","",1)
 . S LRV=0 F  S LRV=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV)) Q:'LRV  D
 . . S LRIENS=LRV_","_LRIENS1
 . . S LRSR1=$$GET1^DIQ(LRFILE,LRIENS,.01)
 . . S LRSR2=+$$GET1^DIQ(LRFILE,LRIENS,.02)
 . . D GLENTRY("Supplementary Report Date: "_LRSR1,3,1)
 . . I $D(LR("R")),'LRSR2 D GLENTRY(" not verified",BTAB) Q
 . . I $P($G(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,0)),U,4) D
 . . . S LRTEXT="*+* SUPPLEMENTARY REPORT HAS BEEN ADDED/MODIFIED *+*"
 . . . D GLENTRY($$CJ^XLFSTR(LRTEXT,IOM),"",1)
 . . . D GLENTRY("(Added/Last","",1)
 . . . S (LRA1,LRB1)=0
 . . . F  S LRA1=$O(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,LRA1)) Q:'LRA1  D
 . . . . S LRB1=LRA1
 . . . Q:'$D(^LR(LRDFN,LRSS,LRI,1.2,LRV,2,LRB1,0))
 . . . S LRA2=^(0),Y=+LRA2,LRA2A=$P(LRA2,"^",2),LRSGN=" Typed by ",LRDSC=" modified: "
 . . . I $P(LRA2,"^",3) S LRSGN=" Signed by ",LRDSC=" released: ",LRA2A=$P(LRA2,"^",3),Y=$P(LRA2,"^",4)
 . . . S LRA2A=$S($D(^VA(200,LRA2A,0)):$P(^(0),"^"),1:LRA2A)
 . . . D D^LRU
 . . . D GLENTRY(LRDSC_Y_LRSGN_LRA2A_")",BTAB)
 . . S LRFLD=1 D WP
 . . D GLENTRY("","",1)
 Q
 ;
 ;
COMMENT ; Print comment field (#99)
 ;
 N LRB
 I '$O(^LR(LRDFN,LRSS,LRI,99,0)) Q
 ;
 D GLENTRY("Comment:","",1)
 ;
 S LRB=0
 F  S LRB=$O(^LR(LRDFN,LRSS,LRI,99,LRB)) Q:'LRB  D
 . S LRB(0)=^LR(LRDFN,LRSS,LRI,99,LRB,0)
 . D GLENTRY(LRB(0),"",1)
 ;
 D GLENTRY("","",1)
 ;
 Q
 ;
 ;
SSJR ; Print special studies/journal references
 D ^LRAPBR3
 S LREFLG=1
 Q
 ;
 ;
PPL ; Print performing laboratories.
 N LRPL,LRJ
 ;
 D RETLST^LRRPL(.LRPL,LRDFN,LRSS,LRI,0)
 I $G(LRPL)<1 Q
 ;
 D GLENTRY($$REPEAT^XLFSTR("=",IOM),"",1)
 D GLENTRY("Performing Laboratory:","",1)
 S LRJ=0
 F  S LRJ=$O(LRPL(LRJ)) Q:'LRJ  D GLENTRY(LRPL(LRJ),"",1)
 ;
 Q
 ;
 ;
WP ; Display word processing fields
 K LRTMP,^UTILITY($J,"W")
 N X,DIWR,DIWL,LRINC
 S X=$$GET1^DIQ(LRFILE,LRIENS,LRFLD,"","LRTMP",)
 S DIWR=IOM-5,DIWL=5,DIWF=$G(DIWF)
 S X=+$$GET1^DID(LRFILE,LRFLD,"","SPECIFIER")
 I $$GET1^DID(X,.01,"","SPECIFIER")["L",DIWF'["N" S DIWF=DIWF_"N"
 S LRINC=0
 F  S LRINC=$O(LRTMP(LRINC)) Q:'LRINC  S X=LRTMP(LRINC) D ^DIWP
 S LRINC=0
 F  S LRINC=$O(^UTILITY($J,"W",DIWL,LRINC)) Q:'LRINC  D GLENTRY(^UTILITY($J,"W",DIWL,LRINC,0),DIWL,1)
 K ^UTILITY($J,"W")
 Q
 ;
 ;
HEADER ;
 D:LRTIU GLENTRY("$APHDR",,1)
 D GLENTRY("","",1)
 ;
 ; Print names of facilities printing/releasing this report.
 N LRN,LRPL,LRRL,LRX
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")>1,'LRTIU D
 . D PFAC^LRRP1(DUZ(2),"",1,.LRPL)
 . S LRN=0
 . F  S LRN=$O(LRPL(LRN)) Q:'LRN  D GLENTRY(LRPL(LRN),"",1)
 ;
 ; Display reporting lab
 I $$GET^XPAR("DIV^PKG","LR REPORTS FACILITY PRINT",1,"Q")#2 D
 . S LRX=+$G(^LR(LRDFN,LRSS,LRI,"RF"))
 . I LRX<1 Q
 . D RL^LRRP1(LRX,1,.LRRL),GLENTRY("","",1)
 . S LRN=0
 . F  S LRN=$O(LRRL(LRN)) Q:'LRN  D GLENTRY(LRRL(LRN),"",1)
 ;
 D DASH
 D GLENTRY("MEDICAL RECORD |",5,1)
 D GLENTRY(LRAA1,40)
 D DASH
 ;
 ;
HEADER2 ;
 ;
 S LRADESC="Accession No. "_$S(LRQ(8)]"":LRQ(8)_LRW(1)_" "_LRAC,1:LRAC)
 S LRLENG1=$L(LRQ(1)),LRLENG2=$L(LRADESC),LRSPCE=IOM-LRLENG2-14
 S:LRLENG1>LRSPCE LRQ(1)=$E(LRQ(1),1,LRSPCE)
 ;
 D GLENTRY("PATHOLOGY REPORT",30,1)
 I '$G(^LR(LRDFN,LRSS,LRI,"RF")) D GLENTRY("Laboratory: "_LRQ(1),"",1)
 D GLENTRY(LRADESC,IOM-LRLENG2-1)
 Q
 ;
 ;
FOOTER ; Footer-called from ^LRAPBR
 D:LRTIU GLENTRY("$FTR",,1)
 D DASH
 S LRTEXT=$S('$D(LR("W")):"",1:"See signed copy in chart")
 D GLENTRY(LRTEXT,"",1)
 S LRTEXT="("_$S($D(LREFLG):"End of report",1:"See next page")_")"
 D GLENTRY(LRTEXT,57)
 D GLENTRY(LRPMD,"",1),GLENTRY(LRW(9),52),GLENTRY("| Date "_LRRC,55)
 D DASH
 D GLENTRY(LRP,"",1)
 S LRTEXT=$S('$D(LR("W")):"STANDARD FORM 515",1:"WORK COPY ONLY !!")
 D GLENTRY(LRTEXT,50)
 D GLENTRY("ID:"_SSN,"",1)
 D GLENTRY("SEX:"_SEX,16),GLENTRY(" DOB:"_DOB,BTAB)
 I AGE D
 . S LRTEXT=$S($G(VADM(6))]"":" AGE AT DEATH: ",1:" AGE: ")_AGE
 . D GLENTRY(LRTEXT,BTAB)
 D GLENTRY(" LOC:"_LRLLOC,BTAB)
 D GLENTRY("","",1)
 I LRADM'="" D GLENTRY("ADM:"_$P(LRADM,"@"),BTAB)
 I LRADX'="" D GLENTRY("DX:"_$E(LRADX,1,26),17)
 D GLENTRY("PCP:",46)
 I LRPRAC'="" D GLENTRY($E(LRPRAC(1),1,28),51)
 Q
 ;
 ;
ESIGLN ; Write signature block name, title, and date of signature
 D GLENTRY(,,1)
 I $D(^VA(200,DUZ,0)) D
 . S LRFILE=200,LRFLD=20.2,LRFLD2=20.3
 . S X=$$GET1^DIQ(LRFILE,DUZ,LRFLD)
 ; Compare DUZ to pathologist, if different, use proxy signature
 S:LRSS="AU" LRPATH=$$GET1^DIQ(63,LRDFN,13.6,"I")
 I LRSS'="AU" D
 . S LRFL2=$S(LRSS="EM":63.02,LRSS="CY":63.09,LRSS="SP":63.08,1:0)
 . S LRIENS=LRI_","_LRDFN_","
 . S LRPATH=$$GET1^DIQ(LRFL2,LRIENS,.02,"I")
 S LRPATH2=""
 S:LRPATH'=DUZ LRPATH2=" FOR "_$$GET1^DIQ(LRFILE,LRPATH,LRFLD)
 S LRTEXT="/es/ "_X_LRPATH2
 ; S LRTEXT="/es/ "_X
 D GLENTRY(LRTEXT,,1)
 S LRTEXT=$$GET1^DIQ(LRFILE,DUZ,LRFLD2)
 D GLENTRY(LRTEXT,,1)
 S LRTEXT="Signed "_$$FMTE^XLFDT(LRNTIME,"1MZ")
 D GLENTRY(LRTEXT,,1)
 Q
 ;
 ;
DASH ; Display a line of dashes
 D GLENTRY(LR("%"),"",1)
 Q
 ;
 ;
GLENTRY(LRPR1,LRPR2,LRPR3) ; Write to global
 ; LRPR1 = Text to be written to global
 ; LRPR2 = Tab position
 ; LRPR3 = 1 means start a new line.  Otherwise, write an current line.
 S LRPR1=$G(LRPR1)
 S LRPR2=+$G(LRPR2)
 S LRPR3=+$G(LRPR3)
 D:LRPR3 NEWLN^LRAPUTL(LRPR1,LRPR2)
 D:'LRPR3 GLBWRT^LRAPUTL(LRPR1,LRPR2)
 Q
 ;
 ;
TEXT1 ;Text for top of report
 ;;BRIEF CLINICAL HISTORY:
 ;;PREOPERATIVE DIAGNOSIS:
 ;;OPERATIVE FINDINGS:
 ;;POSTOPERATIVE DIAGNOSIS:
 ;
TEXT2 ;Descriptive text based on section
 ;;SP;Pathology Resident:
 ;;CY;Screened by:
 ;;EM;Prepared by:
 ;
FIELDS ;Field numbers for word processing fields
 ;;1.3;.13;6
 ;;1;.03;7
 ;;1.1;.04;4
 ;;1.4;.14;5
 ;
TEXTCHK ; update text line counter if it is missing (Remedy 116253)
 N I,X,DATA
 S I=0
 K ^TMP("WP",$J)
 S X=$G(^LR(LRDFN,LRSS,LRI,LRV,0))
 I X'="",$L(X,"^")=1 D
 . F  S I=$O(^LR(LRDFN,LRSS,LRI,LRV,I)) Q:I=""  D
 . . S DATA=$G(^LR(LRDFN,LRSS,LRI,LRV,I,0))
 . . S ^TMP("WP",$J,I,0)=DATA
 I $D(^TMP("WP",$J)) D
 . D WP^DIE(63.08,LRI_","_LRDFN_",",LRV,"","^TMP(""WP"",$J)")
 . K ^TMP("WP",$J)
 Q
 ;
 ;
ATTEND(LRMD) ; Retrieve surgeon/attending
 ; Call with LRMD = current ordering provider array, pass by reference
 ;
 ; Update ordering provider/surgeon if Surgery package indicates change
 ;
 N LRIENS,LRX
 S LRIENS=LRDFN_","_LRSS_","_LRI_",0",(LRMD("SR-ATTEND"),LRMD("SR-SURGEON"))=""
 S LRX=$O(^LR(LRDFN,"EPR","AD",LRIENS,1,0))
 I LRX<1 Q
 ;
 N LRDATA,LRJ,LRORDP,LRREF,LRSRDATA,LRSRTN
 S LRREF=LRX_","_LRDFN_","
 D GETDATA^LRUEPR(.LRDATA,LRREF)
 S LRSRTN=LRDATA(63.00013,LRREF,1,"I")
 ;
 I $P(LRSRTN,";",2)'="SRF(" Q
 ;
 S LRORDP=+$P(^LR(LRDFN,LRSS,LRI,0),"^",7) ; Retrieve current surgeon/provider from file #63
 D SRCASE^LRUEPR(.LRSRDATA,+LRSRTN)
 ;
 I $G(LRSRDATA("ERR")) D  Q
 . S LRMD("ERR")=LRSRDATA("ERR")
 . D SRCASERR^LRUEPR(LRREF,LRSRTN,LRSRDATA("ERR"))
 ;
 F LRJ=.14,123 D
 . S LRX=LRSRDATA(130,+LRSRTN_",",LRJ,"I")
 . I LRX,LRORDP,LRX'=LRORDP S LRMD("SR-SURGEON")=$S(LRJ=.14:" Current Surgeon",LRJ=123:"Current Provider",1:"")_": "_$$NAME^XUSER(LRX,"G")
 F LRJ=.164,124 D
 . S LRX=LRSRDATA(130,+LRSRTN_",",LRJ,"I")
 . I LRX S LRMD("SR-ATTEND")=$S(LRJ=.164:" Attending Surgeon",LRJ=124:"Attending Provider",1:"")_": "_$$NAME^XUSER(LRX,"G")
 ;
 Q
