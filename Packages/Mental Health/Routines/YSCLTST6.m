YSCLTST6 ;HINOI/RBN-TRANSMISSION CLOZAPINE ORDERS (OUTPATIENT) ;22 March 2020 17:40:02
 ;;5.01;MENTAL HEALTH;**122,154**;Dec 30, 1994;Build 48
 ;
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^PS(52.52 supported by IA #782
 ; Reference to ^PS(55 supported by IA #787
 ;
 ; Build outpatient clozapine data for transmision
 ; called at the top from INTANQ^PSON52
 ; ORDSET called from EOJ^PSONEW
 ;
 N PSOPAT,YSCLCNTR,YSCLDFN,X,X1,X2
 S YSCLRET=""
 S PSOPAT=DFN
 S PSODFN=DFN
 S YSCLCNTR=0
 D XTMPZRO^YSCLTST5  ; update zero node, "CLOZAPINE DAILY ROLLUP DATA"
 S:'$G(^XTMP("YSCLTRN",DT)) ^XTMP("YSCLTRN",DT)=0
 ; Get patient and facility demographic data
 D DMG^YSCLTST5
 D DMG1^YSCLTST5  ; create YSCLDEMO
 D GET^YSCLTST5
 S DFN=PSODFN
 S YSCL1=PSONEW("IRXN")
 S YSCLLD=PSOX("STOP DATE")
 D CHECK
 D LOAD
 D END
 Q
 ;
 ; subroutine modified for patch YS*5.01*154 /hrubovcak
CHECK ;for data to send, build line 1 for ^XTMP("YSCLTRN",dt,dfn,PSOX("LOGIN DATE"))
 K ^TMP($J),^TMP("YSCL",$J) D DEM^VADPT
 ; line is built in YSCLX
 ; patient intials (p1), Patient SSN (p2)
 S YSCLX=$E($P(VADM(1),",",2))_$E(VADM(1)),$P(YSCLX,U,2)=$P(VADM(2),U)
 ; zip code (p6), date received - today (p16), YSCLDEMO from DMG1^YSCLTST5
 S YSCLPHY="",$P(YSCLX,U,6)=$P(YSCLDEMO,U,5),$P(YSCLX,U,16)=DT
 N ARRAY D LIST^DIC(603.01,,1,"I",,,DFN,"C",,,"ARRAY")
 ; registration # (p11)
 S YSCLT=0,$P(YSCLX,U,11)=$G(ARRAY("DILIST","ID",1,.01))
 S YSCLLD=+$$GET1^DIQ(55,DFN,58,"I")  ;/RBN ADDED 04/12/2016
 K PNM,SEX,DOB,AGE,SSN I 'VAERR S PNM=VADM(1),SEX=$P(VADM(5),U),DOB=$P(VADM(3),U),AGE=VADM(4),SSN=$P(VADM(2),U)
 I YSCLLD=0,$$GET1^DIQ(55,DFN,54,"I")="P" Q  ;no transmit for pre-treatment
 S YSCLT=1,YSCLRX=$$GET1^DIQ(52,YSCL1,4,"I")  ; Provider
 S YSCL=$O(YSCLA("")) I 'YSCL D LAB S YSCLT=1
 ; site DEA# (p10), site pointer (p12)
 S YSCLD=+$$GET1^DIQ(52,YSCL1,20,"I"),$P(YSCLX,U,10)=$$GET1^DIQ(59,YSCLD,1),$P(YSCLX,U,12)=$$GET1^DIQ(59,YSCLD,2)
 ;here if active
 S $P(YSCLX,U,5)="A"  ; status (p5)
 ;  Rx count (p13) always 1, issue date (p9)
 S $P(YSCLX,U,13)=1,$P(YSCLX,U,9)=$$GET1^DIQ(52,YSCL1,1,"I")
 K YSCLD1 D GETS^DIQ(52,YSCL1,"301;302;303;304","I","YSCLD1")
 I $D(YSCLD1) N REC D  K YSCLD1 S YSCLD1=REC
 .S REC="" F I=301:1:304 S REC=REC_YSCLD1(52,YSCL1_",",I,"I")_U
 ;/MZR Begin modifications for 'New Order Created by editing'
 I '$D(YSCLD1),$$GET1^DIQ(52,YSCL1,12)["New Order Created by editing Rx # " D
 . N PHRX,PHRX0,ARR,YSCLD2 S PHRX=YSCL1
 . F  Q:$$GET1^DIQ(52,PHRX,12)'["New Order Created by editing Rx # "!$L($$GET1^DIQ(52,PHRX,301))  D
 ..  S PHRX0=+$P($$GET1^DIQ(52,PHRX,12),"Rx # ",2)
 ..  I $L($$GET1^DIQ(52,PHRX0,.01)) S ARR(PHRX0,PHRX)="",PHRX=PHRX0 Q
 . I $L($$GET1^DIQ(52,PHRX,301)) N REC D  K YSCLD1 S YSCLD1=REC
 ..  D GETS^DIQ(52,PHRX,"301;302;303;304","I","YSCLD1")
 ..  S REC="" F I=301:1:304 S REC=REC_YSCLD1(52,PHRX_",",I,"I")_U
 ..  F  S PHRX0=$O(ARR(PHRX,"")) Q:PHRX0=""  D  S PHRX=PHRX0
 ...   S DIE="^PSRX(",DA=PHRX0,DR="" F I=1:1:4 S DR=DR_(300+I)_"////"_$P(REC,U,I)_";"
 ...   D ^DIE
 ;/MZR End modifications for 'New Order Created by editing'
 S $P(YSCLX,U,8)=+YSCLD1  ; dosage (p8)
 ; (#3) APPROVING TEAM MEMBER [4P:200] ^ (#4) REASON FOR OVERRIDE [5P:52.54] ^ (#5) COMMENTS [6F]
 K ARRAY D LIST^DIC(52.52,,"3;4;5","I",,,YSCL1,"A",,,"ARRAY")
 I $D(ARRAY("DILIST","ID",1)) D
 . N CMNT,MMBR,RSN S RSN=$G(ARRAY("DILIST","ID",1,4)) D
 . I RSN=9  D  ; handle PRESCRIBER APPROVED 4 DAY SUPPLY special case
 ..  S CMNT=$G(ARRAY("DILIST","ID",1,5))
 ..  S:CMNT["Weather Related Conditions" RSN=91
 ..  S:CMNT["Mail Order Delay" RSN=92
 ..  S:CMNT["Inpatient Going On Leave" RSN=93
 . ; lockout reason (p14)
 . S $P(YSCLX,U,14)=RSN
 . ; get team member, approving member (p15)
 . S MMBR=+$G(ARRAY("DILIST","ID",1,3)),$P(YSCLX,U,15)=$$GET1^DIQ(200,MMBR,.01)
 ; physician DEA # (p7)
 S YSCLPHY=$$GET1^DIQ(200,+YSCLRX,.01),$P(YSCLX,U,7)=$$GET1^DIQ(200,+YSCLRX,53.2)
 ; WBC result (p4) , WBC test date (p3)
 S $P(YSCLX,U,4)=$P(YSCLD1,U,2),$P(YSCLX,U,3)=$P(YSCLD1,U,3)
 I $P(YSCLD1,U,2)]"",$P(YSCLD1,U,3)'>YSCLED,$P(YSCLD1,U,3)'<YSCLM7 S YSCLWBC=1
 ; add if prescription on same day for different drug and different dose
 S $P(YSCLX,U,21)=$$GET1^DIQ(52,YSCL1,27)  ; Add NDC (National Drug Code) to string (p21)
 ; (#39.3) PLACER ORDER # [2N]
 N PSORD S PSORD=$$GET1^DIQ(52,YSCL1,39.3,"I") S:'PSORD PSORD=YSCL1
 S PSOLOGDT=PSOX("LOGIN DATE")
 S ^XTMP("YSCLTRN",DT,DFN,PSOLOGDT,YSCLCNTR)="0^O^"_PSORD
 S YSCLCNTR=YSCLCNTR+1,^XTMP("YSCLTRN",DT,DFN,PSOLOGDT,YSCLCNTR)=YSCLX
 Q
 ;
ORDSET(PSORD) ; Order # instead of Rx #, called from EOJ^PSONEW
 S $P(^XTMP("YSCLTRN",DT,DFN,PSOLOGDT,0),U,3)=PSORD Q
 ;
 ; subroutine changed for patch YS*5.01*154
LAB ; most recent lab data
 N LBRSLT S LBRSLT=$$CL^YSCLTST2(DFN) D  ; Set pieces 3,4,17,19,20,22,23
 . S $P(YSCLX,U,3)=$P(LBRSLT,U,6)  ; WBC Date (p3)
 . S $P(YSCLX,U,4)=$P(LBRSLT,U,2)  ; WBC Results (p4)
 . S $P(YSCLX,U,17)=1  ; WBC Test Count (p17)
 . S $P(YSCLX,U,19)=$P(LBRSLT,U,6)  ; ANC Date (p19)
 . S $P(YSCLX,U,20)=$P(LBRSLT,U,4)  ; ANC Results (p20)
 . S $P(YSCLX,U,22)=$P(LBRSLT,U,3)  ; WBC Name (p22)
 . S $P(YSCLX,U,23)=$P(LBRSLT,U,5)  ; ANC Name (p23)
 Q
 ;
LOAD ;
 S YSCLNST1=$P($$SITE^VASITE,"^",2),YSCLNSTE=$P($$SITE^VASITE,"^",3)
 ; Retransmission Indicator (p18)
 S YSCLLN=YSCLLN+1,$P(YSCLX,"^",18)=YSCLRET,^TMP($J,YSCLLN,0)=YSCLX,YSCLLN=YSCLLN+1,^TMP($J,YSCLLN,0)=YSCLPHY_"^"_YSCLDEMO_"^"_YSCLNSTE_"^"_YSCLNST1
 S YSCLCNTR=YSCLCNTR+1
 S ^XTMP("YSCLTRN",DT,DFN,PSOX("LOGIN DATE"),YSCLCNTR)=^TMP($J,YSCLLN,0)
 ;site number and name
 S YSCLLLN=YSCLLLN+1,^TMP("YSCL",$J,YSCLLLN,0)=$P(^DPT(DFN,0),"^",9)_"   "_$P(^(0),"^")_"  (R) "_$S($P(YSCLX,"^",13)="":"NO RX   ",1:$$FMTE^XLFDT($P(YSCLX,"^",9),"D"))_" (W) "
 S ^TMP("YSCL",$J,YSCLLLN,0)=^TMP("YSCL",$J,YSCLLLN,0)_$S($P(YSCLX,"^",3)="":"NO WBC   ",1:$$FMTE^XLFDT($P(YSCLX,"^",3),"D"))_" (N) "_$S($P(YSCLX,"^",20)="":"NO NEUT  ",1:$$FMTE^XLFDT($P(YSCLX,"^",19),"D"))
 S YSCLCNTR=YSCLCNTR+1
 S ^XTMP("YSCLTRN",DT,DFN,PSOX("LOGIN DATE"),YSCLCNTR)=^TMP("YSCL",$J,YSCLLLN,0)
 ; Increment counter for date and patient
 S YSCLCNTR=YSCLCNTR+1
 S ^XTMP("YSCLTRN",DT,0)=+$G(^XTMP("YSCLTRN",DT,0))+1
 Q
 ;
END ; Clean up
 K ^TMP("YSCL",$J),^TMP("YSCLL",$J)
 Q
 ;
