PSJORRE1 ;BIR/MV-RETURN INPATIENT ACTIVE MEDS (EXPANDED) ;29 Jan 99 / 8:49 AM
 ;;5.0; INPATIENT MEDICATIONS ;**22,51,50,58,81,91,110,111,134**;16 DEC 97;Build 124
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^TMP("PS" is documented in DBIA #2384.
 ;
OEL(DFN,ON)         ; return list of expanded inpat meds
 K ^TMP("PS",$J)
 N ADM,CNT,DN,DO,F,INFUS,INST,MR,ND,ND0,ND2,ND2P5,ND6,NDOI,SCH,SIO,START,STAT,STOP,TYP,UNITS,X,Y
 S F=$S(ON["P":"^PS(53.1,",ON["U":"^PS(55,DFN,5,",1:"^PS(55,"_DFN_",""IV"",")
 I ON'["P",'$D(@(F_+ON_")")) Q
 I ON["P" S X=$G(^PS(53.1,+ON,0)) Q:$P(X,U,15)'=DFN  S TYP=$P(X,U,4) D @$S(TYP="U":"UDTMP",1:"IVTMP")
 D:ON'["P" @$S(ON["U":"UDTMP",1:"IVTMP")
 S Y=$S(ON["V":5,1:12),CNT=0
 I $O(@(F_+ON_","_Y_",0)")) D
 . F X=0:0 S X=$O(@(F_+ON_","_Y_","_X_")")) Q:'X  D
 ..S CNT=CNT+1,ND=$G(@(F_+ON_","_Y_","_X_",0)")),^TMP("PS",$J,"PC",CNT,0)=ND
 S ^TMP("PS",$J,"PC",0)=CNT
 Q
 ;
UDTMP ;*** Set ^TMP for Unit dose orders.
 N DO,DN,INST,X,Y,PROVIDER,NOTGIVEN,RNWDT
 S (MR,SCH,INST)=""
 S ND2=$G(@(F_+ON_",2)")),ND0=$G(@(F_+ON_",0)"))
 S ND6=$P($G(@(F_+ON_",6)")),"^")
 S RNWDT=$$LASTREN^PSJLMPRI(DFN,ON) I RNWDT S RNWDT=+RNWDT
 S STAT=$$CODES^PSIVUTL($P(ND0,U,9),$S(ON["P":53.1,1:55.06),28)
 S NDOI=$G(@(F_+ON_",.2)")),DO=$P(NDOI,U,2)
 S DN(1)=$$OIDF^PSJLMUT1(NDOI) I DN(1)=""  K DN D DRGDISP^PSJLMUT1(DFN,ON,40,0,.DN,1)
 S UNITS="" I '$O(@(F_+ON_",1,1)")) S UNITS=$P($G(@(F_+ON_",1,1,0)")),U,2) S:(ON["U")&(UNITS="") UNITS=1
 S MR=$$MR(+$P(ND0,U,3)),INST=$G(@(F_+ON_",.3)"))
 S NOTGIVEN=$S(ON["U":$P($G(^PS(55,DFN,5,+ON,0)),"^",22),1:"")
 S ^TMP("PS",$J,0)=DN(1)_"^^"_$P(ND2,U,4)_"^^"_$P(ND2,U,2)_U_STAT_"^^^"_DO_U_UNITS_U_$P(ND0,U,21)_U_U_NOTGIVEN_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))_U_U_$G(RNWDT)
 S PROVIDER=$P($G(@(F_+ON_",0)")),"^",2)
 I PROVIDER S ^TMP("PS",$J,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PS",$J,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,"MDR",1,0)=MR
 S ^TMP("PS",$J,"SCH",0)=$P(ND2,U)]"" S:$P(ND2,U)]"" ^TMP("PS",$J,"SCH",1,0)=$P(ND2,U)
 S:$P(ND0,U,7)]"" ^TMP("PS",$J,"SCH",0)=1,$P(^TMP("PS",$J,"SCH",1,0),U,2)=$$GTSCHT($P(ND0,U,7))_"^"_$P(ND0,U,7)
 S ^TMP("PS",$J,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,"SIG",1,0)=INST
 S ^TMP("PS",$J,"ADM",0)=$P(ND2,U,5)]"" S:$P(ND2,U,5)]"" ^TMP("PS",$J,"ADM",1,0)=$P(ND2,U,5)
 S ^TMP("PS",$J,"SIO",0)=ND6]"" S:ND6]"" ^TMP("PS",$J,"SIO",1,0)=ND6
 NEW VERPHARM S:ON["U" VERPHARM=$P($G(@(F_+ON_",4)")),U,3)
 S:+$G(VERPHARM) $P(^TMP("PS",$J,"RXN",0),U,5)=VERPHARM
 NEW PSJDD,INACTDT,NDDD,OUTOI,PSJOUT S CNT=0
 F PSJDD=0:0 S PSJDD=$O(@(F_+ON_",1,PSJDD)")) Q:'PSJDD  D
 . S NDDD=@(F_+ON_",1,PSJDD,0)")
 . I $P(NDDD,U,3)]"",($P(NDDD,U,3)'>DT) Q
 . S PSJOUT=$P($G(^PSDRUG(+NDDD,8)),U,5)
 . I +PSJOUT D
 .. S INACTDT=$G(^PSDRUG(+PSJOUT,"I")),OUTOI=+$G(^PSDRUG(+PSJOUT,2))
 .. I INACTDT]"",(INACTDT'>DT) S (PSJOUT,OUTOI)=""
 . I '+PSJOUT,($P($G(^PSDRUG(+NDDD,2)),U,3)["O") D
 .. S PSJOUT=+NDDD,OUTOI=+NDOI
 .. S INACTDT=$G(^PSDRUG(+NDDD,"I"))
 .. I INACTDT]"",(INACTDT'>DT) S (PSJOUT,OUTOI)=""
 . S UNITS=$P(NDDD,U,2) S:(ON["U")&(UNITS="") UNITS=1
 . S CNT=CNT+1,^TMP("PS",$J,"DD",CNT,0)=+NDDD_U_UNITS_U_PSJOUT_U_$G(OUTOI)
 S ^TMP("PS",$J,"DD",0)=CNT
 Q
 ;
IVTMP ;*** Set ^TMP for IV orders.
 N PROVIDER,RNWDT,IVLIM S ND0=$G(@(F_+ON_",0)")),CNT=0
 F X=0:0 S X=$O(@(F_+ON_",""AD"","_X_")")) Q:'X  S ND=$G(@(F_+ON_",""AD"","_X_",0)")),DN=$P($G(^PS(52.6,+ND,0)),U),Y=DN_U_$P(ND,U,2) S:$P(ND,U,3) Y=Y_U_$P(ND,U,3) S CNT=CNT+1,^TMP("PS",$J,"A",CNT,0)=Y
 S RNWDT=$$LASTREN^PSJLMPRI(DFN,ON) I RNWDT S RNWDT=+RNWDT
 S ^TMP("PS",$J,"A",0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_+ON_",""SOL"","_X_")")) Q:'X  S ND=$G(@(F_+ON_",""SOL"","_X_",0)")),DN=$G(^PS(52.7,+ND,0)),CNT=CNT+1,^TMP("PS",$J,"B",CNT,0)=$P(DN,U)_U_$P(ND,U,2)_U_$P(DN,U,4)
 S ^TMP("PS",$J,"B",0)=CNT
 S INST=$G(@(F_+ON_",.3)"))
 I ON["P" D
 . S SCH=$P($G(^PS(53.1,+ON,2)),U)
 . S PROVIDER=$P(ND0,U,2)
 . S MR=$$MR(+$P(ND0,U,3)),STAT=$$CODES^PSIVUTL($P(ND0,U,9),53.1,28)
 . S INFUS=$P($G(^PS(53.1,+ON,8)),U,5)
 . S ND2=$G(@(F_+ON_",2)")),START=$P(ND2,U,2),STOP=$P(ND2,U,4)
 . S ADM=$P(ND2,U,5),SIO=$P($G(@(F_+ON_",6)")),"^")
 . S ND2P5=$G(@(F_+ON_",2.5)")) S IVLIM=$P(ND2P5,U,4) I $E(IVLIM)="a" S IVLIM="doses"_$P(IVLIM,"a",2)
 . I IVLIM="" S IVLIM=$P(ND2P5,U,2) S:(IVLIM'["d")&(IVLIM'["h") IVLIM=""
 I ON'["P"  D
 . S PROVIDER=$P(ND0,U,6)
 . S SCH=$P(ND0,U,9),INFUS=$P(ND0,U,8),STAT=$$CODES^PSIVUTL($P(ND0,U,17),55.01,100)
 . S MR=$$MR(+$P($G(^PS(55,DFN,"IV",+ON,.2)),U,3))
 . S START=$P(ND0,U,2),STOP=$P(ND0,U,3)
 . S ADM=$P(ND0,U,11),SIO=$P($G(@(F_+ON_",3)")),"^")
 . NEW VERPHARM S VERPHARM=$P($G(^PS(55,DFN,"IV",+ON,4)),U,4)
 . S:+VERPHARM $P(^TMP("PS",$J,"RXN",0),U,5)=VERPHARM
 . S ND2P5=$G(@(F_+ON_",2.5)")) S IVLIM=$P(ND2P5,U,4) I IVLIM="" S IVLIM=$P(ND2P5,U,2) S:(IVLIM'["d")&(IVLIM'["h") IVLIM=""
 S DN=$G(@(F_+ON_",.2)")),DO=$P(DN,U,2)
 S DN=$S(+$P(DN,U):$$OIDF^PSJLMUT1($P(DN,U)),1:"")
 S ^TMP("PS",$J,0)=DN_U_INFUS_U_STOP_"^^"_START_U_STAT_"^^^"_DO_"^^"_$P(ND0,U,21)_U_U_U_($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))_U_U_$G(RNWDT)
 I PROVIDER S ^TMP("PS",$J,"P",0)=PROVIDER_"^"_$P($G(^VA(200,PROVIDER,0)),"^")
 S ^TMP("PS",$J,"MDR",0)=MR]"" S:MR]"" ^TMP("PS",$J,"MDR",1,0)=MR
 S ^TMP("PS",$J,"SCH",0)=SCH]"" S:SCH]"" ^TMP("PS",$J,"SCH",1,0)=SCH
 I ON["P" S:$P(ND0,U,7)]"" ^TMP("PS",$J,"SCH",0)=1,$P(^TMP("PS",$J,"SCH",1,0),U,2)=$$GTSCHT($P(ND0,U,7))_"^"_$P(ND0,U,7)
 S ^TMP("PS",$J,"SIG",0)=INST]"" S:INST]"" ^TMP("PS",$J,"SIG",1,0)=INST
 S ^TMP("PS",$J,"ADM",0)=ADM]"" S:ADM]"" ^TMP("PS",$J,"ADM",1,0)=ADM
 S ^TMP("PS",$J,"SIO",0)=SIO]"" S:SIO]"" ^TMP("PS",$J,"SIO",1,0)=SIO
 I $G(IVLIM)]"" S ^TMP("PS",$J,"IVLIM",0)=$G(IVLIM)
 Q
 ;
MR(X) ;RETURN MED ROUTE ABBR. IF THE ABBR="" RETURN MED ROUTE'S NAME.
 S X=$G(^PS(51.2,X,0))
 Q $S($P(X,U,3)]"":$P(X,U,3),1:$P(X,U))
 ;
GTSTAT(X) ;
 Q $S(X="A":"ACTIVE",X="D":"DISCONTINUED",X="I":"INCOMPLETE",X="N":"NON-VERFIED",X="U":"UNRELEASED",X="P":"PENDING",X="DE":"DISCONTINUED (EDIT)",X="O":"ON CALL",1:"NOT FOUND")
 ;
VA200(X) ;Return the IEN for the user.
 ; X = User name
 NEW DIC,Y S DIC="^VA(200,",DIC(0)="NZ" D ^DIC
 I +Y=-1 Q ""
 Q $P(Y,U)
GTSCHT(X)       ;
 Q $S(X="C":"CONTINUOUS",X="O":"ONE TIME",X="P":"PRN",X="R":"FILL ON REQUEST",X="OC":"ON CALL",1:"NOT FOUND")
