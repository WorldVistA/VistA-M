FBUCLET2 ;WOIFO/SAB - UNAUTHORIZED CLAIM LETTER (continued) ;08/15/02
 ;;3.5;FEE BASIS;**38,46,69**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
AUTHPR ;print authorized dates and approved amounts on disposition letter
 ;INPUT:  FBDA = ien of unauthorized claim, file 162.7
 ;        FBORDER = (optional) order number of status
 ;        FBUCA = current (after) zero node of unauthorized claim (162.7)
 ;        FBUC = unauthorized claim node in parameter file
 ;        FBCC = flag, true if CC address should print at bottom of page
 ;        FBCCI = # used to determine where CC address prints
 ;OUTPUT: FBTAMT = total amount approved
 ;        FBCC value may be changed
 N DA,FBAMT,FBCPT,FBDOS,FBFILE,FBIENS,FBMOD,FBMODLE,FBSC,FBSCA
 N FBSCCOL,FBUCPAY,FBX,FBY,FBACRR,FBADJLR,FBFPPSC,FBSCID,FBFPPSL,FBJ
 ;
 ; get list of payments for the claim
 S FBX=$$PAYST^FBUCUTL(FBDA,"FBUCPAY")
 ; get fpps claim id
 S FBFPPSC=$P($G(^FB583(FBDA,5)),U)
 S FBSCID=""
 ;
 ; loop thru payments to get total amount approved and suspend code list
 S FBTAMT=0
 F FBFILE=162.03,162.11,162.5 D
 . S FBIENS="" F  S FBIENS=$O(FBUCPAY(FBDA,FBFILE,FBIENS)) Q:FBIENS=""  D
 . . I FBFILE=162.03 D
 . . . S FBAMT=$$GET1^DIQ(FBFILE,FBIENS,2)
 . . . Q:FBSCID]""
 . . . S FBSCID=$$GET1^DIQ(FBFILE,FBIENS,49)
 . . I FBFILE=162.11 D
 . . . S FBAMT=$$GET1^DIQ(FBFILE,FBIENS,6.5)
 . . I FBFILE=162.5 D
 . . . S FBAMT=$$GET1^DIQ(FBFILE,FBIENS,8)
 . . . Q:FBSCID]""
 . . . S FBSCID=$$GET1^DIQ(FBFILE,FBIENS,55)  ; patient control number
 . . S FBTAMT=FBTAMT+FBAMT
 ;
 ; print authorized dates and total amount
 I $Y+$S(FBCC:FBCCI,1:8)>IOSL D PAGE^FBUCLET1
 W !?8,"Authorized from: ",$$FMTE^XLFDT($P(FBUCA,U,13))
 W "  Authorized to: ",$$FMTE^XLFDT($P(FBUCA,U,14))
 W !?8,"Amount approved:  " W:FBTAMT "$",$FN(FBTAMT,",",2)
 W "  Itemized list follows:"
 ;
 ; print header and detail lines for civil hospital payments
 I $D(FBUCPAY(FBDA,162.5)) D
 . I $Y+$S(FBCC:FBCCI,1:7)>IOSL D PAGE^FBUCLET1
 . W !!?8,"Patient Control Number: ",FBSCID
 . I $Y+$S(FBCC:FBCCI,1:11)>IOSL D PAGE^FBUCLET1
 . D CHDHD
 . S FBIENS=""
 . F  S FBIENS=$O(FBUCPAY(FBDA,162.5,FBIENS)) Q:FBIENS=""  D CHD
 ;
 ; print header and detail lines for outpatient/ancillary payments
 I $D(FBUCPAY(FBDA,162.03)) D
 . I $Y+$S(FBCC:FBCCI,1:7)>IOSL D PAGE^FBUCLET1
 . W !!?8,"Patient Account Number: ",FBSCID
 . I $Y+$S(FBCC:FBCCI,1:11)>IOSL D PAGE^FBUCLET1
 . D ODHD
 . S FBIENS=""
 . F  S FBIENS=$O(FBUCPAY(FBDA,162.03,FBIENS)) Q:FBIENS=""  D OD
 ;
 ; print header and detail lines for pharmacy payments
 I $D(FBUCPAY(FBDA,162.11)) D
 . I $Y+$S(FBCC:FBCCI,1:11)>IOSL D PAGE^FBUCLET1
 . D PDHD
 . S FBIENS=""
 . F  S FBIENS=$O(FBUCPAY(FBDA,162.11,FBIENS)) Q:FBIENS=""  D PD
 ;
 ;set FBSCCOL flag to indicate if the suspend code column should be used
 ;    = 1 or 0 (1 if there are any suspend codes beside "4 Other")
 S FBSCCOL=0
 S FBSC="" F  S FBSC=$O(FBSCA(FBSC)) Q:FBSC=""  I FBSC'=4 S FBSCCOL=1 Q
 ;
 ; print relevant suspend code descriptions 
 I FBSCCOL D
 . N FBGL,FBLBL
 . I $Y+$S(FBCC:FBCCI,1:10)>IOSL D PAGE^FBUCLET1
 . W !!?8,"*Reason(s) for Suspension"
 . S FBSC="" F  S FBSC=$O(FBSCA(FBSC)) Q:FBSC=""  D
 . . I FBSC="4" D  Q
 . . . W !?8,"(4) Other. Specific reason immediately follows item."
 . . ; print description of suspend code from file when not "Other"
 . . S FBGL="^FBAA(161.27,"
 . . S FBLBL="("_FBSC_") "
 . . S DA=$O(^FBAA(161.27,"B",FBSC,0))
 . . I $Y+$S(FBCC:FBCCI,1:9)>IOSL D PAGE^FBUCLET1
 . . D TXT^FBUCUTL2(FBGL,DA,1,"WC69I8",1,1,.FBCC,FBCCI,FBLBL)
 ;
 W !
 D ACT:$D(FBACRR) K FBACRR
 Q
 ;
ACT ; print table of adjustment reason descriptions
 ; Input
 ;    FBACRR( - required, array
 ;    FBACRR(FBADJRE)=""
 ;    where FBADJRE = adjustment reason code, external value
 N FBADJRE,FBI,X,FBACT
 I $Y+$S(FBCC:FBCCI,1:10)>IOSL D PAGE^FBUCLET1
 W !,?8,"*Adjustment Code Text:"
 S FBADJRE="" F  S FBADJRE=$O(FBACRR(FBADJRE)) Q:FBADJRE=""  D
 . ; get description of code in FBACT
 . I $$AR^FBUTL1(,FBADJRE,,"FBACT")<0 Q  ; quit if error
 . ; print code and description
 . K ^UTILITY($J,"W")
 . S DIWL=1,DIWF="WC79I8"
 . ; include code in output
 . I $Y+$S(FBCC:FBCCI,1:9)>IOSL D PAGE^FBUCLET1
 . S X=$$LJ^XLFSTR("("_FBADJRE_")",6," ") D ^DIWP
 . S DIWF="WC79I14"
 . ; include description in output
 . S FBI=0 F  S FBI=$O(FBACT(FBI)) Q:FBI=""  S X=FBACT(FBI) I X]"" D ^DIWP
 . D ^DIWW
 Q
 ;
CHDHD ; civil hospital payment detail header
 W !!?8,"Admission Date",?24,"Discharge Date"
 W ?40,"Amt Claimed",?53,"Amt Approved"
 W ?67,"Adj Code*"
 W !?8,"--------------",?24,"--------------"
 W ?40,"-----------",?53,"------------"
 W ?67,"--------"
 Q
CHD ; civil hospital payment detail
 S FBSC=""
 S DA=$P(FBIENS,",")
 S FBY=$G(^FBAAI(DA,0))
 S FBFPPSL=$P($G(^FBAAI(DA,3)),U,2) ; fpps line item
 S FBADJLR=$P($$ADJLRA^FBCHFA(DA_","),U)
 S:FBADJLR]"" FBACRR(FBADJLR)=""
 I $Y+$S(FBCC:FBCCI,1:10)>IOSL D PAGE^FBUCLET1,CHDHD
 W !!?8,$$FMTE^XLFDT($P(FBY,U,6)),?24,$$FMTE^XLFDT($P(FBY,U,7))
 W ?40,$J("$"_$FN($P(FBY,U,8),",",2),11)
 W ?53,$J("$"_$FN($P(FBY,U,9),",",2),12)
 S:FBADJLR="" FBSC=$$GET1^DIQ(162.5,FBIENS,10)
 S:FBSC]"" FBSCA(FBSC)=""
 W ?70,$S(FBADJLR]"":FBADJLR,1:FBSC)
 I FBFPPSC]"" W !,?8,"FPPS Claim ID: ",FBFPPSC,?36,"FPPS Line Item: ",FBFPPSL
 ; if "Other" suspend code then print description
 I FBSC="4" D
 . N FBGL,FBLBL
 . S FBGL="^FBAAI("
 . S FBLBL="Reason for Suspension: "
 . D:$Y+$S(FBCC:FBCCI,1:9)>IOSL PAGE^FBUCLET1
 . D TXT^FBUCUTL2(FBGL,DA,1,"WC69I10",1,1,.FBCC,FBCCI,FBLBL)
 Q
ODHD ; outpatient/ancillary payment header
 W !!?8,"Service Date",?22,"CPT-MOD"
 W ?40,"Amt Claimed",?53,"Amt Approved"
 W ?67,"Adj Code*"
 W !?8,"------------",?22,"--------"
 W ?40,"-----------",?53,"------------"
 W ?67,"--------"
 Q
 ;
OD ; outpatient/ancillary payment detail
 N FBADJRE
 S FBSC=""
 S DA=$P(FBIENS,",")
 S DA(1)=$P(FBIENS,",",2)
 S DA(2)=$P(FBIENS,",",3)
 S DA(3)=$P(FBIENS,",",4)
 S FBY=$G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,0))
 S FBFPPSL=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),1,DA,3)),U,2)
 S FBADJLR=$P($$ADJLRA^FBAAFA(DA_","_DA(1)_","_DA(2)_","_DA(3)_","),U)
 F FBJ=1:1 S FBADJRE=$P(FBADJLR,",",FBJ) Q:FBADJRE=""  S FBACRR(FBADJRE)=""
 S FBDOS=$P($G(^FBAAC(DA(3),1,DA(2),1,DA(1),0)),U)
 S FBCPT=$$GET1^DIQ(162.03,FBIENS,.01)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"_DA_",""M"")","E")
 I $Y+$S(FBCC:FBCCI,1:10)>IOSL D PAGE^FBUCLET1,ODHD
 W !!?8,$$FMTE^XLFDT(FBDOS)
 W ?22,FBCPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:"")
 W ?40,$J("$"_$FN($P(FBY,U,2),",",2),11)
 W ?53,$J("$"_$FN($P(FBY,U,3),",",2),12)
 S:FBADJLR="" FBSC=$$GET1^DIQ(162.03,FBIENS,4)
 S:FBSC]"" FBSCA(FBSC)=""
 W ?70,$S(FBADJLR]"":FBADJLR,1:FBSC)
 I $P($G(FBMODLE),",",2)]"" D
 . N FBI
 . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D
 . . ;I $Y+4>IOSL W @IOF D HED W !,"  (continued)"
 . . W !,?27,"-",FBMOD
 I FBFPPSC]"" W !,?8,"FPPS Claim ID: ",FBFPPSC,?36,"FPPS Line Item: ",FBFPPSL
 ; if "Other" suspend code then print description
 I FBSC="4" D
 . N FBGL,FBLBL
 . S FBGL="^FBAAC("_DA(3)_",1,"_DA(2)_",1,"_DA(1)_",1,"
 . S FBLBL="Reason for Suspension: "
 . D:$Y+$S(FBCC:FBCCI,1:9)>IOSL PAGE^FBUCLET1
 . D TXT^FBUCUTL2(FBGL,DA,1,"WC69I10",1,1,.FBCC,FBCCI,FBLBL)
 Q
PDHD ; pharmacy payment detail header
 W !!?8,"RX Date",?21,"RX #"
 W ?40,"Amt Claimed",?53,"Amt Approved"
 W ?67,"Adj Code*"
 W !?8,"------------",?21,"--------"
 W ?40,"-----------",?53,"------------"
 W ?67,"--------"
 Q
PD ; pharmacy payment detail
 N FBADJRE
 S FBSC=""
 S DA=$P(FBIENS,",")
 S DA(1)=$P(FBIENS,",",2)
 S FBY=$G(^FBAA(162.1,DA(1),"RX",DA,0))
 S FBFPPSL=$P($G(^FBAA(162.1,DA(1),"RX",DA,3)),U)
 S FBADJLR=$P($$ADJLRA^FBRXFA(DA_","_DA(1)_","),U)
 F FBJ=1:1 S FBADJRE=$P(FBADJLR,",",FBJ) Q:FBADJRE=""  S FBACRR(FBADJRE)=""
 I $Y+$S(FBCC:FBCCI,1:11)>IOSL D PAGE^FBUCLET1,PDHD
 W !!?8,$$FMTE^XLFDT($P(FBY,U,3)),?21,$$FMTE^XLFDT($P(FBY,U,1))
 W ?40,$J("$"_$FN($P(FBY,U,4),",",2),11)
 W ?53,$J("$"_$FN($P(FBY,U,16),",",2),12)
 S:FBADJLR="" FBSC=$$GET1^DIQ(162.11,FBIENS,7)
 S:FBSC]"" FBSCA(FBSC)=""
 W ?70,$S(FBADJLR]"":FBADJLR,1:FBSC)
 W !?8,"Drug Name: ",$P(FBY,U,2)
 I FBFPPSC]"" W !,?8,"FPPS Claim ID: ",FBFPPSC,?36,"FPPS Line Item: ",FBFPPSL
 ; if "Other" suspend code then print description
 I FBSC="4" D
 . N FBGL,FBLBL
 . S FBGL="^FBAA(162.1,"_DA(1)_",""RX"","
 . S FBLBL="Reason for Suspension: "
 . D:$Y+$S(FBCC:FBCCI,1:8)>IOSL PAGE^FBUCLET1
 . D TXT^FBUCUTL2(FBGL,DA,1,"WC69I10",1,1,.FBCC,FBCCI,FBLBL)
 Q
