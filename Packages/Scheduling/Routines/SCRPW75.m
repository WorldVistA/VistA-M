SCRPW75 ;BP-CIOFO/KEITH,ESW - Clinic Appointment Availability Extract (cont.) ; 5/15/03 3:15pm
 ;;5.3;Scheduling;**206,223,241,249,291**;AUG 13, 1993
 ;
NAVA(SDBDT,SDEDT,SDEX) ;Gather next available appointment wait time information
 ;Input: SDBDT=beginning date
 ;Input: SDEDT=ending date
 ;Input: SDEX='0' for user report, '1' for Austin extract
 ;Output: ^TMP("SDNAVA",$J) array in the format:
 ;        ^TMP("SDNAVA",$J,division)='x'
 ;        ^TMP("SDNAVA",$J,division,credit_pair)='x'
 ;        ^TMP("SDNAVA",$J,division,credit_pair,clinic_ifn)='x'
 ;        ^TMP("SDNAVA",$J,division;credit_pair,clinic_ifn,date_scheduled)='x'
 ;        where 'x' consists of:
 ;        piece 1 = flag '0' appts.
 ;              2 = ave. flag '0' wait time
 ;              3 = flag '1' appts.
 ;              4 = ave. flag '1' wait time
 ;              5 = flag '2' appts.
 ;              6 = ave. flag '2' wait time
 ;              7 = flag '3' appts.
 ;              8 = ave. flag '3' wait time
 ;              9 = follow-up next ava. appts.
 ;             10 = follow-up next ava. wait time
 ;             11 = follow-up non-next ava. appts. <2 days
 ;             12 = follow-up non-next ava. appts. <2 days wait time*
 ;             13 = follow-up non-next ava. appts. 2-7 days
 ;             14 = follow-up non-next ava. appts. 2-7 days wait time*
 ;             15 = follow-up non-next ava. appts. 8-30 days
 ;             16 = follow-up non-next ava. appts. 8-30 days wait time*
 ;             17 = follow-up non-next ava. appts. 31-60 days
 ;             18 = follow-up non-next ava. appts. 31-60 days wait time*
 ;             19 = follow-up non-next ava. appts. >60 days
 ;             20 = follow-up non-next ava. appts. >60 days wait time*
 ;             21 = non-follow-up next ava. appts.
 ;             22 = non-follow-up next ava. wait time
 ;             23 = non-follow-up non-next ava. appts. <2 days
 ;             24 = non-follow-up non-next ava. appts. <2 days wait time*
 ;             25 = non-follow-up non-next ava. appts. <2 days wait time**
 ;             26 = non-follow-up non-next ava. appts. 2-7 days
 ;             27 = non-follow-up non-next ava. appts. 2-7 days wait time*
 ;             28 = non-follow-up non-next ava. appts. 2-7 days wait time**
 ;             29 = non-follow-up non-next ava. appts. 8-30 days
 ;             30 = non-follow-up non-next ava. appts. 8-30 days wait time*
 ;             31 = non-follow-up non-next ava. appts. 8-30 days wait time**
 ;             32 = non-follow-up non-next ava. appts. 31-60 days
 ;             33 = non-follow-up non-next ava. appts. 31-60 days wait time*
 ;             34 = non-follow-up non-next ava. appts. 31-60 days wait time**
 ;             35 = non-follow-up non-next ava. appts. >60 days
 ;             36 = non-follow-up non-next ava. appts. >60 days wait time*
 ;             37 = non-follow-up non-next ava. appts. >60 days wait time**
 ;             38 = percent of non-next ava. appts. within 30 days
 ;             39 = percent of next ava. appts. within 30 days
 ;
 ;      ^TMP("SDNAVB",$J) array in the format:
 ;      ^TMP("SDNAVB",$J,division,credit_pair,clinic_ifn)='y'
 ;      where 'y' consists of: 
 ;      piece 1 = % non-follow-up next ava. appts. within 30 days*
 ;            2 = % non-follow-up next ava. appts. within 30 days**
 ;            3 = % non-follow-up non-next ava. appts. within 30 days*
 ;            4 = % non-follow-up non-next ava. appts. within 30 days**
 ;            5 = sum of squared wait time next ava. appts.**
 ;            6 = sum of squared wait time non-follow-up appts.*
 ;            7 = sum of squared wait time non-follow-up appts.**
 ;            8 = total non-follow-up appointments
 ;
 ;              * desired date to appointment date
 ;             ** transaction date to appointment date         
 ;
 N SDT,SDCT,DFN,SDADT,SDAP,SDAP0,SDWAIT,SDSFU,SDCWT3,SDAVE
 N SDCL,SDFLAG,SDX,SDY,SDZ,SDI,SC0,SDCP,SDSDEV,SDSDDT,SDAVE2
 S SDT=SDBDT-1,(SDOUT,SDCT)=0
 K ^TMP("SDWNAVA",$J),^TMP("SDXNAVA",$J),^TMP("SDYNAVA",$J),^TMP("SDZNAVA",$J),^TMP("SDNAVA",$J),^TMP("SDNAVB",$J)
 ;Iterate through 'date scheduled' xref
 F  S SDT=$O(^DPT("ASADM",SDT)) Q:SDOUT!'SDT!(SDT>SDEDT)  S DFN=0 D
 .F  S DFN=$O(^DPT("ASADM",SDT,DFN)) Q:SDOUT!'DFN  S SDADT=0 D
 ..I $G(SDREPORT(5))=1 I '$D(^TMP("SDIPLST",$J,DFN)) Q  ;only selected patient if (5)
 ..Q:$E($P($G(^DPT(DFN,0)),U,9),1,5)="00000"  ;exclude test patients
 ..F  S SDADT=$O(^DPT("ASADM",SDT,DFN,SDADT)) Q:SDOUT!'SDADT  D
 ...;Check for 'stop task' request
 ...S SDCT=SDCT+1 I SDCT#1000=0 D STOP Q:SDOUT
 ...;Get appointment node
 ...S SDAP0=$G(^DPT(DFN,"S",SDADT,0)) Q:$P(SDAP0,U,19)'=SDT
 ...I '$G(SDREPORT(5)) Q:$P(SDAP0,U,2)="C"!($P(SDAP0,U,2)="CA")   ;quit if cancelled by clinic
 ...S SDCL=+SDAP0 Q:SDCL<1  ;get clinic
 ...;'next ava.' appointment indicator
 ...S SDFLAG=+$P(SDAP0,U,26)
 ...;'date desired' and 'follow up visit' indicator
 ...S SDX=$G(^DPT(DFN,"S",SDADT,1))
 ...S SDSDDT=+$P(SDX,U),SDSFU=$P(SDX,U,2),SDSDEV=""
 ...;Calculate wait time 1 (transaction date to appointment)
 ...S SDWAIT=$S(SDADT<SDT:0,1:$$FMDIFF^XLFDT(SDADT,SDT,1))
 ...;Calculate wait time 2 (date desired to appointment)
 ...S SDCWT3=$$CWT3(SDADT,SDFLAG,SDSDDT,SDSFU,.SDSDEV,.SDX,.SDY,.SDZ)
 ...;Gather patient appointment list information
 ...I $G(SDREPORT(4)),$D(^TMP("SDPLIST",$J,SDCL)) D
 ....N SDPNAME,SDATA,SDSSN
 ....S SDATA=$G(^DPT(DFN,0))
 ....S SDSSN=$P(SDATA,U,9),SDPNAME=$P(SDATA,U) Q:'$L(SDPNAME)
 ....S SDATA=SDSSN_U_$P(SDAP0,U,25)_U_SDFLAG_U_SDSDDT_U_SDSFU_U_SDWAIT_U_SDSDEV
 ....S ^TMP("SDPLIST",$J,SDCL,SDT,SDPNAME,DFN,SDADT)=SDATA
 ....Q
 ...I $G(SDREPORT(5)) I $D(^TMP("SDIPLST",$J,DFN,SDCL)) D GEN5A^SCRPW78(SDAP0,DFN,SDADT,SDCL,SDWAIT,SDT,SDSFU,SDSDEV,SDSDDT,SDFLAG)
 ...;Accrue phase II values ('next ava.' appts.)
 ...S $P(^TMP("SDXNAVA",$J,SDCL),U,((SDFLAG*2)+1))=$P($G(^TMP("SDXNAVA",$J,SDCL)),U,((SDFLAG*2)+1))+1
 ...S $P(^TMP("SDXNAVA",$J,SDCL),U,((SDFLAG*2)+2))=$P(^TMP("SDXNAVA",$J,SDCL),U,((SDFLAG*2)+2))+SDWAIT
 ...I SDWAIT<31 S $P(^TMP("SDXNAVA",$J,SDCL),U,9+(SDFLAG#2))=$P(^TMP("SDXNAVA",$J,SDCL),U,9+(SDFLAG#2))+1
 ...;Accrue sum of squared wait time for standard deviation
 ...I SDFLAG#2 S $P(^TMP("SDWNAVA",$J,SDCL),U,5)=$P($G(^TMP("SDWNAVA",$J,SDCL)),U,5)+(SDWAIT*SDWAIT)
 ...;Accrue phase III values ('date desired' deviation)
 ...I SDCWT3 D
 ....S $P(^TMP("SDYNAVA",$J,SDCL),U,SDX)=$P($G(^TMP("SDYNAVA",$J,SDCL)),U,SDX)+1
 ....S $P(^TMP("SDYNAVA",$J,SDCL),U,SDY)=$P(^TMP("SDYNAVA",$J,SDCL),U,SDY)+SDSDEV
 ....S:SDZ $P(^TMP("SDYNAVA",$J,SDCL),U,SDZ)=$P(^TMP("SDYNAVA",$J,SDCL),U,SDZ)+SDWAIT
 ....;Gather additional information for non-follow-up appointments
 ....I 'SDSFU D
 .....;Accrue next ava. and non-next ava. appts. less than 31 days
 .....N SDP S SDP=$S(SDFLAG#2:1,1:3)
 .....I SDSDEV<31 S $P(^TMP("SDWNAVA",$J,SDCL),U,SDP)=$P($G(^TMP("SDWNAVA",$J,SDCL)),U,SDP)+1
 .....I SDWAIT<31 S $P(^TMP("SDWNAVA",$J,SDCL),U,SDP+1)=$P($G(^TMP("SDWNAVA",$J,SDCL)),U,SDP+1)+1
 .....;Accrue sum of squared wait time for standard deviation
 .....S $P(^TMP("SDWNAVA",$J,SDCL),U,6)=$P($G(^TMP("SDWNAVA",$J,SDCL)),U,6)+(SDSDEV*SDSDEV)
 .....S $P(^TMP("SDWNAVA",$J,SDCL),U,7)=$P(^TMP("SDWNAVA",$J,SDCL),U,7)+(SDWAIT*SDWAIT)
 .....;Total of non-follow-up appointments
 .....S $P(^TMP("SDWNAVA",$J,SDCL),U,8)=$P(^TMP("SDWNAVA",$J,SDCL),U,8)+1
 .....Q
 ....Q
 ...;Accrue values for daily detail
 ...Q:SDEX=1!(SDFMT'="D")
 ...S $P(^TMP("SDXNAVA",$J,SDCL,SDT),U,((SDFLAG*2)+1))=$P($G(^TMP("SDXNAVA",$J,SDCL,SDT)),U,((SDFLAG*2)+1))+1
 ...S $P(^TMP("SDXNAVA",$J,SDCL,SDT),U,((SDFLAG*2)+2))=$P(^TMP("SDXNAVA",$J,SDCL,SDT),U,((SDFLAG*2)+2))+SDWAIT
 ...I SDWAIT<31 S $P(^TMP("SDXNAVA",$J,SDCL,SDT),U,9+(SDFLAG#2))=$P($G(^TMP("SDXNAVA",$J,SDCL,SDT)),U,9+(SDFLAG#2))+1
 ...I SDCWT3 D
 ....S $P(^TMP("SDYNAVA",$J,SDCL,SDT),U,SDX)=$P($G(^TMP("SDYNAVA",$J,SDCL,SDT)),U,SDX)+1
 ....S $P(^TMP("SDYNAVA",$J,SDCL,SDT),U,SDY)=$P(^TMP("SDYNAVA",$J,SDCL,SDT),U,SDY)+SDSDEV
 ....S:SDZ $P(^TMP("SDYNAVA",$J,SDCL,SDT),U,SDZ)=$P(^TMP("SDYNAVA",$J,SDCL,SDT),U,SDZ)+SDWAIT
 ...Q
 ..Q
 .Q
 Q:SDOUT  S SDCL=0
 D ACCRUE^SCRPW77
 Q
 ;
STOP ;Check for stop task request
 S:$D(ZTQUEUED) (SDOUT,ZTSTOP)=$S($$S^%ZTLOAD:1,1:0) Q
 ;
CWT3(SDADT,SDFLAG,SDSDDT,SDSFU,SDSDEV,SDX,SDY,SDZ)      ;Get phase III data
 ;Input: SDADT=appointment date
 ;Input: SDFLAG='next ava.' appointment indicator
 ;Input: SDSDDT=desired date
 ;Input: SDSFU=follow up indicator
 ;Input: SDSDEV=deviation from desired date (pass by reference)
 ;Input: SDX, SDY, SDZ=string locations to update (pass by reference)
 ;Output: '1' if phase III data exists, '0' otherwise
 ;
 N SDDCAT
 I '$L(SDSDDT)!'$L(SDSFU) Q 0  ;no phase III data
 S SDSDEV=$S(SDADT<SDSDDT:0,1:$$FMDIFF^XLFDT(SDADT,SDSDDT,1))  ;wait time
 S SDDCAT=$$DCAT(SDSDEV)  ;date range category
 ;follow-up next ava. appts.
 I SDSFU,SDFLAG#2 S SDX=1,SDY=2,SDZ=0 Q 1
 ;follow-up non-next ava. appts.
 I SDSFU,'(SDFLAG#2) S SDX=SDDCAT*2+1,SDY=SDX+1,SDZ=0 Q 1
 ;non-follow-up next ava. appts.
 I 'SDSFU,SDFLAG#2 S SDX=13,SDY=14,SDZ=0 Q 1
 ;non-follow-up non-next ava. appts.
 I 'SDSFU,'(SDFLAG#2) S SDX=SDDCAT+4*3,SDY=SDX+1,SDZ=SDX+2
 Q 1
 ;
DCAT(SDSDEV)    ;Determine date range category
 ;Input: SDSDEV=wait time
 ;Output: category where '1' = <2 days
 ;                       '2' = 2-7 days
 ;                       '3' = 8-30 days
 ;                       '4' = 31-60 days
 ;                       '5' = >60 days
 ;
 Q:SDSDEV<2 1
 Q:SDSDEV<8 2
 Q:SDSDEV<31 3
 Q:SDSDEV<61 4
 Q 5
