PRCHL4 ;VACO/HNC/VAC - REMOTE PROCEDURE, LIST LOGISTICS DATA FILE 442 ; 4/17/07 3:47pm
 ;;5.1;IFCAP;**103,121**;Oct 20, 2000;Build 2
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;DBIA# 4345 giving permission to reference Prosthetics data
 ;hnc - Aug 21, 2006 add item detail to main grid
 ;VAC - Set limit on 80 po line items
 ;
 ;RESULTS passed to broker in ^TMP($J,
 ;delimited by ^
 ;piece 1 = .1 date; display 2
 ;piece 2 = 91 cost; display 5
 ;piece 3 = 19 agent assigned PO; display 9
 ;piece 4 = primary 2237; display 15
 ;piece 5 = 93 liq amount; display 17
 ;piece 6 = FOB; display 13
 ;piece 7 = 1.4 Appropriation; display 14
 ;piece 8 = 2 cost center; display 8
 ;piece 9 = 5 vendor; display 12
 ;piece 10 = 15 number of line items on po; display 11 
 ;piece 11 = station, derived from PO Number; display 1
 ;piece 12 = 6.4 IEN 442; display 18
 ;piece 13 = .02 method; display 4
 ;piece 14 = .01 purchase order number; display 3
 ;piece 15 = .5 Status; display 6
 ;piece 16 = 1 FCP; display 7
 ;piece 17 =5.4 Ship To; display 10
 ;piece 18 =61 purchase card holder; display 16
 ;piece 19 = Optional Flex Field
 ;piece 20 = Optional Flex Field
 ;piece 21 = Optional Flex Field
EN(RESULT,DATE1,DATE2,FLEXF,FLEX2,FLEX3) ;broker entry point
 ;
 K ^TMP($J)
 I '$D(DATE1)!('$D(DATE2)) G EXIT
 S DATE=DATE1-1
 F  S DATE=$O(^PRC(442,"AB",DATE)) Q:(DATE="")!($P(DATE,".",1)>DATE2)  D
 .S RMPRB=0
 .F  S RMPRB=$O(^PRC(442,"AB",DATE,RMPRB)) Q:RMPRB=""  D
 ..D DATA
 S RESULT=$NA(^TMP($J))
 K DATE,DFN,HDES,LINE,PHCPCS,RMPRB,RMPRFLD,TYPE,PRCHLB
 Q
 ;
DATA ;
 S PRCHLB=RMPRB
 I (FLEXF'="")&(FLEXF'="ITM") S RMPRFLD=".1;91;19;.5;2;20;15;.02;.01;7.2;93;1.4;6.4;5.4;1;61;5;.07;"_FLEXF
 I (FLEXF="")!(FLEXF="ITM") S RMPRFLD=".1;91;19;.5;2;20;15;.02;.01;7.2;93;1.4;6.4;5.4;1;61;5;.07"
 I (FLEX2'="")&(FLEX2'="ITM") S RMPRFLD=RMPRFLD_";"_FLEX2
 I (FLEX3'="")&(FLEX3'="ITM") S RMPRFLD=RMPRFLD_";"_FLEX3
 D GETS^DIQ(442,PRCHLB,RMPRFLD,"","RMXM")
 ;flat data
 S $P(^TMP($J,PRCHLB),U,1)=$G(RMXM(442,PRCHLB_",",.1))
 S $P(^TMP($J,PRCHLB),U,2)=$G(RMXM(442,PRCHLB_",",91))
 S $P(^TMP($J,PRCHLB),U,3)=$G(RMXM(442,PRCHLB_",",19))
 S $P(^TMP($J,PRCHLB),U,4)=$G(RMXM(442,PRCHLB_",",.07))
 S $P(^TMP($J,PRCHLB),U,5)=$G(RMXM(442,PRCHLB_",",93))
 S $P(^TMP($J,PRCHLB),U,6)=PRCHLB
 S $P(^TMP($J,PRCHLB),U,7)=$G(RMXM(442,PRCHLB_",",1.4))
 S $P(^TMP($J,PRCHLB),U,8)=$G(RMXM(442,PRCHLB_",",2))
 S $P(^TMP($J,PRCHLB),U,9)=$G(RMXM(442,PRCHLB_",",5))
 S $P(^TMP($J,PRCHLB),U,10)=$G(RMXM(442,PRCHLB_",",15))
 S $P(^TMP($J,PRCHLB),U,11)=$P($G(RMXM(442,PRCHLB_",",.01)),"-",1)
 S $P(^TMP($J,PRCHLB),U,12)=$G(RMXM(442,PRCHLB_",",6.4))
 S $P(^TMP($J,PRCHLB),U,13)=$G(RMXM(442,PRCHLB_",",.02))
 S $P(^TMP($J,PRCHLB),U,14)=$G(RMXM(442,PRCHLB_",",.01))
 S $P(^TMP($J,PRCHLB),U,15)=$G(RMXM(442,PRCHLB_",",.5))
 S $P(^TMP($J,PRCHLB),U,16)=$G(RMXM(442,PRCHLB_",",1))
 S $P(^TMP($J,PRCHLB),U,17)=$G(RMXM(442,PRCHLB_",",5.4))
 S $P(^TMP($J,PRCHLB),U,18)=$G(RMXM(442,PRCHLB_",",61))
 ;
 I FLEXF'="" S $P(^TMP($J,PRCHLB),U,19)=$G(RMXM(442,PRCHLB_",",FLEXF))
 I FLEXF="" S $P(^TMP($J,PRCHLB),U,19)=""
 I FLEX2'="" S $P(^TMP($J,PRCHLB),U,20)=$G(RMXM(442,PRCHLB_",",FLEX2))
 I FLEX2="" S $P(^TMP($J,PRCHLB),U,20)=""
 I FLEX3'="" S $P(^TMP($J,PRCHLB),U,21)=$G(RMXM(442,PRCHLB_",",FLEX3))
 I FLEX3="" S $P(^TMP($J,PRCHLB),U,21)=""
 ;
 I (FLEXF="ITM")!(FLEX2="ITM")!(FLEX3="ITM") D ITMDET
 K RMXM,PRCHLB
 Q
ITMDET ;item detail
 I PRCHLB="" Q
 S CNT=0
 ;First check number of line items on PO, stop if more than 80
 I $P(^TMP($J,PRCHLB),U,10)>80 S $P(^TMP($J,PRCHLB,1),U,10)="<** More than 80 Line Items **>" Q
 D GETS^DIQ(442,PRCHLB,".01","EN","ITM")
 S PRCHPO=$G(ITM("442",PRCHLB_",",".01","E"))
 S PRCHIEN=""
 I PRCHPO'="" S PRCHIEN=$O(^RMPR(664,"G",$P(PRCHPO,"-",2),PRCHIEN))
 I PRCHIEN'="" D GETS^DIQ(664,PRCHIEN,"2*;11;12","EN","PITMSTR")
 I $D(PITMSTR) D
 .;Prosthetic item
 .S PRCHB="" F  S PRCHB=$O(PITMSTR(664.02,PRCHB)) Q:'PRCHB  D
 .  .S QTY=$G(PITMSTR(664.02,PRCHB,3,"E"))
 .  .S UOP=$G(PITMSTR(664.02,PRCHB,4,"E"))
 .  .S CBOA=$G(PITMSTR(664.02,PRCHB,13,"E"))
 .  .S ITMD=$G(PITMSTR(664.02,PRCHB,1,"E"))
 .  .S AUC=$G(PITMSTR(664.02,PRCHB,6,"E"))
 .  .I AUC="" S AUC=$G(PITMSTR(664.02,PRCHB,2,"E"))
 .  .S HCPCS=$G(PITMSTR(664.02,PRCHB,16,"E"))
 .  .S VSN=$G(PITMSTR(664.02,PRCHB,15.4,"E"))
 .  .S TCST=QTY*AUC
 .  .S CNT=CNT+1
 .  .S $P(^TMP($J,PRCHLB,CNT),U,1)=$G(RMXM(442,PRCHLB_",",.1))
 .  .S $P(^TMP($J,PRCHLB,CNT),U,2)=TCST
 .  .S $P(^TMP($J,PRCHLB,CNT),U,8)=CBOA
 .  .S $P(^TMP($J,PRCHLB,CNT),U,7)=VSN
 .  .S $P(^TMP($J,PRCHLB,CNT),U,11)=$P($G(RMXM(442,PRCHLB_",",.01)),"-",1)
 .  .I HCPCS'="" S $P(^TMP($J,PRCHLB,CNT),U,13)="HCPCS: "_HCPCS
 .  .S $P(^TMP($J,PRCHLB,CNT),U,14)=$G(RMXM(442,PRCHLB_",",.01))_"-P "_CNT
 .  .I FLEXF="ITM" S $P(^TMP($J,PRCHLB,CNT),U,19)=$TR(ITMD,","," ")
 .  .I FLEX2="ITM" S $P(^TMP($J,PRCHLB,CNT),U,20)=$TR(ITMD,","," ")
 .  .I FLEX3="ITM" S $P(^TMP($J,PRCHLB,CNT),U,21)=$TR(ITMD,","," ")
 .;prosthetic shipping
 . S SHIP="",SHIPF=""
 . S SHIP=$G(PITMSTR(664,PRCHIEN_",",11,"E"))
 . S SHIPF=$G(PITMSTR(664,PRCHIEN_",",12,"E"))
 . I SHIPF'="" S SHIP=SHIPF
 . I SHIP'="" D
 .  .S CNT=CNT+1
 .  .S $P(^TMP($J,PRCHLB,CNT),U,2)=SHIP
 .  .S $P(^TMP($J,PRCHLB,CNT),U,1)=$G(RMXM(442,PRCHLB_",",.1))
 .  .S $P(^TMP($J,PRCHLB,CNT),U,11)=$P($G(RMXM(442,PRCHLB_",",.01)),"-",1)
 .  .S $P(^TMP($J,PRCHLB,CNT),U,14)=$G(RMXM(442,PRCHLB_",",.01))_"-P "_CNT
 .  .I FLEXF="ITM" S $P(^TMP($J,PRCHLB,CNT),U,19)="Shipping"
 .  .I FLEX2="ITM" S $P(^TMP($J,PRCHLB,CNT),U,20)="Shipping"
 .  .I FLEX3="ITM" S $P(^TMP($J,PRCHLB,CNT),U,21)="Shipping"
 .;IFCAP item
 S B=0 F  S B=$O(^PRC(442,PRCHLB,2,B)) Q:'B  D
 . S PRCR=$G(^PRC(442,PRCHLB,2,B,0)),PRCR2=$G(^PRC(442,PRCHLB,2,B,2))
 . S IFITM=$P(PRCR,U,5)
 . D GETS^DIQ(441,IFITM,".01;.05;51","E","ITMSTR")
 . S ITMD=$G(ITMSTR(441,IFITM_",",.05,"E"))
 . S IFITM1=$G(ITMSTR(441,IFITM_",",.01,"E"))
 . S NIF=$G(ITMSTR(441,IFITM_",",51,"E"))
 . S LICNT=$P(B,",",1)
 . S QTY=$P(PRCR,U,2)
 . S UOP="" S:$P(PRCR,U,3)'="" UOP=$P($G(^PRCD(420.5,$P(PRCR,U,3),0)),U)
 . S BOC=$P(PRCR,U,4)
 . S CBOA=$P(PRCR2,U,2)
 . S AUC=$TR($P(PRCR,U,9),"$","")
 . S FSC=$P(PRCR2,U,3)
 . S VSN=$P(PRCR,U,6)
 . S UCF=$P(PRCR,U,17)
 . S TCST=$P(PRCR2,U)
 . S ITMDD=$G(^PRC(442,PRCHLB,2,B,1,1,0))
 . I ITMD'="" S ITMD=ITMD_" "
 . S ITMD=ITMD_"1st Line: "_ITMDD
 . K ITMDD
 . S CNT=CNT+1
 . ;S ^TMP($J,PRCHLB,CNT)="I "_LICNT_U_IFITM1_U_QTY_U_UOP_U_BOC_U_CBOA_U_AUC_U_FSC_U_VSN_U_UCF_U_TCST_U_NIF_U_ITMD
 .S $P(^TMP($J,PRCHLB,CNT),U,2)=TCST
 .I FLEXF="ITM" S $P(^TMP($J,PRCHLB,CNT),U,19)=$TR(ITMD,","," ")
 .I FLEX2="ITM" S $P(^TMP($J,PRCHLB,CNT),U,20)=$TR(ITMD,","," ")
 .I FLEX3="ITM" S $P(^TMP($J,PRCHLB,CNT),U,21)=$TR(ITMD,","," ")
 .S $P(^TMP($J,PRCHLB,CNT),U,1)=$G(RMXM(442,PRCHLB_",",.1))
 .S $P(^TMP($J,PRCHLB,CNT),U,8)=BOC
 .S $P(^TMP($J,PRCHLB,CNT),U,9)=VSN
 .S $P(^TMP($J,PRCHLB,CNT),U,11)=$P($G(RMXM(442,PRCHLB_",",.01)),"-",1)
 .I NIF'="" S IFITM1=IFITM1_" NIF: "_NIF
 .I IFITM1'="" S $P(^TMP($J,PRCHLB,CNT),U,13)="Item Master: "_IFITM1
 .S $P(^TMP($J,PRCHLB,CNT),U,14)=$G(RMXM(442,PRCHLB_",",.01))_"-I "_LICNT
 K PRCR,PRCR2,PRCHLB,CNT,ITM,ITMSTR,IFITM,ITMD,IFITM1,LICNT,QTY,UOP,BOC,CBOA,AUC,FSC,VSN,UCF,TCST,NIF,B,PRCHPO,PITMSTR,PRCHB,PRCHIEN,HCPCS,SHIP,SHIPF
 Q
EXIT ;
 Q
 ;END
