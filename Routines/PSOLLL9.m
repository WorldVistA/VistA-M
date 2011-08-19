PSOLLL9 ;BIR/JLC -Prints allergy warning label ;01/24/03
 ;;7.0;OUTPATIENT PHARMACY;**120,161**;DEC 1997
 ;
 N AAA,DATE1,EXPDT,ISD,HARDCOPY,PSAA,PSAQUIT,PSBQUIT,PSCQUIT,BBBB,ICOUNT,PSOING,NOW,TB1,TB2,TB2,SSG
 S HARDCOPY=COPIES
START ;
 I $G(PSOIO("AWI"))]"" X PSOIO("AWI")
 I $G(PSOIO(PSOFONT))]"" X PSOIO(PSOFONT)
 S COPIES=COPIES-1,Y=$P(^PSRX(RX,2),"^",6) X ^DD("DD") S EXPDT=Y,Y=$P(^PSRX(RX,0),"^",13) X ^DD("DD") S ISD=Y
 S Y=DATE X ^DD("DD") S DATE1=Y D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y
 I '$G(RXRP(RX)) S T=$P(PS2,"^",2)_"  ("_$P(RXY,"^",16)_"/"_$S(+$G(VRPH):VRPH,1:" ")_")  "_$P(NOW,":",1,2) D PRINT(T)
 S T="Rx# "_RXN_" has indicated a DRUG ALLERGY:" D PRINT(T)
 I $O(^PSRX(RX,"DAI",0)) D
 . S PSOY=PSOY+PSOYI,T=" Ingredients:" D PRINT(T)
 . F BBBB=0:0 S BBBB=$O(^PSRX(RX,"DAI",BBBB)) Q:'BBBB  S T="  "_$G(^(BBBB,0)) D PRINT(T)
 S PSOY=PSOY+PSOYI
 S PSOY=PSOY+PSOYI,T="This prescription was entered by "_$G(TECH) D PRINT(T)
 S PSOY=PSOY+PSOYI,T="This prescription may require reviewing by a pharmacist" D PRINT(T)
 S PSOY=PSOY+PSOYI I $G(RXRP(RX)) S T="(REPRINT)" D PRINT(T)
 F ICOUNT=1:1 S T=$G(SGY(ICOUNT)) Q:T=""  D PRINT(T)
 S T=RXN_"  "_DATE1_" Fill "_(RXF+1)_" of "_(1+$P(RXY,"^",9)) D PRINT(T)
 S T=PNM_"  "_SSNP D PRINT(T)
 S T="Qty: "_$G(QTY)_"  "_$G(PHYS) D PRINT(T)
 S T=$G(DRUG) D PRINT(T)
 S T="Tech__________RPh__________" D PRINT(T)
 S T="Routing: "_$S("W"[$E(MW):MW,1:MW_" MAIL") D PRINT(T)
 S T="Days Supply: "_$G(DAYS)_" Cap: "_$S(PSCAP:"**NON-SFTY**",1:"SAFETY") D PRINT(T)
 S T="Isd: "_ISD_" Exp: "_EXPDT D PRINT(T)
 S T="Last Fill: "_$G(PSOFLAST) D PRINT(T)
 S T="Pat. Stat "_PATST_" Clinic: "_PSCLN D PRINT(T)
 W @IOF
 I COPIES>0 G START
 S COPIES=HARDCOPY K HARDCOPY
 ;
STORE ;ALLERGY LABEL PRINT NODE - SHOULD ALWAYS BE ON THE ORIGINAL
 D NOW^%DTC S NOW=% S PSAA=0 F AAA=0:0 S AAA=$O(^PSRX(RX,"L",AAA)) Q:'AAA  S PSAA=AAA
 S PSAA=PSAA+1,^PSRX(RX,"L",0)="^52.032DA^"_PSAA_"^"_PSAA,^PSRX(RX,"L",PSAA,0)=NOW_"^"_0_"^Allergy warning label"_$S($G(RXRP(RX)):" (Reprint)",1:"")_"^"_PDUZ_"^2"
END ;
 Q
PRINT(T) ;
 I $G(PSOIO("ST"))]"" X PSOIO("ST")
 W T,!
 I $G(PSOIO("ET"))]"" X PSOIO("ET")
 Q
