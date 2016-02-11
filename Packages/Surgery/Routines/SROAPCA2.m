SROAPCA2 ;BIR/MAM - PRINT OPERATIVE DATA ;06/28/06
 ;;3.0;Surgery;**38,71,95,125,153,174,175,182,184**;24 Jun 93;Build 35
 S SRA(206)=$G(^SRF(SRTN,206)),SRA(207)=$G(^SRF(SRTN,207)),SRA(209)=$G(^SRF(SRTN,209)),SRA(207.1)=$G(^SRF(SRTN,207.1))
 S SRAO(24)=$P(SRA(206),"^",37)_"^451"
 S SRAO(25)=$P(SRA(206),"^",36)_"^450"
 S Y=$P(SRA(207),"^",26),C=$P(^DD(130,468,0),"^",2) D:Y'="" Y^DIQ S SRAO(26)=Y_"^468"
 S Y=$P(SRA(207),"^",27),C=$P(^DD(130,469,0),"^",2) D:Y'="" Y^DIQ S SRAO(27)=Y_"^469"
 S NYUK=$P(SRA(209),"^",9) D YN1 S SRAO(28)=SHEMP_"^481"
 S (NYUK,SHEMP)=""
 S NYUK=$P(SRA(209),"^",13) D YN S SRAO(29)=SHEMP_"^502"
 W !!,"VI. OPERATIVE DATA"
 W !!,"Bridge to Transplant: ",?29,$P(SRAO(28),"^")
 W !!,"Operative Data details:"
 W !,"Total CPB Time: ",?29,$P(SRAO(24),"^")_" min",?50,"Total Ischemic Time: ",$P(SRAO(25),"^")_" min"
 W !,"Incision Type: ",?29,$P(SRAO(26),"^")
 W !,"Conversion Off Pump to CPB:",?29,$P(SRAO(27),"^")
 I $Y+6>IOSL D PAGE^SROAPCA I SRSOUT Q
 K SRA,SRAO D ^SROAPCA3
 Q
YN ; store answer
 S SHEMP=$S(NYUK="NS":"NS",NYUK="N":"NO",NYUK="Y":"YES",1:"")
 Q
YN1 ; store answer for SRAO(28)
  S SHEMP=$S(NYUK="Y":"YES",NYUK="N":"NONE",NYUK="B":"BRIDGE TO TRANSPORT",NYUK="D":"DESTINATION THERAPY",1:"")
  Q
