PSUPR1 ;BIR/PDW - Data Gathering for PBMS PR file 442 ;12 AUG 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;DBIAs
 ; Reference to file #442    supported by DBIA 1020
 ; Reference to file #445.01 supported by DBIA 1021
 ; Reference to file #420.5  supported by DBIA 1022
 ; Reference to file #410    supported by DBIA 2345,2409
 ; Reference to file #440    supported by DBIA 2606
 ; Reference to file #4.3    supported by DBIA 10091
 ; Reference to file #50     supported by DBIA 221
 ;
EN ;EP Entry Point
 S PSUEDT=PSUEDT\1+.24
 S PSUPRSDT=PSUSDT
 S PSUPREDT=PSUEDT
 ;   setup ^XTMP node
 S:'$D(PSUPRJOB) PSUPRJOB=$J
 S:'$D(PSUPRSUB) PSUPRSUB="PSUPR_"_PSUPRJOB
 I '$D(^XTMP(PSUPRSUB)) D
 . S ^XTMP(PSUPRSUB,"RECORDS",0)=""
 . S X1=DT,X2=6 D C^%DTC
 . S ^XTMP(PSUPRSUB,0)=X_"^"_DT_"^ PBMS Procurement Extraction"
START ;EP
 N PSUDT,PSUDA
 S PSURC=0 ;   record counter
 S PSUDT=PSUPRSDT
 F  S PSUDT=$O(^PRC(442,"AB",PSUDT)) Q:PSUDT'>0  Q:PSUDT>PSUPREDT  D PODATE
 Q
 ;
PODATE ;EP Process a PO DATE
 N PSUPODA
 ;    File 442 can not be linked to division so div=sender
 ;    and indicator = "H"
 S X=$P($G(^XMB(1,1,"XUS")),U,17)
 S PSUDIV=PSUSNDR,PSUDIVI="H"
 ;    Loop POs within date
 S PSUPODA=0
 F  S PSUPODA=$O(^PRC(442,"AB",PSUDT,PSUPODA)) Q:'PSUPODA  D PO
 Q
 ;
PO ;EP Process a PO
 N PSUPO,PSUCC
 S PSUCC=$$VALI^PSUTL(442,PSUPODA,2) ;   cost center
 I PSUCC'=822400,PSUCC'=828100 Q  ; not pharmacy related
 S PSUSS=$$VALI^PSUTL(442,PSUPODA,.5) ;  supply status
 I PSUSS>14,PSUSS<45
 E  Q  ; not within status range
 ;      load po information
 D GETS^PSUTL(442,PSUPODA,".01;.1;1;2;5","PSUPO","I")
 D MOVEI^PSUTL("PSUPO")
 ;
 ;      further process po information
 S PSUPO(5)=$$VALI^PSUTL(440,PSUPO(5),.01) ; Vendor name
 ;
 ;      load item information
 K ^TMP($J,"PSUMIT")
 D GETM^PSUTL(442,PSUPODA,"40*^1;1.5;3;3.1;5;9.3;10;11","^TMP($J,""PSUMIT"")","IN")
 D MOVEMI^PSUTL("^TMP($J,""PSUMIT"")")
 ;
 ;      loop items
 S PSUITDA=0
 F  S PSUITDA=$O(^TMP($J,"PSUMIT",PSUITDA)) Q:PSUITDA'>0  D ITEM
 Q
 ;
ITEM ;EP    Process one item
 N PSUIT,PSUDRDA
 M PSUIT=^TMP($J,"PSUMIT",PSUITDA)
 ;
 ;       Get Drug
 S PSUIT(1.5)=+$G(PSUIT(1.5))
 S PSUDRDA=$O(^PSDRUG("AB",PSUIT(1.5),0))
 N PSUARSUB,PSUARJOB S PSUARSUB=PSUPRSUB,PSUARJOB=PSUPRJOB
 I PSUDRDA D DRUG^PSUAR2(PSUDRDA) ;  setup drug profile
 ;
 ;      process dispense unit 445 & conversion factor   3.2.6.1.5
 S X=+$G(PSUIT(10)),X=+$$VALI^PSUTL(410,X,4)
 ;      disp unit
 S PSUIT("DU")=$$VALI^PSUTL(445.01,"X,PSUIT(1.5)",50)
 ;      disp unit conver factor
 S PSUIT("DUCV")=$$VALI^PSUTL(445.01,"X,PSUIT(1.5)",51)
 ;      unit of purchase
 S PSUIT("UOP")=$$VALI^PSUTL(420.5,+$G(PSUIT(3)),.01)
 ;
 ;      further process fields
 S:'$L($G(PSUIT(9.3))) PSUIT(9.3)="No NDC"
 ;
 ;
REC ;EP Assemble record
 K PSUR
 S PSUG="^XTMP(PSUPRSUB,""PSUDRUG_DET"",PSUDRDA)" ; drug reference
 S PSUR(2)=$G(PSUDIV)
 S PSUR(3)=$G(PSUDIVI)
 S PSUR(4)=$G(PSUPO(.1))
 I PSUDRDA D
 . S PSUR(5)=@PSUG@(21)
 . S PSUR(7)=@PSUG@(.01)
 . S PSUR(12)=@PSUG@(14.5)
 . S PSUR(6)=@PSUG@(2)
 I 'PSUDRDA D
 . S PSUR(5)="Unknown VA Product Name"
 . S PSUR(7)="Unknown Generic Name"
 S PSUR(8)=$G(PSUIT(1,1))_$G(PSUIT(1,2)) S:'$L(PSUR(8)) PSUR(8)="No description listed"
 F  S X=$E(PSUR(8)) Q:X'=" "  S PSUR(8)=$E(PSUR(8),2,999)
 S PSUR(8)=$E(PSUR(8),1,50)
 S PSUR(9)=$G(PSUIT(9.3))
 S PSUR(12)=$G(PSUIT("DU"))
 S PSUR(13)=$G(PSUIT("UOP"))
 S PSUR(14)=$G(PSUIT(3.1))
 S PSUR(15)=PSUIT("DU")
 S PSUR(16)=PSUIT("DUCV")
 S PSUR(17)=$G(PSUIT(11))
 S PSUR(18)=$G(PSUIT(5))
 S PSUR(19)=$G(PSUIT(11))*$G(PSUIT(5))
 S PSUR(20)=PSUPO(5)
 S PSUR(22)=PSUPO(1)
 S PSUR=""
 S I=0 F  S I=$O(PSUR(I)) Q:I'>0  S PSUR(I)=$TR(PSUR(I),"^","'")
 S I=0 F  S I=$O(PSUR(I)) Q:I'>0  S $P(PSUR,"^",I)=PSUR(I)
 S PSUR=PSUR_"^"
 ;   Store Records under PSUSNDR default division
 S PSURC=PSURC+1,^XTMP(PSUPRSUB,"RECORDS",PSUSNDR,PSURC)=$E(PSUR,1,240) I $L(PSUR)>240 S ^(PSURC,1)=$E(PSUR,241,999)
 Q
