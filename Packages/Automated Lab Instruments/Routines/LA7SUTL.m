LA7SUTL ;DALISC/JMC - Shipping Utility ;5/5/97  14:44
 ;;5.2;LAB MESSAGING;**27**;Sep 27, 1994
 Q
 ;
SSCFG(SCR) ; Select shipping configuration
 ; Call with  X = 0  no screen
 ;              = 1  active collecting facilty screen
 ;              = 2  active host facility screen
 ; Returns    Y = 0 (unsuccessful) or ien of entry in file #62.9 ^ .01 field name
 ;
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="PO^62.9:EM",DIR("A")="Select Shipping Configuration"
 I SCR S DIR("S")="I $P(^LAHM(62.9,Y,0),U,SCR+1)=DUZ(2),$P(^LAHM(62.9,Y,0),U,4)"
 D ^DIR
 I Y<1 S Y=0
 Q Y
 ;
JULIAN(LA7DT) ; Calculate julian date based on date passed
 ; Call with X = VA FileMan date.
 ;   Returns Y = julian date justified to 3 digits.
 N LA7JUL
 S LA7JUL=$$FMDIFF^XLFDT(LA7DT,$E(LA7DT,1,3)_"0101",1)
 S LA7JUL=LA7JUL+1
 I $L(LA7JUL)<3 S LA7JUL=$E("000",1,3-$L(LA7JUL))_LA7JUL
 Q LA7JUL
 ;
AD(LA7AA) ; Determine current accession date for a given accession area.
 ; Call with LA7AA = ien of entry in file ACCESSION #68.
 ;   Returns LA7AD = accession date in VA FileMan format
 ;                   0^error message if not valid pointer
 N LA7AD,X
 S LA7AA=+$G(LA7AA)
 I $G(LA7AA)<1 Q "0^No pointer to accession file passed"
 S DT=$$DT^XLFDT
 S X=$P($G(^LRO(68,LA7AA,0)),U,3)
 I $L(X) S LA7AD=$S(X="D":DT,X="M":$E(DT,1,5)_"00",X="Y":$E(DT,1,3)_"0000",X="Q":$E(DT,1,3)_"0000"+(($E(DT,4,5)-1)\3*300+100),1:DT) ; Calculate accession date based on accession transform.
 E  S LA7AD="0^No accession transform for this accession area"
 Q LA7AD
TEST(IEN) ;USED FOR THE CATALOG 
 K OUT
 G:'$D(^LAB(60,IEN,0)) EXIT
 G:$P(^LAB(60,IEN,0),U,12)="" EXIT
 S LAFLD=$P(^LAB(60,IEN,0),U,12),LADATA=@(U_LAFLD_0_")")
 S LATYP=$E($P(LADATA,U,2),1,1)
 I $L($T(@LATYP)) D @LATYP
EXIT ;EXIT
 K LADES,LAFLD,LATYP,LADATA,LAI,LANUM,LASET
 S OUT=$G(OUT)
 Q OUT
F ;FREE TEXT
 S OUT="FREE TEXT     "
 S OUT=OUT_$G(@(U_LAFLD_3_")"))
 Q
N ;NUMERIC
 S OUT="NUMERIC     "
 S OUT=OUT_$G(@(U_LAFLD_3_")"))
 Q
S ;SET OF CODES
 S OUT="CODES   "
 S LASET=$P(LADATA,U,3),LANUM=$L(LASET,";")-1
 Q:LANUM'>0
 F LAI=1:1:LANUM S LADES=$P(LASET,";",LAI) D
 .S OUT=OUT_$P(LADES,":",1)_" = "_$P(LADES,":",2)_"   "
 Q
