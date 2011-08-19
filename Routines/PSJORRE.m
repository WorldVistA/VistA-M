PSJORRE ;BIR/MV-RETURN INPATIENT ACTIVE MEDS (CONDENSED) ;28 Jan 99 / 12:56 PM
 ;;5.0; INPATIENT MEDICATIONS ;**22,51,50,58,81,110,111,112,134**;16 DEC 97;Build 124
 ;
 ;Reference to ^PS(52.6 is supported by DBIA 1231.
 ;Reference to ^PS(52.7 is supported by DBIA 2173.
 ;Reference to ^PS(55 is supported by DBIA 2191.
 ;Reference to ^TMP("PS" is documented in DBIA #2383.
 ;
OCL(DFN,BDT,EDT,TFN,MVIEW)         ; return condensed list of inpat meds
 ; MVIEW=0   -  This returns the 'unsorted' list as it was returned prior to GUI 27 
 ; MVIEW=1   -  This returns the old sort view of the list, pre-sorted for GUI 27
 ; MVIEW=2   -  This returns new sort view #1 of the order profile for GUI 27 
 ; MVIEW=3   -  This returns new sort view #2 of the order profile for GUI 27
 D @$S($G(MVIEW)=3:"OCL^PSJORRN1(DFN,BDT,EDT,.TFN)",$G(MVIEW)=2:"OCL^PSJORRN(DFN,BDT,EDT,.TFN)",$G(MVIEW)=1:"OCL^PSJORRO(DFN,BDT,EDT,.TFN)",1:"OCL1(DFN,BDT,EDT,TFN)")
 Q
OCL1(DFN,BDT,EDT,TFN,MVIEW) ; Execute this section if MVIEW=0
 N ADM,CNT,DN,DO,F,FON,INFUS,INST,MR,ND,ND0,ND2,ND6,ON,PON,PST,SCH,SIO,STAT,TYPE,UNITS,WBDT,X,Y,PSJCLIN,A
 ; PON=placer order number (oerr), FON=filler order number
 S:BDT="" BDT=DT S WBDT=BDT_".000001"
 S:EDT="" EDT=9999999
 S:EDT'["." EDT=EDT_".999999"
 S F="^PS(55,DFN,5," F  S WBDT=$O(^PS(55,DFN,5,"AUS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,5,"AUS",WBDT,ON)) Q:'ON  D UDTMP
 S F="^PS(53.1," F PST="P","N" F ON=0:0 S ON=$O(^PS(53.1,"AS",PST,DFN,ON)) Q:'ON  S X=$P($G(^PS(53.1,+ON,0)),U,4) D @$S(X="U":"UDTMP",1:"IVTMP")
 S F="^PS(55,"_DFN_",""IV"",",WBDT=BDT F  S WBDT=$O(^PS(55,DFN,"IV","AIS",WBDT)) Q:'WBDT  F ON=0:0 S ON=$O(^PS(55,DFN,"IV","AIS",WBDT,ON)) Q:'ON  D IVTMP
 Q
 ;
UDTMP ;*** Set ^TMP for Unit dose orders.
 N PROVIDER,RNWDT,EDTCMPLX,NDP2 S (MR,SCH,INST,PON)="",FON=+ON_$S(F["53.1":"P",1:"U")
 D TYPE
 S RNWDT=$$LASTREN^PSJLMPRI(DFN,FON) I RNWDT S RNWDT=+RNWDT
 S NDP2=$G(@(F_ON_",.2)")) S EDTCMPLX=$P(NDP2,"^",8)
 S ND2=$G(@(F_ON_",2)")) I 'EDTCMPLX I F'["53.1",($P(ND2,U,2)>EDT) Q
 S ND0=$G(@(F_ON_",0)")) I 'EDTCMPLX I F["53.1",($P(ND0,U,16)>EDT) Q
 S STAT=$$CODES^PSIVUTL($P(ND0,U,9),$S(FON["P":53.1,1:55.06),28)
 S ND6=$P($G(@(F_ON_",6)")),"^"),INST=$G(@(F_+ON_",.3)"))
 S FON=+ON_$S(F["53.1":"P",1:"U"),DO=$P($G(@(F_ON_",.2)")),"^",2)
 D DRGDISP^PSJLMUT1(DFN,FON,40,0,.DN,1)
 S UNITS="" I '$O(@(F_+ON_",1,1)")) S UNITS=$P($G(@(F_+ON_",1,1,0)")),U,2) S:(FON["U")&(UNITS="") UNITS=1
 S:+$P(ND0,U,3) MR=$$MR^PSJORRE1(+$P(ND0,U,3))
 N NOTGIVEN S NOTGIVEN=$S(FON["U":$P($G(^PS(55,DFN,5,+ON,0)),"^",22),1:"")
 S TFN=TFN+1
 S ^TMP("PS",$J,TFN,0)=FON_";I"_U_DN(1)_"^^"_$P(ND2,U,4)_"^^"_DO_U_UNITS_U_$P(ND0,U,21)_U_STAT_U_U_U_U_NOTGIVEN_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))_U_$P(ND2,U,2)_U_$G(RNWDT)
 K ^TMP("PS",$J,TFN,"CLINIC",0) I PSJCLIN]"" S ^TMP("PS",$J,TFN,"CLINIC",0)=PSJCLIN
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",2)
 I PROVIDER S ^TMP("PS",$J,TFN,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PS",$J,TFN,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,TFN,"MDR",1,0)=MR
 S ^TMP("PS",$J,TFN,"SCH",0)=$P(ND2,U)]"" S:$P(ND2,U)]"" ^TMP("PS",$J,TFN,"SCH",1,0)=$P(ND2,U)
 S ^TMP("PS",$J,TFN,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,TFN,"SIG",1,0)=INST
 S ^TMP("PS",$J,TFN,"ADM",0)=$P(ND2,U,5)]"" S:$P(ND2,U,5)]"" ^TMP("PS",$J,TFN,"ADM",1,0)=$P(ND2,U,5)
 S ^TMP("PS",$J,TFN,"SIO",0)=ND6]"" S:ND6]"" ^TMP("PS",$J,TFN,"SIO",1,0)=ND6
 Q
 ;
IVTMP ;*** Set ^TMP for IV orders.
 N PROVIDER,START,STOP,EDTCMPLX,NDP2,IVLIM
 S NDP2=$G(@(F_ON_",.2)")) S EDTCMPLX=$P(NDP2,"^",8)
 S ND0=$G(@(F_ON_",0)")) I 'EDTCMPLX I F'["53.1",($P(ND0,U,2)>EDT) Q
 D TYPE
 S FON=+ON_$S(F["53.1":"P",1:"V"),TFN=TFN+1,CNT=0
 S RNWDT=$$LASTREN^PSJLMPRI(DFN,FON) I RNWDT S RNWDT=+RNWDT
 F X=0:0 S X=$O(@(F_ON_",""AD"","_X_")")) Q:'X  S ND=$G(@(F_ON_",""AD"","_X_",0)")),DN=$P($G(^PS(52.6,+ND,0)),U),Y=DN_U_$P(ND,U,2) S:$P(ND,U,3) Y=Y_U_$P(ND,U,3) S CNT=CNT+1,^TMP("PS",$J,TFN,"A",CNT,0)=Y
 S ^TMP("PS",$J,TFN,"A",0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_ON_",""SOL"","_X_")")) Q:'X  S ND=$G(@(F_ON_",""SOL"","_X_",0)")),DN=$G(^PS(52.7,+ND,0)),CNT=CNT+1,^TMP("PS",$J,TFN,"B",CNT,0)=$P(DN,U)_U_$P(ND,U,2)_U_$P(DN,U,4)
 S ^TMP("PS",$J,TFN,"B",0)=CNT
 S TYPE=$P(ND0,U,4),(MR,SCH,INST,INFUS)=""
 I FON["P" S ND2=$G(^PS(53.1,+ON,2)),SCH=$P(ND2,U),START=$P(ND2,U,2),STOP=$P(ND2,U,4),MR=$P(ND0,U,3),INFUS=$P($G(^PS(53.1,+ON,8)),U,5),STAT=$$CODES^PSIVUTL($P(ND0,U,9),53.1,28),ADM=$P(ND2,U,5),SIO=$P($G(@(F_+ON_",6)")),"^")
 I FON'["P" S START=$P(ND0,U,2),STOP=$P(ND0,U,3),SCH=$P(ND0,U,9),INFUS=$P(ND0,U,8),MR=$P($G(^PS(55,DFN,"IV",+ON,.2)),U,3),STAT=$$CODES^PSIVUTL($P(ND0,U,17),55.01,100),ADM=$P(ND0,U,11),SIO=$P($G(@(F_+ON_",3)")),"^")
 S DN=$G(@(F_+ON_",.2)")),DO=$P(DN,U,2)
 S DN=$S(+$P(DN,U):$$OIDF^PSJLMUT1($P(DN,U)),1:"")
 S:MR MR=$$MR^PSJORRE1(+MR),INST=$G(@(F_+ON_",.3)"))
 S ^TMP("PS",$J,TFN,0)=FON_";I"_U_DN_U_INFUS_U_STOP_"^^"_DO_"^^"_$P(ND0,"^",21)_U_STAT_U_U_U_U_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))_U_START_U_$G(RNWDT)
 K ^TMP("PS",$J,TFN,"CLINIC",0) I PSJCLIN]"" S ^TMP("PS",$J,TFN,"CLINIC",0)=PSJCLIN
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",6)
 I PROVIDER S ^TMP("PS",$J,TFN,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ND2P5=$G(@(F_+ON_",2.5)")) S IVLIM=$P(ND2P5,U,4) I $E(IVLIM)="a" S IVLIM="doses"_$P(IVLIM,"a",2)
 I IVLIM="" S IVLIM=$P(ND2P5,U,2) S:(IVLIM'["d")&(IVLIM'["h") IVLIM=""
 S ^TMP("PS",$J,TFN,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,TFN,"MDR",1,0)=MR
 S ^TMP("PS",$J,TFN,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,TFN,"SIG",1,0)=INST
 S ^TMP("PS",$J,TFN,"SCH",0)=SCH]"" S:SCH]"" ^TMP("PS",$J,TFN,"SCH",1,0)=SCH
 S ^TMP("PS",$J,TFN,"ADM",0)=ADM]"" S:ADM]"" ^TMP("PS",$J,TFN,"ADM",1,0)=ADM
 S ^TMP("PS",$J,TFN,"SIO",0)=SIO]"" S:SIO]"" ^TMP("PS",$J,TFN,"SIO",1,0)=SIO
 I $G(IVLIM)]"" S ^TMP("PS",$J,TFN,"IVLIM",0)=IVLIM
 Q
STAT(Y,X) ;* Return the full status instead of just the code for U/D.
 S X=$P($P(";"_$P(Y,U,3),";"_X_":",2),";")
 Q X
TYPE ;determine if this is an IMO order or not
 S (A,PSJCLIN)="" I F["PS(53.1" S A=$G(^PS(53.1,ON,"DSS"))
 I F["PS(55" S A=$S(F["IV":$G(^PS(55,DFN,"IV",ON,"DSS")),1:$G(^PS(55,DFN,5,ON,8)))
 I $P(A,"^",2)'="" S PSJCLIN=+A
 Q
