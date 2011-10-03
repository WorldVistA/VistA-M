RMPRPFFS ;Hines OIFO/HNC - REMOTE PROCEDURE, LIST NPPD DATA ;9/8/03  07:23
 ;;3.0;PROSTHETICS;**96,60**;Feb 09, 1996;Build 18
 ;
 ;  patch 96 - HNC
 ;        -DBIA #4419 for INSUR^IBBAPI
 ;        -DBIA #3990 for ICDDX^ICDCODE
 ;        -DBIA #1997 for STATCHK^ICPTAPIU
 ;        -DBIA #3823 for read file 355.3, field .04
 ;RESULTS passed to broker in ^TMP($J,
 ;delimited by "^"
 ;piece 1 = ENTRY DATE
 ;piece 2 = PATIENT NAME
 ;piece 3 = PSAS HCPCS with * if hcpcs has Calculation Flag
 ;piece 4 = QTY
 ;piece 5 = Insurance with * if more insurance info available
 ;piece 6 = Insurance Effective Date
 ;piece 7 = TOTAL COST
 ;piece 8 = DESCRIPTION (ITEM, BRIEF DESCRIPTION WITH ~R~ FOR REPAIR)
 ;piece 9 = Coding Errors
 ;piece 10 = Insurance Holder
 ;piece 11 = STATION
 ;piece 12 = ICD9 Description
 ;piece 13 = Billing Group Number
 ;piece 14 = Subscriber ID
 ;piece 15 = SSN
 ;piece 16 = IEN TO FILE 660
 ;piece 17 = HCPCS SHORT DESCRIPTION
 ;piece 18 = ICD9 code
 ;piece 19 = Delivery Date
 ;piece 20 = Expiration Insurance Date
 ;piece 21 = Hcpcs-Icd9 Flag, this routine will set field 4.9 in file 660
 ;all records will have a 1
 ;ICD9, 2
 ;HCPCS, 3
 ;Not Billable 4
 ;
 ;No errors, number 1.
 ;PSAS HCPCS, Not Billable Item, number 14.
 ;ICD9 error, number 12.
 ;HCPCS error, number 13.
 ;Both ICD9 and HCPCS error, number 132.
 ;Both ICD9 error and Not Billable Item, number 142.
 Q
 ;
EN(RESULT,DATE1,DATE2) ;broker entry point
 ;
 K ^TMP($J)
 I '$D(DATE1)!('$D(DATE2)) G EXIT
 S DATE=DATE1-1
 F  S DATE=$O(^RMPR(660,"B",DATE)) Q:(DATE="")!($P(DATE,".",1)>DATE2)  D
 .S RMPRB=0
 .F  S RMPRB=$O(^RMPR(660,"B",DATE,RMPRB)) Q:RMPRB=""  D
 ..Q:$P(^RMPR(660,RMPRB,0),U,15)["*"
 ..Q:$P(^RMPR(660,RMPRB,0),U,14)'["C"
 ..;Q:$P(^RMPR(660,RMPRB,0),U,12)=""
 ..Q:$P($G(^RMPR(660,RMPRB,"AM")),U,3)<2
 ..;end of filter
 ..S PHCPCS=$P($G(^RMPR(660,RMPRB,1)),U,4)
 ..Q:PHCPCS=""
 ..Q:PHCPCS'>0
 ..S HDES=$P(^RMPR(661.1,PHCPCS,0),U,2)
 ..;code set versioning check
 ..S RICP=""
 ..S RICP=$P(^RMPR(661.1,PHCPCS,0),U,1)
 ..S RICPP="",CODERR="Alert",CODEFLG=1
 ..I RICP'="" D
 ...I $A($E(RICP,2,2))>64 S CODERR=" Non Billable Item",CODEFLG=CODEFLG_4 Q
 ...I $A($E(RICP,2,2))<65 S RICPP=$$STATCHK^ICPTAPIU(RICP,$P(^RMPR(660,RMPRB,0),U,1))
 ..I RICPP'="" D
 ...I $P(RICPP,U,1)=0 S CODERR=CODERR_" HCPCS Inactive",CODEFLG=CODEFLG_3
 ..S TYPE=$P($G(^RMPR(660,RMPRB,0)),U,4)
 ..I TYPE'="X" S LINE=$P(^RMPR(661.1,PHCPCS,0),U,7)
 ..I TYPE="X" S LINE=$P(^RMPR(661.1,PHCPCS,0),U,6)
 ..S CAL=$P(^RMPR(661.1,PHCPCS,0),U,8)
 ..I CAL'="" S CAL="*"
 ..S DFN=$P(^RMPR(660,RMPRB,0),U,2)
 ..D DEM^VADPT
 ..D SVC^VADPT
 ..S RMPROEOI=$S(VASV(11)>0:"<!>",VASV(12)>0:"<!>",VASV(13)>0:"<!>",1:0)
 ..S (RMI,HOLDER,SUBID,INSUR,INSURE,INSURG,INSURGG,INICD9D,INICD9E,RMPRDELD,RMPRIND,RMPRDEL)=""
 ..S RMPRDELD=$P(^RMPR(660,RMPRB,0),U,12)
 ..I RMPRDELD'="" S RMPRDEL=$E(RMPRDELD,4,5)_"/"_$E(RMPRDELD,6,7)_"/"_(($E(RMPRDELD,1,3))+1700)
 ..S X=$$INSUR^IBBAPI(DFN,,"RBA",.RMI,"*") I $D(RMI) D
 ...;format the RMI array
 ...;look for primary insurance
 ...;RMI("IBBAPI","INSUR",n,7)=1^PRIMARY
 ...S X="" F  S X=$O(RMI("IBBAPI","INSUR",X)) Q:'X  D
 ....;I $P(RMI("IBBAPI","INSUR",X,7),U,2)'="PRIMARY" Q
 ....S INSUR=$P(RMI("IBBAPI","INSUR",X,1),U,2)
 ....I X>1 S INSUR="*"_INSUR
 ....S SUBID=$P(RMI("IBBAPI","INSUR",X,14),U,1)
 ....S HOLDER=$P(RMI("IBBAPI","INSUR",X,12),U,2)
 ....S RMPRIND=$P(RMI("IBBAPI","INSUR",X,11),U,1)
 ....I RMPRIND'="" S RMPRIND=$E(RMPRIND,4,5)_"/"_$E(RMPRIND,6,7)_"/"_(($E(RMPRIND,1,3))+1700)
 ....S INSURE=$P(RMI("IBBAPI","INSUR",X,10),U,1)
 ....I INSURE'="" S INSURE=$E(INSURE,4,5)_"/"_$E(INSURE,6,7)_"/"_(($E(INSURE,1,3))+1700)
 ....S INSURG=$P(RMI("IBBAPI","INSUR",X,8),U,1)
 ....S INSURGG=$$GET1^DIQ(355.3,INSURG_",",.04)
 ..I '$D(RMI) D
 ...S INSUR="No Insurance Information"
 ...S SUBID=""
 ...S HOLDER=""
 ...S INSURE=""
 ...S INSURGG=""
 ...S RMPRIND=""
 ..;get icd9 data
 ..S INICD9I=$P($G(^RMPR(660,RMPRB,10)),U,8)
 ..I INICD9I'="" D
 ...S INICD9=$$ICDDX^ICDCODE(INICD9I,$P(^RMPR(660,RMPRB,0),U,1))
 ...I INICD9'="" S INICD9E=$P(INICD9,U,2),INICD9D=$P(INICD9,U,4)
 ...I $P(INICD9,U,10)=0 S CODERR=CODERR_" ICD9 Inactive",CODEFLG=CODEFLG_2
 ..D DATA
 S RESULT=$NA(^TMP($J))
 Q
 ;
DATA ;
 S B=RMPRB
 D GETS^DIQ(660,B,".01;.02;2;4.5;5;7;8;8.3;11;12;14;24;27;68","","RMXM")
 S $P(^TMP($J,B),U,1)=$G(RMXM(660,B_",",.01))
 ;Check for OEF/OIF
 I RMPROEOI="<!>" S RMXM(660,B_",",.02)="<!>"_RMXM(660,B_",",.02)
 S $P(^TMP($J,B),U,2)=$G(RMXM(660,B_",",.02))
 S $P(^TMP($J,B),U,3)=$G(RMXM(660,B_",",4.5))_CAL
 S $P(^TMP($J,B),U,4)=$G(RMXM(660,B_",",5))
 ;change to insurance
 I INSUR="" S INSUR="Incomplete Insurance Information"
 S $P(^TMP($J,B),U,5)=INSUR
 ;change to effective insurance date
 S $P(^TMP($J,B),U,6)=INSURE
 S $P(^TMP($J,B),U,7)=$G(RMXM(660,B_",",14))
 ;patch 77 remove the " for Excel CSV
 ;append ~R~ for repair items
 I $G(RMXM(660,B_",",2))="REPAIR" S RMXM(660,B_",",24)="~R~"_RMXM(660,B_",",24)
 S $P(^TMP($J,B),U,8)=$TR($G(RMXM(660,B_",",24)),"""","'")
 ;change to coding errors
 I CODERR="Alert" S CODERR=""
 S $P(^TMP($J,B),U,9)=CODERR
 ;change to holder
 S $P(^TMP($J,B),U,10)=HOLDER
 S $P(^TMP($J,B),U,11)=$G(RMXM(660,B_",",8))
 ;change to ICD9 description
 S $P(^TMP($J,B),U,12)=INICD9D
 ;change to Billing Group
 S $P(^TMP($J,B),U,13)=INSURGG
 ;change to subscriber ID
 S $P(^TMP($J,B),U,14)=SUBID
 S $P(^TMP($J,B),U,15)=$P(VADM(2),U,2)
 S $P(^TMP($J,B),U,16)=B
 S $P(^TMP($J,B),U,17)=HDES
 ;change to ICD9 code
 S $P(^TMP($J,B),U,18)=INICD9E
 ;add Delivery Date
 S $P(^TMP($J,B),U,20)=RMPRDEL
 ;add Insurance Expiration Date
 S $P(^TMP($J,B),U,19)=RMPRIND
 ;hcpcs-icd9 code flag
 S $P(^TMP($J,B),U,21)=CODEFLG
 S $P(^RMPR(660,RMPRB,1),U,11)=CODEFLG
 S $P(^RMPR(660,RMPRB,1),U,12)=DT
 K RMXM,VADM,CAL
 D KVAR^VADPT
 Q
EXIT ;common exit point
 N RESULTS D KILL^XUSCLEAN
 Q
 ;END
