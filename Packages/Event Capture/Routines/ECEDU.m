ECEDU ;BIR/MAM,JPW-Enter Event Capture Data (cont'd) ;6 Mar 96
 ;;2.0; EVENT CAPTURE ;**10,18,23,47,63,72**;8 May 96
HDR ;hdr for filing
 W @IOF,!,"ENTERING A NEW PROCEDURE FOR "_ECPAT_" ...",!!,"LOCATION: "_ECLN,!,"SERVICE: "_ECSN,!,"SECTION: "_ECMN,!,"CATEGORY: "_ECCN,!!,"PROCEDURE: "
 W $S(ECCPT="":"",1:ECPTCD_" ")_$E(ECPN,1,50)
 I SYN]"",SYN'["NOT DEFINED" W " ["_SYN_"]"
 W "  (#"_NATN_")"
 Q
MSGC ;msg cat
 W !!,"Please enter the number that corresponds to the "_$S(EC1:"procedure",1:"category")_" from which",!,"you would like to select a procedure.  If you would like to continue",!,"with the list, press <RET>.  Enter ^ to quit."
 S CNT=CNT-5
 Q
HDR1 ; heading
 W @IOF,!,"Patient: "_ECPAT,?40,"Procedure Date: "_ECDATE,!!,"Location: "_ECLN,?40,"Service: "_ECSN,!,"Section: "_ECMN,?40,"DSS Unit: "_ECDN W:$D(ECCN) !,"Category: "_ECCN
 Q
MSG W !!,"No procedures entered.  No Action Taken.",!!,"Press <RET> to continue " R X:DTIME S ECOUT=1
 Q
SETE ;set edit
 N ECPXD
 S DA=+EC(EC),EC(0)=^ECH(DA,0),ECC=+$P(EC(0),"^",8),ECCN=$S('ECC:"None",$P($G(^EC(726,ECC,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 S (ECP,ECPROF)=$P(EC(0),"^",9)
 S ECPSY=+$O(^ECJ("AP",+ECL,+ECD,ECC,+ECP,""))
 S ECPSYN=$P($G(^ECJ(ECPSY,"PRO")),"^",2)
 S ECFILE=$S(ECPROF["EC":725,ECPROF["ICPT":81,1:"UNKNOWN")
 I ECFILE="UNKNOWN" S ECPN="UNKNOWN"
 S ECCPT=$S(ECP["ICPT":+ECP,1:$P($G(^EC(725,+ECP,0)),U,5))
 S (ECPTCD,ECPXD)="" I ECCPT'="" D
 . S ECPXD=$$CPT^ICPTCOD(ECCPT,$P(EC(0),U,3)) I +ECPXD>0 S ECPTCD=$P(ECPXD,U,2)
 I ECFILE=81 S ECPN=$S($P(ECPXD,U,3)]"":$P(ECPXD,U,3),1:"UNKNOWN")
 I ECFILE=725 S ECPN=$S($P($G(^EC(725,+ECP,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
HDRE ; hdr for editing
 W @IOF,!,"EDITING A PROCEDURE FOR "_ECPAT_" ...",!!,"LOCATION: "_ECLN,!,"SERVICE: "_ECSN,!,"SECTION: "_ECMN,!,"CATEGORY: "_ECCN,!,"PROCEDURE: "_$S(ECCPT="":"",1:ECPTCD_" ")_ECPN_$S(ECPSYN="":"",1:"  ["_ECPSYN_"]")
 Q
DXEDT ;ALB/JAM - Edit Primary and multiple secondary dx codes
 N PXUPD,IEN,ECPDX,ECDXS,ECDT,ECDXI
 S EC4=$P($G(^ECH(ECFN,0)),"^",19),(ECDX,ECDXN)="",ECDT=ECNEWDT
 S ECPDX=$$PDXCK^ECUTL2(ECDFN,ECNEWDT,ECL,EC4),IEN="" K ECDXIEN(ECFN)
 ;update primary diagnoses code
 S ECDX=ECDX1,ECDXI=$$ICDDX^ICDCODE(ECDX1,ECNEWDT),ECDXN=$P(ECDXI,U,2)
 W !,"Primary ICD-9 Code: ",ECDXN,"  ",$P(ECDXI,U,4)
 D PDX^ECUTL2 I ECOUT=1 Q
 S ECDX1=ECDX
 S DA=ECFN,DR="20////"_ECDX1 D ^DIE K DIE
 ;check for any changes to primary dx
 S ECDX1=X,IEN=""
 F  S IEN=$O(ECDXIEN(IEN)) Q:IEN=""  I $P(ECDXIEN(IEN),U,2)'=ECDX1 D  Q
 .W !?5,"WARNING: More than 1 Primary diagnoses exist for this encounter. All"
 .W !?14,"Procedures will be updated to have same primary & secondary dx"
 ; update secondary diagnosis codes
 D SDX^ECUTL2 S DXS=""
 K ECDXX M ECDXX=ECDXS K ECDXS
 ;Update all procedures for the encounter with same primary dx
 S PXUPD=$$PXUPD^ECUTL2(ECDFN,ECNEWDT,ECL,EC4,ECDX1,.ECDXX)
 K PXUPD,ECDXX S DA=ECFN
 Q
 F  S DXS=$O(ECDXS(DXS)) Q:DXS=""  S DXSIEN=$P(ECDXS(DXS),U) D:DXSIEN>0
 . K DIC,DD,DO S DIC(0)="L",DA(1)=ECFN,DIC="^ECH("_DA(1)_","_"""DX"""_","
 . S DIC("P")=$P(^DD(721,38,0),U,2),X=DXSIEN D FILE^DICN
 K DXSIEN,DXS,ECDXX,DIC M ECDXX=ECDXS K ECDXS
