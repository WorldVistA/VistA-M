YTSPROMU ;SLC/KCM - Score PROMIS29 v2.1 MAUT ; 10/14/18 2:02pm
 ;;5.01;MENTAL HEALTH;**173**;Dec 30, 1994;Build 10
 ;
 ; PROMIS-29+2 Multi-Attribute Utility Theory (MAUT) Scoring
 ; based on MAUT R code at https://github.com/janelhanmer/PROPr
 ;
MAUT(TSCORES,USCORES) ; t-scores are inputs, utility scores are outputs
 N TCOG,TDEP,TFAT,TPAIN,TPHYS,TSLP,TSR              ; theta values
 N CCOG,CDEP,CFAT,CPAIN,CPHYS,CSLP,CSR,C,TODEAD,MAD ; constants
 N DCOG,DDEP,DFAT,DPAIN,DPHYS,DSLP,DSR              ; disutility values
 N MCOG,MDEP,MFAT,MPAIN,MPHYS,MSLP,MSR              ; interim multi-attribute
 ;
 ; convert t-scores to theta values
 S TCOG=(TSCORES("cognition")-50)/10
 S TDEP=(TSCORES("depression")-50)/10
 S TFAT=(TSCORES("fatigue")-50)/10
 S TPAIN=(TSCORES("pain")-50)/10
 S TPHYS=(TSCORES("physical")-50)/10
 S TSLP=(TSCORES("sleep")-50)/10
 S TSR=(TSCORES("social")-50)/10
 ;
 ;W !,"thetas",!,TCOG,!,TDEP,!,TFAT,!,TPAIN,!,TPHYS,!,TSLP,!,TSR,!,"end thetas"
 ;
 ; set multi-attribute constants
 S CCOG=0.6350450
 S CDEP=0.6661641
 S CFAT=0.6386135
 S CPAIN=0.6529680
 S CPHYS=0.6883584
 S CSLP=0.5629657
 S CSR=0.6112686
 S C=-0.9991828
 S TODEAD=1.021915
 ;
 ; Cognition Disutility.  Higher cognition scores are better.
 S DCOG=1 ; 1=turncog*, 8=slopecog*, 15=interceptcog*
 I ($$V(1,1)'>TCOG)&(TCOG<$$V(1,2)) S DCOG=$$V(15,1)+(TCOG*$$V(8,1))
 I ($$V(1,2)'>TCOG)&(TCOG<$$V(1,3)) S DCOG=$$V(15,2)+(TCOG*$$V(8,2))
 I ($$V(1,3)'>TCOG)&(TCOG<$$V(1,4)) S DCOG=$$V(15,3)+(TCOG*$$V(8,3))
 I ($$V(1,4)'>TCOG)&(TCOG<$$V(1,5)) S DCOG=$$V(15,4)+(TCOG*$$V(8,4))
 I ($$V(1,5)'>TCOG)&(TCOG<$$V(1,6)) S DCOG=$$V(15,5)+(TCOG*$$V(8,5))
 I ($$V(1,6)'>TCOG)&(TCOG<$$V(1,7)) S DCOG=$$V(15,6)+(TCOG*$$V(8,6))
 I ($$V(1,7)'>TCOG)&(TCOG<$$V(1,8)) S DCOG=$$V(15,7)+(TCOG*$$V(8,7))
 I ($$V(1,8)'>TCOG)&(TCOG<$$V(1,9)) S DCOG=$$V(15,8)+(TCOG*$$V(8,8))
 I ($$V(1,9)'>TCOG) S DCOG=0
 ;
 ; Depression Disutility.  Lower depression scores are better.
 S DDEP=0 ; 2=turndep*, 9=slopedep*, 16=interceptdep*
 I ($$V(2,1)'>TDEP)&(TDEP<$$V(2,2)) S DDEP=$$V(16,1)+(TDEP*$$V(9,1))
 I ($$V(2,2)'>TDEP)&(TDEP<$$V(2,3)) S DDEP=$$V(16,2)+(TDEP*$$V(9,2))
 I ($$V(2,3)'>TDEP)&(TDEP<$$V(2,4)) S DDEP=$$V(16,3)+(TDEP*$$V(9,3))
 I ($$V(2,4)'>TDEP)&(TDEP<$$V(2,5)) S DDEP=$$V(16,4)+(TDEP*$$V(9,4))
 I ($$V(2,5)'>TDEP)&(TDEP<$$V(2,6)) S DDEP=$$V(16,5)+(TDEP*$$V(9,5))
 I ($$V(2,6)'>TDEP)&(TDEP<$$V(2,7)) S DDEP=$$V(16,6)+(TDEP*$$V(9,6))
 I ($$V(2,7)'>TDEP)&(TDEP<$$V(2,8)) S DDEP=$$V(16,7)+(TDEP*$$V(9,7))
 I ($$V(2,8)'>TDEP)&(TDEP<$$V(2,9)) S DDEP=$$V(16,8)+(TDEP*$$V(9,8))
 I ($$V(2,9)'>TDEP) S DDEP=1
 ;
 ; Fatigue Disutility.  Lower fatigue scores are better.
 S DFAT=0 ; 3=turnfat*, 10=slopefat*, 17=interceptfat*
 I ($$V(3,1)'>TFAT)&(TFAT<$$V(3,2)) S DFAT=$$V(17,1)+(TFAT*$$V(10,1))
 I ($$V(3,2)'>TFAT)&(TFAT<$$V(3,3)) S DFAT=$$V(17,2)+(TFAT*$$V(10,2))
 I ($$V(3,3)'>TFAT)&(TFAT<$$V(3,4)) S DFAT=$$V(17,3)+(TFAT*$$V(10,3))
 I ($$V(3,4)'>TFAT)&(TFAT<$$V(3,5)) S DFAT=$$V(17,4)+(TFAT*$$V(10,4))
 I ($$V(3,5)'>TFAT)&(TFAT<$$V(3,6)) S DFAT=$$V(17,5)+(TFAT*$$V(10,5))
 I ($$V(3,6)'>TFAT)&(TFAT<$$V(3,7)) S DFAT=$$V(17,6)+(TFAT*$$V(10,6))
 I ($$V(3,7)'>TFAT)&(TFAT<$$V(3,8)) S DFAT=$$V(17,7)+(TFAT*$$V(10,7))
 I ($$V(3,8)'>TFAT)&(TFAT<$$V(3,9)) S DFAT=$$V(17,8)+(TFAT*$$V(10,8))
 I ($$V(3,9)'>TFAT) S DFAT=1
 ;
 ; Pain Disutility.  Lower pain scores are better.
 S DPAIN=0 ; 4=turnpain*, 11=slopepain*, 18=interceptpain*
 I ($$V(4,1)'>TPAIN)&(TPAIN<$$V(4,2)) S DPAIN=$$V(18,1)+(TPAIN*$$V(11,1))
 I ($$V(4,2)'>TPAIN)&(TPAIN<$$V(4,3)) S DPAIN=$$V(18,2)+(TPAIN*$$V(11,2))
 I ($$V(4,3)'>TPAIN)&(TPAIN<$$V(4,4)) S DPAIN=$$V(18,3)+(TPAIN*$$V(11,3))
 I ($$V(4,4)'>TPAIN)&(TPAIN<$$V(4,5)) S DPAIN=$$V(18,4)+(TPAIN*$$V(11,4))
 I ($$V(4,5)'>TPAIN)&(TPAIN<$$V(4,6)) S DPAIN=$$V(18,5)+(TPAIN*$$V(11,5))
 I ($$V(4,6)'>TPAIN)&(TPAIN<$$V(4,7)) S DPAIN=$$V(18,6)+(TPAIN*$$V(11,6))
 I ($$V(4,7)'>TPAIN)&(TPAIN<$$V(4,8)) S DPAIN=$$V(18,7)+(TPAIN*$$V(11,7))
 I ($$V(4,8)'>TPAIN)&(TPAIN<$$V(4,9)) S DPAIN=$$V(18,8)+(TPAIN*$$V(11,8))
 I ($$V(4,9)'>TPAIN) S DPAIN=1
 ;
 ; Physical Disutility.  Higher physical function scores are better.
 S DPHYS=1 ; 5=turnphys*, 12=slopephys*, 19=interceptphys*
 I ($$V(5,1)'>TPHYS)&(TPHYS<$$V(5,2)) S DPHYS=$$V(19,1)+(TPHYS*$$V(12,1))
 I ($$V(5,2)'>TPHYS)&(TPHYS<$$V(5,3)) S DPHYS=$$V(19,2)+(TPHYS*$$V(12,2))
 I ($$V(5,3)'>TPHYS)&(TPHYS<$$V(5,4)) S DPHYS=$$V(19,3)+(TPHYS*$$V(12,3))
 I ($$V(5,4)'>TPHYS)&(TPHYS<$$V(5,5)) S DPHYS=$$V(19,4)+(TPHYS*$$V(12,4))
 I ($$V(5,5)'>TPHYS)&(TPHYS<$$V(5,6)) S DPHYS=$$V(19,5)+(TPHYS*$$V(12,5))
 I ($$V(5,6)'>TPHYS)&(TPHYS<$$V(5,7)) S DPHYS=$$V(19,6)+(TPHYS*$$V(12,6))
 I ($$V(5,7)'>TPHYS)&(TPHYS<$$V(5,8)) S DPHYS=$$V(19,7)+(TPHYS*$$V(12,7))
 I ($$V(5,8)'>TPHYS)&(TPHYS<$$V(5,9)) S DPHYS=$$V(19,8)+(TPHYS*$$V(12,8))
 I ($$V(5,9)'>TPHYS) S DPHYS=0
 ;
 ; Sleep Disutility.  Lower sleep disturbance scores are better.
 S DSLP=0 ; 6=turnsleep*, 13=slopesleep*, 20=interceptsleep*
 I ($$V(6,1)'>TSLP)&(TSLP<$$V(6,2)) S DSLP=$$V(20,1)+(TSLP*$$V(13,1))
 I ($$V(6,2)'>TSLP)&(TSLP<$$V(6,3)) S DSLP=$$V(20,2)+(TSLP*$$V(13,2))
 I ($$V(6,3)'>TSLP)&(TSLP<$$V(6,4)) S DSLP=$$V(20,3)+(TSLP*$$V(13,3))
 I ($$V(6,4)'>TSLP)&(TSLP<$$V(6,5)) S DSLP=$$V(20,4)+(TSLP*$$V(13,4))
 I ($$V(6,5)'>TSLP)&(TSLP<$$V(6,6)) S DSLP=$$V(20,5)+(TSLP*$$V(13,5))
 I ($$V(6,6)'>TSLP)&(TSLP<$$V(6,7)) S DSLP=$$V(20,6)+(TSLP*$$V(13,6))
 I ($$V(6,7)'>TSLP)&(TSLP<$$V(6,8)) S DSLP=$$V(20,7)+(TSLP*$$V(13,7))
 I ($$V(6,8)'>TSLP) S DSLP=1
 ;
 ; Social Disutility.  Higher social scores are better.
 S DSR=1 ; 7=turnphys*, 14=slopephys*, 21=interceptphys*
 I ($$V(7,1)'>TSR)&(TSR<$$V(7,2)) S DSR=$$V(21,1)+(TSR*$$V(14,1))
 I ($$V(7,2)'>TSR)&(TSR<$$V(7,3)) S DSR=$$V(21,2)+(TSR*$$V(14,2))
 I ($$V(7,3)'>TSR)&(TSR<$$V(7,4)) S DSR=$$V(21,3)+(TSR*$$V(14,3))
 I ($$V(7,4)'>TSR)&(TSR<$$V(7,5)) S DSR=$$V(21,4)+(TSR*$$V(14,4))
 I ($$V(7,5)'>TSR)&(TSR<$$V(7,6)) S DSR=$$V(21,5)+(TSR*$$V(14,5))
 I ($$V(7,6)'>TSR)&(TSR<$$V(7,7)) S DSR=$$V(21,6)+(TSR*$$V(14,6))
 I ($$V(7,7)'>TSR)&(TSR<$$V(7,8)) S DSR=$$V(21,7)+(TSR*$$V(14,7))
 I ($$V(7,8)'>TSR)&(TSR<$$V(7,9)) S DSR=$$V(21,8)+(TSR*$$V(14,8))
 I ($$V(7,9)'>TSR) S DSR=0
 ;
 ; multi-attribute disutility function
 S MCOG=1+(C*CCOG*DCOG)
 S MDEP=1+(C*CDEP*DDEP)
 S MFAT=1+(C*CFAT*DFAT)
 S MPAIN=1+(C*CPAIN*DPAIN)
 S MPHYS=1+(C*CPHYS*DPHYS)
 S MSLP=1+(C*CSLP*DSLP)
 S MSR=1+(C*CSR*DSR)
 S MAD=(1/C)*((MCOG*MDEP*MFAT*MPAIN*MPHYS*MSLP*MSR)-1)
 ;
 ; calulate the utility from the disutility and round
 S USCORES("PROPr")=$J(1-(TODEAD*MAD),7,3)
 S USCORES("cognition")=$J(1-DCOG,7,3)
 S USCORES("depression")=$J(1-DDEP,7,3)
 S USCORES("fatigue")=$J(1-DFAT,7,3)
 S USCORES("pain")=$J(1-DPAIN,7,3)
 S USCORES("physical")=$J(1-DPHYS,7,3)
 S USCORES("sleep")=$J(1-DSLP,7,3)
 S USCORES("social")=$J(1-DSR,7,3)
 Q  ; done
 ;
V(COL,ROW) ; return value from COLumn and ROW in CONST array
 Q +$P($P($T(CONST+ROW),";;",2,99),U,COL)
 ;
 ; MAUT constants
 ;;turncog^turndep^turnfat^turnpain^turnphys^turnsleep^turnsocial^
 ;;   1       2       3       4        5         6         7
 ;;slopecog^slopedep^slopefat^slopepain^slopephys^slopesleep^slopesocial^
 ;;   8        9        10       11        12         13         14
 ;;intercog^interdep^interfat^interpain^interphys^intersleep^intersocial
 ;;   15       16       17        18       19         20         21
CONST ; 
 ;;-2.052^-1.082^-1.648^-0.773^-2.575^-1.535^-2.088^-1.0047^0.1572^0.1152^0.0891^-1.0761^0.1241^-1.1152^-1.0617^0.1701^0.1898^0.0689^-1.7709^0.1905^-1.3285
 ;;-1.565^-0.264^-0.818^0.1^-2.174^-0.775^-1.634^-0.1745^0^0.1077^0.1721^-0.1756^0^-0.2874^0.2375^0.1286^0.1837^0.0606^0.1867^0.0943^0.0241
 ;;-1.239^0.151^-0.094^0.462^-1.784^-0.459^-1.293^-0.4223^0.1793^0.1189^0.1022^-0.1764^0.0797^-0.1352^-0.0694^0.1015^0.1848^0.0929^0.1853^0.1309^0.2209
 ;;-0.902^0.596^0.303^0.827^-1.377^0.093^-0.955^-0.1949^0.1817^0.1277^0.4241^-0.1161^0.3455^-0.132^0.1357^0.1001^0.1821^-0.1733^0.2683^0.1062^0.2239
 ;;-0.649^0.913^0.87^1.072^-0.787^0.335^-0.618^-0.1082^0.4109^0.222^0.3815^-0.2721^0.3148^-0.4012^0.192^-0.1092^0.1^-0.1277^0.1456^0.1164^0.0576
 ;;-0.367^1.388^1.124^1.407^-0.443^0.82^-0.276^-0.2468^0.1887^0.0496^0.3681^-0.4082^0.1238^0^0.1411^0.1993^0.2938^-0.1089^0.0853^0.2731^0.1683
 ;;-0.002^1.742^1.688^1.724^-0.211^1.659^0.083^-0.0176^0.2115^0.3233^0.1169^-0.1695^1.8964^-0.054^0.1416^0.1595^-0.1681^0.3243^0.1356^-2.6676^0.1728
 ;;0.52^2.245^2.053^2.169^0.16^1.934^0.494^-0.2192^0.7983^1.3632^0.7594^-0.1346^^-0.201^0.2464^-1.1577^-2.3031^-1.0692^0.13^^0.2454
 ;;1.124^2.703^2.423^2.725^0.966^^1.221^^^^^^^^^^^^^^
 ;;zzzzz
 ;
TEST ;
 N TSCORES,USCORES,X
 S TSCORES("cognition")=61.2 ;  29.5  ;6.4
 S TSCORES("depression")=41 ;79.4
 S TSCORES("fatigue")=33.7 ;75.8
 S TSCORES("pain")=41.6 ;75.6
 S TSCORES("physical")=57 ;22.5
 S TSCORES("sleep")=32 ;73.3
 S TSCORES("social")=64.2 ;27.5
 D MAUT(.TSCORES,.USCORES)
 W ! S X="" F  S X=$O(USCORES(X)) Q:'$L(X)  W !,X,?12,USCORES(X)
 Q
