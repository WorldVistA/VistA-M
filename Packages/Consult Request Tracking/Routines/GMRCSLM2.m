GMRCSLM2 ;SLC/DCM,WAT - LM Detailed  display and printing ;12/10/14  14:15
 ;;3.0;CONSULT/REQUEST TRACKING;**1,4,18,15,17,23,22,65,66,73,81**;DEC 27,1997;Build 6
 ;
 ;ICRs
 ;GLOBALS/FILES
 ;#872 ^ORD(101  #875 ORDER STATUS file point(100.01)  #2638 ORDER STATUS file access  #2849 ORDERS file  #10060 NEW PERSON (file 200)  #10040 HOSPITAL LOCATION (^SC)
 ;#10090 INSTITUTION
 ;ROUTINES
 ;#2467 $$OI^ORX8  #2056 $$GET1^DIQ   #10104 XLFSTR   #4156 $$CVEDT^DGCV   #10117  ^VALM10   #4807 RDIS^DGRPDB
 ;
DT(GMRCO,GMRCIERR) ;;Entry point to set-up detailed display.
 ;;Pass in GMRCO as +GMRCO - a number only. GMRCO=IEN from of consult from file 123
 ;;Results are placed in ^TMP("GMRCR",$J,"DT",
 ;;Pass in variable GMRCOER=2 if calling from the GUI, GMRCOER=1 if call is from CPRS consults tab
 ;;Pass in variable GMRCOER=0 (or as <UNDEFINED>) if call is from consults routines
 K GMRCQUT
 N DFN,GMRCD,GMRCDA,ORIFN,GMRCSF S GMRCDVDL="",$P(GMRCDVDL,"-",80)=""
 I $S('GMRCO:1,'$D(^GMR(123,+GMRCO,0)):1,1:0) D:$S('$D(GMRCOER):1,'GMRCOER:1,1:0)  S GMRCQUT=1 Q
 .S GMRCMSG="The consult entry selected for the Detailed Display is unknown." D EXAC^GMRCADC(GMRCMSG) K GMRCMSG
 .Q
 K ^TMP("GMRCR",$J,"DT") S TAB="",$P(TAB," ",30)="",GMRCCT=1
 S GMRCO(0)=^GMR(123,+GMRCO,0),ORIFN=$P(GMRCO(0),"^",3),DFN=$P(GMRCO(0),"^",2)
 S X="SDUTL3" X ^%ZOSF("TEST") I  D
 .N PR S PR=$$OUTPTPR^SDUTL3(DFN) I $L(PR) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Current PC Provider:   "_$P(PR,"^",2),GMRCCT=GMRCCT+1
 .S PR=$$OUTPTTM^SDUTL3(DFN) I $L(PR) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Current PC Team:       "_$P(PR,"^",2),GMRCCT=GMRCCT+1
 .Q
 N VAIN,VAEL,CVELIG
 D INP^VADPT S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Current Pat. Status:   "_$S(+VAIN(8):"Inpatient",1:"Outpatient"),GMRCCT=GMRCCT+1
 I $D(VAIN(4)),$L($P(VAIN(4),"^",2)) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Ward:"_$E(TAB,1,18)_$P(VAIN(4),"^",2),GMRCCT=GMRCCT+1
 D ELIG^VADPT
 S:$L($P(VAEL(1),"^",2)) ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Primary Eligibility:"_$E(TAB,1,3)_$P(VAEL(1),"^",2)_$S(VAEL(8)']"":" (NOT VERIFIED)",1:"("_$P(VAEL(8),"^",2)_")"),GMRCCT=GMRCCT+1
 ;wat 66
 I $L($P(VAEL(6),U,2))  D
 .;if TYPE is Active Duty and VETERAN Y/N? is No, then call the pt Active Duty
 .I $P(VAEL(6),U,1)=5&(VAEL(4)=0) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Patient Type:"_$E(TAB,1,10)_$P(VAEL(6),U,2),GMRCCT=GMRCCT+1
 .E  S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Patient Type:"_$E(TAB,1,10)_$P(VAEL(6),U,2),GMRCCT=GMRCCT+1
 ;//wat 66
 S CVELIG=$$CVEDT^DGCV(DFN) S:$P($G(CVELIG),U,3) ^TMP("GMRCR",$J,"DT",GMRCCT,0)="CV Eligible:"_$E(TAB,1,11)_"YES",GMRCCT=GMRCCT+1 ;WAT
 ;wat 66
 N VASV,OIFOEF S OIFOEF="NO" D SVC^VADPT S:(VASV(11)>0)!(VASV(12)>0)!(VASV(13)>0) OIFOEF="YES"
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="OEF/OIF: "_$E(TAB,1,14)_$G(OIFOEF),GMRCCT=GMRCCT+1
 ; GET SC RATINGS AND %
 N INC,COND S INC=0
 I $P(VAEL(3),U)=1  D
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Service Connection/Rated Disabilities",GMRCCT=GMRCCT+1
 .I '$P(VAEL(3),U,2) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="SC Percent:"_$E(TAB,1,12)_"DATA NOT FOUND",GMRCCT=GMRCCT+1
 .E  S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="SC Percent:"_$E(TAB,1,12)_$P(VAEL(3),U,2)_"%",GMRCCT=GMRCCT+1
 .D RDIS^DGRPDB(DFN,.GMRCRDIS) I $D(GMRCRDIS(1))  D
 ..F  S INC=$O(GMRCRDIS(INC)) Q:INC=""  D
 ...S COND=$$GET1^DIQ(31,$P(GMRCRDIS(INC),U),.01)
 ...S:$G(INC)=1 ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Rated Disabilities:"_$E(TAB,1,4)_$G(COND)_"  ("_$P(GMRCRDIS(INC),U,2)_"%)",GMRCCT=GMRCCT+1
 ...S:$G(INC)>1 ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$E(TAB,1,23)_$G(COND)_"  ("_$P(GMRCRDIS(INC),U,2)_"%)",GMRCCT=GMRCCT+1
 .I '$D(GMRCRDIS)  D
 ..S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Rated Disabilities:"_$E(TAB,1,4)_"NONE STATED",GMRCCT=GMRCCT+1
 ;//wat 66
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Order Information",GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="To Service:"_$E(TAB,1,12)_$P($G(^GMR(123.5,+$P(GMRCO(0),"^",5),0)),"^"),GMRCCT=GMRCCT+1
 I $P(GMRCO(0),"^",11) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Attention:"_$E(TAB,1,13)_$$GET1^DIQ(200,$P($G(GMRCO(0)),"^",11),.01),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="From Service:"_$E(TAB,1,10)_$P($G(^SC(+$P(GMRCO(0),"^",6),0)),"^"),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Requesting Provider: "_$E(TAB,1,2)_$S($P(GMRCO(0),"^",14)]"":$$GET1^DIQ(200,$P($G(GMRCO(0)),"^",14),.01),1:""),GMRCCT=GMRCCT+1
 I $L($P(GMRCO(0),"^",18)) D
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Service is to be rendered on an "_$S($P(GMRCO(0),"^",18)="I":"INPATIENT",1:"OUTPATIENT")_" basis",GMRCCT=GMRCCT+1
 .Q
 I $P(GMRCO(0),"^",10) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Place:"_$E(TAB,1,17)_$P($G(^ORD(101,+$P(GMRCO(0),"^",10),0)),"^",2),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Urgency:"_$E(TAB,1,15)_$S($L($P(GMRCO(0),"^",9)):$P($G(^ORD(101,+$P(GMRCO(0),"^",9),0)),"^",2),1:""),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Clinically Ind. Date:"_$E(TAB,1,2)_$$FMTE^XLFDT($P($G(GMRCO(0)),"^",24),1),GMRCCT=GMRCCT+1 ;WAT/66/81
 S X="ORX8" X ^%ZOSF("TEST") I  D
 .N GMRCOITM S GMRCOITM=$$OI^ORX8(ORIFN)
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Orderable Item:"_$E(TAB,1,8)_$P(GMRCOITM,U,2),GMRCCT=GMRCCT+1
 .Q
 S GMRCPRNM=$P(GMRCO(0),"^",8),GMRCPROC=$S(+GMRCPRNM:$P($G(^GMR(123.3,+GMRCPRNM,0)),"^"),1:"Consult Request")
 I $L(GMRCPROC) D
 .N GMRCLN
 .S GMRCTYPE=$S($P(GMRCO(0),U,17)="P":"Procedure",1:"Consult")
 .S GMRCLN=GMRCTYPE_":"_$E(TAB,1,22-$L(GMRCTYPE))_GMRCPROC
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCLN
 .S GMRCCT=GMRCCT+1
 .I $G(^GMR(123,+GMRCO,1)) D
 .. S GMRCLN=""
 .. S GMRCLN="Clinical Procedure:"_$E(TAB,1,4)
 .. S GMRCLN=GMRCLN_$$GET1^DIQ(123,+GMRCO,1.01,"E")
 .. S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=GMRCLN
 .. S GMRCCT=GMRCCT+1
 .Q
 D PROVDIAG(+GMRCO)
 I $D(^GMR(123,+GMRCO,20,0)) D
 .I $O(^GMR(123,+GMRCO,20,0)) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Reason For Request:",GMRCCT=GMRCCT+1 D  Q
 .. S LN=0
 .. F  S LN=$O(^GMR(123,+GMRCO,20,LN)) Q:LN=""  D
 ... S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=^GMR(123,+GMRCO,20,LN,0)
 ... I $G(GMRCIERR) D
 .... N TXT S TXT=^TMP("GMRCR",$J,"DT",GMRCCT,0)_"..."
 .... S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=TXT
 .... S LN=9999 ;quit with just one line
 ... S GMRCCT=GMRCCT+1
 .. Q
 . Q
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=" ",GMRCCT=GMRCCT+1
 ; get inter-facility consult info
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Inter-facility Information",GMRCCT=GMRCCT+1
 I '$P(GMRCO(0),"^",23) D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="This is not an inter-facility consult request.",GMRCCT=GMRCCT+1
 E  D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$$REPEAT^XLFSTR("-",27)
 . S GMRCCT=GMRCCT+1
 . N GMRCOP
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Remote Facility:"_$E(TAB,1,6)_$$GET1^DIQ(4,+$P(GMRCO(0),"^",23),.01),GMRCCT=GMRCCT+1 ;WAT/73
 . S GMRCO(12)=$G(^GMR(123,+GMRCO,12))
 . I $L($P(GMRCO(12),U,6)) D
 .. S GMRCOP=$P(GMRCO(12),U,6)
 . I '$D(GMRCOP) S GMRCOP=$$GET1^DIQ(200,+$P(GMRCO(0),U,14),.01)
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Ordering Provider:"_$E(TAB,1,5)_GMRCOP,GMRCCT=GMRCCT+1
 . S GMRCO(13)=$G(^GMR(123,+GMRCO,13)) I $L($P(GMRCO(13),U,2,3))>1 D
 .. N LINE
 .. S LINE=$P(GMRCO(13),U,2) I $L(LINE) S LINE=LINE_$E(TAB,1,5) D
 ... S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Ordering Provider phone: "_LINE
 ... S GMRCCT=GMRCCT+1
 .. S LINE=$P(GMRCO(13),U,3) I $L(LINE) S LINE=LINE_$E(TAB,1,5) D
 ... S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Ordering Provider pager: "_LINE
 ... S GMRCCT=GMRCCT+1
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Remote Consult #"_$E(TAB)_$P(GMRCO(0),"^",22),GMRCCT=GMRCCT+1
 . I $L($P(GMRCO(13),U)) S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Remote Service name: "_$E(TAB)_$P(GMRCO(13),U),GMRCCT=GMRCCT+1
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Role: "_$E(TAB,1,10)_$S($P(GMRCO(12),U,5)="P":"Requesting facility",1:"Consulting facility"),GMRCCT=GMRCCT+1
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 ;get status, last action, and significant findings
 S STS=$P(GMRCO(0),"^",12),^TMP("GMRCR",$J,"DT",GMRCCT,0)="Status:  "_$E(TAB,1,14)_$S($D(^ORD(100.01,+STS,0)):$P(^(0),"^",1),1:$P(^ORD(100.01,6,0),"^",1)),GMRCCT=GMRCCT+1
 S GMRCA=$P(^GMR(123,+GMRCO,0),"^",13),^TMP("GMRCR",$J,"DT",GMRCCT,0)="Last Action:"_$E(TAB,1,11)_$S(+GMRCA:$P($G(^GMR(123.1,GMRCA,0)),"^",1),1:""),GMRCCT=GMRCCT+1
 I $L($P(GMRCO(0),"^",19)) D
 .S GMRCSF=$P(GMRCO(0),"^",19)
 .S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Significant Findings:  "_$S(GMRCSF="Y":"YES",GMRCSF="N":"NO",1:"Unknown")
 .S GMRCCT=GMRCCT+1
 .Q
 I $G(GMRCIERR) Q  ;don't need results or activities on IFC errors
 D ACTLOG^GMRCSLM4(+GMRCO)
 ; any inter-facility results?
 I $P(GMRCO(0),"^",23) D
 . N GMRCIFRS,X S GMRCIFRS=0,X=""
 . F  S X=$O(^GMR(123,GMRCO,51,"B",X)) Q:X=""  S GMRCIFRS=GMRCIFRS+1
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",GMRCCT=GMRCCT+1
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Inter-facility Results: "_$S(GMRCIFRS>0:"Results are available via Display Results action.",1:"No results available for this consult request."),GMRCCT=GMRCCT+2
 ;get local results
 D GETRSLT^GMRCART($NA(^TMP("GMRCRT",$J)),1)
 N NXT S NXT=0
 F  S NXT=$O(^TMP("GMRCRT",$J,NXT)) Q:'NXT  D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$G(^TMP("GMRCRT",$J,NXT,0))
 . S GMRCCT=GMRCCT+1
 . Q
 K ^TMP("GMRCRT",$J)
 I $S('$D(GMRCOER):1,'GMRCOER:1,1:0),$D(VALMAR) D CLEAN^VALM10
 S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="",$P(^(0),"=",80)="",^(0)=$E(^(0),1,36)_" END "_$E(^(0),43,80)
DTQ K X,LN,PL,TO,WP,FLG,SEX,STS,URG,WRD,BKLN,DATA,WRD,PROC,LINE,GMRCD,GMRCDVDL,GMRCO,GMRCAR,GMRCRB,GMRCLA,GMRCSR,GMRCTO,MCFILE,MCPROC,DSPLINE,GMRCLA1,GMRCPRNM,GMRCPROC,GMRCTYPE,GMRCWARD
 I $D(GMRCOER),'GMRCOER D:$D(VALMEVL) KILL^VALM10() D:$D(VALMAR) CLEAN^VALM10
 Q
PROVDIAG(GMRCDA) ;test all prov diags
 N GMRCD,GMRCCODE,PIECE,FLG,CODINTXT,BUFFER,REPEAT
 S FLG=0
 S REPEAT=22 ;spaces to repeat for formatting
 S GMRCD=$G(^GMR(123,GMRCDA,30))
 S GMRCCODE=$G(^GMR(123,GMRCDA,30.1)),CODINTXT="("_$P(GMRCCODE,U)_")"
 ;icd-9 consults stored code in diagnosis text, icd-10 does not. Strip code from text and append to end for display
 ;desired coding system and code display format (ICD-9-CM 123.45) or (ICD-10-CM S06.4X0S)
 I GMRCD[$G(CODINTXT) D
 .S GMRCD=$E(GMRCD,0,($L(GMRCD)-$L(CODINTXT)))
 I $L($P(GMRCCODE,U))>0 D
 .I $P(GMRCCODE,U,3)="ICD" S GMRCD=GMRCD_"(ICD-9-CM "_$P(GMRCCODE,U)_")"
 .I $P(GMRCCODE,U,3)="10D" S GMRCD=GMRCD_"(ICD-10-CM "_$P(GMRCCODE,U)_")"
 I $L($G(GMRCD))>54 D
 .F  S PIECE=$L(GMRCD) Q:PIECE<54  D  ;$L of GMRCD will change below, so hold original length in PIECE
 .. N SEG,I S I=2
 .. F  S SEG=$P(GMRCD," ",1,I) Q:$L(SEG)>=54!($L(SEG," ")<I)  S I=I+1
 .. I $L(SEG)=$L(GMRCD) S SEG=$E(GMRCD,1,54) ;means GMRCD doesn't contain spaces, e.g. v55,250.00,414.00,etc.
 .. S BUFFER=SEG
 .. S:SEG[" " SEG=$P(GMRCD," ",1,(I-1)) I $L(SEG)=0 S SEG=$E(BUFFER,1,54) ;$P only good when SEG contains a space, otherwise grab a SEG from BUFFER
 .. S:FLG=0 ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Provisional Diagnosis: "_SEG
 .. I FLG=1&($F(GMRCD," ")'=2) S REPEAT=23
 .. S:FLG=1 ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$$REPEAT^XLFSTR(" ",REPEAT)_SEG
 .. S FLG=1,GMRCCT=GMRCCT+1
 .. S GMRCD=$E(GMRCD,$L(SEG)+1,999)
 . I $F(GMRCD," ")'=2 S REPEAT=23
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)=$$REPEAT^XLFSTR(" ",REPEAT)_GMRCD
 . S GMRCCT=GMRCCT+1,GMRCD=""
 I $G(GMRCD)'="" D
 . S ^TMP("GMRCR",$J,"DT",GMRCCT,0)="Provisional Diagnosis: "_GMRCD
 . S GMRCCT=GMRCCT+1
 Q
