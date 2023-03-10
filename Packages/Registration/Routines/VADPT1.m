VADPT1 ;ALB/MRL,MJK,ERC,TDM,CLT,ARF - PATIENT VARIABLES ;05 May 2017  1:41 PM
 ;;5.3;Registration;**415,489,516,614,688,754,887,941,1059,1067,1071,1064**;Aug 13, 1993;Build 41
 ;
 ; NOTE: When setting up subscripts in the return array, the top level subscript must always be defined
 ;  - (e.g. Inpatient Meds uses this API and assumes the top level subscript is defined)
 ;
1 ;Demographic [DEM]
 N W,Z,NODE
 ;
 ; -- name [1 - NM]
 S VAX=^DPT(DFN,0),@VAV@($P(VAS,"^",1))=$P(VAX,"^")
 ;
 ; -- ssn [2 - SS]
 S Z=$P(VAX,"^",9) S:Z]"" @VAV@($P(VAS,"^",2))=Z_$S(Z]"":"^"_$E(Z,1,3)_"-"_$E(Z,4,5)_"-"_$E(Z,6,10),1:"")
 ;
 ; -- date of birth [2 - DB]
 S Z=$P(VAX,"^",3),Y=Z I Y]"" X ^DD("DD") S @VAV@($P(VAS,"^",3))=Z_"^"_Y
 ;
 ; -- age [4 - AG]
 S W=$S('$D(^DPT(DFN,.35)):"",'^(.35):"",1:+^(.35)) S Y=$S('W:DT,1:W) S:Z]"" @VAV@($P(VAS,"^",4))=$E(Y,1,3)-$E(Z,1,3)-($E(Y,4,7)<$E(Z,4,7))
 ;
 ; -- expired date [6 - EX]
 S (Y,Z)=W X:Y]"" ^DD("DD") S:Z]"" @VAV@($P(VAS,"^",6))=Z_"^"_Y
 ;
 ; -- sex [5 - SX]
 S Z=$P(VAX,"^",2) S:Z]"" @VAV@($P(VAS,"^",5))=Z_"^"_$S(Z="M":"MALE",Z="F":"FEMALE",1:"") K Z
 ;
 ; -- remarks [7 - RE]
 S @VAV@($P(VAS,"^",7))=$P(VAX,"^",10)
 ;
 ; -- historic race [8 - RA]
 S Z=$P(VAX,"^",6),@VAV@($P(VAS,"^",8))=Z_$S($D(^DIC(10,+Z,0)):"^"_$P(^(0),"^"),1:"")
 ;
 ; -- religion [9 - RP]
 S Z=$P(VAX,"^",8),@VAV@($P(VAS,"^",9))=Z_$S($D(^DIC(13,+Z,0)):"^"_$P(^(0),"^"),1:"")
 ;
 ; -- marital status [10 - MS]
 S Z=$P(VAX,"^",5),@VAV@($P(VAS,"^",10))=Z_$S($D(^DIC(11,+Z,0)):"^"_$P(^(0),"^"),1:"")
 ;
 ; -- ethnicity [11 - ET]
 S X=0 F Y=1:1 S X=+$O(^DPT(DFN,.06,X)) Q:'X  D
 .S NODE=$G(^DPT(DFN,.06,X,0)),Z=$P(NODE,"^",1) I Z D
 ..S @VAV@($P(VAS,"^",11),Y)=Z_"^"_$P($G(^DIC(10.2,Z,0)),"^",1)
 ..; -- collection method
 ..S Z=$P(NODE,"^",2) I Z D
 ...S @VAV@($P(VAS,"^",11),Y,1)=Z_"^"_$P($G(^DIC(10.3,Z,0)),"^",1)
 S @VAV@($P(VAS,"^",11))=Y-1
 ;
 ; -- race [12 - RC]
 S X=0 F Y=1:1 S X=+$O(^DPT(DFN,.02,X)) Q:'X  D
 .S NODE=$G(^DPT(DFN,.02,X,0)),Z=$P(NODE,"^",1) I Z D
 ..S @VAV@($P(VAS,"^",12),Y)=Z_"^"_$P($G(^DIC(10,Z,0)),"^",1)
 ..; -- collection method
 ..S Z=$P(NODE,"^",2) I Z D
 ...S @VAV@($P(VAS,"^",12),Y,1)=Z_"^"_$P($G(^DIC(10.3,Z,0)),"^",1)
 S @VAV@($P(VAS,"^",12))=Y-1
 ;
 ; -- current pt preferred language [13 - LG]
 N VALANGDT,VAPRFLAN,VALANG0,VAY,VALANGDA,X,Y
 S VALANGDT=9999999,(VAPRFLAN,VALANG0)=""
 S VALANGDT=$O(^DPT(DFN,.207,"B",VALANGDT),-1)
 I VALANGDT="" S @VAV@($P(VAS,"^",13))="",@VAV@($P(VAS,"^",13),1)=""
 I VALANGDT'="" D
 .S VALANGDA=$O(^DPT(DFN,.207,"B",VALANGDT,0))
 .S VALANG0=$G(^DPT(DFN,.207,VALANGDA,0)),Y=$P(VALANG0,U),VAPRFLAN=$P(VALANG0,U,2)
 .S (VAY,Y)=VALANGDT X ^DD("DD") S VALANGDT=Y
 .S @VAV@($P(VAS,"^",13))=VAY_"^"_VALANGDT ; FM version^human readable
 .S @VAV@($P(VAS,"^",13),1)=VALANGDA_"^"_VAPRFLAN ; Pointer^human readable
 ;
 ;**1059 Adding Sexual Orientation, Sexual Orientation Description, Pronoun, Pronoun Description, SIGI [14 - SOGI]
 ;**1071 VAMPI-13755 (jfw) - Display Additional SO Info
 N SOC,CNTR,PRO,SIGI,SIGIN,VAREF
 S @VAV@($P(VAS,"^",14))=""
 ;Sexual Orientation #.025 multiple
 S CNTR=1,X=0 F  S X=$O(^DPT(DFN,.025,X)) Q:'X!(X="")  D
 .N VASOI D GETS^DIQ(2.025,X_","_DFN,"*","EI","VASOI")
 .;External^Internal values: SO, Status, Date Created, Date Last Updated, TIU Document
 .S VAREF="VASOI(2.025,"""_X_","_DFN_","")",@VAV@($P(VAS,"^",14),1,CNTR)=$P($G(^DG(47.77,@VAREF@(.01,"I"),0)),"^",1,2)
 .N VAI F VAI=.02,.03,.04,.05 S @VAV@($P(VAS,"^",14),1,CNTR,(VAI*100-1))=@VAREF@(VAI,"E")_"^"_@VAREF@(VAI,"I")
 .S CNTR=CNTR+1
 S @VAV@($P(VAS,"^",14),1)=CNTR-1
 ;Sexual Orientatin Description #.241
 S @VAV@($P(VAS,"^",14),2)=$P($G(^DPT(DFN,.241)),"^")
 ;Pronoun #.2406 multiple
 K CNTR,X
 S CNTR=1,X=0 F  S X=$O(^DPT(DFN,.2406,X)) Q:'X!(X="")  D
 .S PRO=$G(^DPT(DFN,.2406,X,0))
 .S @VAV@($P(VAS,"^",14),3,CNTR)=$G(^DG(47.78,PRO,0)),CNTR=CNTR+1 ;NAME ^ CODE
 S @VAV@($P(VAS,"^",14),3)=CNTR-1
 ;Pronoun Description #.24061
 S @VAV@($P(VAS,"^",14),4)=$P($G(^DPT(DFN,.241)),"^",2)
 ;SELF IDENTIFIED GENDER #.024
 S SIGI=$P($G(^DPT(DFN,.24)),"^",4),SIGIN=$$GET1^DIQ(2,DFN_",",.024)
 S @VAV@($P(VAS,"^",14),5)=SIGIN_"^"_SIGI ;NAME ^ CODE
 ; DG*5.3*1064; Adding INDIAN SELF IDENTIFICATION, INDIAN ATTESTATION DATE, INDIAN START DATE, INDIAN END DATE [15 - IND]
 ; The top level subscript must always be defined (see NOTE above)
 S @VAV@($P(VAS,"^",15))=""
 N DGINDARR
 D GETS^DIQ(2,DFN,".571:.574","I","DGINDARR")
 S @VAV@($P(VAS,"^",15),1)=$G(DGINDARR(2,DFN_",",.571,"I"))
 S @VAV@($P(VAS,"^",15),2)=$G(DGINDARR(2,DFN_",",.572,"I"))
 S @VAV@($P(VAS,"^",15),3)=$G(DGINDARR(2,DFN_",",.573,"I"))
 S @VAV@($P(VAS,"^",15),4)=$G(DGINDARR(2,DFN_",",.574,"I"))
 Q
 ;
2 ;Other Patient Variables [OPD]
 N W,Z
 S VAX=^DPT(DFN,0)
 ;
 ; -- city of birth [1 - BC]
 S @VAV@($P(VAS,"^",1))=$P(VAX,"^",11)
 ;
 ; -- state of birth [2 - BS]
 S Z=$P(VAX,"^",12),@VAV@($P(VAS,"^",2))=Z_$S($D(^DIC(5,+Z,0)):"^"_$P(^(0),"^",1),1:"")
 ;
 ; -- occupation [6 - OC]
 S @VAV@($P(VAS,"^",6))=$P(VAX,"^",7)
 ;
 ; -- names
 S VAX=$S($D(^DPT(DFN,.24)):^(.24),1:"")
 S @VAV@($P(VAS,"^",3))=$P(VAX,"^",1) ; father's        [3 - FN]
 S @VAV@($P(VAS,"^",4))=$P(VAX,"^",2) ; mother's        [4 - MN]
 S @VAV@($P(VAS,"^",5))=$P(VAX,"^",3) ; mother's maiden [5 - MM]
 ;
 ; -- employment status [7 - ES]
 S VAX=$S($D(^DPT(DFN,.311)):^(.311),1:""),W="EMPLOYED FULL TIME^EMPLOYED PART TIME^NOT EMPLOYED^SELF EMPLOYED^RETIRED^ACTIVE MILITARY DUTY^UNKNOWN"
 S Z=$P(VAX,"^",15),@VAV@($P(VAS,"^",7))=Z_$S(Z:"^"_$P(W,"^",Z),1:"")
 ;
 ; -- PHONE NUMBER [WORK] [8 - WP]
 I $D(^DPT(DFN,.13)) S @VAV@($P(VAS,"^",8))=$P(^(.13),"^",2)
 Q
 ;
3 ;Address [ADD]
 N VAFOR
 S VABEG=$S($D(VATEST("ADD",9)):VATEST("ADD",9),1:DT),VAEND=$S($D(VATEST("ADD",10)):VATEST("ADD",10),1:DT)
 I $S($D(VAPA("P")):1,'$D(^DPT(DFN,.121)):1,$P(^(.121),"^",9)'="Y":1,'$P(^(.121),"^",7):1,$P(^(.121),"^",7)>VABEG:1,'$P(^(.121),"^",8):0,1:$P(^(.121),"^",8)<VAEND) S VAX=$S($D(^DPT(DFN,.11)):^(.11),1:""),VAX(1)=0
 E  S VAX=$S($D(^DPT(DFN,.121)):^(.121),1:""),VAX(1)=1
 ;set the foreign address fields into local variables for later
 I 'VAX(1) S VAFOR=$P(VAX,U,8,10)
 I VAX(1) D
 . I '$D(^DPT(DFN,.122)) S VAFOR="" Q
 . S VAFOR=$P(^DPT(DFN,.122),U,1,3)
 F I=1:1:6 S VAZ=$P(VAX,"^",I),@VAV@($P(VAS,"^",I))=VAZ I I=5,$D(^DIC(5,+VAZ,0)) S VAZ=$P(^(0),"^"),@VAV@($P(VAS,"^",5))=@VAV@($P(VAS,"^",5))_"^"_VAZ
 S VAZ=$S('VAX(1):$P(VAX,"^",7),1:$P(VAX,"^",11)) S:$D(^DIC(5,+$P(VAX,"^",5),1,+VAZ,0)) VAZ=VAZ_"^"_$P(^(0),"^",1) S @VAV@($P(VAS,"^",7))=VAZ
 S VAZIP4=$P(VAX,U,12)
 S @VAV@($P(VAS,U,11))=VAZIP4_$S('$G(VAZIP4):"",($L(VAZIP4)=5):U_VAZIP4,1:U_$E(VAZIP4,1,5)_"-"_$E(VAZIP4,6,9))
 ;DG*5.3*516
 I $D(^DPT(DFN,.13)) S @VAV@($P(VAS,"^",8))=$P(^(.13),"^",1)
 ;foreign address fields
 F I=1:1:3 S VAZ=$P(VAFOR,U,I) S @VAV@($P(VAS,U,I+22))=VAZ
 ;
 I $P($G(VAFOR),U,3)]"" D
 . S VACNTRY=$P(VAFOR,U,3)
 . S VACNTRY=$$CNTRYI^DGADDUTL(VACNTRY)
 . S $P(@VAV@($P(VAS,U,25)),U,2)=VACNTRY
 I 'VAX(1) G CA
 S @VAV@($P(VAS,"^",8))=$P(VAX,"^",10)
 F I=7,8 S VAZ=$P(VAX,"^",I),Y=VAZ X:Y]"" ^DD("DD") S @VAV@($P(VAS,"^",I+2))=VAZ_"^"_Y
CA ;Confidential Address
 ; JAM, Go to Residential Address if no Conf address- VADPT ICR 10061 ;DG*5.3*941
 I '$D(^DPT(DFN,.141)) G RES
 N VACAT,VAACT,VAACTDT,VATYP,VATYPNAM,VACAN
 S VAX=$S($D(^DPT(DFN,.141)):^(.141),1:"")
 S VAACTDT=$S($D(VAPA("CD")):VAPA("CD"),1:DT)
 F I=1:1:6 S VAZ=$P(VAX,"^",I),@VAV@($P(VAS,"^",I+12))=VAZ D
 .I I=5,$D(^DIC(5,+VAZ,0)) S VAZ=$P(^(0),"^"),@VAV@($P(VAS,"^",I+12))=@VAV@($P(VAS,"^",I+12))_"^"_VAZ Q
 .I I=6,($G(VAZ)]"") S @VAV@($P(VAS,"^",I+12))=@VAV@($P(VAS,"^",I+12))_"^"_$S(($L(VAZ)=5):VAZ,1:$E(VAZ,1,5)_"-"_$E(VAZ,6,9))
 S VAZ=$P(VAX,"^",11) S:$D(^DIC(5,+$P(VAX,"^",5),1,+VAZ,0)) VAZ=VAZ_"^"_$P(^(0),"^",1) S @VAV@($P(VAS,"^",19))=VAZ
 F I=7,8 S VAZ=$P(VAX,"^",I),Y=VAZ X:Y]"" ^DD("DD") S @VAV@($P(VAS,"^",I+13))=VAZ_"^"_Y
 S VABEG=$P(VAX,"^",7),VAEND=$P(VAX,"^",8)
 S @VAV@($P(VAS,"^",12))=1
 I 'VABEG!(VABEG>VAACTDT)!(VAEND&(VAEND<VAACTDT)) S @VAV@($P(VAS,"^",12))=0
 I $D(^DPT(DFN,.14)) D
 .S VACAN="" F  S VACAN=$O(^DPT(DFN,.14,VACAN)) Q:VACAN=""  D
 ..Q:'$D(^DPT(DFN,.14,VACAN,0))
 ..S VATYP=$P(^DPT(DFN,.14,VACAN,0),"^",1),VAACT=$P(^DPT(DFN,.14,VACAN,0),"^",2)
 ..S VACAT=$$GET1^DID(2.141,.01,"","POINTER","","DGERR")
 ..S VATYPNAM="" F I=1:1 S VATYPNAM=$P(VACAT,";",I) Q:VATYPNAM=""  D
 ...I +VATYPNAM[VATYP S VATYPNAM=$P(VATYPNAM,":",2),@VAV@($P(VAS,"^",22),VATYP)=VATYP_"^"_VATYPNAM_"^"_VAACT
 ;foreign address fields for the confidential address
 F I=1:1:3 S @VAV@($P(VAS,U,I+25))=$P(VAX,U,I+13)
 I @VAV@($P(VAS,U,28))]"" D
 . I '$D(^HL(779.004,$P(VAX,U,16),0)) Q
 . S $P(@VAV@($P(VAS,U,28)),U,2)=$$CNTRYI^DGADDUTL($P(VAX,U,16))
 ; -- CONFIDENTIAL PHONE NUMBER [29 - CPN]
 I $D(^DPT(DFN,.13)) S @VAV@($P(VAS,"^",29))=$P(^(.13),"^",15)
RES ;Residential address
 ;CLT, Add Residential Address to VADPT ICR 10061 ;DG*5.3*941
 I '$D(^DPT(DFN,.115)) G Q3
 N DGAR
 S DGAR=$G(^DPT(DFN,.115))
 F I=1:1:7 S @VAV@(29+I)=$P(DGAR,U,I)
 I @VAV@(34)'="",@VAV@(36)'="" I $D(^DIC(5,@VAV@(34),1,@VAV@(36),0)) S VAZ=$P(^DIC(5,@VAV@(34),1,@VAV@(36),0),"^",1),@VAV@(36)=@VAV@(36)_"^"_VAZ
 I @VAV@(34)'="" S:$D(^DIC(5,@VAV@(34),0)) @VAV@(34)=@VAV@(34)_"^"_$P(^DIC(5,@VAV@(34),0),U,1)
 S @VAV@(37)=$P(DGAR,"^",10)
 I @VAV@(37)'="" D
 . S VACNTRY=@VAV@(37)
 . S VACNTRY=$$CNTRYI^DGADDUTL(VACNTRY)
 . S $P(@VAV@(37),U,2)=VACNTRY
 S @VAV@(38)=$P(DGAR,"^",8)
 S @VAV@(39)=$P(DGAR,"^",9)
 ;
Q3 K VABEG,VAEND,VAZIP4 Q
 ;
4 ;Other Address [OAD]
 N VAZIP4
 I $S('$D(VAOA("A")):1,VAOA("A")<1:1,VAOA("A")>6:1,1:0) S VAX=.21,VAOA("A")=7
 E  S VAX="."_$P("33^34^211^331^311^25","^",+VAOA("A"))
 S VAX(1)=VAX,VAX=$S($D(^DPT(DFN,VAX(1))):^(VAX(1)),1:"") I VAX(1)=.25 S VAX=$P(VAX,"^",1)_"^^"_$P(VAX,"^",2,99)
 S VAX(2)=0 F I=3,4,5,6,7,8 S VAX(2)=VAX(2)+1,@VAV@($P(VAS,"^",VAX(2)))=$P(VAX,"^",I)
 S @VAV@($P(VAS,"^",7))="",@VAV@($P(VAS,"^",8))=$P(VAX,"^",9),VAX(2)=8
 F I=1,2 S VAX(2)=VAX(2)+1,@VAV@($P(VAS,"^",VAX(2)))=$P(VAX,"^",I)
 I "^.311^.25"[("^"_VAX(1)_"^") S @VAV@($P(VAS,"^",10))=""
 ;DG*5.3*1067 store the RELATION TYPE field, from the PATIENT CONTACT RELATION file(#12.11)file, into node 10
 ;and move RELATIONSHIP TO PATIENT to node 12 only for the Emergency Contacts, Next of Kins, and Designees options.
 I (+VAOA("A")'=5)&(+VAOA("A")'=6) S @VAV@($P(VAS,"^",10))=$$GET1^DIQ(12.11,$P(VAX,"^",15)_",",.02),@VAV@($P(VAS,"^",12))=$P(VAX,"^",2)
 S VAZ=@VAV@($P(VAS,"^",5)) I VAZ,$D(^DIC(5,+VAZ,0)) S VAZ(1)=$P(^(0),"^",1),@VAV@($P(VAS,"^",5))=VAZ_"^"_VAZ(1)
 S VAZIP4=$P($G(^DPT(DFN,.22)),U,VAOA("A"))
 S @VAV@($P(VAS,U,11))=VAZIP4_$S('$G(VAZIP4):"",($L(VAZIP4)=5):U_VAZIP4,1:U_$E(VAZIP4,1,5)_"-"_$E(VAZIP4,6,9))
 Q
