PSOHLDS4 ;BIR/PWC-Build HL7 Segments for Automated Interface ; 2/13/08 3:21pm
 ;;7.0;OUTPATIENT PHARMACY;**156,255,279**;DEC 1997;Build 9
 ;HLFNC       supp. by DBIA 10106
 ;DIC(5       supp. by DBIA 10056
 ;EN^PSNPPIO  supp. by DBIA 3794
 ;This routine is called from PSOHLDS1
 ;
 ;*255 moved tag NTEPMI from PSOHLDS2
 Q
IAM(PSI) ;allergy list segment
 Q:'$D(DFN)!$D(PAS3)
 N IAM,IDX,SEV,SEV1,DAT,X,TYP,TYP1,VER,VER1
 S IAM="",CNT=0,GMRA="0^0^111" D EN1^GMRADPT
 I $G(GMRAL)="" G ZALQT
 F AIEN=0:0 S AIEN=$O(GMRAL(AIEN)) Q:'AIEN  D
 .K ADTL D EN1^GMRAOR2(AIEN,"ADTL") S CNT=CNT+1
 .S TYP1=$P(GMRAL(AIEN),"^",7)
 .S TYP=$S(TYP1="D":"DRUG",TYP1="F":"FOOD",TYP1="O":"OTHER",TYP1="DF":"DRUG/FOOD",TYP1="DO":"DRUG/OTHER",TYP1="DFO":"DRUG/FOOD/OTHER",1:"""""")
 .S VER=$S($P(GMRAL(AIEN),"^",4)=1:"VERIFIED",1:"NON-VERIFIED")
 .S VER1=$S($P(GMRAL(AIEN),"^",4)=1:"C",1:"U")  ;confirmed or unconfirmed
 .S $P(IAM,"|",2)=TYP1_CS_TYP_CS_"LGMR120.8"
 .S $P(IAM,"|",3)=AIEN_CS_$P(GMRAL(AIEN),"^",2)_CS_"LGMR120.8"
 .S IDX=$O(ADTL("O","")),X="" S:IDX'="" X=$G(ADTL("O",IDX))
 .S DAT=$P(X,"^"),DAT=$S(DAT'="":$$HLDATE^HLFNC(DAT,"DT"),1:"")
 .S SEV=$P(X,"^",2) S:SEV="" SEV="""""",DAT=""
 .S SEV1=$S(SEV="MILD":"MI",SEV="MODERATE":"MO",SEV="SEVERE":"SV",1:"U")
 .S $P(IAM,"|",4)=SEV1
 .S $P(IAM,"|",5)=$P($P(GMRAL(AIEN),"^",8),";")
 .S $P(IAM,"|",13)=DAT
 .S $P(IAM,"|",17)=VER1
 .S ^TMP("PSO",$J,PSI)="IAM|"_IAM,PSI=PSI+1
 .F  S IDX=$O(ADTL("O",IDX)) Q:IDX=""  D   ;repeat for all reactions
 ..S X=$G(ADTL("O",IDX)),DAT=$P(X,"^"),SEV=$P(X,"^",2) I SEV="" Q
 ..S DAT=$S(DAT'="":$$HLDATE^HLFNC(DAT,"DT"),1:"")
 ..S $P(IAM,FS,4)=SEV,$P(IAM,FS,13)=DAT
 ..S ^TMP("PSO",$J,PSI)="IAM|"_IAM,PSI=PSI+1
 S PAS3=1
 ;
ZALQT K GMRAL,ADTL,AIEN,CNT,CNT,GMRA,TYP,TYP1,SEV,SEV1,VER,VER1
 Q
 ;
ORC(PSI) ;common order segment
 Q:'$D(DFN)
 N ORC S ORC=""
 S $P(ORC,"|",1)="NW"
 S $P(ORC,"|",2)=IRXN_CS_"OP7.0"
 S $P(ORC,"|",9)=ISDT
 S $P(ORC,"|",10)=EBY_CS_EBY1
 S $P(ORC,"|",12)=PVDR_CS_PVDR1
 S $P(ORC,"|",13)=$G(PSOLAP)
 S $P(ORC,"|",15)=EFDT
 S $P(ORC,"|",16)=$S($G(RXPR(IRXN)):"PARTIAL",$G(RXFL(IRXN)):"REFILL",$G(RXRP(IRXN)):"REPRINT",1:"NEW")
 S $P(ORC,"|",17)=CLN_CS_CLN1_CS_"99PSC"
 S $P(ORC,"|",19)=$S(CSINER'="":CSINER_CS_CSINER1,1:"")
 S $P(ORC,"|",21)=$P(SITE,"^",1)_CS_CS_$P(SITE,"^",6)
 S PSZIP=$P(SITE,"^",5),PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 S $P(ORC,"|",22)=$P(SITE,"^",2)_CS_CS_$P(SITE,"^",7)_CS_$S($D(^DIC(5,+$P(SITE,"^",8),0)):$P(^(0),"^",2),1:"UKN")_CS_PSOHZIP
 S $P(ORC,"|",23)="("_$P(SITE,"^",3)_")"_$P(SITE,"^",4)
 S ^TMP("PSO",$J,PSI)="ORC|"_ORC,PSI=PSI+1
 Q
 ;
NTEPMI(PSI) ;build NTE segment for PMI sheets                   ;*255
 Q:'$D(DFN)  N A,I,PREVLN,CURRLN,PMI,PSNMSG,PSDRUG
 S PSDRUG=+$P(^PSRX(IRXN,0),"^",6),PMI=$$EN^PSNPPIO(PSDRUG,.PSNMSG)
 Q:'$D(^TMP($J,"PSNPMI"))
 ;PSO*7*279 Add missing PMI ID(7) to NTE Segment
 S ^TMP("PSO",$J,PSI)="NTE"_FS_7_FS_FS_^TMP($J,"PSNPMI",0)
 K A S CNT1=1,CNT=0
 F A="W","U","H","S","M","P","I","O","N","D","R" S CNT=CNT+1,A(CNT)=A
 F I=1:1:11 I $D(^TMP($J,"PSNPMI",A(I))) D
 .S CNT=$P(^TMP($J,"PSNPMI",A(I),0),"^",3)
 .S (PREVLN,CURRLN)=""
 .F J=1:1:CNT D
 .. S ^TMP("PSO",$J,PSI,CNT1)=^TMP($J,"PSNPMI",A(I),J,0)
 .. ;PSO*198 check if " " should be inserted
 .. S CURRLN=^TMP("PSO",$J,PSI,CNT1)
 .. S:CNT1>1 PREVLN=$S(CNT>1:^TMP("PSO",$J,PSI,CNT1-1),1:"")
 .. I CNT1>1,$$SPACE^PSOHLDS3(PREVLN,CURRLN) D
 ... S ^TMP("PSO",$J,PSI,CNT1)=" "_^TMP("PSO",$J,PSI,CNT1)
 .. I J=1 S $P(^TMP("PSO",$J,PSI,CNT1),":",1)="\H\"_$P(^TMP("PSO",$J,PSI,CNT1),":",1)_"\N\"
 .. S CNT1=CNT1+1
 S ^TMP("PSO",$J,PSI,CNT1-1)=^TMP("PSO",$J,PSI,CNT1-1)_FS_"Patient Medication Instructions"
 S PSI=PSI+1 K A,I,J,CNT,CNT1,^TMP($J,"PSNPMI")
 Q
