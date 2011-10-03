PSBOSF ;BIRMINGHAM/EFC-UNABLE TO SCAN DETAIL REPORT ; 29 Aug 2008  11:33 PM
 ;;3.0;BAR CODE MED ADMIN;**28**;Mar 2004;Build 9
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; ^NURSF(211.4/1409
 ;
EN ; UTS Report Entry Point - Report OPTION used by PSB UNABLE TO SCAN (UTS) key holders.
 N PSBX1,PSBX2,PSBX3,PSBIEN,PSBMRGST,PSBHDR,PSBTOT,PSBDSCN
 N PSBCMNT0,PSBCMNTX,PSBCMTLN,PSBCRLF,PSBI,PSBINDAT,PSBNDENT,PSBMRG,PSBX,I,J
 K PSBSRTBY,PSBSTWD
 ; Set Wards based on selection and user's Division - DUZ(2).
 S PSBSTWD=$P(PSBRPT(.1),U,3) I $G(PSBSTWD)'="" K PSBWARD D LISTWD
 K PSBWDDV D WARDDIV^PSBOST(.PSBWDDV,DUZ(2))
 ; Set Start and End dates/times.
 S PSBDTST=+$P(PSBRPT(.1),U,6)_$P(PSBRPT(.1),U,7)
 S PSBDTSP=+$P(PSBRPT(.1),U,8)_$P(PSBRPT(.1),U,9)
  ; Set the sort options internal values. If no sort option
 ; selected, default to ascending date/time.
 S PSBSRTBY=$G(PSBRPT(.52)) S:$G(PSBSRTBY)="" PSBSRTBY="2,,"
 D NOW^%DTC S Y=% D DD^%DT S PSBDTTM=Y
 ; Kill the scratch sort file.
 K ^XTMP("PSBO",$J,"PSBLIST"),PSBLIST
 S (PSBLNTOT,PSBTOT,PSBX1)="",PSBPGNUM=0
 S PSBX1=$$FMADD^XLFDT(PSBDTST,,,,-.1)
 ; Get the records from the MSF UTS log by date (PSBX1) and IEN (PSBX2).
 F  S PSBX1=$O(^PSB(53.77,"ASFDT",PSBX1)) Q:(PSBX1>PSBDTSP)!(+PSBX1=0)  D
 .S PSBX2="" F  S PSBX2=$O(^PSB(53.77,"ASFDT",PSBX1,PSBX2)) Q:PSBX2=""  D
 ..; Don't report successful scans.
 ..N PSBSCTYP S PSBSCTYP=$P(^PSB(53.77,PSBX2,0),U,5)
 ..; Don't list successful scans.
 ..I "WSCN,WKEY,MSCN,MKEY,MMME"[PSBSCTYP Q
 ..I '$D(^PSB(53.77,PSBX2,0))!($D(PSBLIST(PSBX2))) Q
 ..S PSBWRD=$P($P($G(^PSB(53.77,PSBX2,0)),U,3),"$",1)_"$"
 ..; Filter data by institution.
 ..I '$D(PSBWDDV(PSBWRD)) Q
 ..I $G(PSBSTWD)]"",'$D(PSBWARD(PSBSTWD)) Q
 ..I $G(PSBSTWD)]"",'$D(PSBWARD(PSBSTWD,PSBWRD)) Q
 ..L +^PSB(53.77,PSBX2):3 I  L -^PSB(53.77,PSBX2) S PSBLIST(PSBX2)=""
 S Y=PSBDTST D DD^%DT S Y1=Y S Y=PSBDTSP D DD^%DT S Y2=Y
 ; Create the Sort Option Header text.
 F X=1:1:3 D
 .S PSBHDR=$G(PSBHDR)_$S($P(PSBSRTBY,",",X)=1:"PATIENT'S NAME; ",$P(PSBSRTBY,",",X)=2:"DATE/TIME of UTS (ascending); ",$P(PSBSRTBY,",",X)=3:"LOCATION WARD/RmBd; ",1:"")
 .S PSBHDR=$G(PSBHDR)_$S($P(PSBSRTBY,",",X)=4:"TYPE; ",$P(PSBSRTBY,",",X)=5:"DRUG; ",$P(PSBSRTBY,",",X)=6:"USER'S NAME; ",1:"")
 .S PSBHDR=$G(PSBHDR)_$S($P(PSBSRTBY,",",X)=7:"REASON UNABLE TO SCAN; ",$P(PSBSRTBY,",",X)=-2:"DATE/TIME of UTS (descending); ",1:"")
 .Q
 S PSBHDR=$E(PSBHDR,1,($L(PSBHDR)-2))
 ; Add the record to the scratch sort file.
 D BLDRPT
 I PSBTOT=0 S PSBOUTP(0,14)="W !!,""<<<< NO DOCUMENTED BCMA UNABLE TO SCAN EVENTS FOR THIS DATE RANGE >>>>"",!!"
 ;
 ; Send the report.
 D WRTRPT
 K %,O,PSBBLANK,PSBDTSP,PSBDTST,PSBDTTM
 K PSBFLD,PSBLNO,PSBLNTOT,PSBMORE
 K PSBPG,PSBPGNUM,PSBPGRM,PSBRPT,PSBSFCMT,PSBSFHD2,PSBSRTBY,PSBSRTNM
 K PSBSTWD,PSBCMNT0,PSBTAB0,PSBTAB4,PSBTAB7,PSBTOT1,PSBTOTX,PSBVAL
 K PSBVAL1,PSBVAL2,PSBVAL3,PSBWARD,PSBWRD,PSBXORX,XX,Y1,Y2,YY,ZZ
 Q
 ;
BLDRPT ; Compile the report.
 K PSBOUTP S PSBPGNUM="",PSBX3="" D CREATHDR
 S PSBPGNUM=1,PSBTOT1=0
 I '$D(^XUSEC("PSB UNABLE TO SCAN",DUZ)) D  Q
 .S PSBOUTP(0,14)="W !!,""<<<< BCMA UNABLE TO SCAN REPORTS HAVE RESTRICTED ACCESS >>>>"",!!"
 I '$D(PSBSFHD1) D  Q
 .S PSBOUTP(0,14)="W !!,""<<<< Print format NOT SUPPORTED.  80&132 col formats ARE supported. >>>>"",!!"
 I '$D(PSBLIST) D  Q
 .S PSBOUTP(0,14)="W !!,""<<<< NO DOCUMENTED BCMA UNABLE TO SCAN EVENTS FOR THIS DATE RANGE >>>>"",!!"
 ;
 ; Extract the data for the list of records.
 F  S PSBX3=$O(PSBLIST(PSBX3))  Q:+PSBX3=0  K PSBDATA D
 .;
 .; Patient's Name (VAID)
 .I $P(^PSB(53.77,PSBX3,0),U,2)]"" D
 ..N DFN,VA,VADM S DFN=$P(^PSB(53.77,PSBX3,0),U,2)
 ..D DEM^VADPT,PID^VADPT
 ..S PSBDATA(1)=VADM(1),PSBDATA(1,0)="("_$E(VA("PID"),$L(VA("PID"))-3,999)_")"
 .;
 .; Scan Failure Date/Time
 .S PSBINDAT=$$GET1^DIQ(53.77,PSBX3_",",.04,"I"),Y=PSBINDAT D DD^%DT
 .S PSBDATA(2)=$TR($P(Y,"@")," "),PSBDATA(2,0)="@"_$P(Y,"@",2)
 .;
 .; UTS Location
 .S PSBDATA(3)=$P($$GET1^DIQ(53.77,PSBX3_",",.03),"$"),PSBDATA(3,0)="/"_($P($$GET1^DIQ(53.77,PSBX3_",",.03),"$",2))
 .;
 .; UTS Type - Get the parameter from File #53.69, compare it to the value below,and quit if not compatible.
 .S PSBDATA(4)=$S($E($P($$GET1^DIQ(53.77,PSBX3_",",.05)," "),1)="M":"MED",$E($P($$GET1^DIQ(53.77,PSBX3_",",.05)," "),1)="W":"WRIST")
 .I $P($G(PSBRPT(3)),",",1)=1&(PSBDATA(4)="WRIST") Q
 .I $P($G(PSBRPT(3)),",",1)=2&(PSBDATA(4)="MED") Q
 .;
 .; Drug (IEN)
 .S (PSBDATA(5),PSBDATA(5,0))=""
 .F PSBI=2,3,4 I $D(^PSB(53.77,PSBX3,PSBI,1,0)) S PSBDATA(5,0)="("_$P(^PSB(53.77,PSBX3,PSBI,1,0),U)_")",PSBDATA(5)=$P(^PSB(53.77,PSBX3,PSBI,1,0),U,2) Q
 .I $$GET1^DIQ(53.77,PSBX3_",",13)["WS" S PSBDATA(4,0)="(WS)",PSBDATA(5,0)="("_$$GET1^DIQ(53.77,PSBX3_",",13)_")",PSBDATA(5)=$P(^PSB(53.77,PSBX3,5),U,2)
 .I $$GET1^DIQ(53.77,PSBX3_",",13)]"",$$GET1^DIQ(53.77,PSBX3_",",13)'["WS" D
 ..S PSBDATA(4,0)="(UID)",PSBDATA(5,0)="("_$$GET1^DIQ(53.77,PSBX3_",",13)_")",PSBDATA(5)=$$GET1^DIQ(53.77,PSBX3_",",15)
 .S:PSBDATA(5)="" PSBDATA(5)=" " S:PSBDATA(5,0)="" PSBDATA(5.0)=" "
 .;
 .; User Name
 .S PSBDATA(6)=$$GET1^DIQ(53.77,PSBX3_",",.01)
 .;
 .; UTS Reason - Get the parameter from File #53.69. Quit if defined and '= reason.
 .S PSBDATA(7)=$$GET1^DIQ(53.77,PSBX3_",",.06)
 .I $P($G(PSBRPT(3)),",",2)=1&(PSBDATA(7)'="Damaged Medication Label") Q
 .I $P($G(PSBRPT(3)),",",2)=2&(PSBDATA(7)'="Damaged Wristband") Q
 .I $P($G(PSBRPT(3)),",",2)=3&(PSBDATA(7)'="No Bar Code") Q
 .I $P($G(PSBRPT(3)),",",2)=4&(PSBDATA(7)'="Scanning Equipment Failure") Q
 .I $P($G(PSBRPT(3)),",",2)=5&(PSBDATA(7)'="Unable to Determine") Q
 .I $P($G(PSBRPT(3)),",",2)=6&(PSBDATA(7)'="Dose Discrepancy") Q
 .;
 .; Create sort subscripts.
 .S (PSBDATA(0),PSBIEN)=PSBX3
 .;
SORT     .; Sort the line.
 .; Sort Option internal values:
 .;    1=PATIENT'S NAME
 .;    2=DATE/TIME OF SCAN FAILURE (ascending)
 .;    3=LOCATION WARD/RmBd
 .;    4=TYPE
 .;    5=DRUG
 .;    6=USER'S NAME
 .;    7=UNABLE TO SCAN REASON
 .;   -2=DATE/TIME OF SCAN FAILURE (descending)
 .;
 .; Count how many sort options were selected.
 .F X=0:1:2 Q:$P(PSBSRTBY,",",X+1)=""  S PSBSRTNM=X+1
 .;
 .; Add current line to sort file using the sort option data as the
 .; record's file subscripts. Convert commas in the data to a $ in
 .; case the data (PSBX2) is one of the sort keys.
 .S (PSBX1,PSBX2)="",PSBMRG="^XTMP(""PSBO"",$J,""PSBLIST"""
 .F X=1:1:PSBSRTNM S PSBX1=$P(PSBSRTBY,",",X) Q:PSBX1=""  S PSBDSCN="" D
 ..I PSBX1=2!(PSBX1=-2) S:PSBX1=-2 PSBDSCN="-" S PSBX2=PSBINDAT D
 ...I PSBSRTNM>1,X=1!(X=2) S PSBX2=$P(PSBINDAT,".")
 ...S PSBX2=PSBDSCN_PSBX2
 ..I PSBX1'=2&(PSBX1'=-2) S PSBX2=PSBDATA(PSBX1),PSBX2=$TR(PSBX2,",","$")
 ..S PSBMRG=PSBMRG_","_""""_PSBX2_""""
 .S PSBMRG=PSBMRG_","_PSBIEN_")" M @PSBMRG=PSBDATA
 .S PSBTOT=PSBTOT+1 I +PSBTOT=0 K PSBLIST,^XTMP("PSBO",$J,"PSBLIST")
 ; Retrieve the sorted records.
 ; Set sort file root.
 S PSBMRG="^XTMP(""PSBO"",$J,""PSBLIST"")"
 ; Work through the sort file zero node for each scan event and load the data into
 ; the local array PSBDATA.
 F  S PSBMRG=$Q(@PSBMRG) Q:PSBMRG=""!($P(PSBMRG,",")'["PSBO")!($P(PSBMRG,",",2)'=$J)  D
 .K PSBRPLN,PSBCMNT1,PSBCMNT2,PSBCMNT3 S PSBX1=$P(PSBMRG,",",PSBSRTNM+4)
 .;
 .; Get comment. Skip the comment parsing if no comment.
 .S PSBSFCMT=$G(^PSB(53.77,PSBX1,1)),PSBCMNTX="COMMENT: "_PSBSFCMT,PSBNDENT=" "
 .S $E(PSBCMNT0,PSBTAB7)="|"
 .I PSBCMNTX="COMMENT: " S PSBCMNT1=PSBCMNTX G CONSTR
 .;
 .; Replace any quotes in comment.
 .I $F(PSBCMNTX,"""")>0 S PSBCMNTX=$TR(PSBCMNTX,"""","'")
 .;
 .; # of lines needed to parse comment.
 .S PSBCMTLN=$L(PSBCMNTX)\PSBTAB7+($L(PSBCMNTX)#PSBTAB7>0)
 .;
 .; Parse and wrap the comment by space character. Treat consecutive spaces
 .; as one space. Treat a "!~" sequence as a forced CRLF token from GUI.
 .; PSBTAB7 is the report width based on the user's device.
 .; If "!~" CRLF token sent by GUI, separate the system comment from the user comment.
 .S PSBX=$F(PSBCMNTX,"!~"),PSBCRLF=0 I PSBX>0 S PSBCRLF=1 D
 ..S PSBCMNT1=$E(PSBCMNTX,1,PSBX-3),PSBCMNTX=$E(PSBCMNTX,PSBX,999)
 .;
 .; Wrap the system comment if needed.
 .I PSBCRLF=1,$L(PSBCMNT1)>PSBTAB7 D
 ..S PSBCMNT2=PSBNDENT
 ..F PSBI=1:1:$L(PSBCMNT1," ") I $L($P(PSBCMNT1," ",1,PSBI))>PSBTAB7 D  Q
 ...S PSBCMNT2=PSBCMNT2_$P(PSBCMNT1," ",PSBI,999)
 ...S PSBCMNT1=$P(PSBCMNT1," ",1,PSBI-1)
 ..S PSBCRLF=2
 .;
 .; If no space character in user comment, insert a space in the comment
 .; based on line length in PSBTAB7.
 .I $E(PSBCMNTX,10,999)'[" " S PSBCMNTX=$E(PSBCMNTX,1,PSBTAB7-15)_" "_$E(PSBCMNTX,PSBTAB7-14,999)
 .;
 .; Wrap the comment into multiple lines if needed.
 .S PSBLNO=1+PSBCRLF F PSBI=1:1:$L(PSBCMNTX," ") D
 ..I PSBCRLF,PSBLNO>1,$G(@("PSBCMNT"_PSBLNO))="" S @("PSBCMNT"_PSBLNO)=PSBNDENT
 ..S PSBX=$P(PSBCMNTX," ",PSBI) Q:PSBX=""  ; Don't wrap for contiguous spaces.
 ..D
 ...I $L($G(@("PSBCMNT"_PSBLNO)))+$L(PSBX)'>PSBTAB7 S @("PSBCMNT"_PSBLNO)=$G(@("PSBCMNT"_PSBLNO))_PSBX_" " Q
 ...S PSBLNO=PSBLNO+1,@("PSBCMNT"_PSBLNO)=PSBNDENT_PSBX_" "
 .;
CONSTR   .; Construct output from UTS event record.
 .S PSBTOT1=PSBTOT1+1,PSBTOTX=PSBBLANK,$E(PSBTOTX,0,$L(PSBTOT1_".")-1)=PSBTOT1_"."
 .S PSBXORX=$$GET1^DIQ(53.77,PSBX1_",",.08)
 .I PSBXORX]"" S PSBXORX="ORD#: "_PSBXORX,$E(PSBTOTX,PSBTAB4+2,PSBTAB4+2+($L(PSBXORX)-1))=PSBXORX
 .K PSBDATA M PSBDATA=@($P(PSBMRG,",",1,PSBSRTNM+4)_")")
 .D BUILDLN
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W """_PSBTOTX_""""
 .F I=1:1:10 Q:'$D(PSBRPLN(I))  D
 ..F J=1:1:7 S $E(PSBRPLN(I),@("PSBTAB"_J))="|"
 ..S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBRPLN(I)_""""
 .S $E(PSBCMNT1,PSBTAB7)="|"
 .I $D(PSBCMNT2) S $E(PSBCMNT2,PSBTAB7)="|"
 .I $D(PSBCMNT3) S $E(PSBCMNT3,PSBTAB7)="|"
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBCMNT0_""""
 .S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBCMNT1_""""
 .I $D(PSBCMNT2) S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBCMNT2_""""
 .I $D(PSBCMNT3) S PSBOUTP($$PGTOT,PSBLNTOT)="W !,"""_PSBCMNT3_""""
 .S PSBOUTP($$PGTOT(2),PSBLNTOT)="W !,$TR($J("""",PSBTAB7),"" "",""-""),!"
 .;
 .; Force a skip to the next record's zero node.
 .S $P(PSBMRG,",",PSBSRTNM+5)="999999)"
 ;
 K PSBRPLN,PSBCMNT1,PSBCMNT2,PSBCMNT3
 Q
 ;
BUILDLN  ; Construct records
 K LN,J F PSBFLD=1:1:7 D FORMDAT(PSBFLD) S LN(J)="" K J
 Q
 ;
FORMDAT(FLD) ; Format the data.
 S J=3,PSBVAL=PSBDATA(FLD),PSBVAL(0)="" I $D(PSBDATA(FLD,0)) S PSBVAL(0)=PSBDATA(FLD,0)
 I IOM'>90 S XX=@("PSBTAB"_(FLD-1))+1,YY=(@("PSBTAB"_FLD)-1)-XX,ZZ=PSBVAL_" "_PSBVAL(0) D  Q
 .S O=$$WRAPPER(XX,YY,ZZ)
 I ($L(PSBVAL)+(@("PSBTAB"_(FLD-1))))<(@("PSBTAB"_FLD)-1) D  Q
 .F PSBI=$L(PSBVAL)+(@("PSBTAB"_(FLD-1))):1:(@("PSBTAB"_FLD)-3) S PSBVAL=PSBVAL_" "
 .S $E(PSBRPLN(1),@("PSBTAB"_(FLD-1))+2,(@("PSBTAB"_FLD)-1))=PSBVAL
 .F PSBI=$L(PSBVAL(0))+(@("PSBTAB"_(FLD-1))):1:(@("PSBTAB"_FLD)-3) S PSBVAL(0)=PSBVAL(0)_" "
 .S $E(PSBRPLN(2),@("PSBTAB"_(FLD-1))+2,(@("PSBTAB"_FLD)-1))=PSBVAL(0)
 I ($L(PSBVAL)+(@("PSBTAB"_(FLD-1))))'<(@("PSBTAB"_FLD)-1) D  Q
 .I $F(PSBVAL,",")>1 S PSBVAL1=$E(PSBVAL,1,$F(PSBVAL,",")-1),PSBVAL2=$E(PSBVAL,$F(PSBVAL,","),999)
 .E  S PSBVAL1=$E(PSBVAL,1,$F(PSBVAL," ")-1),PSBVAL2=$E(PSBVAL,$F(PSBVAL," "),999)
 .F PSBI=$L(PSBVAL1)+(@("PSBTAB"_(FLD-1))):1:(@("PSBTAB"_FLD)-3) S PSBVAL1=PSBVAL1_" "
 .I $D(PSBVAL2) I ($L(PSBVAL2)+(@("PSBTAB"_(FLD-1))))'<(@("PSBTAB"_FLD)-1) D
 ..S PSBVAL3=$E(PSBVAL2,$F(PSBVAL2," "),999),PSBVAL2=$E(PSBVAL2,1,$F(PSBVAL2," ")-1)
 ..F PSBI=$L(PSBVAL3)+(@("PSBTAB"_(FLD-1))):1:(@("PSBTAB"_FLD)-3) S PSBVAL3=PSBVAL3_" "
 ..S $E(PSBRPLN(3),@("PSBTAB"_(FLD-1))+2,(@("PSBTAB"_FLD)-1))=PSBVAL3
 .I ($L(PSBVAL1)+(@("PSBTAB"_(FLD-1))))>(@("PSBTAB"_FLD)-2) D
 ..S PSBVAL2=($E(PSBVAL1,(@("PSBTAB"_FLD)-1)-(@("PSBTAB"_(FLD-1))),999))_PSBVAL2
 ..S PSBVAL1=$E(PSBVAL1,1,(((@("PSBTAB"_FLD)-1))-(@("PSBTAB"_(FLD-1))+1)))
 .S $E(PSBRPLN(1),@("PSBTAB"_(FLD-1))+2,(@("PSBTAB"_FLD)-1))=PSBVAL1
 .F PSBI=$L(PSBVAL2)+(@("PSBTAB"_(FLD-1))):1:(@("PSBTAB"_FLD)-3) S PSBVAL2=PSBVAL2_" "
 .S $E(PSBRPLN(2),@("PSBTAB"_(FLD-1))+2,(@("PSBTAB"_FLD)-1))=$E(PSBVAL2,1,((@("PSBTAB"_FLD)-1))-(@("PSBTAB"_(FLD-1))+1))
 .I $E(PSBVAL(0),1)'="" D
 ..F PSBI=$L(PSBVAL(0))+(@("PSBTAB"_(FLD-1))):1:(@("PSBTAB"_FLD)-3) S PSBVAL(0)=PSBVAL(0)_" "
 ..S $E(PSBRPLN(3),@("PSBTAB"_(FLD-1))+2,(@("PSBTAB"_FLD)-1))=PSBVAL(0)
 Q
 ;
WRTRPT   ; Write the report.
 I $O(PSBOUTP(""),-1)<1 D  Q
 .S PSBOUTP(0,14)="W !!,""<<<< NO DOCUMENTED BCMA UNABLE TO SCAN EVENTS FOR THIS DATE RANGE >>>>"",!!"
 .D HDR
 .X PSBOUTP($O(PSBOUTP(""),-1),14)
 .D FTR
 S PSBPGNUM=1
 D HDR
 S PSBX1="" F  S PSBX1=$O(PSBOUTP(PSBX1)) Q:PSBX1=""  D
 .I PSBPGNUM'=PSBX1 D FTR S PSBPGNUM=PSBX1 D HDR
 .S PSBX2="" F  S PSBX2=$O(PSBOUTP(PSBX1,PSBX2)) Q:PSBX2=""  D
 ..X PSBOUTP(PSBX1,PSBX2)
 D FTR
 K ^XTMP("PSBO",$J,"PSBLIST"),PSBOUTP
 Q
 ;
HDR      ; Write the report header.
 I '$D(PSBHDR) S PSBHDR=""
 W:$Y>1 @IOF W:$X>1 !
 S PSBPG="Page: "_PSBPGNUM_" of "_$S($O(PSBOUTP(""),-1)=0:1,1:$O(PSBOUTP(""),-1))
 S PSBPGRM=PSBTAB7-($L(PSBPG))
 I $P(PSBRPT(0),U,4)="" S $P(PSBRPT(0),U,4)=DUZ(2)
 D CREATHDR
 W !!,"BCMA UNABLE TO SCAN (Detailed)" W ?PSBPGRM,PSBPG
 W !!,"Date/Time: "_PSBDTTM,!,"Report Date Range:  Start Date: "_Y1_"   Stop Date: "_Y2
 W !,"Type of Scanning Failure: ",$S(+$P($G(PSBRPT(3)),",",1)=0:"All",+$P($G(PSBRPT(3)),",",1)=1:"Medication",1:"Wristband")
 W !,"Reason: " D
 .I $P($G(PSBRPT(3)),",",2)=0 W "All Reasons" Q
 .I $P($G(PSBRPT(3)),",",2)=1 W "Damaged Medication Label" Q
 .I $P($G(PSBRPT(3)),",",2)=2 W "Damaged Wristband" Q
 .I $P($G(PSBRPT(3)),",",2)=3 W "No Bar Code" Q
 .I $P($G(PSBRPT(3)),",",2)=4 W "Scanning Equipment Failure" Q
 .I $P($G(PSBRPT(3)),",",2)=5 W "Unable to Determine" Q
 .I $P($G(PSBRPT(3)),",",2)=6 W "Dose Discrepancy" Q
 W !,"Division: ",$P($G(^DIC(4,DUZ("2"),0)),U,1)
 W "    Nurse Location: " D
 .I $G(PSBSTWD)]"" W $$NURLOC(PSBSTWD) Q
 .W "All"
 W !,"Sorted By: "_PSBHDR,?(PSBTAB7-($L("Total BCMA Unable to Scan events: "_+PSBTOT))),"Total BCMA Unable to Scan events: "_+PSBTOT
 W !!,$$WRAP^PSBO(5,PSBTAB7-5,"This is a report of documented BCMA ""Unable to Scan"" events within the given date range.")
 W !!,$TR($J("",PSBTAB7)," ","_")
 I $D(PSBSFHD1) W !,PSBSFHD1
 I $D(PSBSFHD2) W !,PSBSFHD2
 W !,$TR($J("",PSBTAB7)," ","="),!
 Q
 ;
FTR      ; Write the report footer.
 I IOSL<100 F  Q:$Y>(IOSL-12)  W !
 W !,$TR($J("",PSBTAB7)," ","=")
 W $$WRAP^PSBO(5,PSBTAB7-5,"Note: IV orders will display the orderable item associated with that IV Order in the Drug column."),!
 W !,PSBDTTM,!,"BCMA UNABLE TO SCAN (Detailed)"
 W ?PSBPGRM,PSBPG,!
 Q
 ;
PGTOT(X) ; Track PAGE Number.
 S:'$D(X) PSBLNTOT=PSBLNTOT+1 S:$D(X) PSBLNTOT=PSBLNTOT+X
 I PSBPGNUM=1,(PSBLNTOT=1) S PSBLNTOT=15 S PSBMORE=PSBLNTOT+7 Q PSBPGNUM
 I PSBLNTOT'<PSBMORE D
 .S PSBMORE=PSBLNTOT+7
 .I PSBMORE>(IOSL-9) S PSBPGNUM=PSBPGNUM+1,PSBLNTOT=15 S PSBMORE=PSBLNTOT+7
 Q PSBPGNUM
 ;
CREATHDR ; Create report header.
 K PSBSFHD1
 I IOM'<122 S PSBSFHD1=$P($T(SFHD132A),";",3),PSBSFHD2=$P($T(SFHD132B),";",3),PSBBLANK=$P($T(SF132BLK),";",3)
 I (IOM'>90),(IOM'<75) S PSBSFHD1=$P($T(SFHD80A),";",3),PSBSFHD2=$P($T(SFHD80B),";",3),PSBBLANK=$P($T(SF80BLK),";",3)
 I '$D(PSBSFHD1) S PSBTAB7=80 Q
 ; reset tabs
 S PSBTAB0=1 F PSBI=0:1:($L(PSBSFHD1,"|")-2) S:PSBI>0 @("PSBTAB"_PSBI)=($F(PSBSFHD1,"|",@("PSBTAB"_(PSBI-1))+1))-1
 Q
 ;
SFHD132A ;;| PATIENT'S NAME  | DATE/TIME |      LOCATION     |       |           DRUG            |                     |   REASON   |
 Q
SFHD132B ;;|     (PID)       |   of UTS  |      WARD/RmBd    | TYPE  |           (ID#)           |      USER'S NAME    |    UTS     |
 Q
SF132BLK ;;                 |           |                   |       |                           |                     |            |
 Q
SF80BLK  ;;           |         |          |       |            |            |        |
 Q
SFHD80A  ;;|PATIENT'S |DATE/TIME| LOCATION |       |   DRUG     |   USER'S   | REASON |
 Q
SFHD80B  ;;|NAME (PID)|  of UTS | WARD/RmBd|  TYPE |   (ID#)    |   NAME     |  UTS   |
 Q
 ;
WRAPPER(X,Y,Z) ; Wrap text line.
 N PSB S J=1
 F  Q:'$L(Z)  D
 .I $L(Z)<Y S $E(PSBRPLN(J),X)=Z S Z="" Q
 .F PSB=Y:-1:0 Q:$E(Z,PSB)=" "
 .S:PSB<1 PSB=Y S $E(PSBRPLN(J),X)=$E(Z,1,PSB)
 .S Z=$E(Z,PSB+1,250),J=J+1
 Q ""
 ;
LISTWD   ; List wards & nursing locations.
 K PSBWARD I $G(PSBSTWD)']"" Q
 N PSBLOOP S PSBLOOP=0
 F  S PSBLOOP=$O(^NURSF(211.4,PSBSTWD,3,PSBLOOP)) Q:PSBLOOP=""  D
 .S PSBWARD(PSBSTWD,$P($G(^NURSF(211.4,PSBSTWD,3,PSBLOOP,0)),U,1))=$P($G(^DIC(42,$P($G(^NURSF(211.4,PSBSTWD,3,PSBLOOP,0)),U,1),0)),U,1)_"$"
 .S PSBWARD(PSBSTWD,$P($G(^DIC(42,$P($G(^NURSF(211.4,PSBSTWD,3,PSBLOOP,0)),U,1),0)),U,1)_"$")=$P($G(^NURSF(211.4,PSBSTWD,3,PSBLOOP,0)),U,1)
 Q
 ;
NURLOC(X) ; Nursing Location Name.
 N PSBNULC S PSBNULC=$G(^NURSF(211.4,X,0)) I PSBNULC="" Q PSBNULC
 S PSBNULC=$P($G(^SC(PSBNULC,0)),U,1)
 Q PSBNULC
