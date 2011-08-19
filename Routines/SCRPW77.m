SCRPW77 ;BP-CIOFO/KEITH,ESW - Clinic Appointment Availability Extract (cont.) ; 5/28/03 4:49pm
 ;;5.3;Scheduling;**223,241,291**;AUG 13, 1993
 ;
ACCRUE ;Accrue counts and averages to division and division/credit pair totals
 F  S SDCL=$O(^TMP("SDXNAVA",$J,SDCL)) Q:'SDCL  D
 .S SC0=$G(^SC(SDCL,0)) Q:'$L(SC0)  Q:'$$CPAIR^SCRPW71(SC0,.SDCP)
 .S SDIV=$$DIV^SCRPW71(SC0) Q:'$L(SDIV)
 .Q:'$D(^TMP("SD",$J,SDIV,SDCP,SDCL))
 .S:'$D(^TMP("SDNAVA",$J,SDIV,SDCP)) ^TMP("SDNAVA",$J,SDIV,SDCP)=""
 .I SDMD S:'$D(^TMP("SDNAVA",$J,0,SDCP)) ^TMP("SDNAVA",$J,0,SDCP)=""
 .S SDX=$P(^TMP("SDXNAVA",$J,SDCL),U,1,8)
 .S $P(SDX,U,9)=$G(^TMP("SDYNAVA",$J,SDCL))
 .S $P(SDX,U,38)=$P(^TMP("SDXNAVA",$J,SDCL),U,9,10)
 .S SDAVE=$$AVE(SDX),^TMP("SDNAVA",$J,SDIV,SDCP,SDCL)=SDAVE
 .S:$$AVE2(SDCL,.SDAVE2) ^TMP("SDNAVB",$J,SDIV,SDCP,SDCL)=SDAVE2
 .I SDMD S ^TMP("SDNAVA",$J,0,SDCP,SDCL)=SDAVE
 .F SDI=1:1:18 S $P(^TMP("SDNAVA",$J,SDIV),U,SDI)=$P($G(^TMP("SDNAVA",$J,SDIV)),U,SDI)+$P(SDX,U,SDI)
 .F SDI=19:1:39 S $P(^TMP("SDZNAVA",$J,SDIV),U,SDI)=$P($G(^TMP("SDZNAVA",$J,SDIV)),U,SDI)+$P(SDX,U,SDI)
 .I SDMD D
 ..F SDI=1:1:18 S $P(^TMP("SDNAVA",$J,0),U,SDI)=$P($G(^TMP("SDNAVA",$J,0)),U,SDI)+$P(SDX,U,SDI)
 ..F SDI=19:1:39 S $P(^TMP("SDZNAVA",$J,0),U,SDI)=$P($G(^TMP("SDNZAVA",$J,0)),U,SDI)+$P(SDX,U,SDI)
 ..Q
 .F SDI=1:1:18 S $P(^TMP("SDNAVA",$J,SDIV,SDCP),U,SDI)=$P(^TMP("SDNAVA",$J,SDIV,SDCP),U,SDI)+$P(SDX,U,SDI)
 .F SDI=19:1:39 S $P(^TMP("SDZNAVA",$J,SDIV,SDCP),U,SDI)=$P($G(^TMP("SDZNAVA",$J,SDIV,SDCP)),U,SDI)+$P(SDX,U,SDI)
 .I SDMD D
 ..F SDI=1:1:18 S $P(^TMP("SDNAVA",$J,0,SDCP),U,SDI)=$P(^TMP("SDNAVA",$J,0,SDCP),U,SDI)+$P(SDX,U,SDI)
 ..F SDI=19:1:39 S $P(^TMP("SDZNAVA",$J,0,SDCP),U,SDI)=$P($G(^TMP("SDZNAVA",$J,0,SDCP)),U,SDI)+$P(SDX,U,SDI)
 ..Q
 .S SDT=0 F  S SDT=$O(^TMP("SDXNAVA",$J,SDCL,SDT)) Q:SDOUT!'SDT  D
 ..S SDX=$P(^TMP("SDXNAVA",$J,SDCL,SDT),U,1,8)
 ..S $P(SDX,U,9)=$G(^TMP("SDYNAVA",$J,SDCL,SDT))
 ..S $P(SDX,U,38)=$P(^TMP("SDXNAVA",$J,SDCL,SDT),U,9,10)
 ..S ^TMP("SDNAVA",$J,SDIV,SDCP,SDCL,SDT)=$$AVE(SDX)
 ..Q
 .Q
 S SDIV="" F  S SDIV=$O(^TMP("SDNAVA",$J,SDIV)) Q:'$L(SDIV)  D
 .S SDX=^TMP("SDNAVA",$J,SDIV)_U_$P($G(^TMP("SDZNAVA",$J,SDIV)),U,19,39)
 .S ^TMP("SDNAVA",$J,SDIV)=$$AVE(SDX)
 .S SDCP=0 F  S SDCP=$O(^TMP("SDNAVA",$J,SDIV,SDCP)) Q:'SDCP  D
 ..S SDX=^TMP("SDNAVA",$J,SDIV,SDCP)_U_$P($G(^TMP("SDZNAVA",$J,SDIV,SDCP)),U,19,39)
 ..S ^TMP("SDNAVA",$J,SDIV,SDCP)=$$AVE(SDX)
 ..Q
 .Q
 K ^TMP("SDWNAVA",$J),^TMP("SDXNAVA",$J),^TMP("SDYNAVA",$J),^TMP("SDZNAVA",$J)
 Q
 ;
AVE(SDX) ;Calculate averages
 ;Input: SDX=string of appointment totals and total waiting time
 ;Output: string of appointment totals and average waiting time
 N SDI,SDY,SDZ
 F SDI=2:2:22,24:3:36 D
 .S SDY=+$P(SDX,U,(SDI-1)),$P(SDX,U,(SDI-1))=SDY
 .S $P(SDX,U,SDI)=$FN($S(SDY=0:0,1:$P(SDX,U,SDI)/SDY),"",1)
 .Q:SDI<24
 .S $P(SDX,U,SDI+1)=$FN($S(SDY=0:0,1:$P(SDX,U,SDI+1)/SDY),"",1)
 .Q
 S SDY=$P(SDX,U)+$P(SDX,U,5),SDZ=+$P(SDX,U,38)*100
 S $P(SDX,U,38)=$FN($S(SDY=0:0,1:(SDZ/SDY)),"",1)
 S SDY=$P(SDX,U,3)+$P(SDX,U,7),SDZ=+$P(SDX,U,39)*100
 S $P(SDX,U,39)=$FN($S(SDY=0:0,1:(SDZ/SDY)),"",1)
 Q SDX
 ;
AVE2(SDCL,SDAVE2) ;Format additional fields
 ;Input: SDCL=clinic ifn
 ;Input: SDAVE2=variable to return values (pass by reference)
 N SDX,SDY,SDI
 S SDAVE2=$G(^TMP("SDWNAVA",$J,SDCL))
 Q:'$L(SDAVE2) 0
 S SDY=+$P(SDAVE2,U,8)
 F SDI=1:1:4 D
 .S SDX=$P(SDAVE2,U,SDI)*100
 .S $P(SDAVE2,U,SDI)=$FN($S(SDY=0:0,1:(SDX/SDY)),"",1)
 .Q
 Q 1
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
OUT4 ;Output patient list
 N SDY,SDI,SDPNAME,DFN,SDADT
 I '$O(^TMP("SDPLIST",$J,SC,0)) D  Q
 .S SDY="No appointments scheduled during this date range were found."
 .W !!?(IOM-$L(SDY)\2),SDY Q
 S SDI=0 F  S SDI=$O(^TMP("SDPLIST",$J,SC,SDI)) Q:SDOUT!'SDI  D
 .S SDPNAME=""
 .F  S SDPNAME=$O(^TMP("SDPLIST",$J,SC,SDI,SDPNAME)) Q:SDOUT!(SDPNAME="")  D
 ..S DFN=0
 ..F  S DFN=$O(^TMP("SDPLIST",$J,SC,SDI,SDPNAME,DFN)) Q:SDOUT!(DFN="")  D
 ...S SDADT=0
 ...F  S SDADT=$O(^TMP("SDPLIST",$J,SC,SDI,SDPNAME,DFN,SDADT)) Q:SDOUT!'SDADT  D
 ....S SDATA=^TMP("SDPLIST",$J,SC,SDI,SDPNAME,DFN,SDADT)
 ....I 'SDXM,$Y>(IOSL-SDFLEN) D FOOTER(SDREPORT),HDR^SCRPW76(1,SDREPORT,SDIV,SDCP,SC)
 ....Q:SDOUT
 ....W !,$$DTX(SDI),?13,$E(SDPNAME,1,23),?38,$P(SDATA,U)
 ....W ?50,$$DTX(SDADT),?69,$$SRTY($P(SDATA,U,2))
 ....W ?98,$P(SDATA,U,3),?102,$$DTX($P(SDATA,U,4))
 ....W ?115,$S($P(SDATA,U,5)=0:"NO",$P(SDATA,U,5)=1:"YES",1:"")
 ....W ?120,$J($P(SDATA,U,7),5,0),?127,$J($P(SDATA,U,6),5,0)
 ....Q
 ...Q
 ..Q
 .Q
 Q:SDOUT  D FOOTER(SDREPORT)
 Q
OUT5(DFN,SC) ;Output patient list
 N SDY,SDI,SDPNAME,SDADT
 I '$O(^TMP("SDIPLST",$J,DFN,SC,0)) D  Q
 .S SDY="No appointments scheduled during this date range were found."
 .W !!?(IOM-$L(SDY)\2),SDY Q
 S SDI=0 F  S SDI=$O(^TMP("SDIPLST",$J,DFN,SC,SDI)) Q:SDOUT!'SDI  D
 .S SDPNAME=""
 .F  S SDPNAME=$O(^TMP("SDIPLST",$J,DFN,SC,SDI,SDPNAME)) Q:SDOUT!(SDPNAME="")  D
 ..S SDADT=0
 ..F  S SDADT=$O(^TMP("SDIPLST",$J,DFN,SC,SDI,SDPNAME,SDADT)) Q:SDOUT!'SDADT  D
 ...S SDATA=^TMP("SDIPLST",$J,DFN,SC,SDI,SDPNAME,SDADT)
 ...I 'SDXM,$Y>(IOSL-SDFLEN) D FOOTER(SDREPORT),HDR^SCRPW76(1,SDREPORT,SDIV,SDCP,SC)
 ...Q:SDOUT
 ...W !,$$DTXN(SDI),?11,$$SRTY($P(SDATA,U,2)),?31,$$DTXN($P(SDATA,U,4))
 ...W ?42,$$DTXN(SDADT),?52,$J($P(SDATA,U,7),5,0)
 ...W ?59,$J($P(SDATA,U,6),5,0),?69,$P(SDATA,U,3)
 ...W ?73,$S($P(SDATA,U,5)=0:"NO",$P(SDATA,U,5)=1:"YES",1:"")
 ...W ?79,$$DTXN($P(SDATA,U,8)),?96,$P(SDATA,U,9),?102,$P($$DTXN($P(SDATA,U,10)),"@")
 ...I +$P(SDATA,U,11)>0 N SDFN,SDARR,DR,DIQ,DIC,DA D  W ?113,$G(SDARR(SDFN,DA,DR,"I"))
 ....S DR=".01",DIQ="SDARR(",DIQ(0)="I",DIC=200,SDFN=200,DA=$P(SDATA,U,11) D EN^DIQ1
 ...Q
 ..Q
 .Q
 Q:SDOUT  D FOOTER(SDREPORT)
 Q
 ;
SRTY(SDSRTY) ;Externalize scheduling request type
 ;Input: SDSRTY=internal value for request type
 Q:'$L(SDSRTY) ""
 Q:SDSRTY="N" "Next available"
 Q:SDSRTY="C" "Not-next ava-C/R" ;Clinician Request
 Q:SDSRTY="P" "Not-next ava-P/R" ;Patient Request
 Q:SDSRTY="W" "Walk in appoint"
 Q:SDSRTY="M" "Multi booking"
 Q:SDSRTY="A" "Auto rebook"
 Q "Not-next available"
 ;
DTX(Y) ;Externalize date
 X ^DD("DD")
 Q Y
 ;
DTXN(Y) ;External date formated to abbreviate
 I +Y=0 S Y="" Q Y
 X ^DD("DD")
 N SDSTR S Y=$P(Y,",")_","_$E($P(Y,",",2),3,10)
 I $L(Y)#2=0 S Y=$E(Y,1,3)_"  "_$P(Y," ",2)
 Q Y
 ;
FOOTER(SDREPORT)  ;Print footer
 ;Input: SDREPORT=report element to print
 N SDI,SDFL S SDFL=$S(SDREPORT=1:10,SDREPORT=2:8,SDREPORT=5:13,1:9)
 I SDXM D  Q
 .D XMTX^SCRPW73(" ") S SDI=0
 .F  S SDI=$O(SDFOOT(SDREPORT,SDI)) Q:'SDI  D XMTX^SCRPW73(SDFOOT(SDREPORT,SDI))
 .Q
 F SDI=1:1:80 Q:$Y>(IOSL-SDFL)  W !
 S SDI=0
 F  S SDI=$O(SDFOOT(SDREPORT,SDI)) Q:'SDI  W !,SDFOOT(SDREPORT,SDI)
 Q
 ;
FOOT(SDTX) ;Report footer for retrospective report
 ;Input: SDTX=array to return text
 I $G(SDREPORT(1)) D
 .S SDTX(1,1)=SDLINE
 .S SDTX(1,2)="NOTE:  TYPE '0' represents appointments scheduled during the report time frame not indicated by the user or by calculation to be"
 .S SDTX(1,3)="'next available' appointments.  TYPE '1' represents appointments defined by the user as being 'next available' appointments.  TYPE"
 .S SDTX(1,4)="'2' represents appointments calculated to be 'next available' appointments.  TYPE '3' represents appointments indicated both by the"
 .S SDTX(1,5)="user and by calculation to be 'next available' appointments.  WAIT TIME is the average number of days from the date an appointment"
 .S SDTX(1,6)="was scheduled to the date it is to be performed.  The '% NNA' and '% NA' columns reflect percentage of appointments scheduled within"
 .S SDTX(1,7)="30 days for 'non-next available' appointments (types 0 & 2) and 'next available' appointments (types 1 & 3), respectively."
 .S SDTX(1,8)=SDLINE Q
 I $G(SDREPORT(2)) D
 .S SDTX(2,1)=SDLINE
 .S SDTX(2,2)="NOTE:  The date range categories ('0-1', '2-7', '8-30', etc.) are based on the difference between the 'desired date' defined for the"
 .S SDTX(2,3)="appointment and the date the appointment was performed.  'Wait Time' reflects the average of this difference for all appointments in"
 .S SDTX(2,4)="each category.  'Follow up' status is determined by encounter activity to the same DSS ID credit pair as the appointment clinic"
 .S SDTX(2,5)="within the previous 24 months."
 .S SDTX(2,6)=SDLINE Q
 I $G(SDREPORT(3)) D
 .S SDTX(3,1)=SDLINE
 .S SDTX(3,2)="NOTE:  The date range categories ('0-1', '2-7', '8-30', etc.) are based on the difference between the 'desired date' defined for the"
 .S SDTX(3,3)="appointment and the date the appointment was performed.  'Wait Time1' reflects the average difference between the 'desired date' and"
 .S SDTX(3,4)="the date the appointment was performed.  'Wait Time2' reflects the average difference between the transaction date (the date the"
 .S SDTX(3,5)="appointment was entered by the Scheduling package user) and the date the appointment was performed.  'Non-follow up' status is"
 .S SDTX(3,6)="determined by the absence of encounter activity to the same DSS ID credit pair as the appointment clinic in the previous 24 months."
 .S SDTX(3,7)=SDLINE Q
 I $G(SDREPORT(4)) D
 .S SDTX(4,1)=SDLINE
 .S SDTX(4,2)="NOTE:  'Next Ava. Ind.' Values--'0' = not indicated by the user or calculation to be a 'next available' appointment, '1' = defined"
 .S SDTX(4,3)="by the user as a 'next available' appointment, '2' = indicated by calculation to be a 'next available' appointment, '3' = indicated"
 .S SDTX(4,4)="by the user and by calculation to be a 'next available' appointment.  'Wait Time1' = the difference between the 'date desired' and"
 .S SDTX(4,5)="the date of the appointment.  'Wait Time2' = the difference between the 'date scheduled' and the date of the appointment."
 .S SDTX(4,6)=SDLINE Q
 I $G(SDREPORT(5)) D FOOT^SCRPW78(.SDTX,SDLINE) Q
 Q
