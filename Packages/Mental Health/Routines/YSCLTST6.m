YSCLTST6 ;HINOI/RBN-TRANSMISSION FOR REAL-TIME CLOZAPINE ORDERS (OUTPATIENT ;10 May 2019 12:09:40
 ;;5.01;MENTAL HEALTH;**122**;Dec 30, 1994;Build 112
 ; Reference to $$SITE^VASITE supported by IA #10112
 ; Reference to ^PSRX supported by IA #780
 ; Reference to ^PS(52.52 supported by IA #782
 ; Reference to ^PS(55 supported by IA #787
 ; Reference to ^VA(200 supported by IA #10060
 ; Reference to ^DPT supported by IA #10035
 ; Reference to ^DIC supported by DBIA #2051
 ; Reference to ^DIE supported by DBIA #2053
 ; Reference to ^DIQ supported by DBIA #2056
 ; Reference to ^VADPT supported by DBIA #10061
 ; Reference to ^XLFDT supported by DBIA #10103
 ; Reference to ^%ZTLOAD supported by DBIA #10063
 ; Reference to ^%DTC supported by DBIA #10000
 ;
 ; Build outpatient clozapine data for transmision
 N PSOPAT,PSOIOF,YSCLCNTR,YSCLDFN,YSEND,X,X1,X2
 S YSCLRET=""
 S PSOPAT=DFN
 S PSODFN=DFN
 S PSOIOF=IOF
 S YSCLCNTR=0
 S X1=DT,X2=365 D C^%DTC S YSEND=X
 S $P(^XTMP("YSCLTRN",0),"^",1)=YSEND,$P(^XTMP("YSCLTRN",0),"^",2)=DT ;_"^CLOZAPINE DAILY ROLLUP DATA"
 S:'$G(^XTMP("YSCLTRN",DT)) ^XTMP("YSCLTRN",DT)=0
 ; Get patient and facility demographic data
 D DMG^YSCLTST5
 D DMG1^YSCLTST5
 D GET^YSCLTST5
 S DFN=PSODFN
 S YSCL1=PSONEW("IRXN")
 S YSCLLD=PSOX("STOP DATE")
 D CHECK
 D LOAD
 S IOF=PSOIOF
 D END
 Q
 ;
CHECK ;for data to send
 K ^TMP($J),^TMP("YSCL",$J) D DEM^VADPT
 S YSCLX=$E($P(VADM(1),",",2))_$E(VADM(1))_"^"_$P(VADM(2),"^")
 S YSCLPHY="",$P(YSCLX,"^",6)=$P(YSCLDEMO,"^",5),$P(YSCLX,"^",16)=DT
 N ARRAY D LIST^DIC(603.01,,1,"I",,,DFN,"C",,,"ARRAY")
 S YSCLT=0,$P(YSCLX,"^",11)=$G(ARRAY("DILIST","ID",1,.01))
 S $P(YSSTOP,",",3)=3 Q:$$S^%ZTLOAD
 S YSCLLD=+$$GET1^DIQ(55,DFN,58,"I") ;$P(^PS(55,DFN,"SAND"),U,6) ;/RBN ADDED 04/12/2016
 K PNM,SEX,DOB,AGE,SSN I 'VAERR S PNM=VADM(1),SEX=$P(VADM(5),U),DOB=$P(VADM(3),U),AGE=VADM(4),SSN=$P(VADM(2),U)
 I YSCLLD=0,$$GET1^DIQ(55,DFN,54,"I")="P" Q  ;no transmit for pretreatment
 S YSCLT=1,YSCLRX=$$GET1^DIQ(52,YSCL1,4,"I") ;we've got Provider
 S YSCL=$O(YSCLA("")) I 'YSCL D LAB S YSCLT=1
 S YSCLD=+$$GET1^DIQ(52,YSCL1,20,"I"),$P(YSCLX,"^",10)=$$GET1^DIQ(59,YSCLD,1),$P(YSCLX,"^",12)=$$GET1^DIQ(59,YSCLD,2)
 ;site DEA# (p10), site pointer (p12)
 ;here if active
 S $P(YSCLX,"^",5)="A"  ;,$P(^PS(55,DFN,"SAND"),"^",2)="A" ;force active
 S $P(YSCLX,"^",13)=1,$P(YSCLX,"^",9)=$$GET1^DIQ(52,YSCL1,1,"I")
 K YSCLD1 D GETS^DIQ(52,YSCL1,"301;302;303;304","I","YSCLD1")
 I $D(YSCLD1) N REC D  K YSCLD1 S YSCLD1=REC
 .S REC="" F I=301:1:304 S REC=REC_YSCLD1(52,YSCL1_",",I,"I")_"^"
 ;/MZR Begin modifications for 'New Order Created by editing'
 I '$D(YSCLD1),$$GET1^DIQ(52,YSCL1,12)["New Order Created by editing Rx # " D
 .N PHRX,PHRX0,ARR,YSCLD2 S PHRX=YSCL1
 .F  Q:$$GET1^DIQ(52,PHRX,12)'["New Order Created by editing Rx # "!$L($$GET1^DIQ(52,PHRX,301))  D
 ..S PHRX0=+$P($$GET1^DIQ(52,PHRX,12),"Rx # ",2)
 ..I $L($$GET1^DIQ(52,PHRX0,.01)) S ARR(PHRX0,PHRX)="",PHRX=PHRX0 Q
 .I $L($$GET1^DIQ(52,PHRX,301)) N REC D  K YSCLD1 S YSCLD1=REC
 ..D GETS^DIQ(52,PHRX,"301;302;303;304","I","YSCLD1")
 ..S REC="" F I=301:1:304 S REC=REC_YSCLD1(52,PHRX_",",I,"I")_"^"
 ..F  S PHRX0=$O(ARR(PHRX,"")) Q:PHRX0=""  D  S PHRX=PHRX0
 ...S DIE="^PSRX(",DA=PHRX0,DR="" F I=1:1:4 S DR=DR_(300+I)_"////"_$P(REC,"^",I)_";"
 ...D ^DIE
 ;/MZR End modifications for 'New Order Created by editing'
 S $P(YSCLX,"^",8)=+YSCLD1
 ;status(p5),dosage(p8),rx count(p13),issue date(p9)
 K ARRAY D LIST^DIC(52.52,,"3;4;5","I",,,YSCL1,"A",,,"ARRAY")
 I $D(ARRAY("DILIDT","ID",1)) S $P(YSCLX,"^",14)=$G(ARRAY("DILIST","ID",1,4)) D
 .I ARRAY("DILIST","ID",1,4)=9  D
 ..N YSCLTMP6 S YSCLTMP6=ARRAY("DILIST","ID",1,5)
 ..I YSCLTMP6["Weather Related Conditions" S $P(YSCLX,"^",14)=91
 ..I YSCLTMP6["Mail Order Delay" S $P(YSCLX,"^",14)=92
 ..I YSCLTMP6["Inpatient Going On Leave" S $P(YSCLX,"^",14)=93
 .S YSCLLO=+ARRAY("DILIST","ID",1,3),$P(YSCLX,"^",15)=$$GET1^DIQ(200,YSCLLO,.01)
 ;lockout reason (p14), approving official (p15)
 S $P(YSSTOP,",",4)=4 Q:$$S^%ZTLOAD
 S YSCLPHY=$$GET1^DIQ(200,+YSCLRX,.01),$P(YSCLX,"^",7)=$$GET1^DIQ(200,+YSCLRX,53.2)  ;,YSCLPHY=$P(YSCLPHY,"^")
 S $P(YSCLX,"^",4)=$P(YSCLD1,"^",2),$P(YSCLX,"^",3)=$P(YSCLD1,"^",3) I $P(YSCLD1,"^",2)]"",$P(YSCLD1,"^",3)'>YSCLED,$P(YSCLD1,"^",3)'<YSCLM7 S YSCLWBC=1
 ;wbc(p4),date(p3)
 ; add if prescription on same day for different drug and different dose
 S $P(YSCLX,"^",21)=$$GET1^DIQ(52,YSCL1,27) ;Add NDC to string
 N PSORD S PSORD=$$GET1^DIQ(52,YSCL1,39.3,"I") S:'PSORD PSORD=YSCL1
 S PSOLOGDT=PSOX("LOGIN DATE")
 S ^XTMP("YSCLTRN",DT,DFN,PSOLOGDT,YSCLCNTR)="0^O^"_PSORD
 S YSCLCNTR=YSCLCNTR+1
 S ^XTMP("YSCLTRN",DT,DFN,PSOLOGDT,YSCLCNTR)=YSCLX
 Q
 ;
ORDSET(PSORD) ; Setting and Order # instead of PSRX #
 S $P(^XTMP("YSCLTRN",DT,DFN,PSOLOGDT,0),"^",3)=PSORD
 Q
 ;
LAB ;get most recent
 S $P(YSSTOP,",",5)=5 Q:$$S^%ZTLOAD
 S YSCLLDT="",J=9999998-YSCLED,K=9999998-YSCLM7 I $P(YSCLX,"^",9) S J=9999998-$P(YSCLX,"^",9)
 S YSCLR=$$CL^YSCLTST2(DFN) D  ;Set 3,4,17,19,20,22,23
 . S $P(YSCLX,"^",3)=$P(YSCLR,"^",6)  ;WBC Date
 . S $P(YSCLX,"^",4)=$P(YSCLR,"^",2)  ;WBC Results
 . S $P(YSCLX,"^",19)=$P(YSCLR,"^",6) ;ANC Date
 . S $P(YSCLX,"^",20)=$P(YSCLR,"^",4) ;ANC Results
 . S $P(YSCLX,"^",22)=$P(YSCLR,"^",3) ;WBC Name
 . S $P(YSCLX,"^",23)=$P(YSCLR,"^",5) ;ANC Name
 Q
 ;
LOAD ;
 S $P(YSSTOP,",",6)=6 Q:$$S^%ZTLOAD
 S YSCLNST1=$P($$SITE^VASITE,"^",2),YSCLNSTE=$P($$SITE^VASITE,"^",3)
 S YSCLLN=YSCLLN+1,$P(YSCLX,"^",18)=YSCLRET,^TMP($J,YSCLLN,0)=YSCLX,YSCLLN=YSCLLN+1,^TMP($J,YSCLLN,0)=YSCLPHY_"^"_YSCLDEMO_"^"_YSCLNSTE_"^"_YSCLNST1
 S YSCLCNTR=YSCLCNTR+1
 S ^XTMP("YSCLTRN",DT,DFN,PSOX("LOGIN DATE"),YSCLCNTR)=^TMP($J,YSCLLN,0)
 ;site number and name
 S YSCLLLN=YSCLLLN+1,^TMP("YSCL",$J,YSCLLLN,0)=$P(^DPT(DFN,0),"^",9)_"   "_$P(^(0),"^")_"  (R) "_$S($P(YSCLX,"^",13)="":"NO RX   ",1:$$FMTE^XLFDT($P(YSCLX,"^",9),"D"))_" (W) "
 S ^TMP("YSCL",$J,YSCLLLN,0)=^TMP("YSCL",$J,YSCLLLN,0)_$S($P(YSCLX,"^",3)="":"NO WBC   ",1:$$FMTE^XLFDT($P(YSCLX,"^",3),"D"))_" (N) "_$S($P(YSCLX,"^",20)="":"NO NEUT  ",1:$$FMTE^XLFDT($P(YSCLX,"^",19),"D"))
 S YSCLCNTR=YSCLCNTR+1
 S ^XTMP("YSCLTRN",DT,DFN,PSOX("LOGIN DATE"),YSCLCNTR)=^TMP("YSCL",$J,YSCLLLN,0)
 ; Increment the counter for the date and the given patient
 S YSCLCNTR=YSCLCNTR+1
 S ^XTMP("YSCLTRN",DT,0)=+$G(^XTMP("YSCLTRN",DT,0))+1
 Q
 ;
END ; Clean up
 K ^TMP("YSCL",$J),^TMP("YSCLL",$J)
 Q
 ;
