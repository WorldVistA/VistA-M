PSJPXRM1 ;BIR/MV-RETURN INPATIENT ACTIVE MEDS (EXPANDED) ;29 Jan 99 / 8:49 AM
 ;;5.0; INPATIENT MEDICATIONS ;**90,170**;16 DEC 97
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(52.6 is supported by DBIA 1231.
 ; Reference to ^PS(52.7 is supported by DBIA 2173.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^PSDRUG is supported by DBIA 2192.
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ; Reference to ^DIC is supported by DBIA 10006.
 ;
OEL(DAS,NAME)         ; return list of expanded inpat meds
 N ADM,CNT,DFN,DN,DO,F,INFUS,INST,MR,ND,ND0,ND2,ND6,NDOI,ON,SCH,SIO,START,STAT,STOP,TYP,UNITS,X,Y
 S DFN=$P(DAS,";")
 S F=$S($P(DAS,";",2)["P":"^PS(53.1,",$P(DAS,";",2)=5:"^PS(55,DFN,5,",1:"^PS(55,"_DFN_",""IV"",")
 S ON=$P(DAS,";",3)_$S($P(DAS,";",2)="IV":"V",$P(DAS,";",2)=5:"U",1:"P")
 I ON'["P",'$D(@(F_+ON_")")) Q
 I ON["P" S X=$G(^PS(53.1,+ON,0)) Q:$P(X,U,15)'=DFN  S TYP=$P(X,U,4) D @$S(TYP="U":"UDTMP",1:"IVTMP")
 D:ON'["P" @$S(ON["U":"UDTMP",1:"IVTMP")
 S Y=$S(ON["V":5,1:12),CNT=0
 I $O(@(F_+ON_","_Y_",0)")) D
 . F X=0:0 S X=$O(@(F_+ON_","_Y_","_X_")")) Q:'X  D
 ..S CNT=CNT+1,ND=$G(@(F_+ON_","_Y_","_X_",0)")),NAME("PC",CNT,0)=ND
 S NAME("PC",0)=CNT
 Q
 ;
UDTMP ;*** Set array for Unit dose orders.
 N DO,DN,INST,X,Y,PROVIDER,NOTGIVEN
 S (MR,SCH,INST)=""
 S ND2=$G(@(F_+ON_",2)")),ND0=$G(@(F_+ON_",0)"))
 S ND6=$P($G(@(F_+ON_",6)")),"^")
 S NAME("STAT")=$$CODES^PSIVUTL($P(ND0,U,9),$S(ON["P":53.1,1:55.06),28)
 D DRGDISP^PSJLMUT1(DFN,ON,40,0,.DN,1)
 S NDOI=$G(@(F_+ON_",.2)")),NAME("OI")=+NDOI,NAME("DO")=$P(NDOI,U,2)
 S NAME("START")=$P(ND2,"^",2),NAME("STOP")=$P(ND2,"^",4)
 S NAME("UNITS")="" I '$O(@(F_+ON_",1,1)")) S NAME("UNITS")=$P($G(@(F_+ON_",1,1,0)")),U,2) S:(ON["U")&(NAME("UNITS")="") NAME("UNITS")=1
 S NAME("MR")=$$MR(+$P(ND0,U,3)),NAME("INST")=$G(@(F_+ON_",.3)"))
 S NAME("NOTGIVEN")=$S(ON["U":$P($G(^PS(55,DFN,5,+ON,0)),"^",22),1:"")
 S NAME("OERR")=$P(ND0,U,21)
 S NAME("PENDRENEWAL")=($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))
 S NAME("PROVIDER")=$P($G(@(F_+ON_",0)")),"^",2)
 I NAME("PROVIDER") S NAME("PROVIDER")=NAME("PROVIDER")_"^"_$P($G(^VA(200,NAME("PROVIDER"),0)),"^")
 S NAME("MDR",0)=NAME("MR")]"" S:NAME("MR")]"" NAME("MDR",1,0)=NAME("MR")
 S NAME("SCH",0)=$P(ND2,U)]"" S:$P(ND2,U)]"" NAME("SCH",1,0)=$P(ND2,U)
 S:$P(ND0,U,7)]"" NAME("SCH",0)=1,$P(NAME("SCH",1,0),U,2)=$$GTSCHT($P(ND0,U,7))_"^"_$P(ND0,U,7)
 S NAME("SIG",0)=INST]"" S:INST]"" NAME("SIG",1,0)=INST
 S NAME("ADM",0)=$P(ND2,U,5)]"" S:$P(ND2,U,5)]"" NAME("ADM",1,0)=$P(ND2,U,5)
 S NAME("SIO",0)=ND6]"" S:ND6]"" NAME("SIO",1,0)=ND6
 S:ON["U" NAME("VERPHARM")=$P($G(@(F_+ON_",4)")),U,3)
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
 . ;* S UNITS=$S('+$P(NDDD,U,2):1,1:$P(NDDD,U,2))
 . S UNITS=$P(NDDD,U,2) S:(ON["U")&(UNITS="") UNITS=1
 . S CNT=CNT+1,NAME("DD",CNT,0)=+NDDD_U_UNITS_U_PSJOUT_U_$G(OUTOI)
 S NAME("DD",0)=CNT
 Q
 ;
IVTMP ;*** Set array for IV orders.
 N PROVIDER S ND0=$G(@(F_+ON_",0)")),CNT=0
 F X=0:0 S X=$O(@(F_+ON_",""AD"","_X_")")) Q:'X  S ND=$G(@(F_+ON_",""AD"","_X_",0)")),DN=$P($G(^PS(52.6,+ND,0)),U),Y=DN_U_$P(ND,U,2) S:$P(ND,U,3) Y=Y_U_$P(ND,U,3) S CNT=CNT+1,NAME("AD",CNT,0)=Y
 S NAME("AD",0)=CNT,CNT=0
 F X=0:0 S X=$O(@(F_+ON_",""SOL"","_X_")")) Q:'X  S ND=$G(@(F_+ON_",""SOL"","_X_",0)")),DN=$G(^PS(52.7,+ND,0)),CNT=CNT+1,NAME("SOL",CNT,0)=$P(DN,U)_U_$P(ND,U,2)_U_$P(DN,U,4)
 S NAME("SOL",0)=CNT
 S NAME("INST")=$G(@(F_+ON_",.3)"))
 I ON["P" D
 . S NAME("SCH")=$P($G(^PS(53.1,+ON,2)),U)
 . S NAME("PROVIDER")=$P(ND0,U,2)
 . S NAME("MR")=$$MR(+$P(ND0,U,3)),NAME("STAT")=$$CODES^PSIVUTL($P(ND0,U,9),53.1,28)
 . S NAME("INFUS")=$P($G(^PS(53.1,+ON,8)),U,5)
 . S ND2=$G(@(F_+ON_",2)")),NAME("START")=$P(ND2,U,2),NAME("STOP")=$P(ND2,U,4)
 . S NAME("ADM")=$P(ND2,U,5),NAME("SIO")=$P($G(@(F_+ON_",6)")),"^")
 . S NAME("DN")=$G(@(F_+ON_",.2)")),NAME("DO")=$P(NAME("DN"),U,2)
 . S:NAME("DO")="" NAME("DO")=$P($G(NAME("AD",1,0)),U,2)
 . S NAME("DN")=$S(+$P(NAME("DN"),U):$$OIDF^PSJLMUT1($P(NAME("DN"),U)),1:"")
 I ON'["P"  D
 . S NAME("PROVIDER")=$P(ND0,U,6)
 . S NAME("SCH")=$P(ND0,U,9),NAME("INFUS")=$P(ND0,U,8),NAME("STAT")=$$CODES^PSIVUTL($P(ND0,U,17),55.01,100)
 . S NAME("MR")=$$MR(+$P($G(^PS(55,DFN,"IV",+ON,.2)),U,3))
 . S NAME("START")=$P(ND0,U,2),NAME("STOP")=$P(ND0,U,3)
 . S NAME("ADM")=$P(ND0,U,11),NAME("SIO")=$P($G(@(F_+ON_",3)")),"^")
 . S NAME("VERPHARM")=$P($G(^PS(55,DFN,"IV",+ON,4)),U,4)
 . S NAME("DN")=$G(@(F_+ON_",.2)")),NAME("DO")=$P(NAME("DN"),U,2)
 . S NAME("DN")=$S(+$P(NAME("DN"),U):$$OIDF^PSJLMUT1($P(NAME("DN"),U)),1:"")
 S NAME("OERR")=$P(ND0,U,21)
 S NAME("PENDRENEWAL")=($P(ND0,U,9)="P"&($P(ND0,U,24)="R"))
 I NAME("PROVIDER") S NAME("PROVIDER")=NAME("PROVIDER")_"^"_$P($G(^VA(200,NAME("PROVIDER"),0)),"^")
 S NAME("MDR",0)=NAME("MR")]"" S:NAME("MR")]"" NAME("MDR",1,0)=NAME("MR")
 S NAME("SCH",0)=NAME("SCH")]"" S:NAME("SCH")]"" NAME("SCH",1,0)=NAME("SCH")
 I ON["P" S:$P(ND0,U,7)]"" NAME("SCH",0)=1,$P(NAME("SCH",1,0),U,2)=$$GTSCHT($P(ND0,U,7))_"^"_$P(ND0,U,7)
 S NAME("SIG",0)=NAME("INST")]"" S:NAME("INST")]"" NAME("SIG",1,0)=NAME("INST")
 S NAME("ADM",0)=NAME("ADM")]"" S:NAME("ADM")]"" NAME("ADM",1,0)=NAME("ADM")
 S NAME("SIO",0)=NAME("SIO")]"" S:NAME("SIO")]"" NAME("SIO",1,0)=NAME("SIO")
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
