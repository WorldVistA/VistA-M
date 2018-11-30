PSDDSOR1 ;BHM/MHA/PWC - Digitally signed CS Orders Report; 08/30/02
 ;;3.0;CONTROLLED SUBSTANCES;**40,67,73**;Feb 13,1997;Build 8
 ;Ref. to ^PSRX( supported by DBIA 1977
 ;Ref. to ^PS(52.41, supported by DBIA 3848
 ;
 Q
PRT I ($Y+13)>IOSL D:AC HD^PSDDSOR D:'AC HD^PSDDSOR2 Q:$D(DIRUT)
 S I=0,PL=""
 I $P($G(Y2),"^")]"" S PL=$E($P(Y2,"^"),1,30)
 E  S PL=$E($P($G(Y6),"^"),1,30),I=1
 W !?1," DRUG"_$S($G(I):" (OI)",1:"")_": "_PL,?50,"CS Federal Schedule: "_+$P(Y2,"^",5)
 F I=1:1 Q:'$G(Y7(I))  W "       ",Y7(I),!
 W !?2,"Provider: "_$E($P(Y4,"^")_P1,1,30),?50,"DEA #: "_$P(Y4,"^",3)
 W !?2,"Clinic: "_$$GET1^DIQ(44,$P(Y0,"^",13),.01),?50,"Detox #: "_$P(Y4,"^",4)
 S PL=$P(Y5,"^"),PL1="" F I=2:1:6 S J=$P(Y5,"^",I) D:J]""
 .I PL1="",$L(J)+$L(PL)<60 S PL=PL_", "_J
 .E  S PL1=PL1_$S(PL1]"":", ",1:"")_J
 W !?2,"Provider Address: "_PL W:PL1]"" !?20,PL1
 W !?2,"CPRS Order #: "_$P(Y0,"^",2),?50,"Date Order Written: " S Y=$P(Y0,"^",5) I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !?2,"Patient Name: "_$E($P(Y1,"^")_P1,1,30),?50,"PATIENT ID: "
 S DFN=$S($P(Y0,"^",12)="R":$P(^PSRX(S5,0),"^",2),1:$P($G(^PS(52.41,S5,0)),"^",2)) D PID^VADPT W $E($P(Y1,"^"))_VA("BID")
 S PL=$P(Y1,"^",2),PL1="" F I=3:1:7 S J=$P(Y1,"^",I) D:J]""
 .I PL1="",$L(J)+$L(PL)<60 S PL=PL_", "_J
 .E  S PL1=PL1_$S(PL1]"":", ",1:"")_J
 W !?2,"Patient Address: "_PL W:PL1]"" !?19,PL1
 W !?2,"Rx #: "_$S($P(Y0,"^",12)="R":$P(^PSRX(S5,0),"^"),1:"")
 W ?50,"Qty: "_$S(AC=4:$P(^PS(52.41,S5,0),"^",10),1:$P(Y2,"^",3))
 W !?2,"SIG: "
 D FSIG($P(Y0,"^",12),S5,75)
 I $G(FSIG(1))'="" D
 . W $$UNESC^ORHLESC($G(FSIG(1)))
 . I $O(FSIG(1)) D
 . . F EE=1:0 S EE=$O(FSIG(EE)) Q:'EE  D
 . . . W !?6,$$UNESC^ORHLESC($G(FSIG(EE)))
 F  S PL=$O(Y3(PL)) Q:'PL  W ?7,Y3(PL),!
P1 S RX2=$S($P(Y0,"^",12)="R":$G(^PSRX(S5,2)),1:"")
 W !?2,"Date Filled: ",$$FMTE^XLFDT($P(RX2,"^",2),2)
 W ?27,"# of Refills: ",$S($P(Y0,"^",12)="R":+$P($G(^PSRX(S5,0)),"^",9),1:$P($G(^PS(52.41,S5,0)),"^",11))
 W ?50,"Date Released: " S Y=$P(RX2,"^",13) I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !?2,"Releasing Pharmacist: "_$S($P(RX2,"^",3):$P(^VA(200,$P(RX2,"^",3),0),"^"),1:"")
 W ?50,"Valid PKI Certificate?: "
 N FL0 S FL0=$S(AC=4:"No",1:"Yes"),Y=$P(RX2,"^",2)
 I $P(Y0,"^",12)="R",AC'=4,$D(^PSRX(S5,"A")) N FL S FL=0 F  S FL=$O(^PSRX(S5,"A",FL)) Q:'FL!(FL0="No")  I $P(^PSRX(S5,"A",FL,0),"^",2)="K" S FL0="No",Y=$P($P(^(0),"^"),".")
 W FL0
 W !?2,"Date Signature Validation Attempted by Pharmacy: "
 I Y W $E(Y,4,5)_"/"_$E(Y,6,7)_"/"_$E(Y,2,3)
 W !?2,"CPRS Nature of Order: "_$P(Y0,"^",3),?50,"Order Status: "_$P($P(Y0,"^",4),";",2)
 S PL=$S($P(Y0,"^",7)]"":$P(Y0,"^",7),$P(Y0,"^"):"Digitally Signed",1:"")
 W !?2,"Signature Status: "_$E(PL,1,60) W:$L(PL)>60 !,?20,$E(PL,61,200) W !
 Q
 ;
GETDATA(Y,ORIEN,DFN) ;Gets data from archival file, otherwise use old CPRS call.
 ;Input: ORIEN  - Order IEN
 ;       DFN    - Patient IEN
 ;Output Y
 ;On error: Y = -1^Error message
 ;Else: Y = 1^ Order # ^ Nature of order ^ Order Status ^ Date Signed
 ;   Y(1) = "Patient name ^ Street1 ^ Street2 ^ Street3 ^ City ^ State ^ Zip"
 ;   Y(2) = "Drug name_strength_dosage form (Dispense drug) ^ Drug IEN (file 50) ^ Drug quantity prescribed ^ Schedule of medication ^5 DEA Schedule"
 ;   Y(3) = "Directions for use (SIG)"
 ;   Y(4) = "Provider's name ^ DUZ ^ Provider's DEA # ^ Provider's DETOX #"
 ;   Y(5) = "SiteName ^ SiteStreet1  ^ SiteStreet2 ^ SiteCity  ^ SiteState ^ SiteZip"
 ;   Y(6) = "Orderable Item ^ Orderable Item IEN (file 50.7)"
 ;   Y(7) = "Strenght ^ Dosage Form
 N TMP,PND0,RX0,DDR
 I $G(ORIEN)="" S Y="-1^INVALID ORDER #" Q
 I $G(DFN)="" S Y="-1^INVALID PATIENT ID" Q
 K ^TMP($J,"ORDEA")
 D ARCHIVE^ORDEA(ORIEN)
 I $D(^TMP($J,"ORDEA",ORIEN,1)),'$P(^(1),"^"),'$G(PND) N NCHK S NCHK=0 D  I 'NCHK S Y="-1^INVALID PRESCRIPTION #" Q
 . S NCHK=$$SUBSCRIB^ORDEA(ORIEN,RX)
 . I NCHK K ^TMP($J,"ORDEA") D ARCHIVE^ORDEA(ORIEN)
 I '$D(^TMP($J,"ORDEA")) D GETDATA^ORWOR1(.Y,ORIEN,DFN) Q
 F I=1:1:5 S TMP(I)=$G(^TMP($J,"ORDEA",ORIEN,I))
 I DFN'=$P(TMP(4),"^",2) S Y="-1^INVALID PATIENT ID" Q
 S RXIEN=$O(^PSRX("APL",ORIEN,"")),RX0=$S(RXIEN:$G(^PSRX(RXIEN,0)),1:""),RXOI=$S(RXIEN:$G(^PSRX(RXIEN,"OR1")),1:"")
 S PIEN=$O(^PS(52.41,"B",ORIEN,"")),PND0=$S(PIEN:$G(^PS(52.41,PIEN,0)),1:"")
 I RXIEN="",PIEN="" S Y="-1^INVALID ORDER #" Q
 I RXIEN'="",RXIEN'=$P(TMP(1),"^") S Y="-1^INVALID PRESCRIPTION #" Q
 I RXIEN,'$P($G(^PSRX(RXIEN,"PKI")),"^") S Y="-1^ORDER HAS NOT BEEN DIGITALLY SIGNED" Q
 I PIEN,'$P(PND0,"^",24) S Y="-1^ORDER HAS NOT BEEN DIGITALLY SIGNED" Q
 S DDR=$P(RX0,"^",6) S:DDR DDR=$$GET1^DIQ(50,DDR,.01)_"^"_DDR
 S STA=$S(RXIEN:$P($G(^PSRX(RXIEN,"STA")),"^")_";"_$$GET1^DIQ(52,RXIEN,100),1:99_";"_$$GET1^DIQ(52.41,PIEN,2))
 S Y="1^"_ORIEN_"^ELECTRONICALLY ENTERED^"_STA_"^"_$P(TMP(1),"^",2)
 S Y(1)=$P(TMP(4),"^")_"^"_TMP(5)
 S Y(2)=$S($P(TMP(1),"^",3)'="":$P(TMP(1),"^",3,4),DDR'="":DDR,1:"^")_"^"_$P(TMP(1),"^",6)_"^^"_$P(TMP(1),"^",5)
 S Y(3)="" M Y(3)=TMP(6)
 S Y(4)=$P(TMP(2),"^",3)_"^"_$P(TMP(2),"^",4)_"^"_$P(TMP(2),"^",1,2)
 S Y(5)=TMP(3)
 S ORI=$S($P(RXOI,"^"):$P(RXOI,"^"),1:$P(PND0,"^",8))
 S ORIE=$S($D(^PS(50.7,ORI,0)):$P(^PS(50.7,ORI,0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^"),1:"")
 S Y(6)=ORIE_"^"_ORI
 S CN=$O(TMP(7,"")) I CN'="" S $P(Y(2),"^")=$P(Y(2),"^")_" "_$TR(TMP(7,CN),"^"," ")
 S Y(7)="" M Y(7)=TMP(7) I CN'="" K Y(7,CN)
 S $P(Y,"^",10)=1
 Q
 ;
FSIG(PSOFILE,PSOINTR,PSOLENTH) ;Format front door sig
 ;PSOFILE is 'P' if in Pending File, 'R' if in Prescription File
 ;PSOINTR is internal number for either file
 ;PSOLENTH is length of each line of the Sig
 ;returned in the FSIG array
 K FSIG I $G(PSOFILE)=""!('$G(PSOINTR))!('$G(PSOLENTH)) G FQUIT
 I PSOFILE'="P",PSOFILE'="R" G FQUIT
 I PSOFILE="P",'$D(^PS(52.41,+PSOINTR,0)) G FQUIT
 I PSOFILE="R",'$D(^PSRX(+PSOINTR,0)) G FQUIT
 I PSOFILE="R",'$P($G(^PSRX(+PSOINTR,"SIG")),"^",2) G FQUIT
 N FFF,NNN,CNT,FVAR,FVAR1,FLIM,HSIG,II
 I PSOFILE="P" F NNN=0:0 S NNN=$O(^PS(52.41,PSOINTR,"SIG",NNN)) Q:'NNN  S:$G(^(NNN,0))'="" HSIG(NNN)=^(0)
 I PSOFILE="P" G:'$O(HSIG(0)) FQUIT G FSTART
 S FFF=1 F NNN=0:0 S NNN=$O(^PSRX(PSOINTR,"SIG1",NNN)) Q:'NNN  I $G(^(NNN,0))'="" S HSIG(FFF)=^(0) S FFF=FFF+1
 G:'$O(HSIG(0)) FQUIT
FSTART S (FVAR,FVAR1)="",II=1
 F FFF=0:0 S FFF=$O(HSIG(FFF)) Q:'FFF  S CNT=0 F NNN=1:1:$L(HSIG(FFF)) I $E(HSIG(FFF),NNN)=" "!($L(HSIG(FFF))=NNN) S CNT=CNT+1 D  I $L(FVAR)>PSOLENTH S FSIG(II)=FLIM_" ",II=II+1,FVAR=FVAR1
 .S FVAR1=$P(HSIG(FFF)," ",(CNT))
 .S FLIM=FVAR
 .S FVAR=$S(FVAR="":FVAR1,1:FVAR_" "_FVAR1)
 I $G(FVAR)'="" S FSIG(II)=FVAR
 I $G(FSIG(1))=""!($G(FSIG(1))=" ") S FSIG(1)=$G(FSIG(2)) K FSIG(2)
FQUIT Q
